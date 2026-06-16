Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334C44DB64;
	Tue, 16 Jun 2026 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624695; cv=none; b=qAqhma0U2bm820m3I6EsOoTKvJLt0n2cltgmKWQ+cgmdekTrQOhaz7YYV/meHR8bvd/f003JKjRZ4lwg7F+XNVk6/Gkll297EDW3OTCWaFTBH6GZxLGsAObj8R8pPjiAuRw/XNwAJ2bv+bsid48vMjXPYie4B8t3RLwSD4z1x7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624695; c=relaxed/simple;
	bh=32rz68k4g9ImjkdVGzMKEmNKGdT1iRycgbFiFHTItCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9Qx4MYZTB4l2TGkvQI87eN7cpMhC/cUyPWQ9FBV/DHtOHjxmJ4/4MY2b18NFPKlb1jgJGFZgH9QP46PEwOI/JHV5DvdYL67iYtHBR8bjfHdNI4KR0oxtilixgdKi0GOcA/YX+q/YQ/HgGMDtDSVeSNY7M28E8NBAyx2bs6IcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS4c3lP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS4c3lP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764751F00A3F;
	Tue, 16 Jun 2026 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781624692;
	bh=4sAz4b2UiAlm8HGx4vFXgx9y7DtRhF52e/TjSLYHLig=;
	h=From:To:Cc:Subject:Date;
	b=iS4c3lP0nQlAf4JoegfooDiOLtgh598GsBe+VIMGSIQfTu8BgMSkwdZzGHfJwvqRr
	 mRHdus8LyWB/8nq+nfn7sB6TOaTBb6KAnah2YeJHgFW6BfQeQ8octm615hH5wFXXIF
	 rJVoKq8s4RFpxqnYWz/fyuuxcklpAIr6Tjlhc81jzANmQtMjjrgrL0AoO9PiDXpQ7b
	 4Sbyq02yOFCdrTn8lsg5M3/nl6rxaUzNRnuyntXjoYE8Rfhijj/1EWLg0z7avynIvf
	 RVCYprLk7JlcX4QDDC36wcOFT5ckubUMfbQREk7DDLAp5sWK+hxUT227+0VJ9yp6Pb
	 I551Y3GNM5z5g==
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
Subject: [PATCHES v2 0/2] perf tools: Add cached probe type detection for evsel
Date: Tue, 16 Jun 2026 12:44:44 -0300
Message-ID: <20260616154446.7206-1-acme@kernel.org>
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

Build-tested with gcc and clang.

Changes in v2 (patch 1 only):
  - Detect ftrace-based dynamic probes (kprobes/uprobes/fprobes created
    via tracefs) that report PMU "tracepoint" instead of "kprobe"/
    "uprobe".  Check for the __probe_ip field presence in the tracepoint
    format.  Without this, evsel__is_probe() returned false for ftrace
    probes, breaking __probe_ip suppression in perf trace for probes
    created via 'perf probe' (sashiko-bot).
  - Widen probe_type bitfield from 2 to 3 bits for PROBE__FTRACE.

Arnaldo Carvalho de Melo (2):
  perf evsel: Add lazy-initialized probe type detection helpers
  perf trace: Guard __probe_ip suppression with evsel__is_probe()

 tools/perf/builtin-trace.c |  2 +-
 tools/perf/util/evsel.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |  5 +++++
 3 files changed, 59 insertions(+), 1 deletion(-)

Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
