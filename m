Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204964;
	b=p8Yw72bzmwixm40s+Xx0D69N7bczBQl0/oN2N9o75cz6iGhhI2ZkAH+Cx8tW3VL1Q6Xm
	 pJYy2h0dwZmR22+LIAam3NQ5g5W9EHvVDKAU7sUnVI7vLzOAHGPndmJlUJNJA5Ry9Li2F
	 +d3PWtfIazmmom+q09J5jR8owT0VApJZHeAHT3AMqjKJiU9kA6QigrETQxYAU7vLF7J4a
	 ngMmSLGRtBT4qRrRlVw0zh8ANcfy0U7FjixCgUB5d170wHaF2BRGpY1FEz8YFbT9fmJQ0
	 zK+4jbCQF+O4CKGFBMUSTFKWtJ0F4p3TUkoqNPFSv4Q/wrNxDOdv19V5jp5pf0PzQjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204964;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=35g51n9yT0O+2qdfSgrvgmxnc3ZbtEGQlMJoh7Vkd7I=;
	b=lzAEbe00uuiAa1zW9pF9NZOnAqnJ//gCKT5bt6mTlm4jIjS8yG7rgF607NtfDTCu/G99
	 9YNEKbKVayp31gkmV8tosIZiBm9VDYoFi6m06gO0FTS/hVNeRW6ilebpsM8mw3wTJYYaS
	 jczhCceWKxNujO+mJcJ07XUQYntsL59rM1Qd2tmW3uofr+XSCAkDZP7h2R66rBRo0sWQ4
	 c1sw2chq2strcNK4PQsSxLPgr2f17dm7mn8mNi8lMIpGNtG/ktAECQKTCNt2wLQNfFdxr
	 2o4PHrjsp7+OIOMBVS46Y9bpW1IQhfZMN8GZD5yJPNoOs90J2npu+Q/cPJH3iYCIuLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Vur21Cac;
	arc=none smtp.remote-ip=91.218.175.1
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE27606A6FA
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 20:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE27606A6FA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Vur21Cac
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uQshDafHy9BozPUOwHTJ4xHyL9EhNB+AO68YPNEcvlA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795204958; v=1; x=1795809758;
 b=Vur21Cacc+79jrXsU/M9LO/uvmk2sTAEZZl45vWMgYpWQ6tTT1zxCKUI8n3hZNq9GV+qHzCT
 sivy0zIw7l4xzU//ItmqwvsklG7lSDM8MyKCInMOeT9Aj5+ideiIJvrzNjsmZ/8ukYvRTEtWpjv
 dBcrFGErqCbIfoDVDTr65zVc=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c47a9709b21efdbb;
	Fri, 20 Nov 2026 20:02:38 +0000
X-Mizu-Trace-ID: c47a9709b21efdbb
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0a15bd8-c37e-4736-913e-e926bdbd12e5@linux.dev>
Date: Fri, 20 Nov 2026 20:02:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf/core: Don't zero perf_sample_data in
 do_perf_sw_event()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, rkeilty@meta.com, atish.patra@linux.dev,
 dgreid@meta.com, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20261119211235.99805-1-usama.arif@linux.dev>
 <20261119211235.99805-4-usama.arif@linux.dev>
 <20261120091150.GN2668564@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261120091150.GN2668564@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/11/2026 01:11, Peter Zijlstra wrote:
