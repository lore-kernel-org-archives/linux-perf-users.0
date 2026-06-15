Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C7413244
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543274; cv=pass; b=PkAZ48jDI3+W+Sli8o3ntC0HzDr3QupsjVe4xoH6raIiFcalFtuHEXIaS9vnf0uJQiVVgWXCW7Nyut1hk/nxWNIBtK7xIOfAKDwiSW37rO3WlsjE1T0fIYBWXU2oFZPbiGbaEV86ST4SveBi9wHqdkjTtRJQ0VGSoaMQrGzAsWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543274; c=relaxed/simple;
	bh=uyHTpv9x/511NFkX4ebkZfkyta8ajwNXaZ/f+kw3gtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6o+cxVNURKLq/eCmcs7gmndVIF6ir4E26oqj3WNylWyt5YTn9EST9xRychFVxFOz3wOKWbCPsRfV3BLopTiXN66nSsm32AxFGMlSN+v5yfqwsBCHP3nR4tXlsmkURcZTPR6YEsj2GZuFg6OMRb8bfehzprs77/ipafTtlRssGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCNAmf1I; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCNAmf1I"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf22c18ad3so2815ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543273; cv=none;
        d=google.com; s=arc-20240605;
        b=Xc99wTRNxbbrcEgSoA+pI+lR68jhKKH1xFsN70W0c4+T9dGLG1XUBt73YSoIOTE6/M
         wqtZM5CGFPdB5ZiAQj0jWPCbeOtafsQapCJRBusiX6Sdlaqb83Xbc6NpqyerQ0n/jGvI
         EcjcwGRoWWLXoHGXSFBa8pLmqMCiAd6NOTmsYScSDf3Ovb6wprPqJnJ9+xuIXj6RM0lH
         adSWtMVN0D1d8ScpC1Ls3zShMvrTHXIfD2fzX4FDl84+EAp+fjNHz6vdf/W82F6Ikh73
         LIDOSnwc5dgPbdUHenXiKVE2mXRxdzRyL15378YmW16qTXgZ4ZbxQMfmOxvi0Gsi+pmJ
         Ex5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ryAGj+3hWQJdQU0sOYweKJig4mk0j87EmhDxe1wrH4=;
        fh=Tos7dR4CxRG6j/KW4FA3X96iemuHygLWt/z9MExqnhM=;
        b=kyem7qNSliLHxYcK14sZe1NclhtWw+SCZdHnq73ix4SZ2AjaaxW06+DLkd62c7FLiX
         fFKLBA3s9sT4iKrO2aeol/YM4tcqtuRr9RFVAsHIr44ZbPhM6rwuqB9fcGr4tTH3ItaV
         xEUIvsH65t7r3sK6OpnbiN7iIiuDTUvYaCJsbyer5hTwa2g38j2klJXW3OZT/z5Cy7xs
         UQ+h/1j81cSV5RdRc3OnKhrfvHdtk//9iDbOcy07sMBdYk8bbieSt7CKDCMflM9QpGDs
         CtPGWQyk3tsEX6tag1Mug6SiZmFOBTxgXHgDKWtGzOcyR5ag5/WgVO5+4NcUjq6mqYrO
         NDdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543273; x=1782148073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ryAGj+3hWQJdQU0sOYweKJig4mk0j87EmhDxe1wrH4=;
        b=bCNAmf1Igd5vabPmjQzNRl3UIW3iSyazkNcjOkoKZI09lEVnIQvuD1b8T7tSQFfiG0
         fDduJoIgk7d2giTVjnO8QE2asSEwb49y4WsPhlZA78wzuRFyh52ZuPTuqXtfVNs4hbL8
         WUM/tbLUaZyaMdgWfrQWZ3BY1nQzQwJCSqVNJKPxM82oZm2ywRY9/o+TuYunoJVnEIid
         CcdIrKIoQFu/V7wsnau7gNh4f4zqQ+xUrk/CQEBP6vN70I9W3W9PVvKCHT5pPLnyA7k9
         bNvr6G/nlPiBY0klxaHXcgViu6CEP1Ogxe1af9huHdAHCpAgU0FfGO9rVAm/NolImC63
         b26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543273; x=1782148073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ryAGj+3hWQJdQU0sOYweKJig4mk0j87EmhDxe1wrH4=;
        b=Aj0J6FmI0iYroR31tbBT20G9qz2urgbK8TRA8Vy5VTI7Ob7vaLy7kgZKDRLOvD9qsd
         +txWmx8N5EM1HrNKaLGihaSq0KNW5cx1DohI5vA74joPMUEWOB5KgRdQxiNMrr42Pes0
         56oL9I12UMWGRnOrZcAp1bdaEEvBIynrSq11vngMKIVwYx7/KIOwjsoPHxM3rD4STwsm
         zIc4oj6yw66aBpVjvljjAmvXLQEy+Gng3iyPxGr+PpMPYmiVEk3x3W+C95uChz4qx4X6
         +50h6kgg/lWxrI2B10PW2CHIL9f6dN2ldDTBzcNfsHJpAAdNxdNbLjPYCAsz8QqXIPEj
         xs2w==
