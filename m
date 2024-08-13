Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C11A2564;
	Tue, 13 Aug 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562154; cv=none; b=m7Kuwq1NrAvf5O7xq/cJB9bcPP7w4eBAwnBlMsFlKkk1+d03/ZIZcVciNl9c+ESxAmolHj/0Wdbl+fkJzqpZKan2MabwFm7lFxwzUDqFbzkRTLbbvrFDg+sMIBD2aj1DEuRs/KldQ3srHoPRFjfB4iRK1ExWikQKz3sxDDNz4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562154; c=relaxed/simple;
	bh=vRrhVOIyv1RSRh5C7dPq7mX0Z9S2yF6t+GXeZ380Rgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQn9JYLEDtkoPLiGXA3GhH87R2PD5BCMab/7820p8K/IHjw4RLf3ctdT99f6EmjXHFCwrA2DPszlXB7fXCO+zCHgB4ckmB+4w8krZSRihnmz9qhVliPE+YG07WtCpE53civ5HAXNCiaH7VMayBsSseBNkwBAfwsyonftyzpwwMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MySqx+rA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MySqx+rA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723562152; x=1755098152;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vRrhVOIyv1RSRh5C7dPq7mX0Z9S2yF6t+GXeZ380Rgo=;
  b=MySqx+rA5qVcPYeNKkG9CQkaqAqu3TvPDhjXD1kLjVUWlhsXmP7v6N22
   LIYicScM3iTUYZiZUs8l56UR1IywL7XtnKHWTMHq/eKVNTJpfJyalq9sK
   nTxUqjnedq/VyLpK8bs7quMTA4QAukSwas/iTQO9sLOIIfquCjY1Wqp5g
   FmHMR6cbE4M+Oqqxp1q5615q3I391ONHjyHLu6cqoOArmI8EQbQAOVkog
   31afqlb/ztLRro2+DbiAnVA6+MfaFl2APNrgpq0DLNvhqU8g1kjydlq2c
   qGsKnCvG6tPpCLOd5igxA4bQC72tHMbr3feDoSZ5xHLqKKlmeLVxxEgs7
   A==;
X-CSE-ConnectionGUID: 2ftjFGlnTPSgUn8ePaaIsQ==
X-CSE-MsgGUID: Cjyr70OuT+u9TStqrBHV7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21600433"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21600433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:15:52 -0700
X-CSE-ConnectionGUID: HYtjqdavTpaHcImOGoDl/g==
X-CSE-MsgGUID: c/OcaRZcQHqp4JvERCpClg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="96229172"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:15:51 -0700
Received: from [10.212.113.39] (kliang2-mobl1.ccr.corp.intel.com [10.212.113.39])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 606F920CFED0;
	Tue, 13 Aug 2024 08:15:50 -0700 (PDT)
Message-ID: <bdf150ed-6a41-4c54-a754-13c1f194fac3@linux.intel.com>
Date: Tue, 13 Aug 2024 11:15:49 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/9] Support branch counters in block annotation
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, peterz@infradead.org, mingo@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
References: <20240808193324.2027665-1-kan.liang@linux.intel.com>
 <Zrpk5a2GQl5i5APD@google.com> <Zrps-_ajW_zfze66@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zrps-_ajW_zfze66@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-12 4:13 p.m., Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 12, 2024 at 12:39:17PM -0700, Namhyung Kim wrote:
>> On Thu, Aug 08, 2024 at 12:33:15PM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>> Kan Liang (9):
>>>   perf report: Fix --total-cycles --stdio output error
>>>   perf report: Remove the first overflow check for branch counters
>>>   perf evlist: Save branch counters information
>>>   perf annotate: Save branch counters for each block
>>>   perf evsel: Assign abbr name for the branch counter events
>>>   perf report: Display the branch counter histogram
>>>   perf annotate: Display the branch counter histogram
>>>   perf script: Add branch counters
>>>   perf test: Add new test cases for the branch counter feature
>>
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Clashed with something here, can you please take a look and rebase to
> what is in perf-tools-next/perf-tools-next?

Tools-next/perf-tools-next doesn't include Weilin's TPEBS patch. So I
fail at the patch 5, rather than patch 6 (the failure you observed.)

Can you please update the perf-tools-next?
Or should I re-base on top of the tmp.perf-tools-next?

$ git branch -v
  master              1639fae5132b Merge tag 'drm-fixes-2023-06-17' of
git://anongit.freedesktop.org/drm/drm
* perf-tools-next     cb1898f58e0f perf annotate-data: Support
--skip-empty option
  tmp.perf-tools-next 9da782071202 perf test: Add test for Intel TPEBS
counting mode
$ git branch --show-current
perf-tools-next

$ git am lbr_event_logging_v2/000*
Applying: perf report: Fix --total-cycles --stdio output error
Applying: perf report: Remove the first overflow check for branch counters
Applying: perf evlist: Save branch counters information
Applying: perf annotate: Save branch counters for each block
Applying: perf evsel: Assign abbr name for the branch counter events
error: patch failed: tools/perf/util/evlist.c:33
error: tools/perf/util/evlist.c: patch does not apply
Patch failed at 0005 perf evsel: Assign abbr name for the branch counter
events

Thanks,
Kan

> 
> - Arnaldo
> 
>   ✓ [PATCH v2 9/9] perf test: Add new test cases for the branch counter feature
>     + Acked-by: Namhyung Kim <namhyung@kernel.org> (✓ DKIM/kernel.org)
>     + Reviewed-by: Andi Kleen <ak@linux.intel.com> (✓ DKIM/intel.com)
>     + Link: https://lore.kernel.org/r/20240808193324.2027665-10-kan.liang@linux.intel.com
>     + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>   ---
>   ✓ Signed: DKIM/intel.com (From: kan.liang@linux.intel.com)
> ---
> Total patches: 9
> ---
> Cover: ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.cover
>  Link: https://lore.kernel.org/r/20240808193324.2027665-1-kan.liang@linux.intel.com
>  Base: not specified
>        git am ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.mbx
> ⬢[acme@toolbox perf-tools-next]$        git am ./v2_20240808_kan_liang_support_branch_counters_in_block_annotation.mbx
> Applying: perf report: Fix --total-cycles --stdio output error
> Applying: perf report: Remove the first overflow check for branch counters
> Applying: perf evlist: Save branch counters information
> Applying: perf annotate: Save branch counters for each block
> Applying: perf evsel: Assign abbr name for the branch counter events
> Applying: perf report: Display the branch counter histogram
> error: patch failed: tools/perf/util/annotate.h:551
> error: tools/perf/util/annotate.h: patch does not apply
> Patch failed at 0006 perf report: Display the branch counter histogram
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf-tools-next]$
