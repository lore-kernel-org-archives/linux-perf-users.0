Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649718AFC;
	Mon, 25 Nov 2024 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537900; cv=fail; b=GkF4H78c5h+mrja0cdH7iMGkaDpJ282EH9ORtF+c3Llvdv4csQnX6bYf8MrruL8AEXPY80sZ4eHMqj+52oox2L9xUCE/Sm2vzqOu3+uVOOCOYlGlYA+oLEB5SkkQm9z5Kn0STrvE+TZgmeFzmFJ6SGRXImi5LGTLSWznjaK4pHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537900; c=relaxed/simple;
	bh=vaERtrqabOoTBGB1yS2QbYNHk7T3fGjf3BgAUjjLGKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nzy8CyUNZnAlE9AIdJ9P80yUcK1pndcWwl30R7AhRZ3CguOtZr+SottCjv5dBRlC9KtNwRUTcceR9CGsMci/wy8CGVcBCH/K9xQZYb3MBuK3bKSu+vObhxkABnaMfJIDfHAYsU+VmKiZgpGtVi4opxxZsVPyUu/hrRHBNCXNxKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KbckWqLb; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KbckWqLb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQz0VmaMZcvtrqRwO7ThqkPRCT5ZioM6k2teeax6M351J/hIrFooS3p9LaWicX2cyhTaK5P5UJ8IKM8oQ9qvQMD91K5I3jx1OzWwdVE6EWWnYUkqAG7YQrYM1GHX0aQ3eu6Ptkt3BzQTonvMSdagqv34DNCUYHB+WPNC/c0BiPxb07zMnClfomczTyXTblFZX9CeUzUUB7mkzJVd7dIO8Y/yRgad8iSUgEzkPwb1gGjVFG9xyCWCriNt4y+8/lE7q/lDTYB/B2wSxKCvnHVd+zaI7DIOC9v0kajRbonGwd520cYJFpAPTcMPolQtk5YlBLpBLyyTdiSnG9hQrVlRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkTmQCwsv5qmM5uSmmdiI2Npsfw0O0objpordVIM9Nk=;
 b=IHq0LwppqHyW1s/ZQm4VP2PvVuBIPl5RKNe1s/quloAax+JuCAy3/sqYsuHnHaPr32XCCT7s+izTj5Je1HqW3uloXMiUqC37VsU3yFNEs94tF6onUYthOAib9531qOIC2r34Ekg0l1k3klOkQZ3/Pz6MeUE9GzPdm9XkNrRob/c/cy5tYZEqevBoTUMtL3H2SS/mmJxW8AeAYAIr912L4WugHExXQ1PRIthZa6seLYnZD281ObGtbHo4qzU/U0wdyVfjfUPLBM4bKhwZwW2GVMULrp9iWLlqqc/xXNs+XapT+yiNz2l2agBPYTh5z9vo/xxEHwVfWEeNL+I3JW+Upw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkTmQCwsv5qmM5uSmmdiI2Npsfw0O0objpordVIM9Nk=;
 b=KbckWqLbAjqBAZ/l2R03LWVkc4Lo7crHRD9KpITUprbW8Tv4LAKwEcXEHNUOxubVmdjAGxvCqSHzZ7r4B14xzTTwnyoA5xTtJHz9RrnLr6d/HsQeQPyH2HTOpbwQQ1FSdObBg7xVwN+1RjZk/NX6AU338C6uwfUrVIRguvTVXhQ=
