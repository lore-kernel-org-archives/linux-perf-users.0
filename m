Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE64582C9;
	Fri,  9 Oct 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552089; cv=none; b=fAz31TPW1/bpLGa0SjFpX+PgLAz3lYj4yrNFhKdA9EZ1DiesnxZdTxmdOxTiIQ3CEwlTWKAts6FLrdW7w1FHkniQ7r1J5b3hlbv2NjETz7cxaq3z1TLoWJI4u92iYA6qaqBGppTR9Bgs/81pED4s5FFl6YAyfXMEGVog0Kj4G3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552089; c=relaxed/simple;
	bh=hRhxlDr3ghluH/n3MjQIcZt8qG0YcCtn6rX1pd593sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEnOtojZ00UQQPvsjONZ+9ZeYzmlfi//vQPQaQ7wo2OeZQp7RHOCt6Qz/wlQ5Z55XjdjR1m39R/tPiD6pxM154CIPTVwGjZboTUOLdFQUgzGGwY6zfGijwg50jND7wa5l91TsTOPjyRCpYkqYgGhbT/C7+jBp3uQQGtvyKscsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Adl6jA6J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Adl6jA6J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46DCC1BB2;
	Fri,  9 Oct 2026 06:21:24 -0700 (PDT)
Received: from [10.2.213.24] (e137867.arm.com [10.2.213.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257993F763;
	Fri,  9 Oct 2026 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791552087; bh=hRhxlDr3ghluH/n3MjQIcZt8qG0YcCtn6rX1pd593sQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Adl6jA6J9BYPFxHQzHiaWmUINvAK8wA58GDVWDHD7lg54hvFG7MF1Yc6exVEpsZ6T
	 D6Xxp5nThjjH+YtvgQDITVhH4czKRwtgYb0d3ufijZ2wktSRmZeqk5SbmJrvGkWieY
	 II+Yr9pCM6gLKQF6mGQLT9LhFECZ6ow5oVPJX31Y=
Message-ID: <5becc0b8-9b31-4539-b477-2d4af66c89a4@arm.com>
Date: Fri, 9 Oct 2026 14:21:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification
 to task_work()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
 loongarch@lists.linux.dev, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, Waiman Long <longman@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Adrian Hunter
 <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>, WANG Xuerui <kernel@xen0n.name>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20261001143516.Ew8C97WS@linutronix.de>
 <fd405cda-51bd-4b1c-803c-f2597b2b128e@arm.com>
 <20261008192117.ZIKKU3Yh@linutronix.de>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US, en-GB, fr
Organization: Arm Ltd.
In-Reply-To: <20261008192117.ZIKKU3Yh@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 08/10/2026 20:21, Sebastian Andrzej Siewior wrote:
> On 2026-10-06 18:17:52 [+0100], Ada Couprie Diaz wrote:
>> Hi Sebastian,
> Hi Ada,
>
>> I find the function names a bit counter-intuitive, compared to the other
>> arch-specific perf functions.
>> Given the name `perf_arch_...`, I would have expected them to be defined
>> in arch code, rather than in the generic perf code.
>>  From what I can see, usually perf functions calling an arch-specific
>> function lack the `_arch_` infix of their `arch_` counterpart.
>>
>> I do not know very well what we expect in perf, so I might be off-base,
>> but would calling them `perf_hwbp_send_sig()` and `perf_hwbp_notify()`
>> make sense ?
> Thanks for looking at this. I renamed them as:
> - perf_arch_hwbp_notify() -> perf_hwbp_notify() (generic)
> - arch_hwbp_send_sig() -> perf_arch_hwbp_send_sig() (arch specific)
> - perf_arch_hwbp_send_sig() -> perf_hwbp_send_sig() (generic)
>
> [...]
>
> Sebastian
That sounds good to me, thanks !
Kind regards
Ada
