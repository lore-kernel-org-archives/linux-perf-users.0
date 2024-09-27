Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C413AD1C;
	Fri, 27 Sep 2024 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457760; cv=none; b=fX3OwWWz+fGC8F3hR0HRP/RQX/oAulBCmRm+pfFdmj4tN5kT75w6NkclX8ZtZ2kcNTf3Z6Hkw5IXlXVXF8ojxuzY+a6gJju3pVSYLaiV8qO9idXnoBo2pAr08Bwx1MSN3/PWsQvz0tnwHBP2YZL8ENVhflzYDHGq/CWevhzb75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457760; c=relaxed/simple;
	bh=eMHXdkUTvmKwfPAOVsxS9P3qJhe5YNo1bGQWqw0OTHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dE8Eh3+RclQuSqpMIJgggxgqai2PoXPMCHjeAJXHRyZgSJ69FlioAZimRpot2D9GVsm1VVqv16DJJ6tGPc+4f1pRYXViLnp6LH2eYmIog2eqcOWF4/ter+FhF+EjUcDbEimaiBdKtKgiu61h13vt9vTodn+l2xLVCx6CEETRYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8DIHYEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8DIHYEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB238C4CEC4;
	Fri, 27 Sep 2024 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457760;
	bh=eMHXdkUTvmKwfPAOVsxS9P3qJhe5YNo1bGQWqw0OTHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8DIHYElpBX4NJ/gNP4RaH7ZaUDyVIekhIAxtanF9XwT5t/OIBKICJK4muP17vWld
	 5DndedPODgXj0S0LRNWBwUBTEfQSUKaLJk8MDL3GnL1dGUEWuzi7vDLVSC9jm6GHur
	 kMG6LIkOlaqxWGVO6N7Gzit58mXLldVd/7y6rvQmDBsODxRtZeR6G3b+hEDv+tjPOr
	 XuIV16CMAwAEHimGr2YRIz9pnnoejjNM5WS1evR6hxeVqtBfYQPGYlz2Ll9NVkGeWW
	 hqnILsjHGuzwYII6fvvTyAaAn4z7mqSK/V91+tfl1YoZQVRvEhvKW6bQZHHbjSHDIk
	 7eDywnMn/CL7A==
Date: Fri, 27 Sep 2024 10:22:37 -0700
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
Message-ID: <Zvbp3YCQLNBVWFmD@google.com>
References: <20240912190341.919229-1-irogers@google.com>
 <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
 <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>

On Thu, Sep 26, 2024 at 12:47:26PM -0700, Ian Rogers wrote:
> On Fri, Sep 13, 2024 at 7:34 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 3:50 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > > Rather than have fake and tool PMUs being special flags in an evsel,
> > > > create special PMUs. This allows, for example, duration_time to also
> > > > be tool/duration_time/. Once adding events to the tools PMU is just
> > > > adding to an array, add events for nearly all the expr literals like
> > > > num_cpus_online. Rather than create custom logic for finding and
> > > > describing the tool events use json and add a notion of common json
> > > > for the tool events.
> > > >
> > > > Following the convention of the tool PMU, create a hwmon PMU that
> > > > exposes hwmon data for reading. For example, the following shows
> > > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > > frequency:
> > > > ```
> > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
> > > >      1.001153138              52.00 'C   temp_cpu
> > > >      1.001153138              2,588 rpm  fan1
> > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > >      1.001153138                  8      tool/num_cpus_online/
> > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
> > > >      1.001153138      1,012,773,595      duration_time
> > > > ...
> > > > ```
> > > >
> > > > Additional data on the hwmon events is in perf list:
> > > > ```
> > > > $ perf list
> > > > ...
> > > > hwmon:
> > > > ...
> > > >   temp_core_0 OR temp2
> > > >        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
> > > >         hwmon_coretemp]
> > > > ...
> > > > ```
> > > >
> > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > >
> > > > Ian Rogers (13):
> > > >   perf pmu: Simplify an asprintf error message
> > > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > > >   perf parse-events: Expose/rename config_term_name
> > > >   perf tool_pmu: Factor tool events into their own PMU
> > > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> > > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > > >   perf tool_pmu: Move expr literals to tool_pmu
> > > >   perf jevents: Add tool event json under a common architecture
> > > >   perf tool_pmu: Switch to standard pmu functions and json descriptions
> > > >   perf tests: Add tool PMU test
> > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > > >   perf test: Add hwmon "PMU" test
> > > >   perf docs: Document tool and hwmon events
> > >
> > > For patch 1-10,
> > >
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> I thought the plan was for 1 to 10 to be in v6.12 and the remaining 3
> to be in perf-tools-next/v6.13. I'm not seeing any of the series in
> perf-tools so should everything be going in perf-tools-next?

Ok, I'll pick up the tools_pmu changes first.

And I think it'd be much easier for me if you break the hwmon change
like with basic PMU enabling and unit/alias support.

Thanks,
Namhyung

