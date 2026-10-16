Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780529ACC5;
	Fri, 16 Oct 2026 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109953; cv=none; b=m5beaqMueGt1nmlECR6oOqrFhzje1+rgC8fbLgxgcsXcYSwDRAYKPfBN78yEUW8qosSMVNBdG8e6pUYu2bA5lV6qEFWz/D+G9HUGMS6Rqq6Oe2H0aDV51bYcLY42pq6WjDnh21snimrDxi7YKjzTqHjKcg7UfvI94u4gvmz018w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109953; c=relaxed/simple;
	bh=qNHb1CLjTtMHqgMCXUwp0cCKIIKt9WNSlisl2evFjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iM47Tpfk7Tv8fJSI1qFQLlTiahy8DTw4vC9sA22YT7EyCmxJEfjh61h+oQyiVzZOAz3iEHWCP1h9hN+2BaAk5/FOr81iTGMVQ3qtKIpJmBjpaODtn7/dthPw6YMrfKlD/CU2Jd/0lAISjKFlkdSpAB7sTd14InO7Zm4Oo03PzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elTj+mNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elTj+mNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8021F000C4;
	Fri, 16 Oct 2026 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792109952;
	bh=eXXSCiITuXuvwb3zfcXD2NXYropFwuSwM81SLh+Zg28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=elTj+mNJgHFGrvZzkeKcwzg599CuSPNvrgvBn75UjPaodcZmjOondof8BSDWmkTHT
	 Jx0nNlCh3qUyY0HCooX+D/LLdgkFVyx5rOOjicf34v2vTK8pmmgbUFarYa5Lkn52mF
	 LP9/LZRrZHfbbwkR4VEksYKe0lmiqs3CDxRMPmanzi1e+sPttUYAuPynuUs0DOQGmf
	 OePNp5XClLB2lQh6eTMajstPef/sW2Hxr8coo8RGx5y0DUVgQ6cTdGDTCRomdBgSo2
	 B4Tmj/Pi2SyGNL0xsAFRtVOyhDIV6uXhz7ItOTleKDjqY/O7LgcIElT9aJ0VKwIz9K
	 9SoSAmctMKOEg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 08/19] perf evsel: Don't dump probe events to PERF_TEST_ATTR
Date: Thu, 15 Oct 2026 21:18:32 -0300
Message-ID: <20261016001843.71978-9-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016001843.71978-1-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Events opened just to ask if they are supported, i.e. the ones in
is_event_supported() and is_libpfm_event_supported(), go through the
regular evsel__open() path and thus end up in the event files written to
$PERF_TEST_ATTR, with everything but type, config and disabled zeroed:

  [event-0-38654705664-3]
  fd=3
  cpu=-1
  pid=0
  type=0
  size=0
  config=38654705664
  sample_type=0
  ...

which 'perf test attr' then takes as one of the events that were asked
for, failing with:

  expected cpu=0, got -1
  expected size=176, got 0
  expected sample_type=65927, got 0
  expected freq=1, got 0

This started showing up when there is more than one core PMU, as
perf_pmus__supports_extended_type() probes one such event per core PMU,
but these records were always bogus: nothing asked for them.

Flag those evsels as support probes, keeping the name clear of the
kprobe/uprobe meaning probe already has in evsel, and leave them out of
the dump.

Reported-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/linux-perf-users/asWQvXRdqp_RK85c@google.com/
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c        | 6 +++++-
 tools/perf/util/evsel.h        | 1 +
 tools/perf/util/pfm.c          | 1 +
 tools/perf/util/print-events.c | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e61f309e93dccc7f..59318fef03cb17ff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3104,7 +3104,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			bpf_counter__install_pe(evsel, idx, fd);
 
-			if (unlikely(test_attr__enabled())) {
+			/*
+			 * Support probes aren't what was asked for, leave them
+			 * out of the PERF_TEST_ATTR dump.
+			 */
+			if (unlikely(test_attr__enabled() && !evsel->support_probe)) {
 				test_attr__open(&evsel->core.attr, pid, cpu,
 						fd, group_fd, evsel->open_flags);
 			}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 174f3414fd3cfa0d..53f3641b66e18674 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -120,6 +120,7 @@ struct evsel {
 	u64			db_id;
 	bool			uniquified_name;
 	bool 			supported;
+	bool			support_probe;	/* Opened just to check for support. */
 	bool 			needs_swap;
 	bool 			disabled;
 	bool			no_aux_samples;
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index f80d6b0df47ae64d..ad9bc481da70604e 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -141,6 +141,7 @@ static bool is_libpfm_event_supported(const char *name, struct perf_cpu_map *cpu
 		return false;
 
 	evsel->is_libpfm_event = true;
+	evsel->support_probe = true;
 
 	ret = evsel__open(evsel, cpus, threads);
 	if (ret == -EACCES) {
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 0242243681b6b6f9..77428d9e73c4f1b6 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -147,6 +147,7 @@ bool is_event_supported(u8 type, u64 config)
 
 	evsel = evsel__new(&attr);
 	if (evsel) {
+		evsel->support_probe = true;
 		ret = evsel__open(evsel, NULL, tmap) >= 0;
 
 		if (!ret) {
-- 
2.55.0

