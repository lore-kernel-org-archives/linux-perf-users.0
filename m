Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D91BAEF8
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727758606; cv=none; b=KdRDLDGrwNM2rw49OLqlNlqc8QUdDk3yZZQLSJwOfLoorJbgHCoqaYFYp5KpBoVwGO8Pt1Mft9o+yr2iRxg4EpwhXJ3VHrEang++TraeU8fnpg1IHrSMDWp6ri934AxJczF6UoIVoO3zVR+0JeT2VlUmb3jbLtUciG6/xW1AOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727758606; c=relaxed/simple;
	bh=LH8iE5CU0N90TO7QJlJSc/yP9jjavTjd20gasSfhNRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRFlziGbCkb2u42cKFWDOdoGfAmrwUzp6NSfyn3HXXxRtmFkzQCShZkjrgKHZGKebKHh4QKMdcQcCZ9OlU1h9frlxuA0ZAOoDmhTOAn5J8PdwnVrZ1D4okB11InnwzB1KMvfBcqgrucHaSYi1kZOa9D+BfSIg7k6mF6k7MhszJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SeL8o8/X; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeL8o8/X"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a1a662a633so135935ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727758603; x=1728363403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1+qgFsGryJ5x79x8Hk2ZoChE/T8qGFWaSyUn99N8jQ=;
        b=SeL8o8/XIK5GpfAd5UDHYuEUgtK99oXErgoeX/j0UgHh/VLL3+UiYl8HWahp+CW3hv
         0hkW5T9/XZrKuOUdoLtIQ3RP1lgNq0iRdygzT9D67mPtue0JJ6SuguniUApzS85GJ9NW
         nf1eRnDrYY8888wlwVeORxxOwThuZrafc3BiryG5mBqfBMD2pQSjfKrhK3sDv9AosXog
         euAoffRi6IHww5NgQeVHvPZl37vYNM4u3gpgoSeCGEhrOISEwSWBvILf1odUPZdJjsuc
         MjimSdCdM3AzmkHtqaD0GO/tk61CXNehUD+bYXM4Pf1m9OSG0vT8XIvFqVEj9xAPO96D
         3B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727758603; x=1728363403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1+qgFsGryJ5x79x8Hk2ZoChE/T8qGFWaSyUn99N8jQ=;
        b=qbvqB6zQlMeeALL5kDTripkwD78aR+6dKj5iklObUFjQCou28jDqvW6X8U4VNuErFX
         4fYwYKPpFr8+CTlh3Kg5Jut6aqCFUQPMbdVK82jKBY8htdLp9EO9ndm9IlGoS1JYh9jP
         Hzp5nL37d/IJmlRHqwWkvWjhkbeTmBNTBtU5qqQ7BAXtlqJCGzA2P/tERDx3w2u73rdS
         U5iTOmtL+8k3pqISHaILFUD2s9x0HWU0J7p8hY23qm1axI0BMmxO/qTnPa31eAlL42u5
         RCLS4/bPo2JPkxegzZ72Xs6NjA/7TdNKK6CY5gacjbMG4kz9ONr/hSImNhAiGSdht6Z3
         7nCw==
X-Forwarded-Encrypted: i=1; AJvYcCVOFgLVblAi8e8b5RmT6m7fXH5ZmMy8QSs/ssBMj2MKZSFYLuMGdPCLBS77TejchLFKl3BiuWzmKRiVQf/h8+cw@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnJ1DsV5aVHWKU8Xdq/zo5DHuSKyW8sG1zB7b8gbAsFUxTVYa
	Wz2sLZbp8uSMefWFNaFXet3qLub/5OtM9vGTu+aqfSVKw48UD5QBQGgHXl+Syn/Pj5Bu+WYwkAc
	VYjP5pWN7jtaCBh2C+ZMKrxzAGNQu/RWQ1wO7
