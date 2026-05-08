Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B539D6CF
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282038; cv=none; b=AYY2T1eI1IN+ncInW59xKZy4fW2Db9VHk5Zcq3/yKXzzV7bPn3ZmpjwMuOlFeG4zP9JMrewnRtdI5zo8pjnRAySQh172xOYjAxLHMUPUgI7hYsHUoCB5HEJGm3DVN9BFcsG2mLk95yKCSiDvuXwNcaWHrgw5vzH7I/TusV8bO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282038; c=relaxed/simple;
	bh=yx/8znDbwZackXRIS3uVWDYIbK9dKkMXLjcg4TqN5Us=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tb+5nhNCZ36LfWwn+G7gnQ5s1KNozlmxRO3WX8jgDHnJOhbcLExhq0ihsa2JZ9wAHY3oSN3lPW/RnwyYvkqyCuyImv52MbRf7U6f2IDl+WnW70gHG5CiOQEyQIkkcgJ6pzOBJp9HB/fb1n9I8FT58pOwAXl2qKGuZFZj1vP4PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pzh2WYPB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pzh2WYPB"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c709551ec08so2837210a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282037; x=1778886837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+D5quk3d/QgNQ3+BOhnf9E+QRhuhNCjSe9w0CI0JGNM=;
        b=Pzh2WYPBvEmk9SbutkfErFW52bj9Qstoqx8RBAekfuaODEXCYLQlEPxAYM6d0wrSk6
         lCmv0fFQ/XLJJX8H3Gf0D42oKh4wht84k7hv0XCsn04G4bK2nPoZJlku/eGnwvpMSZdK
         nI25FUL3vCONkiFdAe5hfRRqFgYcZ93u3QX41x66q35qV1vkfXkMKMpSAVumn106hMov
         W/eB5zTredZaduIILTd8t1th/8LqjeCDxAFDidiIpvX43gdZmBImjPseLgEiy2VZyWRF
         11dAdR1kMIJLiwK8AeN3hRytX2oW2aJpO+kapJK9YrK5rHUyGAUYzeX0uBdOCw6NRhKn
         Rhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282037; x=1778886837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D5quk3d/QgNQ3+BOhnf9E+QRhuhNCjSe9w0CI0JGNM=;
        b=eQ2yi8EnHVUeTB8mZFSKPSP1J3AaSze2W025bHOiUZNdgXeQ/mbe24dqKG2Ns9NTYT
         k6uoXNQ2X6ChdMvdjG1Zf974bsWfi5PDycqD5pf2NX2TImwri+UEOi2fIFGo0GR1vKEQ
         sCYELVXkPUz0M7wx3H0eGNpsMcAb+7P0tNbS5XYpf/qU3u/5jPvk8RkF25jT1qAjZ2IN
         sxnoWcnXp2Trb7ZJr5Tk0UPQNFNKRNUer0GUp1EcUsOOfU8TBmSD6/TG5DSIszbLIvSs
         JWWAuwZ0KUtCqORsQVMCX6lvhfEuVlxbjdt45uv+cYBVqfdlBYTUhc8VTvvE4Al63fsI
         jPjw==
X-Forwarded-Encrypted: i=1; AFNElJ/i1b+k/0U/Lo9WnvcmTpOrCUPb6ef5CetV8VimQXj5M+sgL+VPBLQTIV64Au413m3L7Uc7+JE6u8xhDb4SbP0c@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9DuoDInT/sHPcZ3wTdHnKUq0v2mVIzZ0YQ0E33g2qOve0xXs
	CriJrY4pcSb+dT8GH0Qz+Tq5qxQwuda1pwH6kvYUTNb7lJhfJHJsiUmlYBBdL3+xNsOrmiIcC4C
	o6KS1Cw==
X-Received: from pfbgg21.prod.google.com ([2002:a05:6a00:6315:b0:838:27b2:c6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4324:b0:398:4a1f:8a54
 with SMTP id adf61e73a8af0-3aa5a8308ccmr16370081637.2.1778282036646; Fri, 08
 May 2026 16:13:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:45 -0700
In-Reply-To: <20260508231353.406465-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-2-seanjc@google.com>
Subject: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
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

When reinstating PEBS counters into PERF_GLOBAL_CTRL for a KVM guest, mask
the value with perf's desired/original PERF_GLOBAL_CTRL value to ensure
KVM doesn't unintentionally enable counters.  This _should_ be a nop, as
arr[pebs_enable].guest is derived from cpuc->pebs_enabled, which should be
a subset of x86_pmu.intel_ctrl, but paranoia is cheap in this case.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d9488ade0f8e..b70dc35fcceb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5066,7 +5066,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
 		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
 		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
-		arr[global_ctrl].guest |= arr[pebs_enable].guest;
+		arr[global_ctrl].guest |= intel_ctrl & arr[pebs_enable].guest;
 	}
 
 	return arr;
-- 
2.54.0.563.g4f69b47b94-goog

