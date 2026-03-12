Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664E351C11
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344591; cv=none; b=o0CkCPasHytwlIG9din3YM2x9LzryeJZuhIC21u8J36yK7e9YUn+J9YRvTnnYWM2acfgzN2TsXF9TNIqHGTKJc+Fvco2rVhNDQrjQS9eWTGpbHPoVH1OwOaTaV2Jgz32vbMDx1/ly0L+KG2IR/A+x8WHj88IzqoTopifyLF6VUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344591; c=relaxed/simple;
	bh=PmUJT3BxNcBafKXq/GYR+7FSYt60adrZifuvI6AsW+Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fdqHUCAh/4o5HkmBW0Cgm1IgeEPQJ92aaeXoK/0v7zQ90VO4+hB+lsBUCyVvVQC80nqLIA+n1ClQIcoxJD2G5ntxQaldNl93Txhwwgu4g5GeKcrWq4SNn4Ud1BwJSjT/OfLrJmHrez6d5B/Lq+AtWOcdIVBhc/ev+T6+l90hkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SyC/EMJf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SyC/EMJf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bea3b0d83bso7635273eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773344589; x=1773949389; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lQ+jaN3RhB7p55xf2iTw/I8EcO4O2opA0hAzWnZxrZY=;
        b=SyC/EMJfEawCMnMAYy9lPwsQZxpKBkF6/qnyqPhvZJYn1dmnwV4j5ZCj1zGrB7ZFxw
         3Qu+ePB9HzqhUH7+lWiTJa7dnEpL/yEJYx1Y6/lnEm7Tz2xHUFxfdNjhLLKc7h93DuHT
         shIt//mYaLD4xSU79mhobDY6iBgooid5Rj+2EVJ26UHK99jrF9Znnf0XKl/UsnWLLl/w
         xHXU7R60xrwfihBsy4szv8/yvQC4p0uXJ8YtSxYE2cVqtZx0/n1YEsB7Ax3j5MHJZn5Y
         VRDgc396ADcWD0xEV1D7PRUUxYSxjYkM3RQO3WCBgg0dLprVIbNQQ+lfQPxxc2pTww8r
         JoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344589; x=1773949389;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQ+jaN3RhB7p55xf2iTw/I8EcO4O2opA0hAzWnZxrZY=;
        b=mMixS0Qk35ogNQzfu2qPggJ3LFot4kEZ1TQcLn6CqNzgs64SeB30ShZYGQpjyEJSoV
         5Js0ODbuWKt27RIvgdTxLwjjzkpvtYmBG67ax4EM1qFx5dgdP3W/4BOiaUub9sKYTGJj
         3xcggUZOYIegDr2M4QbAvc/zwNst/xHbrYceXPsTSvGrYebEqf4P6P477Jv5RZ9QLDnk
         OhOKgR8vI2GREBYv2VW0oEuZfylmzecFUnFtjlnMJaYfIAzkQ9k3ch6M/wwGYpgKHzKb
         iBwzkdfz7zfTOmqHwg08ToibUaO933aaLIOEJWY+q8kip2cA5ik+WCXXDk4g5HG/MFhL
         lwiw==
X-Forwarded-Encrypted: i=1; AJvYcCXiFkjxr5rUESMdDlkUYABXsX69ua+bXsv1DnsWAL3jv/lXQMFaUhXdPPY6SPhvQ23fuBW/JWBPUXnvrC/dXLd4@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1hrt8hy2RrHuMPtkcPuSlruGoHlFUmoyIFXJ8kS3szueUPzR
	MMm4w04tHwsGFXNp2pl7YmxJGeR33FzH2EkPq6wFuy9UGcBCtn96DTu7VJgzelGsJ1IrzpB3mvK
	C6OlvoHD5Jg==