X-Google-Smtp-Source: AGHT+IGa/2cotE2YIN+3vq/OT2cY3tIH1ECZsEx3QcfDxXZgnNka9B6o4fFI4IEtw1ObkiG83mDAXbtJka7KGyp5564=
X-Received: by 2002:a05:6e02:1d1b:b0:3a0:a3cd:f23d with SMTP id
 e9e14a558f8ab-3a3607ff697mr1372965ab.5.1727758603149; Mon, 30 Sep 2024
 21:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com> <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
 <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>
 <Zvbp3YCQLNBVWFmD@google.com> <CAP-5=fVigHrvtabp1T1HcLRn-LFwzOiShWP8qugtPfkO31u1sA@mail.gmail.com>
 <ZvkAA8NW_5ssmsuf@google.com>
In-Reply-To: <ZvkAA8NW_5ssmsuf@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Sep 2024 21:56:29 -0700
Message-ID: <CAP-5=fWfjU0yuOVn_FJ=qEWfWHZ6SG7BceaOp7KWG+iXS7Rapg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Tool and hwmon PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 12:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Sep 27, 2024 at 11:09:49AM -0700, Ian Rogers wrote:
> > On Fri, Sep 27, 2024 at 10:22=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Thu, Sep 26, 2024 at 12:47:26PM -0700, Ian Rogers wrote:
> > > > On Fri, Sep 13, 2024 at 7:34=E2=80=AFAM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > On Thu, Sep 12, 2024 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@ke=
rnel.org> wrote:
> > > > > >
> > > > > > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > > > > > Rather than have fake and tool PMUs being special flags in an=
 evsel,
> > > > > > > create special PMUs. This allows, for example, duration_time =
to also
> > > > > > > be tool/duration_time/. Once adding events to the tools PMU i=
s just
> > > > > > > adding to an array, add events for nearly all the expr litera=
ls like
> > > > > > > num_cpus_online. Rather than create custom logic for finding =
and
> > > > > > > describing the tool events use json and add a notion of commo=
n json
> > > > > > > for the tool events.
> > > > > > >
> > > > > > > Following the convention of the tool PMU, create a hwmon PMU =
that
> > > > > > > exposes hwmon data for reading. For example, the following sh=
ows
> > > > > > > reading the CPU temperature and 2 fan speeds alongside the un=
core
> > > > > > > frequency:
> > > > > > > ```
> > > > > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cp=
us_online/ -M UNCORE_FREQ -I 1000
> > > > > > >      1.001153138              52.00 'C   temp_cpu
> > > > > > >      1.001153138              2,588 rpm  fan1
> > > > > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > > > > >      1.001153138                  8      tool/num_cpus_online=
/
> > > > > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET    =
             #     1.08 UNCORE_FREQ
> > > > > > >      1.001153138      1,012,773,595      duration_time
> > > > > > > ...
> > > > > > > ```
> > > > > > >
> > > > > > > Additional data on the hwmon events is in perf list:
> > > > > > > ```
> > > > > > > $ perf list
> > > > > > > ...
> > > > > > > hwmon:
> > > > > > > ...
> > > > > > >   temp_core_0 OR temp2
> > > > > > >        [Temperature in unit coretemp named Core 0. crit=3D100=
'C,max=3D100'C crit_alarm=3D0'C. Unit:
> > > > > > >         hwmon_coretemp]
> > > > > > > ...
> > > > > > > ```
> > > > > > >
> > > > > > > v2: Address Namhyung's review feedback. Rebase dropping 4 pat=
ches
> > > > > > >     applied by Arnaldo, fix build breakage reported by Arnald=
o.
> > > > > > >
> > > > > > > Ian Rogers (13):
> > > > > > >   perf pmu: Simplify an asprintf error message
> > > > > > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > > > > > >   perf parse-events: Expose/rename config_term_name
> > > > > > >   perf tool_pmu: Factor tool events into their own PMU
> > > > > > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_even=
t
> > > > > > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > > > > > >   perf tool_pmu: Move expr literals to tool_pmu
> > > > > > >   perf jevents: Add tool event json under a common architectu=
re
> > > > > > >   perf tool_pmu: Switch to standard pmu functions and json de=
scriptions
> > > > > > >   perf tests: Add tool PMU test
> > > > > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon i=
n sysfs
> > > > > > >   perf test: Add hwmon "PMU" test
> > > > > > >   perf docs: Document tool and hwmon events
> > > > > >
> > > > > > For patch 1-10,
> > > > > >
> > > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > I thought the plan was for 1 to 10 to be in v6.12 and the remaining=
 3
