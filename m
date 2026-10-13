Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F054FC329
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896582; cv=none; b=fPe3+5GEFGkYd15g9eudkF+sCgmnkjxOzKGs6GZ4R++A55QXigjuAMbXmYr0T29CRBPBWcQ/ApYr1s0MTPdqNYlJz06B46PZlYtHc0HOVSWDz6NuNoICmgZsu2QoFojHhorXHDWkuv6NTz0xgaRRHs+ii+PHDdPht2cYQliAlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896582; c=relaxed/simple;
	bh=ohfpkXBwU7mhKsOXWTWiB9UmpH3e9wM86mCX2c9VwD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRy3iEbUusZbSwuGAFVjI44hiDh04HTqNTWj6bl0+rY8WolWfTAeMwFcIl5tLeAuN0qKeI0hKIDV3K5lcCWHfYeFBzeZwZ3c7Z7iUTQ33+O/99BpjSw67boIgQ2anBFkQcTZBXWOMIIFel/qi3kODNEbJsbmndUsIltclZjeBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8ZgfG4U; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8ZgfG4U"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ohfpkXBwU7mhKsOXWTWiB9UmpH3e9wM86mCX2c9VwD4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791896580; v=1; x=1792501380;
 b=R8ZgfG4Ugaw7NDnl8kvi7W2GJBPUAMyN5zRpJrWExPii6/gJHA6MQRtzuAi6EAPdMi/JNIzh
 /pqFwtOCx3w47izdkgk5V55JEk4wMvKPB+9EdEDOJWKmTfVg+vlMV3Sl9oFfzcsQqefqe7F/g4v
 vjcF8wBhGRxHkLc9EwLge5gE=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5cb1cba37441c88;
	Tue, 13 Oct 2026 13:03:00 +0000
X-Mizu-Trace-ID: e5cb1cba37441c88
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: sysreg: Fix three incorrect enum values
Date: Tue, 13 Oct 2026 14:02:44 +0100
Message-Id: <20261013130247.4135515-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013130247.4135515-1-fuad.tabba@linux.dev>
References: <20261013130247.4135515-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three enum values in the sysreg file don't match DDI0601 2026-09.
Outer Shareable in VTCR_EL2.SH0 is 0b10, not 0b01, as TCR_EL1.SH0 in
the same file already has it. Thumb-2 in ID_PFR0_EL1.State1 is 0b0011,
not 0b0010, and the M-profile model in ID_PFR1_EL1.MProgMod is 0b0010,
not 0b0001. The spec lists all three old values as reserved.

There are currently no users of these values. The VTCR_EL2 one came in
with commit a035001dea37 ("arm64: Convert VTCR_EL2 to sysreg
infratructure"), the ID_PFR0_EL1 one with commit fb0b8d1a24d8
("arm64/sysreg: Convert ID_PFR0_EL1 to automatic generation") and the
ID_PFR1_EL1 one with commit 1224308075f1 ("arm64/sysreg: Convert
ID_PFR1_EL1 to automatic generation").

Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/tools/sysreg | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index e2d37ee221b84..f2812545f336e 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -434,7 +434,7 @@ EndEnum
 UnsignedEnum	7:4	State1
 	0b0000	NI
 	0b0001	THUMB
-	0b0010	THUMB2
+	0b0011	THUMB2
 EndEnum
 UnsignedEnum	3:0	State0
 	0b0000	NI
@@ -469,7 +469,7 @@ UnsignedEnum	15:12	Virtualization
 EndEnum
 UnsignedEnum	11:8	MProgMod
 	0b0000	NI
-	0b0001	IMP
+	0b0010	IMP
 EndEnum
 Enum	7:4	Security
 	0b0000	NI
@@ -4652,7 +4652,7 @@ Enum	15:14	TG0
 EndEnum
 Enum	13:12	SH0
 	0b00	NONE
-	0b01	OUTER
+	0b10	OUTER
 	0b11	INNER
 EndEnum
 Enum	11:10	ORGN0
-- 
2.39.5

