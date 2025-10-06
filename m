Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069884A06;
	Mon,  6 Oct 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737839; cv=none; b=crqEz3HaOz/gsroCmZD0sO9+Y3wHf8tXcUkdLHtwMYScFbk2l1NiHMvWz+J1fRKqsFQJss+A2wdj53fdjbHd0pv8NLNlMx8iotLT95aZGCfAdy7T0Y7FY0BXkmib/glZj/i0aI454EnqG6L8OzLKgE5Nm0VXkoN4/tsyEzIP5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737839; c=relaxed/simple;
	bh=80jH30xUMQtCp7lqP5MtMRwN/G0fpsGgBjF1aC2HzvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgtxfLCRSqvn1UaK+bLagbt6UVs3Rskdh7wxa8woFfaPOsyjzbQCGBp2Kp4E8YxLpB732VYgxgGy961fwKrEX9ITYBMUZILbT3FJO9pmA2ukyJuJXOlPN1Z7GD3GK1Va97Hend5KFfJBPa9LsyGMr5JZePYeo0jCWRIpA1bUQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+j1iz2V; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+j1iz2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759737838; x=1791273838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=80jH30xUMQtCp7lqP5MtMRwN/G0fpsGgBjF1aC2HzvQ=;
  b=j+j1iz2VwT426IGKwui9dxN+XcW8kk6QvjZshpgUsjl33ViSrDv9NUD5
   oIY1S6cehUgkiUhOctveuwtesz519E2StscnNjisNoK2VQXQ9q8+z773c
   x1GSKU2EYrcDttXUe8EC3XRL6R81qVd/+5odwO53yb4PjxEdV0bkTivaK
   4L06uDtcF6jFLH0ZZ0SqN86ZxjUp+3VbCrllbafVFLv3xyyDPX31D3k5C
   4fmlLhPshCXlFo5zNJTCcpF3oLZU+0qbChKbL5zvxktI4iXeuMwKSAyOT
   NbNw39ooPU0wAm0gA3wFMG/LlI/Dtb/rhaO2JUaURqy7yMfzmHvGHRIuk
   g==;
X-CSE-ConnectionGUID: edCVOkQLS3S9buT3IZ6j7A==
X-CSE-MsgGUID: GDDAut1sRZq3VOfsXA723w==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="64526751"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="64526751"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:03:56 -0700
X-CSE-ConnectionGUID: qE8Qkae9SWKxNyZ2Glm3fg==
X-CSE-MsgGUID: qAHMFRpCSF6IAw2WKjLkBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="184106174"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.209]) ([10.124.232.209])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:03:51 -0700
Message-ID: <4bb0537b-8b8e-48fd-b777-0787b23a3b41@linux.intel.com>
Date: Mon, 6 Oct 2025 16:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <202509081646.d101cfb7-lkp@intel.com>
 <e92a703d-6a92-474c-acba-b15176b97548@linux.intel.com>
 <bd48852d-e5d3-4d58-9d71-891a4e31dd5b@linux.intel.com>
 <aNtoZ3bJ5OmGAMT0@xsang-OptiPlex-9020>
 <6c4a3b2b-d207-466e-bd58-05566f36e1a4@linux.intel.com>
 <aN4lR1TG8Mdz5XoU@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aN4lR1TG8Mdz5XoU@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/2/2025 3:09 PM, Oliver Sang wrote:
> hi, Dapeng,
>
> On Tue, Sep 30, 2025 at 02:19:25PM +0800, Mi, Dapeng wrote:
> [...]
>
>> Oops, it looks previous fix was incomplete. :(
>>
>> Oliver, could you please verify the new attached patch (Please apply this
>> patch on top of the whole patch series)? Thanks a lot for your effort. 
> we confirmed the patch fixed the warning we reported.
>
> Tested-by: kernel test robot <oliver.sang@intel.com>
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
>   gcc-12/performance/x86_64-rhel-9.4/Socket Activity/debian-12-x86_64-phoronix/lkp-csl-2sp7/stress-ng-1.11.0/phoronix-test-suite
>
> commit:
>   0c9567b36ae6f8 ("perf/x86: Remove redundant is_x86_event() prototype")
>   a7138973beb1d1 ("perf/x86/intel: Fix NULL event access and potential PEBS record loss")
>   81248d31dd384c ("perf/x86/intel: Add counter group support for arch-PEBS")
>   54701e916f6782 ("Fixup: perf/x86/intel: Fix NULL event access waring from test robot")
>
> 0c9567b36ae6f83c a7138973beb1d124386472663cf 81248d31dd384c71c3b6a6af25a 54701e916f6782039c2ea8adb4b
> ---------------- --------------------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |             |             |
>            :6          100%           6:6          100%           6:6            0%            :20    dmesg.WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_pebs_nhm

Oliver, thanks a lot for confirm this. :)



>
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 65908880f424..3dedf7a0acf6 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2781,9 +2781,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
>> *iregs, struct perf_sample_d
>>  
>>          /* PEBS v3 has more accurate status bits */
>>          if (x86_pmu.intel_cap.pebs_format >= 3) {
>> -            for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
>> +            for_each_set_bit(bit, (unsigned long *)&pebs_status, size) {
>>                  counts[bit]++;
>> -
>> +                if (counts[bit] && !events[bit])
>> +                    events[bit] = cpuc->events[bit];
>> +            }
>>              continue;
>>          }
>>  
>> @@ -2821,8 +2823,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
>> *iregs, struct perf_sample_d
>>           * If collision happened, the record will be dropped.
>>           */
>>          if (pebs_status != (1ULL << bit)) {
>> -            for_each_set_bit(i, (unsigned long *)&pebs_status, size)
>> +            for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
>>                  error[i]++;
>> +                if (error[i] && !events[i])
>> +                    events[i] = cpuc->events[i];
>> +            }
>>              continue;
>>          }
>>
