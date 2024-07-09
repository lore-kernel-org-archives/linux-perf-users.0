Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48832152E03;
	Tue,  9 Jul 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518913; cv=none; b=JcrSl/9K40yv0OaR99xH994gBAbNZ3pJllhHV0GEc8VFLaHffqPaxOvwx7S+sW514uOe3+fZ8tqG01wPt921tFCtwvCOcjYY3i2Qh5whpmBf+acuXxU8/1Q6MBP7eyOAglJtYBUkQy1zP97G0BqvVBWUhtqm4RL38jja3zuJHBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518913; c=relaxed/simple;
	bh=4iUYg/XUgLCB2QRELheVzquktJ8dWrPootwzGAHVilM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdI9MJoog+3t0pJvjikTIHoFAwmPEN1lL0/XeA4YGyD4wodvcWsu227mOL7UeRGgUA5mzX5iBSbnN8Yma02pRSP5pPNY3vejiPF8e99gbN8mc/MObDmi3NAbLeBo389U3F2P/bpN+QebunE4/bJS0e2opu8cLvUnE7jiCtauyFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxXPD8CI1mVmACAA--.7142S3;
	Tue, 09 Jul 2024 17:55:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqsb6CI1mgt1AAA--.17645S3;
	Tue, 09 Jul 2024 17:55:08 +0800 (CST)
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
Subject: [PATCH v3 1/3] perf: Add perf_event_attr::bp_priv
Date: Tue,  9 Jul 2024 17:55:04 +0800
Message-ID: <20240709095506.9691-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240709095506.9691-1-yangtiezhu@loongson.cn>
References: <20240709095506.9691-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxqsb6CI1mgt1AAA--.17645S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWkAF1rXr47Cr1DXF1DJwc_yoW8Ww4Upr
	Zxurn8K3ykJa4F9w13G3yDZw1UJws7W39Fga43Kw4Yyr43Z393uw1kWFyav3Z8Zw1UAayF
	qwnIgFyDta4UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

When developing hardware watchpoint on LoongArch, we want to set the
same privilege passed by the ptrace user data, but there is no bridge
to save this value like bp_addr, bp_type and bp_len. This is a common
issue for the archs which have privilege level of breakpoint.

Add a member "bp_priv" which lives in a union on config3 at the end
of the uapi struct perf_event_attr to make a bridge between ptrace
and hardware breakpoint.

This is preparation for later patch on some archs such as ARM, ARM64
and LoongArch which have privilege level of breakpoint.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/uapi/linux/perf_event.h | 5 ++++-
 kernel/events/hw_breakpoint.c   | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499b0f5d..abe8da7a1f60 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -521,7 +521,10 @@ struct perf_event_attr {
 	 */
 	__u64	sig_data;
 
-	__u64	config3; /* extension of config2 */
+	union {
+		__u8	bp_priv; /* privilege level of breakpoint */
+		__u64	config3; /* extension of config2 */
+	};
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

