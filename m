Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096099;
	b=eYui8yD8G0yRPQdhEVNtQdCdwrZAEX4uGZK3PYgP7W3n1sqm53W84JoPzl9RXtBATnQF
	 S7XK7H7/In4CvsFtzfGMeiU9xpUaO8K8sFkZq5PjUcVn1Vtitq9ag4VeDqeLZ1x2iVUWa
	 v/8QH2LoNwuwWtOeOhY3hAahvdU9dfwr/4r3ISd9iupfFUYYvTreB6D2BmPeT2NqWKTF8
	 F5oU8r4vSUr9dFdvSZWVgPDB+7TFhioiRBl/rhJa5oSF7IyNxcWAtQvrdak3Miy10VysM
	 je1Ad15em3KJRDAdZQfCfRsCjNvGNtnF4YVp+hKyl5VyDFrXq7vyz0RcTpU19MpNYOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096099;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=s13tSiff6fcPsfGnZQ/kV4hOjYGqsIat17pRr1AVdyQ=;
	b=3JUl0SXxu5Z1BfxGhHENylT+eeJ5WIbu14tocPVgibVS4+1KmaNdguekOuBU/zVgmoza
	 7/bFR3+gLRyvXivPTEo8mNCslA9GiT8BG0li4csEnr3F6bsKG3miCO/Ft8goiBr6617BT
	 slm/p35T+8xZRMoY/CYmaSu5+X2uM++5UkpXK0X/+vqOlkzXo8GQMjj+MA1ov4CDKuQEM
	 Qu+NjCxMEtxjMr/nbnWLltFsAcNDD56FlfPoYTO8GQ7dFbkYqg7AZzKSXyrc/3jGLhwV1
	 wzglM3ISANNJcXigFQB43D0LThTj1atNFWAk4Gm8nrimlrZxdk/HchXmMsMj2QuA+MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kMc6wTVi;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18F606A324;
	Tue, 27 Oct 2026 10:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC18F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kMc6wTVi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793096099; x=1824632099;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s13tSiff6fcPsfGnZQ/kV4hOjYGqsIat17pRr1AVdyQ=;
  b=kMc6wTVitpWizvB0mUe6cemWbvv4BNkZhd+yrhhdNdCBnCXdyRUsFvb0
   UWRLi+Ndiv2Aaslx1qQXHKxLSc2hE5Ersg6C34pXGTHTT4bShejoa//WW
   1a81ubNB/xjhGP1BgZPIi4or5+Naw3hAyOOZ9Hj9ZudS3RX0t7i+FITKl
   MdBk1roWbzlmhFQnllF8GEi76tzVAliUrtSdfRD1Qd4L/hPPwz15FrE8M
   zE9DqYTeO+ZQ5bzYcNjO2fHlydzojJ9xqmF7iCwx2RzvxhziAK0157bJe
   dKrRX1KdLpThojFMoupxeqSVTvp0agI3LGOhfLXLtMOEENYuyolI5Gjhh
   g==;
