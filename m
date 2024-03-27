Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701F149C70
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Mar 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558342; cv=none; b=gVmNxfbp2gW5eUSFwkHxlVwZHsb9S9cSgCIYzppP9mXRaX3R/s9OzQ2wA3p0h3d52tLZdoM57ugsln7rj+pIqQEOd6hNnBPvn8wE5qxEi0uTi5vY5+3W0F9xTzzm9wjpNnzgG+uNa8BI4cmUL7SjdPon/plTDpmnbPBS7EwN6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558342; c=relaxed/simple;
	bh=LrCfNSBDukFLNgYLEGjQizxvDDmJ0B7JnUpqr1GNRtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FUqgVUKgn6JRFMXF3B+d39NTcKYrnLwHgJ0sQwxs1j3erfNmOSjnLjXOHuOooLYSICR867GiqfP5reFTp8kb0RAqvQYYLX1eMy3K34kxQYp5d27NDmMRa6y41Hh/aqJpDM/FuidKDuxcGYrexc5wRiCcIgZ/RJ6SUMaR/m3+nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAqcAbM7; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAqcAbM7"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3686ad91b9bso1395ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Mar 2024 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711558340; x=1712163140; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrCfNSBDukFLNgYLEGjQizxvDDmJ0B7JnUpqr1GNRtY=;
        b=TAqcAbM73SpUZyAQWK/R0528MDRO7ttE88fMmOZqr5727i3OAEEJ+xHseCnLk/bA2X
         yVEnYyc1L5IumV0cJ1ZtSTc0C0DL3Q3TX0m9K5i5u4HAs0EZZMM/k+T5uoKwcd9pBYj2
         5Al3IrUETC6uPQPSvi9SNaqZpktzesAuLG3wA3x2v429BRQ6uB6T8uspziEHZNQEi5Jr
         DYNELpHdccDZdU38jaWkuh00s1tcHJXmJcRnPGaWp8EJdof97ooCdU/oRoud99XA0xaD
         st8pJB3jhzWwH2Z+dvTwyo40ZcE7ZgxH0YGnP9+HfRO5pt9DdDN5jCNhVGZLdAFVNihk
         8MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558340; x=1712163140;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrCfNSBDukFLNgYLEGjQizxvDDmJ0B7JnUpqr1GNRtY=;
        b=lvCBtvRjS52LT4/rYIv2GJ3DLeGERM9O2HXGJqoydCcsPMPPrARIPawBST++RfRvKn
         YRtiUNdN/CyY1agZXCPRjZ1KMUmtoDQMqcU+S5B/q9uYDUHk/ugHxQK2Sz0TOwgJvH9o
         vxtIu4ieNUkLUDmHfo8TLCvxdQzAbjqteo6MbGyO8LdQ/uJhHvq2Gt/Q+0eA/OZPaYVD
         RossBBzxMvk2x3yqrldGD96s1AddbSPdRVqReBPVkYj3fsgZvbFTecUDX1X0262Kh7X4
         YbYLhiDan96D04UKM9FQQUCKu46qgBSfF+77EJiODmbL5ORtov3pvCJFg0ieU6cHXF+/
         TX4Q==
X-Gm-Message-State: AOJu0YzktI85gkox+fhlTEYUBSjwKhxOCjGPdtC+DgZIUo0A9c4oGeQA
	a2faVG4gfUEoAqnC9YOfNSk7lw927L7x+iLqb7Mnvks3+3HTM/yTQMvnv6CSUFo+dT+yWWD2+a8
	OfkL/EmGLys+0vhsltWWD25r28awTMUPg2oDB0vcs8UZtraKJ444v
X-Google-Smtp-Source: AGHT+IGwgtFhnIcEDJNjAot3s0m2xU5uBlGRncH0L/e1twl4sAtuHGGFajrw85T7atIWtUZE6Y5w8juuijw/+pXPCzA=
X-Received: by 2002:a05:6e02:1c22:b0:368:9ca6:3fc7 with SMTP id
 m2-20020a056e021c2200b003689ca63fc7mr239767ilh.10.1711558340184; Wed, 27 Mar
 2024 09:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWALQGhqNqh+hsEDZ9p1O3uS=0T4_hqx-fz_VNQF96Zzg@mail.gmail.com>
 <CAP-5=fVK2UV0s3hfo=G+TpsW7cW4WXndo+-OHVuCOYe0WWduhQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVK2UV0s3hfo=G+TpsW7cW4WXndo+-OHVuCOYe0WWduhQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 27 Mar 2024 09:52:06 -0700
Message-ID: <CAP-5=fVoU5Fq9=Dq8C39sLenr0kn5n1sNPKt4Cym30EUzcTc8Q@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2024
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 8:28=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi,
>
> A reminder/heads-up that the application period has now started and
> will end on April 2nd [1]. Thanks for all the interest we've had, it
> has exceeded everything we've had in the past! I'm really hoping all
> the interest becomes applications and all of those become projects.
> I'm excited for all the improvements that can come from the work.

A reminder that the application deadline is now less than a week away.

Thanks,
Ian

>
> [1] https://developers.google.com/open-source/gsoc/timeline
>
> On Wed, Feb 21, 2024 at 7:07=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Hi,
> >
> > I'm happy to say that the Linux Foundation has once again been
> > successfully chosen as an organization for Google Summer-of-Code
> > (GSoC) 2024. This means we're looking for contributors to do work and
> > get paid as part of the Google Summer-of-Code program!
> >
> > A full timeline is here:
> > https://developers.google.com/open-source/gsoc/timeline
> > We're in the part, "Potential GSoC contributors discuss application
> > ideas with mentoring organizations".
> >
> > Project ideas and more information here:
> > https://wiki.linuxfoundation.org/gsoc/2024-gsoc-perf
> >
> > Please help spread the word, volunteer to help out. etc.
> >
> > Thanks,
> > Ian
