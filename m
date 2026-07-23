Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B02FE566;
	Thu, 23 Jul 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820539; cv=fail; b=QDpDF5KwfvhnrDzH2LuxhOkzkkLq/+z1lWGfmkOdBkWX9aeJv2fwMzp2iOSBKL0XbWtwCgLJhx2k8HAfVs2RuZlkK4lMpMz8ZcRubB04KXK+AZhMrwigBBOqjLrxSnDN8zWy7UvduT3m8HYQ0QO/JLALwrdrs7wDQL7OJ1SDGo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820539; c=relaxed/simple;
	bh=0PvQy9aCxT3deLhCCFEyn4PUvZJA/VwkkkGi+34VTRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0oP7WWuS21KWldSSqGiBF9TcAZaUjkY4lajYTDBhA7ZSpz+0HiOCEjlVeNSz1SS79C3ooyq6+toX/eX98g2y1qGqdEw6QnQehPE30Ao4Q1MYxbqC8jnoZZLB6jLwM5KOO0UTPFRJEuchUTplKIYBZlVFe8nOPzEMkiW52oEEpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lwh/ZU3EIfgjZGM4lr+VpjZtb1K5JmxEVKreFQG72LXFcCAOfKxzxPdpSL9Eq6xByYwu86FBfNSoA6lYxK3OZdqOc/pupxRaCWy0i6BFDFf6xiNoAEPNJV+KMvOpWsDqV30CbdhG1E68KgxxsNdbs+mAJFd3MxGAg0UQyVTFev32WpOeYb2DGEtxRBot6Ri5r4po993THsfGQ7EpB7KxB0clJZ9Eg4hYz++R7tbCyDR4OBlTRbOSkGZkYSsY5e8HHPffgnB37Xqu2Vt9m56B/BzD6gaJYHdE1zF7W2iVo+bX+QiwnCzP5T1MyXi0B32tSDgUAFjfted7n8KwxquqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kvrbXKD9mZFOXX3bOB8zn1gnK+jKM9cOBNucvNb0jlA=;
 b=WUyk3zGdW8xL6m1JJ27VF2g1gBjWeYjC9WxyGrw8OqMfjZ4kmYQ8lq/f8RAnhW5sh/q81LrMBf5XiWJajVfyxQzyyarNyLjQfyOGbJMD4PoDNfRFOl0mOD5N84wVUoPitPl4RyHAtWJqSE8HqrWIY+Mjd8nBfo27aIdhB1nAt2tc3BmTE/IIJrQviBjVFuCjXDiqjhqWi5gXXtqa71sUOiNCu5lDCCPLFbh5a3+X8gbjm2HE+l0RiTHwMKCuR9wN2MFarvYtbpak8Tl3IVEtVW1f5VgBFH4VNsuimHo5bdgML/h7ybWpoYnIJGmPGX24arWsIiCjCz+LZXC31k0usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3374.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:28:53 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 15:28:53 +0000
Date: Thu, 23 Jul 2026 11:28:48 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, steve@abita.co, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] perf trace: Add --bitmask-list command-line option
Message-ID: <kick2ndzn7nisgdnxjit2tp6tfyub3nor54dbgqxqwy7ctgsdd@zxy23kkhc3uh>
References: <20260722155050.503516-1-atomlin@atomlin.com>
 <20260722155050.503516-3-atomlin@atomlin.com>
 <amGrbXzdup2hvg3k@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amGrbXzdup2hvg3k@google.com>
