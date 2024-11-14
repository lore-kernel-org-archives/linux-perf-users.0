Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A01DF275;
	Thu, 14 Nov 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575785; cv=none; b=Tpc17OSxecB+E9mo3x/tLRMK+3cDtZG/w8nlH6Rh3y0fo+Y5NBEH19I1TJpHiaYAHLlgH/f4pBILob6553hid2GweK+7Ja4S+VCcfUt5lA+n1LpD1M8sQ0Hb/EdtqQCUnoVP0crp6SnVj1sVZYebuROgjw82R2asaUc0TPUTPD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575785; c=relaxed/simple;
	bh=FRPm7zXSfqmq/J9zUXN5o0yW/sDC2evZeaXizqGW3GQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G+z9YlcAYT1rPYAFL7tqRsia7JDYeibWWR4XZp2p+KcpenC9KpfCucK8CXhUu95Zbuwq9sm9vJHOm2R6moSWu+ApCaeNB4/G3csc1oTL1vvhFT6llzVBacn3EMFYVanmE92Th4bOXVeXkM8mLiVHSCkUfsEI4XeJh/JeEKl6hXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XpvXj6plDz1JCL6;
	Thu, 14 Nov 2024 17:11:33 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id A6A2914010C;
	Thu, 14 Nov 2024 17:16:18 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Nov 2024 17:16:17 +0800
Subject: Re: [PATCH] perf-probe: Fix --line option to show correct offset line
 number from function
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang
 Kan <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, Yury
 Norov <yury.norov@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S . Miller"
	<davem@davemloft.net>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <173153821454.2776880.582308516721515492.stgit@mhiramat.roam.corp.google.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <6d88ae99-c624-c08e-2272-5866105b10f1@huawei.com>
