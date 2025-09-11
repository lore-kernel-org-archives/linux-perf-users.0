Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361B19A;
	Thu, 11 Sep 2025 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551580; cv=none; b=MBVxsQN+f4wy8Xsptm2abYJw7bmK1DnRkfZylJwKsRqub5A4Ukqb7G3tF5ciRryBWIGCDgfMcWoLt5kYEYqUzYAYedKp84i0GdcvZSVUCBGA3KvYKlOoWmwDkJRTIVT+ZhNwdzRfMj9grlDFmdD+XvWP3USl6IsDZJxmjTE5WfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551580; c=relaxed/simple;
	bh=K99ophOl9mX3e/X5pRAQo+wrGNH1h9Nn1UThydP/v4k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L/mfkZknNtdZkQCGLM+bMzrjvqfbY/R/SAvn2HgfOHwpUcyeyvJVcoINitJygUirJl0Q254252Zmg47DY0wsFfT8Rx+uhwisQwKA8t3OwCQpJkwnurW8tgGX4nyj+uE+G1rQUCsh3r/vC3dUXeVOLm0tOtDeljGjfpPyGvpdFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QB8At8RC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QB8At8RC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1598C4CEEB;
	Thu, 11 Sep 2025 00:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551578;
	bh=K99ophOl9mX3e/X5pRAQo+wrGNH1h9Nn1UThydP/v4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QB8At8RCA1dKGbJGXAjAsWM+cwkq9bWk1fm7K3sJG7vxNVKP6xSSvUurBGZQunMNl
	 0btZsSMe1585w9cxhhmI5GHyWBASKD0Q4vMXuOBuUF017rMfS6ktJFxpWz0HVxJGnU
	 y5dLcJdIDuyFsXsEX5KJdbhpsqRaOJr/F+oB/bidzfW9QlCItd26fNhQmDnfZMJpFW
	 NMrEb7LGYzujvb/h6RaJtJoASDh2u7mhKUkSOhpdgvEQSnpYSkziJp4RAGYhbclueg
	 PlYDR7Q2pWHfKj+AJMSvtMw+Q7ukA7O+IOYYTN6mIWK9FFEaGaYjjQn/PS6X/l/nrs
	 NT3rQC8fJJ5OA==
Date: Thu, 11 Sep 2025 09:46:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Mike Rapoport <rppt@kernel.org>, "Naveen N . Rao"
 <naveen@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander
 Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com, "David S. Miller"
 <davem@davemloft.net>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/19] x86/hw_breakpoint: introduce
 arch_reinstall_hw_breakpoint() for atomic context
Message-Id: <20250911094609.5f30e9767ffc3040068ed052@kernel.org>
In-Reply-To: <20250910052335.1151048-2-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
	<20250910052335.1151048-2-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jinchao,

On Wed, 10 Sep 2025 13:23:10 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> Introduce arch_reinstall_hw_breakpoint() to update hardware breakpoint
> parameters (address, length, type) without freeing and reallocating the
> debug register slot.
> 
> This allows atomic updates in contexts where memory allocation is not
> permitted, such as kprobe handlers.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  arch/x86/include/asm/hw_breakpoint.h |  1 +
>  arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index 0bc931cd0698..bb7c70ad22fe 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
>  
>  
>  int arch_install_hw_breakpoint(struct perf_event *bp);
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp);
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>  void hw_breakpoint_pmu_read(struct perf_event *bp);
>  void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index b01644c949b2..89135229ed21 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	return 0;
>  }
>  
> +/*
> + * Reinstall a hardware breakpoint on the current CPU.
> + *
> + * This function is used to re-establish a perf counter hardware breakpoint.
> + * It finds the debug address register slot previously allocated for the
> + * breakpoint and re-enables it by writing the address to the debug register
> + * and setting the corresponding bits in the debug control register (DR7).
> + *
> + * It is expected that the breakpoint's event context lock is already held
> + * and interrupts are disabled, ensuring atomicity and safety from other
> + * event handlers.
> + */
> +int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	unsigned long *dr7;
> +	int i;
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	for (i = 0; i < HBP_NUM; i++) {
> +		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> +
> +		if (*slot == bp)
> +			break;
> +	}
> +
> +	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
> +		return -EINVAL;
> +
> +	set_debugreg(info->address, i);
> +	__this_cpu_write(cpu_debugreg[i], info->address);
> +
> +	dr7 = this_cpu_ptr(&cpu_dr7);
> +	*dr7 |= encode_dr7(i, info->len, info->type);
> +
> +	/*
> +	 * Ensure we first write cpu_dr7 before we set the DR7 register.
> +	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
> +	 */
> +	barrier();
> +
> +	set_debugreg(*dr7, 7);
> +	if (info->mask)
> +		amd_set_dr_addr_mask(info->mask, i);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);

Please do not expose the arch dependent symbol. Instead, you should
expose an arch independent wrapper.

Anyway, you also need to share the same code with arch_install_hw_breakpoint()
like below;

Thanks,


diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 89135229ed21..2f3c5406999e 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -84,6 +84,28 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 	return (dr7 >> (bpnum * DR_ENABLE_SIZE)) & 0x3;
 }
 
+static void __arch_install_hw_breakpoint(struct perf_event *bp, int regno)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long *dr7;
+
+	set_debugreg(info->address, regno);
+	__this_cpu_write(cpu_debugreg[i], info->address);
+
+	dr7 = this_cpu_ptr(&cpu_dr7);
+	*dr7 |= encode_dr7(i, info->len, info->type);
+
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	set_debugreg(*dr7, 7);
+	if (info->mask)
+		amd_set_dr_addr_mask(info->mask, i);
+}
+
 /*
  * Install a perf counter breakpoint.
  *
@@ -95,8 +117,6 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
  */
 int arch_install_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
 	int i;
 
 	lockdep_assert_irqs_disabled();
@@ -113,22 +133,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
 		return -EBUSY;
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
-
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
-
-	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
-
-	set_debugreg(*dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
-
+	__arch_install_hw_breakpoint(bp, i);
 	return 0;
 }
 
@@ -146,8 +151,6 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
  */
 int arch_reinstall_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
 	int i;
 
 	lockdep_assert_irqs_disabled();
@@ -162,22 +165,7 @@ int arch_reinstall_hw_breakpoint(struct perf_event *bp)
 	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
 		return -EINVAL;
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
-
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
-
-	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
-
-	set_debugreg(*dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
-
+	__arch_install_hw_breakpoint(bp, i);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
