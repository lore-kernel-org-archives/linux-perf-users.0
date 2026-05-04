Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D67401A2D
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929542; cv=none; b=U2WU3tWkxOhHMJQi/CdLz/w8BjOAVk5BJu7TqIYiCndjETodEX7QtHtHM/4Y01S9fNXnUHKcroFB+RhfCd/cogFErVJbLQTump3yGhZhfS9U1XoTncVw3Qi/XrRHMdEo0ntfMSKIhEy5OmDfxd4482vu+/h/WrttyxBkhT/W/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929542; c=relaxed/simple;
	bh=/Xt6rnYnGFBq52V4bBzNz6QqRctwemMB97jkZH74ots=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lTUSUj0mGGboh6HUCBySaWC9kfXKRQOevdANt2MZ1xY4d4Iw2bYccY0tTGlTar17huHfB6/FKcWM4K+VYXqV/6LtkQQv8bkNVw+CEVEgc0Bwj2Zj+azANW938TibAIEHmiB/NxoKea+qEHnUA41oD9o4B5xplWr39VduTUUmSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAA6nA7x; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAA6nA7x"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6948d83a5c0so12665991eaf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929532; x=1778534332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=59TeqgAKhZvxIms330HaGI06DkqMrz/YA7lL8opNhPQ=;
        b=GAA6nA7xd+hXrpdjcybtVknsF0NI8V4ehjMD8DFQ6IOV0BprIcDwQ7/Pve2krzXgDJ
         k8W7ng9N72p6QUJysxBEiK6mBgZEZC3S4SWueXIKTT/j2UOFG3zbdrG3Tli8RSJpDkZu
         27Z3+aUmi4Frzg09wlDzQDrWw7cLDH7LIgi+s+L+UHSYJAO8gtafX7ENT83uaz5+uAKp
         Um8w+5H07mziO1vDOlU2WlsYGdE3sCSGbhh4/sqfkFG3pZ7B/HZ36Oy/XwNoIk3mCiuz
         67fpBa2FWsRM7eUuZQtennVqoZQ1bKOZsTN8s1/m5GyKOMc2uPoMzkqn+cfRgAzuJNWg
         aQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929532; x=1778534332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59TeqgAKhZvxIms330HaGI06DkqMrz/YA7lL8opNhPQ=;
        b=VSdo4vuvxeeMx/hzI1QHSI8kkxno4jItwiyf5rXgde3RTz5vrD1Jq3wUdfj7jCTLjc
         sgDESiOgu8o1s5ZbjbRBQkmEnssdPcKIjGyT5zU73qteBG+okTHjADJ/rFklD/8HjuMx
         KmCJZ47cQa7soTX8JN6hexxq9F/ZekKLHO1k5f3qYrV/lnyTE5BXwroXIOaLtRxIoFag
         f4Smi8LGWA2dfTx2X4tqKhj5Hii6ubGi8lMCCqtUP70jtWo4Ezds6aAn6wwP0G+mLDQ8
         4LPO4sUPxKyZSXpEFOb/Bjg63bVv4Bg7K2H0FyFtYLFK8HjuiGzdl5cSOlQ9yJTCKTMC
         6rkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NIlZFsOXg2oYfhmjVLOmd+krDK4h44fflyFJt4O+Sgk/+wtzqlFo8GcZFvWtTL62SvhOzigeOQWFyTvqv00wf@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjb3pbDLHP1t1HZCAWeDAthP5tuNfvfOUc6U9DM/CGb2J2U5M
	LVigOLBa8Y9hJ+M4z0/qpBHv5QVpPUy0xjQWQSWrZmE3v/RsfwO8kPm4ynVe7+KidlzpXYK6jhH
	u71pbW42EQy/FVY9aqKil4G7v8g==
X-Received: from ildm3.prod.google.com ([2002:a92:8703:0:b0:4fa:5514:a367])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:629:b0:696:757d:1942 with SMTP id 006d021491bc7-69697c60c82mr5023525eaf.32.1777929531976;
 Mon, 04 May 2026 14:18:51 -0700 (PDT)
Date: Mon,  4 May 2026 21:18:11 +0000
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504211813.1804997-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504211813.1804997-19-coltonlewis@google.com>
Subject: [PATCH v7 18/20] KVM: selftests: Add find_bit to KVM library
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
 tools/testing/selftests/kvm/lib/find_bit.c | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6471fa214a9f9..79a45807865b5 100644
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
index 0000000000000..67d9d9cbca85c
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/find_bit.c
@@ -0,0 +1 @@
+#include "../../../../lib/find_bit.c"
-- 
2.54.0.545.g6539524ca2-goog

