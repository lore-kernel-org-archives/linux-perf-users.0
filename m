Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11B31A8F;
	Thu,  6 Jun 2024 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652073; cv=fail; b=PyNSI6nl/ILeQ+90mYxEWIF+UxjRMf9ERjii1DLDC6eirEvlLMkTAhJh1Ubn/ZxlXtmhNgGTVyqJtdAoVjlYa3QbrJdyE6Yz8q34OKONnAqtf/zKFSqXxofH7lHcqQVBX84D4yKfrIH+O2oBB5+Bhucbjr6frLClcY2jQENvpNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652073; c=relaxed/simple;
	bh=V7qqtyuAJRZ0sSN1GWZXXnNySgYJEMwQXp6dtuzi5+c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGibiPj/CAV8N2JZ/w/wZQRhnrPyRSgtLKgq0WD2GA7GCgUXbFiqIstxzbmWdorQXCwShsSEhlHIs7nO/bPSbEnFvxa07BK8mabcgN0GBThDN7ldFyN7J8JFuHp+keiFzLq3CGh35oivvrLR4RZdAeEdwQ07CLTaIjN3gz5Fb0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gTVyYHZS; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gTVyYHZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcESUna152Uduf1dGxl+pUUEgfeXFtZKhYDusxYi3ddendHrXdr7QMEFobqDRcKGhgO+CRqXvdwZ08xhk/7L+aafDMzSa7p1aBZXtR9qDuY07n8ZzkQejSmdUiPkImmEXkm6OZFkzJz5/5VbRmB8jflUsfCzhBUNviKr18ll/o2uBOcxphCyD8I6+PjPj7B1YTmBRKmP3ffjCLjUmoukWS0MyL8y5a+mqDPxzF8ZID8sHuV9Gpe0P7wBjWZLrweEUKkFxAoehIYREE0OKsTPExMzyBz6FXSQzxFN7CjhXItxXWe6KqB6/F1mGCSYCrPfWD5Y1LmVJY2UElpTCHa2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYDH5GjGle48xuqMZ6caFI147Kry2K5PoVtqlk92FlM=;
 b=JfZ+U0PLVaZ4Yv2Cn5M2UnUnpW/MzXLfHwBGgB6ybhdVd6TwOaKgmf+/zsIsfYWoLaKyR/2RiJo8DPPpIzlvgSnNqFvUyt7o0wUidg1ZAH5P3521ioXKJH02/9bBhOxb7HNR0qRYpDSz+y6uJ8hk8IVgaJhxRAyvlbv30zocSUOE1yEYbcIlhHM+8xb/2ZAsUrduB4a7iV7Bde3BKDqqZ3Are/qYaiBRLvpSFmN5Mb8dufFkGTJOrZLQCoeON6YaHE9RfJ3p9ZdD89EdfPXpeUdqREtwF61fueZiviqfi7lEJtPIQ7fVEDZBWPIs8xAIvsDtqe/W0/1CAQZLaUS+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYDH5GjGle48xuqMZ6caFI147Kry2K5PoVtqlk92FlM=;
 b=gTVyYHZSpLOdFtMrqQZ4lIJijJ7wp+vemJE3KRdxZ/7PgaN8vR3p4mFV9tOPKUfr4r67Tkj9xscCnT4+SE/411YKzLKvPcOLoBynio//SX/dGW19IC3tV+qehV4ECn6EwE3op1xYn0hIEDyC1nbPn90lV6Cl//SbRRNvBDUgelE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 05:34:25 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 05:34:25 +0000