X-CSE-ConnectionGUID: PMMLogEJTl2y7naF30MKeg==
X-CSE-MsgGUID: V1MIN0maQ4KXyfyYVQuQjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1799327"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1799327"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:14:58 -0700
X-CSE-ConnectionGUID: x4ttERJOQu2IwdVN1yETUw==
X-CSE-MsgGUID: Vg6kYgviTHKas9yd051bPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4547564"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:14:56 -0700
Message-ID: <b8693216-9d8b-427e-9657-1b1a52cf08e7@linux.intel.com>
Date: Tue, 27 Oct 2026 18:14:53 +0800
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
Subject: Re: perf: perf_pmu_register() publishes sysfs attrs before per-CPU
 contexts exist -> NULL/poisoned cpc deref in
 perf_event_mux_interval_ms_store()
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <de936c3.1476b.1a162c34cec.Coremail.xuhx@hust.edu.cn>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <de936c3.1476b.1a162c34cec.Coremail.xuhx@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/22/2026 4:38 PM, 徐晗翔 wrote:
> perf_pmu_register() makes <pmu>/perf_event_mux_interval_ms writable
> before the per-CPU PMU contexts are allocated and initialized, so a
> concurrent write to that attribute dereferences a NULL or a published
> -but-uninitialized cpc: a kernel oops writing to absolute address 0xf0
> in task context, or a NULL+0xc deref on the target CPU in hardirq
> context ending in "Fatal exception in interrupt" -- both verified
> deterministically on mainline 7.3 and reached naturally by an ordinary
> userspace write loop without any instrumentation.
>
>
> The store side (perf_event_mux_interval_ms_store(),
> kernel/events/core.c:12615) fetches cpc and writes through it with no
> readiness/NULL check, while the register side publishes the sysfs
> attributes first (pmu_dev_alloc() at core.c:12865) and installs the
> per-CPU contexts afterwards (alloc_percpu at 12870; cpc pointer
> published at 12877, its hrtimer initialized only at 12879 by
> __perf_mux_hrtimer_init()). The registrant holds pmus_lock; sysfs
> callbacks take no lock in common with it, so a root writer (default
> attribute mode) racing a runtime PMU registration lands inside the
> window. Verified on mainline 7.3 with KASAN: controlled-window
> evidence pins both faulting instructions exactly, and a natural
> write-hammer hits the window within ~0.6 s. The same publication
> window also has a purely functional consequence (persistent
> interval-configuration divergence) described at the end.
>
>
> The detailed description:
>
>
> * Test environment / affected version
>
> Linux version 7.3.0 (gcc 13.3.0, GNU ld 2.42) #1 SMP PREEMPT_DYNAMIC
> -- vanilla mainline 7.3 release tarball (kernel.org, unmodified),
> rebuilt with CONFIG_KASAN_GENERIC=y, CONFIG_KASAN_OUTLINE=y,
> CONFIG_KASAN_VMALLOC=y, CONFIG_PERF_EVENTS=y, CONFIG_MODULES=y,
> CONFIG_HZ_1000=y, booted in QEMU/KVM on x86_64 (4 and 64 vCPU
> guests). The publication order and the store code are identical in
> 7.1.5 (function-level diff); line numbers below are from 7.3.
>
>
> * Mechanism
>
> perf_pmu_register() publishes first and initializes later:
>
>
> if (pmu_bus_running && !pmu->dev) {
> ret = pmu_dev_alloc(pmu); /* core.c:12865:
> device_add() makes the
> attribute group live */
> ...
> }
> pmu->cpu_pmu_context = alloc_percpu(...); /* core.c:12870 */
> for_each_possible_cpu(cpu) {
> cpc = kmalloc_node(...); /* per-CPU allocs */
> *per_cpu_ptr(pmu->cpu_pmu_context, cpu) = cpc; /* :12877 */
> __perf_init_event_pmu_context(&cpc->epc, pmu);
> __perf_mux_hrtimer_init(cpc, cpu); /* :12879 */
> }
>
>
> and the store path has no readiness check:
>
>
> for_each_online_cpu(cpu) {
> struct perf_cpu_pmu_context *cpc;
> cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu); /* :12640 */
> cpc->hrtimer_interval = ns_to_ktime(...); /* :12641 */
> cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
> /* :12643 */
> }
>
>
> Two windows follow:
>
>
> - Window A (array published, slots still NULL; register thread is in
> the per-CPU kmalloc_node loop): the write faults at :12641 with a
> NULL cpc. In the 7.3 build the store does
> "mov %r14, 0xf0(%rsi)" with rsi==0 -- a write to absolute address
> 0xf0.
>
> - Window B (cpc pointer already published at :12877, but
> __perf_mux_hrtimer_init() at :12879 has not run yet, so the
> embedded hrtimer is all-zero): the write itself succeeds and the
> IPI at :12643 executes perf_mux_hrtimer_restart() ->
> hrtimer_forward_now() -> hrtimer_cb_get_time() on the remote CPU,
> which reads timer->base->clockid with timer->base == NULL (offset
> 0xc) in hardirq context.
>
>
> pmu_dev_is_visible() (core.c:12709) does not mask the interval
> attribute, and there is no lock common to the registrant (pmus_lock)
> and the sysfs callback.
>
>
> * Controlled-window evidence (deterministic, both fault forms)
>
>
> Stalling the registering thread briefly (kprobe on the first per-CPU
> cpc allocation for window A, on the first hrtimer_setup call for
> window B; a 400 ms stall, writer runs during it) produces exactly
> the predicted faults, nothing else:
>
>
> Window A:
> BUG: kernel NULL pointer dereference, address: 00000000000000f0
> #PF: supervisor write access in kernel mode
> RIP: 0010:perf_event_mux_interval_ms_store+0x18a/0x250
> (Code: ... <4d> 89 be f0 00 00 00 ... /* mov %r14,0xf0(%rsi) */)
>
>
> Window B:
> BUG: kernel NULL pointer dereference, address: 00000000000000c
> CPU: 0 ... Comm: swapper/0
> RIP: 0010:hrtimer_cb_get_time+0x1e/0x70
> __flush_smp_call_function_queue
> remote_function
> perf_mux_hrtimer_restart
> hrtimer_cb_get_time
> Kernel panic - not syncing: Fatal exception in interrupt
>
>
> The kprobe module used for the stalls is available on request; it is
> only a controlled-window amplifier and is NOT needed to hit the bug
> naturally (next section).

