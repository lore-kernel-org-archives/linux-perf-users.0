Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEE3370F0
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545437; cv=none; b=ZFxf7XMr2hPNDfzCVkIFd6vDJ8qk66Qw4UCUa7g8S/1RBaxiwORnkgcUVOAfvObv49dfDOLkZDKglget0AHdfkAQDm88L5Y5SACq9Ac0JMoaM3Yip7/tCmORoOfjJn26tzashMtIVpY4n/Pk//Em0FK5Wh4JSOzYnxiwKpI9bRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545437; c=relaxed/simple;
	bh=YCuuQ4Gf9qVTgjyBOxKmdCmIqW2Sy6fVsHsFIsJmb8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsjdexYJec67CgmpyHDiSaE43ss/v9J4/qhY30BWNgjSdoBlzUNW53Xmxfp2GWstzBk2ymu1HO+RlutKepbapNgCb8PaaDc3RN7qIKeWTMz6GjFW4+9bupzBHrOK67oD16I9M63HPbQzErtPkRSM2akcOtZYF4vlRsfm3y6Kyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IV1IEYCL; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV1IEYCL"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5959b2f3fc9so1492665e87.2
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 01:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763545433; x=1764150233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Fa9tqny9Uv3EsQHOlHh6vatB6E0hfhqPdHHDP8aCig=;
        b=IV1IEYCLolMlYGjqXMxw1Ibui+A5zwRL72/WLNlLVvIo3wppMASktAsiULbzCzFHr7
         UIjJB3n1etad6CPqir5h8Y9mu1pCtbeg/gN6yiQ3WGmUYJuLtXp8lBX5Fv79LmVv+1mD
         8KzRaUB3VOWFIWhroHrOT2/bjpD1QFfykDTSr2qAmomfAzLxJ67XVXnqjZ+MU/5rFI7r
         8XR5z0XkUzcbF5+oCgcSx948cQVCZY8Kbz2gm5hmfVard2ntZJITUsBl1xdLbT+wmUPz
         f0MzGAqM6RNFi84XKgw9cb4Zgt8UJk40DBlZJPBYS+BtWihGIXXoa+4C3UcY5VhFlSD/
         Lhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763545433; x=1764150233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Fa9tqny9Uv3EsQHOlHh6vatB6E0hfhqPdHHDP8aCig=;
        b=WLrFvKZev7NBPh1sTyoKPReN1f7FB0Wi+lD2lLmS6hD++C632nnBR5z8Uw+pKbKslN
         fUGnFRgNPVXTGmArmnWKM0kDB2sXG+cvc4SiyvKE+lZUtvglSkKN9Gl+smny9SmXIKw6
         Y88l690SOSSoa2F/gdYOVmheRlrmJT4Vn9eIbn2D+mw2bYKEnUMWCgTH2YQsMYz3gXtF
         ybXBP507U+DEGJZQGp1AFE+Y5cIcbD3qQfqQaPCRKXATTpjUd4tjIbWrV5x91Fh55Al+
         ZGkh+4U3LfK0IKFc1sLYo/mbvq2ksbgmGT6mmlghqbjbecNS6M8CIH66WJcJPn0JdevA
         UiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI5KbyvNteXHEQ+2ZftFPstHUCJifBuyDetCo7Zazn0VlMVAYxeoOCoeyc4FK1yl4s96swPTEpNuDRpuZjKiok@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgdaKmcyfa8FD0FWyLskLs37ePXEMvySv6fVKnL7GFo0iBwu/
	42tos4s1NBzq1MedaBzUmRaUbTd4/jGBe/+L7srTJU5IZw50y27e2MonUD2LZOCq2mUmu5JYmi9
	zmfK83iXEaeCovk1ONEHCSo+MuNRT6JU=
X-Gm-Gg: ASbGncvfk6jPjGfwDN+hhNonO2ow05U6GKWh/ZAbBtpfdvlN2B9+Vi9OYd0M5OgZ0dM
	9Z9Tw5ibUnS5tAqotL4pZdJelM8Ap27THf1AN1DIY9LY0AfcHOg/5crMlDtbJcGMhjpv4eZr1sJ
	CYu88BoRu5ChwEuyyGQ/28EJzi8ZTe3FgLubhgsGMvBtLt75dSx/yohGbQyhxHpMXl70ZmXu2Ca
	FESGyBTX1BY8GNF9U2KSV/IeoGd6dIta1EMNzoLJA2lrSWqBm60NbN63INE9vf6MBsl0fg=
X-Google-Smtp-Source: AGHT+IEWG3uyhIOtAp8CAmOqn4Kv4GJIT7ML8FHe4zRBPSx6UxMqVzMhTFgupSN5tRiIc5L4eLqqTt0tT3bsdF/zEx4=
X-Received: by 2002:a05:6512:4286:b0:595:fb9f:f967 with SMTP id
 2adb3069b0e04-595fb9ffec0mr864716e87.45.1763545433066; Wed, 19 Nov 2025
 01:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com> <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
 <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
 <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com> <CADHxFxROMe++VB17J3UgOxSoEhJ7bNagBHO6gRQQPpAELc1ocw@mail.gmail.com>
In-Reply-To: <CADHxFxROMe++VB17J3UgOxSoEhJ7bNagBHO6gRQQPpAELc1ocw@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 19 Nov 2025 17:43:41 +0800
X-Gm-Features: AWmQ_bkZG-DjStSPdgqFViwf3UiLdDmoVSYms7O0cZDmXgesrKna4QCH0ZVPSZc
Message-ID: <CADHxFxTHHT0bWf__dwnZXk6E8Qb2sxL5=L5KDh_Xmzq-hNYs6g@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

RESEND

On Tue, Nov 18, 2025 at 3:28=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Leo and Namhyung,
>
> On Tue, Nov 18, 2025 at 3:18=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> >
> > I then added KHDR_INCLUDES to BPF_INCLUDE, pointing it to the kernel=E2=
=80=99s
> > self-contained header directory so that the build prefers headers
> > provided by the kernel.
> >
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 47c906b807ef..65c6e871988b 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1202,7 +1202,8 @@ endif
> >
> >  CLANG_OPTIONS =3D -Wall
> >  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET=
_ARCH))
> > -BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_=
INCLUDES)
> > +KHDR_INCLUDES :=3D $(abspath $(OUTPUT)/../../usr/include)
> > +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> > -I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)
> >  TOOLS_UAPI_INCLUDE :=3D -I$(srctree)/tools/include/uapi
> >
> >  ifneq ($(WERROR),0)
> >
> >
> > With this change verified, perf compiles successfully even without
> > explicitly specifying the cross-toolchain sysroot in the compile
> > command.
> >
>
> As an additional suggestion, I=E2=80=99d prefer to keep both the above pa=
tch
> and the previously discussed PATCH v3, which would mean submitting two
> PRs. From my perspective, allowing users to pass custom compilation
> options via EXTRA_BPF_FLAGS is more flexible than only configuring
> headers, so I=E2=80=99d like to hear your thoughts.
>
> Thanks,
> hupu
