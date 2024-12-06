Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE981957E7;
	Fri,  6 Dec 2024 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462301; cv=fail; b=AtxbPhFWj8sxc3IL2fTeo53yz9T3PuSHKMa70vXlx8IOeJtxw/RCppBxP3SIyU9BFW58oNM+fs/0b8uQM0+7kBDOhuY+C17ZJdnsYqgjJx74LS4/0ci3XP8h963QNDGK7CJOPruljTy+9TLQQFEcjeKjtfsuWqfIAkeAsQFGBq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462301; c=relaxed/simple;
	bh=lrJ4p/eJqYxOguZ3ugo/FQP+IAbzGuGJUkcNoXFdv6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODIxJTQUj1iE4TbU+onz4qSeY1fpoLf7F5C5L3PtjrfmyjlWPv/uSj8SpAovFaHDM1QDt2kEv3FhkVbsSNSneYJmpHXpRguOU8KFidac4bmNUOz5/AbrRtfKKjI+zlQi6YJ03j0XZwzgXJZucz6hyrnOVkiqIUo3glV4osRsfg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bVBJa+6T; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bVBJa+6T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+bO2VYllRVKaXe3xXg46/Yl+lTRF4FUFcLcJuYERvo0YrMGk7NQOHKoXEGbtSros3bJCAJvBrrW39XC4CdPDxPb5wHgo9dSP8AViV/rmCTHtr2J0ipxxV09Q/J+Riu1PlIWFBt/XmZ5iiJIC9CFlW16W8SZMtFR7aC/Ns/y27ijAxX3Yo/IjhcWuAVMLTCHEg6KvRL6nxuyDjE5+X8/faiA5oSBKvTsr3+ntyBl35EE+AOVHW3cJwD5ncZNecVZ3rqOh0S/CGh92REd4zgytvHUrMYAU+16jn52mDjiNtCcf2JgL9AOJQpbGpQNM1R9PP6PyB6UKZ4Qsxq7BmwWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwQzVXvIhFcEh+rqJNAGMUSMyi3DbJVpKYwdU6vn2cI=;
 b=YfOPU9AW5ApUzOLmPeZ1F9DTDC3m+fYmBTcZB55G0wfl81wFqJnUfrk1YFbxbxXqLrvzeRiegXYZre8lW3A1/4NE7tNZN/GzQUJFc41iW83f3ZHY1sghAxPZzZ2M31hi/39g6v0tHdZDeNah68jw3xi6YfPAmBFe/tm9dGYWjrFuMRC1PiQV0AsC0DthnUuh4L/g+OBqTifjfAl5Qz9VSemPIdVo69qKuUBEed7JkbxZuRxJ2sAnqmZYA8rEO9JNA7ygyMBKBT392CWToV0qbsq7LT6KTMzuxyG9Cd+f/Zd+kZduuE97OvzbgTZixJl8PtWHOgXQQHPGtlU7X9geAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwQzVXvIhFcEh+rqJNAGMUSMyi3DbJVpKYwdU6vn2cI=;
 b=bVBJa+6ToABKB/qNJHLopBWMvjFXhx/EAmgIpMRBrgcff3R9krKzvP1itxHO3b/DXuRIJEQ+03rF44avSfYvG9I748Esj+/ooiV5TRf4D5c9Woxc9yhOsENWZhhKRYbgSzn8ZCCPR7R/iVyl97t70sSKsM2HHktY7RmT+kd2bVk=
Received: from BYAPR08CA0023.namprd08.prod.outlook.com (2603:10b6:a03:100::36)
 by PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 05:18:13 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::a3) by BYAPR08CA0023.outlook.office365.com
 (2603:10b6:a03:100::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 05:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:18:13 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:17:55 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 05/10] perf/amd/ibs: Don't allow freq mode event creation through ->config interface
