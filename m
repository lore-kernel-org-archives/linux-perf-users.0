Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793428562;
	b=yat2lpf69vGhWUnuBTND/Mlur8P35h37H6Ha/e9zYqea9H3vX1UxRUDYDbIFN2iign7r
	 AiYWzeu3cTFeUmHqmrTgWSECm2YISzeOVq5soYeSluPSpQXllzKmT5s55tlAp/ljr3yQM
	 ZN2+BBxKQ51qdrG+iNi7jdq6IeQSldRI1Vi27M10LDGq4sGYoa/LjlC4DRj+ZvagT1i5+
	 C7k0CrDLoom2lNMT+al+/GKD2tCaIXjQyFxDtKHwVBq6dZmBX5491Y6KfdKDe00ScB1RC
	 mFOp/ZNVst+zFrfcS+NGpmtiXb5jwnRfB5OUJMePNAcWwArS0VlxsLcw+ojJpEyvUCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793428562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FDB7DyCaZl3SoWW1cphn8L2kafvRHi8lhfs4yKRo15o=;
	b=ZWI/ob+Zqpmc70FCpQm5wtZU0TdM7YChBrvFPdIp976SPmnOKx2b6msliHwXkgEOa68d
	 8EbOCTXzf9DqD+PP4fILAnUh6jYg59xt2sMv9bZKamKFMK7mwqDGcAXG+tTt6hrrX29xM
	 1GDR64qIjDSPjchsNus2hzOVvKKlY4Mvo9WHHQ/fR01aDkGaB6CuATrduKOY+gHsfmuWF
	 wX6oukb9vmhFeoss2p9CYj/WByasMTfWbbnHK0zBXQYW7UFAk2mJkYz9LYe0svRPPkmdg
	 69Nrzb6UbfPngWAYmH+280JXCCGgnK41u8zw2tSSXbXQVU5eiguwfY0ypCcTEgODJOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pUJW7SrU;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D25606A325
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Oct 2026 06:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D25606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pUJW7SrU
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso3219138eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793428561; x=1794033361; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDB7DyCaZl3SoWW1cphn8L2kafvRHi8lhfs4yKRo15o=;
        b=pUJW7SrUl3cHuqeQ3E2hoY6Y1iH0ah0Z2cPIFhz4UUfzB9nX9SVqIL04RCiNXLVawb
         mbUPU5i8vKanfFcdd4d0ERulTuHIfLNn6kJhaJDvABLXTDs8hNfMUFj9lFuV8fxjH9Ld
         jrkcblDFZu9m1NXEm5/S9GM4nFTVhcik/vA1zIzmS7tj9HqOUuc9rN0K452k5CT+ZpPb
         e9bqmvlhMIDBarLEdLbo29KAdp52uX2V8xivUd+RriiJ/Op1avrnS8CchATFV2wBD0Wr
         cyT4JCC1ULcpzwz3jdV61mfkdhq5vzX9UPmKPm/iMYHbHC3VxuYA3yzaQBt8wGrFcrFm
         PpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793428561; x=1794033361;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FDB7DyCaZl3SoWW1cphn8L2kafvRHi8lhfs4yKRo15o=;
        b=Iy1CfFz9JumPNx763HjHI1MDxjb2os6zaXL4O8sqKo9lyRs2WKXw404ZaswOm/UZny
         +kXvBtCar8e7EwXb89Jp7UcPhOMSS6twRbAV9XbJuqh2dOj4dGihwof1ZlIVEIbFLjIv
         vwTddpNalk3BdXMMNpSo/ooRx7v95NK5V2Man31Dt9NwnPRr7EEF+SGmiZwanSpXYOYP
         mqUSEiMdBzusyNOcmZaaEFVeMR7y0+l3V+zNosZ4z6R3my8KJHBuLGx8+GXH2lwOfCJ+
         /l2A8Cz3ktdigPAUMZG2fucrdiqY2oi+Tg9YF84MUyDJGbPFT4cA16+AZxyjrCdKGL7T
         KNTQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1PC4LuIfHMEVdcdNKjbLQoMmHqmwC8JwtqrP0bb52150d3MHYQfRFTz+M6wjAuzj9DSI+rAPik2cJh3WJIxVe@vger.kernel.org
X-Gm-Message-State: AFq9FYKxwmyYEnRGbGYIS+gXB0bvhGDeJNkVDIMfvjDdHuiQIZu0bjTy
	0w3rC/y348CGTFqTFK6jw7yZTxWz0ucqlYekube9iGt0jy8VXYTwvdQS3dKLckexCC5QJejDoob
	0f8UK61UBfw==
