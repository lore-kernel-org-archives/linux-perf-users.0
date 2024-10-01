Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F41D4336;
	Tue,  1 Oct 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825985; cv=none; b=BG8N3BVCS0bNORgDSN9kVAJ+b2wQC/tXGKbtAwgH1gv8RQqlHRTmssUWHavEh8FekveujfpKpq6OXUKLKT51DC+tD8ndvldVzhu42NmracNNBytXyvimvYXOcbtbGiWV6ZflPIUldoEu4ipbFKel49iRA0GSbNcJZkMmBTGjgcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825985; c=relaxed/simple;
	bh=UZsLca04WQbgLW08kkjh5oMDCWy5Il9wVFjeDso967M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoAhHGs0OaKC7epusOSV4q+ZJrtqFdFh5dIGM8xCat9YEkH6mtZipxEth6QsuyRJt01bkCfC9+YS+KL3tzFuXWOk0E7wg61akCf1c6fQ0HcTyWUVQ5CkL5o5eWlFSq2Xpmuaxg9n6837EBH+ueG8EF0c8FjwnWeWuQcNHpO6vAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPfvkMSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPfvkMSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66A2C4CEC6;
	Tue,  1 Oct 2024 23:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727825985;
	bh=UZsLca04WQbgLW08kkjh5oMDCWy5Il9wVFjeDso967M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPfvkMSSRH5ncHD5zRo4X+M7N1j8ZL0hFYru0Y+4wq7eq3oV8SZHs5T1m5q//cTx8
	 u1uxHRnSx+qGXwXLoiOVlCdikIAOzn1oIz2ycO21/4QbB0CTiehd1cXi2wEpvszX7G
	 whAfGPlv+q1l48cwp/tNzwgWXmhX2dvV9tLs6PQRNaxad80UpFbrpZnnQSjr2ZIJDa
	 Q3gPftTVSAAOJzrYiPvJP3dYQT0EPf6FCEt0Ixnc87+csSiKi1pmyCeSVuBfNzZ1/d
	 NVpbjrvLla4y7bB1eoybXAfSHloHuqtdIIiUytZjnPCWJR+4N6rC5PzUWNDsNvQq8O
	 omSQq8eA5sjLA==
Date: Tue, 1 Oct 2024 16:39:42 -0700
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
Message-ID: <ZvyIPmE30oIKr_BM@google.com>
References: <20240912190341.919229-1-irogers@google.com>
 <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
 <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>
 <Zvbp3YCQLNBVWFmD@google.com>
 <CAP-5=fVigHrvtabp1T1HcLRn-LFwzOiShWP8qugtPfkO31u1sA@mail.gmail.com>
 <ZvkAA8NW_5ssmsuf@google.com>
 <CAP-5=fWfjU0yuOVn_FJ=qEWfWHZ6SG7BceaOp7KWG+iXS7Rapg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWfjU0yuOVn_FJ=qEWfWHZ6SG7BceaOp7KWG+iXS7Rapg@mail.gmail.com>

On Mon, Sep 30, 2024 at 09:56:29PM -0700, Ian Rogers wrote:
> On Sun, Sep 29, 2024 at 12:21 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Sep 27, 2024 at 11:09:49AM -0700, Ian Rogers wrote:
> > > On Fri, Sep 27, 2024 at 10:22 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 26, 2024 at 12:47:26PM -0700, Ian Rogers wrote:
> > > > > On Fri, Sep 13, 2024 at 7:34 AM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > On Thu, Sep 12, 2024 at 3:50 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > > > > > > Rather than have fake and tool PMUs being special flags in an evsel,
> > > > > > > > create special PMUs. This allows, for example, duration_time to also
> > > > > > > > be tool/duration_time/. Once adding events to the tools PMU is just
> > > > > > > > adding to an array, add events for nearly all the expr literals like
> > > > > > > > num_cpus_online. Rather than create custom logic for finding and
> > > > > > > > describing the tool events use json and add a notion of common json
> > > > > > > > for the tool events.
> > > > > > > >
> > > > > > > > Following the convention of the tool PMU, create a hwmon PMU that
> > > > > > > > exposes hwmon data for reading. For example, the following shows
> > > > > > > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > > > > > > frequency:
> > > > > > > > ```
> > > > > > > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
> > > > > > > >      1.001153138              52.00 'C   temp_cpu
> > > > > > > >      1.001153138              2,588 rpm  fan1
> > > > > > > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > > > > > > >      1.001153138                  8      tool/num_cpus_online/
> > > > > > > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
> > > > > > > >      1.001153138      1,012,773,595      duration_time
> > > > > > > > ...
> > > > > > > > ```
> > > > > > > >
> > > > > > > > Additional data on the hwmon events is in perf list:
> > > > > > > > ```
> > > > > > > > $ perf list
> > > > > > > > ...
> > > > > > > > hwmon:
> > > > > > > > ...
> > > > > > > >   temp_core_0 OR temp2
> > > > > > > >        [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
> > > > > > > >         hwmon_coretemp]
> > > > > > > > ...
> > > > > > > > ```
> > > > > > > >
> > > > > > > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > > > > > > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > > > > > > >
> > > > > > > > Ian Rogers (13):
> > > > > > > >   perf pmu: Simplify an asprintf error message
> > > > > > > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > > > > > > >   perf parse-events: Expose/rename config_term_name
> > > > > > > >   perf tool_pmu: Factor tool events into their own PMU
> > > > > > > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> > > > > > > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > > > > > > >   perf tool_pmu: Move expr literals to tool_pmu
> > > > > > > >   perf jevents: Add tool event json under a common architecture
> > > > > > > >   perf tool_pmu: Switch to standard pmu functions and json descriptions
> > > > > > > >   perf tests: Add tool PMU test
> > > > > > > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > > > > > > >   perf test: Add hwmon "PMU" test
> > > > > > > >   perf docs: Document tool and hwmon events
> > > > > > >
> > > > > > > For patch 1-10,
> > > > > > >
> > > > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > >
> > > > > I thought the plan was for 1 to 10 to be in v6.12 and the remaining 3
> > > > > to be in perf-tools-next/v6.13. I'm not seeing any of the series in
> > > > > perf-tools so should everything be going in perf-tools-next?
> > > >
> > > > Ok, I'll pick up the tools_pmu changes first.
> >
> > It doesn't apply cleanly anymore.  Please rebase.
> >
> > > >
> > > > And I think it'd be much easier for me if you break the hwmon change
> > > > like with basic PMU enabling and unit/alias support.
> > >
> > > I'd kept the hwmon PMU as a single addition on purpose - testing and
> > > documentation are follow up patches. Typically a new driver would be a
> > > single commit, and so I think this is the LKML norm. For example:
> > > https://lore.kernel.org/lkml/20190326151753.19384-3-shameerali.kolothum.thodi@huawei.com/
> > >
> > > Having multiple commits where things are only partially working means
> > > bisects will be broken. It also means changes I have on top of this
> > > can end up conflicting with what you're doing. I agree this means we
> > > have a big patch when the new thing is added, I think this is normal
> > > in the case of a driver - which to some extent this is.
> >
> > I think it depends, and of course I want bisectable patches.  A
> > standalone driver with well-known pattern of implementation could come
> > in a single commit.  But this is new and I'm not familiar with the hwmon
> > interfaces and behaviors.  So I'm asking you to split the minimal code
> > that can run with perf stat from the full-fledged version.  That would
> > help maintainers understand and maintain the code better.
> 
> I consider the code to be in its minimal state. The first 10 patches
> lay ground work in tool PMU for an API hwmon PMU will follow, patch 12

