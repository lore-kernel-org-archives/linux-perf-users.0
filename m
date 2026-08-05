Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953AD3C5DCD
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955908; cv=pass; b=urNrO3vDludwnyjdOyc8p9fCLcqi7Ki9eh2Lg1SBu+5BwLr0ql38kKiew/DJxduWgfOAM+CPmliij/UUwj1SwhG2u6ZRjwQQx7VCcC1dEYu4IP78FV/pVb/HL/vly+3BQc+sK8kEjDW4Y5Dw5Rnbs4QEDUTd0lSXpJ/GJ+FxXIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955908; c=relaxed/simple;
	bh=UBQB8lazqd7k7sHbxSjCyBkFUZzmlO+rkvuiN843uvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tix5AtJRm5OgzMxqiwEpcNk1rwWiqxjgzphUCwp7i90mmSThlcMXUHXjziCe/ZWDJxHS6oVnrFIVPtFbHrnJfTe3o2Fh68bFuPKKFalZPxkS7pIBYFlZ1VquC8p4MXm+4OnO9i79fE0qWdpkx6OUk1i8HHT3W+AG+k/JYvTqU4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dy5wzFdl; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dy5wzFdl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c01c79467so49731cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 11:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785955906; cv=none;
        d=google.com; s=arc-20260327;
        b=HDtkyiUPxeTmPA/imEHcKaVby9+1nA1z/2YpW8mWoc3KTS6hGI8ybXAlwqe6NcQm4h
         bSNUX8XZRozssrpB34Qg4KvaOqzFgm2YceouIeLTgKAxu7bdCTbisy15JuQkIEOvLFZs
         Ho9vHTnFV8UH0ldkgazyA5vJpxz5QFbuySKSn8JK4QAZlNZLgOgrlLl7CQhpenKnvlZG
         UMZxXiggaZYngujtq3gf47MYUyqb0qff9JAYwu9V3uCS1BPWgYJVQdopECnwbbtVDQbA
         r6f0+AUzTjhtU6ATaD6z7l0/AA0H5BEV4tWEC44aolZ/sOZ1177XJa8YwfyiGiMZiPdq
         e15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pIFkjv1N5ewUvrjXMwzuAVifAI0srKVRbKjpXTo7o4=;
        fh=CDfzapmWOiWjPKze8KSnfY33YSEuQd/0B436pwucLFU=;
        b=jWbDxGoiciF3UIqb/XaJzU94HxmCjTogJ1IlWHDBxFtb2SKs/osndlSxpX/2t24aQN
         PRAV80SHo5GRsngRRISaXKpaSsIZqT3Kr+cGppgPn0uV5G14//+4T/MbVM45pndAycZR
         QqKJX/JtHBmKA+WIj+do4qotemr+dS4EAEuAbmlOMWbe9hAuK9JC3E6IFJa7KWqKZEjp
         xygNGxulJSiW4rgpRKWPjsua2z0MwlvSXuasX7B4m77i3AXuR8OUdW1WRTdhd52zPK4o
         xQxPs16z5ypjrnbaCBegDUf4lQIdId86+cCdUS3c7iME4UmhKABeA6DozPRW1txYs4tr
         3y6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785955906; x=1786560706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6pIFkjv1N5ewUvrjXMwzuAVifAI0srKVRbKjpXTo7o4=;
        b=dy5wzFdlSdTM9I2WHXGoY25VSPTYjtIqHGnL8O0wFVgcttTQ6dsKlrzdhWwGsrSDTz
         e5ynKcY8UFN8gZCbYTTREQ9ij23Y6wVZyFxhINR4lSnM8Deq5jG13FaQ7eRMv2IFT2Nb
         RZw6rdgmkRgltJ846CpbuG2eFzHgU/Go7tm5R5d1S0G3lIuRSgljVOVRN1F5tSiVxT+p
         qArlgAEJfu/JQ1yqDqIOIl4DBEmBiDgnRcGrCGBIZOIFM17HoiSEXdk1iFpt4KFy/2XR
         d7GTfNeRUK46OibtREItLVi6jGHr6evna4CMVIdqS2ngNsYc5LUSk6jAiVD4OAHZcYga
         /xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955906; x=1786560706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pIFkjv1N5ewUvrjXMwzuAVifAI0srKVRbKjpXTo7o4=;
        b=AeY5lLLh+EUNYIajsj0SfwxLyDkxLGk+gxHPa8atJZE0khx79CfempINpYcpwrEXax
         BfiGqd4d1m0NpqlGyTmuF5ZyfjW8EOMgjQT3Sd6Vp/R9dPfvw/Naz+6/cauDKWS2C4dI
         fzTcb2KpR1kPQYfMOt4wpu4H7O87dvBz4Dk4/ogvDJl/M3fZcgFYXwEuY55TRX9gokyX
         10tzEixH64gZohUYCbLpCPCN+OUy/R2bMRMg11EaIUa2XD5ARBXDhXgl4noSNX6/R5kn
         EnuSIrMvGhGDQD6CjIWTs1j84dSukftiPD0o1ZvGAIjwKGrh2kLnORvPPn6sA4itfB+H
         HQtA==
