Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2F42FE066;
	Thu, 21 May 2026 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325926; cv=none; b=dc57Ona6+edRTSvuM5z5GI6pgLmN5MiqawqzZhEoRHXTrDHNsQmNkcnLu4FG2Hc1cLmaYdIeO4aNUHDxiwFBk9174FeoNsqbQjGGUql/Wd8JSJcSC9JGC3/yIvIMdfYSdKJxZsIK4cf+4IN6Gi70hziZ6g5XBl3hvF0pS/TyO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325926; c=relaxed/simple;
	bh=Yqg/IBE2CcGpNJPPDJ4kC7uzHfAqzlRL6k9ckhkcn+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBVBNfj9zwy8BGvqsdh1BDtF4w8rGXmJQD1jUUOTp94VaI75SSZ+WFhLjKyn7zQVgSDuj/AQ9mQDGHGChDRc6/azCMIDCNF9M3V2tZJEhzhTnZCDbg44L7U2UwDjSHNcYdXVYr7RlEHTo29+UZV0k3KGXnUn9FH3+VHj1IPaILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beUD0xfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beUD0xfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF9D1F000E9;
	Thu, 21 May 2026 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325925;
	bh=dJprlDZCEIfvTVcYWDyyLMwv3FMI4RqyQGUtKkqsT2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=beUD0xfrIImVa3MTthubR1dfB+XlqdS2ljs7I6plVtMuXHwYE/IOClWU+MQKA4/U/
	 BF664bYp13yBd0+r8a4LDgt6w62tcazXkbPpmPknFoBNCMkjK/GoajR6H/qbqthovw
	 WhGjl5H3eT0l2V1bpqVQ8IgE+cTXrcwalwjiTfMZ2QRx18JFqH11Ddv8kl4WEOFN0o
	 4jJ+6EbuEP2TjZ3CsVZGjtE/FDkdSoRk4cqPshKQN7I7YyoW0CI+/KpZoNWMI8rDlG
	 AqCoNhQFGG5xViodfybLo5FI6xeDdb8XF2UHDO5RzxEylcZeeQ7h7/5FZB1Bw+Q3KM
	 DqIjxePNozeQQ==
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
Subject: [PATCH 22/27] perf session: Add byte-swap for PERF_RECORD_COMPRESSED2 events
Date: Wed, 20 May 2026 22:10:07 -0300
Message-ID: <20260521011027.622268-23-acme@kernel.org>
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
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5c679264362d262e..7e25f75de37abce4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1028,6 +1028,14 @@ static int perf_event__time_conv_swap(union perf_event *event,
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
@@ -1166,6 +1174,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_COMPRESSED2]	  = perf_event__compressed2_swap,
 	[PERF_RECORD_BPF_METADATA]	  = perf_event__bpf_metadata_swap,
 	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
-- 
2.54.0

