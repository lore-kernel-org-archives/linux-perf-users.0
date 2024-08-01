Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C1C143884
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722488362; cv=none; b=tbzJNIjWUwFke821XMDn/aG0O/P6MryE0BSkwvEfNnsk/0c+aZeYJMwJBHRRUCmHiPo6BHQyx2yPWRej7CSYIcDNGY7U86l/U1pJYNHWjyVCQ8tsoOyW8KJ/tWrFlsOjYJVvt5ymqOS353m7b09U98z9t/pw2VICALmbXNLvgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722488362; c=relaxed/simple;
	bh=XpWZVpP+1fU8zyiBCBEZSEjntYhRTb04Ki1oElLfW4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XBYuj3A/ESdtbOy5/XSUNcV8NOFSCOU9WB5KuAI09KFUr0r0eYFcyyhbqKQBPpsRbeuf696ZNUG5fqYqK/oSQzMg5S8zV1IpWSBfJHAsJa1WQp87OMeDRHMHBtTVC43wgZmZsOrXhD7ORbL0XqI2rfFIQtquI8bJVOlNJi9ydn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdJ8GY+b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdJ8GY+b"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71050384c9aso1577742b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 21:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722488361; x=1723093161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6duVsFRfrk0IpAUCyLOr5AOz6KYb78N++19JHZQFaLc=;
        b=fdJ8GY+bhcQyRIG8y92u20GHycTeC+kKZsEZj9XZ8VjPMkcCxfjrDhTF+RLMqx4THP
         FowQGy0dl7bDp8eH1TxiK4m1wr+p+qJ86MDliMYpXnIe+lsotMe3bUB3E8GyTjGh3rUw
         cDq7Vn/IATRqfZ2DH+GEPUvfZesjPH4miqdRvz5g+df2B5mCQFWcuCtQg4R7kusJGBGG
         /WBO5iftWgoIiMUR/A7lSCzpUI5pEOnI5sqdpTTYUi2LFwSeYvDb8DVJ0TylLrZHBnw8
         A6s8hUn5Mql72TFM9Qwuh0vAT0aHd+No6+lgknUiRt0ppQ+4Iq+QZQDpSoVPEN/KKkk1
         aYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722488361; x=1723093161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6duVsFRfrk0IpAUCyLOr5AOz6KYb78N++19JHZQFaLc=;
        b=BKrIPkyT9iBLqzRQYeqjCEbsAmCLVHhSNsb3wZ9Bw621UkcOEUE0/cPp0UuX6XaLJ3
         DNp3Ebmy/XHuwEv6C9BVbQmqZizeZ5MULXAU7hC2hCUUJc4SDeAoUtHBFN/ArOKGi4QB
         ZvZg+dIIhBArchvFpz+34o2rRavs6QNpww0O16HH49k21JaAdy+Q/fC2tTcNh9ErV+ua
         4zzbYjV+A5Kd+RFXMFutPEhapAv4KXyaj9k+sBrS+qb7TU5HxKdJkzASAZ/LtfNuUH2M
         aQODpPu/HQLGyfSVWDRecFvD2tgAzJ/2nqYOb0E9P7Sd4bxiR9sCYjtgUNx7r1Oso72F
         behQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKRx6Pg9qQGD85TaoIU4xligpIyNEXwlBDfxA5Yca0MQxsi8W6iSkhLasAvW+84AjsxU3bdhzVqn/K1l0DLpXO/wtf7GDcoc+6a46jVf3wYA==
X-Gm-Message-State: AOJu0YyomtCrsVH6pfqrCoxDWAjBw3wFIhzDC++jRhCqrRVLiPS4ToxL
	bsGhb4yMPMaQVxC6sLQVkq9Pi7UFuVQBZcxx2jSKhcg+iK5xE7eqk/pgu+aTsmdDOhzm55wLDVg
	ZTRYHrg==
X-Google-Smtp-Source: AGHT+IE0xF0ZWDReclAZ16EiEfEORg6bp7W7nUuzCTTl84dqX0CiNk3QO/0bqT1nO6h5B7MExJodqJcFutLy
X-Received: from mizhang-super.c.googlers.com ([34.105.13.176]) (user=mizhang
 job=sendgmr) by 2002:a05:6a00:9465:b0:706:6a2f:36b0 with SMTP id
 d2e1a72fcca58-71065e4ef40mr758b3a.2.1722488360754; Wed, 31 Jul 2024 21:59:20
 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Thu,  1 Aug 2024 04:58:14 +0000
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240801045907.4010984-6-mizhang@google.com>
Subject: [RFC PATCH v3 05/58] x86/msr: Introduce MSR_CORE_PERF_GLOBAL_STATUS_SET
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add additional PMU MSRs MSR_CORE_PERF_GLOBAL_STATUS_SET to allow
passthrough PMU operation on the read-only MSR IA32_PERF_GLOBAL_STATUS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b9f8744b47e5..1d7104713926 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1113,6 +1113,7 @@
 #define MSR_CORE_PERF_GLOBAL_STATUS	0x0000038e
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
+#define MSR_CORE_PERF_GLOBAL_STATUS_SET 0x00000391
 
 #define MSR_PERF_METRICS		0x00000329
 
-- 
2.46.0.rc1.232.g9752f9e123-goog

