Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99571465AE;
	Mon, 13 Jan 2025 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750095; cv=fail; b=NsO3HRLzfbvp/t6vDK5EFpD1l4D+oSh7U86ZHb11Wv9OnZMINBGAIt6E7NCSIC9Px1wGDcKfd4GFLxOtp19Oq+V/+6RQ7gnmTlwu7eqQ/W5AoUqnB5kGMDNCC8Eutx7DMU3CCYFB61aRcxg0e4DvSh/NVR19fWg9xI/hJUOKFq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750095; c=relaxed/simple;
	bh=Yij6n6w1wED5GPLnv64WGC2vSPLlbBWpUWK3HxF3HSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D3E/GoJSNgBKEUrdzGYX3bYILesDaB923wq9pXAzxT9Del6OWQ9gAmzb5CW79MjQ3O/jSi3JqwVDoK/jSV1ZtSUiXa7e1RhFVhyjyJ6jL/cX50lwinBHMTSSO0yulwE3pqqLYX58BXtb+B8mQTRQoPxtOwT4czizENOqiHt+/N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=epK0LTtd; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="epK0LTtd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGTNGHNH/i1+bx1ojrwpcNVGduNqBr4lDpJiko+/aAjhL0/f2fdTLETeY35VJSQsANI6RfCYQf+Uii1YhEmChViycVbsrhSDnl98puFZc9WuDQBBlgmmYbmQHzVJF/ibnKvQNVTwRL5Bm2qQIOQYygAm7DFoft+y0elqFAF6xpy978uDN2gzkAaDmWWN01qnMYi+/VKkoI/oaUnfUvlFIZ0dE5R175WhKTbWfPo6mF6/xhz3stsEJZt7bMPnPFKvhD0mi9v6+G3J70fgTKbg2He6BGgRVFMedD5m4Ln0jizVaUI7IAF6p3QWmRy6CMkvfVMrCpL5YuhoatxRA5+wDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=934LnFhWh60PcGUDWqgnonyU7ClVTdpGWJe/ydCrDOs=;
 b=iUjjNPEaXwfBL/Mu2JedC8BTLYxeTs78YNhVh+/ousZXPSpD5+YZ2q6gfQGDvFZEkCBXdgSkB+ywjf//ae7tCNws+TjkYt2syyQpgD5vOsWcHndmEmoKvXq85mBIeHrT3b6o2YoCpPjdEJ5JLZzwF8we/yxHdX7Bq4CVTRe37s+VHOJN+2SgKxv03QudZiNVMoeD1U2FwHjsOl21Fd4eYByLbjISQpOUV2+8/qA/qzpyMI5LHZwKKaGy2qtjiFJxYOluL/ztLH0fiWWrXhwWzkvxOR3qL5Q8KZcN4ogqVd5ePSe+FDsMCQffaLXKFGtIaAz0w7ocExhal1V7gGlczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=934LnFhWh60PcGUDWqgnonyU7ClVTdpGWJe/ydCrDOs=;
 b=epK0LTtdUvDXa6rOS/BU+oyODaWFYftQ3LIJoQQWbzsltFkLtELtCQ9Qm8uC6bwgAYH8CzDPtDsDC55wNvwfKf60rzhPFzjTFNvoat7Mue5v9U3lk/lORDYChBDexqRJRSI65KvL+4a5E6fw9oIk4KPJMrAkfQnLpzngntCXuww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 06:34:51 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 06:34:51 +0000
