Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301826E171
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837636; cv=none; b=Zw3YWBQE4l/NuuAU8rMEkR9PCt73rH49TjqI3mzAJZPi0BNY4S8yVnq671UQ9ORinPM7AxuUNAcAXMx11r/5gVRSX5n9bh0zCGQGYosSySHHzoAZew9h07+NH2va3IKEAN6iTY1u6y/96ERaXu7Hblo6bVioLdRzhDKJ4dewYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837636; c=relaxed/simple;
	bh=Fzdu3CbhlWwdv5ErNtNQUvoyT6udvNORVBxBG5rpyUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gp1AjqZ3Mlc+5UIj4mpx3jTahkmHdMTqfKhK3zkxfguVUGGIFTsI4IwjVihkUk5kwggeG4lqRlBk8HsAOes490vh7WkS1ghZvNafzDMzPLkzamp9EHESFb7axilY4hQvvkySg5XM8UgWNeuDTxs0McaFIsDoNafo9hEIibdKWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XyQvbI1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mizhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XyQvbI1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2264e5b2b7cso69870205ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742837634; x=1743442434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=88C2UbjNetqKIudE+7P6t/BsF0Q2P+IjVPGB7Q/ZhWo=;
        b=0XyQvbI1xqPbubC9grfv9wVTIfiSKn6Cv4HPN/QlYcOEVHj20FFrced+pBcJIs57jW
         qM5RNvPwkJQpBrFw587YcjBbkb9N5N4m8K7fg02ocXD7zZqXMDNtj9cp6NzKGvx3WjUr
         Q//l+Bxtli4E3tLhtubZqN/g7WToDWDk37y95nzMXPBcl3+q7D31sd+qXwx0e520h9e2
         HYbuI5tWpkje9sPpiUMfslRRgDavvufOSWQfvIBQ+w+ghZ/QsAOYTTLeIQOcJ8LKDQua
         dL1VzyqC2HLA/Yol00qB687zYIsAht8eWGgucc/B4wR/qLTZROc2J6BNyp3mhpLOgNni
         2png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742837634; x=1743442434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88C2UbjNetqKIudE+7P6t/BsF0Q2P+IjVPGB7Q/ZhWo=;
        b=NChyGo6UhhMfgp298zqw0oOraOFYx3bjm9Eiz6cCaZaUDDJo151XRcjguxqzaExaB2
         PP3dFUCgF8WkDaSLJOxJhxNnRGn5hSkhoYBbuHxb47crtA1ZibQvy0Cg2nKPis4SyO4V
         zKmRlaTuEV3VBsdVeAZJ7h4behH2p7cUJDTqrnjfr10v/v+qWeq0AMPl8mZStHydG/gD
         f1QwMz30SDUzvS8mwjX1EE1hc/gumdngqDpg3F+um3akIc/a/zEeBm59wZqLgut9ixwQ
         TwkKZDpu9WVPBVqYSaJK+PhlHtU+RW+z9R6KRQBc1cLJR2AhHTQeYzUO6oHrTmc5QC6U
         QtmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTkd2MdSzO8rfLtQZjaZ2x/uv+U3U0WSoK7WAUCjfPwWJqG08ByMNkoKMAPxKuk8eKL4hq49QtWfVcW+aq78P@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1dcejJtd6CkR3HnfjiPKNDknFlLQaNA7WaxfsGWe1V9aVMTR
	udCpxtcbEWfwSrSzycDlJtTMcqsylYvKV/vZ1WppWZDLknM8szipDFoRfJF8E1pZ8AVIlG3PS2p
	qxXeBZw==
X-Google-Smtp-Source: AGHT+IFbsFBFAVlfGnjEPNOWOEliKW5tmQpe2OOWwOf9zNzJ3tQktbRTua3NsLOUyOjEGtnHL9GXrfWkJCng
X-Received: from plbmg13.prod.google.com ([2002:a17:903:348d:b0:220:efca:379c])
 (user=mizhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c40a:b0:223:fabd:4f99
 with SMTP id d9443c01a7336-22780c529ffmr247929475ad.5.1742837633604; Mon, 24
 Mar 2025 10:33:53 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date: Mon, 24 Mar 2025 17:31:18 +0000
In-Reply-To: <20250324173121.1275209-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324173121.1275209-39-mizhang@google.com>
Subject: [PATCH v4 38/38] KVM: Selftests: Fix pmu_counters_test error for
 mediated vPMU
From: Mingwei Zhang <mizhang@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Yongwei Ma <yongwei.ma@intel.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Zide Chen <zide.chen@intel.com>, Eranian Stephane <eranian@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

As previous patch commit 'f8905c638eb7 ("KVM: x86/pmu: Check PMU cpuid
configuration from user space")', KVM would check if user space configured
pmu version is larger than KVM supported maximum pmu version for
mediated vPMU, or if fixed counter bitmap is configured incorrectly,
if so, KVM would return an error.

This enhanced check would lead to pmu_counters_test fails, thus limit
pmu_counters_test only validate KVM supported pmu versions for mediated
vPMU and only validate 0 fixed counter bitmap if pmu version is less than
5.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  8 ++++++++
 .../selftests/kvm/x86/pmu_counters_test.c     | 20 ++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index d60da8966772..7db34f48427a 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1311,6 +1311,14 @@ static inline bool kvm_is_pmu_enabled(void)
 	return get_kvm_param_bool("enable_pmu");
 }
 
+static inline bool kvm_is_mediated_pmu_enabled(void)
+{
+	if (host_cpu_is_intel)
+		return get_kvm_intel_param_bool("enable_mediated_pmu");
+	else
+		return get_kvm_amd_param_bool("enable_mediated_pmu");
+}
+
 static inline bool kvm_is_forced_emulation_enabled(void)
 {
 	return !!get_kvm_param_integer("force_emulation_prefix");
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 441c66f314fb..4745f82ce860 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -564,8 +564,14 @@ static void test_intel_counters(void)
 	 * Test up to PMU v5, which is the current maximum version defined by
 	 * Intel, i.e. is the last version that is guaranteed to be backwards
 	 * compatible with KVM's existing behavior.
+	 *
+	 * Whereas for mediated vPMU, limit max_pmu_version to KVM supported
+	 * maximum pmu version since KVM rejects PMU versions larger than KVM
+	 * supported maximum PMU version to avoid guest to manipulate unsupported
+	 * or unallowed PMU MSRs directly.
 	 */
-	uint8_t max_pmu_version = max_t(typeof(pmu_version), pmu_version, 5);
+	uint8_t max_pmu_version = kvm_is_mediated_pmu_enabled() ?
+				  pmu_version : max_t(typeof(pmu_version), pmu_version, 5);
 
 	/*
 	 * Detect the existence of events that aren't supported by selftests.
@@ -622,8 +628,16 @@ static void test_intel_counters(void)
 			pr_info("Testing fixed counters, PMU version %u, perf_caps = %lx\n",
 				v, perf_caps[i]);
 			for (j = 0; j <= nr_fixed_counters; j++) {
-				for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
-					test_fixed_counters(v, perf_caps[i], j, k);
+				/*
+				 * pmu version less than 5 doesn't support fixed counter
+				 * bitmap, so only set fixed counter bitamp to 0.
+				 */
+				if (v < 5) {
+					test_fixed_counters(v, perf_caps[i], j, 0);
+				} else {
+					for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
+						test_fixed_counters(v, perf_caps[i], j, k);
+				}
 			}
 		}
 	}
-- 
2.49.0.395.g12beb8f557-goog

