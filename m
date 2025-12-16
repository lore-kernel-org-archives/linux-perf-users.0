Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5352D8760;
	Tue, 16 Dec 2025 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765860181; cv=fail; b=mgn76ULTfxgWp9PHHKonDYAS3VuDMzrvoPOM72VrWnHps0h/YT3KVPtpKC9OtYXyBlG1Lg5Mfpg3YkTahcU71tfuKHF+d1wHFAB26zve/Q5tw/ag+VGKAa0QyfqSMoYiajW3qvBQVsgE3rWOtm8KWht6ZMQktJ7SE80I3WTeHAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765860181; c=relaxed/simple;
	bh=uyOtXPnHB2WShmCUtg1WEFkRQljLlHxpmurs0XOa4NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WpPPT3mHlV2Heh0C7ZpreZk3ff93jydG7lcsU3uTicssZnfI4vdSdBC/vxrR4M1JgdY8A6BkAJI/s0qYjBsw0H4ODlQUxP6VgIu3guI6gIn865vifoKFqQhXh+6ZDoHhmzj/TV+/m0ZW7VshSIE7uc4lZMHqa7D23klPkniA+gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ydd4xd9M; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ydd4xd9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nwz/kLwD6bs6FtDAanyWAlYmx8pXWe3oIP3d/h9bcH9qnekyCZAnk4A50ypFDauozrVQbTF4j62Rqe9QvGV/7rLMmdW0b/W544h+qApfqp1hjIn+cxe6Ur8bV/FEYCDu9KKEzzd3ExT7CQgTAQg2I8qjfG8hHJhBKhFan15KiRik9KSTbWoTmLoGaIoXVS7G5A+FxRZrXrEacXecQPfz7BYyxU5l6VWiYu77qcFf+JPY8zMyCa4IOPdRpXzvAoPnSqFPf9Jb/3Pe3iDpS6b1UoCocjdzIvIoHqPKM66IPCJYFlgs+jIsp+KllSxBc9SvORbwggOFxZozHLtQug9LAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=845xRJp428sw2zeVBrqZERCFyMG0xR85WqgC8hY2ng0=;
 b=OqsRDx+OCsYHCk7zXnE1pY2ENC/qEcubkMyJaTtk6qzFE0dRIrh6fcJaklYWMaUUc8GIXw+NabqiOjuELodG/pqFiVKVoANxnXtscw8Ux+wj4ysg1znui391P+o1NPNGUIEGcivgXm/BWcibbJ17Ut9DCcII+d37TQZ8yek9WajKPomVTdSI8nswhO34BhlZmUyMUwPRd+99cun0HDULBQ0bNUZN2kII/DMAafLvSYoMiAolEWoDtbVPTWYOOeh5hpYHHElnUDajmzMAWMtMziuYux401wNrkzd8qciODjKK0uxqi2zRZ2t7Mt31Lq6Uunm+RrgsKax4C9tmR1zZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=845xRJp428sw2zeVBrqZERCFyMG0xR85WqgC8hY2ng0=;
 b=ydd4xd9MOlVuqqOL/jzMbGdFtpBazrvgxI0HCLl1CP0/Ix8Tlor2uemP88Q2igxsf8iwBAFXA4CdaU56KSJXmfS4gzisVWfDnEVYxgiNUNF1f/6mpNzTRYmS8MNPVGRr+jkWi8aM3y6NbbbhHmZQmlQ1XlJ5XX9maPO9gZEc+yg=
