Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819322AEFE;
	Sun, 29 Sep 2024 07:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594502; cv=none; b=aOuhYd7dqpbZuJ6olFjzI7pdUFoQ8JVjxUtww3OkLXxU287aQABvZui0A1x6ewRtoHjUar8y2Ohy2MSPmrDwmrbHbH2zr0QZj4QGIsyzp6tZGYg9o9a42GRS6508+HWN+f1Nspm3wXi4gfYNtB95jC6S9ZiXLRI2TObxUOzk/uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594502; c=relaxed/simple;
	bh=jS0BLFSgkx081+O2KoqIcQUBqT/42Be60lv0zaA+bNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akh5x5QujrNZ/bDr2wvSNC9/q3QT1lmTRWCWvVuUZJY7KCcNlYrpm1sAelmaQASkDajWOVsR3CmfPZ7PDyaPgnQUyzz/UXijqIzKqM+q4OtXDqfVmER3kjAVfLBwZ0gZbeI4FxZisBWfDALiWE7kugs0ve+IqV8i/KRB8ZNQDCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBgt0YQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBgt0YQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883C4C4CEC5;
	Sun, 29 Sep 2024 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727594502;
	bh=jS0BLFSgkx081+O2KoqIcQUBqT/42Be60lv0zaA+bNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBgt0YQkemk4aifWPwYQYGYjqmHkLJLnWxI/Rtxm/Jj4TABiydM2iiyWjc4LG3D+r
	 pg3DX+mEsd16+q1YzGiXLl9d0taCYB/obNHCywJV5tcd8w7f2mcbSKhKdmx10o0QXZ
	 wM9xMTFE1niV59GMb3xJuLVf9rxaKMEk02TwvPrc6K8sUCFAm3Oub/ryGruUrGpzz/
	 wfEF6TnLg7t47C5rS7KwpuUrUvH2H/v2Hv/Ox6ENwYSdQ18AstZiU/r82+PnA6WOwp
	 V4Zw85q5SmtSosVNffQu3HhWss8ka0lu0K49oMMTWjn5lQfbA2CGVZuU9y0ooWYlbo
	 oN4Nc9VpESHKQ==
Date: Sun, 29 Sep 2024 00:21:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Junhao He <hejunhao3@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 00/13] Tool and hwmon PMUs
Message-ID: <ZvkAA8NW_5ssmsuf@google.com>
References: <20240912190341.919229-1-irogers@google.com>
 <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
 <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>
 <Zvbp3YCQLNBVWFmD@google.com>
 <CAP-5=fVigHrvtabp1T1HcLRn-LFwzOiShWP8qugtPfkO31u1sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVigHrvtabp1T1HcLRn-LFwzOiShWP8qugtPfkO31u1sA@mail.gmail.com>

On Fri, Sep 27, 2024 at 11:09:49AM -0700, Ian Rogers wrote:
> On Fri, Sep 27, 2024 at 10:22 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Sep 26, 2024 at 12:47:26PM -0700, Ian Rogers wrote:
> > > On Fri, Sep 13, 2024 at 7:34 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Thu, Sep 12, 2024 at 3:50 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > > > > Rather than have fake and tool PMUs being special flags in an evsel,
> > > > > > create special PMUs. This allows, for example, duration_time to also
> > > > > > be tool/duration_time/. Once adding events to the tools PMU is just
> > > > > > adding to an array, add events for nearly all the expr literals like
> > > > > > num_cpus_online. Rather than create custom logic for finding and
> > > > > > describing the tool events use json and add a notion of common json
> > > > > > for the tool events.
> > > > > >
> > > > > > Following the convention of the tool PMU, create a hwmon PMU that
> > > > > > exposes hwmon data for reading. For example, the following shows
> > > > > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > > > > frequency:
> > > > > > ```
> > > > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
> > > > > >      1.001153138              52.00 'C   temp_cpu
> > > > > >      1.001153138              2,588 rpm  fan1
> > > > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > > > >      1.001153138                  8      tool/num_cpus_online/
> > > > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
> > > > > >      1.001153138      1,012,773,595      duration_time
> > > > > > ...
> > > > > > ```
> > > > > >
> > > > > > Additional data on the hwmon events is in perf list:
> > > > > > ```
> > > > > > $ perf list
> > > > > > ...
> > > > > > hwmon:
> > > > > > ...
> > > > > >   temp_core_0 OR temp2
> > > > > >        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
> > > > > >         hwmon_coretemp]
> > > > > > ...
> > > > > > ```
> > > > > >
> > > > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > > > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > > > >
> > > > > > Ian Rogers (13):
> > > > > >   perf pmu: Simplify an asprintf error message
> > > > > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > > > > >   perf parse-events: Expose/rename config_term_name
> > > > > >   perf tool_pmu: Factor tool events into their own PMU
> > > > > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> > > > > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > > > > >   perf tool_pmu: Move expr literals to tool_pmu
> > > > > >   perf jevents: Add tool event json under a common architecture
> > > > > >   perf tool_pmu: Switch to standard pmu functions and json descriptions
> > > > > >   perf tests: Add tool PMU test
> > > > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > > > > >   perf test: Add hwmon "PMU" test
> > > > > >   perf docs: Document tool and hwmon events
> > > > >
> > > > > For patch 1-10,
> > > > >
> > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > I thought the plan was for 1 to 10 to be in v6.12 and the remaining 3
> > > to be in perf-tools-next/v6.13. I'm not seeing any of the series in
> > > perf-tools so should everything be going in perf-tools-next?
> >
> > Ok, I'll pick up the tools_pmu changes first.

It doesn't apply cleanly anymore.  Please rebase.

> >
> > And I think it'd be much easier for me if you break the hwmon change
> > like with basic PMU enabling and unit/alias support.
> 
> I'd kept the hwmon PMU as a single addition on purpose - testing and
> documentation are follow up patches. Typically a new driver would be a
> single commit, and so I think this is the LKML norm. For example:
> https://lore.kernel.org/lkml/20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com/
> 
> Having multiple commits where things are only partially working means
> bisects will be broken. It also means changes I have on top of this
> can end up conflicting with what you're doing. I agree this means we
> have a big patch when the new thing is added, I think this is normal
> in the case of a driver - which to some extent this is.

I think it depends, and of course I want bisectable patches.  A
standalone driver with well-known pattern of implementation could come
in a single commit.  But this is new and I'm not familiar with the hwmon
interfaces and behaviors.  So I'm asking you to split the minimal code
that can run with perf stat from the full-fledged version.  That would
help maintainers understand and maintain the code better.

Thanks,
Namhyung

