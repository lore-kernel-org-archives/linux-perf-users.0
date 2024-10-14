Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F32153BF8;
	Mon, 14 Oct 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933749; cv=none; b=tXxD/sgZ02iNkIV7KtAgbx2+vkF6xGksqMrM348oYRvO9XWq8SnwMcH3zzOM2ovcjJWVjRugECWHcpcvW4jR65b+V6EZzULvq2/tj98niwKb2Ji8Ut4CKT2i1Ax59srFAeTkMzSx42rkAjNTMykhi5YIQhlZcYMRwavz9SCEfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933749; c=relaxed/simple;
	bh=HkvfNoujqbpWdYNRwFDEuggdGcE60lfwUM5RbEbk9c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyDJ3B0//GNqp42+XTgYXF5viewThXX+w+tJYO3SaMJly7E+P8i0orV+n1/0k+bsSR79L7NEFcrvKaJaiygHosA3ItrzpqfiJST9q5hRIYVO6NKID2k0UKO+jALr3v8jiyHJ9sNLMo6vo78+L6abiCeDU0ILjwl9otyH/5q9cGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy5jNvXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy5jNvXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE83C4CEC3;
	Mon, 14 Oct 2024 19:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728933748;
	bh=HkvfNoujqbpWdYNRwFDEuggdGcE60lfwUM5RbEbk9c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jy5jNvXDMjMLFjNh7ifVMeSxwrJi0vhU81PBSZsdnXP38wKv42c00sYjfpTpMDCvq
	 MGs7CQSVDeyLlDvqX+3QnDgUotWMp3+JRLmffqwXSy2SCvsVHFOPPMaLHQZTaCrw4c
	 Bdosio2vAn+ogoYnHJn1FniaFTzDiFv+wLP3emY0bu5ttZDFb655stLHjsxDyX96rl
	 2noGGl/W5HkZZmMCjxC4emOQeFIbFBl8l/rHKxQ/zK+aZQt+CtEVBCozvhHBZSTTD4
	 H1kZXq8B3zuQZ7/oznGGXQOjBnsWNpikQvEk9XHIAGtpANctaeoW2K13/qRmdOHPIp
	 jrpKOQXSEK/wg==
Date: Mon, 14 Oct 2024 12:22:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 7/8] perf tools: Check fallback error and order
Message-ID: <Zw1vcnX-HdnmJMU1@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-8-namhyung@kernel.org>
 <CAP-5=fVBhLfb3Md1b6NZqmOh4q4_S5=g8hA7p6UzuPJG2GfPiQ@mail.gmail.com>
 <ZvxrQsHML0A1kF1P@google.com>
 <CAP-5=fUAqmvA+pzE15Lmk4Aakj6tOzrqYFhYb43UX9B3E3Odmg@mail.gmail.com>
 <Zv7O_XJZcSIS9I_i@google.com>
 <CAP-5=fUVLEo0f5ygccnf11J2zdZbFmoGF5UatAb+E8T9vwbeAg@mail.gmail.com>
 <Zv8cyZN1p7EI08XA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv8cyZN1p7EI08XA@google.com>

Hi Ian,

