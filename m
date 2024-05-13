Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5C83CDE;
	Mon, 13 May 2024 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715570032; cv=fail; b=UPbu0p9UFn3Qy2xU+K1WeiKagI7VkNVhjQ1Q1l8Tihc+3raPf/DXMNwgpvu2v6iby2/Lelm+PKb7AH+W3s+0F7l2GGt5TFBlXdVw/pgmGetWABG1pa3BAnBo3Jq0WOY6ZLtqXulgbORRRIfwm/GPJfDaQBp2Qx3HCJP322CKU/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715570032; c=relaxed/simple;
	bh=prEjAIUEaWfsSjkVPV5LjZH0xjvq/Ur7FvJSG5CmeRI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nWmKihzu8G1E9SWerw7Ao67sY3GlUGGFlXMk0UlYoF39vpBUhyODfwwRzNF5ac+lEbupyYhD8snajS8NbnaRAcbXYHZI72J1vs5c4UizvT0++/5ld2jFYe63vv8GsqxHOyBMZi7whcmXpMFW/Wp22166GYk8vpf5SeaT3WpyboU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/MK7enq; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/MK7enq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1yhI3yx7uV0aiLc3Y51AhGTEiOFRY8UaZ9qZssJC7T3JqEnm2X+e/BueKwoMlFmvNZKY/vtH4cjkknardBIr6JojqEajKVuA9yPpQHbpuBBHVEqaLXZXcVclQHwC2wTUtcFjaQuIqk6iWrZUcxH7afdrWFQfWDQNI4yEIGMl79Fyh3p6WwJBw6+IW/ie+Xii3dfIIyIfiUMnH7zFwNfong9Mju/rWE27KtR+/mrkSlTmHVrFwBBCNdeiaxznjfFcsluPyEKV2Bofjim599eTNMPTW2Z0IhPpt/CCMUOLBhMZBEPhp4VWjpfGRyyTbCCt0+UWez9PQg0pnHTHouBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3ASHcL2fIwdiUBdklV6ExRh2y4y5BWAHnXVkd+yPDo=;
 b=hBqatbhwjV9v4nvLh2mQQsH8g1ettIMIVB7bQKU3Q+6HahubC58N3GgfAe2epEArM0nSYguaSMjMMuwT7PLzqT1EC+J/GtMGD9lK7EgerdhbuuLsPBvuE51OhZGjqnhQovwq9CGWoZ0WAF0JwtlIO7HYGmdSJRam0sntsOdJ4c0dzqkwj6rfzHTb2xy60H5nlX6gdIOIz75dkkDsR6ItbhSaEejPuWnZNRd2g82PoP2i8B8WIzZ5AWdMf75S3himSEMPxdO6Re8NbT208rUX353e1dSjzXR+OTdraTZWdyIoi35pL3eKciKzw5PJQL5xjmL+AMzvShwsVpb73NKTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3ASHcL2fIwdiUBdklV6ExRh2y4y5BWAHnXVkd+yPDo=;
 b=s/MK7enqEgul7z1lihp9xgk0Jp52jNETNH5WECo76afLwzbImFsgUGnuC4uG/nvIzWnE06f4VznMn0uxvv8VFHVlANnaXZv/QIbrl/ZSIFGy4BY7WiEI5hyv3i2VWIrKEqGtVtA0XdQ3vZS6+ajtUiJbe0XhSuwW+ESbTFz+UkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Mon, 13 May 2024 03:13:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 03:13:47 +0000
Message-ID: <284a27be-bd63-d86c-885f-756bd2d37adc@amd.com>
Date: Mon, 13 May 2024 08:43:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC 4/4] perf sched schedstat: Add support for report subcommand
To: Chen Yu <yu.c.chen@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, irogers@google.com, swapnil.sapkal@amd.com,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 rostedt@goodmis.org, vincent.guittot@linaro.org, bristot@redhat.com,
 adrian.hunter@intel.com, james.clark@arm.com, kan.liang@linux.intel.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, juri.lelli@redhat.com,
 yangjihong@bytedance.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
 <20240508060427.417-5-ravi.bangoria@amd.com> <Zj8iMV9vhyGC3tT9@chenyu5-mobl2>
