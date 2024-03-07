Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FAC5C82
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774032; cv=none; b=bCGYMHVw2rRqSLx6IrTA0hQm4xK58O0BzbA/Jx5Kq+XXr0UuMMEZxUgGihrRQNvkkNSRXlkgVjXMKzDK3tRY/tvTd7Hn+YWXy0aRrm9/ahxdtQEs/GaJJW7uPkx96Qrskk4fc1wZ5MUVngYbPzqjNS7VQAs2C/2/ghhsEdXO1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774032; c=relaxed/simple;
	bh=pDYlO6655RQWWCS62vtsbuYOY+fbm6Nz4LPdmuV/H+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZnksjOT4A7PVcpRp9dYgzZD/EyHtC0jOK/cVln3xUOAm3NeL4dlaHv3RnQ0U3oKkPzUrjjQnaYqAXQcnY38bVzPPHBy1+2b0VAJUOgNsXM6LoTFeLizv2RTTAuKJPLdtfr5TLtj0JFcIAEPHr3XwsVf/6D6KMhjJPHtGAAMhmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HxaFGzxn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxaFGzxn"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dcbb769a71so361907a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Mar 2024 17:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709774030; x=1710378830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=URdnb8no/gejybKx7VpZ/WZV3Jy5gWivUnugYsUgOO8=;
        b=HxaFGzxneQWmKhHlBPb3/ZGmN8weGbFF+vRusrGdXoi+BN9wZ6aMUk6zH5avbOpg5K
         jGYyQAtvJOs0ddJUG7Shxg4LAjXU07jE1GU9JZw04SyRSCyLuxlZ8zJNsd6oareD+t5D
         9/sTof9JyzIoYm1co0jxgyg88QA17kLEAnkdd2YpmdpzEA4Iva4AwOaaJucMn+amknHA
         XVFJSH8g/mbqKQ7bw/IrPHl/bY2oe17FbqQJ+micIJGEEwrGPXv2zOtGgDmyLTOHQzcr
         UFhT5/xDAIBxCz0lzvOMQe1rHXr20XftgZ2uObJGKiCf28K48olJTweeEokfl0q6jOpe
         /sYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774030; x=1710378830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URdnb8no/gejybKx7VpZ/WZV3Jy5gWivUnugYsUgOO8=;
        b=J/kmmSqCpOzn9R7MiLV0uz2hpXYY155OFdKnp9dUMG0+1AjaIM62GGGF0RvncfBWCg
         ZfzXg5Cx82OPY/7L7hcoh0hWGd+F49NpmvZ87Lhj7fovEawQxtqIAlJxvrtQfM6W0ImW
         DspklQNsKowNS7ZNVCTuQJRHUdH8kpaTl7UvfZb4JCIu3EgrQaXZ0KcElQW1HWXCCxNy
         r5VzGZPkpVgOCnZa9zypJrTlm7AMUlGV0jw+ggApWBXES+Hz97HbDfco3jYZX0QtAATd
         WCvEPoVJ2qWD+ASUa4MMvM6BaCBgC0WExSQeDETmMSZMzhCt/0soHXHex0bEqsGnw2p0
         3AqQ==
X-Gm-Message-State: AOJu0YytdbZErstY1tJXgz8FmEoqWCrAvvI9Xi7ZYHdomcmI5AjMR3dL
	O/FUJQIl2pt+XAM2Kk2iXrLCsyON6vgiIfS1TpBu2zUrj5HnBIitxKiRkoSScoM8t5hEYuL1zCn
	d+A==
X-Google-Smtp-Source: AGHT+IHE3hLUtN9mAa6biOVT2TlEtSXabGraYG0Zvf7THAU106ApQjXZwsK1IkK5O6pSCZp8GdlGKQw1rTY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:f87:b0:5e4:292b:d0eb with SMTP id
 dq7-20020a056a020f8700b005e4292bd0ebmr39689pgb.2.1709774030473; Wed, 06 Mar
 2024 17:13:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 17:13:43 -0800
In-Reply-To: <20240307011344.835640-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307011344.835640-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307011344.835640-3-seanjc@google.com>
Subject: [PATCH 2/3] perf/x86/intel: Expose existence of callback support to KVM
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a "has_callstack" field to the x86_pmu_lbr structure used to pass
information to KVM, and set it accordingly in x86_perf_get_lbr().  KVM
will use has_callstack to avoid trying to create perf LBR events with
PERF_SAMPLE_BRANCH_CALL_STACK on CPUs that don't support callstacks.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/lbr.c       | 1 +
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 78cd5084104e..4367aa77cb8d 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1693,6 +1693,7 @@ void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
 	lbr->info = x86_pmu.lbr_info;
+	lbr->has_callstack = x86_pmu_has_lbr_callstack();
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3736b8a46c04..7f1e17250546 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -555,6 +555,7 @@ struct x86_pmu_lbr {
 	unsigned int	from;
 	unsigned int	to;
 	unsigned int	info;
+	bool		has_callstack;
 };
 
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
-- 
2.44.0.278.ge034bb2e1d-goog

