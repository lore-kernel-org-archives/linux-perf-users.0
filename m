Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165928;
	b=GRRg43FSoYLxeeWGl21ti3EZ+VZY+KbqPxtTdDPUEKJMMmGZ6r9BFMNL5yVIYOYL01qs
	 Yfm46wYI/ItJdwwhpCaD4m2u7zBhehobX8H8nDWlfvhTL7HbS6uNa477LmqZsmwe5jcPv
	 X41HH06YLDaVoGrG/QQOIBC1btBjAKrbjpWvO7c6hfJxF/33kNDB0btNQbqxkSpg+HnOq
	 GVBeihNYAK/GcV74tf4l/27s3FDHKswkOMz7++D/qhuYCoMuw2tgMWlLPpJRb5MaphwgH
	 Id1z3of0bx3OkcuBzI8iBUvmI1KJZOXrLjRFsZPWTBunC5eoBYcGOYnM3yfITUhT/bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165928;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LwOejMAdRbuE8OwBsY1eR8U3BjOfICbFhYv18a3dato=;
	b=I7WVINXe5+lXt7x42mkmooiA7Gm4Qfot+wx3yElSEM+vVKvVizuqLaU+MxPlk82vqgyd
	 HqSaOKSbcyiz/8AiYqvQjQpNBjz/YCrYX7w0AEkKCvTHJgPZ5EryJUCORvGqlnI25JOCp
	 N1i6IOXmLx2ETvXZMoILK3g8C/LPmCTAxwNGFKGqxZFfJnLb0rbJmn+dHp8fAQ1058Btd
	 khUYL8mvNerdT/GF9yHu8vt0qABgwei+Ew0kRT8FNi8jjXj966zcsQ3c4Bx8JnnKdAuet
	 F+O20uQ+ix8xnkB0qlfvJFvhehhCgLTvWcbxKUbOllMcv6pz0CeH+HMjb9SnwdvpkIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mQE5Y+7n;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466F606A320;
	Fri, 20 Nov 2026 09:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1466F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=mQE5Y+7n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LwOejMAdRbuE8OwBsY1eR8U3BjOfICbFhYv18a3dato=; b=mQE5Y+7naZlSZJc6Uz/hgLTFB8
	zcybajwjaDoj7n3uN/iYFUAXUy51oBjb/boQXEX7CJVVffHbpLRLLEFz9oNLcdaUsVyuAefF+hzOa
	HFGnzN2irmcFvWQ9sNj9gPfK90xopyZZA9LnfwVwfO/2qnpznruWeeGgPh3Vk4T8Mw859NJrHvibT
	vtYgjhE3y5HN0+FtMktC1BuTcvarXGIWs/kI5jXji2UDw3DcCwW85XFFExiV2qJR66tNCYMm9gOFJ
	ndx2a4LrLfIfiL1mEE8Uqx/J7O6sbBUJJkCiBMaaUU1XKtvRNB1+JVklzwq1TQR+iLna82ZnUo1OL
	AYVWfAgg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKeu-00000000aEA-3SfW;
	Fri, 20 Nov 2026 09:11:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 06040300708; Fri, 20 Nov 2026 10:11:51 +0100 (CET)
Date: Fri, 20 Nov 2026 10:11:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, rkeilty@meta.com,
	atish.patra@linux.dev, dgreid@meta.com, riel@surriel.com,
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 3/3] perf/core: Don't zero perf_sample_data in
 do_perf_sw_event()
Message-ID: <20261120091150.GN2668564@noisy.programming.kicks-ass.net>
References: <20261119211235.99805-1-usama.arif@linux.dev>
 <20261119211235.99805-4-usama.arif@linux.dev>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119211235.99805-4-usama.arif@linux.dev>

On Thu, Nov 19, 2026 at 01:10:46PM -0800, Usama Arif wrote:

