Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087AA920
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Sep 2024 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460605; cv=none; b=AP2rgo1lc4xIEG11unRG6Hl4XVkTwToAEl7IG3t9QopJMTOSooSdaQiXAuTjFwOm6Tfn55SxGIva6pxkujpENOWyrirjQcs2MGJUr1dvkiHI2S5Rnwyk0ZZj1/aO1ldUK/O+eSyvxwJBmdd4ZHeSsWGMKNQyWY7KfOtexd6ezbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460605; c=relaxed/simple;
	bh=QnZc5IMpRvKkSTOCSj7lB8RPszal7wcZ5QEHB8a+8d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8QpgVd/OrhoykUx5J7RUK3DTyUZQJJyw0tGvpeBE0D5IctB/R9Or/gSASREr5aDlohi22oFySvL6ie2tt/shNWoGWH4N+gfvuVBre5vN8Y+VEelhQz73H446i95ujTkVJvtQLeYBOiJ/1Ju0RvkNUSoI4U61qN0HTf7LR/XJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hm3A4Vr+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hm3A4Vr+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b4a090f3eso17825ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Sep 2024 11:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727460603; x=1728065403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIEsrVTlTvILQ2eWv0DM89YVNKjAZnVoC4sB1CwcgVo=;
        b=Hm3A4Vr+BOX8oOoQvB5n6HJ4f7px1p5FdlohiKy+//bEQcaTRlkkIbqQfx1FXyKT8R
         wroS7rTnTa1ZdeFlAvwq9fPpNpnwGol4POq5jjhJ+ctLdAzObnsRJ9wcPNSHnQ04ZW+Y
         BnBYwkH3xLYlo50dX3znJQEs+hnjWI7E5/uiF9rM8RPGLeSb6+Vf0DytzKAYBqSo+hxj
         9J7tncXAQG8x8LAoUqV1YmH+B3omIEsayin/AJO7LNZZavqFS54DAS7+LH2fUWdH0Pg2
         /XPVnC3JUNHSevPnnloOYp3MX+lXC8J6UEfJyKVCGoL4ybaeObE3T+AxU+mazQY7xtB7
         TNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460603; x=1728065403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIEsrVTlTvILQ2eWv0DM89YVNKjAZnVoC4sB1CwcgVo=;
        b=cziR3bLY5GPaV2s1MDyjrHaLmRA0TiS+5OzL/cAnjH3vYORnC1chYnv19G07cKk9Sh
         UJ+0VAbIS5AeX2A3DXvzSw85GnaX7NRtHh36Q4gPw+mRhh1DKkOpNq6IC7fPFKLOFy+B
         dScBe1RGdMdl1J2UThnRI+tcNHnwn0CcQzTBTbpWMMumg4F8CwRJGdTw1LkAZirTJ0Xc
         tM+XKLnJuoa3A9ojcCjgXuhTxHt3aqhGtd+K/41AcX6kr+bYMjkEL9IZEEP3sBqRtXMq
         TKo8OzBKAUYudDgzZL/zd1D5dM8oNDQde4ffyO7V79YbZNZ6p3qdLxfYgOi9fchDvnir
         5kkA==
X-Forwarded-Encrypted: i=1; AJvYcCUaPIFjKRzCl+rjFvZt8KviYBb6oAWG2as6/Ll7SARXtbt9lJ+fSkQ7cRyaX4aXka/IRiPWQU/zBGoXtd5Bk6ko@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5l6s6Fmsq3HtSze9B1WcPqJrJm62X5DYNzujeuxjXghvwkhf1
	X4Ii5M2qmPY5C1UZrUx9jCJuuYyYyn83FVlD0GQR6okylgA7RBekgxC5ZnxHiy/oO9flA5/U5V2
	7+j6e3CnxvshNOjE3X7Ukw+WzrY84EORSCD43
X-Google-Smtp-Source: AGHT+IFEBPKfylkkIQVwpgBI2XQqTnVQtiDU0l1waIs+ur0JDVovqp8FFbY18VqbLvdSwSyPV4QwU2PxoShy7qGd+B4=
X-Received: by 2002:a17:903:32c1:b0:205:8610:3e39 with SMTP id
 d9443c01a7336-20b5835d373mr58945ad.23.1727460602549; Fri, 27 Sep 2024
 11:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com> <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
 <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com> <Zvbp3YCQLNBVWFmD@google.com>