It looks a real issue. I suppose the changes below would fix the issue. The
changes only pass the building, not validated yet.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7cdd02dba4f1..e088c31534bc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12831,6 +12831,9 @@ perf_event_mux_interval_ms_store(struct device *dev,
        if (timer == pmu->hrtimer_interval_ms)
                return count;

+       if (!pmu->cpu_pmu_context)
+               return -ENODEV;
+
        mutex_lock(&mux_interval_mutex);
        pmu->hrtimer_interval_ms = timer;

@@ -13062,12 +13065,6 @@ int perf_pmu_register(struct pmu *_pmu, const char
*name, int type)
        pmu->type = pmu_type.id;
        atomic_set(&pmu->exclusive_cnt, 0);

-       if (pmu_bus_running && !pmu->dev) {
-               int ret = pmu_dev_alloc(pmu);
-               if (ret)
-                       return ret;
-       }
-
        pmu->cpu_pmu_context = alloc_percpu(struct perf_cpu_pmu_context *);
        if (!pmu->cpu_pmu_context)
                return -ENOMEM;
@@ -13086,6 +13083,12 @@ int perf_pmu_register(struct pmu *_pmu, const char
*name, int type)
                __perf_mux_hrtimer_init(cpc, cpu);
        }

+       if (pmu_bus_running && !pmu->dev) {
+               int ret = pmu_dev_alloc(pmu);
+               if (ret)
+                       return ret;
+       }
+
        if (!pmu->start_txn) {
                if (pmu->pmu_enable) {
                        /*



>
>
> * Natural reachability (no instrumentation)
>
>
> A minimal PMU driver registered/unregistered in a loop through the
> exported perf core API (same lifecycle as an unloadable PMU module
> or an Intel uncore PCI rebind), while userspace runs a tight loop
> writing the attribute as soon as it appears (alternating values, so
> every write passes the same-value fast path). On a 64-vCPU KASAN
> VM (7.3) the first slab-use-after-free appears ~0.6 s after the
> hammer starts (94 reports within the run; the writes that land late
> in the window successfully arm cpc->hrtimer and are then freed by
> the unregister of the same round -- that use-after-free in
> perf_pmu_free() is a separate defect I am reporting in its own
> mail). A fault dump in the same run shows the writer's path
> stopping exactly at perf_event_mux_interval_ms_store+0x18a, the
> same instruction as the controlled window-A witness. On 7.1.5 the
> same uninstrumented hammer also faulted naturally inside the store
> (dangling percpu array read at store+0x149).
>
>
> * Reproducer
>
> Module source inlined at the end of this mail; usage:
>
> # build against the kernel under test
> make -C <kernel-build-dir> M=$PWD modules
>
> # in the guest (root):
> insmod r4_repro.ko
> # terminal A: writer hammer
> while :; do
> F=/sys/bus/event_source/devices/r4pmu/perf_event_mux_interval_ms
> [ -e $F ] && { echo 100 > $F 2>/dev/null; echo 200 > $F 2>/dev/null; }
> done
> # terminal B:
> echo "regloop 400" > /sys/module/r4_repro/parameters/action
>
>
> Triggering requires a runtime PMU registration (unloadable PMU
> driver, uncore PCI rebind on matching hardware) plus a root writer
> (attribute mode 0644); the window is the registration interval
> (device_add done -> last cpc timer initialized), sub-millisecond to
> milliseconds per round, trivially hit by a write loop.
>
>
> * Additional symptom of the same window (functional, no memory fault)
>
>
> If the store lands between __perf_mux_hrtimer_init()'s "is the
> field unset" read and its default assignment (the default is
> PERF_CPU_HRTIMER = 1000/HZ; the assignment writes
> pmu->hrtimer_interval_ms), the PMU ends up with
> pmu->hrtimer_interval_ms == default while every cpc actually runs
> the user's value -- and because the store's same-value fast path
> returns early on an equal value, writing the field value back is a
> permanent no-op: the divergence cannot be repaired by re-writing
> the same number. Same fix point (normalize defaults before
> publication), so reported here rather than separately.
>
>
> Thanks for taking a look.
>
> Regards,
> Hanxiang Xu
> xuhx@hust.edu.cn
>
> ------------------------------------------------------------------------
> reproducer: r4_repro.c (build with: make -C <kernel-build-dir> M=$PWD
> modules; requires CONFIG_PERF_EVENTS=y and CONFIG_MODULES=y)
> ------------------------------------------------------------------------
> // SPDX-License-Identifier: GPL-2.0
> /*
> * r4_repro.c - minimal reproducer for the premature-sysfs-publication
> * NULL dereference in perf_event_mux_interval_ms_store()
> * (kernel/events/core.c).
> *
> * perf_pmu_register() publishes the PMU device and its sysfs attributes
> * (pmu_dev_alloc() -> device_add()) *before* allocating and installing the
> * per-CPU perf_cpu_pmu_context array and initializing each cpc's hrtimer.
> * A concurrent root write to perf_event_mux_interval_ms during that window
> * reaches:
> *
> * cpc = *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
> * cpc->hrtimer_interval = ...; <- NULL cpc => write to 0xf0
> *
> * or, one window later (cpc published, timer not yet initialized), the
> * restart IPI runs perf_mux_hrtimer_restart() on a zeroed hrtimer and
> * dereferences timer->base == NULL in hrtimer_forward_now().
> *
> * Usage (from userspace):
> *
> * insmod r4_repro.ko
> * # terminal A: writer hammer on the freshly (re)created sysfs node
> * while :; do
> * for F in /sys/bus/event_source/devices/r4pmu/perf_event_mux_interval_ms; do
> * [ -e $F ] && { echo 100 > $F 2>/dev/null; echo 200 > $F 2>/dev/null; }
> * done
> * done
> * # terminal B: registration churn through the exported perf core API
> * echo "regloop 400" > /sys/module/r4_repro/parameters/action
> *
> * Alternating values bypass the same-value fast path so every open of the
> * node performs a full store. On a KASAN kernel, a write landing inside
> * the window produces an immediate NULL-pointer oops in
> * perf_event_mux_interval_ms_store() (write fault at address 0xf0), or an
> * IRQ-context panic via perf_mux_hrtimer_restart() -> hrtimer_cb_get_time()
> * (NULL+0xc). Writes landing in a later part of the window succeed in
> * arming cpc->hrtimer and will surface as use-after-free reports when the
> * same registration round unregisters again (that is the related
> * perf_pmu_free() defect; see the report text).
> *
> * No kernel source modification: everything goes through the
> * EXPORT_SYMBOL_GPL perf core API, exactly like a real unloadable PMU
> * provider driver (e.g. Intel uncore PCI drivers via bind/unbind).
> */
> #define pr_fmt(fmt) "R4REPRO: " fmt
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/kthread.h>
> #include <linux/sched.h>
> #include <linux/delay.h>
> #include <linux/workqueue.h>
> #include <linux/perf_event.h>
> #include <linux/err.h>
> #include <linux/string.h>
> static struct pmu test_pmu;
> static int my_registered;
> static int test_type = -1;
> static unsigned long stat_reg_ok, stat_reg_fail, stat_unreg_ok, stat_unreg_fail;
> static int repro_event_init(struct perf_event *event)
> {
> if (event->attr.type != test_type)
> return -ENOENT;
> return 0;
> }
> static void repro_pmu_reset(void)
> {
> static const struct pmu tmpl = {
> .task_ctx_nr = perf_invalid_context,
> .module = THIS_MODULE,
> .capabilities = PERF_PMU_CAP_NO_INTERRUPT |
> PERF_PMU_CAP_NO_EXCLUDE,
> .event_init = repro_event_init,
> };
> test_pmu = tmpl;
> }
> static int do_register(void)
> {
> int ret;
> repro_pmu_reset();
> ret = perf_pmu_register(&test_pmu, "r4pmu", -1);
> if (ret) {
> stat_reg_fail++;
> my_registered = 0;
> } else {
> stat_reg_ok++;
> my_registered = 1;
> test_type = test_pmu.type;
> }
> return ret;
> }
> static int do_unregister(void)
> {
> int ret = -EINVAL;
> if (my_registered)
> ret = perf_pmu_unregister(&test_pmu);
> if (ret) {
> stat_unreg_fail++;
> } else {
> stat_unreg_ok++;
> my_registered = 0;
> }
> return ret;
> }
> static char action_cmd[64];
> static void action_workfn(struct work_struct *w)
> {
> char cmd[64];
> char *p, *cp;
> long n = 0;
> strscpy(cmd, strstrip(action_cmd), sizeof(cmd));
> cp = cmd;
> p = strsep(&cp, " ");
> if (cp && cp[0])
> if (kstrtol(cp, 0, &n))
> n = 0;
> if (!strcmp(p, "register")) {
> pr_info("register rc=%d type=%d\n", do_register(), test_type);
> } else if (!strcmp(p, "unregister")) {
> pr_info("unregister rc=%d\n", do_unregister());
> } else if (!strcmp(p, "regloop") && n > 0) {
> long i;
> for (i = 0; i < n; i++) {
> if (my_registered)
> do_unregister();
> do_register();
> usleep_range(0, 50);
> }
> pr_info("REGLOOP_DONE n=%ld reg_ok=%lu reg_fail=%lu unreg_ok=%lu unreg_fail=%lu\n",
> n, stat_reg_ok, stat_reg_fail, stat_unreg_ok,
> stat_unreg_fail);
> } else if (!strcmp(p, "status")) {
> pr_info("status registered=%d type=%d reg_ok=%lu reg_fail=%lu unreg_ok=%lu unreg_fail=%lu\n",
> my_registered, test_type, stat_reg_ok, stat_reg_fail,
> stat_unreg_ok, stat_unreg_fail);
> } else {
> pr_info("unknown action '%s'\n", p);
> }
> pr_info("ACTION_COMPLETE\n");
> }
> static DECLARE_WORK(action_work, action_workfn);
> static int action_set(const char *val, const struct kernel_param *kp)
> {
> int ret = param_set_copystring(val, kp);
> if (ret == 0)
> schedule_work(&action_work);
> return ret;
> }
> static const struct kernel_param_ops action_ops = {
> .set = action_set,
> .get = param_get_string,
> };
> static struct kparam_string action_param = {
> .maxlen = sizeof(action_cmd),
> .string = action_cmd,
> };
> module_param_cb(action, &action_ops, &action_param, 0200);
> MODULE_PARM_DESC(action, "register|unregister|regloop N|status");
> static int __init r4_repro_init(void)
> {
> repro_pmu_reset();
> pr_info("loaded; start the userspace writer hammer, then run regloop\n");
> return 0;
> }
> static void __exit r4_repro_exit(void)
> {
> cancel_work_sync(&action_work);
> if (my_registered)
> do_unregister();
> pr_info("unloaded\n");
> }
> module_init(r4_repro_init);
> module_exit(r4_repro_exit);
> MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("Minimal reproducer: premature sysfs publication NULL deref in perf_event_mux_interval_ms_store()");