Message-ID: <98f6108a-3a4f-4ad1-8f0a-a03264f7a2d7@amd.com>
Date: Mon, 13 Jan 2025 12:04:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
To: Koichiro Den <koichiro.den@canonical.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
 irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.dei, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::22) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f1ab0b-1735-48cf-78f0-08dd339c622f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGc3K3VkcVpDNDUvdnJEV3U3RmJtZUlhcTJ6d2VBdDd3aXdMYWk1UUJoQkRX?=
 =?utf-8?B?TU1nZ3dIem9mMWt2MFJMaTlmbWlXa05xdmNtL0FSRDBmYWowOHpoZTJFUTAr?=
 =?utf-8?B?d0UxbE5pRmtUdWFlY1pHNjgwTmRqQ3dLRGxzbWNUSmwxWUMyclc0UEF6cWdL?=
 =?utf-8?B?dkJ2Q3NoQ05qajBlamNENWlVa3ZabTlxWXhaTkh6cm9RZGxqVWVWblBiREFo?=
 =?utf-8?B?eVBrM3kzd0FSSTQ1U0htT00xZnloaVZmeWN6MjAwREJTNkVQMWNaWGhNTFdT?=
 =?utf-8?B?NmhsVzNHcHJFejBCQmJFMWhmb0tzY0U0OE5IOHFuMXNnTFM2OEJaTFlmRFdn?=
 =?utf-8?B?cWxGUnB5dmhNMTE5WnVyT25tS2QzcXAzZWlhQXRSZ0FQV29jMDluR3lZU2do?=
 =?utf-8?B?eSsvTGZCcXF4cFliTDZmYUpnWGZKWE1FcFhaa05PWExmQXduL0Z6ZEtRSGNV?=
 =?utf-8?B?dk9UMEJsbmtuRFhqSHBidC9XQTdKOWx3SXlLaXk3Tmg1M1h0NWVrTmJlNmJJ?=
 =?utf-8?B?TkZMbnhkb1MrNkpudnk5YXhMVHVzb3Rkcm9vb2kvb25JOWMxYjV3S3FqaHg4?=
 =?utf-8?B?a3YvNkJUWE5LYzBOcTN2S0NBZ1FUYmZyL1ZhQ0VBREFRZTdjc3FzZkRSdnQ3?=
 =?utf-8?B?WXc5OUJwa0tzZlltYnZHQXVva2Y1SldYYW5RcGRkaE1FSzhOdGtPcWVlWG40?=
 =?utf-8?B?M1hxdmw0SzkyKzhuNlk4VllRc3U3VkVaZTB4Z0dsY1k5SndibmU3bHI4SjUw?=
 =?utf-8?B?cGl0N2NIdW1rcjNFREtmNEg5SThpekVyRG1JaVRpUmRRNTRQMEJDbUxaYTl0?=
 =?utf-8?B?UjBYSkRPSEcrdkxoZDJwcGFVY1FHQmEwalpzVTUvaVpzbkNNT25DQ2pUZ09p?=
 =?utf-8?B?Njk3RDA5eTJ5ZGpJY0hVWGphVldlUmVNS2pFbmZIV0pERzlQbzFtOVVETUNZ?=
 =?utf-8?B?bEJiWW1FTG9BZ2pYR1NyZnhwdnRUSnJtWCtpSG1xR1F5dlA4Y3pVbnJmMk5B?=
 =?utf-8?B?Wi9SQ25mMUZxZit4byswRDJPblZaNE1zVmxyMnpYR0Rqd0xabmVYVHBiNFdM?=
 =?utf-8?B?c1ZYNWlqQVBhMWF5OERKZ0ttbWhOQU5HeFBVOFNLZVpCc1hsR3ZITmlDRGVj?=
 =?utf-8?B?ZnJUSWVZNFFWNStnL2svR3c5NjhBT0MrSlJHRm0zMXI1cHV3dHFqcFhDcEhQ?=
 =?utf-8?B?aWVzaVNvWWRzYytlU1pGYTNPaDBpNlJZOFdySkVyV2kwZ1FIQjZEc3RLZGdt?=
 =?utf-8?B?ZFQ0Vzk1Q1piZkRhTGVWOU9jdEJUWURxOVhLYzVmUHNYTlE4N3NuTlA5blhB?=
 =?utf-8?B?azlrMVhOVU93eUxUWWZpMHZ4OVNpYVk0MnlEVWlucGo3MVdKRHd1Y21PcTgx?=
 =?utf-8?B?VVdnU2toVmFjVFZRS0dxaXIxZ0l0RjhTYk96T3VsS05kUnFaK0QyOGFIUThk?=
 =?utf-8?B?U1lNbTREeXpsSWEvUmdIdFU4K0REUDNoVWR1M0ZDQ1NQYjVFT3BiQTRGUjhH?=
 =?utf-8?B?VFVmQlJIOGM2bXVLY2ZYVTdORkRua0xaVTFZMnN2bVlSYkxIMjlTbjFXWHpz?=
 =?utf-8?B?V1lJOVorbkVoL3FBVXpETGZoQjFnVE42by9GN0NFZFd4TUlqUWJOMitqYXdK?=
 =?utf-8?B?SnZZbzA4TXYvT2RacUNzMlBJRjQxWjdrUnVHRHRVdFBHM2Z1d0t0NDRJOCsz?=
 =?utf-8?B?aDJCV3daWXBJalhrdHpFODJ0cXMwL1luM3Z4SGJ5THljaE9McnRjMTN4aU9v?=
 =?utf-8?B?aGx3T3BlWFZJaCtHRDRreTkvZ0NGZlUyeG5MTWhZR1RhUWt1S2M4MU5YSnNJ?=
 =?utf-8?B?cEJFK2FvVmlhNDRpL3NKYTcvRE5TbGE0L1AyVTFkSGZMVmhzbTdSMG9ab2Vw?=
 =?utf-8?Q?Wnt8b1jviv3Ym?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXA3aE1mcEMzQ3B1U1ZYUGZNV0g2VEc5bkJUY0pVK3VFbVpZVkNIWjhEZzVv?=
 =?utf-8?B?UnVESVladkFJRmhSa1h5Sk5WMTgvV0ZyMnFNZVYwUndiTXJtWHY3QlVXOEhs?=
 =?utf-8?B?MzRNWGlOekZ0TDhMVjZwQnhSNWVxenp1QXVUWlMvWmlPaFZPb1pOL0J2b29J?=
 =?utf-8?B?TzViODNTMWxwUEpQQmFaYVZJbU9lUWNQYVBvNWppYTVLaXBPaGxoMVBldzU2?=
 =?utf-8?B?b3F2eDBEcjEydnY2SndLbHZ5SndVVmV5WTQ2ZFJNeVVnRWgxQnFMRXc2TlBY?=
 =?utf-8?B?ZTVnYXUzOFJNUmlnYWJyNFhpUzB2YS9XSXJjL0FvQWV2MVBUdjVsb1IzYnBz?=
 =?utf-8?B?U21wK2RZVUtUSTdCWmh4WUZRL2t1dVV6dU5oalRPL3JtNGRDR1VkRDZFY2JV?=
 =?utf-8?B?UllMeFdEUHcwV29Nb2JzM01aTWhySmRPTnNuRHR0L3IxVWM4NXZndDlEZjJt?=
 =?utf-8?B?L2w0WmtJOXVhbDRZWWVXVzlnWnFyNVRNb3lMeFVDZGVucmN4TmZ4TERRQ21O?=
 =?utf-8?B?bk43dW5Da3YzTmdCSy85ak5DYzgzaGJScGNuZG1OTm1tcGdwZzdjYktvWUVs?=
 =?utf-8?B?NEo2Z0t2aFlyTjlFSWZCa0t2RkFROUVjbkpvb2RlVktkbWZUZXlGbXFmUXNB?=
 =?utf-8?B?bEcrdGJvN0pScEFsNHhZZ0NmV1dWZloxYVpCTGQzZk9ZcWl0UHNQS2dlZ2lO?=
 =?utf-8?B?YnBqTk44NHRzbVliTVpwakZvc3B6aU9vV0dGTjZnMFBxUGJWbUZmSDN1b2hz?=
 =?utf-8?B?UlgzZVJUT3hGbVc1T2JMWFdhOVN1VUJFL2hXNVNqOExCQTd4ZzdtVUcvZi9J?=
 =?utf-8?B?Vm5odHZzbHJKTmVrdjlsTGl2MDZodE83ZzNoZW50azlLYlgxYm9HKzhDYWhm?=
 =?utf-8?B?K1EraEM1TFpFNERsVGtFWXhQaXh1eHJldGxxaTJ0a3h0ZXFiMnZkVkQ4Szdu?=
 =?utf-8?B?ekNpb0pJQ1Zjd1h6Y05EbEYwVEVkWnlualI2cW9RNFB2YzNWS1N4bkNQMXRp?=
 =?utf-8?B?N1pQVXVjTkZhUGIyWC9vQmVxak9Jdk1QYzVKd2t5WGRMQjIwNnIySmJDOERa?=
 =?utf-8?B?SndwTmtIcENkc3k2RXhIQ1BZV3ZpaEQyRGFsOVFOcnEydCtIejdxOXhWMnBw?=
 =?utf-8?B?eEtCU3JTVjZudXhwMnlMUE50N3JDTmloQ05qa2x5azZDS1VJOEwvSVRWUVY5?=
 =?utf-8?B?N2d5ZERKaVUzMllIcXMyOXBhY3Evd25CMnBObjZzOUZMTitWTlZZd3h6d1Nk?=
 =?utf-8?B?U0RiK2FjcEs4K2FzZ3NZRk1qc2FCWHhSdUdWT1lrUVV6OS9KQmI1MEtPOExF?=
 =?utf-8?B?dDlwUTBIbnVQSUI0WGVwTENoNU1laERTb3dxYUhhSVJuRThRYWNrMktnUENw?=
 =?utf-8?B?SGVsUHUxekpPaU1XU0JrOVRvbG1HRXo3bFI0c3k0S2NMWTZDZWVHTDQ3OXla?=
 =?utf-8?B?dUg0V29qYjF3TmJOOC91TGtqTmpEL0NrSFN4a1ROWktvK1ZNbGdRVE9ZSXZ5?=
 =?utf-8?B?dVo5MTBWUFpYS3U0Yk5lTW9mTzNneGpoQ3dvUnJXK1JvYVVSam9vZUVsVEE1?=
 =?utf-8?B?dDdEdEtFOTh1c2J6UVRsVGJnZGl3NkZKZVBQODdPcDhWY3h4TWFOU25YaVY2?=
 =?utf-8?B?TzVQRVVtT2NnR0VmeXZnTnk2MUhOMkVCUDlXaWZZb0RuOXZtbFNOeGZTTURa?=
 =?utf-8?B?cElVV2lqSVlHS21QaFc3RW1tWmhLa0QrWFR6eFdwOWt0YVErRU9ER2MrbTZa?=
 =?utf-8?B?b0V6V1d3TXdqc1RwMjZUQmRkSmwwcDN5Q0FmaE1vNHlQVDVRT3dvYlhFU3FM?=
 =?utf-8?B?ajlRUktTR29EYXJJL2QwU2RWTUNmTVZVT1pmZ3JUMTlrWDNNQ1VOZ29CQXhk?=
 =?utf-8?B?Sy9vdDVJdWdtMVh3UXFOdnp0SzB2cnZoSzFzWEtTZVlwMVRjNVMvdkdPQ3Q3?=
 =?utf-8?B?ekRyWUthdUNGNW5kd0h2WE1sczRTbmJyLzVtaXlsU2RxTTk0U0w2S3hFNGMw?=
 =?utf-8?B?R3h5Zk41d25kQ2hIb3EreVJUMzF3RGdnQnJlMlZvS0lmSkJpOGloWDQzMzBR?=
 =?utf-8?B?eElhRXNBNXNOQnYrVzE3dUxUQytIMjNobkhzR2RodTFnRGdpelBBeXdXYk96?=
 =?utf-8?Q?RlqZr+6ulQXbq4fc1XUg3i9vG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f1ab0b-1735-48cf-78f0-08dd339c622f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 06:34:51.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6X5pTg1O+b+hwoYgUgrYDkD843BcbnAKONPXq8OTPGCLavOYltVFqYStr3KPtoKr42GUnYp2gyd7+jD24sn6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294

