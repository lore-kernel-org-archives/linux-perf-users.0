Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CD28EA;
	Fri, 26 Jul 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002856; cv=none; b=GKl0/1q4Sd8pMaslSQXPKfATDvHQRGLHnF+KIeIgSthUcAevpc4S7s06T2nfYSN9KUvjbm6b/xExiskZDIoJtc1WpVLcObOq0cx5kk0zFqs5APyyNak4h20oSHReCsq3OTPgzIfbF6tofZ/Dk+kZMKndDGDuYtTJHGatWpugOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002856; c=relaxed/simple;
	bh=DrtcZusawSUwPtIU89V5vY/QZ9NjVUCq17IWHL4U/TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfHW+TnzP0oy7yoMJvxwgYfDNKSFlIklc9SghT0im2r3zdawovYYaV6JaKM4WajqgasUEPnGAei1kvGoEeSTm/yJR7rXzYZmpdxv0+QfNiVW4yI0fJSY81MiRb6cHO3UavCzl1kH2/FvfFc2BIvsTzT7EHeEv0wgKoti/0CMU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJvXnzRh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJvXnzRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722002855; x=1753538855;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DrtcZusawSUwPtIU89V5vY/QZ9NjVUCq17IWHL4U/TI=;
  b=cJvXnzRhynOgEh+tHqD1q9fL5T34AONk7/Uj0S2jnx3fC7GHuTDHElkG
   lallTKpwd4WNI/z/CiOnc3zOgJjlmhUzw+ndME4KnNlfBzCrWvxMJICIm
   idOiwGlKp/g3k0eSQNDh0fYOXmk45V6CaillftgudXIbA7gmddguZ9DJP
   QEPgM8b3DZkywcZv20KK/7oz0px5Tg/SFpRy7FO578sbc5V5wlKMLTxET
   qIu5KGSn6cPvfNyJtC1peEzJsRxvSgmLB9ybd5Y0pqJmzrIy/nemAiinu
   Q7lRi2NSSCkD6iY3s+tkRsWATc4NH0CtIbUdqR+BcC1MQQSyhZFcGQCV+
   g==;