In-Reply-To: <Zvbp3YCQLNBVWFmD@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Sep 2024 11:09:49 -0700
Message-ID: <CAP-5=fVigHrvtabp1T1HcLRn-LFwzOiShWP8qugtPfkO31u1sA@mail.gmail.com>
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

On Fri, Sep 27, 2024 at 10:22=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Sep 26, 2024 at 12:47:26PM -0700, Ian Rogers wrote:
> > On Fri, Sep 13, 2024 at 7:34=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, Sep 12, 2024 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > > > Rather than have fake and tool PMUs being special flags in an evs=
el,
> > > > > create special PMUs. This allows, for example, duration_time to a=
lso
> > > > > be tool/duration_time/. Once adding events to the tools PMU is ju=
st
> > > > > adding to an array, add events for nearly all the expr literals l=
ike
> > > > > num_cpus_online. Rather than create custom logic for finding and
> > > > > describing the tool events use json and add a notion of common js=
on
> > > > > for the tool events.
> > > > >
> > > > > Following the convention of the tool PMU, create a hwmon PMU that
> > > > > exposes hwmon data for reading. For example, the following shows
> > > > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > > > frequency:
> > > > > ```
> > > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_o=
nline/ -M UNCORE_FREQ -I 1000
> > > > >      1.001153138              52.00 'C   temp_cpu
> > > > >      1.001153138              2,588 rpm  fan1
> > > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > > >      1.001153138                  8      tool/num_cpus_online/
> > > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET        =
         #     1.08 UNCORE_FREQ
> > > > >      1.001153138      1,012,773,595      duration_time
> > > > > ...
> > > > > ```
> > > > >
> > > > > Additional data on the hwmon events is in perf list:
> > > > > ```
> > > > > $ perf list
> > > > > ...
> > > > > hwmon:
> > > > > ...
> > > > >   temp_core_0 OR temp2
> > > > >        [Temperature in unit coretemp named Core 0. crit=3D100'C,m=
ax=3D100'C crit_alarm=3D0'C. Unit:
> > > > >         hwmon_coretemp]
> > > > > ...
> > > > > ```
> > > > >
> > > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > > >
> > > > > Ian Rogers (13):
> > > > >   perf pmu: Simplify an asprintf error message
> > > > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > > > >   perf parse-events: Expose/rename config_term_name
> > > > >   perf tool_pmu: Factor tool events into their own PMU
> > > > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> > > > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > > > >   perf tool_pmu: Move expr literals to tool_pmu
> > > > >   perf jevents: Add tool event json under a common architecture
> > > > >   perf tool_pmu: Switch to standard pmu functions and json descri=
ptions
> > > > >   perf tests: Add tool PMU test
> > > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sy=
sfs
> > > > >   perf test: Add hwmon "PMU" test
> > > > >   perf docs: Document tool and hwmon events
> > > >
> > > > For patch 1-10,
> > > >
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > I thought the plan was for 1 to 10 to be in v6.12 and the remaining 3
> > to be in perf-tools-next/v6.13. I'm not seeing any of the series in
> > perf-tools so should everything be going in perf-tools-next?
>
> Ok, I'll pick up the tools_pmu changes first.
>
> And I think it'd be much easier for me if you break the hwmon change
> like with basic PMU enabling and unit/alias support.

I'd kept the hwmon PMU as a single addition on purpose - testing and
documentation are follow up patches. Typically a new driver would be a
single commit, and so I think this is the LKML norm. For example:
https://lore.kernel.org/lkml/20190326151753.19384-3-shameerali.kolothum.tho=
di@huawei.com/

Having multiple commits where things are only partially working means
bisects will be broken. It also means changes I have on top of this
can end up conflicting with what you're doing. I agree this means we
have a big patch when the new thing is added, I think this is normal
in the case of a driver - which to some extent this is.

Thanks,
Ian
