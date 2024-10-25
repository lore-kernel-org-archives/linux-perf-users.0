Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA1120C30B;
	Fri, 25 Oct 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877438; cv=none; b=Xgy/R1Qke5FRH7Ily2Kas2Cduizk6gN0fYbvNKVo00agaoCbr97nQ5WVgsh413ZeqPxwzUYOFboKfysmQotNpmKmHT5P/P2C/LbqdonwFlXL2Kep4wyzsHfgQXLfBcPX5PdBg7NGeRRXH1fOXVpJtmv795Us/AQLa3dtbpC6w8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877438; c=relaxed/simple;
	bh=ANS/gOrVqrxuajygy/OjPOoYLboLMlnXl9LVM3C87TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0S785lGYMzEdDoCrSVYUa76qzu8+qh7uVpi5O+kHW59dm0b91YnFdrV41pA1gO2/WT/Pae6/FTuTOyfKc8PedakLxmThFa5YXC913gBmdO7zLeQd19vTwxIOTwuugkfRPLyYN27r7rvR8dCR49m7nwivO6gmtP3TRdixzWpDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKZi+w7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKZi+w7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC0BC4CEC3;
	Fri, 25 Oct 2024 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729877437;
	bh=ANS/gOrVqrxuajygy/OjPOoYLboLMlnXl9LVM3C87TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKZi+w7oOiybHc4xqTorEzGtVN9yu6ZIC2LyD1PLMKbfLngS9xDt2n2JijbG83FI4
	 jO2gpq9YKbpxd3FUkDbEuMbdR7nAeG0uWV3Q+6O838iLQkwa4vm73byERo3843Vnix
	 2DWRJP1Y6OQMtkVPVaX9gQcHuOcGojWcZc6lj81oSyIBK73GoCYW51Ubga+tjwBc0R
	 7oWZmgh5wfSkaWdLd5EB7QIak8xH4Mh2claTi4EZeaCLD6KR+yuVsHqlL/a0A4g6XM
	 eXnUj5XjkYerhZOwHZe8KEC+CVcz8sbR6E6PNvQtmOvzblJOgKuy/IA56645v/gGQo
	 dVsLEe5DfW2tw==
Date: Fri, 25 Oct 2024 10:30:32 -0700
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
Message-ID: <ZxvVuFqef2CLwtCs@google.com>
References: <20241022180623.463131-1-irogers@google.com>
 <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
 <Zxp4mbzsFyO5nUh7@google.com>
 <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>

On Thu, Oct 24, 2024 at 06:33:27PM -0700, Ian Rogers wrote:
> On Thu, Oct 24, 2024 at 9:41 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Oct 24, 2024 at 12:07:46AM -0700, Ian Rogers wrote:
> > > On Wed, Oct 23, 2024 at 8:06 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hi Ian,
> > > >
> > > > On Tue, Oct 22, 2024 at 11:06:18AM -0700, Ian Rogers wrote:
> > > > > Following the convention of the tool PMU, create a hwmon PMU that
> > > > > exposes hwmon data for reading. For example, the following shows
> > > > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > > > frequency:
> > > > > ```
> > > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
> > > > >      1.001153138              52.00 'C   temp_cpu
> > > > >      1.001153138              2,588 rpm  fan1
> > > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > > >      1.001153138                  8      tool/num_cpus_online/
> > > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
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
> > > > >        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
> > > > >         hwmon_coretemp]
> > > > > ...
> > > > > ```
> > > > >
> > > > > v6: Add string.h #include for issue reported by kernel test robot.
> > > > > v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
> > > > > v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
> > > > >     the update to perf_pmu to use it. Try to make source of literal
> > > > >     strings clearer via named #defines. Fix a number of GCC warnings.
> > > > > v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
> > > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > > >
> > > > > Ian Rogers (5):
> > > > >   tools api io: Ensure line_len_out is always initialized
> > > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > > > >   perf pmu: Add calls enabling the hwmon_pmu
> > > > >   perf test: Add hwmon "PMU" test
> > > > >   perf docs: Document tool and hwmon events
> > > >
> > > > I think the patch 2 can be easily splitted into core and other parts
> > > > like dealing with aliases and units.  I believe it'd be helpful for
> > > > others (like me) to understand how it works.
> > > >
> > > > Please take a look at 'perf/hwmon-pmu' branch in:
> > > >
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > >
> > > Thanks Namhyung but I'm not really seeing this making anything simpler
> > > and I can see significant new bugs. Your new patch:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git/commit/?h=perf/hwmon-pmu&id=85c78b5bf71fb3e67ae815f7b2d044648fa08391
> > > Has taken about 40% out of patch 2, but done so by splitting function
> > > declarations from their definitions, enum declarations from any use,
> >
> > Yeah, it's just because I was lazy and you can split header files too
> > (and please do so).
> >
> > > etc. It also adds in code like:
> > >
> > > snprintf(buf, sizeof(buf), "%s_input", evsel->name);
> > >
> > > but this would be a strange thing to do. The evsel->name is rewritten
> > > by fallback logic, so cycles may become cycles:u if kernel profiling
> >
> > I know it doesn't work but just want to highlight how it's supposed to
> > work.  Eventually what we need is a correct file name.  In fact, I think
> > it'd work if we can pass a correct event name probably like:
> >
> >   perf stat -e hwmon5/name=fan1/ true
> 
> But this isn't what the term name and evsel's name are for. They are
> to allow you to do:
> ```
> $ perf stat -e cycles/name=foobar/ true
> 
> Performance counter stats for 'true':
> 
>         1,126,942      foobar
> 
>       0.001681805 seconds time elapsed
> 
>       0.001757000 seconds user
>       0.000000000 seconds sys
> ```
> Why would you do this in code, change a fundamental of evsel behavior,
> then just to delete it in the next patch?

