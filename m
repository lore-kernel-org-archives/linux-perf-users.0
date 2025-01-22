Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF7145B0B;
	Wed, 22 Jan 2025 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514926; cv=none; b=RGqSlyVx/J6n5jpKmoJN729mjQFbQFCE3gRjsF6TRKPsc+VsEIAt8r/xkAOHVgEPR6D+/m4TxFS+f9aqszFGGc9GY54yOP1u630QEUyzg0SAXZZG8rWvj7OqH4N63iFr9U/TX+3ViejwoW/Ccx0fRwCES5VIZ25TYyROnhg7qTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514926; c=relaxed/simple;
	bh=BgrYG9WcCDnzmoSkAIsY6/9qnhPL92Gk3IPD/KQL+ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S46sbqzU9zwCWoyIkhNZvqsIpLhUqUrI6sm+o/TgSEEdWdriOS/BcspA8oFiwRhcWyJpLTtnOn2Nfda1POJVgrcEL+PTIaBJk5aKtG+q7XTS+QS/ELEzrRnMoxHrqY4iqu04sEo7xAX9gHhvDaOru0IFCGkYBTiZwdUyRrVbV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIBpLgfY; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIBpLgfY"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so10004564276.3;
        Tue, 21 Jan 2025 19:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737514924; x=1738119724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OrJ7eS4GC3iycAalq2MpKxlqB3VQOcEMxEVWzDKl38=;
        b=YIBpLgfYzyoelleRIBxJ3vEm656trLPAnwEGNOsCVeTUeLIFigOlJHTaCvMIu2Flwe
         MdNsjzopcpCWJ07//OSeyTLutJxHGuRjGKPr0g/fZNBjJUpdAac3K46oDvz+fpf7KXqw
         TJjA/wJub+LBWSu/yca8Wd0c7S/869h4jHySy3Qx0swjymtsUGeqGLdOTxMLQbcn+iMq
         rBjtSRp1NPGnlZWOD8mxiBmhT10yx671cYSdl01I+eFqIKWXSoUFHMo2SWxl9qNfPoHS
         fUMXgjUJ2CJZSsemKlM2EMBtl5cDdqbfkvqeULNb+ILe7SBg4qJvMcNV3J4CsVUOlzeo
         yeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737514924; x=1738119724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OrJ7eS4GC3iycAalq2MpKxlqB3VQOcEMxEVWzDKl38=;
        b=Fka7+FWa9Q9S9LB2oKOsMi9iPFQrnuCgcWgZUdcEeGKudM8HCC1liukzw+KyqU1ocy
         9o+OaP518/i+Ee2bNHucjXFvvFn+eTjyB5uWDGWZwP+dnq15vlN1/MgJUz65kQKJ3OoV
         WfEBCrs0iAV0+9FQqPs04LKyUG7U9IrmHDtgiuxM1olhDTLGNXecZmAU64XQOXljyp1u
         fTQ3ffjZQutluD1cRuspUVhTAIgvmTWc5lopJgXpFjnYyW6KbSEpUCDg5MZevj7exMHu
         XlX3cWmS62FEMFgxoRZlA02ueoKRZHPuo3BO6suIBvh/hkjqwpPtbwmtfdAz0Sc1ad9t
         405Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+ZY0Q2k8PUdt1EZU6kdFljGz74sJbHJAAYWaCgbtu8s7d4GYacnm27z15QL3QZqXolOAThw6P9FyrNX7+2iaG3A==@vger.kernel.org, AJvYcCXHM3WJW57jM9/gAAEjuv3GVWSpMFNJU+WWz+08vq+t3dDgQ1kRD4eihw2RUJCgASVCYOiv/aUce4Ys51s=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyI+RHDhyOUVEew3aA6yhfLyJ8ky2rG5DHgmOGBKJXCJ/h9sP
	WvYvNCMGR9BLbjy8ivlxpkabDosiVwEgqkQnkb5CViqA3GR2BAY1GWeiQMx1Nodht+myOGqn+86
	bVbGSn+Vbz6mqfXa3RVVCkTWpVUM=