Content-Language: en-US
In-Reply-To: <Zj8iMV9vhyGC3tT9@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eb129a-b38c-465d-b547-08dc72fab43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mi9lQ1BGc0t0Slh6OThDYWNISkxDOGZRUFZTUFhkeE0zZUUzVS81ZG11NFV2?=
 =?utf-8?B?aGtRUDg4R3VpdUxxeGk2aFF6VW9ZRnkwTEE4TlpTaUVqZXN5TXFKQ2VlU29S?=
 =?utf-8?B?blBGUDc2djVDdkJYQnlsYVNsdkQ5T2lTRHh0WktVTHd5ZWJJQjB6REZTUSt0?=
 =?utf-8?B?WnF2RVI4bWcyVTBKeUc3UlNvQ0Z1aEZXbmhYS0I0L01RRVN0cHpVQ1dhT1Nt?=
 =?utf-8?B?SmVhSUhhbEViUDduczhUbmNJQ29Ubi9jQ0xyNFVwVFFvUnlQWWZrdGU5cUpq?=
 =?utf-8?B?QWw3WWZtTGxNOVY1Y1FqZzNuT1MyeHdqNlovbEZpUjRBbzB2b0YwK1VDTEpp?=
 =?utf-8?B?dGpKZGlGWm1lR2IydDZpcmhtSmdreFBEZTczRlY1R3dCM21jM0Z0NURkOWI0?=
 =?utf-8?B?RUtjUHNZTElqNVV5MWpnME42VldmdXllci9FRWlFUWN5a1kyRGlDeTAvRzBv?=
 =?utf-8?B?WWU4M0M4cXd0ajdtZG9YSEVXT2FIUEVDNVRZaVJJb000SkJ3Wm1TQkJLY1BG?=
 =?utf-8?B?dHhPYm5WQmhLUnhUQ0IxeGlnRTV5WjlTWFI0akRQOTVNTnI5WVkzS2VMTXo4?=
 =?utf-8?B?d0dlU0p0aEZFTDNDSWt0ZlRaQ1hud256Z21nNTNhK09XSGtLZDB1WFlXL2hB?=
 =?utf-8?B?bFpad1J3U3ZHOG1QcThNMkgvNWZkQlNEZHcxTW5mUHJ4QXJWQWRhRXpoY1Y2?=
 =?utf-8?B?NU50N1Q3UmRQeUlXUGYrTmUreVVJR3ExOEZ0b0RLcGlobnlsMTMzWURhYWNF?=
 =?utf-8?B?c3U3Vk50YmhZenRwTGhWSkFVSzRQaWMrSG4wcjdaVDBHd29jcDBtb2RTazJp?=
 =?utf-8?B?RmFhb2FRNHRPdjlWUHlGL0xJTmVxd2h6SVdwYUpsRGFpdzZaTDVtUDU1NXRD?=
 =?utf-8?B?UjlDSGNIOHFqQi95Um52OFdpT2Mxb3VjdExQODZMWGNqWUw4VXFCVzZYaHUr?=
 =?utf-8?B?Mk4yOXd4a1FzYkZzZjZmUTFSNUxjZWNqNnhOZ3RpTXFDNFZzcnJTNUc0VEtT?=
 =?utf-8?B?MklSL050clhUZFdmNCtHUG1ycDhQYjMyN2MyVDVYV2ZPU0pFT2pKU21Gb0Zx?=
 =?utf-8?B?Z1Rwc055YnBmK0k5ekV1ZmRweC83TDJiNmd1bDB5NmRIRnAzRlZ6U3AzNVNR?=
 =?utf-8?B?akFId0E1dVRDQThnbzZYUml3ZVQ2clRNU2ppVzRpVlh1RG96ZUVqb0EzTFU2?=
 =?utf-8?B?Q0d1VjJvQlVpaGduTDg3bDRLdlk0SlJmc2J6cGgyQ3FHR2ErOUdEcUZNVzNB?=
 =?utf-8?B?alZQaUd0N0cxZmZOU1ZBdW81SjVtalBLSE9vU1dUd0U1WkRucFpIQnZVbGN5?=
 =?utf-8?B?QVc1aEJQN2x3b1gxVldBOE1MUHUveWlRM0VYU3FYcWF6MXQrcnQxeHRKdGxy?=
 =?utf-8?B?MU5DRFl6MEZpdnN5UHN0WSs4ZzJ3aHZYdno1M0l0V0szc2pZNytsRm8xZ3Ex?=
 =?utf-8?B?SGlzcDZaZnRqcjFMdC9Bc0VQL0FIeWFzb3dVUU10ekRPSnRHRUtubk9VdzMx?=
 =?utf-8?B?aE04UStScjBRU3E5cHZhdldVRityWWFULzlLcE80WmRxL3R1Qm5HV0Nta05I?=
 =?utf-8?B?ZVVIcTBDNmhXUml6bUhJUDB6cHJYYlpiWWw4bTZ1TW1mVU9iZVoyb2tVeUk1?=
 =?utf-8?B?a0FYOHJueG10ek4vYzcwY2JaK21Kckhoby9lczdZUGdJbFhYeUdHK2ZuRjJ0?=
 =?utf-8?B?OURXUEhWa0JvdWtJOVRMdHdnSTJ4RDZQeGdUVE5IWStzZkt2QjVnMFBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEM4NE9xU3EzUjIvaXpUbHRRMXl0Zk9aaldoY0pWQjlaNDZYenNLTkUyMGVq?=
 =?utf-8?B?Z0I1eDQ5NDkzVTU1R3BuUGdhZnZYSVN6OFp5L3dWRWN4N3djRHJlWWgyZVBt?=
 =?utf-8?B?S082N2hEaTVWeEROWms0cVdJTXhEdks0S1VIcmpYQWsrd2xZdDJ1d1c1R0hK?=
 =?utf-8?B?TkdZL01VWDVDMXlkQWdIbmRXZTU4bTY4c0FpRzJudS9Fd0o1NEFOYmN3emZ6?=
 =?utf-8?B?cUU5UHNrZHE2WmlRNmhBN3VGTDVXaGl1UTRIZHArZ1BvOWVTN0l1SnVrVEIr?=
 =?utf-8?B?NWJSL1ZBT092clUvQkhiUHdodVByVkhqNEQ1NnhUMDBWWE0vOFh3elNUZGUr?=
 =?utf-8?B?SEpxMlJHSGZ0SmlncTR6dXI2NS9BMitEQWdrdEMzUWJGNFlWMTlDV2t4REQx?=
 =?utf-8?B?OTZOT1FQT0s3cVVldHNmQ0UrREJnZFNvQWRtYTNXZXlPZm9PY3FIazE3ZnJP?=
 =?utf-8?B?akVkb3BPR2JHMkd4N0hJM3orOGxMeFhjY3d0aGZkSkhrS3FuZnlWc3A1SzF5?=
 =?utf-8?B?Q3RBdU82Z3QzYUZaQ0JmZW1OODFvbTlSZnova3crcUE2WlBSa3MvdUNOUGR1?=
 =?utf-8?B?T29LUUo0VGVJZFhvd1E0Z3JYbHBEMnI4SHJMNmFHZTlkeFNqV0Y5cDl1dTV0?=
 =?utf-8?B?NkM4QXRsVUx0S3VYR1lXV2czSE9kMHlsN3JTSGdEL25KbkRwdDdoOFpKL2Y4?=
 =?utf-8?B?VGxhbzhxVVlZWm5mMlJkVUdpOTYyUFl1cjJEa3d6NkdnMEJHazlsWGN0Ti92?=
 =?utf-8?B?MWU1Z0hzZjM5dW8wdUFFZGdBc092NmRka3R1UytXdEtITlJXV29tS29iZElk?=
 =?utf-8?B?cEFSajluYlNWWEt2TkI4VnJlN0YzYmt0VlB5TC92S2hxalJKVWl4RHF3UHVX?=
 =?utf-8?B?TzJQRzNrVS9IRlNZYUZaZnhxZllOSWRjQ1QycmZvK1FxejQ0SVdEN01yemhp?=
 =?utf-8?B?b2Q0eTlyN1BMYVdKcjVjNHBRTWpNZjNkb0gyUnZmdDRMRW1LbC9YaTZQeDdI?=
 =?utf-8?B?b0ZHV29xN2VyOG5FMit2SHJyY24zZk9TVUI2cjRnOE9oVWZrRXJOYmx4Z21r?=
 =?utf-8?B?TVRkWVpaU3Vmdnd1R2tOcUdybjN5czFHMXl2aDB1RHNqLzFGKzVvanh3YU83?=
 =?utf-8?B?Vm5TQkxkVnNHYkdpd2QwN1NGcGRxbWVvd3pnNlVjQ2NHNWY2R3VoZG40NUJE?=
 =?utf-8?B?a3JBODE2QWZHcXkzRFdKSzdOamliWG1BWGRTdndjSTdObzV2UTMwcVZUbzVl?=
 =?utf-8?B?OTVJaDVXOTJKV0R3bURCTVVrc2gwYVdiZC9FRnJMZWtIbjVDL2FuRFdvVjdY?=
 =?utf-8?B?enYvWmJ0Uk1BaFhDR1JaN1ZRenZFb2E2SzUrVUpPdjhDK1RCWWw2dW9KZm9x?=
 =?utf-8?B?L0RqQ2pZUGY4dWkvYk1JeW5ONkRpZUN6Q0w1VnQ1ZDFRMmxMSndpeVVnQytD?=
 =?utf-8?B?ZDR2YmJUY0ZZQ0JLRHJMN2o3Y3pvUkc0Z0RyRTFvNC9uR3RsSGxlT1ZUSVo2?=
 =?utf-8?B?OVFualZOTTZXV29NblFtNk5GQlVNWUJXaTJrV0F4eStrRU5MelN3bzBtcDBB?=
 =?utf-8?B?Z0g3czRqQjIrWTRpT3pqemJvRFVVS2ZKL1FWQm5lVmxOWC9CMVF2M3BhSDFG?=
 =?utf-8?B?QlNiK2FMbmtJa2oxRXNkdXd0Z0pWRGJoY09Bdjh3aU9hUmR6NlVodHJBZExy?=
 =?utf-8?B?MmZkTXltcTZzS1BGVmRRT1o5bHZWNDJ5SUVjUDRjK1dPVE1UdEhlSnRzZTZi?=
 =?utf-8?B?VEx1VjNIRmhiQjgvTGhGa252bXo3U3dYaWNSdTJ4ZkxUTExFb2l2VVA1QUtS?=
 =?utf-8?B?c1Avak9MUGY1WnhzWnQ4Q3RMU1VHSFJJYmc4K2Zxd2VpcndqSW8zRm8veWY5?=
 =?utf-8?B?NUlYNUZDaktCaThsSWpab2RUcEpnMU9rT0tHejJkak5WNHBUbWhvTGhYSmNG?=
 =?utf-8?B?L3phbkZFZ2tXbGVsOExHNG80aHFDSHczTnZSTitCVUNmNXVWcEZRay9aR2tG?=
 =?utf-8?B?WDdaYk41anVTSGpkSDAwVGtsbTlQTFJpNkxDNG90TWtKUUFXZFZub1dLTHA0?=
 =?utf-8?B?T2ZIbXlPZ3RoMzBoRFdXU0g1THRzaHJhSTVacUd6Q2I4SzBscTRnSTNOVENU?=
 =?utf-8?Q?U7owg2fNP8djX1cHXIUYuzkQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eb129a-b38c-465d-b547-08dc72fab43e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 03:13:47.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZ4guOqWpMZFq4YyY1iqML7Xsmot2M/zmpFT2zXXbdlE9QzBPGUkmORFeb5qcHY8nAlZga73Y+35SkscyktBOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293

On 11-May-24 1:15 PM, Chen Yu wrote:
> On 2024-05-08 at 11:34:27 +0530, Ravi Bangoria wrote:
>> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
>>
>> `perf sched schedstat record` captures two sets of samples. For workload
>> profile, first set right before workload starts and second set after
>> workload finishes. For the systemwide profile, first set at the beginning
>> of profile and second set on receiving SIGINT signal.
>>
>> Add `perf sched schedstat report` subcommand that will read both the set
>> of samples, get the diff and render a final report. Final report prints
>> scheduler stat at cpu granularity as well as sched domain granularity.
>>
>> Usage example:
>>
>>   # perf sched schedstat record
>>   # perf sched schedstat report
>>
>> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>
> 
> I've tested it on a 240 CPUs Xeon system and it looks very useful. Thanks!

Glad you found it useful!

> 1. Just to confirm, if we want to add new fields for debugging purpose,
>    schedstat-domain-v1x.h and schedstat-cpu-v1x.h are the only files to
>    be touched, right?

Correct.

> 2. Although we can filter the output, is it applicable to only track some
>    CPUs? Like perf sched schedstat -C 4 record

Yes, adding filtering capabilities should be possible at both record and report
time.

Thanks,
Ravi
