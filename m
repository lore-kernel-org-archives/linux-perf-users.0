Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF62EBB84;
	Fri, 12 Jun 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224534; cv=none; b=KhnzGZPSQEd43kq3hPOybeFeYlRT0ArH9td8ORx1gtOopQtxtaIsIq+hiNgkQkLS6YBy2KwEPzSWXK3tVUAggbxnhZJMUMeJ5VnezcRgfz2q69tdtTv7RUYEYlze88aLLOG+guPb2lRAKMg/a5f8mfO1M3qYP4BwWSTkGq4IApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224534; c=relaxed/simple;
	bh=2xkPTrxGOhzZfX7aIOOwowSEJj2Ts7/gMOE713U/tyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWYJ7kDplzgG6eLRMwffkH37iVFbo71gZKny1Yte37JMQ9vgC9T0Nn0wTrrDx+Kk6fl08I+Q899z114FIEn54u/wT8E0YeoL5gK7/z2r0RCqNhdO46Ba0wk34IU+5lq2/9qkaVxeILPTd9ci56AyIeZnmF92rQgJGc9QbFyVl/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKxeiO/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKxeiO/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5511F00A3A;
	Fri, 12 Jun 2026 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224533;
	bh=d5eUlpvf4Z6s2VrN0LRJWwu8wwWwGEVee+PX7Q4Om40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aKxeiO/sHq4LtnBa4rokN878x/7ngzDYjn/h9/LsznVkaNlMihGQY1co8OKI73Vt7
	 +a6tmqPbubRmL3CJ7s7Pi4tNR9spqRcjod6OfkrXYo2p0xLx4vvNaYGCSVimZJtEsA
	 MTcz6HpWaw4uWwHVQuNOybhmFgzL/CnabS1xy6Rcm/DLalw0hMq9i87Ol/Zf3TYTS/
	 8LBjN/PSu7dNdqUsjfJnc8T173FWTUdHZYA647P7Ta/7pkFH/IQxsL2HnKAP5gSi9N
	 /E22pz/xXdOeVkluFOUOnsd/dDtenGnhytlJo/9lPMcPy1pSXuiaixMOOG+/k32fxQ
	 geVZMQ+sYWHVQ==
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
Subject: [PATCH 11/15] perf bpf: Reject oversized BPF metadata events that truncate header.size
Date: Thu, 11 Jun 2026 21:34:39 -0300
Message-ID: <20260612003444.50723-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
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

