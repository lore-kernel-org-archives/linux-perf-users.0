Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A928FA9A
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032431; cv=none; b=hkW1V8fxTIXvQjLuY60YF3f6/VJeq8QXHNaw5IgogJk7jI6cEiyRufvAGVJPp38rKPafc3fbY6xQ/cAetiMw3FuziqU68lO1+LtvpjU0p53jUUmaesqlDiNjjrNftw+erU/x4K2b2km8sWYFo/EfLeOzfNso9tmJoEMPInZ6tJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032431; c=relaxed/simple;
	bh=uHRBT0xtiTkIZnuHIJP94+r3B3sUuzdcITtjzmdIZxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NoMFfbvbH2fAFPgguzA99NxGzuD/E/tz8VZSFAN6nrEZdQAdd8GdIt08HfpuzCAiFGg6nZen+97c7OmoCK/lYE54au8/c6xz/ZB86irUndIRX2evsvXPjfivDgrAvq7c6QU6UOVpVWgeYAAC4akGTMm5VXF/yVEfM9i8tEQa4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzbM1kmG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzbM1kmG"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aae146bab0so19377765ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032429; x=1771637229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RDtoclkNp4NWg025cIg81rPLzczzFSfFPqIQKO5nW/E=;
        b=AzbM1kmGvfonESNeM5gf/EkKtK14QmUOulaHH/TuYm86IiW+1usGe5/Qujy/9Z9M/a
         8StGD2vquyv9mlQC7jysNKFrluPX+TknqZFGe1Ia2f8yAmNnxqjOeJJwUBz7NQ3udBta
         u8GMB7uPEfjoH4ZSA2Yef2/TRr30VQdF/JJYwNOWUKF4ySU8JHoAsNdg5bXxq/xsugHv
         qEZS/yaLJUaWelLgwGTqgnBr/6QOeMVaDLw3vT9nZLGiAEQSFg3kyjAICWqhmcO9CiMe
         YB9r27WHLcdMkpTg7hLpP4/3WLt9Mv+jI6lVNxu+ZxvBaqyZC5aZhfO1dtMX3Jos/u9N
         rCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032429; x=1771637229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDtoclkNp4NWg025cIg81rPLzczzFSfFPqIQKO5nW/E=;
        b=NKYrJ0pMR6nVvRADY4z2breTTpvfl+jQkUVl1KggNvA5NFdBbItaxHGtHrlT1WFShZ
         4/I/ueqsqPPFi1SG7L1dHBOBD/GZuYwhZvonxtT1dEQfEycOr6zQiaTCfQt5Fkrr9n6P
         RHJROGKAQeUpbTuS4k5BqCGRrQfN9V1Q0tCy0LM3eXamMXBbGMiplMGQzmwa+VIIXCNB
         w4+MyvxpMY645Sq57tQBTsh2FxN1LYDuX1WQYqyFhDL0NcP+tZGe5bwL+luhDPhi1CDi
         FpJrdAE912dXfFC72GSAZVPUba6CVyw+wSP1hZB3g5tRMnKikcxL8eqPRMSaFEF+vFei
         MLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWArxsQ+u0BK42ddwqsZ3IhmGjDH/Kzp0TTuGnxZtVHoIhdyQPOXnmwphttSm5A9ZAG1Y7y4uotro/ZlFY/pQ9c@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCSdoj68pXakfc4zrYzm9FfZqTc6IdCXZtSgfAI1o2diKvNg1
	pQayIMH4BWx/1y3nr8SL3rKt5m86To5w0u1I06mDJjnwQ39/rtPsBIo23H5uq98C+Y1QkdGcBBV
	M9u4RNA==
X-Received: from plil7.prod.google.com ([2002:a17:903:17c7:b0:2a1:10fa:4a4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f609:b0:2ab:230d:2d96
 with SMTP id d9443c01a7336-2ab50521f49mr39916555ad.11.1771032429246; Fri, 13
 Feb 2026 17:27:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:26:48 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-3-seanjc@google.com>
Subject: [PATCH v3 02/16] KVM: VMX: Move architectural "vmcs" and "vmcs_hdr"
 structures to public vmx.h
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move "struct vmcs" and "struct vmcs_hdr" to asm/vmx.h in anticipation of
moving VMXON/VMXOFF to the core kernel (VMXON requires a "root" VMCS with
the appropriate revision ID in its header).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h | 11 +++++++++++
 arch/x86/kvm/vmx/vmcs.h    | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index b92ff87e3560..37080382df54 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,6 +20,17 @@
 #include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
+struct vmcs_hdr {
+	u32 revision_id:31;
+	u32 shadow_vmcs:1;
+};
+
+struct vmcs {
+	struct vmcs_hdr hdr;
+	u32 abort;
+	char data[];
+};
+
 #define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
 
 /*
diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
index 66d747e265b1..1f16ddeae9cb 100644
--- a/arch/x86/kvm/vmx/vmcs.h
+++ b/arch/x86/kvm/vmx/vmcs.h
@@ -22,17 +22,6 @@
 #define VMCS12_IDX_TO_ENC(idx) ROL16(idx, 10)
 #define ENC_TO_VMCS12_IDX(enc) ROL16(enc, 6)
 
-struct vmcs_hdr {
-	u32 revision_id:31;
-	u32 shadow_vmcs:1;
-};
-
-struct vmcs {
-	struct vmcs_hdr hdr;
-	u32 abort;
-	char data[];
-};
-
 DECLARE_PER_CPU(struct vmcs *, current_vmcs);
 
 /*
-- 
2.53.0.310.g728cabbaf7-goog

