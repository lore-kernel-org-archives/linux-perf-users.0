Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CDE1427A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717368; cv=none; b=l23K7dUOrQzfyeLpPjMHYJ4Qu14XpNysGozo1wKaob2NzE3Iv3DNkXCmE2gzHwY16Pv2pMxBozfjkbYX/d94cHbc6J3k2DyVwLXIt5NAbAXRjUcVQa8uaCfkB20IIwJrIItOBqdB1F+G2d8cjuCw4Nl5CoqHVNIx5x5h/hbuxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717368; c=relaxed/simple;
	bh=47JougxzyLRfPeKtNtBeFuD//fDNWBKYSggGqC9sPr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UL0GUsVtawlB4uo2dsX56MfDPEJHZ2udOUU4I3mMcdrQsGiiVZ+EbgtQwMzsj5K0O2t2hS+RjKRJO+5raoAkE559UbWeAq6qELgTWnx9juK/rqWg7hbzrVpNRr/OSoM3oRsZlFbw3tDsb+uPry0m4TyiJnDCVWwfNrqAW1TR96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC+q9Cs/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC+q9Cs/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29852dafa7dso29695ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764717365; x=1765322165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50DVMy0iPzcBKBbda9cIbV2YMyijzbaPSI2wUDkfV6I=;
        b=SC+q9Cs/K14wvJ7kLTiZuZlCq7jhedCs21kQkRUy2ou1RPrvsQPJ9fT1FTTp8rNk9R
         2++5sHZ54pkLrhXDpOe7mvKC2JtWyqNtqGCJb0VyjAkTJM4g23xxWNhXmONKsYFIncbt
         sEfGpgAariwoK+//P5qFRbkWbWTuBMz7oFSvIBxCswIX5GAtXigmgOemJ5e3uRUE8fyy
         IZVB8WEAWqEBuNpIIJFiLUNTh5MN4itSWqkHoZzmveXjXOYhzYVU3laMQJdSmGm5XTRO
         6YsbZP0m+fvqIfHwroJL3k6mUwK62Kqi1twJ/hBdlXBCqPi+471Fs6R4XwQiKLvfImYu
         7Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764717365; x=1765322165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50DVMy0iPzcBKBbda9cIbV2YMyijzbaPSI2wUDkfV6I=;
        b=qtzNqh0VnuPKAO/0bz3gBBNFYRWuPqNAAZ5qO0c7/tVGUAebze033ih91My+E1N7Lw
         dIds1z5WFvMaamEdJpCOUQpz56YJHEt8D1mpyiBnJp8k6a9DlkepiL+aBXop0Gn4YEG7
         70D3ttwDZou1P6Ob+1H60q6Vadi79cFg/IclFoR2QvluW5KjgGvruTyR135tuOxRQ9UW
         QtyEAMgo2/mjdxudAmvFRgIIVC8OJ1AEuwlIyHncFq9Zes+Zn+F2UiZ9KU7Vj8mu/c/I
         3HZla+XwSu66pwZEXQ+RQVmRyTuLw4GTjZHJOg7Hxrg0QbjAw9o2nO4iaP3yhnZIGcFH
         OemA==
X-Forwarded-Encrypted: i=1; AJvYcCUireQMO7APDoILL4R+IeVgXw9wd7Ncg3VDT4jMzjTiNq1J6oJOUyUfcrVIx5co1QFPrgITXHDnbHyGHzigop6I@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhfFgoW1EPrhLjuVjMojY2PhBB8Uee6bVVhmuv6OxIwF6DMVI
	86HOgXh8ZF8aKY+isEIrjUnHNmt+xYiolgLSMLNFWPRqTJ8rGIfvnnVgYQOdvTRYyOFYr5ZeKIi
	Ivu4sqiEYuZl1UVIDLMSkayujz11N0bdH0acff0Lq
X-Gm-Gg: ASbGncvDPLyQJbdkH2Bt7hgGlPi0AWFIHDe+P2LljuZ+dnLJL/G8XRuTUKEJi+P9SgF
	KvmTZVh3+GQwEmZq1BSysbq40PddYWlUujfMcAv8DwPt+qlfjx8vBJqboS6Rsz5Y9H/Pnp/8TRy
	DI8+bJOmLc8Ls+J4NHLjLoyxtgi36Vbc+34q3L3l7fli5DGYP2HBVIWziHJT683dHjxSnfCL3Tj
	SAtHGm4xOrFJ78Rn8zdxZMspMGrBAFQaEAjkn3gudKqIfXSqqhO6RALGEdwO+3TwG+A8GJSfC5E
	cdexvOoPFYAAmYnUTcZWIFoF
