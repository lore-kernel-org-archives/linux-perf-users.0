Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD64DF53
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435321; cv=none; b=IrFB/6PTcnc13FdoLH8a3LBrMZtgmNGyVDqvew4FSOx9p9yAO5eUKRXQ3ZgnOpMKRA8ufb964Y8k8aQDZYd49GqIhelGxqUYEHSvXBAdZE9HieH0FWuGc9W9bVaUtQYXaCybfjwdzkJ/sxImINfbk5/LAqP3wjwW00Tc+WCfeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435321; c=relaxed/simple;
	bh=0oWET50ReYVFiUV39cnYiJFH1L/O2I+HkRr5gstNEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpllognMcrF3QVoUGmSWrMMZtNmlWm8NFiOcSxXpCLeiHp0pEVmo3n0exBOVmTRoPkWFFSc3rFpiV+bqSCUunHRBol4aLj3r2+0ETKyCavr93hvJi8C8S4wO1mQyxxTBqTlqIypAxMfgx6m/jhPDgzI/7486l9M6nqar/cXk4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbCz/o76; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbCz/o76"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36646d1c2b7so1635ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710435319; x=1711040119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5dW0gMuORo7rcnXCPfAPRP+bphbtCW0qVhM/Z5OPHY=;
        b=fbCz/o76htBOISV2x6yRakdhz2zQOhjVWb0h5CM2AnAa3DQqQYFYv/ljnSnyq79mfx
         5P72SsUoQE7EMh9l/EC5GgEKtjJpmamwwB+dTBnY7CeHWF8opVJq8HQHE5eiKJkIw/3R
         0+9A1RaAZ1Cvg6S4/kLfspmo23BCSJsow+AdmmFFm6XtK1hA4IxN9Hx7m7g6cKEP1dUx
         ileBIUKCW9wo0qMY2JnYBv8qI0FWgATRN2cHFf7F33JgvzyBj/QiwiRObZiaofX+kZ6u
         nXISnWkiEj4ImWkSuzwjc9RTBapxTY0sNckiapDxcLDGtkK0KNv88q5hxgvk0i2kLjZo
         Bcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435319; x=1711040119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5dW0gMuORo7rcnXCPfAPRP+bphbtCW0qVhM/Z5OPHY=;
        b=bQ+RYW5wLtsxOCregh5L4pQ/rZ89nOu0ErFCfvHFJnTIXGitXPbR3RAj0Smu2LFGFK
         Fp3EcaSGX/+Ryoooy5XxT8J0B8H7UW/Hwxv9r8oIJM/Wnr6ugqIhGMZDoVe1vSTpxwBb
         xD5QU3yYSp22DKD3p6ieQemPKpctKEUyVSwnIVknz/sPHAIOJcZ3Jqy/WXj3Hi4tfFU2
         S/7qPzRPJrTIBnan1AemCItw5dbEERvYzK5mpNGJCKlqCriTS0PUJT94d/Ok/Lp7tbHp
         WmS+T8520B+srYfmEocXI2uw9pgavI8Bd/x63JR6z02dQ3QGq+/RvdpuOFanQaLI+F+V
         iKKA==
X-Forwarded-Encrypted: i=1; AJvYcCXhf36OMmKaYn//bmP8CzGazJ0wXRmFXnfb1CT0AXeg4k82wjNptU/L+Ko8ZgdIxDSx3FlLM2GOjbjFXCO3QvEzunCMeImyMnf1BL2ObbPRmA==
X-Gm-Message-State: AOJu0YzamVWVPsT4635r5SKM/YenwyxmuXPGJAdtSE7YgWM4niznliYj
	jNsHh/p6TkbYz5WVtHmipF518DWLXd9ZO/Xm5qqL9GnoN1f/WC3qRZxa3SRmcDDQk5P/ETXoUZr
	PmtjuPxH08+0jK31WyDxRWGfSFT1yy8ZE6JPm
X-Google-Smtp-Source: AGHT+IGKatndCxMi834h/dlO/DC03asvOPVr9HAIlJRDGJOBaCq6kQ0C1aOMQZbfhFiIDxZzgJGPup9P3JwtQy2vn8I=
X-Received: by 2002:a05:6e02:74a:b0:366:27e0:3436 with SMTP id
 x10-20020a056e02074a00b0036627e03436mr289316ils.15.1710435319075; Thu, 14 Mar
 2024 09:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314144320.743217-1-acme@kernel.org> <CAP-5=fX=UmW2iAQNfYcBG89Bv9LmLUtSmPOOH+3LN=r396sO1g@mail.gmail.com>
 <CA+JHD93osaLDZurWep=ie5Rnshk-T8i8ZnLrneVfeQ6eNAaKJA@mail.gmail.com>
In-Reply-To: <CA+JHD93osaLDZurWep=ie5Rnshk-T8i8ZnLrneVfeQ6eNAaKJA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Mar 2024 09:55:04 -0700
Message-ID: <CAP-5=fUzj7CFstDH-4=_wRFaib8sbuQ1vothgfUB7R2Ei=6ovQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Move some more header copies to tools/perf/trace/beauty/
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:46=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Thu, Mar 14, 2024, 12:00 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Mar 14, 2024 at 7:43=E2=80=AFAM Arnaldo Carvalho de Melo
>> <acme@kernel.org> wrote:
>> >
>> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> >
>> > Hi,
>> >
>> >         Move a few more files that is used just by scrappers.
>>
>> Thanks Arnaldo! A nit, could you change s/scrapp/scrap/g in the commit
>> messages - scrapping is throwing away, you mean scraping :-)
>
>
> Sure, learned the difference an extra p makes :-)
>
> Can I take this as an acked-by?

Yep.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo
>
>>
>> Ian
>>
>> > - Arnaldo
>> >
>> > Arnaldo Carvalho de Melo (3):
>> >   perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the director=
y
>> >     used to build perf
>> >   perf beauty: Move uapi/sound/asound.h copy out of the directory used
>> >     to build perf
>> >   perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the
>> >     directory used to build perf
>> >
>> >  tools/perf/Makefile.perf                      | 19 +++++++++++-------=
-
>> >  tools/perf/check-headers.sh                   |  6 +++---
>> >  .../arch/x86/include/asm/irq_vectors.h        |  0
>> >  .../beauty}/include/uapi/linux/usbdevice_fs.h |  0
>> >  .../trace/beauty}/include/uapi/sound/asound.h |  0
>> >  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh    |  4 ++--
>> >  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh    |  4 ++--
>> >  .../beauty/tracepoints/x86_irq_vectors.sh     |  6 +++---
>> >  tools/perf/trace/beauty/usbdevfs_ioctl.sh     |  6 +++---
>> >  9 files changed, 24 insertions(+), 21 deletions(-)
>> >  rename tools/{ =3D> perf/trace/beauty}/arch/x86/include/asm/irq_vecto=
rs.h (100%)
>> >  rename tools/{ =3D> perf/trace/beauty}/include/uapi/linux/usbdevice_f=
s.h (100%)
>> >  rename tools/{ =3D> perf/trace/beauty}/include/uapi/sound/asound.h (1=
00%)
>> >
>> > --
>> > 2.43.2
>> >
