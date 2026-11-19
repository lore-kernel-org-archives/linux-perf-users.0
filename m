Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114366;
	b=W68HQG7T1TjAAmjABRDm1Wlcd5i6wO0GUumjAQd3ZA9R20zYlbfnWtHF135KomX7oxtR
	 blaLcdFty7Xb3H5rRtf8rK1QZs+VviMifk/f6sXNYxR0+14LDZblrDo8kE+VXCYuLcAU6
	 mn/XW/Laovi+SLIYJOgy0aZrhNUs6Ad52BzpjjDnNVBg9f6g5kSyhc7Daua63HQQTZe3G
	 UwFFB9sWocYTWltpd/YQrwuvOn5POEHs6CNq8HAG+qB6a5hIy1RQZQeYGB3iVTf+ELty2
	 hiIdOPoTSOt73wxt61GZIVLrmQ1JKFQ9uwayDwoDXUwf+8k7oCK80ZCidio4GHNihNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=AHJ6vsYYQy4ZksSL7GxZoPUPCozguL3MZwWjlTE9XOs=;
	b=pGBlpmIZYgUlvkRiEhscUf8ygDJbehk5OJ7DOS8TXmjN/remJ52yZjSOLFLizxdQdfzS
	 pptF6dHxpR1Lsi23viuXtwXzZPxu5dkhNuEjvY+uMuMQtVpcIQQy1b+kp4Pnb9puQvXK4
	 PDoy9E+UqUb6Vv094NT0DKmj+f9ScKpLHtDPllLf+kbWybEq2mjLEZyOzoMmEbH698oZS
	 zNliGEr2Phw48YNr5D2ZJ5v7E4rSvGQd+zM17ZbbRR23S0aGIEBkwGKkn1sdR8ZrH81Ru
	 c78Mqjjt2Z+0GljR2qkKMXs4LdwAExFKGvyeKqVn+Pru/E6h1X3Irfx1LZSwCli2xnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wzc4c+OL;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187B60713F6
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7187B60713F6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wzc4c+OL
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4e937c5bd4fso121291b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114364; x=1795719164; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AHJ6vsYYQy4ZksSL7GxZoPUPCozguL3MZwWjlTE9XOs=;
        b=Wzc4c+OLTCQBedhbweaUILehwOwpk8UGZepyB1JKwHSjXkS/54EEQH0n6DmEeuEPja
         OT1Jj6VIdqXnEI0RwH6/b/K+yNw369Lhl8ki/GjLcqXiW9+/i2k+ncbrYGrq+zHziTZN
         eOXRKnbkw7glyoV+p+d6ZZ7qNZpGFECEal+dCv9t0F39vuL/8zah5prbl/WBB7UddSsf
         iqNd0QQRw7FzzTmdrHev5GkOML4rtse19SzsaRYnKqsmj7ZXWecmr/FdbhJFx0ngdGmv
         soFtYDZNDXnqCII4Flxcc3WZ2LUq4xAIL0NTXCVn6ftkWuq2DuSL7OUUD2tpNDJ99IsS
         DzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114364; x=1795719164;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHJ6vsYYQy4ZksSL7GxZoPUPCozguL3MZwWjlTE9XOs=;
        b=dKZGMNgA2YqQEZvdqJqI+wyIbLID2Ukz+x9QC7Wz7N2mNt2bbIW1S52EOKWUBsR49N
         503qqURxX/vbq14FG7x53kQoNi65IhKROn/aNuXNqBI+fwR0G25mMGm51Hn6Z3+HzmA/
         0TOwm0kWcb745dM1l7eiirZkX92YJkICOUwFWPKYBw/4hzaEbXFnLq32miWXaLjaFlsg
         IHGEA/n64OwPilUZkFK0KuIzhrEhJkSDJS9YzQePFbXvcKbXqf9X9hnK23SghXRO6URx
         /JkgFXze3onoyuk3/XDN3FRzhScy+Q/xLblgRgauBjmEHkzKNTUy51Zf75/0rBDKA+iW
         HrOw==
