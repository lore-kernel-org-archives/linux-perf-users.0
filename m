Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C1375AAD;
	Thu, 30 Apr 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529515; cv=fail; b=QBVP2ycgFrNXx+hbCYpElochKCkKL/nMYC4c6vpsyQRHbgniNBgCXv4UuGsdP0jGQrW2JtvdYmU0BYso9ZOs1wubvqoQ3N7uVWCLt6eAqRebYxU0AQDHFrbVOXLDyaOL/iE55f4a/JUfHhv8GMvGefVxo/XjER+iQJsu5yWSq0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529515; c=relaxed/simple;
	bh=yDNzcUeUgsEk24/J59wy1T+kUWrRDGiWmde2LRKNr7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmVtxGkcczFhOz6gzwQjgP5Ck7+gTmhSPOefozGHZ4Xxj50wmJgVP3Bus5kQ3AETWQIOoK59vyQtcpnHVD3PfKsBFEkFEyLtoMhApAdKMARgD1f2MzIBvp/JAyuMJg0WKNE/gnzBYew/GWZ+SXSmwqTWl6oNA/SmwhitwchPGYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tqdhREpm; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tqdhREpm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAYMhgEX6YHElOL8uD/cZGhxY0IxgY91uXe00IIImPFwbwns2h6C/3nR9IWxhREMAuIwl8LMMkUJn02AamZ/JNalAhvbGMPRHYKmsVzuW5lOBsYHoMuW0xkvEpm3S/V3r3fMJdHl8gkLdLVGaMoxRLlJzRYpOhII2ZW1nYTD2xuW3DfoHiZkhOWGWSmVPdcXP4RKkH/j0f89GHXBi9wxgTXxM0w7uezRIA9RleOL/UP7NHObKjJX7Rnbw9M+TiBMKSaZXiFPvU2yW4v72QNztLlEcX+lklrJ2uVn+nclsMNoOpRyvCH9gLBEzwMCmY91+7YrmlslmaFJTi5+wHUeOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0r1p5pYzfNoAi5du8gBxpk7L/1CXmjuapfBBW6OW1Y=;
 b=Le376DMavnC/xQ6qrcWsCmnvkMUxne+V3D0A93HKfw2Q5yO4RruQ59Mcsfw72FNe1FgcnTtOo6JsU3UiWqCNn1OKBip8StJ3gOrNsF/mJoTTkVR1qPpsdhMLyyghHBJSzebhsFoSCFXOh2oJbx1c+PcAa3FnyVhkgwrQaMU9jpomNY7CHRta5bnPOslIR42ddy419KerWiX0ILNgt7PKhErMjuWf704it1O8OO/0Gv8VhCligNaZZzL0AifU5ICcJmpKfAyesWHqjtukiIkXlUh4gSW34z2stIIZMwuk20GL6DEqBpVHbDvG1Ra+96DmJrWw9Jl49zEgMqVyNySQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0r1p5pYzfNoAi5du8gBxpk7L/1CXmjuapfBBW6OW1Y=;
 b=tqdhREpm9EOKf3e2J9+Jq3OxGCRcqqB3xAOyULBuNLD/02I+x1/U8Si0eMP3CCK2IHX4SWqIGG6pbmiYS/+bpTPtP0CNLUfs6D8vgzliIZbaAufsl30b6HK3iTq4skA12hCU/ygGAFGMpizDcycGPrVr5L/cbKqc+M8TkS6me6U=
Received: from CY5PR19CA0045.namprd19.prod.outlook.com (2603:10b6:930:1a::22)
 by DSSPR12MB999211.namprd12.prod.outlook.com (2603:10b6:8:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 06:11:50 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::86) by CY5PR19CA0045.outlook.office365.com
 (2603:10b6:930:1a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:50 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:45 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 3/8] perf test ibs: Remove obsolete privilege test
