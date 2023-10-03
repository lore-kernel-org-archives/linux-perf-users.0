Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFD3CD09
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 20:08:13 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BAEA1;
	Tue,  3 Oct 2023 13:08:11 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3af5fd13004so906256b6e.0;
        Tue, 03 Oct 2023 13:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363691; x=1696968491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1L7JTll2iZg4TpN2jgrHscBi0WZs33vPmuyNsxvOfNo=;
        b=AzRUI7/xe+MXKnw/KPJVUJ0A58df4gaRkpqRfkAE0fC3qBv/gJSerUruTAusqRnLHS
         SfgNDpoGLFTKmJbouBOQt4Ykvk3hMoj9lx6DH4jvao0cXGOV169eJK04yUarxOfBOxbw
         mZ4ewM4CitGGrgmv4Sa5oKDjmODmTj2jpg5pPa9oJ6Je3ir4VGg5dUvUP6JJiCEJ9tLL
         5OVeeefzQEv235+y4UD56cwEQh5lry0n3D7zfYedJYvwwabuJJOBTftMukZVUAgyY0I8
         vSA/R6IcT8hp2/tUVp902MMpwXv33P2KPMUuT1uVZsF/yZRHXGsdyJKAxWcn+k6MZiu8
         +KOQ==
X-Gm-Message-State: AOJu0YzkhuxkS7wBOVFouyzUhUqMA7Bv6yEQ77hm+vvDB/ypKbSdTePI
	kK5lwkbOpHkFHikYClLxxwRakx12ToFDZoMyzuE=
X-Google-Smtp-Source: AGHT+IEvFmLOJnmgZT9/huzr+lyWE9YoYca94R5FI0tVfrqnzYWNE2s0hf91+akXZEvrFXRBJeH4xZMrp9nqTIHyOcQ=
X-Received: by 2002:a05:6808:1b1f:b0:3ae:2877:9b31 with SMTP id
 bx31-20020a0568081b1f00b003ae28779b31mr652430oib.20.1696363690891; Tue, 03
 Oct 2023 13:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com> <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
In-Reply-To: <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 3 Oct 2023 13:07:59 -0700
Message-ID: <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To: Mingwei Zhang <mizhang@google.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong1@huawei.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Wed, Sep 20, 2023 at 10:05=E2=80=AFPM Mingwei Zhang <mizhang@google.com>=
 wrote:
>
> On Mon, Sep 18, 2023 at 3:43=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Sat, Sep 16, 2023 at 5:46=E2=80=AFPM Mingwei Zhang <mizhang@google.c=
om> wrote:
> > > Thank you very much for the change. I have one quick question about
> > > the PMU unthrottling logic. When I am looking into the function
> > > perf_adjust_freq_unthr_context(), I see the loop with PMU stop and
> > > start in each iteration. Is there a good way to avoid this PMU reset
> > > operation while quickly figuring out the event in frequency mode?
> >
> > Agreed. I think before the pmu_disable could be avoided for this condit=
ion:
> > ```
> > if (event->hw.interrupts !=3D MAX_INTERRUPTS &&
> >     (!event->attr.freq || !event->attr.sample_freq))
> >         continue;
> > ```
> > Fixing up the event stop/start looks harder.
> >
>
> Right, I think putting the check early before pmu_disable() is already
> a great optimization. The only concern I initially had was whether
> event->hw.interrupts can be accessed before we disable the pmu. But
> after checking this field in other locations, I don't see any problem
> at all.

The event->hw.interrupts would be increased in the NMI handler
so there is a race between the check and the NMI.  That's why
I think it checks that after disabling the PMU.

But I think we can skip non-sampling events for sure.  Then it
would be better to set attr.sample_period =3D 0 rather than attr.freq.

    if (!is_sampling_event(event))
        continue;

    perf_pmu_disable(event->pmu);
    ...

Thanks,
Namhyung
