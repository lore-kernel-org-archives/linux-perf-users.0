Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6A22F7AC1;
	Wed, 10 Jun 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093183; cv=none; b=qZWDuoSoL3DbXk9Z0Bi/534gcIIfORt/wRPgWJaX7jLlkVQ9SARAIQ7oDkfrqFpfMhCmAjrjksISxodqzU/G7aVP0L0vKx31orHhbNzcMOXCHYPDT5xpQZ6QLbyb46HP2RHt/apV46S+R6pNiMyguqGFqbLnWpASblDalrSyeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093183; c=relaxed/simple;
	bh=rujJyszYoZxVBuShIVSfJhMxKgJGNFD4xe3puWtSQTM=;
	h=Message-Id:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=jCAkW5Yem67DM11aAI9U/J8ME4HTdi35ZjOvEL/xuxCxPNRbSJvJBSH0egqoaHKxYpz7UoC9fT7+7Lb/+S0sTq+CgfjPXyhKx74OIm+Pnf09riLCzMbeMtPUP6aK8iwXVt5pfBqzGVL3/iLJ4fjoE9fxckRMdjR8IKeGgsx5u4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gb4Hm650pz5B13W;
	Wed, 10 Jun 2026 20:06:12 +0800 (CST)
Received: (from root@localhost)
	by mse-fl1.zte.com.cn id 65AC69UA050105;
	Wed, 10 Jun 2026 20:06:09 +0800 (+08)
	(envelope-from yang.susheng@zte.com.cn)