> On Thu, Nov 19, 2026 at 01:10:46PM -0800, Usama Arif wrote:
> 
>>  kernel/events/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 57ea7e3c01a025..fa10ad7cfd99af 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -11212,7 +11212,7 @@ static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
>>  				    u64 nr, struct pt_regs *regs, u64 addr)
>>  {
>>  	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
>> -	struct perf_sample_data data;
>> +	struct perf_sample_data data __uninitialized;
>>  	struct perf_event *event;
>>  	struct hlist_head *head;
>>  
> 
> I like this one, didn't know about the __uninitialized thing. But I
> think we wants to be more consistent with this.
> 
> A little git-grep seems to suggest we ought to do the same elsewhere.
> Shall I fold the little something below in this patch?
> 


Thanks! I went through the below. perf_tp_event(), perf_bp_event()
and perf_swevent_hrtimer() call perf_sample_data_init() for each event,
like do_perf_sw_event() does. The side-band emitters only use the
sample ID fields, which perf_event_header__init() writes and
perf_event__output_id_sample() reads under the same sample_id_all
check. So they are all fine to do.

But they do need the fix in patch 2 to work.

There is another fix that I found looking at your next reply.
Would you like me to send all the fixes and you can then send
the below patch (and the next one?)


> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9123,7 +9123,7 @@ perf_event_read_event(struct perf_event
>  			struct task_struct *task)
>  {
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	struct perf_read_event read_event = {
>  		.pid = perf_event_pid(event, task),
>  		.tid = perf_event_tid(event, task),
> @@ -9390,7 +9390,7 @@ static void perf_event_task_output(struc
>  {
>  	struct perf_task_event *task_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data	sample;
> +	struct perf_sample_data	sample __uninitialized;
>  	struct task_struct *task = task_event->task;
>  	int ret;
>  
> @@ -9534,7 +9534,7 @@ static void perf_event_comm_output(struc
>  {
>  	struct perf_comm_event *comm_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  
>  	if (!perf_event_comm_match(event))
> @@ -9625,7 +9625,7 @@ static void perf_event_namespaces_output
>  {
>  	struct perf_namespaces_event *namespaces_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  
>  	if (!perf_event_namespaces_match(event))
> @@ -9748,7 +9748,7 @@ static void perf_event_cgroup_output(str
>  {
>  	struct perf_cgroup_event *cgroup_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  	u16 size = sizeof(cgroup_event->event_id) + cgroup_event->path_size;
>  
> @@ -9859,7 +9859,7 @@ static void perf_event_mmap_output(struc
>  {
>  	struct perf_mmap_event *mmap_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int size = sizeof(mmap_event->event_id) + mmap_event->file_size;
>  	u32 type = PERF_RECORD_MMAP;
>  	u16 misc = PERF_RECORD_MISC_USER;
> @@ -10155,7 +10155,7 @@ void perf_event_aux_event(struct perf_ev
>  			  unsigned long size, u64 flags)
>  {
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	struct perf_aux_event {
>  		struct perf_event_header	header;
>  		u64				offset;
> @@ -10188,7 +10188,7 @@ void perf_event_aux_event(struct perf_ev
>  void perf_log_lost_samples(struct perf_event *event, u64 lost)
>  {
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  
>  	struct {
> @@ -10240,7 +10240,7 @@ static void perf_event_switch_output(str
>  {
>  	struct perf_switch_event *se = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	u32 type;
>  	u16 misc;
>  	u16 size;
> @@ -10307,7 +10307,7 @@ static void perf_event_switch(struct tas
>  static void perf_log_throttle(struct perf_event *event, int enable)
>  {
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  
>  	struct {
> @@ -10363,7 +10363,7 @@ static void perf_event_ksymbol_output(st
>  {
>  	struct perf_ksymbol_event *ksymbol_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  	u16 size = sizeof(ksymbol_event->event_id) + ksymbol_event->name_len;
>  
> @@ -10450,7 +10450,7 @@ static void perf_event_bpf_output(struct
>  {
>  	struct perf_bpf_event *bpf_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	int ret;
>  
>  	if (!perf_event_bpf_match(event))
> @@ -10540,7 +10540,7 @@ static void perf_callchain_deferred_outp
>  {
>  	struct perf_callchain_deferred_event *deferred_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	u64 nr = deferred_event->trace->nr;
>  	u16 size, id_size, max_payload;
>  	int ret;
> @@ -10615,7 +10615,7 @@ static void perf_event_text_poke_output(
>  {
>  	struct perf_text_poke_event *text_poke_event = data;
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	u16 size = sizeof(text_poke_event->event_id) + text_poke_event->tot + text_poke_event->pad;
>  	u64 padding = 0;
>  	int ret;
> @@ -10686,7 +10686,7 @@ EXPORT_SYMBOL_GPL(perf_event_itrace_star
>  static void perf_log_itrace_start(struct perf_event *event)
>  {
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	struct perf_aux_event {
>  		struct perf_event_header        header;
>  		u32				pid;
> @@ -10721,7 +10721,7 @@ static void perf_log_itrace_start(struct
>  void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
>  {
>  	struct perf_output_handle handle;
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	struct perf_aux_event {
>  		struct perf_event_header        header;
>  		u64				hw_id;
> @@ -11603,7 +11603,7 @@ void perf_tp_event(u16 event_type, u64 c
>  		   struct pt_regs *regs, struct hlist_head *head, int rctx,
>  		   struct task_struct *task)
>  {
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct perf_event *event;
>  
>  	/*
> @@ -11949,7 +11949,7 @@ void perf_event_free_bpf_prog(struct per
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
>  void perf_bp_event(struct perf_event *bp, void *data)
>  {
> -	struct perf_sample_data sample;
> +	struct perf_sample_data sample __uninitialized;
>  	struct pt_regs *regs = data;
>  
>  	/*
> @@ -12403,7 +12403,7 @@ static int perf_event_set_filter(struct
>  static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
>  {
>  	enum hrtimer_restart ret = HRTIMER_RESTART;
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct pt_regs *regs;
>  	struct perf_event *event;
>  	u64 period;

