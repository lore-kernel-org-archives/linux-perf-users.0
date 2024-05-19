Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0379FC0E
	for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716159666; cv=none; b=OoueLP7VxwjLNf/I1KFRiGXtvq1GRqKFQ/F7aiLcXDKqHZ8sxtq6VxlIVg7lapKnhgvyEGD0xEaoQh3oU3JD2enAFnNIudTzcH/Q6C+70MAVqgaVTDBpJ4F5a7ddok4x02P6SsSvsTGo704ro4tDPhdm9RvbibOHkC4ohnwLANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716159666; c=relaxed/simple;
	bh=ho1U+M+/SGKXCmr0Jp3HXiCcni35a30OfnM/31BV0dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndIQEMUZaUNbC2jtUQ1rtGCjYAvSwS3WQFsLMZgmlR5m3ExFLKRWwJZ2joi6KP4KXVEEqbpNEj/1jSO9Z7TE9VjRwOn5NB/Zpx0IaSVVcRHEEnur9hYmcuUM/KjqYfPfmHyxUUy/4C/8fslYozZnFUvPBiu8fuIH1jXmd0aiT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8/UEu9T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8/UEu9T"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso116855ad.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 16:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716159663; x=1716764463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T2sk0zUifZrkf16bKv1srjvtZVOWyPlOZal3CJeJAY=;
        b=b8/UEu9T5DCQwfiPpf+MimFMLG5PgTepH0diyfLvc1snZzgCL754bSfOr4x1U/rqRY
         k4PH1KnNcK4GuQcIMRwicGS1yhEzUIS0Jd70TR1a714pamdTa8z8Re+GCXq/CdlmJYPG
         kN8DnJ1RUykHBStRK1lpCNusNQD1d+z9qUULsAVZJciGFXOw0aznNbqM+y8poTN96/nr
         oGM8ELy3dSyaMv3a2q69L+uvLq/GW9nkjvpvBdhR1UVmOsakSrSnvhLKpHHOPUjY0df+
         0ZG8xYpfF5gxsQpmw305BUpu9/lovgpIJBLXoZ0ZP4ux/FoG9dmbqzrnjSm4fhCmA8lo
         qV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716159663; x=1716764463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T2sk0zUifZrkf16bKv1srjvtZVOWyPlOZal3CJeJAY=;
        b=KhRcfs+hT5y3W2UtRPLjDmFw/VDiW9QVQrRF1taXgGLPYzo2RUUAAz5UXBJuUhv0Yu
         XRPq6dJYNVOaBpMRM6wf9D0wTcUX2hfPnFrD04/ois7QKLo3s0kd62B2+VsDWVN5fT+w
         u8QpyYCXRN2yDk3g4+inEPF63BWIznu1cHrCsmY1yO/QZcgEMocjELwv2G9AkqvKtXix
         lDjO1VJSaUs3ub80gYIevrnpiZFPyLY4NokAJWQwUNOXmMVWMaL8Z4/irQls2XRD1qnT
         MriGKwZhKnNiXPFXymCR2/Z+2a2E6z5cL6570f7Fxr3HcfQ+LKgeTer31uiXUQa29O8h
         wtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXff/lUyP/m3xq2z34hGH03CJ073lTq9KwfhyGQZhiT7cpQqGEls0j9l9hueBQKQgmYLiMJv8J8O2+i54EYVoBDonq/A1k5S5A3wepGZ/zJMQ==
X-Gm-Message-State: AOJu0YzAtM8FYBb3ftxBjp+aH4JBhQnrjV7SPBydm39MrzAUADMVeVX2
	eZfYpk5qPJ98yLv8LgWDnBjbnDKc8ggxAfwrY8NptCZKlXDDM3YWOMr8/L8VrJOjElg21iqI48X
	J/yKVRs/arhc2T9xoW6X479XRaqC4ozwJIverU4VBp6EbRBdc4w==
X-Google-Smtp-Source: AGHT+IEdkAdka9vpjvtaC0wh0z5o+xjxTsSuFpdHlphp4TlD/UT1+nt08SkIxRJcG/B6LnRDtJK2UhjIBc1osOgzwDo=
X-Received: by 2002:a17:902:ba8d:b0:1eb:59c4:4fc4 with SMTP id
 d9443c01a7336-1f2ecbb175bmr2401905ad.10.1716159662758; Sun, 19 May 2024
 16:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518165335.3963530-1-sesse@google.com> <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>
 <ZkpokaHRfQYCo3uG@google.com>
In-Reply-To: <ZkpokaHRfQYCo3uG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 May 2024 16:00:27 -0700
Message-ID: <CAP-5=fVYbewBtC0-GBKFUQq_gaGUMdZenCRyh3cyP4ff7yuqCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf report: Support LLVM for addr2line()
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 2:01=E2=80=AFPM Steinar H. Gunderson <sesse@google.=
com> wrote:
>
> On Sun, May 19, 2024 at 11:23:26AM -0700, Ian Rogers wrote:
> > I think we might want to display this in the feature list during the bu=
ild:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/Makefile.feature?h=3Dperf-tools-next#n123
>
> Ack.
>
> > s/HAVE_LIBLLVM_SUPPORT/HAVE_LLVM_SUPPORT/
>
> Ack.
>
> >> +#pragma GCC diagnostic push
> >> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LL=
VM 14. */
> > nit: pehaps disabling this should be conditional:
> > #if LLVM_VERSION_MAJOR =3D=3D 14
>
> It doesn't seem LLVM_VERSION_MAJOR is defined yet at this point, so I
> don't think that would work. (I just checked; 15 has the same issue.)
> In any case, I think it would be just more clutter for dubious gain.
>
> >> +       if (file) {
> >> +               if (line_info.FileName =3D=3D "<invalid>") {
> >> +                       /* Match the convention of libbfd. */
> >> +                       *file =3D nullptr;
> > Should "*file" be cleared if "!file" so the caller can reliably free it=
?
>
> I don't understand. If =E2=80=9C!file=E2=80=9D, then file =3D=3D NULL and=
 surely accessing
> *file would mean a crash?

You're right, sorry. Thanks,
Ian

> /* Steinar */