X-Google-Smtp-Source: AGHT+IEtBuE8dMkxTWk0sC4VgTcy2fTd4H8KpQmmfnh9lLn7x4CPXcF3p1ST9wc1sX8gwN21gB73EnevpSjDYYQmjvw=
X-Received: by 2002:a17:902:cec8:b0:299:c367:9e02 with SMTP id
 d9443c01a7336-29d67f71595mr480785ad.17.1764717365133; Tue, 02 Dec 2025
 15:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120234804.156340-1-namhyung@kernel.org> <20251120234804.156340-7-namhyung@kernel.org>
In-Reply-To: <20251120234804.156340-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 15:15:53 -0800
X-Gm-Features: AWmQ_bnZbpawHRiOWnRkWKBXay2hQ9O3dtwYzvtFpXbMDeouLJk9PtKM7rmz02s
Message-ID: <CAP-5=fV5_jxOmZP1q3k88Cs9VXG_d9YW0qk8NoUFKgZgp1x73A@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] perf tools: Flush remaining samples w/o deferred callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:48=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's possible that some kernel samples don't have matching deferred
> callchain records when the profiling session was ended before the
> threads came back to userspace.  Let's flush the samples before
> finish the session.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/session.c | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index dc570ad47ccc2c63..4236503c8f6c1350 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1295,6 +1295,10 @@ struct deferred_event {
>         union perf_event *event;
>  };
>
> +/*
> + * This is called when a deferred callchain record comes up.  Find all m=
atching
> + * samples, merge the callchains and process them.
> + */
>  static int evlist__deliver_deferred_callchain(struct evlist *evlist,
>                                               const struct perf_tool *too=
l,
>                                               union  perf_event *event,
> @@ -1345,6 +1349,42 @@ static int evlist__deliver_deferred_callchain(stru=
ct evlist *evlist,
>         return ret;
>  }
>
> +/*
> + * This is called at the end of the data processing for the session.  Fl=
ush the
> + * remaining samples as there's no hope for matching deferred callchains=
.
> + */
> +static int session__flush_deferred_samples(struct perf_session *session,
> +                                          const struct perf_tool *tool)
> +{
> +       struct evlist *evlist =3D session->evlist;
> +       struct machine *machine =3D &session->machines.host;
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample sample;
> +
> +               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> +               if (ret < 0) {
> +                       pr_err("failed to parse original sample\n");
> +                       break;
> +               }
> +
> +               evsel =3D evlist__id2evsel(evlist, sample.id);
> +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> +                                            &sample, evsel, machine);
> +
> +               list_del(&de->list);
> +               free(de->event);
> +               free(de);
> +
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
>  static int machines__deliver_event(struct machines *machines,
>                                    struct evlist *evlist,
>                                    union perf_event *event,
> @@ -2038,6 +2078,9 @@ static int __perf_session__process_pipe_events(stru=
ct perf_session *session)
>  done:
>         /* do the final flush for ordered samples */
>         err =3D ordered_events__flush(oe, OE_FLUSH__FINAL);
> +       if (err)
> +               goto out_err;
> +       err =3D session__flush_deferred_samples(session, tool);
>         if (err)
>                 goto out_err;
>         err =3D auxtrace__flush_events(session, tool);
> @@ -2384,6 +2427,9 @@ static int __perf_session__process_events(struct pe=
rf_session *session)
>         if (err)
>                 goto out_err;
>         err =3D auxtrace__flush_events(session, tool);
> +       if (err)
> +               goto out_err;
> +       err =3D session__flush_deferred_samples(session, tool);
>         if (err)
>                 goto out_err;
>         err =3D perf_session__flush_thread_stacks(session);
> @@ -2506,6 +2552,10 @@ static int __perf_session__process_dir_events(stru=
ct perf_session *session)
>         if (ret)
>                 goto out_err;
>
> +       ret =3D session__flush_deferred_samples(session, tool);
> +       if (ret)
> +               goto out_err;
> +
>         ret =3D perf_session__flush_thread_stacks(session);
>  out_err:
>         ui_progress__finish();
> --
> 2.52.0.rc2.455.g230fcf2819-goog
>
