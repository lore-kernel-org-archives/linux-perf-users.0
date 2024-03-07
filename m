Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD744C6C
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709774030; cv=none; b=pnGKpAKkYKd8MbmpalA/pF+G6XpyTOwZyZzUfwZIwBNaubm+q2cd2wNmM7+ziGN6EJ1bs0voF4WU462KbZf3e/2I0snoKLX5gzHw12c+FvRSr8Vriu+q2/Hs3PbVvJGR4pHLpjpMM3pyLLoRzaVz1ioTKOWHTgtB0r6GpHAyKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709774030; c=relaxed/simple;
	bh=hZ5Sn1jSz8DAkNrCHxC3gfo9H5L7otCVEGMyNOPmqyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pVwwQcqqEe7FzT0t8tdUTqhJRsxaZXenUL+v2dukQYgk1V1oH81OLN36Gz2hB27XCNuLjzFjkuCb55TEaqq5anOI0GHjgVDox0CqCHO9MYuXZNL77uc56i0shR4y4yDcI90Wo3IFKhO0+I1TUR9jZsprZZyRBQcJ5bW219bDnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKHGNoPu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKHGNoPu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ac8c5781so7009457b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Mar 2024 17:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709774027; x=1710378827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt0lW+kiwJbcMwQc46VkiXalXJk5+eKabvSXhIGfvyw=;
        b=PKHGNoPumI+ZyWWTJJp1Hm9EYyJ1/44OIk65AK6xkd5m6NWOAIy/KTz13KYELFKviV
         nmYniytveXrg4Xt+VI1znvSH4EcKFEHIuzMc5pnDWeFeIlgnBpI+k7BNzqcEHAJZs83i
         CAS3CQqGp+X3Qx95rb4GKvZKvbHn/jauLZbq7a0/ohknT82EsCaYMKtbYCLG7nqkjQKR
         PnRjZ3LGWxE3VwJ0EGBg04+V07oYThqX5RVBPiR8J4A1KKBFY9PHahd0F8kGQTJ3VUBY
         Pfs9UHWDk7o7FLEwMca2rgkrOJ2dsXLVzGsUSiHlXmfEWU7aaZ8xxQd24TrpotVYiz8g
         BEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709774027; x=1710378827;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt0lW+kiwJbcMwQc46VkiXalXJk5+eKabvSXhIGfvyw=;
        b=cMLhgVjTbI1w/I+vUfbPWpMQoDoiFlwn1JcOQFdKXNGxEO+Ze540QvaJXqKbYsIq+v
         wXaTnX9pgTRzWOJwVFW7uFseWNKnDDK9OLCOD3JRxsUQhAXzRfarMwPHdjwpL+2AWXBL
         VeEqanDiiC70fPv3jRWNEUgDLIibTCy4C5FweqN9PcItaVCo1z1m5WtQqKA+Purg/mxF
         BGnApU9tBeKALTGLxIebyDaC8qJaG/JwR/IAvF3pcn9hPQQ1BmLFcDQRIkhzEAwobDm2
         9W882RQmyPpt3L5aiSsBJ6cs1TJn8QoYn947uFN8g937l/daeegX7Zc5nUkCUMU0mI85
         eIFg==
X-Gm-Message-State: AOJu0YxAfgJLm9JddEAIH9YMF6bID9xJpemc6qCAcUxAEUMrE5oHzJUB
	HWoDcONE4u7hu+IJxN6EL2+6t0IDlvCgT5WUX3bw4nfnU+enFj/tc6mkoANbFVqUmifAOqyzG4H
	rDA==
X-Google-Smtp-Source: AGHT+IHf2WAdN8sJOEpl8sXRG0fsScQWF4WTan2Mj8l4gnGUdx7FojV+fNOXpKpPaex0EROrURmv1CzhYg0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9b97:0:b0:609:38d1:2ad9 with SMTP id
 s145-20020a819b97000000b0060938d12ad9mr4120303ywg.4.1709774027042; Wed, 06
 Mar 2024 17:13:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Mar 2024 17:13:41 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307011344.835640-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: VMX: Disable LBRs if CPU doesn't have callstacks
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Disable LBR virtualization if the CPU (or I guess perf) doesn't support
LBR callstacks, as KVM unconditionally creates the associated perf LBR
event with PERF_SAMPLE_BRANCH_CALL_STACK.  That results in perf rejecting
the event, and cause LBR virtualization to silently fail.

This was detected by running vmx_pmu_caps_test on older hardware.  I didn't
tag it for stable because I can't imagine anyone is trying to use KVM's LBR
virtualization on pre-HSW.

Sean Christopherson (3):
  KVM: VMX: Snapshot LBR capabilities during module initialization
  perf/x86/intel: Expose existence of callback support to KVM
  KVM: VMX: Disable LBR virtualization if the CPU doesn't support LBR
    callstacks

 arch/x86/events/intel/lbr.c       |  1 +
 arch/x86/include/asm/perf_event.h |  1 +
 arch/x86/kvm/vmx/pmu_intel.c      |  2 +-
 arch/x86/kvm/vmx/vmx.c            | 17 +++++++++++++----
 arch/x86/kvm/vmx/vmx.h            |  2 ++
 5 files changed, 18 insertions(+), 5 deletions(-)


base-commit: 0c64952fec3ea01cb5b09f00134200f3e7ab40d5
-- 
2.44.0.278.ge034bb2e1d-goog

