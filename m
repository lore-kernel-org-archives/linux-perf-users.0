Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FB1DC98E;
	Tue, 10 Dec 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823351; cv=fail; b=M1OFUtNM2fZwoTo2Mu2sdjgK5QKkJ2M7UotJllWGPt4g2ovBYJilw9nSlF/4LhSpLIIezA8PkluJQTuwou7MAieW5lpBxciLyJT4q8QoSw/jLACTJJDwai/3YW4o9+thDGIBOBY8bX7+R3Kh0fjmW6T/z61SXtFsZUyc8LaZpBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823351; c=relaxed/simple;
	bh=oXwMspnklaEKw+3Dnwk+UzHBujLoVmxzLBT/pyUJqcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARmCvn4963RoeWy7NupGpaP26tnq++uR1tHbj+wTJqWaZ9nbCjXuPuSI6c+qSZBJUiA/vaX4wWHMzlMyCU+kx5t89fY5iUGXBzhx+lhkUhli1MJEtY/NKlI17wFqacjOOJ/6gzEYFJz94S1BpfV9NAHT1rWihHRW2OsLk7XxgfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UG66CuMM; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UG66CuMM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCXxvJfLRTMcu1OFIXhU5SkL9xgP1fyW07LzgQYw6zvd+IRVoPQgXwB0KQukF63KT1/0wT6DolrQq6NiP7NAO01wevLspZ2hm6XFVthgiS4Ss6pixqwBqbYy5BCsQlkDFCLGo6nUB2k+N1J5eyk1o7ZcRbvSq2kPG6JRCZ1mnEKnOLN9x0kP/Uejx/LXBGfRCIgGg2koLgO26aM8LgIdAVFC75eZk32ekG4ay2HPZ7Pazhw94SpYRa2sHWf7ng8P8wampT4TN/BYmJeepT0tq9R2oUpOuU33vHzSihOdHktXF2WAUEErlMQZt34HGvnRhLxVEyxwrMync2e4Kuwqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwDzLvP8sO/hht95liQJ+am7mc0dDiplwj1UV7IIzG0=;
 b=Z+UBjknMSCLMzVBXA6nQz5vKDLs0taH/tmQvSkYUEuICsJxZKXbTCNR/rUNv4OUx/9QkPNzdf8P0sgm7E+w4lU7quQlSJpnMoZ+ceudDlo2uOfxfY/rJ7ImNcspyyD8KpFxAX7Z1+KCKOWrrCUfKKKk/Jm3spUL0VMVYQQlDKJOKrhN1hvIuxG0iWCabkRFA+UtW2NGI/0wZw7xED8gq7RVoGGLKK+hAELZgDe20M9ELy6lL5DSzYSjBPZxky+l8Ftzi4TDl0B/rrvWriEMQzKpS+aOGoXLma5CDKXnjJie6+9MZxxNKWCD8n4ikSpZmBkNCqN2JS4Rw4ehUn5C8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwDzLvP8sO/hht95liQJ+am7mc0dDiplwj1UV7IIzG0=;
 b=UG66CuMMW/ShV53h4cZqJBkg7BXhed3Q0n/7fbjqNjacAQvNR7yRnjjaPhugn9B5hVxoHYmqky/SyJYphq+13f/vOvAlObflMkSEQwSOTEP6BnLZXQb8RA5YuTQj7viGy+XAOtO+99dJSpBF1/sFcZOyiUnXYXp6L+E1eRiqKwk=
Received: from MN2PR17CA0002.namprd17.prod.outlook.com (2603:10b6:208:15e::15)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 09:35:45 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:15e:cafe::6c) by MN2PR17CA0002.outlook.office365.com
 (2603:10b6:208:15e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Tue,
 10 Dec 2024 09:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:45 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:39 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 05/10] perf/amd/ibs: Don't allow freq mode event creation through ->config interface
