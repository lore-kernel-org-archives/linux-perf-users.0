Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3737C10C;
	Thu,  9 Apr 2026 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730798; cv=none; b=q6wG/J/qjfwCP2+V94KVVaBmpeOIrJFr8v9btKaeaK3W62l2IIW4oSRKnz7z9vzOgSmZHFHSAYiuL/kS6FB3jBq+oVr0BKwecTTVf8t95URCPQ975uVBME3oAcyDh354PLW3fDVe7XqtnGXzQZi1gN7kH7iHoJnpFKAYvQmcddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730798; c=relaxed/simple;
	bh=8czUvg+EycwtHlbZWxF7J0jKdXRWUlyM2w5PFmEYPX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neC73scYCI0O3QyjfmXsdRAUUoF1WC8qWxML8JQ2f/dSOHXE0G7Z22mV6dU7AQzucCIerQ7Xp+Iht0SAmsElws4RHRZvCrceBhnsQ6vsnfLD7roIH05qEDq8YqsUpivYM6lnIfqem41ILFRxAX4iKowtZnF88ld9uk/wSBKrZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcBUYY0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcBUYY0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40E0C4CEF7;
	Thu,  9 Apr 2026 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775730798;
	bh=8czUvg+EycwtHlbZWxF7J0jKdXRWUlyM2w5PFmEYPX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hcBUYY0NnKBezFbYhem2WL28Vc0KnxeimOAEAOSzb6XkOhWdD0bobaa7WsIZ8/pug
	 MKsF7Xm5AU0nDBEmzbr+L0WO3czOaNZUuknyMWFJ2xlvg+ml4fWLWFkGXzIOTOsvRy
	 NTO8vNxXEMwaJuU1Jagl4GNMSdmhnGC0W003kYUNoHGlTz47XLtASNxmpE6uZp2ICs
	 p/aVOfFvwiDS3fMVNzhxs/V6p1cY0WlBV2PA4qDgjh/hMSpAYnnvLSzVcBHhpLSVav
	 auatanNlZldLFRolOhvPkkKHC0PXjszLy/okBVIErgeQ1ezaFqfJXBbmfYhfcwbtQa
	 /dYGtwyVQI6zQ==
Date: Thu, 9 Apr 2026 07:33:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES perf-tools-next v6 0/8] Cleanups and fixes
Message-ID: <adeAarNktqfAQHwG@x1>
References: <20260408173203.96700-1-acme@kernel.org>
 <adcM73wJFBaKZs5t@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcM73wJFBaKZs5t@google.com>

On Wed, Apr 08, 2026 at 07:20:31PM -0700, Namhyung Kim wrote:
> On Wed, Apr 08, 2026 at 02:31:55PM -0300, Arnaldo Carvalho de Melo wrote:
> >         Here are some cleanups, a refresh for a patch Ian sent and fell
> > thru the cracks, using calloc where applicable, constify some arrays and
> > add a missing header that was making the build fail on some musl
> > systems.

> > 	This also adds checks for perf.data headers that were suggested
> > by sashiko.

> It seems sashiko keeps creating new issues or finding bugs.  As we
> discussed, I'd like to apply this series to fix known things first
> and we can address other issues separately.

Sure, please merge v6 as-is if you think it is ok and I'll come up with
follow up patches addressing more issues, for instance, here are some
more checks I'm writing with the help of Claude:

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 22c44b6f0b098f95..2d23dbc666b676be 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2722,6 +2722,13 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 	ret = do_read_u32(ff, &nr_cpus_online);
 	if (ret)
 		return ret;
+
+	if (nr_cpus_online > nr_cpus_avail) {
+		pr_err("Invalid HEADER_NRCPUS: nr_cpus_online (%u) > nr_cpus_avail (%u)\n",
+		       nr_cpus_online, nr_cpus_avail);
+		return -1;
+	}
+
 	env->nr_cpus_avail = (int)nr_cpus_avail;
 	env->nr_cpus_online = (int)nr_cpus_online;
 	return 0;
@@ -3698,6 +3705,17 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 	nra = env->nr_cpus_avail;
 	nr = env->nr_cpus_online;
 
+	if (nra == 0 || nr == 0) {
+		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: missing HEADER_NRCPUS\n");
+		return -1;
+	}
+
+	if (ff->size < 2 * sizeof(u32) + nr * 2 * sizeof(u32)) {
+		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: section too small (%zu) for %u CPUs\n",
+		       (size_t)ff->size, nr);
+		return -1;
+	}
+
 	cd_map = calloc(nra, sizeof(*cd_map));
 	if (!cd_map)
 		return -1;
@@ -3714,6 +3732,19 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 	if (ret)
 		return ret;
 
+	/*
+	 * Sanity check: real systems have at most ~10 sched domain levels
+	 * (SMT, CLS, MC, PKG + NUMA hops). Reject obviously bogus values
+	 * from malformed perf.data files before they cause excessive
+	 * allocation in the per-CPU loop.
+	 */
+#define MAX_SCHED_DOMAINS 64
+	if (max_sched_domains > MAX_SCHED_DOMAINS) {
+		pr_err("Invalid HEADER_CPU_DOMAIN_INFO: max_sched_domains %u > %u\n",
+		       max_sched_domains, MAX_SCHED_DOMAINS);
+		return -1;
+	}
+
 	env->max_sched_domains = max_sched_domains;
 
 	for (i = 0; i < nr; i++) {
@@ -3725,6 +3756,11 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			return -1;
 		}
 
+		if (cd_map[cpu]) {
+			pr_err("Invalid HEADER_CPU_DOMAIN_INFO: duplicate cpu %u\n", cpu);
+			return -1;
+		}
+
 		cd_map[cpu] = zalloc(sizeof(*cd_map[cpu]));
 		if (!cd_map[cpu])
 			return -1;
@@ -3760,7 +3796,13 @@ static int process_cpu_domain_info(struct feat_fd *ff, void *data __maybe_unused
 			if (!d_info)
 				return -1;
 
-			assert(cd_map[cpu]->domains[domain] == NULL);
+			if (cd_map[cpu]->domains[domain]) {
+				pr_err("Invalid HEADER_CPU_DOMAIN_INFO: duplicate domain %u for cpu %u\n",
+				       domain, cpu);
+				free(d_info);
+				return -1;
+			}
+
 			cd_map[cpu]->domains[domain] = d_info;
 			d_info->domain = domain;
 
