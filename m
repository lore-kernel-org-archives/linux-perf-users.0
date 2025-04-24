Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B101E5219;
	Thu, 24 Apr 2025 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477539; cv=fail; b=JfHzYyySa5Oc6wN6SwXWn7RU7Fj4gNbilMFi/RrQgED3VqtdNljKlEOJn5VNHuFriFRqtUES3Dk23a6BpEEvzJYnpdpuhws6MCZ0BOaDkgSxWh3o+Fj+kVx3A8ptsTHOoPX0w14HMyKlrxCDDOWBuLsFYHodHR3+A4bPcjkv9uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477539; c=relaxed/simple;
	bh=Q8IoOdFxVLdPlcb58vnchwZmTL9eqtdNTJXLbx3udj4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LZyLsufqfKaMb1lW99CCPzRjq6OoCEMoKyJb9eL5mfX5hyBIMlhpyp73QVKcS67mz8JbSt/J/FKj2D0Q4YHh/aVm1OT83svc5yDSEJNK57W9cf6ahFRg6183FfgFRHNHPJdZYUGT2jTSQyupIyMXt1kkWF9+paC9f/3QhGe3wG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cWg/vdpx; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cWg/vdpx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omB4AKdr4SzznZIxwOO+z2FnGP+u+ybfOYeDZpZpJYHR8ec+Tff8OShoIpASyUBG6bvbS+ZUMqAjbZGQmjPVptnWymAFS+696Gnl0/t+G3Am9CxpEPju/viTcqDnnA1I4wg4L7htkN2uHO+u95GAjc6servsQbU/8GxOBg5tOGCpC6xDo4tGNjtqw2tTWnFjUXyOr9qUnYfZyHiz3ec4gUAgMkj4Abpo1bKnDZUlhfUSQ1ALXV6fv2MI3ZVzVHwzepDyRWozyjXtyN1rCM07QF/HTqduyluni1dj3JvyUVS3371neqh13hphgSCgZXFX8nZGmm0FMSFJNJB68c/Rrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hyV+wZTU+G1XkPZUFo7qqtEzlpG95uORIbAOwFg5K8=;
 b=A3jCfgy2TCfP849lA0inYLEtq9wVcO0ALwtziMwTWzHJ0Cf5gFy/nM3Hmdt0xLeK3cRN7XX0nEMNAWR0XBOE4IAfjxCEX8rSaeGiD1gy+1Axw5xjXeb4JK06n3KpztkLRaEzLYXS9JhueH8PTVAsn3D+JyNcrX6jf9q+VxuH9OuZ4Z/xPJcEPrxgAlvy/nZ0RfIHm1YH001WyegcQtPgrlj5G4gQQvF3lqZSlaGKtE/yQjNl2c/MqM7+ccTttmMRFQYO8MQ5Wbgxf0yz8L9hC95NCkRkxggyJ9OZ6xcTvDXQR/tL95vzygGnNGw6t+SMRCJ6pMkBFa/geLVcyZLwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hyV+wZTU+G1XkPZUFo7qqtEzlpG95uORIbAOwFg5K8=;
 b=cWg/vdpxTBVRKnBERyEwyopYUs75xeP9b5WyjyQZLMqLXnd5WExAVWicggHj9t9SWrc3Tl/544Sv5UQMFU6kS+uNFSp58ENhSI+Aog6mS3HmLBl1jeIKILpcTV73bCmUIwfQqwu738URookLk0hzfcVHiXamL4MxjtL3YaF2qPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:52:13 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:52:13 +0000
