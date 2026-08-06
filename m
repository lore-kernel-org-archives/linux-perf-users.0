Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EA7298991;
	Thu,  6 Aug 2026 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019806; cv=none; b=sDYafpyRT6ed15Q7PtJMgCnl74UAJap7neo87+fvXVFC4nMjOgkhd+vZj4g2t/T+mkXXleRIuds4BbfkQdajJRd3a1gK30js9c5EgTCecQqcUf6cPJo/hovh+ct4btEaiNjHf+jjrvm34JzRtEXiiSkQC7rNswTWhFvcgfwIiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019806; c=relaxed/simple;
	bh=zOzZ6R9n9cX/hkQsyXcUak2eXDWTGufaDSt4AoIwZiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MptKzwKRmKa22xSRTp8PE7rJJbm7YckwP/10oBur1kjUALVXyTUhbWUdEJVGirjTLo5dnO/5e2IlyW3NifvFf16Jt0wUC7Eki9ubs5iRcq8Ngv0Dk5Qgao8VAmkzfYwMhIhNaGZfycikA/dggx53Iz1poDljyADjExTVj9M9G3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldam6ImE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldam6ImE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922431F000E9;
	Thu,  6 Aug 2026 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019805;
	bh=qkYprDtGWPa4KjbGn9gcW9pfLi13mKr1cL3g3IKZD+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ldam6ImE6X1NAPm1hZBdMkqEKTpPCAZA2A5ByP4ACXimS2L+3Wpe02YC5rkLv+syg
	 Lo6Zpp2mu7AE2iHn6HP5maYpjQ7QZWLVADMdvh9YbZ2iEkC7uYs1MzvUf8cHvv5Fag
	 I2rGKCasHxdaUeDu+E5GSqDbKB8GAZRgzXrEycgDAdsMOUj2eWy7K2GCoH2gjAEP0j
	 Fx6JLOrlfkrTrIBmjMWt55Dgx04cK55659eCH7IEWKmkv2Qu/Ww9r0dLLcYze6eIQA
	 d+bqYOk3DV8G4MDxzrJrskGgA2PXlJLBMQ1bBVnF0ot8z2qV7M42DFhMsePse46aeV
	 njlbAaIR0Ph4w==
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
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 06/12] perf jitdump: Check snprintf return before computing header size
Date: Thu,  6 Aug 2026 09:35:57 -0300
Message-ID: <20260806123604.271277-7-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

snprintf() returns the would-have-been length on truncation.  When the
jitted filename exceeds PATH_MAX, the unclamped 'size' value inflates
sizeof(event->mmap2.filename) - size into a massive underflow, causing
the header.size computation to write an oversized header.  The
subsequent write to 'id = event + header.size - idr_size' then corrupts
the heap.

Clamp size to PATH_MAX - 1 after snprintf in both jit_repipe_code_load()
and jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 7efbaa07f1ba73f9..45f0e21b0e780cb6 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -495,6 +495,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 			jd->dir,
 			nspid,
 			count);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= sizeof(event->mmap2.filename))
+		size = sizeof(event->mmap2.filename) - 1;
 
 	size++; /* for \0 */
 
@@ -625,6 +628,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	         jd->dir,
 		 nspid,
 		 jr->move.code_index);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= sizeof(event->mmap2.filename))
+		size = sizeof(event->mmap2.filename) - 1;
 
 	size++; /* for \0 */
 
-- 
2.55.0

