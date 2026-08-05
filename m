Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D33EF64A
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965402; cv=pass; b=ri4NXpyzk1l0iTLCi805ORsICwISIqLp632tSiLCq5rWuqnkNHpGPEUGX9QdqkkTHoUaPMc1ho42fKm2SjD52ophGQ4dx3Tb5EdPq60xRzTeynpqJLSNwFpubPl6/5ipOvN16168ih9M6YIZ7lM9zhlY98bqWWqdwccobgToW4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965402; c=relaxed/simple;
	bh=D9Q/Au9Y+diFkozFMMx78S88MxEV5ROAubO99EyLbdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0R7NUPBdAu1+IPV+agdcVsVgNa3vROCItYR8Ytr1JtlDUfK7+ZmYE/W7XZnRex8fsJ+vnY97QeS7sORWO/ZhaJ//TA8UAXOI3KMBmaIVYjcguC2Q/KfL+NCp8/gmoGCO32XO9pIynSxERyZY/I08QfbFzjzJAG9ZiUlKJe5Q6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plDlIgE5; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plDlIgE5"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10e86e52so30261cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 14:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785965399; cv=none;
        d=google.com; s=arc-20260327;
        b=HPesFsT0Ho738fKdtSiXngV5e+vViSKaAVF525/X8OnjS6vy2vP6LmIZLLpInUiZjL
         Q+y4qOkP31EExqd/9RjTLLN/ougLxoRgPDSTBOKR+59lTe5R59byWHh4B25iLewgm6dT
         aKmGPHWa8ZKa5yXz0ycS9mS0y0tGbcwpGjjDyHW8BwuL71Kz5b5X5iMM0UFIFcvrmcAb
         JRb1AuXT+H2Dc0ylw2yXXrmA+T+4WIYm6mRR6jLiBV0Rhme4rqC4Gu87L/B93wiTmC94
         REPZoiuIJMmBfzuaUFI2/NlwGImJMTSplzLEiJtSXI92NcdVs5uq1yyUTRBMHktAJKfl
         sxnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6Jb8l8BkMvXRyue7sGwCsNPEFPsZOpcTjt6skahsWo=;
        fh=59ysGHnmB5kMu+D5fk0ifGa2hQoWhL2iHqrXNqhaCQY=;
        b=RrufNugLFpP6LeMbnFlqZXAkxYkG/jsV3wvyGB2wEZASxcWW2lwru7HVYkVt9BfPwl
         NEL7FmzfrNKrRNP+A/YyFLw5jguik8lNnvfiEZf1z173Rc22CFJNXYX/BXl/CL4KXjbf
         fz2RTF0dlzvQtrdbo/+SQZwcF/RnsUsvQQiCftt1cIXuqfb2TjMVaO+CgCIjRPkCQV7r
         w5R4tSYcDY1zgKu5e1atxOTKAmjG7LwrQYH0o585ize2EQ9SiEZl2Sgdtnf+rsvtUFVO
         +o/tE3hgYGuAA+jfCtt4DNSe/E3fgwzPOgV/mVqJ8tZ15cdP4JyT/bNf6S/7i4+1TIVc
         VMMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785965399; x=1786570199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O6Jb8l8BkMvXRyue7sGwCsNPEFPsZOpcTjt6skahsWo=;
        b=plDlIgE50Ec8inpkfWgYhtM/bLqDGCQLsjno4gdE3OTjIsrEJ6pHLVhpWOM0rrJgy/
         ImmwEBNohzRm9TQ9vLi4besQ5nQt/wArpjgiDUiKXhWmqAfojyr6xgZQx6KT4wkOm3eY
         kV4yD+3fSgZTeq7iU+VCEO/79UcRzK3TY8KWFD5ZdSzmY1K6ipXsFSgzWYyMJqwpKF7q
         OGExFznvy5PCIDSLUVYpeM1B8rdycB9jZDxaw1s7A1gWlRzYsSX1DAjcHf8Yg626DU22
         2XqXwoCqbXt6qvHwiVgj6zJATYtIta6ZmR3AYfFcrQr5dYNc/VwaowKFvWWioPv5yAFp
         0QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965399; x=1786570199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O6Jb8l8BkMvXRyue7sGwCsNPEFPsZOpcTjt6skahsWo=;
        b=c0K2n9EmItobXraGAWmnMbNBF3OI7oN1uLLZ2D4jeKfXwi0a4rjhD86Q8YWDinzULx
         QTme72hsczvryKsjruBoxEqZ/wa0tM8Z1LB3mV9hZftCedXhhyL+RXlacww1RGahlF04
         KiGBGlA2h2huFIXIbfpKWOVuHKHMYsIE0GD6UJOV3ufDphesJlbNgW4Fgm/5XqzRRUpe
         1iLSYMlXzA/46TETPxGoMEzr0xuAskEOXkVfPClqaRxGXCUsD2/O0VOS1KDeIzA+lFjB
         c9cwjdI+YvQe3ILKojguXTCabldwQt3TGogVJaiUUmtvHGnJOEeH/dU+slgcRiclI34Z
         bXMw==
