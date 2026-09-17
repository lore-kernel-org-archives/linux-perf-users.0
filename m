Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EACE4B4873;
	Thu, 17 Sep 2026 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639268; cv=fail; b=sHl/9/9dDGXYo5hPn0k+eaBT02rlskMUmsBCLhl3vVtiMy0ZkzJSrIttgHiiE+bKi/HZFTVuZ6DwV1GPT0EfrPJXSdcAYlG0vPqvxkSwtUPSUOOP4WSktL6Z2QTUl8aDrcFzrtKYR9xVvLpX/qaPCg/QOK3Ji68dyaqsbiETJzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639268; c=relaxed/simple;
	bh=6tsvHX3ox2E99bq3unLpeCfP2x5uS8y4gu00H/DunEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COSwuXzaybRzSmzVYt9DPSI58r4Y1IWrdDeBBBe1KwXHoIEJFyeeCF6QvMkNiIvzbIuVn6120FStRUOBnX1kuIjn9n1S2vHCqDYNbCbNFbIcdZghxlpZhs2CVDCRYIUihHedCQGXFx71s0YQUE4BN/wOr7Kq04LmQbKQVigLbbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qpPvpeii; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qpPvpeii"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKkWawRIIt9mDU5/mu/EO+iJYWmF/hAmZzBskQZV0tz6QVs4Vq1nxcubVMH9W4WeURPkjssF+y/IQckz8oyGeTuwRmWYufwG1LWLPbhGAAQk9WdEISIn7T6eIV5NLOZ4Fs+/6S+QeCdpa2xSiP92HB7qpGAWnWqg5XaDjdAAVm1gAqDmfP5R9CVVgmwErm3OulHdH/wGcjuWRicVRUvkWm683WwxY8rHjYAc/gqedHwgLZ8yAEZmQqniOc51wDCswQUmrqtis/+X4kqMNhBR54MfvCNAGrVWeI0jMHvyQtQbzZsddOpfaLzFPD3GdgXo/74bX55M87qiemPMAJJhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aueaJj0oO3KKa8SHG8TqCid9ON0Iatts6M1ZB4Bd/IQ=;
 b=bPmJDkAe23E+ebs2hkZJXv2u8/iWkerYO0oNtf3yJyPMV5PwNiqc03iYJRi9ixDbC2pZc2eV+RYFA7QcK0AJSpZG8OTa8AXFrkDOMpakQxQad6qtHjGpYdDfmozCC107njeIQ/0keZ1IpA8L1HmK55DdpSqzC/wZMcYNG9Yf9QKjZLOEOs+bIHP4gmVaefOxwuXoOoWZRY4UVZrqo4UJiUM58wzcVJ2wx9P4lWfWfuOUy7R6iJ2cMofpFfuxNLji36nkI+SX6fRs9KgtIx46yGRsz8jL4YVZMrOvCBgrg6TpzRCKXLjkHOVdmQuQeoBEEv87JwT6KcgOl5y7tWmagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aueaJj0oO3KKa8SHG8TqCid9ON0Iatts6M1ZB4Bd/IQ=;
 b=qpPvpeiih/XEVg5glp8Tt7X/JWTqelm/PdX9XIUvUb2JGIQvUDwZTQw3IXn1x5/1LOOvJ0ZZL7LxccJMIduyV1+wv1SanRFLC9ELW7q35/ALgsx75nYPktBTHvIbosjulOecKv0ScoXJAAeVojvXjGzfqbJPQoxLlRit2DsWrwk=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 10:00:34 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1f) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 10:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 10:00:34 +0000
Received: from sindhu.amdval.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 05:00:29 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, Ravi Bangoria <ravi.bangoria@amd.com>,
	"Ananth Narayan" <ananth.narayan@amd.com>, Sandipan Das
	<sandipan.das@amd.com>
