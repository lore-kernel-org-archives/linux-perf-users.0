Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C5274B2B;
	Thu, 11 Sep 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633037; cv=none; b=a5C/LR8DL5ET8NOLL7PmetmuwctJumxEwXksOS1ngGqWSAAxwa1C48BTSTdPCrLspq2YNie3INIJ8roYnJA/s2IOMwRzyBknyGn7sitIu2c7fPJ6zvWJFNJl9wz2DR6QmrDTDZ6duInRgHPFm2DHcmwsIwiD5MMrnMQYr1J3Sok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633037; c=relaxed/simple;
	bh=5/KPH7XsCSGImCOjQwBlg6KfqnJwT1NE+60RMcKKZJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqXLYcRVWngoda5xCqhqQfdffjNi2uUJHId1IT+FuGSgCeHLBVaBLjpqkrd1+2ULWnpxoQm300ndrBut6z918VsAtK97b3CiwcASFaRsGCGRxxSuI3pbNE49ctTIRkmjvbGTdgHJIAgX6Xv6w27xLz0yyu3InBnOQGUHnJY6HqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YoZe9h3p; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YoZe9h3p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
	:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QhInm/d1x81hkriWldNAfr4t3DuDfh81HFnFGoEo6zo=; b=YoZe9h3pcekJVStV5Kw7lm65yJ
	cijNWkl0CKxScbRqoUbXOF+60RUZJTvaQ7lYjUhnSmr7tDdtGMjdR6kIu7ArG+zDq7j3/pQVFDtvh
	29PCEf8JXvyqx+NXZAPf29xQnBo+QEEMP+sG0h7B0tcqCzr+vv1m+bzpjDCxAVFyaBPdzznKxJYWB
	p8fSV/7Lzd1QOmMJIQtlmvpZc805Eaf5fiRb5LQ6UXsreTS/WOrLUK572bc6pUg6CVQwL43esgLbQ
	g5+SjS2xeQmNnMyDliz1qBLEWJ+EjvP6IxtF9SWAlMNLvtLvbBcvDO6VrnPnUuf7xTpebijqWHqh1
	BXVpQV8Q==;
Received: from cw141ip160.vpn.codeweavers.com ([10.69.141.160])
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <bmcgrath@codeweavers.com>)
	id 1uwqdn-00HATe-0D;
	Thu, 11 Sep 2025 18:23:47 -0500
Message-ID: <3e6eb24f-5557-4045-8593-bfd12e2b9cec@codeweavers.com>
Date: Fri, 12 Sep 2025 09:23:42 +1000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf symbols: Fix HAVE_LIBBFD_BUILDID_SUPPORT build
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
 =?UTF-8?Q?R=C3=A9mi_Bernon?= <rbernon@codeweavers.com>,
 Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
 <3db2d6af-3b21-4ce2-be1f-668270adbbeb@codeweavers.com>
 <CAP-5=fX33kGxfHzqVGzusMBiHJM6G75TbLyZazjp37yohwscGg@mail.gmail.com>
Content-Language: en-US
From: Brendan McGrath <bmcgrath@codeweavers.com>
In-Reply-To: <CAP-5=fX33kGxfHzqVGzusMBiHJM6G75TbLyZazjp37yohwscGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/25 01:47, Ian Rogers wrote:
> On Mon, Sep 8, 2025 at 3:24 AM Brendan McGrath <bmcgrath@codeweavers.com> wrote:
>> Just wanted to let you know that I've been able to put together a PoC
>> that does just this. It allows the pe-file-parsing test to pass using
>> LLVM in place of libbfd.
>>
>> If there's interest, I would be happy to try to shape this in to
>> something that can be accepted upstream.
> 
> IMO that'd be great! In this series:
> https://lore.kernel.org/lkml/20250823003216.733941-1-irogers@google.com/
> I wanted to pull apart the disasm vs the srcline vs .. uses of
> libraries like llvm, capstone, let's delete libbfd, objdump, etc. The
> idea being to have the API defined somewhere like disasm.h and then
> based on compile time and runtime options select which implementation
> to use. Things have evolved in perf, with a lot of stuff just globbed
> into places like symbol without clear separation of APIs. Separating
> things by library used allows reuse of things like library handles.
> 
> That series has 2 issues I'm aware of:
> 1) the last 6 patches remove libbfd support (rather than refactor) and
> some people may care. I suspect with your fix it could be down to ~1
> person caring. I removed rather than refactored as there is a very
> real risk that when you do refactor you break, and as this stuff is
> next to always disabled then it's easy for regressions to creep in at
> which point that ~1 person would probably complain. I'd much rather we
> had a good solution that everyone was working toward having work well,
> your patches would pull in this direction :-)
> 
> 2) Namhyung didn't like that I'd reversed the struct definitions for
> the the capstone/LLVM APIs using pahole and would prefer that the
> definitions came from capstone.h/llvm.h. My reasons for not doing that
> are:
> 2.1) if you have say capstone.h or llvm.h then why not just link
> against the library? But doing that avoids the decoupling the patch
> series is trying to set up. We'd need more build options, which option
> to make the default, etc. which is kind of messy.
> 2.2) to support that you'd need to bring back a "what if no
> capstone.h/llvm.h" option in the code, I'd wanted that to be the
> dlopen/dlsym case which must already handle libcapstone.so or
> libLLVM.so being missing. Supporting the "no anything" option brings
> with it a lot of ifdef-ery I was hoping to avoid and it would again be
> one of those seldom used and often broken build options (like symbol
> minimal (no libelf) today).
> 2.3) in my build environment (bazel) depending on headers means
> linking against the library and the global initializers mean that even
> though no code (in say libLLVM) is directly used you can't strip out
> the library again. I'd need to rework my build environment to try to
> get the headers without the library and that'd be a larger undertaking
> than the reverse engineering of the structs using pahole (as is
> already done in the series). So changing the patches would mean
> creating a patch series that I'd need to then do more work on to have
> work in my build environment, and I'm not sure things are any better
> by doing that. pahole was my compromise to just sidestep all of this
> without copy-pasting from header files and introducing licensing
> issues.
> 
> Anyway, what does this mean to fixing PE executables in LLVM? Perhaps
> the first 12 patches of:
> https://lore.kernel.org/lkml/20250823003216.733941-1-irogers@google.com/
> can land and then you put your changes into llvm.c there?

I'm happy to do that. I'll be largely unavailable for the next 4 weeks 
anyway, and I've still got clean-up/improvements to make to the PoC 
before it would be ready for any kind of submission. So I'm happy to 
wait and then modify my patches accordingly.

> We can
> always clean up the issues of problem (2) above as later patches -
> don't let perfect be the enemy of good. If libbfd must live-on then we
> can move it to libbfd.c so that going through the generic source
> doesn't mean wading through the libbfd code.
> 
> Anyway, I know I'm hijacking your fix to advance my own patch series.
> I'm happy with your work landing independent of it, it just seemed we
> could do the APIs more cleanly if both series landed together. I don't
> object to (I'd also be positive for) just getting PE working without
> my series. Isolating your code in the llvm.c in my series may make
> things a bit easier for you. Having both series together would allow
> the library decoupling, BPF JIT disassembly along with LLVM PE
> support.
> 
> Namhyung/Arnaldo as the barriers to entry, could you comment?
> 
> Thanks,
> Ian

