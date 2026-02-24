Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB41DE4FB;
	Tue, 24 Feb 2026 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915843; cv=none; b=R5TRU6uGG5W0mDYBQzewLFbo1ru3WNWBwwQasFogpDj6rYAcwZxx6y93wQk3Z6FriC8brJSUORfhWYTC0P42vteqkB/oeicDin+mr8VZ1QHPXz6vneHOio79UuirS+p5nCqwQ9W2VFHUdi3XEKIFW9z+8oKR46SZ/GY3U8T9XQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915843; c=relaxed/simple;
	bh=kFrNHVd139VPdn3z8GrLUZw/MVznmik0fxjs92u2VgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPYL4avY0nY+X/jwxnx7hHTfk9z7iU/AZCMiZ2tJknGwaKP5JpgmPHfHmAxvWAAbkXzibJnytf4jUgRN/QdimOjSRwftIvLV/jf2c8BkL+GqX1lCnC73+vRgvK+KTUbupfGKGXws5AFKRHrK7/K+X2rNMt7WeRKJztV3GjMHG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ME3EM3wW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ME3EM3wW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771915842; x=1803451842;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kFrNHVd139VPdn3z8GrLUZw/MVznmik0fxjs92u2VgA=;
  b=ME3EM3wWNCiofdZZuR6NVaZBitpYpJBEBeJjkXLiVSq/wIlE9E1q8J5o
   JvuOZ4/sexO7DCWVuhthH0tqrlDyHyIuoJulwozaUxk7NdQKtZhp7yOTK
   3Ta9J0K7TDlnVJOZfzRqjip/6CNPMThA8clQQ1ClH2T2GwFK597cHnVLB
   CVdGoqhUNQa3GLGZQ4Hy6BTVzgIume4lAAsIOA/38X3zABWksQriTyN/P
   PCk1K9KggOAcmxlx2+9wCmwzIU/iRlNubiiFPKtU2equyk0spO3irPVk9
   +tEZENHoxo/qSDclDYHwB83CS7sI+zcF+bH5rqdIFae8TAqUGVd5XmXvA
   w==;
X-CSE-ConnectionGUID: AU1dTg83TGWYy9OoNQyH0A==
X-CSE-MsgGUID: g6P2mLpqQo2blRkrV8Y2Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84379336"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="84379336"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 22:50:41 -0800
X-CSE-ConnectionGUID: B2gZdwKXQZaI61OpHwNM7A==
X-CSE-MsgGUID: NkuQ1YnCQXSquT8eHNrDDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215831093"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 22:50:36 -0800
Message-ID: <a0bc418d-c167-4ccf-8f50-eba9396d2112@linux.intel.com>
Date: Tue, 24 Feb 2026 14:50:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after
 saving FPU state
To: Dave Hansen <dave.hansen@intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
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
 <960918ce-f42f-464f-a887-c36d8d9e2937@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <960918ce-f42f-464f-a887-c36d8d9e2937@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/12/2026 3:55 AM, Dave Hansen wrote:
> On 2/11/26 11:39, Chang S. Bae wrote:
>> But the changelog doesn't look clear enough to explain the reason to me.
> Yeah, the changelog could use some improvement.
>
> This also leaves the code rather fragile. Right now, all of the:
>
> 	save_fpregs_to_fpstate(fpu);
> 	set_thread_flag(TIF_NEED_FPU_LOAD);
>
> pairs are open-coded. There's precisely nothing stopping someone from
> coming in tomorrow and reversing the order at these or other call sites.
> There's also zero comments left in the code to tell folks not to do this.
>
> Are there enough of these to have a helper that does:
>
> 	save_fpregs_to_fpstate_before_invalidation(fpu);
>
> which could do the save and set TIF_NEED_FPU_LOAD? (that name is awful
> btw, please don't use it).

Sure. Would introduce an inline function and add comments. Thanks.


>
> This:
>
>>  	/* Swap fpstate */
>>  	if (enter_guest) {
>> -		fpu->__task_fpstate = cur_fps;
>> +		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
>> +		barrier();
>>  		fpu->fpstate = guest_fps;
>>  		guest_fps->in_use = true;
>>  	} else {
>>  		guest_fps->in_use = false;
>>  		fpu->fpstate = fpu->__task_fpstate;
>> -		fpu->__task_fpstate = NULL;
>> +		barrier();
>> +		WRITE_ONCE(fpu->__task_fpstate, NULL);
>>  	}
> also urgently needs comments.
>
> I also can't help but think that there might be a nicer way to do that
> without the barrier(). I _think_ two correctly-ordered WRITE_ONCE()'s
> would make the compiler do the same thing as the barrier().
>
> But I'm not fully understanding what the barrier() is doing anyway, so
> take that with a grain of salt.

IMO, barrier() seems a safer way for this situation. I'm not quite sure if
two WRITE_ONCE()'s would block the reordering from compiler, so I asked
Gemini, and here is its answer.

"

WRITE_ONCE() provides a certain level of protection, but it isn't a full
barrier.

WRITE_ONCE(): Prevents the compiler from optimizing the store away or
splitting it into multiple instructions.

Two WRITE_ONCE() calls: The compiler is generally discouraged from
reordering two volatile-style accesses (which WRITE_ONCE uses), but the C
standard doesn't strictly guarantee it in all cases.

"

Thanks.