Date: Fri, 6 Dec 2024 05:17:08 +0000
Message-ID: <20241206051713.991-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206051713.991-1-ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH7PR12MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc42b38-0744-4abd-1ef3-08dd15b56229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQM5HUkClbs5omtSojyLZXjG8OU4ReyPWBSUrt0s+Qn8h2sjuiYqK6DNHboj?=
 =?us-ascii?Q?xWS41aGCD8FRxIw2OkHdMM+jGe1US4zTVbA2fMHClXYEgC5GW22eVMt2+2ss?=
 =?us-ascii?Q?kuEsmVEpJvo1+6SzsQm+tfNrAI6yBA92/K5fyWC1abZiP6+vjebGM6faD1yj?=
 =?us-ascii?Q?pawEoLxiTHr5/8Ghh2Q//4465euLWRuFspGluOvjXQzVDhaToZXnxEhmJz2N?=
 =?us-ascii?Q?ZQ3FKG16SEMfFfnR14L5HFz8fshP27aGxyQopt8AByf3bBRQ+t9cym0GKRJ8?=
 =?us-ascii?Q?5Wh00Za85Nuzj8M5+Ksru+nFq316TYpDi/6n2ptpIGp+yyIJgfHttqNfdWfW?=
 =?us-ascii?Q?O7TE2xWtBCqoB6Ankh4rRHY6AGwvMsk7zCNmJaiXiIfH9i7LekZZGD38LuL8?=
 =?us-ascii?Q?qPL7dEVh5/blQ2jxE/0TAD6b9E4Lfg4JOuXccrtd9jdFwGrf/OsQBZ915asi?=
 =?us-ascii?Q?+Ba+GnxfiRXQoANE67VFBF5VLffgdWpz6yk0/ZRVu5oi3VCnM/5ubcNj5UFe?=
 =?us-ascii?Q?u6fkX3SfjJAFD22D0LGgXZsukXI8fUd8ZRlexCXzjDB41yDe5UoLF3KE0+Fu?=
 =?us-ascii?Q?P2LucQHH858ujOfgH6TVkloLJuFpUQY6bSOmxkBAt5H0B6Tb6oF3J6J980Na?=
 =?us-ascii?Q?bQmzOS+tdxjAI61Yq0xnBJkcLzx5EdyoYrD0M/aQpMUVxKn10C5gOu65ZDOF?=
 =?us-ascii?Q?l/OI2JUmFqmwUibc64FmwUG395fx0xxmazTXF+on+i9fbdmSmLfSU+70/du0?=
 =?us-ascii?Q?rPO+RqjIvIZYZ4rKHUer/mkkhhgj7Z3NYKDCaOOLFseqM+NGew7GvmD7Z6I/?=
 =?us-ascii?Q?Pq+KSXqowMUC7M4sy5BdYOC8vC/qn8ZZbGETmEqb0LukppPZHljZxOLsDLyI?=
 =?us-ascii?Q?eQEci8E4s8LfXtu8FLV5AY0r78Ph+U2bIT5tpzOaQLjyvoMjGJAwSgUoYyGe?=
 =?us-ascii?Q?1FLbitEQ5by78vJ2rVHylw2xtOxYtqw3CFYGWcImDPpUtOtyNNiQx0Urk6t2?=
 =?us-ascii?Q?8Kk2L2Ca407J8Pp08ZLy5WFO0OR+JxsFSTWMhPXmpzfCpzAlWGQzsAZHFYPX?=
 =?us-ascii?Q?4J69iTKJoA5m1kL9o9JVdQewuZVHg+8HPO1Ys3uasHMTTQxz5pLycVvyDSBn?=
 =?us-ascii?Q?Glk1IJ1W/tSk3qPWVFnFU6QGDIr2gr6nYtFSj/cYtog6xNOe7V8rT61F1qXX?=
 =?us-ascii?Q?yIlW5sYQ5fQXHpvT92Xt0i/lE4WtqZsFrRj8ge6NzSes1bhEUPiJZO6panU1?=
 =?us-ascii?Q?IgmDVek3PiIXtEnu0SmmBvtW+rVNig0cgV9Fzjv1OlfMeMoUG1b0IcF2Yyah?=
 =?us-ascii?Q?t9KsZI4gCwO2ImQXMDiIEpG0gywlo9OOBQw2VUXRj5RscXdb3Pa6kuNbBRoj?=
 =?us-ascii?Q?LQqv6z/ik3uk06aLQUIbW9+IO/6cQh5h6u5gpiDNPCU7IRLKJxkh29Sy6tyM?=
 =?us-ascii?Q?3QLDM1DcN2MDGYPkkMs/pzv2QDsLYY1h?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:18:13.5041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc42b38-0744-4abd-1ef3-08dd15b56229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6611

Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
MSR. Since the sample period is programmed in these control registers,
IBS PMU driver allows opening an IBS event by setting sample period
value directly in perf_event_attr->config instead of using explicit
perf_event_attr->sample_period interface.

However, this logic is not applicable for freq mode events since the
semantics of control register fields are applicable only to fixed
sample period whereas the freq mode event adjusts sample period after
each and every sample. Currently, IBS driver (unintentionally) allows
creating freq mode event via ->config interface, which is semantically
wrong as well as detrimental because it can be misused to bypass
perf_event_max_sample_rate checks.

Don't allow freq mode event creation through perf_event_attr->config
interface.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 11123c174a3b..a687ffb09905 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -302,6 +302,9 @@ static int perf_ibs_init(struct perf_event *event)
 	} else {
 		u64 period = 0;
 
+		if (event->attr.freq)
+			return -EINVAL;
+
 		if (perf_ibs == &perf_ibs_op) {
 			period = (config & IBS_OP_MAX_CNT) << 4;
 			if (ibs_caps & IBS_CAPS_OPCNTEXT)
-- 
2.47.0

