Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB3279DC9;
	Thu, 21 May 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331956; cv=fail; b=BRL46IC08WoQ19tzTT4WlhePpt2NDiNQ5tbUF0kwLjmrSAlJVjYFuOM5I2HTuZGmWWicVdfmiKVAb+USQ2fvilCtopcZCk7p8ne2xkWsBE9LhH/iZ6VEiNBSxG2nO5RMOHAf4sjHgzIZLBe6eArDoMHZtyubEzmTbWtZ5UVndCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331956; c=relaxed/simple;
	bh=2Josya71q9KTuKi6k+YtaaIHkBqf85GCAU2jJyUuXbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fxdFvT+haKZw0h/VtaBjIfrlrO33UbGB6VicFFIznACaOXNAmE73hQBs1RY+8WDMoxwCYIdgr1foTjpq5kmbVJvq/lWGCGGg6IiCdEFY3rL4fkkj8fEVjHNtRvzrxP1Rm4unkT6jiLGWU4N3DVvYbb6mG1aU7IYk6azYyDsz86s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WvL7lppz; arc=fail smtp.client-ip=40.107.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WvL7lppz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQqTkm5q+z2L7Iqf0BK8Pcx23V5TMbKbU4b7XbB7lrZO1sI6FL1DM1pTBQTGjbLEmef8PTlHhP4P/0JC3Cm4DfZhTB6dctFZmYmXObOck5v/rKuX8pKc/J2XO+RXdPbNppyxhQueZzfFw800etYdx6wqB0JXWNXwn+zYAeRXfk8a8O29H/YAwgHKuX4T6Ir+3MQ9w/6xvctxHAmAjguXYIeQHFwvMGSEJZ/Urn1hjzwUsUek/lS8z+O//ymLXfbWfIEuChgjnhSfLedntQX6YfaH5ALXpjzfbe2HD4VknDVAXSV9G0KBH3CPGl8xc9lXklAXDUJ5eJXgxx4QMSmp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQB2u4teT8q2sUP6DvDt4HzDDmg5axmmdIAc1jkre3s=;
 b=QZr/WH2XncFyOoAlEKX/etN0Ay6Gu7hA/LUILxObcDyOJfe/FI425pCviXLDHwtCZjfS6EUAysF6VXyMPB/kfKRjNVrPZkON4NFk4G5M7H6RIdl5YP4ZOK1Nhre7cQi+Xs0VkSwBpdSOG86LQtDPLz2OLMJWHTriNshZrsczgn3D4PcRZh+27WFHJCBJowu46VQ5AqClr2nfch8qWByrQyepTZ7XNkAvxHSIorm3+wBDq5oXZigxnIuZpVmwmDkjFdTnFBmBD/RO8kM2UnWfHU3agWs477qTbVSNJhKEq14mINXcjS5q+uepPt9eV353tjNz7HF2mG/rel2nmViqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQB2u4teT8q2sUP6DvDt4HzDDmg5axmmdIAc1jkre3s=;
 b=WvL7lppzT+PzJ3JbkSWdhJTW+XoX2fTWeDDjBWzFLF/zNjGk57QcYBKZfcjXaSKYg9mWBx9ut/dY53TlMlXca0F+D6OgG+OkOTWVIwhgGFw8DjIutjeL9Y4DgVZ6x+YQwpKevBRFvm1LwdQEWuYRvztOfwPsx4E7Zf6w5HIuI9c=
