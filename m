Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA1225761
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807306; cv=none; b=svtsotc/znss7Go3/hraIAMrsE/gU2tZdFf1m8zV8l8uHJseKtp2GkuCgPtt6G6nwnsy+egXFtpsNwEmXOiLg10Odts3YNugmjdpw8XN2o2ZR2eBYJGwGbTGRYLS7ook5FNRwR7Lz6MsDltR6VvyX0FZvUVX0KCtGThEAWEM1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807306; c=relaxed/simple;
	bh=4XR+ngAMCog6DO46Hyh5AiUKNlB6sNrS9+O0tkQsXis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGuJutIJpCfGN/QyHvdEWL5+BvwnhN1SOrpA28+X2jRyJ8OUlMuOXbJpPeyw53b5m2Ww2w1X0pQuK/0lRE36PFASldG5LbU0KjPFHivbKShPY1OX4ZyxSzNW6f9ss98y2LfthE5WTvBEg1vJ4P5YELw8bjiw+Al2WH6TCEJo8/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rCWlkOJl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCWlkOJl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so2704379f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 07:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739807302; x=1740412102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPDghrWJkASO+zl2RLTvdn4N9sHfOOgrUhUPDIBW/kE=;
        b=rCWlkOJlX1199Th+85qNH32ebykBZOoUVl/8pPIv/s76sspQBskbqlQS0F/EExcZ4p
         0IVUwmBiymsoROjZGtVaMSe/kdWk4/yJwYpzXfZlvH+l1P3YqhWxzq223DkdFXJyp+Z5
         xkysBJKPMxp/z+3PtGyzFE+qHTaDInxIcZ1tuedhHHOfpwblJHEG8xsa5axguPo7VSG8
         nXY38MLwIq2s3r6bhIvaAMWUjZn9+/W+CHpZjf+vheD1SQzJ/SR11U+fiTqGMrujLBgk
         RwgIDViE1ITXUe/p6qJ2v9nHkHvx8Px+Uc00SGQwkb0nmlKWD06WrPjP4uK34wPxpVYa
         PT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739807302; x=1740412102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPDghrWJkASO+zl2RLTvdn4N9sHfOOgrUhUPDIBW/kE=;
        b=O/bmo70InXgsbBMwGczbEzu0hv3P6uOyWlEIHM9e3RLhR3CCkn868SFVHep7wG859e
         N7NIiuDUDzarqGpyHdn3qQ1Slml8Z18WnAV4heYPYTd1RfKM9+D4IXA1TiS1JvfcQ3W5
         YKYL3bDBsJ6J/Y6dNm40imLg2YSlQABg/B4p5VJMELRhWIyJAaVqceWFcKdI5622kFp6
         lx0QhRMVed9IU4MinzMnP4WN//YJtacSnrqqC/BrSkXM+gaWTqexf1yyfwHM3QZOb0mc
         cc8oEwCtS471Q/LHtdU+E1vAKMGWt+o8IV1qCWV0GYEhhCmgG9BGdyZDFQQRxIqgP+5N
         RPUA==
X-Gm-Message-State: AOJu0YyPpG3YFEx/wE3uO+etgEDI6iEWRE672RTQzzbnjJ25tXB2moQa
	pKz8+DXpklCP08Ka+URAO+bM33+dWExUO8BdZl4SKlZiWpL1kLBRP7f9sNfKgdA=
X-Gm-Gg: ASbGncuyA2JSFEtDqAKYpgmCNZo1pxpgW00qm7plDfoBALHKUsrQEc/ISl+sMMElalY
	rPoiRO2gd5XEw5hDOCKF6htdYnGd/nJv2Oe9DmIcQSQjSwC8y8oGfanhkf9mlh2uTssPrpN+wPE
	q/3C9AkZ0kls9i0WBtrBtRCM8OFY9UO/+TXe0WVlEv7hi2iTd/9Ub2H9tWD4GtAYGusGxtV0a1v
	xKQM8HOtjKabboneOXX1MlWHP6bb3ttzYh3BakTR+9OxoSfk+9KjlE1Fn5KAJQ5OEuL2mcXuuyv
	sl5gOm57HWPA6W0Ylnh0lYbG2A==
