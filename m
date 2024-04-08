Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143910942
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712557435; cv=none; b=qbzvq9fRQL2WgCosCGAxQss+3vd+d/LpEo9F2cu6pYp1Oh5rQYkseP1eZ9doAwLJSjbavEvAgJ/dDb930sLSiruZ//Q6iygyYe3uUekg7e30faU7nlNOXE2j9myIhOWFx1KHuM81n4RaU0g6NCl3zzDSu8o7WJMdHu5OH1ABCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712557435; c=relaxed/simple;
	bh=4/0Mk5m77iBGhYlyvjVouXtM3A7GeYa0knzDCH7OgQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EK+oXjBe32+pjy9tA7QdD7yheggFgRUyUxNp0MRCvrZjLFk5nsOwghPh1DMRUNyr1LR+3eUqZk6DQwNqB+zjRuT+p2q3H7Xd65XyYDWsucLc1miPJvO1X5AEp/7yirpVlB1ex5QphsUMKVD0a8cn7SEfM+p28imarL+uN5U3Sdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 734AB1682;
	Sun,  7 Apr 2024 23:24:24 -0700 (PDT)
Received: from a079740.arm.com (unknown [10.163.54.109])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 763583F6C4;
	Sun,  7 Apr 2024 23:23:51 -0700 (PDT)
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
To: linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	james.clark@arm.com,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: [PATCH V2 6/8] perf tools: Enable configs required for test_uprobe_from_different_cu.sh
Date: Mon,  8 Apr 2024 11:52:28 +0530
Message-Id: <20240408062230.1949882-7-ChaitanyaS.Prakash@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
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
2.30.2

