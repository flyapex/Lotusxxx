import 'package:get/get.dart';
import 'package:lotuspmc/api/api_wt.dart';
import 'package:lotuspmc/model/wt/wt_all.dart';
import 'package:lotuspmc/model/wt/wt_complete.dart';
import 'package:lotuspmc/model/wt/wt_denied.dart';
import 'package:lotuspmc/model/wt/wt_open.dart';
import 'package:lotuspmc/service/common.dart';
import 'package:open_file/open_file.dart';

class WTController extends GetxController {
  var wtAllData = Rxn<WtAllModel>();
  var isLoadingAll = false.obs;

  void fetchWtAll() async {
    try {
      isLoadingAll.value = true;
      final info = await ApiServiceWT.wtAllApi();
      if (info != null) {
        wtAllData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingAll.value = false;
    }
  }

  var wtOpenData = Rxn<WtOpenModel>();
  var isLoading = false.obs;

  void fetchWtOpen() async {
    try {
      isLoading.value = true;
      final info = await ApiServiceWT.wtOpenApi();
      if (info != null) {
        wtOpenData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  var wtCompletedData = Rxn<WtCompletedModel>();
  var isLoadingCompleted = false.obs;

  void fetchWTCompleted() async {
    try {
      isLoadingCompleted.value = true;
      final info = await ApiServiceWT.wtCompletedApi();
      if (info != null) {
        wtCompletedData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingCompleted.value = false;
    }
  }

  var wtDeniedData = Rxn<WtDeniedModel>();
  var isLoadingDenied = false.obs;

  void fetchWTDenied() async {
    try {
      isLoadingDenied.value = true;
      final info = await ApiServiceWT.wtDeniedApi();
      if (info != null) {
        wtDeniedData.value = info;
      } else {
        showSnackbar("Error", "Failed to fetch property information.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingDenied.value = false;
    }
  }

  var isLoadingPdf = false.obs;

  void fetchPDF(int reportID) async {
    try {
      isLoadingPdf.value = true;

      final filePath = await ApiServiceWT.wtGetExcelApi(
        reportID,
      );

      if (filePath != null) {
        print('File downloaded at: $filePath');
        final result = await OpenFile.open(filePath);
        if (result.type != ResultType.done) {
          showSnackbar("Error", "Failed to open the Excel file.");
        }
      } else {
        showSnackbar("Error", "Failed to fetch the Excel file.");
      }
    } catch (e) {
      showSnackbar("Error", "An error occurred: $e");
    } finally {
      isLoadingPdf.value = false;
    }
  }
}