Received: from PH7P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::35)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 25 Nov
 2024 12:31:31 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::90) by PH7P221CA0030.outlook.office365.com
 (2603:10b6:510:32a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Mon,
 25 Nov 2024 12:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Mon, 25 Nov 2024 12:31:29 +0000
Received: from [172.31.152.206] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 06:31:19 -0600
Message-ID: <fcefeb4d-3acb-462d-9c9b-3df8d927e522@amd.com>
Date: Mon, 25 Nov 2024 18:01:16 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] sched/stats: Print domain name in /proc/schedstat
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<vineethr@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, James Clark
	<james.clark@linaro.org>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
 <20241122084452.1064968-2-swapnil.sapkal@amd.com>
 <20241122111253.GR24774@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20241122111253.GR24774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f283a2-45c0-48e8-c99b-08dd0d4d1676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBOL3NWa1FoY3RlZnhldlNVMWxQbHNlN0RHQWw5NFdSU1BnWUlYNE1OczRL?=
 =?utf-8?B?Z3BDbjJ1dGtFVFhkNzFCYkxDQTQwWnhkRDBnWHVNcmFScEViRXFGMVJOYTJM?=
 =?utf-8?B?bFVWNWZhcTc4c2t0RXkvWTZlclhMQWtFSHJIalBCRXlCaTdFaGxYamUxSWx0?=
 =?utf-8?B?d3lKSC9pUVlMcU04R0JwTmJ0cmJMLzQzRGZEbmRvNEs2U0tVZm9zRHVjejNP?=
 =?utf-8?B?N3Vveng4QkhFbElpSk5BR0UxMWdRZnZmeHVjR2hhdmJHd0I5M1JocXI2S1BT?=
 =?utf-8?B?UmF6ZFVtLytndVVmYU91eFZaY2hmNjJKd2ZsTER1K3NDVkFLR3VzQlJiM3Vn?=
 =?utf-8?B?TXB1cDY0S3pReDZHTEFUZU8vRWNBQjJnL0N6TzQrV09UcGNQeXkzTHBIZ2lB?=
 =?utf-8?B?VEN4dk1wWU9tZzM0YXowMFJDck8zb0MrTnZHOGFsNWs3cmw1T2RWRHZ0OTIv?=
 =?utf-8?B?c2d5Tzk5Mi83Z1kwamV1eGdsQmFCWlVUTEVFcC9EWEZiNy8vMzhtOEVaYkIr?=
 =?utf-8?B?NE0vZjY1aEZ3Q05FT1lxMlBDZkcxTGNWY2JKS1FqOFdGQU92Vm5FYWdaLytk?=
 =?utf-8?B?WnBJcmtRY0pOYXJ0YUNNUUVhRmdySGJySVIwSEJ4ZFlEM0lWSSs1VWNuVGZH?=
 =?utf-8?B?bGVWUGxtdmhFa2V2NkUzMFZVTGtsVDNEZFc2UVNKVVVING13MzdvNnREZVJi?=
 =?utf-8?B?cmNrTFdKdXlzNVFDK3Q0MndDdjB4M2xrWkV6dldYMUc5WmhWNUt6dGdJTkt5?=
 =?utf-8?B?c1lIWlhVMHVETm1DdEc4c1ZKTHVoY2o4U3FLL1ExVHl0NU9wVVhmMGh3Y0E0?=
 =?utf-8?B?L3RnaHJoK0RoOVJMb0c3ZW9GZEtGNlJybnVEaHlwYW12N2ZrS3BNSHhpeWlR?=
 =?utf-8?B?aVF1SUVhR0RzVTRIdWpnb0FQaG9wZmFFTHB4YjBEb29HcWNMOU5kRnJTbmNM?=
 =?utf-8?B?dUp4U09hUm5vTVZVRXd3bmxadWxPMW1NUkxyRnFNQ3JOdEdVN05lUXZMTXVE?=
 =?utf-8?B?d0tSd24wT2wvTUFldXJWT1U3NXBHS2pCV1BwQ0k0K2pRdEc0VG1aNm1HTko2?=
 =?utf-8?B?clp0bk9uYkJnaTA0UmcwTEFPaXY2azc0UWFRS3N4VTI5UEhXMXh2UGdJRm1F?=
 =?utf-8?B?RUQ4Y3RBcUM3a0FHWlZ5a1JsbjFNMGFuZndOL3F3NzlBQWwxbHZkeDdqNlV2?=
 =?utf-8?B?WlR6SjFiTGxRblZNOU9IS1BHZzdmd0RmWkhTaUJ0UGNNMkptUE1lUjJYTmNF?=
 =?utf-8?B?bkhjcDh4ckRjMURKUW1GaW8yVHN5VWxBTGx2bVhSRHhySHEyNGtBV1BGTVRX?=
 =?utf-8?B?ZVYrSEttT0hwZFVyU0wvbHlSNEFqSWFsaGZFY1lScVVvYkpjWGpOSllLM2R4?=
 =?utf-8?B?WHdLalhJUlllZzMzMFI1dHF5QTlpV2RLbmx4V251SkZ0QUtZSWVWa2J4MTZ1?=
 =?utf-8?B?alh2dXFIdFhKbWVSKzVpWkJrdWRzc3FOdTNmb2YvUGtObmVTL2ZlOTJTbGls?=
 =?utf-8?B?NmdlclJKdm5Ja2Q0dkRyQzNyT1ZFZDN2ZEVGSUN1cnJlN0JSTENEdThKQWhx?=
 =?utf-8?B?dVFnU2hRTWMyeEY3MVBPM1oyaXhqSXFBUnVRMEp5ZWtCV2RQQmM2VmphT2p0?=
 =?utf-8?B?NFR0UE9VSi9sZ2NuVmFwdE5zM3NSYWdPQW9JR3NzM2NXTDk0NWF2L3R5RHlY?=
 =?utf-8?B?Vzk3ZThoOGc0blAyU0oveUduTDMrWkVOd2kwYzlsZTU0djhBSGhqZmFQMHVS?=
 =?utf-8?B?K1k5aTRla2FhTmVSbGdoWFM2Y3BxckVTUkFCN0pIb21objNsZWZLb2Y4Q3Br?=
 =?utf-8?B?a0YvNTBWL1pFUWZmVUM0QkEvVWRtSWRGbk42Skp6NnNmV2VBZW9wdVMza1Jo?=
 =?utf-8?B?bWxWNHVqU3hlbU53b3R5VzNxSGU4Y29kSGZkTjIzQnhON2FpZzFsQ0lrQnJH?=
 =?utf-8?B?VzYwUW9MQXBzVnJDK3VnK2U2Nkh6MjhuK1NYeU1XRTRRT0lsYVlKeDRaTmhM?=
 =?utf-8?B?c3dYU1ZRWEtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 12:31:29.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f283a2-45c0-48e8-c99b-08dd0d4d1676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370

