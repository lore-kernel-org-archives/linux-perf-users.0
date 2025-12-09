Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BE30CD93
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765313575; cv=none; b=IIw5H3mllZeQZWRUGOq/fKTqamb2/t1WDfhDUntkcyJJ9WJqYrLFbTZ1HIYUo93xKhU4NcjONbWnU+wF57oTOu+fNXZuTkY6l3/MrEzaJzyPFf2QnRmAQxgfKz3hEQrk36GoP1JZKawHrRpDvhfr+/5ht1UZYVm7Fsyslm8a0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765313575; c=relaxed/simple;
	bh=L6JRHNao9Dv2st9IstObJcFX6EfxZz6LafDaZCOeTJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cXOlgszXm2DovGu9+bXeCqM+1pMRccNqgWGR/TOZzuuRUjCz2qUZHylTs3rd13A4IGcwNleGlqVaDhMW/biFwBmpGfNyp1PztIn8PsgTC8f7ArRYE10pQwFlN+74K4F/UkAoZyxvYq8LKJdqB6aeIx8Qyf0e27AlzoUT7TiydwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTA237n3; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTA237n3"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3e88de1d93aso7193457fac.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 12:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765313562; x=1765918362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zQsEiABUjsdMkMEnByRoAgIWKd7GLr6DjLwzP+aDHY=;
        b=tTA237n3Vh+t0TIlK504bUJ84TNu3JyywoJOfI6da3cEuIcPDmvEBP055LtGPDiUQ8
         sPg87QSnOrZGUAD5KqTXFD1MV/+XIws2NjpIHidBrZcuyDlxl1+sre2N5ziwwb1/1j0s
         VgOAOJwCdAjDOTXYYcBhKOyJg2dwDqlxKUxgBK/dO0JQvyLFjDg53pk2EcHxDennl1im
         X1AKM4Tq2abZFcxxHKHvGPl/fpODydG/lhq/GDqLkYg0l8qYXxOVobanLKjGkLyQDUzZ
         MRFr3hkKh3qTeFVJZo5YeSzETycwsB/7Tq4ABxzdfZq/2trtFT/PF/m3QhsdODZbyJdE
         awSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765313562; x=1765918362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zQsEiABUjsdMkMEnByRoAgIWKd7GLr6DjLwzP+aDHY=;
        b=YS6/+ZXYzGPw0ZmliSEWykJdlsxocDWDbKrGuXjowUV6BEJQGV3nVBcAtgpX7tDdAA
         Y/0W8V/7aHJPeGoeE4V8xCaNVAWZ//ZcLNTH1eg2PlYs09s+qXyuTibvKF4NyVqSX0r+
         IwNFo5KXdnpoI8Q3BCV03XN4YyKd8HxAvRUTFDLEsiHVNxyjohHGT7jVkunRqe1FOuKz
         PvLvSKRLDELc7GJjPmnmWd2mFY7ZzexpJvk+GVDurcpucpNywjQ7IArZSfq4WrtVbZEQ
         H8NXzzr7mZTlYMZCoUYy9eSZqwy/Rbgz28Kt0QZyKuTwLaxi7CHXa3EnUTllkpn4oOzF
         sDPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7z7YDtP+8cun1/6tjqWbddfDqcw92BtnO+wZSD6mtgqbrJWQbVb8iWpYfWWvNtw9hEY4exes2v6Fji2i2BtOd@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAWBq4OWoS330pHNNCQ5QnW54DR8C8O2C1N7Hadhyol+wscye
	adbYzRDZT60+14miTqj3nxh05RGx4YxKhnfyxTMWMqAiXCMpiC+BdfBEGt7ILd5ZA+lC6x+hugN
	134/cl8hXTfPsaOMRAMmGF+e6rA==
X-Google-Smtp-Source: AGHT+IFRKHeoUmjGuNFSlsmzEp/JswAlPAyHOqJKqkJs0+bQVeMX9v3ykC4h/RUbKQXV9XNTVLE12IZWXk6mEzWBCQ==
X-Received: from oahn5.prod.google.com ([2002:a05:6870:3485:b0:3ec:4657:83cc])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:8208:b0:3ec:3b3e:4f38 with SMTP id 586e51a60fabf-3f5bdbe25e0mr227516fac.36.1765313562359;
 Tue, 09 Dec 2025 12:52:42 -0800 (PST)
Date: Tue,  9 Dec 2025 20:51:13 +0000
In-Reply-To: <20251209205121.1871534-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251209205121.1871534-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251209205121.1871534-17-coltonlewis@google.com>
Subject: [PATCH v5 16/24] KVM: arm64: Account for partitioning in PMCR_EL0 access
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure reads and writes to PMCR_EL0 conform to additional
constraints imposed when the PMU is partitioned.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/pmu.c      | 2 +-
 arch/arm64/kvm/sys_regs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 1fd012f8ff4a9..48b39f096fa12 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -877,7 +877,7 @@ u64 kvm_pmu_accessible_counter_mask(struct kvm_vcpu *vcpu)
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
 	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	u64 n = vcpu->kvm->arch.nr_pmu_counters;
+	u64 n = kvm_pmu_guest_num_counters(vcpu);
 
 	if (vcpu_has_nv(vcpu) && !vcpu_is_el2(vcpu))
 		n = FIELD_GET(MDCR_EL2_HPMN, __vcpu_sys_reg(vcpu, MDCR_EL2));
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 70104087b6c7b..f2ae761625a66 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1360,7 +1360,7 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	 */
 	if (!kvm_vm_has_ran_once(kvm) &&
 	    !vcpu_has_nv(vcpu)	      &&
-	    new_n <= kvm_arm_pmu_get_max_counters(kvm))
+	    new_n <= kvm_pmu_hpmn(vcpu))
 		kvm->arch.nr_pmu_counters = new_n;
 
 	mutex_unlock(&kvm->arch.config_lock);
-- 
2.52.0.239.gd5f0c6e74e-goog