Yes, please send the first 10 patches separately.


> adds the testing separated from the main driver and patch 13 adds the
> documentation.
> 
> In patch 11 the added APIs are:
> perf_pmus__read_hwmon_pmus
> perf_pmu__is_hwmon
> hwmon_pmu__have_event
> hwmon_pmu__num_events
> hwmon_pmu__for_each_event
> hwmon_pmu__check_alias
> hwmon_pmu__config_terms
> hwmon_pmu__exit
> evsel__hwmon_pmu_open
> evsel__hwmon_pmu_read
> 
> If we read hwmon PMUs without allowing the events to be programmed
> then the hwmon code would just be empty and I see no value in such a
> patch - I'd be fighting all of the C compilers unused variable and
> function warnings.

I'd like to have a minimal working version first and then add more
features or convenience on and on.  It should read *some* numbers
from hwmon.


> If we have a hwmon PMU we need the perf_pmu__is_hwmon test as we lack
> C++ virtual methods.
> There are 3 event functions exactly corresponding to the same
> functions in perf_pmu. The reading code store data in a hashmap so
> these functions query or iterate the hashmap.
> The check_alias and config_terms functions set up the perf_event_attr
> and without them the generic code won't work. They are copies of the
> generic code but with support for most terms removed as things like
> call-graph have no meaning on a hwmon event.

Can the check_alias() part be optional?  I'm not sure how much work is
needed in config_terms() other than setting attr.type for the PMU in the
minimal version.


> The exit function is the usual house keeping.
> The evsel open and read functions are needed as trying to open a
> configured event with perf_event_open will fail and break tests like
> tools/perf/tests/shell/stat_all_pmu.sh. If you open the event you
> can't read it as if the contents were the binary contents of a
> perf_event_open file, it has to be read as text so we need the read
> function.

Yep, these are essential.

> 
> The driver is essentially a hashmap. hwmon files are of the form
> <type><number>_<item>, so an event is a type and number with the
> different items associated with the event held in the hashmap's value.
> We can find an event like "temp1" from the type and number but we may
> prefer the event "temp_cpu" where "cpu" is read from the label item
> file. Finding such labelled events is a linear search and the label
> file is read when the event is created in the hashmap for simplicity.

I guess this can be in the second patch to improve the behavior.  By
reading the label, it can give the meaning of the numbers in the hwmon.
But it could work without that too, right?


> We could make the driver support the "temp1" name and then the
> "temp_cpu" name but the line savings would be minimal, we'd have a new
> hwmon driver that would have different rules around event alias names
> and the like, basically it'd be a whole heap of work that would in the
> next patch just be thrown away.

Pleaes keep it minimal to avoid unnecessary work as much as possible.
I think it's needed for maintainers and other contributors to
understand the code and the semantics better.

> 
> I've described how the driver works in the paragraph above but in the
> code I added a generous amount of kerneldoc that already says this. I
> could remove the kerneldoc and add it as an additional patch, but I
> don't see why. I also don't see how this differs from how existing
> drivers are added except that the pmu API is cleaned up prior to use
> while drivers tend to be using a stable API.

I appreciate your work on this.

Thanks,
Namhyung

