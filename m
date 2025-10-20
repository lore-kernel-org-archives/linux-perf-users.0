Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D22E62A8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947226; cv=none; b=mHwX7uMzkvRZ1CuCygLaPG9cmlsWbATDOg8pXiXss2o1jh9Vk6QHofFNwJAIxWu4dFUV0i9IGI6uVAubiPrwLWbSGmPGqPBmu+/KyQw8vuQh+waXbjDXb3K/Z705+KZUMrTxpSB55VzVHq/mpBBbQjfTKyG+1mEFQlIOLI7ElZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947226; c=relaxed/simple;
	bh=Zmqo4L+meBOETvdur9HriUdnxH1JJd48yOGhQ75ip1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HK063p1tWYqlzkUBER7cSfFoD4TcEBwSa507SEZTlUFqPpCXxhMcTlmmTz8nC0fQgtEiULWlhnK79XaEs9tNxMtmlDXVrZqTDc2SziC8OTXyijXe+disyfkjcEAzEFi5HY80GctP1mT803R98rRtJ55M2nuSFl1O/XHR2bmza/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcyUDAUP; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcyUDAUP"
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-36a6a397477so40779781fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Oct 2025 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760947223; x=1761552023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqFqpQMzveXZ0RGEyviEw8DDVWwyBqtk13RJd8bj4CU=;
        b=XcyUDAUPPTFohquNJG9Wt+PeHhyqoozQHTXCFY0p6WwxojSFpve1rgiCYW7EuK7cDq
         5vsNTUhgj+8O6yimk5SKHn7J7y84SKPmpFC4S2zDLDD4bFljVGTifpwvg9pmm49oImon
         q6Z//8Q5r4fOVLC0g7WDMOf0TD83nzq4Ji3v6z4Mj1N1mrR6xdEW5PwCvlr8S1aqwjen
         6fBbEtZMdm20qow3g/08ROuxMzJEycBJ8ABo45nrb36PLHEFW8Eifl/A5Bo9PUhETj9N
         UWhwP6GEBRyJCEmI8P7qcA3MvTIyiVyEkgm5wYAVlcMLdp9hQtYttYDDm1GjVxPBhhIG
         M7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760947223; x=1761552023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqFqpQMzveXZ0RGEyviEw8DDVWwyBqtk13RJd8bj4CU=;
        b=k9jog+dI0YLilFbt34XxIkR0L1m8HJ3gxcci0Q3JoASdn+kdtBcW47yEWcdNGlRJxH
         Ol4ls7GZD7EQD9WX/lxXvKxBt5IdwvMPHJ+Oz+bdkyBd5YF60olg6ZdHM+iilMV4WLKT
         GeleNS7pJ6RPtBh41FrrnUSL7yxJNJ9+Re+J2rdNzz9yMY3iK6KZXBRc0RY0IiCzkIiW
         SfLksOdjMEKlZVRyhALzedpJ+X8LQPVbSwqjiM3QEN8uSAdYSIPKDNYAfPdHH9UQhPsP
         pCGM9eKY7GonVf6f4KBrk/8Hp9GqxSzxqFIBXEXNLWLP9c3Dkiq/sb5XEVq8Zo8L/MYE
         c2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVWsl9LprZAAD7rbFHvFJhM8ONL69MmUMmiXZ5/PvyRvK0HHnjcDhzd/3Csg/HneeV5AWRvGFdKP91vf4q3E6Cs@vger.kernel.org
X-Gm-Message-State: AOJu0YzehDtcZ6YXm8SDF6+QfKmm3mBwgOm+PTMGMOY83uUQEjf2+RlL
	NXAlII6zJq6tK/JNXIpV1PAd000TgDe48d+6Xcgeil15BGbpMYKjXRXYFLvHRMS0eIFk0K4/1U+
	aFOU4VeVR2WRrPkUqmCXRAeTzY5DhiJA=
X-Gm-Gg: ASbGnctrQBoIo3dm/56eZgYXLjG+gK1+eiCPxMRTurrJZfZ4EHD+aR2HkQOhzFcwMXH
	BI1leucWqaRKWB0PA8hZv0YUSdaRlCvQSST3YiS/D29NLtdSK5kdTr4+/wkPMoc56n1LGambRh7
	3QD9WLc/JtzxQ21pmGO/F05unCBm46W6fkiykyH4DANUjaSFYM4YDloIJQYfjw20mhoLX3yRIDy
	Nv9N65tmdQpVHbDvvR3H0uNvDmG3F9iuU+4ojIgqs9fM+otEyWkQ9fUEsjamcBkuoAhg5U=
X-Google-Smtp-Source: AGHT+IEb6aTrOmEOubjtMhNC4fScG5O+4jxoJC7WfiJ+3w31K1dW+u/j2kGMtu9zgMz0h6FWV//Soz3m52hhkz09Slo=
X-Received: by 2002:a05:651c:1b96:b0:372:9f0c:2154 with SMTP id
 38308e7fff4ca-37797a63033mr32880721fa.42.1760947222240; Mon, 20 Oct 2025
 01:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com>
In-Reply-To: <aPW3rilb8DtFDIMC@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 16:00:10 +0800
X-Gm-Features: AS18NWCPgKC5zJlAEPd5vuFyJxDJdYi3AQG_LXrD3kVoNlN710m-tOjCqzYruQQ
Message-ID: <CADHxFxQF033b97sBx8rtRHAo5Ou5Uc3WLUH1Y5+qA3f1i2MMjw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thanks for your review.

On Mon, Oct 20, 2025 at 12:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Oct 20, 2025 at 10:40:49AM +0800, hupu wrote:
> > When cross-compiling perf with BPF enabled, Clang is invoked during the
> > build. Some cross-compilation environments require additional compiler
> > options, such as `--sysroot` or custom include paths.
> >
> > This patch introduces a new Make variable, `EXTRA_BPF_FLAGS`. During BP=
F
> > skeleton builds, it appends user-provided options to `CLANG_OPTIONS`,
> > allowing extra Clang flags to be set without modifying Makefile.perf
> > directly.
> >
> > Example usage:
> >     EXTRA_BPF_FLAGS=3D"--sysroot=3D$SYSROOT"
> >     make perf ARCH=3D"$ARCH" EXTRA_BPF_FLAGS=3D"$EXTRA_BPF_FLAGS"
>
> Why not just:
>
>   make perf ARCH=3D"arm64" EXTRA_BPF_FLAGS=3D"--sysroot=3D..."
>
> >
> > Change history:
> >   v2:
> >     - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
> >     - Update commit message
> >   v1:
> >     - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options
> >
> > Signed-off-by: hupu <hupu.gm@gmail.com>
>
> Leo, are you ok with this?
>
> > ---
> >  tools/perf/Makefile.perf | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 47c906b807ef..f1f2efdbab8c 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1249,6 +1249,11 @@ else
> >       $(Q)cp "$(VMLINUX_H)" $@
> >  endif
> >
> > +# Allow users to specify additional Clang options (e.g. --sysroot)
> > +# when cross-compiling BPF skeletons, enabling more flexible
> > +# build configurations.
>
> Can you please move this comment or add new one at the top of the file
> along with EXTRA_CFLAGS?
>

Alright, I will prepare a v3 patch based on your review comments.

Thanks,
hupu
