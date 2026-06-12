Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DB3D3338;
	Fri, 12 Jun 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303099; cv=none; b=mPKs69+6OfbwSwJAhyIZ2Y+yOuyFFfhROkCyFNkEs5CfK8x0ZY3tygKPnsCXeMkalKByYs7QPEFL1ZA9+CPJEvrPC6Oup1FhEB5lSLohpCq5MyUDCHfh6Jz0Alfap34nfzHAAHpYqQF13ZFLGJZclDjocpfFRqCFrNwx4X44W/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303099; c=relaxed/simple;
	bh=2xkPTrxGOhzZfX7aIOOwowSEJj2Ts7/gMOE713U/tyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd46YjQsyIYi9akldIh84swznNie7A+Bi+qEo78x9kWi+f48YtCsZaKEr2X9AaIoQe8nxnQVrniVIDvYbAYQCnF4bMe1hkOFd/F3U3mY4eLYBQpv7ouAsQYLEZRCnwNPPvFMrBsCAUOduipFrCK+ul1kzgNEfmjff5oviRQ3YNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhjxGzcF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhjxGzcF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F8E1F000E9;
	Fri, 12 Jun 2026 22:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303098;
	bh=d5eUlpvf4Z6s2VrN0LRJWwu8wwWwGEVee+PX7Q4Om40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VhjxGzcFBUEpSJ9WgDCC6tiBm+JsB6ne4NIxJsu6IWPZhR+hDgA+xWuevPgsR5HOG
	 /xa8COXIvZIbVMqVW7GHOQdr/vbG4CrgHmo8KTk7v5YIXb6ReoP+d81JUiD47Iju7x
	 q9hKJGuNdV4BVC9TKljKtANP6G6kktUveP+iLvVDd4imD3qOxZ/Sj8rTx0rt2cTTb6
	 d0p6P8wHyjnAKsU3xzVxyNeWqhw8j/ZhtD5GspcxHvq/zUqJbkzTMTf17keRNZ5pUl
	 ApZzXiZXVHLy9rMJD0o80LJEGdLdcq2Cu1ZvXErM4MNsdFC10jOxJz+OW65116B+zd
	 ayLCkWSrZRXqQ==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Blake Jones <blakejones@google.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 10/13] perf bpf: Reject oversized BPF metadata events that truncate header.size
Date: Fri, 12 Jun 2026 19:24:09 -0300
Message-ID: <20260612222413.40791-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

bpf_metadata_alloc() computes event_size from the number of BPF metadata
variables and stores it in header.size, which is __u16.  With 204 or
more .rodata variables prefixed "bpf_metadata_", event_size exceeds
65535 and silently truncates.

The truncated header.size causes synthesize_perf_record_bpf_metadata()
to allocate a buffer sized by the truncated value, then memcpy the full
event data into it — a heap buffer overflow.

Add a check that event_size fits in __u16 before proceeding.  BPF
programs with that many metadata variables are exotic enough that
silently dropping the metadata is acceptable.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: ab38e84ba9a80581 ("perf record: collect BPF metadata from existing BPF programs")
Cc: Blake Jones <blakejones@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index fe6fbca508c5135c..57d53ba848359e12 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -369,6 +369,15 @@ static struct bpf_metadata *bpf_metadata_alloc(__u32 nr_prog_tags,
 
 	event_size = sizeof(metadata->event->bpf_metadata) +
 	    nr_variables * sizeof(metadata->event->bpf_metadata.entries[0]);
+	/*
+	 * header.size is __u16.  synthesize_perf_record_bpf_metadata()
+	 * adds machine->id_hdr_size (up to ~64 bytes) after this, so
+	 * leave headroom to prevent the final size from wrapping.
+	 */
+	if (event_size > UINT16_MAX - 256) {
+		bpf_metadata_free(metadata);
+		return NULL;
+	}
 	metadata->event = zalloc(event_size);
 	if (!metadata->event) {
 		bpf_metadata_free(metadata);
-- 
2.54.0