X-Google-Smtp-Source: AGHT+IECdESRQYV/W+1X8h4Mc4PXA3ZTzsooOvg7iZMEiHqHLyviO+jMiRENW2nH7BAq2FLQxIJOCw==
X-Received: by 2002:a05:6000:188c:b0:38d:b6a9:2cd2 with SMTP id ffacd0b85a97d-38f3407371emr11339096f8f.46.1739807302022;
        Mon, 17 Feb 2025 07:48:22 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm12577678f8f.26.2025.02.17.07.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:48:21 -0800 (PST)
Message-ID: <964f60e0-fe88-48c8-87c3-a6ea2f3cac6c@linaro.org>
Date: Mon, 17 Feb 2025 15:48:20 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf: Pick the correct dwarf die while adding probe
 point for a function
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
 hbathini@linux.vnet.ibm.com, Aditya.Bodkhe1@ibm.com, acme@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
 namhyung@kernel.org
References: <20250212131949.68706-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250212131949.68706-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/02/2025 1:19 pm, Athira Rajeev wrote:
> Perf probe on vfs_fstatat fails as below on a powerpc system
> 
> ./perf probe -nf --max-probes=512 -a 'vfs_fstatat $params'
> Segmentation fault (core dumped)
> 
> This is observed while running perftool-testsuite_probe testcase.
> 
> While running with verbose, its observed that segfault happens
> at:
> 
>     synthesize_probe_trace_arg ()
>     synthesize_probe_trace_command ()
>     probe_file.add_event ()
>     apply_perf_probe_events ()
>     __cmd_probe ()
>     cmd_probe ()
>     run_builtin ()
>     handle_internal_command ()
>     main ()
> 
> Code in synthesize_probe_trace_arg() access a null value and results in
> segfault. Data structure which is null:
> struct probe_trace_arg arg->value
> 
> We are hitting a case where arg->value is null in probe point:
> "vfs_fstatat $params". This is happening since 'commit e896474fe485
> ("getname_maybe_null() - the third variant of pathname copy-in")'
> Before the commit, probe point for vfs_fstatat was getting added only
> for one location:
> 
> Writing event: p:probe/vfs_fstatat _text+6345404 dfd=%gpr3:s32 filename=%gpr4:x64 stat=%gpr5:x64 flags=%gpr6:s32
> 
> With this change, vfs_fstatat code is inlined for other locations in the
> code:
> Probe point found: __do_sys_lstat64+48
> Probe point found: __do_sys_stat64+48
> Probe point found: __do_sys_newlstat+48
> Probe point found: __do_sys_newstat+48
> Probe point found: vfs_fstatat+0
> 
> When trying to find matching dwarf information entry (DIE)
> from the debuginfo, the code incorrectly picks DIE which is
> not referring to vfs_fstatat. Snippet from dwarf entry in vmlinux
> debuginfo file.
> 
> The main abstract die is:
>   <1><4214883>: Abbrev Number: 147 (DW_TAG_subprogram)
>      <4214885>   DW_AT_external    : 1
>      <4214885>   DW_AT_name        : (indirect string, offset: 0x17b9f3): vfs_fstatat
> 
> With formal parameters:
>   <2><4214896>: Abbrev Number: 51 (DW_TAG_formal_parameter)
>      <4214897>   DW_AT_name        : dfd
>   <2><42148a3>: Abbrev Number: 23 (DW_TAG_formal_parameter)
>      <42148a4>   DW_AT_name        : (indirect string, offset: 0x8fda9): filename
>   <2><42148b0>: Abbrev Number: 23 (DW_TAG_formal_parameter)
>      <42148b1>   DW_AT_name        : (indirect string, offset: 0x16bd9c): stat
>   <2><42148bd>: Abbrev Number: 23 (DW_TAG_formal_parameter)
>      <42148be>   DW_AT_name        : (indirect string, offset: 0x39832b): flags
> 
> While collecting variables/parameters for a probe point, the function
> copy_variables_cb() also looks at dwarf debug entries based on the
> instruction address. Snippet
> 
>          if (dwarf_haspc(die_mem, vf->pf->addr))
>                  return DIE_FIND_CB_CONTINUE;
>          else
>                  return DIE_FIND_CB_SIBLING;
> 
> But incase of inlined function instance for vfs_fstatat, there are two
> entries which has the instruction address entry point as same.
> 
> Instance 1: which is for vfs_fstatat and DW_AT_abstract_origin points to
> 0x4214883 (reference above for main abstract die)
> 
> <3><42131fa>: Abbrev Number: 59 (DW_TAG_inlined_subroutine)
>      <42131fb>   DW_AT_abstract_origin: <0x4214883>
>      <42131ff>   DW_AT_entry_pc    : 0xc00000000062b1e0
> 
> Instance 2: which is not for vfs_fstatat but for getname
> 
>   <5><4213270>: Abbrev Number: 39 (DW_TAG_inlined_subroutine)
>      <4213271>   DW_AT_abstract_origin: <0x4215b6b>
>      <4213275>   DW_AT_entry_pc    : 0xc00000000062b1e0
> 
> But the copy_variables_cb() continues to add parameters from second
> instance also based on the dwarf_haspc() check. This results in
> formal parameters for getname also appended to params. But while
> filling in the args->value for these parameters, since these args
> are not part of dwarf with offset "42131fa". Hence value will be
> null. This incorrect args results in segfault when value field is
> accessed.
> 
> Save the Dwarf_Die which is the actual DW_TAG_subprogram as part of
> "struct probe_finder". In copy_variables_cb(), include check to make
> sure the DW_AT_abstract_origin points to the correct entry if the
> dwarf_haspc() matches the instruction address.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>   tools/perf/util/probe-finder.c | 21 ++++++++++++++++++---
>   tools/perf/util/probe-finder.h |  1 +
>   2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 1e769b68da37..361086a7adae 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -973,6 +973,7 @@ static int probe_point_search_cb(Dwarf_Die *sp_die, void *data)
>   	pr_debug("Matched function: %s [%lx]\n", dwarf_diename(sp_die),
>   		 (unsigned long)dwarf_dieoffset(sp_die));
>   	pf->fname = fname;
> +	memcpy(&pf->abstract_die, sp_die, sizeof(Dwarf_Die));
>   	if (pp->line) { /* Function relative line */
>   		dwarf_decl_line(sp_die, &pf->lno);
>   		pf->lno += pp->line;
> @@ -1179,6 +1180,8 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
>   	struct local_vars_finder *vf = data;
>   	struct probe_finder *pf = vf->pf;
>   	int tag;
> +	Dwarf_Attribute attr;
> +	Dwarf_Die var_die;
>   
>   	tag = dwarf_tag(die_mem);
>   	if (tag == DW_TAG_formal_parameter ||
> @@ -1196,10 +1199,22 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
>   		}
>   	}
>   
> -	if (dwarf_haspc(die_mem, vf->pf->addr))
> +	if (dwarf_haspc(die_mem, vf->pf->addr)) {
> +		/*
> +		 * when DW_AT_entry_pc contains instruction address,
> +		 * also check if the DW_AT_abstract_origin of die_mem
> +		 * points to correct die.
> +		 */
> +		if (dwarf_attr(die_mem, DW_AT_abstract_origin, &attr)) {
> +			dwarf_formref_die(&attr, &var_die);
> +			if (dwarf_dieoffset(&pf->abstract_die) != dwarf_dieoffset(&var_die))
> +				goto out;
> +		}
>   		return DIE_FIND_CB_CONTINUE;
> -	else
> -		return DIE_FIND_CB_SIBLING;
> +	}
> +
> +out:
> +	return DIE_FIND_CB_SIBLING;
>   }
>   
>   static int expand_probe_args(Dwarf_Die *sc_die, struct probe_finder *pf,
> diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
> index dcf6cc1e1cbe..b3039635c94e 100644
> --- a/tools/perf/util/probe-finder.h
> +++ b/tools/perf/util/probe-finder.h
> @@ -63,6 +63,7 @@ struct probe_finder {
>   	const char		*fname;		/* Real file name */
>   	Dwarf_Die		cu_die;		/* Current CU */
>   	Dwarf_Die		sp_die;
> +	Dwarf_Die		abstract_die;
>   	struct intlist		*lcache;	/* Line cache for lazy match */
>   
>   	/* For variable searching */

Reviewed-by: James Clark <james.clark@linaro.org>

