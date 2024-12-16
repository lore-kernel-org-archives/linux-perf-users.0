Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CAF9D6;
	Mon, 16 Dec 2024 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331387; cv=fail; b=PXHGpQt/DD4ZMaUqcP8kH1rd0mL0ngWeyMbdgfz8757GWmlUVIymPuotjHbaqfUAUmV2Zw1NPkmBGRmac0zliwshjw4Niexu53dRw+XDZbmtAMfk0+/ke7MyxKKacRWo3TfzC4+f+HjMNPf4kNPu0GMdqlVrQOIt6PzMAL63kWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331387; c=relaxed/simple;
	bh=uU4qVXqjD4zwTznJ9ZHJBAOR3R9Ecipfmsp/qyLDcoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxCpBy4HeoN1PzRUa0s9ViLPQTXxPEKy4LSIxiF6BtCXXd93yQGHB25crFl4nAS/DT/JU74EfTPqs+ctISTILCAdTxv8ZVE9ZQrFidyV7YleH3LBtr0lgWuZesYeRkK/Rypse6EELZ9/GH6Qk9VEZbEw3v53qyVS5v7a5A+ia7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mjr4UpgZ; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mjr4UpgZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hROvU3xcflTFvnTldEPHqRWoiDrry/mDxCWAnEoXd4lWiwwOKwpYY3+zgedfzJ8p3ykfphZqnFg6bCcI0P2eCMf1NJrWMOK5IwLJ3LKSGQ+9o0s4eS3LbaUq6yDR63jgFJA7/WcCP7StT5qxFrBMrDb3Q1R5OiHQiFaLgdAHsDDT/IwurRMQu/32OARQP6rNXI+XkK+0Kz3T+zsY876lfOe9KaxjaFAvzEUukjRfdKDhY28BO2cbW5uWRT7TJYsGkjAE/oTHaPoOvSbNsd9e7SJTohMXJXtadfnq8hHyJVvDJJqZ2D8lGv/elJGhnZkNr39F+qFk0WmWk8en94o0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6NjyyB/GkKX+kmpfWWui7wrMBIub/SZzxX3ibPTEK8=;
 b=w6T6U0bvZpsP/yDwebofGT0haoLVmvQk7L2MSURicm7Yfs8bw3064RWKSec83l7lRogmvuU7Vya6KP1qhRFVdwEt4Gq1vhXrqoYgEjjZ4/r4ivdPn0UVXeMLmmA0l2Cd9bEF5eA//eMP8d8TU8fNX2jSktMG1zf41w18FjL4Tdtpr3F3Xe/JdeGnzrC649gW818L4tsqyKKHLTUixf+6R1jRfWnyVYxtqZ2TEENNPxDntC1xJbNhK6v8zzA4uRtjJESxOVObREujmD4FcHLiWTJ6KF3gt7pAoSJdSmEcxPNft1wTTaa3XNemvof1Cia2oN8xII/hLP0rFbnqZLsZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6NjyyB/GkKX+kmpfWWui7wrMBIub/SZzxX3ibPTEK8=;
 b=Mjr4UpgZODhokSXmRMUL+jQp3qsB8WUG8ntZmkYtXCsXy73QxD0at4i7ICm0YTDLW9hwhShRakHJn5oYj7kkxvXNYx2cVjrBJSkhsv2Te+1QwXVpetpdMjl7VyYnhmKn77nuJMiPRNOmxplMYaEfjD2TrWHY6fhrWVR4TnZme8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 06:43:02 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 06:43:02 +0000
