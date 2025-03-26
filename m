Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97D24EA8B;
	Wed, 26 Mar 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013826; cv=none; b=P9YLqPjvNfxKiGy+lAKzhH6LTtS1vCB5qRaq2u/emUOjgyWFJKRJyz8BEPkumybtibXTfS1kA83et/OKv8s4xQ5jZ2Z7hCUg9OhjJsHi/Tl04F5xHBr61vdL5z0YMtRvFdb2npBawLSxUk2y1WQsrzNAJE4/V8RHwcN3sgooQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013826; c=relaxed/simple;
	bh=YYt6gJMffULnt4QDShgCB06vVikqmoye837uD5CHh8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bU1ebJIm3ooax0uQg6HiszNqc9BDLQouGa5NkJvjcs5lKUkPL+T2K3EYN4Mpy7n0qmlW8Lhxig0w8J4rg9uEZ2QzQoUrJkkUOnM+1dOWNi6zdiAHVLArI6PKmpkBJROmqr/q2fp2JIMyRH8tz+/6v4O6CqXrPMibh+DWHE1lvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijv/CK89; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijv/CK89"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e6582542952so157938276.3;
        Wed, 26 Mar 2025 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743013824; x=1743618624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSo75ysSYfpqVeAiF/C0jwrxlqsNzz3MNPDa+DBosDk=;
        b=ijv/CK89pNdhXWZFOejFIVVAjVN6JDGPow57kbwiG2K0cGHYB6F5yEpmUm+aVhKZ7v
         1HVgsSiTXvhd8JXfs9UP8LGAgbMPlu6gc9nL3VWQUY91ho2EeZUHcPYWmIhORjrNklHb
         bSipbvjYgeYfYi4hWG2qz10V5wF9qgGD/bcbdZ2A9KnZJBcW3dPmsweZrz5NY379sV7Z
         Yb9vy3+T6UBwxVKkeOD+x7DHsTX4ZJvLLtuN06dagut8Tkjka/3aetFx8FgUCJSVyb2L
         yshieuanjDzrgi6m2LK+vyhBbwCjmjuwIrcUxuZV/oMogu/YczsFCUJjTTWZJ8biJo9J
         TBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013824; x=1743618624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSo75ysSYfpqVeAiF/C0jwrxlqsNzz3MNPDa+DBosDk=;
        b=MdfwIv2t+ghho48aaaUO8MrJIBGRuOOQ/NLr9ST9R8gLAjAnVczXqtpLHpp93eYOdU
         UK9E+dr1RQRreifcN90+TZZECCOt0R0K9AlLhUJZYNVq6eUFSmuKUXkE1g2WBLqtHOfv
         Ar1rph4mshjKuorms1VK2ostGw17e3huGT6ltP8t8GFW90UcRyUuLxNg84UW6L13kE7x
         aRXdHQpqRZ7+ymB1EzFzX/bhb3mxKO/sOTc+DpMrkV5tGCrUqW9flwYzaeYvoSZyigN/
         +jBJvltbH4bYqbVAoKLnoiImAV5+usbiZmf0b6PWwc4HIjbL6T7uICDQtcX+gfxn4kjp
         eHTA==
X-Forwarded-Encrypted: i=1; AJvYcCVnF8s5SsFn2++9dHDqLrR1h9ie+mBjlm0JeTNDcUA1GdaGDK2EkmsccVUyzaCMMiCruXSOmQrn4ruZPjEolQPk1A==@vger.kernel.org, AJvYcCXRsaX1siePhKSJKE8gigYZP4QpqQxSSosOtM5MnNLvB2qBNG1gbEDDrs7ROKemn0x87S6IUYZb8p4sRcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9NKuFKYH/cDc1ddYxojjyXy1qDWiMf3E46W9JlVszsYv9F6nV
	8lHYma7aJxhmuJiCsNxEDwt2Pa5MCRSa2kS1E8Lhd/wI0fQvJPYWOdl5IJCvRUsW1RZFP7XlXBY
	mcX1bDzyVuUipfp7Buaoe5qZYPYs=
