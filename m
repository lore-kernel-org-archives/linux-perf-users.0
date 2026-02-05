Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62D19E968;
	Thu,  5 Feb 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313974; cv=none; b=aT0Yl2feo5QvJoR05HCL5rx0I1TYoICjhee2ckllnY97AyBm1N6cvecjtPrY7VVWc9d9CRwDV2b7YMtL8SDhs6p8M8EUE6lcdX5y5SUt7Xsf7cwIxqzumPZvUy3+76K7h/s9CUYRXy/IGBKdpvlHEU8LYz3IBnz+PgJ9brP7Blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313974; c=relaxed/simple;
	bh=jN0aoRUS1Qa5I/977NdQpKXObJdgdZlLmxsbMhKQ2yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftwDomzdTgP+L3Mfs65GKGg9FwPLAwj1OmnoNhHXIC+1ltwk6mwp4eLe53zt0xEf+cntbYXBS5qZ1zQFYBp8CCZWI6D3J8gBP5w8hGv4afIid4yjq/CmfEfatARjjBD0pt/KCQjzEB6VVodcRBjpHskgkBY/6IPDyZ5FFeGZCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53D95339;
	Thu,  5 Feb 2026 09:52:46 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FD303F632;
	Thu,  5 Feb 2026 09:52:52 -0800 (PST)
Date: Thu, 5 Feb 2026 17:52:50 +0000
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
Message-ID: <20260205175250.GC3529712@e132581.arm.com>
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205173918.GB3529712@e132581.arm.com>

On Thu, Feb 05, 2026 at 05:39:18PM +0000, Leo Yan wrote:

> > > The sorting function introduced by commit a745c0831c15c ("perf stat:
> > > Sort default events/metrics") compares events based on their individual
> > > properties. This can cause events from different groups to be
> > > interleaved, resulting in group members appearing before their leaders
> > > in the sorted evlist.
> > 
> > Hi, sorry for the issue. I can see what you're saying but why is this
> > an arm64 issue? The legacy Default metrics are common to all
> > architectures:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=perf-tools-next
> 
> Since you are mentioning common metrics, I found the common metrics does
> not work on Arm64 platform (I built with NO_JEVENTS=1 or enabled jevnts
> but both don't work).
> 
> The latest perf will have no any output if the CPU type is missed in
> json and rallback to common metrics. The failure path is:
> 
>   add_default_events()
>     metricgroup__parse_groups()
>       pmu_metrics_table__find()  => return NULL
> 
> In my case, pmu_metrics_table__find() always return NULL, as a result,
> `perf stat sleep 1` directly bail out without any output.
> 
> I expect Breno's env might have the corresponding CPU json files, this
> is possible different from my test machine.

On my local env, I need a fix:

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index e4d00f6b2b5d..f74acc206856 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -3237,14 +3237,6 @@ const struct pmu_events_table *perf_pmu__default_core_events_table(void)
         return NULL;
 }
 
-const struct pmu_metrics_table *pmu_metrics_table__find(void)
-{
-        struct perf_cpu cpu = {-1};
-        const struct pmu_events_map *map = map_for_cpu(cpu);
-
-        return map ? &map->metric_table : NULL;
-}
-
 const struct pmu_metrics_table *pmu_metrics_table__default(void)
 {
         int i = 0;
@@ -3261,6 +3253,17 @@ const struct pmu_metrics_table *pmu_metrics_table__default(void)
         return NULL;
 }
 
+const struct pmu_metrics_table *pmu_metrics_table__find(void)
+{
+        struct perf_cpu cpu = {-1};
+        const struct pmu_events_map *map = map_for_cpu(cpu);
+
+       if (map)
+               return &map->metric_table;
+
+       return pmu_metrics_table__default();
+}
+

I have no deep understanding for jevents, seems to me, Breno's issue is
a different one from me.  Please kindly confirm.

Thanks,
Leo
