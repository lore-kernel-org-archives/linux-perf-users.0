Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9BCC433E0
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Feb 2021 20:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5007364D5D
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Feb 2021 20:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhBLUez (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Feb 2021 15:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhBLUew (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Feb 2021 15:34:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DC8764D5D;
        Fri, 12 Feb 2021 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613162050;
        bh=wsxAobsfZBfVL3J6K8JwnfzCIzCe1QIc+xOYU6dgGJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAkvK7onLOJJXAg+m7wvSs5B6FowWihS1Kk1/yRaCXigMKBHVk8IWefqBBYNWNZ1+
         HT9CXcl+/w9gIpaPxPWKPLz2cavGZMvxAm4hAHp0fmYzdG4QPkOoi/kZS10VHBMJv9
         f78hiBrZo7fypBUhwziHvzvr1+X6h673sODUCGffSQkIzTNaOs3x/r+JwRwW75D8u0
         QJVEJmb6Ax7W7SAe8Hp3V3kBxg42eMtnydSZ9/LgBodEqUOxFnAlNPl7rwAahd03Jt
         aTRnhOfN9p/Z3V+yz9+Zb+glhjJ4lkCuKr0wztWde6uxGlN59Yp7QhzRVSnQuMHvZ8
         68+uCMVHnTfkg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2018D40513; Fri, 12 Feb 2021 17:34:08 -0300 (-03)
Date:   Fri, 12 Feb 2021 17:34:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH][RFC] perf annotate: show full line locations with 'k' in
 UI
Message-ID: <20210212203408.GH1398414@kernel.org>
References: <9acb63e0-af38-eeeb-157e-32f6177da557@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9acb63e0-af38-eeeb-157e-32f6177da557@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Feb 12, 2021 at 03:42:47PM +0100, Martin Liška escreveu:
> Hello.
> 
> Sometimes it's handy to display also a filename of a source location, mainly because
> source lines can come from different files. I extended 'k' hotkey and one can now see:
> 
> 1) no source lines:
> 
>   1.31 │     ↓ je      130                                                                                   ▒
>        │     return iterative_hash_object (arg, val);                                                        ▒
>        │                                                                                                     ▒
>        │     if (!TYPE_P (arg))                                                                              ▒
>        │       movzwl  (%rdi),%edx                                                                           ▒
>  18.95 │       lea     tree_code_type,%rbx                                                                   ▒
>        │       movzwl  %dx,%ecx                                                                              ▒
>        │       mov     %rdx,%rax                                                                             ▒
>        │       cmpl    $0x2,(%rbx,%rcx,4)                                                                    ▒
>  11.76 │     ↓ jne     5f                                                                                    ▒
>   0.65 │     ↓ jmp     c0                                                                                    ▒
>        │       nop                                                                                           ▒
>        │     iterative_hash_template_arg(tree_node*, unsigned int) [clone .localalias]:                      ▒
>        │     tree_operand_length (const_tree node)                                                           ▒
>        │     {                                                                                               ▒
>        │     if (VL_EXP_CLASS_P (node))                                                                      ▒
>        │     return VL_EXP_OPERAND_LENGTH (node);                                                            ▒
>        │     else                                                                                            ▒
>        │     return TREE_CODE_LENGTH (TREE_CODE (node));                                                     ▒
>        │ 40:   lea     tree_code_length,%rdx                                                                 ▒
> 
> 2) only source lines displayed
> 
>   1.31 │     ↓ je      130                                                                                   ▒
>        │1774 return iterative_hash_object (arg, val);                                                        ▒
>        │                                                                                                     ▒
>        │1776 if (!TYPE_P (arg))                                                                              ▒
>        │       movzwl  (%rdi),%edx                                                                           ▒
>  18.95 │       lea     tree_code_type,%rbx                                                                   ▒
>        │       movzwl  %dx,%ecx                                                                              ▒
>        │       mov     %rdx,%rax                                                                             ▒
>        │       cmpl    $0x2,(%rbx,%rcx,4)                                                                    ▒
>  11.76 │     ↓ jne     5f                                                                                    ▒
>   0.65 │     ↓ jmp     c0                                                                                    ▒
>        │       nop                                                                                           ▒
>        │1785 iterative_hash_template_arg(tree_node*, unsigned int) [clone .localalias]:                      ▒
>        │3837 tree_operand_length (const_tree node)                                                           ▒
>        │3838 {                                                                                               ▒
>        │3839 if (VL_EXP_CLASS_P (node))                                                                      ▒
>        │3840 return VL_EXP_OPERAND_LENGTH (node);                                                            ▒
>        │3841 else                                                                                            ▒
>        │3842 return TREE_CODE_LENGTH (TREE_CODE (node));                                                     ▒
>        │ 40:   lea     tree_code_length,%rdx                                                                 ▒
> 
> full source locations displayed.
> 
>   1.31 │     ↓ je      130                                                                                   ▒
>        │/home/marxin/Programming/gcc/gcc/cp/pt.c:1774 return iterative_hash_object (arg, val);               ▒
>        │                                                                                                     ▒
>        │/home/marxin/Programming/gcc/gcc/cp/pt.c:1774 if (!TYPE_P (arg))                                     ▒
>        │       movzwl  (%rdi),%edx                                                                           ▒
>  18.95 │       lea     tree_code_type,%rbx                                                                   ▒
>        │       movzwl  %dx,%ecx                                                                              ▒
>        │       mov     %rdx,%rax                                                                             ▒
>        │       cmpl    $0x2,(%rbx,%rcx,4)                                                                    ▒
>  11.76 │     ↓ jne     5f                                                                                    ▒
>   0.65 │     ↓ jmp     c0                                                                                    ▒
>        │       nop                                                                                           ▒
>        │/home/marxin/Programming/gcc/gcc/cp/pt.c:1774 iterative_hash_template_arg(tree_node*, unsigned int) [▒
>        │/home/marxin/Programming/gcc/gcc/tree.h:3837 tree_operand_length (const_tree node)                   ▒
>        │/home/marxin/Programming/gcc/gcc/tree.h:3837 {                                                       ▒
>        │/home/marxin/Programming/gcc/gcc/tree.h:3837 if (VL_EXP_CLASS_P (node))                              ▒
>        │/home/marxin/Programming/gcc/gcc/tree.h:3837 return VL_EXP_OPERAND_LENGTH (node);                    ▒
>        │/home/marxin/Programming/gcc/gcc/tree.h:3837 else                                                    ▒
>        │/home/marxin/Programming/gcc/gcc/tree.h:3837 return TREE_CODE_LENGTH (TREE_CODE (node));             ▒
>        │ 40:   lea     tree_code_length,%rdx                                                                 ▒

It is valuable, I just think we should try to limit the number of
columns used by the source code line, perhaps something like:

   0.65 │     ↓ jmp     c0                                                                                    ▒
        │       nop                                                                                           ▒
        │/home/marxin/Programming/gcc/gcc/cp/pt.c:1774                                                        ▒
        │           iterative_hash_template_arg(tree_node*, unsigned int) [                                   ▒
        │/home/marxin/Programming/gcc/gcc/tree.h:3837                                                         ▒
        │           tree_operand_length (const_tree node)                                                     ▒
        │           {                                                                                         ▒
        │           if (VL_EXP_CLASS_P (node))                                                                ▒
        │           return VL_EXP_OPERAND_LENGTH (node);                                                      ▒
        │           else                                                                                      ▒
        │           return TREE_CODE_LENGTH (TREE_CODE (node));                                               ▒
        │ 40:   lea     tree_code_length,%rdx                                                                 ▒

Another idea is to, when requested, reserve one line at the bottom to
show what is the source code file:line for where the TUI cursor is, i.e.
you press down/up and the line under the cursor has its source file:line
shown at the second (from bottom to top) line in the screen.

- Arnaldo
 
> Thoughts?
> Thanks,
> Martin
> 
> ---
>  tools/perf/ui/browsers/annotate.c | 11 +++++++++--
>  tools/perf/util/annotate.c        | 24 ++++++++++++++++++------
>  tools/perf/util/annotate.h        |  2 ++
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index bd77825fd5a1..ca09736e14a3 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -746,7 +746,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  		"t             Circulate percent, total period, samples view\n"
>  		"c             Show min/max cycle\n"
>  		"/             Search string\n"
> -		"k             Toggle line numbers\n"
> +		"k             Circulate line numbers, full location, no source lines\n"
>  		"P             Print to [symbol_name].annotation file.\n"
>  		"r             Run available scripts\n"
>  		"p             Toggle percent type [local/global]\n"
> @@ -758,7 +758,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  			annotate_browser__show(&browser->b, title, help);
>  			continue;
>  		case 'k':
> -			notes->options->show_linenr = !notes->options->show_linenr;
> +			if (notes->options->show_fileloc) {
> +				notes->options->show_fileloc = false;
> +				notes->options->show_linenr = false;
> +			}
> +			else if (notes->options->show_linenr)
> +				notes->options->show_fileloc = true;
> +			else
> +				notes->options->show_linenr = true;
>  			break;
>  		case 'H':
>  			nd = browser->curr_hot;
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index e3eae646be3e..32e5926d587f 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1159,6 +1159,7 @@ struct annotate_args {
>  	s64			  offset;
>  	char			  *line;
>  	int			  line_nr;
> +	char			  *fileloc;
>  };
>  static void annotation_line__init(struct annotation_line *al,
> @@ -1168,6 +1169,7 @@ static void annotation_line__init(struct annotation_line *al,
>  	al->offset = args->offset;
>  	al->line = strdup(args->line);
>  	al->line_nr = args->line_nr;
> +	al->fileloc = args->fileloc;
>  	al->data_nr = nr;
>  }
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
> @@ -1511,6 +1514,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>  	args->offset  = offset;
>  	args->line    = parsed_line;
>  	args->line_nr = *line_nr;
> +	args->fileloc = *fileloc;
>  	args->ms.sym  = sym;
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
> +	char *fileloc = strdup("");
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
> @@ -3004,10 +3012,14 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  	if (!*al->line)
>  		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
>  	else if (al->offset == -1) {
> -		if (al->line_nr && notes->options->show_linenr)
> -			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
> -		else
> -			printed = scnprintf(bf, sizeof(bf), "%-*s  ", notes->widths.addr, " ");
> +		if (al->line_nr) {
> +			if (notes->options->show_fileloc)
> +				printed = scnprintf(bf, sizeof(bf), "%s ", al->fileloc);
> +			else if (notes->options->show_linenr)
> +				printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
> +			else
> +				printed = scnprintf(bf, sizeof(bf), "%-*s  ", notes->widths.addr, " ");
> +		}
>  		obj__printf(obj, bf);
>  		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
>  	} else {
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