X-Gm-Gg: ASbGncutUMh+zwR/WeHDeCL2PbVXNIqyUAWsymNHXTEqg8iNbGagWPCW5d38EunxUOK
	f7KhmRQGziYUPBOXimDDT/GLr2jM1evoALUMZOnVEoiWDbW1n58LJjZVilLhnFUVEQalbwSYmkZ
	CzszXC9xvTCZTXY67zjIfDCB3a
X-Google-Smtp-Source: AGHT+IEzCosq3qsKQupSo2wD7I8cFb64KsFmE0stNqv7unOq7R9lALuGlVPhJ0bnf6cH3rAD1JLXly/IzfATFg43PPI=
X-Received: by 2002:a05:6902:2509:b0:e5b:3de2:ce95 with SMTP id
 3f1490d57ef6-e694350955emr889046276.9.1743013822119; Wed, 26 Mar 2025
 11:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324235245.613063-1-howardchu95@gmail.com> <Z-RFu_PLmKMq8YFU@google.com>
In-Reply-To: <Z-RFu_PLmKMq8YFU@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Mar 2025 11:30:11 -0700
X-Gm-Features: AQ5f1Jqylku7SJA6ma0x5MrUSl63xzrXcR7ONHw0NZgO5gKcAmaqGEA-ylamBoM
Message-ID: <CAH0uvoi-uxLNOoZ8P1g--jBZUnax_1vCu42SjFCNS7mdAH6Ozg@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix possible insufficient allocation of
 argument formats
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

LGTM. This is better. :)

Thanks,
Howard

On Wed, Mar 26, 2025 at 11:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Mar 24, 2025 at 04:52:45PM -0700, Howard Chu wrote:
> > In my previous fix of runtime error(Link:
> > https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howard=
chu95@gmail.com/),
> > I made a mistake of decrementing one unconditionally, regardless of
> > whether an extra 'syscall_nr' or 'nr' field was present in
> > libtraceevent's tp_format. This may cause perf trace to allocate one
> > fewer arg_fmt entry than needed for the accurate representation of sysc=
all
> > arguments.
> >
> > This patch corrects the mistake by checking the presence of'syscall_nr'=
 or
> > 'nr', and adjusting the length of arg_fmt[] accordingly.
>
> Thanks for the fix.  I've noticed this too but I feel like we can make
> syscall__alloc_arg_fmts() a bit simpler.
>
> How about this?
>
> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6ac51925ea4249c2..b9bdab52f5801c3a 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *=
sc, int nr_args)
>  {
>         int idx;
>
> -       if (nr_args =3D=3D RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr=
_args !=3D 0)
> -               nr_args =3D sc->fmt->nr_args;
> -
>         sc->arg_fmt =3D calloc(nr_args, sizeof(*sc->arg_fmt));
>         if (sc->arg_fmt =3D=3D NULL)
>                 return -1;
> @@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *=
sc, int nr_args)
>                         sc->arg_fmt[idx] =3D sc->fmt->arg[idx];
>         }
>
> -       sc->nr_args =3D nr_args;
>         return 0;
>  }
>
> @@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, =
struct trace *trace)
>                 return err;
>         }
>
> -       /*
> -        * The tracepoint format contains __syscall_nr field, so it's one=
 more
> -        * than the actual number of syscall arguments.
> -        */
> -       if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields -=
 1))
> -               return -ENOMEM;
> -
>         sc->args =3D sc->tp_format->format.fields;
> +       sc->nr_args =3D sc->tp_format->format.nr_fields;
> +
>         /*
>          * We need to check and discard the first variable '__syscall_nr'
>          * or 'nr' that mean the syscall number. It is needless here.
> @@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, s=
truct trace *trace)
>                 --sc->nr_args;
>         }
>
> +       if (syscall__alloc_arg_fmts(sc, sc->nr_args))
> +               return -ENOMEM;
> +
>         sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "exi=
t");
>         sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat");
>
> --
> 2.49.0.395.g12beb8f557-goog
>
