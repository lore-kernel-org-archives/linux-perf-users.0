Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306157D3EC;
	Tue, 11 Jun 2024 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131772; cv=none; b=FjUg8JS8Ox+d5F1U1CZ3pbm9WBB4J2a0mv9/78chXxpRTGWnGQTfpZCEw5vsn86ukVn9Zfa4DFfLaLxWCYG43Wn4wdyjfZy5/41TtmB88IeOQD2Sf/sNh5K/kQcQjN9Vn8rFAg8RU5QiY5DDcyEXeSUlpp38Z4/1iORbj7r3c3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131772; c=relaxed/simple;
	bh=9AfnrOzuFVouB318icoJVfUNjCv/vLkWwc2/t4eGvuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhnMVDsrYFTSq/AsA4ANOxIy+6giVzyat0YTvSYgx89YrV50WyfAv7+CFt9p+yD77r+i7VJSTttXRb3nrGQjJg8FAv8ZTYVUCbLkYYvAVhaP7RAFzfaIWbAa0SM6S+QbIQKqLBlbgnzjkaQP2ZdUeAjNOqB+TweBlD+ziSIL68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6c4926bf9baso4470425a12.2;
        Tue, 11 Jun 2024 11:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131770; x=1718736570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=is/wNlrYWOG5ah0bo7/hYWjp3j6+EGYQ6aiKUz1KB8I=;
        b=vIZPCa+khtV+WjUjJ9Cga4qyXZAshLPhyr3Z88MtHEB0FGmdQ9Ygk2UiYZCAi4sUCI
         PwO5LmMR3Mq2AszKT3isWROZqzl+uujkqlgxBN9RMWz4RRWis/v4PQhou8a8X9t9DSS+
         kQGn/KBMnZFruDB3snlOa+MjI6rgVW8KwdUqtCbBmzNewznEOqokt3GGR4OkHQ+0oJdn
         F2hkV0S80hZd/X5NY8QKG90Aa9eacleo/+HE2VxliNiGGFUIOIw8EfrpdR/iCBvDlEnp
         hCclDVBRBj8yLHS0AALUumi9bkAuCUIkh4RVB7ptoGFD9SVmzm3p39vHawfCSC00SPDp
         xgZw==
X-Forwarded-Encrypted: i=1; AJvYcCXb1Qlq438PVv9nAeNQmTfN/AXLInR/iNPX6zAxuVgRK7GLks0Nma+TAaOTTA5slpiq5mXzdIy6HBAleXdJ+kAeHk0ojFiaOSIQ51fyxPZBrR/xO1y6XIdWqiGbBss8NCpUuikdpIWDiEAFl6nWOw==
X-Gm-Message-State: AOJu0YypGahzgokdux2bAZM/wtAD0vDDkvYkZ8GcmuFr1ShJwvkpYZcc
	GIsrVX7AN9oczZ3xN83WnjELMAiBsBQEe4gMLtsKoWBIxf3sUoqQp14td3tZSzzUEfHnVJCC5rK
	FUc8XCeYpuVF4gsMOH4HsXBB8/tQ=
X-Google-Smtp-Source: AGHT+IHB4wFeU6pQK1jde8hS48Gmzb8jJq4LB6e2QpaNOTAqRlrskBnhBOTIUPKtDfWd/5JDxKYI9lnJJmx8UnxXS8U=
X-Received: by 2002:a05:6a20:1589:b0:1b8:498e:4e34 with SMTP id
 adf61e73a8af0-1b8498e4ff1mr4858776637.34.1718131770346; Tue, 11 Jun 2024
 11:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611052331.85715-1-weilin.wang@intel.com> <20240611052331.85715-7-weilin.wang@intel.com>
 <CAM9d7chQFeqCFJAfnRFKkQkxyRtOotF3kE49tL47EuEEBC_RkA@mail.gmail.com> <CO6PR11MB56353719739D822626369453EEC72@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56353719739D822626369453EEC72@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 11 Jun 2024 11:49:18 -0700
