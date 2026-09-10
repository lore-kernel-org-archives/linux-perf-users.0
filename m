Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75F4A3F3B
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054651; cv=pass; b=hpQ0HngvgF6BGOKoymGMEEylxYXSRDTqLphQTTmSML6E3Xs75X+GaLNqzRcJC8blHXXdxxV/w7IPlO//JmLoUgW/MbQlcqTd5CqWUoQ4oGxc41FnuoNZO4skD+C36HB39QS7JMziCVL/bIQanqJrqo4EfjJVOgEMphO5qRqbk3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054651; c=relaxed/simple;
	bh=ynSxNuDkxhKdE/yGw9XYokMd7L14dEwjnifpIUDbrDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xj76jiCT7D21CTV5wlQS5Ng/fT2nw+BZylAqstEG2Ca2NXhVd0UhvvzgTnyktG4AsPMDgfhebKmGHCmJoS4FaJaEDEq3LKuymHAlcYVBGgoiJ77lDzzkdkdsyxqsDVOtg4wsB0mM2dzfW2c6dmQxUiIoi1EfOk0eZRI1jiuWgHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wd8vwnNR; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wd8vwnNR"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so308171cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 08:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789054648; cv=none;
        d=google.com; s=arc-20260327;
        b=Xae/QXGafikwQhNrCNBctOvAr2s1XJyXjSLcj3IdVhYEFwzwW8oVVYnzcyu+aIaiBJ
         Pcnibg7dMekujOh0Ggw0Pjkf0JsyYIW9VgVNz/tlizfLq8JcaeQpndBUYYslDmkgtxey
         dBODpI6WUwhWqoO5eqtq2oMwBDdPnreJSJrevRqNGZUDsJCjGjwjy1qY0DkinQEbQxa8
         TVbNsaA648TPpnxQOsWpTf+VYKqBiNNwYOPojcAA234Eey8u2h+Cs6pVUdlEtLo71ZLV
         dPTMpqbpafOGn4Q8LHRCVCPBkSkSS29aww+hHFklQb/hWRVAxdUmVxVWt97EwJrBDMZv
         qPZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2fzJmHe53im+RdRlFHTdcZykU88bTlrtsEb9uv7A3KM=;
        fh=HAMd25OSDSbmINyQbJNHGL0Z+AobeFrjDwM+TGrU9Uk=;
        b=Ts/kFVKHY3hPZmSg4itHnxhtnBr1sjoKVZCBx8kfIJwD9pEXZ6atdNU4kQIu8euk1z
         t+egBYp0sH+2D2PRfZs0s4jrclUvYKHz4hJvTCuVvPTuenUbZlYjmG+PlUTCjv8F8Tgy
         dnY8xPfM4aU8JcBe41bw4J1sabz54EzBpRgmCv1t+mXlfcv+s2POPnY4HRdOtTXw0dYP
         jgQchXjvsW7yxDLF72Q861BF2Cqw4X3LakdZuwc4BgPAg5crhmQM2sFdDoAGpkqGFAMz
         NRDtTFNvC0eI70DyJryz1xYhrrjAvzLaxPmh2BDsGdqrBl+Bl9vkYAeN1ErV6mVAM3y2
         Rt/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054648; x=1789659448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2fzJmHe53im+RdRlFHTdcZykU88bTlrtsEb9uv7A3KM=;
        b=wd8vwnNRXgVHoy9xVoIX50iGQJxor55X1x214F6cv6Zb/Q/yCojNIy4Gn8J+JUJs+i
         l6r9+FoVQpzxjJD404IOrhPh8ClFNuYMakxyuaMSEtiYXhlA1GRDfliYP4raZMb+bIT5
         FeYl+tzvOPCyRohKGWRodf61Ad69RnbUVYyVsBHmo91dTKkvN1sVleiTiEzOZZj/PEK8
         exo7Gzzqhgkv+J2lkuaRCRmKxXL2VbU1zUvjpO3pB8e9eHtMzO3IP7xt2/n2Uvm1OFft
         +o1JxutEq7GJLzi6mkY0CMr7+6qWWVQsfm0c5pTHFxmrp3di7UYD0RsF83f9jZ+scD+O
         bt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054648; x=1789659448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fzJmHe53im+RdRlFHTdcZykU88bTlrtsEb9uv7A3KM=;
        b=se4+vVhEHBPsRYuNvLoqm6p16LejgDMr6jyxutldUGi2Iufck3zenWylt4FxfzoZv/
         SqnM5dWdPVs5bLiQVr9eFFOIIjFvcGi222yb9bAvtyHlm4d4GsOB4hH3yNSnSnevRa2h
         RrQDzTewMdUR30SLllynb4W+aIvahJuYTHwAY/rrzs645BgW21Qgbm38Dp9N4CzX/GUg
         ARl8X+czmLTArBTHTbHQfB9BtlciAe3WjAt9nH/IYYSaloK0rkyfNBUIIamw/YP8557g
         gwByS1dF0WaGZSPmjjaWvIYqWlaIyj3WUnZQpPSsow+MXC6cZCEBuMJQnPFAzUjbrT/W
         X0Hw==
