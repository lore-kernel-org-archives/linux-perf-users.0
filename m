Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA530E835;
	Thu, 21 May 2026 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325900; cv=none; b=dIAc2ADh7LQwoQumkMrT6RYzMbiWAsi9EEHlmbKpeP9PmTxWL7FoIFvLNFwTNk9ZRp0yWr+svp5s54yYHHBz9O2gq7RMnYOKCC+jz4Yr5Ub5ATBkxpKx2LfE8+Xf0fvXwvWw/e2uFlj95+Qsd2kimtsQbEVfG2NXSMkes8QMJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325900; c=relaxed/simple;
	bh=WRosXuZkQDmYT8rjDXE5FylHHwOQJjryxO18sN26qGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aId1d9D8uibXlc/bZNJBzpFT++kJ10oAuAc7r2/ph2mE16jA1UQG08QcgWpxTOQmlO5fozk/sr34uM0LkqzpUfiaHX+3uScjZKLNByTxUWFmaCbuh7RFmddiDRA7EyBDo08gP//R9kOAYMi8ai1hGGiFwT6UTY6qNJcKNWct+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/PgNVIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/PgNVIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FCD1F00A3B;
	Thu, 21 May 2026 01:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325899;
	bh=I0dIR4DnWQ86OB3fVrj++Z8yjNAKmzRMqhWPPx4sOKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M/PgNVIukyolyPjpX3PmWM+EboMJ81djgkkVb4LC0LaFSwoB18i5KtdbS+FMbiMoI
	 zfsCzR9P4PYGu6zpbt6OCQlXRO0U9byZYOMV7dpJzHpcA+2SIeLS3HOao7MuuYP295
	 N3bDJ+p1xkOAsRLJNXj9CDJdjkji7FPLZJjX9IoGxRq3YAdxNWKTSQOFEiXfZHdnlh
	 0KBGFVFuAZQRWGvIHI7rAAeyn3zM6FcVB16+urWl4AX11GcTt1t3+RU/rpYEpq+grO
	 bpcyIcGArw2AJo6PTTEljUeSblWiFDfZD8XabtK/VkLnGW9AZ3BK+dhmETEPzPiwqP
	 /CG04ub3xYL2g==
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
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 15/27] perf header: Validate null-termination in PERF_RECORD_EVENT_UPDATE string fields
Date: Wed, 20 May 2026 22:10:00 -0300
Message-ID: <20260521011027.622268-16-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

strdup(ev->unit) and strdup(ev->name) read until '\0' with no
guarantee the string is null-terminated within event->header.size.
The dump_trace fprintf path has the same problem with %s.

Validate before either path runs — same class of bug fixed for
MMAP/MMAP2/COMM/CGROUP by perf_event__check_nul().

Also harden the event_update swap handler to:
- Validate SCALE event size before swapping the double at
  offset 24, which exceeds the 24-byte min_size.
- Validate CPUS event size before accessing the cpu_map
  type/nr/long_size fields, which also start at the min_size
  boundary.
- Swap CPUS variant fields (type, nr, long_size) so the
  processing path sees native byte order.

Add validation in perf_event__process_event_update() for all
event update variants (UNIT, NAME, SCALE, CPUS) before
dump_trace or processing.

Validate CPUS nr against payload size for both PERF_CPU_MAP__CPUS
and PERF_CPU_MAP__MASK types on the fprintf (dump_trace) path:
- CPUS: check nr does not exceed available cpu entries
- MASK: check nr does not exceed available mask entries for
  both mask32 (long_size == 4) and mask64 (long_size == 8)
  layouts, with underflow guards on the offsetof subtraction