X-Forwarded-Encrypted: i=1; AFNElJ/ldDugf53k5FUirzC2rkKoT+Px2IkYIF7cdK+LwlmvEcCNZT4W49ZXNfOh/l7bCnroYk1uC+9vuktqEjLfEpim@vger.kernel.org
X-Gm-Message-State: AOJu0YxrV4xZKR2yl8r5AOek186T0ynh1tRt7sIDsyjFEyXwu1hhRdOm
	5IaffYUBqFJMYYIo5J/fXOVCdcCB1hlAOnYWIE3gYARDhDb3SnSMdMip+UO2NrhViWZM6KclkTZ
	GTLUuwygG4dSOVuPFGh3BP4qoROPpKUFLGdd+fPHc
X-Gm-Gg: Acq92OGDcK6R2MukIddSksleOJETFuTTUuOzGzg6r1CsApxA71aqwWQd2QW5kze2f3L
	2MEsu9c6Ta3V3Flni6fLvv1iYNZHqpDbfbUUK7d6NEkVxia7TCExqdLcAwHeSvSnkJ9iNEcFj4Q
	0wIqO8DYD/2ghrSkjT5NwONyv79xINU5qng2y+u7hyHbkqqHRjAJhiAqDouvqPyitMC+Nqe0+xV
	uh9/MuYDpuhZkv636bZ0uoo7TQPjD8Y+JzS7QBBerPijQMgUfNXvhldZH/3p6A9oZFdEI1x0N3n
	sXPcFwwPxHP5th8LTp0tqlmE8xjBasXM+VxcQlU+WYU+bu0=
X-Received: by 2002:a17:902:ef4d:b0:2ba:73c3:49b0 with SMTP id
 d9443c01a7336-2c69a298bd6mr49885ad.14.1781543272217; Mon, 15 Jun 2026
 10:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-3-acme@kernel.org>
In-Reply-To: <20260612222413.40791-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:07:39 -0700
X-Gm-Features: AVVi8Cd_FeP9FdoV8IvKSNuyUat5UVeMig-0xSHFEMm4frJo2OYLppGxvyoz1E0
Message-ID: <CAP-5=fUPjAcFW0gBZiBgaFDTvc+uQOMxvXj_j4wwUPX5Qua1AA@mail.gmail.com>
Subject: Re: [PATCH 02/13] perf symbols: Validate p_filesz before use in filename__read_build_id()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> filename__read_build_id() stores ELF p_filesz in a ssize_t variable.
> A crafted 32-bit ELF with p_filesz =3D 0xFFFFFFFF produces ssize_t value
> -1.  The comparison `p_filesz > buf_size` evaluates false because signed
> -1 is less than any non-negative buf_size, so the realloc is skipped and
> buf remains NULL.
>
> The subsequent read(fd, NULL, -1) returns -1, which equals p_filesz,
> passing the error check.  read_build_id() then dereferences the NULL
> buffer.
>
> Add an explicit check for p_filesz <=3D 0 before using the value,
> catching both zero-length and sign-wrapped negative sizes from crafted
> ELF files.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: ba0b7081f7a521d7 ("perf symbol-minimal: Fix ehdr reading in filena=
me__read_build_id")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/symbol-minimal.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index f4b0a711a62cf3de..0a71d146395271a6 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -186,6 +186,9 @@ int filename__read_build_id(const char *filename, str=
uct build_id *bid)
>                         continue;
>
>                 p_filesz =3D elf32 ? hdrs.phdr32[i].p_filesz : hdrs.phdr6=
4[i].p_filesz;
> +               /* ssize_t can go negative with crafted ELF p_filesz valu=
es */
> +               if (p_filesz <=3D 0)
> +                       continue;
>                 if (p_filesz > buf_size) {
>                         void *tmp;
>
> --
> 2.54.0
>
