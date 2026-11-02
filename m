Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621762;
	b=GV5PkU78YLgxG1J3+6NyxlNnvt7UkRXB+GGG/FoIXgn58bkPdwuLq/dZ5nOLdA0H1nuh
	 ZKZ0ze4EHLspwlGjeUjeVLbsia9af8qmboe33T+7ln0N2jhxzQqBR1SJNH4a0b0sYwYaW
	 SrsOe97UczvEobrhljqJjIr2qiZPziW84T4CT2yG7xKRYlPE2Ey8bZ1dEEQ+k1DXIPzRB
	 UD11kL93+RuL88goNYv2sVmNj3FfQfbD5v+cbJ7+JgUTnSnxrBuYEHDfSU4Sfs+iSvTlQ
	 E70e6fi8Sb3AnW4O6Y9tOVml0YJ8aiJP8/jFjkyRAhORE7Ql7gwDibOQDXNtECwV0kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5E7haAucu6qfiv2l5VpOzqA9ji1qzQ0GwblIaMBQnLU=;
	b=hyCt6SMi0G8sJywxJkxNGhw4Px9jSk0eAQxaA89qIOPaMLX5e9UC+E73nkrbWpOLXJQC
	 QPaTgMafnY8vqkiQZox8MOE63SaXIZBdGv6i0btco8OcsB0WEDV1YM/Z1OLhxsIfxh+Fr
	 4AkejevtH9fte0FfmKAY/KW9P86mYJuu6G4ND3IDTZlGjcP5/7DhIH7kuXFTbrapP19AD
	 cMJ3speHhHk5ZVz9biBXLfpEgfQFsVSkYjfGEnt1v2mGPt1UuRVwvSLE+wnKJ7Kvu4Wsm
	 MU8BxazP+gMvuzzmlgNFwWz/UasdixjcoXuDvK1Od9F86i/GJ0XYJxOfMjFMVxs1jiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G9OR64fr;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8836606B190
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8836606B190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=G9OR64fr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso12852955e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621760; x=1794226560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5E7haAucu6qfiv2l5VpOzqA9ji1qzQ0GwblIaMBQnLU=;
        b=G9OR64frJl/W1Wr5WSm0zTlzskxU4S2d916hLDQCyQu7kqu23gEhvmom5ycOEi0O5X
         NIv06Dlo9LBDksr6b/iA+wVadt0CPY+DDH0XKjuavdD7HFyK2j7Hrd1Y9AYYQyEG50bF
         FmUc4ULZWzaUlnTZVbm37EyNY+TDq/PMS9vvn1E3g0wRHu77TT/2vvuJ99jd/9pYtQLp
         xjhJEqhxYUj7cBFjhhlEJengysgInXbcwbMrfbXUXHYwDGWn0CI0FVzVr9uQ67asB0Uf
         e2+feOmrnU5yvI3D3oQgPsGTU04w8GwvPdHYY3gWkiPXU0nBSlFj/T4SFFMgCl54B2Ly
         HY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621760; x=1794226560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5E7haAucu6qfiv2l5VpOzqA9ji1qzQ0GwblIaMBQnLU=;
        b=jfbCIVjezBMurIW2wnTdB8VjF+S47pYE/gk7rmIBOGVumGDOUzESZPwKKs0yvP1H8H
         w52eJt5RIbcUU4r+5RN5veH686k9uyvz15QgLlZLeDdk9nfOP/4DUJO2/PeiZXkps3Mw
         XHJHStX8p+bu772W+KNY5YOdXDY39YCqrC6zE9eqcig69dBXyiola8Dn7NHqwMBYgwn9
         c2wwy2l/88HKMTxykNt6E0js0VPPtGhBxdLlUglz3cGA/DZyhPDhzYaUa6u4MCas7knh
         FbYrs9TPLFSrn6ZvI/wv+AmEo2bF0qwCueBZQjimRTiibXpt/ubygN/zzXwZZ3IPnlGn
         BROQ==
X-Forwarded-Encrypted: i=1; AKwUvBwA3V1/ZJ2jDFWV9rM2vnEVVBJaifjEh4fbkAgI1S2iE3j5892qhaUNWgbbs+UH++1dpyncKU8I7H/IOsNQYxyq@vger.kernel.org
X-Gm-Message-State: APuU4Z/zcp3uZuswltiB8m2Ljn+bdyoQUT/t3d7/DvOwt8HlVwe02VhT
	fakbQJ8xdiHzLmh/EoOj3ZB8Gpn4wSJX/5HOLOs6pXDX33UiCEojGKHDKqmE6xcgmek=
X-Gm-Gg: AYBFou0v0gTIZT54Liak4RgAKyu+ighrUK+CsuS7VzVqZybMacnk6hhJ3a1AQczI0In
	2tJIWsNhDZHqbbl6i0lvHX8xKW4u+VgG5qDWMB7EYYNQc96UNgIYfkGPpzxGKsgPx4fYo5ME4ia
	QVhkqoB3BARs9hoFS1i5xDkLmK+Z37CawuaTIkYHEXSJukdApPAGgTLSYrBTx3Ca9st3Tbe4tso
	jo4xEObh4pg54AEii6AWzVVmlzsLnbhP943iYQPSWJO/JLqF6eK7d3UPqBCIVLoQIufw3dULw8b
	nqAFR9XKyLVGam6Kk/h7AN5ZzS1ItbLWvojCjjbBq0ikuMflo3n581NpF0Q9fBIGCKecEWxviUK
	ZjSLXIFt8rMG3Ye606DCLuAOHpNm/0ChBlalqUcvwiU2NSG4CWmYI9Me10OR4x76lXfsEoE6Cd0
	z4hl926+cXTKBIgowwBHP+snRYcV1i3nbHqG6GKX3B+NQS8q9dLmarrmh9YrVD5LpLa5ZOgKxQ0
	i03Q43srmAACiFz4bA7FGaX7g6y8+Pr41qY+e1CWFwaWF8VofKyVn85Wb+ZDLv9/C9WGSkSXZNc
	4RkmKLN278cswTk8zawey7TEwRGaShcV
