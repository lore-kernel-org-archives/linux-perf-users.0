Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993003B19DE;
	Fri, 25 Sep 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370054; cv=none; b=mQCeiUPsdgqRajccPpXN86BzX0zGPMPGqAj8ZrGjXHboFtWEOnjhnsHR5MZUM2F1Y9LvhuruAW5h5jz9meo3nNTieCdwFtmkJkCIe77XdGZ1HjeF/PQSeZV+gJCdBJ3IFz4pZo3tk7EBh9jP73PIKbhG4iMRYUv0dPtoeDshdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370054; c=relaxed/simple;
	bh=6Bt13QyTayBMqWKb9nSCzKJRcO2MPtsNV9qv4F9THgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tjNdhUHUH4s9DJR5pWFydA1nhbIR2XBzs83p0MNxuBpULnilJ/fCZaQ+OG2ifqdQVsOybn9HfaHviAtggMooJWpRsKvItVkqYxGH+w6Hxdit1dGRkq6q3c5bbctzr4QXFwcylU5L+nwnzkQXs2JVVxlC2FiVVap7V4riYjxdglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io; spf=pass smtp.mailfrom=serhei.io; dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b=T3IBdPOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mRytaF6P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=serhei.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=serhei.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=serhei.io header.i=@serhei.io header.b="T3IBdPOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mRytaF6P"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DC78EC01D8;
	Fri, 25 Sep 2026 17:00:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 25 Sep 2026 17:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1790370051; x=1790456451; bh=GI
	ebuVtnDClQY4/EWsG9mpy5eNxIVOZQFxC7BYCDWFA=; b=T3IBdPOOC/Af3/Xksx
	b04mj19/gnShFs+Wb/E0QK/3KMxPbeh7lsXUh+L5Sfqq3sdqX46MebJkkVP4icsR
	rUU0PvfuAcL2VDXiKYRPqGzsP1H2GFnm0DZ2UIjZRYMTfs5bi3HWjSbYa8Aq6BkM
	HcWrEP2z0TlKJvMlzVh5vdUlDC4PCYc5JH79EHLegcc9EfQtH9HzNP8twz+rh9jX
	23YRmpLdGoXHjEjNwuiV7pwDhGD6nFJY3VbUrH+/Kf/+1KT9WNyzEBRt3K3mHG3V
	sMrqD1Ha9p2lLE96ci9lJY0ngX3rr8xyR347d1XmM8FVh7G4ubQ9nod6v6jIGfkl
	ZKEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790370051; x=1790456451; bh=GIebuVtnDClQY4/EWsG9mpy5eNxI
	VOZQFxC7BYCDWFA=; b=mRytaF6P08yT4fBjQ+0aHIlaS87pBKudHj7Fe1ZetE4b
	wgJHR1ImBxdpTwEFEz0aCeRnD04jdmKSxEO6hwQ0cSOnGVULZmpcPYF9RmAm8feb
	mQ1iah37a28DlTHeshTh+wY8yCHOz5/arunCWP1wB3PEOgCiupq6LtCrU/O5q117
	YKfkfROA3K/GehArceKDwxrbUbwiwv0izLnkvSc0cKzdcudOFbxmEvaoVJGc7Ve2
	AuLT/ko6KIMniDbMPtvjHjhwxZKOA/KLBuPxnWW5XWKi4GLLopL1/W7KutWPQb9P
	RRbA+S1p8wyjC3Km4KHX8LWHo4s+8yBDfc10h43oJA==
X-ME-Sender: <xms:AuG2arcb2vmC5k-tkjve-zWAy81ZvZGxdrTY5umPubAfRmWBqVHYzw>
    <xme:AuG2ave88PcWgt72DrctzNrdcg7jjS54OkuTuNpcjsO8FuadN2CRuWHcyrqX5ZqSf
    afOzVDXHoyisM-7gfM8Lh4I97f84iTVTFs7HQHWDHWESHMK3CyI>
