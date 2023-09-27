Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2959195
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 01:00:59 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5C416EBE;
	Tue, 26 Sep 2023 18:00:58 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-79fe6da0049so61656739f.1;
        Tue, 26 Sep 2023 18:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695776457; x=1696381257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9+1nCO1D5B1eQeTJpZBJNL5I9g9vcwJsTUle11cEt4=;
        b=d2yf7qEBXKdRMjn3OB74W2qaJJkGfJPfZoK+LJZ5HHA2AYP9GzluioRWR1mebY3bbo
         fePW676RyRDBFLmWvEGvFshZoQR76VoKOMWYU5DgIH72Ez4Qj1UgGopRxn9TxWA22rXQ
         Bl+xyZIST1Kr9Xlal7EvOfPFErBDL+Wbk0K7rrWtttOuvAF2gGdaKbIfJtyL3Stj9hh+
         cDPhTTZP/ytmw3g1jco6IZLysjKGf4/p6Pr7U/HHxlYAiFgBkRbjfl+Y3KaOr1XDY4IN
         Ttj/aXZtxzgRrEmqwrZbdH2AaLv3V1bUOSox5iHuS7szaMg5uFgIpw6hySzZbkgkA9XP
         LrOQ==
X-Gm-Message-State: AOJu0YyszUI5rfkJm5pHDMSQdaLT9JUtJqODia6ZCnsb7N9/9nHiGNnc
	DN6fayIk2k1ZPuthZrpclPw1RB5fAIPREyr5wqE=
X-Google-Smtp-Source: AGHT+IGrl4MvN8IhXVvSTCRxo5yTkv3C8H24KaiHt8IC+9n0I5mzVpGiPcV2RurPqp45DxByroWLG3YOtKSUkbfKQmA=
X-Received: by 2002:a6b:916:0:b0:792:6fb7:5d8f with SMTP id
 t22-20020a6b0916000000b007926fb75d8fmr493590ioi.18.1695776457212; Tue, 26 Sep
 2023 18:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWuaii1rOOvN7rJDo3UoQvkEtiJv3QiBhLRhYk1_Se7ew@mail.gmail.com> <f4812cce-14d2-9771-233f-b0db5af449be@linux.alibaba.com>
In-Reply-To: <f4812cce-14d2-9771-233f-b0db5af449be@linux.alibaba.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 18:00:46 -0700
Message-ID: <CAM9d7cjjSJybJEbSdBkVH3qx7RDqriv4tqBCNw1Yi9bAeUf3Yw@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add metrics for Arm CMN
To: Jing Zhang <renyu.zj@linux.alibaba.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, Zhuo Song <zhuo.song@linux.alibaba.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Mon, Sep 25, 2023 at 8:15=E2=80=AFPM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
>
>
> =E5=9C=A8 2023/9/26 =E4=B8=8A=E5=8D=8812:37, Ian Rogers =E5=86=99=E9=81=
=93:
> > On Sun, Sep 24, 2023 at 10:58=E2=80=AFPM Jing Zhang <renyu.zj@linux.ali=
baba.com> wrote:
> >>
> >> Changes since v8:
> >> - Add fully match identifier check as suggested by Ian.
> >> - Link: https://lore.kernel.org/lkml/1695037955-107983-1-git-send-emai=
l-renyu.zj@linux.alibaba.com/
> >>
> >> Jing Zhang (7):
> >>   perf pmu: "Compat" supports regular expression matching identifiers
> >>   perf metric: "Compat" supports regular expression matching identifie=
rs
> >>   perf jevents: Support EventidCode and NodeType
> >>   perf test: Make matching_pmu effective
> >>   perf test: Add pmu-event test for "Compat" and new event_field.
> >>   perf jevents: Add support for Arm CMN PMU aliasing
> >>   perf vendor events: Add JSON metrics for Arm CMN
> >
> > Thanks for the patience with all the to and fro. I was able to test
> > the series with "git am -3" to get around a merge issue on
> > perf-tools-next.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Tested-by: Ian Rogers <irogers@google.com>
> >
>
> Thank you for following this series and providing many valuable suggestio=
ns.

It's not applied cleanly.  Can you please rebase onto the current
tmp.perf-tools-next branch in the following tree?

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

Thanks,
Namhyung
