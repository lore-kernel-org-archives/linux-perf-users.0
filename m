Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B1241443D;
	Thu, 10 Sep 2026 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070012; cv=none; b=YMbbbj0cNXXUlzbhM4V+sc7EDNH8QV6EvVc7jyb2HNupqJ+s/yn8W1W4qWJDV9zEbZWFmtk/muLGwK9BmsMyAplCKkd49c7KyaPUxY23DLWIS7c+bMvccLwNdaZodJ0PmuM/nFdglFNPo/blswFxTx22xwCzZ8BtEVR/qH2lLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070012; c=relaxed/simple;
	bh=iWqOT9+0/3sOX827MIawvxL+XwBkdYbstgbzA9QJIlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CojKxSA9usXK5Qr3P/n12G1rnw5CVF9uQ2DnCFTQhKoMjNHuBj5Yp1esvvjXlvAOtRyCSlUGcYyZ0Bj/Nm5MdLWMP6i5WlVKGXazjpmp/dF11ZvlYaNhTa6KH+Hd5rHsJ6TEVDLFPSrNUlAYX3W5V0ZiC5W6u9o/hkXEoStEEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEPF3+3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEPF3+3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD7A1F000FF;
	Thu, 10 Sep 2026 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070011;
	bh=LWCw1vI1TLupqhlfARjSwb6dKvjuY9OTFIJZELmfBL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WEPF3+3A1c+SfmoQrIcZuPZ0jMVYuH3HDxDLG54ZBO/Q/dFxt5hdWRGMGAqS4K1PD
	 twFGnF13OWICRQjXvEWtqtPNLIK4Xu0VKKPiecbW+5c2LBsGZAsY0wMnFXnuDicz1l
	 CzN8fC6I3erLiP2Vdf4W6BnYzZvnDhrboXw/yq22VleHv3E+jizf1ea9D2w7d4NNus
	 F4NFRVTrbKBsMnZJ8RngoBDtkCx51MCEPn8bVFAVxMfaRs1hZmNE4qnns7CxSwqWYr
	 fEVUJSYxCfrp8fRTFZd60REhCyq9cWl1yXUjlfI/k8EypbDEJseBoYEK8Nc/JBPMiC
	 mti6j3gXJ7A+g==
Message-ID: <1799b944-535e-4019-9dce-e12e71aa96e0@kernel.org>
Date: Thu, 10 Sep 2026 20:53:25 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd
 feature fallback
To: Ian Rogers <irogers@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260909204122.1993010-1-irogers@google.com>
 <20260909204122.1993010-4-irogers@google.com>
 <36a64b34-bb69-4352-9e84-c31d0793b6a4@kernel.org>
 <CAP-5=fUC+2+qafs=GjfC6K5X1o8t8BTxj8L7NuGAm40n_UTYWg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAP-5=fUC+2+qafs=GjfC6K5X1o8t8BTxj8L7NuGAm40n_UTYWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2026-09-10 08:37 UTC-0700 ~ Ian Rogers <irogers@google.com>
