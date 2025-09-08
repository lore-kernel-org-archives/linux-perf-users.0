Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B668C2F3C32;
	Mon,  8 Sep 2025 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327101; cv=none; b=hCzdxJNEJ11MXrhPFEluuXcHM0ydUl24Hd4LSXLXYcKY4yC1e4w+ypASMzyrr1idnIzqvrqQtNYILzo7rnvgw8hXgMlWNk5fBWOdxnajwgdbCps2QJQocDEVJmUpiY9kZ9oCNznP8OXECrHOKxySpZAAEPXocoS3u0o1Zlx7Uig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327101; c=relaxed/simple;
	bh=7XwAMwHH5guQVH4NlQeVLDaBQni8VA4GO34QBkjSrsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjesAv1oJtYS7kKQPpkKbbMg3nA9QJE0D7CHw9eHQIIuqhWxv/8h4Vk8CzhADALzBOi/5fSlDTqA8pChJCbdQ+65iDyaPR22vRHPBuZaCU3/8ntYBK2hgEK2Tn8YGh4q16Opv9cg8FyEit+xhrlNfoCMp36BTJQWKtYX+RxrPFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=I9Rn3OCS; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="I9Rn3OCS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
	:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kjodhArTHkwbk89MoyDDCGDQOaiGSJEGaIfs9n6I2Mg=; b=I9Rn3OCSgrJ0Pdcj4Q07t3xkDv
	qBFpaMV5kzWu21Y1mqebjExdZPKkUR7WhOfAV+OsojDTpEGWctSQHiLWl2vvvv8ylIuW6WP1UYEqO
	YuDZ5uhnh1FeW6EIwoyb/Dmx/c2ciV8oYgWX/iEYO0nC36eSITtJGxCCgaAMOlXb27KpNRLeTrVdr
	IYdFqdvXEtsbDrynWBTWzfelq+rrABu7i8Eq4S0uIqlCnpZwlnn2QQ/bIVDMth8SOUgEoBmWIX/0H
	QbXy7YtazEJBbARMfR+D/pQcOg4n6RSyspOF6P23iW547C/rwE3BKZHyjvNGE7zUjGu7L7IeVKOSD
	2pDkvH7g==;
Received: from cw141ip160.vpn.codeweavers.com ([10.69.141.160])
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <bmcgrath@codeweavers.com>)
	id 1uvZ3K-005Fa0-1f;
	Mon, 08 Sep 2025 05:24:50 -0500
Message-ID: <3db2d6af-3b21-4ce2-be1f-668270adbbeb@codeweavers.com>
Date: Mon, 8 Sep 2025 20:24:45 +1000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>
Cc: =?UTF-8?Q?R=C3=A9mi_Bernon?= <rbernon@codeweavers.com>,
 Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org>
 <CAP-5=fWHGFBaCgiRcj8zVy196OE07F8jnSUbjvsO_HerdqeyTg@mail.gmail.com>
 <70bd9eea-905a-4fa9-8265-f84ab9894b12@linaro.org>
 <2b958dec-7ba9-41a3-b11b-43b5e8418849@codeweavers.com>
 <549d3812-a606-4981-83f5-0a99b0ff9f6a@linaro.org>
 <CAP-5=fXKthsZe3J4_UHHGwDafBq7pHzM18Mh=_2QrnSfCT3nOg@mail.gmail.com>
Content-Language: en-US
From: Brendan McGrath <bmcgrath@codeweavers.com>
In-Reply-To: <CAP-5=fXKthsZe3J4_UHHGwDafBq7pHzM18Mh=_2QrnSfCT3nOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/25 01:53, Ian Rogers wrote:
> On Thu, Sep 4, 2025 at 7:18 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 04/09/2025 9:27 am, Rémi Bernon wrote:
>>> Hi!
>>>
>>> On 9/4/25 10:13, James Clark wrote:
>>>>
>>>>
>>>> On 03/09/2025 5:07 pm, Ian Rogers wrote:
>>>>> On Wed, Sep 3, 2025 at 8:15 AM James Clark <james.clark@linaro.org>
>>>>> wrote:
>>>>>>
>>>>>> read_build_id() now has a blocking argument, but libbfd uses fopen()
>>>>>> internally which doesn't support O_NONBLOCK. Fix the build by adding
>>>>>> the
>>>>>> argument and ignoring it:
>>>>>>
>>>>>>     util/symbol-elf.c:964:8: error: too many arguments to function
>>>>>> ‘read_build_id’
>>>>>>       964 |  err = read_build_id(filename, bid, block);
>>>>>>
>>>>>> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to
>>>>>> filename__read_build_id")
>>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>>
>>>>> Libbfd should go away:
>>>>> https://lore.kernel.org/lkml/20250823003216.733941-14-
>>>>> irogers@google.com/
>>>>> but I can imagine that currently this is hit in a build test - sorry
>>>>> for missing that and thanks for the fix!
>>>>>
>>>>
>>>> Yeah just one of the build tests, I'm not actually using it.
>>>>
>>>> Remi are you still using this? To be fair the addition for PE support
>>>> is fairly recent and even includes a binary for testing it so I'm not
>>>> sure if we should be so quick to remove it.
>>>>
>>> Yes, I'm still using it occasionally, and I think it's generally useful
>>> for Wine profiling purposes and I would rather prefer that it's not
>>> removed.
>>>
>>> I know it's not built by default because of license conflicts. I didn't
>>> realize that was an issue when contributing the changes, and it is quite
>>> unfortunate (and silly IMO).
>>>
>>> Then I'm not particularly attached to libbfd and any other option that
>>> would let perf read PE files would be alright, as long as PE support is
>>> kept.
>>>
>>> Cheers,
>>
>> It looks like libLLVM might work. Looking at the doxygen there are vague
>> references to PE binaries around the getBuildID() function. But as
>> mentioned in the linked thread, it's huge at 100+ MB.
>>
>> WRT that thread, I think maybe re-writing some of this in Perf wouldn't
>> be so bad. Surely getting the buildID is trivial. For PE binaries it's
>> hard to tell what's supported currently, what's being used and what's
>> being done by what library or tool. addr2line, libbfd, symbols,
>> disassembly etc.
> 
> I know some people who work on LLVM for Windows for the sake of having
> a Chrome build from Linux. It should be possible to migrate the libbfd
> use cases to LLVM.

Just wanted to let you know that I've been able to put together a PoC 
that does just this. It allows the pe-file-parsing test to pass using 
LLVM in place of libbfd.

If there's interest, I would be happy to try to shape this in to 
something that can be accepted upstream.

> If I remember John Levine's Linkers and Loaders
> book correctly (contents available by way of your favorite search
> engine) everything is just a variant of COFF anyway.
> 
> It is a shame that the PE testing in buildid.sh (and the testing in
> general) is requiring `cc` as it'd be much nicer to have the tests in
> a form similar to the perf test workloads (e.g. perf test -w noploop).
> I don't have a good idea on how to fix this but just wanted to note
> it.
> 
> I'll write a non-blocking patch for read_build_id with libbfd that
> matches what the others do and should avoid the hang in the meantime.
> 
> Thanks,
> Ian
> 

