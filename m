Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205124;
	b=ujIURw4euDfj7wOIOmKXf+iOiHDuJ+TxiiXOl3av9G6zFjJt78qSFkmrxzeQTmvcJe8l
	 sbi+owTJU+g3g7vWDTTAKoqorWUErmNh322ii20D57OU1tc/LavU3luA6gJTu+UXW7rR2
	 w709X7uZSrTfzzj90nTgoZvi7CXRLPjuZu/QxwKIpU8JCnk/HzDyUszCMfCJelT1Pio70
	 +toxxoqbSWEfCuouYQWhsYhBE3lKkvJV30Fj6Zjo69HNpmmKNvzWOC42Z+SzrT7WERzY2
	 opbIhHrJ+yxjH8ms18yXrASUeFYxhNIHvXS0pS9JVLxEabqfi4vtkFiDnccoV9rgkwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205124;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Lp04bo2sgP06USHAChXdOuNrd2K1DM1CxyrrPNLoIDc=;
	b=PCkOTksyxMq+hmfBK1oj4RuHuI4MtqeP3s5CUFWRiUWzCxcWoz3KB7E/N4bwkuzg3Wxu
	 9IvNffNtXyr8XN6L6eJ8LmcxxplSCvBKuAns7WglKPjQyPRrDL303AwM9PEcEG9WxNy0p
	 r2dEK5zjFvXLMuf6PLN4mUQ3rUFTCGBtysUL64u+Aiq5jAUpbvzV/U0V31oj8SiQMoiAe
	 Xt9OpuO4xlDKsZKhp8nNGueoAf5qN2IgddiIEMMSoMlu4r9ab7n9LlUwf6lQd7sqgmdEw
	 HpSEdsiulDufqmK1mGiRSfyeDbFhCHSzQtyhzvHJJNxT56r1vEZIfFPRFNnHbnX+evA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="p/71m9Bl";
	arc=none smtp.remote-ip=95.215.58.159
