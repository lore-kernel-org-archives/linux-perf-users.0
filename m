Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DFF4AE138
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451600; cv=none; b=tdlmxDlPLFJgKQ9cn60D6IOrYayxNtH3NKB3Qr0HZw6cHjUQh8pmDofd1u1l+Zehs3YiTl1RDQnQkDdP7BfSaXFBYrEo+YcBdIPatmCTukSXqpo8UnToydkPfksUt6u3QX6HP4M1ccaaN6GYAneeG2ORlsxtLpt58aUXQhtPeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451600; c=relaxed/simple;
	bh=VxTzA25wjumB3+f3mjAuzTrnWqfe4sUlBMNEnKhLDPs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO7lmzaIuefrasl6RnpdFnJ9rXbhLjf3OxzeronZ9TlZS6AJcNydJ5BCntphah9eWlRz2/2CKJBs3+o8TFYeItOV/nr4HmRUm8M2QIyZZQcuhq2c4lY/vVYgCjwsI8cLHNy7xZT3fDWanfRKVPb8fGYsg3VgUvSiSU9bZF8dMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=K4WbhN5z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="K4WbhN5z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D56351650;
	Thu,  3 Sep 2026 09:06:33 -0700 (PDT)
Received: from e140010.cambridge.arm.com (e140010.arm.com [10.2.213.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C29F53F673;
	Thu,  3 Sep 2026 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788451597; bh=VxTzA25wjumB3+f3mjAuzTrnWqfe4sUlBMNEnKhLDPs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=K4WbhN5zlcBSFyrVzluRZ5FkRynRdz8ifU/6SYnsipqn8DICTmH0uTvLW8Z8OJPZ2
	 rN08aJIm0LmX/VFDaCRzl6iGotbU0Nr7ggzv2gpPGHdjftet6a3csg+e4mUd+i5zJ/
	 GaCES9PB68Rk+l2yqZUve+uVc6nsGwVPfDFqAk/g=
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: maz@kernel.org,
	oupton@kernel.org,
	fuad.tabba@linux.dev,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	catalin.marinas@arm.com,
	james.clark@linaro.org
Subject: [RFC PATCH v7 01/28] arm64/sysreg: Add the nVM field to PMBLIMITR_EL1
Date: Thu,  3 Sep 2026 17:05:56 +0100
Message-ID: <20260903160623.315525-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903160623.315525-1-alexandru.elisei@arm.com>
References: <20260903160623.315525-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define PMBLIMITR_EL1.nVM, to be used by KVM.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/tools/sysreg | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 94bf065c8ac7..a11a968eb707 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3106,7 +3106,9 @@ EndSysreg
 
 Sysreg	PMBLIMITR_EL1	3	0	9	10	0
 Field	63:12	LIMIT
-Res0	11:6
+Res0	11:8
+Field	7	nVM
+Res0	6
 Field	5	PMFZ
 Res0	4:3
 Enum	2:1	FM
-- 
2.43.0

