Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50D3C76AF;
	Tue,  2 Jun 2026 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444651; cv=none; b=KdORGgONZgpepcQh1Tjydqauyopf0n6O4BNfJMGZUSATS51Tt6th1lijX/Bq/BZ/xh3F9Y7j/1buWnVaZzWVfC5NdWETgrX+CTjzRstezZsFuK/4uMeTsf5S3mwXWxMsLbXRlFJIjlrpXzkW+pN20V2zss8LArtMAhb4GCKQJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444651; c=relaxed/simple;
	bh=FizgIGoqxIYieXEQd67/TFnY4gePAIZsmdbaF6lKoWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEkVBiFQps0tuGFhg2qqi3X30MZPnkPXI7W+jSeBOc/YvtctrWGrnSqQEHbhnYAPY5neS8ToxF3kp1BgGS99ym1lXMOAoPCsC8kFjFSYpJV/+5NPaq+VO8NbUPHUYUeuyGHW1fqXZ7iFcF6Q/2G/RBbU15cqe25LKIB5KWS7zN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vgsr6AdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vgsr6AdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A919A1F00893;
	Tue,  2 Jun 2026 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444649;
	bh=78qyVSIOLPMH4ADifqB4NJQ/0qW2+qa/hZS/twONP98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vgsr6AdFg5ObLEnl7w5fPW5wZrgbzhpyjX/gqSNBg5zpXq/1YWKcxaTNJqYTuFNX+
	 XAduxqHG6ToID7/tfE9nLDQLVLaWzZg4z60cablK4qtKr9Ay8j8txxh/brp+GI9CgC
	 uCqoeGBrwSQJcXvhe5EgU5vD2+lj7pGRqxj8mc1dyN/R0jhZ96jqKlimabSVdbI+7u
	 Hwa4Hb//Ag2Gushecnw5siGH57fQEKLc1rLQnKZ+Gah0rsR7NC5jTl+vyA4HTTdYxD
	 dldu2ETp+6d0xrBBLA5ujY/WzqMp1mJSpE067fcnuFyhvI4FdeYy66anaIeAHnxAEQ
	 KAukl43HN+tnQ==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 2/8] perf session: Include file offset in event skip/stop messages
Date: Tue,  2 Jun 2026 20:57:01 -0300
Message-ID: <20260602235709.1541603-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
References: <20260602235709.1541603-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add 'at offset %#<hex>' to all warning and error messages in session.c
that fire when events are skipped or processing stops due to validation
failures.  This lets users cross-reference with 'perf report -D' output
to inspect the surrounding records and understand the corruption context.

Covers messages in perf_session__process_event() (alignment, min size,
swap failure), perf_session__deliver_event() (no evsel, parse failure,
CPU clamping), machines__deliver_event() (NAMESPACES, TEXT_POKE,
null-terminated string checks for MMAP/MMAP2/COMM/CGROUP/KSYMBOL), and
perf_session__process_user_event() (THREAD_MAP, CPU_MAP, STAT_CONFIG,
BPF_METADATA, HEADER_BUILD_ID).

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 112 ++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7996787d742e32c6..e4efb75509278a4e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1931,13 +1931,14 @@ static int session__flush_deferred_samples(struct perf_session *session,
  * read-only (MAP_SHARED + PROT_READ) so we cannot write a
  * null byte in place; skip the event instead.
  */
-static bool perf_event__check_nul(const char *str, const void *end, const char *event_name)
+static bool perf_event__check_nul(const char *str, const void *end,
+				  const char *event_name, u64 file_offset)
 {
 	size_t max_len = (const char *)end - str;
 
 	if (max_len == 0 || strnlen(str, max_len) == max_len) {
-		pr_warning("WARNING: PERF_RECORD_%s: string not null-terminated, skipping event\n",
-			   event_name);
+		pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_%s: string not null-terminated, skipping event\n",
+			   file_offset, event_name);
 		return false;
 	}
 
@@ -1995,7 +1996,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_MMAP:
 		if (!perf_event__check_nul(event->mmap.filename,
 					   (void *)event + event->header.size,
-					   "MMAP"))
+					   "MMAP", file_offset))
 			return 0;
 		return tool->mmap(tool, event, sample, machine);
 	case PERF_RECORD_MMAP2:
