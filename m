Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C862FD69F;
	Fri,  9 Jan 2026 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957905; cv=fail; b=eN1Oe0BU8Mc5D1MI6H4NX/hjWgJI8V2FjYO4J185wjYCAaA74TfarciUDSp2+C/qukpFvss05ah9b9bGDhh9A2bbzJgnnPTptS9R45PjroLyU7r9ZTyWL6O6xSkp9aBrSfppaO68fLKwX9QaL8SE5ZMA+3yOHCICwLdSTT71tbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957905; c=relaxed/simple;
	bh=eBnrprElHCxL3GbQJ6c+aJI1SrxqIcYRH50T62G1yZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nLtqRzriiu1emYWY+514tKuyZBJMVFgJhbAR9+0sZW9hBliKNDyvyKUexCSwfxOHAVOLAf8ctT3v+HmJa377I5wcoFGwMOtB2LQlPGmuimWq/DJ5Tsys3OvqU3SsMymbylskd+cYPKZUTiNLlxmgDgTT6KesVLzsfhXYT4+UypE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Aey0B8Bb; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Aey0B8Bb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiDzsv97ab5LmhZQePUx5tvZAlt7blEoR1WhnZ4CrLa49LK3qb46IwIibru4ybz92BiPVruxJ+W9CzQPI9g9LOZGlGcjqVEuxZ3oMwhehOGkBu2T8YsiCzDgUugCtgHJe/Cn93eENteJChuMeFZk/eNw0or81wkBKQdR/km6QmdArPcVXXXJPs9oZx18ezSyL+BNyqMCZqkUaiONDvOIJSPAhgpXnDedaKS/Y6f5zvaFf/c96JY1M+xoBtc/HomwyAcGVt4nYYUMUcFusoZUDsSmWXPp5JTgL2aRFIYW4qx77ezDJ/CoGh53Koerk3nUGntA4VNlw0Z+Ytn8npHHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSaP/kfdSEJXqKm2qVOpc0SnVNaZelGCpxzW+VB0wOM=;
 b=yF04k6vjAJM9y0C6zrka3Qkmq5T6aW/WB3FezJCXF9AWNNFSCBeSABHORA91+vNxdy/SCZHPLEstNgMbgiZDeJngrIazZkXy48StuGyVPVVORU8nyQextzI2ICECwkcF9Mp3rN6HbI8idV4eAPK6TSlLCPH8JcWtQgwc6YEySZOfeetbWkFPsGjH6lgeRjCegpGsVnwVyo2i6hL0ncP/VXP/DCm2qrt+Op3b7tlFmBZPWcMiELGK9FnArf55NR+X0bhICrp8UCN2Nzoff+y2bAuMORDcfsayyFxPmLb7tDP/Ht2g5x9F3jH+Fqdin7AJt9g9IpFPF4TkEu8HwU4TRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSaP/kfdSEJXqKm2qVOpc0SnVNaZelGCpxzW+VB0wOM=;
 b=Aey0B8BbjMdrV7TXw/gUDkiXSnC3H4xfbvxg34QaUclBOerZ4LZlaIn8tMHxyrzDin6e8KU343fFxEiWgVQ+/JRc5z3Fu1UDfA2x1a1Pgjs/aWdaiHXRzQCBknfZsbZcaw6I/paS74JAMukJJMEy2C9eWm3sRRtxGFWCTL0wcMo=
