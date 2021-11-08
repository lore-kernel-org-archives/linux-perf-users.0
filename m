Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F2C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652706115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhKHNph (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNph (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69V9RZoQsy256Ok3C4vvSXl3xsBiW8ahoKh/0sPx/Sw=;
        b=ZSjZ/v6aocCPESgGiXhcqEwFdI0h9ATu0nVuRlU892SP0dSmmO7MHmZIuluO/Hkrs/d+YW
        6uT4D2Xtq4+bHfQhkSBUj3ZxL8EKDyT+n+Ga+sd9TYIrxVRN0ipNSI/bX9NAoWwAbaQbN4
        aGbsPYsaSbXif2SmTMe/sOyVmHvdDR0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-y_aImuM4PZ-YHXLkh_6CYQ-1; Mon, 08 Nov 2021 08:42:51 -0500
X-MC-Unique: y_aImuM4PZ-YHXLkh_6CYQ-1
Received: by mail-wm1-f70.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so10154205wmc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69V9RZoQsy256Ok3C4vvSXl3xsBiW8ahoKh/0sPx/Sw=;
        b=FSh05nxuMu+WbjdxNjcXImAGkawjbI0aJX5pSAAtqCzpMwjR1KjOwKMBkOXG6Pweaz
         aRuUd1TRSRf6mmd+kr8Xcof+Cn6Nw6dGEhbmsdhmXWdHsYmQd9zstCVUXTolF+lKVPx2
         rMGgU4527qxHU6pDXHQSBiB11QGrs9HekXV/OxCj/pzefbCFeMciBtxcfRzvm2W9SWqJ
         3ayb/yRtelvRTxz6svNV5KOJUH8ISVVcjlAv1/voLW8iYdAgrLl49WzOre37lDSqrQrC
         UGE5hM1vTVpD3eihBypxtRQ6iKo0yJtpHRj1AXL0mmt9tVunKXPajedmU5W9bJj4ZXEz
         yBSw==
X-Gm-Message-State: AOAM532EukPVJeB9J2HsV5ssTW8+0nnbnDRHNkwqT7UcbdkpthZyTgfb
        oR2TGp+9AiZ3XHoxHebROiTiNrIRhP/pg3L+uKiDhWoRN4PfH43iarbiiCeYhy5Hyx7mfqv8XEs
        l8qC46UCtvnaIaV4OwkRM7ajaXP9k8Q==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr49143681wml.85.1636378968312;
        Mon, 08 Nov 2021 05:42:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCQEydG5pz/rHMQq63M+XMTZuwsxXz67rGXVPlabK+5W/JobFLsH+vC2HF2I4O3kQeOKlI7w==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr49143603wml.85.1636378967522;
        Mon, 08 Nov 2021 05:42:47 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n4sm19295602wri.41.2021.11.08.05.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:47 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 55/59] libperf: Move in parse-events flex/bison parser
Date:   Mon,  8 Nov 2021 14:37:06 +0100
Message-Id: <20211108133710.1352822-56-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse-events flex/bison parser in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build                          |  23 +
 .../lib/perf/include/internal/parse-events.h  |   3 +
 tools/lib/perf/parse-events.c                 |  38 +
 tools/lib/perf/parse-events.l                 | 411 ++++++++
 tools/lib/perf/parse-events.y                 | 992 ++++++++++++++++++
 tools/perf/util/Build                         |  15 -
 tools/perf/util/parse-events.c                |  38 -
 tools/perf/util/parse-events.l                | 411 --------
 tools/perf/util/parse-events.y                | 992 ------------------
 9 files changed, 1467 insertions(+), 1456 deletions(-)
 create mode 100644 tools/lib/perf/parse-events.l
 create mode 100644 tools/lib/perf/parse-events.y
 delete mode 100644 tools/perf/util/parse-events.l
 delete mode 100644 tools/perf/util/parse-events.y

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index af4663e4421f..3e29d173e0ec 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -12,6 +12,8 @@ libperf-y += pmu-bison.o
 libperf-y += pmu.o
 libperf-y += pmu-hybrid.o
 libperf-y += parse-events.o
+libperf-y += parse-events-flex.o
+libperf-y += parse-events-bison.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
@@ -19,6 +21,15 @@ $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 
 tests-y += tests/
 
+$(OUTPUT)parse-events-flex.c $(OUTPUT)parse-events-flex.h: parse-events.l $(OUTPUT)parse-events-bison.c
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)parse-events-flex.c \
+		--header-file=$(OUTPUT)parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
+
+$(OUTPUT)parse-events-bison.c $(OUTPUT)parse-events-bison.h: parse-events.y
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
+		-o $(OUTPUT)parse-events-bison.c -p parse_events_
 
 $(OUTPUT)pmu-flex.c $(OUTPUT)pmu-flex.h: pmu.l $(OUTPUT)pmu-bison.c
 	$(call rule_mkdir)
@@ -41,7 +52,19 @@ else
   flex_flags := -w
 endif
 
+bison_flags := -DYYENABLE_NLS=0
+BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
+ifeq ($(BISON_GE_35),1)
+  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum
+else
+  bison_flags += -w
+endif
+
 CFLAGS_pmu-flex.o  += $(flex_flags)
 CFLAGS_pmu-bison.o += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
+CFLAGS_parse-events-flex.o  += $(flex_flags)
+CFLAGS_parse-events-bison.o += $(bison_flags)
+
 $(OUTPUT)pmu.o: $(OUTPUT)pmu-flex.c $(OUTPUT)pmu-bison.c
+$(OUTPUT)parse-events.o: $(OUTPUT)parse-events-flex.c $(OUTPUT)parse-events-bison.c
diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 0a8a61219885..5020a1b2bff2 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -194,4 +194,7 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
 int parse_events_name(struct list_head *list, const char *name);
+int parse_events__scanner(const char *str,
+			  struct parse_events_state *parse_state,
+			  bool terms);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index 6efc2bb73cdf..da684023b273 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -13,6 +13,13 @@
 #include <errno.h>
 #include <asm/bug.h>
 #include "internal.h"
+#include "parse-events-bison.h"
+#define YY_EXTRA_TYPE void*
+#include "parse-events-flex.h"
+
+#ifdef PARSER_DEBUG
+extern int parse_events_debug;
+#endif
 
 struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -592,3 +599,34 @@ int parse_events_name(struct list_head *list, const char *name)
 
 	return 0;
 }