Received: from mta1.migadu.com (out-159.mta1.migadu.com [95.215.58.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA8606A33B
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 20:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACA8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=p/71m9Bl
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6iXX93MlfIOuC/eK1roCbWuvGCrP8yxENT5m24PLFpg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795205118; v=1; x=1795809918;
 b=p/71m9BlbwFJb0TdRnG4u3KnNBiLxaf0sq42iV6OQu6Z9SYyEPr3dD9dQR00EYbiBBwgM1zr
 rTHfO/Z5O+ESBgZ8OIdrYGOa6vLxfQSYW6pp/Ww+9tbKEfsJVpmsion1KPjrHlSOlpoXrCHMsVh
 wbpVt5WtceZQd1fsViRm65TQ=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4ca826ec631b7483;
	Fri, 20 Nov 2026 20:05:17 +0000
X-Mizu-Trace-ID: 4ca826ec631b7483
X-Migadu-Flow: FLOW_OUT
Message-ID: <7f9c12cf-b2a6-4238-b768-17d66b84b2a9@linux.dev>
Date: Fri, 20 Nov 2026 20:05:12 +0000
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
 <20261120091258.GH2669272@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20261120091258.GH2669272@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/11/2026 01:12, Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 10:11:51AM +0100, Peter Zijlstra wrote:
>> On Thu, Nov 19, 2026 at 01:10:46PM -0800, Usama Arif wrote:
>>
>>>  kernel/events/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 57ea7e3c01a025..fa10ad7cfd99af 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -11212,7 +11212,7 @@ static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
>>>  				    u64 nr, struct pt_regs *regs, u64 addr)
>>>  {
>>>  	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
>>> -	struct perf_sample_data data;
>>> +	struct perf_sample_data data __uninitialized;
>>>  	struct perf_event *event;
>>>  	struct hlist_head *head;
>>>  
>>
>> I like this one, didn't know about the __uninitialized thing. But I
>> think we wants to be more consistent with this.
>>
>> A little git-grep seems to suggest we ought to do the same elsewhere.
>> Shall I fold the little something below in this patch?
>>
> 
> And this should be a separate patch again I think.

Agreed, but IBS is not safe yet. For PERF_SAMPLE_WEIGHT_STRUCT,
perf_ibs_parse_ld_st_data() writes only var1_dw and var2_w but sets
PERF_SAMPLE_WEIGHT_TYPE, so perf_output_sample() copies var3_w from
whatever is on the stack. INIT_STACK_ALL_ZERO hides that today, and
INIT_STACK_NONE kernels have leaked those 2 bytes since 6b2ae4952ef8.
With __uninitialized in perf_ibs_handle_irq() every kernel would.

We need the below:

commit e662f8539ca00096db3ee4d570efe97767427fbe
Author: Usama Arif <usama.arif@linux.dev>
Date:   Fri Nov 20 09:04:13 2026 -0800

    perf/x86/amd/ibs: Don't leak stack contents through PERF_SAMPLE_WEIGHT_STRUCT

    For a load that missed the data cache, perf_ibs_parse_ld_st_data()
    reports the miss latency as the sample weight and marks
    PERF_SAMPLE_WEIGHT_TYPE as done, so perf_prepare_sample() leaves the
    field alone. With PERF_SAMPLE_WEIGHT_STRUCT it writes only var1_dw and
    var2_w, but perf_output_sample() copies all 8 bytes of the union into
    the ring buffer. var3_w therefore carries whatever was left in the
    on-stack struct perf_sample_data in perf_ibs_handle_irq().

    CONFIG_INIT_STACK_ALL_ZERO hides this by clearing the struct on entry.
    Without it, every such sample hands 2 bytes of kernel stack to user
    space. "perf mem record" asks for PERF_SAMPLE_WEIGHT_STRUCT on x86, and
    since v6.14 swfilt lets an unprivileged user sample their own tasks with
    IBS.

    Write var3_w as well.

    Fixes: 6b2ae4952ef8 ("perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_STRUCT}")
    Cc: stable@vger.kernel.org
    Signed-off-by: Usama Arif <usama.arif@linux.dev>

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 66e67e27224f18..9aa47751b37f6c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1376,6 +1376,7 @@ static void perf_ibs_parse_ld_st_data(__u64 sample_type,
                if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
                        data->weight.var1_dw = op_data3.dc_miss_lat;
                        data->weight.var2_w = op_data.tag_to_ret_ctr;
+                       data->weight.var3_w = 0;
                } else if (sample_type & PERF_SAMPLE_WEIGHT) {
                        data->weight.full = op_data3.dc_miss_lat;
                }


The other sites look fine to me, including arch-PEBS: the drain skips
records whose first fragment has no basic group, so var3_w is always
written there.



> 
> ---
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce566..db6c87552594 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -958,7 +958,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	static atomic64_t status_warned = ATOMIC64_INIT(0);
>  	u64 reserved, status, mask, new_bits, prev_bits;
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct hw_perf_event *hwc;
>  	struct perf_event *event;
>  	int handled = 0, idx;
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 96c96369480a..cf0eafd67430 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1483,7 +1483,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
>  	struct perf_event *event = pcpu->event;
>  	struct hw_perf_event *hwc;
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct perf_raw_record raw;
>  	struct pt_regs regs;
>  	struct perf_ibs_data ibs_data;
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 4e344fb1ae3e..5f8bfc65b256 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2157,7 +2157,7 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
>  
>  int x86_pmu_handle_irq(struct pt_regs *regs)
>  {
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct cpu_hw_events *cpuc;
>  	struct perf_event *event;
>  	int idx, handled = 0;
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df59..5d84c18096a9 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3819,7 +3819,7 @@ static int x86_pmu_handle_guest_pebs(struct pt_regs *regs,
>  
>  static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  {
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int bit;
>  	int handled = 0;
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 8444670cee4a..73f6fd66856f 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1184,7 +1184,7 @@ int intel_pmu_drain_bts_buffer(void)
>  	struct bts_record *at, *base, *top;
>  	struct perf_output_handle handle;
>  	struct perf_event_header header;
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	unsigned long skip = 0;
>  	struct pt_regs regs;
>  
> @@ -1265,7 +1265,7 @@ int intel_pmu_drain_bts_buffer(void)
>  void intel_pmu_drain_pebs_buffer(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  
>  	WARN_ON_ONCE(cpuc->enabled);
>  
> diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
> index e887adc108ac..aa38b0ac3c7b 100644
> --- a/arch/x86/events/intel/knc.c
> +++ b/arch/x86/events/intel/knc.c
> @@ -213,7 +213,7 @@ static inline void knc_pmu_ack_status(u64 ack)
>  
>  static int knc_pmu_handle_irq(struct pt_regs *regs)
>  {
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct cpu_hw_events *cpuc;
>  	int handled = 0;
>  	int bit, loops;
> diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
> index 5368dc31787c..4ac429e55935 100644
> --- a/arch/x86/events/intel/p4.c
> +++ b/arch/x86/events/intel/p4.c
> @@ -1033,7 +1033,7 @@ static int p4_pmu_set_period(struct perf_event *event)
>  
>  static int p4_pmu_handle_irq(struct pt_regs *regs)
>  {
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct cpu_hw_events *cpuc;
>  	struct perf_event *event;
>  	struct hw_perf_event *hwc;
> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
> index e506f677db57..fc98a7fdd3bc 100644
> --- a/arch/x86/events/zhaoxin/core.c
> +++ b/arch/x86/events/zhaoxin/core.c
> @@ -355,7 +355,7 @@ static void zhaoxin_pmu_enable_event(struct perf_event *event)
>   */
>  static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
>  {
> -	struct perf_sample_data data;
> +	struct perf_sample_data data __uninitialized;
>  	struct cpu_hw_events *cpuc;
>  	int handled = 0;
>  	u64 status;
> diff --git a/arch/x86/include/asm/stop_machine.h b/arch/x86/include/asm/stop_machine.h
> deleted file mode 100644
> index e69de29bb2d1..000000000000

