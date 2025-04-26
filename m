Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5D13A244
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Apr 2025 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626444; cv=none; b=XPTcljAqHZHExmGEgDhriHBlXaOtcJDGqY7OMrvIENA9oRYgeoY5KPrCvJidUqp/igjTXbtOXYxbtbxC7ZVvZpPEVEBg98A3hhK8YSkhWuMcmp3KI+uRENawtyFCI/GgILTfQuiGaMZvpSo+wnOEgx/UZW89wHU8Ij7d9bY4dH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626444; c=relaxed/simple;
	bh=5ZI1miHdJz7wfQVJ3AKTnq8ZxdU0aecNlHa6tzNWZxE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uLSh0nJhHSyK9efgIVV3z6TMTolzeS4PXTFlVF1u8R42PGybs/WdnLvAobTk8szDC1c2lPY7Gqf/ZyLpunstXPBgSox6hAMlggtPNviKB7RYP4i/wMhmfpgPdBy8RduoG2QGAu8d+Ki8EDsTqo/hpCguH/Tj4TD4oXiwmopw0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lybnRj71; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lybnRj71"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2265a09dbfcso42153425ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 17:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745626442; x=1746231242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxpVCBLHTfcLtbj0gBx4eYSK7GUN1WhxDLmW+4nAY1I=;
        b=lybnRj71bcsgCzrsxS62lOXwTsxB+aoTRgUedTWvZQ9SQHi9YkxQyifFe8QytC+RcE
         sZd4BWyrzwf86MXgPEV95GYGbwxwF39To/u0H+/WPtO/YA19J2x74vjnbZineKCb1UrH
         FMAOoqKx5v94b3MA6C8QideorQoXqRksdlebX1KnS2LVqkKc+vgnV/Zurjmi7NOGywNr
         D0wvtSMkf48+HLkg+9ZE1rK4b3ds6mHOvL7R56SST9YUon9eEdP660N7W/jLruMzJ3dT
         Hwiam5MacLwrfznZPk7/d9uAd7mpPKTpqSuVogjS3JjOovkbQ79kWqg8MY0JBcMLC0cE
         d4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626442; x=1746231242;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxpVCBLHTfcLtbj0gBx4eYSK7GUN1WhxDLmW+4nAY1I=;
        b=fwhB7hzEs1/XmT0+PKlZGxmbX+BPWOBM547Jee0gzRWfTyqot3a9IpMBG8YmSYnbDC
         SOYxzHRSLEjoThd55inZLW80jGcYWCwxcYLUq7nVE0Ey7+qLGqFPA9ryQY4wax4HQfzq
         Kzy6a0fiPEw4iOoVfVFysgWLa5dNqGYzklbBIym90hkcvqmpBgGMGzEygIbJXKxKMHvC
         hzCQAjc+wrUVaKt5xZfTfaUvopA46eoSqGlCbUvCKxCIU6fUYYeycnsnwoMVV66i1Dsm
         XA00eHLZTim2QKM98nPZ1zFwxRxXMAX+X1i7pe3TxAJnMzghSsiOZR4LCDDHCeuNs43/
         eTjQ==
X-Gm-Message-State: AOJu0Yxv+7/5HSLBVgoYstx8qs5FPw7aCtrNN0MA4BFBqNQp33JyVi0p
	q23Q8irQXMwRGG0KulL0d5AU6f+amEmfufg+0eut2ITd6yUbcllxZRA8h00LVYxehw6nVUjgmKd
	dYQ==
X-Google-Smtp-Source: AGHT+IE2zeHpQPZegtnClFnzj4+h59uTeKaFQ58TNuLPt2n5wY8qYg8PRH47N7frx+oBKxsilN/R1JEII2E=
X-Received: from pgns27.prod.google.com ([2002:a63:925b:0:b0:af0:e359:c50a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4f:b0:224:24d5:f20a
 with SMTP id d9443c01a7336-22dbf740c03mr67564265ad.48.1745626442696; Fri, 25
 Apr 2025 17:14:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Apr 2025 17:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250426001355.1026530-1-seanjc@google.com>
Subject: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest with
 vCPU's value.
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When generating the MSR_IA32_PEBS_ENABLE value that will be loaded on
VM-Entry to a KVM guest, mask the value with the vCPU's desired PEBS_ENABLE
value.  Consulting only the host kernel's host vs. guest masks results in
running the guest with PEBS enabled even when the guest doesn't want to use
PEBS.  Because KVM uses perf events to proxy the guest virtual PMU, simply
looking at exclude_host can't differentiate between events created by host
userspace, and events created by KVM on behalf of the guest.

Running the guest with PEBS unexpectedly enabled typically manifests as
crashes due to a near-infinite stream of #PFs.  E.g. if the guest hasn't
written MSR_IA32_DS_AREA, the CPU will hit page faults on address '0' when
trying to record PEBS events.

The issue is most easily reproduced by running `perf kvm top` from before
commit 7b100989b4f6 ("perf evlist: Remove __evlist__add_default") (after
which, `perf kvm top` effectively stopped using PEBS).	The userspace side
of perf creates a guest-only PEBS event, which intel_guest_get_msrs()
misconstrues a guest-*owned* PEBS event.

Arguably, this is a userspace bug, as enabling PEBS on guest-only events
simply cannot work, and userspace can kill VMs in many other ways (there
is no danger to the host).  However, even if this is considered to be bad
userspace behavior, there's zero downside to perf/KVM restricting PEBS to
guest-owned events.

Note, commit 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily
in two rare situations") fixed the case where host userspace is profiling
KVM *and* userspace, but missed the case where userspace is profiling only
KVM.

Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
Reported-by: Seth Forshee <sforshee@kernel.org>
Closes: https://lore.kernel.org/all/Z_VUswFkWiTYI0eD@do-x1carbon
Cc: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd6329207311..75a376478b21 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4625,7 +4625,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	arr[pebs_enable] = (struct perf_guest_switch_msr){
 		.msr = MSR_IA32_PEBS_ENABLE,
 		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
-		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
+		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
 	};
 
 	if (arr[pebs_enable].host) {

base-commit: 2492e5aba2be064d0604ae23ae0770ecc0168192
-- 
2.49.0.850.g28803427d3-goog

