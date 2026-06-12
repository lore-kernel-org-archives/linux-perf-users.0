Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857D03D3306
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292576; cv=none; b=M327DNZMMruTSJ8VJRauPrlJMlYIQvUSE9uIYDtHDAiC4wOucGSclm7n4bN//Zv0xlqzALeLgl+KVaho9JG3FkwyY0DdTM+Bh4q2+Hh6BVJGeBwn1h6eHjMIH50Gz/zWOWx1FZdAEeFMTGK5k3gXNhDdKfU/fQ+gSzC63/Wz+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292576; c=relaxed/simple;
	bh=HBuFwboneQNMp7qglhgXk7alnCfDwtLSxYiguum4PxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZatjSw+6i5yotsDobxWRCRMyl9exOKS+E58ZeHQC+IshVUiiv2uk/4eGpl6kKIglFNvz55H3aHpIQafJGinGKacnwFPDB942QrGQBFX0J/wGVOltJukQZuTXWPNQFIIO7GrumegYHSpjREhd/xtRS7FiCWPh5E7wLSxdPEKYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pr/aGln3; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pr/aGln3"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-486660d2abaso1646019b6e.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781292568; x=1781897368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lI2FhZeVSW/rDbtlOOBPVMTchx/8Z69t0suel1yDoGI=;
        b=pr/aGln3J9K7mB7pFQ7vKNt9N+5/LTescX762MEq40KZ1XOAC30WqI5a0vJXHE+DfU
         xdB68KTUPAAMR7uVW+JgMPpz4ZP0yWKhC16N/HYehe20mq+vfcZTRjBsF+KTONi4LKZZ
         B8vcrXsCdI8im2fICAcFWli0usmHnyg8/ELYuxJnfo8pzpDpqD24ebc27fd/sDxC2D7x
         oEZerZ33KuqZQxkDPXJXf8esM4OTDSuq2aHsX3pN0aKd2hUFdtpY1h5u9m3yJrUknuUL
         8J6PU323xrNVo/dZz0xLqm8RbjzHFrD3P3xBh9iE086T1kjX37MiZXPaaliDY/Cd6+kK
         u2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781292568; x=1781897368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lI2FhZeVSW/rDbtlOOBPVMTchx/8Z69t0suel1yDoGI=;
        b=p/Vq45YTPRBGoJmuAwtrhYcOk3dnRChl18VSVbzUhi3V/VY2KrnppG5TkGuCoKUCU7
         G7vlkMkwkeZAobk6cE4Qr44ldYGQRVhSGiNdEzvIEjyrL4yZntBwxB0Bkk1uvZssl6sR
         +aRRHz5+PMTy7bffvh/F4zM1IjVivqsM3Qz4WPEWv/+WxvP6FxqlO6YNO8BB6JGJwA0D
         cDqogTSvmRzPeoJaBsfrM+c2N5yFt3C2xT+uoPAPN0JF1Evu6vRVLBCCcfxhd0KfDmzJ
         RUjVUdzYIImS+dTG8vpIyTX3XTUNJCda8aiwCFmRbSRn1r6N1JigQfph4HFEMsI6ZUu8
         fzyw==
X-Forwarded-Encrypted: i=1; AFNElJ+Hrh+iIyZEKyLpTxgCBz895+liYgw+FGkdLgXva89Yt2GirmDskDA1HFoaV9sThFi8sZSBWNLQAOjCK1sAJn/o@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCLops7m8SwtD6kr7zwh8VVuHAyvpyUWCFw447zpH7Hln4kHc
	q6yfqms0a+3QqcDAY/n74e+5pk16noi06fTrtBKTJYQduzKhdSj27irKYg3jujalJZtj+PAGQCh
	0N2wLEGtSPUW72rMUWRNAl/8t1w==
X-Received: from iljq18.prod.google.com ([2002:a05:6e02:1072:b0:500:26db:d9ff])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1b2a:b0:485:467f:a306 with SMTP id 5614622812f47-4872f352d35mr2615199b6e.4.1781292567951;
 Fri, 12 Jun 2026 12:29:27 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:07 +0000
In-Reply-To: <20260612192909.1153907-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612192909.1153907-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612192909.1153907-20-coltonlewis@google.com>
Subject: [PATCH 19/21] KVM: selftests: Add find_bit to KVM library
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Alexandru Elisei <alexandru.elisei@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Mingwei Zhang <mizhang@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, 
	James Clark <james.clark@linaro.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Some selftests have a dependency on find_bit and weren't compiling
separately without it, so I've added it to the KVM library here using
the same method as files like rbtree.c.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm   | 1 +
 tools/testing/selftests/kvm/lib/find_bit.c | 2 ++
 2 files changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89f..fa7a2746b1c13 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -5,6 +5,7 @@ all:
 
 LIBKVM += lib/assert.c
 LIBKVM += lib/elf.c
+LIBKVM += lib/find_bit.c
 LIBKVM += lib/guest_modes.c
 LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
diff --git a/tools/testing/selftests/kvm/lib/find_bit.c b/tools/testing/selftests/kvm/lib/find_bit.c
new file mode 100644
index 0000000000000..5534248c663f7
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/find_bit.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../../../../lib/find_bit.c"
-- 
2.54.0.1136.gdb2ca164c4-goog