X-Received: from dyt24.prod.google.com ([2002:a05:693c:8098:b0:2be:6911:c4f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4085:b0:2b7:fa47:3b37
 with SMTP id 5a478bee46e88-2bea51694e8mr439311eec.0.1773344588552; Thu, 12
 Mar 2026 12:43:08 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:43:05 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312194305.1834035-1-irogers@google.com>
Subject: [PATCH v1] perf/x86: Fix potential bad container_of in intel_pmu_hw_config
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Auto counter reload may have a group of events with software events
present within it. The software event PMU isn't the x86_hybrid_pmu and
a container_of operation in intel_pmu_set_acr_caused_constr (via the
hybrid helper) could cause out of bound memory reads. Avoid this by
guarding the call to intel_pmu_set_acr_caused_constr with an
is_x86_event check.

Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
Signed-off-by: Ian Rogers <irogers@google.com>
---
This fix was prompted by failure to get a BUG_ON in this series:
https://lore.kernel.org/lkml/a61eae6d-7a6d-40bd-83ec-bd4ea7657b9d@linux.intel.com/
and so I ran an AI analysis to see if there were similar bad casts as
spotted in:
https://lore.kernel.org/lkml/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
The AI analysis found this issue and its much more verbose
description is below:

I have evaluated all callers of the hybrid_pmu function within the
arch/x86/events directory. The vast majority of usages are safe
because they operate on an event that is currently being initialized
by the x86 PMU subsystem, which guarantees that event->pmu is
inherently an x86 PMU.

However, there is a distinct bug where a non-x86 PMU (e.g., a software
PMU) can be inadvertently passed into the hybrid_pmu function.

This issue occurs during group event validation and configuration in
intel_pmu_hw_config.

The Vulnerability Flow

 1. The Context:

Inside intel_pmu_hw_config (located in arch/x86/events/intel/core.c),
there is logic to handle Automatic Counter Reload (ACR) capabilities
for event groups. The code needs to identify siblings that cause other
events to reload and apply constraints to them.

 2. The Missing Check:

In the first pass through the sibling events, the code correctly
checks if each sibling is an x86 event via !is_x86_event(sibling)
before building a cause_mask.  However, in the second pass to apply
the constraints, the code iterates over all siblings again but omits
the is_x86_event(sibling) check: arch/x86/events/intel/core.c#n4847
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c#n4847)

 1            if (leader->nr_siblings) {
 2                for_each_sibling_event(sibling, leader)
 3                    intel_pmu_set_acr_caused_constr(sibling, idx++, cause_mask); // <-- Missing is_x86_event() check!
 4            }

 3. The Invalid Cast:

The intel_pmu_set_acr_caused_constr function takes this sibling event
(which could be a software event) and executes the hybrid macro over
its pmu pointer: arch/x86/events/intel/core.c#n4624
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c#n4624)

 1    static inline void intel_pmu_set_acr_caused_constr(struct perf_event *event,
 2                               int idx, u64 cause_mask)
 3    {
 4        if (test_bit(idx, (unsigned long *)&cause_mask))
 5            event->hw.dyn_constraint &= hybrid(event->pmu, acr_cause_mask64);
 6    }

 4. The Root Cause:

The hybrid macro expands and passes the event->pmu to hybrid_pmu:
arch/x86/events/perf_event.h#n788
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n788)

 1    #define hybrid(_pmu, _field)                \
 2    ...
 3        if (is_hybrid() && (_pmu))            \
 4            __Fp = &hybrid_pmu(_pmu)->_field;    \

Which subsequently results in a blind container_of on a non-x86 PMU
pointer: arch/x86/events/perf_event.h#n780
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/perf_event.h#n780)

 1    static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
 2    {
 3        return container_of(pmu, struct x86_hybrid_pmu, pmu);
 4    }

 Conclusion

If a user creates an event group led by an x86 ACR event but includes
a non-x86 sibling event (like a software event), the second traversal
in intel_pmu_hw_config will blindly pass the software PMU to
hybrid_pmu. Because container_of assumes the PMU is embedded inside an
x86_hybrid_pmu struct, the resulting pointer becomes invalid, leading
to memory corruption or an out-of-bounds access when attempting to
read the acr_cause_mask64 property.
---
 arch/x86/events/intel/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cf3a4fe06ff2..26e829b8a882 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4844,8 +4844,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		intel_pmu_set_acr_caused_constr(leader, idx++, cause_mask);
 
 		if (leader->nr_siblings) {
-			for_each_sibling_event(sibling, leader)
-				intel_pmu_set_acr_caused_constr(sibling, idx++, cause_mask);
+			for_each_sibling_event(sibling, leader) {
+				if (is_x86_event(sibling))
+					intel_pmu_set_acr_caused_constr(sibling, idx++, cause_mask);
+			}
 		}
 
 		if (leader != event)
-- 
2.53.0.851.ga537e3e6e9-goog