X-ME-Received: <xmr:AuG2at2iSDjpXwSbkiC1jGrINwD8AYchwJOWixN7DSYY1kJQJyw6P6DKq-eenYOAOb2Rdjwaa00X-yWL>
X-ME-Proxy-Cause: dmFkZTF9KlVdyhqm9yVBqrZ3N25dN0XPofRirTNJbw6uAXVSxd0KSfU5or0QuJVSyn+CRu
    STQIH0ieKtgV/LyTY0ruj+6jZ+byHS40DW3jn+VjRjcWDEaWRDDsqDgHMspGuenofS2Ii6
    oHAW6ue9BE2IPXEsxVwu3WtpGEtTVT+KSUQ3m5RCugDLHr2kE62jGJfC+MD2VcH3y8HPeH
    9q470m1dxBgBTkTLc5xMNyJumkPLhPVrm7ds9M1TLLq/yu+CFEt4EAacg39JKdaIgd244T
    uSxwu9sX4PzEU65wj3WNtPaVOI0uH/1LqcEq0+K+F5Vlnk6raoDRgWuFxwdjTwe3k4/xfD
    0pX7qzb6gOpmRj7mpOeeaZGIXrnk8CNisVBL72ve5zS6wG+M14v7scGAw9pnVV7I4tmirq
    NiFswADw97vANcknNasHgtKCwxaTRbQV/JytSpf2hTdmRXmGUj06vhvESQ0OUfhdrr7/Wx
    zslOoIkrLUzhXJR/+Sm3XURXSM1dbF7cM+JXoUsJJeheTkCS3F+J+8shH63vC9W5aIJxLd
    Ngez4xnV6PGS3nXU/fUQxl73SljgfhTtCnKkcouaXSuKWWEPM/PDjfh2npHSwkJKWkYllG
    y+uo4dphQJfM9I7wDTPwx31P2eeK3M+Sw7sjh5X+B7I5BPouV/Vs51D/wTkA
X-ME-Proxy: <xmx:AuG2av-44PlObKoxSSE3Jfc8yJhdTdjmzi2jIwfQdZJkn3RicwxWxA>
    <xmx:AuG2aq75wsfyKISeXlf7JzSbrPollc9l7O8fMgSd0b2767S9zIHN2w>
    <xmx:AuG2avsN8AePfpFn8ZbpOiarp693wd_B01-mPWoJ1IObM2t03oqcag>
    <xmx:AuG2ak2vemNtAEv8ZRjh2SnbpUtLT35OfqlrFMkflcQeT4uP62eRJg>
    <xmx:A-G2asnC-Vx1SOFSXhu6QcLiV3yRDRo_zEprzkCrduy85lqj1iWS0unV>
Feedback-ID: i572946fc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 17:00:48 -0400 (EDT)
From: Serhei Makarov <serhei@serhei.io>
To: acme@kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	james.clark@linaro.org
Cc: jolsa@kernel.org,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Serhei Makarov <serhei@serhei.io>
Subject: [RFC PATCH 1/2] perf inject: Support piped data with --convert-callchain
Date: Fri, 25 Sep 2026 17:00:29 -0400
Message-ID: <20260925210030.1957778-1-serhei@serhei.io>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When profiling applications without framepointers or non-framepointer
distros, it's helpful to pipe stack sample data directly to perf
inject --convert-callchain, e.g.:

perf record -F 999 --call-graph dwarf -o - -- myapp \
  | perf inject --convert-callchain -i - -o perf.data

This piped setup doesn't store stack samples on disk, removing a major
performance bottleneck for DWARF stack unwinding as noted in [1].

To support piped output, write a modified copy of the event attributes
in perf_event__repipe_attr. This gets around the inability to modify
event attribute records in-place after they are written to the pipe.

To support piped input, perform a more-exact sample size calculation
to perf_event__convert_sample_callchain.

[1]: https://rwmj.wordpress.com/2023/02/14/frame-pointers-vs-dwarf-my-verdict/
> The first most obvious thing is that even with the smallest stack
> data collection, DWARF’s perf.data is over 10 times larger, and it
> balloons even larger once you start to collect more reasonable stack
> sizes. For a single minute of data collection, collecting 10s of
> gigabytes of data is not very practical even on high end machines, and
> continuous performance analysis would be impossible at these data
> rates.

