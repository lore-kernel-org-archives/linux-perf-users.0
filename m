Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D7274651;
	Wed, 20 Aug 2025 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725333; cv=none; b=J1RdZbPPTnzip6tnRY68cQg/zbRQZev/kp1rfup63Lt48Zjac0m4wYhI8BUId8xsOrMOij0QjuLQ37ifYgUdyGA/uNezWGTb64ykzwNBp/E4Lw1PIpvPeJ9Y9+OuullR4uheRyS1mYTECMQExEhe2rNIALK+zX6qSiW9XGTheJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725333; c=relaxed/simple;
	bh=ia7JKuMSnuQna+Ux/qiQ9jwPTdyxh5VmuGqaTQhalq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYDb9PCy4pgt+KsWtOsPyIbqUS9u1TTnPVlA5wP3MBRgryLqM6zvGwrUF70G5FIiqHPbCM6Ka/hQ3JqPLq4tIFylQXV9tZ8COD759bU6jouBt76IajBF4+1nJDwcbMKngjN1TRsbaPzyUD1xcybeW/v8wFHNSWAdvZp4rB9GaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+cOF5kd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+cOF5kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBB6C4CEE7;
	Wed, 20 Aug 2025 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755725333;
	bh=ia7JKuMSnuQna+Ux/qiQ9jwPTdyxh5VmuGqaTQhalq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+cOF5kdNutQHpqbWmTgBmd8Zu0X7qQxhfgXBCUNePkutVCpc8a9G9iQEGDmFt847
	 xtf54IQIdbx5xzR7rG5H0zdOMIzkMqH2y2MmNo0m+ZXKdeBWD9lOgj21wX3g9zc5w0
	 Qb+bjytQFAIH7plfZ5CkVrOJRwXJnmRAn2SE+qNFVXaHRPoAEIDC4vTVuxkb2X3eCi
	 vM+76o8DTRMAutmhV6A31oDldZ1dIhuDovT7u5fAERdB4rfdD30+W3eA579dTg2Qs5
	 QxT5VelhafaIejNN2d+ON2WU/2ZU2tYdSHDcP/+G7AUnCY1o7XdGdXQD13BLdSr2d/
	 YCQJGXodb19ZQ==
Date: Wed, 20 Aug 2025 18:28:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 10/12] perf annotate: Hide data-type for stack
 operation and canary
Message-ID: <aKY-Ed1ZjOgRi8As@x1>
References: <20250816031635.25318-1-namhyung@kernel.org>
 <20250816031635.25318-11-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816031635.25318-11-namhyung@kernel.org>

On Fri, Aug 15, 2025 at 08:16:33PM -0700, Namhyung Kim wrote:
> It's mostly unnecessary to print when it has no actual type information
> like in the stack operations and canary.  Let's have them if -v option
> is given.

In the main 'report' TUI the 'V' key is wired to bumping the verbose
level, wiring it up in the annotation view seems in order :-)

- Arnaldo
 
> Before:
>   $ perf annotate --code-with-type
>   ...
>          : 0    0xd640 <_dl_relocate_object>:
>     0.00 :      0:       endbr64
>     0.00 :      4:       pushq   %rbp           # data-type: (stack operation)
>     0.00 :      5:       movq    %rsp, %rbp
>     0.00 :      8:       pushq   %r15           # data-type: (stack operation)
>     0.00 :      a:       pushq   %r14           # data-type: (stack operation)
>     0.00 :      c:       pushq   %r13           # data-type: (stack operation)
>     0.00 :      e:       pushq   %r12           # data-type: (stack operation)
>     0.00 :     10:       pushq   %rbx           # data-type: (stack operation)
>     0.00 :     11:       subq    $0xf8, %rsp
>     ...
>     0.00 :     d4:       testl   %eax, %eax
>     0.00 :     d6:       jne     0xf424
>     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-type: struct link_map +0xf0
>     0.00 :     e3:       testq   %rbx, %rbx
>     0.00 :     e6:       jne     0xf2dd
>     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: struct link_map +0xf8
>     ...
> 
> After:
>          : 0    0xd640 <_dl_relocate_object>:
>     0.00 :      0:       endbr64
>     0.00 :      4:       pushq   %rbp
>     0.00 :      5:       movq    %rsp, %rbp
>     0.00 :      8:       pushq   %r15
>     0.00 :      a:       pushq   %r14
>     0.00 :      c:       pushq   %r13
>     0.00 :      e:       pushq   %r12
>     0.00 :     10:       pushq   %rbx
>     0.00 :     11:       subq    $0xf8, %rsp
>     ...
>     0.00 :     d4:       testl   %eax, %eax
>     0.00 :     d6:       jne     0xf424
>     0.00 :     dc:       movq    0xf0(%r14), %rbx               # data-type: struct link_map +0xf0
>     0.00 :     e3:       testq   %rbx, %rbx
>     0.00 :     e6:       jne     0xf2dd
>     0.00 :     ec:       cmpq    $0, 0xf8(%r14)         # data-type: struct link_map +0xf8
>     ...
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 99e976d254493de2..ea68b32da7ce584a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -765,6 +765,17 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
>  			    struct debuginfo *dbg, struct disasm_line *dl,
>  			    int *type_offset);
>  
> +static bool needs_type_info(struct annotated_data_type *data_type)
> +{
> +	if (data_type == NULL || data_type == NO_TYPE)
> +		return false;
> +
> +	if (verbose)
> +		return true;
> +
> +	return (data_type != &stackop_type) && (data_type != &canary_type);
> +}
> +
>  static int
>  annotation_line__print(struct annotation_line *al, struct annotation_print_data *apd,
>  		       struct annotation_options *opts, int printed,
> @@ -844,7 +855,7 @@ annotation_line__print(struct annotation_line *al, struct annotation_print_data
>  
>  			data_type = __hist_entry__get_data_type(apd->he, apd->arch,
>  								apd->dbg, dl, &offset);
> -			if (data_type && data_type != NO_TYPE) {
> +			if (needs_type_info(data_type)) {
>  				char buf[4096];
>  
>  				printf("\t\t# data-type: %s",
> @@ -1958,7 +1969,7 @@ static int disasm_line__snprint_type_info(struct disasm_line *dl,
>  		return 1;
>  
>  	data_type = __hist_entry__get_data_type(apd->he, apd->arch, apd->dbg, dl, &offset);
> -	if (data_type == NULL || data_type == NO_TYPE)
> +	if (!needs_type_info(data_type))
>  		return 1;
>  
>  	printed = scnprintf(buf, len, "\t\t# data-type: %s", data_type->self.type_name);
> -- 
> 2.50.1
> 
