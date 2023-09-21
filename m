Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CA20310
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Sep 2023 18:57:10 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35BCD7
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Sep 2023 11:56:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578af21ff50so927283a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Sep 2023 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322612; x=1695927412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rIvdiurpDX362nIy+5uMijXXxEn3T8WYHLicLPORFs=;
        b=YclrvdPvRGQ3LuZr0qL4s5tTvjtqr4nW+ax/1kszNIbGrNJnsq1VRxqX5VEjm3EHwZ
         zjZCK1+MUZUPhRZQ2OyseZ7pFpgyQv2VMQuFRvjdtS3b/9DtvedQ94lkBwBD8NE9/fzR
         5KY2UXcMWeywIDk1s9tHDNCyMrHju3yLLDFEmlVE0MUEpaNlqDmeK/gk70A0qVcqj2tf
         eyz94E5q7AzCvZ+WPO9LGbA8bRvHCxh4YE4E150M3Gyu2Ja29/zVlD0KIL1ayXaV/r4r
         pbPY1c3Fi7QYqEiAZoZhxDCC5tPGzYmB8ZFjKFzVcr5wdd2+ofWT62AHzOCql3VGLt5P
         Htiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322612; x=1695927412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rIvdiurpDX362nIy+5uMijXXxEn3T8WYHLicLPORFs=;
        b=T70FVgI2u5bG5ner2EvzqDWkLLGdwqh1ZTVCXNHVJEH+2V22Ov/WO69WBmowJPlK7w
         UZdZFaoficwFi/7URMLY35i8VrtY4NWswidDufgBH91sG5QPH+bXJQewM3Ee933L4bK+
         yBv82dbC9Bg2TrFleaeZRIi7ljlbwI8eX4rSITqkSTSZCmTXpiKPRBG5uEVGljv31TSX
         posODIzikOi7lq3smU793HuAXTkvsVjOHhHk3ageTil9PziGPdGSqjFBF0XBVzzacH5M
         eNDoOnai1F3AFfhzf7SP6Wh4ba8jJB4qmdvfdgxUwlmxcijuhz+9Ha362w87pkTeaOHE
         7pUg==
X-Gm-Message-State: AOJu0Yyia76eaF78UvAUwDglfPV2QEZo5aibQo89ajudXbEEsAPvVQq6
	WdQNavJ2D0VwPJ6Ua6D0VxYi+ndrnX/77YpchAhj5uLTDsu2tQ1/aHE=
X-Google-Smtp-Source: AGHT+IEG/d5rseIUQeHqQWPyJevlx2AboGo3Glp1ZdN2saaWqtKL3E8KeHANDNwuTkw1eosfVo+UqML7Yj40hU35jIw=
X-Received: by 2002:a05:6214:a13:b0:64f:50c2:d57a with SMTP id
 dw19-20020a0562140a1300b0064f50c2d57amr4385539qvb.28.1695272709362; Wed, 20
 Sep 2023 22:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
In-Reply-To: <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 20 Sep 2023 22:04:33 -0700
Message-ID: <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@google.com=
> wrote:
> >
> > On Fri, Sep 15, 2023 at 9:10=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > Dummy events are created with an attribute where the period and freq
> > > are zero. evsel__config will then see the uninitialized values and
> > > initialize them in evsel__default_freq_period. As fequency mode is
> > > used by default the dummy event would be set to use frequency
> > > mode. However, this has no effect on the dummy event but does cause
> > > unnecessary timers/interrupts. Avoid this overhead by setting the
> > > period to 1 for dummy events.
> > >
> > > evlist__add_aux_dummy calls evlist__add_dummy then sets freq=3D0 and
> > > period=3D1. This isn't necessary after this change and so the setting=
 is
> > > removed.
> > >
> > > From Stephane:
> > >
> > > The dummy event is not counting anything. It is used to collect mmap
> > > records and avoid a race condition during the synthesize mmap phase o=
f
> > > perf record. As such, it should not cause any overhead during active
> > > profiling. Yet, it did. Because of a bug the dummy event was
> > > programmed as a sampling event in frequency mode. Events in that mode
> > > incur more kernel overheads because on timer tick, the kernel has to
> > > look at the number of samples for each event and potentially adjust
> > > the sampling period to achieve the desired frequency. The dummy event
> > > was therefore adding a frequency event to task and ctx contexts we ma=
y
> > > otherwise not have any, e.g., perf record -a -e
> > > cpu/event=3D0x3c,period=3D10000000/. On each timer tick the
> > > perf_adjust_freq_unthr_context() is invoked and if ctx->nr_freq is
> > > non-zero, then the kernel will loop over ALL the events of the contex=
t
> > > looking for frequency mode ones. In doing, so it locks the context,
> > > and enable/disable the PMU of each hw event. If all the events of the
> > > context are in period mode, the kernel will have to traverse the list=
 for
> > > nothing incurring overhead. The overhead is multiplied by a very larg=
e
> > > factor when this happens in a guest kernel. There is no need for the
> > > dummy event to be in frequency mode, it does not count anything and
> > > therefore should not cause extra overhead for no reason.
> > >
> > > Fixes: 5bae0250237f ("perf evlist: Introduce perf_evlist__new_dummy c=
onstructor")
> > > Reported-by: Stephane Eranian <eranian@google.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evlist.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index 25c3ebe2c2f5..e36da58522ef 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -251,6 +251,9 @@ static struct evsel *evlist__dummy_event(struct e=
vlist *evlist)
> > >                 .type   =3D PERF_TYPE_SOFTWARE,
> > >                 .config =3D PERF_COUNT_SW_DUMMY,
> > >                 .size   =3D sizeof(attr), /* to capture ABI version *=
/
> > > +               /* Avoid frequency mode for dummy events to avoid ass=
ociated timers. */
> > > +               .freq =3D 0,
> > > +               .sample_period =3D 1,
> > >         };
> > >
> > >         return evsel__new_idx(&attr, evlist->core.nr_entries);
> > > @@ -277,8 +280,6 @@ struct evsel *evlist__add_aux_dummy(struct evlist=
 *evlist, bool system_wide)
> > >         evsel->core.attr.exclude_kernel =3D 1;
> > >         evsel->core.attr.exclude_guest =3D 1;
> > >         evsel->core.attr.exclude_hv =3D 1;
> > > -       evsel->core.attr.freq =3D 0;
> > > -       evsel->core.attr.sample_period =3D 1;
> > >         evsel->core.system_wide =3D system_wide;
> > >         evsel->no_aux_samples =3D true;
> > >         evsel->name =3D strdup("dummy:u");
> > > --
> > > 2.42.0.459.ge4e396fd5e-goog
> > >
> >
> > Thank you very much for the change. I have one quick question about
> > the PMU unthrottling logic. When I am looking into the function
> > perf_adjust_freq_unthr_context(), I see the loop with PMU stop and
> > start in each iteration. Is there a good way to avoid this PMU reset
> > operation while quickly figuring out the event in frequency mode?
>
> Agreed. I think before the pmu_disable could be avoided for this conditio=
n:
> ```
> if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
>     (!event->attr.freq || !event->attr.sample_freq))
>         continue;
> ```
> Fixing up the event stop/start looks harder.
>

Right, I think putting the check early before pmu_disable() is already
a great optimization. The only concern I initially had was whether
event->hw.interrupts can be accessed before we disable the pmu. But
after checking this field in other locations, I don't see any problem
at all.

Thanks.
-Mingwei