On 1/12/2025 7:12 PM, Koichiro Den wrote:
> On Fri, Nov 15, 2024 at 06:08:06AM GMT, Dhananjay Ugwekar wrote:
>> Add a new "power_core" PMU and "energy-core" event for monitoring
>> energy consumption by each individual core. The existing energy-cores
>> event aggregates the energy consumption of CPU cores at the package level.
>> This new event aligns with the AMD's per-core energy counters.
>>
>> Tested the package level and core level PMU counters with workloads
>> pinned to different CPUs.
>>
>> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
>> machine:
>>
>> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
>> stress-ng: info:  [21250] setting to a 5 second run per stressor
>> stress-ng: info:  [21250] dispatching hogs: 1 matrix
>> stress-ng: info:  [21250] successful run completed in 5.00s
>>
>>  Performance counter stats for 'system wide':
>>
>> S0-D0-C0              1               0.00 Joules power_core/energy-core/
>> S0-D0-C1              1               0.00 Joules power_core/energy-core/
>> S0-D0-C2              1               0.00 Joules power_core/energy-core/
>> S0-D0-C3              1               0.00 Joules power_core/energy-core/
>> S0-D0-C4              1               8.43 Joules power_core/energy-core/
>> S0-D0-C5              1               0.00 Joules power_core/energy-core/
>> S0-D0-C6              1               0.00 Joules power_core/energy-core/
>> S0-D0-C7              1               0.00 Joules power_core/energy-core/
>> S0-D1-C8              1               0.00 Joules power_core/energy-core/
>> S0-D1-C9              1               0.00 Joules power_core/energy-core/
>> S0-D1-C10             1               0.00 Joules power_core/energy-core/
>>
>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>> ---
>>  arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
>>  1 file changed, 152 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 6e51386ff91f..e9be1f31163d 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -39,6 +39,10 @@
>>   *	  event: rapl_energy_psys
>>   *    perf code: 0x5
>>   *
>> + *  core counter: consumption of a single physical core
>> + *	  event: rapl_energy_core (power_core PMU)
>> + *    perf code: 0x1
>> + *
>>   * We manage those counters as free running (read-only). They may be
>>   * use simultaneously by other tools, such as turbostat.
>>   *
>> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>>  };
>>  
>> +#define PERF_RAPL_CORE			0		/* single core */
>> +#define PERF_RAPL_CORE_EVENTS_MAX	1
>> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
>> +
>>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>>  	"pp0-core",
>>  	"package",
>> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>>  	"psys",
>>  };
>>  
>> +static const char *const rapl_core_domain_name __initconst = "core";
>> +
>>  /*
>>   * event code: LSB 8 bits, passed in attr->config
>>   * any other bit is reserved
>> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
>>  
>>  struct rapl_model {
>>  	struct perf_msr *rapl_pkg_msrs;
>> +	struct perf_msr *rapl_core_msrs;
>>  	unsigned long	pkg_events;
>> +	unsigned long	core_events;
>>  	unsigned int	msr_power_unit;
>>  	enum rapl_unit_quirk	unit_quirk;
>>  };
>>  
>>   /* 1/2^hw_unit Joule */
>>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
>> +static int rapl_core_hw_unit __read_mostly;
>>  static struct rapl_pmus *rapl_pmus_pkg;
>> +static struct rapl_pmus *rapl_pmus_core;
>>  static u64 rapl_timer_ms;
>>  static struct rapl_model *rapl_model;
>>  
>> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
>>   * Helper function to get the correct topology id according to the
>>   * RAPL PMU scope.
>>   */
>> -static inline unsigned int get_rapl_pmu_idx(int cpu)
>> -{	/*
>> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>> +{
>> +	/*
>>  	 * Returns unsigned int, which converts the '-1' return value
>>  	 * (for non-existent mappings in topology map) to UINT_MAX, so
>>  	 * the error check in the caller is simplified.
>>  	 */
>> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>> -					     topology_logical_die_id(cpu);
>> +	switch (scope) {
>> +	case PERF_PMU_SCOPE_PKG:
>> +		return topology_logical_package_id(cpu);
>> +	case PERF_PMU_SCOPE_DIE:
>> +		return topology_logical_die_id(cpu);
>> +	case PERF_PMU_SCOPE_CORE:
>> +		return topology_logical_core_id(cpu);
>> +	default:
>> +		return -EINVAL;
>> +	}
>>  }
>>  
>>  static inline u64 rapl_read_counter(struct perf_event *event)
>> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>>  	return raw;
>>  }
>>  
>> -static inline u64 rapl_scale(u64 v, int cfg)
>> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>>  {
>> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
>> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
>> -		return v;
>> -	}
>> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
>> +
>> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
>> +		hw_unit = rapl_core_hw_unit;
>> +
>>  	/*
>>  	 * scale delta to smallest unit (1/2^32)
>>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>>  	 * or use ldexp(count, -32).
>>  	 * Watts = Joules/Time delta
>>  	 */
>> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
>> +	return v << (32 - hw_unit);
>>  }
>>  
>>  static u64 rapl_event_update(struct perf_event *event)
>> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
>>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>>  	delta >>= shift;
>>  
>> -	sdelta = rapl_scale(delta, event->hw.config);
>> +	sdelta = rapl_scale(delta, event);
>>  
>>  	local64_add(sdelta, &event->count);
>>  
>> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>>  static int rapl_pmu_event_init(struct perf_event *event)
>>  {
>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>> -	int bit, ret = 0;
>> +	int bit, rapl_pmus_scope, ret = 0;
>>  	struct rapl_pmu *rapl_pmu;
>>  	unsigned int rapl_pmu_idx;
>> +	struct rapl_pmus *rapl_pmus;
>>  
>> -	/* only look at RAPL events */
>> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
>> -		return -ENOENT;
>> +	/* unsupported modes and filters */
>> +	if (event->attr.sample_period) /* no sampling */
>> +		return -EINVAL;
> 
> Hi Dhananjay,
> 
> On linux-next, since this commit, it seems that simple sampling with 'perf
> record -- <command>' (i.e. the default event), 'perf top' etc. can
> unexpectedly fail because rapl_pmu_event_init() now returns -EINVAL instead
> of -ENOENT even in such cases of a type mismatch. I observed that this
> prevents evsel__fallback() from falling back to cpu-clock or task-clock.
> 
> Should we reorder the checks in rapl_pmu_event_init() to allow an early
> return with -ENOENT in such cases, as shown below? I'm not very familiar
> with this area and I might be missing something. I'd appreciate it if you
> could share your thoughts.
> 
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -370,17 +370,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>         unsigned int rapl_pmu_idx;
>         struct rapl_pmus *rapl_pmus;
> 
> -       /* unsupported modes and filters */
> -       if (event->attr.sample_period) /* no sampling */
> -               return -EINVAL;
> -
> -       /* check only supported bits are set */
> -       if (event->attr.config & ~RAPL_EVENT_MASK)
> -               return -EINVAL;
> -
> -       if (event->cpu < 0)
> -               return -EINVAL;
> -
>         rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
>         if (!rapl_pmus)
>                 return -EINVAL;
> @@ -411,6 +400,17 @@ static int rapl_pmu_event_init(struct perf_event *event)
>         } else
>                 return -EINVAL;
> 
> +       /* unsupported modes and filters */
> +       if (event->attr.sample_period) /* no sampling */
> +               return -EINVAL;
> +
> +       /* check only supported bits are set */
> +       if (event->attr.config & ~RAPL_EVENT_MASK)
> +               return -EINVAL;
> +
> +       if (event->cpu < 0)
> +               return -EINVAL;
> +
>         /* check event supported */
>         if (!(rapl_pmus->cntr_mask & (1 << bit)))
>                 return -EINVAL;
> 
> Thanks.
> 
> -Koichiro

Hello Koichiro,

I tried reproducing the issue you mentioned using "sudo perf record -- sleep 2" and 
"sudo perf top" commands on an AMD EPYC system, the commands worked successfully. 
Can you please mention which system and which exact commands you're 
running that reproduced the issue?

My analysis is, if we are running "perf record/top" with the default event, we would 
not enter the rapl_pmu_event_init() function, which renders the reordering of the type 
checks irrelevant. Regardless, please let me know how I can reproduce the issue.

Thanks,
Dhananjay