Received: from SA1PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:2ce::20)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 11:24:54 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::d7) by SA1PR04CA0014.outlook.office365.com
 (2603:10b6:806:2ce::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 11:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 11:24:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 9 Jan
 2026 05:24:52 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Jan
 2026 05:24:51 -0600
Received: from [10.136.42.229] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 03:24:39 -0800
Message-ID: <b76d4f3f-cf91-4580-b5bb-17e1fac21fda@amd.com>
Date: Fri, 9 Jan 2026 16:54:38 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 05/11] perf sched stats: Add schedstat v16
 support
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
 <20250909114227.58802-6-swapnil.sapkal@amd.com> <aVhGm6L2mnecKYHU@google.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aVhGm6L2mnecKYHU@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: swapnil.sapkal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd6821f-cfc7-4eec-6d7e-08de4f71b573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFRCL0RSb25mQ0tBNWEyZU5pWnVVWUVvb3pYbUFneUVhODZGb3FVZFYyaUIv?=
 =?utf-8?B?NnJheGpabklqYks0RUlGYllrWitkLzZGQ2E3TWtFRU51NjBmUFNWZ1RHTEh1?=
 =?utf-8?B?VzdiSjgrZzE0SnBpd3V0cklCeXVBSUE2aVNMd0p3V2xjOXBLdUU3ZEVpeHgr?=
 =?utf-8?B?YnRDelZFMnRhNWUxWWN6Mm93SXFVeEx5c1A0UFJNS0x6OTM4Zm16OW1ybjFh?=
 =?utf-8?B?NnBWQzJCbUR4U0NuWTZ1SUpsdlhpdUFYWVA5ZTVxTCt4NFFRMGJFNG9ManQv?=
 =?utf-8?B?STlrdldZdldic3Fid3RGSERTR1RYakEwbTJSVzFCSFNIMWRWb1BTeGlSaytH?=
 =?utf-8?B?bUkzNDMxWFNKOE1zdEpiTWVmM0F2Q25yT3ArTk1SZkpkZ1JEdHVJWWRrbzdj?=
 =?utf-8?B?SGNmcmpGb3NlMTJKNDBKbnFheVVJMjBmQndkWmtEV1hXZysxeTdDU3FFZGhY?=
 =?utf-8?B?QWlkZ3A3a1dwQjdDN0xac09xQ0RJRlJSVk5VNEJBank0TVQ0NWlzcU9oUC9W?=
 =?utf-8?B?YnVsL3ZqcmhFS3lMQk5wYlFuem5sc2djM2NqcXh6YndRZllacHYxN1IzY0R3?=
 =?utf-8?B?cGQ2ZGdUN2djUTN3dzl4ZzNqajVNNnU3aGZjRjNjeGZ2S1RvMWNPc3NWOFJs?=
 =?utf-8?B?VGhZVWVPUVJVOFdpdmlOdktOVG5VZzhJY1Nub1pBblk2cXBlQWtQYzNRRDJS?=
 =?utf-8?B?aWJuNTRYa2o0dkwyNDgyY0UrbldnUjc0RVIxVkorb3lKWHcrMDQ3d1RzT1Zw?=
 =?utf-8?B?enh1Z1BsaGFVWUxjbExRU0dnWno2VDd5allSSDFub3V6U2U0c0dka1VqQlZ6?=
 =?utf-8?B?VWlqSHluMTJsd25ORXJPTVpveUpVekpqRzFSVHYwcEEzUWZTbHd5T1k4MXdK?=
 =?utf-8?B?R0ZtUU45Mmw1SWVPTU5BSjRLazBnVlkySzMydEJmcHV3VG5KM0gwRCtXR2JV?=
 =?utf-8?B?bGZuc1JYWkFKZW9mc2V2cWIwL2kzTnVTMGlnMzhNV3BibmJMc2pOT2tlOFI0?=
 =?utf-8?B?K2s4d3pHYm1SanA5dmpuQUlqWm5aVjY5NTdWd3VJMjN6TDgzazdsMUtrcHRJ?=
 =?utf-8?B?d0t1MEFOL001UWx5b1hLbzYxVmxGRE1uTXloUzJXUEF5czJidG9zcDFvMGQy?=
 =?utf-8?B?bjZoQlRFTnhrZ2pmMWxTc0l0Um5kWjFRMmtNamxLejNKSFhVa3g0ZWR0UldY?=
 =?utf-8?B?dDlrbDErMjJDSmczNWwzTzF4QUp2M1pvdWsyeDYxTGQvM1FRdWdyWk80WS9Z?=
 =?utf-8?B?T21UL2ZVRTBFQjdEaXpoSFJiWnJUMHk2OENSbU10VENPMjV6eFJidC9PRi9h?=
 =?utf-8?B?VHR4QmcrSzlTN0VKeWlvVTY0SjhGSS83TC9jSDBReDQ4WUlJYkR1OE5JY1E3?=
 =?utf-8?B?cmlTakRYREQ0eVVkZ1BDczZ5WWx0OXJTbU1mMkJjVFNyWXZVVXN2NGFMK0RD?=
 =?utf-8?B?M1A4TThibjZteHJBOUZibUhQOU1CZWtQa0IrZVBkMG1OWU9Yd0NSNlpIblVC?=
 =?utf-8?B?WEtrVlRlWDBWTkl1bjI2Wkh3WXRHbEovYmY4N1R5ZG5kWVQxSC9UQUt4b0ha?=
 =?utf-8?B?cWIrRG1aK0VQZ1VtVkh3ZVR1Qmg0TUpGcXBURTUxSURETTl1R0hIc1hwSkRT?=
 =?utf-8?B?cGlpaTBQUXMyZzRUKzJmRVNOYzZiWUF6bVUyRHFBczRxbExmUGp5ZmZRMnRn?=
 =?utf-8?B?Vk9FdVBRN1RzdnVaS2FMbE93MEZtekNjM1lkK3lZdDlDWUJKTWJXNVBMOHNF?=
 =?utf-8?B?all2OHA4RGJPaFBCcnZXMm1nWERYR3RBdkxtZkx1QVNSdStjMGR1ak5jWkVj?=
 =?utf-8?B?UjI1UlRqajkyUGFvUEN2Y2E5UHNxeVQwRVpUT1hYTjlHa01qeU10WGhvcE92?=
 =?utf-8?B?RUQxL0FmZUVIQlZMWmRUYWN2ODExdXdXYW9TcTFzS0FyWTRDeGxFbTlmUlhh?=
 =?utf-8?B?SVNVamxjZVgwd3JZMmxvNFI3ZnFydzVnbTJFbjBCZThCbVByRXNCNFhsSFN4?=
 =?utf-8?B?STVSOVFGR0tsRXIrWGpEVm9ZaTFYUDVjb1N4cHIrdUU2QllkS2JXek45UlFN?=
 =?utf-8?B?VFdrMHh0SmFpRHU2VFNQMkNlSDJqN1VBbmsrbU01cEdnbEw2K0pJMHczZktp?=
 =?utf-8?Q?ATvs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:24:52.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd6821f-cfc7-4eec-6d7e-08de4f71b573
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457

Hello Namhyung,

On 03-01-2026 03:58, Namhyung Kim wrote:
> On Tue, Sep 09, 2025 at 11:42:21AM +0000, Swapnil Sapkal wrote:
>> /proc/schedstat file output is standardized with version number.
>> Add support to record and raw dump v16 version layout.
> 
> It'd be great if you could write a brief description what's changed in
> v16 (and v17 in the next commit).
> 

Sure, I will add the description for the same.

> Thanks,
> Namhyung
> 

--
Thanks and Regards,
Swapnil