Date: Tue, 10 Dec 2024 09:34:44 +0000
Message-ID: <20241210093449.1662-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fcd872-cd49-403a-8176-08dd18fe05a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GBOrJvu/+nwt/aK+dQxsb8kCvNGuJO8u7gXX93+xJHEJIvT9JTuVzhUrbWkp?=
 =?us-ascii?Q?n4Uy9FpqeISYQsL7GPMfdVZVeug4OHOJfRpPwVlWgKv+Ozl9WL83C/UXMFx9?=
 =?us-ascii?Q?fRij7YDzqtoLJcn2mcZkkipcEjwjJ6bkAA8p+9fhdHDrWyFwR5dJqdczJO1N?=
 =?us-ascii?Q?haxnyL1eLw9L6CYFms9infAYoIRPwWT/gthNVMZKzJ0W1Ev4wKnjWEGWm6Gf?=
 =?us-ascii?Q?72v8m7CrIwyteGfsG3/JtL6cYu6y4mI4KM214cxhIcVUoJ3KHXqKDVniaEdX?=
 =?us-ascii?Q?Vj3XIXI6ltCMSXx65Lzv0MVp+AudoA/RK8anoDjBVKeDCyRrMlslXOCHPMDb?=
 =?us-ascii?Q?/iDy+W0LHncAT5/RMUYBrBkDQFer6L4Ob2TXUZrpY4n6tnZmH4YODI6x2EEL?=
 =?us-ascii?Q?DbKaRnLLzWtWmcnF1rddxmALsSztnvnh5DocJHhC9ign+9vM+0+QwkKrR/g8?=
 =?us-ascii?Q?roqvG1GSz1Pf8LlEohqEApMgTIMN3Jhki9n8V8WXPPq2zerNb6NhPYcbU/Tg?=
 =?us-ascii?Q?VLG0vXVnkzDDfRZvZcwUD0AGdgYPgOS0cu7rHC/F0jMWVQkM+5eHdC3bpFwP?=
 =?us-ascii?Q?XXPCweTtp615Azc1fCypZdGrz9eybAAy6gLaynec6eL5YVcXvoW7IVw3DSx3?=
 =?us-ascii?Q?TUuavfcDrQ034Cu/ITyp5Thfp47GsMYHjHTrhOxHljJdUse0XkzfUiTOPh30?=
 =?us-ascii?Q?2tEgap2GeO4A9zK74EtjK+6oMGtsQDHz3aFu2Ehais+3Ed1/kJC1mtYecqIh?=
 =?us-ascii?Q?koFsSvHevBswc8Y0EGFOOwlau76URHO0w1Na8J7hLYj+i0Zn0239G/EpgxWH?=
 =?us-ascii?Q?5TBKzbLn+xeZgqjF4Io6CuB2tAYkTYI6bOkmDGMIA84p+Vz9ZCou81KtYQc1?=
 =?us-ascii?Q?TQwKXny0/vkUihLClhMMy2BaeCBwq0sOgqcGS9r9rxE0ofgb006uS81Fc388?=
 =?us-ascii?Q?GdE/iomKd81SubVXJJAWXcjXYGY/NoPtwrKiUOImhY5QaTcf9bbcsMXIVrjB?=
 =?us-ascii?Q?J5Sa9zjGoo4xYRcJagEGkl52jaMfexTdP7YV7OI4PKxB2UfECYSOY4g+iGHt?=
 =?us-ascii?Q?0EeqFwxCvFRcSoyv0OKNJzQD1AhZ2E9oCezo9+CrkT1K+DtGzeZlSTIcKVFj?=
 =?us-ascii?Q?RHoiY/r1HvKt/2f6fTspSr161zgcoiBEzQ4D+3pF0ZtrNFoN8rwe8TWmE1BP?=
 =?us-ascii?Q?I0dv4saz85OY/neJosP8aOM+yfy/1eiSLokBlX09BkdZY4JI4MMFZMMg2bO8?=
 =?us-ascii?Q?0Gu487Qld1lka3Az3dETdSbUnES77OsPN9vaXRv2UY+KdmK38YuTNHxmJ+2p?=
 =?us-ascii?Q?RBtN4DCTK6JoxGNc/2rl453foKBGn4JzNkmyl5n+von0AZOpmWLnzOERxYQO?=
 =?us-ascii?Q?SzT4eiyrHuvNEMyNJ7oNm7JwshknSn3qpjG4V6x9qq3wUTP7sv8gdeYYOMRW?=
 =?us-ascii?Q?AVIAlwrl9fwSkUQX5Zk18zPI0zb55aZa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:45.1451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fcd872-cd49-403a-8176-08dd18fe05a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

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
index d9c84f1d530f..3e7ca1e2f25e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -315,6 +315,9 @@ static int perf_ibs_init(struct perf_event *event)
 	} else {
 		u64 period = 0;
 
+		if (event->attr.freq)
+			return -EINVAL;
+
 		if (perf_ibs == &perf_ibs_op) {
 			period = (config & IBS_OP_MAX_CNT) << 4;
 			if (ibs_caps & IBS_CAPS_OPCNTEXT)
-- 
2.43.0

