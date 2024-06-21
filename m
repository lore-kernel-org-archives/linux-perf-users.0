Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CCA14D449;
	Fri, 21 Jun 2024 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955558; cv=none; b=lYMujcPX+C0vPZ0Yh86NeYLyDRs/Tg5QZoiznFZ4Ar9Av9/NOBjvu6eU3OrPkaLduerGsno9mvpqOHRpu1MC3gf7q5URsA/nwDAu0h1d99R54A5itmipEDH1TAvvqAk0pE03J6OfKpXfQCfSHaqdMcuH3JmYt6Sdoi3rTVxXTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955558; c=relaxed/simple;
	bh=fny5qmN5Zof2ylj9b+oRQj/l3DHFhHzzbmYllH4d2Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZlOzO9w/ctDuly4VoceXS4BGOTeJMl3Yk1UpZHKk7jCp3gZ99O+9knYNmaA1jKYQUw9YFebCGY3+bfReW9ahKB0KUimANSssPtdeF4nrQs4L4U43n+sKpWn3z6rJjzsVgM26lrFDy6/oiwj9GHLtECU82cGGlPzyuUEYBmNeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx2OkhLnVmlcsIAA--.23038S3;
	Fri, 21 Jun 2024 15:39:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMcfLnVmIjgrAA--.39322S3;
	Fri, 21 Jun 2024 15:39:12 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] perf: Add perf_event_attr::bp_priv
Date: Fri, 21 Jun 2024 15:39:08 +0800
Message-ID: <20240621073910.8465-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240621073910.8465-1-yangtiezhu@loongson.cn>
References: <20240621073910.8465-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPMcfLnVmIjgrAA--.39322S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1DAr1fZF45Cw13Gw47KFX_yoW8WFyrpr
	ZrZrn5K3y8JayS9w13Ga1q9345JrZ7W39Fgay5Kw4FyFs8u393GasrWFnIvFn5Wr4jyayS
	qwnFqr4qqa4UtFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

Add a member "bp_priv" at the end of the uapi struct perf_event_attr
to make a bridge between ptrace and hardware breakpoint.

This is preparation for later patch on some archs such as ARM, ARM64
and LoongArch which have privilege level of breakpoint.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/uapi/linux/perf_event.h | 3 +++
 kernel/events/hw_breakpoint.c   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..f9f917e854e6 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: bp_priv */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -522,6 +523,8 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	__u8	bp_priv; /* privilege level of breakpoint */
 };
 
 /*
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6c2cb4e4f48d..3ad16b226e4f 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -754,6 +754,7 @@ static void hw_breakpoint_copy_attr(struct perf_event_attr *to,
 	to->bp_addr = from->bp_addr;
 	to->bp_type = from->bp_type;
 	to->bp_len  = from->bp_len;
+	to->bp_priv = from->bp_priv;
 	to->disabled = from->disabled;
 }
 
-- 
2.42.0