Message-ID: <CAM9d7cipkoRSDkw2FEE4UN6a_W7Y5E1XBvKHa4GWsJNqm8qNhA@mail.gmail.com>
Subject: Re: [RFC PATCH v12 6/8] perf stat: Add command line option for
 enabling tpebs recording
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:49=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Tuesday, June 11, 2024 9:50 AM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v12 6/8] perf stat: Add command line option for
> > enabling tpebs recording
> >
> > Hello,
> >
> > On Mon, Jun 10, 2024 at 10:24=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > With this command line option, tpebs recording is turned off in perf =
stat on
> > > default. It will only be turned on when this option is given in perf =
stat
> > > command.
> > >
> > > Exampe with --enable-tpebs-recording:
> > >
> > > perf stat -M tma_dtlb_store -a --enable-tpebs-recording sleep 1
> > >
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.000 MB - ]
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %
> > tma_dtlb_store
> > >          3,195,608      cpu_core/topdown-retiring/
> > >         40,156,649      cpu_core/topdown-mem-bound/
> > >          3,550,925      cpu_core/topdown-bad-spec/
> > >        117,571,818      cpu_core/topdown-fe-bound/
> > >         57,118,087      cpu_core/topdown-be-bound/
> > >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> > >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
> > >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> > >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> > >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> > >                  0      MEM_INST_RETIRED.STLB_HIT_STORES:R
> >
> > Here I guess we can expect a non-zero value, right?
>
> Hi Namhyung,
>
> Do you mean when we have the option, we should expect non-zero value?
> During the execution, it's possible that we don't capture any sample on t=
his
> event. In this case, we would have a zero value. In the future, I think w=
e will
> give it the default value instead of zero.

I mean there's a chance you get non-zero, but it can be zero sometimes, rig=
ht?
Then I think it's better to choose non-zero in this example otherwise it's =
not
clear what's the difference of using this option or not when you look at th=
e
output in this commit message (they are both 0).

Thanks,
Namhyung

>
> >
> > >
> > >        1.003105924 seconds time elapsed
> > >
> > > Exampe without --enable-tpebs-recording:
> > >
> > > perf stat -M tma_dtlb_store -a sleep 1
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %
> > tma_dtlb_store
> > >          3,195,608      cpu_core/topdown-retiring/
> > >         40,156,649      cpu_core/topdown-mem-bound/
> > >          3,550,925      cpu_core/topdown-bad-spec/
> > >        117,571,818      cpu_core/topdown-fe-bound/
> > >         57,118,087      cpu_core/topdown-be-bound/
> > >             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
> > >              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
> > >         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
> > >         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
> > >            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
> > >                  0      MEM_INST_RETIRED.STLB_HIT_STORES:R
> > >
> > >        1.003105924 seconds time elapsed
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  tools/perf/builtin-stat.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 14be132f7b6f..055139e44763 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -1235,6 +1235,8 @@ static struct option stat_options[] =3D {
> >
> > What's the base of your patchset?  I think we moved this to cmd_stat().
> > Please make sure to rebase on the perf-tools-next.
>
> This was rebased on top of Ian's change for the tool event and retire_lat=
ency parser
> patches. I think that was on tmp.perf-tools.next. I will rebase on perf-t=
ools-next.
>
> >
> >
> > >                        "disable adding events for the metric threshol=
d calculation"),
> > >         OPT_BOOLEAN(0, "topdown", &topdown_run,
> > >                         "measure top-down statistics"),
> > > +       OPT_BOOLEAN(0, "enable-tpebs-recording", &tpebs_recording,
> > > +                       "enable recording for tpebs when retire_laten=
cy required"),
> >
> > Please update the documentation (man page) for this option.
> >
> > Also I'm afraid it'd fail to build on non-x86 because tpebes_recording
> > is defined in intel-tpebs.c.
> >
>
> Yes, you are right. I forgot about non-x86. I will update this and also t=
he
> Documentation.
>
> Thanks,
> Weilin
>
> > Thanks,
> > Namhyung
> >
> >
> > >         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> > >                         "Set the metrics level for the top-down stati=
stics (0: max level)"),
> > >         OPT_BOOLEAN(0, "smi-cost", &smi_cost,
> > > --
> > > 2.43.0
> > >
