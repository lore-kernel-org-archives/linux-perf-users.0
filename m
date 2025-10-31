Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021095.outbound.protection.outlook.com [52.101.52.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0DB2FD686;
	Fri, 31 Oct 2025 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938750; cv=fail; b=Sv0pbWAxwq7yboeLViwEg1/ihjCUTtIRH7coNnrcDfU/JA1obHtRVEiruYMsMBtyPwhIJ2yCvS31pCbgR01N6QAWrSC/uvnRHeAqhSMASk4c1PkCvfa7OXQRbBZ4LUtMhuo70EzmmUckJqRdJH7Kl2sTnmvf5ZOV7Ybbp5pRUmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938750; c=relaxed/simple;
	bh=fwaTw8kqTdZUfZ0KA/ewynRTXR2n04e1dFoVwcjga9I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=NUpd4ZaJlaIcl7tJlZ+8wea842lfsSiGgToNoxrKnuBXzT/3LR2Nfy5RVDWLAFIBQg70qEateJtitieYbnCu12ulgWLY/ZBWjbUORhznLK/HFpS0lq+t9OrpG8GLIifSHXQJEfPHy1kCnIcJ3epVDAz5LQ0pfiQSpwkr3Pykihk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gRNBtql/; arc=fail smtp.client-ip=52.101.52.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gRNBtql/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSCcyAQ+ye8yiW8SVfpS0xmF6k0lBJAkl8DRa2uiixqflS7a9wrW2xBevBq9tqV+K3x8BPLhGRt9omEBUcDnhmWnrrVMzGLXOEvD3onxfh9+27jRxK3TN/DnPz356eiF1kCjmopKv40xxorQK3Iww2ykW2ULsf5sJrhbaEDIX+LcJ3GwsdA6z4SdP+1Tb+qPqR8rHr5PNhKbpaIHTvIUj6C4c3BkIPkdFUHh4qgr7RfZkSUxM7EG3/+Bb76PQxn+cOyO3LfXqsHHW+G/u6WTJkeJPuPQnOR03Bk1DVuVPt04XrTuT+sqleO9xvriOMAPd9aT4iNdjFp/bi7hrbzsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phzp5sFL2Ropv9wCJ0xAGRmgJTb4WGeLYwb2gMxchlk=;
 b=zPPw4+JoZn+bJHebAnHa/P8c9lA8I7hH1hjyps3ULjTUE/tL93xb0HFFLFT3eLD00M6tWFTh2GODssHkbVZtOo1/xqMPXIhkZ5vVIZZwCCsnA6r7yxnC4WS6YjBhIOxDDLES7Q5iaH0GtXqJ2eHCnuwhtPSPqmN5rPXj/HNUC1HaGqd4+M+oud53lKjEfSYd6b8FAtQTpeQDVPOsu2N5NeG92YJgQR641SGhlrnxUyVzyGOHZxR2XNnb9+2WpkeT07a1mUGRZ/a8/FeX0Wq0VHo7WWKNE6KJtBBqniWQJa10fUDeA7NLfcic9oQSEuT3zfLsrFgCx+Ys1cGG/cR2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phzp5sFL2Ropv9wCJ0xAGRmgJTb4WGeLYwb2gMxchlk=;
 b=gRNBtql/Yw57RRsBSsQgQkL/H1bK2mm46F5d/C3U2nQF664j30xzlRH7FOizAlnRHmRrpuOI9Cff5F92LCzBUfM9rS2cqA3FaF569P1Huoar0AyGTtcxAOfxM+AEUA07NZxbL4RsmRRaBQWNYC1p4tDVgrD9QaBUAOEyrli8C64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CO1PR01MB8889.prod.exchangelabs.com (2603:10b6:303:272::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 19:25:40 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:25:39 +0000
Date: Fri, 31 Oct 2025 12:25:37 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Chu Guangqing <chuguangqing@inspur.com>
cc: john.g.garry@oracle.com, will@kernel.org, james.clark@linaro.org, 
    mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org, 
    mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
    mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
    irogers@google.com, adrian.hunter@intel.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix typo error in json file
In-Reply-To: <20251031031729.2304-1-chuguangqing@inspur.com>
Message-ID: <0016eecf-e261-a16e-461e-5f7c40705060@os.amperecomputing.com>
References: <20251031031729.2304-1-chuguangqing@inspur.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CO1PR01MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: b24a61c0-40ca-47e4-ac28-08de18b346b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HySWG873xYGkdUX8zgvmIiy/unebfncWoTwuvuTOTQwBf0Q1Tw4TlAKNQtSg?=
 =?us-ascii?Q?FOnkUdB3nBvXIL8tUHNPdLXLubINe73oY+jOEFpzBFUgUIS4M3q/k5CXK6e2?=
 =?us-ascii?Q?1x22c3e46Dfr1Z3tEnhqGH252qrM7qfNx6AozBl87rGM4av/XqoUtylHaurx?=
 =?us-ascii?Q?31Povm4MIy42v7uraYhBHDYPCWRnfsGNyWsYsEBJpdoxrLqrlGaLUl//3OZN?=
 =?us-ascii?Q?ssZKM+SQlTEHB2B9WurI3TGUnF0bOliM2sRR0XLJqXjbXZCJIsSHc8VIswaP?=
 =?us-ascii?Q?FdXIXAIITBUpQIYHGZi3Nw39LcCIX3NsTere+0EVUiCXWJGe5ZHb8V1r/HCg?=
 =?us-ascii?Q?OEyjEg0903386Ggud2VVAl7qiiwzs2FCI3zZWggvRkUENN8Hn2uZ4FRumsyJ?=
 =?us-ascii?Q?F3ChjG4zvc3i7R+t3ixyggZyieTzFd98ake00vET2ho4Qxg1xGi9rE3TzR7V?=
 =?us-ascii?Q?f8wj/N4+wxBpsR2+xozdRk8K8MADjpu1qZXeRoih4fRZ5C/I4uoHNiaazGQK?=
 =?us-ascii?Q?dHRfSCJQu5ZqB6dlXdeXLJjhwXpD+L74qBjC0WnXaXxIEcKH3WhJ6DTe3dhS?=
 =?us-ascii?Q?qiGvnlTlUUW0vfCAZbJCG9RDeTQLxjdwJ13XXxV8qF+JsA/R2eG4NZMFWZQt?=
 =?us-ascii?Q?YREO+Z6lpc/PbnaO/grBDbSqiKQpqDtiyvvYBWTIVl7OmbfvY8m78TgZc5Bs?=
 =?us-ascii?Q?+0AqgZpfY2q3g2LMQZZh14bbPhHIoWA4j8UJejYHt2ZT4BdtWWEux/Oz3pkG?=
 =?us-ascii?Q?ElAuC2EU+gm0a+a9bhZ6YP+PUqjeT3TnNzcoJFtcENpc9dex7VaEsWqtxZqi?=
 =?us-ascii?Q?R8RqSW3CXrmjMZjony0RZrRHQ2j+D3NaH5rVLHIZvlVUF9VgbL/eWoVCn4NJ?=
 =?us-ascii?Q?1yj/e5w9bYSSvmtKq9d17WQKwWf9NxtjRdz2IlSPuWo2hyDDs36rrWYcouOP?=
 =?us-ascii?Q?Y3Yrn3I9DYCyVzwJ7AjxERAbaZFiifttbJK+H7sPB1D57CykidzMWi7e1s0f?=
 =?us-ascii?Q?Mic6dlQXfJfAuLocMno9K7hCqDl4E3/1kn/+9gtl2wIXB/9cLaYc8grnLinO?=
 =?us-ascii?Q?5N590vmR4KQJNNUYNaAJpBiYHIg5r5rb6sEY3aU+iitUsbzC7uzrZ/LfuYRz?=
 =?us-ascii?Q?FsfD6C1iDaMEzYXcvxF6zdrqv55K1wuCQIyGuTLnEyU9WCL24KbHDB/+Avtp?=
 =?us-ascii?Q?4fa+oSpmoC9k8QviggojFsl7U4Lfk/m0E4cV0Hbrb9jhH67wcSD+P+1KSZce?=
 =?us-ascii?Q?HuPuJbfCvozl707bIMgKjxA9qYR+P7FSnulugaI2mUNJ3fx5CsNwhKx79s+R?=
 =?us-ascii?Q?Gw4nFxjP65YJ3Ox1PTjT90yjp48jZ2SSAef1I/yOj0rd43t01qyGmB2a/EiV?=
 =?us-ascii?Q?6Tzq5UFYrzKtX9HF9Ww3nbb6ilm/vuj8HIX/eIZUgSe/MZVXgDI4LRgVheIT?=
 =?us-ascii?Q?KrnNIII2QUX9MIAN9/O+aNneydRljnUe8z0wcpaRFGQywIi7RNSQavetAbwF?=
 =?us-ascii?Q?HBnxUernXybbJJSXvBn8QsBhT+aBUv38LzJX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cm4ywIJqirvNC78EfB7Ww29A8T5mgQU9fYxCtcyGsRXQ9jUGNguYWvmrsXtj?=
 =?us-ascii?Q?oWKRSE6hGv2ZbR81qsbatRN2hO6B3MXpSbJI+CU8zjxdK3cf+rybVhjQxz32?=
 =?us-ascii?Q?brwX5HSM1vjpaDeROCMT/L11Su4Y9SXtK2kz0oYWbXuTicVhWkRpt81k2iID?=
 =?us-ascii?Q?r4nhA96O2f0vG/aaSARWMWlB989/n2dBkEyfQHJp1ZZWt+JJAYCA8gmOV6Og?=
 =?us-ascii?Q?tcy4pIicirFZ5Kw0pAtvxSBP2neQbrGAR6ih1KKZY8jgXiNX7hjQ8BCbIdlt?=
 =?us-ascii?Q?XTbPtHwI47ICiHL1THrn60Mzx6g2ixmg4xD9Lj+e+kss+VUByTe8XtsmSiwh?=
 =?us-ascii?Q?I1mM+IXVBWvdOffIWUSSscZwyCrma2t2g5PstiSMEPigqyrc/5PdyGtbfWjS?=
 =?us-ascii?Q?g6zSK2de36T8c+9Ly7aVRFMJVhn5G4ZzZZSEeXDxxWYswqTrxd/8o0GUkPDR?=
 =?us-ascii?Q?KfSjC4lwihwrdz0dKhbJNMRxecQfUW5dxjxse2EK4UXUDXI4PgzVP/gYv7zS?=
 =?us-ascii?Q?6kMa4D81n8P6dTaFr6mJsKO8XP58Pf2b2hCXo7wwgBShESTqX+1r1ikN6JvR?=
 =?us-ascii?Q?/S7Ro6tiydEaxpK6cXUmJ8XK0eTWocIY88oSFAho0aAuYD00Z5odOIbWcRxK?=
 =?us-ascii?Q?o7CMi6AWCViM4nJwDYokqpie7ydBryvktVNrKqF6kldfj/eQ7AxnbanPaW7N?=
 =?us-ascii?Q?7VvF2XfIatq3FYDNLYUEYGQIXWBgPZRDgUMeaWK/0wV52SRugLkofc4iwqWK?=
 =?us-ascii?Q?x6aEQSTBx3Em+VQFonnlbeJf++h3/c67dOxOZAIsBo59YQ+VEJLJ50PVuY6W?=
 =?us-ascii?Q?IEet4aSR8SgApMNFmzmgBy6eAdL8ESo1oUmm2Cjy4bYk5dCpp/EGwORSrS4e?=
 =?us-ascii?Q?rwG7qI8fe23ZzSERdvUK+4XGz+wV8u5E0qoD9/NBRYatE+AItDHkM0aqqE31?=
 =?us-ascii?Q?s9Ljs8mW3Z/hROzcIahRBKEC8UmWvlsMOuT5U9O0ESh8yw/UyRJ9FMtBkAoX?=
 =?us-ascii?Q?M4JcQfbTwXS3Tj4AyATYK1pscXohUY9QVDO59qI9cGmTZTd5V3lMYPXQupW0?=
 =?us-ascii?Q?pehAK9DBvOXWTg3WSwI5ET+YdWweZ2f65Zf/55Jnd34q0V9nXn2P9QQ4PK6m?=
 =?us-ascii?Q?G/vOu0+oh9jDV7JPwXBK19eoQS7U8Q6fT/aUiqKYFPu/hHObRX2rfVqVxCIQ?=
 =?us-ascii?Q?yEsmC2YAGIU7Kv1ncquBf4oyI2rCQantet1fLknOK6/Br2hemZfQ60jvv1Oy?=
 =?us-ascii?Q?FnzxpT+aAuVdAEWl/UPqE3Bct/5yKSXkKCPdMxAZX61JiDsKBtHVJhLb6yZ+?=
 =?us-ascii?Q?qSrSTUzn6L+UaFarVdMzx7zSTuAmGm/8+BgAmvuPCgn7mdoePg7ZukItgGPR?=
 =?us-ascii?Q?xZcwmuJkr3XAbAFjbk5Zrr2eZ0J+y0U5X9Rh5qGyyTCIbV/7t/i4bmwItvAO?=
 =?us-ascii?Q?1XEOsH/D6XPLx9HfOf6mR9IxplBAIK5DlE9E2TlFA3I2LN4pmQGwPI2QsTln?=
 =?us-ascii?Q?qjrBukZwlDLVJvfKpU0K7vdkL5d5WWMAJ8uGGxPGs7pNGDpjf5k7QXZ78cOI?=
 =?us-ascii?Q?flBAZqj0gbUfbdZR6Dd4/h8RGFgapCSN13k2cAGpm87jQ8+g/NR1b/7fZVEw?=
 =?us-ascii?Q?tvSesZ2MHgSZv7ImcEDOdI4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24a61c0-40ca-47e4-ac28-08de18b346b4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:25:39.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV1mEgkqQOYqAqx9Mm79k9DusA4eiSbVM9y6jpQj2hYcLoBOHa90onxT1ELwT24sD7SIPUjTCu8Bl9WMkTpWon3EUQ9+zk2FfmROo4DQksozBJ35DAiuP6mFo7HXNfV8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8889


On Fri, 31 Oct 2025, Chu Guangqing wrote:
> Correct instruction spelling errors.
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>


Thanks for the patch. Just one comment, would you mind changing the 
subject line slightly. Something like

"perf vendor events arm64: Fix typo in Ampere eMag json file"


With that change

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka


> ---
> tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> index 4cc50b7da526..4001cc5753a7 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
> @@ -81,7 +81,7 @@
>         "BriefDescription": "L2D TLB access"
>     },
>     {
> -        "PublicDescription": "Level 2 access to instruciton TLB that caused a page table walk. This event counts on any instruciton access which causes L2I_TLB_REFILL to count",
> +        "PublicDescription": "Level 2 access to instruction TLB that caused a page table walk. This event counts on any instruction access which causes L2I_TLB_REFILL to count",
>         "EventCode": "0x35",
>         "EventName": "L2I_TLB_ACCESS",
>         "BriefDescription": "L2I TLB access"
> -- 
> 2.43.7
>
>
>
