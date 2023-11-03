Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21411FCE
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="HrKlVHjx"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86FA9D42
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Nov 2023 22:49:07 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id ymvyqyGqr2IvKymvyq7BJd; Fri, 03 Nov 2023 06:41:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698990094;
	bh=/HR6R2/dBCV5KtAoNDtBGcIdggMj4KflzvoVgbVGe3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HrKlVHjxRPVmpNH5/JYmdS7ezpXE5VbSGMHB9kFVsrtdIczKexOlVpcjbntVXskkn
	 yH/VptbmPQ7pkeTwiEJ0Z0Y/c4if7NC4lXmSn5zLiXZB5XoyovKjaa7BIrL9BOXGj0
	 D8VuWrku7V3IS2lI2ZU4eBaOuNc0FNcFPyktfY9KrVMv7VSE5ZHgUcLXHyf+70lLZ3
	 rGvnAFe0p5j7N7stVCohDqe3EOPS9+S1Cx9B7gFRoBQYRucAtQzqMDAL3sn0z18Hii
	 u53db/Eyo0FlHiqhXKXn4i8J8TjNqfSyUwQsQGuzFihhAPsYuiaw7SQykwbiaHcPIe
	 gqh0soOGbQ8Bg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 03 Nov 2023 06:41:34 +0100
X-ME-IP: 86.243.2.178
Message-ID: <133a66fe-a7e7-42e2-822b-1f3caea7862a@wanadoo.fr>
Date: Fri, 3 Nov 2023 06:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] perf annotate: Move some fields to annotated_source
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20231102222653.4165959-1-namhyung@kernel.org>
 <20231102222653.4165959-5-namhyung@kernel.org>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231102222653.4165959-5-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 02/11/2023 à 23:26, Namhyung Kim a écrit :
> Some fields in the struct annotation are only used with annotated_source
> so better to be moved there in order to reduce memory consumption for
> other symbols.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/ui/browsers/annotate.c | 12 ++++++------
>   tools/perf/util/annotate.c        | 17 +++++++++--------
>   tools/perf/util/annotate.h        | 14 +++++++-------
>   3 files changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index d2470f87344d..1b42db70c998 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -384,7 +384,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>   		if (al->idx_asm < offset)
>   			offset = al->idx;
>   
> -		browser->b.nr_entries = notes->nr_entries;
> +		browser->b.nr_entries = notes->src->nr_entries;
>   		notes->options->hide_src_code = false;
>   		browser->b.seek(&browser->b, -offset, SEEK_CUR);
>   		browser->b.top_idx = al->idx - offset;
> @@ -402,7 +402,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
>   		if (al->idx_asm < offset)
>   			offset = al->idx_asm;
>   
> -		browser->b.nr_entries = notes->nr_asm_entries;
> +		browser->b.nr_entries = notes->src->nr_asm_entries;
>   		notes->options->hide_src_code = true;
>   		browser->b.seek(&browser->b, -offset, SEEK_CUR);
>   		browser->b.top_idx = al->idx_asm - offset;
> @@ -435,7 +435,7 @@ static void ui_browser__init_asm_mode(struct ui_browser *browser)
>   {
>   	struct annotation *notes = browser__annotation(browser);
>   	ui_browser__reset_index(browser);
> -	browser->nr_entries = notes->nr_asm_entries;
> +	browser->nr_entries = notes->src->nr_asm_entries;
>   }
>   
>   static int sym_title(struct symbol *sym, struct map *map, char *title,
> @@ -860,7 +860,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>   					   browser->b.height,
>   					   browser->b.index,
>   					   browser->b.top_idx,
> -					   notes->nr_asm_entries);
> +					   notes->src->nr_asm_entries);
>   		}
>   			continue;
>   		case K_ENTER:
> @@ -991,8 +991,8 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>   
>   	ui_helpline__push("Press ESC to exit");
>   
> -	browser.b.width = notes->max_line_len;
> -	browser.b.nr_entries = notes->nr_entries;
> +	browser.b.width = notes->src->max_line_len;
> +	browser.b.nr_entries = notes->src->nr_entries;
>   	browser.b.entries = &notes->src->source,
>   	browser.b.width += 18; /* Percentage */
>   
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 92a9adf9d5eb..ee7b8e1848a8 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2808,19 +2808,20 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
>   void annotation__set_offsets(struct annotation *notes, s64 size)
>   {
>   	struct annotation_line *al;
> +	struct annotated_source *src = notes->src;
>   
> -	notes->max_line_len = 0;
> -	notes->nr_entries = 0;
> -	notes->nr_asm_entries = 0;
> +	src->max_line_len = 0;
> +	src->nr_entries = 0;
> +	src->nr_asm_entries = 0;
>   
> -	list_for_each_entry(al, &notes->src->source, node) {
> +	list_for_each_entry(al, &src->source, node) {
>   		size_t line_len = strlen(al->line);
>   
> -		if (notes->max_line_len < line_len)
> -			notes->max_line_len = line_len;
> -		al->idx = notes->nr_entries++;
> +		if (src->max_line_len < line_len)
> +			src->max_line_len = line_len;
> +		al->idx = src->nr_entries++;
>   		if (al->offset != -1) {
> -			al->idx_asm = notes->nr_asm_entries++;
> +			al->idx_asm = src->nr_asm_entries++;
>   			/*
>   			 * FIXME: short term bandaid to cope with assembly
>   			 * routines that comes with labels in the same column
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index d8a221591926..c51ceb857bd6 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -268,10 +268,13 @@ struct cyc_hist {
>    * returns.
>    */
>   struct annotated_source {
> -	struct list_head   source;
> -	int    		   nr_histograms;
> -	size_t		   sizeof_sym_hist;
> -	struct sym_hist	   *histograms;
> +	struct list_head	source;
> +	int    			nr_histograms;

If this int...

> +	size_t			sizeof_sym_hist;
> +	struct sym_hist		*histograms;
> +	int			nr_entries;
> +	int			nr_asm_entries;
> +	u16			max_line_len;

... and these int and u16 were grouped, you would also save a hole in 
the struct and reduce padding.


On x86_64, after patch 4/5:
struct annotated_source {
	struct list_head           source;               /*     0    16 */
	int                        nr_histograms;        /*    16     4 */

	/* XXX 4 bytes hole, try to pack */			<====

	size_t                     sizeof_sym_hist;      /*    24     8 */
	struct sym_hist *          histograms;           /*    32     8 */
	int                        nr_entries;           /*    40     4 */
	int                        nr_asm_entries;       /*    44     4 */
	u16                        max_line_len;         /*    48     2 */

	/* size: 56, cachelines: 1, members: 7 */
	/* sum members: 46, holes: 1, sum holes: 4 */
	/* padding: 6 */					<====
	/* last cacheline: 56 bytes */
};

After patch 5/5, the struct would be just 64 bytes. If fields are 
re-ordered, it would be 56 bytes.

Because of rounding in memory allocations, 56 or 64 shouldn't change 
anything. But it would be more future proof, should something else be 
added here in the future.

CJ

>   };
>   
>   struct annotated_branch {
> @@ -289,9 +292,6 @@ struct LOCKABLE annotation {
>   	struct annotation_line	**offsets;
>   	int			nr_events;
>   	int			max_jump_sources;
> -	int			nr_entries;
> -	int			nr_asm_entries;
> -	u16			max_line_len;
>   	struct {
>   		u8		addr;
>   		u8		jumps;

