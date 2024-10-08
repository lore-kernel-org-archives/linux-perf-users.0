Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CB152532;
	Tue,  8 Oct 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369846; cv=fail; b=a1G38ljSdwhh3XpKtBHpfCXGtBGXDishYdv4cmzmJ2prXhSBfJu0j+bjfTNfhaRDTvwe7CCUJ2/U6YOoivlB3sJWsWmX3U5uk0pl69Yp1K4apbrf57FqQXDhsDAhwkc01MiccuKHcXitWFgR+huNlFdJ0IS7FomxnTb20ficG2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369846; c=relaxed/simple;
	bh=VfQ0RjF/1R8L/YZGunNbpJCMeHIhdX8hqzWUpL+iYL4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZybmENJYoCoob2aJST/LWnwEJzWA8lTv4ufpuBrCTbDuGOfjEIOd/jpk92JpwQJrtR6muPR6Lw0uGHaAgwWz5qBD71BCbapp7bi2P9cfUvSZnaA109sase20zJ4hdB+z1nawJ2EBhp08x+sMd8Ud3oPc1zS7nXJiSVm9F2E2+hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eQJj6Nec; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eQJj6Nec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on6g37bLtn5lSo34RF4sZOZxeqNQQ9va9UNz6wN6MEDM2eTyZM3uUlcHYfrSTZ9urSMNHwG3xA3+xS39ptpashkZ3wqIUFIT2f3Y2JSxjlWGt7G40uBA1b4Ld9GXV///+DCkio0p1ofWnTfoI9H/2uqONw59QdIvour9603xh5X9yc6j5Z43qSlWckgNTH7lqfOr9E5kcyDEOzkAtULrJJhUdAvrXD69IRRUDlcXS12kqs2PPnwVVWwDqpyx10eDUHTlz4QR0dGprWY0fjDHP2k/rzHSPbLGOySwYNbPRkcpL2YcXF8smAXfBo6YuGHrHymw0NHOmY3gAi4OpErTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTL2HfkUy+Zw/55if8MuP+KlZr8qYw7eGR8tMG+yKaM=;
 b=cdjdFuGs/wpVIZB0S7H10fBxPKCr3/6RknDMcn4ynl7oCQP0u58YVgtbF8raD66BvEdYc+XwLegBIuinMv+LIBuWgyXIdVPYu3Rbnokj6GobMSGMz4Hi7mGVFtxEngdlrfk9Unlu6l49eN5NW0+sSs/9ASk1/8zaIOYvY/WWoRP9De3E2KVMqALBClEX80fYnyf65rQ7TxXCJS+gKyo68qbxDwMQveRkCcIihE4VFBrBZuIrbusBCQuLa0XcEEukN56jxE+sLJFAcqMP+czMJoWgIRPE8A+pZhWrffOIqT8PxM8aQbrKmuvk761yRq2qxnzFoGsTCBxscs9D+PFBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTL2HfkUy+Zw/55if8MuP+KlZr8qYw7eGR8tMG+yKaM=;
 b=eQJj6NecpYtbljbsE73J4zlFGIRwYfHzfAvYtcngK+aeOlrl3qTp9+XOYzHQ78inEg4qEotfvLFzpRc/llB8ryRl1f9ITkkNx0RYqjmuxYFA4U4dfOnpUv32DOxr4frjl6oshHKk6zVRkOn7rZoddSrxnJa3mE54jsULuTmnhxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 06:44:01 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 06:43:59 +0000
Message-ID: <6d3b54a4-1c25-4737-8719-a2697ae64559@amd.com>
Date: Tue, 8 Oct 2024 12:13:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD
 CPUs
