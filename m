Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB6B70810;
	Tue, 24 Feb 2026 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911344; cv=none; b=ipyZ4+xKykg90o/lL0mRWVkL5tKYIQzEh6aXGGQQ37Ky8dynqlc3/oySDqC/ZbSlG410i6G9KvmhuU02VlNkLSsdNetbxRDV4qzyjoc1NHBC6x+L+05etUuXH1rusYfOJrTXxTAXw0OML6RieKjEGO4uDFFsUWDHpZl1mRxfLCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911344; c=relaxed/simple;
	bh=g58Cs0tEHUwUKfVfpBkuVJ52B7lsuw2ux59otioXIOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgXZFMH2ucLlWbWDyWPk21auutaYGyqtAxwWuFvlirAqvpV60u8IuOJLuGpBHEGcELR7Wb5y6jQGZVXToxPEoUOeCgEpw86I8+KXYitR2CocR62LbFPaRqfWNq91NruIRmb/9FNU1g0FuVh5Li9tF4zwJRq5KUGvDqx62XT1wTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWP7Z2F6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWP7Z2F6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771911342; x=1803447342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g58Cs0tEHUwUKfVfpBkuVJ52B7lsuw2ux59otioXIOQ=;
  b=lWP7Z2F6axXfKcWoEVA+3CW/nAFD3R3uRxnfjETMa7PA8yTTd8Jgx8ll
   7R7bYIkAPEa4+Saf9CHwHU2TQHbzE7YHFbgjOn7TuM3FhJqfx4OrNd6aQ
   Pwxk+pseTmuGZWh73DJ5FKase9YznxOeasd8GPXRpd8YF48HjLW5dXz6R
   hgYDyIFJULIfyrS2KnZoVZpvpWhWpigzW7IJY5TytfwtLL0i0EGQfxdme
   hJGnbXWSaRusqbpnqtWDUGgGtPJdTIOJfYT5xNoXQdUc1bz4vkZ5+rd4W
   L3k/hvqM7zRdnVrBGkvx2OQAX6bTj4RCrs1jPKmtcDwGGd69QJkdc/A0a
   w==;
X-CSE-ConnectionGUID: JZInCojpThqxJK0SQjC5cA==
X-CSE-MsgGUID: mjHgUojsTxy3qTcLIMFM0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73099888"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73099888"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 21:35:42 -0800
X-CSE-ConnectionGUID: vYfL/gFaTMe4wXu/Dv4GLw==
X-CSE-MsgGUID: yFR68jGiRoKr5K2JOseIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="246382552"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 21:35:36 -0800
Message-ID: <57ef5e60-505e-4ae8-944d-fd630e168af1@linux.intel.com>
Date: Tue, 24 Feb 2026 13:35:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after
 saving FPU state
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-9-dapeng1.mi@linux.intel.com>
 <5c3ea318-4543-42a4-9b81-7a1da0b8bed1@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <5c3ea318-4543-42a4-9b81-7a1da0b8bed1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/12/2026 3:39 AM, Chang S. Bae wrote:
> On 2/8/2026 11:20 PM, Dapeng Mi wrote:
>> Ensure that the TIF_NEED_FPU_LOAD flag is always set after saving the
>> FPU state. This guarantees that the user space FPU state has been saved
>> whenever the TIF_NEED_FPU_LOAD flag is set.
>>
>> A subsequent patch will verify if the user space FPU state can be
>> retrieved from the saved task FPU state in the NMI context by checking
>> the TIF_NEED_FPU_LOAD flag.
>>
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> I could check some previous discussions there:
> https://lore.kernel.org/all/20251204151735.GO2528459@noisy.programming.kicks-ass.net/
>
> With that, I think I can get the context of this change -- tightening 
> the flag up with the buffer against *NMIs*.
>
> But the changelog doesn't look clear enough to explain the reason to me.
>
> At least, I guess Links to the past discussions provides better context 
> to readers.

Thanks for the reminding. I would add a "Closes" tag here.