X-Received: by 2002:a05:600c:1d1c:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4ac1709a1f5mr235402515e9.12.1793621760385;
        Mon, 02 Nov 2026 04:16:00 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:59 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:27 +0000
Subject: [PATCH v3 13/18] perf cs-etm: Queue partial AUX records
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-13-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

In snapshot mode AUX records may straddle the boundary of multiple trace
buffers. Currently we only queue AUX records whose range is contained
wholly within a single buffer.

Fix it by queuing any partial AUX range that overlaps any buffer.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 54 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index f19aa4f787fa..e899d82b7c93 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3238,7 +3238,8 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	union perf_event *auxtrace_event_union;
 	struct perf_record_auxtrace *auxtrace_event;
 	union perf_event auxtrace_fragment;
-	__u64 aux_offset, aux_size;
+	__u64 aux_start, aux_end, auxtrace_start, auxtrace_end;
+	__u64 frag_start, frag_end, frag_size;
 	enum cs_etm_format format;
 
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
@@ -3286,25 +3287,23 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	}
 
 	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE) {
-		/*
-		 * Clamp size in snapshot mode. The buffer size is clamped in
-		 * __auxtrace_mmap__read() for snapshots, so the aux record size doesn't reflect
-		 * the buffer size.
-		 */
-		aux_size = min(aux_event->aux_size, auxtrace_event->size);
-
 		/*
 		 * In this mode, the head also points to the end of the buffer so aux_offset
 		 * needs to have the size subtracted so it points to the beginning as in normal mode
 		 */
-		aux_offset = aux_event->aux_offset - aux_size;
+		aux_start = aux_event->aux_offset - aux_event->aux_size;
+		aux_end = aux_event->aux_offset;
 	} else {
-		aux_size = aux_event->aux_size;
-		aux_offset = aux_event->aux_offset;
+		aux_start = aux_event->aux_offset;
+		aux_end = aux_event->aux_offset + aux_event->aux_size;
 	}
 
-	if (aux_offset >= auxtrace_event->offset &&
-	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
+	auxtrace_start = auxtrace_event->offset;
+	auxtrace_end = auxtrace_start + auxtrace_event->size;
+	frag_start = max(aux_start, auxtrace_start);
+	frag_end = min(aux_end, auxtrace_end);
+
+	if (frag_start < frag_end) {
 		/* Old per-thread files have no CPU (before v6.4) */
 		int queue_idx = sample->cpu == (u32)-1 ? 0 : sample->cpu;
 		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, queue_idx);
@@ -3313,18 +3312,19 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 			return -EINVAL;
 
 		/*
-		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
-		 * based on the sizes of the aux event, and queue that fragment.
+		 * If this AUX event overlaps this buffer, create a new auxtrace event
+		 * for the overlapping range and queue that fragment.
 		 */
+		frag_size = frag_end - frag_start;
 		auxtrace_fragment.auxtrace = *auxtrace_event;
-		auxtrace_fragment.auxtrace.size = aux_size;
-		auxtrace_fragment.auxtrace.offset = aux_offset;
+		auxtrace_fragment.auxtrace.size = frag_size;
+		auxtrace_fragment.auxtrace.offset = frag_start;
 		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
 		auxtrace_fragment.auxtrace.cpu = etmq->queue_nr;
-		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
+		file_offset += frag_start - auxtrace_start + auxtrace_event->header.size;
 
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64
-			  " tid: %d cpu: %d\n", aux_size, aux_offset, sample->tid, sample->cpu);
+			  " tid: %d cpu: %d\n", frag_size, frag_start, sample->tid, sample->cpu);
 		err = auxtrace_queues__add_event(&etm->queues, session, &auxtrace_fragment,
 						 file_offset, NULL);
 		if (err)
@@ -3364,6 +3364,7 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	struct auxtrace_index *auxtrace_index;
 	struct evsel *evsel;
 	size_t i;
+	bool found = false;
 
 	/* Don't care about any other events, we're only queuing buffers for AUX events */
 	if (event->header.type != PERF_RECORD_AUX)
@@ -3397,11 +3398,14 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 			ret = cs_etm__queue_aux_fragment(session, ent->file_offset,
 							 ent->sz, &event->aux, &sample);
 			/*
-			 * Stop search on error or successful values. Continue search on
-			 * 1 ('not found')
+			 * Stop search on error values. Continue search on
+			 * 1 ('not found') or 0 ('queued')
 			 */
-			if (ret != 1)
+			if (ret < 0)
 				goto out;
+
+			if (!ret)
+				found = true;
 		}
 	}
 
@@ -3409,8 +3413,10 @@ static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf
 	 * Couldn't find the buffer corresponding to this aux record, something went wrong. Warn but
 	 * don't exit with an error because it will still be possible to decode other aux records.
 	 */
-	pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
-	       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+	if (!found) {
+		pr_err("CS ETM: Couldn't find auxtrace buffer for aux_offset: %#"PRI_lx64
+		       " tid: %d cpu: %d\n", event->aux.aux_offset, sample.tid, sample.cpu);
+	}
 	ret = 0;
 out:
 	perf_sample__exit(&sample);

-- 
2.43.0

