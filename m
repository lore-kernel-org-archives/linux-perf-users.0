Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EC33F5A9;
	Mon, 20 Apr 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701393; cv=none; b=JHXcRcHhooMP0hmhRh6DijPIp70BGk+cdeSfV6SHv6Y5M4b3AIiKxGwo0HWNsi7q+FbYBZU8vPP4DMq9mVdHv4nvWGFKsalZ4xvogDVqrF5ypDAZPJ0WbhsKge3MRGoPk9MfpVXpA2ruMOQIbsx6WNdbbhf5mXtyuEXFqSJBVG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701393; c=relaxed/simple;
	bh=LU7CWvXhlzTiwPRG/Dl10GW4MQfjU3GRcoyKpKoSbRE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=L/bvtDpGVhbNhm6UgDcPPUk0JeIFng6nXanxUSrtcxHRWUvQ88D700MFOroM0FNHN9FCycvOXZi2DF+4EngqEDoXje7B0CSnjf7RsarIsI7OYDvA5k0arN3iAWlLmlPVrVd3bfVLZqcWGggnDXJdMF7LltHF7D5426W/kF1cuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Z0TzwIAk; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Z0TzwIAk"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 63KFYZjX2498022
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 20 Apr 2026 08:34:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 63KFYZjX2498022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1776699277;
	bh=YOjefaD0HuomJeYQN32my7NysyPXsVG/fp1iO82adoE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Z0TzwIAkmhRhYKAdgMU7zZOnFZ/pmn5y6edNTygmnz4HHuiMdiwc1bHwv1KHINYgw
	 3b9lK3aoAmMve6fTbEv29/xOoFip9B3rQRwaF/IWtT3ormqVoYn8/moLbJJfNQxhDL
	 6ZJay8EQEhfH9MM/2epY61SI47QxzKyIIKZj8XCs2u2GyaOoQg9zX9mcp+nBWn3RWN
	 AUjYqwWaWjH/ctaJRd8J7UdakctM3lwSxH63js5+L3Owj3LkTy0IC08hmEPCKoW7+J
	 hIk0xft/dgHg46qorAAoCzfgbV1tesfgkUM4xNZEzxrDbzY12n0nUU6sccj4fYDXGn
	 PFV9DKw+i7IaA==
Date: Mon, 20 Apr 2026 08:34:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Sean Christopherson <seanjc@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-edac@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH RFC 0/6] x86/msr: Rename MSR access functions
User-Agent: K-9 Mail for Android
In-Reply-To: <febe1272-60a6-4f38-95ea-eb7d86c3d34b@suse.com>
References: <20260420091634.128787-1-jgross@suse.com> <20260420113512.GG3102624@noisy.programming.kicks-ass.net> <20260420114117.GC3102924@noisy.programming.kicks-ass.net> <d730553e-b7ca-4f90-a367-4c0ce0d8e7f4@suse.com> <aeYty5kU8Rp44USr@google.com> <febe1272-60a6-4f38-95ea-eb7d86c3d34b@suse.com>
Message-ID: <2EAC0C61-7923-4BE9-BF4C-5B4457BC95E8@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 20, 2026 7:04:16 AM PDT, "J=C3=BCrgen Gro=C3=9F" <jgross@suse=2Eco=
m> wrote:
>On 20=2E04=2E26 15:44, Sean Christopherson wrote:
>> On Mon, Apr 20, 2026, J=C3=BCrgen Gro=C3=9F wrote:
>>> On 20=2E04=2E26 13:41, Peter Zijlstra wrote:
>>>> On Mon, Apr 20, 2026 at 01:35:12PM +0200, Peter Zijlstra wrote:
>>>>> On Mon, Apr 20, 2026 at 11:16:28AM +0200, Juergen Gross wrote:
>>>>>=20
>>>>>> - Use functions instead of macros for accessing MSRs, which will dr=
op
>>>>>>     modifying variables passed as a parameter=2E
>>>>>>=20
>>>>>> - Eliminate multiple accessors doing exactly the same thing (e=2Eg=
=2E
>>>>>>     rdmsrl() and rdmsrq())=2E
>>>>>=20
>>>>> So far so sane=2E
>>>>>=20
>>>>>> - Instead of having function names based on the underlying instruct=
ion
>>>>>>     mnemonics, have functions of a common name space (msr_*())=2E
>>>>>=20
>>>>> Not sure on this one=2E The whole msr_{read,write}_{safe,noser}() th=
ing is
>>>>> a royal pain=2E Also 'noser' reads to me as the noun that goes with =
'to
>>>>> nose' [he that noses (around), like baker: he that bakes]=2E
>>>>>=20
>>>>> I would much rather we just stick to the mnemonics here=2E All of th=
is
>>>>> really is about wrapping single instructions, no need to make it an
>>>>> unreadable mess=2E
>>>>=20
>>>> Also, the _safe suffix should just go away=2E All MSR accessors shoul=
d be
>>>> 'safe'=2E
>>>=20
>>> That would be fine by me, but I'd like to have some confirmation this =
is
>>> really the route to go=2E
>>=20
>> I don't care what the suffix is called, or if there is even a suffix, b=
ut there
>> needs to be a way for the caller to communicate that it wants to handle=
 faults,
>> so that the "caller isn't going to handle a fault" case generates a WAR=
N if the
>> access does #GP=2E
>
>This could be handled by just switching parameters:
>
>Let rdmsr() return a u64 and use a pointer parameter for 0/-errno=2E If t=
hat
>parameter is NULL we can do the WARN() on error=2E
>
>> If we make rdmsr() return a u64, then we can vacate __rdmsr() and use t=
hat for
>> the version with a label=2E
>>=20
>> E=2Eg=2E something like this if we provide both the out-param and label=
 variants:
>>=20
>> static __always_inline u64 rdmsr(u32 msr)
>> {
>> 	<this version WARNs on fault>
>> }
>>=20
>> #define __rdmsr(msr, label)
>> ({
>> 	u64 __val;
>>=20
>> 	<this version jumps to @label on fault>
>> 	__val;
>> })
>>=20
>> static __always_inline int rdmsr_p(u32 msr, u64 *val)
>> {
>> 	<this version zeros *val on fault and returns 0/-errno>
>> }
>
>Thinking of paravirt support I'm not really sure the label variant is
>something I'd like to do=2E It is possible, but it would certainly not be
>more readable=2E :-)
>
>
>Juergen

Can we freaking let PV burn in hell please?
