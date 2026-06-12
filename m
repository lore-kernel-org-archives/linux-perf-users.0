Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA327B35F;
	Fri, 12 Jun 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224538; cv=none; b=Zry0XQzcvLUve3QqFIJ9ss5r8gV9fcz/NrBmRuiNGMF1z4o1hANP7uBqMZcnkJUmzpYK7X9tAaB+kWM+SHJQZLPOdZCvWurN1PKXc+Wh79t2Z+Rw6yvwxM94IzhwkI5zEqu09F6dcf85AFmfprquye5LnozJw79wvOHzdvHDFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224538; c=relaxed/simple;
	bh=Q4fsncbmRmID7c6quLhWnxmE3rKTSHWrUlEqq++ABks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj3w3ZyawDNoybDytASGW9RuaxqIqYUlgNnl+1sHZY1KUp2fdnTl8/hK/MAP6aovMF4r487BoPDIcd+AKFct0+wZ68zpjFQpVWSONB5UvoOugGxbYr+K20qOIuk1FJhQjhOFxZFNCP2CdbodG47xzV4TAfAfUNzJfuJ6afDMrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZnCiOT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZnCiOT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DC51F000E9;
	Fri, 12 Jun 2026 00:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224537;
	bh=2GVxeL9n9i64nQyWxWoDViRq81cnkUIKORHiyOMN7Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZnCiOT2V3mAI7CrqOHOoOtLlJ4ioErwxAIu/tkhpc5kCdzn4hQKe3dlJfcll2zzK
	 kDvhrs2N/E+4N17aNOYAC3Jfwihv+4hNAbvjFysS98kuDicdlF3kcoZOa0gexhWeOR
	 FT2fWbUpLrqGHTHKq8mUXL4L2MN+OPxrAtLeD7bkG+nLiN7Cvgr6vIy7Cr+XI9PLho
	 sHVwT5ukPavyKbSdjQDS0l4z15MXo1U2kjp1Wp4NVovejkOZXlEgLUN3A9Dqdvk2qT
	 GTH2jF+fd3xr4cHscaWMF0Q1tLoTuwP8496c3XKcA3HvrdRb7yWc2nsvamVatN2ix3
	 EKfHPfoMtGRAQ==
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
	Dave Marchevsky <davemarchevsky@fb.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 12/15] perf bpf: Bounds-check array offsets in bpil_offs_to_addr()
Date: Thu, 11 Jun 2026 21:34:40 -0300
Message-ID: <20260612003444.50723-13-acme@kernel.org>
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

bpil_offs_to_addr() converts offsets stored in perf.data's
bpf_prog_info_linear structure into heap pointers by adding the offset
to the data allocation base.  The offsets come from untrusted file input
and are not validated against data_len.

If an offset exceeds data_len, the computed address points outside the
allocated data buffer.  Callers like synthesize_bpf_prog_name() then
dereference prog_tags[sub_id] or func_info pointers, reading arbitrary
heap memory.

Add a bounds check: when an offset exceeds data_len, zero the field
and skip the conversion.  This prevents out-of-bounds pointer
construction from crafted perf.data files.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 6ac22d036f86c4e2 ("perf bpf: Pull in bpf_program__get_prog_info_linear()")
Cc: Dave Marchevsky <davemarchevsky@fb.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-utils.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index d6d2c9c190f7afbf..98cf21a9113428dc 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -264,12 +264,26 @@ void bpil_offs_to_addr(struct perf_bpil *info_linear)
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
 		const struct bpil_array_desc *desc = &bpil_array_desc[i];
 		__u64 addr, offs;
+		__u32 count, size;
 
 		if ((info_linear->arrays & (1UL << i)) == 0)
 			continue;
 
 		offs = bpf_prog_info_read_offset_u64(&info_linear->info,
 						     desc->array_offset);
+		count = bpf_prog_info_read_offset_u32(&info_linear->info,
+						      desc->count_offset);
+		size = bpf_prog_info_read_offset_u32(&info_linear->info,
+						     desc->size_offset);
+		/* offset and extent from perf.data are untrusted — keep within data[] */
+		if (offs >= info_linear->data_len ||
+		    (u64)count * size > info_linear->data_len - offs) {
+			bpf_prog_info_set_offset_u64(&info_linear->info,
+						     desc->array_offset, 0);
+			bpf_prog_info_set_offset_u32(&info_linear->info,
+						     desc->count_offset, 0);
+			continue;
+		}
 		addr = offs + ptr_to_u64(info_linear->data);
 		bpf_prog_info_set_offset_u64(&info_linear->info,
 					     desc->array_offset, addr);
-- 
2.54.0