Subject: [PATCH] perf jevents: Limit the number of JSON reading workers
Date: Thu, 17 Sep 2026 15:29:21 +0530
Message-ID: <20260917095921.2802275-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 590c9ad3-cc7e-40c8-d03e-08df14a28434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tBe3yts2tXMPxcYtujwE+rkmNFt2wolYqVIN+85UqJih3DK/g1GA2TfiR519IEQWwvnpdVgeDLlKwYM17VyAM9JKqN5w0UcF3c/4bHuF1wAEEhjnDPYAx1MPQqGd3xWEJX0utUkFoJWVjeYa4XQunNuD51H5oGqHISti/9i8UN/WxD3oBa62bmkUY6cvwT/UmAM9KzXLo0d8GqvVgF8eiNBjHy4YC5CkmqvNhD5P1UyqPR/79nI1xbcL5b1eoC7wKY4IAS130JHmwFmeiFwwPOrCnDD/mAlM4pLIUMaNgv7Mrb9b4MVx3J2iXX1KxIr8KZtLCwiSPESUuzkomNzRvvH35cdmEHfymNucH+bNtn2kfvhsUAvI90mtGbbggNb4Is2qPmLMb5/b/e+eojJK2iZ+262GjFvGPW3qr8hSiaGes+ve6O2dy8lBy4GZyU7YUOVr49rxSkCFD9vxFUSaE+O1uCRxslUosXSLQoUdpJOeh61ohu1X5fx0e1I3fJ5zvydhTJHYZ9RtiN08zoWXpgAhYk0yLbjKkqpG3Cseo96eARD2KjXTEEH9HwHqdGS4uBRDMoyBPp8xKylHy9VKfILwSaTe2ePwvLPP2OHbBgYNL0VpNCUg3dNECpY83jAEOLaYvvsClKPqQOLx//hTMMz6ZdUlV9mxkcV5pwrmnwxqzJpyjdDFXXq6zzv0E2zZ0ep315zIviyLEs8kUq5LiQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZAm9IOleoHBX0j+GqDuKqhCq4F/kKNDhaGloQG1D/Msa4KBGLWBqyW9xUrWttVtvscXddi1kC9bopCxlM0csqt/6tNGW+cJlO27Cac437rqHOQBBx2edfij+C7ui6vaiSZ9sMZcaQrhbSvMvnyw5D2evid1C64Hm1umy2QKtiTQuRmAcLZf5Tl5eLc12y0e5tJWXEXdAqnHWxyNnSH7J87BZDPw6VyH6Tl+d5tSwg+wYe0ydQKnHhuVN2H3yy5lGDq7CjMoOmHVntp5N2G6t1JRF6bfC9AguBAswYB5EHB6RHrwQrPhLF4KbpcWCydFrCMRwzt+O7REL8Jj8elQ/h7J0jEu0OlUNKXF+svNROkvIkMiul6A5zhE9XuhweFYw/+7fORYWKU4XGtwkanWT3+QoP7WY1zVJsVlPXaMJrwt0oVQIFRTuhgGk7l7fIvv1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 10:00:34.4917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590c9ad3-cc7e-40c8-d03e-08df14a28434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762

The ProcessPoolExecutor is created without max_workers, so
concurrent.futures defaults to one worker per CPU and forks all of them
when the first task is submitted. Each worker costs the parent a few
file descriptors. For systems with high core-count processors like the
AMD EPYC 9996, the pool can easily exhaust RLIMIT_NOFILE as seen below.

  File ".../multiprocessing/popen_fork.py", line 65, in _launch
    child_r, parent_w = os.pipe()
  OSError: [Errno 24] Too many open files

The error is reported, but jevents.py does not exit. The workers that
did start stay blocked waiting for work and are never joined, so the
build eventually hangs. Other targets keep building in the meantime,
leaving the traceback several lines above the point where the build
stalls.

Limit the pool instead of sizing it against the descriptor limit, which
would mean relying on how many descriptors concurrent.futures needs for
each worker. At least for recent AMD EPYC processors, reading the JSON
files does not need many workers to be fast and things typically stop
scaling beyond 32 workers. Hence, a small upper bound keeps the speedup
and stays well inside any usable limit.

Fixes: eaab2eb09dc2 ("perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/jevents.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 860027bb71b2..d81fe6757915 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1450,6 +1450,13 @@ const char *describe_metricgroup(const char *group)
 }
 """)
 
+# Upper bound on the number of workers reading JSON files in parallel.
+_max_parallel_workers = 32
+
+def _parallel_worker_count(num_tasks: int) -> int:
+  return max(1, min(getattr(os, 'process_cpu_count', os.cpu_count)() or 1,
+                    _max_parallel_workers, num_tasks))
+
 def _parallel_read_json_events(task: Tuple[str, str]) -> Tuple[str, str, Sequence[JsonEvent]]:
   path, topic = task
   return path, topic, _read_json_events_impl(path, topic)
@@ -1549,7 +1556,9 @@ struct pmu_table_entry {
     preprocess_arch_std_files(arch_path)
     ftw(arch_path, [], collect_json)
 
-  with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
+  with concurrent.futures.ProcessPoolExecutor(max_workers=_parallel_worker_count(len(tasks)),
+                                              initializer=_init_worker,
+                                              initargs=(_arch_std_events,)) as executor:
     for path, topic, events in executor.map(_parallel_read_json_events, tasks):
       _json_cache[(path, topic)] = events
 
-- 
2.53.0

