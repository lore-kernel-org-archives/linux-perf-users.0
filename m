Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865C14388B
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973501; cv=none; b=GtV95ZA60S90qscTWcx01n2go7dYXNAFRDIePKxXU4Z/GizTQAQ7t18l4OOvB3khWHd5nV5dvina+nONROaDmP/Uq8T8gB0FepB+5RRtS1im1uppglHNPxcYkMbdcGACDNwITaovnA2F6tkxZgnWbcXRcogZoOGRnxOBEVSO6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973501; c=relaxed/simple;
	bh=DZSWdRseL57JFKlw31VsawawKE+k1mERzVTXnFwL8t8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fOcHRqxp6YdDx6ms9Inc2vxKx2/CcOM6OPWOUvvep4dGFLkzjPk2KKP0iNiB/uKXpKmaF8D7iIjBypz1oBgZqucB//mExoUZH77H29aLtaRDVC54A7rkSq0FB3BlPK1cxsYNE0P58Ymt0fEQBsWtHlxg17I9LbHGmy4/hg37o/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SKyaCDgP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKyaCDgP"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61beaa137acso29459687b3.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973499; x=1715578299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+tZnFPelKgQ9+tzFE8Krjkx+y5cOXsHDjgrtYLK1tdU=;
        b=SKyaCDgPs0SqsQvtFpKVxVIpRWGasksJcKtMFQfI39e8WrT2pV4N+RJv4BmsyS1xQf
         z5+GQqSNIpCY9s2YmFNsO38pNRWY76WwBlTZTn9J7XksF85+M8kM2a4SuP5dQZqpeZuk
         ZOIgiqxiGhX6cOFJalTiuPIh25i6rT8gU3XoiIt5DFF0gHUymACINF7RMga5eyyRwVOn
         FH2ub62doRtadLWWyBKD4lvXlhT6IXzuxmDNgmI+09F8Pun6nMsYN18YdGwYNLAy8S1u
         DhOgDWq8V4qBrYdqrCpyCK2Gyo8tzcKkmpx2r0cO0uiln1hQx/tfAneeUwbpL+b50Rn/
         4bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973499; x=1715578299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tZnFPelKgQ9+tzFE8Krjkx+y5cOXsHDjgrtYLK1tdU=;
        b=taYKInna2i7EhYpZcXuu6MPoHBxCZTZAGayFxv77jX9zfOePofRMn6a5ynwZT1nfyq
         E+UXfzOysqcF01dAqk8rgBWbbLYTATvqW6kWbQQ+YT39qogrBw51gAHX1qB5broUGqco
         57axsvI+5DjHqnNTsAxfUq/x8PPzMiqQUd99wjrweR0R5RqGpPPGnEHA8z3QfIipJpuv
         aMQyUyx3xPsEzScEf1wgA5KkKbtqxHAVUiNEd+Y87Fc2y6dsteSvkB0imfSk9pKpwsd7
         AruJIQDd4KHZ15krDN9U2BUmttjGZIUMWTt0eqjokJ2cyTjVOkx1C+iRULFlhW2UPx7s
         75zg==
X-Forwarded-Encrypted: i=1; AJvYcCXAJXGWGKSj0hl0jjaTGryTt8q1HgdGKFRbTGkYFGbA4vr1gN7sF1CBJVc3KBQ+qUMB9qjZcNAkaEhbH/nSSfGjMg5SdRiqCYGpLLFc1/sTug==
X-Gm-Message-State: AOJu0YxjsAmSiSOGYQM6cxthINcrHI+6ZWAUJO0opRy8fiRfQHfl6nU/
	kutHb1XvbiHQV7AeLBLI8nn4SmqOHoLZL49bzDpLlcu2gl0KFzVJJQVsudE7msAQ8jSILqjqTvq
	zflvOMA==
X-Google-Smtp-Source: AGHT+IFxvZEFzZ0XjsZJVKcgg1TsSUA3w/oGHhz5UHk6n/ARs05crQP25w+vO++u4YwKRI3SvMzeI9D4Wg9Y
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a0d:d857:0:b0:61b:e524:f91a with SMTP id
 a84-20020a0dd857000000b0061be524f91amr2194694ywe.10.1714973499542; Sun, 05
 May 2024 22:31:39 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:30:03 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-39-mizhang@google.com>
Subject: [PATCH v2 38/54] KVM: x86/pmu: Call perf_guest_enter() at PMU context switch
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kan Liang <kan.liang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Sandipan Das <sandipan.das@amd.com>
Cc: Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mingwei Zhang <mizhang@google.com>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Xiong Zhang <xiong.y.zhang@linux.intel.com>

perf subsystem should stop and restart all the perf events at the host
level when entering and leaving passthrough PMU respectively. So invoke
the perf API at PMU context switch functions.

Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f5a043410614..6fe467bca809 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -705,6 +705,8 @@ void x86_perf_guest_enter(u32 guest_lvtpc)
 {
 	lockdep_assert_irqs_disabled();
 
+	perf_guest_enter();
+
 	apic_write(APIC_LVTPC, APIC_DM_FIXED | KVM_GUEST_PMI_VECTOR |
 			       (guest_lvtpc & APIC_LVT_MASKED));
 }
@@ -715,6 +717,8 @@ void x86_perf_guest_exit(void)
 	lockdep_assert_irqs_disabled();
 
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
+
+	perf_guest_exit();
 }
 EXPORT_SYMBOL_GPL(x86_perf_guest_exit);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