Hello Peter,

On 11/22/2024 4:42 PM, Peter Zijlstra wrote:
> On Fri, Nov 22, 2024 at 08:44:47AM +0000, Swapnil Sapkal wrote:
> 
>> schedstat version has not been updated since this change merely adds
>> additional information to the domain name field and does not add a new
>> field altogether.
> 
> So I don't care much either way, but if an existing tool is trying to
> parse the domain number, it might now get confused by the extra
> characters. I know of no such tool, just being pedantic.

I will change the schedstat version so that it will not break any 
existing tools.

However the domain name is under CONFIG_SCHED_DEBUG and thus 
incrementing the schedstats version is not sufficient when this config 
option is disabled. Is it okay for you to move domain name out of 
CONFIG_SCHED_DEBUG?

Previously, I sent couple of patches to change the schedstat layout for
* Correctly accounting the different types of imbalances [1]
* Accurately computing the task hot migrations [2] (This was your patch)
I would like to include these two patches that better helps justify the 
version change. Is that okay by you?

[1] 
https://lore.kernel.org/all/20240514044445.1409976-1-swapnil.sapkal@amd.com/
[2] 
https://lore.kernel.org/all/20230614102224.12555-1-swapnil.sapkal@amd.com/

--
Thanks and Regards,
Swapnil
