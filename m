Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3D19B3EC;
	Fri, 17 Jan 2025 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737141057; cv=none; b=FH/Ly63VJjdw+fSd3kG8SvL6pJL5sObIcJ4SaNSrVNe1y8cFW7QdqjX2EyCRx6wlXe2ArUfqzR9rXXtdGLGDR3cU5VQkIKGHSYaBNLPmQ5YnckuD5sL4yw0EelXvmqUlZuYwRa5cY9+jgFG9gxyNJN/EIHACViGEeq84bvvFs6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737141057; c=relaxed/simple;
	bh=obbCjbk7EhRmB25kaCcLxIOEqJFZ16uBOWTrslSUcOI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qqylbtdjMGuzNvNBNitgLkeMwEMNzLzTZkC0HxS8iZcugP7spQkfb2TJbeD246MxA508SSemqKGENa8iYVHXFnPuPJchAEPiywH02inVytCLkeGNFFJTVIoISHTH+sfKagNGxeN5SGYCs1NJAUTJQv0LyY9YqI0/shhZWlrwbOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+frC1QU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+frC1QU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737141056; x=1768677056;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=obbCjbk7EhRmB25kaCcLxIOEqJFZ16uBOWTrslSUcOI=;
  b=h+frC1QU9B3fuFD9thcPnuFDjOjDRauAMDuvZ4wrb0u9GVdZe7cNyeAV
   EZVu6C6xAbY5sFBu7hLm0wbaeXUptMpuSWyuLXHqHd1zutMjaj/ub90cU
   LFAxtNqdZkWRk1ir/ONG39ZKSa/G9i5h1bDueuNCYnH9B90S4s7JZYtEH
   fbffEd7tmyPkHKiJEvQMCZ6+OrMeLdoiLBOcbWJ1PsLjvOjN7Mf4EOC92
   Fc5TuEtk47tqCdQhx2ftoEL1XD68cZY93yaTDNwqess1cA7kmlHV4MsuS
   YIzOXfI0RdLGCuquOdtfpww8/LWtnIfP/0ZuAWFYyZkvNIUw7oqHjSinQ
   A==;
X-CSE-ConnectionGUID: 2qndHITNQweU49aywj8qbQ==
X-CSE-MsgGUID: LxcO7TezQyebsmpZ3cJ0zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48172794"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48172794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 11:10:55 -0800
X-CSE-ConnectionGUID: yyzTMCp0Rzegljqdoh8YJA==
X-CSE-MsgGUID: jIYuYCi7RZuTUI2t0jKFyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="105849760"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 11:10:55 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6C76A20B5713;
	Fri, 17 Jan 2025 11:10:52 -0800 (PST)
Message-ID: <3d87d244-a47b-4b70-90cd-710a38aa2431@linux.intel.com>
Date: Fri, 17 Jan 2025 14:10:51 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Intel vendor events and TMA 5.01 metrics
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
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
References: <20250116064355.344245-1-irogers@google.com>
 <10984553-bf84-4bff-9129-4b31815e38d6@linux.intel.com>
Content-Language: en-US
In-Reply-To: <10984553-bf84-4bff-9129-4b31815e38d6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-17 11:03 a.m., Liang, Kan wrote:
> 
> 
> On 2025-01-16 1:43 a.m., Ian Rogers wrote:
>> Update the Intel vendor events to the latest.
>> Update the metrics to TMA 5.01.
>> Add Arrowlake and Clearwaterforest support.
>> Add metrics for LNL and GNR.
>> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
>>
>> The perf json was generated using the script:
>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
>> with the generated json being in:
>> https://github.com/intel/perfmon/tree/main/scripts/perf
>>
>> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
>> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
>> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
>> together.
>>
>> v2: Fix hybrid and Co-authored-by tag issues reported by
>>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
>>     Clearwaterforest.
> 
> Thanks Ian!
> 
> Acked-by: Kan Liang <kan.liang@linux.intel.com>
> 

Thanks Thomas to do more tests for the series.

There is an issue for the FP_ARITH* related metrics on hybrid platforms.
I have to take the acked-by back. Sorry for the noise.

Here is the issue on ADL and ARL.

$ sudo ./perf stat -M tma_info_inst_mix_iparith -a sleep 1
Cannot resolve IDs for tma_info_inst_mix_iparith: INST_RETIRED.ANY /
(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIRED.VECTOR)


The patch set add the tma_info_inst_mix_iparith for cpu_atom.

+    {
+        "BriefDescription": "Instructions per FP Arithmetic instruction
(lower number means higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR
+ FP_ARITH_INST_RETIRED.VECTOR)",
+        "MetricGroup": "Flops;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
+        "PublicDescription": "Instructions per FP Arithmetic
instruction (lower number means higher occurrence rate). Values < 1 are
possible due to intentional FMA double counting. Approximated prior to BDW",
+        "Unit": "cpu_atom"
+    },

However, the FP_ARITH_INST_RETIRED.SCALAR and
FP_ARITH_INST_RETIRED.VECTOR event are only available for cpu_core.

sudo ./perf stat -e FP_ARITH_INST_RETIRED.SCALAR -a sleep 1

 Performance counter stats for 'system wide':

                 0      cpu_core/FP_ARITH_INST_RETIRED.SCALAR/

There should be no such metric for cpu_atom.

Thanks,
Kan