To: "Zhang, Rui" <rui.zhang@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "irogers@google.com" <irogers@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "bp@alien8.de" <bp@alien8.de>, "acme@kernel.org" <acme@kernel.org>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 "jolsa@kernel.org" <jolsa@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "namhyung@kernel.org" <namhyung@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <76b67e939f58c3f4665c779bb867a03973796650.camel@intel.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <76b67e939f58c3f4665c779bb867a03973796650.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::13) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: d87763df-4b7e-4e59-176b-08dce764967e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDZEaHFpR0JadDB1YUlwRS9HUW1ZRDhWVVluV2YzNHkwUmM0MVhiN0NBeU4x?=
 =?utf-8?B?bnE4Wm5aWVFDV3FYWmZwRElIR2VaSDFTSFlXelU5R0ZIZkVQQit6MzAyYzhk?=
 =?utf-8?B?TFhaQ3pTTDJqTk5CWElZdjVkS3FmZnpEMHVvb1A5YnJUUG42RWRRRWFjRy9r?=
 =?utf-8?B?TzlnbXhkZWJacUo3SW8wYjJWdEZsWnhrM3NmNGx0K1VUSlIvNXAzeStQajFl?=
 =?utf-8?B?YWZRa1BXTjU1ZmdnWXIwdVQxNU8xbDFTNko2aW1Rek1KV29OaExTZ3d6TFVO?=
 =?utf-8?B?c1Rvc3F6NDJxQ0RaVUhXZzN5ckdobjJYdm9mVURzdUhTQmhGM3BoU29xU3FT?=
 =?utf-8?B?c0hjV0YwcllLMjNzdVNqcXo0cmljaWdLSVFOaU9KZGwwS0xGQ1BXc1IrQ1ZR?=
 =?utf-8?B?SlZuUG80STcvaUdjUFRZSWt4ZytQREpnOFVwVmIwUFFFSVplcnNzYkJEQTQ5?=
 =?utf-8?B?d2YyZC9FSVNweHhDT2cyaEJtMFJlY3BQY2RPUjQyM1RpMnllVWZIaHphUHA5?=
 =?utf-8?B?cytQUzNTWGdma3Y0aG1KRjBvOUVKNllXYlpydEVXNjZJQlI5V0NFQzNnMXVp?=
 =?utf-8?B?cW9EV0FFek5tRVMxU2ZVYnlVOHcxdTFXZGNEMzgvTHF6clZ3Yi9Yb1hEVWVu?=
 =?utf-8?B?WkN6Y1p6MlM4MUpKR2lKTGFtdzk2eXcvR3RYTE94M3drL0lvY0FNaENhb2M4?=
 =?utf-8?B?NDByTzZYUUQ0MXRINmtxbVlqdzNpV21qUjVyU21vcGhYUURSQkt4aEFaYTJO?=
 =?utf-8?B?Z2RhK1pMYStKMHlwTVZKTWJXV0dnaWFKdFNEM1JrS0svS3dMZFQ0b0JCUGR5?=
 =?utf-8?B?SVBra05uQ09Za3lraHEwTDh4c1lvVHl0NDhHN2ZTN0hUckw1T0dvdjNialh3?=
 =?utf-8?B?RUlOb2JMV0pkQ3FpTnlnQm1IZThSYndrSUROak5xbVBTNmhKbDBDZTE5RUtR?=
 =?utf-8?B?bUx5b2ZUTjFmOXBuNXoraGtsb0NtY3FzOUs3ekMxN2ZCQTJzc1hoRUJ3eXAy?=
 =?utf-8?B?TXhaVTZobjhiUmdMRjZwVldnN2RzU0RSNUhQWE1uR2xjZ3hlSmkzMGZGVHdR?=
 =?utf-8?B?VDI4OE1JR1h6SFNSWDQ4b2hCRjAvenhIME9lbjVQRHBNOFJ4Q3AyeXU2Nkpk?=
 =?utf-8?B?VlBDWVRuTXZ6QUppSGtSWnU1L3ZKbDRwQjNveldmeHlSZHhiK2QrdUR5L2g2?=
 =?utf-8?B?cmlDeU1BdzlzWWpHdTNQRTNBMDFIQzBLL0pYTTlDN1F2Z25vUndGYjY3T1ZN?=
 =?utf-8?B?YVJaS01KSU9VV3VmL05OZTlYbWpjZFQyZVN1T1ZTMXVWbk9wTFViNnA0SUpN?=
 =?utf-8?B?akVaQ1hmcDNLSDlyS1dNbXovZy9wdWRQYzhqZGVkNlpPYklsTFBIWmVZWTc3?=
 =?utf-8?B?bXlvQzNTUGVGa1pPZFM2NkJnc1dmL09ydEpTclJnNy9mM0ZXZ0ZLV0lxNC82?=
 =?utf-8?B?d0prYUxEdGxIMmg4YmY5ZlN4a0dkbGlLM1d2bXZnNzMwK1NoVEZZdzBFY2hG?=
 =?utf-8?B?eE10Rnl1T3l4VFhoM3hUdGhSRWtMSFVZaTU4Q3hkSU1KMDVSbVZBT0ZyeFM4?=
 =?utf-8?B?MTc3MkJUT1FpYzVFSk9rVW1wWEZkMDJpd1JPaWlCRGFxeDVhMlh4QmRON0Vh?=
 =?utf-8?B?bmhuRGlpbk9YbHpDNCtlZUN4akMydXVCV2UvUE1lZkYvTjNSQkRNUGh1eUxz?=
 =?utf-8?B?bDJlTHkwQjZMQ2RWN09KZUxqVk1ldTN0TG5MR0NLanNPeDlGL2Y3VzdzVzFp?=
 =?utf-8?B?VHdkSllxME5DWUJqUzNkM0pMMTc3bGcxSzRSVkZCUkFFdEpPL25zdFY0TWJv?=
 =?utf-8?B?UXhaKzFDVDdsaVh0T3E3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXR5RHlNYU9wQUYvSnNhUW1WcEdHczZVRDBhL2NnZ1JkbXgyVzAvamRSWW5G?=
 =?utf-8?B?amFDK2FTRERzN2VJV2dBTjl5TlFhRUdVNTB1TGJsb1dkR2xDZWpmSGE3czc5?=
 =?utf-8?B?WnlJNk5lMFFaR2J5TjVzK0thWExJYnIzaTFib0J6Tm9ma3F1dXRNMzVKWTZL?=
 =?utf-8?B?cDFSdUNjcStPNnc5dVNjWCtZMTZkaCtUWDhGc3NYK3Fzd3NyQXlIRVRkMHBR?=
 =?utf-8?B?eERZS2RTWmNWOVZ0cm10SC9aeEYvUlU4QTM4Mjlmc3YxTVE3MUI2NHFrdGFt?=
 =?utf-8?B?S3dpVmlCRkVzZXlXRWdLN3plaGlFQURaYzNDQUMrUVZSN2hTWEtUbWU2Mm5S?=
 =?utf-8?B?eXI1YS9icERZQm1FMFphekFOclpxM3JZNUZ3Q0ZkQWlqckcrb2ZvcjJHKzhD?=
 =?utf-8?B?VkUrTVUzTjdNcytSMWMxZU5MalZjajh1eFg5b3NMKzdONlFMVWQvNHlZVlBY?=
 =?utf-8?B?b1llQkdzNEJteENrbHRiM2xXSkx2MlE4eHp3bVp2QnRsSDdCWkxCOEFaVmZn?=
 =?utf-8?B?a0JjZ1BKaEV3T0xleWlLaDAxU0R5TFlLSjd3SXBDMzZ6L2c4YnUxUnpHd1Zp?=
 =?utf-8?B?aWZvYmxNWmtSTnlUbUZoQ011azRqdjdkWVVSRmFnNUEveHNHUzlZVHJUVUJt?=
 =?utf-8?B?T0FoMjlrbjBpNUxuSHZvN1BPTlhYTGovTTBpR1ZCOVhFMTdRcmN6REtzSGhY?=
 =?utf-8?B?RGFVWER2Z3orRTNDN3ZSVzE5N3ZlaEcwclZoaFpHeVFTdHpmcWZsRUNiY1A5?=
 =?utf-8?B?bmZuTmtrdis3aER2aWwyTTVoQVFycDYxVEJ3WVZVN2lLOHQ2ZFlBTXB2MFhu?=
 =?utf-8?B?Q1RHSFRNUGI3YWRmRDZ5RmpoWUNiR3hRMkJpZDQ1VzlnaDZhMEVldnNBU29M?=
 =?utf-8?B?d1ZvdzFpQUFDOFNtTUovSGtBWjJ6N3QyVDhrRy9ZWStpSy9VMW8yVmorQ0VB?=
 =?utf-8?B?ekJFMDRaMHdtTElSdFZ3MDFuOFRuKzdsVHBra3hFRFlpYXgzcW8wQlpuajR3?=
 =?utf-8?B?NHBWaDBVLzB5T1JHRmRDeHEzMDFFMHpGTTFsdnRLb2VERFZHWVpLcFIxM1FT?=
 =?utf-8?B?TWxibkJUVUdBVVJlcW41WkhHVWFycjh3L2J1RjFQVnpxeDJzRGVJWnpWaEpN?=
 =?utf-8?B?MndhWWNOcXRNMzlZY29mTEdvS0lIaTIxWXl5UG0rWDhueW5IZi94UzRhRHFE?=
 =?utf-8?B?YnJvcWFGcmQ4M0Z2RTF4K1l6TytNbmtncUJOZzhERWVHQUVXaDBqN0x3cnJB?=
 =?utf-8?B?UzVTUUtzN3lobS9VcklDQUcrdlYzSDBuMythSEh6L1gzTTZXalNxTm1DVGk3?=
 =?utf-8?B?eDU4bGhBSUF1OTc4SVdLSTNXdGFaTE1HQ0Q0WXhuSG92Tk85S3UzRVB1TlV1?=
 =?utf-8?B?RnJibWV2MXE3bVFrOW9XZVVjVEZhaDJlZzdyQ0U4UkNqQzI3QWU0NVVBby9H?=
 =?utf-8?B?R2VoZmdjeDVwK3pYWG5iVEE5bWkxOEluWTJYdGc4eXYxRm5HQ3A2S3p6ajB4?=
 =?utf-8?B?bUxUNnJyckQ4ZDBoMHhWVGFlek1UY0NNL2VMQzcydndVNXZ1TWYzc05rWEpx?=
 =?utf-8?B?SW5NdERCc01vWHZBU0lQMTJ6Ty90N2FLSW84UllVeVNQb0p4L0E1TU9KNXB4?=
 =?utf-8?B?OERmV3o3MkJQQ2FGM1g4K0g0YXB5Q2F1MlYxRkFGV2cwR3YrOUJ1NGpKVjBV?=
 =?utf-8?B?dDlTL2ZhR2VQUUZlMWxJeFlTYTZZdy9zTXNQTHdyZkdmb1NaZEE0cWVBSzRS?=
 =?utf-8?B?SmN6dlFpWHVCWUZ6YUh4c3lFK0RFTUlDMGIzK04vMi8weWUzZGdNOW5Zd0h5?=
 =?utf-8?B?RGh6RnFXa202THBuWTNGQVVpT0RvYmlsZ1NBUENWQmF2NXJhYUl0dytLbktB?=
 =?utf-8?B?bmVhSU1OUVRDek1HckRzQUoxdnZ5aGk2cU9BbGZkWTg2cFUxTHpOZ0IvU1ZS?=
 =?utf-8?B?V1pVdjZLcWhyQllySyt6SXN1YldWSi9VWTBzV2ZEYVpFS1NRUXZsM0UvOVNV?=
 =?utf-8?B?bmZUQjQyQW1hWGNGZzFtblQ0TS9lcFF4bmNEa0VpdG10U0tsRm9EN0Y5b210?=
 =?utf-8?B?SmROVm9FWVZXNEgrVE8wenNRakFxQ1hiYmRtOTV6alVnYUU1ci9PVlhrNG0w?=
 =?utf-8?Q?BdaDN3UCnEy3MdDWYlwI1v9XY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87763df-4b7e-4e59-176b-08dce764967e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 06:43:59.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk1o6E8ZrKBE5EMaEaGkEmAUCRqpK1tcYBh0qvkbq0Z3p1ze0Oo08TRpY37/mzuOOQvxJNDO1KLZDD8ovwwlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865

