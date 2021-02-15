Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E5BC433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Feb 2021 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291D164E32
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Feb 2021 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBOMfP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Feb 2021 07:35:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhBOMfM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Feb 2021 07:35:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA734AC32;
        Mon, 15 Feb 2021 12:34:29 +0000 (UTC)
Subject: Re: [PATCH][RFC] perf annotate: show full line locations with 'k' in
 UI
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <9acb63e0-af38-eeeb-157e-32f6177da557@suse.cz>
 <20210212203408.GH1398414@kernel.org>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
Message-ID: <5b59c46e-4907-7ab9-a68d-dd234e988dc7@suse.cz>
Date:   Mon, 15 Feb 2021 13:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212203408.GH1398414@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------C6EF3B088A119A782A97FA9F"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------C6EF3B088A119A782A97FA9F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/21 9:34 PM, Arnaldo Carvalho de Melo wrote:
> Another idea is to, when requested, reserve one line at the bottom to
> show what is the source codefile:line  for where the TUI cursor is, i.e.
> you press down/up and the line under the cursor has its sourcefile:line
> shown at the second (from bottom to top) line in the screen.

Hello.

I decided to use the footer bar and a full location is displayed when 'l'
hokey is pressed. I think it's quite rare feature, so on demand footer
line usage should be an appropriate place.

Thoughts?
Thanks,
Martin

--------------C6EF3B088A119A782A97FA9F
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-perf-annotate-show-full-source-location-with-l-hotke.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-perf-annotate-show-full-source-location-with-l-hotke.pa";
 filename*1="tch"

From f85a5d7e66c3437b62622ebdb1cd690722d05c53 Mon Sep 17 00:00:00 2001
From: Martin Liska <mliska@suse.cz>
Date: Mon, 15 Feb 2021 12:34:46 +0100
Subject: [PATCH] perf annotate: show full source location with 'l' hotkey
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Right now, when Line numbers are displayed, one can't easily
find a source file that the line corresponds to.

When a source line is selected and 'l' is pressed, full source file
location is displayed in perf UI footer line.

Signed-off-by: Martin Liška <mliska@suse.cz>
---
 tools/perf/ui/browsers/annotate.c | 23 +++++++++++++++++++++--
 tools/perf/util/annotate.c        | 12 ++++++++++--
 tools/perf/util/annotate.h        |  2 ++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index bd77825fd5a1..adf5ce513438 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -381,6 +381,23 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 	return true;
 }
 
+#define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
+
+static void annotate_browser__show_full_location(struct ui_browser *browser)
+{
+	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
+	struct disasm_line *cursor = disasm_line(ab->selection);
+	struct annotation_line *al = &cursor->al;
+
+	if (al->offset != -1 || al->fileloc == NULL) {
+		ui_helpline__puts("No source file location.");
+	} else {
+		char help_line[SYM_TITLE_MAX_SIZE];
+		sprintf (help_line, "Source file location: %s", al->fileloc);
+		ui_helpline__puts(help_line);
+	}
+}
+
 static void ui_browser__init_asm_mode(struct ui_browser *browser)
 {
 	struct annotation *notes = browser__annotation(browser);
@@ -388,8 +405,6 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
 	browser->nr_entries = notes->nr_asm_entries;
 }
 
-#define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
-
 static int sym_title(struct symbol *sym, struct map *map, char *title,
 		     size_t sz, int percent_type)
 {
@@ -747,6 +762,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"c             Show min/max cycle\n"
 		"/             Search string\n"
 		"k             Toggle line numbers\n"
+		"l             Show full source file location\n"
 		"P             Print to [symbol_name].annotation file.\n"
 		"r             Run available scripts\n"
 		"p             Toggle percent type [local/global]\n"
@@ -760,6 +776,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 'k':
 			notes->options->show_linenr = !notes->options->show_linenr;
 			break;
+		case 'l':
+			annotate_browser__show_full_location (&browser->b);
+			continue;
 		case 'H':
 			nd = browser->curr_hot;
 			break;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e3eae646be3e..e4b0c21362d8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1159,6 +1159,7 @@ struct annotate_args {
 	s64			  offset;
 	char			  *line;
 	int			  line_nr;
+	char			  *fileloc;
 };
 
 static void annotation_line__init(struct annotation_line *al,
@@ -1168,6 +1169,7 @@ static void annotation_line__init(struct annotation_line *al,
 	al->offset = args->offset;
 	al->line = strdup(args->line);
 	al->line_nr = args->line_nr;
+	al->fileloc = args->fileloc;
 	al->data_nr = nr;
 }
 
@@ -1480,7 +1482,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  */
 static int symbol__parse_objdump_line(struct symbol *sym,
 				      struct annotate_args *args,
-				      char *parsed_line, int *line_nr)
+				      char *parsed_line, int *line_nr, char **fileloc)
 {
 	struct map *map = args->ms.map;
 	struct annotation *notes = symbol__annotation(sym);
@@ -1492,6 +1494,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	/* /filename:linenr ? Save line number and ignore. */
 	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
 		*line_nr = atoi(parsed_line + match[1].rm_so);
+		*fileloc = strdup(parsed_line);
 		return 0;
 	}
 
@@ -1511,6 +1514,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 	args->offset  = offset;
 	args->line    = parsed_line;
 	args->line_nr = *line_nr;
+	args->fileloc = *fileloc;
 	args->ms.sym  = sym;
 
 	dl = disasm_line__new(args);
@@ -1805,6 +1809,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 			args->offset = -1;
 			args->line = strdup(srcline);
 			args->line_nr = 0;
+			args->fileloc = NULL;
 			args->ms.sym  = sym;
 			dl = disasm_line__new(args);
 			if (dl) {
@@ -1816,6 +1821,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		args->offset = pc;
 		args->line = buf + prev_buf_size;
 		args->line_nr = 0;
+		args->fileloc = NULL;
 		args->ms.sym  = sym;
 		dl = disasm_line__new(args);
 		if (dl)
@@ -1850,6 +1856,7 @@ symbol__disassemble_bpf_image(struct symbol *sym,
 	args->offset = -1;
 	args->line = strdup("to be implemented");
 	args->line_nr = 0;
+	args->fileloc = NULL;
 	dl = disasm_line__new(args);
 	if (dl)
 		annotation_line__add(&dl->al, &notes->src->source);
@@ -1931,6 +1938,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	bool delete_extract = false;
 	bool decomp = false;
 	int lineno = 0;
+	char *fileloc = NULL;
 	int nline;
 	char *line;
 	size_t line_len;
@@ -2058,7 +2066,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
 		if (symbol__parse_objdump_line(sym, args, expanded_line,
-					       &lineno) < 0)
+					       &lineno, &fileloc) < 0)
 			break;
 		nline++;
 	}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 096cdaf21b01..3757416bcf46 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -84,6 +84,7 @@ struct annotation_options {
 	     print_lines,
 	     full_path,
 	     show_linenr,
+	     show_fileloc,
 	     show_nr_jumps,
 	     show_minmax_cycle,
 	     show_asm_raw,
@@ -136,6 +137,7 @@ struct annotation_line {
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
+	char			*fileloc;
 	int			 jump_sources;
 	float			 ipc;
 	u64			 cycles;
-- 
2.30.0


--------------C6EF3B088A119A782A97FA9F--
