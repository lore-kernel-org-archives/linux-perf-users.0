Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E653C2B8B;
	Tue, 26 May 2026 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830375; cv=none; b=UQnDyjouBdDdMguv4H73cES9IHHL0UV82ZhdDhPxD/aRPacHYqniRhPJ5ZnFw+XyNtXyFXZ9F5rSfOmXodDzGDTZEKm2UhER3pY+nesl6sDz/f/48esCzgKtwwDR2qRG75z6uOVSe5u6DPRA08E8eyi9Mt1Z46magIs/BTmU92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830375; c=relaxed/simple;
	bh=WKoFQjJDe0IHzs+e/rLQ4u/bvS6zSfWdfUsgGZRTjfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IArmmcSmBLjuxSst3hLF39JUbG7u16B61/ef2nRVlncr3nh/t38jBe0rE883CVQ8tPbN3EuhFW46V9fuKd/UNI/gZXKazJ0iKhfeuz1bNxKZG3ObBkAE21czXPdvKb91KXGnJy3hVObCzMKOEt724vZcWpx195/yoqL3CoB5Cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9f06IAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9f06IAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3881F00A3A;
	Tue, 26 May 2026 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830374;
	bh=P5azfTMXGrs1XaBtFDBxFOfqbcoD+gR0GYYpU+KoUJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9f06IAv7SGf40OHZhEWVm5eNVcuKpkffVf8anySU/Bk6J+pwi7BkhsY6jyqHm8AV
	 1dx1hfVqd7R4NolVQPy/QjwqlinPrldn5dx6n1Y+DyXubCuArbCWb5hSTlpwL5mBYt
	 R4uQoe5D7UWXcJZ7w08x+o/fnoazaB3iWJhUFZH6OcVMCHQJwPPqcXpK4OaDdxODX5
	 Hu5hWwXDWUMRHRjF/0NkHnPy/n/jjRvPC+ESJ7EqeQ6pdNV4sIXYm+u4vpSgcLn/gS
	 RK0bbN0bHpoUfiy/JANbURplUQCc0Bo7WrxFtfZJNOwgHzfZS3Uwti2vuuiPnhFOhV
	 Pj1zqkyWjFmQw==
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
Date: Tue, 26 May 2026 18:17:59 -0300
Message-ID: <20260526211806.1193848-24-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>
References: <20260526211806.1193848-1-acme@kernel.org>
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

