Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857953D8105;
	Tue, 16 Jun 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634353; cv=none; b=fCCKhIpJD02ot39hS3gCxu1s5nU3JMrBb8eXLE/N/0FUiVa7cO3HxY+JCQeHhrttV/Ignv7PHx3ZkhKe+NsdMVTpQvHpEyrnpMSGlUdCai9AGHNCvUgrFlnOThyMhfHy5i+uOaEqSgyPw4Bw9vJ8O1+1mqbah1YUu94jX5oa54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634353; c=relaxed/simple;
	bh=qcOwg5lAWDCEwRfHqTzcOfmVBbaxqQ7w+hOQ/VdHnJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NdjxFPm0r9UJ1o6frE0dr2B7BtNwd79WqY1nNG5b6tTv8HuybJImDtw6uJhVMASRqXcn7djZvecAtpegjFlFZ4O7+VthgzyAgYA1SSRORZ2IHYNpC2aDAVuQqQgD+2JOGUJX3GP+UCJLAeo2htvh9hfAY40VH52m9y0E5Y3fo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQXU9OWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQXU9OWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9326F1F000E9;
	Tue, 16 Jun 2026 18:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781634352;
	bh=IcJniV6lhax4c/5j/JObc9Pl2YLIqDMvOznt2sbk8bE=;
	h=From:To:Cc:Subject:Date;
	b=RQXU9OWqvScMtrPZ49ajQPov6fOMZwhJtO9Zjj/xn7kQePvxK3nWcbMi9dMxGkm3E
	 rttGdTi79CVN7brdOMYXGqMrrUrIODLy7w1NlfIMmA6TJHWjfQQZGhjLOiU/ZzBvPr
	 VQyMAN+7QgvWEZJsjMXWwi3R3UMrZiIc7rXbZLbgVk3H2nFIwXfNEy+jJOaSpXib18
	 HrhWe14UhxjjCBcWawiWWFcJE96bzN4HS5O8hzkVGwuVBciCgk3wBrB5uCregHUvL8
	 eKkEDfybfiSGExztVDuvHDN9V5/QuoYlDF120FARFy+MlcP/9JQjIBMsTFzEba/5ly
	 kJ4ubBR1BOfOw==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: [PATCHES v3 0/2] perf tools: Add cached probe type detection for evsel
Date: Tue, 16 Jun 2026 15:25:44 -0300
Message-ID: <20260616182546.8892-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Checking whether an evsel is a kprobe or uprobe currently requires
walking the PMU list via evsel__find_pmu() on every call.  This is
wasteful when the same evsel is checked repeatedly in hot paths like
trace__fprintf_tp_fields().

Patch 1 adds evsel__is_kprobe(), evsel__is_uprobe(), and
evsel__is_probe() helpers that resolve the probe type on first call
and cache the result in a 3-bit field that fits in existing struct
padding.

Detection covers both PMU-based probes (kprobe/uprobe PMU, detected
by PMU name) and ftrace-based dynamic probes (kprobes/uprobes/fprobes
created via tracefs, which report as PMU "tracepoint").  Ftrace probes
are detected by the __probe_ip field that the kernel adds to all
dynamic probe formats — this is authoritative regardless of the
group/system name the user chose.

Patch 2 is the first user: it guards the __probe_ip field name
comparison in perf trace with evsel__is_probe(), so the strcmp is
skipped entirely for the common case of non-probe tracepoint events.

Patch 3 adds inline stubs for evsel__field() and evsel__common_field()
when libtraceevent is absent.  These were previously declared
unconditionally but defined only inside #ifdef HAVE_LIBTRACEEVENT,
which was harmless until patch 1 added a call from always-compiled
code in evsel.c.

Build-tested with gcc and clang.

Changes in v3:
  - Add patch 3: no-libtraceevent stubs for evsel__field() and
    evsel__common_field().  Without this, NO_LIBTRACEEVENT=1 builds
    fail to link because evsel__resolve_probe_type() calls
    evsel__field() unconditionally (sashiko-bot).

Changes in v2 (patch 1 only):
  - Detect ftrace-based dynamic probes (kprobes/uprobes/fprobes created
    via tracefs) that report PMU "tracepoint" instead of "kprobe"/
    "uprobe".  Check for the __probe_ip field presence in the tracepoint
    format.  Without this, evsel__is_probe() returned false for ftrace
    probes, breaking __probe_ip suppression in perf trace for probes
    created via 'perf probe' (sashiko-bot).
  - Widen probe_type bitfield from 2 to 3 bits for PROBE__FTRACE.

Arnaldo Carvalho de Melo (3):
  perf evsel: Add lazy-initialized probe type detection helpers
  perf trace: Guard __probe_ip suppression with evsel__is_probe()
  perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()

 tools/perf/builtin-trace.c |  2 +-
 tools/perf/util/evsel.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    | 19 +++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>

Developed with AI assistance (Claude/sashiko), tagged in commits.
