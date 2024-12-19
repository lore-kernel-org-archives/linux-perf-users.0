Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE819C56D;
	Thu, 19 Dec 2024 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734646883; cv=none; b=unQzSgF5SB1lYOs+Cu0vgqj5/npnwZWdkdFa15JJejmjfA0wToTZGVTGZ5TmXI3nMtnX3dWW3V7yzzxpl1AQh+mzKaR3hp6OKPfdN8jk+9/ED3yFHNsl13BwkFwV/CM5o51sVGupTm2pm7uTF8PLaqQfXb8UVOOGA13zDAfIBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734646883; c=relaxed/simple;
	bh=hPHKrHXVc2PqYhrJN3CKb59gyG8WVL34lkNlKOJ4kB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbxBwSODPbY7hOYVy41/TO8hRVFU7q97bOv8xQf4rmh6tSfLnZBFc39Csrj5Hobk9zM3TRcWF/b9NlE0ZJcuE4bzSK9vV2j7OMCqJtGVm6Z2e/giWNPCDxwrsG88gaXvJWv3/fc4YrNDU+WFn9aIw4STc5BZTUwr4reKRXtOMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HVJeNXmF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HVJeNXmF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fOuWMr67x+hMlqO688LsPnghFlOxk8nxnT6yaQl+UnE=; b=HVJeNXmFpz1TELSqlQzQHytKpj
	Y0auSvGyz49ZLmTrpv4nWXbb3ugO5vmsWruGfHaG7WsAA28lxQMpDDKFbGgIXwevQ6O8rz/HZqy4G
	zJMZsH3xwYEwjcbKOh+8ZBaCazm4O45K2bzBZjv3J4OhtHriJwzb5oJy+uFA6cxrVZEu4SA2R1A6J
	FlMoiUBLeap3d2yoGpCV7wmwYklmrlWpJOgTmUfZvYxW4MKx02EXH3Q6fydgbwtk3e6fzv6BYXnDf
	jsM/tMy5Q6pyiAhezfk78u0iH3wjAAVW5K+MwkR83jX/aA2Tysza33kazFxmbE5dH5ts4uUZwQeNC
	EkjC3TIw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOOtL-00000005W3O-2dHG;
	Thu, 19 Dec 2024 22:21:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AEA3E3003C4; Thu, 19 Dec 2024 23:21:10 +0100 (CET)
Date: Thu, 19 Dec 2024 23:21:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V6 2/3] perf: Extend perf_output_read
Message-ID: <20241219222110.GH26279@noisy.programming.kicks-ass.net>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
 <20241218151643.1031659-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218151643.1031659-2-kan.liang@linux.intel.com>

On Wed, Dec 18, 2024 at 07:16:42AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The event may have been updated in the PMU-specific implementation,
> e.g., Intel PEBS counters snapshotting. The common code should not
> read and overwrite the value.
> 
> The PERF_SAMPLE_READ in the data->sample_type can be used to detect
> whether the PMU-specific value is available. If yes, avoid the
> pmu->read() in the common code.

I had a poke at this, and ended up with the below. Not sure though,
wdyt?

---
 include/linux/perf_event.h  |  8 +++++++-
 kernel/events/core.c        | 33 ++++++++++++++++-----------------
 kernel/events/ring_buffer.c |  1 +
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8333f132f4a9..582f517a5dc8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1062,7 +1062,13 @@ struct perf_output_handle {
 	struct perf_buffer		*rb;
 	unsigned long			wakeup;
 	unsigned long			size;
-	u64				aux_flags;
+	union {
+		u64			flags;	   /* perf_output*() */
+		u64			aux_flags; /* perf_aux_output*() */
+		struct {
+			u64		skip_read : 1;
+		};
+	};
 	union {
 		void			*addr;
 		unsigned long		head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b2bc67791f84..f91ba29048ce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1191,6 +1191,12 @@ static void perf_assert_pmu_disabled(struct pmu *pmu)
 	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
 }
 
+static inline void perf_pmu_read(struct perf_event *event)
+{
+	if (event->state == PERF_EVENT_STATE_ACTIVE)
+		event->pmu->read(event);
+}
+
 static void get_ctx(struct perf_event_context *ctx)
 {
 	refcount_inc(&ctx->refcount);
@@ -3473,8 +3479,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4618,15 +4623,8 @@ static void __perf_event_read(void *info)
 
 	pmu->read(event);
 
-	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
-			/*
-			 * Use sibling's PMU rather than @event's since
-			 * sibling could be on different (eg: software) PMU.
-			 */
-			sub->pmu->read(sub);
-		}
-	}
+	for_each_sibling_event(sub, event)
+		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
 
@@ -7400,9 +7398,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader, self);
 	if (read_format & PERF_FORMAT_ID)
@@ -7415,9 +7412,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub, self);
 		if (read_format & PERF_FORMAT_ID)
@@ -7476,6 +7472,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4f46f688d0d4..9b49ecca693e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -185,6 +185,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	handle->rb    = rb;
 	handle->event = event;
+	handle->flags = 0;
 
 	have_lost = local_read(&rb->lost);
 	if (unlikely(have_lost)) {
