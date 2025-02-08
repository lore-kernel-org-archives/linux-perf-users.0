Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E74594A;
	Sat,  8 Feb 2025 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977590; cv=none; b=nun5OlQQ69qoiger9RyK/7dHhpDGJf34l3XzH/t8PeBXXtOJGahxhj/GeAanJVcTT/+DXWg6ukWnGVhp/QPrz+EITO7iOcAGJy8sfTttdaiXU3H1kuooDDhAb4S1BEoo+kkIGyeWkYMQPsQM1W7u/AKODxL/usYPCdYWdcluQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977590; c=relaxed/simple;
	bh=N1dozlyB/Ante9985QURFeCAXIe2kcoHVsrIRvYtPUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCESWvznF6tHkLs0c5a4bZ/pYz64bdDMgPo6pEdy88thvNnDowi3n/TwXqj79q1lPOpg3Iq+4taWjkqIP3evZL6vPgXPlL5+i/pKbz7jx4flngIl8Dbh7REtgJd9adwGn/ehj0XwM0QfuSmfKDxYxF6nKgrWsfFRqzEsKAgOKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itMLp/rG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itMLp/rG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738977589; x=1770513589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N1dozlyB/Ante9985QURFeCAXIe2kcoHVsrIRvYtPUE=;
  b=itMLp/rG1MEKNzBmpq8YDvRt1673tgtvv0I/4XeWJS1cRAjX6ard2drN
   oEMLgJZtXv2xcQtywrU38OL8q24O/KLSbbeQqFCbA+rcmCa8rKqE201g7
   ZcBBx7V5UUvPTczgtgvDLYwPnrT0ryMiXst+lB2zZwke8YS69Rbhe2Eyh
   wiUsdyKNx64rZkk3M1EB3DQ57RJ+GUvd1Kw4BUBveCj/FgDDy5apZxRzb
   eyL+4aDLgPj9qER3DOsW1cRuiNz6S2eEeBLu2q1iLn6XquaLO8MFbyLl9
   djvdcsznd82KQZWvAkThLdCWyD7TuNmHCxasQYvcnl2M+YyrHm/VqSmS/
   A==;
X-CSE-ConnectionGUID: PVAzbnNBTYy2TGiAEcN3pg==
X-CSE-MsgGUID: qXXAnaPSSq+p8FAjBUwArQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="50613098"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="50613098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:19:48 -0800
X-CSE-ConnectionGUID: 6XoOJxNbTAuEsLuqDKke/w==
X-CSE-MsgGUID: z2z3Vt4mQPWXZ3JzOSAhAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="116719027"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 17:19:47 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7FC2D20B5713;
	Fri,  7 Feb 2025 17:19:44 -0800 (PST)
Message-ID: <309171b2-430f-4169-a396-d8bc34b637bd@linux.intel.com>
Date: Fri, 7 Feb 2025 20:19:43 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/24] perf vendor events: Add Arrowlake events/metrics
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>,
 Samantha Alt <samantha.alt@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Thomas Falcon <thomas.falcon@intel.com>
References: <20250207185154.824433-1-irogers@google.com>
 <20250207185154.824433-4-irogers@google.com>
 <0990a674-d8ab-4abc-a904-299513773f90@linux.intel.com>
 <CAP-5=fXCtWZicFAk+d8KSWkNDNREjk-Djz0jh=EZXX1f29Dd1w@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXCtWZicFAk+d8KSWkNDNREjk-Djz0jh=EZXX1f29Dd1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-07 6:00 p.m., Ian Rogers wrote:
> On Fri, Feb 7, 2025 at 12:44 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>> On 2025-02-07 1:51 p.m., Ian Rogers wrote:
>>> +    {
>>> +        "BriefDescription": "Percentage of time that the core is stalled due to a TPAUSE or UMWAIT instruction",
>>> +        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (8 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
>>> +        "MetricName": "tma_info_serialization _%_tpause_cycles",
>> It doesn't seem a correct MetricName. A convert script bug?
> They come from the E-core_TMA_Metrics.csv line 91:
> https://github.com/captain5050/perfmon/blob/main/E-core_TMA_Metrics.csv
> Info.Serialization %_Tpause_Cycles 100 * SERIALIZATION.C01_MS_SCB /
> #SLOTS 100 * SERIALIZATION.C01_MS_SCB / #SLOTS 100 *
> SERIALIZATION.C01_MS_SCB / #SLOTS 100 * SERIALIZATION.C01_MS_SCB /
> #SLOTS Percentage of time that the core is stalled due to a TPAUSE or
> UMWAIT instruction
> 
> The % works okay in the metric name but we could swap it if you wan

Yes, the % works, but there is a space between tma_info_serialization
and _%_tpause_cycles.

I'm not sure if it's an issue of E-core_TMA_Metrics.csv or the convertor
script.

Thanks,
Kan