Fix a missing break before the default case in the CPUS
switch path.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c  | 149 ++++++++++++++++++++++++++++++++++++--
 tools/perf/util/session.c |  99 ++++++++++++++++++++++++-
 2 files changed, 241 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c0b5c99f462ad925..a5acdcb1a4c02fca 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -5117,15 +5117,76 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 
 	switch (ev->type) {
 	case PERF_EVENT_UPDATE__SCALE:
+		if (event->header.size < offsetof(struct perf_record_event_update, scale) +
+					 sizeof(ev->scale)) {
+			ret += fprintf(fp, "... scale: (truncated)\n");
+			break;
+		}
 		ret += fprintf(fp, "... scale: %f\n", ev->scale.scale);
 		break;
 	case PERF_EVENT_UPDATE__UNIT:
-		ret += fprintf(fp, "... unit:  %s\n", ev->unit);
-		break;
-	case PERF_EVENT_UPDATE__NAME:
-		ret += fprintf(fp, "... name:  %s\n", ev->name);
+	case PERF_EVENT_UPDATE__NAME: {
+		size_t str_off = offsetof(struct perf_record_event_update, unit);
+		size_t max_len = event->header.size > str_off ?
+				 event->header.size - str_off : 0;
+
+		if (max_len == 0 || strnlen(ev->unit, max_len) == max_len) {
+			ret += fprintf(fp, "... %s: (unterminated)\n",
+				       ev->type == PERF_EVENT_UPDATE__UNIT ? "unit" : "name");
+			break;
+		}
+		ret += fprintf(fp, "... %s:  %s\n",
+			       ev->type == PERF_EVENT_UPDATE__UNIT ? "unit" : "name",
+			       ev->unit);
 		break;
-	case PERF_EVENT_UPDATE__CPUS:
+	}
+	case PERF_EVENT_UPDATE__CPUS: {
+		size_t cpus_off = offsetof(struct perf_record_event_update, cpus);
+		u32 cpus_payload;
+
+		if (event->header.size < cpus_off + sizeof(__u16) +
+					 sizeof(struct perf_record_range_cpu_map)) {
+			ret += fprintf(fp, "... cpus: (truncated)\n");
+			break;
+		}
+
+		/*
+		 * Validate nr against payload — this function may be
+		 * called from the stub handler (dump_trace path) which
+		 * bypasses perf_event__process_event_update() validation.
+		 */
+		cpus_payload = event->header.size - cpus_off;
+		if (ev->cpus.cpus.type == PERF_CPU_MAP__CPUS) {
+			if (cpus_payload < offsetof(struct perf_record_cpu_map_data, cpus_data.cpu) ||
+			    ev->cpus.cpus.cpus_data.nr >
+			    (cpus_payload - offsetof(struct perf_record_cpu_map_data, cpus_data.cpu)) /
+			    sizeof(ev->cpus.cpus.cpus_data.cpu[0])) {
+				ret += fprintf(fp, "... cpus: nr %u exceeds payload\n",
+					       ev->cpus.cpus.cpus_data.nr);
+				break;
+			}
+		} else if (ev->cpus.cpus.type == PERF_CPU_MAP__MASK) {
+			if (ev->cpus.cpus.mask32_data.long_size == 4) {
+				if (cpus_payload < offsetof(struct perf_record_cpu_map_data, mask32_data.mask) ||
+				    ev->cpus.cpus.mask32_data.nr >
+				    (cpus_payload - offsetof(struct perf_record_cpu_map_data, mask32_data.mask)) /
+				    sizeof(ev->cpus.cpus.mask32_data.mask[0])) {
+					ret += fprintf(fp, "... cpus: mask nr %u exceeds payload\n",
+						       ev->cpus.cpus.mask32_data.nr);
+					break;
+				}
+			} else if (ev->cpus.cpus.mask64_data.long_size == 8) {
+				if (cpus_payload < offsetof(struct perf_record_cpu_map_data, mask64_data.mask) ||
+				    ev->cpus.cpus.mask64_data.nr >
+				    (cpus_payload - offsetof(struct perf_record_cpu_map_data, mask64_data.mask)) /
+				    sizeof(ev->cpus.cpus.mask64_data.mask[0])) {
+					ret += fprintf(fp, "... cpus: mask nr %u exceeds payload\n",
+						       ev->cpus.cpus.mask64_data.nr);
+					break;
+				}
+			}
+		}
+
 		ret += fprintf(fp, "... ");
 
 		map = cpu_map__new_data(&ev->cpus.cpus);
@@ -5135,6 +5196,7 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 		} else
 			ret += fprintf(fp, "failed to get cpus\n");
 		break;
+	}
 	default:
 		ret += fprintf(fp, "... unknown type\n");
 		break;
