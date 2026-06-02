Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9F282F1B;
	Tue,  2 Jun 2026 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444646; cv=none; b=lXxj8roahreMzisPT+gxO0UF7Jwps2kOnkpDqLxKu8bU9IqppBgu5fwwHLZf8DMAMsEMn2inAM75O+K3WkseadFZz8+iVgklkvV0Esxp6zMZrxQ/LGA7cKb8lmGKotJZ9y+4R7g4MyUrnYwwngt47/RWsiwrxdwjIP8OUy95dtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444646; c=relaxed/simple;
	bh=jXidNDA8LRO9dK6i/qGjx0uk2g///hUp3PxSO1/BqN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSkS+njLz1B5PoqxhdkblEWmgvtwsATqlHK2IhE/F9aj04W5yjLTHVuTiQv8Mj+hNw633WAORCeqiTXbwwJohaf/WgOw1t/9r+2/r1lt77qgSVdQZKMHvWwd8+16ZvANN8othSI42Rj380jRnmeJYeRCL1ZA9RAlJJ8py12A4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxVx1PAh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxVx1PAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B2A1F00898;
	Tue,  2 Jun 2026 23:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444645;
	bh=lOcDbCc7Iramj69iqATBMmpIIl4u6Ltd0M2lP0mgQmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxVx1PAhzaKToyX9kKJBxRA1pYefvzc99i3SxzwT6SN/ONPu+VGd0CwqHkWCWHlV8
	 SZOuX0G6F+LBV5+FDGuBR8Teb9/uC//mhIQF/kD/iAKgmUp45CCXPj4pjScHmS8ayV
	 Jh5w70OvPpg2l5AkeUExgz84VcWARKKQ8wZIpJthlX5L++3YLRqHM4B9zV04MvbY8I
	 K5me/TlZPuqCoY19NMbGJbB1ShcgAawxtTwX1YRNJI5iKinTggkxlgi41E+gNH7Kav
	 l+aioWRS71XWhx6bIjpYsj0sIxI7AEasH5eKTDWWn1QnlFX2O45vXiV4EqzPc+A28z
	 rMDStUoKaz7FQ==
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
Subject: [PATCH 1/8] perf sample: Add file_offset field to struct perf_sample
Date: Tue,  2 Jun 2026 20:57:00 -0300
Message-ID: <20260602235709.1541603-2-acme@kernel.org>
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

Add a file_offset field to struct perf_sample so that event processing
callbacks can report the byte offset of the problematic event in
perf.data, letting users cross-reference with 'perf report -D' output.

Set sample.file_offset in perf_session__deliver_event(), which is the
common entry point for both file mode (mmap'd offset) and pipe mode
(running byte counter from __perf_session__process_pipe_events).

The assignment is placed after evsel__parse_sample(), which zeroes
the struct via memset.

Preserve file_offset through the deferred callchain delivery path by
storing it in struct deferred_event and restoring it after
evlist__parse_sample() in both evlist__deliver_deferred_callchain()
and session__flush_deferred_samples().

Subsequent patches will use this field in skip/stop warning messages.

Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sample.h  | 2 ++
 tools/perf/util/session.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index e556c9b656ea9cd6..c4eae8b2fd06035a 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -158,6 +158,8 @@ struct perf_sample {
 	u64 code_page_size;
 	/** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
 	u64 cgroup;
+	/** @file_offset: Byte offset of this event in the perf.data file. */
+	u64 file_offset;
 	/** @flags: Extra flag data from auxiliary events like intel-pt. */
 	u32 flags;
 	/** @machine_pid: The guest machine pid derived from the sample id. */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e2e821b77766dbfc..7996787d742e32c6 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1824,6 +1824,7 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 struct deferred_event {
 	struct list_head list;
 	union perf_event *event;
+	u64 file_offset;
 };
 
 /*
@@ -1858,6 +1859,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 			perf_sample__exit(&orig_sample);
 			break;
 		}
+		orig_sample.file_offset = de->file_offset;
 
 		if (sample->tid != orig_sample.tid) {
 			perf_sample__exit(&orig_sample);
@@ -1906,6 +1908,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
 			perf_sample__exit(&sample);
 			break;
 		}
+		sample.file_offset = de->file_offset;
 
 		sample.evsel = evlist__id2evsel(evlist, sample.id);
 		ret = evlist__deliver_sample(evlist, tool, de->event,
@@ -1984,6 +1987,7 @@ static int machines__deliver_event(struct machines *machines,
 				return -ENOMEM;
 			}
 			memcpy(de->event, event, sz);
+			de->file_offset = sample->file_offset;
 			list_add_tail(&de->list, &evlist->deferred_samples);
 			return 0;
 		}
@@ -2126,6 +2130,7 @@ static int perf_session__deliver_event(struct perf_session *session,
 		pr_err("Can't parse sample, err = %d\n", ret);
 		goto out;
 	}
+	sample.file_offset = file_offset;
 	/*
 	 * evsel__parse_sample() doesn't populate machine_pid/vcpu,
 	 * which are needed by machines__find_for_cpumode() to
-- 
2.54.0

