Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C13CAE93;
	Tue,  2 Jun 2026 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444676; cv=none; b=Wz+0+xD8i7zDoOjd16Zh9f+IhA+WVOFKJXtnZDdxVUORXcshi6ExhB0qjeX3hdB3U8U7jWSokIlgwX4iNmPDJuEKqo3HPLSnZrGsxS9pBOa5W5f1F/OsZp65Yw+v/c4khQl/94fuSpYCrns1zmZzz+w6d0XMZcHZt+Kpyv43AJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444676; c=relaxed/simple;
	bh=3W+M9g0IM0OKXb/XsOgrm7hbrT6yi1m+2Bb9CW8vooc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5gc4u89lTTutsdUUaDC97SuOhUytPAuBxlmCVrjy1RSxNknhk88N8NOJSblA02nYiF8BxDQJQRFyz/NU2BNCSmL0NJUm0rhLkxlcbDibDPB6syV7p5f7Ez9QoLK3S1mareIwSLj4CJX8qFnoB++03pTSdwXMS5dK+o7YcgauiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0TXo37p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0TXo37p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2BD1F00898;
	Tue,  2 Jun 2026 23:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444674;
	bh=PlgokHVzlvqNn7AcOeXGgDaNmWunftIleGMUmqpUrIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C0TXo37pooi5t5BHR7D0doJhRFAKzmAE7EF5RzA0+kLvKmvh5e+bZHEJap801jvYO
	 0gLGjvwT6MKlOB5UlaQP1L0OGYYyKfBtojdK/Lw9LH0ePHse5KhN3xYQngnh6OQBUD
	 yPN7XaoqiL837nUJU6CeNR9D7FgdwXdqINFz8iSaXjswBg2nOiDlh6UWQi8a+c0Ct4
	 m7QGVtYP0Omp384G0yo+jfC2772QwmetlP0DKiztYZvDyoGK0la0gS4fEKsibxAXG2
	 V+0tzD123Ol95//4HgGetiHVUomS72EdIa47TGJSw/qvEhXmeFvFVZJnu3WPe/R+Cr
	 62sW+SIVFt9DQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 7/8] perf sched: Replace BUG_ON on invalid CPU with graceful skip
Date: Tue,  2 Jun 2026 20:57:06 -0300
Message-ID: <20260602235709.1541603-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
References: <20260602235709.1541603-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

latency_switch_event(), latency_runtime_event(), and map_switch_event()
use BUG_ON(cpu >= MAX_CPUS || cpu < 0) to validate the sample CPU.
When PERF_SAMPLE_CPU is absent from the sample type,
evsel__parse_sample() initializes sample->cpu to (u32)-1.  Casting
this to int yields -1, which triggers the BUG_ON and aborts perf sched.

The central CPU validation in perf_session__deliver_event() intentionally
preserves the (u32)-1 sentinel for downstream tools like perf script
and perf inject, so leaf callbacks must handle it themselves.

Replace the three BUG_ON calls with graceful skips using pr_warning(),
matching the existing pattern in process_sched_switch_event() and
process_sched_runtime_event() earlier in the same file.  Include the
file offset for cross-referencing with perf report -D.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 9ec8e049e19b0038..81833d169470582b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1145,7 +1145,12 @@ static int latency_switch_event(struct perf_sched *sched,
 	int cpu = sample->cpu, err = -1;
 	s64 delta;
 
-	BUG_ON(cpu >= MAX_CPUS || cpu < 0);
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
+	if (cpu >= MAX_CPUS || cpu < 0) {
+		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
+			   sample->file_offset, cpu);
+		return 0;
+	}
 
 	timestamp0 = sched->cpu_last_switched[cpu];
 	sched->cpu_last_switched[cpu] = timestamp;
@@ -1215,7 +1220,13 @@ static int latency_runtime_event(struct perf_sched *sched,
 	if (thread == NULL)
 		return -1;
 
-	BUG_ON(cpu >= MAX_CPUS || cpu < 0);
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
+	if (cpu >= MAX_CPUS || cpu < 0) {
+		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
+			   sample->file_offset, cpu);
+		err = 0;
+		goto out_put;
+	}
 	if (!atoms) {
 		if (thread_atoms_insert(sched, thread))
 			goto out_put;
@@ -1640,7 +1651,12 @@ static int map_switch_event(struct perf_sched *sched,  struct perf_sample *sampl
 	const char *str;
 	int ret = -1;
 
-	BUG_ON(this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0);
+	/* perf.data is untrusted input — CPU may be absent or corrupted */
+	if (this_cpu.cpu >= MAX_CPUS || this_cpu.cpu < 0) {
+		pr_warning("WARNING: at offset %#" PRIx64 ": out-of-bound sample CPU %d, skipping sample\n",
+			   sample->file_offset, this_cpu.cpu);
+		return 0;
+	}
 
 	if (this_cpu.cpu > sched->max_cpu.cpu)
 		sched->max_cpu = this_cpu;
-- 
2.54.0

