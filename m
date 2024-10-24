Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB781DD0D9;
	Thu, 24 Oct 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788060; cv=none; b=JC31GvRFx4QCpJzcTvqG9pRH8p+u5fUc7dJL21bovgVlIkFql83RoWJ3V/BA1HlRB0YjfZnssWbAK/45rBdPzkXI5v+V32PW1YmfLmrGXqTCxjCIt+jO7be3iQIso+kuLOybIlX8w8mlNUKwecNjft+OrOwlNGV/ersbnvhNq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788060; c=relaxed/simple;
	bh=faHVFb2xb/Fc6TEDHZCcyQQGgQulULSTV8l2eFgj3SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPRyPoAlZ5eT8ZLKKph2pjmyjFO1opXXqPvs/z8gU86LjYfWswIi0t0NbJk0tIBleRXj6o5mA/FyYrRaZBvbaj9MKnJXY3TLZRwq0XuxSuS5COOlB/WO/GKHi71+oa9vWS9YXzL4NNfRrM69KoPHIadQiU94J13QepiUPsUmNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJyf4dmA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJyf4dmA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997DAC4CEC7;
	Thu, 24 Oct 2024 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729788060;
	bh=faHVFb2xb/Fc6TEDHZCcyQQGgQulULSTV8l2eFgj3SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJyf4dmAOhT2IppasgAgSZKB7nEsa29a04NxE+RzCtBGVtveugc8v5wPoJCW1ancA
	 Br5fZEJmp4LPvh7CBKvW680FH8kCjHZ3tRugN1qzzuawsLE7/3WjmxWEcHGv7mfwMn
	 17INaw9ZBylP2r0sJ31VsI9Uc+bppkEmUgdIVOs/gRlvE2vKmjuuPtC2kGJGCCUJmc
	 cWl4EesYa0sxJxG9rVcFJdTxs4SD/6y/YBslGJp2ujgeJrSw1Or34gd/u5ElOCpRXN
	 wXdP6Bmpk7Pe2LtzroFeSWxoWxOmDaq3Py/4GgQ1Ert9BTXes2XwiJvnQNoQCsyxGZ
	 G+ljtm0HU5g9Q==
Date: Thu, 24 Oct 2024 09:40:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
Message-ID: <Zxp4mbzsFyO5nUh7@google.com>
References: <20241022180623.463131-1-irogers@google.com>
 <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>

On Thu, Oct 24, 2024 at 12:07:46AM -0700, Ian Rogers wrote:
> On Wed, Oct 23, 2024 at 8:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Oct 22, 2024 at 11:06:18AM -0700, Ian Rogers wrote:
> > > Following the convention of the tool PMU, create a hwmon PMU that
> > > exposes hwmon data for reading. For example, the following shows
> > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > frequency:
> > > ```
> > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
> > >      1.001153138              52.00 'C   temp_cpu
> > >      1.001153138              2,588 rpm  fan1
> > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > >      1.001153138                  8      tool/num_cpus_online/
> > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
> > >      1.001153138      1,012,773,595      duration_time
> > > ...
> > > ```
> > >
> > > Additional data on the hwmon events is in perf list:
> > > ```
> > > $ perf list
> > > ...
> > > hwmon:
> > > ...
> > >   temp_core_0 OR temp2
> > >        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
> > >         hwmon_coretemp]
> > > ...
> > > ```
> > >
> > > v6: Add string.h #include for issue reported by kernel test robot.
> > > v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
> > > v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
> > >     the update to perf_pmu to use it. Try to make source of literal
> > >     strings clearer via named #defines. Fix a number of GCC warnings.
> > > v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > >
> > > Ian Rogers (5):
> > >   tools api io: Ensure line_len_out is always initialized
> > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > >   perf pmu: Add calls enabling the hwmon_pmu
> > >   perf test: Add hwmon "PMU" test
> > >   perf docs: Document tool and hwmon events
> >
> > I think the patch 2 can be easily splitted into core and other parts
> > like dealing with aliases and units.  I believe it'd be helpful for
> > others (like me) to understand how it works.
> >
> > Please take a look at 'perf/hwmon-pmu' branch in:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks Namhyung but I'm not really seeing this making anything simpler
> and I can see significant new bugs. Your new patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git/commit/?h=perf/hwmon-pmu&id=85c78b5bf71fb3e67ae815f7b2d044648fa08391
> Has taken about 40% out of patch 2, but done so by splitting function
> declarations from their definitions, enum declarations from any use,

Yeah, it's just because I was lazy and you can split header files too
(and please do so).

> etc. It also adds in code like:
> 
> snprintf(buf, sizeof(buf), "%s_input", evsel->name);
> 
> but this would be a strange thing to do. The evsel->name is rewritten
> by fallback logic, so cycles may become cycles:u if kernel profiling

I know it doesn't work but just want to highlight how it's supposed to
work.  Eventually what we need is a correct file name.  In fact, I think
it'd work if we can pass a correct event name probably like:

  perf stat -e hwmon5/name=fan1/ true

> is restricted. This is why we have metric-id in the evsel as we cannot
> rely on the evsel->name not mutating when looking up events for the
> sake of metrics. Using the name as part of a sysfs filename lookup
> doesn't make sense to me as now the evsel fallback logic can break a
> hwmon event. In the original patch the code was:

The fallback logic is used only if the kernel returns an error.  Thus
it'd be fine as long as it correctly finds the sysfs filename.  But it's
not used in the final code and the change is a simple one-liner.

> 
> snprintf(buf, sizeof(buf), "%s%d_input", hwmon_type_strs[key.type], key.num);
> 
> where those two values are constants and key.type and key.num both
> values embedded in the config value the evsel fallback logic won't
> change. But bringing in the code that does that basically brings in
> all of the rest of patch 2.

Right, that's why I did that way.

> 
> So the patch is adding a PMU that looks broken, so rather than
> simplifying things it just creates a broken intermediate state and
> should that be fixed for the benefit of bisects?

Actually it's not broken since it's not enabled yet. :)


> It also complicates understanding as the declarations of functions and
> enums have kernel-doc, but now the definitions of enums and functions
> are split apart. For me, to understand the code I'd want to squash the
> patches back together again so I could see a declaration with its
> definition.

Yep, please move the declarations to the patch 3.

Thanks,
Namhyung

