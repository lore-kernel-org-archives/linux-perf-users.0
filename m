Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866552C11E7;
	Thu,  5 Feb 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313163; cv=none; b=ksW2ouYvvKyuiHdCt5RoJk+xN7zYweIvDRwYKPT5w1n2aboLPgdNU2YUA05qiU6lz5yOF7TE0TNE9toUK4NKw8SWXPeu1N5AbJ3OegMxMJ4Ph4655uxo0ovqev2cL/rpTyAYx0MZeVgScHhIMixS5QE+ZZSB6rs53O5QM5k4nH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313163; c=relaxed/simple;
	bh=ZmDrKMAfGEZZYFeCr9c8ux98JdvXU1hp/YoBEAewZBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkcLvmUhA1THjONccB36CKnruo79aPP1zhfwRvLdighEfR5TbBqI3kNnKNWPf00vg1w6qOcHtuN6c4TOEfkGdyyrqi+xC0BsfkmMHkMHPvryFhpV7VfPPAUHWfGQDEQThSl3uTqzc/K+uTGrUloK8qAWQ5+dtLdyEud8BMq/5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 473F1339;
	Thu,  5 Feb 2026 09:39:15 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33C533F778;
	Thu,  5 Feb 2026 09:39:21 -0800 (PST)
Date: Thu, 5 Feb 2026 17:39:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
Message-ID: <20260205173918.GB3529712@e132581.arm.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>

Hi Ian,

On Thu, Feb 05, 2026 at 08:59:07AM -0800, Ian Rogers wrote:
> On Thu, Feb 5, 2026 at 3:46 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Perf stat is crashing on arm64 hosts with the following issue:
> >
> >         # make -C tools/perf DEBUG=1
> >         # perf stat sleep 1
> >         perf: util/evsel.c:2034: get_group_fd: Assertion `!(!leader->core.fd)' failed.
> >         [1]    1220794 IOT instruction (core dumped)  ./perf stat
> >
> > The sorting function introduced by commit a745c0831c15c ("perf stat:
> > Sort default events/metrics") compares events based on their individual
> > properties. This can cause events from different groups to be
> > interleaved, resulting in group members appearing before their leaders
> > in the sorted evlist.
> 
> Hi, sorry for the issue. I can see what you're saying but why is this
> an arm64 issue? The legacy Default metrics are common to all
> architectures:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=perf-tools-next

Since you are mentioning common metrics, I found the common metrics does
not work on Arm64 platform (I built with NO_JEVENTS=1 or enabled jevnts
but both don't work).

The latest perf will have no any output if the CPU type is missed in
json and rallback to common metrics. The failure path is:

  add_default_events()
    metricgroup__parse_groups()
      pmu_metrics_table__find()  => return NULL

In my case, pmu_metrics_table__find() always return NULL, as a result,
`perf stat sleep 1` directly bail out without any output.

I expect Breno's env might have the corresponding CPU json files, this
is possible different from my test machine.

Thanks,
Leo
