From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH 07/12] perf topdown-parser: Metric expression parser.
Date: Tue, 10 Nov 2020 02:03:41 -0800
Message-ID: <20201110100346.2527031-8-irogers@google.com>
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

A parser capable of processing metrics found in TMA_Metrics.csv.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../pmu-events/topdown-parser/expr_parser.y   | 224 ++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/expr_parser.y

diff --git a/tools/perf/pmu-events/topdown-parser/expr_parser.y b/tools/perf/pmu-events/topdown-parser/expr_parser.y
new file mode 100644
index 000000000000..ddf635a6470c
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/expr_parser.y
@@ -0,0 +1,224 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+/* Topdown expression parser */
+%language "c++"
+%define api.value.type variant
+
+%code requires {
+#include <string>
+}
+
+/* Increase error verbosity. */
+%define parse.trace
+%define parse.error verbose
+/* Semantic value printer. */
+%printer { yyo << $$; } <*>;
+
+
+/* Inputs for the parser and yylex. */
+%param { const std::string &input }
+%param { size_t *cursor }
+/* Inputs/output for the parser. */
+%parse-param { bool convert_if_stmt }
+%parse-param { bool remove_false_branch }
+%parse-param { bool wrap_div_in_function }
+%parse-param { std::string *final_val }
+
+/* Tokens returned by yylex. */
+%define api.token.prefix {TOK_}
+%token
+  MIN
+  MAX
+  IF
+  ELSE
+  MODEL
+  IN
+  NEG
+  EOF 0
+%token <std::string> ID_OR_NUM
+
+/* Type of non-terminal expressions. */
+%type <std::string> expr if_expr IDS
+
+/* Presidence and associativity. */
+%left MIN MAX MODEL IN
+%right ELSE
+%right IF
+%left '='
+%left '<' '>'
+%left '-' '+'
+%left '*' '/' '%'
+%left NEG
+
+%code {
+static int yylex(yy::parser::semantic_type *res,
+		 const std::string &input,
+		 size_t *cursor);
+
+void yy::parser::error (const std::string& m)
+{
+//	ERROR(m << '\n' << "Input:\n" << input << "\nCursor: " << *cursor);
+}
+
+}
+
+%%
+%start all_expr;
+all_expr: expr EOF { *final_val = $1; } ;
+
+IDS:
+'\'' ID_OR_NUM '\''     { $$ = std::string(" ") + $2 + " "; }
+|
+IDS '\'' ID_OR_NUM '\'' { $$ = $1 + " " + $3 + " "; }
+;
+
+if_expr:
+expr IF expr ELSE expr
+{
+	if (convert_if_stmt)
+		$$ = $3 + " ? " + $1 + " : " + $5;
+	else
+		$$ = $1 + " if " + $3 + " else " + $5;
+
+	if (remove_false_branch) {
+		if (std::string::npos !=  $3.find("0.000", 0))
+			$$ = $5;
+		else if (std::string::npos != $3.find("1.000", 0))
+			$$ = $1;
+	}
+}
+|
+expr IF MODEL IN '[' IDS ']' ELSE expr
+{
+	$$ = std::string("#Model in [ ") + $6 + " ] ? " + $1 + " : " + $9;
+}
+;
+
+expr:
+ID_OR_NUM     { $$ = $1; }
+|
+expr '+' expr { $$ = $1 + " + " + $3; }
+|
+expr '-' expr { $$ = $1 + " - " + $3; }
+|
+expr '*' expr { $$ = $1 + " * " + $3; }
+|
+expr '>' expr { $$ = $1 + " > " + $3; }
+|
+expr '<' expr { $$ = $1 + " < " + $3; }
+|
+expr '%' expr { $$ = $1 + " % " + $3; }
+|
+'(' expr ')'  { $$ = std::string("( ") + $2 + " )"; }
+|
+expr '=' '=' expr { $$ = $1 + " == " + $4; }
+|
+'-' expr %prec NEG { $$ = std::string(" - ") + $2; }
+|
+expr '/' expr
+{
+	if (wrap_div_in_function)
+		$$ = std::string("d_ratio ( ") + $1 + " , " + $3 + " )";
+	else
+		$$ = $1 + " / " + $3;
+}
+|
+MIN '(' expr ',' expr ')'
+{
+	$$ = std::string("min ( ") + $3 + " , " + $5 + " )";
+}
+|
+MAX '(' expr ',' expr ')'
+{
+	$$ = std::string("max ( ") + $3 + " , " + $5 + " )";
+}
+|
+if_expr
+{
+	if (convert_if_stmt)
+		$$ = std::string("( ") + $1 + " )";
+	else
+		$$ = $1;
+}
+;
+
+%%
+static int expr__symbol(yy::parser::semantic_type *res,
+       	   	 	size_t p,
+			const std::string &input,
+			size_t *cursor)
+{
+	std::string dst;
+
+	if (input[p] == '#')
+		dst += input[p++];
+
+	while (p < input.size() &&
+	       (isalnum(input[p]) ||
+		input[p] == '_' ||
+		input[p] == '.' ||
+		input[p] == ':' ||
+		input[p] == '@' ||
+		input[p] == '\\' ||
+		input[p] == '=')
+	      ) {
+		if(input[p] == '\\') {
+			// Consume 2 consequitive '\\' and the escaped char.
+			dst += input[p++];
+			if (p >= input.size())
+				break;
+			dst += input[p++];
+			if (p >= input.size())
+				break;
+		}
+		dst += input[p++];
+	}
+	*cursor = p;
+	if (p >= input.size() && dst.empty())
+		return yy::parser::token::TOK_EOF;
+	if (dst == "min") return yy::parser::token::TOK_MIN;
+	if (dst == "max") return yy::parser::token::TOK_MAX;
+	if (dst == "if") return yy::parser::token::TOK_IF;
+	if (dst == "in") return yy::parser::token::TOK_IN;
+	if (dst == "else") return yy::parser::token::TOK_ELSE;
+	if (dst == "#Model") return yy::parser::token::TOK_MODEL;
+	res->emplace<std::string>(dst);
+	return yy::parser::token::TOK_ID_OR_NUM;
+}
+
+static int yylex(yy::parser::semantic_type *res,
+		 const std::string &input,
+		 size_t *cursor)
+{
+	size_t p = *cursor;
+
+	// Skip spaces.
+	while (p < input.size() && isspace(input[p]))
+		p++;
+
+	if (p >= input.size()) {
+		*cursor = p;
+	  	return yy::parser::token::TOK_EOF;
+	}
+	switch (input[p]) {
+	case '#':
+	case 'a' ... 'z':
+	case 'A' ... 'Z':
+		return expr__symbol(res, p, input, cursor);
+	case '0' ... '9': case '.': {
+	     	// Read the number and regularize numbers starting
+	     	// with '.' adjusting the cursor to after the number.
+		const size_t s = p;
+		res->emplace<std::string>(
+			std::to_string(std::stod(input.substr(p), &p)));
+		*cursor = p + s;
+		return yy::parser::token::TOK_ID_OR_NUM;
+	}
+	default:
+		*cursor = p + 1;
+		return input[p];
+	}
+}
-- 
2.29.2.222.g5d2a92d10f8-goog
