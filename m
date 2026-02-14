Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE0299A87
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Feb 2026 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771032453; cv=none; b=NLqqRSIlPeK6hji5GaMzbnHm5iVwy1tq1rDsJAr1DsVfBCE3w41FwJCOOZqPgO9XRH3zP9iNywzDXK80XpbhjetxesJXXBNkbCTRst76Vqx/M5gOTwezPrC/BY6bP/2OIjAQqbSynyh4u/rxUbv/hTZ7Otm8rQ2CR/cgHEJu5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771032453; c=relaxed/simple;
	bh=2jURTAzz81y5fmKZ0nkZ+MRnOfqPxSPZP5ZzXKImRwE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8w33FpgSUzMv0oM7E1o1TFDqcoXDLDyYSBD9cDoXRNv8Iz5DGPtnfuGgZVDhUKsBSZGfB+USksTjuYy2K05hQYlfq5n2IJppNXH2juoJnH2zkTxMO0yuDSOFs3Hoor4emsbyzDzH1c7XtUqKoTFcwTUMg+YRDQ3FdytPaEBTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oPrtfbDX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oPrtfbDX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aaeafeadbcso16554455ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771032451; x=1771637251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hrsNdfLewzqAJ4j/aZKlf6lqr1ErBy4WWW6V+vzZ7i0=;
        b=oPrtfbDXpFGF+Nvkp/7SPz/60rjY57PFvdBOlFwHU5fwCuBzhGjsGWna5Im7oClNHv
         MJGiWSypeq8hFLRPSuY92UbEomAGadSJGH87KJUMwMEBJ9HZHG9yF6ZwFGdK3YjlxEXe
         GicFYao3t4s9zoz42mnUn0IcW+gxrpVmk/T8BVTAxyuFORmQP21G1lae/Eq6rQbwR6IR
         kxMJWhfQHvSi/5t9uneEPMh1ImLYKeaSa2tysv5066X5Lp2FI+bUPXENiK7eX5KHqRoe
         xM/VPZKpDsPq2xXKNsyd8aOIckZB3c8kz61rUloAV+AK0oJPzCTh9h2lARHmEYT2upOO
         HKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771032451; x=1771637251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrsNdfLewzqAJ4j/aZKlf6lqr1ErBy4WWW6V+vzZ7i0=;
        b=st3rLgpo7/WkaEFUfZGGQV7Mv0iMtoSEK1wcGa41waOzyGvd2kre+51eR8IXOEe8kg
         Vw3aq6YTwKsqWCkXX+mrTyEexKUL2c5bw4F54jr0k7fP+N7/cXe2qXT59CoeDBL17Tcr
         cEimBNfkNKKBcbTxh3eF4kzF03/zf561skE77WXMGK0CIvyigeGzJdkFVo9pI08vLIaH
         A2rHyEhS7RFvzPR48k6qLVRgQEFw6a3QhPoAhDCqLbM/6AtxqV73zS3EUCQaHlf7Yn1K
         SdaszzM962uO31Rx7szE4FnFMyzEyeumm4/0AkgghVDcJy7Y0J9CnYc3k2FXG+SHJmJd
         xx+g==
X-Forwarded-Encrypted: i=1; AJvYcCXfdPVRyZC9qH4aYC0H9M/i9d6YcR/M/GglmsWP/2PgrF7YmGyVDKS3rXgQsW5129JqH3lPgY0a2E1ZYUiXfXAF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5oCeWyI7sDwpwBO0MaCblCXQ3DvSkPIFGggLW7BIH3L4gh0J
	cW04iBUZubdN0kGzVu2PM1CfDhdaTz4S7NZhtfnT8DWvDTQgC7BLg43REi4b/9//zlKhzDEsSGn
	dIcbsPg==
X-Received: from plqu18.prod.google.com ([2002:a17:902:a612:b0:2a7:8c71:aa97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c947:b0:2aa:d647:b3ed
 with SMTP id d9443c01a7336-2ab505bd0fdmr36326685ad.34.1771032450744; Fri, 13
 Feb 2026 17:27:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Feb 2026 17:27:00 -0800
In-Reply-To: <20260214012702.2368778-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260214012702.2368778-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260214012702.2368778-15-seanjc@google.com>
Subject: [PATCH v3 14/16] x86/virt/tdx: Use ida_is_empty() to detect if any
 TDs may be running
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

Drop nr_configured_hkid and instead use ida_is_empty() to detect if any
HKIDs have been allocated/configured.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ddbab87d2467..bdee937b84d4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -59,8 +59,6 @@ static LIST_HEAD(tdx_memlist);
 static struct tdx_sys_info tdx_sysinfo __ro_after_init;
 static bool tdx_module_initialized __ro_after_init;
 
-static atomic_t nr_configured_hkid;
-
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -194,7 +192,7 @@ static int tdx_offline_cpu(unsigned int cpu)
 	int i;
 
 	/* No TD is running.  Allow any cpu to be offline. */
-	if (!atomic_read(&nr_configured_hkid))
+	if (ida_is_empty(&tdx_guest_keyid_pool))
 		goto done;
 
 	/*
@@ -1545,22 +1543,15 @@ EXPORT_SYMBOL_FOR_KVM(tdx_get_nr_guest_keyids);
 
 int tdx_guest_keyid_alloc(void)
 {
-	int ret;
-
-	ret = ida_alloc_range(&tdx_guest_keyid_pool, tdx_guest_keyid_start,
-			      tdx_guest_keyid_start + tdx_nr_guest_keyids - 1,
-			      GFP_KERNEL);
-	if (ret >= 0)
-		atomic_inc(&nr_configured_hkid);
-
-	return ret;
+	return ida_alloc_range(&tdx_guest_keyid_pool, tdx_guest_keyid_start,
+			       tdx_guest_keyid_start + tdx_nr_guest_keyids - 1,
+			       GFP_KERNEL);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_guest_keyid_alloc);
 
 void tdx_guest_keyid_free(unsigned int keyid)
 {
 	ida_free(&tdx_guest_keyid_pool, keyid);
-	atomic_dec(&nr_configured_hkid);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_guest_keyid_free);
 
-- 
2.53.0.310.g728cabbaf7-goog

