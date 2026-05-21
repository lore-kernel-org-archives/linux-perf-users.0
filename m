Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E54374E67;
	Thu, 21 May 2026 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331761; cv=fail; b=odDIIzVIhbvzlyYFrJZFZ4J++wnpUdOWNaNuTAkIcDmyBO8OYuccaLpHgC6rzo0EO8rkhfmftyReys3WLP1h64l4eFE2OX2AOceGFjXkbyHc1q/tAdLMqky92E3FfTSjEgrc6kgbCPRhsH3jojF5/V+7R/IkGL1kHrAjxwDvJ38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331761; c=relaxed/simple;
	bh=wiTaFaZft+Rhts5F49hlMoLxfYZbD69qU6U9bDXHYAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tuIUzxvtF41/k/d+/jUZ+9LNfS0LNeeuRHe0FwvNoeu93pRk3z4XVy5djisx96zStUbJfc8HLKfTpg+VhmKSSp1PvWk2I3iFXgLsdEtYbA6mMpoyP9rtmZu0WI3U3riHMc7U5GmLyhb4iV+5bHqfu0NIBiM+a38dquBFnHmw+YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kYbY+Mhf; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kYbY+Mhf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv2l62bmYVtDlRT7mfo8vzAfxe92rm5DG9EuDU9d9CwLfFonI15S5D5+XV4+Dz7GhxzesSVUkLIPyzDogl4lruKPf822ulrORJV5WXFyB1OxWtSYeWGxSPvlWCNB8QlXUKwQmvmGeOkyN0Uem0x95VDzWa7ral7iBFDyg7CaeHaIsp0InFdsmVWyDc2l9RRWfbCeI24G237d6X40FseN4aPnu7TcJIeTRjirmBBoJ4S84OVMr17NHotWXYtPsARkMfds2HrFe/U/P2uWXYvit0e0oTCX4nEB8HFEC2lJNYuFIcghqTMgD40xt4BHCJj9oQSDu6POXsGqlL6mIT7i1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG/ZhQTusUZ2rJWK/Oxb1tpvuuqK1WFDG8pM9/niPDQ=;
 b=G38VXc/sN9cqmdomq/ELVQM9rRlltViik9cWMtx041wa/89qwawePfTLbq90gX3WeJ1OVidBApbIFZjApqYZA+44+qBy0TgqhkyERjM7nCtEd2JvuzdoGLlruGdetHsKppt7U5KdA8XPVk5mO2o6s99acTzF5fzeTckfiQ0SKeyYcKWLGRedcFyPFBjxjkaZ90xsdXOb4oW2HSAMHvFL/0kB+wLU0sWDUDIdqiXysNBnl1FV/UiGHEFk2SO3qUtvAz67ri9Ogv8gKprohctsdZLJ+U6IbukEEZtecVx/gCR5Q2fKG8OGbAW1Wy3K8S8D9aKSWjLXkPD5r+KGB4F3qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG/ZhQTusUZ2rJWK/Oxb1tpvuuqK1WFDG8pM9/niPDQ=;
 b=kYbY+Mhf2sUuIAmxymw1/ETQIVBFkHG1Ff94wdUDL0mrfGlVaLrFxIBbKkEkqXiuxoQoTcRej1tv1fXfTKLJGDs3INXyF0msCFpftm6BuDs0/zUx9zJJT7YxqHcRkjwV5ZqH0QuVAAJYO5HUUa/jy8RAwPyvhzTEDf04daP230FclHpm7KBpPa1iNp1TPHN/IKwcZXLZzbYaNBUk7se0ebFaa5cIOrsYYAJkrKPPOXuUQ3fZL9Leg1ihq8qWyN8DS54Nh2kQ6IOl7Kstm57jxRHFaQg/1LyFE4IQChvbHvqs7eJFRau+MNAO8oZKiqwetUOCFkpVfLfbYGm/mzCcYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Thu, 21 May 2026 02:49:08 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9913.012; Thu, 21 May 2026
 02:49:08 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 2/2] drm/xe: gate observation streams with perf_allow_cpu()
