Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C9E15D5C5;
	Tue,  4 Feb 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677983; cv=none; b=sv6Ne7WRYZw717HanmuofKnMHJuIuXp2RJ9ls+PsWCAhXP/gbJdTWGUDjoJej6F0sf+2NbW0qg4W/TlRqetfS7niDRt3JY9+8HWNZt6sDCd80FEEjFl+aq0ju6a8DaFFBDSkeF5iQbCOPZNFdRCzhuzF8SpkBK1rUhjMUk4SOp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677983; c=relaxed/simple;
	bh=xIUeRZOz538kb61SgWNqCAOCBZIbbvPiphScunkYzWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmVMRG2MLIGc2EzOSXiEswO+S4tQHT8K03DiARM7tJvu3+BPV4HzCy1I01pY7e3xtBrC8iux/5dAZ47lyqIhKIOqJ+AlaWllcZe+64s0eFle33CGBJCxjouj1O5Azq3vV+0Bc+261vtn/TxX7incYExWsxUL0QKucNH/akflI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSwkTGS6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSwkTGS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738677982; x=1770213982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIUeRZOz538kb61SgWNqCAOCBZIbbvPiphScunkYzWY=;
  b=OSwkTGS6AonnhZMSU9xK3glQfuAb943Himz9fYSSKT6PcVSIpORzZ7Fc
   0zBh5QZAlNzNMROmfCqUrg/aRwTPjaNbrJIUgVL00uBwQonfcoXpFedW0
   IMy0PaVuD4L/QU+uNqf4qAceJl/DbkP7uygYLLUgSQx00f9iqJYgi7pD2
   PwJG5mG98GA/TSFx2YQfFfZxyKvgWUZcKXmwgWwpZjXnJaRvlQNC3IVVX
   coIJIfvGq64MOmSjbKbJjE6CuPW/1Tchihg1QmiWcCWz8ph25RO7o60oA
   9Sv9A+ge/L1ZwkvAh2M6v8SHvgJA6heCBrV/UXVF+KPzxypZSTwRmRkDk
   w==;
X-CSE-ConnectionGUID: j6NV1p//TuSONT9m7yP8pA==
X-CSE-MsgGUID: SsLEpQLETISCY3jivE8fJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50198786"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="50198786"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:06:21 -0800
X-CSE-ConnectionGUID: tS9l5w1xTFCZdpuxcMKIMA==
X-CSE-MsgGUID: 9cqS46PnQCGPJ9OXrBiy9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111048095"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 06:06:21 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 40DC220B5713;
	Tue,  4 Feb 2025 06:06:19 -0800 (PST)
Message-ID: <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
Date: Tue, 4 Feb 2025 09:06:18 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com> <2025020426-spool-refreeze-2870@gregkh>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <2025020426-spool-refreeze-2870@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-04 5:16 a.m., Greg Kroah-Hartman wrote:
> On Tue, Feb 04, 2025 at 09:41:03AM +0200, Alexander Shishkin wrote:
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>
>>> In sysfs, for some reason, all pmu devices seem to show up in the "root"
>>> of /sys/devices/ making for a confusing mess as these devices are not
>>> really at the root of the system at all.
>>>
>>> Create a fake root devices, "pmu_bus" and place them all under there if
>>> they do not already have a parent device set, cleaning up sysfs to look
>>> more sane.
>>
>> Yeah, so what happens to the userspace that uses them via /sys/devices/*
>> directly? Even I have scripts that do that.
> 
> You should never be doing that, as you have no idea what type of devices
> are in that location in the tree.  You should be doing what the
> documentation says to do, and look in /sys/bus/event_source/devices/
> instead.  That didn't change here.
>

Not just the script, the /sys/devices/ is also used in the current perf
tool. For example,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/mem-events.c#n192

And the comments and document in the perf tool.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n39
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-list.txt#n191

I think it should bring big impact for the end user, especially when
they still use an older perf tool and script.

Thanks,
Kan

> Again, system topology can, and will, change all the time in
> /sys/devices/ so expect that.  The only "stable" locations are the
> symlinks in the /sys/bus/ and /sys/class/ locations, which is why those
> symlinks are present.
> 
> Been that way for over a decade now :)
> 
> thanks,
> 
> greg k-h

