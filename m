Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4123D3338;
	Fri, 12 Jun 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303103; cv=none; b=G4CjfCeZrsd9mmIAyqI/xcwuhtDXLkqIpxzrVliHP1AW9/sxWeZXcPjpZy8WECBVDSbPjOcIkwTOUcN52zqDB+9bd5ZzVWyeHL3pcv7jfqTVlB7mIIE+7X6znt5HSy/IDJUJ1KM0ES48DRoXuHFf+cZ9c7yOpHrwJjIZmi2WSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303103; c=relaxed/simple;
	bh=BjVpoHxLmthPlxaxsS4orRmDUsO+u5t+Kv2bhKcLmZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jge313wyfp4gcFL0SNwIWC5VW4huLtX3EGlyC3iqheLtEmK5rcAND29ClHZPesmwiGtP55VrChvvwjt1yWu3A4tw4gA/6qCAo9hOwNWI+e9u3f3I+z2krNuwlSHno2ZkiABaGzkxEbFORFMBi8BhNWyU8Ae3FEraFQHH3vIj0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAMb9DN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAMb9DN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76FB1F00A3A;
	Fri, 12 Jun 2026 22:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303102;
	bh=VHWWJ3iR5lUQcqoj2RNphUVBbkE9iVBtthOyhMR05bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mAMb9DN2Pf78G1mX7nfNBjltNBaE6XzzYerci++g96m/B5Y9AHje2f7H0xU9CIGXn
	 IPse3yRD7gDI0p1mRrvASJn0+8VWr1WRBmqwNfKbr+1F+jYcMlKXdui7BHTypj+ebN
	 YfPyzzctcCHF02D3a8BEidjFVDXH06I6X306EgQaJ9KvhYiitzlwkjhdlfxP0K+eBx
	 aDUjW0hY1dCLEAr5C+jbWA9xE9CsA5i2zK0NCEFtuPKkHvSEcTMDGPNTg13WjmBR8A
	 W3fBteLTT8BoHccc3MiMgAneorEgcVQma1N8ChyfDE4l1ZYJ7a49H0qaRnxvq8dZHG
	 PQ9IWTU3A3WQg==
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
Subject: [PATCH 11/13] perf bpf: Bounds-check array offsets in bpil_offs_to_addr()
Date: Fri, 12 Jun 2026 19:24:10 -0300
Message-ID: <20260612222413.40791-12-acme@kernel.org>
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
 tools/perf/util/bpf-utils.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index d6d2c9c190f7afbf..69148197b1ef9e8b 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -264,12 +264,28 @@ void bpil_offs_to_addr(struct perf_bpil *info_linear)
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
+			/* clear the bit so bpil_addr_to_offs() won't reverse a zeroed address */
+			info_linear->arrays &= ~(1UL << i);
+			continue;
+		}
 		addr = offs + ptr_to_u64(info_linear->data);
 		bpf_prog_info_set_offset_u64(&info_linear->info,
 					     desc->array_offset, addr);
-- 
2.54.0