@@ -2003,13 +2004,13 @@ static int machines__deliver_event(struct machines *machines,
 			++evlist->stats.nr_proc_map_timeout;
 		if (!perf_event__check_nul(event->mmap2.filename,
 					   (void *)event + event->header.size,
-					   "MMAP2"))
+					   "MMAP2", file_offset))
 			return 0;
 		return tool->mmap2(tool, event, sample, machine);
 	case PERF_RECORD_COMM:
 		if (!perf_event__check_nul(event->comm.comm,
 					   (void *)event + event->header.size,
-					   "COMM"))
+					   "COMM", file_offset))
 			return 0;
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES: {
@@ -2027,8 +2028,8 @@ static int machines__deliver_event(struct machines *machines,
 		 * cross-endian path.
 		 */
 		if (event->namespaces.nr_namespaces > max_nr) {
-			pr_warning("WARNING: PERF_RECORD_NAMESPACES: nr_namespaces %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
-				   (u64)event->namespaces.nr_namespaces, max_nr);
+			pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_NAMESPACES: nr_namespaces %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
+				   file_offset, (u64)event->namespaces.nr_namespaces, max_nr);
 			return 0;
 		}
 		return tool->namespaces(tool, event, sample, machine);
@@ -2036,7 +2037,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_CGROUP:
 		if (!perf_event__check_nul(event->cgroup.path,
 					   (void *)event + event->header.size,
-					   "CGROUP"))
+					   "CGROUP", file_offset))
 			return 0;
 		return tool->cgroup(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
@@ -2078,7 +2079,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_KSYMBOL:
 		if (!perf_event__check_nul(event->ksymbol.name,
 					   (void *)event + event->header.size,
-					   "KSYMBOL"))
+					   "KSYMBOL", file_offset))
 			return 0;
 		return tool->ksymbol(tool, event, sample, machine);
 	case PERF_RECORD_BPF_EVENT:
@@ -2090,7 +2091,8 @@ static int machines__deliver_event(struct machines *machines,
 				       event->text_poke.new_len;
 
 		if (event->header.size < text_poke_len) {
-			pr_warning("WARNING: PERF_RECORD_TEXT_POKE: old_len+new_len exceeds event, skipping\n");
+			pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_TEXT_POKE: old_len+new_len exceeds event, skipping\n",
+				   file_offset);
 			return 0;
 		}
 		return tool->text_poke(tool, event, sample, machine);
@@ -2120,14 +2122,17 @@ static int perf_session__deliver_event(struct perf_session *session,
 	perf_sample__init(&sample, /*all=*/false);
 	evsel = evlist__event2evsel(session->evlist, event);
 	if (!evsel) {
-		pr_err("No evsel found for event type %u\n",
+		pr_err("ERROR: at offset %#" PRIx64 ": no evsel found for %s (%u) event\n",
+		       file_offset, perf_event__name(event->header.type),
 		       event->header.type);
 		ret = -EFAULT;
 		goto out;
 	}
 	ret = evsel__parse_sample(evsel, event, &sample);
 	if (ret) {
-		pr_err("Can't parse sample, err = %d\n", ret);
+		pr_err("ERROR: at offset %#" PRIx64 ": can't parse %s (%u) sample, err = %d\n",
+		       file_offset, perf_event__name(event->header.type),
+		       event->header.type, ret);
 		goto out;
 	}
 	sample.file_offset = file_offset;
@@ -2204,8 +2209,8 @@ static int perf_session__deliver_event(struct perf_session *session,
 			 * Downstream array users (timechart, kwork) have
 			 * their own per-callback bounds checks.
 			 */
-			pr_warning_once("WARNING: sample CPU %u >= nr_cpus_avail %u, clamping to 0\n",
-					sample.cpu, nr_cpus_avail);
+			pr_warning_once("WARNING: at offset %#" PRIx64 ": sample CPU %u >= nr_cpus_avail %u, clamping to 0\n",
+					file_offset, sample.cpu, nr_cpus_avail);
 			sample.cpu = 0;
 		}
 	}
@@ -2278,7 +2283,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_HEADER_BUILD_ID:
 		if (!perf_event__check_nul(event->build_id.filename,
 					   (void *)event + event_size,
-					   "HEADER_BUILD_ID")) {
+					   "HEADER_BUILD_ID", file_offset)) {
 			err = 0;
 			break;
 		}
