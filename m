Return-Path: <SRS0=rwtg=IE=vger.kernel.org=linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0674C433E0
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 14:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972B46501C
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 14:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCFOcM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Mar 2021 09:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCFOb7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Mar 2021 09:31:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32D1364FD6;
        Sat,  6 Mar 2021 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615041119;
        bh=9UixC1YsmyD1g3FlTN4ADrheIM7vi+HPPL0FVxlz8ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHWo1CJXH9KXEJeiYl1LLrxzekAtb55SMxe4EEmqST38IusOHkcwQH2s7lkiTCVkI
         TBhP8ollKZcAKLTuN8MsgHDlg0lZ3jU7O+ZKFciffh7/hd3bC4CUKbvIiwz/toKkdS
         WY+LA6ywxlmzWdvP7Me8ejPEXWckLq5DjtsqucNdfWsbS4g5DW/LNe6Di6QE7ikluO
         mjDf+LvN0qzkJqRIoAziADtt49wNMSiB0UMex2MR0q9u7Hq+kJXZcInC2R7wcFBLYc
         /8Uj0vCqECxSaTULULV2XwUkZg7vbJScvPTcd4LMZtbSNii4A2g4zT5uCpNkaXIFRv
         tBd/efVGOF0SA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34C9240647; Sat,  6 Mar 2021 11:31:55 -0300 (-03)
Date:   Sat, 6 Mar 2021 11:31:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH][RFC] perf annotate: show full line locations with 'k' in
 UI
Message-ID: <YEOSWxmy1mbe0ucw@kernel.org>
References: <9acb63e0-af38-eeeb-157e-32f6177da557@suse.cz>
 <20210212203408.GH1398414@kernel.org>
 <5b59c46e-4907-7ab9-a68d-dd234e988dc7@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b59c46e-4907-7ab9-a68d-dd234e988dc7@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Feb 15, 2021 at 01:34:29PM +0100, Martin Liška escreveu:
> On 2/12/21 9:34 PM, Arnaldo Carvalho de Melo wrote:
> > Another idea is to, when requested, reserve one line at the bottom to
> > show what is the source codefile:line  for where the TUI cursor is, i.e.
> > you press down/up and the line under the cursor has its sourcefile:line
> > shown at the second (from bottom to top) line in the screen.
> 
> Hello.
> 
> I decided to use the footer bar and a full location is displayed when 'l'
> hokey is pressed. I think it's quite rare feature, so on demand footer
> line usage should be an appropriate place.
> 
> Thoughts?
> Thanks,
> Martin

I'm trying to test this with 'perf top', then 'A' on a kernel symbol on
this system:

[root@five ~]# ls -la /usr/lib/debug/lib/modules/5.10.19-200.fc33.x86_64/vmlinux
-rwxr-xr-x. 1 root root 827665640 Feb 26 13:40 /usr/lib/debug/lib/modules/5.10.19-200.fc33.x86_64/vmlinux
[root@five ~]# uname -r
5.10.19-200.fc33.x86_64
[root@five ~]#

the annotate TUI finds the right vmlinux, matching the build-id of the
running kernel, so it should find the line loc, right?

But its not working, I get:

'No source file location.'

Its a fedora 33 system:

[root@five ~]# rpm -qa | grep kernel-debuginfo
kernel-debuginfo-common-x86_64-5.10.10-200.fc33.x86_64
kernel-debuginfo-5.10.10-200.fc33.x86_64
kernel-debuginfo-common-x86_64-5.10.13-200.fc33.x86_64
kernel-debuginfo-5.10.13-200.fc33.x86_64
kernel-debuginfo-common-x86_64-5.10.19-200.fc33.x86_64
kernel-debuginfo-5.10.19-200.fc33.x86_64
[root@five ~]# uname -a
Linux five 5.10.19-200.fc33.x86_64 #1 SMP Fri Feb 26 16:21:30 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@five ~]#

I see, it works only when pressing on source code lines:

Source file location: /usr/src/debug/kernel-5.10.fc33/linux-5.10.19-200.fc33.x86_64/./arch/x86/include/asm/msr.h:205

So we better improve that message? I.e. 'press on source code lines', or
'enable showing source code lines to get line number'?

- Arnaldo