X-Forwarded-Encrypted: i=1; AKwUvBzYL/8wxjmk8Rmnzzl7mul+TzzgoEDdw+I7J9Ub87odrMPDhEOcfGqe4LJVI9kM7LlfHzYHu4eRGXMymG6SCihM@vger.kernel.org
X-Gm-Message-State: AFuF++nSKKRy3hbnkzYNzs5JUiReZwxDOwx2c46QNI7LixHa/s0GM20L
	+675OQpp8+O24cCbD7RwXtztRpd043/8U92FCZN9mHnBK86N6n0/yUsiyqdIaL18H862PahQ8oF
	PetV7htva63jtwEYGnZVI2iuLklVGj7bPsz0nKZYZ
X-Gm-Gg: AYBFou3UYuuxR4xoDF1njTD82M/2PKO5KiRPe7KhdkVORqXZzSH566hjxtcK2C4yhAZ
	xwnsI7EVeL7B4R8Q3j452s2jFm10Nx6Ux0A8VTTBQndx1XsmizrGNwqtTbFpSnDgibbr4XIoi52
	aV392IUOSHHOm/Ss1aeJQGVyFauUS4DONSCJjI6563Or46GN9fDyDvLy8YWLaT+KbLBhQQu/HDN
	Sr9gMUopV+ii62sshJfCROlyBf3hI9Q0glooGF86c+DIZAOQ3SVIgbiHxGzfvz4zXnvy3hHimLP
	FK4CiZelU4RyXy1NucoXbzYhKFXfZIz0yki30wzHlG6DlXrHCj/AiJvffQEvIdA7dGQEaJc6P0v
	SnBC5+j4qMCrzmsEUaLMC
X-Received: by 2002:ac8:5711:0:b0:527:f08f:56a2 with SMTP id
 d75a77b69052e-530b48fee7bmr20271511cf.8.1789054646975; Thu, 10 Sep 2026
 08:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909204122.1993010-1-irogers@google.com> <20260909204122.1993010-4-irogers@google.com>
 <36a64b34-bb69-4352-9e84-c31d0793b6a4@kernel.org>
In-Reply-To: <36a64b34-bb69-4352-9e84-c31d0793b6a4@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 10 Sep 2026 08:37:15 -0700
X-Gm-Features: AcwNN1VPdFbSJ00CKGszV1vwicAKF7OS9Ew-KRRognhOG4ktLaQZIRP5UUupJ2I
Message-ID: <CAP-5=fUC+2+qafs=GjfC6K5X1o8t8BTxj8L7NuGAm40n_UTYWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd
 feature fallback