X-CSE-ConnectionGUID: 5fgLVnLFRMuw+zNWbaAI2Q==
X-CSE-MsgGUID: vC9eoq3vRF6KQvi7m9HO/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19644154"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19644154"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 07:07:34 -0700
X-CSE-ConnectionGUID: 8hDMQqcXSWOgcepIC8dFEg==
X-CSE-MsgGUID: eurExc5QSTSQyYqD9aj1GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="58103002"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 07:07:34 -0700
Received: from [10.212.61.242] (kliang2-mobl1.ccr.corp.intel.com [10.212.61.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 227FD20BA6EC;
	Fri, 26 Jul 2024 07:07:31 -0700 (PDT)
Message-ID: <17f2e99e-2d52-4174-b40f-df87d3b73fa5@linux.intel.com>
Date: Fri, 26 Jul 2024 10:07:29 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
 <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
 <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
 <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
 <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
 <c4b499a5-7d2a-44db-bd0c-c123417337a5@amd.com>
 <3c3d1cd9-ccb1-495d-a670-9ee504fb0bbe@amd.com>
 <CAP-5=fXpacz331M71WR1HZHS0p7t9zqNUqBvMf2EjOxaB9Ayyw@mail.gmail.com>
 <a0bdb947-63cb-40b4-b410-92b4dc9e6801@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <a0bdb947-63cb-40b4-b410-92b4dc9e6801@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-26 4:17 a.m., Dhananjay Ugwekar wrote:
> 
> 
> On 7/26/2024 1:22 PM, Ian Rogers wrote:
>> On Fri, Jul 26, 2024 at 12:10 AM Dhananjay Ugwekar
>> <Dhananjay.Ugwekar@amd.com> wrote:
>>>
>>>
>>>
>>> On 7/26/2024 12:36 PM, Dhananjay Ugwekar wrote:
>>>> Hello, Ian, Kan,
>>>>
>>>> On 7/20/2024 3:32 AM, Ian Rogers wrote:
>>>>> On Fri, Jul 19, 2024 at 9:35 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
>>>>>>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
>>>>>>> solely its perf event context, I want to know its core power and
>>>>>>> package power as a group so I never record one without the other. That
>>>>>>> grouping wouldn't be possible with 2 PMUs.
>>>>>>
>>>>>> For power, to be honest, I don't think it improves anything. It gives
>>>>>> users a false image that perf can group these counters.
>>>>>> But the truth is that perf cannot. The power counters are all
>>>>>> free-running counters. It's impossible to co-schedule them (which
>>>>>> requires a global mechanism to disable/enable all counters, e.g.,
>>>>>> GLOBAL_CTRL for core PMU). The kernel still has to read the counters one
>>>>>> by one while the counters keep running. There are no differences with or
>>>>>> without a group for the power events.
>>>>>
>>>>> Ok, so power should copy cstate with _core, _pkg, etc. I agree the
>>>>> difference is small and I like the idea of being consistent.
>>>>
>>>> So, it seems we want to follow the new PMU addition approach for RAPL
>>>> being consistent with Intel cstate driver, should I revive my "power_per_core"
>>>> PMU thread now?
>>>
>>> The power_per_core PMU thread link for reference,
>>>
>>> https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
>>
>> I think so. Would it be possible to follow the same naming convention
>> as cstate, where there is cstate_pkg and cstate_core? (ie no "_per" in
>> the name)
> 
> Makes sense, we should probably rename the original "power" PMU to "power_pkg" 
> as well.

It may brings some compatible issue for the old platforms. There may be
two ways to address it.
- Add a symlink or something to link the "power" and "power_pkg".
- Only when there are two or more different scopes of counters in a
system, the "power_<scope>" are used. If there is only one scope of
power counter, "power" is still used.
The latter method is used for the Intel uncore and hybrid core drivers now.

Thanks,
Kan

> 
> Thanks,
> Dhananjay
> 
>>
>> Thanks,
>> Ian
>>
>>>>
>>>> Thanks,
>>>> Dhananjay
>>>>
>>>>  Do we
>>>>> want to add "event.cpus" support to the tool anyway for potential
>>>>> future uses? This would at least avoid problems with newer kernels and
>>>>> older perf tools were we to find a good use for it.
>>>>>
>>>>>>> My understanding had been that for core PMUs a "perf stat -C" option
>>>>>>> would choose the particular CPU to count the event on, for an uncore
>>>>>>> PMU the -C option would override the cpumask's "default" value. We
>>>>>>> have code to validate this:
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n2522
>>>>>>> But it seems now that overriding an uncore PMU's default CPU is
>>>>>>> ignored.
>>>>>>
>>>>>> For the uncore driver, no matter what -C set, it writes the default CPU
>>>>>> back.
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/intel/uncore.c#n760
>>>>>>
>>>>>>> If you did:
>>>>>>> $ perf stat -C 1 -e data_read -a sleep 0.1
>>>>>>> Then the tool thinks data_read is on CPU1 and will set its thread
>>>>>>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
>>>>>>> throw away the -C option.
>>>>>> The perf tool can still read the the counter from CPU1 and no IPIs
>>>>>> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
>>>>>>
>>>>>> Not quite sure, but it seems only the open and close may be impacted and
>>>>>> silently changed to CPU0.
>>>>>
>>>>> There's also enable/disable. Andi did the work and there were some
>>>>> notable gains but likely more on core events. Ultimately it'd be nice
>>>>> to be opening, closing.. everything in parallel given the calls are
>>>>> slow and the work is embarrassingly parallel.
>>>>> It feels like the cpumasks for uncore could still do with some cleanup
>>>>> wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
>>>>> tempted to rewrite evlist propagate maps as someone may look at it and
>>>>> think I believe in what it is doing. The parallel stuff we should grab
>>>>> Riccardo's past work.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Kan
>>>>>>>
>>>>>>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
>>>>>>>>> files parse correctly and have a corresponding event.
>>>>>>>>> 3) keep adding opening events on the PMU to a group to make sure that
>>>>>>>>> when counters are exhausted the perf_event_open fails (I've seen this
>>>>>>>>> bug on AMD)
>>>>>>>>> 4) are the values in the type file unique
>>>>>>>>>
>>>>>>>>
>>>>>>>> The rest sounds good to me.
>>>>>>>
>>>>>>> Cool. Let me know if you can think of more.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Ian
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Kan
>>>>>>>
>>>
> 