X-Received: from dycng16.prod.google.com ([2002:a05:7300:ce10:b0:355:e5a8:715f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8959:20b0:369:f5f6:36a7
 with SMTP id 5a478bee46e88-36a423d1cc5mr6796966eec.16.1793428560954; Fri, 30
 Oct 2026 23:36:00 -0700 (PDT)
Date: Fri, 30 Oct 2026 23:35:49 -0700
In-Reply-To: <20261031063549.1281324-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031063549.1281324-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261031063549.1281324-4-irogers@google.com>
Subject: [PATCH 3/3] perf annotate: Fix block_range symbol loss on split and
 leaks on exit
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alireza Haghdoost <haghdoost@uber.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When block_range__create() splits an existing struct block_range entry
into a leading head range (entry->start < start) or a trailing tail
range (end < entry->end), it copies coverage and branch statistics from
the original entry into head/tail, but omits .sym = entry->sym. Because
the returned iterator only spans [start, end], process_basic_block()
never revisits the split-off head or tail range, leaving its .sym NULL
and causing block_range__coverage() to return -1 on instructions in that
split range.

Additionally, the global block_ranges rbtree is never freed on exit from
cmd_annotate(), and process_branch_stack() frees the resolved
branch_info array without calling addr_map_symbol__exit() on bi[i].to
and bi[i].from, leaking thread and map references acquired by
sample__resolve_bstack().

Preserve .sym = entry->sym when splitting head and tail in
block_range__create(), add block_ranges__exit() and call it from
cmd_annotate(), and release bi[i].to and bi[i].from in
process_branch_stack().

Fixes: 70fbe0574558 ("perf annotate: Add branch stack / basic block")
Fixes: bffb5b0c0976 ("perf map/maps/thread: Changes to reference counting")
Suggested-by: Alireza Haghdoost <haghdoost@uber.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c |  5 +++++
 tools/perf/util/block-range.c | 16 ++++++++++++++++
 tools/perf/util/block-range.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8863f3a570f6..331adbdbd635 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -174,6 +174,10 @@ static void process_branch_stack(struct branch_stack *bs, struct addr_location *
 		prev = &bi[i].to;
 	}
 
+	for (i = 0; i < (int)bs->nr; i++) {
+		addr_map_symbol__exit(&bi[i].to);
+		addr_map_symbol__exit(&bi[i].from);
+	}
 	free(bi);
 }
 
@@ -967,6 +971,7 @@ int cmd_annotate(int argc, const char **argv)
 #ifndef NDEBUG
 	perf_session__delete(annotate.session);
 #endif
+	block_ranges__exit();
 	annotation_options__exit();
 
 	return ret;
diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 7c559fcfd7e0..280d695c6c58 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -165,6 +165,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 			return iter;
 
 		*head = (struct block_range){
+			.sym		= entry->sym,
 			.start		= entry->start,
 			.end		= start - 1,
 			.is_target	= entry->is_target,
@@ -203,6 +204,7 @@ struct block_range_iter block_range__create(u64 start, u64 end)
 				return iter;
 
 			*tail = (struct block_range){
+				.sym		= entry->sym,
 				.start		= end + 1,
 				.end		= entry->end,
 				.is_target	= 0,
@@ -330,3 +332,17 @@ double block_range__coverage(struct block_range *br)
 
 	return (double)br->coverage / branch->max_coverage;
 }
+
+void block_ranges__exit(void)
+{
+	struct rb_node *rb = rb_first(&block_ranges.root);
+
+	while (rb) {
+		struct block_range *entry = rb_entry(rb, struct block_range, node);
+
+		rb = rb_next(rb);
+		rb_erase(&entry->node, &block_ranges.root);
+		free(entry);
+	}
+	block_ranges.blocks = 0;
+}
diff --git a/tools/perf/util/block-range.h b/tools/perf/util/block-range.h
index ec0fb534bf56..0ea4751292c8 100644
--- a/tools/perf/util/block-range.h
+++ b/tools/perf/util/block-range.h
@@ -72,5 +72,6 @@ static inline bool block_range_iter__valid(struct block_range_iter *iter)
 extern struct block_range *block_range__find(u64 addr);
 extern struct block_range_iter block_range__create(u64 start, u64 end);
 extern double block_range__coverage(struct block_range *br);
+extern void block_ranges__exit(void);
 
 #endif /* __PERF_BLOCK_RANGE_H */
-- 
2.56.0.317.g454f8302e1-goog