@@ -2311,8 +2316,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		u64 max_nr;
 
 		if (event_size < sizeof(event->thread_map)) {
-			pr_err("PERF_RECORD_THREAD_MAP: header.size (%u) too small\n",
-			       event_size);
+			pr_err("ERROR: at offset %#" PRIx64 ": PERF_RECORD_THREAD_MAP: header.size (%u) too small\n",
+			       file_offset, event_size);
 			err = -EINVAL;
 			break;
 		}
@@ -2320,8 +2325,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		max_nr = (event_size - sizeof(event->thread_map)) /
 			 sizeof(event->thread_map.entries[0]);
 		if (event->thread_map.nr > max_nr) {
-			pr_err("PERF_RECORD_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 "\n",
-			       (u64)event->thread_map.nr, max_nr);
+			pr_err("ERROR: at offset %#" PRIx64 ": PERF_RECORD_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 "\n",
+			       file_offset, (u64)event->thread_map.nr, max_nr);
 			err = -EINVAL;
 			break;
 		}
@@ -2345,8 +2350,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 				     sizeof(data->cpus_data.cpu[0]);
 
 			if (data->cpus_data.nr > max_nr) {
-				pr_warning("WARNING: PERF_RECORD_CPU_MAP: nr %u exceeds payload (max %u), skipping\n",
-					   data->cpus_data.nr, max_nr);
+				pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_CPU_MAP: nr %u exceeds payload (max %u), skipping\n",
+					   file_offset, data->cpus_data.nr, max_nr);
 				err = 0;
 				goto out;
 			}
@@ -2359,8 +2364,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 					     sizeof(data->mask32_data.mask[0]);
 
 				if (data->mask32_data.nr > max_nr) {
-					pr_warning("WARNING: PERF_RECORD_CPU_MAP mask32: nr %u exceeds payload (max %u), skipping\n",
-						   data->mask32_data.nr, max_nr);
+					pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_CPU_MAP mask32: nr %u exceeds payload (max %u), skipping\n",
+						   file_offset, data->mask32_data.nr, max_nr);
 					err = 0;
 					goto out;
 				}
@@ -2375,14 +2380,14 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 							     mask64_data.mask)) /
 					 sizeof(data->mask64_data.mask[0]);
 				if (data->mask64_data.nr > max_nr) {
-					pr_warning("WARNING: PERF_RECORD_CPU_MAP mask64: nr %u exceeds payload (max %u), skipping\n",
-						   data->mask64_data.nr, max_nr);
+					pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_CPU_MAP mask64: nr %u exceeds payload (max %u), skipping\n",
+						   file_offset, data->mask64_data.nr, max_nr);
 					err = 0;
 					goto out;
 				}
 			} else {
-				pr_warning("WARNING: PERF_RECORD_CPU_MAP: unsupported long_size %u, skipping\n",
-					   data->mask32_data.long_size);
+				pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_CPU_MAP: unsupported long_size %u, skipping\n",
+					   file_offset, data->mask32_data.long_size);
 				err = 0;
 				goto out;
 			}
@@ -2404,8 +2409,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 * cannot clamp nr in place.  Skip the event instead.
 		 */
 		if (event->stat_config.nr > max_nr) {
-			pr_warning("WARNING: PERF_RECORD_STAT_CONFIG: nr %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
-				   (u64)event->stat_config.nr, max_nr);
+			pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_STAT_CONFIG: nr %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
+				   file_offset, (u64)event->stat_config.nr, max_nr);
 			err = 0;
 			goto out;
 		}
@@ -2446,8 +2451,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		u64 nr_entries, max_entries;
 
 		if (event_size < sizeof(event->bpf_metadata)) {
-			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too small, skipping\n",
-				   event_size);
+			pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_BPF_METADATA: header.size (%u) too small, skipping\n",
+				   file_offset, event_size);
 			err = 0;
 			break;
 		}
@@ -2458,7 +2463,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 */
 		if (strnlen(event->bpf_metadata.prog_name,
 			    BPF_PROG_NAME_LEN) == BPF_PROG_NAME_LEN) {
-			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: prog_name not null-terminated, skipping\n");
+			pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_BPF_METADATA: prog_name not null-terminated, skipping\n",
+				   file_offset);
 			err = 0;
 			break;
 		}
@@ -2467,8 +2473,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		max_entries = (event_size - sizeof(event->bpf_metadata)) /
 			      sizeof(event->bpf_metadata.entries[0]);
 		if (nr_entries > max_entries) {
-			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 " exceeds max %" PRIu64 ", skipping\n",
-				   nr_entries, max_entries);
+			pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 " exceeds max %" PRIu64 ", skipping\n",
+				   file_offset, nr_entries, max_entries);
 			err = 0;
 			break;
 		}
