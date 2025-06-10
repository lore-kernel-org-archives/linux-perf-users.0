Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94D7083C;
	Tue, 10 Jun 2025 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749534626; cv=fail; b=VH67qwb/unJm89o8YMgwJZD/40fvb+i4elB/OK/5NtNzJY1VDp8czPhtrQin8l5aPs1ArUEgIwSj8r1pCy33i99urQq8vxDmmsVtSadzTKkq82UvBg4zuL8eQugu73ZBWZukqtdj1njYJcCPcM6dSircfwrNkhAxkrojwJ+wMCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749534626; c=relaxed/simple;
	bh=lKYJmi7C1XoNZTyhS0uRjys/6i36WSB5Cd+gSpFe/aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S6JyyCaYnsJhvK/s6A5j86CA0gSoQ8J8mKEb5fATl+InoLz8zMeqZAEqlaRzPltn7uyqIJz7w90Jf1yf2rd1NHIp8D2MCBTuQ+szmwS9fswlqYmvAaKIF+Ik+F2ky/q10XD6LKrhO11ZcZA4pr1Quk/I1KsHJPIMCDGLUCyDDBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jlol4ygI; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jlol4ygI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpKNL+BE30sepJXnuIUnwJqtSLwYj55CdGIv6rJI2yrCjbl1vDM10uOnbxYBzDcCsisoeRBVEDSYfqv2kI6/iDE/kbRd9xMgbwKdt9bAjyZL4xXQvfimPseX8O6n0zrXfHDb/4a00Lo5/TlJ8S5BtLm2d3T8GKWq4KSUw4HOLg9BTRVRAXjhw/BMuh8rPCGUZ9iK53F6gStofT7vTCsQeDNj+4D2weCrPjBOOnQmGh0vTzEgzkeWBb/y83PtoCzfsDzEY6ID3wJvlhF6JQucxkxJYqX2Qh2u7OI0OtHFoD5A0bZ1gTZyawPh9PgX+K22YGVI3Lj6oE9gX+pce3X84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Krc7Kf6WUz/ebnMlRZJ1SsbzShUeGasdzYoxkUxpwa8=;
 b=QcSIYio791d1ccV3K768lpIgwiK37INk12eXdCPMXvqmgwW0cuiq4+PZ4t1wbNcUFJYwkFzk701nMHjZWzSdbnqOFuLZXJ1dwE5Xcx6zFNoEIIbeAZo9P/N7LQ7YyfJFpQmAAK7/KkWlj0aAVn2gePKhuzssryBRO1C1UkHXapq79PrM6AMp3gFR6HKRNqYUSbgNG2bqsIBU63FNUYuDlI1oO0vzTlnTlMvKHy1U7aN7B5CorSeKdnIFvSsBMMn9TveUDBLhqojkffwutesKFcz5F41L6E5juEWYcAm4sAhcjmiPqCUFwOZSIDXhzW6fBsb/R3KWatgD1ohfRpQr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Krc7Kf6WUz/ebnMlRZJ1SsbzShUeGasdzYoxkUxpwa8=;
 b=jlol4ygIuWGaJveAVFu3VtZ1NYZrGEyDwGD/Osim0QmmCRh5b0wfXGcnajeg00cISoaE83Cuz3cFmf8+YBk1Azza9fOyLsgv1Gdmil+4htU05q7FBrghyK0uJPXJ4PCI52LrFw8VVVm0QHt2f2K7XFX4TeXMtK4ir5ZLey0qNxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 05:50:23 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 05:50:23 +0000
