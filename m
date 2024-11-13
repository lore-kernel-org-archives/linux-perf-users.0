Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7E185955;
	Wed, 13 Nov 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487208; cv=none; b=KZnX4rqdas9c71lLqq8Ea60hVy6NNLfV5wI+rVJNSTfC2Oia+I85XxwEXZMnB80/O53M9us6q5hes9nOkr1YvdxhSWy++Ec8S+JDynPAU+1GB9/ov04pbctAuOM9J5vANvMcF+D9CBrxiCNjt7wh4vQTmumkb3wcra8mCwokCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487208; c=relaxed/simple;
	bh=h+ZWZ2cmb5EMORtlsXR0c9X0JrbB8YGj1LTIf9CXef0=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IX0AIA20bp7EACHtvOkXyPHACf7iUpjRf4fLubqw8GlKb1jxFREw8ZaNOpnqA15FRXq4Ac4WK4qQi8/JfISCfTytv5wWTXZF6yn4vfvbXncqwMXmtlcyN2B5hK/EuYUAq1rzZLvLyvncr6/mL2yCxO+Gu1UKzdDjDhvL0/0Bht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XpGqp5HtLz1T9Xy;
	Wed, 13 Nov 2024 16:37:26 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id A4BDA1400D1;
	Wed, 13 Nov 2024 16:39:55 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 16:39:54 +0800
Subject: Re: [PATCH 2/2] perf probe: Fix the incorrect line number display in
 'perf probe -l'
From: Li Huafei <lihuafei1@huawei.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<dima@secretsauce.net>, <aleksander.lobakin@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241108181909.3515716-1-lihuafei1@huawei.com>
 <20241108181909.3515716-2-lihuafei1@huawei.com>
 <20241111170549.e4d1ba7b65aee3d890889277@kernel.org>
 <20241111210559.055c990dc94e95666f6464a2@kernel.org>
 <4751058c-62e3-4b99-9568-283fdf52b055@huawei.com>