Message-ID: <f8c349c8-b074-4b27-b799-e484631b9b3e@amd.com>
Date: Thu, 24 Apr 2025 12:22:03 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf/x86: Fix open counting event error
To: Luo Gengkun <luogengkun@huaweicloud.com>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org"
 <acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Bangoria, Ravikumar" <ravi.bangoria@amd.com>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a730baa-4a12-4f63-42d7-08dd82fc8ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDh4bXZUU20xNmhoNElQVU9wZlJPRDhzeGg1cHJZZWRMdFUyVE94NEdva0dJ?=
 =?utf-8?B?VWd5VHJwNlQ5QTlXWjQ1dU5HdTRYeVhrM0pTb3llclZqakxTUGJQa0g4Nld1?=
 =?utf-8?B?VGhEakl5aEs1QnJVbHE1K0NUS0NxeDkwVzA2R3EzRmpzWnkwSXdTa29CRUJ4?=
 =?utf-8?B?QWgyTFpNazkwTUxNcllsWllUVEFVMmFqSnI2UUNaODl3ZkRyQjRJSXhMOEZI?=
 =?utf-8?B?M3ExSXRmcW5FNGk4OVBnRThSUThsS1pITFdqc2RINzRaS0dZbnJlVmNjVWx1?=
 =?utf-8?B?MnhwSmVTYjdMSlhXY1RBYkFqVUFYbGxIVFA2NVlPaFl4TkhXL3RBcDRydGZR?=
 =?utf-8?B?d0poT3JZeEpOQjZ4TWF5L3dCTEpMdGR5UUxDT3JqVGlPL2NKYlhQQndxdmhl?=
 =?utf-8?B?RHJkNklXMUNCRjlPVmg4NGVDclh4OWdsZUxSLy9aT2E2SzlUZ0QrRmQ0ejFq?=
 =?utf-8?B?ZzhlSG5NYkQxdmcveHNzVFhnRkJUOURNTldIRUNDdEJKQllMZHNzb0NNSC9V?=
 =?utf-8?B?djkvN2dnMkJ5QWp4THhyeTRYL2NEQlFNL3dHTWdUYkYxczFmbUdVdXpkeS9x?=
 =?utf-8?B?OU5CV1BZaXprZGpZUFpRWFlHWk94VTA1Ny9JZlVWSERQZ1hOQXlHYjlOWkVT?=
 =?utf-8?B?WjR0eHJVeWMxc0hDS1l3cVNqUlNBSm15dUZ1d00wbTkxUjhsWS8rYmRWQm9F?=
 =?utf-8?B?bkNrN0VJdTFzeGJZRlMxUExYaG9reXBBNVZjUHc4T21DZ2VSckV3bFZBVGMw?=
 =?utf-8?B?Mm4ycmNXRHg2byt6RXZWaVp1OGFCSlZYUTRmbWJsR2EyZnlCSlJiUUk2UThH?=
 =?utf-8?B?WDZHTyt6OVJxRDFndExaRUg1VXZrVC9XMDhtckRDNHZ1Y2huZTI0M2VYUlhB?=
 =?utf-8?B?TnlkMWlzT093TFUvNmxkbjhOUXZOUUdaYnlIbWJrMkp5MGNYRVJsYlVIc1FT?=
 =?utf-8?B?elZ1UWQrQUtWc2lTQ3h3bnkzb3FKRnVDYkp4TzNNSm5QbmNLSmRPQ0V0YjRj?=
 =?utf-8?B?THJMbVNqQmxId3duemVLYlJrbEQxYmZVZy9ZOVFNV292WWkzd0lDaG5RbGg1?=
 =?utf-8?B?Y200RDNSL3FJZlp6RE5mTFQ4UkZ2NHlpVm1ZL2Jpa1BJV1dJMEw1MWFBdGoz?=
 =?utf-8?B?KzI4K2ZHdEV4SHJxaU5qM0NqL3ZvdG0rWTEvYjExNUxRdmg4TWllclBGOGZN?=
 =?utf-8?B?ZVlBUWZwSytNc2NLaVdkZ21nM1VqVFc3UHVMNURZbHlTRlRGbTRPdnV6RFVh?=
 =?utf-8?B?aW8rWUJBcmgzZmJ1NTdyREptcWt2YXM1WmpGV3NUTGR1bEUySVVwbHk0Wm5z?=
 =?utf-8?B?eHpyUmdLaUZWMVFPdHNvWXp4UDIvbDhQU1BZdkVhZW5kOUVITFlYMjJuS2I1?=
 =?utf-8?B?MFRNUVZscjZuWjlQcWVUanBWODRZanJvamllMlBpWEtmTFY3T2VEaTJidE0v?=
 =?utf-8?B?U1VkQU16c0RxSUtpM084cDZTRzU2NHViWEttR1FNRTlDYW9mMmdqTTRQOUI4?=
 =?utf-8?B?NHJLOUJ3a24zQjc4dTAvMk0reVpMU1N4WWhoWndySnBLbWNHeUx2RUhMN0RS?=
 =?utf-8?B?VThYYmxrc3dnYzRzem9XWFY1WkN6UjNkTUJjNWExRFhYUGlYSlM2RW9pTWdw?=
 =?utf-8?B?alRTcSszMjhKR2s3eWFqMmFFMGltRDRFb2pHT1dsUHFZSTc3RHdRR1RaRzIz?=
 =?utf-8?B?RU9jdW03UVpqS21zOXBUTlBrM3BHVGsybkRMUVU4WUJpVUhRbjRGd0N4K1h5?=
 =?utf-8?B?c1NKNHNJcXlTLzVNL3lYUmFqNkdrRFdwL0pERVZVeWlSU0dnOTRyUlY5OXJm?=
 =?utf-8?B?cGlHTnhwMDZRQ0VmbGUveGZIRXFydmtnczczemoyTXBpM1JxZjBCUWgzZitm?=
 =?utf-8?B?cWRvRGQxMVRZT1RmU21odldVSk1USVFHZkwyMXFyWW9Fd2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dllqYmlaaVhrTEl3elBXVSttZW11VmM5R043SmZQbU0xeWs4R0RoMFZVVDRr?=
 =?utf-8?B?cnZxTW9MaGlhaUM2dEpLd2V2Z1gybFd2OHExS2NwQ3kyVmVvdm4vWTRkTng0?=
 =?utf-8?B?MVpFM0hkL1p0MFZOaTAxY0ZabkwxU3U0dGN2b3J5SlA0UXlhOFdhWjNFOVFx?=
 =?utf-8?B?R3lGUFpFUWhKYkV3a2RFd3h5QWVmb3ZlTmhyengzMFBHUzZiLzBVUlpDRCtD?=
 =?utf-8?B?MmZNbEtzWU52SjMxUTZJaGdxTjFjSXNKUkxodCtRendTSUVyZjFJTmF2bEFx?=
 =?utf-8?B?TGZiMHRNMGREZTJFcnprN0pWcWk3U3dKTk9WSmdOY0RLRmJrUVAvRGRwOEhP?=
 =?utf-8?B?RHcxVGtMcC9jYjVxalN2QzZsOTdDQ1hyV1c4eTFqR0tjR0dxR29WUXNrUjFa?=
 =?utf-8?B?YWVGdVJwN01mRzdmWjVsSTU1K2t2Mno3bU1TUXpCeU81ZThNait4cmxRSkpG?=
 =?utf-8?B?WTAyOXNzZERubCtucnhFNmloclpZSUp6Um1SNnkrREU2RzZMbmpibEZ0UzhY?=
 =?utf-8?B?VkF1UnZQZGYwd0tnSHZJeEx0S2NhNVBUbjBMRjN6dTMwQmJ2WkpsOU4vbzlK?=
 =?utf-8?B?SDQySVRmTmNHNXIrUllBc2Y3cEExVzBOSEVCZ1UrZ1ovV1o1bk91VnY2cE96?=
 =?utf-8?B?a2VrWXduTWYrRUJuRDg2Z01iWkdld2ROMDFnMFFxQ01seHA3UVZESVVYaUdT?=
 =?utf-8?B?bTRnVEdET3Uvc3kvdTRscXdvcTljS2xoVjJUZ3k1RnJweUFLa0xRQndyaFB4?=
 =?utf-8?B?ZFdGSVRNMXB6eGZxMlBVeitJNmFkeCtROGZOQnBDNElDbUh5TjRLV1hwbm44?=
 =?utf-8?B?dTFhbTZacHhzSWZIRHJXTk0veGJBd0hFbGF4b1JpWDh0MjI5ZW5MNGp6Njg1?=
 =?utf-8?B?WGUyazREelRZdkVZbEd5M2lVWmlGR1V1WHVBN3oySkxsdURFdlJDMERHOXVG?=
 =?utf-8?B?UzNWR0R2N3NtM1dSTWRoNldGZldGbWZ1WUx6V0EyeUZVR0M1ZVowbzFwSVlz?=
 =?utf-8?B?aWpxM2V4UnZndDYvYk1heEFRc2h2dGw1cHNzR09ZT2k5cmdQaFpDRUw2YUM5?=
 =?utf-8?B?Y1lXdERJVHlWZU1BNHp2YTFtYzNNcVN4T2JyYjA2M3VGVk1iaERaeVlFcWw1?=
 =?utf-8?B?dzE1UXNKUlg1WmgxUmxDKzNxeVlSVDY3ampMWmUzUjc0NEZEK0tZQlRFSlFB?=
 =?utf-8?B?TlRQb0lSNDJNOTlkYnUyRzVhaS9RVVYyUWtXbWp4Ti9mTWxnVTR4c3ZwTWRW?=
 =?utf-8?B?bmVScGNEaHM1bWZ3UDluT1Uvd2JiOGlDYkxTQ2pTNlhQTlArY3dWY0dJZUhN?=
 =?utf-8?B?cjYyUTl0ci9ESzg4djR5MWZDRTUwNjVacE9vS3ZLdDVhNGk3cG1MLzJZbkZQ?=
 =?utf-8?B?c2hSN3FBWUo5TkhidE9MZGhoMjY4Y3RpUVlCZlNxRHFyTU52bW54Qjlpbkly?=
 =?utf-8?B?Z3ZNbEIySmFaT2ludjFGVXIzdzd2WEVaS0pxaEVZK2IydHd4bWpENzNKUnZB?=
 =?utf-8?B?cERtNTltaGpMaGVjeXlrZllkejF6TlMvZ2dWbm82Mi9XRmJGWjNDTlEwdVkv?=
 =?utf-8?B?cC9IYnpOTFg1N2Z2U014T2x2K3ZQaUVsc2orcDI2SUN5eURNSDNWZkdNRXhh?=
 =?utf-8?B?Y0tMOWJGdUNZNVU5ai9PbFhXK2oxeFd4QzVoYnlkMmxYL0lVdU9UVkY5WDlo?=
 =?utf-8?B?R0Vnbm1mdUpleUZ0R0dkRS9RVTQxMHRPUnFwY2p3NWhscjZSQ2RpZ1ZhZFVC?=
 =?utf-8?B?VS9pd2RBTzVvZ211RndoeUtsckVKc2VpZXlhMEZFOWxGWHpjSlNPZlpNOVNL?=
 =?utf-8?B?bi9Gc3F4RE9GMDlicGJwdU9KeGVQNXZzYVJxdFE0ZjNjQlE4amk1U2l6aE95?=
 =?utf-8?B?ZDkxd1ZCSnFreGFtdHhzRnVvc1oxWGhzdG0yaVFVdDdIcHQ4UFExNitlcTEv?=
 =?utf-8?B?dUUyaGE0ditNZEx2MlJkV1d6cS9iMlZrdm50dTZyTGlHM09Ldi9uRjU3dmFC?=
 =?utf-8?B?Q3RnZnE5cnhrQjVyZzFvdi9kbXRMaWdVYnpnaGJMdkZQeXJCLzhMNWpvRGM1?=
 =?utf-8?B?S3JHMnhzT3VsekJWZjZZUzBXMEhobkx6OGNJN04xY0dnUWZVWGxQODVoN2NE?=
 =?utf-8?Q?GHfxve7plM3v2Qv5TXX76bhNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a730baa-4a12-4f63-42d7-08dd82fc8ac6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:52:13.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVkUxxIN2OWwAIixzoSlOQO8zIAaVDlA2V3fzzHbFLWHUJxdVwyh076A5DtvvARWtLYDb8fjxk5OEDG0EYAMNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