>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 57ea7e3c01a025..fa10ad7cfd99af 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11212,7 +11212,7 @@ static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
>  				    u64 nr, struct pt_regs *regs, u64 addr)
>  {
>  	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct perf_event *event;
>  	struct hlist_head *head;
>  

I like this one, didn't know about the __uninitialized thing. But I
think we wants to be more consistent with this.

A little git-grep seems to suggest we ought to do the same elsewhere.
Shall I fold the little something below in this patch?


--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9123,7 +9123,7 @@ perf_event_read_event(struct perf_event
 			struct task_struct *task)
 {
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	struct perf_read_event read_event = {
 		.pid = perf_event_pid(event, task),
 		.tid = perf_event_tid(event, task),
@@ -9390,7 +9390,7 @@ static void perf_event_task_output(struc
 {
 	struct perf_task_event *task_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data	sample;
+	struct perf_sample_data	sample __uninitialized;
 	struct task_struct *task = task_event->task;
 	int ret;
 
@@ -9534,7 +9534,7 @@ static void perf_event_comm_output(struc
 {
 	struct perf_comm_event *comm_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 
 	if (!perf_event_comm_match(event))
@@ -9625,7 +9625,7 @@ static void perf_event_namespaces_output
 {
 	struct perf_namespaces_event *namespaces_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 
 	if (!perf_event_namespaces_match(event))
@@ -9748,7 +9748,7 @@ static void perf_event_cgroup_output(str
 {
 	struct perf_cgroup_event *cgroup_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 	u16 size = sizeof(cgroup_event->event_id) + cgroup_event->path_size;
 
@@ -9859,7 +9859,7 @@ static void perf_event_mmap_output(struc
 {
 	struct perf_mmap_event *mmap_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int size = sizeof(mmap_event->event_id) + mmap_event->file_size;
 	u32 type = PERF_RECORD_MMAP;
 	u16 misc = PERF_RECORD_MISC_USER;
@@ -10155,7 +10155,7 @@ void perf_event_aux_event(struct perf_ev
 			  unsigned long size, u64 flags)
 {
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	struct perf_aux_event {
 		struct perf_event_header	header;
 		u64				offset;
@@ -10188,7 +10188,7 @@ void perf_event_aux_event(struct perf_ev
 void perf_log_lost_samples(struct perf_event *event, u64 lost)
 {
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 
 	struct {
@@ -10240,7 +10240,7 @@ static void perf_event_switch_output(str
 {
 	struct perf_switch_event *se = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	u32 type;
 	u16 misc;
 	u16 size;
@@ -10307,7 +10307,7 @@ static void perf_event_switch(struct tas
 static void perf_log_throttle(struct perf_event *event, int enable)
 {
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 
 	struct {
@@ -10363,7 +10363,7 @@ static void perf_event_ksymbol_output(st
 {
 	struct perf_ksymbol_event *ksymbol_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 	u16 size = sizeof(ksymbol_event->event_id) + ksymbol_event->name_len;
 
@@ -10450,7 +10450,7 @@ static void perf_event_bpf_output(struct
 {
 	struct perf_bpf_event *bpf_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	int ret;
 
 	if (!perf_event_bpf_match(event))
@@ -10540,7 +10540,7 @@ static void perf_callchain_deferred_outp
 {
 	struct perf_callchain_deferred_event *deferred_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	u64 nr = deferred_event->trace->nr;
 	u16 size, id_size, max_payload;
 	int ret;
@@ -10615,7 +10615,7 @@ static void perf_event_text_poke_output(
 {
 	struct perf_text_poke_event *text_poke_event = data;
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	u16 size = sizeof(text_poke_event->event_id) + text_poke_event->tot + text_poke_event->pad;
 	u64 padding = 0;
 	int ret;
@@ -10686,7 +10686,7 @@ EXPORT_SYMBOL_GPL(perf_event_itrace_star
 static void perf_log_itrace_start(struct perf_event *event)
 {
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	struct perf_aux_event {
 		struct perf_event_header        header;
 		u32				pid;
@@ -10721,7 +10721,7 @@ static void perf_log_itrace_start(struct
 void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 {
 	struct perf_output_handle handle;
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	struct perf_aux_event {
 		struct perf_event_header        header;
 		u64				hw_id;
@@ -11603,7 +11603,7 @@ void perf_tp_event(u16 event_type, u64 c
 		   struct pt_regs *regs, struct hlist_head *head, int rctx,
 		   struct task_struct *task)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct perf_event *event;
 
 	/*
@@ -11949,7 +11949,7 @@ void perf_event_free_bpf_prog(struct per
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 void perf_bp_event(struct perf_event *bp, void *data)
 {
-	struct perf_sample_data sample;
+	struct perf_sample_data sample __uninitialized;
 	struct pt_regs *regs = data;
 
 	/*
@@ -12403,7 +12403,7 @@ static int perf_event_set_filter(struct
 static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 {
 	enum hrtimer_restart ret = HRTIMER_RESTART;
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct pt_regs *regs;
 	struct perf_event *event;
 	u64 period;
