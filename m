Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57028DB54;
	Thu, 26 Mar 2026 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496826; cv=none; b=RdtN2uBstGm10WhVZxURn1tVYLPZtw/H7tdg5OhQBG+TEaQZPCZm0eYMWSmSTY+2/cvl2Vy3NtxFg1HHaVmi4qkrPoXmBTKgo+aVuiw1zwEFSPO14aFgSo7fMYQazardYUpOm/FJFNP6NOhpL0euCjmwdZ66gLYfNdSQURZ7C+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496826; c=relaxed/simple;
	bh=a01caIgdw8K5lW6bErAiMiEDFBlhJ/I4LcweqJ5vzuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9oCkoV9x/NNPhA085Ty1moGEsjc2jqRkBlXk9Iw0UJsW7udYjExOVHDoYaLgBmTOtoEnWr3LsCr/ML5tyjblDN6VdWwf7HUcHUCV5tHn2Wl8uivHpwvpxmzc3GPLWxQ1P8gjPu9mmLRTMd4cb0MRvuGqN6PBA+fvf64IE5Pl7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=JdynUzbb; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="JdynUzbb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=IVp2hqmU+KCQ4JYeOOX1aInjRTzm6Ect0l0BiwWltcA=;
	b=JdynUzbbL/wehu7oJYRtmF37Hno0R0k4ZkMwt1iT4Sg9xyQZVHeyW/Ti41bWCB
	ATc6STmKZwSoUHwxv9oV2LHz5o/Ph/D6SYkPYflMUHvGQeDynb8HGHfSo4CgaEoq
	j89QAZ+Hsv9BM/g1abB4rEu+aFsRXTwlOhahJU0Lzjkb4=
Received: from [172.24.149.146] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3_0Vdq8RpfcUhAg--.39776S2;
	Thu, 26 Mar 2026 11:43:27 +0800 (CST)
Message-ID: <7815cf12-5579-44df-adc6-2b061f365adb@126.com>
Date: Thu, 26 Mar 2026 11:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf symbols: Add 'intel_idle_irq' to the list of idle
 symbols
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, Thomas Richter <tmricht@linux.ibm.com>,
 mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, james.clark@linaro.org, ojeda@kernel.org,
 gary@garyguo.net, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260323085255.98173-1-jameshongleiwang@126.com>
 <CAP-5=fVdxJxSAYyAoS_UVxQqOtS1GrhHphEag=Ksb2Oc+NuCGQ@mail.gmail.com>
 <acOJPVxR7MRLE4NW@google.com>
 <CAP-5=fX8QmteodkvmaE4baJdw=wwWWN7+_DA3v8C95BJuN2y=w@mail.gmail.com>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <CAP-5=fX8QmteodkvmaE4baJdw=wwWWN7+_DA3v8C95BJuN2y=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_0Vdq8RpfcUhAg--.39776S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW7WFWfuFy5WF4UCrWxZwb_yoW8uF43pF
	yUuFWjgF45Xr1fGw13tr4fXF4Ygas7XayrWFn5tw1UZFnI9Fn2grWxJF4Y93y8WrykGF1r
	AFyj9F9I93W0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtpnQUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/xtbBrh+NO2nEq19W2wAA3T



On 3/26/26 12:07 AM, Ian Rogers wrote:
> On Wed, Mar 25, 2026 at 12:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Mon, Mar 23, 2026 at 11:35:05AM -0700, Ian Rogers wrote:
>>> On Mon, Mar 23, 2026 at 1:53 AM Honglei Wang <jameshongleiwang@126.com> wrote:
>>>>
>>>> Commit 32d4fd5751ea ("cpuidle,intel_idle: Fix CPUIDLE_FLAG_IRQ_ENABLE")
>>>> introduced intel_idle_irq as entry of those with
>>>> CPUIDLE_FLAG_IRQ_ENABLE, say, skx and icx so far. Let's add a new
>>>> one to the list of idle symbols to avoid noise.
>>>>
>>>> Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
>>>> ---
>>>>  tools/perf/util/symbol.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>>>> index 8662001e1e25..7cff66e7ce06 100644
>>>> --- a/tools/perf/util/symbol.c
>>>> +++ b/tools/perf/util/symbol.c
>>>> @@ -730,6 +730,7 @@ static bool symbol__is_idle(const char *name)
>>>>                 "cpu_startup_entry",
>>>>                 "idle_cpu",
>>>>                 "intel_idle",
>>>> +               "intel_idle_irq",
>>>
>>> It would be nice to make this an Intel specific idle symbol. I sent
>>> out a patch set to do this:
>>> https://lore.kernel.org/lkml/20260302234343.564937-1-irogers@google.com/
>>> but there are no reviews. Perhaps we can follow up that patch by
>>> adding this symbol. Arnaldo, Namhyung, wdyt? I believe Arnaldo was
>>> supportive in:
>>> https://lore.kernel.org/lkml/aahC-zp56irr5e2k@x1/
>>
>> Yeah, I'm ok in general.  I've left a comment there.
> 
> As that patch adds:
> ```
> if (e_machine == EM_386 || e_machine == EM_X86_64) {
>     if (strstarts(name, "mwait_idle") ||
>          strstarts(name, "intel_idle")) {
>         sym->idle = SYMBOL_IDLE__IDLE;
>     return true;
>     }
> }
> ```
> 
> The strstarts covers intel_idle_irq and that change will incorporate
> this modification.
> 
> Thanks,
> Ian
> 

Sorry, I was a bit busy these two days.. I'm OK to make this general.
But at a fast test on my machine with your v2 patch, the intel_idle_irq
was still there at top of the output. I'll do more debug to see why it
happened.

Thanks,
Honglei

>> Thanks,
>> Namhyung

