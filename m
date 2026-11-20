Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795165989;
	b=G3332ERgkeDlR2o7EBlwpN/rOTgJaT4ym7v8cL7i/7NZNFCZReYbr5kXEErpjbl4lDi7
	 tmyDCtxU4ZdZECtzrt0Hs/3zIgZ8qxzHcH8tb3FF314VWlkRCznV5Bg+vdYC4/d9OGUqK
	 qzmf+iTsg7jzu6iIUNq9eq629nceh7FyUP8ntvbtQJMbMeCRyqA7nESLv8cKjdidOjGE9
	 +m4mEHhl8RiIYdCetVRM9HkhOvGUPiKVtxpV9rdeeBOS2bMXwI0iXPLzmab//O83SVecQ
	 ZEXMyEBCyx9Yiu1IbpcbYI912flSFNDBW5eSbrV3QDz9fosQmcOIr43er9c9G7JJvrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795165989;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=kMfrK4uJJ3SyP08/jJGJsJf6bTnM2XRLHwgjTFafnPI=;
	b=dU8fGHt9pb+he9u0wsYMyYTlPXZpZs0jgyaRQvkHPbU4jlVb06fnU0H8Wi0O2gVaXKFf
	 X4tmj3AqbQ3UczulCkR0lXb17x9/Yp+mgjTwYZeOizQJuAo+QtK1nNA9+iWLQYLoweJpv
	 yJw2gccjqht1ES5BLCEkFfYGXsUeGDliXhuNQiEWcJppnrSW0nBRAGCMozmefOMtP3jwz
	 dsrFqTtucUb9FdXQqJCZh3mzbT+YbnD4F925C+EHuSibvF7Lhg+HONsRfUETtj073rk8s
	 WqG23dU7VIbwTjK4xLtHNgTI8GMLAdRirCn6AFyHwSV18i0PUaON5ZHiuW3ASAaKv4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=tSL3DFqG;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4A606A320;
	Fri, 20 Nov 2026 09:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C4A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=tSL3DFqG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kMfrK4uJJ3SyP08/jJGJsJf6bTnM2XRLHwgjTFafnPI=; b=tSL3DFqGGMBffymevBIBD14598
	JWD1FNgjRcUinkF2E4igyPbKdmvK/09p6OZB9Lwmw/vMAOoDjdEI8jny0LihN5nmLOBzJzqoa7lcq
	3ASVI1ggxavKpkX2hk1NCQZDIfzgyzS+1YoRRJSBKBYEHl4TXrewQkEI9aKmmwCkLUgK5xB+ECFMQ
	ucljUffeP3gs5yIHoflXYqkg87wJpK+qRlZzTkZYq6496/Ww8GeY/jMhmBXgBWaW6kBbh1OdGa5aO
	/+hOvMCRSdVCVfA9gH0zpVtuPl6uUrz2lPalPyikSmfETMrhoe/7K45h44ARziFc76hRsFKBYQnlc
	2LfVsGbA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKfz-00000001jrJ-1JhM;
	Fri, 20 Nov 2026 09:12:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40F2E300708; Fri, 20 Nov 2026 10:12:58 +0100 (CET)
Date: Fri, 20 Nov 2026 10:12:58 +0100
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
Message-ID: <20261120091258.GH2669272@noisy.programming.kicks-ass.net>
References: <20261119211235.99805-1-usama.arif@linux.dev>
 <20261119211235.99805-4-usama.arif@linux.dev>
 <20261120091150.GN2668564@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261120091150.GN2668564@noisy.programming.kicks-ass.net>

On Fri, Nov 20, 2026 at 10:11:51AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2026 at 01:10:46PM -0800, Usama Arif wrote:
> 
> >  kernel/events/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 57ea7e3c01a025..fa10ad7cfd99af 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11212,7 +11212,7 @@ static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
> >  				    u64 nr, struct pt_regs *regs, u64 addr)
> >  {
> >  	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
> > -	struct perf_sample_data data;
> > +	struct perf_sample_data data __uninitialized;
> >  	struct perf_event *event;
> >  	struct hlist_head *head;
> >  
> 
> I like this one, didn't know about the __uninitialized thing. But I
> think we wants to be more consistent with this.
> 
> A little git-grep seems to suggest we ought to do the same elsewhere.
> Shall I fold the little something below in this patch?
> 

And this should be a separate patch again I think.

---
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..db6c87552594 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -958,7 +958,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	static atomic64_t status_warned = ATOMIC64_INIT(0);
 	u64 reserved, status, mask, new_bits, prev_bits;
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 96c96369480a..cf0eafd67430 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1483,7 +1483,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
 	struct perf_event *event = pcpu->event;
 	struct hw_perf_event *hwc;
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct perf_raw_record raw;
 	struct pt_regs regs;
 	struct perf_ibs_data ibs_data;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4e344fb1ae3e..5f8bfc65b256 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2157,7 +2157,7 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct cpu_hw_events *cpuc;
 	struct perf_event *event;
 	int idx, handled = 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a34d674df59..5d84c18096a9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3819,7 +3819,7 @@ static int x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 
 static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8444670cee4a..73f6fd66856f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1184,7 +1184,7 @@ int intel_pmu_drain_bts_buffer(void)
 	struct bts_record *at, *base, *top;
 	struct perf_output_handle handle;
 	struct perf_event_header header;
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	unsigned long skip = 0;
 	struct pt_regs regs;
 
@@ -1265,7 +1265,7 @@ int intel_pmu_drain_bts_buffer(void)
 void intel_pmu_drain_pebs_buffer(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 
 	WARN_ON_ONCE(cpuc->enabled);
 
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index e887adc108ac..aa38b0ac3c7b 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -213,7 +213,7 @@ static inline void knc_pmu_ack_status(u64 ack)
 
 static int knc_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct cpu_hw_events *cpuc;
 	int handled = 0;
 	int bit, loops;
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 5368dc31787c..4ac429e55935 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1033,7 +1033,7 @@ static int p4_pmu_set_period(struct perf_event *event)
 
 static int p4_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct cpu_hw_events *cpuc;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index e506f677db57..fc98a7fdd3bc 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -355,7 +355,7 @@ static void zhaoxin_pmu_enable_event(struct perf_event *event)
  */
 static int zhaoxin_pmu_handle_irq(struct pt_regs *regs)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data __uninitialized;
 	struct cpu_hw_events *cpuc;
 	int handled = 0;
 	u64 status;
diff --git a/arch/x86/include/asm/stop_machine.h b/arch/x86/include/asm/stop_machine.h
deleted file mode 100644
index e69de29bb2d1..000000000000