Date: Thu, 30 Apr 2026 06:11:10 +0000
Message-ID: <20260430061115.10266-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430061115.10266-1-ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DSSPR12MB999211:EE_
X-MS-Office365-Filtering-Correlation-Id: 6016710e-b089-4e97-6388-08dea67f5dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9lBmCNW35xrGsl9rRBq6pb6OXnsSztPsQ8yLIAE6GtS7GBRnn3jer5HqxVY/OevgrDkjLXhnkKzdQc4E5GpqrsY9NVvLRG0xbSUktm67K5CbDAxke3uVDnaS4/OTj6R3lmy46COIwiUr7MmGpJEf7/pHhir8WWlNdyNCqLTO5NRDfusvWJiFzp4RdmBMVgWdxzc+bOeES0U0wqTodt2D1P8vZ96jpYfM3yLEOuJcBKLM9s8Xk+fRKuFPzRiEQ5+JnnvxIJwuJp2+pCPNzdlkUPuOkVcnAAXyD4tuWCX+N9sII+We4kVxAzgDDXucydYREvWB4OyLJWKa+87yb3q+4db2tWZOsUTNPWFgmk5Nl0NFy1SkI30IhwhJ6UgB8l6Ofd1v17b/FJQ/dQtgdNC137dWYQ188p1CmMKn5VkTvYfXInCv96OosgIJ84KmHnPC+eQkTNdEcblsZBdW834z+zYCTJndsA7Y4wlkb3/uMsndzJ6Cmv+sL9odpPKQIUUzrbWntPs6xyViLLV6OKLRZ2NKgR7vuDNOPe6psCUsc1xhcKXwiQwUT2xSHqKC5OojHFOm/0ea6wttEpuethpP7zTX7jgwi+mImsKD3cm9/3JBzCPQEJNyGEdfKvzSvMvxmITCepQTGN2XNzSQ4ZRlzHuRfEMhchwjQNnoSiIckPSFm8zGHl020UEVQTe72IBsC67HWW03Hn3K6VWh881mrRUjPvs4Dkz2pVBZxgN9xc6+sH/z1vw9cVkXP1ecOdno+hYrc4XDBUb6JRl30W1GeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PCiykZNJxju68qdOtJIiHG8ovcsiX4GOUeciMJHlQigwDm4o0u1z6UyZA6FIAzO5aHWDb8qTPjq82nQhI4iB8FSfI7cH+l/CgphQotGg1EVH5k7z8ASg3Fc9HKxpVseR+st31bwwgSZhRigNCSOT6FE8jHkMsOnERVldiPrJ07Mo8Z5FU+hkvFV0KdzQUa2PLMVqbzaoEWhUuBUfuKxqHE5W4lPJWze7EktE4Qu2L8vcmh5IYfsRLf7Z9k22w+O3sNpwmjZbM0rNsCPIGqqv9vZAh6Kwg62WQfcE8unZm0wtFF5tz79KWdUwU1yvEIpOcvKcGL01bgZ/AijhzjvEg4hL2JkFmcZda4aS0mtlB9hNRyLKkk9gKXXZmq/MnDzaFw60u97JxozUqvwXIFdY8pA2w+Wv+ivH68P025zEk18ZF/0H2vy0V34fiBoCrBlx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:50.0379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6016710e-b089-4e97-6388-08dea67f5dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999211

Older IBS implementations lacked a hardware privilege filter, so the
kernel enabled swfilt=1. Newer AMD CPUs will provide privilege filtering
via the RIP[63] bit, making swfilt redundant. Remove the perf unit test
that assumes IBS has no hardware-assisted privilege filter.

swfilt is ignored by kernel on platforms that support RIP[63] bit filter
i.e. all amd-ibs-swfilt.sh tests will test hardware assisted privilege
filter.

Without the patch:

  # ./perf test -vv 75
  test child forked, pid 26029
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [FAIL] IBS PMU should not accept exclude_kernel
   75: AMD IBS software filtering                            : FAILED!

With the patch:

  # ./perf test -vv 75
  check availability of IBS swfilt
  run perf record with modifier and swfilt
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB /dev/null ]
  check number of samples with swfilt
  [ perf record: Woken up 5 times to write data ]
  [ perf record: Captured and wrote 0.040 MB - ]
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.054 MB - ]
   75: AMD IBS software filtering                            : Ok

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/tests/shell/amd-ibs-swfilt.sh | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
index e7f66df05c4b..92ef45bf3043 100755
--- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
+++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
@@ -22,13 +22,6 @@ fi
 echo "run perf record with modifier and swfilt"
 err=0
 
-# setting any modifiers should fail
-perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
-if [ $? -eq 0 ]; then
-    echo "[FAIL] IBS PMU should not accept exclude_kernel"
-    exit 1
-fi
-
 # setting it with swfilt should be fine
 perf record -B -e ibs_op/swfilt/u -o /dev/null true
 if [ $? -ne 0 ]; then
-- 
2.43.0

