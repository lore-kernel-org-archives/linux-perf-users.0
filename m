Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45A1519B1;
	Wed,  5 Feb 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770423; cv=none; b=JtoyJRGLODtAof5McGeKHPtraMjgCqw0rU7lphYQb/GcLtei4+rhhv+6g872Ym0Sk7XwaDgiQmi1jO3Yj0Y56+fqqr2ilw/2qA1lm0zao5jfXDQDsxypH3wOxiaHCCkZpqUMPlbC3Cg7Yh+TLv2UG77nRSHpSDxJApOSc4N0MKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770423; c=relaxed/simple;
	bh=u3GF9FfhFtmHd+2GnYTqKaR+kPEeObINYiC6MXou440=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVchDg/aYOG6ljeJz+WD8PWltjKXTI3BIePFymzHqceJMMIwW8g4bbaC1r/FOVwVlcS+3yvGTVDQTwF9XjAlB+wEeXZ/37ogeGz8oo+y9pfFJz48/ko/EqBUsZzo+uwu5lEPrJqVNv/pPaS4pQxZGQxjapFY8JPikjUwmFMHd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieDqMhBN; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieDqMhBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738770422; x=1770306422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u3GF9FfhFtmHd+2GnYTqKaR+kPEeObINYiC6MXou440=;
  b=ieDqMhBN4GCb5S+YkBeXgRpp/HWPgNAQtk9q8lMpL3X3/JawK035ZpFP
   pTmPI3YZUPuvZdnEqDK5z6RyEAP7W9XdrJejFOHUYb3VVgBrMmCgIyyjT
   OwVdhY+3VOuMN/AKlFRIqCbGfyNufMnUQzy+ISKhrj1jgWHMcgciIHwke
   y7mdB7XsfZHaWXOmvcz9zxDiabmk5FgSM3BA+dDoJYUsAqIZk3/hG1fsh
   l1RWKfKeEJtnBeID6yricHO0SAbQLc5t8AZQAtEJIszcQYyzQFApE9HB5
   lWz/yuDDHWjrxxwyKgVQShA5hPcS0xmiJ74xL2bNglTmt/XxJygeji3ME
   A==;
X-CSE-ConnectionGUID: dDcwT4kNTvmNkPq77P3Ung==
X-CSE-MsgGUID: gCa9HLrSSUyqn8w+pYM8xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39368793"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39368793"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:47:01 -0800
X-CSE-ConnectionGUID: BvkSNlPcTAG71V6jhxGssA==
X-CSE-MsgGUID: cGoWOIaoR/C+Vcp6BbbwYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115010091"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 07:47:00 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 271AC20B5713;
	Wed,  5 Feb 2025 07:46:58 -0800 (PST)
Message-ID: <ca45ff5e-3d1a-4149-8efe-7615dd3581ff@linux.intel.com>
Date: Wed, 5 Feb 2025 10:46:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/23] Intel vendor events and TMA 5.01 metrics
To: Ian Rogers <irogers@google.com>, "Falcon, Thomas"
 <thomas.falcon@intel.com>
Cc: "Baker, Edward" <edward.baker@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "Biggers, Caleb" <caleb.biggers@intel.com>,
 "mpetlan@redhat.com" <mpetlan@redhat.com>,
 "Taylor, Perry" <perry.taylor@intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "Alt, Samantha" <samantha.alt@intel.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "Wang, Weilin" <weilin.wang@intel.com>, "acme@kernel.org" <acme@kernel.org>,
 "afaerber@suse.de" <afaerber@suse.de>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
References: <20250204213259.127939-1-irogers@google.com>
 <CAP-5=fXpuND+kNe16CJMETkMOW+__eQpB8No0ra5gyEcfqCCKQ@mail.gmail.com>
 <d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com>
 <CAP-5=fV8EcxVZR0Be6wb57_VvssE9FYFBTmbd415CqmidGWT7g@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV8EcxVZR0Be6wb57_VvssE9FYFBTmbd415CqmidGWT7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-04 11:58 p.m., Ian Rogers wrote:
