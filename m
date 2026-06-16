Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F56379C50;
	Tue, 16 Jun 2026 01:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573526; cv=none; b=AMnlGnnb0CS1R0pjP1Epdng9zTIfAoQ8PlweuCkF4MOiUmU5PVbdtemj3H337FtV+673OnNW0H1l8uMAjCWX4CtloplhCCqGkNLd/5/0/a0ngfKmW4Ebxsm/CDV05/SYFnaKEdI8zSfzJ35+BQcHGQI68j4H0NbZXJyKamV/wps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573526; c=relaxed/simple;
	bh=sbcHCIv0lRr5CImtuwWqkESk6j+lockmvDy0ju5e5bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kk9MU60Ki+rKmS2PVQ/z6wns/+fpWwZX2CP5hhNC8qHD3Sl5VWDZ3VFcs/s4jDiFrFeeSv18UHFXYpTVBKKiSIjWEZ/vAtmD9x6afcscnqMrwziirrP7utVIoIpI+kGwVwccQX49/W46flzpqiA4zxqzYDhno/0UrJha0l3x5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNcqKqb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNcqKqb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1835D1F000E9;
	Tue, 16 Jun 2026 01:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573524;
	bh=pWivSfthB93jpC4ChRa0JsQ/yems5fzFHTpHyHVjJa0=;
	h=From:To:Cc:Subject:Date;
	b=GNcqKqb3g9mx2pSmfGvC4Jis4hrzVp/+MP8ShtODU3koG8or9Cy0aQXogdUvWZV/X
	 w26ht7RHnf3IqyJKW/1XElG7vT2fRpHsgFA1ePLcg560hQfVD5kxYxHEMKVEFMzt4W
	 eOanb+gxmQem47e04vwBEGozuM7v3LXoxh2CoeufS7ifuy5PZ6N5xXc3dERZxUWS+b
	 fUQf7m7rgjIP7OVxDxQMK8WqqYXxWsDl+TI07OZAB3oU359pY/3SaOSzEeH8htNabQ
	 m0gLsnRIUf04OEdRWlO/ZTxoZTm6x9Djd2h17ZUnraQIrwEBXFHlzSRTvOQYcLaQZ+
	 Gj7a1MG4egD7w==
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
Subject: [PATCHES 0/2] perf tools: Add cached probe type detection for evsel
Date: Mon, 15 Jun 2026 22:31:55 -0300
Message-ID: <20260616013157.38960-1-acme@kernel.org>
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
and cache the result in a 2-bit field that fits in existing struct
padding.

Patch 2 is the first user: it guards the __probe_ip field name
comparison in perf trace with evsel__is_probe(), so the strcmp is
skipped entirely for the common case of non-probe tracepoint events.

Build-tested with gcc and clang.

Arnaldo Carvalho de Melo (2):
  perf evsel: Add lazy-initialized probe type detection helpers
  perf trace: Guard __probe_ip suppression with evsel__is_probe()

 tools/perf/builtin-trace.c |  2 +-
 tools/perf/util/evsel.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |  5 +++++
 3 files changed, 50 insertions(+), 1 deletion(-)

Developed with AI assistance (Claude), tagged in commits.

Thanks,

- Arnaldo