> On Thu, Sep 10, 2026 at 2:20 AM Quentin Monnet <qmo@kernel.org> wrote:
>>
>> On 09/09/2026 21:41, Ian Rogers wrote:
>>> Distributions like Fedora currently ship a statically compiled binutils
>>> libbfd that natively depends on zstd to decompress sections (e.g.
>>> undefined reference to 'ZSTD_decompress').
>>>
>>> Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
>>> bpftool's Makefile so it can natively build against static binutils
>>> distributions.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> Assisted-by: Antigravity:gemini-3.1-pro
>>> ---
>>>  tools/bpf/bpftool/Makefile | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>>> index b0f7168e7943..1cac4508eb0c 100644
>>> --- a/tools/bpf/bpftool/Makefile
>>> +++ b/tools/bpf/bpftool/Makefile
>>> @@ -125,6 +125,7 @@ FEATURE_TESTS += libcap
>>>  FEATURE_TESTS += libbfd
>>>  FEATURE_TESTS += libbfd-liberty
>>>  FEATURE_TESTS += libbfd-liberty-z
>>> +FEATURE_TESTS += libbfd-liberty-z-zstd
>>>  FEATURE_TESTS += disassembler-four-args
>>>  FEATURE_TESTS += disassembler-init-styled
>>>  FEATURE_TESTS += libelf-zstd
>>> @@ -135,6 +136,7 @@ FEATURE_DISPLAY += libcap
>>>  FEATURE_DISPLAY += libbfd
>>>  FEATURE_DISPLAY += libbfd-liberty
>>>  FEATURE_DISPLAY += libbfd-liberty-z
>>> +FEATURE_DISPLAY += libbfd-liberty-z-zstd
>>>  endif
>>>
>>>  check_feat := 1
>>> @@ -201,6 +203,8 @@ else
>>>      LIBS += -lbfd -ldl -lopcodes -liberty
>>>    else ifeq ($(feature-libbfd-liberty-z),1)
>>>      LIBS += -lbfd -ldl -lopcodes -liberty -lz
>>> +  else ifeq ($(feature-libbfd-liberty-z-zstd),1)
>>> +    LIBS += -lbfd -ldl -lopcodes -liberty -lz -lzstd
>>>    endif
>>>
>>>    # If one of the above feature combinations is set, we support libbfd
>>
>>
>> Hi Ian, thanks for this!
>>
>> Just checking: my understanding is that if libbfd depends on libzstd,
>> then it always also depends on zlib, so we never need to check some
>> variant such as "feature-libbfd-liberty-zstd" (without the "-z"), is
>> this correct?
> 
> Hi,
> 
> You make a good point. Normally we want to use pkg-config to get the
> libraries necessary for a dependency. Unfortunately pkg-config is
> generally broken around binutils/libbfd. This is why we have all of
> these tests to determine the list of libraries we need to link with
> libbfd for things to work, which pkg-config normally provides. It is
> perfectly possible to build libbfd with libzstd and without libz, but
> currently, we haven't encountered a distribution doing this. I can
> imagine a memory hardened future where libz has become zlib-rs that
> conveniently provides C headers.
> 
> For perf we don't build with binutils by default; this matter is only
> an issue for our build tests. We don't depend on libbfd because its
> GPLv3+ license isn't compatible with perf's GPLv2 license, which would
> create an undistributable binary. This isn't an issue for bpftool
> because its BSD 2-clause license is compatible with libbfd. In perf


We still have some issues for bpftool related to libbfd: for Debian
packaging, building against the shared libbfd is "Not Allowed" [0]. This
was one of the motivations for introducing the use of LLVM as an
alternative dependency. I didn't know elfutils offered a similar
feature, I should look into it.

[0] https://packages.debian.org/sid/amd64/binutils-dev


> we've been replacing libbfd based functionality with that in elfutils.
> libLLVM is another consideration, but it's generally too heavyweight
> for the effort to be worthwhile (it is generally large, distributions
> don't want a dependency on it, and it runs many initialization hooks
> at startup that don't benefit perf). Hopefully elfutils can provide a
> stable API for its disassembler (libasm) as that would cover pretty
> much everything perf needs without requiring us to fork objdump, use
> libcapstone or use libLLVM.
> 
> Anyway, we could add another flavor (zstd without libz) to the feature
> tests for libbfd but since this isn't currently an issue I think we
> can cross our fingers for binutils to fix pkg-config or for other
> tools in the kernel, like perf, to migrate away from the use of
> libbfd. If we add every flavor of libbfd's dependencies, it feels like
> a lot of build clutter (imo) and I don't know where we stop.


Thanks for all the context, very much appreciated! I agree, sticking to
the zlib + zstd variant sounds like a good option for now, thanks.

Acked-by: Quentin Monnet <qmo@kernel.org>
