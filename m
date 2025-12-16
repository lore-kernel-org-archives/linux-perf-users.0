Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113EF2D8796;
	Tue, 16 Dec 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879777; cv=fail; b=TczQMk2Ibk0Gcbwu6XscuW1b9VRNloh7SNBFPWkvSBV2LVIEgmxN7v3eXNeuBag0O7qZ/wKG5KqwkOK4qfL7Mrr9MFCSpuMHSESRbYoJ3Vi3Tf83Sp4zHyWiKxQ0d/T6PKd7/C7/5PH/jnohQ5cGj4Fxx+ijdainuYr9QPKs6qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879777; c=relaxed/simple;
	bh=Mkokjaf0AUn98DhJh8cx31QDQH0qbu32jFGtk3lfCHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZPRbIZscULco8n05SAZRSLz5bN7NxQ7l8OELQwrE/XcOoGKUpHaa/07/1qK+VQNvV8pD4IPrUJHQD7ILbHGf+2MUUBmz0jUlHf37TYwqG1W7K54N3uAAJW4wvOTlfg9h7R2FT80KQ0n6mF/fwBjN66CpODK5htmyOBqkSjGIfdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJmlxl4k; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJmlxl4k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7L2pYh4sf1c02Ae0eJIAP9tXHueAh/JUh4mFNuPsPBW9ez74F5OKdlv8uM5DZ0GuFlru4UEdVkgXXy1xcN4ZH/DKIkqL1eXhsBh3P+rn2n6SHn5/Zpk2Q5oSL1JSWWob2NOX2Sa7d8MWc+G85nC+E0FUVp2hQZtqTcovoasP3EaDzwCXIfh6VlqBRpR2I1q8PFE4eZMeqTWiYiLnWSKL/R0FJXlDG7HSLBwoy+3h9ssu7MyxOGkRKHr8v7LH0+pa/qkavcdof2yeelPCWuf1V+hNYb9E7gwR8EY/wQjImNPaq9/tg9+bGo56M6IGIJ3xZiRiLQOpppBnLaNjYJQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khFVfOUtn6hTfiaoPj+Pv+lj8wUiHaulGmXKAkw8UTg=;
 b=VdEnbhLdEDG/pkM4YdDwg6Car3nDCH9Kl+lOhSvxaMUzno+c0WWlP7Xra1MQ1OdJm1YPTmi9NUhts9o9q9e2bluQZx8bhzq0OxQ7mWgrzOBNRAcVZ9wMGewnl2QeWqLm4XRbB3HA5fe4fOEU/3LUbc9ffj4seBVz+QxsZW9R7LrOUs5U1QA3mKM2kPr92OhFLHRggPP/gFqco5sWDACMnTrY73RpBE5IRkpegNP4pvwrppn78dx3gDWf3XXdhAyFzA/PvAVU9Zu8sVQmULVGZCwO90PBN2yCN/UVxmKn5wAqv2vn4c6MxdL+VSUlEv1Vc4RKfnvqGlKjQlFS1CzY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khFVfOUtn6hTfiaoPj+Pv+lj8wUiHaulGmXKAkw8UTg=;
 b=uJmlxl4km6TmoUz8h5InwEkoyUFMYfn083RFWzgpF6B5WKf5M0q63U0vuab4J9l+v6+MGSdzuzWOZz1TdHvY8cGKVuqEz4/pNU6HNrVG7oRa5faWXdSWG374eUYPPyGL2+RNQocMZ5EGbqxsKdCIhjLs0LNGxEbZFQbtJkYB+TA=
