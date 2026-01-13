Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121AC1E8342;
	Tue, 13 Jan 2026 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273895; cv=fail; b=PDmWkiCJ6VstS4+/S8z17+Eonua1S9UsW/qhAbJ263jnspj3SUmpQNdoZ/OuU/HzgzrdAT/msHbNGanGXmh43GWFwVKHfVo+4CvBR0IMlAhZXqRfSPzMw1BifGrU6Hmvx+k0SOHyHPign5/w4r4HcJG/VWxHnZTwCpIV2YhnBjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273895; c=relaxed/simple;
	bh=qkfUuJ1U6pc/ezWMUmv9/e+Yj3sK1xl/xqIl4x1rEBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Voiqn4M5B2cSJ1offnKqy+x22m68KtvWXaqcF12gQpR3j3qXtt7XdbM1Jsfe++vMZElxfxIhVNQgHQJ+g3LkClBw/25Jh8MThhkMz/oS9//sdPYeTNU2qMV5/HGi7qBCTCq7Gy/ow7YvCzYC/gIaHSgrdIEblU+H9Mb+z4SUXiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B7CB1KTM; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7CB1KTM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7AvjATngLkf3P3DckzGFAKvglawbZVtYX/IsaNKuE0N+2cRhHPfZkD6sf4CXHh7PpmIlDmSb3hOuRx65YDoBcxmmjNouvPJaHBWkoEl8LlQmzcTto3NAsS0VT/8PWOrvCy7BiQioAxzWRiCUy/2fH9ZwYEy1QRplYctS6c6ADfenEx9jEg1quiRTej0JHC3rVm1Zl60+CnuRcDSnAbvHbtsxczC0FxuT98wlneQlQWZr7BfuMEnf4ZUq5hl27PKH0rF/u8ruW7UutTThY7iY5w8mZrYaNS17GpiCGsH6MoAfBglWqLU0A5hiVJk+bZU5D8566ef1UyWqRLNXIo6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ynr7BNHMZ+Q9rsShlRpBmZKkeFqPEm8vBK+KMwzjrI=;
 b=cDQ5yhd2M+F37Ueq93cZMrZ0npcPbh3CiB8YcSIxmClL1dp5NJVhZRzLLFpFrDcV6aXiVqZp//2ZGUT7PIzdOTnAKBkoQ1bpYpf8jmM1Wi9wM9g7EnEbMBiS6pjLERXcwBhT7J6U0Q6R99aPRwqq+Ij+/TfzaXDXrvSMAnfygfa0lXN8rcuALeN222N3etYsrNgnnvfrKYK/AV6TosnbRtrgKwE66tVeS6nUOrFsu/s757HRPTk3FDTC6DDJfHV5Eyv0N3mx9ZwpdqBpjkLtDuzSF0LTQZqFc5kFDt8vRRMR4cZSFfYFehl38vBImJlDrQjuXVGFfi8G3G2ikbCF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ynr7BNHMZ+Q9rsShlRpBmZKkeFqPEm8vBK+KMwzjrI=;
 b=B7CB1KTMZBw8ZXsEFUKJ5BfgIseTTE60qRYVGNO1HIfBQBI0UCgkOu+VunggLOG4vxNrCTH5VKq3hq2Rj2ZyM/jpOBSB8GAu4c7Qxo/xBCuUdsRHRsQxAl2ULIwV0e+kNJ5ToBn4wCNcgd+dn4EG1+T5i8StBFEhqTnLMwoOP40=
