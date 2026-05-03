Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1739D6CE;
	Sun,  3 May 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777852491; cv=none; b=szO5EGYqYXUmP01BGS6dFd9+OUlYedyxEy0rmcNNSynpKwcs+ccnb0mSnTW4QmdqO6UU7o/KsyUoozk16j2wBvNQX06b6i0s6SudKixH9/U43bcDoO01kiCBK44nyhNxvEtEGajS4IxXdYLPaQ+Wjjbrri4daRZKuegaK2EnX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777852491; c=relaxed/simple;
	bh=VQDC0d/dSEhD7rZ/x3Z2DNiIZh4nDMuhsqsjHVuTU5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBHAQuLJhNKbU4dRxrKtMswci+8/lMEMjndg6usDiTVeB2mRarRgH5xIQrfLCHE20y1U4ouzus0wy+b/khLV3pZWKg7cB9OgeiXbRonC1lAsuqFTOq6MTLD084mxoFISEQFXw5yFDnYsyEv8E8hS6eJXFKrwr1QNKjmNvC9pbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTKdb7oS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTKdb7oS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF48CC2BCB4;
	Sun,  3 May 2026 23:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777852491;
	bh=VQDC0d/dSEhD7rZ/x3Z2DNiIZh4nDMuhsqsjHVuTU5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTKdb7oS+SBlAl1jovmfUIIeVfp5HpOjjaSbVHhSXNIIxjkD0kCGysi94E1RoZ01a
	 UUJ6PMZ6iTcPwVcG39/Bt3Y3/7dQpdBLzLf6yU0HNJMYDZJK1XxS9vpMFpy3tHLUM5
	 1mWs6fVVGYB+ZWJPDUkvJecOeDOvhVhOJgtXwzG7wVO5qPjhYQlWiodTLQAEbct6d/
	 l+9dBbGkQ7b+gpbObVJNTqE/JHQvtd/j7C8yxmk1gQdFnQfMwor4I8irLfDtTt+odA
	 KPR8pnHzCm66JlZwlvYxjyeRg7CfjQ3PJCbO31FyamXlSBC35DcCjbj0EHWzJ/Th3x
	 cGC2ooxK/D55A==
Date: Sun, 3 May 2026 16:54:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zecheng Li <zli94@ncsu.edu>,
	Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] perf debuginfo: Fix libdw API contract violations
Message-ID: <affgSUgoSjPZmYGF@z2>
References: <20260503003552.1063540-1-irogers@google.com>
 <20260503171032.1559338-1-irogers@google.com>
 <20260503171032.1559338-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503171032.1559338-7-irogers@google.com>

On Sun, May 03, 2026 at 10:10:32AM -0700, Ian Rogers wrote:
> Check return value of `dwfl_report_end` during offline initialization.
> Validate `dwfl_module_relocation_info` result before passing to `strcmp`
> to avoid potential segmentation faults.
> 
> Additionally:
>  - Fix a file descriptor leak in `debuginfo__init_offline_dwarf()` when
>    `dwfl_report_offline()` or subsequent setup calls fail.
> 
> Fixes: 6f1b6291cf73 ("perf tools: Add util/debuginfo.[ch] files")
> Assisted-by: Gemini-CLI:Google Gemini 3
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> v4:
>  - Fix file descriptor leaks in debuginfo init paths.
> ---
>  tools/perf/util/debuginfo.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index 0e35c13abd04..84a78b30ceac 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -42,6 +42,7 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
>  {
>  	GElf_Addr dummy;
>  	int fd;
> +	bool fd_consumed = false;
>  
>  	fd = open(path, O_RDONLY);
>  	if (fd < 0)
> @@ -55,6 +56,7 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
>  	dbg->mod = dwfl_report_offline(dbg->dwfl, "", "", fd);
>  	if (!dbg->mod)
>  		goto error;
> +	fd_consumed = true;
>  
>  	dbg->dbg = dwfl_module_getdwarf(dbg->mod, &dbg->bias);
>  	if (!dbg->dbg)
> @@ -62,13 +64,14 @@ static int debuginfo__init_offline_dwarf(struct debuginfo *dbg,
>  
>  	dwfl_module_build_id(dbg->mod, &dbg->build_id, &dummy);
>  
> -	dwfl_report_end(dbg->dwfl, NULL, NULL);
> +	if (dwfl_report_end(dbg->dwfl, NULL, NULL) != 0)
> +		goto error;
>  
>  	return 0;
>  error:
>  	if (dbg->dwfl)
>  		dwfl_end(dbg->dwfl);
> -	else
> +	if (!fd_consumed)
>  		close(fd);
>  	memset(dbg, 0, sizeof(*dbg));
>  
> @@ -167,7 +170,7 @@ int debuginfo__get_text_offset(struct debuginfo *dbg, Dwarf_Addr *offs,
>  	/* Search the relocation related .text section */
>  	for (i = 0; i < n; i++) {
>  		p = dwfl_module_relocation_info(dbg->mod, i, &shndx);
> -		if (strcmp(p, ".text") == 0) {
> +		if (p && strcmp(p, ".text") == 0) {
>  			/* OK, get the section header */
>  			scn = elf_getscn(elf, shndx);
>  			if (!scn)
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
