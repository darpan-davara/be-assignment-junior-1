var selectedAuthor = 0;
var selectedSplitUser = 0;

$('select#expense_paid_by_id').change(function(e){
  var value = $(this)[0].value;
  var optionCond = optionCondition(value);
  var name = $(this).children(optionCond).html();
  $('select#expense_user_ids').children(optionCond).prop('disabled', true);
  removeSplitUserElement('from_author', selectedAuthor);
  selectedAuthor = value;
  selectedSplitUser += 1;
  var element = addSplitUserElement('from_author', 'from_author', name, value, false);
  $('table.split_users').prepend(element);
  $('a.from_author').click(function(e) { removeSplitUserElement('from_author', selectedAuthor); });
  assignSplitAmount();
}); 

$('select#expense_user_ids').change(function(e){
  var value = $(this)[0].value;
  var optionCond = optionCondition(value);
  var name = $(this).children(optionCond).html();
  $('select#expense_paid_by_id').children(optionCond).prop('disabled', true);
  $('select#expense_user_ids').children(optionCond).prop('disabled', true);
  var element = addSplitUserElement('split_user_' + value, 'split_user', name, value, true);
  $('table.split_users').append(element);
  selectedSplitUser += 1;
  $('a.split_user_' + value).click(function(e) {
    removeSplitUserElement('split_user_' + value, value);
    assignSplitAmount();
  });
  assignSplitAmount();
});

$('input#expense_amount').change(function(e) { assignSplitAmount(); });

function assignSplitAmount(){
  var amount = parseFloat($('input#expense_amount')[0].value);
  var split_amount = parseFloat((amount/selectedSplitUser).toFixed(2));
  $('table.split_users').find('input[type="number"]').each(function(index){
    $(this).off('change');
    this.value = split_amount;
    $(this).change(function(e){ changeOfSplitAmount(); });
  });
  var first_input = $('table.split_users').find('input[type="number"]');
  if (split_amount*selectedSplitUser != amount){
    first_input.off('change');
    first_input[0].value = (split_amount+amount-split_amount*selectedSplitUser).toFixed(2);
    first_input.change(function(e){ changeOfSplitAmount(); });
  }
}

function changeOfSplitAmount(){
  var total = 0;
  $('table.split_users').find('input[type="number"]').each(function(index){
    total += parseFloat(this.value);
  });
  var amount_element = $('input#expense_amount');
  amount_element.off('change');
  amount_element[0].value = total;
  amount_element.change(function(e) { assignSplitAmount(); });
}

function optionCondition(value){
  return 'option[value="' + value + '"]';
}

function removeSplitUserElement(className, value){
  $('select#expense_user_ids').children(optionCondition(value)).prop('disabled', false);
  $('table.split_users').find("tr#" + className).remove();
  if(selectedSplitUser > 0){
    selectedSplitUser -= 1;
  }
}

function addSplitUserElement(className, idName, name, value, removeCheck){
  var element = `<tr id="${className}">\
                  <td style="display: inline-block; margin-right: 10px; width: 250px;">
                    <input type="hidden" name="expense[${idName}][${value}]" value="${value}">\
                    ${name}\
                  </td>\
                  <td style="display: inline-block; width: 250px;">\
                    <input class="form-control" type="number" name="expense[${idName}][${value}]" value="0" step="0.01">\
                  </td>`;
  if(removeCheck){
    element += `<td style="display: inline-block; width: 50px;">\
                  <a class="btn ${className}">X</a>\
                </td>\
                </tr>`;
  } else {
    element += '</tr>';
  }
  return element;
}
