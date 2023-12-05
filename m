Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="OwGcd7y/"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42FA1BD
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 10:23:43 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1a0bc1e415so563028566b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 10:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701800622; x=1702405422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+0YlV3bBjMI57c/U4EB7oIqdJ8ldlbudM2aWbhqhfU=;
        b=OwGcd7y/rv/7lEe1ubMO6IEKyPg7ia2YgVEA50a9URa6nktRIzuMWBTslrYMTj0IPS
         1Ur1dbbODFAhoyF9OYZKYFP9707UxeEnxuE/ciLDebn31FlkscteI2flGj/QTYH/fDya
         cglI6gszPsw2Cv88t6yTcI+vr8bwBKrAI2x76562sGnte1+jxeBx4+0RwyneXrDY3s0d
         1bM9bGNVKz8q2MVjuoaLbGi9cUsxxb6Crs8iwz/XEJOvaniMAEAJK+nWqTLgVwjFh1ea
         lr6KVtHNflooM0mdmqkIveAXTdotK/74xkjIGpwHwm6A8mnsW9d32pg8Y437ATeraKgr
         dlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800622; x=1702405422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+0YlV3bBjMI57c/U4EB7oIqdJ8ldlbudM2aWbhqhfU=;
        b=sc1dCpQwzsOw5Tf6Cjvp33zlH3XPPPciMEc5JOSD9Cy3ZO51HdF9ZP+oxnGTuSAZAL
         T8C1zR/StSlXRy+L6oGqT4nJ/ZGCHFettoYgucNremQc4RAhYjZLwLstqG8B2w6Jp+8z
         6aSG4TZ1SPRX7wdWuXLR2vdDSL+nQ3D6/T/XIImyORrBYm2uiAt28EPxsoea6HZXbiVU
         VZbtS+LZlu+W4YJUZ0gP+ft2I84ksr55u4gaIrccHzikgwYyyvN1FQvLlC8piYWBME7w
         CYcGVTNJecY2VVK6yNQZh9VtTXeXlA5g4+56IEFagE76Cx9gAlvIGyVEvrhotl8uvImP
         XImw==
X-Gm-Message-State: AOJu0Yy3K/TxE6b4JQF1WE9rF2CImghF/vXw6xW2vASCtE5I5xp1cvIA
	kqy6m12tvecl44jPxhNVRFsuhqsKP+behR/ygsZqbQ==
X-Google-Smtp-Source: AGHT+IGRGeCn9pEqVAY8iz3lyzXrueW4v8n436DdU9IWtnh+NqFaWgvKvAL5wFhMr6ZBk6uovrD180nlBRzfvUfE5rQ=
X-Received: by 2002:a17:906:1003:b0:a1b:81c6:3900 with SMTP id
 3-20020a170906100300b00a1b81c63900mr1503399ejm.80.1701800621992; Tue, 05 Dec
 2023 10:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
 <ZW8Gi2QI5ceAJfab@krava> <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
 <CANpmjNPfoLX=HPy0MhbGqMmGT4jE0Ky29cx5QP_8tJ2u=1ju_Q@mail.gmail.com>
In-Reply-To: <CANpmjNPfoLX=HPy0MhbGqMmGT4jE0Ky29cx5QP_8tJ2u=1ju_Q@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Tue, 5 Dec 2023 10:23:30 -0800
Message-ID: <CAP045ApMPuB=cngLj4cmOoKbjwkX3oi66oixbsSeEbLP-yOcng@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To: Marco Elver <elver@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <olsajiri@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kyle Huey <khuey@kylehuey.com>, 
	linux-kernel@vger.kernel.org, "Robert O'Callahan" <robert@ocallahan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:17=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, 5 Dec 2023 at 19:07, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > Add Marco Elver to CC.
> >
> > On Tue, Dec 5, 2023 at 3:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> > > > On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com>=
 wrote:
> > > > >
> > > > > Returning zero from a bpf program attached to a perf event alread=
y
> > > > > suppresses any data output. This allows it to suppress I/O availa=
bility
> > > > > signals too.
> > > >
> > > > make sense, just one question below
> > > >
> > > > >
> > > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > >
> > > > > ---
> > > > >  kernel/events/core.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > > index b704d83a28b2..34d7b19d45eb 100644
> > > > > --- a/kernel/events/core.c
> > > > > +++ b/kernel/events/core.c
> > > > > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct =
perf_event *event,
> > > > >         rcu_read_unlock();
> > > > >  out:
> > > > >         __this_cpu_dec(bpf_prog_active);
> > > > > -       if (!ret)
> > > > > +       if (!ret) {
> > > > > +               event->pending_kill =3D 0;
> > > > >                 return;
> > > > > +       }
> > > >
> > > > What's the distinction between event->pending_kill and
> > > > event->pending_wakeup? Should we do something about pending_wakeup?
> > > > Asking out of complete ignorance of all these perf specifics.
> > > >
> > >
> > > I think zeroing pending_kill is enough.. when it's set the perf code
> > > sets pending_wakeup to call perf_event_wakeup in irq code that wakes
> > > up event's ring buffer readers and sends sigio if pending_kill is set
> >
> > Right, IIUC pending_wakeup is set by the ring buffer code when
> > a task is waiting for events and it gets enough events (watermark).
> > So I think it's good for ring buffer to manage the pending_wakeup.
> >
> > And pending_kill is set when a task wants a signal delivery even
> > without getting enough events.  Clearing pending_kill looks ok
> > to suppress normal signals but I'm not sure if it's ok for SIGTRAP.
> >
> > If we want to handle returning 0 from bpf as if the event didn't
> > happen, I think SIGTRAP and event_limit logic should be done
> > after the overflow handler depending on pending_kill or something.
>
> I'm not sure which kernel version this is for, but in recent kernels,
> the SIGTRAP logic was changed to no longer "abuse" event_limit, and
> uses its own "pending_sigtrap" + "pending_work" (on reschedule
> transitions).
>
> Thanks,
> -- Marco

The patch was prepared against a 6.7 release candidate.

- Kyle