Message-ID: <79562882-7cf7-4d85-9072-d655d2828534@amd.com>
Date: Thu, 6 Jun 2024 11:04:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Warn only on new bits set
To: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: leit@meta.com, "Paul E . McKenney" <paulmck@kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
References: <20240524141021.3889002-1-leitao@debian.org>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20240524141021.3889002-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: adf0b7d5-e350-4074-9bcb-08dc85ea5394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3RuN0Y5VWd4ZTdaZ2o5MTRnN1YzTlN2UFBndUI2SXJFbENsVHl0L09rSmx0?=
 =?utf-8?B?L3Q5bWJrcUpUbCtFdTBXQk83anRGcHc0NlMvUWphcjljTmROSjcxVjFqd0N0?=
 =?utf-8?B?TURwN2ZMVEVqSXVqdm1sdm1lYzk1UDVsd3kvVTdRRXRFSjRwY0RITUxuQUdk?=
 =?utf-8?B?c01hMXhXK01qVEVJZS9mQUpQZFhmMk5SQU8zRTZjV2dGZ1ZYK2RpOEZvWTZ2?=
 =?utf-8?B?Y25sQnI2aDVaQmFkZCs1SUk2MU1NWU1pYzVJMUxuaTFYMFMrM1dvN1RuNXM5?=
 =?utf-8?B?RWZWeXkwNmNBc3d0UktjMUVlTVdOTW55WGpwdnlwb2o4OWoxK3JySTBKNXph?=
 =?utf-8?B?d0JpWGZsQk1NZ2RGZnFIYlRPUFYzYW1CcTVrazBzQzdhRTYrWDdkdnFQWWdV?=
 =?utf-8?B?RTFCMCtXcDVQL1QrK3Yva1l0TU93SzBFcitrYjV0blJyb2pZUVZYdHRiUy9t?=
 =?utf-8?B?emU0QlhjWjF1aEMxTzB6TXlNYmNsMm13eUgvekExZVJmcm1tYzhOaXFzQWtX?=
 =?utf-8?B?elJnWEFFT0RtWGhOditOWk1iRnFjTmhJNk1SUVdqQnRHeXBSZVZWNVhqb0l2?=
 =?utf-8?B?M2hpYWhobjMzSEw5RTNmTTZvaDMwZytmZnZoWU51a1lQQk5hNjNQbGFSSHZY?=
 =?utf-8?B?VHY4MXNPQmlJZzdSMkRMc1JyZTJjTW9VL2ZFSnFHVlJRMWx1cTZlSzJyd3dl?=
 =?utf-8?B?cEFWTWtlVElPWEFrRzYzVHI2M1lDYkF5TXRwU0RhWWcwNHFCSXFia3NnQ29Y?=
 =?utf-8?B?ZjhNMTRJclZVU1VmaVlwa1cyODltaVB3RE51MG13VkRVMVJvM0Nzc0RTUkYy?=
 =?utf-8?B?ZGk0NVZSY0h3cG13TEtnU3pQSXJ1RjQ5aHZRZ3ZZelNESjlOaGVYZUtIUng0?=
 =?utf-8?B?WlI4cVFIYmZ4SElvcTVIaG90UCtWOVJtTHlPZzc5b0RzS3RJSFEvbWVJYkN5?=
 =?utf-8?B?MXcyVG9sd2V1akluTk5QSGZEMnpiY0xPS0d1dDB3TWlxSHRaNmprVXR6N2g0?=
 =?utf-8?B?TG9rZ2Nic1I2RG9sK1BOamRuUEkwUEpiTzRvbUNtY2tjblBIZ1ZyaTcwK3V2?=
 =?utf-8?B?SmVOZ3ovV1RLaVlocXVJQUVpT2JhanlIMjJFQUlMRlpiUU9GSHNrL3FMUHQ3?=
 =?utf-8?B?MXdkdkxWMW85L1U5aXZ0OGkzemVBRzFLK2VyQk5yamZoNkxpSWhIOEJBWW9B?=
 =?utf-8?B?ZGdydUswT0NmR0ZtMWE3STRCekpLcnJRRHRrWjhrMkN4WGZ6YlZIU3J2eU5S?=
 =?utf-8?B?ckJuM3dZTFNqNXZVU0taZ2FQUFljMTFKK084eWRxMkJqSW9TNk5vUHRUOHpa?=
 =?utf-8?B?b3ZWZ0I0bXBnREl2NkxwaGh0VU5JYnBTQ20xVjREYkNTMThaUmxUWHNadnc1?=
 =?utf-8?B?dGdHS2FTWmVOTVF5Y1F2NzhwQnhTaXhCVVVwalJYclBzNG1tK3lrRjE3aFpQ?=
 =?utf-8?B?SlQ4NjgwVFpQWVMwQmp6OVM5RkgycWNjSXZLejRVZERiMjl1WGRSSjFaZFkw?=
 =?utf-8?B?dEIrdFYrNW9JODRaN3ZlUnFPL2hQYmNXRXR0RmpmcEhmMVZpMVFhVEc1RnQ5?=
 =?utf-8?B?cHg1Zmg0eDVGNEp1L1lUYVAyVHdBSitEcWlBcFl6ZHNWdEVUUEFXWmdqaVBo?=
 =?utf-8?B?d0x6bUhDSHdIcmNGc1dubjMzTnNkdnA5MHdWTmU5alNKWWxBakR0bXBUZER2?=
 =?utf-8?B?Tit3OS9hRWY4NTJzSGxKQlBQWkhBTGFXQTdQVlkxbUpJb1dEckwwb0tadHNZ?=
 =?utf-8?B?WGZPYlhGRWlPc3lGMlROQ3BkRnNYSU8ydUdaTWFIWkhKVlZ3N1Nyd21rUE5S?=
 =?utf-8?Q?LilDj/TREsemNv14rOI+N65CWgaccAyxr/TwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkhpMitZRkdWN291ZlhMTGIxdlUzYUh2NEJnRzRNbFJRVHdsRzNCTlVNcFNs?=
 =?utf-8?B?N21JRlJjYkJtay9QV0J5N3hBaGNzVjdDakwvR3ZJK3hDL1ZrVmdoUW00bDZz?=
 =?utf-8?B?Q3pqMy9qcjdUd0dBT0NqOC83aSsxMkZPOHZVb1l1QzU2czVrTG82UVB2REUx?=
 =?utf-8?B?RjZCQ21SaXpRdDVIV0g2L1JmaEJPWFNSMldURHRNSHMrQTFLTFZvdGl6d25w?=
 =?utf-8?B?WHVZeGo4L0d2SFJyN3prR0dRZDc1OHNGSXZ4QVFwSngzZG5YeWxPZ05ZdXIx?=
 =?utf-8?B?L0xkUkpzanYzcmN0T2hTMEpKZTRWa3NObU4xcnpiN0NtUittZ0FCT2c1cEl3?=
 =?utf-8?B?OEdpbVA3QUVJMjhtczBXN1N0Z3JiV1VWUk5YeFRDQjEvNU5KcUR1bDdBNGYx?=
 =?utf-8?B?Z3dYMXNWL3M4VnhCVWpiQUp5T2lwVzJSQmN2OUZTaVVIaTBBQTNBK1VLTWZn?=
 =?utf-8?B?S3hObTZVQUlhYTlkcjJvSFpnaldLamozaWF4aENYOGVXZ0VBRXJKVDB0RWVp?=
 =?utf-8?B?cncydERpTUJYZCtEZTZRTGJZcEFwbEpieFJyVjRnZmVIWlVIQ0lSMzVLQ1pI?=
 =?utf-8?B?QWtaNlcrRzFzdFVvMTJMbkVSZWl5Y1c3QVZtemh5Y2ZaUXdYRnYwWitFeDEy?=
 =?utf-8?B?RHh3eThadzZBdXpvdGNlQkVFa3dlTGJScWlaSFZOSmNEbmp6VzMyc0RobUxL?=
 =?utf-8?B?RGpLVit3TU9lQi9vZ3pDZFMzTHRsNzE1RnkwWGZoeXRJRzdSd3dEMVJ0ODB2?=
 =?utf-8?B?bVUzNmI1RGhlNThJODdrUmFlS1lTS2JJNnM4QmZkOEVmMWZ0bGk0MmxCRjlR?=
 =?utf-8?B?dXgxUUM2VzhEOUV0K1A5NENkTHN2VFBWQlY0RWcweWt6RzJzcTgvNmdFc2ov?=
 =?utf-8?B?cExMcjNTOVh1UVlMbG8rR1V2UXh1czc5S0ZkOHVpZWtWRzdnQ244czV1eDNN?=
 =?utf-8?B?a0lsbFpaY0R3WDBXNUVwRzhVRHMra1QzVDFObTFQQ0FLdEc0Ynlsb0o2UEI0?=
 =?utf-8?B?NTE4ZDhCNFRsVzlXOWVqejF5WVR3M2RnNmsxeGk1NFlqdG9vZUMrSWloSkF3?=
 =?utf-8?B?MHhHVE5uTk0xOFBkSDB0b0oxUHl4TUhic01kcmNKaU40K2pkWVhYT1VkUFhS?=
 =?utf-8?B?d2E2NGwvd3lRWXFsVytSRFlrQmZObEZrenZMWTdVc0dESmkrSkl5em9SZmIr?=
 =?utf-8?B?WGJ6UGhRQVZvVlhpeHJDRFk1eHN3UzZFdFBCTmh5TE0zckcvTE5YTjFObXpG?=
 =?utf-8?B?VkxSUmFSVUtoMHRHWFFlZVZCazVzVnBHS0cyWENhVTgwbGpEUUVyR3hjVmwz?=
 =?utf-8?B?R0Jjd0VTUFBVaEhXaDdPQnIvczRZUU5tdmVOVW1xV0hGdFM2aDQxb1NjSGFU?=
 =?utf-8?B?bDhoYUNhVkt3MytOMXBHT0w5QkN5QzFzOWFPQlIvZC94Y3VjZlJBdUJ3Z1Ix?=
 =?utf-8?B?ZU5XVWFQcFJZRW1NdE95WHJuVWM3R3BQWUpJeHpzeUV5L3lMVFFvY2pGRHJK?=
 =?utf-8?B?dWoxa3BPUkI0SEozbjZvTWdWeHVJb3VoWnJHN1VUdGxXbjNlWjd2SmY3Y1Vv?=
 =?utf-8?B?aDNmVkhKbzBWMTNka2pNMTdxYlJ3ZnRWQ1haVW9iSnRBalV0MFR0WER1Y0pz?=
 =?utf-8?B?UFRmcE1tNS90WEpSbnJDcHJXOHBCK0JrMWpTdU02WjBCT05hbi9vWld2dnlp?=
 =?utf-8?B?QUE2cXhJbm1tL1dvK1lxbXp6bFBTck1EdkJGdm11MnJORE1RQ3B6SnVEKzVu?=
 =?utf-8?B?WFFodU16Y1BFL3hhNi94bC9BWUJpRlpQNjQxa0FsVkhaNC9PdmE0Snl4ZTEy?=
 =?utf-8?B?WTVrUEdtM0Z1RTExM013ZWhNV3NzUDZJVVpnYVFvVFFrNlVXcUY0aGhHR1dH?=
 =?utf-8?B?NS9UT0JzS3ZEd1p1cXVEV1Z6K0NlUmY4U0Evd1Q3WTVqZ2wrNmNteEQ4Mkdk?=
 =?utf-8?B?cnE2UllGZGc5ZnU1bExLdXI4OXdkZ1BqNDVORGdteUdJZWd1a0ZJeXJ5bVR5?=
 =?utf-8?B?NUhQTlFLWkFGZVhKTEgxbG9VbFNlTTcvVVA3bW5uM2hsQkRkR1NTREdybWFV?=
 =?utf-8?B?WE9BaloxMm9oNzE1bHk4TEhNL3FHd3JhUVBJVHljdkFNSjFPMkFFZXlDL1cv?=
 =?utf-8?Q?e+IV5ndQcpeaSOWGe5xXCilPU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf0b7d5-e350-4074-9bcb-08dc85ea5394
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 05:34:25.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDr/XnaMAI1vKnDXG/zuXrAyxe6S/zGux4usIejP4CGZQojaGamDw7gabOwi1RZL6+g09fzB1wE1e2ZusBcL8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 5/24/2024 7:40 PM, Breno Leitao wrote:
> Warning at every leaking bits can cause a flood of message, triggering
> vairous stall-warning mechanisms to fire, including CSD locks, which
> makes the machine to be unusable.
> 
> Track the bits that are being leaked, and only warn when a new bit is
> set.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

> ---
>  arch/x86/events/amd/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 1fc4ce44e743..df0ba2382d13 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -941,11 +941,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	static atomic64_t status_warned = ATOMIC64_INIT(0);
> +	u64 reserved, status, mask, new_bits;
>  	struct perf_sample_data data;
>  	struct hw_perf_event *hwc;
>  	struct perf_event *event;
>  	int handled = 0, idx;
> -	u64 reserved, status, mask;
>  	bool pmu_enabled;
>  
>  	/*
> @@ -1010,7 +1011,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  	 * the corresponding PMCs are expected to be inactive according to the
>  	 * active_mask
>  	 */
> -	WARN_ON(status > 0);
> +	if (status > 0) {
> +		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);
> +		// A new bit was set for the very first time.
> +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> +	}
>  
>  	/* Clear overflow and freeze bits */
>  	amd_pmu_ack_global_status(~status);