Received: from PH0PR07CA0085.namprd07.prod.outlook.com (2603:10b6:510:f::30)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 02:52:28 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::ab) by PH0PR07CA0085.outlook.office365.com
 (2603:10b6:510:f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 02:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 02:52:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 21:52:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 21:52:27 -0500
Received: from [10.85.42.212] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 21:52:23 -0500
Message-ID: <299d7023-fbb1-4e17-8931-5bd73ffd947a@amd.com>
Date: Thu, 21 May 2026 08:22:23 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] perf tools amd ibs: Fixes + Zen6 enhancements
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James
 Clark <james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
 <agAok_vgqBrZzMhA@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <agAok_vgqBrZzMhA@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: ravi.bangoria@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: c62ae23e-a225-47b9-d212-08deb6e3fed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|3023799007|11063799006|6133799003|4143699003|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	gP8BlbXlnP1u3e+doPOYv+z2PaY99NXdsXFggzVdwOVp6Z7HCgSt1rDqspqkIprFAVNkVWgS1Et3+esurZT9ZYq3y27qMzL3EMneNVLYTyvE+xB1B7CLYMhCrhn1cAn3mQ5Yqkmfkg9V5Cudg7doSkKVY8jJE/PpoMq5pVU90FJyyRtSR1ITS6zVDkK0cWEjVlBepquuDnkihJnbbM45jaJDD+9cgImoCDAi6ePMeyNBA0+JZWm58lUeXiw6XBJBcWCFPF600eXdgv8Es436nPytbvo1pfue+98DWcIbrs5IpogsvJgJFxPTJCnWdePA6C52k8CFpwMiXnqrPmro0vI2xR3678VB/mmoyUkSVYHXdqwS84be7m2kgNmozP8UTJ2DxhH7VCWxJNLC/0nUP/NIStI706f+DImPwidME1rM+2w3jXJGgE9Wh+tcEx/aTyqSw8+LgnGngUj9xoJr0oCXzTlUU0TcKHCbNfrfCl/mXj3EllbdDoqoaBBFhjVsDT0SfDbjRRC50L5Yfd1wS2TxeyQlJr5DDiqE3C4zHwHLvwsrM6PvZ21L9FgjlFUCy0iRbm5/WbgsVfFesQCnXJsb0nIe9oA2OAHuYdkfWEUmzsORnBtuKixxTqcW3COp4qn0bKfGcBn9H2b1Hp5yW7UVVnIJn8IFKn5Dti03HE4Kwa7jPEDK8Msph03RODbY4oKbJ+ylJYbHs4AlUlcn1bLcXOO5n0D9S/DWkqOq9ig=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(3023799007)(11063799006)(6133799003)(4143699003)(56012099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YDtHwi/d/6hiLnj2ECmS0L6LXnvkRAoSQWXFjzTRUcFk5nABA1vVRMfk0xCbgg3QOyCCbDmVen656+yOi4/K42qWt9lVwbO931ZYn0D0rMTw4IO/nWcd10hqlNjf52S2pdm5cKxBn8vI1+77c51HbkXQpjnmczX8d3350CIi24wlLGZyb3+mDJV4FxAOZDlSHzVsU3wid+AvV/VISrxyRWfdPkJdGtGtnvHi1YE5y6iPHJnhIuDhe9WIH1Jmni3NM32467QyfAUjQ9puGrXUuuGmHQGLV3dVX9d60RIyn2Z76Wamn3IQWgEfVhKADpPeAtSUQasQnoyVpb2gxK87HyWULx0Rc2LEZP4h68mK47DoUsNR6DKasXZ7z8E//dBl9JnxMroMNpFrggyH3vQRrffERm+oL9Jk1QijR8WSzskYbf7KlFLV/zld/J3NiRBN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 02:52:28.1372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ae23e-a225-47b9-d212-08deb6e3fed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

>> o Fix kernel version check in perf IBS unit test.
>> o On Zen6 and newer platforms, skip perf unit test that assumes IBS don't
>>   have hardware-assisted privilege filter.
>> o Starting with Zen4, the validity of several IBS fields changes. Add
>>   the required dependency checks when decoding IBS MSRs.
>> o Zen6 and future platforms extends IBS OP with Streaming-Store and
>>   Remote-Socket indicators for load/store instructions. Add decoding
>>   support for these new bits.
>> o Document new IBS features in perf-amd-ibs man page 
>>
>> IBS Zen6 enhancements doc:
>>   AMD64 Zen6 Instruction Based Sampling (IBS) Extensions and Features,
>>   Pub. 69205 Rev. 1.00 March 2026 
>>   https://bugzilla.kernel.org/attachment.cgi?id=310002
>>
>> Patches are prepared on perf-tools-next/perf-tools-next (53bc03289278).
>>
>> v2: https://lore.kernel.org/r/20260430061115.10266-1-ravi.bangoria@amd.com  
>> v2->v3:
>>  - Instead of removing the priv modifier unit test completely, skip
>>    it on platforms that supports hardware privilege filtering. (Namhyung)
>>  - Rebased the series on latest perf-tools-next/perf-tools-next.
>>
>> Ravi Bangoria (8):
>>   perf test amd ibs: Fix incorrect kernel version check
>>   perf tool ibs: Sync AMD IBS header file
>>   perf test ibs: Skip privilege test on Zen6 and newer platforms
>>   perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
>>   perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for
>>     newer platforms
>>   perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
>>   perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
>>   perf doc: Document new IBS capabilities in man page
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks Namhyung.

Arnaldo, mind picking this up?

Thanks,
Ravi
