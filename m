Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B018D65C;
	Mon, 28 Oct 2024 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097505; cv=fail; b=YdcZhb5uliQ4v3iMaas+a4pE/WeGs0sInlKwdt7vVj51BBxePVjpVkjCbsK7K4/URB4oR4/7xBCsfRpc6Y8M9Le1KqtakRNdmuUynkAhzyUKP76N8WLNiUNsxn0G6JBnTMkxV/lEYv12drkRAHbSYQjpg2fm8QrXmpWUD6b7aWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097505; c=relaxed/simple;
	bh=aODwcidz0mW/rEEA+5PXbbFsSWxhVId78PcSAKpX8QI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uw5rmLb7apdwL+WJNQPNVuRrwt/1X82QaIvkOHdF1cNUsD8bRBtVPGDy+qFfTGYCBGdmGKzMkg2nOLXqoBzKqC0vqGZwnWcpkBm7LKiGE5aoKn/nE8tnBJ53KGSkK31YZFIEwJhtmCuPihAH/xTVrFue5QXWNNur/6QKT+C+Hw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nlHk9zBQ; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nlHk9zBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8fkQIpTiAF7fFwwuv7tN0bUikZ4gYHj6GPSRnpIkIj5nJkOMwrgOVgx0CFj2upajTjgQc4lxpqFvY4otcci9gReb32rozQwctLjHCV5EM5v6BPn71nZL7w+CftdI/5GbAgAXYtTkULnWZm/b61DYzTeb/LyxVMe1FrXEAgUC5Zvd2SiV+pg4BjMREvmTvChmYMlRXbiQmr3ztwCBthB75pkIsGoMUsxFWxNK55n/W6+UwlWPkSnjlM+t/FRtSCPWSPS6g+0vUj8GI7c22DlsjV3Hd/VMGOD/lDcNiRzBE/8I7mghzrWIaoL202I2pUdzN59KtSDfn53Jg3M9peAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvVKBb1fzfqiaNdEMwy0Li9SJ0DAZSmxjhJ40gWEzVM=;
 b=gDAdrwFibyXQah0nERU9vM9jOY3xsGSYsswdXVDgFwKxsvs4T8EQ+o1tZ8A4QrZ8wFLBtO6pkIW9ZqX6mxni66NZiHkad48T9/pM2UWVN9UrhzjVuZtYN7dz9HnCv5X5vdXqRb9f2DSTx/b9E0qohvco6YbG8svS/5hfeuCPoT3ZsDZMQ4znuIr2nMXh/P6HuzSmK2YJDBzs4QCkdD1V9oUKhR3AZFLftEufonVgubnigvaey1i7nYdd4INl8bVGQDQ044BYEJuNV67+n5LXPu5EDA8ftrcAxVy6B01URMCbSd8AhywArBm+ILALCA0+Os2h6DIEiv8q0y16uSjMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvVKBb1fzfqiaNdEMwy0Li9SJ0DAZSmxjhJ40gWEzVM=;
 b=nlHk9zBQwOFKFT8Q65hOE25XD9nN9vfP4xCcNPB9VkahfVOLPIjZ9MPNFRvmJTiuhQerpzywGFVD0TReZWXU3htpaxbi4ACQ4FCclZzaL9RbRMNE9g0DzUn0wsKiUIZ3PXkOFSGfFXlcPa2Pu5A4vZgh74HKSIZKCm9kmwYrbqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 06:38:19 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8048.017; Mon, 28 Oct 2024
 06:38:19 +0000
