Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6C23BCED;
	Tue, 22 Sep 2026 01:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039610; cv=none; b=jKR+HsbV5YiFTqLH67Jvn6foHgU3MpoKMiWeZPE+2Hp/O55woRy1PRgkbBOwrHbm2qPT7wXYFmrd3nwbzJYDT1+IRjMKTzibLWhj+vT2qnoOodAgXdIFATu2Kkn3eKWH61wkFoDgwnohQ4CJRKxz9OGIFO+8Lag6h4GjcxY5wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039610; c=relaxed/simple;
	bh=YXL9stNuFSe0druMEK4OBXRkQjvEGxpipLAr1y5OXtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtMzFa0EX+kBxxO1hzCOe6Comavzuny7qHcAr1uEbOY2nIS/GR6Tq1xPOwKiiMZB4NkX4UEz2cSaHrAUyd3NRFHwg7W56kSMDMIwnLng2ihzawlR3HtFJnmuI+8iCSwgsZmiI9CJ0dKtAn4t+wpzCX07WwdkEF04+J+7QzeAu1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjRVPBCs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjRVPBCs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC4D1C2BCF6;
	Tue, 22 Sep 2026 01:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039610;
	bh=YXL9stNuFSe0druMEK4OBXRkQjvEGxpipLAr1y5OXtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rjRVPBCsGj/b9M3MvgIMfdgtRfsQOG3OG5ZgCFquGbWRvwyBUFvdER+noZhfDKb4M
	 R3lSEU+ZT1fy3Io2lCAoaEQ8ZxeNGtkpQHKMsV/UHlexInowrT7vv7v+p3awlL3AXZ
	 zVm9AMFlLBOciOa6E+CB2icCXnTOzi6e8+8hstuVn9Fzd0UPmrZYFKJFzVLVHNY9TR
	 d5u3xmBc7tnK53ELcNPOiFW2sm8Xu0V0tTeK4ljGTJTm7iWt1IzRJ1qQn7YygrXSvh
	 2pGqSNLy8VQOgsxJRhaRQIEjdsuqxTiXlvKRcLsArHb1XTJfMxaGGC4b6FZb9Gc1Se
	 +FJgL8dj2arhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F0C982F0;
	Tue, 22 Sep 2026 01:13:29 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:13:24 -0400
Subject: [PATCH 1/3] perf/core: publish the aux_event link with release
 semantics
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-perf-core-v1-1-ac56a719c02b@vt.edu>
References: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
In-Reply-To: <20260921-mb-perf-core-v1-0-ac56a719c02b@vt.edu>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039609; l=2045;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=Hy0/fktxi3buuF66+I6+QW/1V+ole54AgH7uVyKIW/c=;
 b=qTk3z/ml5HJ1ZgNOvAaiiTN6s5dcMJurLA/dd6L/hXaZ5pFrdMDyzkTnWMC/UqtkzGQ5YsYKr
 h/0ZpyMn9NrCpIXOgzFsu8ubcFfW+7EAoeqsiAm7lTCfZ/Hmttj+k1c
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

perf_get_aux_event() links an aux_output event to its group leader with
a plain store to event->aux_event once the leader has been validated.
perf_aux_output_begin() and the AUX sample path read the link with plain
loads, from the PMU interrupt on the CPU the event is scheduled on.

Store the link with smp_store_release() and read it with
smp_load_acquire(), so that a reader that sees the link also sees the
state of the leader it points at.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 kernel/events/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db7b76d6b..7cce3fc7c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2332,7 +2332,8 @@ static int perf_get_aux_event(struct perf_event *event,
 	 * group in torn down, the aux_output events loose their
 	 * link to the aux_event and can't schedule any more.
 	 */
-	event->aux_event = group_leader;
+	/* Pairs with the smp_load_acquire() in the AUX output paths. */
+	smp_store_release(&event->aux_event, group_leader);
 
 	return 1;
 }
@@ -7974,7 +7975,8 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
 					  struct perf_sample_data *data,
 					  size_t size)
 {
-	struct perf_event *sampler = event->aux_event;
+	/* Pairs with the smp_store_release() in perf_get_aux_event(). */
+	struct perf_event *sampler = smp_load_acquire(&event->aux_event);
 	struct perf_buffer *rb;
 
 	data->aux_size = 0;
@@ -8046,7 +8048,8 @@ static void perf_aux_sample_output(struct perf_event *event,
 				   struct perf_output_handle *handle,
 				   struct perf_sample_data *data)
 {
-	struct perf_event *sampler = event->aux_event;
+	/* Pairs with the smp_store_release() in perf_get_aux_event(). */
+	struct perf_event *sampler = smp_load_acquire(&event->aux_event);
 	struct perf_buffer *rb;
 	unsigned long pad;
 	long size;

-- 
2.43.0