Received: from CH2PR11CA0018.namprd11.prod.outlook.com (2603:10b6:610:54::28)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 10:09:32 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::8a) by CH2PR11CA0018.outlook.office365.com
 (2603:10b6:610:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 10:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 10:09:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Dec
 2025 04:09:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Dec
 2025 04:09:30 -0600
Received: from [10.136.43.216] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Dec 2025 04:09:23 -0600
Message-ID: <3b7c8c6f-e54e-4bec-9e12-ca672671ad87@amd.com>
Date: Tue, 16 Dec 2025 15:39:21 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] perf sched: Introduce stats tool
Content-Language: en-GB
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<sandipan.das@amd.com>, Cristian Prundeanu <cpru@amazon.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
 <cc87d705-0409-4451-b95d-8a9af94f0c1c@amd.com>
 <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <CAP-5=fWSFgkWggNaYDRno=Lv+s980_9ckr3vKy+CX2TsCJH+vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: swapnil.sapkal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 418d1255-b17e-49ac-7a10-08de3c8b3563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QS9FaHhqMERxempNN214bnJ0MGRTMEtEd2pvSFN2STlLL3c3NDZtTllSRlZX?=
 =?utf-8?B?OEZWWUw4d2dZTzUwQUdKM0ZWclR6ZWJMZDQzQ2xxdlE5b3RjR2N5MjA1aURR?=
 =?utf-8?B?TzZ5ZXVQd2oyK2RnNWFxNjI2V3A1OVRqckVVTi9sN2M1R2ZjUmZ6anZvMnhT?=
 =?utf-8?B?d21OMm1Xb29aWk1kUmh2SFUvWWduS2ZxZE1wQmF2TWRKYkVWbC81RkI4MmJx?=
 =?utf-8?B?bzByakgzalM1N1ZrVVZiRjA1U3VYbDY3RG93c2pvbHR6VEVCRXJJNmtnSjUr?=
 =?utf-8?B?RFZ1UnVpS1dMZXlsZG1HK3F4TTVuUklobVFrc2JrMTV2eGZVQUYvSlBpUEIv?=
 =?utf-8?B?eC9oWWxJcmR4N05iVXB5clNyVUl6bzJFWHNscDQ5cktVZW9EYkFuZmZUZmpU?=
 =?utf-8?B?SkNESy9jaGlIcS9PVDA4NzJHb1ZiYlo2Z21RQzExdmQ2aGthamZqSXZSa3Bs?=
 =?utf-8?B?UWJ1cTE1OGh3YzF2RExoeng5ZmZYd3RjcFpSYlF3UEZYVVFSY2IzVTZuNWkr?=
 =?utf-8?B?QVp0T003S1pTWlZnSEhyalF3RTBpcGRKVGxtOGdSUTYyTnVUN3A4MHVwZmJm?=
 =?utf-8?B?OWVPUVRKTVpmL2tGMWZZQzg1TEd2Ym8yK21YUHBEN1JrY0puZGVuWDV4aWll?=
 =?utf-8?B?RnpTUTJnSFA5WmRrREJSaUtzc1NwRmNhYkM1RmVzV0R2Vm9UNmdXT3pYNno1?=
 =?utf-8?B?ekM3R1pGd3QybjF3SFJFNzBRZzgrQnJlSFd3eWpZN1YrWlJHdEpJQnViZURW?=
 =?utf-8?B?S3ZEM3VObCt4WFlOY05NZy9hUFcxWi9icUZhUS9saytXTUxlZWowblNZT1Va?=
 =?utf-8?B?Tzl1Y2wwOXJIL2xmaVlxaGtPakt6TmhRTW1kSWN0UlBjZUQvTlNxZlM5RzFW?=
 =?utf-8?B?VUlEZ2srMUlsWDh1U0NXMnZsUTh6MUJCZXNaNVJ3S1ZpZy9MYUJNaDRIVmJH?=
 =?utf-8?B?L1lqRUsvSE9teCtuaVNFMFZNL1hIanB5bkVtaDNMdUt1UWVoeFFidm5NMkVj?=
 =?utf-8?B?OEhZVWJTTjJEUEdwUXZIci9URDdGbFMzVHl3S05wRXRHZ1JUeXAvSjdpLzVG?=
 =?utf-8?B?TVVFUmVOaHJXaDhhTzUrSSs4WGEvZ3o0cWhyM2VYTUpTWGpDckJDOG1sWmhh?=
 =?utf-8?B?TTJuaEJ0RU5hai85V0svaDZYT3BlcXVmQ3B3a0lUK09rOU9TUlNCVVBZSnRD?=
 =?utf-8?B?dy8wdmZ0ZldmM3dnNU1sYXFZZytqb1MwVzB3TzhPamlGZTNWRU9WbllZb3Fo?=
 =?utf-8?B?NmU5VlRiQm05MlVkVFNNcUs2bzVsazFtRGM1eERDdjZxZkVCRnJHNThITUha?=
 =?utf-8?B?VkVHUFhDa2JWd3RwUndqbElwOFhzSFBDd0FYZWdvMUZZeUFCOGxPSGtsTGhQ?=
 =?utf-8?B?TWFBU0ZUbDhoVjJ4N1Rlb3BXVE8rcDRIQ2ZHZDVDWEZFNXUwNnF2MFNTR3Nq?=
 =?utf-8?B?NDVLdk9jTW4xVnJ3eXZQUGF6MmlzajNsQktrdFVNdDhXdktHLzliK3lhMWkr?=
 =?utf-8?B?eExSenVUdjgyT05JRWxlM3ZycUVrc2VXbGtsTXM4MXJFYnRpZ1REQkt6ZnFW?=
 =?utf-8?B?VmlYTEExSHhOU1pBZ0ZNdmc4alErWHlMdm1WUmRHL0tkZEJKRHN1bUVjNmJv?=
 =?utf-8?B?OGN3Sys3b1Q2L0xGcFMyakVjRW1ZSDRFNUgzZnhvMkxITS9DYW05SE9veFlO?=
 =?utf-8?B?VGxmbmpZbkZPd0ttNGhSbmppY2FCRk1ad2FNMW9rRjBYcDNKZzN1WEgyNURQ?=
 =?utf-8?B?Z3ZEMTNwNWJ6OUtnQi93YitzcDhsV1BwN3FUNXpCczBUd1EvZG9jVU9uamdk?=
 =?utf-8?B?VlpHSXZrUlZ0cXdkZURXMW1uV1krVjM3ZmhqNTN3QXNHT2ZwOEErcmNxZVlt?=
 =?utf-8?B?MktoRzlwV3pWSnlhbUk0M0k0N2k1L2hoaG1LRTB5eEhWaU5LNjRJb2IxUXhT?=
 =?utf-8?B?emU2bi9RUnQrREJxN1g4T0Q4RjBqNEw2bWlKa3FvZzhiVk90YklrbDcxWEs3?=
 =?utf-8?B?M3VpMHNNbmxvNUpXcEFXMkpNWXdYT3ViRVNSWGRaMGlHZ2VsNlRNTGNwZVk5?=
 =?utf-8?B?U0s2aW1STmFFYytzM1cwelFiOHhoRXFMTFIzdDZRb0M0THliUHo1ZmEvWWY5?=
 =?utf-8?Q?Auus=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 10:09:32.6485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 418d1255-b17e-49ac-7a10-08de3c8b3563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623

Hi Ian,

On 10-12-2025 02:33, Ian Rogers wrote:
> On Wed, Aug 27, 2025 at 9:43 PM Sapkal, Swapnil <swapnil.sapkal@amd.com> wrote:
>>
>> Hello all,
>>
>> Missed to add perf folks to the list. Adding them here. Sorry about that.
> 
> Hi Swapnil,
> 
> I was wondering if this patch series was active? The kernel test robot
> mentioned an issue.

The series is active. I have fix for the kernel test robot issue. I will 
be posting the next version in a week. I did not see any more review 
comments on the series hopefully it will be the final version.

--
Thanks and regards,
Swapnil


