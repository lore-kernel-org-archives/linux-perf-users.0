Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4578F4A;
	Tue,  4 Feb 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693437; cv=none; b=g4eTTp1OH5HtswBgZZUTl5DYcKtjaeqBF6QRdwH9UV41c/d80lLeAX9UUsc23g1F21nR7KkonZFuYXBW4c10Frd4dIhJvPGuxsCctgi+qPuDb7seSed9OIpFBPOXuZUfmxDSEsRhue9LKlqkxVnw7EyqVqvfV/9TEVqzgR/onPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693437; c=relaxed/simple;
	bh=jIJQfLnWt//hklNtiZN38RPULNlKpKsyubMrM4kG1l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/6H6jDac30J4Ec4ZCW9L0MAsTYWrDc5/yT44xA8f9dV1D7GIzG0YOcetVJz//LKX0t10JKaUlVzHCt0vI5mh7l9j5dnXjusmxtRHvCpM16DHka+9H6YUYJ6bk8X3LGjwJGq2ArDxVeqwXnc3c4wPu92O8FPSU78TIWlMxzR0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fr+M7JkF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fr+M7JkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738693436; x=1770229436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jIJQfLnWt//hklNtiZN38RPULNlKpKsyubMrM4kG1l8=;
  b=fr+M7JkF8F8RHgYVKELcLS0X+m+dEY2zpQRnw60pw7ZoXix60q61ZU8U
   7Apo5v3+wE2MDhCOhz88pNcAQ1IIw+yrBukvzFCSi2CwXN9sNR/rYDfoU
   qJF00TIjfq4JfYAE9HgfKYkDJn6/HweJe4pCIoa4S7OW0GafZbyZIzfKf
   bnLcOpHZoO3hgnJyz8JkIbekVUm2cZwZ6QGRI9c1JkWlLZ5ZSiqvyCvot
   MFCiChf8Vd+wn300hnylMrf8aAjeANfXe3Y4Qm33Rg7qAVwYl/BHmPTHc
   jqfpdMWhMr8BmOuRPU/tmhIlUc+DxIyYg9YRKEDG8JkRAplhPoj+GEd5x
   g==;
X-CSE-ConnectionGUID: tugKT94tRP6YBqT3bfWHrQ==
X-CSE-MsgGUID: q2JIvmM9QUKyPaN/6IvVpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56660306"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="56660306"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 10:23:55 -0800
X-CSE-ConnectionGUID: EzYWgQXKQGSZv8KJOPWBBA==
X-CSE-MsgGUID: TRslo0PORk+3LEC+bN9NYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111109456"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 10:23:55 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id F29D020B5713;
	Tue,  4 Feb 2025 10:23:52 -0800 (PST)
Message-ID: <9656a86c-30fb-48d9-9327-920cd449e73a@linux.intel.com>
Date: Tue, 4 Feb 2025 13:23:51 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <2025020304-chip-trench-4e56@gregkh>
 <87pljyyx68.fsf@ubik.fi.intel.com> <2025020426-spool-refreeze-2870@gregkh>
 <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com>
 <2025020408-apron-fled-d29e@gregkh>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <2025020408-apron-fled-d29e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-02-04 11:28 a.m., Greg Kroah-Hartman wrote:
> On Tue, Feb 04, 2025 at 09:06:18AM -0500, Liang, Kan wrote:
>>
>>
>> On 2025-02-04 5:16 a.m., Greg Kroah-Hartman wrote:
>>> On Tue, Feb 04, 2025 at 09:41:03AM +0200, Alexander Shishkin wrote:
>>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>>>
>>>>> In sysfs, for some reason, all pmu devices seem to show up in the "root"
>>>>> of /sys/devices/ making for a confusing mess as these devices are not
>>>>> really at the root of the system at all.
>>>>>
>>>>> Create a fake root devices, "pmu_bus" and place them all under there if
>>>>> they do not already have a parent device set, cleaning up sysfs to look
>>>>> more sane.
>>>>
>>>> Yeah, so what happens to the userspace that uses them via /sys/devices/*
>>>> directly? Even I have scripts that do that.
>>>
>>> You should never be doing that, as you have no idea what type of devices
>>> are in that location in the tree.  You should be doing what the
>>> documentation says to do, and look in /sys/bus/event_source/devices/
>>> instead.  That didn't change here.
>>>
>>
>> Not just the script, the /sys/devices/ is also used in the current perf
>> tool. For example,
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/mem-events.c#n192
>>
>> And the comments and document in the perf tool.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/pmu.c#n39
> 
> Note, this file looks to work properly, it's just the comment that is
> incorrect.
> 
> Any hints on what perf command or test I should run to verify I did get
> this all right?

For the perf tool, "perf test" should be run at minimum.

> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/Documentation/perf-list.txt#n191
> 
> I'll fix that.
> 
>> I think it should bring big impact for the end user, especially when
>> they still use an older perf tool and script.
> 
> It seems that the majority of the perf code IS looking in the correct
> place, just mem-events.c seemed wrong.
> 

There should be two more.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-stat.c#n100

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/x86/util/iostat.c#n35

Thanks,
Kan