Signed-off-by: Serhei Makarov <serhei@serhei.io>
---
 tools/perf/builtin-inject.c | 88 ++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f174bc69cec4..29b22b52a631 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -219,6 +219,7 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 				   union perf_event *event,
 				   struct evlist **pevlist)
 {
+	union perf_event *event2;
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
 	int ret;
@@ -231,7 +232,28 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (!inject->output.is_pipe)
 		return 0;
 
-	return perf_event__repipe_synth(tool, event);
+	/* We can repipe the original event in most cases: */
+	event2 = event;
+
+	if (inject->convert_callchain) {
+		/* Copy event to repipe with corrected final attributes,
+		   without confusing downstream users of pevlist: */
+		event2 = (void *)inject->event_copy;
+		if (event2 == NULL) {
+			inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
+			if (!inject->event_copy)
+				return -ENOMEM;
+			event2 = (void *)inject->event_copy;
+		}
+		memcpy(event2, event, event->header.size);
+
+		event2->attr.attr.sample_type &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER);
+		event2->attr.attr.sample_regs_user = 0;
+		event2->attr.attr.sample_stack_user = 0;
+		event2->attr.attr.exclude_callchain_user = 0;
+	}
+
+	return perf_event__repipe_synth(tool, event2);
 }
 
 static int perf_event__repipe_event_update(const struct perf_tool *tool,
@@ -384,6 +406,18 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
+static bool evsel__has_dwarf_callchain(struct evsel *evsel)
+{
+	struct perf_event_attr *attr = &evsel->core.attr;
+	const u64 dwarf_callchain_flags =
+		PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER | PERF_SAMPLE_CALLCHAIN;
+
+	if (!attr->exclude_callchain_user)
+		return false;
+
+	return (attr->sample_type & dwarf_callchain_flags) == dwarf_callchain_flags;
+}
+
 static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 						union perf_event *event,
 						struct perf_sample *sample,
@@ -391,15 +425,21 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 						struct machine *machine)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
-	struct callchain_cursor *cursor = get_tls_callchain_cursor();
+	struct callchain_cursor *cursor;
 	union perf_event *event_copy = (void *)inject->event_copy;
 	struct callchain_cursor_node *node;
 	struct thread *thread;
 	u64 sample_type = evsel->core.attr.sample_type;
 	u32 sample_size = event->header.size;
+	u64 prev_callchain_nr;
 	u64 i, k;
 	int ret;
 
+	if (!evsel__has_dwarf_callchain(evsel))
+		return perf_event__repipe(tool, event, sample, machine);
+	cursor = get_tls_callchain_cursor();
+	prev_callchain_nr = sample->callchain->nr;
+
 	if (event_copy == NULL) {
 		inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
 		if (!inject->event_copy)
@@ -455,8 +495,18 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	memcpy(event_copy, event, sizeof(event->header));
 
 	/* adjust sample size for stack and regs */
-	sample_size -= sample->user_stack.size;
-	sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);
+	{
+		/* need to get stack size from the raw event */
+		const u64 *raw_stack = (const u64 *)((void *)event + sample->user_stack.offset);
+		u64 raw_alloc = raw_stack[0];
+		sample_size -= sizeof(u64);
+		if (raw_alloc)
+			sample_size -= raw_alloc + sizeof(u64);
+	}
+	sample_size -= sizeof(u64); /* abi */
+	if (sample->user_regs && sample->user_regs->abi)
+		sample_size -= hweight64(evsel->core.attr.sample_regs_user) * sizeof(u64);
+	sample_size -= (prev_callchain_nr + 1) * sizeof(u64);
 	sample_size += (sample->callchain->nr + 1) * sizeof(u64);
 	event_copy->header.size = sample_size;
 
@@ -2482,18 +2532,6 @@ static int __cmd_inject(struct perf_inject *inject)
 	return ret;
 }
 
-static bool evsel__has_dwarf_callchain(struct evsel *evsel)
-{
-	struct perf_event_attr *attr = &evsel->core.attr;
-	const u64 dwarf_callchain_flags =
-		PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER | PERF_SAMPLE_CALLCHAIN;
-
-	if (!attr->exclude_callchain_user)
-		return false;
-
-	return (attr->sample_type & dwarf_callchain_flags) == dwarf_callchain_flags;
-}
-
 int cmd_inject(int argc, const char **argv)
 {
 	struct perf_inject inject = {
@@ -2746,15 +2784,15 @@ int cmd_inject(int argc, const char **argv)
 	if (inject.convert_callchain) {
 		struct evsel *evsel;
 
-		if (inject.output.is_pipe || inject.session->data->is_pipe) {
-			pr_err("--convert-callchain cannot work with pipe\n");
-			goto out_delete;
-		}
-
-		evlist__for_each_entry(inject.session->evlist, evsel) {
-			if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evsel)) {
-				pr_err("--convert-callchain requires DWARF call graph.\n");
-				goto out_delete;
+		/* For on-disk data, check evlist up-front.
+		   For piped data, evlist is not available yet;
+		   check in perf_event__convert_sample_callchain. */
+		if (!inject.session->data->is_pipe) {
+			evlist__for_each_entry(inject.session->evlist, evsel) {
+				if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evsel)) {
+					pr_err("--convert-callchain requires DWARF call graph.\n");
+					goto out_delete;
+				}
 			}
 		}
 
-- 
2.55.0