+
+int parse_events__scanner(const char *str,
+			  struct parse_events_state *parse_state,
+			  bool terms)
+{
+	YY_BUFFER_STATE buffer;
+	void *scanner;
+	int ret;
+
+	if (terms)
+		parse_state->stoken = PE_START_TERMS;
+	else
+		parse_state->stoken = PE_START_EVENTS;
+
+	ret = parse_events_lex_init_extra(parse_state, &scanner);
+	if (ret)
+		return ret;
+
+	buffer = parse_events__scan_string(str, scanner);
+
+#ifdef PARSER_DEBUG
+	parse_events_debug = 1;
+	parse_events_set_debug(1, scanner);
+#endif
+	ret = parse_events_parse(parse_state, scanner);
+
+	parse_events__flush_buffer(buffer, scanner);
+	parse_events__delete_buffer(buffer, scanner);
+	parse_events_lex_destroy(scanner);
+	return ret;
+}
diff --git a/tools/lib/perf/parse-events.l b/tools/lib/perf/parse-events.l
new file mode 100644
index 000000000000..1d4e0aa5ee31
--- /dev/null
+++ b/tools/lib/perf/parse-events.l
@@ -0,0 +1,411 @@
+
+%option reentrant
+%option bison-bridge
+%option prefix="parse_events_"
+%option stack
+%option bison-locations
+%option yylineno
+%option reject
+
+%{
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <internal/parse-events.h>
+#include "parse-events-bison.h"
+#include <internal/evsel.h>
+
+char *parse_events_get_text(yyscan_t yyscanner);
+YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
+
+static int __value(YYSTYPE *yylval, char *str, int base, int token)
+{
+	u64 num;
+
+	errno = 0;
+	num = strtoull(str, NULL, base);
+	if (errno)
+		return PE_ERROR;
+
+	yylval->num = num;
+	return token;
+}
+
+static int value(yyscan_t scanner, int base)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	return __value(yylval, text, base, PE_VALUE);
+}
+
+static int str(yyscan_t scanner, int token)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	if (text[0] != '\'') {
+		yylval->str = strdup(text);
+	} else {
+		/*
+		 * If a text tag specified on the command line
+		 * contains opening single quite ' then it is
+		 * expected that the tag ends with single quote
+		 * as well, like this:
+		 *     name=\'CPU_CLK_UNHALTED.THREAD:cmask=1\'
+		 * quotes need to be escaped to bypass shell
+		 * processing.
+		 */
+		yylval->str = strndup(&text[1], strlen(text) - 2);
+	}
+
+	return token;
+}
+
+static int raw(yyscan_t scanner, struct parse_events_state *parse_state)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	if (parse_state->ops->parse_check(text) == PMU_EVENT_SYMBOL)
+		return str(scanner, PE_NAME);
+
+	return __value(yylval, text + 1, 16, PE_RAW);
+}
+
+static bool isbpf_suffix(char *text)
+{
+	int len = strlen(text);
+
+	if (len < 2)
+		return false;
+	if ((text[len - 1] == 'c' || text[len - 1] == 'o') &&
+	    text[len - 2] == '.')
+		return true;
+	if (len > 4 && !strcmp(text + len - 4, ".obj"))
+		return true;
+	return false;
+}
+
+static bool isbpf(yyscan_t scanner)
+{
+	char *text = parse_events_get_text(scanner);
+	struct stat st;
+
+	if (!isbpf_suffix(text))
+		return false;
+
+	return stat(text, &st) == 0;
+}
+
+/*
+ * This function is called when the parser gets two kind of input:
+ *
+ * 	@cfg1 or @cfg2=config
+ *
+ * The leading '@' is stripped off before 'cfg1' and 'cfg2=config' are given to
+ * bison.  In the latter case it is necessary to keep the string intact so that
+ * the PMU kernel driver can determine what configurable is associated to
+ * 'config'.
+ */
+static int drv_str(yyscan_t scanner, int token)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	/* Strip off the '@' */
+	yylval->str = strdup(text + 1);
+	return token;
+}
+
+#define REWIND(__alloc)				\
+do {								\
+	YYSTYPE *__yylval = parse_events_get_lval(yyscanner);	\
+	char *text = parse_events_get_text(yyscanner);		\
+								\
+	if (__alloc)						\
+		__yylval->str = strdup(text);			\
+								\
+	yycolumn -= strlen(text);				\
+	yyless(0);						\
+} while (0)
+
+static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_state)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+	char *text = parse_events_get_text(scanner);
+
+	yylval->str = strdup(text);
+
+	/*
+	 * If we're not testing then parse check determines the PMU event type
+	 * which if it isn't a PMU returns PE_NAME. When testing the result of
+	 * parse check can't be trusted so we return PE_PMU_EVENT_FAKE unless
+	 * an '!' is present in which case the text can't be a PMU name.
+	 */
+	switch (parse_state->ops->parse_check(text)) {
+		case PMU_EVENT_SYMBOL_PREFIX:
+			return PE_PMU_EVENT_PRE;
+		case PMU_EVENT_SYMBOL_SUFFIX:
+			return PE_PMU_EVENT_SUF;
+		case PMU_EVENT_SYMBOL:
+			return parse_state->fake_pmu
+				? PE_PMU_EVENT_FAKE : PE_KERNEL_PMU_EVENT;
+		default:
+			return parse_state->fake_pmu && !strchr(text,'!')
+				? PE_PMU_EVENT_FAKE : PE_NAME;
+	}
+}
+
+static int sym(yyscan_t scanner, int type, int config)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+
+	yylval->num = (type << 16) + config;
+	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
+}
+
+static int tool(yyscan_t scanner, enum perf_tool_event event)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+
+	yylval->num = event;
+	return PE_VALUE_SYM_TOOL;
+}
+
+static int term(yyscan_t scanner, int type)
+{
+	YYSTYPE *yylval = parse_events_get_lval(scanner);
+
+	yylval->num = type;
+	return PE_TERM;
+}
+
+#define YY_USER_ACTION					\
+do {							\
+	yylloc->last_column  = yylloc->first_column;	\
+	yylloc->first_column = yycolumn;		\
+	yycolumn += yyleng;				\
+} while (0);
+
+#define USER_REJECT		\
+	yycolumn -= yyleng;	\
+	REJECT
+
+%}
+
+%x mem
+%s config
+%x event
+%x array
+
+group		[^,{}/]*[{][^}]*[}][^,{}/]*
+event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
+event		[^,{}/]+
+bpf_object	[^,{}]+\.(o|bpf)[a-zA-Z0-9._]*
+bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
+
+num_dec		[0-9]+
+num_hex		0x[a-fA-F0-9]+
+num_raw_hex	[a-fA-F0-9]+
+name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
+name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
+name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
+drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
+/* If you add a modifier you need to update check_modifier() */
+modifier_event	[ukhpPGHSDIWeb]+
+modifier_bp	[rwx]{1,3}
+
+%%
+
+%{
+	struct parse_events_state *_parse_state = parse_events_get_extra(yyscanner);
+
+	{
+		int start_token = _parse_state->stoken;
+
+		if (start_token == PE_START_TERMS)
+			BEGIN(config);
+		else if (start_token == PE_START_EVENTS)
+			BEGIN(event);
+
+		if (start_token) {
+			_parse_state->stoken = 0;
+			/*
+			 * The flex parser does not init locations variable
+			 * via the scan_string interface, so we need do the
+			 * init in here.
+			 */
+			yycolumn = 0;
+			return start_token;
+		}
+         }
+%}
+
+<event>{
+
+{group}		{
+			BEGIN(INITIAL);
+			REWIND(0);
+		}
+
+{event_pmu}	|
+{bpf_object}	|
+{bpf_source}	|
+{event}		{
+			BEGIN(INITIAL);
+			REWIND(1);
+			return PE_EVENT_NAME;
+		}
+
+<<EOF>>		{
+			BEGIN(INITIAL);
+			REWIND(0);
+		}
+,		{
+			return ',';
+		}
+}
+
+<array>{
+"]"			{ BEGIN(config); return ']'; }
+{num_dec}		{ return value(yyscanner, 10); }
+{num_hex}		{ return value(yyscanner, 16); }
+,			{ return ','; }
+"\.\.\."		{ return PE_ARRAY_RANGE; }
+}
+
+<config>{
+	/*
+	 * Please update config_term_names when new static term is added.
+	 */
+config			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG); }
+config1			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG1); }
+config2			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG2); }
+name			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NAME); }
+period			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD); }
+freq			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ); }
+branch_type		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE); }
+time			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_TIME); }
+call-graph		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CALLGRAPH); }
+stack-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_STACKSIZE); }
+max-stack		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_MAX_STACK); }
+nr			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_MAX_EVENTS); }
+inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
+no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
+overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
+no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
+percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
+aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
+aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
+metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+r{num_raw_hex}		{ return raw(yyscanner, _parse_state); }
+r0x{num_raw_hex}	{ return raw(yyscanner, _parse_state); }
+,			{ return ','; }
+"/"			{ BEGIN(INITIAL); return '/'; }
+{name_minus}		{ return str(yyscanner, PE_NAME); }
+\[all\]			{ return PE_ARRAY_ALL; }
+"["			{ BEGIN(array); return '['; }
+@{drv_cfg_term}		{ return drv_str(yyscanner, PE_DRV_CFG_TERM); }
+}
+
+<mem>{
+{modifier_bp}		{ return str(yyscanner, PE_MODIFIER_BP); }
+:			{ return ':'; }
+"/"			{ return '/'; }
+{num_dec}		{ return value(yyscanner, 10); }
+{num_hex}		{ return value(yyscanner, 16); }
+	/*
+	 * We need to separate 'mem:' scanner part, in order to get specific
+	 * modifier bits parsed out. Otherwise we would need to handle PE_NAME
+	 * and we'd need to parse it manually. During the escape from <mem>
+	 * state we need to put the escaping char back, so we dont miss it.
+	 */
+.			{ unput(*yytext); BEGIN(INITIAL); }
+	/*
+	 * We destroy the scanner after reaching EOF,
+	 * but anyway just to be sure get back to INIT state.
+	 */
+<<EOF>>			{ BEGIN(INITIAL); }
+}
+
+cpu-cycles|cycles				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
+stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
+stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
+instructions					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
+cache-references				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES); }
+cache-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
+branch-instructions|branches			{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
+branch-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }
+bus-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BUS_CYCLES); }
+ref-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_REF_CPU_CYCLES); }
+cpu-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_CLOCK); }
+task-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_TASK_CLOCK); }
+page-faults|faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS); }
+minor-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
+major-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
+context-switches|cs				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES); }
+cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_MIGRATIONS); }
+alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
+emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
+dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
+duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
+bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
+
+	/*
+	 * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
+	 * Because the prefix cycles is mixed up with cpu-cycles.
+	 * loads and stores are mixed up with cache event
+	 */
+cycles-ct				|
+cycles-t				|
+mem-loads				|
+mem-loads-aux				|
+mem-stores				|
+topdown-[a-z-]+				|
+tx-capacity-[a-z-]+			|
+el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
+
+L1-dcache|l1-d|l1d|L1-data		|
+L1-icache|l1-i|l1i|L1-instruction	|
+LLC|L2					|
+dTLB|d-tlb|Data-TLB			|
+iTLB|i-tlb|Instruction-TLB		|
+branch|branches|bpu|btb|bpc		|
+node					{ return str(yyscanner, PE_NAME_CACHE_TYPE); }
+
+load|loads|read				|
+store|stores|write			|
+prefetch|prefetches			|
+speculative-read|speculative-load	|
+refs|Reference|ops|access		|
+misses|miss				{ return str(yyscanner, PE_NAME_CACHE_OP_RESULT); }
+
+mem:			{ BEGIN(mem); return PE_PREFIX_MEM; }
+r{num_raw_hex}		{ return raw(yyscanner, _parse_state); }
+{num_dec}		{ return value(yyscanner, 10); }
+{num_hex}		{ return value(yyscanner, 16); }
+
+{modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
+{bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
+{bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
+{name}			{ return pmu_str_check(yyscanner, _parse_state); }
+{name_tag}		{ return str(yyscanner, PE_NAME); }
+"/"			{ BEGIN(config); return '/'; }
+-			{ return '-'; }
+,			{ BEGIN(event); return ','; }
+:			{ return ':'; }
+"{"			{ BEGIN(event); return '{'; }
+"}"			{ return '}'; }
+=			{ return '='; }
+\n			{ }
+.			{ }
+
+%%
+
+int parse_events_wrap(void *scanner __maybe_unused)
+{
+	return 1;
+}
diff --git a/tools/lib/perf/parse-events.y b/tools/lib/perf/parse-events.y
new file mode 100644
index 000000000000..5ed21a4509e5
--- /dev/null
+++ b/tools/lib/perf/parse-events.y
@@ -0,0 +1,992 @@
+%define api.pure full
+%parse-param {void *_parse_state}
+%parse-param {void *scanner}
+%lex-param {void* scanner}
+%locations
+
+%{
+
+#define YYDEBUG 1
+
+#include <fnmatch.h>
+#include <stdio.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/zalloc.h>
+#include <internal/pmu.h>
+#include <internal/evsel.h>
+#include <internal/parse-events.h>
+#include "parse-events-bison.h"
+
+void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
+
+#define ABORT_ON(val) \
+do { \
+	if (val) \
+		YYABORT; \
+} while (0)
+
+static struct list_head* alloc_list(void)
+{
+	struct list_head *list;
+
+	list = malloc(sizeof(*list));
+	if (!list)
+		return NULL;
+
+	INIT_LIST_HEAD(list);
+	return list;
+}
+
+static void free_list_evsel(struct parse_events_state *parse_state,
+			    struct list_head* list_evsel)
+{
+	struct perf_evsel *evsel, *tmp;
+
+	list_for_each_entry_safe(evsel, tmp, list_evsel, node) {
+		list_del_init(&evsel->node);
+		parse_state->ops->perf_evsel__delete(evsel);
+	}
+	free(list_evsel);
+}
+
+/* list_event is assumed to point to malloc'ed memory */
+static void update_lists(struct list_head *list_event,
+			 struct list_head *list_all)
+{
+	/*
+	 * Called for single event definition. Update the
+	 * 'all event' list, and reinit the 'single event'
+	 * list, for next event definition.
+	 */
+	list_splice_tail(list_event, list_all);
+	free(list_event);
+}
+
+static void inc_group_count(struct list_head *list,
+		       struct parse_events_state *parse_state)
+{
+	/* Count groups only have more than 1 members */
+	if (!list_is_last(list->next, list))
+		parse_state->nr_groups++;
+}
+
+static int loc_term(void *loc_term_)
+{
+	YYLTYPE *loc_term = loc_term_;
+
+	return loc_term ? loc_term->first_column : 0;
+}
+
+static int loc_val(void *loc_val_)
+{
+	YYLTYPE *loc_val = loc_val_;
+
+	return loc_val ? loc_val->first_column  : 0;
+}
+
+%}
+
+%token PE_START_EVENTS PE_START_TERMS
+%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_RAW PE_TERM
+%token PE_VALUE_SYM_TOOL
+%token PE_EVENT_NAME
+%token PE_NAME
+%token PE_BPF_OBJECT PE_BPF_SOURCE
+%token PE_MODIFIER_EVENT PE_MODIFIER_BP
+%token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
+%token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
+%token PE_ERROR
+%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%token PE_ARRAY_ALL PE_ARRAY_RANGE
+%token PE_DRV_CFG_TERM
+%type <num> PE_VALUE
+%type <num> PE_VALUE_SYM_HW
+%type <num> PE_VALUE_SYM_SW
+%type <num> PE_VALUE_SYM_TOOL
+%type <num> PE_RAW
+%type <num> PE_TERM
+%type <num> value_sym
+%type <str> PE_NAME
+%type <str> PE_BPF_OBJECT
+%type <str> PE_BPF_SOURCE
+%type <str> PE_NAME_CACHE_TYPE
+%type <str> PE_NAME_CACHE_OP_RESULT
+%type <str> PE_MODIFIER_EVENT
+%type <str> PE_MODIFIER_BP
+%type <str> PE_EVENT_NAME
+%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
+%type <str> PE_DRV_CFG_TERM
+%type <str> event_pmu_name
+%destructor { free ($$); } <str>
+%type <term> event_term
+%destructor { parse_events_term__delete ($$); } <term>
+%type <list_terms> event_config
+%type <list_terms> opt_event_config
+%type <list_terms> opt_pmu_config
+%destructor { parse_events_terms__delete ($$); } <list_terms>
+%type <list_evsel> event_pmu
+%type <list_evsel> event_legacy_symbol
+%type <list_evsel> event_legacy_cache
+%type <list_evsel> event_legacy_mem
+%type <list_evsel> event_legacy_tracepoint
+%type <list_evsel> event_legacy_numeric
+%type <list_evsel> event_legacy_raw
+%type <list_evsel> event_bpf_file
+%type <list_evsel> event_def
+%type <list_evsel> event_mod
+%type <list_evsel> event_name
+%type <list_evsel> event
+%type <list_evsel> events
+%type <list_evsel> group_def
+%type <list_evsel> group
+%type <list_evsel> groups
+%destructor { free_list_evsel (_parse_state, $$); } <list_evsel>
+%type <tracepoint_name> tracepoint_name
+%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
+%type <array> array
+%type <array> array_term
+%type <array> array_terms
+%destructor { free ($$.ranges); } <array>
+
+%union
+{
+	char *str;
+	u64 num;
+	struct list_head *list_evsel;
+	struct list_head *list_terms;
+	struct parse_events_term *term;
+	struct tracepoint_name {
+		char *sys;
+		char *event;
+	} tracepoint_name;
+	struct parse_events_array array;
+}
+%%
+
+start:
+PE_START_EVENTS start_events
+|
+PE_START_TERMS  start_terms
+
+start_events: groups
+{
+	struct parse_events_state *parse_state = _parse_state;
+
+	/* frees $1 */
+	update_lists($1, &parse_state->list);
+}
+
+groups:
+groups ',' group
+{
+	struct list_head *list  = $1;
+	struct list_head *group = $3;
+
+	/* frees $3 */
+	update_lists(group, list);
+	$$ = list;
+}
+|
+groups ',' event
+{
+	struct list_head *list  = $1;
+	struct list_head *event = $3;
+
+	/* frees $3 */
+	update_lists(event, list);
+	$$ = list;
+}
+|
+group
+|
+event
+
+group:
+group_def ':' PE_MODIFIER_EVENT
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list = $1;
+	int err;
+
+	err = parse_events__modifier_group(list, $3, parse_state->guest);
+	free($3);
+	if (err) {
+		struct parse_events_error *error = parse_state->error;
+
+		parse_events__handle_error(error, @3.first_column,
+					   strdup("Bad modifier"), NULL);
+		free_list_evsel(parse_state, list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+group_def
+
+group_def:
+PE_NAME '{' events '}'
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list = $3;
+
+	inc_group_count(list, _parse_state);
+	parse_state->ops->set_leader($1, list, parse_state);
+	free($1);
+	$$ = list;
+}
+|
+'{' events '}'
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list = $2;
+
+	inc_group_count(list, _parse_state);
+	parse_state->ops->set_leader(NULL, list, parse_state);
+	$$ = list;
+}
+
+events:
+events ',' event
+{
+	struct list_head *event = $3;
+	struct list_head *list  = $1;
+
+	/* frees $3 */
+	update_lists(event, list);
+	$$ = list;
+}
+|
+event
+
+event: event_mod
+
+event_mod:
+event_name PE_MODIFIER_EVENT
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list = $1;
+	int err;
+
+	/*
+	 * Apply modifier on all events added by single event definition
+	 * (there could be more events added for multiple tracepoint
+	 * definitions via '*?'.
+	 */
+	err = parse_events__modifier_event(list, $2, false, parse_state->guest);
+	free($2);
+	if (err) {
+		struct parse_events_error *error = parse_state->error;
+
+		parse_events__handle_error(error, @2.first_column,
+					   strdup("Bad modifier"), NULL);
+		free_list_evsel(parse_state, list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+event_name
+
+event_name:
+PE_EVENT_NAME event_def
+{
+	int err;
+
+	err = parse_events_name($2, $1);
+	free($1);
+	if (err) {
+		free_list_evsel(_parse_state, $2);
+		YYABORT;
+	}
+	$$ = $2;
+}
+|
+event_def
+
+event_def: event_pmu |
+	   event_legacy_symbol |
+	   event_legacy_cache sep_dc |
+	   event_legacy_mem |
+	   event_legacy_tracepoint sep_dc |
+	   event_legacy_numeric sep_dc |
+	   event_legacy_raw sep_dc |
+	   event_bpf_file
+
+event_pmu_name:
+PE_NAME | PE_PMU_EVENT_PRE
+
+event_pmu:
+event_pmu_name opt_pmu_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
+	struct list_head *list = NULL, *orig_terms = NULL;
+
+#define CLEANUP_YYABORT					\
+	do {						\
+		parse_events_terms__delete($2);		\
+		parse_events_terms__delete(orig_terms);	\
+		free(list);				\
+		free($1);				\
+		YYABORT;				\
+	} while(0)
+
+	if (parse_events_copy_term_list($2, &orig_terms))
+		CLEANUP_YYABORT;
+
+	if (error)
+		error->idx = @1.first_column;
+
+	list = alloc_list();
+	if (!list)
+		CLEANUP_YYABORT;
+	if (parse_state->ops->add_pmu(parse_state, list, $1, $2, orig_terms, false, false))
+		CLEANUP_YYABORT;
+	parse_events_terms__delete($2);
+	parse_events_terms__delete(orig_terms);
+	free($1);
+	$$ = list;
+#undef CLEANUP_YYABORT
+}
+|
+PE_KERNEL_PMU_EVENT sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	err = parse_state->ops->add_pmu_multi(parse_state, $1, NULL, &list);
+	free($1);
+	if (err < 0)
+		YYABORT;
+	$$ = list;
+}
+|
+PE_KERNEL_PMU_EVENT opt_pmu_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	/* frees $2 */
+	err = parse_state->ops->add_pmu_multi(_parse_state, $1, $2, &list);
+	free($1);
+	if (err < 0)
+		YYABORT;
+	$$ = list;
+}
+|
+PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	char pmu_name[128];
+
+	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
+	free($1);
+	free($3);
+	if (parse_state->ops->add_pmu_multi(_parse_state, pmu_name, NULL, &list) < 0)
+		YYABORT;
+	$$ = list;
+}
+|
+PE_PMU_EVENT_FAKE sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	if (!list)
+		YYABORT;
+
+	err = parse_state->ops->add_pmu(parse_state, list, $1, NULL, NULL, false, false);
+	free($1);
+	if (err < 0) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_PMU_EVENT_FAKE opt_pmu_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	if (!list)
+		YYABORT;
+
+	err = parse_state->ops->add_pmu(parse_state, list, $1, $2, NULL, false, false);
+	free($1);
+	parse_events_terms__delete($2);
+	if (err < 0) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+value_sym:
+PE_VALUE_SYM_HW
+|
+PE_VALUE_SYM_SW
+
+event_legacy_symbol:
+value_sym '/' event_config '/'
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int type = $1 >> 16;
+	int config = $1 & 255;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_numeric(parse_state, list, type, config, $3);
+	parse_events_terms__delete($3);
+	if (err) {
+		free_list_evsel(_parse_state, list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+value_sym sep_slash_slash_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int type = $1 >> 16;
+	int config = $1 & 255;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	ABORT_ON(parse_state->ops->add_numeric(parse_state, list, type, config, NULL));
+	$$ = list;
+}
+|
+PE_VALUE_SYM_TOOL sep_slash_slash_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	ABORT_ON(parse_state->ops->add_tool(_parse_state, list, $1));
+	$$ = list;
+}
+
+event_legacy_cache:
+PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_cache(parse_state, list, $1, $3, $5, error, $6);
+	parse_events_terms__delete($6);
+	free($1);
+	free($3);
+	free($5);
+	if (err) {
+		free_list_evsel(parse_state, list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_cache(parse_state, list, $1, $3, NULL, error, $4);
+	parse_events_terms__delete($4);
+	free($1);
+	free($3);
+	if (err) {
+		free_list_evsel(parse_state, list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_NAME_CACHE_TYPE opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_cache(parse_state, list, $1, NULL, NULL, error, $2);
+	parse_events_terms__delete($2);
+	free($1);
+	if (err) {
+		free_list_evsel(parse_state, list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+event_legacy_mem:
+PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_breakpoint(parse_state, list, $2, $6, $4);
+	free($6);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	if (parse_state->ops->add_breakpoint(parse_state, list, $2, NULL, $4)) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_breakpoint(parse_state, list, $2, $4, 0);
+	free($4);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_PREFIX_MEM PE_VALUE sep_dc
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	if (parse_state->ops->add_breakpoint(parse_state, list, $2, NULL, 0)) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+event_legacy_tracepoint:
+tracepoint_name opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	if (error)
+		error->idx = @1.first_column;
+
+	err = parse_state->ops->add_tracepoint(parse_state, list, $1.sys, $1.event,
+					       error, $2);
+
+	parse_events_terms__delete($2);
+	free($1.sys);
+	free($1.event);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+tracepoint_name:
+PE_NAME '-' PE_NAME ':' PE_NAME
+{
+	struct tracepoint_name tracepoint;
+
+	ABORT_ON(asprintf(&tracepoint.sys, "%s-%s", $1, $3) < 0);
+	tracepoint.event = $5;
+	free($1);
+	free($3);
+	$$ = tracepoint;
+}
+|
+PE_NAME ':' PE_NAME
+{
+	struct tracepoint_name tracepoint = {$1, $3};
+
+	$$ = tracepoint;
+}
+
+event_legacy_numeric:
+PE_VALUE ':' PE_VALUE opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_numeric(_parse_state, list, (u32)$1, $3, $4);
+	parse_events_terms__delete($4);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+event_legacy_raw:
+PE_RAW opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
+	parse_events_terms__delete($2);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+event_bpf_file:
+PE_BPF_OBJECT opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_bpf(parse_state, list, $1, false, $2);
+	parse_events_terms__delete($2);
+	free($1);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+|
+PE_BPF_SOURCE opt_event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	struct list_head *list;
+	int err;
+
+	list = alloc_list();
+	ABORT_ON(!list);
+	err = parse_state->ops->add_bpf(parse_state, list, $1, true, $2);
+	parse_events_terms__delete($2);
+	if (err) {
+		free(list);
+		YYABORT;
+	}
+	$$ = list;
+}
+
+opt_event_config:
+'/' event_config '/'
+{
+	$$ = $2;
+}
+|
+'/' '/'
+{
+	$$ = NULL;
+}
+|
+{
+	$$ = NULL;
+}
+
+opt_pmu_config:
+'/' event_config '/'
+{
+	$$ = $2;
+}
+|
+'/' '/'
+{
+	$$ = NULL;
+}
+
+start_terms: event_config
+{
+	struct parse_events_state *parse_state = _parse_state;
+	if (parse_state->terms) {
+		parse_events_terms__delete ($1);
+		YYABORT;
+	}
+	parse_state->terms = $1;
+}
+
+event_config:
+event_config ',' event_term
+{
+	struct list_head *head = $1;
+	struct parse_events_term *term = $3;
+
+	if (!head) {
+		parse_events_term__delete(term);
+		YYABORT;
+	}
+	list_add_tail(&term->list, head);
+	$$ = $1;
+}
+|
+event_term
+{
+	struct list_head *head = malloc(sizeof(*head));
+	struct parse_events_term *term = $1;
+
+	ABORT_ON(!head);
+	INIT_LIST_HEAD(head);
+	list_add_tail(&term->list, head);
+	$$ = head;
+}
+
+event_term:
+PE_RAW
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_CONFIG,
+					NULL, $1, false, loc_term(&@1), 0));
+	$$ = term;
+}
+|
+PE_NAME '=' PE_NAME
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $3, loc_term(&@1), loc_val(&@3))) {
+		free($1);
+		free($3);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
+PE_NAME '=' PE_VALUE
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $3, false, loc_term(&@1), loc_val(&@3))) {
+		free($1);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
+PE_NAME '=' PE_VALUE_SYM_HW
+{
+	struct parse_events_term *term;
+	int config = $3 & 255;
+
+	if (parse_events_term__sym_hw(&term, $1, config)) {
+		free($1);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
+PE_NAME
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, 1, true, loc_term(&@1), 0)) {
+		free($1);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
+PE_VALUE_SYM_HW
+{
+	struct parse_events_term *term;
+	int config = $1 & 255;
+
+	ABORT_ON(parse_events_term__sym_hw(&term, NULL, config));
+	$$ = term;
+}
+|
+PE_TERM '=' PE_NAME
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__str(&term, (int)$1, NULL, $3,
+				   loc_term(&@1), loc_val(&@3))) {
+		free($3);
+		YYABORT;
+	}
+	$$ = term;
+}
+|
+PE_TERM '=' PE_VALUE
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false,
+					loc_term(&@1), loc_val(&@3)));
+	$$ = term;
+}
+|
+PE_TERM
+{
+	struct parse_events_term *term;
+
+	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, 1, true, loc_term(&@1), 0));
+	$$ = term;
+}
+|
+PE_NAME array '=' PE_NAME
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $4, loc_term(&@1), loc_val(&@4))) {
+		free($1);
+		free($4);
+		free($2.ranges);
+		YYABORT;
+	}
+	term->array = $2;
+	$$ = term;
+}
+|
+PE_NAME array '=' PE_VALUE
+{
+	struct parse_events_term *term;
+
+	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
+					$1, $4, false, loc_term(&@1), loc_val(&@4))) {
+		free($1);
+		free($2.ranges);
+		YYABORT;
+	}
+	term->array = $2;
+	$$ = term;
+}
+|
+PE_DRV_CFG_TERM
+{
+	struct parse_events_term *term;
+	char *config = strdup($1);
+
+	ABORT_ON(!config);
+	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
+					config, $1, loc_term(&@1), 0)) {
+		free($1);
+		free(config);
+		YYABORT;
+	}
+	$$ = term;
+}
+
+array:
+'[' array_terms ']'
+{
+	$$ = $2;
+}
+|
+PE_ARRAY_ALL
+{
+	$$.nr_ranges = 0;
+	$$.ranges = NULL;
+}
+
+array_terms:
+array_terms ',' array_term
+{
+	struct parse_events_array new_array;
+
+	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
+	new_array.ranges = realloc($1.ranges,
+				sizeof(new_array.ranges[0]) *
+				new_array.nr_ranges);
+	ABORT_ON(!new_array.ranges);
+	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
+	       $3.nr_ranges * sizeof(new_array.ranges[0]));
+	free($3.ranges);
+	$$ = new_array;
+}
+|
+array_term
+
+array_term:
+PE_VALUE
+{
+	struct parse_events_array array;
+
+	array.nr_ranges = 1;
+	array.ranges = malloc(sizeof(array.ranges[0]));
+	ABORT_ON(!array.ranges);
+	array.ranges[0].start = $1;
+	array.ranges[0].length = 1;
+	$$ = array;
+}
+|
+PE_VALUE PE_ARRAY_RANGE PE_VALUE
+{
+	struct parse_events_array array;
+
+	ABORT_ON($3 < $1);
+	array.nr_ranges = 1;
+	array.ranges = malloc(sizeof(array.ranges[0]));
+	ABORT_ON(!array.ranges);
+	array.ranges[0].start = $1;
+	array.ranges[0].length = $3 - $1 + 1;
+	$$ = array;
+}
+
+sep_dc: ':' |
+
+sep_slash_slash_dc: '/' '/' | ':' |
+
+%%
+
+void parse_events_error(YYLTYPE *loc, void *parse_state,
+			void *scanner __maybe_unused,
+			char const *msg __maybe_unused)
+{
+	parse_events_evlist_error(parse_state, loc->last_column, "parser error");
+}
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1d697cecf4ea..ad9e2de899da 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -66,8 +66,6 @@ perf-y += comm.o
 perf-y += thread.o
 perf-y += thread_map.o
 perf-y += trace-event-parse.o