Hello Rui,

On 10/8/2024 11:38 AM, Zhang, Rui wrote:
> On Fri, 2024-09-13 at 15:21 +0000, Dhananjay Ugwekar wrote:
>> Currently the energy-cores event in the power PMU aggregates energy
>> consumption data at a package level. On the other hand the core
>> energy
>> RAPL counter in AMD CPUs has a core scope (which means the energy 
>> consumption is recorded separately for each core). Earlier efforts to
>> add
>> the core event in the power PMU had failed [1], due to the difference
>> in 
>> the scope of these two events. Hence, there is a need for a new core
>> scope
>> PMU.
>>
>> This patchset adds a new "power_per_core" PMU alongside the existing
>> "power" PMU, which will be responsible for collecting the new
>> "energy-per-core" event.
>>
>> Tested the package level and core level PMU counters with workloads
>> pinned to different CPUs.
>>
>> Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa 
>> machine:
>>
>> $ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep
>> 1
>>
>>  Performance counter stats for 'system wide':
>>
>> S0-D0-C0         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C1         1          5.72 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C2         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C3         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C4         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C5         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C6         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C7         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C8         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C9         1          0.02 Joules power_per_core/energy-per-
>> core/
>> S0-D0-C10        1          0.02 Joules power_per_core/energy-per-
>> core/
>>
>> v4 Link:
>> https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/
>>
>> v5 changes:
>> * Rebase on top of Kan Liang's "PMU scope" patchset [2]
>> * rapl_cntr_mask moved to rapl_pmus struct in patch 8
>> * Patch 1 from v4 is merged separately, so removed from this series
>> * Add an extra argument "scope" in patch 5 to the init functions
>> * Add an new patch 2, which removes the cpu_to_rapl_pmu() function
>>
>> Base: tip/perf/core(currently has just 1-5 patches from [2]) + patch
>> 6 from [2] + 
>>       diff [3] + patch 7 from [2] + revert [4] + apply [5] 
>>
> 
> The patch LGTM. But they don't apply to latest upstream because
> https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugwekar@amd.com/
> and the upstream version diverges.
> 
> will you rebase your patches so that I can give them a try on my Intel
> testbox?

