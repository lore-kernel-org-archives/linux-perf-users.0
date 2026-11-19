Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122772;
	b=JndniLi5EE37Vet57AVl38WOiWg7ISg7UZOaTjZyOANIf67x5K/qu83lLh9IllPU+Ppz
	 RQJCcRviXZE0RczWLFkvbXNUwrF18se+ltUUb9Li6l3QxFzWGnkCL+bsliSWvSKWXaZgw
	 BRf7VWXeKcI0V8ekN3riI5rFBIrhKEGgOgSgzoesQQdxjKBilr3WnBHLG0lITiSacIr3t
	 6NbGKmwipqCv9CBCcORY966kVdkmFoclxdVXBaVtxpQo246G1Nz4Q+xCSUHy/ucObiRha
	 rL3dhXSguSW6zs4R5UOa3clvGjQKXpIXyzurTk4ghrgYR89Bobwdt7uTnexC6A14ewA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122772;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xKNBFOq0+Du+ecEZB15Du1viTBkrv214W8b8amc82xc=;
	b=uSFcN/TX8peHaasVNpRngFCbWE6iD3TgPtlQ+MI5dU68NXAsh0qUnRJF2IGuvvEnGOME
	 tutpkCybd/zf7vqN+mcamLUwZssC5toxPaeLs82uUY6wnpemfHFIHI+1EhL1CN4y+i4+f
	 71CTu1wGfndUEJu8fDFSvL0MzVolo9GxsWTE42ibGV8/s3mlPmmgF+l9KysaJQjxDwCKO
	 VwJrzEYjIBh9EfUDQ45e95wffL+GHVmlHRhevil7WfUY1w2R3x8L7J5B0a4EiI9Yuursf
	 /pzG7iWYd0wqU8QDhKnh/rmAPTlmkQa+P4Sl9GpOOKDCf7N21PbP5zmYa8wJBFqZRfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cHUhqVuN;
	arc=none smtp.remote-ip=91.218.175.163
Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200260A2608
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 21:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3200260A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cHUhqVuN
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=obhNSdn+LWkloNwEAMY8yndm9depsHpVQ76eEZwRiT0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795122770; v=1; x=1795727570;
 b=cHUhqVuNuB42QAaEfTm3KBcAu708jyfrE3pCFzFWpuU5hF8HJC8TIsf8kKgOK8k2LTlojCo7
 4WYH2BUfkXyxhnH86Tw8Ao2TCk40ZLbAHXsuGL14khn5Q5lYCZ9CjnyOeBlGb2cvNUa81FJ2jc9
 mDHFPWHA8TXrn9qrMXJ48+as=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id e7767fc64b4b765c;
	Thu, 19 Nov 2026 21:12:50 +0000
X-Mizu-Trace-ID: e7767fc64b4b765c
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	rkeilty@meta.com,
	atish.patra@linux.dev,
	dgreid@meta.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] perf/core: Fix perf_sample_data reuse across software events
Date: Thu, 19 Nov 2026 13:10:44 -0800
Message-ID: <20261119211235.99805-2-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119211235.99805-1-usama.arif@linux.dev>
References: <20261119211235.99805-1-usama.arif@linux.dev>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_perf_sw_event() passes one on-stack struct perf_sample_data to every
matching event. perf_prepare_sample() fills in the fields an event
samples, marks them in data->sample_flags and skips fields that are
already marked, and those marks survive from one event to the next.

So a sampling event later in the list emits the sample ID, timestamp,
pid/tid and callchain prepared for an earlier one. Its record size is
computed from the earlier event's dynamic fields as well and can come
out smaller than what is written, in which case the kernel writes past
its ring-buffer reservation over the records that follow.

Two "perf record -e page-faults,context-switches -c 1 -a" sessions
running at the same time hit this: the one started first gets the
other's sample IDs and fails with "Bad address".

Commit 1d1bfe30dad5 ("perf/core: Fix perf_sample_data not properly
initialized for different swevents in perf_tp_event()") fixed the same
problem for tracepoints. Do the same here: initialize the struct for
each matching event. While at it, drop the unused data argument of
perf_swevent_match().

Fixes: bb447c27a467 ("perf/core: Set data->sample_flags in perf_prepare_sample()")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/events/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 687bd398275ba3..1c1ffd103c74a0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11142,7 +11142,6 @@ int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
 static int perf_swevent_match(struct perf_event *event,
 				enum perf_type_id type,
 				u32 event_id,
-				struct perf_sample_data *data,
 				struct pt_regs *regs)
 {
 	if (event->attr.type != type)
@@ -11207,11 +11206,10 @@ find_swevent_head(struct swevent_htable *swhash, struct perf_event *event)
 }
 
 static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
-				    u64 nr,
-				    struct perf_sample_data *data,
-				    struct pt_regs *regs)
+				    u64 nr, struct pt_regs *regs, u64 addr)
 {
 	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
+	struct perf_sample_data data;
 	struct perf_event *event;
 	struct hlist_head *head;
 
@@ -11221,8 +11219,10 @@ static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
 		goto end;
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_swevent_match(event, type, event_id, data, regs))
-			perf_swevent_event(event, nr, data, regs);
+		if (perf_swevent_match(event, type, event_id, regs)) {
+			perf_sample_data_init(&data, addr, 0);
+			perf_swevent_event(event, nr, &data, regs);
+		}
 	}
 end:
 	rcu_read_unlock();
@@ -11243,13 +11243,10 @@ void perf_swevent_put_recursion_context(int rctx)
 
 void ___perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
 {
-	struct perf_sample_data data;
-
 	if (WARN_ON_ONCE(!regs))
 		return;
 
-	perf_sample_data_init(&data, addr, 0);
-	do_perf_sw_event(PERF_TYPE_SOFTWARE, event_id, nr, &data, regs);
+	do_perf_sw_event(PERF_TYPE_SOFTWARE, event_id, nr, regs, addr);
 }
 
 void __perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
-- 
2.53.1-Meta

