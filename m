Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66D1E484
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708403424; cv=none; b=RkAjfyChGRlQsxYz+uS/q+z6UP1kRtExUWOYFnLy9abd/Ee+Kd1JR650BhBsOEADFqB15/vUT+k6Osu9mkyjO42tYNlv3OXlFygIlZjfOl4n6gdEGRAvbFuLL0e3O1zAfmVEKrXXDFfADxLm0nPv0d4ADARq3xF66N2ZK/5EyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708403424; c=relaxed/simple;
	bh=TSIJ2u76zXm+LB5WLodSn5ng60jv2vpFX4qcHKYETYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsTIQGm+juTOVskCv2e1MMtlMmdsiwtvm+dbO7j+9rrWaVYVrw5qw3cPLuQ8UpHV7j7ckj4RZwBLd6zlNWSC+hmuMIXvkuAh89dB2pv+UIECELjiZN6suWQd11xrESLoupQCmAcYc2T6RKSLfr2syyc8Zz6H0GFSqz14ArB5tQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FF8D1007;
	Mon, 19 Feb 2024 20:31:01 -0800 (PST)
Received: from a079740.blr.arm.com (a079740.arm.com [10.162.43.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AD8C3F762;
	Mon, 19 Feb 2024 20:30:20 -0800 (PST)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH 1/3] perf tools: Enable configs required for test_uprobe_from_different_cu.sh
Date: Tue, 20 Feb 2024 09:59:55 +0530
Message-Id: <20240220042957.2022391-2-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>

Test "perf probe of function from different CU" fails due to certain
configs not being enabled. Building the kernel with
CONFIG_KPROBE_EVENTS=y and CONFIG_UPROBE_EVENTS=y fixes the issue. As
CONFIG_KPROBE_EVENTS is dependent on CONFIG_KPROBES, enable it as well.
Some platforms enable these configs as a part of their defconfig, so
this change is only required for the ones that don't do so.

Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
---
 tools/perf/tests/config-fragments/config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
index c340b3195fca..4fca12851016 100644
--- a/tools/perf/tests/config-fragments/config
+++ b/tools/perf/tests/config-fragments/config
@@ -9,3 +9,6 @@ CONFIG_GENERIC_TRACER=y
 CONFIG_FTRACE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BRANCH_PROFILE_NONE=y
+CONFIG_KPROBES=y
+CONFIG_KPROBE_EVENTS=y
+CONFIG_UPROBE_EVENTS=y
-- 
2.34.1