X-ClientProxiedBy: BN0PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:408:ed::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3374:EE_
X-MS-Office365-Filtering-Correlation-Id: e8539a87-e059-4a87-fd1b-08dee8cf1a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Bl8GiJbK7l8LAlOpoqIj5y0oZtD/0zQx63hk2BAdjznR1M45gJFUvV2BLgf1MVVx4bamHJ4METxU9y09rLBuRgmnaqTm5PvRc3munMLDG5V9ZMg2hmPTy2LpsN99xOljjyABKMqcOyINCdplWnVdymkZ8CAddgmezR4KOKobAEDq4USsDrxLoY2/wbkG7Umd34YD0L4vJK3JsxMJe63FntI5jXV7VIkBv30ZgHsM8gWQYSJIKpugVDfF9u1/cWIg1kCioyxAyMwgio4boxOchdW6iMv9jYaBiIUv9LQ27+KCDzbszkzyw8iq2bg9LPrPj84LF0VCSKgokXJSFcqzn2UlNYAVoO0+hB27eovEhKrcYbNvYpci2cuMtW/tHk67NSxD/26lfZegtxsBrBm43fzryHlbgvowDe+eJSsqkNewwXAVWV6uzfIjrbIvFXyZNS+nPQRviOlXZrcD0RefzUa2ueAIteKCI6rYHveFo8RdCuBWOxI2DQks864SQz06HbYCz33aZB7hIW26Z+bakgvVk44dqcrYTluKZe1+BIMzAYFhHbQ3w2qs0UlSsGmKG+nLqJ033GuDnA9S5UTYfapc+ehE4XA8fuVTeSmm7LX5FNg6WyItnlRhXgyaude05tgO1Vc4V7Mi6KKMSINHzfcWmhWzqfjBKTA/H5sTSq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHJpKzZzWW15MDYyeC94NzdvSGt6WlEwK1BuZGhmMk9oY2V2VjVGOWFrRFMr?=
 =?utf-8?B?SjlRVjk4OGZJRXFPK0hTY0R5aFhJSTdBZW5FNDh6TkQwdEJraXplMk9GMHh2?=
 =?utf-8?B?T1E0UW4welkxaWZQNmV5V1NUbHYvT05UTFkrN0xKTXNYalArcVMyRG9EM1Zq?=
 =?utf-8?B?SThWN2tNeGRzYUpEUm5Lck8xYlhvbldmMmN1K3FnQytnTmhUTjczZTlVTFhs?=
 =?utf-8?B?SE5rMFV2WHZ2MGhrNi9EbnZjcXZXeVpKbXNvRFo3dWltTE84VDRsMGl6L280?=
 =?utf-8?B?WGVGbFp6OFlJeHVGdWZPbzhmVUk0WEJLb3BtS0E5eVEzdFNVZGVreUY4VG5z?=
 =?utf-8?B?aGtRZWRLZ29peHJEM2tFcEtWaVZMU3JpSEdJT1RYNVVYYkJvcFhoL2pNOXpV?=
 =?utf-8?B?M3kzcmh2S3l5eGo0Q3ZmMGpVWWROVmladnduU2FGWXI4QkIyTTZlR0pYUVVw?=
 =?utf-8?B?c0REMUU5Y2swUXZZZ3BvSWR6WE1ORWVzK3AyWWFsN3RBNEl5WHh0Vm9hZXFY?=
 =?utf-8?B?YzdubHJ5QzVRSFFBbFBkUjQzL0w2d2JwRUpOazZjZTBHazNHR1dWb29QRkpJ?=
 =?utf-8?B?ZGF5eXNyVGVOTjNHS3oxRnh0cGVCNk91cURzaUJUbzE5RzBEODEyU1NocTRu?=
 =?utf-8?B?dmtka25ZcWsxcTVFUGpUMjJidWQxT3diVDFqUlJjNERCK2dGays4djlZUHVt?=
 =?utf-8?B?TTNXcGtSSGhDMHlwR2FmTGpwZmxFZi9PMXZwYWR1RlJTY3JHVmY5WUZJcEpV?=
 =?utf-8?B?SGZHaE9xQm52bkpVUlUxRnR2NVMzZTV2Rk1FUGdQZWtJWUdUaXNDcUErYnpX?=
 =?utf-8?B?L1Jzay9rK0Q1clhodEgyeS9LRDhQaDRCVjMwNkhKQ2RDVE9uNW1USWdGQzlm?=
 =?utf-8?B?emhqeWtsVTBJY21ZK2FWVjdlNTg5YVZDai9FaE5GNTZaalVDZWpTVnhobWFJ?=
 =?utf-8?B?NnVYQ0E3ZmNRUVBLWmpJc2FvbS9LV25vcllGVG02bHROWlFXTDd4dFN2ZVJy?=
 =?utf-8?B?M2dVcEh0Z1lWdHZnN1g1V2hydC9objVSWXdtQ1cvcHRuS2xhcTY2MzJ4VlZB?=
 =?utf-8?B?ZEFaNFp5Q2ZtU3owa3NqT0Z4WG90SjhiSmlRdGROaUovbHBrRXJTU0RxZVBU?=
 =?utf-8?B?NGxxS0NYNU1PTDduUHB5SlgycDR3NGlSbG9aYW8waVpmL1V4Y05tM1d6OWJU?=
 =?utf-8?B?RTlSeUMvd2p0VXRJWkNqN3Q1MnExUVhuRXczbVV2NUhkMVUvVno3cUR5ZFMz?=
 =?utf-8?B?T0tNZ2YydW11U3NCRkp2aUtrYTdhZFUwelhCbjNTcmhRZThXdlhOZUkwWjdh?=
 =?utf-8?B?OUorRkxkZ0hrN05sS2t6RkhNUWpQenJEeFl1Q0RRM1RldjhKMVFIeWNyN3RF?=
 =?utf-8?B?R2tuRDNiOWQ0cFNUOWxGOHBSNmo4cUtjc3cwdW5tengwUExtblVtVGRxUXRZ?=
 =?utf-8?B?eEdvcjNDTnhTMUJLQi8zRmlURWRacVJia1Y0bmFnOUEzcE1lUGc1K3VpZlM5?=
 =?utf-8?B?WHhJZTNRNkhUWmNISHd4aXN4SlpGaHJ1ekVXeDF1Q2UzL1lYWFFzeTVsaHIv?=
 =?utf-8?B?SWplMnQxdkxsWVNDaWRaUzVkcHNwZEk5bnpqWXRZZTJ2WXBTd0ZXWWVGc2pL?=
 =?utf-8?B?SUxMbitUaUxOWGZEUE5zNy9WaVd4MzFBTnVKOWR1dG5iSk9wbFZUV2YvWW5Z?=
 =?utf-8?B?RFRDYjE2R2dyR1hTQ0c4TU9FeFZYM3R6RHdaY3VPekhmMFQwSjk3QllML0VE?=
 =?utf-8?B?c0RndUFTOUpscTZJc2FZeTVPREpKNjIweE9xTVNuMWZMY1JCRWl0LzB5elRk?=
 =?utf-8?B?azVOd1k4UGZpQ0FlNDNKNE8remVSaXdUMGdNY3JlMXF5eDZ2NVFRYW41NjZw?=
 =?utf-8?B?UjBaUmFrRDk0eFpMTkM3RzVSeVlvTUowZ0o5cm56ZzNHckZFdlhIbjVmZjRn?=
 =?utf-8?B?eHA4a0ZPVTM0dEh6c25acGlXbWtzUHluWEdEbzVxQWlOaFA3d0NkNTZ2bFZL?=
 =?utf-8?B?aU1MWVFNWWd5ZlB3KzJPQ3kyTE5YeDdGSTBocjJJNmpBSVFGS1I2ZnVzUFVW?=
 =?utf-8?B?YnIwUlNpZEdZd016SmtVRW9rRmRtQkttZVorMVgxMFQ1UGI1c2NZQk5ibWR2?=
 =?utf-8?B?dENxVWw0TzI0V0ZBaFZwZ1lxeDF2aC9oUlRKWnNaVzVDYjVSWVBzNm5TT0ZJ?=
 =?utf-8?B?WkNYUVJUQndKdFQ1eFlER05aaVBsUG1PdVRlN1cwRUVzMktyQ0lNWklVdncv?=
 =?utf-8?B?NDVRZklDencwZ2xtZVdsYWRQakdDMTRuOUU5blVuVzY0dllNWmVLOXd2Z01l?=
 =?utf-8?B?V3ZqRVkyK1hQUnU5ZWg5YnptTThMQU1kSWJSTXd2Qk9ZMmV3bHNwZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8539a87-e059-4a87-fd1b-08dee8cf1a18
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:28:52.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0lKumxv+1V2j2I+oF+eqrUd723s4hA/4Wia/vmDNaGxBWQ5O7mS7+KPa8+EIem6caXg7TrnxksO1XFtyE5mjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3374

On Wed, Jul 22, 2026 at 10:49:33PM -0700, Namhyung Kim wrote:
> On Wed, Jul 22, 2026 at 11:50:49AM -0400, Aaron Tomlin wrote:
> > Introduce a new '--bitmask-list' command-line option for 'perf trace'.
> > When this option is specified, the formatting of cpumasks is delegated
> > to bitmap_scnprintf(), enabling cpumasks to be displayed as a condensed,
> > human-readable list (e.g., "0,2-5,7") instead of the default hexadecimal
> > representation. An example is provided below:
> 
> Do you know any other places than cpumask use bitmask too?  I'm just
> curious if it needs to handle other cases or not.

Hi Namhyung,

As far as I can tell, currently no other users.

Kind regards,
-- 
Aaron Tomlin
