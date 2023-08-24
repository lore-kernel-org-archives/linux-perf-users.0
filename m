Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EDBC83003
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Aug 2023 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbjHXPdm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbjHXPdP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 11:33:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FC410C3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 08:33:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68bec3a81c4so3284b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692891193; x=1693495993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpvKkEI/e7qDOTO7kkwnbGAWQL/h1j/QJekiYZuCdi8=;
        b=Eqf7ZSxJom24lSCPPItZp0Jzzsgydj3wjWNxBG8UNQBsegWpHjaQtL61A3HiBfuCSo
         J6ml8OZW3onJcqmoTMruSdhqZm2KlF9FZfDEflnZQcMt0G9ngDavylngBuvI7gJwipef
         +GFSyITHnIR+HkAukdoTDl81UHsm3QEZjrhug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692891193; x=1693495993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpvKkEI/e7qDOTO7kkwnbGAWQL/h1j/QJekiYZuCdi8=;
        b=gFss70FICfhXDVeeiU7NVe46HXY1OAmp7uJadp1S8mqklTDHhMIUT+aeNVrITEgzxk
         jKI+DyYNIUM7H6TrRpT44oamB3fzZvmaQetyzOCf8svfHctynKq+z7ZuEBvdJ/vABfON
         d7SW9E4kfGuBYu+MpUoJuVFub51vO5jslQcvOTyida+JGXb/vHsuwY31YKSoukrt+m+D
         ZfkPAl0PYJ82qGGHzTMB62+vUiLUnD0Dsq9y6ankVzXOfhh9wAJzfS8U+1lB5o633vye
         puILkeVjWxEVUghctPtGCRd0eIy7D3ajat7dV9hKP3XhR2LV4WVbXD+uxcouy5PrNIan
         XfZA==
X-Gm-Message-State: AOJu0Yz4NpwCYrVyUbGb34oQivvtaYzgRjq6U8m43wqW6NteiDlA/S7R
        Qx3Ca9Kg8dcAV5fPl1nMAi+2/A==
X-Google-Smtp-Source: AGHT+IH3Wlo4UhfEjU/WdEk/Y/44LnzFs3Gaq+1amqWxjKrBJ8EosqQauQzhM/dQC7jvUfImtbjO5A==
X-Received: by 2002:a05:6a00:ccd:b0:68a:45a1:c0f7 with SMTP id b13-20020a056a000ccd00b0068a45a1c0f7mr20902029pfv.8.1692891192681;
        Thu, 24 Aug 2023 08:33:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:afa3:fcf5:1b7f:f7e2])
        by smtp.gmail.com with ESMTPSA id m30-20020a63711e000000b0056365ee8603sm11631337pgc.67.2023.08.24.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:33:12 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 6/6] arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI roundup
Date:   Thu, 24 Aug 2023 08:30:32 -0700
Message-ID: <20230824083012.v11.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824153233.1006420-1-dianders@chromium.org>
References: <20230824153233.1006420-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Up until now we've been using the generic (weak) implementation for
kgdb_roundup_cpus() when using kgdb on arm64. Let's move to a custom
one. The advantage here is that, when pseudo-NMI is enabled on a
device, we'll be able to round up CPUs using pseudo-NMI. This allows
us to debug CPUs that are stuck with interrupts disabled. If
pseudo-NMIs are not enabled then we'll fallback to just using an IPI,
which is still slightly better than the generic implementation since
it avoids the potential situation described in the generic
kgdb_call_nmi_hook().

Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I debated whether this should be in "arch/arm64/kernel/smp.c" or if I
should try to find a way for it to go into "arch/arm64/kernel/kgdb.c".
In the end this is so little code that it didn't seem worth it to find
a way to export the IPI defines or to otherwise come up with some API
between kgdb.c and smp.c. If someone has strong feelings and wants
this to change, please shout and give details of your preferred
solution.

FWIW, it seems like ~half the other platforms put this in "smp.c" with
an ifdef for KGDB and the other half put it in "kgdb.c" with an ifdef
for SMP. :-P

(no changes since v10)

Changes in v10:
- Don't allocate the cpumask on the stack; just iterate.
- Moved kgdb calls to smp.c to avoid needing to export IPI info.
- kgdb now has its own IPI.

Changes in v9:
- Remove fallback for when debug IPI isn't available.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.

 arch/arm64/kernel/smp.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4566934aaf9f..d440c8b21ea7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -32,6 +32,7 @@
 #include <linux/irq_work.h>
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
+#include <linux/kgdb.h>
 #include <linux/kvm_host.h>
 #include <linux/nmi.h>
 
@@ -79,6 +80,7 @@ enum ipi_msg_type {
 	 * with trace_ipi_*
 	 */
 	IPI_CPU_BACKTRACE = NR_IPI,
+	IPI_KGDB_ROUNDUP,
 	MAX_IPI
 };
 
@@ -868,6 +870,22 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
 	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
 }
 
+#ifdef CONFIG_KGDB
+void kgdb_roundup_cpus(void)
+{
+	int this_cpu = raw_smp_processor_id();
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		/* No need to roundup ourselves */
+		if (cpu == this_cpu)
+			continue;
+
+		__ipi_send_single(ipi_desc[IPI_KGDB_ROUNDUP], cpu);
+	}
+}
+#endif
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -919,6 +937,10 @@ static void do_handle_IPI(int ipinr)
 		nmi_cpu_backtrace(get_irq_regs());
 		break;
 
+	case IPI_KGDB_ROUNDUP:
+		kgdb_nmicallback(cpu, get_irq_regs());
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -949,6 +971,7 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 	case IPI_CPU_STOP:
 	case IPI_CPU_CRASH_STOP:
 	case IPI_CPU_BACKTRACE:
+	case IPI_KGDB_ROUNDUP:
 		return true;
 	default:
 		return false;
-- 
2.42.0.rc1.204.g551eb34607-goog