Message-ID: <a27e8a6d-4ce8-4496-b524-3b0bb1b8e921@amd.com>
Date: Tue, 10 Jun 2025 11:20:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
To: Alistair Popple <apopple@nvidia.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 david@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org
References: <20250609170806.447302-2-shivankg@amd.com>
 <yhmscjk4j22mi6yjqpswighh2h5phnmdc7cr2otvn43ng4w577@vheecvjlwmmr>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <yhmscjk4j22mi6yjqpswighh2h5phnmdc7cr2otvn43ng4w577@vheecvjlwmmr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3129a7-f44a-426f-2cc8-08dda7e2b096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEg3cmpxZ2xscDNLMTBIRW9lQnVhcEdnY28zNm1aR1VzQk9jMis2RDJnZXA0?=
 =?utf-8?B?WnVrNWorUmRDVVdXbEF2NDg5aExhcDROOFQ2T3EyV3ZtZXJ5TExQMnZFUTNY?=
 =?utf-8?B?bXdKbzFIbllMT09PUlloM3pTTmk5MVZOZ012ZEJlVFJNNStjNkI0R0JleW5l?=
 =?utf-8?B?NmlvM2p2RmRYNTVLamRBaHB0ajlPT2hJOGdpYU9JTExReGU2ZUU0dngzVjFZ?=
 =?utf-8?B?OWh0a1ZLd1gveGRsS2tpTDNIcmt6bkV3Q2ZjWjVoM04xN1JvYXA4emwrSXpm?=
 =?utf-8?B?OFU5QzJDaU00NGFtTGJycXBQOGVHaDBqTzNQYmJndzFBT2xqOWROQWRkT2Jz?=
 =?utf-8?B?TDk3a2s4S2dlZTQwU2ZOODdkdjJZWlhsQXpMWGxCZUxtcnZXRVlEaE9HWDRs?=
 =?utf-8?B?S3JuRmxlWERTQVhyUXhRMjEvQUZUUi9DZU5vU0c4RnB0Z3NKaDh4NzZUL1hZ?=
 =?utf-8?B?Zk5yalJZOHgxSEkzQ01NZGxnZndQclJ4aWNqc1JvTEJiTHNMRjFJeVJMZkw0?=
 =?utf-8?B?OUNDUk5oUFlSOTMwK0YydTRDZzB3RHdLRXhMTUJNQ3dRMEJyWGxZR1JYRVJo?=
 =?utf-8?B?NEFiaklaSjVpcG9URHVTODZ6UjlkQ09MR2tqb095Y0VUQ3BFenY2dzlubzVQ?=
 =?utf-8?B?YmZsc0x2MlZ4ZlFiQmROSDhFZ0JZcExPL050V3lTNEF0a2d1OWUvMm5aQmFQ?=
 =?utf-8?B?R0UzcWZxMDZsblRuZHNPbjBZb2pxaGNTbnM1ZUhLakFFYk5GT1RqdHBBWWVH?=
 =?utf-8?B?djFNK3dENVFWT0lDUjIrM2c3akNaS09GNDhKQmFLUlJnYVJBSS9nd01ZWERE?=
 =?utf-8?B?M0lJMFVEckZQdk54Z2p1ZG80eTZ5SXB0aGFFTU5uYWhWaXR3dnVuRTlqMGdP?=
 =?utf-8?B?UVZwMVBTYVpoVHdzY1MwQUtHZGRGdjlRUHZmYzBXR3MrMStjblFEdld6RlJT?=
 =?utf-8?B?Qlg0OTF3QXBiRDhzZVdhNlY1ZHBzRG1OMHFxODlWNGlXM0dYQkE1VWhNV3JQ?=
 =?utf-8?B?eXdIZXpsMGFZcGNNUVl6Z2F5eDNkdC9UN2FDMzJqblFpdXo2Zy9sc1l3aCtE?=
 =?utf-8?B?Nk1kMVZDVWtMMEpsNjlqV3RCbkE0QlhGdVdYd0xEaXlzRUR2STV5MkxyMmpx?=
 =?utf-8?B?OFlxQlF1b29hdmo1c3FyWFZJb0htbTdlZGNtTzB1WVVLK29CTmtZR1NKaHM5?=
 =?utf-8?B?c0pEdEl6bTJGQ3JxSVd6a0lhL3UzdWFwdWh0WXVoM0hqNHZZWkszT28xd1pj?=
 =?utf-8?B?SFZsenVwK3FEbkRjcmtwZXZwdS9YQmwrbUNJUWpRUHAyMFVlMmhHSERROC9p?=
 =?utf-8?B?TWlJZ3k4TGE0Y0VBbVovcnFmVUVMZDFRTHpBR2F3ZmtaT2lrSDVhcEZoWVRV?=
 =?utf-8?B?ODVhTzhIcDJKelROYnFVMFpxTmdSQVdTdno4aEp0NHkyZEhZQk16YkdtdWxD?=
 =?utf-8?B?MkxPUTlmb1diVTZ2TVZtdUZ0eTA0VGFUcUlzRmhqbENFUFgyYUhRQk5ZU053?=
 =?utf-8?B?dlF0NVhBYldwU1RCNDVQS0lTaCtJeG5NYUFpQVl1dlFFQzFGWW41NERxalNY?=
 =?utf-8?B?STJMOW8wc1VpNlo4aTZhTEhHRnBucERTNUIyQ1BMVjhERUR2dXFjcGRSS1hv?=
 =?utf-8?B?OTBZTTV4T1pDRkwvdklSZHppT2wwaUNBTkcxbGRoMVBhbG12S3pWWGVJQmVm?=
 =?utf-8?B?SlU3WGZuZDhoZ1dwS2lYRE9uelE4ajBnTTZ2RGNXUVhsMXBCRGVVdmZnUHI2?=
 =?utf-8?B?ZHBXeEk0VkNDcWNzQ2prclpLdFRNQXdINHBPQ0ppNy9SQWVFN0t5anFMMjU0?=
 =?utf-8?B?cFprSCtmdVhNVFFnL2gwbE1LWWVPalpkSVRkdnIxdGk2ejB5b0J5N3ZVMHYv?=
 =?utf-8?B?NnVyQkhINCthdHd2eEtmNHZVQ0tteHdoMWp4bm1BdHNCZEdERzdjYjdCbUgv?=
 =?utf-8?Q?kGu2bn2r4pU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9wL25MZEdSVUJJeXVZSTJrUURxQU5yRHVnOURXbDdGaUNZSmtUOW12Z2g4?=
 =?utf-8?B?NUVmZkRaYWlORDdqVEwzNXhCdEEyOVd5REdIbmhjTm4vbVdrMXFYWnlPK1lq?=
 =?utf-8?B?czR4UzMzb2d0SE5ZNi90S0c0NUJuNUJUeXNXcEZ4WXF1NmFDUzVHRWlPTTUv?=
 =?utf-8?B?MUtsTUEzWnRuclZVVXEvaWRmbG00akFsZVkyWnFwaGp5eDdTekVxTi9YTGVq?=
 =?utf-8?B?bkRYcVRMUzYrQ3BBUWpQRC9QaDBEYlg4QTJNdFJGRzVXMXRndlZhSGFEeWEx?=
 =?utf-8?B?V2JqeG9SNEtkMlpXRFZLQThta0pjaDQrYVg3Qk1uSlI2L0RWeW0ycDRCQlAy?=
 =?utf-8?B?SS9zWmJmd1MwaFlYc2pBeEpIODN0ZjNWdjhySXNmV1BvYm5vTzcrMmpVQURE?=
 =?utf-8?B?R1RkYUdsbU9yS0hCOEtydFd2a09xYmtOTzdtdmlENTRxblM3TUltU0s4bUtV?=
 =?utf-8?B?TzBQd1dCRDdQSVVqMGhEWnVKZE9xNUg3R3NUTktpQXFick1OSmNsYkJyTzIv?=
 =?utf-8?B?YUk1c3MvMlZUL0c1ZUZ3c2liU3Jmd3ZHK1luNFdIZHBsZjlWMVBzR3BTaWZP?=
 =?utf-8?B?WVRpVzRjNWF2cG5TdFB3WGFlT3lxaGxDSStXTVgvd3Q4QnF3bjZtTG1FZGdP?=
 =?utf-8?B?RDJNSUM0Tk9LdTNrM2F6RGZJWGQrenlJeThmSUdQTDR5VldKMDUrbEZiUWtv?=
 =?utf-8?B?QUd0eTd3ZktMR2NVZ2Q3ZEI2ekk2VUg5WnJhbXZPMTVGcEEveVhkWnpqdTZR?=
 =?utf-8?B?MXM0RWhpRUlJSGxGK1NwYVVFZ0NpV1JycDdOSTVSYmwyZVQvOHRGWHQzZDVE?=
 =?utf-8?B?aWVmWDFTbC9NUDZnNE5Ec0EwMXB5bXNNT3BZdkw3L0dHNEh6NFVvVDZBZnh6?=
 =?utf-8?B?QWU5K09DbFhNMUd1akF0cEh4VjdZYzRFYS8wU2FPZEJSS1FmY0FCblQ3T2VX?=
 =?utf-8?B?aURCOG5wa0ZwZGpUNlBNci9LbTdxdC8xbmx4ejcrMWxyU0RQRWw0VWdOTm1h?=
 =?utf-8?B?UkdHZjJ6MGR1bllJNEowa3VNTzY5eHVDb2tpa3VzR1V3V0E4THBQdGpsR1FK?=
 =?utf-8?B?V0l4aTlWY1ZXU2dPQWN6em53Z1BYWTZCMDJYN25jdW1lWm9FVlBEYnNVMlpu?=
 =?utf-8?B?cm9uSGJySnJDM1ptbWRRRlJLV3RTOHVSS01rZmQ2aTBHNXZtWHp2dExRQzRn?=
 =?utf-8?B?cTlId3ZKVGNjT0s4N21oczQ4SkcvZEcvK0Z2a0hMeTRDY1RSZ0NSSGNmTlFo?=
 =?utf-8?B?TWhJazhOU0lTUHMwRThsZFgyS1o1VFpxL2xYVGt0SllwSnpKNVRVS1pHdHZM?=
 =?utf-8?B?OHo0eDZWS1I2OGo1aU5xa3NUY2lHcHNaMmx3U0tlVm1GSjAzVnh6ZGQvN29Y?=
 =?utf-8?B?eWx4TFpTRm1FMEtid1FIeU0rdmwyU1AzeU9OaFNIVk10a1NobVI0SGFGY3cx?=
 =?utf-8?B?THJNZ3NtM0JPNFhvV3hXN2pBMWx5Ym5CaXhzcFI0dVMvQjFqNk42VEpyRnkw?=
 =?utf-8?B?RFVXSytCdTZudFZuSGZuZFJCNk5hc1U1Qm5BN3AyS3c1clVubDRCenlYTWx4?=
 =?utf-8?B?YlpXN0dJbEttbjRSZVc5eFhUSlo5ekJ4cDZ2SnUyWXRVcVU5RlUzU3daRVpJ?=
 =?utf-8?B?bExHZzluQUtTZCtOUE05eEl0ZmhxWUpiQVF2UHpYTW5OZEhKeUU1VGxWMDRv?=
 =?utf-8?B?ajlrdlRiTzFWakYwUTRXaXVITjJRSncxQVgxNnlEbGtZeUNZVjNmVEh3L3pL?=
 =?utf-8?B?c3dpSElUS2pYWjlVSTNEa1NhN1FvOXJtdkdNZnh1ancwNUh4cERNRHBMY1RV?=
 =?utf-8?B?YnhCZGdUcFhmdG5NVVJXUytKMUZlQVNNaE1NNW5veGd1cFFmWXZxY0xUdmlX?=
 =?utf-8?B?b3htTjZwVkdvVUE2VE1vTWNVRVczMndqRGwwcHM4cW9WcDJnZUVLMFVCY3Fx?=
 =?utf-8?B?b2dyNFI2Z28rWFo1Z1hBQVVHRFUxL2FtRitZZjErWmJJUnYwVzhQVnB1cDBp?=
 =?utf-8?B?dERXZ1JGQ0JacmJLaEF6dkdvenZQUW9taitWRDdXWTZxaGlVb0phSEFHczBp?=
 =?utf-8?B?ZTN2N1gxbURvaUJmWlNMdmQwWFVqdnhsallWa1d1dkJjQ3FDVEJ4TVJhSHJi?=
 =?utf-8?Q?cKc7aWquyOfVTbE8geM84u/Hj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3129a7-f44a-426f-2cc8-08dda7e2b096
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 05:50:22.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwALNs8SA5LMaf5Cx5VjtsS+axAE5BO9mjmYaimaLSKTq9SxNJGulv4+qvOnf3Jr/Ww4DZtReul1ugB8/jN4fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432



