Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17F229B38;
	Wed,  7 Jan 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774406; cv=none; b=MmDPwVEHtG3UB60hS4NXwcbfM7brATEChDwcS5xbt84E0lB5rANRSL8lFjqdd1tOHpx46NP5+a1K8LAmsQcWriSdqpE0/HO4QCHZhb5b5pTtESCMk4p1CJSyTi5MX9zLp7/ZEerLMvcSgQcvmDp5A9DNA7WQNaxnHj/0kSq6IjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774406; c=relaxed/simple;
	bh=2TLQMmVXPUeDbbbdnF41Xo3MjftY2B9+e84ZTJ/leKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKkVOdRjW+2rDUfy/EBsaZTl8QOvwBgT2+DU0Fqn2THXJVGoPEHBsGjoLo5vkg314Bfx7femjZ+lUZl3l2TJt1B19PTnjxxprPzkiWdlOvu/aXynDbUJ2IC29VDIWzWDyfdGtSQ3C4aMUyofuKiPP+j2u3cq9n/8GZhwMBeYcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAHIdifGF5pwaPxAw--.29116S2;
	Wed, 07 Jan 2026 16:26:08 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] perf/x86/core: Remove duplicate include
Date: Wed,  7 Jan 2026 16:21:59 +0800
Message-Id: <20260107082159.2150934-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHIdifGF5pwaPxAw--.29116S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_XcC_AcWlOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4c8EcI
	0Ec7CjxVAaw2AFwI0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRAMa0UUUU
	U
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Remove duplicate inclusion of linux/kvm_types.h.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 arch/x86/events/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0ecac9495d74..c182a47f0f38 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -30,7 +30,6 @@
 #include <linux/device.h>
 #include <linux/nospec.h>
 #include <linux/static_call.h>
-#include <linux/kvm_types.h>
 
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
-- 
2.25.1

