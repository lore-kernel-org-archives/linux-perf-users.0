Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C565C6FA8F
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbjH3Ube (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbjH3UbW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 16:31:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB0630E0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:15:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso126475ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693422829; x=1694027629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noX4yZdaLohQeeiEyvyLjmGW8lnsNXNGq5GJE9PggTY=;
        b=ej6ZlDygJnZHnqUMyb7rvbNQyM2VKu3HHWmEHZt0i8TVXF29NO5x4QuSK6Tl0L16sb
         zAcmwatPqGf/EV02wqs+3f8dTrlzCYDBw8+8bFrLlL/7yiz2z7jQPH/LoqFCEMW5DgYm
         t1u/OZsPMhKqfTW5rGu59PdK+6yB9UoIIG2J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693422829; x=1694027629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noX4yZdaLohQeeiEyvyLjmGW8lnsNXNGq5GJE9PggTY=;
        b=lzCfSR9miur2ejjuSnGaUxh9hXoC0mN1fXejHE0WsK4pK7yzIlO3A9PiwsAnzL7bMl
         qnXOGvXCa1Cr6wFtQOEfh1XGS0odgFTux16Mn3JT0gRUURuc3G8LslMy/XR2SuQoxb+v
         S1Z1IJYQXidrOndwlbso+niybaq9ZCvLdzNR4dMWICN8P7hdiBdKVTIzAZD9363cNe1w
         W7FrZH64eGaPwCIiy/welxJnAgkMSKRhqz1bJRsXCfi2Z9m9fO9rQDhhdCtuh/6d2bSx
         5021rj8Ugkj0LVX+14JNKSlm8c0dup30OkdbCSuqssU00n64Q/A+SLslADVpKrDB9UOm
         teqw==
X-Gm-Message-State: AOJu0YyAowVeOe+f9zeoLxmjVo2h6NswrQo1x4CAUiBA4uXnsjW9TF3D
        XKyladqSxYLlkfTzZ0J/w/0+ng==
X-Google-Smtp-Source: AGHT+IGdb5Mb2GxsmI1BOhJNHIBP+oW3B+qOgeklBIYfkq+/l/caGuTOikwQNy7fuKfgn5kIZmdgGA==
X-Received: by 2002:a17:902:ef93:b0:1b7:e49f:1d with SMTP id iz19-20020a170902ef9300b001b7e49f001dmr3090765plb.62.1693422829677;
        Wed, 30 Aug 2023 12:13:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e315:dec6:467c:83c5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bbdf32f011sm11338928plg.269.2023.08.30.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 6/7] arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI roundup
Date:   Wed, 30 Aug 2023 12:11:27 -0700
Message-ID: <20230830121115.v12.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
References: <20230830191314.1618136-1-dianders@chromium.org>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
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
index 800c59cf9b64..1a53e57c81d0 100644
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
2.42.0.283.g2d96d420d3-goog