@@ -5269,6 +5331,82 @@ int perf_event__process_event_update(const struct perf_tool *tool __maybe_unused
 	struct evsel *evsel;
 	struct perf_cpu_map *map;
 
+	/*
+	 * Validate payload before dump_trace or processing — both
+	 * paths access variant-specific fields without further checks.
+	 */
+	if (ev->type == PERF_EVENT_UPDATE__UNIT ||
+	    ev->type == PERF_EVENT_UPDATE__NAME) {
+		size_t str_off = offsetof(struct perf_record_event_update, unit);
+		size_t max_len = event->header.size - str_off;
+
+		if (max_len == 0 || strnlen(ev->unit, max_len) == max_len) {
+			pr_warning("WARNING: PERF_RECORD_EVENT_UPDATE: %s not null-terminated, skipping\n",
+				   ev->type == PERF_EVENT_UPDATE__UNIT ? "unit" : "name");
+			return 0;
+		}
+	} else if (ev->type == PERF_EVENT_UPDATE__SCALE) {
+		if (event->header.size < offsetof(struct perf_record_event_update, scale) +
+					 sizeof(ev->scale)) {
+			pr_warning("WARNING: PERF_RECORD_EVENT_UPDATE: SCALE payload too small, skipping\n");
+			return 0;
+		}
+	} else if (ev->type == PERF_EVENT_UPDATE__CPUS) {
+		size_t cpus_off = offsetof(struct perf_record_event_update, cpus);
+		size_t min_cpus = sizeof(__u16) +
+				  sizeof(struct perf_record_range_cpu_map);
+		u32 cpus_payload;
+
+		if (event->header.size < cpus_off + min_cpus) {
+			pr_warning("WARNING: PERF_RECORD_EVENT_UPDATE: CPUS payload too small, skipping\n");
+			return 0;
+		}
+
+		/*
+		 * Validate per-variant nr against the remaining
+		 * payload on the native path — the swap path clamps
+		 * nr in perf_event__event_update_swap(), but native
+		 * events are read-only and cannot be clamped in place.
+		 * cpu_map__new_data() trusts nr for allocation and
+		 * iteration, so unchecked values cause OOB reads.
+		 */
+		cpus_payload = event->header.size - cpus_off;
+		switch (ev->cpus.cpus.type) {
+		case PERF_CPU_MAP__CPUS:
+			if (ev->cpus.cpus.cpus_data.nr >
+			    (cpus_payload - offsetof(struct perf_record_cpu_map_data, cpus_data.cpu)) /
+			    sizeof(ev->cpus.cpus.cpus_data.cpu[0])) {
+				pr_warning("WARNING: EVENT_UPDATE CPUS: nr %u exceeds payload, skipping\n",
+					   ev->cpus.cpus.cpus_data.nr);
+				return 0;
+			}
+			break;
+		case PERF_CPU_MAP__MASK:
+			if (ev->cpus.cpus.mask32_data.long_size == 4) {
+				if (cpus_payload < offsetof(struct perf_record_cpu_map_data, mask32_data.mask) ||
+				    ev->cpus.cpus.mask32_data.nr >
+				    (cpus_payload - offsetof(struct perf_record_cpu_map_data, mask32_data.mask)) /
+				    sizeof(ev->cpus.cpus.mask32_data.mask[0])) {
+					pr_warning("WARNING: EVENT_UPDATE MASK: nr %u exceeds payload, skipping\n",
+						   ev->cpus.cpus.mask32_data.nr);
+					return 0;
+				}
+			} else if (ev->cpus.cpus.mask64_data.long_size == 8) {
+				if (cpus_payload < offsetof(struct perf_record_cpu_map_data, mask64_data.mask) ||
+				    ev->cpus.cpus.mask64_data.nr >
+				    (cpus_payload - offsetof(struct perf_record_cpu_map_data, mask64_data.mask)) /
+				    sizeof(ev->cpus.cpus.mask64_data.mask[0])) {
+					pr_warning("WARNING: EVENT_UPDATE MASK: nr %u exceeds payload, skipping\n",
+						   ev->cpus.cpus.mask64_data.nr);
+					return 0;
+				}
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (dump_trace)
 		perf_event__fprintf_event_update(event, stdout);
 
@@ -5300,6 +5438,7 @@ int perf_event__process_event_update(const struct perf_tool *tool __maybe_unused
 			evsel->core.pmu_cpus = map;
 		} else
 			pr_err("failed to get event_update cpus\n");
+		break;
 	default:
 		break;
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 928775f727c497cf..5c679264362d262e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -680,8 +680,103 @@ static int perf_event__build_id_swap(union perf_event *event,
 static int perf_event__event_update_swap(union perf_event *event,
 					 bool sample_id_all __maybe_unused)
 {
-	event->event_update.type = bswap_64(event->event_update.type);
-	event->event_update.id   = bswap_64(event->event_update.id);
+	struct perf_record_event_update *ev = &event->event_update;
+
+	ev->type = bswap_64(ev->type);
+	ev->id   = bswap_64(ev->id);
+
+	/*
+	 * Swap variant-specific fields so the processing path
+	 * sees native byte order.
+	 */
+	if (ev->type == PERF_EVENT_UPDATE__SCALE) {
+		if (event->header.size < offsetof(struct perf_record_event_update, scale) +
+					 sizeof(ev->scale))
+			return -1;
+		mem_bswap_64(&ev->scale.scale, sizeof(ev->scale.scale));
+	} else if (ev->type == PERF_EVENT_UPDATE__CPUS) {
+		u32 cpus_payload;
+		struct perf_record_cpu_map_data *data = &ev->cpus.cpus;
+
+		/* CPUS fields start at the same offset as scale (union) */
+		if (event->header.size < offsetof(struct perf_record_event_update, cpus) +
+					 sizeof(__u16) + sizeof(struct perf_record_range_cpu_map))
+			return -1;
+		cpus_payload = event->header.size - offsetof(struct perf_record_event_update, cpus);
+		data->type = bswap_16(data->type);
+		/*
+		 * Full swap including array elements — same logic as
+		 * perf_event__cpu_map_swap() but scoped to the
+		 * embedded cpu_map_data within EVENT_UPDATE.
+		 */
+		switch (data->type) {
+		case PERF_CPU_MAP__CPUS: {
+			u16 nr, max_nr;
+
+			data->cpus_data.nr = bswap_16(data->cpus_data.nr);
+			nr = data->cpus_data.nr;
+			max_nr = (cpus_payload - offsetof(struct perf_record_cpu_map_data,
+							  cpus_data.cpu)) /
+				 sizeof(data->cpus_data.cpu[0]);
+			if (nr > max_nr) {
+				nr = max_nr;
+				data->cpus_data.nr = nr;
+			}
+			for (unsigned int i = 0; i < nr; i++)
+				data->cpus_data.cpu[i] = bswap_16(data->cpus_data.cpu[i]);
+			break;
+		}
+		case PERF_CPU_MAP__MASK:
+			data->mask32_data.long_size = bswap_16(data->mask32_data.long_size);
+			switch (data->mask32_data.long_size) {
+			case 4: {
+				u16 nr, max_nr;
+
+				data->mask32_data.nr = bswap_16(data->mask32_data.nr);
+				nr = data->mask32_data.nr;
+				max_nr = (cpus_payload - offsetof(struct perf_record_cpu_map_data,
+								  mask32_data.mask)) /
+					 sizeof(data->mask32_data.mask[0]);
+				if (nr > max_nr) {
+					nr = max_nr;
+					data->mask32_data.nr = nr;
+				}
+				for (unsigned int i = 0; i < nr; i++)
+					data->mask32_data.mask[i] = bswap_32(data->mask32_data.mask[i]);
+				break;
+			}
+			case 8: {
+				u16 nr, max_nr;
+
+				data->mask64_data.nr = bswap_16(data->mask64_data.nr);
+				nr = data->mask64_data.nr;
+				if (cpus_payload < offsetof(struct perf_record_cpu_map_data, mask64_data.mask)) {
+					data->mask64_data.nr = 0;
+					break;
+				}
+				max_nr = (cpus_payload - offsetof(struct perf_record_cpu_map_data,
+								  mask64_data.mask)) /
+					 sizeof(data->mask64_data.mask[0]);
+				if (nr > max_nr) {
+					nr = max_nr;
+					data->mask64_data.nr = nr;
+				}
+				for (unsigned int i = 0; i < nr; i++)
+					data->mask64_data.mask[i] = bswap_64(data->mask64_data.mask[i]);
+				break;
+			}
+			default:
+				break;
+			}
+			break;
+		case PERF_CPU_MAP__RANGE_CPUS:
+			data->range_cpu_data.start_cpu = bswap_16(data->range_cpu_data.start_cpu);
+			data->range_cpu_data.end_cpu = bswap_16(data->range_cpu_data.end_cpu);
+			break;
+		default:
+			break;
+		}
+	}
 	return 0;
 }
 
-- 
2.54.0

