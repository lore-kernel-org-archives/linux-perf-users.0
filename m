Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831B14F124;
	Thu,  3 Oct 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998152; cv=none; b=bSy02vsOuD3h1I48DZxj9dYh7UdHyuhG1WwSPdErgHEscpMJIrEptJqmZ5fvpDp6B+C0546LIZGZF7afV/dWX3H6ydRLvNLr7SQsXPm8bYV1TZd88EcsUiGHoHJkDdUJT1G32nn1kjmLUQUqbCsObt2eFZQp39Hq5rCr2bwNDa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998152; c=relaxed/simple;
	bh=EcjpaGGoIojuVWyEVxScjI6b5+oadMTUSKGV4NjiTNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JG8FWbHjG9fj8Yt59mKigxREPlPcLW1H1GeK11sGA5OMKUtLSCJvqECB73sXHN4VPSDK4Xjd8pX+l/ya1Cma/5rFmM1SSZm5cQmonSDMc8D9SHL2h6Bl0CHqJO+wGch6AcqyBmZmsH+R6XPtOKcAqiRUM+wkQfPvzGglh6atqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/J0j8DX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/J0j8DX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727998150; x=1759534150;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EcjpaGGoIojuVWyEVxScjI6b5+oadMTUSKGV4NjiTNs=;
  b=L/J0j8DXPnrpZDT86Ao26VX7ZxIbeXl9OSmKE8893BSDOer8q1M1qKV1
   ppiDK7FbQqPvDgNTpiSmF7qzibTavw5KtdG7xJhIXM9URy2XgsBdqZ8SC
   TLRIRiJrFdD/WQSOQU9gMeps7yeJS2ylLe/8xeYKrtj2nqvIEWwk1HcgM
   EMOqa38/NkwnH25GLwqtgTM1OLF3CblgTCv8vkrkDM2X2sg3c02OfO7fE
   rOoqoJvmI0jAwJ/nRbEiuyMUAlTueymv8HkIdCnpONlI/8XYJhpf0eHQ/
   ARmFRZva30aUAgv3T8zLQn0CoXsF2DfH6i5Ubn1f7b/SL1d4ITuWyOH/L
   A==;
X-CSE-ConnectionGUID: 5GaO9V3sRrSGQpcbtSyKwg==
X-CSE-MsgGUID: RX7WfYvAQ+C/KckG6z+jQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="38577565"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="38577565"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 16:29:09 -0700
X-CSE-ConnectionGUID: Uzc30iryRhun5iLSQt84DA==
X-CSE-MsgGUID: R9JJSgLtTIiFzjC7MZpJGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74512370"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 16:29:08 -0700
Received: from [10.212.90.18] (kliang2-mobl1.ccr.corp.intel.com [10.212.90.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 9737220B5782;
	Thu,  3 Oct 2024 16:29:07 -0700 (PDT)
Message-ID: <8df24fe8-4d90-4105-acf0-e4f2667c42c9@linux.intel.com>
Date: Thu, 3 Oct 2024 19:29:06 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 0/6] Bug fixes on topdown events reordering
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com>
 <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
 <CAP-5=fU7_RqcG+YO4C=FP_cy__eSd=ieJ_pOe4J-s2zh=sybsw@mail.gmail.com>
 <Zv8XIZAwfoTtzOl4@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Zv8XIZAwfoTtzOl4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-03 6:13 p.m., Namhyung Kim wrote:
>> Dapeng's comment should cover replace the comment /* Followed by
>> topdown events. */ but there are other things amiss. I'm thinking of
>> something like: "slots,cycles,{instructions,topdown-be-bound}" the
>> topdown-be-bound should get sorted and grouped with slots, but cycles
>> and instructions have no reason to be reordered, so do we end up with
>> slots, instructions and topdown-be-bound being grouped with cycles
>> sitting ungrouped in the middle of the evlist? I believe there are
>> assumptions that grouped evsels are adjacent in the evlist, not least
>> in:
>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2106
>> Does cycles instructions end up being broken out of a group in this
>> case? Which feels like the case the code was trying to avoid.
> I got this:
> 
>   $ sudo ./perf record -a -e "slots,cycles,{instructions,topdown-be-bound}" true
>   Error:
>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-be-bound).
>   "dmesg | grep -i perf" may provide additional information.

To be honest, I think the "slots,cycles,{instructions,topdown-be-bound}"
is a meaningless case. Why a user wants to group instructions and
topdown events, but leave the slots out of the group?
There could be hundreds of different combinations caused by the perf
metrics mess. I don't think the re-ordering code should/can fix all of them.

For the case which the re-ordering cannot cover (like above), an error
out is acceptable. So the end user can update their command to a more
meaningful format, either {slots,cycles,instructions,topdown-be-bound}
or {slots,topdown-be-bound},cycles,instructions still works.

I think what the patch set really fixed is the failure of sample read
with perf metrics. Without the patch set, it never works no matter how
you change the order of the events.
A better ordering is just a nice to have feature. If perf cannot
provides a perfect re-ordering, I think an error out is also OK.

Thanks,
Kan