Thanks for taking a look. 
Yes, I will be rebasing on top of upstream and posting v6, mostly by monday.

Regards,
Dhananjay

> 
> thanks,
> rui
> 
>> [1]:
>> https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
>> [2]:
>> https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
>> [3]:
>> https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com/
>> [4]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/core&id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
>> [5]:
>> https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugwekar@amd.com/
>>
>> Dhananjay Ugwekar (8):
>>   perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
>>   perf/x86/rapl: Rename rapl_pmu variables
>>   perf/x86/rapl: Make rapl_model struct global
>>   perf/x86/rapl: Add arguments to the cleanup and init functions
>>   perf/x86/rapl: Modify the generic variable names to *_pkg*
>>   perf/x86/rapl: Remove the global variable rapl_msrs
>>   perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>>   perf/x86/rapl: Add per-core energy counter support for AMD CPUs
>>
>> K Prateek Nayak (1):
>>   x86/topology: Introduce topology_logical_core_id()
>>
>>  Documentation/arch/x86/topology.rst   |   4 +
>>  arch/x86/events/rapl.c                | 406 ++++++++++++++++--------
>> --
>>  arch/x86/include/asm/processor.h      |   1 +
>>  arch/x86/include/asm/topology.h       |   1 +
>>  arch/x86/kernel/cpu/debugfs.c         |   1 +
>>  arch/x86/kernel/cpu/topology_common.c |   1 +
>>  6 files changed, 266 insertions(+), 148 deletions(-)
>>
> 
