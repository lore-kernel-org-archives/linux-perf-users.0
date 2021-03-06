Return-Path: <SRS0=rwtg=IE=vger.kernel.org=linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E4EC433E0
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A396650BC
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Mar 2021 19:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhCFTRK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:17:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhCFTQy (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Mar 2021 14:16:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E48BC65004;
        Sat,  6 Mar 2021 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615058214;
        bh=nV6ae13fXxxsetQ6fzmDHfH0TawA3gmKiWa9auwwSis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjmwfN85Gbc+KAOBEJtgkF8E3vBYskAxrUXqp2mJu8Egb3ST7LbKXiXv72V4fE/PG
         TvbTe+zsO2gvx92+nGUuz5exSoblkLKbjskeT922A4ttcwEbKeV5h1wT29BvlB0Tzr
         y276wBhy/uyW+Q3UiHWidBRHrUw145iXqXVmydU8h3eTyV84dUWY75iMeC70JqjunB
         Z6lgjzDBGcAN9s5aFBoYSkOuAik+c7hDFJZNDX8j+hFrBZWKO9AHMihK61TJKBW7XV
         2S1A0FyzKElTaBZoLrt5LtXS8vPHCIkW4Q6Z0422s2BKFcYZQn7nXGqRJcH4wtbW0O
         1jQN2iUCw2VyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A94840647; Sat,  6 Mar 2021 16:16:51 -0300 (-03)
Date:   Sat, 6 Mar 2021 16:16:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH][RFC] perf annotate: show full line locations with 'k' in
 UI
Message-ID: <YEPVI8rHUffiBnjO@kernel.org>
References: <9acb63e0-af38-eeeb-157e-32f6177da557@suse.cz>
 <20210212203408.GH1398414@kernel.org>
 <5b59c46e-4907-7ab9-a68d-dd234e988dc7@suse.cz>
 <YEOSWxmy1mbe0ucw@kernel.org>
 <25a6384f-d862-5dda-4fec-8f0555599c75@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25a6384f-d862-5dda-4fec-8f0555599c75@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Mar 06, 2021 at 08:02:24PM +0100, Martin Liška escreveu:
> On 3/6/21 3:31 PM, Arnaldo Carvalho de Melo wrote:
> > I see, it works only when pressing on source code lines:
> 
> Hey.
> 
> Yes, I forgot to explicitly mention that.

Some requests, send the mail inline, not as an attachment, so that I can
use scripts that will extract the Message-ID, add it as a Link: tag,
etc.

Also something Ingo asked me since the dawn of times and I grew used to:


[PATCH][RFC] perf annotate: show full line locations with 'k' in

[PATCH][RFC] perf annotate: Show full line locations with 'k' in

Capitalize that :-)

Also please base your work on my perf/core branch, as I had to do
adjustments to one of the patch hunks.

> > Source file location: /usr/src/debug/kernel-5.10.fc33/linux-5.10.19-200.fc33.x86_64/./arch/x86/include/asm/msr.h:205
> > 
> > So we better improve that message? I.e. 'press on source code lines', or
> > 'enable showing source code lines to get line number'?
> 
> Fixed that in the attached patch. I got inspiration from 's' hotkey which prints the following warning:
> "Only available for assembly lines.".

Thanks, testing now.

- Arnaldo
 
> Thanks,
> Martin

> From 8fb7db7722c481ee4d1e0de2d2dc884f25aa90a1 Mon Sep 17 00:00:00 2001
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
> location is displayed in perf UI footer line. The hotkey works
> only for source code lines.
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/ui/browsers/annotate.c | 25 +++++++++++++++++++++++--
>  tools/perf/util/annotate.c        | 12 ++++++++++--
>  tools/perf/util/annotate.h        |  2 ++
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index bd77825fd5a1..cf60ba59b903 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -381,6 +381,25 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
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
> +	if (al->offset != -1)
> +		ui_helpline__puts("Only available for source code lines.");
> +	else if (al->fileloc == NULL)
> +		ui_helpline__puts("No source file location.");
> +	else {
> +		char help_line[SYM_TITLE_MAX_SIZE];
> +		sprintf (help_line, "Source file location: %s", al->fileloc);
> +		ui_helpline__puts(help_line);
> +	}
> +}
> +
>  static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  {
>  	struct annotation *notes = browser__annotation(browser);
> @@ -388,8 +407,6 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
>  	browser->nr_entries = notes->nr_asm_entries;
>  }
>  
> -#define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
> -
>  static int sym_title(struct symbol *sym, struct map *map, char *title,
>  		     size_t sz, int percent_type)
>  {
> @@ -747,6 +764,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		"c             Show min/max cycle\n"
>  		"/             Search string\n"
>  		"k             Toggle line numbers\n"
> +		"l             Show full source file location\n"
>  		"P             Print to [symbol_name].annotation file.\n"
>  		"r             Run available scripts\n"
>  		"p             Toggle percent type [local/global]\n"
> @@ -760,6 +778,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
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
> 2.30.1
> 


-- 

- Arnaldo