@@ -2478,7 +2484,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 				    BPF_METADATA_KEY_LEN) == BPF_METADATA_KEY_LEN ||
 			    strnlen(event->bpf_metadata.entries[i].value,
 				    BPF_METADATA_VALUE_LEN) == BPF_METADATA_VALUE_LEN) {
-				pr_warning("WARNING: PERF_RECORD_BPF_METADATA: entry %" PRIu64 " key/value not null-terminated, skipping\n", i);
+				pr_warning("WARNING: at offset %#" PRIx64 ": PERF_RECORD_BPF_METADATA: entry %" PRIu64 " key/value not null-terminated, skipping\n",
+					   file_offset, i);
 				err = 0;
 				goto out;
 			}
@@ -2752,22 +2759,22 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	    event->header.type != PERF_RECORD_HEADER_TRACING_DATA &&
 	    event->header.type != PERF_RECORD_COMPRESSED &&
 	    event->header.type != PERF_RECORD_HEADER_FEATURE) {
-		pr_warning("WARNING: peek_event: event type %u size %u not aligned to %zu\n",
-			   event->header.type,
-			   event->header.size, sizeof(u64));
+		pr_warning("WARNING: at offset %#" PRIx64 ": %s (%u) event size %u not aligned to %zu\n",
+			   (u64)file_offset, perf_event__name(event->header.type),
+			   event->header.type, event->header.size, sizeof(u64));
 		return -1;
 	}
 
 	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
-		pr_warning("WARNING: peek_event: unsupported event type %u, skipping\n",
-			   event->header.type);
+		pr_warning("WARNING: at offset %#" PRIx64 ": unsupported event type %u, skipping\n",
+			   (u64)file_offset, event->header.type);
 		return 0;
 	}
 
 	if (perf_event__too_small(event, &min_sz)) {
-		pr_warning("WARNING: peek_event: %s event size %u too small (min %u)\n",
-			   perf_event__name(event->header.type),
-			   event->header.size, min_sz);
+		pr_warning("WARNING: at offset %#" PRIx64 ": %s (%u) event size %u too small (min %u)\n",
+			   (u64)file_offset, perf_event__name(event->header.type),
+			   event->header.type, event->header.size, min_sz);
 		return -1;
 	}
 
@@ -2883,9 +2890,9 @@ static s64 perf_session__process_event(struct perf_session *session,
 	    event->header.type != PERF_RECORD_HEADER_TRACING_DATA &&
 	    event->header.type != PERF_RECORD_COMPRESSED &&
 	    event->header.type != PERF_RECORD_HEADER_FEATURE) {
-		pr_err("ERROR: %s event size %u is not 8-byte aligned, aborting\n",
-		       perf_event__name(event->header.type),
-		       event->header.size);
+		pr_err("ERROR: at offset %#" PRIx64 ": %s (%u) event size %u is not 8-byte aligned, aborting\n",
+		       file_offset, perf_event__name(event->header.type),
+		       event->header.type, event->header.size);
 		return -EINVAL;
 	}
 
@@ -2905,16 +2912,17 @@ static s64 perf_session__process_event(struct perf_session *session,
 	 * can be safely stepped over without misaligning the stream.
 	 */
 	if (perf_event__too_small(event, &min_sz)) {
-		pr_warning("WARNING: %s event size %u too small (min %u), skipping\n",
-			   perf_event__name(event->header.type),
-			   event->header.size, min_sz);
+		pr_warning("WARNING: at offset %#" PRIx64 ": %s (%u) event size %u too small (min %u), skipping\n",
+			   file_offset, perf_event__name(event->header.type),
+			   event->header.type, event->header.size, min_sz);
 		return 0;
 	}
 
 	if (session->header.needs_swap &&
 	    event_swap(event, evlist__sample_id_all(evlist))) {
-		pr_warning("WARNING: swap failed for %s event, skipping\n",
-			   perf_event__name(event->header.type));
+		pr_warning("WARNING: at offset %#" PRIx64 ": swap failed for %s (%u) event, skipping\n",
+			   file_offset, perf_event__name(event->header.type),
+			   event->header.type);
 		return 0;
 	}
 
-- 
2.54.0

