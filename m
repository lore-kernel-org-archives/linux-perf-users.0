Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004B2C859
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Oct 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016727; cv=none; b=MyCd6cUOgYZK0iAn04krxGUAufuju2+FNNFoTV/fzLKXaJRkQY0Zl+MBkeSRaGb5ZqjdUKaXpCsqYVYNzc5OUeU/cClcRDDRwlkRE8rspYDEKwzJEoG/dmoJ+MUxtPLpfu2NIJmyxlTM3UlG/1iEcLqAl1N9XGNoV9IDTbQS/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016727; c=relaxed/simple;
	bh=h3NuZ12K3/lElcibtGA+QG5w/yrJTAfAVGN7114N2I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj+qZJJUf2vWZdAeWfbo2lLQRRt2nHwL8r3rZ5nefIaP+w/Gt8zoKHahl26y84wBPJfF4aA98lK0jQcgUUGWTiyqQxxJC7Xs3pNLZzphtylON7+mD5+o2i7oFW4SRyUYl6HtPeueRsJILXYB3sAvQlh6MAwY47fzYqB2siaC5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYXDwAUs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYXDwAUs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27d67abd215so252615ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Oct 2025 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760016724; x=1760621524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKgrX9I9H1E8Rzi9UZJixQg4AVl3hxGPKMOGQpXFZKY=;
        b=WYXDwAUslJVv9B33sTxrzUROyXOdUAJUw2I83Y+TRSakmd8R6qjzVononSGrBedWj4
         PQFAohIt7qKAuSUL/MOIPMtG6Y998nhRKt+1FII330JKyO0opC0iz9QbfKmOHyTrIVuS
         da3b5Rrl1Nt9t0q/Bao99IRJqrh6nqJpqCf1RSMwn84560wKYIfUFGCjp0vUuuNfyaPh
         BW/y3pzQjc9d7zSjN8FKsy7p73Yvw4r7Fs4bq/np0cToxTGTbE/w74C/YT0iWwga6Pls
         ZiEpTOT614sGGlriz+QAtxCKQq68N/Zos2sgJBQRBjQJBPVsohWl9ku3aUJznPncEnWC
         8vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016724; x=1760621524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKgrX9I9H1E8Rzi9UZJixQg4AVl3hxGPKMOGQpXFZKY=;
        b=bPHbraTynidI5BW9ge4XWTcHuNQm/YnSIYSC3Wq2LzyaRHiB/2veW0ddhB4avtyFhV
         1NwaDRCxHctQ4RnCO2VlJYdoPuf8GGkcuZ3MhtXsSCGxyK2eVVtgg1YPlmOpiAGw3hHN
         l+TvujzXws4XTzHjjQ1HxSSWkL60pTUrIli8hEaN4c8d6US9AIHifnADP0hvuO8EMlBs
         QofMqpDcyvAWznVZNj5uf5zwo8i5bkwDvdn+INvl/g3b6mTVLsyczsix3+Mno7rLpZ+t
         LbD8fqlQiMcZOK3U8RziA/1ykiwZ/Tg5joSSzqmpvyHxDpvwCvmG6dbBkfH+TMlbELY1
         cSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3+/dqZU3TiuuV6KvqqrPIfwJQL/j9OfHsXUR3CqqQOp160h8Az2uU6GgdxrJmyda2Io/wGvaw18YGasJcMTV3@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1/9MWxtCwBW1cAyxFNDVaT6kNylWWU+q04dJ+GOogOLBfeEd
	xqPW7td3Rt6j/JYHMjgaaDNZqMe6aSJieKGCA7/5yTZNjgLNyncmz1eIuaL2cxyMLq9BmKkpor2
	ZaEj6firYNbYkzyWw8n+6rvYDrOVGthneMbq5bO5V
X-Gm-Gg: ASbGncuMuBTijwCpQe38F6nrgOU7VRIeihbcnEoVhgEIcjZR5NYv9uvTGkekj+HymH8
	iVD8seJ76msV/sIRk8ioh5isAJxiV5FNg3bt7S1/r2QGWbYbzhkEZbx7VpqK5x/2MZSwAWk79jE
	8DLT310LAtGNXCtY4sHBVdPwc/7iP7RUFEBK7iS0wEfN2DoevvERmw2XYgeb6XhcnR7Ob7ZrMMd
	7KDpVic1i+gBQQS7c4V4Q9z7mvS+L5Hcd8Q1Uz/IkuR1/W72g==
X-Google-Smtp-Source: AGHT+IFZJq65ep3s4bVMk6jxRxVRnjn2WyK+ZNQwtHI4t4HXIP6rXT96ATbGdNG/wBUzAgqVESqMBEwAWlzsE5261Jc=
X-Received: by 2002:a17:902:d548:b0:25b:ce96:7109 with SMTP id
 d9443c01a7336-290275de5a5mr9131235ad.3.1760016723556; Thu, 09 Oct 2025
 06:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005181421.2787960-1-irogers@google.com> <aOYkRdU5pn_jTOq3@google.com>
 <CAP-5=fUqYeaE_P3ApXvq7j9SRuNXpLf+mK-4XBsvv2R=OTccbQ@mail.gmail.com> <aOdNWrIAQMkaVsqR@google.com>
In-Reply-To: <aOdNWrIAQMkaVsqR@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Oct 2025 06:31:51 -0700
X-Gm-Features: AS18NWBVDbTPoqSC3Meaoii89yADm94rw5shK2Rf50XwIFJD_M3dwkPQDvt3OEs
Message-ID: <CAP-5=fVERf8jf3MrwiEfQtChvC1KUe0EEASK1aVk-UKkk=Pb0w@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Additional verbose details for <not
 supported> events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 08, 2025 at 09:31:53AM -0700, Ian Rogers wrote:
> > On Wed, Oct 8, 2025 at 1:43=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Sun, Oct 05, 2025 at 11:14:21AM -0700, Ian Rogers wrote:
> > > > If an event shows as "<not supported>" in perf stat output, in verb=
ose
> > > > mode add the strerror output to help diagnose the issue.
> > > >
> > > > Consider:
> > > > ```
> > > > $ perf stat -e cycles,data_read,instructions true
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >            357,457      cycles:u
> > > >    <not supported> MiB  data_read:u
> > > >            156,182      instructions:u                   #    0.44 =
 insn per cycle
> > > >
> > > >        0.001250315 seconds time elapsed
> > > >
> > > >        0.001283000 seconds user
> > > >        0.000000000 seconds sys
> > > > ```
> > > >
> > > > To understand why the data_read uncore event failed, with this chan=
ge:
> > > > ```
> > > > $ perf stat -v -e cycles,data_read,instructions true
> > > > Using CPUID GenuineIntel-6-8D-1
> > > > cycles -> cpu/cycles/
> > > > data_read -> uncore_imc_free_running_0/data_read/
> > > > data_read -> uncore_imc_free_running_1/data_read/
> > > > instructions -> cpu/instructions/
> > > > Control descriptor is not initialized
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > data_read:u event is not supported by the kernel.
> > > > Invalid event (data_read:u) in per-thread mode, enable system wide =
with '-a'.
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > data_read:u event is not supported by the kernel.
> > > > Invalid event (data_read:u) in per-thread mode, enable system wide =
with '-a'.
> > > > cycles:u: 351621 362833 362833
> > > > failed to read counter data_read:u
> > > > failed to read counter data_read:u
> > > > instructions:u: 156184 362833 362833
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >            351,621      cycles:u
> > > >    <not supported> MiB  data_read:u
> > > >            156,184      instructions:u                   #    0.44 =
 insn per cycle
> > > >
> > > >        0.001584472 seconds time elapsed
> > > >
> > > >        0.001811000 seconds user
> > > >        0.000000000 seconds sys
> > > > ```
> > > > where without this change only "data_read:u event is not supported =
by
> > > > the kernel." is shown.
> > >
> > > I think what you say is:
> > >
> > > Before:
> > >   data_read:u event is not supported by the kernel.
> > >
> > > After:
> > >   data_read:u event is not supported by the kernel.
> > >   Invalid event (data_read:u) in per-thread mode, enable system wide =
with '-a'.
> >
> > I kept things verbose as unfortunately the
> > "kernel.perf_event_paranoid=3D2" is important as is the use of
> > per-thread mode. Different paranoia levels lead to different errors
> > and unfortunately a lot of the time the error gets reported as "
> > data_read:u event is not supported by the kernel." and I'm not sure
> > all users will get that the key part there is the :u modifier.
>
> Yep, I'm ok with the change.  But the changelog was a bit unclear what
> is being added exactly.  IIUC we already have the paranoid message with
> the verbose level 1.

I thought the line:
"""
where without this change only "data_read:u event is not supported by
the kernel." is shown.
"""
covered this?

Thanks,
Ian

> > However, fixing  evsel__open_strerror wasn't in scope for this change.
>
> Sure, we can handle that separately.
>
> Thanks,
> Namhyung
>
> >
> > > Off-topic, it'd be great if we reduce the number of the same warning
> > > messages.  I think the data_read is from two uncore PMUs so the messa=
ge
> > > was repeated.  If we can connect the related evsels and show the
> > > messages once, then the output is more readable.  Maybe we also want =
to
> > > show the fallback message just once (globally).
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/builtin-stat.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 7006f848f87a..84e06ec09cc2 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -624,8 +624,9 @@ static enum counter_recovery stat_handle_error(=
struct evsel *counter, int err)
> > > >        */
> > > >       if (err =3D=3D EINVAL || err =3D=3D ENOSYS || err =3D=3D ENOE=
NT || err =3D=3D ENXIO) {
> > > >               if (verbose > 0) {
> > > > -                     ui__warning("%s event is not supported by the=
 kernel.\n",
> > > > -                                 evsel__name(counter));
> > > > +                     evsel__open_strerror(counter, &target, err, m=
sg, sizeof(msg));
> > > > +                     ui__warning("%s event is not supported by the=
 kernel.\n%s\n",
> > > > +                                 evsel__name(counter), msg);
> > > >               }
> > > >               return COUNTER_SKIP;
> > > >       }
> > > > @@ -649,10 +650,11 @@ static enum counter_recovery stat_handle_erro=
r(struct evsel *counter, int err)
> > > >               }
> > > >       }
> > > >       if (verbose > 0) {
> > > > +             evsel__open_strerror(counter, &target, err, msg, size=
of(msg));
> > > >               ui__warning(err =3D=3D EOPNOTSUPP
> > > > -                     ? "%s event is not supported by the kernel.\n=
"
> > > > -                     : "skipping event %s that kernel failed to op=
en.\n",
> > > > -                     evsel__name(counter));
> > > > +                     ? "%s event is not supported by the kernel.\n=
%s\n"
> > > > +                     : "skipping event %s that kernel failed to op=
en.\n%s\n",
> > > > +                     evsel__name(counter), msg);
> > > >       }
> > > >       return COUNTER_SKIP;
> > > >  }
> > > > --
> > > > 2.51.0.618.g983fd99d29-goog
> > > >