X-Forwarded-Encrypted: i=1; AHgh+RqGvY55Mj6MoWkIF6+xHKSCvv2xJ4PRDVquNvrwtD4l2Vs4UrLql7BIQDn7CuKUTj2wNZVldrZk0HEuFo3D5pBL@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRUaK/ZhWS9RI6rQsZIVCha0sGjoIKm7zfIh3lChKazsHo4CT
	J+w5uuF4Rz8oRaz9+Fqqa7cVl1Kmrc+c1UR5f3O5z2ezcSh9RHvU8O1+X2vR8eAHvanLqUPqGHA
	o6hLEUiquuWbT9tDhF32URnI2XcDsoemZfYLpATtL
X-Gm-Gg: AR+sD13q7HqpyzBWBj+tlqESkEjkHr1MtFK8SKMrvFmYtcpR6+4nJpJfT0fKMsmxDpZ
	rs7iT5J3TB3cZ+KMqW6gKxuM4M/daMUiFa+t9UsTOfr0RZ42lhR10FSNKP28WZzKUWmBnG4YL+6
	bzo6D1r7KIc+Mwlggs4hVugv3fMMYEk0x6YgfNeToCZf+ie9lZ2+6AaHOYvO70tsWDbjHwcaIbX
	thlsLxctwK/JUY4HdCNxOzD8++joG0afpGtW/hjQpUzsGK34dmkT88lWdVn8YtUqgP/PjzzrHV9
	PcPBLoIjoPofc9KP0Wk+kNmLl096W1aAH9cQxDbqMXQt4A==
X-Received: by 2002:ac8:5e4e:0:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52cfc15bad6mr2577571cf.13.1785955905660; Wed, 05 Aug 2026
 11:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-2-acme@kernel.org>
In-Reply-To: <20260805133013.235016-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 11:51:33 -0700
X-Gm-Features: AUfX_mznKeDGpEQ9en9wF6nFihCMxxOYkojT5XAsDyYi3if6d903zQPlJ4q0V-4
Message-ID: <CAP-5=fW6CkQSM5HRWROMZr0NPR8cSP+EVnHsSQ5NLh_zoFjYfg@mail.gmail.com>
Subject: Re: [PATCH 01/12] perf jitdump: Fix extended header read that always fails
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_open() sets bsz =3D bs before the fread() that uses bs - bsz as the
> read size, making the expression always evaluate to zero.  fread() with
> size 0 returns 0, which triggers the ret !=3D 1 error path =E2=80=94 so e=
xtended
> jitdump headers (total_size > sizeof(header)) have been silently broken
> since the original implementation.
>
> Additionally, when 0 < bs <=3D bsz the if (bs > bsz) block is skipped
> entirely, leaving extended header bytes unread in the stream.  Subsequent
> jit_get_next_entry() calls then parse those leftover bytes as a
> jr_prefix, corrupting the record stream.
>
> Fix by separating the buffer growth from the read: realloc only when
> bs > bsz, then unconditionally fread bs bytes when bs > 0.
>
> Fixes: 9b07e27f88b9cd78 ("perf inject: Add jitdump mmap injection support=
")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 83005b30b9bf3fd7..4b7c7ba7cd95ddbb 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -224,10 +224,12 @@ jit_open(struct jit_buf_desc *jd, const char *name)
>                 n =3D realloc(buf, bs);
>                 if (!n)
>                         goto error;
> -               bsz =3D bs;
>                 buf =3D n;
> -               /* read extra we do not know about */
> -               ret =3D fread(buf, bs - bsz, 1, jd->in);
> +               bsz =3D bs;
> +       }
> +       if (bs > 0) {
> +               /* consume extended header bytes from the stream */
> +               ret =3D fread(buf, bs, 1, jd->in);
>                 if (ret !=3D 1)
>                         goto error;
>         }
> --
> 2.55.0
>