On 23-Apr-25 12:17 PM, Luo Gengkun wrote:
> Perf doesn't work at perf stat for hardware events:
> 
>  $perf stat -- sleep 1
>  Performance counter stats for 'sleep 1':
>              16.44 msec task-clock                       #    0.016 CPUs utilized
>                  2      context-switches                 #  121.691 /sec
>                  0      cpu-migrations                   #    0.000 /sec
>                 54      page-faults                      #    3.286 K/sec
>    <not supported>	cycles
>    <not supported>	instructions
>    <not supported>	branches
>    <not supported>	branch-misses

Wondering if it is worth to add this in perf test. Something like
below?

--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -16,6 +16,24 @@ test_default_stat() {
   echo "Basic stat command test [Success]"
 }
 
+test_stat_count() {
+  echo "stat count test"
+
+  if ! perf list | grep -q "cpu-cycles OR cycles"
+  then
+    echo "stat count test [Skipped cpu-cycles event missing]"
+    return
+  fi
+
+  if perf stat -e cycles true 2>&1 | grep -E -q "<not supported>"
+  then
+    echo "stat count test [Failed]"
+    err=1
+    return
+  fi
+  echo "stat count test [Success]"
+}
+
 test_stat_record_report() {
   echo "stat record and report test"
   if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
@@ -201,6 +219,7 @@ test_hybrid() {
 }
 
 test_default_stat
+test_stat_count
 test_stat_record_report
 test_stat_record_script
 test_stat_repeat_weak_groups
---

Thanks,
Ravi