Message-ID: <c6bb1c11-c869-4e4d-82f1-f1efd2b2d7ec@amd.com>
Date: Mon, 16 Dec 2024 12:12:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] perf/amd/ibs: Fix sample period computations
To: peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 namhyung@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::23) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f3a783-3087-4144-a95a-08dd1d9ce2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1gvVnNjQVUyT3NpYXNVLzlqdzYyOVg4Y3JET2RHK2VBZVcrZjZPYzBoYU53?=
 =?utf-8?B?T3BXNGc1d04xU1FLdFZGbXFuSGhNRm5PdFByakFKS1FtS2JMa3VDNFpOSTZW?=
 =?utf-8?B?ZG9xNm5yNGVxR1lENmVnY29vYTVlQ0czMGtvTnBvWmdMMkV6MGZVR1BGdW1T?=
 =?utf-8?B?MzJZdVB2MHR2T2pHUFZlZUJTQzlIN1RXck4xK0JMQ0ovazRoNDVYMHp4dmtl?=
 =?utf-8?B?NldvRWxlRGxUblk1ZmpCV0ZkKzcreFAzUGNWeEpJUVJwMXE1K1pwdE82L1gx?=
 =?utf-8?B?MkJlRjh1N3RhdVJPM281ZkxVdk9veHpESndZN3NjZkl6ckJSRE5mQ2lkUzZ4?=
 =?utf-8?B?RnJrMkdyVm5VR1R0YW9GaTlYSnRrbml1SHRvVUcxVlVZSzFlWW1FUDl5VXZy?=
 =?utf-8?B?Z2NWYjhSNjlzU3J4Ukh6WXBJcCs0dFNpRHk2eHF2amVib2Z3MmFXRTZNNmZT?=
 =?utf-8?B?VXdOZDVOYXVKeXNJUnhMbEdLRngvWEIyYnBNTG5KQmFjWU1LelpIWk52TjVK?=
 =?utf-8?B?NmplT1ZHb09NUHhZQ2J4SE5XUFZzbUhKejR3dTFDZTd6bkhjZURzRzFjUE9p?=
 =?utf-8?B?R0MyZWxkOFJSQXE0bkRQUXpEemZBMjE5ZjBYU29rVWFraHdJNk1oL05kVjI2?=
 =?utf-8?B?QllGUEgxR1poNDlvQUMyeUxNcDlMZGJIRDBMdXBOZ1Y2WXFJY2t1OENiUGJj?=
 =?utf-8?B?QlhvbGVkTUc3QmtlUUJiMzRPbHBwdzVIVXNnNjYwUEdmcW5xdDdGUFFhZFYy?=
 =?utf-8?B?VHFDMnI0aGs4ZFBpS1hPYWlhV1c1Zi9LRGxPWE5sU21lSG5YSCs2SmtzWEd5?=
 =?utf-8?B?cWxHTG9WZWMwUVB0bGhEQ21mMTREZHY4a05nclppb3J6dzlDS0FEeWRRd0l0?=
 =?utf-8?B?SUZNOHlZWnd3Zy8zcEZoSEJBeUQvcmNhdFNqZGdnczcrM0FKN3d6bFRtOGJa?=
 =?utf-8?B?TEtjZWcxN1lnUGx5MUpKVGsxZ2lZZHk3L0JFRlNUYTNXeTN1QUxKbXlXS2VB?=
 =?utf-8?B?RlhZcGd1cGF1LzdhOWd6SmhVZ1BPdUFtSGRrNndPV2RDMWxhQzZYQXhnSGVT?=
 =?utf-8?B?dThYMXhocHNWWnhPNGtsUVdSckRqTE5FS2Y0NGxubk1xU2I1Ym5OYkhkN01s?=
 =?utf-8?B?V0RWZ083Q1YwOElZaSt3NXIwUGNHN3ZwSmZHclQrclFaVm9pNEVBSFRoUzk1?=
 =?utf-8?B?bkk4MWkvUXpXZVg5L0E0ZnpFemNpVUdOUDRPQVd0bnpCTmZhRXUxSGVudmpz?=
 =?utf-8?B?YmdmWFhKQ3piaVQ4ZWhIMzNIaEJFQmZqRkV0MlVaM1VmZUZIdk9EajJJZCs2?=
 =?utf-8?B?aWRZNTdCOXJsSFNjRTF0alc2ZGd0VUZmUmtEWVl4OHVXamVnRnZEaUpBMXpI?=
 =?utf-8?B?UGhENDBsYW9oTEthOTNVNEovK1dTUCt4UndYOUtXNGJnZjRBcWxFSnd6TEI0?=
 =?utf-8?B?VENlUk5hZEMzblJYbEoxZkNWK2NzUGNKakFtZ200Q0VvUGVnbi9sTjVkb01q?=
 =?utf-8?B?WU5ZaEZJbW5aY0NhcnlIU1Y0YTVFOXBWWFZEazlUNmZGdVg0WTVrdExuN2hL?=
 =?utf-8?B?M09TajJST2ZCOGIzM3hBQjBDN0p1akovSnVjeDNITjNtOE1odjJaL3RseEI3?=
 =?utf-8?B?eml6d3ZGYWxTMCtZQ21qWjNpaFIvZjRhSFV2QlB5UHVQU1RFK2ZFckx0SlpV?=
 =?utf-8?B?N2NzUTdYMnB5S1o2R3ExOFdoQko2V2hqOG5BcEdweHVEVFpuYU54c25sNVJ4?=
 =?utf-8?B?a2MrY0MwWkprRUFnbmJhRE5COFBkWDRWcXJaMGQ1eVVzYlgwQVRraFNvTWdq?=
 =?utf-8?B?RTdZZzlOajVjUjhqMDNhQW1zVnpGc1ZxaDNVR0JJdkg0MzBveGRsN09iRDB6?=
 =?utf-8?B?aXp0T002dFEvQWNBSTR4S0Z4TGxJblY3Qlg3QW1tcDBPb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHM2cS85SjVQemJJTm9vNWVzc0hUSjFpNk1oSzJiM2k1eFFtUTJGZ3U2ZkIx?=
 =?utf-8?B?UVZLM1dNZHg2WlArVkRLYVJ6VG9VQUUyVzF0WHFVNzhBdWl3ZWVuYjA2Mnhl?=
 =?utf-8?B?VWRRMytFc010a0pJYjJrUEpHbHZ0TGo1ekE5cXlLSy9YKyt3eFhJNTAyTzhW?=
 =?utf-8?B?aHhpR1NjY0pwWTZvVS9Qc0R1dkJnZnVLc0dKMWhxQ3F5eVMzY2VZaEc0UVA5?=
 =?utf-8?B?YzRjQVBLblQ4aWhhUnoxU1BiUmVZN3NwaXRGQWhqTjZZaGd6QnZEa0REbzdX?=
 =?utf-8?B?Nm9salZVTXljaExvbjg4TmVQKy9RTTN3eTVKaVVDMkFuTEdZM0ZhMUk0aU5C?=
 =?utf-8?B?R3Q0YXdtZTJMb0sxQlE2S1ZHNkRaa3RWMHB5WVdSK0tYbTdSbXpDaU5MeGV1?=
 =?utf-8?B?Q1E0VGZETVRrY1dtSElCVEFuQVRXMGlqMXROOThzR2JidEFBb29oUjBsVjJv?=
 =?utf-8?B?T05ocW5OZUtrZjRIWDY0aG54cmRmbXBmZWtsbHZpZEJHT0djMkVmRC9QTnZq?=
 =?utf-8?B?UFFoTHA1a0lSNUJTd3FLNGhnZmc5bTZNUE1jSkk4dXdIdDBMcThiQ01NalU5?=
 =?utf-8?B?ZjlFR21wR2dWNEZqZndSM2dtRGgyRks1YnBVQk54by90RktxUjhoTVhscURo?=
 =?utf-8?B?ZW82WDliQXZKTHhidXJTM29EMThia0JOYU9mZEJlajRIQWErRUJOaGdSUXIy?=
 =?utf-8?B?c2txZUU5MUxjSU1KbTdOeEhmQSs4SjRPOFFEYys2TnBxTDJpcW0xWGFOYTVD?=
 =?utf-8?B?aWpOdFVNVmpjYS9obDMxSldoemJKTG95RmY1eDB5VkRGVEt6WVNHWmtuK005?=
 =?utf-8?B?Ny9YWWV1QXR1Kzd2cERsSjFlakFYdjdsODFoSW9sRThucTBCUlRaMEt4Z1l6?=
 =?utf-8?B?Nlp6ZVVBd2xFWXZURlo1V2hrRUVjTXMydURPZ2ozbXZzRmVvVER0c2dsYURk?=
 =?utf-8?B?c3pvZmVtejBaSnFCYldSUzF5K2VJbXd2dEFtd1JSbDlKU3VXQ1NOUVdRQ1dt?=
 =?utf-8?B?eS90WFlLMUFzKzRoZTBHdTRrU01WU2dQaXhVNlNIMFF1bE9YemNGRW44UjVQ?=
 =?utf-8?B?RXlORCs1ZDFDOVlrSEp5RmxuaGRqWGZBRkNYU2NoSWlLMTZ6VmFkdDF1bXo2?=
 =?utf-8?B?QUtlT3J0NzIrRVN3UmZNZ251ZjFicGlXanNQQWNrbExnSWYvYUNubU0rMXkr?=
 =?utf-8?B?d3RYV3dWbTdpekF3NWlveWNoNlV6Smcrbm1ZOEd2all5UEpPNC9ERmlmdy9O?=
 =?utf-8?B?MWJuUGxSR0tqcGc3TG93b0JoQ2ZGQjlCT3FHTHlQTUhwMFg1ZERtaDQ5VUFF?=
 =?utf-8?B?NC9EdWhTYWZUNlFLR1kwVy9sY2xYaWdXOC9qU1RDSG5tWFV0d25HWFpxQ3Uz?=
 =?utf-8?B?OWFPbld2aXZHVnpYMm1wMmw2MTkxREpDeGRnQ0w3UnZPdnFxdmVKcjBNcWM5?=
 =?utf-8?B?enQxcmtsYXdGRDY4SWRwVE42VG56dGVVa2F2Q3cvUmZsUjEyQk1MOHZhNEkx?=
 =?utf-8?B?MGVmajJ2MU5xWXNGc3Y2ZFcrKzkrVys2NWVlbjBJcEc3NEZIMzBPNGtFOXZT?=
 =?utf-8?B?cjBDRUUvcjJpdWRGMkx0WXlVN0pMemZHUVpoQk5GbUM3eis0L3JEODR5UVpL?=
 =?utf-8?B?R2dBVFZLWmtzL2pveTI2b2ErVWJ0ZERpMExEOEprbmM3VG90SGExb2RpVTNL?=
 =?utf-8?B?cWQxdHdGcVlnSnFHTWw1MGNtL2Y4M0g1ZmRaUzlMTXNEdVhSUXJQQnRRNWVm?=
 =?utf-8?B?UTkzNUttM2pXMGtDYUpqY09vUE95TU5SUWFYSjc4RThlRHdodEwzNCtqQllj?=
 =?utf-8?B?NHhXS2pHZXE3WVZnM1ZDOUxGRnhkRHJBWnk0b0FsRVRhSEp2Q0wrS2N6ckc1?=
 =?utf-8?B?K3JwM25OL3J4cTUreFliZjJua3JQMFBoVFErL3JqUG1EQVVGT0hFcjFTb1ZG?=
 =?utf-8?B?Ty9JbnU3blc5bVBFTTRYcjd6bDc2US9DcjJ4c2I0SWlrSS9jdlRKRmNIcWRC?=
 =?utf-8?B?M3JycmhrNU12MDhMeHNXMWdyOHVZdmpiZmpaUjhFUkJzc1NaeXpGaDQybFpV?=
 =?utf-8?B?bWN5UytOQXAvaFByQ3RiaEkwZnF6bzNpVUhNM1ZRbEZodU5XY2tuWEVmWGQx?=
 =?utf-8?Q?PM40TFLARNq044onkac2ztYmi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f3a783-3087-4144-a95a-08dd1d9ce2d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 06:43:01.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3LMAEaaKBoVAllWvA0Fj/y5Otk2t2GGVRYfOpui1Ic3wvGmNkiyCIbmzV0KaxnGrhdIU4VVwFLNCBllSKjmJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532

On 10-Dec-24 3:04 PM, Ravi Bangoria wrote:
> IBS Fetch and IBS Op PMUs have constraints on supported sample period
> values. The IBS hw behavior could be undefined if they are not followed.
> Currently, IBS driver does not honor them correctly and thus a malicious
> event could cause issues to the system. Fortunately, the IBS hw is very
> resilient so far and IBS PMUs are restricted to root only, so the attack
> vector is minimal. In any case, these are genuine bugs and must be fixed.
> 
> There were some conflicts with Namhyung's IBS patches[1] which are now
> in the tip tree, so rebased the series on tip/perf/core (02c56362a7d3).
> 
> v2: https://lore.kernel.org/r/20241206051713.991-1-ravi.bangoria@amd.com
> v2->v3:
>  - No code changes
>  - s/pmu/PMU/g
>  - Include unit test example in the commit description
> 
> [1]: https://lore.kernel.org/r/20241203180441.1634709-1-namhyung@kernel.org

Peter, Ingo, gentle ping.

Thanks,
Ravi
