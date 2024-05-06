Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF024D5A0
	for <linux-perf-users@vger.kernel.org>; Mon,  6 May 2024 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973438; cv=none; b=tajBnQHcUcl7tkNLH2MVVWoG2U76e7TiD+NFkn3wMqz70zi8hvUi5fQ/AR187dqB4suXTgtlFXQ7LVvlfg7wWkaLYZLawTEGv6VpFt5KOHwNBxCHNcNsREvH8ARby+8Fa6sykpVnEcINpxVhcrY/Thu+Go+JDzOl4B1bzjragXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973438; c=relaxed/simple;
	bh=p1/mWwBDHge0aaoxvafwfz7+X3yWihUIGs8MvmL7VfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MvgQXgXcfyPXgnQJF9GM6g9y2sOCSUnsVWr4AKMugTcEnqDlki9xTK46AHRiF/CTUt8MdLtFjDDnU2O39G6YWAo8sW8rK+Wb8es7DVNzgaKvBXfIjPD8r/endBgmwDDuJ5sB/GnfV15y2AVaiT1lzKut17BgZX7fbKrJ2s+X9Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdOeWRuL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdOeWRuL"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46eb81892so1258599b3a.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 May 2024 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973436; x=1715578236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ro4DfA6A8QKxJZDclKEMPi7BoRrzJeCZo4M/Bj5PgnU=;
        b=sdOeWRuLfDnmIS1M1dwIa42YzGzT9O5+XfMdgM0ceRS3uHvz4YlCo+BicBG8a8AdnE
         mmKNwVFHUcLbBSp6ihzqGMXBIi6onWWy9c1q0fCNv/W+Adujmgs2rP5Ndr/O4wb6xXNo
         WN9fF/8r1+ipRRkLZkWJD+/brkgn6I0nZ3so+g9Q6IMiPWsfb2r9A8qbQP6Gl8a91/uX
         ExNFZ0zIuj4kLstqX/AKtuLh1NbrSZaroofiSHi/QT7BsM+2Hl0W0krYRB92kJAPF6kJ
         XFFctc09z0LGfrpt7jzLTHO8yuuKXHsTYfDdlPj6IBG2IW/mtMsx2mH4/As2MplCFKjW
         lZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973436; x=1715578236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ro4DfA6A8QKxJZDclKEMPi7BoRrzJeCZo4M/Bj5PgnU=;
        b=k/hktyEFfIyvwKBJBBr+euXLZLJkK3atQp0Zb80KaOxOEtqNcb2WXDa3H2tmvGpTBw
         26HxR0oJQ+zSGIpnAPdhJKx/AXBhi3YYnib9GQ1nuunTnKppANRA6eUrA2/6+4D+IfV8
         cOFlZEa61BKdhVjDT+bXjdHsRrH6f87c6iLEX/V2hamksahNoeq8X8zXNb/njuCkYl8E
         qfJ82CYSlUpNWFV90e+gl6Q/tRxcufX0qVpjiakVB4y28r5oFlD0qRuV1+ZbsNAu55zQ
         U3lEUTjkVc5rtL0BSnEXr3qpvFc8+MMYENlJ4lxs+3lrDAYpx2yybCz66nfWEi28Bpqy
         mCLg==
X-Forwarded-Encrypted: i=1; AJvYcCXEd9uzi3FSAXAAjB5r3njg8JJhcLmLX6zcfCL39u6yYpmTMqWcyriXk41ZPXFF5PJ5uAORkNMZxWWeZgDBCogsXJMjU1W0zl+QiVt+RULBjw==
X-Gm-Message-State: AOJu0YzXZrWVGUl1ImBEXBDbWmdFXU4QX4Bu/wZtA+NxtCcLxIDttWlm
	m/A+gknVoghGvygk16lJUHvQTNoJUYws/CAxiz3OOWxP63qVXBwOcQ1vDrWRvU6HQ4/SpcnI2As
	NJ+FewA==
X-Google-Smtp-Source: AGHT+IEflzQyVA/s91GJeohwmAyYBIOJ+aUtHa/6hbR3WMlALelEVrdGk/rk5z41cq9v0+BuYE1IIr+nlit/
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:2e84:b0:6ea:c43c:a666 with SMTP id
 fd4-20020a056a002e8400b006eac43ca666mr434167pfb.6.1714973436393; Sun, 05 May
 2024 22:30:36 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon,  6 May 2024 05:29:30 +0000
In-Reply-To: <20240506053020.3911940-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506053020.3911940-6-mizhang@google.com>
Subject: [PATCH v2 05/54] x86/msr: Introduce MSR_CORE_PERF_GLOBAL_STATUS_SET
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add additional PMU MSRs MSR_CORE_PERF_GLOBAL_STATUS_SET to allow
passthrough PMU operation on the read-only MSR IA32_PERF_GLOBAL_STATUS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ed9e3e8a57d6..a1281511807c 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1107,6 +1107,7 @@
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
+#define MSR_CORE_PERF_GLOBAL_STATUS_SET 0x00000391
 
 #define MSR_PERF_METRICS		0x00000329
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

