Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012019.outbound.protection.outlook.com [40.93.195.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC13624A4;
	Mon, 19 Jan 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827625; cv=fail; b=mMhNHpQEc/XkBP/NfmoTg0u0SB+hHkihiww2crQD47NkjOpRtEWB3hcKLViECbUpIjv41hIC7KFvXHj28wrU8HBF3eyc9Ld9JRyj+S2nseXQl9ZrtovOyaujfbzlAnHA/vivKi/+rbTSvV/XxACk0MLNBB0VttdrtmBGTdi3y1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827625; c=relaxed/simple;
	bh=tHFZHSMijxGvWk/g6rhVPGIVCPKZe+cIMwhQsJaEt0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S8yGqBhNhZ32pH7FiSkhcYacg7BoEnyjD1kcc1DohtdmDfim6x42s3ByeVeQd5jebUSDWglrcQPhoF4sIBkCu+VGqdoeHDvXt5Z6U8Gi0qotxr6Vwo9DW3pu+k7ghr+JcvRqx9g8M2z7XJmFMCoYP4uj5i0ZYx4OIYOIezMeVRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dq4b8ee3; arc=fail smtp.client-ip=40.93.195.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dq4b8ee3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS9MHPVbtwvxxv0MtgjVLpT1Uckq+F4ef4ysjhlf8sg5faejLW5XL7CKknNfvfSoM+1tYNMDmSLNecj74i0tZ8Vvv8k75zbKDgnP032bAPJ8cWN7zDJLxTDrsaKbVQTSFkZMHczZKqyru0mmpKVZrUjRFUTTVbU++ef+3ZDZClW0M1Dlqe/FoNGJscfjnUux0uNSXaOt3fpHsiKUaSw5y8KiikZwJfi39RNzHUwUmDraTp6LefQQyNJLr6G6+b+DCkjEjJkvdRNQ2+6HjhdJa4rUqYZpgRgOCT0GVArjXwXcXZV3xMLpA0CyVeCq0Aqeep9d68CT1hFYbetxy2/dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trEh8tvIhO/7vDYPdTaJK6pn7zmsK8Sj4FfCV/65Q2k=;
 b=vzIaBspg0RI9Yvufi3UpaTreaZySukjQQhRSRlisyY2UUz7VxTUNcOxujZ3rVmTyYmz7J3rOuja+/E2R3/B5MSlmLCzzuV4mxURF7JqkfKhR33c2QgjDlLZbgU3y4yNMoSBxmmDsL8n4S3leYTh2Us5WWb/lf1FzL/7f6TfHqAgllEut9GVDjQOL0io7u8B7rNTwGzVLmDMkC87/WiPvVOPu9Jbal6ZdzLe1siZWZ79MbWWNKaHlvKziy7LjY1JJTekVScsGqrpOlmjz5lYOJNo0kOufjC6wqCe4XMYeRySV3dSWfND7OB3UpHvUXPF+3v7uZbMuFudNeeGDiGbumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trEh8tvIhO/7vDYPdTaJK6pn7zmsK8Sj4FfCV/65Q2k=;
 b=Dq4b8ee3Z23fE/8Zn7oXB0wzKSLTAG/ssBQlC/NdriFbUPdgr16MkWOCm9AJLtdY+z2Ifz5IySIse1I6GPZVz0+7bxMDPVdvyKKM9y53b7dEZHvEqVrUZKBgQmRyoqCQtfaFVunu33BRML/iAP/PrxAl7IBn0x3kh5IrWxkjQWQ=
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 13:00:19 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::fb) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 13:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 13:00:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 19 Jan
 2026 07:00:18 -0600
