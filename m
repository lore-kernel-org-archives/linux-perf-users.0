Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153E7483
	for <linux-perf-users@vger.kernel.org>; Sat, 18 Oct 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781919; cv=none; b=Tjc2QraI23P8hOHU+UZjvFacmoZpbQfKqDIvXRsJmT0VB/jTiWkQ21jfYCfbM9YjMGYNOJRxzW2vhTuXL+EqtWsgIwD7WF6o6V0FUCDw/fPJBgG+3Pw1bFEdYW3CNoa22bYRzhBMsgoYeSLoM/jzggbWG4GJEX3Nt48m0JOz2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781919; c=relaxed/simple;
	bh=jILDbtgEGrDjHKsxHXX0Z7pNz2KBcPwl+sHUKqZRRKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o75Kho7SPcfMnwXFmDn7OsYB0RFaJE6PbFTP1OL+YJP+u8nXCVvR8k2qif9LA2m59y+e02FC96GalAqDgTRTMq+maW5dsluhV+6IV6xnwhCVFRqa43i6wIUK+kMAanLCAsQnjlIiOdPMCQvvzaQUsP05Sl6YbIqtOUFHB/X1QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFF4qO5v; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFF4qO5v"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-591c74fd958so3389456e87.3
        for <linux-perf-users@vger.kernel.org>; Sat, 18 Oct 2025 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781916; x=1761386716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggNHeadx/yVyQKurytJQB18oAkIN891rfTr0AvhQ24A=;
        b=IFF4qO5vjsFEaAbbw1BZanKcTgRtKoVfgznXA7N343duYlEmYwOqsxojB/F4wk4wtR
         esEtf3sKN5Q9gKaAoALKyZwBixyu77fOii93Fugtw45g8bS4eevkwPIM9F2ECMDtHGzo
         5cCPbIh0Gv4cJJe1EsfesrDnDvnK3R9k4OBCf4NtxR+f2dLh6ylzz5K8b61XqJqXcUjK
         DiTo4mGCaXe1PoXfLViL68OMX/38p4QSVQYNX33rnL1PxkKFtZdm1NsUocnlirGOhiZt
         fCvjjX0iuowgdWmd8O3R9uZT2ib3icf3KZeDL/GWpGYauEZb1FmK/dsV7lddo26QePDh
         mjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781916; x=1761386716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggNHeadx/yVyQKurytJQB18oAkIN891rfTr0AvhQ24A=;
        b=Y8kotzFI4qUGxlZzbmDvQmCn7Plloow0o15MxOF3xS9XwKJLGD7A4xPspOHpoWR1MA
         xuirZl2/82kMNxs4hnGdNIC8vUO4TVICYnpmvl0criBLbD6Ptx9GE0CmWZ6kFsT1A/D8
         DRwFCymdYQjM5uIQXNnx2t+hPvzG/6gUTqAWx/Ab3Gk+z/Y2T0iTex5nqi7xZ3wpitn+
         Zz403HvKqo0qw724eQEbcrJLhqMC5j0TljKNk5LMKQL1e55x3jPDgQdkFWNXa8Sy6LsZ
         iev19VaWF9wgBagoLpyAcO+B4skyvqajOBpgTGlKL9XZAhr4KyPvqOYl5nsSuijWTd8f
         FIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjnJjUWxMiVhWSbMBwLSSLSWk8WL9AUyTQh5B/yz6+0XJxNUCvLmy1Px5/g4mcDxVi5fQ+rwM5Ja7L0WyCarDA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24knaFjqBGJ7hRg2LfutXEIFSzflWm8PCwLTGpZBnb7mKWhBr
	BQuxCsX9rTTuuPEdM+7dJLiMYVF1qJEmcB+bgf5suiMskJRlGXlSJoaa1MchRTPykjwlUa/hhKw
	1CJKmD1Ejwmb4QSp5E0zgescjhIpCPXg=
X-Gm-Gg: ASbGnct7q9Zt0xQELDI0gUnHZYwDhlzUx1+i/Qjk3SP0SugtJYjxHU5HwiIzep6aj5p
	3wlfllzYWYw62xRdZ34bIClc82CMd586baLEB4oY/TN1FpPKMVZKnYPBjhu57WDyNq/Ua84xxqo
	IeSuVmJg2TMXGM2AvU4qiPoBM5Zy6ljQKw3wCw6eHuG6TUTEGGWH85am5paV8t8ATzWbWJFJivm
	7o9xJbJWdDVJFhL37zhfCfi6GGTef8wr0I3ChSjMcnTYWk5ZceeJnDtkXRgh819rzYauAQ=
X-Google-Smtp-Source: AGHT+IHScblRWCo3+/Jkz+NAdGrNeOoTsaOcLasCZZiMglmvRAhrS5MGFRacZjn2a8teO4QOoi32B5GmnOXKY9XQB9c=
X-Received: by 2002:a2e:bcc2:0:b0:36b:ce19:d853 with SMTP id
 38308e7fff4ca-37797a7d1c3mr20823661fa.45.1760781915430; Sat, 18 Oct 2025
 03:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com> <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com> <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
In-Reply-To: <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Sat, 18 Oct 2025 18:05:03 +0800
X-Gm-Features: AS18NWAHkf3xqmS5GJtoX59kNBIpU3xW6dhZJ_FJPAmwFMr--pVGi6SVq85UwHY
Message-ID: <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo, Ian, and fellow maintainers.

On Wed, Oct 15, 2025 at 7:47=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Leo,
> Thank you for your reply.
>
> On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Have you installed the GCC cross packages ?
> >
> >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-=
cross
> >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cros=
s
> >
> > My understanding is arm64 cross compilation tries to find headers in th=
e
> > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> > distros).  After install GCC cross packages, the headers should appear
> > in the folder.
> >
>
> I hadn=E2=80=99t installed the packages you mentioned earlier, but after
> running the installation commands you provided, I was indeed able to
> successfully build perf.
>
> In fact, I=E2=80=99m currently working on creating an SDK package, which
> includes a cross-toolchain that I built myself using crosstool-NG. My
> initial idea was to install certain third-party libraries (such as the
> packages you mentioned) into the cross-toolchain=E2=80=99s sysroot direct=
ory.
> With this approach, even when developing on different host machines,
> we could simply specify the header search path (pointing to the
> cross-toolchain=E2=80=99s sysroot directory) during compilation, and the =
build
> should succeed without requiring any additional package installation
> on the system.
>
> Based on this, I think allowing users to extend some options via
> EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> However, this is just my personal thought and might not be entirely
> correct, so I=E2=80=99d like to hear your advice.
>


Although installing the GCC cross packages allows me to build perf
successfully, I still prefer to be able to pass additional Clang flags
via EXTRA_CLANG_FLAGS, as this approach feels more flexible to me.

I look forward to continuing the discussion on this topic.

Thanks,
hupu