> From f85a5d7e66c3437b62622ebdb1cd690722d05c53 Mon Sep 17 00:00:00 2001
> From: Martin Liska <mliska@suse.cz>
> Date: Mon, 15 Feb 2021 12:34:46 +0100
> Subject: [PATCH] perf annotate: show full source location with 'l' hotkey
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Right now, when Line numbers are displayed, one can't easily
> find a source file that the line corresponds to.
> 
> When a source line is selected and 'l' is pressed, full source file
> location is displayed in perf UI footer line.
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/ui/browsers/annotate.c | 23 +++++++++++++++++++++--
>  tools/perf/util/annotate.c        | 12 ++++++++++--
>  tools/perf/util/annotate.h        |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index bd77825fd5a1..adf5ce513438 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -381,6 +381,23 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>  	return true;
>  }
>  
> +#define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
> +
> +static void annotate_browser__show_full_location(struct ui_browser *browser)
> +{
> +	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
> +	struct disasm_line *cursor = disasm_line(ab->selection);
> +	struct annotation_line *al = &cursor->al;
> +
> +	if (al->offset != -1 || al->fileloc == NULL) {
> +		ui_helpline__puts("No source file location.");
> +	} else {
> +		char help_line[SYM_TITLE_MAX_SIZE];
> +		sprintf (help_line, "Source file location: %s", al->fileloc);
> +		ui_helpline__puts(help_line);
> +	}
> +}
> +
>  static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  {
>  	struct annotation *notes = browser__annotation(browser);
> @@ -388,8 +405,6 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  	browser->nr_entries = notes->nr_asm_entries;
>  }
>  
> -#define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
> -
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
>  		     size_t sz, int percent_type)
>  {
> @@ -747,6 +762,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		"c             Show min/max cycle\n"
>  		"/             Search string\n"
>  		"k             Toggle line numbers\n"
> +		"l             Show full source file location\n"
>  		"P             Print to [symbol_name].annotation file.\n"
>  		"r             Run available scripts\n"
>  		"p             Toggle percent type [local/global]\n"
> @@ -760,6 +776,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		case 'k':
>  			notes->options->show_linenr = !notes->options->show_linenr;
>  			break;
> +		case 'l':
> +			annotate_browser__show_full_location (&browser->b);
> +			continue;
>  		case 'H':
>  			nd = browser->curr_hot;
>  			break;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e3eae646be3e..e4b0c21362d8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1159,6 +1159,7 @@ struct annotate_args {
>  	s64			  offset;
>  	char			  *line;
>  	int			  line_nr;
> +	char			  *fileloc;
>  };
>  
>  static void annotation_line__init(struct annotation_line *al,
> @@ -1168,6 +1169,7 @@ static void annotation_line__init(struct annotation_line *al,
>  	al->offset = args->offset;
>  	al->line = strdup(args->line);
>  	al->line_nr = args->line_nr;
> +	al->fileloc = args->fileloc;
>  	al->data_nr = nr;
>  }
>  
> @@ -1480,7 +1482,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
>   */
>  static int symbol__parse_objdump_line(struct symbol *sym,
>  				      struct annotate_args *args,
> -				      char *parsed_line, int *line_nr)
> +				      char *parsed_line, int *line_nr, char **fileloc)
>  {
>  	struct map *map = args->ms.map;
>  	struct annotation *notes = symbol__annotation(sym);
> @@ -1492,6 +1494,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>  	/* /filename:linenr ? Save line number and ignore. */
>  	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
>  		*line_nr = atoi(parsed_line + match[1].rm_so);
> +		*fileloc = strdup(parsed_line);
>  		return 0;
>  	}
>  
> @@ -1511,6 +1514,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>  	args->offset  = offset;
>  	args->line    = parsed_line;
>  	args->line_nr = *line_nr;
> +	args->fileloc = *fileloc;
>  	args->ms.sym  = sym;
>  
>  	dl = disasm_line__new(args);
> @@ -1805,6 +1809,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
>  			args->offset = -1;
>  			args->line = strdup(srcline);
>  			args->line_nr = 0;
> +			args->fileloc = NULL;
>  			args->ms.sym  = sym;
>  			dl = disasm_line__new(args);
>  			if (dl) {
> @@ -1816,6 +1821,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
>  		args->offset = pc;
>  		args->line = buf + prev_buf_size;
>  		args->line_nr = 0;
> +		args->fileloc = NULL;
>  		args->ms.sym  = sym;
>  		dl = disasm_line__new(args);
>  		if (dl)
> @@ -1850,6 +1856,7 @@ symbol__disassemble_bpf_image(struct symbol *sym,
>  	args->offset = -1;
>  	args->line = strdup("to be implemented");
>  	args->line_nr = 0;
> +	args->fileloc = NULL;
>  	dl = disasm_line__new(args);
>  	if (dl)
>  		annotation_line__add(&dl->al, &notes->src->source);
> @@ -1931,6 +1938,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  	bool delete_extract = false;
>  	bool decomp = false;
>  	int lineno = 0;
> +	char *fileloc = NULL;
>  	int nline;
>  	char *line;
>  	size_t line_len;
> @@ -2058,7 +2066,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  		 * See disasm_line__new() and struct disasm_line::line_nr.
>  		 */
>  		if (symbol__parse_objdump_line(sym, args, expanded_line,
> -					       &lineno) < 0)
> +					       &lineno, &fileloc) < 0)
>  			break;
>  		nline++;
>  	}
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 096cdaf21b01..3757416bcf46 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -84,6 +84,7 @@ struct annotation_options {
>  	     print_lines,
>  	     full_path,
>  	     show_linenr,
> +	     show_fileloc,
>  	     show_nr_jumps,
>  	     show_minmax_cycle,
>  	     show_asm_raw,
> @@ -136,6 +137,7 @@ struct annotation_line {
>  	s64			 offset;
>  	char			*line;
>  	int			 line_nr;
> +	char			*fileloc;
>  	int			 jump_sources;
>  	float			 ipc;
>  	u64			 cycles;
> -- 
> 2.30.0
> 


-- 

- Arnaldo