Received: from BN9PR03CA0255.namprd03.prod.outlook.com (2603:10b6:408:ff::20)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:11:29 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::3c) by BN9PR03CA0255.outlook.office365.com
 (2603:10b6:408:ff::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 03:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 03:11:29 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 21:11:29 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 21:11:28 -0600
Received: from [10.136.46.14] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 12 Jan 2026 21:11:25 -0600
Message-ID: <fb38d19e-f4b4-4f89-a41a-78a845861468@amd.com>
Date: Tue, 13 Jan 2026 08:41:24 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: fix segfault in `lock contention -b`
To: Tycho Andersen <tycho@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <20260109164417.396138-1-tycho@kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260109164417.396138-1-tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 03dce0cd-1559-4e41-f319-08de5251720a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWxZVis5NGg2MVRLMW9VbmhJeUFnK3V0Z0lZODVLbjNSMG5LL1IvY0R4OHJN?=
 =?utf-8?B?amp4eDVYMXRMSzJNbVQxNlp0TzhDYnN4RXo2VFUrZXcwQk5VbFNIK2I3SnhU?=
 =?utf-8?B?dk51aHFTMi8yRit6S3FhMnliU2QySk9UNGNPamZJdXpvS3NEVjdXdEdUTmNK?=
 =?utf-8?B?MUtXUHNxZUQ0dHVpdjU1S0FoL0hDTksvMVdLRFB2S3ladjhNNEFVRUJjRjVr?=
 =?utf-8?B?eC9DTVFMWXdrNldidG5yMVFPSVFScVpjRFBsNDZXOHZvUnBRWEJ1U3VYandm?=
 =?utf-8?B?OEVxTGlZVXoyVUoxMEtJTVRIa3phS0JJTEN0bFRvZy9tUnVPU3VwbmNKSTNY?=
 =?utf-8?B?YmtTNE1SRTJtdGZDVmQwY21Fci9ldEdPaTVGenppNC8zWmtTUFJkd3JxeHJw?=
 =?utf-8?B?ZFFUYk5HNTIvZGpiRmd5QnoyNFlRbzUyVGFsN1NaOWhKdjI5S2Mxb3hBNFQ1?=
 =?utf-8?B?eDlrUmV5TVlzdzNaeWNaM21VdUVyNitUdUNaVlowWExTalNLNjFhQjkvZExK?=
 =?utf-8?B?aWtrR2E2THlITkY3MWtUektWY0NwT2xtTHFpM3luSzZQMEN3RDE5YzFoWjFy?=
 =?utf-8?B?a3gycWhqcit1Q2pyYzJXMmJKNEZxSzRBRWkxUmVkR1FzZFY4a1VVTVBtdlJV?=
 =?utf-8?B?NGpsV0hnM0NkUzVqRGliSWI5THRrS1lha0hFR2FBL2JlOFQ5aElBeVpDaytt?=
 =?utf-8?B?YVpmS0NrVGV4TXBpT2xtUzJRT1c4Sm84TE9odDNhUFd1VVg0eTFHNG1YNElh?=
 =?utf-8?B?N1FMdkdka0F3dlJ4ak0zeHdoZ1M5YTdETTdTQkg2cmVKazNyTTM1bXo1Mkpo?=
 =?utf-8?B?QWd6VHBlQXNDVFlYdlFqbmtBWEFqQ2VKQ3ExQk1SUW1TcUhwQXVOUEJvVUtH?=
 =?utf-8?B?cEdqOVJuN0oxa3VOS0MxN29MSDhSQXJIN0RSZUozS2FFYXN5T1orM0hCaE5k?=
 =?utf-8?B?d0lrUmZ4SWhEV0gycE9QNnRDU1M2NnZ0SEtvZ3MyYkZaRFdDQVZkeDFJVVM2?=
 =?utf-8?B?WXQ0THpzWDVkVGZqT2NXWjBzcEhkbXlXKzBxaDRmYUZvbDF2Sm0rVU4vaEJj?=
 =?utf-8?B?Z0w2SUdnSEVUbmpxMTl0RTY0U3RvM2pUYTBPR3hsMEllcWg5dHFoSmMvVS9S?=
 =?utf-8?B?ekdWdENzQml3Sk1NcVQ4TUN1ZE96RVptTUNic2ZxZ1M1Y2Q3bGdGcXpUSVB1?=
 =?utf-8?B?Wi96QWFGZGJ1V1hRZDJLcjROU05jVGtwWEErVnpJYkVzNnRxZmxGRmVtMGdC?=
 =?utf-8?B?TWlyakQ2RldNU2xoK2xqcHk3SEdiZ3FrUDhDb1ZWdm94aHRmdmk4dy9ueFp3?=
 =?utf-8?B?NVhUNDhRMXRTZVZMQ2FSVlV6Zk00UUJOYlg3VlhNWWFhRTFxNFBJbXZIY205?=
 =?utf-8?B?VDhvbEhsNHFYbmtTRnFVaHpYSnpHL28vQk1nZVlYQTI4SW5nR2JGNzJITkxl?=
 =?utf-8?B?QkI5amJadDFKZlVOUWpzK2NsRUtHcy9kTHpKcjBITGRGV3BYcHlLTmsvcWc3?=
 =?utf-8?B?Y016QzJDczJVa2xUTUxqdzU1b2FkbGdKc1ZUOWE0clFsVTVrd05Cb1JZKzM5?=
 =?utf-8?B?OTcyRGVDaFdacUNHRWU0YTNDdU1ROFpneTFuVUlYaFY2U1RHdjBhUmFyd01D?=
 =?utf-8?B?cDdCUlRqRE9qMGlreGtHM2I1OWtVMkVuUkZ5NVM2ek5CYWZBSWJ6NkRZdTI1?=
 =?utf-8?B?d0VRbnY4aVptR0xsY2FlaGlNcmFibW5lRjFJckhCOXo1ajJ6RE9CUVNtRjUy?=
 =?utf-8?B?SUxTcmlJd2N4MUFPVy9GcHFha2JON1VYOERvYklXUDh1M1gweklLUXcxeHVM?=
 =?utf-8?B?cVZIYXo2UExRVmdPSWFadFB4L2FCY1liQ1RzU0tQbmVGdEJ0Z2ZwK0JVTkRE?=
 =?utf-8?B?T0FQWlNkd0Zab0w0VGFWRkkxcFRwaURIM0Y1RGoralFBOElqbkp6UXpHeGRq?=
 =?utf-8?B?ekFITVRHUk1VM1RWL1hhaGM5bmU4YXk5MjlRbGE4SEd0ZVJsUGxsTHF3dGJW?=
 =?utf-8?B?OTlSeUJQd053Rzg1RE9YemNXOWxFeFE0cDYvQ0M5QnljMER6dnBsTGx2TUdL?=
 =?utf-8?B?MDUwVlFZOU45MjdrZWYzOHpNTWxoZVIxM21JcHI4c0NiQUMvYWg2cDE5a2NE?=
 =?utf-8?Q?bRxc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:11:29.1937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dce0cd-1559-4e41-f319-08de5251720a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644

Hello Tycho,

On 1/9/2026 10:14 PM, Tycho Andersen wrote:
> @@ -43,19 +43,20 @@ static void check_slab_cache_iter(struct lock_contention *con)
>  	con->btf = btf__load_vmlinux_btf();
>  	if (con->btf == NULL) {
>  		pr_debug("BTF loading failed: %s\n", strerror(errno));
> -		return;
> +		return -errno;
>  	}
>  
>  	ret = btf__find_by_name_kind(con->btf, "bpf_iter__kmem_cache", BTF_KIND_STRUCT);
>  	if (ret < 0) {
>  		bpf_program__set_autoload(skel->progs.slab_cache_iter, false);
>  		pr_debug("slab cache iterator is not available: %d\n", ret);
> -		return;
> +		return ret;
>  	}
>  
>  	has_slab_iter = true;
>  
>  	bpf_map__set_max_entries(skel->maps.slab_caches, con->map_nr_entries);
> +	return 0;
>  }
>  
>  static void run_slab_cache_iter(void)
> @@ -301,7 +302,8 @@ int lock_contention_prepare(struct lock_contention *con)
>  			skel->rodata->use_cgroup_v2 = 1;
>  	}
>  
> -	check_slab_cache_iter(con);
> +	if (check_slab_cache_iter(con) < 0)
> +		return -1;
>  
>  	if (con->filters->nr_slabs && has_slab_iter) {

nit.

Now that lock_contention_prepare() bails out when
check_slab_cache_iter() fails, we no longer need the "has_slab_iter"
global indicator.

Both this, and run_slab_cache_iter() that depend on "has_slab_iter"
will only run if check_slab_cache_iter() succeeded and the global
indicator will be true in both those cases.

Can be separate follow-up cleanup.

>  		skel->rodata->has_slab = 1;
> 
> base-commit: 5572ad8fddecd4a0db19801262072ff5916b7589

-- 
Thanks and Regards,
Prateek

