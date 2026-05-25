Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59825265629;
	Mon, 25 May 2026 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671249; cv=none; b=V4T4M/vXcAtiBltaI2UEP165RsidpeajfmrjBG2rEZaIr41zPcdDOCyHR4NvEkfKGIoqBWaPvKuuiVsQoY5s9eRe221XZA9Q81ApV5CDwzcwlORxH0IllZuHCrr4INWk6U1Tq1NuP8Tm1onR6Ufz7C7lhBZ8kdGegqnxLquXEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671249; c=relaxed/simple;
	bh=WKoFQjJDe0IHzs+e/rLQ4u/bvS6zSfWdfUsgGZRTjfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHrBTTznzj+5iTfcGxEBFKfwAfv9e2+yIu6sRTNPOeCjL13U0t9t7cNO8FFTXKsKP2Pf3CJUOtGoDHFc7gCdYy1E8KyvHu5ULXRYrICN+yE1K1wfLTXy/WZx/0RpUQGphuKqespmnyvzLrL4bzI7cexnTkalSZykCzp8fVpMJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiiBkf+d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiiBkf+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EAD1F000E9;
	Mon, 25 May 2026 01:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671248;
	bh=P5azfTMXGrs1XaBtFDBxFOfqbcoD+gR0GYYpU+KoUJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hiiBkf+dAdIKQfxJEuqfJarluI6E5MI7GySC4Wa4mKga4wjKs8j9ojS8fUFK7F9Gz
	 5ny0Xvy5m4Y7KdvDYE1uf5pfFD3mtx3YSoMQSsJ/2rFohSYF8EzAK1XT2E8zwyGeDI
	 3KmQpfcda0znnYOXX+qXbnvWYj9vUYZFbkfMvW5QqBu5ysZx/rxBLOAZw6OsBMmvu7
	 CCHF/kmIrUeT1P7IC410AIPrFEHc0+5mRGuHn5E6rBIn4GyCrehDbFXr+nrNjk9Wy7
	 tc1kdK3fX+iWBF2NZQIal8FX55j4lHa814YD84gwjs4zD3zWp0z6xu1vA0DRpbXBqS
	 7GtZXSmcqUlLg==
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
	Chun-Tse Shao <ctshao@google.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 23/29] perf session: Add byte-swap handler for PERF_RECORD_COMPRESSED2
Date: Sun, 24 May 2026 22:05:43 -0300
Message-ID: <20260525010550.1100375-24-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525010550.1100375-1-acme@kernel.org>
References: <20260525010550.1100375-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

PERF_RECORD_COMPRESSED2 events carry a data_size field that must be
byte-swapped when reading cross-endian perf.data files.  Without a
swap handler, reading COMPRESSED2 events on a different-endian machine
would misinterpret data_size as a garbage value, causing the
decompression path to read the wrong number of bytes.

The compressed payload itself is a raw byte stream and needs no
swapping.

Fixes: 208c0e16834472bb ("perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8280413f4528f53c..9271885e3920f897 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1056,6 +1056,14 @@ static int perf_event__time_conv_swap(union perf_event *event,
 	return 0;
 }
 
+static int perf_event__compressed2_swap(union perf_event *event,
+					bool sample_id_all __maybe_unused)
+{
+	/* Only data_size needs swapping — compressed payload is a raw byte stream */
+	event->pack2.data_size = bswap_64(event->pack2.data_size);
+	return 0;
+}
+
 static int perf_event__bpf_metadata_swap(union perf_event *event,
 					 bool sample_id_all __maybe_unused)
 {
@@ -1197,6 +1205,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_COMPRESSED2]	  = perf_event__compressed2_swap,
 	[PERF_RECORD_BPF_METADATA]	  = perf_event__bpf_metadata_swap,
 	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
-- 
2.54.0

