From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 02/12] perf topdown-parser: Add utility functions.
Date: Tue, 10 Nov 2020 02:03:36 -0800
Message-ID: <20201110100346.2527031-3-irogers@google.com>
References: <20201110100346.2527031-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>, Sandeep Dasgupta <sdasgup@google.com>, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sandeep Dasgupta <sdasgup@google.com>

Basic string, ostream and file functions.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../topdown-parser/general_utils.cpp          | 173 ++++++++++++++++++
 .../pmu-events/topdown-parser/general_utils.h | 131 +++++++++++++
 2 files changed, 304 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/general_utils.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/general_utils.h

diff --git a/tools/perf/pmu-events/topdown-parser/general_utils.cpp b/tools/perf/pmu-events/topdown-parser/general_utils.cpp
new file mode 100644
index 000000000000..810c27cf3724
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/general_utils.cpp
@@ -0,0 +1,173 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "general_utils.h"
+
+#include <dirent.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <regex>
+#include <sstream>
+
+#include "logging.h"
+
+namespace topdown_parser
+{
+std::string Trim(const std::string &str)
+{
+	const char *ws = " \t\n\r\f\v";
+	size_t endpos = str.find_last_not_of(ws);
+	if (endpos == std::string::npos)
+		return "";
+
+	size_t startpos = str.find_first_not_of(ws);
+	return str.substr(startpos, endpos - startpos + 1);
+}
+
+std::vector<std::string> Split(const std::string &str, char delim)
+{
+	std::vector<std::string> tokens;
+	std::string token;
+	std::istringstream tokenStream(str);
+	while (std::getline(tokenStream, token, delim)) {
+		tokens.push_back(Trim(token));
+	}
+	return tokens;
+}
+
+std::string Strip(const std::string &str, char delim)
+{
+	std::string retval("");
+	for (size_t i = 0; i < str.length(); ++i) {
+		if (str[i] != delim) {
+			retval += str[i];
+		}
+	}
+	return retval;
+}
+
+std::vector<std::string> WhitespaceSplit(const std::string &s)
+{
+	std::vector<std::string> split_tokens = Split(s, ' ');
+	std::vector<std::string> retval;
+	for (auto &split_token : split_tokens) {
+		if (split_token.empty() || split_token == " ") {
+			continue;
+		}
+		retval.push_back(split_token);
+	}
+	return retval;
+}
+
+bool IsOperator(const std::string &str)
+{
+	std::regex r(
+		"\\/|\\-|\\+|\\*|\\(|\\)|\\<|\\>|min|max|\\?|\\:|,|==|>=|<=|="
+		"|if|else|d_ratio|#Model|in|\\[|\\]");
+	return regex_match(Trim(str), r);
+}
+
+bool IsConstant(const std::string &str)
+{
+	std::regex integer("[-+]?[0-9]+");
+	std::regex floating("[-+]?[0-9]*\\.?[0-9]+");
+
+	return regex_match(str, integer) || regex_match(str, floating);
+}
+
+time_t GetTimestamp(const std::string &fname)
+{
+	struct stat st;
+	int ierr = stat(fname.c_str(), &st);
+	if (ierr != 0) {
+		ERROR("Error getting stat on file: " << fname);
+		return 0;
+	}
+	return st.st_mtime;
+}
+
+bool CheckDirPathExists(const std::string &dirname)
+{
+	return opendir(dirname.c_str()) != nullptr;
+}
+
+std::string ConvertToCIdentifier(const std::string &str)
+{
+	static const char *int_to_word[] = { "zero",  "one",  "two", "three",
+					     "four",  "five", "six", "seven",
+					     "eight", "nine" };
+	std::regex r("\\/|#|\\.|-|:|=");
+	std::string retval = regex_replace(str, r, "_");
+
+	std::smatch sm;
+	if (regex_match(retval, sm, std::regex("^([0-9])(.*)"))) {
+		auto digit = stoi(sm[1].str());
+		std::string word = int_to_word[digit];
+		std::string rest = sm[2].str();
+		return word + "_" + rest;
+	}
+	return retval;
+}
+
+std::string ToLower(const std::string &str)
+{
+	std::string retval("");
+
+	for (auto &c : str) {
+		retval.append(1, std::tolower(c));
+	}
+	return retval;
+}
+
+std::vector<std::string> NormalizeModel(const std::vector<std::string> &tokens,
+					const std::string &cpu)
+{
+	std::vector<std::string> retval;
+	// Track the event if encountering a '['
+	bool match_start = false;
+	// The evaluated value of the sub-expression #Model in ['CPUX' 'CPUY']
+	int condition = 0;
+
+	for (size_t i = 0; i < tokens.size(); ++i) {
+		// Skip keywords like "#Model" and "in"
+		if (tokens[i] == "#Model" || tokens[i] == "in") {
+			continue;
+		}
+		if (tokens[i] == "[") {
+			match_start = true;
+			continue;
+		}
+
+		if (tokens[i] == "]") {
+			retval.push_back(std::to_string(condition));
+			match_start = false;
+			continue;
+		}
+
+		if (match_start) {
+			if (cpu == Strip(tokens[i], '\'')) {
+				condition = condition | 1;
+			}
+			continue;
+		}
+
+		// Rest of tokens
+		retval.push_back(tokens[i]);
+	}
+
+	return retval;
+}
+
+std::string InjectSanityChecksAndReturn(const std::string &str)
+{
+	std::string injected_string =
+		std::string("double retval = ") + str + ";\n\n";
+	injected_string += "\treturn  retval < 0.0 ? 0.0 : retval;";
+
+	return injected_string;
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/general_utils.h b/tools/perf/pmu-events/topdown-parser/general_utils.h
new file mode 100644
index 000000000000..6e1213247011
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/general_utils.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// ------------------------------------------------
+// File: general_utils.h
+// ------------------------------------------------
+//
+// The header implements the interface of common utilities used by the
+// topdown generator.
+
+#ifndef TOPDOWN_PARSER_GENERAL_UTILS_H_
+#define TOPDOWN_PARSER_GENERAL_UTILS_H_
+
+#include <set>
+#include <string>
+#include <unordered_set>
+#include <vector>
+
+namespace topdown_parser
+{
+/**
+ * Overloading << operators for various STL containers.
+ */
+template <typename T>
+std::ostream &operator<<(std::ostream &OS, std::vector<T> V)
+{
+	for (size_t i = 0; i < V.size(); ++i)
+		OS << V[i] << ",";
+
+	return OS;
+}
+
+template <typename T> std::ostream &operator<<(std::ostream &OS, std::set<T> V)
+{
+	for (auto &f : V)
+		OS << f << "|";
+
+	return OS;
+}
+
+template <typename T>
+std::ostream &operator<<(std::ostream &OS, std::unordered_set<T> V)
+{
+	for (auto &f : V)
+		OS << f << "|";
+
+	return OS;
+}
+
+/**
+ * Function used for splitting a string 'str' based on a delimiter 'delim'.
+ */
+std::vector<std::string> Split(const std::string &str, char delim);
+
+/**
+ * Function used for
+ * (1) splitting a string 'str' based on a whitespace, and
+ * (2) pruning the splits resulting in empty string or string containing only
+ * whitespaces.
+ * Example: For an input string s = "a  b   d"
+ *  Result: {"a", "b", "c"}
+ */
+std::vector<std::string> WhitespaceSplit(const std::string &str);
+
+/**
+ * Trim removes the leading and trailing whitespaces of a string `str`.
+ */
+std::string Trim(const std::string &str);
+
+/**
+ * Remove a char 'delim' from anywhere in string 'str'.
+ */
+std::string Strip(const std::string &str, char delim);
+
+/**
+ * Check if the string `str` is an operator.
+ */
+bool IsOperator(const std::string &str);
+
+/**
+ * Check if the string `str` is an constant decimal numer or float.
+ */
+bool IsConstant(const std::string &);
+
+/**
+ * Returns timestamp of a file `fname`
+ */
+time_t GetTimestamp(const std::string &fname);
+
+/*
+ * Check if a directory path `dirname` exists
+ */
+bool CheckDirPathExists(const std::string &dirname);
+
+/**
+ * Convert an arbitrary string `str` to C identifier.
+ * It converts some characters like '#', '.', '-', '=' to '_', if appear
+ * anywhere in the string.
+ */
+std::string ConvertToCIdentifier(const std::string &str);
+
+/**
+ * Lowercase a string `str`
+ */
+std::string ToLower(const std::string &str);
+
+/**
+ * The input csv file might contain formula like
+ *    "Exp1 if #Model in ['CPUX' 'CPUY'] else Expr2 "
+ *  in a column specifying a list of CPUs as CPUX/CPUY/CPUZ
+ * We want to generate the following formulas for each cpu
+ *  For CPUX: Expr1 if 1 else Expr2
+ *  For CPUY: Expr1 if 1 else Expr2
+ *  For CPUZ: Expr1 if 0 else Expr2
+ *
+ *  `tokens`: A list of tokens representing the formula delimited by whitespace.
+ *  `cpu`: The CPU for which we want to generate the formula.
+ */
+std::vector<std::string> NormalizeModel(const std::vector<std::string> &tokens,
+					const std::string &cpu);
+
+/**
+ * `InjectSanityChecksAndReturn` converts a formula 'str'
+ * to
+ *  double retval = str < 0.0 ? 0.0 : str;
+ *  return retval;
+ */
+std::string InjectSanityChecksAndReturn(const std::string &str);
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_GENERAL_UTILS_H_
-- 
2.29.2.222.g5d2a92d10f8-goog