Message-ID: <fa59a868-b7cc-5402-9379-4f7f931e5813@huawei.com>
Date: Wed, 13 Nov 2024 16:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4751058c-62e3-4b99-9568-283fdf52b055@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/11/12 11:09, Li Huafei wrote:
> Hi Masami,
> 
> On 2024/11/11 20:05, Masami Hiramatsu (Google) wrote:
>> Hi Li,
>>
>> On Mon, 11 Nov 2024 17:05:49 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>
>>> Currently debuginfo__find_probe_point() does
>>>
>>>  (1) Get the line and file from CU's lineinfo
>>>  (2) Get the real function(function instance) of the address
>>>      (use this function's decl_line/decl_file as basement)
>>>  (2-1) Search the inlined function scope in the real function
>>>      for the given address.
>>>  (2-2) if there is inlined function, update basement line/file.
>>>  (2-3) verify the filename is same as basement filename.
>>>  (3) calculate the relative line number from basement.
>>>
>>> The problem is in (1). Since we have no basement file/line info,
>>> we can not verify that the file/line info from CU's lineinfo.
>>> As Li shown above, the lineinfo may have several different lines
>>> for one address. We need to find most appropriate one based on
>>> the basement file/line.
>>>
>>> Thus what we need are
>>>
>>>  - Introduce cu_find_lineinfo_at() which gives basement file/line
>>>    information so that it can choose correct one. (hopefully)
>>>  - Swap the order of (1) and (2*) so that we can pass the basement
>>>    file/line when searching lineinfo. (Also, (2-3) should be right
>>>    before (3))
>>>
>>
>> Can you check below change fixes your issue?
>>
> 
> Thank you for the detailed explanation in your previous email. I tested
> your patch, and the results are as follows:
> 
>   # perf probe -l
>     probe:schedule       (on schedule:5@kernel/sched/core.c)
> 

Sorry, I made a mistake. 5 is the offset from the function entry, not
the line number. So your patch is ok.

Thanks，
Huafei

> Is this not as expected? Should our expectation be:
> 
>   probe:schedule       (on schedule:6780@kernel/sched/core.c)
> 
> Thanks,
> Huafei
> 
>> Thank you,
>>
>> >From 3027c4d3c8be874a7c84a98e73fe0837fd135129 Mon Sep 17 00:00:00 2001
>> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
>> Date: Mon, 11 Nov 2024 20:56:00 +0900
>> Subject: [PATCH] perf-probe: Fix --line option to show correct offset line
>>  number from function
>>
>> Fix --line option to show correct offset if the DWARF line info of the
>> probe address has the statement lines in differnt functions.
>>
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> ---
>>  tools/perf/util/dwarf-aux.c    | 78 ++++++++++++++++++++++++++++------
>>  tools/perf/util/dwarf-aux.h    |  7 +++
>>  tools/perf/util/probe-finder.c | 44 +++++++++++++------
>>  3 files changed, 105 insertions(+), 24 deletions(-)
>>
>> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
>> index 92eb9c8dc3e5..0bffec6962b8 100644
>> --- a/tools/perf/util/dwarf-aux.c
>> +++ b/tools/perf/util/dwarf-aux.c
>> @@ -60,14 +60,33 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die)
>>  	return dwarf_formstring(&attr);
>>  }
>>  
>> +static Dwarf_Line *get_next_statement_line(Dwarf_Lines *lines, size_t *idx, Dwarf_Addr addr)
>> +{
>> +	bool is_statement = false;
>> +	Dwarf_Line *line;
>> +	Dwarf_Addr laddr;
>> +	size_t l = *idx;
>> +
>> +	while (!is_statement) {
>> +		line = dwarf_onesrcline(lines, ++l);
>> +		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
>> +			dwarf_linebeginstatement(line, &is_statement) != 0)
>> +				return NULL;
>> +		if (laddr > addr)
>> +			return NULL;
>> +	}
>> +	*idx = l;
>> +	return line;
>> +}
>> +
>>  /* Unlike dwarf_getsrc_die(), cu_getsrc_die() only returns statement line */
>> -static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>> +static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr,
>> +								 Dwarf_Lines **lines_p, size_t *idx)
>>  {
>>  	Dwarf_Addr laddr;
>>  	Dwarf_Lines *lines;
>>  	Dwarf_Line *line;
>>  	size_t nlines, l, u, n;
>> -	bool flag;
>>  
>>  	if (dwarf_getsrclines(cu_die, &lines, &nlines) != 0 ||
>>  	    nlines == 0)
>> @@ -91,16 +110,14 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>>  		if (!line || dwarf_lineaddr(line, &laddr) != 0)
>>  			return NULL;
>>  	} while (laddr == addr);
>> -	l++;
>>  	/* Going forward to find the statement line */
>> -	do {
>> -		line = dwarf_onesrcline(lines, l++);
>> -		if (!line || dwarf_lineaddr(line, &laddr) != 0 ||
>> -		    dwarf_linebeginstatement(line, &flag) != 0)
>> -			return NULL;
>> -		if (laddr > addr)
>> -			return NULL;
>> -	} while (!flag);
>> +	line = get_next_statement_line(lines, &l, addr);
>> +	if (!line)
>> +		return NULL;
>> +	if (lines_p)
>> +		*lines_p = lines;
>> +	if (idx)
>> +		*idx = l;
>>  
>>  	return line;
>>  }
>> @@ -129,7 +146,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
>>  		goto out;
>>  	}
>>  
>> -	line = cu_getsrc_die(cu_die, addr);
>> +	line = cu_getsrc_die(cu_die, addr, NULL, NULL);
>>  	if (line && dwarf_lineno(line, lineno) == 0) {
>>  		*fname = dwarf_linesrc(line, NULL, NULL);
>>  		if (!*fname)
>> @@ -141,6 +158,43 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
>>  	return (*lineno && *fname) ? *lineno : -ENOENT;
>>  }
>>  
>> +/**
>> + * cu_find_lineinfo_after - Get a line number after file:line for given address
>> + * @cu_die: a CU DIE
>> + * @addr: An address
>> + * @lineno: a pointer which returns the line number
>> + * @fname: the filename where searching the line
>> + * @baseline: the basement line number
>> + *
>> + * Find a line number after @baseline in @fname for @addr in @cu_die.
>> + * Return the found line number, or -ENOENT if not found.
>> + */
>> +int cu_find_lineinfo_after(Dwarf_Die *cu_die, Dwarf_Addr addr,
>> +					int *lineno, const char *fname, int baseline)
>> +{
>> +	const char *line_fname;
>> +	Dwarf_Lines *lines;
>> +	Dwarf_Line *line;
>> +	size_t idx = 0;
>> +
>> +	if (cu_find_lineinfo(cu_die, addr, &line_fname, lineno) < 0)
>> +		return -ENOENT;
>> +
>> +	if (!strcmp(line_fname, fname) && baseline <= *lineno)
>> +		return *lineno;
>> +
>> +	line = cu_getsrc_die(cu_die, addr, &lines, &idx);
>> +
>> +	while (line && dwarf_lineno(line, lineno) == 0) {
>> +		line_fname = dwarf_linesrc(line, NULL, NULL);
>> +		if (line_fname && !strcmp(line_fname, fname) && baseline <= *lineno)
>> +			return *lineno;
>> +		line = get_next_statement_line(lines, &idx, addr);
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>> +
>>  static int __die_find_inline_cb(Dwarf_Die *die_mem, void *data);
>>  
>>  /**
>> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
>> index bd7505812569..19edf21e2f78 100644
>> --- a/tools/perf/util/dwarf-aux.h
>> +++ b/tools/perf/util/dwarf-aux.h
>> @@ -23,6 +23,13 @@ const char *cu_get_comp_dir(Dwarf_Die *cu_die);
>>  int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
>>  		     const char **fname, int *lineno);
>>  
>> +/*
>> + * Get the most likely line number for given address in given filename
>> + * and basement line number.
>> + */
>> +int cu_find_lineinfo_after(Dwarf_Die *cudie, Dwarf_Addr addr,
>> +					int *lineno, const char *fname, int baseline);
>> +
>>  /* Walk on functions at given address */
>>  int cu_walk_functions_at(Dwarf_Die *cu_die, Dwarf_Addr addr,
>>  			 int (*callback)(Dwarf_Die *, void *), void *data);
>> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
>> index 13ff45d3d6a4..efcacb5568e5 100644
>> --- a/tools/perf/util/probe-finder.c
>> +++ b/tools/perf/util/probe-finder.c
>> @@ -1578,7 +1578,8 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>>  {
>>  	Dwarf_Die cudie, spdie, indie;
>>  	Dwarf_Addr _addr = 0, baseaddr = 0;
>> -	const char *fname = NULL, *func = NULL, *basefunc = NULL, *tmp;
>> +	const char *fname = NULL, *func = NULL, *basefunc = NULL;
>> +	const char *basefname = NULL, *tmp;
>>  	int baseline = 0, lineno = 0, ret = 0;
>>  
>>  	/* We always need to relocate the address for aranges */
>> @@ -1592,11 +1593,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>>  		goto end;
>>  	}
>>  
>> -	/* Find a corresponding line (filename and lineno) */
>> -	cu_find_lineinfo(&cudie, (Dwarf_Addr)addr, &fname, &lineno);
>> -	/* Don't care whether it failed or not */
>> -
>> -	/* Find a corresponding function (name, baseline and baseaddr) */
>> +	/* Find the basement function (name, baseline and baseaddr) */
>>  	if (die_find_realfunc(&cudie, (Dwarf_Addr)addr, &spdie)) {
>>  		/* Get function entry information */
>>  		func = basefunc = dwarf_diename(&spdie);
>> @@ -1607,10 +1604,16 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>>  			goto post;
>>  		}
>>  
>> -		fname = die_get_decl_file(&spdie);
>> +		basefname = die_get_decl_file(&spdie);
>> +		if (!basefname) {
>> +			lineno = 0;
>> +			goto post;
>> +		}
>> +
>>  		if (addr == baseaddr) {
>>  			/* Function entry - Relative line number is 0 */
>>  			lineno = baseline;
>> +			fname = basefname;
>>  			goto post;
>>  		}
>>  
>> @@ -1627,7 +1630,9 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>>  				 */
>>  				lineno = die_get_call_lineno(&indie);
>>  				fname = die_get_call_file(&indie);
>> -				break;
>> +				if (!fname || strcmp(fname, basefname))
>> +					lineno = 0;
>> +				goto post;
>>  			} else {
>>  				/*
>>  				 * addr is in an inline function body.
>> @@ -1636,20 +1641,35 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>>  				 * be the entry line of the inline function.
>>  				 */
>>  				tmp = dwarf_diename(&indie);
>> -				if (!tmp ||
>> -				    dwarf_decl_line(&indie, &baseline) != 0)
>> -					break;
>> +				basefname = die_get_decl_file(&indie);
>> +				if (!tmp || !basefname ||
>> +				    dwarf_decl_line(&indie, &baseline) != 0) {
>> +					lineno = 0;
>> +					goto post;
>> +				}
>>  				func = tmp;
>>  				spdie = indie;
>>  			}
>>  		}
>> +	}
>> +
>> +	if (!lineno) {
>> +		/* Find a corresponding line (filename and lineno) */
>> +		if (cu_find_lineinfo_after(&cudie, (Dwarf_Addr)addr, &lineno,
>> +								   basefname, baseline) < 0)
>> +			lineno = 0;
>> +		else
>> +			fname = basefname;
>> +	}
>> +
>> +post:
>> +	if (lineno) {
>>  		/* Verify the lineno and baseline are in a same file */
>>  		tmp = die_get_decl_file(&spdie);
>>  		if (!tmp || (fname && strcmp(tmp, fname) != 0))
>>  			lineno = 0;
>>  	}
>>  
>> -post:
>>  	/* Make a relative line number or an offset */
>>  	if (lineno)
>>  		ppt->line = lineno - baseline;
>>