On Thu, Oct 03, 2024 at 03:38:01PM -0700, Namhyung Kim wrote:
> On Thu, Oct 03, 2024 at 10:32:47AM -0700, Ian Rogers wrote:
> > On Thu, Oct 3, 2024 at 10:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > On Tue, Oct 01, 2024 at 03:21:50PM -0700, Ian Rogers wrote:
> > > > On Tue, Oct 1, 2024 at 2:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > On Tue, Oct 01, 2024 at 11:00:20AM -0700, Ian Rogers wrote:
> > > > > > On Mon, Sep 30, 2024 at 5:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > >
> > > > > > > The perf_event_open might fail due to various reasons, so blindly
> > > > > > > reducing precise_ip level might not be the best way to deal with it.
> > > > > > >
> > > > > > > It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
> > > > > > > given precise level.  Let's try again with the correct error code.
> > > > > > >
> > > > > > > This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
> > > > > > > user events with exclude_kernel=1 cannot make progress.  Let's add the
> > > > > > > evsel__handle_error_quirks() to this case specially.  I plan to work on
> > > > > > > the kernel side to improve this situation but it'd still need some
> > > > > > > special handling for IBS.
> > > > > > >
> > > > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > > ---
> > > > > > >  tools/perf/util/evsel.c | 27 +++++++++++++++++++++------
> > > > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > > > > index 32e30c293d0c6198..ef8356260eea54cd 100644
> > > > > > > --- a/tools/perf/util/evsel.c
> > > > > > > +++ b/tools/perf/util/evsel.c
> > > > > > > @@ -2419,6 +2419,20 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
> > > > > > >         return false;
> > > > > > >  }
> > > > > > >
> > > > > > > +static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> > > > > > > +{
> > > > > > > +       /* AMD IBS doesn't support exclude_kernel, forward it to core PMU */
> > > > > >
> > > > > > Should the quirk handling be specific to evsels with the IBS PMU given
> > > > > > the comment above? ie this is a PMU specific workaround rather than an
> > > > > > AMD specific workaround, however, the PMU only exists on AMD :-)
> > > > > >
> > > > > > > +       if (error == -EINVAL && evsel->precise_max && evsel->core.attr.precise_ip &&
> > > > > > > +           evsel->core.attr.exclude_kernel && x86__is_amd_cpu()) {
> > > > > >
> > > > > > So here rather than x86__is_amd_cpu it would be
> > > > > > !strcmp(evsel->pmu->name, "ibs_...") . But it may be cleaner to move
> > > > > > the logic into pmu.c.
> > > > >
> > > > > I guess the problem is that AMD driver does implicit forwarding to IBS
> > > > > if the legacy hardware events have precise_ip.  So it might have just
> > > > > core pmu (or no pmu) in the evsel.
> > > >
> > > > I think the no PMU case should probably have a PMU possibly similar to
> > > > the tool PMU in:
> > > > https://lore.kernel.org/all/20240912190341.919229-1-irogers@google.com/
> > > > But that's not in place yet. You can always use
> > > > perf_pmus__scan_core(NULL) or
> > > > perf_pmus__find_by_type(evsel->core.attr.type or PERF_TYPE_RAW).
> > > > evsel->pmu->is_core && x86__is_amd_cpu() would identify an AMD core
> > > > PMU whereas the code above could fire for IBS or other PMUs.
> > >
> > > But IBS is the only PMU on AMD that provides precise_ip IIRC.  So I
> > > don't think other events would have it nor have any effect on changing
> > > the value.  So maybe we can skip the PMU scanning and just drop to 0?
> > 
> > cpu supports precise_ip as it forwards it to IBS, IBS is an ambiguous
> > term as there are ibs_op and ibs_fetch PMUs. The code is using values
> > in the attribute to infer the PMU that is being used, it feels it
> > would be more intention revealing to do things like:
> > ```
> > if (error == ... && perf_pmu__is_ibs_op_or_fetch(evsel->pmu)) ..
> > ```
> 
> I guess it'd get a core PMU for the default cycles event.  I think the
> intention is already confusing with the implicit forwarding.

What about this?

---8<---

From 70d39fb5c2956ba264a292f112f7fd7272dc91be Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 3 Sep 2024 22:50:09 -0700
Subject: [PATCH] perf tools: Check fallback error and order

The perf_event_open might fail due to various reasons, so blindly
reducing precise_ip level might not be the best way to deal with it.

It seems the kernel return -EOPNOTSUPP when PMU doesn't support the
given precise level.  Let's try again with the correct error code.

This caused a problem on AMD, as it stops on precise_ip of 2 for IBS but
user events with exclude_kernel=1 cannot make progress.  Let's add the
evsel__handle_error_quirks() to this case specially.  I plan to work on
the kernel side to improve this situation but it'd still need some
special handling for IBS.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 50 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 476658143822c346..2c45c55222c43dd4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2246,6 +2246,43 @@ static bool evsel__detect_missing_features(struct evsel *evsel)
 	return false;
 }
 
+/*
+ * AMD core PMU forwards some events with precise_ip to IBS implicitly.
+ * This logic matches to the kernel function (core_pmu_ibs_config).
+ */
+static bool evsel__is_implicit_ibs_event(struct evsel *evsel)
+{
+	if (evsel->core.attr.precise_ip == 0 || !x86__is_amd_cpu())
+		return false;
+
+	if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
+	    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES)
+		return true;
+
+	if (evsel->core.attr.type == PERF_TYPE_RAW &&
+	    (evsel->core.attr.config == 0x76 || evsel->core.attr.config == 0xc1))
+		return true;
+
+	return false;
+}
+
+static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
+{
+	/*
+	 * AMD IBS doesn't support exclude_kernel, forward it back to the core
+	 * PMU by clearing precise_ip only if it's from precise_max (:P).
+	 */
+	if (error == -EINVAL && evsel__is_implicit_ibs_event(evsel) &&
+	    evsel->core.attr.exclude_kernel && evsel->precise_max) {
+		evsel->core.attr.precise_ip = 0;
+		pr_debug2_peo("removing precise_ip on AMD\n");
+		display_attr(&evsel->core.attr);
+		return true;
+	}
+
+	return false;
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu_map_idx, int end_cpu_map_idx)
@@ -2366,9 +2403,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	return 0;
 
 try_fallback:
-	if (evsel__precise_ip_fallback(evsel))
-		goto retry_open;
-
 	if (evsel__ignore_missing_thread(evsel, perf_cpu_map__nr(cpus),
 					 idx, threads, thread, err)) {
 		/* We just removed 1 thread, so lower the upper nthreads limit. */
@@ -2385,11 +2419,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
 		goto retry_open;
 
-	if (err != -EINVAL || idx > 0 || thread > 0)
-		goto out_close;
+	if (err == -EOPNOTSUPP && evsel__precise_ip_fallback(evsel))
+		goto retry_open;
 
-	if (evsel__detect_missing_features(evsel))
+	if (err == -EINVAL && evsel__detect_missing_features(evsel))
 		goto fallback_missing_features;
+
+	if (evsel__handle_error_quirks(evsel, err))
+		goto retry_open;
+
 out_close:
 	if (err)
 		threads->err_thread = thread;
-- 
2.47.0.rc1.288.g06298d1525-goog

