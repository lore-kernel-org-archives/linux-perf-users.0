Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="NzKiYhUG"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611D183
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 11:19:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c09ba723eso32900645e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701803980; x=1702408780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUiWMelRtaSuKf34GWZl1zdeJXOb8CJdDd8iB0u/KdQ=;
        b=NzKiYhUG3/30cqMl1wP20PgByu3nBeV1ZrmmYJH0LxIlE5ZGZn7aldYh11jnL4+xRb
         vwAxDHBRKgxub3444p7u+UZ70ADJUamd1NiL2RB9eg5Sv+TH56WUrIYOcu9DfdWmKyia
         XrUdeWOaw8B5N5lIgiirr7BKbplC5QC4m80lYnRP6JKWTPRky7n65JGrrfStH2B0FrLe
         zs9hXAY1YJ1HQotkUr/mcSCm/+6ZJSUdidT9NExDOLPJZu9Ngi4TTTaOMa/QdyfxBfNE
         qFKf9F6mPt04eETuCOtWYEMehu8ocT6yux/S9zrq6OiXijPlXtoRCdl2DVcNozcMF7XV
         vdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803980; x=1702408780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUiWMelRtaSuKf34GWZl1zdeJXOb8CJdDd8iB0u/KdQ=;
        b=LfWbjNvAcf/07yej74b3vkyjfDO4E5Ri7yZ/ofvrlrsboP2B4V+khCsTSdCuz3jVw0
         p2QyGUHh5s1xEqRcb0YL2y7ZXy0mVNA6QyAtK/S3eYhr8Ggy1BNjnMz4gRqMkUuG63oi
         OdvrMwRgWWnfMHouYsxRQnNIM+tj4O0XngQk8uZQA5aAA5GSdD79kUIk5UHHbs4MO1yp
         /BfnI1TeOIA+V1yekNXq1Lj0ubB8F8GEVBtR9TSrlNTPYxk0Qnr0/R2iBwiXKpkngFe2
         xTAT5GW2gYIx9d3JQNupNJDsdJdvaEaAC6NackBwPjeKO6y1btIRjwMSiXIVeCH6GRxg
         d2vg==
X-Gm-Message-State: AOJu0YwIIJhgt19QFf5KToN9GzRRMAfSjhxdac+aU7jvDmZmh0rOtXgF
	vOLTprvDwRk3VJyuTRhFkUbzhYp1j6NhArD71HyZnQ==
X-Google-Smtp-Source: AGHT+IH+Hos519sOnl3NFDQt1BOFxg9pV0N8ECT+kj4/IauNLCyqB8YB4Jeyfnu7/ed6Lvxgf776B+v7gWN3J0pqAd0=
X-Received: by 2002:a05:600c:2d8c:b0:40b:5e4a:4086 with SMTP id
 i12-20020a05600c2d8c00b0040b5e4a4086mr790606wmg.166.1701803980483; Tue, 05
 Dec 2023 11:19:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204201406.341074-1-khuey@kylehuey.com> <20231204201406.341074-2-khuey@kylehuey.com>
 <CAEf4BzYtSXtgdO9C2w9OOKni68H-7UOExFJRBEij3HG2Qwn1Rg@mail.gmail.com>
 <ZW8Gi2QI5ceAJfab@krava> <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
In-Reply-To: <CAM9d7chztaCfDsxfyJ2q_UmD=y20BFikCUQhs=LR8wsNV6pMjg@mail.gmail.com>
From: Kyle Huey <me@kylehuey.com>
Date: Tue, 5 Dec 2023 11:19:28 -0800
Message-ID: <CAP045AooA7mpk+uac-+JxP-PJX2fguVSKK+8o=qSB4p5LDtz6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	"Robert O'Callahan" <robert@ocallahan.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:07=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> Add Marco Elver to CC.
>
> On Tue, Dec 5, 2023 at 3:16=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
> >
> > On Mon, Dec 04, 2023 at 02:18:49PM -0800, Andrii Nakryiko wrote:
> > > On Mon, Dec 4, 2023 at 12:14=E2=80=AFPM Kyle Huey <me@kylehuey.com> w=
rote:
> > > >
> > > > Returning zero from a bpf program attached to a perf event already
> > > > suppresses any data output. This allows it to suppress I/O availabi=
lity
> > > > signals too.
> > >
> > > make sense, just one question below
> > >
> > > >
> > > > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > > > ---
> > > >  kernel/events/core.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index b704d83a28b2..34d7b19d45eb 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct pe=
rf_event *event,
> > > >         rcu_read_unlock();
> > > >  out:
> > > >         __this_cpu_dec(bpf_prog_active);
> > > > -       if (!ret)
> > > > +       if (!ret) {
> > > > +               event->pending_kill =3D 0;
> > > >                 return;
> > > > +       }
> > >
> > > What's the distinction between event->pending_kill and
> > > event->pending_wakeup? Should we do something about pending_wakeup?
> > > Asking out of complete ignorance of all these perf specifics.
> > >
> >
> > I think zeroing pending_kill is enough.. when it's set the perf code
> > sets pending_wakeup to call perf_event_wakeup in irq code that wakes
> > up event's ring buffer readers and sends sigio if pending_kill is set
>
> Right, IIUC pending_wakeup is set by the ring buffer code when
> a task is waiting for events and it gets enough events (watermark).
> So I think it's good for ring buffer to manage the pending_wakeup.
>
> And pending_kill is set when a task wants a signal delivery even
> without getting enough events.  Clearing pending_kill looks ok
> to suppress normal signals but I'm not sure if it's ok for SIGTRAP.
>
> If we want to handle returning 0 from bpf as if the event didn't
> happen, I think SIGTRAP and event_limit logic should be done
> after the overflow handler depending on pending_kill or something.

Hmm, yes, perhaps. The SIGTRAP thing (which I was previously unaware
of) would actually be more useful to us than an I/O signal.

I am slightly wary that event_limit appears to have no tests in the kernel =
tree.

- Kyle

> Thanks,
> Namhyung
