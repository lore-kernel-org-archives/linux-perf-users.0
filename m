Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BA54B1C4;
	Tue, 13 Oct 2026 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922492; cv=none; b=s2X9i7EJtCq2QQp91WY5lHUNv9Mdnr9n3hMitIIJEklFJ3KDUQz+uoMzZOuHUWA7YvdBBIuUTYgmqXJxiXB0uNU5UoAgTRmqZgRaVn0yuvQ1AE52S2+toVekynQkt0PTN86p74GabgTTwF8M8z2Dy6qqr2ecFygCcC6J9+xdtlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922492; c=relaxed/simple;
	bh=qNHb1CLjTtMHqgMCXUwp0cCKIIKt9WNSlisl2evFjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2/u39j76DzyHBBSoocfgEvj0kDYQ2TLqFdLtuMscLUViNdL0W/F6i/BKDAOricuplu+TrRzat3O0QybCgSPM2OWDB0ii0oVLTKnireZHqOLlECMcdUb/an6DURLDZu0sJV1289/18MG6v9wbuG9a3FbRvbq70lKdh0B+vmJJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BToMNplz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BToMNplz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD91F00893;
	Tue, 13 Oct 2026 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791922489;
	bh=eXXSCiITuXuvwb3zfcXD2NXYropFwuSwM81SLh+Zg28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BToMNplzG1vh2Fwk+pbmuhrTMfITunMbAnrZD9q4kckL+qBwrfhbBU8GSkTY0bcr4
	 rrEqyBsozguT4ma+v9SsfrulcKt1oiNvv0oeIrrIO+zRCm3kEx3SkPIsWUzgfCoC2T
	 O9GjtYQdku8CYI/qrqcxTiwWVQw1X4GTpb+pOqvCkyA3DVPvgBlHQkLgvzAhmX6g6w
	 5pAER8PXdd7gQOlkE0ptto5yg1IbnjX119iD//l4ZpY+6cx5xBmF5CLGiwt/XHkgnZ
	 qIui7WW9OUirGqqs/wKWM1MqRhQZw005pOyU3rwx0jBZnjUkZDYEYuaJSOSxKGDUiC
	 iNbOOsAjv++hg==
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
Subject: [PATCH v2 08/19] perf evsel: Don't dump probe events to PERF_TEST_ATTR
Date: Tue, 13 Oct 2026 17:14:03 -0300
Message-ID: <20261013201415.36428-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013201415.36428-1-acme@kernel.org>
References: <20261013201415.36428-1-acme@kernel.org>
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

