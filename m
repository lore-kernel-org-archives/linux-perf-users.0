Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EE211A29
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748561252; cv=none; b=cEf59jjDaI0yhpe7nyTEwHiB3LwOA1DeI8w2CSqUcUXeGyhL0VFO9SCeHsIK2Ycr701BRmMy9HzUBNHVBCUSu7Ob9bwH3E1V4OoVJRBjoWDoRNqF9eC/wgPBRXgxiYtI+SK+59CRuL7/NkNPf7215BjXqRFg/GfB54qeVPDzPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748561252; c=relaxed/simple;
	bh=nkRgExktWkPoV4ASNKp4o0suzItHNI2KsTFhEZJS5/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwZuqgQ1aR5mqSzOwMeYcc7G20RTwZ6DmPQCXGqEuu+qKfGvEBzwp/if9Out5N4ODO+nZ3K1Yos5AQjkGKYSmqjCXv9WNrwH7++PPnrvF1cMzgBcYWXiBGCC7D5VHS/47k+DyJJggji97w7NcjRVQt89QZTXzRL5aZyUzGJp1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4WqP59rr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4WqP59rr"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso48385ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748561250; x=1749166050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkRgExktWkPoV4ASNKp4o0suzItHNI2KsTFhEZJS5/w=;
        b=4WqP59rrvmiFjpBrP68AopwC4dYgVQAPI02wn37SBTrFts8Mogumqeel5QGko2K9Xa
         8E6y25Xc2cHZNNNN79ikZlSynGV/+J10vhxC+03e9LPegILKJq2BMc6QhzNu1hqgonct
         T8NOAhp0NJGSS01d8x3pbC3uHDs0VELwpOzhOzHUDERK+cJhVFVeUZRkV7mz/z/7BfYr
         KniaAaUMPstQfIUYFjZpC1BPpxQRcpq4YPsVTvUz2mwArPVVyvthkoVg2V8yTEbxQkUN
         0pR83CqVjCEoFtbfEz3RX6jLBXb8bc93hQ10UVtdaBTwXbry/n9A3nR6HwcQ8+trMGrT
         RFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748561250; x=1749166050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkRgExktWkPoV4ASNKp4o0suzItHNI2KsTFhEZJS5/w=;
        b=hUmgpg4zL+FiP8Vcye0CmCRfHP5EeYXhKMUCv7mlXZcbvt2w7A6vBLlxXaFByBHB7L
         F7VXjiTjXPgwc+k6qCtlNsEuVLJ1m3fcJEJ7yF0UrcCsyhDveyv3ISe888Kp6MA1KUSV
         1/BkteP8eP+rbs0lk0O0gBLFik+b378x+ZKheKHUaDdmDXezW0DEQo6oItRBAdO1vMRz
         11ZQTCjMfvWw9lAUQzI/Wmy+xtHUbTVO8RiiQuws1dAybzXFgoGaQGIiNJkQPlIxq17D
         W9ByOEOt7Qk6NMO9A2qnwtUYXkk9ZMSV57zgH6LnZCHvqx3T9BRW+LIQy6Ei8pDNtjs0
         Opqg==
X-Forwarded-Encrypted: i=1; AJvYcCXwsUmriflQOPIZqPkE4CkAk7bcPZb93gFk0OiPRpWTW10Ethh82WTysPNaAH5ZF5OB3qQaQOxHDZMHXlpgNHTL@vger.kernel.org
X-Gm-Message-State: AOJu0YyTBzSTFlmmmkN1Ylpi6jOtH0SSSo91DFQf4fVi4mDhvh30TpmB
	qc/wdhu+8JXxpJrOtHEJETGU3UIbuZcIFyqRSpmY/m1quQl7oyNhK6H1W3AtmfDMO5shDrVLv/k
	UeFoi0VCKLLsHulije2pS4BGzdkEFbPVokPhtv/L0
X-Gm-Gg: ASbGncvbf40sCqrcssReQfCieLwTao8k4eP1ixZEX8wtKEGUpQG+ZsD6b+j7wLdBTjB
	06/epjREfWhAlvGivsfwtnylre/1F3L7KS+3hgUjpnD5AG55JBGSDTchteHzywD448qBNwnxcUN
	KgN2blmuX1BF/DutmrHvmh6BvaLhrZ/fL53M8i+LSdHGARMNaCJ20UPlE=