To: Quentin Monnet <qmo@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, Tomas Glozar <tglozar@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Leo Yan <leo.yan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 2:20=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> On 09/09/2026 21:41, Ian Rogers wrote:
> > Distributions like Fedora currently ship a statically compiled binutils
> > libbfd that natively depends on zstd to decompress sections (e.g.
> > undefined reference to 'ZSTD_decompress').
> >
> > Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
> > bpftool's Makefile so it can natively build against static binutils
> > distributions.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3.1-pro
> > ---
> >  tools/bpf/bpftool/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index b0f7168e7943..1cac4508eb0c 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -125,6 +125,7 @@ FEATURE_TESTS +=3D libcap
> >  FEATURE_TESTS +=3D libbfd
> >  FEATURE_TESTS +=3D libbfd-liberty
> >  FEATURE_TESTS +=3D libbfd-liberty-z
> > +FEATURE_TESTS +=3D libbfd-liberty-z-zstd
> >  FEATURE_TESTS +=3D disassembler-four-args
> >  FEATURE_TESTS +=3D disassembler-init-styled
> >  FEATURE_TESTS +=3D libelf-zstd
> > @@ -135,6 +136,7 @@ FEATURE_DISPLAY +=3D libcap
> >  FEATURE_DISPLAY +=3D libbfd
> >  FEATURE_DISPLAY +=3D libbfd-liberty
> >  FEATURE_DISPLAY +=3D libbfd-liberty-z
> > +FEATURE_DISPLAY +=3D libbfd-liberty-z-zstd
> >  endif
> >
> >  check_feat :=3D 1
> > @@ -201,6 +203,8 @@ else
> >      LIBS +=3D -lbfd -ldl -lopcodes -liberty
> >    else ifeq ($(feature-libbfd-liberty-z),1)
> >      LIBS +=3D -lbfd -ldl -lopcodes -liberty -lz
> > +  else ifeq ($(feature-libbfd-liberty-z-zstd),1)
> > +    LIBS +=3D -lbfd -ldl -lopcodes -liberty -lz -lzstd
> >    endif
> >
> >    # If one of the above feature combinations is set, we support libbfd
>
>
> Hi Ian, thanks for this!
>
> Just checking: my understanding is that if libbfd depends on libzstd,
> then it always also depends on zlib, so we never need to check some
> variant such as "feature-libbfd-liberty-zstd" (without the "-z"), is
> this correct?

Hi,

You make a good point. Normally we want to use pkg-config to get the
libraries necessary for a dependency. Unfortunately pkg-config is
generally broken around binutils/libbfd. This is why we have all of
these tests to determine the list of libraries we need to link with
libbfd for things to work, which pkg-config normally provides. It is
perfectly possible to build libbfd with libzstd and without libz, but
currently, we haven't encountered a distribution doing this. I can
imagine a memory hardened future where libz has become zlib-rs that
conveniently provides C headers.

For perf we don't build with binutils by default; this matter is only
an issue for our build tests. We don't depend on libbfd because its
GPLv3+ license isn't compatible with perf's GPLv2 license, which would
create an undistributable binary. This isn't an issue for bpftool
because its BSD 2-clause license is compatible with libbfd. In perf
we've been replacing libbfd based functionality with that in elfutils.
libLLVM is another consideration, but it's generally too heavyweight
for the effort to be worthwhile (it is generally large, distributions
don't want a dependency on it, and it runs many initialization hooks
at startup that don't benefit perf). Hopefully elfutils can provide a
stable API for its disassembler (libasm) as that would cover pretty
much everything perf needs without requiring us to fork objdump, use
libcapstone or use libLLVM.

Anyway, we could add another flavor (zstd without libz) to the feature
tests for libbfd but since this isn't currently an issue I think we
can cross our fingers for binutils to fix pkg-config or for other
tools in the kernel, like perf, to migrate away from the use of
libbfd. If we add every flavor of libbfd's dependencies, it feels like
a lot of build clutter (imo) and I don't know where we stop.

Thanks,
Ian

> Quentin