X-Forwarded-Encrypted: i=1; AL+hErFCWPIdcz9osR1CpP1+ronUwhnKltYtVJ56D3JjX7UP2/l/n5Sre+yFPe3PUIvX0F0z5/JNok/O48w8xVBfXn80@vger.kernel.org
X-Gm-Message-State: APuU4Z8OxzbfW+c/EkmLokKALpTgPhXnsnZNU+tkxXByJoA+m/UWPrj9
	0G7nQWJueKTZ5/HEp+SVB2JDA2G/7cRvmzn6+6mKdASYhJuDpcl6QXWxbXgG6gQdbI2OHhUQ5Dc
	9hglb+A3WgfWMAj1x3YSemhqCUQ==
X-Received: from iobi29-n2.prod.google.com ([2002:a05:6602:c69d:20b0:9c7:67b2:21c8])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:67c7:b0:4f5:98d:d1ae with SMTP id 5614622812f47-57a0bb8d52cmr963272b6e.55.1795114364230;
 Thu, 19 Nov 2026 10:52:44 -0800 (PST)
Date: Thu, 19 Nov 2026 18:52:11 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-30-coltonlewis@google.com>
Subject: [PATCH v10 29/33] KVM: arm64: Forward FGT traps for PMXEVTYPER_EL0
 and PMXEVCNTR_EL0
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an L1 hypervisor runs a nested L2 guest with a Partitioned PMU
(vMDCR_EL2.TPM == 0), L1 relies on fine-grained traps in HDFGRTR_EL2 and
HDFGWTR_EL2 (PMEVTYPERn_EL0, PMCCFILTR_EL0, and PMEVCNTRn_EL0) rather
than coarse-grained MDCR_EL2.TPM traps.

Add SYS_PMXEVTYPER_EL0 and SYS_PMXEVCNTR_EL0 to encoding_to_fgt[] in
arch/arm64/kvm/emulate-nested.c so L0 forwards fine-grained traps on
selector-indexed PMU accesses to L1, using PMSELR_SEL to check
HDFG{R,W}TR_EL2.PMCCFILTR_EL0 when PMSELR_EL0.SEL == 31 and
HDFG{R,W}TR_EL2.PMEVTYPERn_EL0 otherwise.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/emulate-nested.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 1cd2f42452fe7..9da7e98b4d18f 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1319,6 +1319,7 @@ static DEFINE_XARRAY(sr_forward_xa);
 enum fg_filter_id {
 	__NO_FGF__,
 	HCRX_FGTnXS,
+	PMSELR_SEL,
 
 	/* Must be last */
 	__NR_FG_FILTER_IDS__
@@ -1870,6 +1871,8 @@ static const struct encoding_to_trap_config encoding_to_fgt[] __initconst = {
 	SR_FGT(SYS_PMCNTENSET_EL0, 	HDFGRTR, PMCNTEN, 1),
 	SR_FGT(SYS_PMCCNTR_EL0, 	HDFGRTR, PMCCNTR_EL0, 1),
 	SR_FGT(SYS_PMCCFILTR_EL0, 	HDFGRTR, PMCCFILTR_EL0, 1),
+	SR_FGF(SYS_PMXEVTYPER_EL0,	HDFGRTR, PMEVTYPERn_EL0, 1, PMSELR_SEL),
+	SR_FGT(SYS_PMXEVCNTR_EL0,	HDFGRTR, PMEVCNTRn_EL0, 1),
 	SR_FGT_RANGE(SYS_PMEVTYPERn_EL0(0),
 		     SYS_PMEVTYPERn_EL0(30),
 		     HDFGRTR, PMEVTYPERn_EL0, 1),
@@ -2609,6 +2612,16 @@ bool triage_sysreg_trap(struct kvm_vcpu *vcpu, int *sr_index)
 
 	case HDFGRTR_GROUP:
 		fgtreg = is_read ? HDFGRTR_EL2 : HDFGWTR_EL2;
+		switch (tc.fgf) {
+		case __NO_FGF__:
+			break;
+
+		case PMSELR_SEL:
+			if (SYS_FIELD_GET(PMSELR_EL0, SEL,
+					  kvm_pmu_get_pmselr(vcpu)) == 31)
+				tc.bit = HDFGRTR_EL2_PMCCFILTR_EL0_SHIFT;
+			break;
+		}
 		break;
 
 	case HAFGRTR_GROUP:
-- 
2.56.1.708.g77570a6a1d-goog

