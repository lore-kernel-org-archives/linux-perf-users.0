Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020110.outbound.protection.outlook.com [52.101.193.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195D74E09
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577825; cv=fail; b=UDiemcR65wg6ImQg0rvDH5MFK5+I0EMlXj4fPbnkg2E2/k7vh32bM4bUVuzrPQpR4OTRyparyDAmDcnSmW+j5R8+r1aoglG/lq0bZ5ffOofX4dLW9mbMMuiZuNO7kwuFp4nqVeSKVWsedhmiQikl9HFmyu/GHJDTCilTLGiZnwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577825; c=relaxed/simple;
	bh=nQu3eGOieDsZjjMtPi4s4OiAnSIExsSmYGd7eKeIylI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bfeCaTyFyGOi/adhlFAw95c68tdF1ojQB5xjVhI5Ub9lAnwJnkbhyR3rBdAHk/R8WXnf5kWpvdkWf2wcmeB+uVtXRYK0HVtpwFxdpF09KvRwLBBswysELxVBMMmfoH8Zr6aoKIsNzLcfDSte1e51MKyLge/D1yPJmqFiHuQxJ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nOVQxqD6; arc=fail smtp.client-ip=52.101.193.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nOVQxqD6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKYXG4v674ssnkbOhOTS8y6P3AxSIIgAYQgYmHGQkOc1MV+EEoCHa+WnSpxJBueRaeqNksx0ZHLRwNsfP8Hi3LtbCY5vZkWFGq6Lu2eFOiA9OOhhtK7D7MpcYy+2r2kdq8wc6ke/D3D64OVvNgcy6GB6Iw4ZW02yF9nWaXXeXiCsVkOLKQKXt6uJ8vRH/Ho2pg6LrDyTR28TJbinCg2WtGrSACYsS4YMBHahsqkm1HiHBUKLVf2fwjMvv4np6LUUNE172KH4D0/BvesWNI7FT7E1IdRHwDfVPaJ28Rgl+++MP33oRRutlFNC1oMzcgUR+KXOxwbieGvngkreWigPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6E4yqMn2BfqpxEk0BI6PKJugvDnkzab5X4O98qA+Xo=;
 b=uiRtT2WEPPoFkJPzj84nKMkGVYPoybyuqBA9/xkNFo4wJIBGll4Ss2POqPPdCTWqiHD1LewCaa0dPdRyGMkzc1S4takRzVBO9LY+CoUNlgsjNRIXFgivD/1NWrAka+RzSN8Of+sUo0ttGSqkGd0n8wE5LASErXR8zLMpKC1YGPiBn8MynxJM1Ji0+hd/nZ2MsPenYT0MigqVjnoU83OV5jqh2pRRRqOYWQTSoYMgQWRzmH0eVqXcohJSXEGah5Qa2MIGSZOqUqNFpn4AMwG9McCbDB/ysA2MvcpBNzRMUfLMdtlqqiU8CH9kn2cUskcEaaJlk9PxGZWOyX8hA6QN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6E4yqMn2BfqpxEk0BI6PKJugvDnkzab5X4O98qA+Xo=;
 b=nOVQxqD6y4BITzCuJfCc4X3QTRjxBzJlGfQ8e77mC54FgCD/h0kzKdYqKZ6Bbtm7vpObLou79d09U4I5Y+ylx2AKYG4tZyLeRJOs8s+SGCHXIv70T/xspL8uHnB6gpHh50ji3yO7M2l+vd4UDfyJesEMZos/bN3V0+Jd8O06yV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH7PR01MB7653.prod.exchangelabs.com (2603:10b6:510:1d4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Thu, 10 Oct 2024 16:30:10 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.031; Thu, 10 Oct 2024
 16:30:09 +0000
Message-ID: <0b94f480-452e-4316-bbe1-e5b2d46ab6e5@os.amperecomputing.com>
Date: Thu, 10 Oct 2024 09:30:06 -0700
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V8 1/4] Add dso__is_pie call to identify ELF PIE
To: Leo Yan <leo.yan@arm.com>, james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
 <18bb5281c3648a67bff61ce44966d3dfd7c09b4f.1725667397.git.scclevenger@os.amperecomputing.com>
 <e3542d05-9bc3-45f7-98af-73be9db27359@arm.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <e3542d05-9bc3-45f7-98af-73be9db27359@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH7PR01MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3ef638-4b67-4096-77f0-08dce948cea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzlET3BPNU5DZHNMd3lub1ptdjcvV2JFVCtrSlFoVUZFZFQwb29vYytjay9H?=
 =?utf-8?B?K2xrU2RQQ2xWbXR5ZnV4aTdGd1JibDNFd3JNVWJnc29MS1BDM1laWVQyZXRP?=
 =?utf-8?B?R3ZxMkZMVlE2QVZHNFJYRTl4b1ozMXJDRE40RGZZZG4xOExjNnhFS3Q4aHpa?=
 =?utf-8?B?aDd6dkVjQ0VsNFo1R0VLdVYvM05NN2dmam9JZVFpRUJIWUYvd3hpTEZrOE9F?=
 =?utf-8?B?TnViRDZHTlUwNWQwV2U5eDJqVG1aS1poTzJaTXJHSmE2R0gwYWlzaHlvcXBG?=
 =?utf-8?B?WVhzMkFpN3lyRjJndGZEeWlkcm1BcW5XMmlBaU9LTmJ5TEQ1QjU1cGlZZEZl?=
 =?utf-8?B?dlpPZzlnVGVZaXdtL05UWFVSV2ZxaTNUSXlIdk1zbzc1Zm1pc1VVb0tOT0dQ?=
 =?utf-8?B?bkJEekx1ZjVYOEppL0RKWUo3RmlocmozWjE4U0RaTnVTUnlzY2ZoV1l6KzZx?=
 =?utf-8?B?dVErNjUwemc2TDJzM0VqbUp6UnorVDVLcVg5SGpmVi9FMXI1VDFmUVpRYUxu?=
 =?utf-8?B?TnVRQmhvNUZHTE1nSFV5YzFPb0NjRGZhaWlITDlKYURCeEhGUjBWdHNFYW9a?=
 =?utf-8?B?TWVqSjY1QkhBTGtqakQxTTdiaHYwczFDVWFZbzdlZEI2NG94dnd2M3V6Qldq?=
 =?utf-8?B?aUJ6UWxER00zek02VFhUdHgwZzFwMGZISWNvM21senBYWUNBSm1naG1GcDNo?=
 =?utf-8?B?N3h0WlBjVE1Vek5uem1WeGhXM3g0WHQ2bW10SWVGMlFNUlcxam1FaHhxQklI?=
 =?utf-8?B?U1ExOEZkZFU5Y0xPdmlKajFJQ2s1dm5naHIwU0JDcWIvb2g4ekJWOUR5SGpt?=
 =?utf-8?B?UEJBK0lPL0RnMDBXTHRhVDM5OVhnakRRMkFDZ3hsR0d2ZVBvSGJVQ01aZVBz?=
 =?utf-8?B?N3FIemVLMTBpajlBajR2WXlFQkFxTW5LdUNEMFFnVDRUQ0ZVajdjemRXTTFj?=
 =?utf-8?B?N29zeGlXTXY4cmM2UmJwUDdkdjhwYkRGYWxrQWF0VWhMd2dkdzMwUHNneGlr?=
 =?utf-8?B?dlJCdzJWRkNWL3pseXlvMjRUaVYzaVN2Q2EvWjVCMHRwQkZRY1k1cEVkYVBl?=
 =?utf-8?B?NnQzTVNhdzdYcHBPbEN0ZTdHQW9pT0NBZXkxczY3NHNZUXYzb2pYczk2RjZz?=
 =?utf-8?B?cTllZ3BDSVIrN2t6cmR6bkNCN3N0bU9SYW9OcDBkUW9ISW5WSHZVaVFzdGVx?=
 =?utf-8?B?TjJkRG0zdU1TUC9DYXZYcTF6aGN3T1FuK1B0K1hPbkc2SmgzajBBM0Y0TWR2?=
 =?utf-8?B?ajJtMThCVUVmN2ZKM3RpNWREZ1BQdlRMUHRmeDhmZFhTcStjZjE5UWcxemlr?=
 =?utf-8?B?R09UTm5FMXZSbEt1MDZlT2s2d1ZUNTJhTFlHL0pVb091YkVrVURkaGhXMnBl?=
 =?utf-8?B?SzFtK2ErbzN5eXpDVWlCY0lyQjcwTTlNUDlLK2FGM2RiTWRHVGprVjI5aUJZ?=
 =?utf-8?B?cEpXS1BTaUxSSjNLWXZFanExSHJOS3lYejN5c2JpWUgrdGNCb3p0b2J5dVpr?=
 =?utf-8?B?a1ZHU2swSjBjZGVXdGJVRkpYWTZ1YXMzLzRWYTJyekdvVXBPQVRkc0greGp0?=
 =?utf-8?B?dVFnZHVtL3U1NkEvK0h4eXEwMnJXQkZsWnA4bS8zMFZIS2M1MFE1cm4zSmo1?=
 =?utf-8?B?QVBPMFdTRTBJWElHK1crQUNpU2xubmpoMHM5ZnhLNDNpWGZWU3kyd3dVaU1q?=
 =?utf-8?B?TFVJR0NWY2dGZ3FmT2RnM3h6R2hnTnpxcDVkdnlBNEhSL0FCUFR5NTlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkhLcmFSZitiNkRnaytQZ1c2eURGNzE2bVF6MzkxY3BRT1BDWjY0VGZlODdm?=
 =?utf-8?B?Unl2QXFiR3ZjRVU3VnIyTVBmdkFzdXZkOHE0KzlxMDdWQitMR0FyWkZJZW0x?=
 =?utf-8?B?L0VFSk91SHRYWENiVTUzeEJsTUorZUlLaHkyZTBjOGZ4cmNhMzZuSittREZj?=
 =?utf-8?B?SkkyUzhMdDJtQXhybElOZVpuU3dEcjZkaGhKUUVSdGVUSGtRNU4wcS8rbHhm?=
 =?utf-8?B?bFhkOTFsYVphN2g4QStoc3JOZDZlZkx0d29rSmxuOXVINU91cWdKMmNGbDNM?=
 =?utf-8?B?MHZDMUxhMTIzMVJHdmwzbmo1Rkc1RHZzdzZ0cU8wMkhWMFFYOGZTd09pOGFC?=
 =?utf-8?B?cXhuYkxDK0VCUUN4bVVwbitzcEdkQ0JUZ3ZMRXkrY2pVZmFTVXY4YmdXdWxr?=
 =?utf-8?B?WllCOElZZEVkOXFDc0xmWS9haHRERXZHNEk0L0tIKzk0N08xNU9PZm5vdjYr?=
 =?utf-8?B?M1c4REt5dmtQc0U2VFZXWUVkaGxLRlNEbkp3MlpWVHVxbFRrTzRQdzlIZFJD?=
 =?utf-8?B?UzVXcmE0elRCcVZ3TGhpYStYak9iU3NoUTZ5TVA3NCs5VTdNWlgyOTFQOXZQ?=
 =?utf-8?B?OXBvVk1qNUpFT0VtdC9OTkRoUzM0Q0ZqQ0pCQmtOSHdZVUNhRzR4eW51aGNF?=
 =?utf-8?B?YUNNWDRaU29EZUlxRjd2dXhHaEJoYkYrM28rN2dzVDBEQ3dRSThMUWNZZllR?=
 =?utf-8?B?YVlIc09DaHpsRHI1dlVZYnM2ak1kQ2dZUG5JWFltSE9ZRVEzcW9yRjQ2TlZy?=
 =?utf-8?B?b2JyQUNEdmcyZUs5bW5MNytIR3FoZ2x3dWZqU0JoZ1U0QUdaVGZpYVpNRVZ2?=
 =?utf-8?B?WFNKTjhNVzZWTllhZlpYRDhMNXYxdmZEM3l4MUFiT010VDFyMW41Rm1WcTdZ?=
 =?utf-8?B?V3diczRPYndWVjBkMG1oS25YYU1VeEwwalE5dGtEUGtJbWZyMDBYNGhWS2lv?=
 =?utf-8?B?R0VCRnhFblZTa2lOVnlIY2RZZDZqN01mcVdlek1mLzA5L2ZVRjgxdlFCWTFi?=
 =?utf-8?B?VW82WHA0cjlPVjZDdTA2REx3WWhheC8vMHlLWHRUNjRaM21FbVdBMzVqdlFV?=
 =?utf-8?B?K1NvaWVzdHpVd1RtM1dGeE4xNm1DSmF3bEV6Y0huL3Z3WmhJTkxQVElXQXBj?=
 =?utf-8?B?QkNwRlo5TUtmSVQ3WXJvMmhpYk4yVHcvOWlWRE05L0FWcnVZQkVCaEhVaEZv?=
 =?utf-8?B?aVIxeDNkTTBOTStXZDJpVkhra3BtWkF1ZlRLVndyUFJjYXpsdUFUWDgyTEpQ?=
 =?utf-8?B?d1M4ZUpqUmhpMENucVVlaTdnaTlrdFJxQ2FaS1krVmxqMmpzVE80M3dCQ3Qr?=
 =?utf-8?B?eTFyY2dWbWZ4OVRxM2ZaYTI0VTVyMndUV2tUS2IzV3p6aVU2TjY5aDMwKzNB?=
 =?utf-8?B?TTkwYzZudi9vWUd3RVdZMlJ2MFlRZVFtSFd2a2NnNG5sZm9IajR6V0l3Q0J3?=
 =?utf-8?B?TXdVREMwYjNtNkoxMmx5SzErRmZ6QTgwYW1jQkNTNFVLT3YxUHdsM0dXTkxE?=
 =?utf-8?B?cXJvZERXckl3MVJtK0h6QUt1NjV0VEZaSG5yN2YvaXJzYmNSTWVGTmNuUjgw?=
 =?utf-8?B?UUVwOGpxS0x3MS9KR0lsR29zSDEzcGVSRWp2K3F6U05LdjRpZi9DY2VqSzZW?=
 =?utf-8?B?VGtHSGx0TmJlOW5PdHlGeXgraUVIL1NOd01vK3E1Z2lBSmt1VkRwNnhlSFlz?=
 =?utf-8?B?MkxkZnBqRzVFa29nbnhIb096bnVoOFQxSlYxYXR5U2NaMUFucS9BQ0dodXJv?=
 =?utf-8?B?eGp6bSt6dElwNlpWS3lCSmlmcGM4bnBqOE9BM3NGaG1lK1Z5UHlpQUpUaXpN?=
 =?utf-8?B?UTZ4ZEliWHd5NDcvb1lRMUhpNmxCdDRtSXpFV1hoNU9aUlcvakxZbDAySmlY?=
 =?utf-8?B?OUxyWlJ1WWl0U2FTWURiZWpVZ29pWmxtT2dINFR0cU4rUDNIR3d0Qk9uN1h2?=
 =?utf-8?B?ZVRsS2V6UnRFcjBiT3kxaWVVdEI3cHk0Z0xuZHdxdGVHcmxtZkk2T2JmVnlr?=
 =?utf-8?B?S2NvQkRmSTJMQVkyT1haUCtIUk1nU2Q2YTM5Y1NOcnZNWTRnbCs4aXY1Zmw0?=
 =?utf-8?B?Z2xvYmFuT2ttOWdNcy83aVlrdko0ZFk5Y0pMMFk0NHVuTmFNaXFoaEdzZ2Nq?=
 =?utf-8?B?QkthOHlRa1NIM0pqbk5xUWlyUXdyU1ovMDRLaSszRnllMHh2eVB2SGtNV0o1?=
 =?utf-8?Q?42+8K/Jd+ZcfrGpJNh76azw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3ef638-4b67-4096-77f0-08dce948cea1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:30:09.4923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0t4Z+/b3r4vxuy0nGcYA9GOAtZyVtxcC2h3ZdvOYhz8INkDYy+mGpu6ro34xxXqOjsq5r++UViwJr7H8ugqEwz2ALSJYV/LRNK1v1nx8T3Siu296gBkqNUFeJj8Gzo4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7653



On 10/9/2024 2:13 PM, Leo Yan wrote:
> On 9/9/2024 10:30 PM, Steve Clevenger wrote:
>>
>> Add dso__is_pie global to read the .dynamic section DT_FLAGS_1 entry for
>> the DF_1_PIE flag. This identifies position executable code.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  tools/perf/util/symbol-elf.c | 61 ++++++++++++++++++++++++++++++++++++
>>  tools/perf/util/symbol.h     |  1 +
>>  2 files changed, 62 insertions(+)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index e398abfd13a0..babe47976922 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -662,6 +662,67 @@ static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
>>         return err;
>>  }
>>
>> +/*
>> + * Check dynamic section DT_FLAGS_1 for a Position Independent
>> + * Executable (PIE).
>> + */
>> +bool dso__is_pie(struct dso *dso)
>> +{
>> +       Elf *elf = NULL;
>> +       Elf_Scn *scn = NULL;
>> +       GElf_Ehdr ehdr;
>> +       GElf_Shdr shdr;
>> +       bool is_pie = false;
>> +       char dso_path[PATH_MAX];
>> +       int fd = -1;
>> +
>> +       if (!dso || (elf_version(EV_CURRENT) == EV_NONE))
>> +               goto exit;      // false
>> +
>> +       dso__build_id_filename(dso, dso_path, sizeof(dso_path), false);
>> +
>> +       fd = open(dso_path, O_RDONLY);
>> +
>> +       if (fd < 0) {
>> +               pr_debug("%s: cannot read cached %s.\n", __func__, dso_path);
>> +               goto exit;      // false
>> +       }
>> +
>> +       elf = elf_begin(fd, ELF_C_READ, NULL);
>> +       gelf_getehdr(elf, &ehdr);
>> +
>> +       if (ehdr.e_type == ET_DYN) {
>> +               Elf_Data *data;
>> +               GElf_Dyn *entry;
>> +               int n_entries = shdr.sh_size / sizeof(GElf_Dyn);
> 
> I took time to play this series on Arm64 machine and found issue in above
> sentence. As the 'shdr' strucutre is read out from elf_section_by_name()
> below, but it calculates the entries before reading out the section header.
> Therefore, I observed that program will not be detected as PIE executable due
> to 'n_entries' is 0.
> 
> With fixing this bug, then I observed the regression caused by patch 02.
> 
> Below are steps:
> 
> - Build test program with below command:
> 
>   # gcc -pie -Wl,-z,relro,-z,now -o test test.c
>   # readelf readelf -a test | grep FLAGS
>   0x000000000000001e (FLAGS)              BIND_NOW
>   0x000000006ffffffb (FLAGS_1)            Flags: NOW PIE
> 
>   The test program is a simple infinite loop. I run this program in a docker
>   container with Fedora 40.
> 
> - Record trace data:
> 
>   # perf record -e cycles -p 149531
>   # perf script
> 
>             test  149531 483168.078485:       4986 cycles:      aaaacde401b4
> [unknown] (/home/test)
>             test  149531 483168.078564:     134207 cycles:      aaaacde401b4
> [unknown] (/home/test)
>             test  149531 483168.079305:    1257097 cycles:      aaaacde401b4
> [unknown] (/home/test)
> 
>   You can see it fails to parse symbol and print out [unknown].
> 
>   After I reverted patch 02 in this series, then:
> 
>   # perf script
>             test  149531 483168.078485:       4986 cycles:      aaaacde401b4
> main+0xc (/home/test)
>             test  149531 483168.078564:     134207 cycles:      aaaacde401b4
> main+0xc (/home/test)
>             test  149531 483168.079305:    1257097 cycles:      aaaacde401b4
> main+0xc (/home/test)
> 
> Not sure if I miss anything for PIE executable, seems to me, we should drop
> the first two patches and just pass pg_off to python script?
> > Thanks,
> Leo

Hi Leo,

I verified the perf/arm-cs-trace-disasm.py script patch results for
CoreSight user and kernel trace using Fedora distros 37 and higher. I
did little to test non-CoreSight trace, but I do see the dso__is_pie
initialization error, and the problem revealed by your test program. As
a side effect, the problem would contribute to the CoreSight user
instruction test passes.

The arm-cs-trace-disasm.py python script has a legacy IF block to force
'dso_vm_start' to zero for kernel code. Similarly, map_pgoff gets forced
to zero here. See the adjacent comment pertaining to memory offsets for
kernel dso and executable file dso. This, I think, is the root of the
misunderstanding with regard to the PIE check. I see the python IF
comparison includes a check for dso_start == 0x400000 but I see no
information as to why this hardcoded value is relevant. Do you know?

perf has (or now has) the information (e.g. map__rip_2objdump,
map__objdump_2mem) needed to make all objdump address adjustments prior
to calling the script. The script could even be made redundant as
suggested in an earlier thread. In the meantime, Ampere needs this
working so the patch implementation has to work with the current
perf/script implementation.

I agree the revised approach is to pass pgoff to the updated script
unmodified.This means patch 3 will pass map_pgoff unmodified by
MAPPING_TYPE into the dictionary. Patch 1-2 goes away, and patch 4
remains as-is.

Steve

> 
>> +
>> +               scn = elf_section_by_name(elf, &ehdr, &shdr, ".dynamic", NULL);
>> +               if (!scn)
>> +                       goto exit_close;        // false
>> +
>> +               data = (Elf_Data *) elf_getdata(scn, NULL);
>> +               if (!data || !data->d_buf)
>> +                       goto exit_close;        // false
>> +
>> +               // check DT_FLAGS_1
>> +               for (int i = 0; i < n_entries; i++) {
>> +                       entry = ((GElf_Dyn *) data->d_buf) + i;
>> +                       if (entry->d_tag == DT_FLAGS_1) {
>> +                               if ((entry->d_un.d_val & DF_1_PIE) != 0) {
>> +                                       is_pie = true;
>> +                                       break;
>> +                               }
>> +                       }
>> +               } // end for
>> +       }
>> +
>> +exit_close:
>> +       elf_end(elf);
>> +       close(fd);
>> +exit:
>> +       return is_pie;
>> +}
>> +
>>  /*
>>   * We need to check if we have a .dynsym, so that we can handle the
>>   * .plt, synthesizing its symbols, that aren't on the symtabs (be it
>> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
>> index 3fb5d146d9b1..33ea2596ce31 100644
>> --- a/tools/perf/util/symbol.h
>> +++ b/tools/perf/util/symbol.h
>> @@ -127,6 +127,7 @@ void dso__insert_symbol(struct dso *dso,
>>                         struct symbol *sym);
>>  void dso__delete_symbol(struct dso *dso,
>>                         struct symbol *sym);
>> +bool dso__is_pie(struct dso *dso);
>>
>>  struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
>>  struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
>> --
>> 2.44.0
>>