> On Tue, Feb 4, 2025 at 8:28 PM Falcon, Thomas <thomas.falcon@intel.com> wrote:
>>
>> On Tue, 2025-02-04 at 13:35 -0800, Ian Rogers wrote:
>>> On Tue, Feb 4, 2025 at 1:33 PM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> Update the Intel vendor events to the latest.
>>>> Update the metrics to TMA 5.01.
>>>> Add Arrowlake and Clearwaterforest support.
>>>> Add metrics for LNL and GNR.
>>>> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
>>>>
>>>> The perf json was generated using the script:
>>>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
>>>> with the generated json being in:
>>>> https://github.com/intel/perfmon/tree/main/scripts/perf
>>>>
>>>> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
>>>> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>
>>>> and
>>>> Weilin Wang <weilin.wang@intel.com> for helping get this patch
>>>> series
>>>> together.
>>>>
>>>> v4: Fix TSC events on hybrid mistakenly specifying the core PMU
>>>>     inhibiting the use of the msr PMU.
>>>> v3: Fixes for hybrid metrics that were missing PMU. Update to the
>>>>     latest events.
>>>> v2: Fix hybrid and Co-authored-by tag issues reported by
>>>>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition
>>>> of
>>>>     Clearwaterforest.
>>>
>>> Sorry, forgot to add Thomas again.
>>> https://lore.kernel.org/lkml/20250204213259.127939-1-irogers@google.com/
>>
>> Hi, I'm seeing some warnings like this and the all metrics test is
>> skipped:
>>
>> Testing tma_info_inst_mix_iparith
>> FP issues
>> Cannot resolve IDs for tma_info_inst_mix_iparith:
>> cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ +
>> cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)
>> Testing tma_info_inst_mix_iparith_avx128
>> FP issues
>> Cannot resolve IDs for tma_info_inst_mix_iparith_avx128:
>> cpu_core@INST_RETIRED.ANY@ /
>> (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ +
>> cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@)
>> Testing tma_info_inst_mix_iparith_avx256
>> FP issues
>> Cannot resolve IDs for tma_info_inst_mix_iparith_avx256:
>> cpu_core@INST_RETIRED.ANY@ /
>> (cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@ +
>> cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)
>> Testing tma_info_inst_mix_iparith_scalar_dp
>> FP issues
>> Cannot resolve IDs for tma_info_inst_mix_iparith_scalar_dp:
>> cpu_core@INST_RETIRED.ANY@ /
>> cpu_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@
>> Testing tma_info_inst_mix_iparith_scalar_sp
>> FP issues
>> Cannot resolve IDs for tma_info_inst_mix_iparith_scalar_sp:
>> cpu_core@INST_RETIRED.ANY@ /
>> cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@
> 
> Thanks Tom, we've gone from a fail to skip - so progress! I think it
> actually isn't something to worry about. These metrics are measuring
> vector and floating point things. We run a workload, when testing the
> metrics, that doesn't have floating point and vector operations. This
> causes issues with metrics for these instructions as the counters
> don't count anything. Because of this I added some logic to just skip
> when we see these failures:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=perf-tools-next#n51
> but a better fix would be to have a workload with FP and AMX operations.
> 
> You could test these metrics work manually, by running something like:
> $ perf stat -M tma_info_inst_mix_iparith <benchmark>
> where <benchmark> would need to contain FP or AMX instructions.
> 

It should be OK to skip the "FP issues", but the "Cannot resolve IDs"
seems a different issue.

I found the similar error when I run perf stat on my Arrow Lake machine.

$ sudo ./perf stat
Cannot resolve IDs for tma_memory_bound: topdown\-mem\-bound /
(topdown\-fe\-bound + topdown\-bad\-spec + topdown\-retiring +
topdown\-be\-bound) + 0 * slots

I think the warning is because perf doesn't find all the matched events.
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/metricgroup.c?h=tmp.perf-tools-next#n326


Then I go to check the event list of tma_memory_bound.
For cpu_atom, it requires slots and topdown-mem-bound, which should be
only available on p-core.

+    {
+        "BriefDescription": "This metric represents fraction of slots
the Memory subsystem within the Backend was a bottleneck",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 *
slots",
+        "MetricGroup":
"Backend;Default;Slots;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_memory_bound",
+        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound
> 0.2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots
the Memory subsystem within the Backend was a bottleneck.  Memory Bound
estimates fraction of slots where pipeline is likely stalled due to
demand load or store instructions. This accounts mainly for (1)
non-completed in-flight memory demand loads which coincides with
execution units starvation; in addition to (2) cases where stores could
impose backpressure on the pipeline when many of them get buffered at
the same time (less common out of the two)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },

I didn't check the tma_info_inst_mix_iparith which Thomas mentioned
above yet. But I suspect it should be the same issue.

The perf test may have to error out when the "Cannot resolve IDs"
message is detected.

Thanks,
Kan