X-Forwarded-Encrypted: i=1; AHgh+RpvFGvPP3KGBoNFFMn8IW9P6BQCMRXaIyvgl4+j6ry0oxbfmu3oyJBHb1sbSTtwYVo7oe26silfHkl5WMccFdrf@vger.kernel.org
X-Gm-Message-State: AOJu0YxzRtDdGS4gUzXuX735q+0+MzPiIA3bcrwsKTk+jKdo17Kz1u/t
	SwZDPczuaeDExRHwPFbU17JJvaqNn9+cLkg7tpX13sURBERmObshmzUPs9UKcy7WFA+Nla5MXQZ
	+EaY/SqauDRMJS/j+qAT/xokz6ARegUcPgJcF/FZ/eqGgMPqg4s3/UAfz3Bg=
X-Gm-Gg: AR+sD13XLcu8ByZKMj6VW3uGVWhUVMAKVstz/zUCTq9tRXTsKYlUdjFzSccFWrcVpol
	DxLdgjHnXubhQtc7PJL6YfpB4BG0sto6ilq4YxBLtErN8A1MEspeUtxUD8Cs/2+Dt/LL99yXjsF
	vodG1Jmk/YPvPK7UMZgwcn+WcUKI6ahmKPL39HpMMj7HVTcgX2jsuckNa09iK1EMK+tiN68WUVC
	t3T8mmzHeiYP1iXYzSaYV1yGbskpl7ANS8JaMlxtEQ5+1RB5PKRRWmbD3DTPqc4QXHUDwAY0b1Z
	nJ0g8b4FIec4OZFlRtm+aE/K/2tMo5nLFc56xb4Eosjvbw==
X-Received: by 2002:ac8:5a4e:0:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52cfe8205ccmr417321cf.1.1785965398780; Wed, 05 Aug 2026
 14:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-6-acme@kernel.org>
 <CAP-5=fXRei4AivX_RcqR4xjmLtbYuNsJALOzJMAWvy7HCU09Dg@mail.gmail.com> <anOS6oYhAKJkAQdh@x1>
In-Reply-To: <anOS6oYhAKJkAQdh@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 14:29:47 -0700
X-Gm-Features: AUfX_mxp6JglIFeFuC1xB1oBxKRPrPEploUrJuAEi-MbEygz0sPkZeGhJgqeO-A
Message-ID: <CAP-5=fU6w8pjDs161=JtKK-OLns9O2iLgTrJhd-Dcahn7xon-Q@mail.gmail.com>
Subject: Re: [PATCH 05/12] perf jitdump: Check snprintf return before
 computing header size
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:45=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Aug 05, 2026 at 12:07:23PM -0700, Ian Rogers wrote:
> > On Wed, Aug 5, 2026 at 6:31=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > snprintf() returns the would-have-been length on truncation.  When th=
e
> > > jitted filename exceeds PATH_MAX, the unclamped 'size' value inflates
> > > sizeof(event->mmap2.filename) - size into a massive underflow, causin=
g
> > > the header.size computation to write an oversized header.  The
> > > subsequent write to 'id =3D event + header.size - idr_size' then corr=
upts
> > > the heap.
> > >
> > > Clamp size to PATH_MAX - 1 after snprintf in both jit_repipe_code_loa=
d()
> > > and jit_repipe_code_move().
> > >
> > > Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support=
")
> > > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > > Cc: Stephane Eranian <eranian@google.com>
> > > Assisted-by: Claude:claude-opus-4.6
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/util/jitdump.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> > > index 078d3304d2b7ebce..fd11e07bf00b7978 100644
> > > --- a/tools/perf/util/jitdump.c
> > > +++ b/tools/perf/util/jitdump.c
> > > @@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_de=
sc *jd, union jr_entry *jr)
> > >                         jd->dir,
> > >                         nspid,
> > >                         count);
> > > +       /* snprintf returns would-be length on truncation, clamp to b=
uffer */
> > > +       if (size >=3D PATH_MAX)
> > > +               size =3D PATH_MAX - 1;
> >
> > Given the recent fixes to reading /proc/pid/maps where it was assumed
> > the file paths would be limited to PATH_MAX and it turns out that
> > PATH_MAX doesn't really do that and we had potential buffer overruns
> > during synthesis, I wonder it would be more intention revealing here
> > to use "sizeof(event->mmap2.filename)" rather than PATH_MAX. Other
> > than the constant used, I agree with the change and using PATH_MAX
> > isn't wrong.
>
> We need to go on having our tools/perf/AGENTS.md with all those rules
> :-)

Yeah, I don't know of a plan for AGENTS.md files but there is always:
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/perf.m=
d

Perhaps we can add something like:
```
## PATH_MAX avoidance

The PATH_MAX constant isn't a limit to paths in places like
/proc/pid/maps, and reading paths from these locations can lead to
buffer overruns for buffers sized at PATH_MAX - as such prefer dynamic
memory allocation for paths. When referring to the size of PATH_MAX
sized char arrays in kernel system call and ring buffer data
structures, prefer to use sizeof the variable rather than the PATH_MAX
constant to make it clear the size and possible truncation is being
enforced by the kernel which may substitute long paths with the value
"//toolong".
```

Thanks,
Ian

> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks!
>
> - Arnaldo
>
> > Thanks,
> > Ian
> >
> > >
> > >         size++; /* for \0 */
> > >
> > > @@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_de=
sc *jd, union jr_entry *jr)
> > >                  jd->dir,
> > >                  nspid,
> > >                  jr->move.code_index);
> > > +       /* snprintf returns would-be length on truncation, clamp to b=
uffer */
> > > +       if (size >=3D PATH_MAX)
> > > +               size =3D PATH_MAX - 1;
> > >
> > >         size++; /* for \0 */
> > >
> > > --
> > > 2.55.0
> > >
