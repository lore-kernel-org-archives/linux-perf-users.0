Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C54270EC1;
	Sat, 23 May 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500018; cv=fail; b=DtUKDWJa63GCgh7CNFnKatpeswomwszK9ji2LV2Tst1T6RPz+1x6OeORtL4jZvjSLStNDUDmMdJDuAICZcQkGrEii4nFlhRebmSXOm5HR4AMx+a0wJOy8PzImiZMUH5KOXkOHkcOj3VZdEVpaYMpmhokCZSTolyeLXQbKuj0ns0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500018; c=relaxed/simple;
	bh=gpYxVYeRxamQyoQ+k0ghw1LyPUEpaQpyqPfg4WNaF4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GoWunxq+M9mr4PveOpU++taeoiymb2o+zjLL1TN6z+JdVyAuw4UsfiB8fE8cd1KwNadUTz3ebwDn0n85lBZ5OfRAauzHV0xES0z384++uA591p9elrdW35ejuUzIydNRAmDLd9mzhEE6JPzXQpCs2siy16jIqB/bDm6OiHlng98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YiCv/NFx; arc=fail smtp.client-ip=52.101.62.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YiCv/NFx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBGih1y5RHF8YuGKzvQUVh9ev0f24yhm8TzZs6s8bL9knFocgjzILdrsIeBRU4kV9YAmhZoO4oUiW1XbKJGsbzYx1CT/womA81ESarloYn1E0wSay/Q2gNul7rghf69eFLFmsi4ouNyuJQ5zx4dLjOfTi4iKuuIF1eRlxdVNNpLHOecS0fSyo+H31mOyW+TuWKuq36oWIgSr5nm7MXUwUfv7dX0PN4kpHbpYCbGwxq5SAEYu7KDqilA+UEABd2JrHYdMymWEeEnhtdnOik8xIU4l2bW/7NK3uXD0gT3a3XXWShhOAiBUNWm6u4hjhemHm7G4Xbr8if6qncTn6gAYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnDHBQMTjS1NYEkoYbsKHuQ6bVJXcvBMT3b4FM5PmxA=;
 b=KUz7khExCmc9imHDja4DpBDzYTtWLiEldpzLov+6GhdXDzZaDLQYp+GBBEeqbmhbREPjSoo/Be7Ja355dgWLU278hJl6edTaOWGRcfUvgJvkoIr55Ir3H8xi3qjpakWawzb/cL3A86ZrWoa6MzOw1Qk/JCauH8zc+m3eMd5AaIXtFs+o7dhyvZ4h1MKGZfQKvzsCmnViIs6+QahwBCs7FDiGAgg2lC9D9X93yqkyVVI8NpBJAuw9dqSpZgobfn28/F/G0/ypEEM/VG8BlCpKCj68rZXEDVPOqEyUhQvbDSvRTuPDB5uhdZzWvj4GTjkGSGB7XOf8d9H14fbXZXpqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnDHBQMTjS1NYEkoYbsKHuQ6bVJXcvBMT3b4FM5PmxA=;
 b=YiCv/NFx4Ln29aNYXUEk7Uv46nXMh/vqNnwBIG9pShDRQNPcrl4ldIg2Cud17QU5oTS5/5dr3tNt0PkZyK5PgQbHgdEIJQOjcklTZeKbPUpN7j2YAT6KPyerz5qNpTbRhdKvkY7r4yDkybojColtajj7rI7WLRTvT4+iqmEn7Gp9ytdIhnKtajXD/wOFpRGinf+jJyY3rh2tmjJ/FWSXl/QWTE/rdFvX9h2KFGvLd2zqqOBQUxdxw+RQ4Woy01v2JClpaqZkFqGn0aVvoY0LfY/5F1Be4mxWeqKHmKa8s9hkWPuU5H+UAiBKXpa98sxkAuj1E3Q/J5Lwy5N+jmUkEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 23 May
 2026 01:33:31 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 01:33:31 +0000
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
Subject: [PATCH v2 2/2] drm/xe: gate observation streams with perf_allow_cpu()
Date: Fri, 22 May 2026 18:33:26 -0700
Message-ID: <20260523013326.129491-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523013326.129491-1-jhubbard@nvidia.com>
References: <20260523013326.129491-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: fa379677-a12f-42e5-b96d-08deb86b4c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	mOENB8h+QZAZREGzgoNQV0Qhg/TkG4k6LvGOU+VZPcA+Is8ON+0cj7SVqqETUcJqqtvZO2Dix5VS2QpGMBUwZkJjDOPDh909V9xBp9fmIneguvAnBfTfwCNqzcxPyatVSOaF2n1KiCkoWMzLYEhzquecEk+epr+UeSdYoUTMkdd0mbbSk7r1wrGXkqtzcEqirklfCjyIl/kX+AP7MUpb8gnIbVDV9fiz31BL1/Hw9ggenKK3I6YXAI0IbBQ0Fw0xeoQMafO6TENyw83+qu60fBA75fKGozHK7kBO6+KiLKi5Q/yyBi9bmDeu3cj3afCnPc4X0sMB2j2oO5k/MbnjNDhDEMgJA03MIaOHbxyl3ELjnepyQ6zBq5xNwKkzY7AxncTWoa7LDSSA8KlKFoIVXY0nIgG8ux3tbW3gMIr4qWhD+yUIMg2dGiyHLG9D+S/JSMimtZN0tvFobX264o1UV4KJ3IEeDLLcOnxtBCtwiN8OSSizUG4rusRGzxJXjOfC7HAVB28tf2b1FRd5jrBBZryCqa4YAORjRtRg0DIEcdxBnqDr8OEJKo+8O8fFMn8sDXRokAp2aQm+a1WzlMxOfvYP/1mLeiEa9eprimkroRBlylS3DW0NFu4/2OdOwZ1Vl6YdZPf31RT9OuarwZyRAJ37vh1iY+z5sLZCLTJJukgRIdtUgXXU8ruoZPxGOcnF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BRwaHPUZV9BML+t79/q0B3FZWi63TYLIIki/2lrzXbIzyzgBwqtcqbNook9M?=
 =?us-ascii?Q?uMauBNEmR3AUsj+RRpaY8iNveOplV/uSj1nfTlR6mTbd+7OPb8P43SsPchoU?=
 =?us-ascii?Q?sJiphjwELEi/9w/695+nr/s0PdSTOJMdx0dOMIUxXyZP87eIAHsaUI5T3s1O?=
 =?us-ascii?Q?Ybfoul6atvyyV3zCVp2DmVa2YBxCNPFLKI1yxLAVJjnBW872fVZpA+8L7Rbj?=
 =?us-ascii?Q?3Yxm5P9LL584RMsnY1ptwdSF3Kwl3xkeY8a4YGRz65Wa0klFXBMIBVzPMzak?=
 =?us-ascii?Q?3CuoiPxS6pt4EqXL0eed3uwdBoRMgh/VW+URqNr2lhE4bKut3Vmhs7/3/mpF?=
 =?us-ascii?Q?c2yVmDKbaHcgR20tIwIyx6Q+UDpSYE5+6UINeqC031VXbUcH2b+jwHZZQSeP?=
 =?us-ascii?Q?NeyyWuQWv97UuCHZtxNor5pnBV7bIouxrsgsiMIOpj38fbtBbZYtWtlDP/P4?=
 =?us-ascii?Q?CcDVaLZOgCyGKIaKzFjEcQtIzxlSzCp0d8DxqslVNvfL5vDig9q5ALl8s/pR?=
 =?us-ascii?Q?foxji1MMmWs8DxaGKDA/ECEPy9EejAzaDoDvDi2/VzHTDOl+vvXzOMPK4Rz3?=
 =?us-ascii?Q?1WyaF7GM+3NlglUIYUOHyqV1Ss7bE4mRaolEppLOpPXeCa1hqZLjN5p+YkeZ?=
 =?us-ascii?Q?/J4NFoNGHkM50p3c4sFka98YHcv+U8wYiJUAUqA3Vp4rINPyQTmD9OErondh?=
 =?us-ascii?Q?ogi3GcymKug53iJfaBLyBtIsBtVFWBBpzvUY4AIowFibk0CdOdVJZ85iE23t?=
 =?us-ascii?Q?Qn3pWCmi0tsMmDen5+NwkvFMzZtsC95nceXWVrjCgiC7HxQjK3gwWjW0N8FO?=
 =?us-ascii?Q?Eu7+e4uw/P47BSsIezVNAqIjHV1WYuX23iQTTY3U2A9qSqFMwD89lKBymJ/B?=
 =?us-ascii?Q?nF1urGsRmNBAUuNFKcJlpa+JMRoh1BfXjXvUr5nI8VuWQotU4ZQP9yOTu+eD?=
 =?us-ascii?Q?xI+hxfchAVe29nLMDkeHKa6WwLcmsczjgIRjp1YiaQJk4hKv0Y8dOVA5UO0f?=
 =?us-ascii?Q?9LkEuwZffwnS7p2K8OsE9eCwLQnbHdtP5I2waNxaD0cZmEJ2PT1iJxaRGCy2?=
 =?us-ascii?Q?Y9JI7zzJ37becYMgFhgB500MIN7qiuDjf3/DTnFfqtU1ZQBAuO5VhZXQ9SK5?=
 =?us-ascii?Q?WBbPs5dy/Fw6T3kPw1VI4sWgR4H952LbAd2Ce/K0Sph9n1RcCRPL72aP3d+L?=
 =?us-ascii?Q?KTWLedo46C2qmkZdUiwF3g7zxS9oxe0PYj85Wu/lIiq2bKj1XuS0+eo6nfqG?=
 =?us-ascii?Q?J53YpowUqgFmb3kX3CM3dhIX4YQjpWPFKUpFVl15gLdgaTuvGIZLJM3w7nPu?=
 =?us-ascii?Q?YrP2BC35C0q1l7SLUp8eb27vxE6kfcZtEpjVHquJ3b8/fRTeT2oZVCnmXkeC?=
 =?us-ascii?Q?5cUIiGFJVZZBVm8B05TAm49USJeTPxmSi8ryuR0Q1i0I8+mN+FirL5EgC1eW?=
 =?us-ascii?Q?HpJn6hE/CRhsQW++rCOWqA0z+sWBABU8mMO0bTro8B4hMJy12N1Oj3FTVm81?=
 =?us-ascii?Q?L5vBs2zy4i6HB6/iKfOVu4S1RbE5uxQPJ6tiEMdM+iEEhuunRH72T0pc4dLT?=
 =?us-ascii?Q?rQlJYpjdzqmQJ806GC6hwalVoaa/2uay3RsDxmjfgfWRfDnNzX/EIvUmXUzg?=
 =?us-ascii?Q?02+Co3sGvj2FELhgaCm+MjiYbqqj1N09+xsL+Pn0Ux5rDloT3EdZ2w37aBHz?=
 =?us-ascii?Q?OnRz2hMdo7j00Vv75TRzorfE/F3XSIdCcG802ho9jMszkRoaY49fLlL0e5b2?=
 =?us-ascii?Q?RFuQN0/n9g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa379677-a12f-42e5-b96d-08deb86b4c0d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 01:33:31.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qxsNh5bfY23eNvDUDUlff4BVKvnTQvHmBi/7TiDFcpHqvffY6sapTU+q0cv62UkOgYgL4MjssgFU+Gb/nHh1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

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
index d908f4e03906..f3dcff66b336 100644
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
@@ -2054,10 +2055,12 @@ int xe_oa_stream_open_ioctl(struct drm_device *dev, u64 data, struct drm_file *f
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
@@ -2336,9 +2339,10 @@ int xe_oa_add_config_ioctl(struct drm_device *dev, u64 data, struct drm_file *fi
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
@@ -2438,9 +2442,10 @@ int xe_oa_remove_config_ioctl(struct drm_device *dev, u64 data, struct drm_file
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

