From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/37] tools lib subcmd: Introduce OPTION_ULONG
Date: Thu, 25 Oct 2018 08:10:00 -0300
Message-ID: <20181025111031.3440-7-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kim Phillips <kim.phillips@arm.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For completeness, will be used in 'perf trace --max-events'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-glaj3pwespxfj2fdjs9a20b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 19 +++++++++++++++++++
 tools/lib/subcmd/parse-options.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index cb7154eccbdc..dbb9efbf718a 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -116,6 +116,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		case OPTION_INTEGER:
 		case OPTION_UINTEGER:
 		case OPTION_LONG:
+		case OPTION_ULONG:
 		case OPTION_U64:
 		default:
 			break;
@@ -166,6 +167,7 @@ static int get_value(struct parse_opt_ctx_t *p,
 		case OPTION_INTEGER:
 		case OPTION_UINTEGER:
 		case OPTION_LONG:
+		case OPTION_ULONG:
 		case OPTION_U64:
 		default:
 			break;
@@ -295,6 +297,22 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
 
+	case OPTION_ULONG:
+		if (unset) {
+			*(unsigned long *)opt->value = 0;
+			return 0;
+		}
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			*(unsigned long *)opt->value = opt->defval;
+			return 0;
+		}
+		if (get_arg(p, opt, flags, &arg))
+			return -1;
+		*(unsigned long *)opt->value = strtoul(arg, (char **)&s, 10);
+		if (*s)
+			return opterror(opt, "expects a numerical value", flags);
+		return 0;
+
 	case OPTION_U64:
 		if (unset) {
 			*(u64 *)opt->value = 0;
@@ -703,6 +721,7 @@ static void print_option_help(const struct option *opts, int full)
 	case OPTION_ARGUMENT:
 		break;
 	case OPTION_LONG:
+	case OPTION_ULONG:
 	case OPTION_U64:
 	case OPTION_INTEGER:
 	case OPTION_UINTEGER:
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 92fdbe1519f6..6ca2a8bfe716 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -25,6 +25,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_LONG,
+	OPTION_ULONG,
 	OPTION_CALLBACK,
 	OPTION_U64,
 	OPTION_UINTEGER,
@@ -133,6 +134,7 @@ struct option {
 #define OPT_INTEGER(s, l, v, h)     { .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, int *), .help = (h) }
 #define OPT_UINTEGER(s, l, v, h)    { .type = OPTION_UINTEGER, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned int *), .help = (h) }
 #define OPT_LONG(s, l, v, h)        { .type = OPTION_LONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, long *), .help = (h) }
+#define OPT_ULONG(s, l, v, h)        { .type = OPTION_ULONG, .short_name = (s), .long_name = (l), .value = check_vtype(v, unsigned long *), .help = (h) }
 #define OPT_U64(s, l, v, h)         { .type = OPTION_U64, .short_name = (s), .long_name = (l), .value = check_vtype(v, u64 *), .help = (h) }
 #define OPT_STRING(s, l, v, a, h)   { .type = OPTION_STRING,  .short_name = (s), .long_name = (l), .value = check_vtype(v, const char **), .argh = (a), .help = (h) }
 #define OPT_STRING_OPTARG(s, l, v, a, h, d) \
-- 
2.14.4
