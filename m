Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BB14F9CB
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488429; cv=none; b=eZ/ACL9KvHe0GUpCBArC764TJAFY5L4BOsFuFQ4QJQeXalBwskfyXrBJ2OupSoO+vn4lBl5gOYcWVqK3TpVbkazPIxTRY3CZYNbq8vgRgA19L+ZDtdmZEvXMBRfAq0bWPQUIUFqJIxV0kFl1BD7W5z0yE6menhS4mn0lXHZh9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488429; c=relaxed/simple;
	bh=Er1+rIamv8zqHCWIvU5+MdGxE5F17D0FaBd+GU9PuDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rXXu+nNRpujgschWnnDW392at7A36VjBJT40FvLFR5JOjMfefpmdZgrDaloRhCFYhcP1OGlI1pG8BldPwnEmu01JeWFOaNiMM/zVW2jQ2rBgxbVmA8wZL7qFLss/gfoQlR36Fr+u6p8/jNfN8AGIcHINlkzIuJmjJvXNgkeV6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IEU5Yr2j; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IEU5Yr2j"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-70e97ac260eso6441178b3a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488427; x=1723093227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hMe5GjAdDPvJgfCRTahsDqHRizME6fQZtVPI9cUADrw=;
        b=IEU5Yr2jCPuIOkgiag8TcQHtv5b0Ez6XvgYD2I0WwhQSXpqxrosbuAQ+tEldavrwSU
         PHRiaCZUuR+90fGoZTwze8Iapm5+tBaBnxaP9vkpEy4YCuvtuFnbRBlu28Uncr5PzvzV
         iox9flORua6pFGvV380kdNJ6dAp+tMPgHokpmfuotN80uu0ZPlQ+XTYahwJhBgpO5jzQ
         Fmp8P7xiXpcifjN/19pAydtW6uqU0BvF8XCcAvAN3D6tplZ0EpcR/BP9IFSaUg/5dsh4
         tdxAJQH7pi9DU4Ln0Be8UL7zqlA+91Ot0qQV4ZGgSpIq5yI14ZYTJJlw3U/UPwXI+L0f
         4vTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488427; x=1723093227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMe5GjAdDPvJgfCRTahsDqHRizME6fQZtVPI9cUADrw=;
        b=Wk4pkLZxufKh8NL7Q78X7jD17b/XDglzZjrIeWbknDfmyNsrj788+3RgISlguovKpE
         QSHmrHuYNfVLNEOnf2Qz8d3gCPxhKZZCm5ZYfSNZTeUSCa1WdqxGsNY/ULaYb6UiUaz1
         Aw1DmJPKnHT+uhFQ/2eayvLe86TY2iOSDpPtWPbiCXVWlszYlx+VWm08ovR2WeRduZah
         CVwpDe+XQLEqLsIIfu0fZRE2MzifaQbG7XNjTSKzTMGRe/l7SRDIN2BwCElQRNs37vWP
         McV+350iiB5bm1sLv8qggg6qbz1YhgLue9mWb9EdqgTChQQ6cmme5ZkYdKYJs2pGfR84
         jtiw==
X-Forwarded-Encrypted: i=1; AJvYcCXavF6Ti30gwRrDqReTXyF4mNmt9rtyhKSz4zX4OVfMj7H4vuBgG9isZgPtO0eXkQHaVwhVJgB3nztS0mdBXyTZncxlzlOk/5q6Hp0m/iUHcg==
X-Gm-Message-State: AOJu0YzGJ2qCZJLAk+pwaPgqMOqdPmUtC8urI/eapC9hpU7eggFOl9Xo
	Y+Mzwj4vn0v8S4adgcF+aAnHGj3mdFuQUtz0TS/H/iJPdCEoBJyWiPZKovYy35Grl0f4gDaNH6A
	F+zf1lQ==
X-Google-Smtp-Source: AGHT+IGQLdd9VIQeVQT4wYUeYXOg0Hx4N4Em1cpDz2c5QtwlNnmaxxHjY9+MSpq0udu3T1+5Rmfp56K1We6y
X-Received: from mizhang-super.c.googlers.com ([35.247.89.60]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:73b4:b0:710:4d94:f9aa with SMTP id
 d2e1a72fcca58-7105d83cbd1mr37503b3a.6.1722488427018; Wed, 31 Jul 2024
 22:00:27 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:50 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-42-mizhang@google.com>
Subject: [RFC PATCH v3 41/58] KVM: x86/pmu: Add support for PMU context switch
 at VM-exit/enter
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

Add correct PMU context switch at VM_entry/exit boundary.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index dd6d2c334d90..70274c0da017 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11050,6 +11050,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	if (is_passthrough_pmu_enabled(vcpu))
+		kvm_pmu_restore_pmu_context(vcpu);
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
@@ -11078,6 +11081,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		++vcpu->stat.exits;
 	}
 
+	if (is_passthrough_pmu_enabled(vcpu))
+		kvm_pmu_save_pmu_context(vcpu);
+
 	/*
 	 * Do this here before restoring debug registers on the host.  And
 	 * since we do this before handling the vmexit, a DR access vmexit
-- 
2.46.0.rc1.232.g9752f9e123-goog

