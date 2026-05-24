Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0052C21F2;
	Sun, 24 May 2026 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593381; cv=none; b=ssnL9kYqtF2uDH5gk1rReL4+OkvbHGrY7ykJ+cHQIda0dWvVx4pulu3vjIgrWBR2R5Md4Km9AhOa3zhBlqqfqcHZcJb3x5WKldgs3WNcCBobUQRM52wbIt9o7K8todmf/4PT6/dLQPdacDACH+54Sf7lx/Wo7pvBfttJRxqmY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593381; c=relaxed/simple;
	bh=tII2vPD14Xh4yLyVOoEVnA37QplsV2Vu27M3ZmwcZcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZTQHbCW/GV/OQ7DNpl/6nhgVZ/6pjYi51TDG4rsBMBjSMsVyhAegcdtQa9aeLddfLrh9FhQtrieu+IOiJ7GN5ZcrVu6boK1VKRoIPCq3OGnZsPc+011zTb458PkU1TSAZyJqkXXObu/Tg+BPQBIK3agPEzaoiHbxjT8FqntVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k38WVhor; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k38WVhor"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC8F1F00A3A;
	Sun, 24 May 2026 03:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593380;
	bh=tXjCGzSEn7B5l74+OL8xm64lOR6AtHNBFjVyCT0bX6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k38WVhorVH7GIrkDHEswRTwQCRGEg1YYl1JMIvLB5bLg26sJ84D3SPOVXU7IQzugc
	 tOtJ4lMdvkMkWSY0BPaJuU5cq7HM/yCbC2ade6aLKH5b3D/8rXDsp7Jre5xAHvYx/P
	 mSYU4DmJB+mkQH5oPmk/67NyYd0dDAqiE9vv7qXvGZguwN7z83xwLHrX5qhPtTnR5d
	 hJvwMNz0IlFjXDnTtrxe71c9fMwZ6duO0Q/WS42ASLlCm7uwcGN8m15O5+itdOIiEE
	 WzUvoLDUFe81o5entlIPWB5hKp1khBqhuFh2RtidKVurPeDenuhik+47e3YSBdV4SD
	 VLH46ALEzNZmg==
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
Date: Sun, 24 May 2026 00:26:57 -0300
Message-ID: <20260524032709.1080771-24-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
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
index 04446f18d76c4cdb..cb1d851686d9cbc0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1045,6 +1045,14 @@ static int perf_event__time_conv_swap(union perf_event *event,
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
@@ -1186,6 +1194,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_COMPRESSED2]	  = perf_event__compressed2_swap,
 	[PERF_RECORD_BPF_METADATA]	  = perf_event__bpf_metadata_swap,
 	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
-- 
2.54.0