Date: Thu, 14 Nov 2024 17:16:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <173153821454.2776880.582308516721515492.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/11/14 6:50, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix --line option to show correct offset if the DWARF line info of the
> probe address has the statement lines in differnt functions.
> Currently debuginfo__find_probe_point() does
> 
>  (1) Get the line and file from CU's lineinfo
>  (2) Get the real function(function instance) of the address
>      (use this function's decl_line/decl_file as basement)
>  (2-1) Search the inlined function scope in the real function
>      for the given address.
>  (2-2) if there is inlined function, update basement line/file.
>  (2-3) verify the filename is same as basement filename.
>  (3) calculate the relative line number from basement.
> 
> The problem is in (1). Since we have no basement file/line info,
> we can not verify that the file/line info from CU's lineinfo.
> Li Huafei reported[1], the lineinfo may have several different lines
> for one address. We need to find most appropriate one based on
> the basement file/line.
> 
> [1] https://lore.kernel.org/all/20241108181909.3515716-2-lihuafei1@huawei.com/
> 
> This basically does
> 
>  - Introduce cu_find_lineinfo_after() which find the line after the
>    basement file/line information so that it can choose correct one.
>  - Swap the order of (1) and (2) so that we can pass the basement
>    file/line when searching lineinfo.
> 
> Reported-by: Li Huafei <lihuafei1@huawei.com>
> Closes: https://lore.kernel.org/all/20241108181909.3515716-2-lihuafei1@huawei.com/
> Fixes: 57f95bf5f882 ("perf probe: Show correct statement line number by perf probe -l")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Tested-by: Li Huafei <lihuafei1@huawei.com>

Thanks,
Huafei

> ---
>  tools/perf/util/dwarf-aux.c    |   78 ++++++++++++++++++++++++++++++++++------
>  tools/perf/util/dwarf-aux.h    |    7 ++++
>  tools/perf/util/probe-finder.c |   44 ++++++++++++++++-------
>  3 files changed, 105 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 92eb9c8dc3e5..4e3bf41746c1 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -60,14 +60,33 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
>  	return dwarf_formstring(&attr);
>  }
>  
> +static Dwarf_Line *get_next_statement_line(Dwarf_Lines *lines, size_t *idx, Dwarf_Addr addr)
> +{
> +	bool is_statement = false;
> +	Dwarf_Line *line;
> +	Dwarf_Addr laddr;
> +	size_t l = *idx;
> +
> +	while (!is_statement) {
> +		line = dwarf_onesrcline(lines, ++l);
> +		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
> +		    dwarf_linebeginstatement(line, &is_statement) != 0)
> +			return NULL;
> +		if (laddr > addr)
> +			return NULL;
> +	}
> +	*idx = l;
> +	return line;
> +}
> +
>  /* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
> -static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
> +static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr,
> +								 Dwarf_Lines **lines_p, size_t *idx)
>  {
>  	Dwarf_Addr laddr;
>  	Dwarf_Lines *lines;
>  	Dwarf_Line *line;
>  	size_t nlines, l, u, n;
> -	bool flag;
>  
>  	if (dwarf_getsrclines(cu_die, &lines, &nlines) != 0 ||
>  	    nlines == 0)
> @@ -91,16 +110,14 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>  		if (!line || dwarf_lineaddr(line, &laddr) != 0)
>  			return NULL;
>  	} while (laddr == addr);
> -	l++;
>  	/* Going forward to find the statement line */
> -	do {
> -		line = dwarf_onesrcline(lines, l++);
> -		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
> -		    dwarf_linebeginstatement(line, &flag) != 0)
> -			return NULL;
> -		if (laddr > addr)
> -			return NULL;
> -	} while (!flag);
> +	line = get_next_statement_line(lines, &l, addr);
> +	if (!line)
> +		return NULL;
> +	if (lines_p)
> +		*lines_p = lines;
> +	if (idx)
> +		*idx = l;
>  
>  	return line;
>  }
> @@ -129,7 +146,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  		goto out;
>  	}
>  
> -	line = cu_getsrc_die(cu_die, addr);
> +	line = cu_getsrc_die(cu_die, addr, NULL, NULL);
>  	if (line && dwarf_lineno(line, lineno) == 0) {
>  		*fname = dwarf_linesrc(line, NULL, NULL);
>  		if (!*fname)
> @@ -141,6 +158,43 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  	return (*lineno && *fname) ? *lineno : -ENOENT;
>  }
>  
> +/**
> + * cu_find_lineinfo_after - Get a line number after file:line for given address
> + * @cu_die: a CU DIE
> + * @addr: An address
> + * @lineno: a pointer which returns the line number
> + * @fname: the filename where searching the line
> + * @baseline: the basement line number
> + *
> + * Find a line number after @baseline in @fname for @addr in @cu_die.
> + * Return the found line number, or -ENOENT if not found.
> + */
> +int cu_find_lineinfo_after(Dwarf_Die *cu_die, Dwarf_Addr addr,
> +					int *lineno, const char *fname, int baseline)
> +{
> +	const char *line_fname;
> +	Dwarf_Lines *lines;
> +	Dwarf_Line *line;
> +	size_t idx = 0;
> +
> +	if (cu_find_lineinfo(cu_die, addr, &line_fname, lineno) < 0)
> +		return -ENOENT;
> +
> +	if (!strcmp(line_fname, fname) && baseline <= *lineno)
> +		return *lineno;
> +
> +	line = cu_getsrc_die(cu_die, addr, &lines, &idx);
> +
> +	while (line && dwarf_lineno(line, lineno) == 0) {
> +		line_fname = dwarf_linesrc(line, NULL, NULL);
> +		if (line_fname && !strcmp(line_fname, fname) && baseline <= *lineno)
> +			return *lineno;
> +		line = get_next_statement_line(lines, &idx, addr);
> +	}
> +
> +	return -ENOENT;
> +}
> +
>  static int __die_find_inline_cb(Dwarf_Die *die_mem, void *data);
>  
>  /**
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index bd7505812569..19edf21e2f78 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -23,6 +23,13 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
>  int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
>  		     const char **fname, int *lineno);
>  
> +/*
> + * Get the most likely line number for given address in given filename
> + * and basement line number.
> + */
> +int cu_find_lineinfo_after(Dwarf_Die *cudie, Dwarf_Addr addr,
> +					int *lineno, const char *fname, int baseline);
> +
>  /* Walk on functions at given address */
>  int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
>  			 int (*callback)(Dwarf_Die *, void *), void *data);
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 13ff45d3d6a4..efcacb5568e5 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1578,7 +1578,8 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  {
>  	Dwarf_Die cudie, spdie, indie;
>  	Dwarf_Addr _addr = 0, baseaddr = 0;
> -	const char *fname = NULL, *func = NULL, *basefunc = NULL, *tmp;
> +	const char *fname = NULL, *func = NULL, *basefunc = NULL;
> +	const char *basefname = NULL, *tmp;
>  	int baseline = 0, lineno = 0, ret = 0;
>  
>  	/* We always need to relocate the address for aranges */
> @@ -1592,11 +1593,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  		goto end;
>  	}
>  
> -	/* Find a corresponding line (filename and lineno) */
> -	cu_find_lineinfo(&cudie, (Dwarf_Addr)addr, &fname, &lineno);
> -	/* Don't care whether it failed or not */
> -
> -	/* Find a corresponding function (name, baseline and baseaddr) */
> +	/* Find the basement function (name, baseline and baseaddr) */
>  	if (die_find_realfunc(&cudie, (Dwarf_Addr)addr, &spdie)) {
>  		/* Get function entry information */
>  		func = basefunc = dwarf_diename(&spdie);
> @@ -1607,10 +1604,16 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  			goto post;
>  		}
>  
> -		fname = die_get_decl_file(&spdie);
> +		basefname = die_get_decl_file(&spdie);
> +		if (!basefname) {
> +			lineno = 0;
> +			goto post;
> +		}
> +
>  		if (addr == baseaddr) {
>  			/* Function entry - Relative line number is 0 */
>  			lineno = baseline;
> +			fname = basefname;
>  			goto post;
>  		}
>  
> @@ -1627,7 +1630,9 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  				 */
>  				lineno = die_get_call_lineno(&indie);
>  				fname = die_get_call_file(&indie);
> -				break;
> +				if (!fname || strcmp(fname, basefname))
> +					lineno = 0;
> +				goto post;
>  			} else {
>  				/*
>  				 * addr is in an inline function body.
> @@ -1636,20 +1641,35 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  				 * be the entry line of the inline function.
>  				 */
>  				tmp = dwarf_diename(&indie);
> -				if (!tmp ||
> -				    dwarf_decl_line(&indie, &baseline) != 0)
> -					break;
> +				basefname = die_get_decl_file(&indie);
> +				if (!tmp || !basefname ||
> +				    dwarf_decl_line(&indie, &baseline) != 0) {
> +					lineno = 0;
> +					goto post;
> +				}
>  				func = tmp;
>  				spdie = indie;
>  			}
>  		}
> +	}
> +
> +	if (!lineno) {
> +		/* Find a corresponding line (filename and lineno) */
> +		if (cu_find_lineinfo_after(&cudie, (Dwarf_Addr)addr, &lineno,
> +								   basefname, baseline) < 0)
> +			lineno = 0;
> +		else
> +			fname = basefname;
> +	}
> +
> +post:
> +	if (lineno) {
>  		/* Verify the lineno and baseline are in a same file */
>  		tmp = die_get_decl_file(&spdie);
>  		if (!tmp || (fname && strcmp(tmp, fname) != 0))
>  			lineno = 0;
>  	}
>  
> -post:
>  	/* Make a relative line number or an offset */
>  	if (lineno)
>  		ppt->line = lineno - baseline;
> 
> 
> .
> 
