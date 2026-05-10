Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1D270EDF;
	Sun, 10 May 2026 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384200; cv=none; b=R3yJm59JDRSdMxCPQw1T2rmLj6jcSOsIQH6unHwSmSwT+qjCfzCb4ihVZRCNfS3J0jU2YH5G5UdI9gdrKlhioQ7qso0D5lV7WmWc8xA/9rlXF0q9J1sEVR7M/x2MqErpzM3WWbwYkTLTJLlIYRGW1wJLzxNEP33fmRsRUdS0O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384200; c=relaxed/simple;
	bh=VcfiWO5Vp0JgEdvLsStB4zHN67Q0J7XbmZEFgWFlUPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llahEqFdsUBU2cE+2YR693CCRyh8RvWDXJIOcCzahJ3wx6bZBYVWnV1FuUCaV5mQDXZx1tSZvVJ7dM/Xiw/qLqG2O7IarvmTMGM6cz+R0hUFc/9zh8xU8GtMcbgqtJ4KvBT4gbuPfdqUtPxax/gMidBMOVRe/uoJzU31Ag/0D74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRn5G6JF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRn5G6JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C5C2BCF7;
	Sun, 10 May 2026 03:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384200;
	bh=VcfiWO5Vp0JgEdvLsStB4zHN67Q0J7XbmZEFgWFlUPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JRn5G6JF8jzmA2paiq/PXi0XMYpV92Hcv9sFU8BoNLiyWKghWXwcH/TFIR3I4ddoW
	 MBeMu1+c6rZXKX37E0tnxPcr80P/mR5m1DSwevS9bV++j/xU5Cdafu/vUAf+NBys/1
	 TWJZlPCXgVgc1E5rjZF3WFYTioWpUhZr8we7/gh0X2GJb4tjOTTxRSrsz1/B+8O9Tq
	 z5WFXVWIW2VPs9nKP3aqrifKmicKHUMD3Vyt+qcVq9Okbu6fkz8kegYYO7JwNS0Un3
	 yKo/jo7D5l8m+5HuCrZbiFQTZbqrqcvvXbgYhNzTnW+3EDE7P7lRyLTW9U5jq3qWII
	 EcL9TnN1UweFw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	Chun-Tse Shao <ctshao@google.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 22/28] perf session: Add byte-swap for PERF_RECORD_COMPRESSED2 events
Date: Sun, 10 May 2026 00:34:13 -0300
Message-ID: <20260510033424.255812-23-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

PERF_RECORD_COMPRESSED2 has a data_size field (__u64) at offset 8
that is not covered by the header byte-swap in prefetch_event().
When reading a cross-endian perf.data file, data_size was used
without swapping, causing either garbage decompression sizes or
silent data corruption.

PERF_RECORD_COMPRESSED (the original format) has no fields beyond
the header, so it doesn't need a swap op.

Add perf_event__compressed2_swap() and register it in
perf_event__swap_ops[].

Fixes: 208c0e168344 ("perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Chun-Tse Shao <ctshao@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 85591ccdc2e8ada3..80cb03d150cecc0b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1037,6 +1037,14 @@ static int perf_event__time_conv_swap(union perf_event *event,
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
@@ -1175,6 +1183,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_COMPRESSED2]	  = perf_event__compressed2_swap,
 	[PERF_RECORD_BPF_METADATA]	  = perf_event__bpf_metadata_swap,
 	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
-- 
2.54.0

