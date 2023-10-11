Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C218B04
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395529D;
	Wed, 11 Oct 2023 09:10:04 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-58907163519so5286778a12.1;
        Wed, 11 Oct 2023 09:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040603; x=1697645403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ+VIPsKS+z6FGqu1gSOMc5oXv3t+KffR0mpRHqGu2k=;
        b=Qnt7cxb2+eM6qJMUL016LqFSXptG2Bhc10IkBoSkIvA0rBgbQeju1cWpAjAOmjrDIC
         IpkapYAM3PsCniNBB2Bj/b4JJZfU68AxrgdlzHBSDmCIo1QReWXjr3oIhUqWcfhUo3Q/
         xk8IwzB3adxgtfWLjb+p64S8DW0VnSPbUDk/vWV9va/ZL02QL9SiKGIhhskmUt1INn9H
         Zs84ctjkeucnb82tt7FKaNM/ZLb5hdevIpIxMWhXhfp+cwPK8fLCaRXKUjzcjc28pCxT
         coZJczebIVxz7My3c1byKN2QYYeciOG862///+FQN0vOJdb0xD7caXHSlzVIoL1NaRSc
         blhA==
X-Gm-Message-State: AOJu0Yxwxb9BeyQWRiDNYbEWd32jpJxv8lPb2RQ2VPqsFhXkuEtzN8yi
	4OZYSoiNVhxXSAlb3AXrrGNta7abSGFGlAJo9Ds=
X-Google-Smtp-Source: AGHT+IHnjfzk1SghAsiF23/gGQQawTqA4BpkDSmSW28ox1CFLYnmzEXivE6eYPQlyskK5f+u1Eo/7e7ICRMkd0hM8rU=
X-Received: by 2002:a17:90b:ecc:b0:27d:a59:ebae with SMTP id
 gz12-20020a17090b0ecc00b0027d0a59ebaemr1571538pjb.46.1697040603539; Wed, 11
 Oct 2023 09:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
 <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
 <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com>
 <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com> <CAL715WJ8w+q_=0_NVZJ=rs0GLs=pYqDiRLcCxxO0gDcGdcvZnw@mail.gmail.com>
In-Reply-To: <CAL715WJ8w+q_=0_NVZJ=rs0GLs=pYqDiRLcCxxO0gDcGdcvZnw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 11 Oct 2023 09:09:51 -0700
Message-ID: <CAM9d7ci-G-+FFPsKbMzzSzCr2kS75axYHFDm2=f6TxUk=dM_CA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To: Ian Rogers <irogers@google.com>, Mingwei Zhang <mizhang@google.com>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong1@huawei.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Tue, Oct 3, 2023 at 4:20=E2=80=AFPM Mingwei Zhang <mizhang@google.com> w=
rote:
>
> On Tue, Oct 3, 2023 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Tue, Oct 3, 2023 at 1:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Sep 20, 2023 at 10:05=E2=80=AFPM Mingwei Zhang <mizhang@googl=
e.com> wrote:
> > > >
> > > > On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@go=
ogle.com> wrote:
> > > > > > Thank you very much for the change. I have one quick question a=
bout
> > > > > > the PMU unthrottling logic. When I am looking into the function
> > > > > > perf_adjust_freq_unthr_context(), I see the loop with PMU stop =
and
> > > > > > start in each iteration. Is there a good way to avoid this PMU =
reset
> > > > > > operation while quickly figuring out the event in frequency mod=
e?
> > > > >
> > > > > Agreed. I think before the pmu_disable could be avoided for this =
condition:
> > > > > ```
> > > > > if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
> > > > >     (!event->attr.freq || !event->attr.sample_freq))
> > > > >         continue;
> > > > > ```
> > > > > Fixing up the event stop/start looks harder.
> > > > >
> > > >
> > > > Right, I think putting the check early before pmu_disable() is alre=
ady
> > > > a great optimization. The only concern I initially had was whether
> > > > event->hw.interrupts can be accessed before we disable the pmu. But
> > > > after checking this field in other locations, I don't see any probl=
em
> > > > at all.
> > >
> > > The event->hw.interrupts would be increased in the NMI handler
> > > so there is a race between the check and the NMI.  That's why
> > > I think it checks that after disabling the PMU.
> > >
> > > But I think we can skip non-sampling events for sure.  Then it
> > > would be better to set attr.sample_period =3D 0 rather than attr.freq=
.
> > >
> > >     if (!is_sampling_event(event))
> > >         continue;
> > >
> > >     perf_pmu_disable(event->pmu);
> > >     ...
> > >
> > > Thanks,
> > > Namhyung
> >
> > With the PMU disabled, isn't there still a risk of an interrupt still
> > being in flight? In other words the disable doesn't prevent a race and
> > we'll catch this on the next timer call to
> > perf_adjust_freq_unthr_context. I think we can also improve the code
> > by just disabling a PMU once, we can take advantage of the
> > perf_event_pmu_context and disable that PMU, iterate its events and
> > then re-enable the PMU - i.e. no need for an enable and disable per
> > event. I'll put a patch together.
> >
> > Thanks,
> > Ian
>
> +Jim Mattson
>
> I initially thought this idea was just an alternative, or a more
> professional fix in the perf subsystem. I was wrong...
>
> This would be way better than just skipping frequency events in the
> loop. Since if we just skip by event, we may still suffer from huge
> overhead if the event list contains many sampling events in frequency
> mode. Unfortunately, that is the general case when we do perf record
> -e 'eventlist' (IIUC all events in eventlist are in frequency mode if
> we don't specify period=3D). So the problem actually remains whenever we
> do perf sampling unless we use something like Intel vtune.
>
> On the other hand, since all of the events are presumably CPU core
> events, with the fix we pay only once for the PMU reset per hrtimer
> regardless of how many events are in frequency mode.
>
> Looking forward to the patch! Please keep us posted if possible.

Any updates?

Thanks,
Namhyung