X-Google-Smtp-Source: AGHT+IHLmy0nRSI3pD4dWzHG/KLXzBhm5OI0nmwhq4T9rKXhINbdxKGX8zoaRsASfBrRMpq6BoDM9QIWbwJsPqa32/0=
X-Received: by 2002:a05:6e02:154b:b0:3dc:8116:44a8 with SMTP id
 e9e14a558f8ab-3dd9a7e4ba1mr1533675ab.26.1748561249792; Thu, 29 May 2025
 16:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-4-blakejones@google.com> <CAP-5=fWZG-N8ZzRh6h1qRuEgFbxTCyEwGu1sZZy+YmnSeGgSSw@mail.gmail.com>
 <CAP_z_Ch2SKwVcSV7ffV1Lbp=6TuKLyofSs1gpfBPMf6mV9-wHA@mail.gmail.com>
In-Reply-To: <CAP_z_Ch2SKwVcSV7ffV1Lbp=6TuKLyofSs1gpfBPMf6mV9-wHA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 May 2025 16:27:17 -0700
X-Gm-Features: AX0GCFuFUHoZigmrpc5J862lbtKYyW7pCTUFeDXVHf0lCXfWDnfxr2BAbxc_ILg
Message-ID: <CAP-5=fXkfVb4gwuSXr_yZMj8ctPr8LHs-Js7g9hP46dhkU_kQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf: collect BPF metadata from new programs, and
 display the new event
To: Blake Jones <blakejones@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 4:09=E2=80=AFPM Blake Jones <blakejones@google.com>=
 wrote:
>
> Hi Ian,
>
> Thanks for your comments!
>
> On Thu, May 29, 2025 at 11:12=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> > On Wed, May 21, 2025 at 3:27=E2=80=AFPM Blake Jones <blakejones@google.=
com> wrote:
> > > diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/per=
f/util/bpf_skel/sample_filter.bpf.c
> > > [...]
> > > +// This is used by tests/shell/record_bpf_metadata.sh
> > > +// to verify that BPF metadata generation works.
> > > +const int bpf_metadata_test_value SEC(".rodata") =3D 42;
> >
> > This is a bit random.
>
> Yeah, that's fair. I added it because it was a straightforward way to rel=
iably
> get a known value that I could observe from tests/shell/test_bpf_metadata=
.sh.
>
> > For the non-BPF C code we have a build generated
> > PERF-VERSION-FILE that contains something like `#define PERF_VERSION
> > "6.15.rc7.ge450e74276d2"`. I wonder having something like
> ]> [...]
> > would be more useful/meaningful. Perhaps the build could inject the
> > variable to avoid duplicating it all the BPF skeletons.
>
> I could do this if you'd like. It would make it harder for my test to che=
ck
> that it was reporting the right value, because the PERF-VERSION-FILE defi=
nes
> PERF_VERSION in a way that's useful for C programs but not shell scripts.
> I'd just have the test check that it was reporting some string (maybe one
> with at least one dot in it, if I can stably make that assumption). WDYT?

It should be okay as you can compare the string against that reported
by `perf version`. On my build in `/tmp/perf`:
```
$ /tmp/perf/perf version
perf version 6.15.rc7.gb9ac06abfde9
$ cat /tmp/perf/PERF-VERSION-FILE
#define PERF_VERSION "6.15.rc7.gb9ac06abfde9"
```

> > nit: I wonder for testing it would be interesting to have 0 and >1
> > metadata values tested too. We may want to have test programs
> > explicitly for that, in tools/perf/tests.
>
> My testing right now depends pretty heavily on the fact that perf will lo=
ad
> sample_filter.bpf.o for me; this seems much better than trying to load a
> BPF program manually from a test.
>
> If I could find other perf invocations that would load other BPF programs
> automatically, I could potentially test the "0 metadata" and ">1 metadata=
"
> cases. That would involve more BPF-program-specific modifications, though=
,
> which would be closer to the thing you objected to above. So to me this
> doesn't seem worth the effort.

Ok, and the main 1 metadata case is well covered by the test you added.

Thanks,
Ian