Received: from BL1PR13CA0400.namprd13.prod.outlook.com (2603:10b6:208:2c2::15)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 04:42:45 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::9e) by BL1PR13CA0400.outlook.office365.com
 (2603:10b6:208:2c2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 04:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 04:42:44 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 22:42:41 -0600
Received: from [10.136.36.160] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Dec 2025 22:42:36 -0600
Message-ID: <c2892e7a-65c4-4744-a611-6fc3c1d37cd3@amd.com>
Date: Tue, 16 Dec 2025 10:12:35 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 00/19] Support SIMD/eGPRs/SSP registers sampling for
 perf
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Zide Chen <zide.chen@intel.com>, "Falcon
 Thomas" <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, "Xudong
 Hao" <xudong.hao@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: a7914af6-8a51-4ded-12b4-08de3c5d8e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpkNDhaTzhuL3I5Y2FqTTZIR0RMYTA5N3FLSm1Sa0hHMnVtTGhXZVlST0Nl?=
 =?utf-8?B?ODdYS1hTYSt4eWZTM0o1bXE1enhURm1oS1hKUjFzZ0hZbWR4QldhdVNkakVm?=
 =?utf-8?B?VVp2bkpzNGJZanBGZjRod2hTRnZQbUdBS1dVQkhDbXpOd0hTQTRQRHg3VFFx?=
 =?utf-8?B?NTUrZ1FIcEg0OTR3NHpFRGY0dVNzWERrakpRUElkSjlMUnBad1htRmd1U2ln?=
 =?utf-8?B?cEtFRk1tQ2JWRmFBMUtFOHVTSGlvZGNOUmRBYnpkRFdtR0M4MnBnRVM5cXFv?=
 =?utf-8?B?RFk0cnF0SzMvb2VZQWNnYnAvVzZPMDl3UC9DMmpZbGc0OU8xcWJKc0I1MXVL?=
 =?utf-8?B?LzdBUVlyTVM2WVM0c2RhZ21OZVE0cmRIUThhVEljWS9mZXZSNXRrR3IrSjNl?=
 =?utf-8?B?TVRYdzZXWDNNNFExOTl3SW5ma2ovUEhNdWJzUjRYeWpXUTU5d3dTVXBWVzlZ?=
 =?utf-8?B?VHRMSXBNZ3pPRUdVUmxObmxNbng4K0NpdGtQT0twdXBZY3RKM2VIamRVeEQ5?=
 =?utf-8?B?SEZiWHZzQ2RYZHZ1T3dXM2YvaVBKUmFSQXF6bGF6TXRMUU5JUCtsRVJHMml1?=
 =?utf-8?B?ekpOYWFCWmNCVHpINDZML0pUZGk0QUlCZnkyMTQ4NjhpNnpHblJtYUxSaWNS?=
 =?utf-8?B?OWova1dRNlg3a0ZvRlZkRHpsOUIwTGFCVmlUTWgyamhaWkV3cUdiQWN6M0or?=
 =?utf-8?B?ZmVqdUV3Q0NMbjNkK1RPSWtrWW1KK1h4SGEvN3JPWCs4YSsxTy9lamRCV0Zy?=
 =?utf-8?B?Yk5xdUhaWVc3V2xKeUdLdmtSTFZIYUozQ0pvN1Z1bU9iR1UxVDNVaUJKZi9m?=
 =?utf-8?B?K2t2SjZYMlBQbHZrOGorVVI2dEZkcEo5ZC9TMUxUdTVwbW94MHRKRTRNRGRq?=
 =?utf-8?B?bEZ5Ni9hRGFzNWJqNTNOTTlqYXY4M3lFZzgvWWxJUnJTcmtSMVhDb204WGlP?=
 =?utf-8?B?TTdIeWpqMWwzRk5DZXRzVjBPUkZpYTlGQTBZOWFDT2liQ3lHMkc4VnJCSEsv?=
 =?utf-8?B?L0wvamFCMmU0alVHM0FWTjBrK3dSYkNqamI0Q1BMWnFadnMvQzd6Skd4akxR?=
 =?utf-8?B?WDlJZUJzcUFRUzFKOHdLNTAxRVordVZrckVwVmloVjJBM29ydlFxUERnaGNw?=
 =?utf-8?B?M25NcGk1bm1EOUllcE91azZaYUpiRzFaeVROaXk3TURpaVc0SjhiOUZCbVM2?=
 =?utf-8?B?ZVk2Vm1aSGJMM1hxWEdtN0RDY0FxTjE4YUtMSm51aythdkxIRWhtNXFnNyts?=
 =?utf-8?B?TGpWWTIzK3p5dzFPdHUzc1cvVHZQNWRnbGVrZWRHSGZvUVNpUE1rMUlTbW1J?=
 =?utf-8?B?TWtGNVRMYXZRd3h0Q2JuUlNGSXc4Y1NkdGpFTGJrU3VnYlh0WUZKL3NxamdE?=
 =?utf-8?B?LzF0L0svcnhseGJGUzdhOWxreDNxWEVMWkNjUS9xU2tlY2lENkUwbDFqcGFp?=
 =?utf-8?B?K0g1S2I4ZXNETnJWb2ZKK1RlQVFia2VwWnk0WjlkNUJqSDdTZUR3NTJDNzZs?=
 =?utf-8?B?cURkVkg3Z2RQUjU1Y2QzSU9EN1F0elE3WlN2U0xwVllCQzFXNGdCdU1hblhV?=
 =?utf-8?B?Y3FCT3JJSi9sN2puODVxOWtMOHBYRHlqeHg1R2RiNEhtYnFBQUxnalA0UWRF?=
 =?utf-8?B?S3p2Qmx3UHBiQ3I3THFRYWFiWjUrOXpieXRyY0lsUVcvZ0xLU0M5UnFwaFVh?=
 =?utf-8?B?dUlQMU9Wd3VGY1ErZmNXd09Gb05vOU9TRTlaY1NheE9GRVRnZExGcG9FeklY?=
 =?utf-8?B?Y0F6UnJpVEo1WW1pWk1TUTVrVFNRUmJSWGFzR1BqZnp5dktpS2hiZ25EUWZ4?=
 =?utf-8?B?MVRPa2RhZ2Q1cktMVWVxaVhPMGNxbXp0S3Vhbys1U1Y3R2lkQm5sZ1UrNnVY?=
 =?utf-8?B?aWhRTURsNHpvblJ6anEzczB4aUtXMnNudFJIZGlkTVFJREpFeHJCKzYxWGhH?=
 =?utf-8?B?VlAweEpBVWdxeE9Id3pxVS9rNTRlaXZWWUM5bE15VS96WThpbW9Pa3RoanlF?=
 =?utf-8?B?RVFUMjZpNFJ4eGc3c1NqU3J5YTJ6S0RqWDdWTnlnUzFvUVBvVE5mMDM2Zkxz?=
 =?utf-8?B?TEgybEdmd3U2U3g1cVdwMTJYV1dOYkFZdVpyWXNEUzBhaENSRzNlZ3ZUckha?=
 =?utf-8?Q?v4f4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 04:42:44.5472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7914af6-8a51-4ded-12b4-08de3c5d8e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

Hi Dapeng,

> While the hardware solution remains preferable due to its lower
> overhead and higher accuracy, this software approach provides a
> viable alternative.

Lower accuracy in the software approach is due to the delay in an NMI
delivery which will make the SIMD data misaligned a bit? Something like:

   insn1
   insn2  -> Overflow. RIP, GPRs captured by PEBS and NMI triggered
   insn3
   insn4
   insn5  -> NMI delivered here, so SIMD regs are captured here?
   insn6

Am I interpreting it correctly?

Thanks,
Ravi