Message-ID: <1b1aaccc-c31c-492d-bd21-b56d5fba69b2@amd.com>
Date: Mon, 28 Oct 2024 12:08:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/10] perf/x86/rapl: Remove the unused
 get_rapl_pmu_cpumask() function
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, ananth.narayan@amd.com,
 kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
 <20241025111348.3810-2-Dhananjay.Ugwekar@amd.com>
 <Zx8ragiP5JBVuKvy@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <Zx8ragiP5JBVuKvy@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH3PR12MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3a017d-b761-4cd3-41d8-08dcf71b1c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEZoZHUxZ0UwQi9mTU1HOTBzRkwyTUs5cmJLZWF0djZBWDkxYWQvVGxQSDMr?=
 =?utf-8?B?ZUgvb3Yvc3orTUYrYkczdWJjRmpZS290NWtxYjNhY0RmN1JneVhvd1QyRFA5?=
 =?utf-8?B?QWI4YlFZQVdyaVRQMVhPYXFIUE8rWGFVV1REZlVZTE8wR2V6L1A5L1dIREVj?=
 =?utf-8?B?U0dtbnNoRkVVeWJaL3RldUc2T1h0dVBkZEdjaHhZZFZ0c0dKem1JMm9aZDRj?=
 =?utf-8?B?R2gySEpMZ3JrYjJ2MGEyWTU3N0ZNL2ZMYXRXUXBzQkZ2MXNLb0RsUGNQZnZa?=
 =?utf-8?B?cUlzUndMU1hPMVE3TWZQVjI4S05vU0xDUVV4cXh4Z1dYQ1YrenRSeVhIL1NG?=
 =?utf-8?B?UmJwaCt6MkRtbzh0aVVraXgzQVZ0V3U5WjVmMHduMVJGMHcxYk1TRnIyMGtV?=
 =?utf-8?B?YnRzNGdLVS9WR0dzK1hJbnNtQlhEdXhQQWM2Ti90UjZISmlpN3Izb1VPTTBR?=
 =?utf-8?B?c2d6UUp0MEVLYXNCTG1LRGd0ZFdpQ0tkRmpuQXZxZjFHZDVKT1dWMTRXTVNL?=
 =?utf-8?B?NkFSeHJLNUtVUG1yR2IwdXp0a2hSc05RdTFOdWRYMmVHdWM3YkNWMERDeVJu?=
 =?utf-8?B?NFhMQ0hBTkZOdllkSTJ1RGU5WDFOdVJTSFdadGxmK3JzOGdQcS93VG9nbGxE?=
 =?utf-8?B?SVhuQ1IxQnVGQ1NZTkhtaUE1cGpMQjI0ZUR1ajVxd1orRTcyNElTOStERjZC?=
 =?utf-8?B?Y1RaUkd4N05ub0tXWGVBODZ2NVNmeDVvajQ1R1JFcnYycXZ6cHRkdnhPNVZM?=
 =?utf-8?B?K0ZQdGtrTmt3ZHZFL3d0T0I1amVSeEtpdFNjN25vZ2R3NGtTbW1qaTdBT1pn?=
 =?utf-8?B?c1Jvc1h1TFVvVHZRNUg3Zzd2YlZLN2VHaERnUElNUzNiemJPOE9oWDhVL09K?=
 =?utf-8?B?byt1VHNXQTh1bzRQZm5NMUxyaWlSSUhjT1BFNGZDRTB2ZHFYcmhGU1k0VktT?=
 =?utf-8?B?WkQ4U2dlUkM5L1ZZZjNsNWpZd0dhc2NSNDZXRUtSbnNCUHJzYXMrbmJrTnhB?=
 =?utf-8?B?KzVsOUxjN3lDelQyYkM2MWVHcWpjckxNcFY2ZUtPd0NLVXFVcHRmd0hxS1pS?=
 =?utf-8?B?ZGJ1b3VEWnA1ZFBmTTlPaWNBQmV5OTBHaGd6Y0QxcXpYWnIybGNWU0FRQ2tG?=
 =?utf-8?B?VnI4OVI3QXIveGhROVVoNmVWQnNFQVJOeFU1OXZGb1Y3TGtqdC9kQWkvYXl6?=
 =?utf-8?B?WUt2RzJPRHcxYi9yNDVyUVNJbjFYVHh2R1hYRmdaSy85YUVIN0V1U09xZVM5?=
 =?utf-8?B?UzJLeWt5blIrVTNEa3hScGJEdjcwTU01ZVg3TUVudUJLK0E4d2hkOUM2UTBN?=
 =?utf-8?B?U1JoZWdQbUtQU0F2NzFLL0F4TnBIUC9EOWdLTjJZVHV1MTJYQmRldnkvc3lr?=
 =?utf-8?B?TEt1UVBQcHp0cGlVc3E1d1Q4Yzhwd3pvWk5YMEYyNTd0R2N3c3RjaUd1SGcy?=
 =?utf-8?B?ZStIUkl1WXVsUk95aHdVbDU5TVRTKzZaR2t3WXN6TXRUWWM0Y3JYUWV6Vzc0?=
 =?utf-8?B?Rmp5OHZuMnpxL1NtdXNaMmVxdXlaQ0tROTgyZEUxc3lQOUpWR1hCT0EwdWRQ?=
 =?utf-8?B?OGNDODhNZ1U5dnNTUUxDYWtPQnA0TEl4M2syclFrQzlwaGN6Q0c2WWdqMjg4?=
 =?utf-8?B?N1kzTDJXb0x2MUJGRGt5NkxjaVhqeDNEOUlXWXJ1SUNnalJGdjNlZmM4Q29B?=
 =?utf-8?B?M0NmMG1PU1MyVlhtV2NzNjA2VUE2S1lxelpVc3hkNW05THFQMUJyZ0VVMmdR?=
 =?utf-8?Q?uGGFrmEH0oe6dHP2Oy32QM+yyLHUzW9FDuTOxin?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c25hTFA5bU5hZURlUVl0OU50eWxaUTZpU05md2JpUUdzclZEbU5SaE5JYjc2?=
 =?utf-8?B?UU5QeXN4eFhpc1BWdUFTVDBMSzhHM3UxbEFQR3hEaWRLZjVBdUkrVkd1WndZ?=
 =?utf-8?B?VlNIWldyaVRxUFk0MmhIOGdveHR1eUNJZGVxWXc5NVpXZmRId21lQjdJTytI?=
 =?utf-8?B?cG5HM3I1VERpbWQ2RXVPbk9FSkkrSWFKWURSbGQzaTRKNTVnYW9COFhLT2RC?=
 =?utf-8?B?d2wrV1FOUjJOQXkyOXNndjVVNDVsOGlBaVVXRGltZndCMkZ5dlNhazdUanlQ?=
 =?utf-8?B?Tmd6MnZIVHMweHp2VUJJL0w3dDNKN3krM0FLM3RUU1pTSlB0RHBKSmRDT1BM?=
 =?utf-8?B?VzZaSE9jNWtsMjBsNlNpSkw1WUZDMi9NRStZdnhPaWdjVEYrT3cyREcrUEFY?=
 =?utf-8?B?NDBidXphNGhPUVFXN3ZyWG55b0hkeEQyM3ZTaHdhYSs1cjQzSi9qc3BKR2w1?=
 =?utf-8?B?R2hhQ2V4dXR0LzVWMDZTWHlIZ1RDMEVZQ3A1b2ZYV05IUmdCWC8rcklWQmxi?=
 =?utf-8?B?Q3RCVDRPK0pQazdqLzhyZGhkL3FNZkFJQVp0NGxrODJNcUprUVVmaDJmWXlL?=
 =?utf-8?B?M3FFeFd6UXlGQ291dXo0cTVNZmNnN0N5TldTZFYvemREUWhkdFdlTXJpaUhE?=
 =?utf-8?B?OGdYRXltSHl0c2YvSCtQS2VxUjd4Mk9JK3Qxb09PWXFnUmpSK1ZTellXZFJT?=
 =?utf-8?B?RDh6UHpwMHQzeEtBb3AxQktTeEcyaHRUVUlNSGk3eStGNWx6Nk9mbzVHTFhT?=
 =?utf-8?B?eDZCNElNcVNSZkJoQk04aHU1SW9ncEIvVGJBc0RZRlZqT1pmQ0xvUkJPVW1v?=
 =?utf-8?B?dnp3eVp4TGJ6TVhxUG9qcUR3b1F4Wit2TDIxNTExZ0pER1JWRi9CWm5yV3hB?=
 =?utf-8?B?aE1MRU42U1pvSDIvdkhTd1ppYXN6VlRiK3R2YzZocEtQVVNVcnArYTFJNTBu?=
 =?utf-8?B?SVltYjRocnlpbXBrUnV6d1p3ZSs5YW51aXhtWTYyd1J4KzFHTlgrejhMdUI5?=
 =?utf-8?B?MGp6TXFQSDAwQis5aSswUnpHbkZROWhaZjhRYWhDUEhrd2ErK2MzSlZKQkxO?=
 =?utf-8?B?ZG9rZW5pbUlPeEJqWHg2SEI3b1VWYXJzYWtCb2ZRVHVhbWpvQ1NwOFdsdXFX?=
 =?utf-8?B?TWZwUFdrREVCYVNObjFXZmVMM3VkNkRmUHJRcm5CWWZRUG5vZm1MdEZVVHZP?=
 =?utf-8?B?OTV3d1E0WjJkU3NEUlAway9WNUpEdTJaYnIyUWlUaTJ1NUtSNkhmb3RhK2Mw?=
 =?utf-8?B?OUNJWEZRdGpLcE5iTlpIeSt4Q1Jhc0dwN1l4V2VndjJNNCs0REJSTVhRMCtF?=
 =?utf-8?B?emVvZGM0azdhenlOdzkzcXlvZnVSTllQRzMzT0pnUDRORXJWdjVhK0VOSTRO?=
 =?utf-8?B?MTBxYTNEa1lsMFRwYzRrVlIvQk1lVGoxcU5FK1dVbi9kaXY2dEtOaWRiMHlz?=
 =?utf-8?B?QzVpejc5UGlkQzUvQy9aTEwwWnRlemR0NlpEV2JhWXROUkNjTjhkc21VYXdi?=
 =?utf-8?B?dlIvUzVSNmZsQWV2UzFRbzl1U1Y4cnZBVjRUZncrT1ViZFp3Qm5GTGlLV1k5?=
 =?utf-8?B?SWdrTjlFcUd5ZitOaUdiK3VBMmNOdUZuSjdMY2hEamcrWmlYbGp2eEhvc1BB?=
 =?utf-8?B?VTdhYytRUGt3TUNMWlhzWnJoM0g1Ym94eU4zdk1ZY0hJZU4xSkdRelRJSGlv?=
 =?utf-8?B?THNHUUdOYWZlU3c3ZjNxVy9oYWxnczlxQ2FwTmM5UVFrUkVKeXBXNzg2cVl4?=
 =?utf-8?B?SWxCUVVsbjQwOFpvODVBSDQ0VG5hYWZ1ZC96NU4wenovRmVrUkk5MHlrYURX?=
 =?utf-8?B?eE00VWxpM1NUdVBmRWJQS1lJdVlETk1jZE1vT0xKS25qclpydGd4bmRQRUtR?=
 =?utf-8?B?am9qUVVLa2FaODlhWEN6VzBmR1dYLzNmZy90cU9HVE1HL0NweFU0WWIrU0ZT?=
 =?utf-8?B?KzdrV2ZMR0owVnFPSTJaYmJjdDZXSGhUYVZBSFNPUDRscjVzWlBIV0o2QW56?=
 =?utf-8?B?NXl5ZCtmdGdLcjRmWnlGc2hnQWhHNlkwSlV3Z3Vqb29iV3lkN0ZQbDVHMFZ4?=
 =?utf-8?B?TE0zRW9YMWpmczJCWVhtK3RMVlBNQ2hFME9sbWt4a3ZIUXFYb0N4M3NWTldY?=
 =?utf-8?Q?lt0fBce66NGEyrtVUgeFyrGUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3a017d-b761-4cd3-41d8-08dcf71b1c71
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 06:38:19.6735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmq2cUuYLtLrDkUPF2kthGjQTwCNvdYbVHhGMY9Fjc/3517jRqmLVFvrFzDojxOmGvceQFK9ucVK+dJbTbuaKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755