Date: Wed, 20 May 2026 19:49:04 -0700
Message-ID: <20260521024904.331912-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521024904.331912-1-jhubbard@nvidia.com>
References: <20260521024904.331912-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::25) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce51a5b-2c2c-4e8b-2b0f-08deb6e387ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|11063799006|18002099003|22082099003|56012099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	tC4dN5tmGND3t6FwZNm9L9wGVaOUPUO+LIYz62LtfX2Yr61r4Yx68nfHImKaTnJPKUwrkgBRdhu/5fWgC2FJ71MyXf3oZa5jTHySbJLuwjjX49n1db4siCp8Jgssn2Pr5cGCbBN1zBXQNDz1f/E54azWFScKwqyUHDGPjfK6fckHgVshj+IMowWZ4e4E6j3WIKQmbB9Qb5ukOQ1LyDEMol6QHRvjPNpWAipwYt+UTdkJKqyKKzYwqY/XrDBSHCwg1WAChaMQ8CVG6PIOHjkCItmeuEY2O1iniPxPwC+u6TTiTUEHg6frA3rSRs9YDNOU0CeiiUkDtu7jRWKGx4LXbEyJPDJbXuvX1ZkRpb4Tjw4baB4O4LZ0k+XuFnEi5ViM02v6aeK3YleA0834Q0Qd8/TW4C4i4f/f0nF562So3o8ycQoElmU52NvCkiSWq5wK7sb5oeyCkNMXcYfUrivuqESeQzn863X0uOeH5fr3fGX7+D9fzv0YwXBRvk5+0d17rq2MXmy1ZkDMoeJPpi6kRAM9n1Dv8ZfBli5dqPeyXH2sw73uz173c34UuqTSVpB9CDeEvDnFV6gDFQJL1/clgjNLZ2rDeRhqoWn5nLuoet3V53k1xBuHJyicLUCt/UYs3yHqKkNely2FgHVRSdnDn0IPPOD8KCU9STpiVL05H05dpoMtu255j44J/Fxx93zM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(11063799006)(18002099003)(22082099003)(56012099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dz3OY+NIRkOUpBZZKR/T5tgZkwqndr1mPtKSq/lr8AQYsnGROzjc7OxuuiG?=
 =?us-ascii?Q?MPE4sNkWkDUalWFOd+rcw6TCTmgAuU1dsyIzd7EQ5NLDy0ofYaCF92HtVOeH?=
 =?us-ascii?Q?M40KL601Frc2O0qlrIbFf4D8tlqZESOd4czQiI2tJ64KjP1CM7dm4Y/uued2?=
 =?us-ascii?Q?MAoFmlMkE5kIySrcImBb5l1TxBQFStLA3kARp7hlkv8FslMw6vnanhvyC+hL?=
 =?us-ascii?Q?H4oNcSC9q+fHU9PqxTDUhrOIGm/cr0xJ2kyHPymS2foC192fO/LtOEYb2cFu?=
 =?us-ascii?Q?xggHghzJsrxYSi9CNx/uIlpfqSZq/RBJ3moanTzt9vmwk86F9cYgHp0NCpSy?=
 =?us-ascii?Q?I9RKV4IExgijeqxIOfDMjXyCHYZDYcbahAw72HJaQDsPUKsWf8q2IvzKdCCR?=
 =?us-ascii?Q?ahWrXBEAKR/ZusrlOOsSggu3Yi9eCbbFofpR/40btGUDad7Oj0uW3g5UYGX9?=
 =?us-ascii?Q?St9TVgyhhQaVXJuNB8XD2XN7tyWGGiHHAU6nBzMCrzJ5MS8pLurY0GW90Oug?=
 =?us-ascii?Q?v0cdZ0lulJINqyFlq20zXoGJQm5VzxSUNkaBrbWfd/etMV7qiNZ0BXZP/oqG?=
 =?us-ascii?Q?9TXIbDdxuLsXvoBLa4hQZOvBDeihg871q9Zg22ePAmn3ZFu94KsJ4guVLdRg?=
 =?us-ascii?Q?L+D+KEew5KBofmVR4HYPH9B2qLqT3IQNpI36UM9d4EiXKKVmZF+sJDDThdpj?=
 =?us-ascii?Q?Effb8+w1yOqYd0nMurkrZTlLYVFBnnA3Ud9J857DZwfmMbqv9EaTFk3ZFRYO?=
 =?us-ascii?Q?FsYWmjLgAAbFEGSODQmgpyg90Jiq+HuYLoVgmVPh5/yHb/NlfW9vrruFCQDJ?=
 =?us-ascii?Q?DN2P3zMXVrk6EcYl61saBFkViUy92PI4neOKPDUcOXQHm7IicrEO7BUNGDRq?=
 =?us-ascii?Q?76sorJlLV7Pq2WYT95Wnyq/mLQjO27QZDCmSy3azcgpahv83J6Zg+4oozTU2?=
 =?us-ascii?Q?gNCR2eDXQZFV+W6gRk1jo0pbSBcn6yWZrXlMNav2hqmJxOAuhkIbJ8+6FxNp?=
 =?us-ascii?Q?esi8d/lPwGkQkBO4fCRMZT/UEHSNQcnU+kgNPF95+gg0O8vwbaxq8G5Hx4pp?=
 =?us-ascii?Q?Jzik57ZKBlRZnDHyugZBoFMwQc1RESYHIf0ZqjS/lWRrphAu5Z8rZrg8x4GK?=
 =?us-ascii?Q?Y40NFyDAMYzChybG77hDaaBs+Gjf3RvdOl+I+0PDd2zqRJBLqyhkX7xn9mPj?=
 =?us-ascii?Q?ZCUHc4YSuRYBFwJ7FG2tX957zwT0SHo+J0RDbfOuf3Hc7o/ePfmpurHTGGbc?=
 =?us-ascii?Q?0ML5xK8a+609LSpInvzk08B4j1mN1H2ARtQ1f0SHsML4GNZfS2uK1OuC9K8X?=
 =?us-ascii?Q?LUSO72l0Eqzfw8fu8V77WUUWrYO8T3pOLkR6OldeDe+cN+IS08lyj/m9ZD5j?=
 =?us-ascii?Q?aF5lLi3k2ufMn8Uw0ww2DB8M2Ubx6gkslbIB8vwDlvrlq14KUEeV3gq7DLyB?=
 =?us-ascii?Q?etMuwy2+gomsnpBhshXxp3efa8SKTz/he0cVs+xEBza2KU/Q1gmpsJIeurIi?=
 =?us-ascii?Q?nrMy/DYdBYWsBq0P4iR05q4uHgkH69QssysmRd6p1k5Dj48bw4cSAEXh7sew?=
 =?us-ascii?Q?Vgf2lmTldErleHuGgOdEAsMuQn5ETlhvdhOFlcSHjnqxYrDMIhfwAWbeJSlO?=
 =?us-ascii?Q?xKybnF55FjAo6+/nXwYRTucB2q/4ujJpYkcLILENYDXCwCNcQWR/o+0qpVNt?=
 =?us-ascii?Q?bzw81fcP9a/TuFQPksnfWvSv//ZYD2ucnlBPFGb6Yc6R1MMEaW8KU+hW0i+9?=
 =?us-ascii?Q?jWMy/0zf/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce51a5b-2c2c-4e8b-2b0f-08deb6e387ef
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:49:08.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnBpa6maRv0VpxVvRsQVOGE+MTFK9C3yQst7MExxIJxYa16oEW6a7SaYgo/jXfP27AfEBjIDfCjzvhBIBRrKtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

xe OA and EU-stall paths open-code a partial copy of the system-wide
perf CPU-event permission check:

    if (xe_observation_paranoid && !perfmon_capable())
            return -EACCES;

This open-coded check skips two things perf_allow_cpu() handles: the
graduated kernel.perf_event_paranoid policy that an administrator
may have tuned, and the security_perf_event_open() LSM hook.

Introduce xe_observation_paranoid_check() to wrap perf_allow_cpu(),
and convert the open-coded sites in xe_oa.c and xe_eu_stall.c. The
dev.xe.observation_paranoid sysctl still acts as an escape hatch
when cleared.

xe observation now consults kernel.perf_event_paranoid and the LSM
perf hook on every open. Sites that have already configured an LSM
perf policy or tuned the paranoid sysctl will see those settings
extend to xe.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/drm/xe/xe_eu_stall.c    |  5 +++--
 drivers/gpu/drm/xe/xe_oa.c          | 25 +++++++++++++---------
 drivers/gpu/drm/xe/xe_observation.c | 32 ++++++++++++++++++++++++-----
 drivers/gpu/drm/xe/xe_observation.h |  3 +--
 4 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_eu_stall.c b/drivers/gpu/drm/xe/xe_eu_stall.c
index dddcdd0bb7a3..ede8e3c98b2b 100644
--- a/drivers/gpu/drm/xe/xe_eu_stall.c
+++ b/drivers/gpu/drm/xe/xe_eu_stall.c
@@ -963,9 +963,10 @@ int xe_eu_stall_stream_open(struct drm_device *dev, u64 data, struct drm_file *f
 		return -ENODEV;
 	}
 
-	if (xe_observation_paranoid && !perfmon_capable()) {
+	ret = xe_observation_paranoid_check();
+	if (ret) {
 		drm_dbg(&xe->drm,  "Insufficient privileges for EU stall monitoring\n");
-		return -EACCES;
+		return ret;
 	}
 
 	/* Initialize and set default values */
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 6337e671c97a..f15847be01bc 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1676,9 +1676,10 @@ static int xe_oa_mmap(struct file *file, struct vm_area_struct *vma)
 	unsigned long start = vma->vm_start;
 	int i, ret;
 
-	if (xe_observation_paranoid && !perfmon_capable()) {
+	ret = xe_observation_paranoid_check();
+	if (ret) {
 		drm_dbg(&stream->oa->xe->drm, "Insufficient privilege to map OA buffer\n");
-		return -EACCES;
+		return ret;
 	}
 
 	/* Can mmap the entire OA buffer or nothing (no partial OA buffer mmaps) */
@@ -2052,10 +2053,12 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
 		privileged_op = true;
 	}
 
-	if (privileged_op && xe_observation_paranoid && !perfmon_capable()) {
-		drm_dbg(&oa->xe->drm, "Insufficient privileges to open xe OA stream\n");
-		ret = -EACCES;
-		goto err_exec_q;
+	if (privileged_op) {
+		ret = xe_observation_paranoid_check();
+		if (ret) {
+			drm_dbg(&oa->xe->drm, "Insufficient privileges to open xe OA stream\n");
+			goto err_exec_q;
+		}
 	}
 
 	if (!param.exec_q && !param.sample) {
@@ -2334,9 +2337,10 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
 		return -ENODEV;
 	}
 
-	if (xe_observation_paranoid && !perfmon_capable()) {
+	err = xe_observation_paranoid_check();
+	if (err) {
 		drm_dbg(&oa->xe->drm, "Insufficient privileges to add xe OA config\n");
-		return -EACCES;
+		return err;
 	}
 
 	err = copy_from_user(&param, u64_to_user_ptr(data), sizeof(param));
@@ -2436,9 +2440,10 @@ int xe_oa_remove_config_ioctl(struct drm_device *dev, u64 data, struct drm_file
 		return -ENODEV;
 	}
 
-	if (xe_observation_paranoid && !perfmon_capable()) {
+	ret = xe_observation_paranoid_check();
+	if (ret) {
 		drm_dbg(&oa->xe->drm, "Insufficient privileges to remove xe OA config\n");
-		return -EACCES;
+		return ret;
 	}
 
 	ret = get_user(arg, ptr);
diff --git a/drivers/gpu/drm/xe/xe_observation.c b/drivers/gpu/drm/xe/xe_observation.c
index e3f9b546207e..39e05b9131a7 100644
--- a/drivers/gpu/drm/xe/xe_observation.c
+++ b/drivers/gpu/drm/xe/xe_observation.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/errno.h>
+#include <linux/perf_event.h>
 #include <linux/sysctl.h>
 
 #include <uapi/drm/xe_drm.h>
@@ -12,9 +13,28 @@
 #include "xe_oa.h"
 #include "xe_observation.h"
 
-u32 xe_observation_paranoid = true;
+static u32 xe_observation_paranoid = true;
 static struct ctl_table_header *sysctl_header;
 
+/**
+ * xe_observation_paranoid_check - Gate access to xe observation streams.
+ *
+ * When the xe-specific observation_paranoid sysctl is enabled (the
+ * default), defer to perf_allow_cpu() so that access is governed by the
+ * same policy as system-wide perf CPU events: kernel.perf_event_paranoid
+ * plus the security_perf_event_open() LSM hook. When the sysctl has been
+ * cleared by a privileged user, observation is open to all callers.
+ *
+ * Return: 0 if access is permitted, a negative errno otherwise.
+ */
+int xe_observation_paranoid_check(void)
+{
+	if (!xe_observation_paranoid)
+		return 0;
+
+	return perf_allow_cpu();
+}
+
 static int xe_oa_ioctl(struct drm_device *dev, struct drm_xe_observation_param *arg,
 		       struct drm_file *file)
 {
@@ -83,11 +103,13 @@ static const struct ctl_table observation_ctl_table[] = {
 };
 
 /**
- * xe_observation_sysctl_register - Register xe_observation_paranoid sysctl
+ * xe_observation_sysctl_register - Register the observation_paranoid sysctl
  *
- * Normally only superuser/root can access observation stream
- * data. However, superuser can set xe_observation_paranoid sysctl to 0 to
- * allow non-privileged users to also access observation data.
+ * When dev.xe.observation_paranoid is set (the default), access to
+ * observation streams follows the system-wide perf_allow_cpu() policy:
+ * kernel.perf_event_paranoid plus the security_perf_event_open() LSM
+ * hook. A privileged user can clear the sysctl to bypass that gate and
+ * allow unprivileged access to observation data.
  *
  * Return: always returns 0
  */
diff --git a/drivers/gpu/drm/xe/xe_observation.h b/drivers/gpu/drm/xe/xe_observation.h
index 17816998e966..73a03e03c96a 100644
--- a/drivers/gpu/drm/xe/xe_observation.h
+++ b/drivers/gpu/drm/xe/xe_observation.h
@@ -11,8 +11,7 @@
 struct drm_device;
 struct drm_file;
 
-extern u32 xe_observation_paranoid;
-
+int xe_observation_paranoid_check(void);
 int xe_observation_ioctl(struct drm_device *dev, void *data, struct drm_file *file);
 int xe_observation_sysctl_register(void);
 void xe_observation_sysctl_unregister(void);
-- 
2.54.0