X-Gm-Gg: ASbGncsIJrXbuNkl7FS0FnIJ56aK3gnnNS/co2Tbn9GU3sAjD2Oe4Ok5MfAJ3Syia//
	OuFRxkX8Gg/BmrGulq3sjvpXqLb2IrUeKqXkKiEpAFMK9t4X+VQ==
X-Google-Smtp-Source: AGHT+IHDEtZKHbVBPsCFpFck/wsXq4P8AQd2F9THTcsa0WJbOznAELCxMTHwx+M7fsXvKpye/cJh60dvhnGneaxPMnE=
X-Received: by 2002:a05:690c:6603:b0:6ef:c5f6:2ac8 with SMTP id
 00721157ae682-6f6eb904750mr162063147b3.27.1737514923643; Tue, 21 Jan 2025
 19:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com> <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
In-Reply-To: <CAH0uvoi6=JmtX2xit9y7+NR5O+1S5zbxWpmLpbzC9+9nrkudHQ@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 21 Jan 2025 19:01:53 -0800
X-Gm-Features: AbW1kvY_OofDRzdzofl5f6gCf7hJD4ohz31QQJqvExZBbmJqkIovc5V0cIUDt_o
Message-ID: <CAH0uvohQvqRYo8JBX_Z1yVobqcxRgQG4G1Y8o8XMv18CnrqBbA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Remove return value of trace__fprintf_tp_fields
To: Benjamin Peterson <benjamin@engflow.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello fellow maintainers,

Just a slight ping.

Thanks,
Howard

On Fri, Dec 13, 2024 at 10:06=E2=80=AFAM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hello Benjamin,
>
> On Thu, Dec 12, 2024 at 7:56=E2=80=AFPM Benjamin Peterson <benjamin@engfl=
ow.com> wrote:
> >
> > The return value of this function was meaningless and therefore ignored=
 by
> > the caller. Remove it.
> >
> > Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
> > ---
> > This is a small followup cleanup to my earlier commit 5fb8e56542a3 ("pe=
rf
> > trace: avoid garbage when not printing a trace event's arguments").
> > ---
> >  tools/perf/builtin-trace.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..246be66fd59a4b9d76e4d3c=
42b68d0a444ca366a 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3022,8 +3022,8 @@ static void bpf_output__fprintf(struct trace *tra=
ce,
> >         ++trace->nr_events_printed;
> >  }
> >
> > -static size_t trace__fprintf_tp_fields(struct trace *trace, struct evs=
el *evsel, struct perf_sample *sample,
> > -                                      struct thread *thread, void *aug=
mented_args, int augmented_args_size)
> > +static void trace__fprintf_tp_fields(struct trace *trace, struct evsel=
 *evsel, struct perf_sample *sample,
> > +                                    struct thread *thread, void *augme=
nted_args, int augmented_args_size)
> >  {
> >         char bf[2048];
> >         size_t size =3D sizeof(bf);
> > @@ -3088,7 +3088,7 @@ static size_t trace__fprintf_tp_fields(struct tra=
ce *trace, struct evsel *evsel,
> >                 printed +=3D syscall_arg_fmt__scnprintf_val(arg, bf + p=
rinted, size - printed, &syscall_arg, val);
> >         }
> >
> > -       return printed + fprintf(trace->output, "%.*s", (int)printed, b=
f);
> > +       fprintf(trace->output, "%.*s", (int)printed, bf);
> >  }
> >
> >  static int trace__event_handler(struct trace *trace, struct evsel *evs=
el,
> >
> > ---
> > base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
> > change-id: 20241212-void-fprintf_tp_fields-8aaae2f5525f
> >
> > Best regards,
> > --
> > Benjamin Peterson <benjamin@engflow.com>
> >
> >
>
> Thank you for the follow-up patch, LGTM. Built and tested.
>
> perf $ ./perf test "perf trace"
> 109: perf trace enum augmentation tests                              : Ok
> 110: perf trace exit race                                            : Ok
>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
>
> Thanks,
> Howard