Hello Gautham,

On 10/28/2024 11:42 AM, Gautham R. Shenoy wrote:
> Hello Dhananjay,
> 
> On Fri, Oct 25, 2024 at 11:13:39AM +0000, Dhananjay Ugwekar wrote:
>> An earlier commit eliminates the need for this function, so remove it.
> 
> If the commit is merged, please provide the commit id. If it is not
> merged, please share the shortlog here with the link to the patch on
> the mailing list.

Sure, The commit I'm referring to here is 
"[PATCH V2 2/2] perf/x86/rapl: Clean up cpumask and hotplug"
(https://lore.kernel.org/all/20241010142604.770192-2-kan.liang@linux.intel.com/)
It is not yet merged, but I've taken it as base for this patch series.

It removes the cpumask handling from rapl.c. Hence, we no longer need the 
get_rapl_pmu_cpumask() function.

I can post a new version or provide newly drafted commit msg here, whichever way is 
okay with the maintainers.

Thanks,
Dhananjay

> 
> --
> Thanks and Regards
> gautham.
> 
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index a8defc813c36..f70c49ca0ef3 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -153,7 +153,7 @@ static u64 rapl_timer_ms;
>>  static struct perf_msr *rapl_msrs;
>>  
>>  /*
>> - * Helper functions to get the correct topology macros according to the
>> + * Helper function to get the correct topology id according to the
>>   * RAPL PMU scope.
>>   */
>>  static inline unsigned int get_rapl_pmu_idx(int cpu)
>> @@ -162,12 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
>>  					 topology_logical_die_id(cpu);
>>  }
>>  
>> -static inline const struct cpumask *get_rapl_pmu_cpumask(int cpu)
>> -{
>> -	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
>> -					 topology_die_cpumask(cpu);
>> -}
>> -
>>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>>  {
>>  	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>> -- 
>> 2.34.1
>>
