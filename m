Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAFC2661A6
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469927; cv=none; b=nv6jV1/mNOSkaRJHTKc8HWeF3aIb7Tzn/6XuNlhbygS6BXlisKdmqE6Mub8j6ke7tpYfLA0JO7MWb9W410bLiArUzJho4AZIr03aTrdVwjZd6tWYzH+b9fNcrvTWGNE38ZIM3JBGVHXBmPXX76lYHxrGHjOQ/SZ0jFUoG3JI+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469927; c=relaxed/simple;
	bh=hbnkoWg3lv/YYFKHJvhomB8fITcWyPweyE8n5wrds+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=enXopxFldMyThoKA/B87HvG6fSCVbhBOVY+lD/vHgvgEVbit1KHgbRgeWY3I27nQaWiO5W/EKZ0P7U4eBXB+0azXtceB06WesdgqFPX4pJ44HsSVjeNbzpD6GLyl/Y9jZvyMg/MpCh9M5uBsiEep3EVyukpsGqK4htd/BY1dsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wipzcNqm; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wipzcNqm"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3d05b1ae6e3so8243805ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739469923; x=1740074723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UWZgB5w3eSM0BtzO18X6A2qHryHBneRbetiSxyPOf/w=;
        b=wipzcNqmx+gDasdjqsJack+VlJBK6mYn21wTLYY5BT78x79MSC+bUhb/n8p4PR+gR/
         kA+VZ7A5Ku+gtXFWw410CYJwCWaDrgyjeM0ECVJGICL8juGGG0kDTbp/gWXG0EyYbaF8
         ikGGHCnryp3RRDsttP6tFv0y1q4eB7PBd63AEfWU3c5OvLMFEKd+lbeHOEv7I0EXyc+i
         yQFL3TaRRqDz51Sxjkxpkhqa6XzMbk/xF+yzuy95oRJuT4DEKS5Cr9RKOcQ2Y+VC4xX7
         jHXOoQwrYWhM87ZfG8pKOsvY+CIGfSkXjR01zyroYeAAFaxLkSlbEWe5PcYfykMmQ7bz
         Wymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469923; x=1740074723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWZgB5w3eSM0BtzO18X6A2qHryHBneRbetiSxyPOf/w=;
        b=cIWQE9fl3LweGBv+OUATfcbs74VRO8jTXGx27BOTJiqiwTJwpp6I75FGrbGeXOivqm
         Ch0FLY7yXPg9I81labc4x6Ro5iWVgQc5ynIlfaXkr/5fVGZ7B+fIKuRTUItb8QDIWH70
         ALBKQDoPmirpw/QvMOTEWhGo3b6pSVLQ105Z0hHnbv8SBpKRueimFdkSp7/o9ew3XUBf
         Vh51ySDuBQO30pXOHYQ4DMBFERMNjx5TO1s85Tep4rTJUKGM77F4/UOXiLL2BoMnUDkC
         aR3kBnAcY6aN7mcczlZlvcJkk9FX5d5AdolL1XwtKrgn0tm/FIofoBitdD9Xs64/R0y4
         jZww==
X-Forwarded-Encrypted: i=1; AJvYcCUDLT13x9Jvehd4wIv2nextZyk5d3qynjyGo0WudBwmOaPgipKAOWsWVleIgMW0LmvDLt52ZN+kJLoI2owadrjy@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWPj3HTo4LwIrPMKKKkZhw5vlCWQv76/gKhnFY5fLDFi6G8mF
	74QqKUAepTNIM3qTNzhS/15nCfHTYEZxCmebeyVRoDMOGT1hyXUw68B28Dv+s18hjy2AqG0Ox62
	793wXLeX7/XVNs/i7zbt6VA==
X-Google-Smtp-Source: AGHT+IGInJOaRNM/UmxApk8AjirtA1Ey5wL5ojkxOBaGdRUfXbOtlN+CuOjjpt+ni2zL9WpitRvyEXXQjjs//eksWw==
X-Received: from ilbec25.prod.google.com ([2002:a05:6e02:4719:b0:3d1:8322:8ecb])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:144f:b0:3d0:47cf:869c with SMTP id e9e14a558f8ab-3d18c31c4e8mr35827555ab.19.1739469923254;
 Thu, 13 Feb 2025 10:05:23 -0800 (PST)
Date: Thu, 13 Feb 2025 18:03:17 +0000
In-Reply-To: <20250213180317.3205285-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213180317.3205285-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213180317.3205285-9-coltonlewis@google.com>
Subject: [RFC PATCH v3 8/8] KVM: arm64: selftests: Reword selftests error
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

It's possible the host has that many counters, but HPMN restricts us
from using them.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/arm64/vpmu_counter_access.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
index f16b3b27e32e..b5bc18b7528d 100644
--- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
@@ -609,7 +609,7 @@ static void run_pmregs_validity_test(uint64_t pmcr_n)
  */
 static void run_error_test(uint64_t pmcr_n)
 {
-	pr_debug("Error test with pmcr_n %lu (larger than the host)\n", pmcr_n);
+	pr_debug("Error test with pmcr_n %lu (larger than the host allows)\n", pmcr_n);
 
 	test_create_vpmu_vm_with_pmcr_n(pmcr_n, true);
 	destroy_vpmu_vm();
-- 
2.48.1.601.g30ceb7b040-goog

