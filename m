Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6F3890E1
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053585; cv=none; b=fE48qo0CdhxBcc9g+0nG42kaxtYoesDyxKG61rJW3wqLm1MpyKihYCoFSJcI9rU0LSjflVypQR091J9iuR+LYxfh2rzpbqoT09Q9VJYy/5LlsOC/fWCyhzkxQyx8v7ldXK1LtAHIMLxmGSYuzmoSN2M/pWeRr0WFsA88JEDdWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053585; c=relaxed/simple;
	bh=bwZsKPXpFj0EagILS74wobtw3QdQZQfP3x9LOTF4xSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dcr0q3p6Dlyo1z5c0gE2jiLaJ6WgSbsVWmTI2Fz3w8hY/kG6zdvT8RFOgY33JgChXlaLjVKRaLHtHwth3onNEi88pZnSnipeHM3Mj037iUa/CWdB7u5nR2aK7pPY9kkl2IqMBIswwdtqqzpZ4Dd+kkmFhyyuPWWBjXM4lraF1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEGBWILj; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEGBWILj"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d9da2559aeso568357eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053579; x=1776658379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsfPYVO08tCC/QkaQf/uBEFF+74z2Xz18vy6UCdEwM=;
        b=cEGBWILj9dchk5VJ4XZgp+XqHMbUtXf/d4QH45NmjuPZM2GljIQ0GW7/M3SRO5QynF
         UvZNgJkyWNFw+3ga4b1TDAwFqomRWFFm9L3Q+emtNjtbgaXfCJOh3a3M/5C3d7IuXYHB
         KC6mCFW9mkAEbWn+LfDFdhPfSMH11XmKnwoCfcWidJdxj3y7iZIvoLIlBdyT4GT/7Wcq
         DMk/TlqBxn9qKcxXVn8D3wq/19NT1AUQNWH7A0d+BIzg9ZsijfWJnxmmwhuF0zqwkrDU
         ChniBk9BpSkptlBMzihkKQ1eAcTx1Q/kfbMf4k1v1KjFr8+cgGBPNFXnLqjGFylbyMun
         QFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053579; x=1776658379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsfPYVO08tCC/QkaQf/uBEFF+74z2Xz18vy6UCdEwM=;
        b=Hw5WsIY48BMoxN24I2V85IHXNftWFH/GauC9j0yRQC0D+SC1pxD8uvzf8tgQj0iljK
         IsMMjQPiBxAJmZ6mSYxK9pa+MyK8UBK+7xqeLV6iSf5EDLg7G2ZvMbDLa1wsRxBSaUOy
         SQk8GEQFsduTARYeRbD2GO3oAlfUYMw+6kfyL6rEyswc9P+iTmGmoyhuoiP4oT4wumv9
         oYXDti7lPjDZ7qn6kvFwLe4eQt83RBKXTi0rUaGY6dr9r9y2kGjKpk6O4gh8FBIMd4Rv
         D2kaoSY2K1KnM7k3E5cHJnrlAnMShE/yjVvhJTB/+DTh48tTyzDscuuvbQLm5k9j2Ee/
         2aZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ja8+wpGVjcMM9/VBx1U9BldGgnriTyvnlVfKXGMVgGcca1SFVShTVYcP4f9kri8gK7BKC/QDS71Zy4KmnfsC8@vger.kernel.org
X-Gm-Message-State: AOJu0YyND04nMzCd/cguOj3DfY2yQu3Agnr7F4ZNgijDwmuI7DwKXHAz
	ttl4sLPFr1tiVDla6UZ3UwDjHzFGxUiuFufZrSdFDTuWHeYOPYd9KAjJZW3aeqcFNlC06WSUyes
	3MYnVxLRNoQ==
X-Received: from dyhb15.prod.google.com ([2002:a05:7300:148f:b0:2d1:4dd2:72fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cb0e:b0:2ce:f3d7:221
 with SMTP id 5a478bee46e88-2d589463e5cmr6479369eec.17.1776053578696; Sun, 12
 Apr 2026 21:12:58 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:37 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-28-irogers@google.com>
Subject: [PATCH v12 27/33] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Prompted by Sashiko code review, add bound checks when synthesize
mmap2 and build_id events to make sure the filename doesn't overflow
the event and lead to stack corruption.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index de812a2befbc..a7fef7ac3da6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2257,14 +2257,20 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    const char *filename)
 {
 	union perf_event ev;
-	size_t len;
+	size_t len, filename_len = strlen(filename);
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array = &ev;
 	int ret;
 
-	len = sizeof(ev.build_id) + strlen(filename) + 1;
+	if (filename_len >= sizeof(ev.mmap2.filename))
+		return -EINVAL;
+
+	len = sizeof(ev.build_id) + filename_len + 1;
 	len = PERF_ALIGN(len, sizeof(u64));
 
+	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, len);
 
 	ev.build_id.size = bid->size;
@@ -2303,14 +2309,21 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  const char *filename)
 {
 	union perf_event ev;
+	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array;
 	int ret;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	if (filename_len >= sizeof(ev.mmap2.filename))
+		return -EINVAL;
+
+	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
+	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, ev_len);
 
 	ev.mmap2.header.type = PERF_RECORD_MMAP2;
-- 
2.53.0.1213.gd9a14994de-goog

