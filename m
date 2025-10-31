Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E427223311;
	Fri, 31 Oct 2025 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761880714; cv=none; b=nqWQvhc5O9S3mFUwMEEXTbjCeraWDnqcVzidXVeZTKv7UEvlzi49Y/MiKICH5zWiKqHe1E5T07II42uDpBpmItG14riD4gtTSwqaDGnI9mzgfQ2g7KNd3x9rHp2UpLVh2si4tDM71cMohj3YY9svweHaec73LWh3qSmCIFtd0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761880714; c=relaxed/simple;
	bh=hRCm+Lsv62rEjeA8scTpXabBzMfMskUgT4sKtOL3L5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PfxgUQbs8BQA6pDgNeCkiqtO8u4IKpvHhG/AVH9TluCVjhtxPkwLepdgJ8Xy+Jb+S/EzmMhmwI1QcXr58fiA/EpdHRNW57HaA5y0xarutnTJuHOSebrhuHc5PuTT9YagD55RfJ5E2TLvUc2iDWUuOAwNJFBeOnd5/2A+p/2YgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510311118208200;
        Fri, 31 Oct 2025 11:18:20 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 31 Oct 2025 11:18:19 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 31 Oct 2025 11:18:19 +0800
Received: from localhost.localdomain.com (unknown [10.94.18.144])
	by app1 (Coremail) with SMTP id YAJkCsDwEnZ5KgRp55A5AA--.2365S4;
	Fri, 31 Oct 2025 11:18:19 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <john.g.garry@oracle.com>, <will@kernel.org>, <james.clark@linaro.org>,
	<mike.leach@linaro.org>, <leo.yan@linux.dev>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Chu Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] tools: Fix typo error in json file
Date: Fri, 31 Oct 2025 11:17:29 +0800
Message-ID: <20251031031729.2304-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwEnZ5KgRp55A5AA--.2365S4
X-Coremail-Antispam: 1UD129KBjvdXoWruFy5XF1fGr4DuF45JFW7XFb_yoWDKFg_WF
	yxtryq9FWrJr9YvrZ0ga15ArW8Kayru3ykJrnxt3WayFy3JwsYvFsxt3srAa43W3y2grsY
	yF93Jr15Cr47ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?XhNnpJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KZKWHoHpvSAUcq6ibWdcqN8lFw/sVRpRCkZZCdi8t7fht8cTLSs374mJJiRqE5D4Nh48
	iAytS7QgT/9rDUSInDc=
Content-Type: text/plain
tUid: 2025103111182157bb79293b7610108f6603683722332a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Correct instruction spelling errors.

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
index 4cc50b7da526..4001cc5753a7 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
@@ -81,7 +81,7 @@
         "BriefDescription": "L2D TLB access"
     },
     {
-        "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
+        "PublicDescription": "Level 2 access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2I_TLB_REFILL to count",
         "EventCode": "0x35",
         "EventName": "L2I_TLB_ACCESS",
         "BriefDescription": "L2I TLB access"
-- 
2.43.7