Received: from [172.31.177.127] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 19 Jan 2026 07:00:13 -0600
Message-ID: <7a012575-bf92-4614-80e7-6bbe593f57cd@amd.com>
Date: Mon, 19 Jan 2026 18:30:12 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to
 eliminate RMW race
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-8-ravi.bangoria@amd.com>
 <82e836e7-c0cc-4226-91cf-4b2275d99e73@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <82e836e7-c0cc-4226-91cf-4b2275d99e73@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 227b6924-86d8-4679-a62a-08de575ab273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OSttT2lEMWRsSmpmNUlPbXNxQVNBOUs5TWM1cnU2eU4wSGpML1g3Q1lrVmJ1?=
 =?utf-8?B?S2NkNWY0Qm44RU9kdk1kZFo5d21pUnJqOEdhTTVoTG1LZFg5NEhFbUJwR0xp?=
 =?utf-8?B?Y3FHYVFIblZ3THh6UzhNRzdIa1BnbVJ1bFlObVJHbXJFWGszZ0prcWlTZjBz?=
 =?utf-8?B?VEVndVh5ODFLT0tCcDdZZUVHV0kyeTRwTFprRlhXZXFYc2RndVQwVEJQWG5u?=
 =?utf-8?B?K3J0YzlZTS93Z1k4VUQ1dWlKNWp1S0pWSUZvRXh2aDNodlBWcWZRWU43RWsy?=
 =?utf-8?B?WmZVUVg3dk5HSXVIZmhucWt2KzJaWVNNRzY4cW5qSlNva1dzMmlOQW1ORGcv?=
 =?utf-8?B?eUNzRERMM250VmRyYVBoRFBjRE0wRWorMHlEUi9wSDRXaHFpekFBaTN4cTYy?=
 =?utf-8?B?eU9NSHFxRUlnOEFtdEtITm1KdEg3dGVPWDdjVUNiVnROcnVJQmJ5cUlIY2tw?=
 =?utf-8?B?S0loNmYxSUwzWnVzNUo4UEFsZHBueklUVi9CSkNNSkdrYjY5SWZraGtuYjVu?=
 =?utf-8?B?RU1oaTVDclREUUt5YVJXY2ljTHhxWGJWTytDU2VITlM5MVhTM3lqc3V6ZFpn?=
 =?utf-8?B?RkZSbGRyT2lIalUrVnNQdElEczhjODNZSHRqVG1DZkREZCtDanRkbDRTV1Vx?=
 =?utf-8?B?cSs1SlU3UU9iUVJNUVl1d29TN0xnUEIwMW9WcldwelFPT0pTTUhicll0Nm53?=
 =?utf-8?B?UEFKQ3JIa2xuSjNVMTEyVlJ5YkZic1RtcEZZQUdVbUYzckhNazVsWWlqN2JZ?=
 =?utf-8?B?YzJmYWFhbUxWU1drY2MvSlZkYjBFbU1GemlpU2dpZ3VZb2JNV0JLVFpoeGlk?=
 =?utf-8?B?bng5VGcrR3FDTUk2NjVxeU0rSWl2amNCdHA2YjFjM0o5MDdpUFpBK3Q3a3NF?=
 =?utf-8?B?WWxabFg2Y2hCMEVRYWN6c0ZHZ3M3UUEvZnRKT1NNbHBQSzZzV2pqa2dHZWFF?=
 =?utf-8?B?S01CMFdjc2ZlMUNVT0NZc1NURC9EdWRJaTFRZWhaUFkvSTFBVm1KSnlGR3V5?=
 =?utf-8?B?MVN5b3pLamZvQzdSNlkzN2VORStpUWg4KzZMKzcxcUlnSGtzUDJXRVlOUktP?=
 =?utf-8?B?ZGpmSVhZMTA1ZFpPSHdBd2ovZ2I1Y2hscTR3MlZFSzlidTFtTm5wUi9xNDlF?=
 =?utf-8?B?UnBNbkJMbklpbnlQenFoMTAyVUhmb0Z5dVI3ZTNIb3JSbGx3UHJLNW1YR05o?=
 =?utf-8?B?MFdWbjF2bHUyOE9vMlkremtDam56K0FQbXY4SWVoaktMZWZ6Tmc1VmNqa2VP?=
 =?utf-8?B?aTRReForaTRZM1JhNG53clEwNGd1N0NHK2NzVzkzb2VNc01JSFVTallVRkZ1?=
 =?utf-8?B?REdXd095ZkVlK3A1aGtHMW5IMndFOFJBOUpRYWRtVXpjLzAwQW5Pa2oxMzRC?=
 =?utf-8?B?NVJ6UXBUMS8yK0FUZCt2RVJTcG1QSjJ5RWY4RnNobjZmdUgvUG5Fc2xoZFZm?=
 =?utf-8?B?M3R5M2pVblUzTEc4QnNsVVZ5Uzl3NmpBR08rcG04c0lIbXRsUlV4bHg1cGtB?=
 =?utf-8?B?NWMyRW4zbzFUd2QxcGtPa0FFMU9nOXUzQTcxUllraS84cit4Yms5K2lBV05R?=
 =?utf-8?B?RUs3TzZqS25QQ2FUOGp1Y2YwNTB4VkhRSW1UdExuOCtvdlBYZWg3cmRCTk9t?=
 =?utf-8?B?UTJ1TytsaW5lQm04YkViSkE5U2d1TnNZTkVNQWJKYk9hYWJoTWtCbWpwd003?=
 =?utf-8?B?RG4yYU45WEszaWUvcDN1VFJQTEJhVk84cGUxYi80N3NaRGpTaEhxalJZUk10?=
 =?utf-8?B?TjRtY1g3cHBUUjVxa1hYNlBDN1RkQ2h2SDZqRDNNakRXQnFaOFhQTlREMGZz?=
 =?utf-8?B?SHZHUVNKdTNiYVFWcmlBMG52elNEcW5aZzlMUzFUK3F0UjNqQUVNWk9WY1dq?=
 =?utf-8?B?alpCdnQrblQxTjVrSXd5NHgwSC85STgxOWp5RnhlelBsRjBGRHh6ZGg4bEds?=
 =?utf-8?B?eDRmblVuUVpuNTRtSDJsVXlvQnlBbzBXSGdDcmRCQTdQRjJaUDNnbGh0VDM2?=
 =?utf-8?B?clJjbUtFZnhIaGtiNk9EWHRXUlN1RXRkWFJ1eUJ0UFBGTE9RWUxGa091VUtZ?=
 =?utf-8?B?RzgvZ0JBUGVyM2Q1VjdRdWVjWFI3UmJpU01ESmNLcTNFYllISDNWcEFkS002?=
 =?utf-8?B?a2R1eFhmRDFQZjBKT3RoL0dOWFIzUkhLNm0zbkxZYTVZOTQwUmV4WUQzNDlx?=
 =?utf-8?B?b1J4STZCZUEyTU9McXRpMkZJWDMySHdHOXV0QUFhMzdRU3BuSkpUVWJsc05i?=
 =?utf-8?B?dDUzVDVFamJaZTNOdU8wTzJCV1ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 13:00:18.5430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227b6924-86d8-4679-a62a-08de575ab273
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450

Hi Dapeng,

>>  static int x86_pmu_amd_ibs_starting_cpu(unsigned int cpu)
>>  {
>>  	setup_APIC_ibs();
>> +
>> +	if (ibs_caps & IBS_CAPS_DIS) {
>> +		/*
>> +		 * IBS enable sequence:
>> +		 *   CTL[En] = 1;
>> +		 *   CTL2[Dis] = 0;
>> +		 *
>> +		 * IBS disable sequence:
>> +		 *   CTL2[Dis] = 1;
>> +		 *
>> +		 * Set CTL2[Dis] when CPU comes up. This is needed to make
>> +		 * enable sequence effective.
>> +		 */
>> +		wrmsrq(MSR_AMD64_IBSFETCHCTL2, 1);
>> +		wrmsrq(MSR_AMD64_IBSOPCTL2, 1);
> 
> What does the BIT 0 of these 2 MSRs mean? Disable? Better define a macro
> instead of using the magic number "1". 

Right, those are disable bits. I'll replace those magic numbers with
IBS_FETCH_2_DIS and IBS_OP_2_DIS.

Thanks,
Ravi