Well, I didn't change the actual behavior and it doesn't work yet.
The deletion is just one line, and I think it reveals the intention of
the next patch very well.

> 
> > > is restricted. This is why we have metric-id in the evsel as we cannot
> > > rely on the evsel->name not mutating when looking up events for the
> > > sake of metrics. Using the name as part of a sysfs filename lookup
> > > doesn't make sense to me as now the evsel fallback logic can break a
> > > hwmon event. In the original patch the code was:
> >
> > The fallback logic is used only if the kernel returns an error.  Thus
> > it'd be fine as long as it correctly finds the sysfs filename.  But it's
> > not used in the final code and the change is a simple one-liner.
> 
> But it's not. It's changing what evsel->name means to be an event
> encoding. How does reverse config to name lookup work in this model?
> How does the normal use of the name term work?

It's intermediate code that is not activated yet.  So I think it's about
to say how the code works.  If you really don't like to use evsel->name,
maybe you can put a dummy name with a comment saying it'll be updated in
next patch.

> 
> > >
> > > snprintf(buf, sizeof(buf), "%s%d_input", hwmon_type_strs[key.type], key.num);
> > >
> > > where those two values are constants and key.type and key.num both
> > > values embedded in the config value the evsel fallback logic won't
> > > change. But bringing in the code that does that basically brings in
> > > all of the rest of patch 2.
> >
> > Right, that's why I did that way.
> >
> > >
> > > So the patch is adding a PMU that looks broken, so rather than
> > > simplifying things it just creates a broken intermediate state and
> > > should that be fixed for the benefit of bisects?
> >
> > Actually it's not broken since it's not enabled yet. :)
> >
> >
> > > It also complicates understanding as the declarations of functions and
> > > enums have kernel-doc, but now the definitions of enums and functions
> > > are split apart. For me, to understand the code I'd want to squash the
> > > patches back together again so I could see a declaration with its
> > > definition.
> >
> > Yep, please move the declarations to the patch 3.
> 
> So I think moving the enum declarations into one patch is okay. But as
> the enum values have no bearing on hardware constants, or something
> outside of the code that uses them it smells strange to me. Ultimately
> this is going to do little to the lines of code count but damage
> readability. I'm not sure why we're doing this given the kernel model
> for adding a driver is to add it as a large chunk. For example, here
> is adding the intel PT driver:
> https://lore.kernel.org/all/1422614392-114498-1-git-send-email-alexander.shishkin@linux.intel.com/T/#u

Maybe others can understand a big patch easily, but I'm not.

Thanks,
Namhyung

