From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 43/60] tools lib traceevent: Take care of return value of asprintf
Date: Mon, 20 Apr 2020 08:52:59 -0300
Message-ID: <20200420115316.18781-44-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, He Zhe <zhe.he@windriver.com>, Steven Rostedt <rostedt@goodmis.org>, Tzvetomir Stoyanov <tstoyanov@vmware.com>, hewenliang4@huawei.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

According to the API, if memory allocation wasn't possible, or some
other error occurs, asprintf will return -1, and the contents of strp
below are undefined.

  int asprintf(char **strp, const char *fmt, ...);

This patch takes care of return value of asprintf to make it less error
prone and prevent the following build warning.

  ignoring return value of ‘asprintf’, declared with attribute warn_unused_result [-Wunused-result]

Signed-off-by: He Zhe <zhe.he@windriver.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: hewenliang4@huawei.com
Link: http://lore.kernel.org/lkml/1582163930-233692-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/parse-filter.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 20eed719542e..c271aeeb227d 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1958,7 +1958,8 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 				default:
 					break;
 				}
-				asprintf(&str, val ? "TRUE" : "FALSE");
+				if (asprintf(&str, val ? "TRUE" : "FALSE") < 0)
+					str = NULL;
 				break;
 			}
 		}
@@ -1976,7 +1977,8 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 			break;
 		}
 
-		asprintf(&str, "(%s) %s (%s)", left, op, right);
+		if (asprintf(&str, "(%s) %s (%s)", left, op, right) < 0)
+			str = NULL;
 		break;
 
 	case TEP_FILTER_OP_NOT:
@@ -1992,10 +1994,12 @@ static char *op_to_str(struct tep_event_filter *filter, struct tep_filter_arg *a
 			right_val = 0;
 		if (right_val >= 0) {
 			/* just return the opposite */
-			asprintf(&str, right_val ? "FALSE" : "TRUE");
+			if (asprintf(&str, right_val ? "FALSE" : "TRUE") < 0)
+				str = NULL;
 			break;
 		}
-		asprintf(&str, "%s(%s)", op, right);
+		if (asprintf(&str, "%s(%s)", op, right) < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2011,7 +2015,8 @@ static char *val_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 {
 	char *str = NULL;
 
-	asprintf(&str, "%lld", arg->value.val);
+	if (asprintf(&str, "%lld", arg->value.val) < 0)
+		str = NULL;
 
 	return str;
 }
@@ -2069,7 +2074,8 @@ static char *exp_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		break;
 	}
 
-	asprintf(&str, "%s %s %s", lstr, op, rstr);
+	if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
+		str = NULL;
 out:
 	free(lstr);
 	free(rstr);
@@ -2113,7 +2119,8 @@ static char *num_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		if (!op)
 			op = "<=";
 
-		asprintf(&str, "%s %s %s", lstr, op, rstr);
+		if (asprintf(&str, "%s %s %s", lstr, op, rstr) < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2148,8 +2155,9 @@ static char *str_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 		if (!op)
 			op = "!~";
 
-		asprintf(&str, "%s %s \"%s\"",
-			 arg->str.field->name, op, arg->str.val);
+		if (asprintf(&str, "%s %s \"%s\"",
+			 arg->str.field->name, op, arg->str.val) < 0)
+			str = NULL;
 		break;
 
 	default:
@@ -2165,7 +2173,8 @@ static char *arg_to_str(struct tep_event_filter *filter, struct tep_filter_arg *
 
 	switch (arg->type) {
 	case TEP_FILTER_ARG_BOOLEAN:
-		asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE");
+		if (asprintf(&str, arg->boolean.value ? "TRUE" : "FALSE") < 0)
+			str = NULL;
 		return str;
 
 	case TEP_FILTER_ARG_OP:
-- 
2.21.1