> > > > to be in perf-tools-next/v6.13. I'm not seeing any of the series in
> > > > perf-tools so should everything be going in perf-tools-next?
> > >
> > > Ok, I'll pick up the tools_pmu changes first.
>
> It doesn't apply cleanly anymore.  Please rebase.
>
> > >
> > > And I think it'd be much easier for me if you break the hwmon change
> > > like with basic PMU enabling and unit/alias support.
> >
> > I'd kept the hwmon PMU as a single addition on purpose - testing and
> > documentation are follow up patches. Typically a new driver would be a
> > single commit, and so I think this is the LKML norm. For example:
> > https://lore.kernel.org/lkml/20190326151753.19384-3-shameerali.kolothum=
.thodi@huawei.com/
> >
> > Having multiple commits where things are only partially working means
> > bisects will be broken. It also means changes I have on top of this
> > can end up conflicting with what you're doing. I agree this means we
> > have a big patch when the new thing is added, I think this is normal
> > in the case of a driver - which to some extent this is.
>
> I think it depends, and of course I want bisectable patches.  A
> standalone driver with well-known pattern of implementation could come
> in a single commit.  But this is new and I'm not familiar with the hwmon
> interfaces and behaviors.  So I'm asking you to split the minimal code
> that can run with perf stat from the full-fledged version.  That would
> help maintainers understand and maintain the code better.

I consider the code to be in its minimal state. The first 10 patches
lay ground work in tool PMU for an API hwmon PMU will follow, patch 12
adds the testing separated from the main driver and patch 13 adds the
documentation.

In patch 11 the added APIs are:
perf_pmus__read_hwmon_pmus
perf_pmu__is_hwmon
hwmon_pmu__have_event
hwmon_pmu__num_events
hwmon_pmu__for_each_event
hwmon_pmu__check_alias
hwmon_pmu__config_terms
hwmon_pmu__exit
evsel__hwmon_pmu_open
evsel__hwmon_pmu_read

If we read hwmon PMUs without allowing the events to be programmed
then the hwmon code would just be empty and I see no value in such a
patch - I'd be fighting all of the C compilers unused variable and
function warnings.
If we have a hwmon PMU we need the perf_pmu__is_hwmon test as we lack
C++ virtual methods.
There are 3 event functions exactly corresponding to the same
functions in perf_pmu. The reading code store data in a hashmap so
these functions query or iterate the hashmap.
The check_alias and config_terms functions set up the perf_event_attr
and without them the generic code won't work. They are copies of the
generic code but with support for most terms removed as things like
call-graph have no meaning on a hwmon event.
The exit function is the usual house keeping.
The evsel open and read functions are needed as trying to open a
configured event with perf_event_open will fail and break tests like
tools/perf/tests/shell/stat_all_pmu.sh. If you open the event you
can't read it as if the contents were the binary contents of a
perf_event_open file, it has to be read as text so we need the read
function.

The driver is essentially a hashmap. hwmon files are of the form
<type><number>_<item>, so an event is a type and number with the
different items associated with the event held in the hashmap's value.
We can find an event like "temp1" from the type and number but we may
prefer the event "temp_cpu" where "cpu" is read from the label item
file. Finding such labelled events is a linear search and the label
file is read when the event is created in the hashmap for simplicity.
We could make the driver support the "temp1" name and then the
"temp_cpu" name but the line savings would be minimal, we'd have a new
hwmon driver that would have different rules around event alias names
and the like, basically it'd be a whole heap of work that would in the
next patch just be thrown away.

I've described how the driver works in the paragraph above but in the
code I added a generous amount of kerneldoc that already says this. I
could remove the kerneldoc and add it as an additional patch, but I
don't see why. I also don't see how this differs from how existing
drivers are added except that the pmu API is cleaned up prior to use
while drivers tend to be using a stable API.

Thanks,
Ian
