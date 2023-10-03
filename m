Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD43E48B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 23:02:31 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EDCC;
	Tue,  3 Oct 2023 16:02:29 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1027696a12.1;
        Tue, 03 Oct 2023 16:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696374148; x=1696978948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc75ZLj27HqA99qp9BegB2tmAdW+msTPeqxif7xbAds=;
        b=c3iTPSvpAIuxsy5yNxtHdeeDfrqN4j2fN9yJYyNj0UZxdwCdaEOZ/KTTQJY53ZBenb
         VPi3lP+1MzPnL6hv6FralCteLDvZ2etoyBYP01gROD3XyOfK2ODccFKq8FmChy/h+n07
         AGHl8BjTf/d2Eh5bHZ+t/RaOIijqi6cTUG9AHsStGEz5lXgusXYhc3i61THXCaHN6dCH
         u78CQ7zJ1tb8XXRq1zbbV1tfS/izc4xu9BZeq1UVQp2Zlv/ot3EfiFUqmudk5ksUe7gV
         RH5gajfam9H2lbh54Oram2mHhQd/bOU5HW+1H3/vgd0WLWNZ7IM5DgdOgWqGtG+VKH3i
         /1/g==
X-Gm-Message-State: AOJu0Yy28/Ry0D/WHMXcWv9J0Q19cHeEJcFhO7Vc/f6xXS8H89SwpuTT
	2KstOuYiXujs78aDqCgT4f6+6vdYYTBbeaEQ7I8=
X-Google-Smtp-Source: AGHT+IGAkoQiMFTXkbVvOxFELSTwKSi5Kx8u6/d/wdATKmcGrHUGgEhpNZTlcEuSPPK+Aj0GSgPlI+1C0Cy+KHRn7K8=
X-Received: by 2002:a17:90a:c293:b0:268:18e:9dfa with SMTP id
 f19-20020a17090ac29300b00268018e9dfamr731538pjt.5.1696374148336; Tue, 03 Oct
 2023 16:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
 <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
 <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com> <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 3 Oct 2023 16:02:16 -0700
Message-ID: <CAM9d7cjJxR5bvx5UvywEkwazkzpRZiKo8s7GLWutNiBKYa1J7g@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To: Ian Rogers <irogers@google.com>
Cc: Mingwei Zhang <mizhang@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong1@huawei.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 3, 2023 at 1:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
> >
> > Hello,
> >
> > On Wed, Sep 20, 2023 at 10:05=E2=80=AFPM Mingwei Zhang <mizhang@google.=
com> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@goog=
le.com> wrote:
> > > > > Thank you very much for the change. I have one quick question abo=
ut
> > > > > the PMU unthrottling logic. When I am looking into the function
> > > > > perf_adjust_freq_unthr_context(), I see the loop with PMU stop an=
d
> > > > > start in each iteration. Is there a good way to avoid this PMU re=
set
> > > > > operation while quickly figuring out the event in frequency mode?
> > > >
> > > > Agreed. I think before the pmu_disable could be avoided for this co=
ndition:
> > > > ```
> > > > if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
> > > >     (!event->attr.freq || !event->attr.sample_freq))
> > > >         continue;
> > > > ```
> > > > Fixing up the event stop/start looks harder.
> > > >
> > >
> > > Right, I think putting the check early before pmu_disable() is alread=
y
> > > a great optimization. The only concern I initially had was whether
> > > event->hw.interrupts can be accessed before we disable the pmu. But
> > > after checking this field in other locations, I don't see any problem
> > > at all.
> >
> > The event->hw.interrupts would be increased in the NMI handler
> > so there is a race between the check and the NMI.  That's why
> > I think it checks that after disabling the PMU.
> >
> > But I think we can skip non-sampling events for sure.  Then it
> > would be better to set attr.sample_period =3D 0 rather than attr.freq.
> >
> >     if (!is_sampling_event(event))
> >         continue;
> >
> >     perf_pmu_disable(event->pmu);
> >     ...
> >
> > Thanks,
> > Namhyung
>
> With the PMU disabled, isn't there still a risk of an interrupt still
> being in flight? In other words the disable doesn't prevent a race and
> we'll catch this on the next timer call to
> perf_adjust_freq_unthr_context. I think we can also improve the code
> by just disabling a PMU once, we can take advantage of the
> perf_event_pmu_context and disable that PMU, iterate its events and
> then re-enable the PMU - i.e. no need for an enable and disable per
> event. I'll put a patch together.

Thanks, I was thinking about that too.  It's also a side effect of
the context rewrite.  Maybe we could iterate pmu_ctx's active lists
and skip pmus with PERF_PMU_CAP_NO_INTERRUPT and
individual non-sampling events.

Thanks,
Namhyung