-perf-y += parse-events-flex.o
-perf-y += parse-events-bison.o
 perf-y += pmu.o
 perf-y += trace-event-read.o
 perf-y += trace-event-info.o
@@ -209,16 +207,6 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
 # avoid compiler warnings in 32-bit mode
 CFLAGS_genelf_debug.o  += -Wno-packed
 
-$(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
-		--header-file=$(OUTPUT)util/parse-events-flex.h $(PARSER_DEBUG_FLEX) $<
-
-$(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
-	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
-		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
-
 $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/expr-flex.c \
@@ -239,7 +227,6 @@ ifeq ($(FLEX_GE_26),1)
 else
   flex_flags := -w
 endif
-CFLAGS_parse-events-flex.o  += $(flex_flags)
 CFLAGS_expr-flex.o          += $(flex_flags)
 
 bison_flags := -DYYENABLE_NLS=0
@@ -249,10 +236,8 @@ ifeq ($(BISON_GE_35),1)
 else
   bison_flags += -w
 endif
-CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 
-$(OUTPUT)util/parse-events.o: $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-bison.c
 $(OUTPUT)util/expr.o: $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-bison.c
 
 CFLAGS_bitmap.o        += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7b171252083c..44980b34e367 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -23,9 +23,6 @@
 #include "debug.h"
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
-#include "parse-events-bison.h"
-#define YY_EXTRA_TYPE void*
-#include "parse-events-flex.h"
 #include "pmu.h"
 #include "thread_map.h"
 #include "probe-file.h"
@@ -41,10 +38,6 @@
 
 #define MAX_NAME_LEN 100
 
-#ifdef PARSER_DEBUG
-extern int parse_events_debug;
-#endif
-int parse_events_parse(void *parse_state, void *scanner);
 static int get_config_terms(struct list_head *head_config,
 			    struct list_head *head_terms __maybe_unused);
 static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
@@ -1913,37 +1906,6 @@ perf_pmu__parse_check(const char *name)
 	return r ? r->type : PMU_EVENT_SYMBOL_ERR;
 }
 
-static int parse_events__scanner(const char *str,
-				 struct parse_events_state *parse_state,
-				 bool terms)
-{
-	YY_BUFFER_STATE buffer;
-	void *scanner;
-	int ret;
-
-	if (terms)
-		parse_state->stoken = PE_START_TERMS;
-	else
-		parse_state->stoken = PE_START_EVENTS;
-
-	ret = parse_events_lex_init_extra(parse_state, &scanner);
-	if (ret)
-		return ret;
-
-	buffer = parse_events__scan_string(str, scanner);
-
-#ifdef PARSER_DEBUG
-	parse_events_debug = 1;
-	parse_events_set_debug(1, scanner);
-#endif
-	ret = parse_events_parse(parse_state, scanner);
-
-	parse_events__flush_buffer(buffer, scanner);
-	parse_events__delete_buffer(buffer, scanner);
-	parse_events_lex_destroy(scanner);
-	return ret;
-}
-
 /*
  * parse event config string, return a list of event terms.
  */
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
deleted file mode 100644
index 1cebd5fcdb5d..000000000000
--- a/tools/perf/util/parse-events.l
+++ /dev/null
@@ -1,411 +0,0 @@
-
-%option reentrant
-%option bison-bridge
-%option prefix="parse_events_"
-%option stack
-%option bison-locations
-%option yylineno
-%option reject
-
-%{
-#include <errno.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include "parse-events.h"
-#include "parse-events-bison.h"
-#include "evsel.h"
-
-char *parse_events_get_text(yyscan_t yyscanner);
-YYSTYPE *parse_events_get_lval(yyscan_t yyscanner);
-
-static int __value(YYSTYPE *yylval, char *str, int base, int token)
-{
-	u64 num;
-
-	errno = 0;
-	num = strtoull(str, NULL, base);
-	if (errno)
-		return PE_ERROR;
-
-	yylval->num = num;
-	return token;
-}
-
-static int value(yyscan_t scanner, int base)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	return __value(yylval, text, base, PE_VALUE);
-}
-
-static int str(yyscan_t scanner, int token)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	if (text[0] != '\'') {
-		yylval->str = strdup(text);
-	} else {
-		/*
-		 * If a text tag specified on the command line
-		 * contains opening single quite ' then it is
-		 * expected that the tag ends with single quote
-		 * as well, like this:
-		 *     name=\'CPU_CLK_UNHALTED.THREAD:cmask=1\'
-		 * quotes need to be escaped to bypass shell
-		 * processing.
-		 */
-		yylval->str = strndup(&text[1], strlen(text) - 2);
-	}
-
-	return token;
-}
-
-static int raw(yyscan_t scanner, struct parse_events_state *parse_state)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	if (parse_state->ops->parse_check(text) == PMU_EVENT_SYMBOL)
-		return str(scanner, PE_NAME);
-
-	return __value(yylval, text + 1, 16, PE_RAW);
-}
-
-static bool isbpf_suffix(char *text)
-{
-	int len = strlen(text);
-
-	if (len < 2)
-		return false;
-	if ((text[len - 1] == 'c' || text[len - 1] == 'o') &&
-	    text[len - 2] == '.')
-		return true;
-	if (len > 4 && !strcmp(text + len - 4, ".obj"))
-		return true;
-	return false;
-}
-
-static bool isbpf(yyscan_t scanner)
-{
-	char *text = parse_events_get_text(scanner);
-	struct stat st;
-
-	if (!isbpf_suffix(text))
-		return false;
-
-	return stat(text, &st) == 0;
-}
-
-/*
- * This function is called when the parser gets two kind of input:
- *
- * 	@cfg1 or @cfg2=config
- *
- * The leading '@' is stripped off before 'cfg1' and 'cfg2=config' are given to
- * bison.  In the latter case it is necessary to keep the string intact so that
- * the PMU kernel driver can determine what configurable is associated to
- * 'config'.
- */
-static int drv_str(yyscan_t scanner, int token)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	/* Strip off the '@' */
-	yylval->str = strdup(text + 1);
-	return token;
-}
-
-#define REWIND(__alloc)				\
-do {								\
-	YYSTYPE *__yylval = parse_events_get_lval(yyscanner);	\
-	char *text = parse_events_get_text(yyscanner);		\
-								\
-	if (__alloc)						\
-		__yylval->str = strdup(text);			\
-								\
-	yycolumn -= strlen(text);				\
-	yyless(0);						\
-} while (0)
-
-static int pmu_str_check(yyscan_t scanner, struct parse_events_state *parse_state)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-	char *text = parse_events_get_text(scanner);
-
-	yylval->str = strdup(text);
-
-	/*
-	 * If we're not testing then parse check determines the PMU event type
-	 * which if it isn't a PMU returns PE_NAME. When testing the result of
-	 * parse check can't be trusted so we return PE_PMU_EVENT_FAKE unless
-	 * an '!' is present in which case the text can't be a PMU name.
-	 */
-	switch (parse_state->ops->parse_check(text)) {
-		case PMU_EVENT_SYMBOL_PREFIX:
-			return PE_PMU_EVENT_PRE;
-		case PMU_EVENT_SYMBOL_SUFFIX:
-			return PE_PMU_EVENT_SUF;
-		case PMU_EVENT_SYMBOL:
-			return parse_state->fake_pmu
-				? PE_PMU_EVENT_FAKE : PE_KERNEL_PMU_EVENT;
-		default:
-			return parse_state->fake_pmu && !strchr(text,'!')
-				? PE_PMU_EVENT_FAKE : PE_NAME;
-	}
-}
-
-static int sym(yyscan_t scanner, int type, int config)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-
-	yylval->num = (type << 16) + config;
-	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
-}
-
-static int tool(yyscan_t scanner, enum perf_tool_event event)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-
-	yylval->num = event;
-	return PE_VALUE_SYM_TOOL;
-}
-
-static int term(yyscan_t scanner, int type)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-
-	yylval->num = type;
-	return PE_TERM;
-}
-
-#define YY_USER_ACTION					\
-do {							\
-	yylloc->last_column  = yylloc->first_column;	\
-	yylloc->first_column = yycolumn;		\
-	yycolumn += yyleng;				\
-} while (0);
-
-#define USER_REJECT		\
-	yycolumn -= yyleng;	\
-	REJECT
-
-%}
-
-%x mem
-%s config
-%x event
-%x array
-
-group		[^,{}/]*[{][^}]*[}][^,{}/]*
-event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
-event		[^,{}/]+
-bpf_object	[^,{}]+\.(o|bpf)[a-zA-Z0-9._]*
-bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
-
-num_dec		[0-9]+
-num_hex		0x[a-fA-F0-9]+
-num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
-name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
-name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
-drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
-/* If you add a modifier you need to update check_modifier() */
-modifier_event	[ukhpPGHSDIWeb]+
-modifier_bp	[rwx]{1,3}
-
-%%
-
-%{
-	struct parse_events_state *_parse_state = parse_events_get_extra(yyscanner);
-
-	{
-		int start_token = _parse_state->stoken;
-
-		if (start_token == PE_START_TERMS)
-			BEGIN(config);
-		else if (start_token == PE_START_EVENTS)
-			BEGIN(event);
-
-		if (start_token) {
-			_parse_state->stoken = 0;
-			/*
-			 * The flex parser does not init locations variable
-			 * via the scan_string interface, so we need do the
-			 * init in here.
-			 */
-			yycolumn = 0;
-			return start_token;
-		}
-         }
-%}
-
-<event>{
-
-{group}		{
-			BEGIN(INITIAL);
-			REWIND(0);
-		}
-
-{event_pmu}	|
-{bpf_object}	|
-{bpf_source}	|
-{event}		{
-			BEGIN(INITIAL);
-			REWIND(1);
-			return PE_EVENT_NAME;
-		}
-
-<<EOF>>		{
-			BEGIN(INITIAL);
-			REWIND(0);
-		}
-,		{
-			return ',';
-		}
-}
-
-<array>{
-"]"			{ BEGIN(config); return ']'; }
-{num_dec}		{ return value(yyscanner, 10); }
-{num_hex}		{ return value(yyscanner, 16); }
-,			{ return ','; }
-"\.\.\."		{ return PE_ARRAY_RANGE; }
-}
-
-<config>{
-	/*
-	 * Please update config_term_names when new static term is added.
-	 */
-config			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG); }
-config1			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG1); }
-config2			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CONFIG2); }
-name			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NAME); }
-period			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD); }
-freq			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_SAMPLE_FREQ); }
-branch_type		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_BRANCH_SAMPLE_TYPE); }
-time			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_TIME); }
-call-graph		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_CALLGRAPH); }
-stack-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_STACKSIZE); }
-max-stack		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_MAX_STACK); }
-nr			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_MAX_EVENTS); }
-inherit			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_INHERIT); }
-no-inherit		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOINHERIT); }
-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_OVERWRITE); }
-no-overwrite		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_NOOVERWRITE); }
-percore			{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
-aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
-aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
-metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
-r{num_raw_hex}		{ return raw(yyscanner, _parse_state); }
-r0x{num_raw_hex}	{ return raw(yyscanner, _parse_state); }
-,			{ return ','; }
-"/"			{ BEGIN(INITIAL); return '/'; }
-{name_minus}		{ return str(yyscanner, PE_NAME); }
-\[all\]			{ return PE_ARRAY_ALL; }
-"["			{ BEGIN(array); return '['; }
-@{drv_cfg_term}		{ return drv_str(yyscanner, PE_DRV_CFG_TERM); }
-}
-
-<mem>{
-{modifier_bp}		{ return str(yyscanner, PE_MODIFIER_BP); }
-:			{ return ':'; }
-"/"			{ return '/'; }
-{num_dec}		{ return value(yyscanner, 10); }
-{num_hex}		{ return value(yyscanner, 16); }
-	/*
-	 * We need to separate 'mem:' scanner part, in order to get specific
-	 * modifier bits parsed out. Otherwise we would need to handle PE_NAME
-	 * and we'd need to parse it manually. During the escape from <mem>
-	 * state we need to put the escaping char back, so we dont miss it.
-	 */
-.			{ unput(*yytext); BEGIN(INITIAL); }
-	/*
-	 * We destroy the scanner after reaching EOF,
-	 * but anyway just to be sure get back to INIT state.
-	 */
-<<EOF>>			{ BEGIN(INITIAL); }
-}
-
-cpu-cycles|cycles				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
-stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
-stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
-cache-references				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_REFERENCES); }
-cache-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
-branch-instructions|branches			{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
-branch-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }
-bus-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BUS_CYCLES); }
-ref-cycles					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_REF_CPU_CYCLES); }
-cpu-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_CLOCK); }
-task-clock					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_TASK_CLOCK); }
-page-faults|faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS); }
-minor-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MIN); }
-major-faults					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_PAGE_FAULTS_MAJ); }
-context-switches|cs				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CONTEXT_SWITCHES); }
-cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CPU_MIGRATIONS); }
-alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
-emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
-dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
-duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
-bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
-cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
-
-	/*
-	 * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
-	 * Because the prefix cycles is mixed up with cpu-cycles.
-	 * loads and stores are mixed up with cache event
-	 */
-cycles-ct				|
-cycles-t				|
-mem-loads				|
-mem-loads-aux				|
-mem-stores				|
-topdown-[a-z-]+				|
-tx-capacity-[a-z-]+			|
-el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
-
-L1-dcache|l1-d|l1d|L1-data		|
-L1-icache|l1-i|l1i|L1-instruction	|
-LLC|L2					|
-dTLB|d-tlb|Data-TLB			|
-iTLB|i-tlb|Instruction-TLB		|
-branch|branches|bpu|btb|bpc		|
-node					{ return str(yyscanner, PE_NAME_CACHE_TYPE); }
-
-load|loads|read				|
-store|stores|write			|
-prefetch|prefetches			|
-speculative-read|speculative-load	|
-refs|Reference|ops|access		|
-misses|miss				{ return str(yyscanner, PE_NAME_CACHE_OP_RESULT); }
-
-mem:			{ BEGIN(mem); return PE_PREFIX_MEM; }
-r{num_raw_hex}		{ return raw(yyscanner, _parse_state); }
-{num_dec}		{ return value(yyscanner, 10); }
-{num_hex}		{ return value(yyscanner, 16); }
-
-{modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
-{bpf_object}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_OBJECT); }
-{bpf_source}		{ if (!isbpf(yyscanner)) { USER_REJECT }; return str(yyscanner, PE_BPF_SOURCE); }
-{name}			{ return pmu_str_check(yyscanner, _parse_state); }
-{name_tag}		{ return str(yyscanner, PE_NAME); }
-"/"			{ BEGIN(config); return '/'; }
--			{ return '-'; }
-,			{ BEGIN(event); return ','; }
-:			{ return ':'; }
-"{"			{ BEGIN(event); return '{'; }
-"}"			{ return '}'; }
-=			{ return '='; }
-\n			{ }
-.			{ }
-
-%%
-
-int parse_events_wrap(void *scanner __maybe_unused)
-{
-	return 1;
-}
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
deleted file mode 100644
index 38d29946fa07..000000000000
--- a/tools/perf/util/parse-events.y
+++ /dev/null
@@ -1,992 +0,0 @@
-%define api.pure full
-%parse-param {void *_parse_state}
-%parse-param {void *scanner}
-%lex-param {void* scanner}
-%locations
-
-%{
-
-#define YYDEBUG 1
-
-#include <fnmatch.h>
-#include <stdio.h>
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/zalloc.h>
-#include "pmu.h"
-#include "evsel.h"
-#include "parse-events.h"
-#include "parse-events-bison.h"
-
-void parse_events_error(YYLTYPE *loc, void *parse_state, void *scanner, char const *msg);
-
-#define ABORT_ON(val) \
-do { \
-	if (val) \
-		YYABORT; \
-} while (0)
-
-static struct list_head* alloc_list(void)
-{
-	struct list_head *list;
-
-	list = malloc(sizeof(*list));
-	if (!list)
-		return NULL;
-
-	INIT_LIST_HEAD(list);
-	return list;
-}
-
-static void free_list_evsel(struct parse_events_state *parse_state,
-			    struct list_head* list_evsel)
-{
-	struct perf_evsel *evsel, *tmp;
-
-	list_for_each_entry_safe(evsel, tmp, list_evsel, node) {
-		list_del_init(&evsel->node);
-		parse_state->ops->perf_evsel__delete(evsel);
-	}
-	free(list_evsel);
-}
-
-/* list_event is assumed to point to malloc'ed memory */
-static void update_lists(struct list_head *list_event,
-			 struct list_head *list_all)
-{
-	/*
-	 * Called for single event definition. Update the
-	 * 'all event' list, and reinit the 'single event'
-	 * list, for next event definition.
-	 */
-	list_splice_tail(list_event, list_all);
-	free(list_event);
-}
-
-static void inc_group_count(struct list_head *list,
-		       struct parse_events_state *parse_state)
-{
-	/* Count groups only have more than 1 members */
-	if (!list_is_last(list->next, list))
-		parse_state->nr_groups++;
-}
-
-static int loc_term(void *loc_term_)
-{
-	YYLTYPE *loc_term = loc_term_;
-
-	return loc_term ? loc_term->first_column : 0;
-}
-
-static int loc_val(void *loc_val_)
-{
-	YYLTYPE *loc_val = loc_val_;
-
-	return loc_val ? loc_val->first_column  : 0;
-}
-
-%}
-
-%token PE_START_EVENTS PE_START_TERMS
-%token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_RAW PE_TERM
-%token PE_VALUE_SYM_TOOL
-%token PE_EVENT_NAME
-%token PE_NAME
-%token PE_BPF_OBJECT PE_BPF_SOURCE
-%token PE_MODIFIER_EVENT PE_MODIFIER_BP
-%token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
-%token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
-%token PE_ERROR
-%token PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
-%token PE_ARRAY_ALL PE_ARRAY_RANGE
-%token PE_DRV_CFG_TERM
-%type <num> PE_VALUE
-%type <num> PE_VALUE_SYM_HW
-%type <num> PE_VALUE_SYM_SW
-%type <num> PE_VALUE_SYM_TOOL
-%type <num> PE_RAW
-%type <num> PE_TERM
-%type <num> value_sym
-%type <str> PE_NAME
-%type <str> PE_BPF_OBJECT
-%type <str> PE_BPF_SOURCE
-%type <str> PE_NAME_CACHE_TYPE
-%type <str> PE_NAME_CACHE_OP_RESULT
-%type <str> PE_MODIFIER_EVENT
-%type <str> PE_MODIFIER_BP
-%type <str> PE_EVENT_NAME
-%type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
-%type <str> PE_DRV_CFG_TERM
-%type <str> event_pmu_name
-%destructor { free ($$); } <str>
-%type <term> event_term
-%destructor { parse_events_term__delete ($$); } <term>
-%type <list_terms> event_config
-%type <list_terms> opt_event_config
-%type <list_terms> opt_pmu_config
-%destructor { parse_events_terms__delete ($$); } <list_terms>
-%type <list_evsel> event_pmu
-%type <list_evsel> event_legacy_symbol
-%type <list_evsel> event_legacy_cache
-%type <list_evsel> event_legacy_mem
-%type <list_evsel> event_legacy_tracepoint
-%type <list_evsel> event_legacy_numeric
-%type <list_evsel> event_legacy_raw
-%type <list_evsel> event_bpf_file
-%type <list_evsel> event_def
-%type <list_evsel> event_mod
-%type <list_evsel> event_name
-%type <list_evsel> event
-%type <list_evsel> events
-%type <list_evsel> group_def
-%type <list_evsel> group
-%type <list_evsel> groups
-%destructor { free_list_evsel (_parse_state, $$); } <list_evsel>
-%type <tracepoint_name> tracepoint_name
-%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
-%type <array> array
-%type <array> array_term
-%type <array> array_terms
-%destructor { free ($$.ranges); } <array>
-
-%union
-{
-	char *str;
-	u64 num;
-	struct list_head *list_evsel;
-	struct list_head *list_terms;
-	struct parse_events_term *term;
-	struct tracepoint_name {
-		char *sys;
-		char *event;
-	} tracepoint_name;
-	struct parse_events_array array;
-}
-%%
-
-start:
-PE_START_EVENTS start_events
-|
-PE_START_TERMS  start_terms
-
-start_events: groups
-{
-	struct parse_events_state *parse_state = _parse_state;
-
-	/* frees $1 */
-	update_lists($1, &parse_state->list);
-}
-
-groups:
-groups ',' group
-{
-	struct list_head *list  = $1;
-	struct list_head *group = $3;
-
-	/* frees $3 */
-	update_lists(group, list);
-	$$ = list;
-}
-|
-groups ',' event
-{
-	struct list_head *list  = $1;
-	struct list_head *event = $3;
-
-	/* frees $3 */
-	update_lists(event, list);
-	$$ = list;
-}
-|
-group
-|
-event
-
-group:
-group_def ':' PE_MODIFIER_EVENT
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list = $1;
-	int err;
-
-	err = parse_events__modifier_group(list, $3, parse_state->guest);
-	free($3);
-	if (err) {
-		struct parse_events_error *error = parse_state->error;
-
-		parse_events__handle_error(error, @3.first_column,
-					   strdup("Bad modifier"), NULL);
-		free_list_evsel(parse_state, list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-group_def
-
-group_def:
-PE_NAME '{' events '}'
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list = $3;
-
-	inc_group_count(list, _parse_state);
-	parse_state->ops->set_leader($1, list, parse_state);
-	free($1);
-	$$ = list;
-}
-|
-'{' events '}'
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list = $2;
-
-	inc_group_count(list, _parse_state);
-	parse_state->ops->set_leader(NULL, list, parse_state);
-	$$ = list;
-}
-
-events:
-events ',' event
-{
-	struct list_head *event = $3;
-	struct list_head *list  = $1;
-
-	/* frees $3 */
-	update_lists(event, list);
-	$$ = list;
-}
-|
-event
-
-event: event_mod
-
-event_mod:
-event_name PE_MODIFIER_EVENT
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list = $1;
-	int err;
-
-	/*
-	 * Apply modifier on all events added by single event definition
-	 * (there could be more events added for multiple tracepoint
-	 * definitions via '*?'.
-	 */
-	err = parse_events__modifier_event(list, $2, false, parse_state->guest);
-	free($2);
-	if (err) {
-		struct parse_events_error *error = parse_state->error;
-
-		parse_events__handle_error(error, @2.first_column,
-					   strdup("Bad modifier"), NULL);
-		free_list_evsel(parse_state, list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-event_name
-
-event_name:
-PE_EVENT_NAME event_def
-{
-	int err;
-
-	err = parse_events_name($2, $1);
-	free($1);
-	if (err) {
-		free_list_evsel(_parse_state, $2);
-		YYABORT;
-	}
-	$$ = $2;
-}
-|
-event_def
-
-event_def: event_pmu |
-	   event_legacy_symbol |
-	   event_legacy_cache sep_dc |
-	   event_legacy_mem |
-	   event_legacy_tracepoint sep_dc |
-	   event_legacy_numeric sep_dc |
-	   event_legacy_raw sep_dc |
-	   event_bpf_file
-
-event_pmu_name:
-PE_NAME | PE_PMU_EVENT_PRE
-
-event_pmu:
-event_pmu_name opt_pmu_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
-	struct list_head *list = NULL, *orig_terms = NULL;
-
-#define CLEANUP_YYABORT					\
-	do {						\
-		parse_events_terms__delete($2);		\
-		parse_events_terms__delete(orig_terms);	\
-		free(list);				\
-		free($1);				\
-		YYABORT;				\
-	} while(0)
-
-	if (parse_events_copy_term_list($2, &orig_terms))
-		CLEANUP_YYABORT;
-
-	if (error)
-		error->idx = @1.first_column;
-
-	list = alloc_list();
-	if (!list)
-		CLEANUP_YYABORT;
-	if (parse_state->ops->add_pmu(parse_state, list, $1, $2, orig_terms, false, false))
-		CLEANUP_YYABORT;
-	parse_events_terms__delete($2);
-	parse_events_terms__delete(orig_terms);
-	free($1);
-	$$ = list;
-#undef CLEANUP_YYABORT
-}
-|
-PE_KERNEL_PMU_EVENT sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	err = parse_state->ops->add_pmu_multi(parse_state, $1, NULL, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
-|
-PE_KERNEL_PMU_EVENT opt_pmu_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	/* frees $2 */
-	err = parse_state->ops->add_pmu_multi(_parse_state, $1, $2, &list);
-	free($1);
-	if (err < 0)
-		YYABORT;
-	$$ = list;
-}
-|
-PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	char pmu_name[128];
-
-	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
-	free($1);
-	free($3);
-	if (parse_state->ops->add_pmu_multi(_parse_state, pmu_name, NULL, &list) < 0)
-		YYABORT;
-	$$ = list;
-}
-|
-PE_PMU_EVENT_FAKE sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYABORT;
-
-	err = parse_state->ops->add_pmu(parse_state, list, $1, NULL, NULL, false, false);
-	free($1);
-	if (err < 0) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_PMU_EVENT_FAKE opt_pmu_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYABORT;
-
-	err = parse_state->ops->add_pmu(parse_state, list, $1, $2, NULL, false, false);
-	free($1);
-	parse_events_terms__delete($2);
-	if (err < 0) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-value_sym:
-PE_VALUE_SYM_HW
-|
-PE_VALUE_SYM_SW
-
-event_legacy_symbol:
-value_sym '/' event_config '/'
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_numeric(parse_state, list, type, config, $3);
-	parse_events_terms__delete($3);
-	if (err) {
-		free_list_evsel(_parse_state, list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-value_sym sep_slash_slash_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int type = $1 >> 16;
-	int config = $1 & 255;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	ABORT_ON(parse_state->ops->add_numeric(parse_state, list, type, config, NULL));
-	$$ = list;
-}
-|
-PE_VALUE_SYM_TOOL sep_slash_slash_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	ABORT_ON(parse_state->ops->add_tool(_parse_state, list, $1));
-	$$ = list;
-}
-
-event_legacy_cache:
-PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_cache(parse_state, list, $1, $3, $5, error, $6);
-	parse_events_terms__delete($6);
-	free($1);
-	free($3);
-	free($5);
-	if (err) {
-		free_list_evsel(parse_state, list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_cache(parse_state, list, $1, $3, NULL, error, $4);
-	parse_events_terms__delete($4);
-	free($1);
-	free($3);
-	if (err) {
-		free_list_evsel(parse_state, list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_NAME_CACHE_TYPE opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_cache(parse_state, list, $1, NULL, NULL, error, $2);
-	parse_events_terms__delete($2);
-	free($1);
-	if (err) {
-		free_list_evsel(parse_state, list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-event_legacy_mem:
-PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_breakpoint(parse_state, list, $2, $6, $4);
-	free($6);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	if (parse_state->ops->add_breakpoint(parse_state, list, $2, NULL, $4)) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_breakpoint(parse_state, list, $2, $4, 0);
-	free($4);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_PREFIX_MEM PE_VALUE sep_dc
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	if (parse_state->ops->add_breakpoint(parse_state, list, $2, NULL, 0)) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-event_legacy_tracepoint:
-tracepoint_name opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct parse_events_error *error = parse_state->error;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	if (error)
-		error->idx = @1.first_column;
-
-	err = parse_state->ops->add_tracepoint(parse_state, list, $1.sys, $1.event,
-					       error, $2);
-
-	parse_events_terms__delete($2);
-	free($1.sys);
-	free($1.event);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-tracepoint_name:
-PE_NAME '-' PE_NAME ':' PE_NAME
-{
-	struct tracepoint_name tracepoint;
-
-	ABORT_ON(asprintf(&tracepoint.sys, "%s-%s", $1, $3) < 0);
-	tracepoint.event = $5;
-	free($1);
-	free($3);
-	$$ = tracepoint;
-}
-|
-PE_NAME ':' PE_NAME
-{
-	struct tracepoint_name tracepoint = {$1, $3};
-
-	$$ = tracepoint;
-}
-
-event_legacy_numeric:
-PE_VALUE ':' PE_VALUE opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_numeric(_parse_state, list, (u32)$1, $3, $4);
-	parse_events_terms__delete($4);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-event_legacy_raw:
-PE_RAW opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
-	parse_events_terms__delete($2);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-event_bpf_file:
-PE_BPF_OBJECT opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_bpf(parse_state, list, $1, false, $2);
-	parse_events_terms__delete($2);
-	free($1);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-|
-PE_BPF_SOURCE opt_event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	ABORT_ON(!list);
-	err = parse_state->ops->add_bpf(parse_state, list, $1, true, $2);
-	parse_events_terms__delete($2);
-	if (err) {
-		free(list);
-		YYABORT;
-	}
-	$$ = list;
-}
-
-opt_event_config:
-'/' event_config '/'
-{
-	$$ = $2;
-}
-|
-'/' '/'
-{
-	$$ = NULL;
-}
-|
-{
-	$$ = NULL;
-}
-
-opt_pmu_config:
-'/' event_config '/'
-{
-	$$ = $2;
-}
-|
-'/' '/'
-{
-	$$ = NULL;
-}
-
-start_terms: event_config
-{
-	struct parse_events_state *parse_state = _parse_state;
-	if (parse_state->terms) {
-		parse_events_terms__delete ($1);
-		YYABORT;
-	}
-	parse_state->terms = $1;
-}
-
-event_config:
-event_config ',' event_term
-{
-	struct list_head *head = $1;
-	struct parse_events_term *term = $3;
-
-	if (!head) {
-		parse_events_term__delete(term);
-		YYABORT;
-	}
-	list_add_tail(&term->list, head);
-	$$ = $1;
-}
-|
-event_term
-{
-	struct list_head *head = malloc(sizeof(*head));
-	struct parse_events_term *term = $1;
-
-	ABORT_ON(!head);
-	INIT_LIST_HEAD(head);
-	list_add_tail(&term->list, head);
-	$$ = head;
-}
-
-event_term:
-PE_RAW
-{
-	struct parse_events_term *term;
-
-	ABORT_ON(parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_CONFIG,
-					NULL, $1, false, loc_term(&@1), 0));
-	$$ = term;
-}
-|
-PE_NAME '=' PE_NAME
-{
-	struct parse_events_term *term;
-
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, loc_term(&@1), loc_val(&@3))) {
-		free($1);
-		free($3);
-		YYABORT;
-	}
-	$$ = term;
-}
-|
-PE_NAME '=' PE_VALUE
-{
-	struct parse_events_term *term;
-
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $3, false, loc_term(&@1), loc_val(&@3))) {
-		free($1);
-		YYABORT;
-	}
-	$$ = term;
-}
-|
-PE_NAME '=' PE_VALUE_SYM_HW
-{
-	struct parse_events_term *term;
-	int config = $3 & 255;
-
-	if (parse_events_term__sym_hw(&term, $1, config)) {
-		free($1);
-		YYABORT;
-	}
-	$$ = term;
-}
-|
-PE_NAME
-{
-	struct parse_events_term *term;
-
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, 1, true, loc_term(&@1), 0)) {
-		free($1);
-		YYABORT;
-	}
-	$$ = term;
-}
-|
-PE_VALUE_SYM_HW
-{
-	struct parse_events_term *term;
-	int config = $1 & 255;
-
-	ABORT_ON(parse_events_term__sym_hw(&term, NULL, config));
-	$$ = term;
-}
-|
-PE_TERM '=' PE_NAME
-{
-	struct parse_events_term *term;
-
-	if (parse_events_term__str(&term, (int)$1, NULL, $3,
-				   loc_term(&@1), loc_val(&@3))) {
-		free($3);
-		YYABORT;
-	}
-	$$ = term;
-}
-|
-PE_TERM '=' PE_VALUE
-{
-	struct parse_events_term *term;
-
-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, $3, false,
-					loc_term(&@1), loc_val(&@3)));
-	$$ = term;
-}
-|
-PE_TERM
-{
-	struct parse_events_term *term;
-
-	ABORT_ON(parse_events_term__num(&term, (int)$1, NULL, 1, true, loc_term(&@1), 0));
-	$$ = term;
-}
-|
-PE_NAME array '=' PE_NAME
-{
-	struct parse_events_term *term;
-
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, loc_term(&@1), loc_val(&@4))) {
-		free($1);
-		free($4);
-		free($2.ranges);
-		YYABORT;
-	}
-	term->array = $2;
-	$$ = term;
-}
-|
-PE_NAME array '=' PE_VALUE
-{
-	struct parse_events_term *term;
-
-	if (parse_events_term__num(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					$1, $4, false, loc_term(&@1), loc_val(&@4))) {
-		free($1);
-		free($2.ranges);
-		YYABORT;
-	}
-	term->array = $2;
-	$$ = term;
-}
-|
-PE_DRV_CFG_TERM
-{
-	struct parse_events_term *term;
-	char *config = strdup($1);
-
-	ABORT_ON(!config);
-	if (parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG,
-					config, $1, loc_term(&@1), 0)) {
-		free($1);
-		free(config);
-		YYABORT;
-	}
-	$$ = term;
-}
-
-array:
-'[' array_terms ']'
-{
-	$$ = $2;
-}
-|
-PE_ARRAY_ALL
-{
-	$$.nr_ranges = 0;
-	$$.ranges = NULL;
-}
-
-array_terms:
-array_terms ',' array_term
-{
-	struct parse_events_array new_array;
-
-	new_array.nr_ranges = $1.nr_ranges + $3.nr_ranges;
-	new_array.ranges = realloc($1.ranges,
-				sizeof(new_array.ranges[0]) *
-				new_array.nr_ranges);
-	ABORT_ON(!new_array.ranges);
-	memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
-	       $3.nr_ranges * sizeof(new_array.ranges[0]));
-	free($3.ranges);
-	$$ = new_array;
-}
-|
-array_term
-
-array_term:
-PE_VALUE
-{
-	struct parse_events_array array;
-
-	array.nr_ranges = 1;
-	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
-	array.ranges[0].start = $1;
-	array.ranges[0].length = 1;
-	$$ = array;
-}
-|
-PE_VALUE PE_ARRAY_RANGE PE_VALUE
-{
-	struct parse_events_array array;
-
-	ABORT_ON($3 < $1);
-	array.nr_ranges = 1;
-	array.ranges = malloc(sizeof(array.ranges[0]));
-	ABORT_ON(!array.ranges);
-	array.ranges[0].start = $1;
-	array.ranges[0].length = $3 - $1 + 1;
-	$$ = array;
-}
-
-sep_dc: ':' |
-
-sep_slash_slash_dc: '/' '/' | ':' |
-
-%%
-
-void parse_events_error(YYLTYPE *loc, void *parse_state,
-			void *scanner __maybe_unused,
-			char const *msg __maybe_unused)
-{
-	parse_events_evlist_error(parse_state, loc->last_column, "parser error");
-}
-- 
2.31.1

