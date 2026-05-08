Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55D3B530D
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282042; cv=none; b=g4ibalXz5JxILWxTXZehaTaeUryIQO/J4ttMk76EDf/Lf1KhchQZSzNwp352ozn6+qXVahFaxSWy8zPvgG0d6FeWhBbjAAjH+QO5m2XhHOX7+zzb/Oqcm3McjLfnyk5ezg9hwfTnHAIg6y0//3O5724F26/Xm5C8Hbs83m0lF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282042; c=relaxed/simple;
	bh=zC4BgdIkH0zEFk6RlMRGIuylwnchi/hIcehvbfaf81g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EiVJFeBe5HXtT9dzIb8nmFrDaTjpGDWCdStveZGerLgQ2BwVrUjel7QR+AOPjLgVw/rGFwmBhUP0VWD2DYgBwnysSFdHgipMbsF60pKYmYHzt49OyzAOKe8gilEvTRFHO2q0vIop9RtTtj4bIF15sqEionUQLGGU0HRkkI/P2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AHbKioBV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AHbKioBV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so5326235ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282040; x=1778886840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XL8sVld4hY/ipwFKhW3uhAJLAQJEgZCQ2/7huQZafKA=;
        b=AHbKioBVXN5bmDSoZDV8n3LyPtKdWgQd86YFm43vXPOynhtb0oMGejUk1w35+uQu2+
         uNfH6Hico5Hjc/3tbCeVkBUHJuiQUQeBOiz89sYPdNvqzV9+Z7/CH4tDaNzBiTMJnTvq
         23OLIcKZ9M640hn+oTDpwfLl2Whsd7QpimL5HnupyYAWkToGG62fiwi2bqZ4OiLrtL5l
         Ctg8C/063hSVv1IESZCV0iEhTCQMw/MyYkabKebEXups6noM9RRYmK9KnYZ5SIqXWRds
         itEfFkXUhjG4yY8reXtv7T5Y5YKxYJHe7+6AYSmZTsM7/VRF+S7PI0Jr/u/8Jy93iPG8
         U73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282040; x=1778886840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XL8sVld4hY/ipwFKhW3uhAJLAQJEgZCQ2/7huQZafKA=;
        b=AFFUrbEEGz0omN0WpfGWp8j+HplBlobcK99Ly1XHfOfIFjjTcj80/EU91kqkTmGFpd
         GgsGr+g0e53qiii50TtG5zDRbnaBkq8pP0Bw/Fp6+bO+Oa7uaQe9KvaFzgfYYGwSf5P7
         x6C+q63LSZ/Nt4QIRwOW6uA6sfhXvjOBZ21n/2PIcIgync3U8idx5Zkc8tx6M1H8O/Wz
         Ca247XxVlpZP8Ol9+XaLSv966PcT9EE8fUF2lK93OJ7XPXBIk0/fr5tiyz+yt1W70YY6
         RxvfgA50gcLeCL8T9X0b9SBKg7QI/deN9yxVZnb1TZgS66WxMoJUz0qqvEIU6QI3a5pz
         LEYA==
X-Forwarded-Encrypted: i=1; AFNElJ+o1DtHkDuJELNybD37jeqYPAh1DBLT+2Sbk0SzwoFV+wG6RjssQYPuYtjrejSR/tZ2vgjKLf5FyZEAbjgezzk0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5qc6POUqsYcSFrWU/CX/yV2kif1b2h1sBSQ5BYa04OnTKWpK
	NRxsjxq/z60hXoMeVWbCnIF/qDexvGP3XW/9oGljd+DKmA6MpU22W+x23inQEx2aLq+p29JtVdz
	SZlyanQ==
X-Received: from pgno26.prod.google.com ([2002:a63:7e5a:0:b0:c81:2646:5294])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939d:b0:398:6ea8:21f7
 with SMTP id adf61e73a8af0-3aa5a9559ebmr15365421637.15.1778282039831; Fri, 08
 May 2026 16:13:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:48 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-5-seanjc@google.com>
Subject: [PATCH v3 4/9] perf/x86/intel: Make @data a mandatory param for intel_guest_get_msrs()
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
pointer, and carrying code that suggests @data may be NULL is confusing,
e.g. incorrectly implies that there are scenarios where KVM doesn't pass
a PMU context.

Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to support guest DS")
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Cc: Stephane Eranian <eranian@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0e9ac2e9b5e7..e9f5a6143e71 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5038,11 +5038,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	}
 
 	/*
-	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
-	 * guest, then there's nothing more to do as disabling PMCs via
-	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
+	 * If the CPU doesn't support PEBS in the guest, then there's nothing
+	 * more to do as disabling PMCs via PERF_GLOBAL_CTRL is sufficient on
+	 * CPUs with guest/host isolation.
 	 */
-	if (!kvm_pmu || !x86_pmu.pebs_ept)
+	if (!x86_pmu.pebs_ept)
 		return arr;
 
 	/*
-- 
2.54.0.563.g4f69b47b94-goog

