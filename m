Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21993CB2FC;
	Tue,  2 Jun 2026 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444670; cv=none; b=qZmm10Pai7m2oMIo24ddDyhmdOh56tgDiQxmq8mAbKUxMLoKcvn1VN4/fUjNZKAXDMUbZLWJVOn9z2Qun8zYOl7M6u2fAlEdsXiOa6HEyI9gNS3UfzC+9MMO8eROZuTvCc3cenOKaNMjVkGRuz/bJpqmgO9aB4Tg6cOBcI/tfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444670; c=relaxed/simple;
	bh=XairhkinOlLgJ183KSKtqLr/kj2basHlueOJfjWbfhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai3qf7zFMuQUoIfmHYo90xmlCVziOS8ekkp+jg9jIuXmqHTRCeCK5VLJAP06Y99+DtyWOl2RmiXF4D85A4n/VzrKNO+ZcKVA13cda7NfjLl0EgNBDWnK6FJ1J0ui3FO/L7MAP11ObNpJvWCtE52xunrgFdi3FX9D6pdCiakalsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0l1MYmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0l1MYmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2452E1F00893;
	Tue,  2 Jun 2026 23:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444669;
	bh=7lWCIY/S0jG4bknSkEfEJyJMreQkwBYC0pOxtklnA1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q0l1MYmdndIK39Bi8GVucvTcth2OHo3TeMz59qnWRVNN3B7OIiKLtThA8ovR4WhUy
	 bX/Z0VfiPp2BJ7DJ2Ugb9MmT4kn7WIPLNuBlb/5JouVGaoncT3qvOGK9N8JZFzBiQq
	 QWgR16z3P5Miu1//4QLDvkMYYUIcmF1u28GKNz4qCcXNvlBFctro4ajeCEF5ucHio4
	 VjZRQbgavDWe3vqL2I3Kt9FnPawQJ4oRKbcV4oo/IETf3xMsrhGvzZwC/+pGttlHap
	 i0kkVY1t7xjMabnZRDQT7aFOR77fDt8WiMXgBPJtYulxpkqsgCxgmhLEM+cd7ike+D
	 a5fu3H4OlxC2Q==
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
Subject: [PATCH 6/8] perf timechart: Fix cat_backtrace() use-after-free on corrupted callchain
Date: Tue,  2 Jun 2026 20:57:05 -0300
Message-ID: <20260602235709.1541603-7-acme@kernel.org>
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

cat_backtrace() uses open_memstream() to build a backtrace string.
When an invalid callchain context is encountered, zfree(&p) frees
the memstream buffer, then the exit path calls fclose(f), which
flushes to the already-freed buffer — a use-after-free.  The function
then returns a dangling pointer that the caller passes to a handler
and subsequently double-frees.

Fix by replacing the zfree(&p) with a 'corrupted' flag.  At the exit
label, always fclose(f) first (which finalizes the buffer), then
conditionally free it when corrupted.  This ensures the memstream
contract is honored: the buffer remains valid until fclose().

While here, update the machine__resolve failure message to include
file_offset and the event type name, matching the pattern from the
preceding series.  Also update the three legacy power event handlers
under SUPPORT_OLD_POWER_EVENTS to include file_offset in their
out-of-bounds CPU messages for consistency.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 071987241a528ba4..85a9ad0455aecccd 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -489,6 +489,10 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 	}
 }
 
+/*
+ * Returns a malloc'd backtrace string built via open_memstream, or NULL
+ * on error.  Caller must free() the returned pointer.
+ */
 static char *cat_backtrace(union perf_event *event,
 			   struct perf_sample *sample,
 			   struct machine *machine)
@@ -500,6 +504,7 @@ static char *cat_backtrace(union perf_event *event,
 	u8 cpumode = PERF_RECORD_MISC_USER;
 	struct ip_callchain *chain = sample->callchain;
 	FILE *f = open_memstream(&p, &p_len);
+	bool corrupted = false;
 
 	if (!f) {
 		perror("open_memstream error");
@@ -511,8 +516,9 @@ static char *cat_backtrace(union perf_event *event,
 		goto exit;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
-		fprintf(stderr, "problem processing %d event, skipping it.\n",
-			event->header.type);
+		pr_err("problem processing %s (%u) event at offset %#" PRIx64 ", skipping it.\n",
+		       perf_event__name(event->header.type), event->header.type,
+		       sample->file_offset);
 		goto exit;
 	}
 
@@ -537,14 +543,8 @@ static char *cat_backtrace(union perf_event *event,
 				cpumode = PERF_RECORD_MISC_USER;
 				break;
 			default:
-				pr_debug("invalid callchain context: "
-					 "%"PRId64"\n", (s64) ip);
-
-				/*
-				 * It seems the callchain is corrupted.
-				 * Discard all.
-				 */
-				zfree(&p);
+				pr_debug("invalid callchain context: %" PRId64 "\n", (s64) ip);
+				corrupted = true;
 				goto exit;
 			}
 			continue;
@@ -561,7 +561,14 @@ static char *cat_backtrace(union perf_event *event,
 	}
 exit:
 	addr_location__exit(&al);
+	/*
+	 * fclose() on an open_memstream always sets p to a valid buffer,
+	 * even if nothing was written — see open_memstream(3).  So p is
+	 * never NULL after fclose and we need the flag to discard it.
+	 */
 	fclose(f);
+	if (corrupted)
+		zfree(&p);
 
 	return p;
 }
@@ -686,7 +693,8 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 	/* perf.data is untrusted input — cpu_id may be corrupted */
 	if (cpu_id >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %llu\n",
+			 sample->file_offset, (unsigned long long)cpu_id);
 		return -1;
 	}
 	c_state_start(cpu_id, sample->time, value);
@@ -700,7 +708,8 @@ process_sample_power_end(struct timechart *tchart,
 {
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu %u\n", sample->cpu);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu %u\n",
+			 sample->file_offset, sample->cpu);
 		return -1;
 	}
 	c_state_end(tchart, sample->cpu, sample->time);
@@ -717,7 +726,8 @@ process_sample_power_frequency(struct timechart *tchart,
 
 	/* perf.data is untrusted input — cpu_id may be corrupted */
 	if (cpu_id >= MAX_CPUS) {
-		pr_debug("Out-of-bounds cpu_id %llu\n", (unsigned long long)cpu_id);
+		pr_debug("at offset %#" PRIx64 ": out-of-bounds cpu_id %llu\n",
+			 sample->file_offset, (unsigned long long)cpu_id);
 		return -1;
 	}
 	p_state_change(tchart, cpu_id, sample->time, value);
-- 
2.54.0