On 6/10/2025 7:56 AM, Alistair Popple wrote:
> On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
>> Replace open-coded folio reference count calculations with the
>> folio_expected_ref_count() helper to improve code maintainability
>> and reduce duplication.
> 
> I wonder if there is any opportunity for reducing duplication more broadly?
> The migration code has similar helpers (folio_expected_refs) as does
> khugepaged (is_refcount_suitable) and vmscan (is_page_cache_freeable).

The folio_expected_refs() and is_refcount_suitable() consolidation was 
recently merged:
- 86ebd50224c0 ("mm: add folio_expected_ref_count() for reference count calculation")
- 0b43b8bc8ef8 ("mm/khugepaged: clean up refcount check using folio_expected_ref_count()")

> do_huge_pmd_wp_page() also has an open-coded version of these checks and there
> are probably others around the place to.
> 
> These could all be converted to a helper that returns all the "extra" references
> after taking into account things like mapping, swapcache, etc. depending on folio.> 
>> No functional changes intended.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>  kernel/events/uprobes.c | 5 +++--
>>  mm/memfd.c              | 4 ++--
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 4c965ba77f9f..c978c8c27340 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -434,10 +434,11 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
>>  	/*
>>  	 * When unregistering, we may only zap a PTE if uffd is disabled and
>>  	 * there are no unexpected folio references ...
>> +	 * Expected refs: mappings + swapcache.
>> +	 * We hold one additional reference (+1).
>>  	 */
>>  	if (is_register || userfaultfd_missing(vma) ||
>> -	    (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
>> -	     folio_test_swapcache(folio) * folio_nr_pages(folio)))
>> +	    (folio_ref_count(folio) != folio_expected_ref_count(folio) + 1))
>>  		goto remap;
>>  
>>  	/*
>> diff --git a/mm/memfd.c b/mm/memfd.c
>> index ab367e61553d..4ed5506221b7 100644
>> --- a/mm/memfd.c
>> +++ b/mm/memfd.c
>> @@ -32,8 +32,8 @@
>>  
>>  static bool memfd_folio_has_extra_refs(struct folio *folio)
>>  {
>> -	return folio_ref_count(folio) - folio_mapcount(folio) !=
>> -	       folio_nr_pages(folio);
>> +	/* Expected refs: pagecache + mappings */
>> +	return folio_ref_count(folio) != folio_expected_ref_count(folio);
>>  }
>>  
>>  static void memfd_tag_pins(struct xa_state *xas)
>> -- 
>> 2.43.0
>>
>>