Message-Id: <202606101206.65AC69UA050105@mse-fl1.zte.com.cn>
Received: from njb2app05.zte.com.cn ([10.55.22.121])
	by mse-fl2.zte.com.cn with SMTP id 65AAenpW033653;
	Wed, 10 Jun 2026 18:40:49 +0800 (+08)
	(envelope-from yang.susheng@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid201;
	Wed, 10 Jun 2026 18:40:51 +0800 (CST)
X-Zmail-TransId: 2af96a293f33401-d5197
X-Mailer: Zmail v1.0
Date: Wed, 10 Jun 2026 18:40:51 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <yang.susheng@zte.com.cn>
To: <zhangzhanpeng.jasper@bytedance.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <conor@kernel.org>, <cleger@rivosinc.com>, <himanshu@thechauhan.dev>,
        <will@kernel.org>, <mark.rutland@arm.com>, <atish.patra@linux.dev>,
        <anup@brainfault.org>, <shuah@kernel.org>, <cuiyunhui@bytedance.com>,
        <yuanzhu@bytedance.com>, <zhangzhanpeng.jasper@bytedance.com>,
        <liu.xuemei1@zte.com.cn>, <zhang.anmeng@zte.com.cn>,
        <gao.rui@zte.com.cn>, <tan.hu@zte.com.cn>, <jin.qi@zte.com.cn>,
        <li.zhichao@zte.com.cn>, <jia.yunxiang@zte.com.cn>,
        <dai.hualiang@zte.com.cn>, <liu.qingtao2@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2OSA0LzVdIHBlcmY6IFJJU0MtVjogYWRkIHN1cHBvcnQgZm9yIFNTRSBldmVudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65AC69UA050105
X-MSS: AUDITRELEASE@mse-fl1.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: yang.susheng@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 10 Jun 2026 20:06:12 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A295334.000/4gb4Hm650pz5B13W

Hi Zhanpeng,

> 
> In order to use SSE within PMU drivers, register an SSE handler for the
> local PMU event. Reuse the existing overflow IRQ handler and pass
> appropriate pt_regs. Add a config option RISCV_PMU_SBI_SSE to select event
> delivery via SSE events.
> 
> When the SSE path is used, also honor the return value from
> perf_event_overflow(). If perf core throttles or disables an event, do not
> immediately restart the overflowed counters from the SSE handler.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> Co-developed-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> ---
>  drivers/perf/Kconfig           | 10 +++++
>  drivers/perf/riscv_pmu.c       | 23 +++++++++++
>  drivers/perf/riscv_pmu_sbi.c   | 78 ++++++++++++++++++++++++++++++++-----
>  include/linux/perf/riscv_pmu.h |  5 +++
>  4 files changed, 104 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index ab90932fc2d0..b6c58475091c 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -105,6 +105,16 @@ config RISCV_PMU_SBI
>  	  full perf feature support i.e. counter overflow, privilege mode
>  	  filtering, counter configuration.
>  
> +config RISCV_PMU_SBI_SSE
> +	depends on RISCV_PMU && RISCV_SBI_SSE
> +	bool "RISC-V PMU SSE events"
> +	default n
> +	help
> +	  Say y if you want to use SSE events to deliver PMU interrupts. This
> +	  provides a way to profile the kernel at any level by using NMI-like
> +	  SSE events. Since SSE events can be intrusive, this option allows
> +	  selecting them only when needed.
> +
>  config STARFIVE_STARLINK_PMU
>  	depends on ARCH_STARFIVE || COMPILE_TEST
>  	depends on 64BIT
> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> index 8e3cd0f35336..a48e286d9394 100644
> --- a/drivers/perf/riscv_pmu.c
> +++ b/drivers/perf/riscv_pmu.c
> @@ -13,6 +13,7 @@
>  #include <linux/irqdesc.h>
>  #include <linux/perf/riscv_pmu.h>
>  #include <linux/printk.h>
> +#include <linux/riscv_sbi_sse.h>
>  #include <linux/smp.h>
>  #include <linux/sched_clock.h>
>  
> @@ -254,6 +255,24 @@ void riscv_pmu_start(struct perf_event *event, int flags)
>  	perf_event_update_userpage(event);
>  }
>  
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +static void riscv_pmu_disable(struct pmu *pmu)
> +{
> +	struct riscv_pmu *rvpmu = to_riscv_pmu(pmu);
> +
> +	if (rvpmu->sse_evt)
> +		sse_event_disable_local(rvpmu->sse_evt);
> +}
> +
> +static void riscv_pmu_enable(struct pmu *pmu)
> +{
> +	struct riscv_pmu *rvpmu = to_riscv_pmu(pmu);
> +
> +	if (rvpmu->sse_evt)
> +		sse_event_enable_local(rvpmu->sse_evt);
> +}
> +#endif
> +
>  static int riscv_pmu_add(struct perf_event *event, int flags)
>  {
>  	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
> @@ -411,6 +430,10 @@ struct riscv_pmu *riscv_pmu_alloc(void)
>  		.event_mapped	= riscv_pmu_event_mapped,
>  		.event_unmapped	= riscv_pmu_event_unmapped,
>  		.event_idx	= riscv_pmu_event_idx,
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +		.pmu_enable	= riscv_pmu_enable,
> +		.pmu_disable	= riscv_pmu_disable,
> +#endif
>  		.add		= riscv_pmu_add,
>  		.del		= riscv_pmu_del,
>  		.start		= riscv_pmu_start,
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 385af5e6e6d0..ac10ebd73c7c 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -17,6 +17,7 @@
>  #include <linux/irqdomain.h>
>  #include <linux/of_irq.h>
>  #include <linux/of.h>
> +#include <linux/riscv_sbi_sse.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/sched/clock.h>
>  #include <linux/soc/andes/irq.h>
> @@ -1038,10 +1039,10 @@ static void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>  		pmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
>  }
>  
> -static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
> +static irqreturn_t pmu_sbi_ovf_handler(struct cpu_hw_events *cpu_hw_evt,
> +				       struct pt_regs *regs, bool from_sse)
>  {
>  	struct perf_sample_data data;
> -	struct pt_regs *regs;
>  	struct hw_perf_event *hw_evt;
>  	union sbi_pmu_ctr_info *info;
>  	int lidx, hidx, fidx;
> @@ -1049,7 +1050,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	struct perf_event *event;
> +	int ev_overflow = 0;
>  	u64 overflow;
>  	u64 overflowed_ctrs = 0;
> -	struct cpu_hw_events *cpu_hw_evt = dev;
>  	u64 start_clock = sched_clock();
>  	struct riscv_pmu_snapshot_data *sdata = cpu_hw_evt->snapshot_addr;
>  
> @@ -1059,13 +1059,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  	/* Firmware counter don't support overflow yet */
>  	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
>  	if (fidx == RISCV_MAX_COUNTERS) {
> -		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
> +		if (!from_sse)
> +			csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
>  		return IRQ_NONE;
>  	}
>  
>  	event = cpu_hw_evt->events[fidx];
>  	if (!event) {
> -		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
> +		if (!from_sse)
> +			ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
>  		return IRQ_NONE;
>  	}
>  
> @@ -1080,16 +1082,16 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  
>  	/*
>  	 * Overflow interrupt pending bit should only be cleared after stopping
> -	 * all the counters to avoid any race condition.
> +	 * all the counters to avoid any race condition. When using SSE,
> +	 * interrupt is cleared when stopping counters.
>  	 */
> -	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
> +	if (!from_sse)
> +		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
>  
>  	/* No overflow bit is set */
>  	if (!overflow)
>  		return IRQ_NONE;
>  
> -	regs = get_irq_regs();
> -
>  	for_each_set_bit(lidx, cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS) {
>  		struct perf_event *event = cpu_hw_evt->events[lidx];
>  
> @@ -1133,18 +1136,65 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>  			 * TODO: We will need to stop the guest counters once
>  			 * virtualization support is added.
>  			 */
> -			perf_event_overflow(event, &data, regs);
> +			ev_overflow |= perf_event_overflow(event, &data, regs);
>  		}
>  		/* Reset the state as we are going to start the counter after the loop */
>  		hw_evt->state = 0;
>  	}
>  
> -	pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +	if (!ev_overflow || !from_sse)
> +		pmu_sbi_start_overflow_mask(pmu, overflowed_ctrs);
> +
>  	perf_sample_event_took(sched_clock() - start_clock);
>  
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t pmu_sbi_ovf_irq_handler(int irq, void *dev)
> +{
> +	return pmu_sbi_ovf_handler(dev, get_irq_regs(), false);
> +}
> +
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +static int pmu_sbi_ovf_sse_handler(u32 evt, void *arg, struct pt_regs *regs)
> +{
> +	struct cpu_hw_events __percpu *hw_events = arg;
> +	struct cpu_hw_events *hw_event = raw_cpu_ptr(hw_events);
> +
> +	pmu_sbi_ovf_handler(hw_event, regs, true);
> +
> +	return 0;
> +}
> +
> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
> +{
> +	int ret;
> +	struct sse_event *evt;
> +	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
> +
> +	evt = sse_event_register(SBI_SSE_EVENT_LOCAL_PMU_OVERFLOW, 0,
> +				 pmu_sbi_ovf_sse_handler, hw_events);
> +	if (IS_ERR(evt))
> +		return PTR_ERR(evt);
> +
> +	ret = sse_event_enable(evt);
> +	if (ret) {
> +		sse_event_unregister(evt);
> +		return ret;
> +	}
> +
> +	pr_info("using SSE for PMU event delivery\n");
> +	pmu->sse_evt = evt;
> +
> +	return ret;
> +}
> +#else
> +static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>  static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
> @@ -1195,6 +1242,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
>  	struct irq_domain *domain = NULL;
>  
> +	ret = pmu_sbi_setup_sse(pmu);
> +	if (!ret)
> +		return 0;
> +
>  	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
>  		riscv_pmu_irq_num = RV_IRQ_PMU;
>  		riscv_pmu_use_irq = true;
> @@ -1229,7 +1280,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
>  		return -ENODEV;
>  	}
>  
> -	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_handler, "riscv-pmu", hw_events);
> +	ret = request_percpu_irq(riscv_pmu_irq, pmu_sbi_ovf_irq_handler, "riscv-pmu", hw_events);
>  	if (ret) {
>  		pr_err("registering percpu irq failed [%d]\n", ret);
>  		return ret;
> diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
> index f82a28040594..08fdcf6baf4e 100644
> --- a/include/linux/perf/riscv_pmu.h
> +++ b/include/linux/perf/riscv_pmu.h
> @@ -28,6 +28,8 @@
>  
>  #define RISCV_PMU_CONFIG1_GUEST_EVENTS 0x1
>  
> +struct sse_event;
> +
>  struct cpu_hw_events {
>  	/* currently enabled events */
>  	int			n_events;
> @@ -54,6 +56,9 @@ struct riscv_pmu {
>  	char		*name;
>  
>  	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
> +#ifdef CONFIG_RISCV_PMU_SBI_SSE
> +	struct sse_event *sse_evt;
> +#endif
>  
>  	unsigned long	cmask;
>  	u64		(*ctr_read)(struct perf_event *event);
> -- 
> 2.50.1 (Apple Git-155)

We found that if RISCV_PMU_SBI_SSE is enabled, executing 'perf record -g 
-F 999 ls' may occasionally fail. If the program is more complex, the 
error occurs 100% of the time. After disabling RISCV_PMU_SBI_SSE, the 
program runs normally. Therefore, we suspect there may be an issue with 
the PMU_SBI_SSE functionality. Have you encountered this phenomenon? Do 
you have any troubleshooting suggestions?
Below are some fault information：
[root@localhost ~]# perf record -g -F 999 ls
[ 9478.867438] BUG: spinlock bad magic on CPU#2, ls/1046
[ 9478.871534] Unable to handle kernel paging request at virtual address ffffffc6004940d0
[ 9478.872804] Oops [#1]
[ 9478.873359] Modules linked in: xt_MASQUERADE xfrm_user xfrm_algo iptable_nat xt_addrtype
iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c br_netfilter bridge stp llc overlay virtio_gpu virtio_dma_buf drm_shmem_helper
drm_client_lib drm_kms_helper nls_iso8859_1 drm drm_panel_orientation_quirks backlight configfs efivarfs
[ 9478.877513] CPU: 2 UID: 0 PID: 1046 Comm: ls Not tainted 6.13.0-00006-ge94d0b11d044-dirty #7
[ 9478.878544] Hardware name: QEMU QEMU Virtual Machine, BIOS 2.7 2/2/2022
[ 9478.879324] epc : string+0x48/0xe6
[ 9478.880100]  ra : vsnprintf+0xea/0x3b4
[ 9478.880697] epc : ffffffff809e39ae ra : ffffffff809e656e sp : ffffffc600493360
[ 9478.881331]  gp : ffffffff81516480 tp : ffffffd68d280000 t0 : ffffffc600493312
[ 9478.881952]  t1 : ffffffffffffffff t2 : 6e697073203a4755 s0 : ffffffc6004933a0
[ 9478.882557]  s1 : ffffffffffffffff a0 : ffffffc6004934d7 a1 : 0000000000000000
[ 9478.883355]  a2 : ffffffc6004934a8 a3 : ffffffc6004930d0 a4 : ffffffc6004940d0
[ 9478.883988]  a5 : ffffffc7004934d6 a6 : ffffffffffffe000 a7 : 0000000000000004
[ 9478.884600]  s2 : ffffffc6004934d7 s3 : ffffffc6004934a8 s4 : ffffffff80f24ea4
[ 9478.885420]  s5 : ffffffff000000ff s6 : ffffffff8100153e s7 : 0000000000ffffff
[ 9478.886056]  s8 : ffffffff8100153c s9 : 0000000000000007 s10: 0000000000000002
[ 9478.886859]  s11: ffffffc6004935f0 t3 : 0000000000000004 t4 : ffffffff80e592d8
[ 9478.887493]  t5 : ffffffff8152cb20 t6 : ffffffc60049307a
[ 9478.887946] status: 0000000200000100 badaddr: ffffffc6004940d0 cause: 000000000000000d
[ 9478.888886] [<ffffffff809e39ae>] string+0x48/0xe6
[ 9478.889342] [<ffffffff809e656e>] vsnprintf+0xea/0x3b4
[ 9478.889795] [<ffffffff8007c2ce>] vprintk_store+0x108/0x3d2
[ 9478.890459] [<ffffffff8007d0ce>] vprintk_emit+0x82/0x218
[ 9478.890932] [<ffffffff8007d27a>] vprintk_default+0x16/0x1e
[ 9478.891416] [<ffffffff8007e270>] vprintk+0x1e/0x3c
[ 9478.892011] [<ffffffff8000332a>] _printk+0x32/0x50
[ 9478.892441] [<ffffffff80002f84>] spin_dump+0x5e/0x6e
[ 9478.892865] [<ffffffff80077bf4>] do_raw_spin_unlock+0x130/0x132
[ 9478.893542] [<ffffffff809f50e0>] _raw_spin_unlock+0x10/0x22
[ 9478.894031] [<ffffffff80166118>] filemap_map_pages+0x314/0x434
[ 9478.894541] [<ffffffff8019f6ea>] __handle_mm_fault+0x9ac/0xd50
[ 9478.895556] Code: 97aa a809 7463 00c5 0023 00d5 0505 2585 0663 00f5 (4683) 0007 
[ 9478.896729] ---[ end trace 0000000000000000 ]---
[ 9478.897637] note: ls[1046] exited with irqs disabled
[ 9478.898653] note: ls[1046] exited with preempt_count 4

[root@localhost x264]# perf record -g -F 999 ./x264 -o output_static.mkv ./Kimono_1920x1080_24.yuv
--input-res 1920x1080 --fps 24 --preset faster --vbv-maxrate 2400 --vbv-bufsize 4800 --ref 1
--aq-mode 2 --aq-strength 1.2 --qcomp 0.8 --lookahead-threads 12 --ipratio 1.0 --bframes 3
--rc-lookahead 6 --crf 28 --keyint 60 --scenecut 0 --frames 200                                                                                                      
[   63.382672] Unable to handle kernel paging request at virtual address 0000003feb0ff5d8                                                               
[   63.383325] Oops [#1]                                                                                                                                
[   63.383395] Modules linked in: xt_MASQUERADE xfrm_user xfrm_algo iptable_nat xt_addrtype
iptable_filter ip_tables xt_conntrack x_tables nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
libcrc32c br_netfilter bridge stp llc overlay virtio_gpu virtio_dma_buf drm_shmem_helper
drm_client_lib drm_kms_helper nls_iso8859_1 drm configfs drm_panel_orientation_quirks
backlight efivarfs                                                                          
[   63.385401] CPU: 3 UID: 0 PID: 580 Comm: x264 Not tainted 6.13.0-00006-ge94d0b11d044-dirty #7                                                
[   63.385521] Hardware name: QEMU QEMU Virtual Machine, BIOS 2.7 2/2/2022                                                                              
[   63.385732] epc : walk_stackframe+0x5c/0x11a                                                                                                         
[   63.386470]  ra : walk_stackframe+0xda/0x11a                                                                                                         
[   63.386537] epc : ffffffff80013b5c ra : ffffffff80013bda sp : ffffffc600493a40                                                                       
[   63.386579]  gp : ffffffff81516480 tp : ffffffd684b33300 t0 : ffffffd7febf9c20                                                                       
[   63.386617]  t1 : 000000003b9aca00 t2 : ffffffd7febe8080 s0 : ffffffc600493a90                                                                       
[   63.386654]  s1 : ffffffc600493ee0 a0 : 0000000000000001 a1 : ffffffff809f5a48                                                                       
[   63.386692]  a2 : 0000000000000002 a3 : 0000003feb0ff5d0 a4 : ffffffffffffc000                                                                       
[   63.386729]  a5 : 0000000000003fff a6 : ffffffff81552558 a7 : ffffffd698fb8000
[   63.386769]  s2 : 0000003feb100000 s3 : 0000003feb0ff5e0 s4 : ffffffff8001886a
[   63.386806]  s5 : ffffffc600493ac0 s6 : ffffffff809f5a48 s7 : 0000000000000000
[   63.386844]  s8 : ffffffc600493ac0 s9 : 0000000000000000 s10: 000000000007fff8
[   63.386886]  s11: ffffffd698fb8000 t3 : 0000000000000015 t4 : 00000000000003e7
[   63.386932]  t5 : 0000000000452bf5 t6 : ffffffc600493f70
[   63.386965] status: 0000000200000100 badaddr: 0000003feb0ff5d8 cause: 000000000000000d
[   63.387069] [<ffffffff80013b5c>] walk_stackframe+0x5c/0x11a
[   63.387122] [<ffffffff80018902>] perf_callchain_kernel+0x28/0x34
[   63.387154] [<ffffffff80160294>] get_perf_callchain+0x88/0x18e
[   63.387189] [<ffffffff8015bcf2>] perf_callchain+0x52/0x6e
[   63.387219] [<ffffffff8015c0f4>] perf_prepare_sample+0x3e6/0x730
[   63.387249] [<ffffffff8015c8d6>] perf_event_output_forward+0x56/0xb8
[   63.387280] [<ffffffff8015c51a>] __perf_event_overflow+0xdc/0x2e2
[   63.387310] [<ffffffff8015d954>] perf_event_overflow+0x12/0x1a
[   63.387341] [<ffffffff807e15e0>] pmu_sbi_ovf_handler+0x684/0x736
[   63.387383] [<ffffffff807e16ee>] pmu_sbi_ovf_sse_handler+0x26/0x30
[   63.387417] [<ffffffff807b73a0>] sse_handle_event+0x16/0x48
[   63.387449] [<ffffffff8001933a>] do_sse+0x76/0xa8
[   63.387478] [<ffffffff800195ac>] handle_sse+0xc0/0x162
[   63.387748] Code: 7933 00e9 6463 0539 f693 0079 e2a1 e062 8693 ff09 (bc03) 0086 
[   63.388072] ---[ end trace 0000000000000000 ]---
[   63.388547] Kernel panic - not syncing: Fatal exception in interrupt
[   63.388870] SMP: stopping secondary CPUs

Regards
Yangsusheng
