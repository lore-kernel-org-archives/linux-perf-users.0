Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2937213790B
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055993; cv=fail; b=Y7ru7y1pwi0SU3M7dASZi63ekwWkkAmWze5UKX0ulAanG33qFLtnzNPxZPUiPDZ9VzVG2AbVhcxLwgVrMmm+aPcY3BCR8K+Q2+YPfPavYeBJnOP2vnXo4gyuo+ZlD9iuKaNiIllttedzsnQaFMT6LFL5CBOfUiloiViYq6p/TOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055993; c=relaxed/simple;
	bh=tCdK00s8q7o60j8A9WSmN/Vidi7n0beZ2s8xSl+vVqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QFmAo/3yM+8N8K99asOUGotVH/Ukww+W4VM2+dXh/pf0QlKDJCeOU0sE+1bW6QSij/lYz7vqBoRqfrRBAdnGZp4Jlg2NkN7bX1yhzX4PtZHRLiSQ7kEEb4v1btrn0wpv/M3eWXo+cHQIwLVMpYlDLQj78/poPM9qhXpflgJ9pEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZzU4xuG+; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZzU4xuG+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkRDGMqU9ZBUOY8IPxfsd1LqAeauN+fpQzHASf5T1z3m+/aRMx1+r9RiGYs3EwfV2SQNm+I4O+xVGL2Y+RLJ4FYHuNjYeI8I5RSNIWdMQolbUQmWZ19mY6N+0EJR7inFQf3TMNRFH6vjzOA3SgIe0++ACEpaeyBchFWNrYqxn1BPh15YQD+eR6yRnKBIWiMI9pWMXaxaZ0laMaQC350VocXVVs0hVuT2HHOxSz/wyypIVS/gcBu7RFXbPTMwudeLL2LYA+K2f5c+WQjotik7jLYnNRUZYEVvHi+zubd3oaY6Irt/zT8bonLygAxcTJi3bwlcy4Fpm7g10dXInBmTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFl2eoz5r7K+rbkTckrEMxEZTtGGh/0YozOzXjYool0=;
 b=BNS5fX7IYVZDisp59KPGHDXT0mo10zQ591pnGTVohmLSRi7yDfmTIrm9/aW3HZuiQf2N+qTNBzXNQbtq/ZB7K45yxCyG8JCuiCmq6M7GLCreySG2sc1jkeIeIga2Fh+HA5wfjoNhzRVfqcSy+67J1g6K7XykTIk74Q0IvZ9HiDAhhTFN8Lsed93rpD5zUnK/HhsV3zgOWe5xE3ZdKVlVMqR3p4lh42gkrFPMMrvfT0uAdf9UYstHuRJ89n6IxA7sScBIapKAM6bKC+vUj9noIc/pq3hGc4lc6zk3vRtsAlFMG1lYd2w8/MERT7CaWXQwgUa1/+6wfiO0Soo1GegZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFl2eoz5r7K+rbkTckrEMxEZTtGGh/0YozOzXjYool0=;
 b=ZzU4xuG+XGd8uItYb03WJI5c3KVP19oJkbIyV5qmA7BXf17L3igVLO2A0rydpqZ0CH6aeOTZ4l5Vg5kevOJGx/WpecORbUK1VegVvOM5cRXybwfsH/8mKCA6vToaE45KWpziY3CZQWEF+ooyoM2G2i6jLzX5lilPQ8CaQ4mRcLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 07:33:08 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 07:33:08 +0000
Message-ID: <59d7d871-0765-4783-9cad-a825b8249ad4@amd.com>
Date: Tue, 25 Nov 2025 08:33:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Support CMN-600AE
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f0c6e66df6b74f073df77c00bdf9ed560ca9c703.1764002394.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::32) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|LV8PR12MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e18085-87b0-49e6-19a9-08de2bf4e149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWZxRGtSTWpPNjh4V3dJdWVSNkw5ZmlaclJOVDE3WDVzTUlMZU9PdHpBekxq?=
 =?utf-8?B?ZGgxbnlibnQ2MzNGRlR0RFd4U3JYZmtRUmNoRTR1MVZnYThaK1pQalcvL0lL?=
 =?utf-8?B?WHdnOE5ESmxmQTRUd3hnZWg2cDh3aWZzcmZiRjB2UWx6ZG5Vd3VzblI2czhB?=
 =?utf-8?B?WGpKbmVVdTRhUDFqbzNEclhlWmdaeXFVdW1JeEQwblFOeUlQdTl2QVk3clJk?=
 =?utf-8?B?TmwwTk44bGlhRytJNUFqQjV2Y09uYURuTHlDSHQzckpGYStLMFJWcndFaUF6?=
 =?utf-8?B?WVM2RXpiLytVZmRjaDBJRFJ2MXBVR29JdDFkR05KaFlSekJaVTRSL01pR3pM?=
 =?utf-8?B?TG1FMVYxRG04MmlXY3Y0c0FBdUpBRk14end1SHJSVms2Z1NLbFg1N3hFbjJs?=
 =?utf-8?B?ejdnYmVsdWN1SDc3SmZjRHllZkJmWVE1UUdrUnd1dGY1ZVM1VjRwWng3QXVT?=
 =?utf-8?B?a2UrVEliMzhuUy9BYVVLdEo4Mi9XamloU1dKa0I3UnpuSlhlQitMbTVtZExD?=
 =?utf-8?B?b1drbVc4djM5MDdiRStXUiswZ1ZhRzR1WW5hSDhtYzhTNENGTjA0RS9TWlRO?=
 =?utf-8?B?bW1WM3dob1NZNFZFOHg0V2xPOTkzbWFQc1QvMHNMdmZPQ3RCb2xvaWl2UnFt?=
 =?utf-8?B?TzROd1VNNW96eXdrZVFGRU9pM09GbFE5a0tHb0MzRVI3UnR4T0UxeFYyTnAr?=
 =?utf-8?B?dThZeXUxczA0cmlhcUFOWGdHejBHNVpBV2ZyOWhHOUxJazFQanN2Y29DNzlj?=
 =?utf-8?B?T0lMZHNxRTFKaFd1NUNCQjBlMVRvOE03YjFSTGwvUVVsZDBYaUxFaXExemtH?=
 =?utf-8?B?MG9PeEpSVUtJbVk0eVpwRXYwaW5QODMxbUxNY2k1RFBSbSthUjFYTnJmOTBT?=
 =?utf-8?B?MVFWNHFMeDZzNnlNbFA2OThTQmxqcEx5OE96OGNyZjBRUjlUTkNPTGI4VVJE?=
 =?utf-8?B?MGpPbCtFT0YrRkh6VmVmckJuMzRBN3NYZjFhaXY0dUE1TXNjM3NZQmxFWVg4?=
 =?utf-8?B?SU5OVHVhdlJSUEtTWjgyUENQSFR1Y08ybE5MQzd5ZENpanFmQlcyR3ZMYjU2?=
 =?utf-8?B?cy9FeFlCSnZGSFlsbFVKSEdERjNoTUM2N056akRuTk40K3k4STF0R3owYmpZ?=
 =?utf-8?B?STZDZjVvdkozZ1c2RVF0TU1VMnN6dW96NHp6SWN5bXBZYlgrQTF2VHI5dURz?=
 =?utf-8?B?UHk4ZzI3RlZhZHJUYnkzQzVhamtNckh6cERQbmpoelZQck4wWEdjMThJYTVh?=
 =?utf-8?B?Y1hBdUMvTlBBK01JRGVlMk1LYk1oV2MvVkxrcTdYNTRwUjN6c1E4MGcxbGZ2?=
 =?utf-8?B?c0Y3RE5GVG1vOFpNMDZ5aVVlc2NtT3JoWW5FYmhhQkVZNGlCd01YZUl2OFJH?=
 =?utf-8?B?UjhHZUJvdWV1aEVHRXBFTXVtR015c1F6VFBxMUNMaVN1MmR0UlBxVHN5NWVi?=
 =?utf-8?B?Qk85Q1JISHhVakIzMGJFZEdSWTZZdzRIcG5JNmUzbzBGRCtFZmp0ZzYvdGR4?=
 =?utf-8?B?TTkvMlNnZzBSa2tCclNhUDJENkZWTDBZbUUzQy93dHFPblMvRkhEVldqRGRq?=
 =?utf-8?B?VXZiaUh1TVBROTNjVHVkcXU4WVNRcGVWWkJNVmw2dHoxbTRyYVVjYnJCTjcw?=
 =?utf-8?B?K3Y0RStLNURHUmVoUmM3TFNBY3dxRitvekVlWnRCbUF0MitFRHZleHRtblFR?=
 =?utf-8?B?c2JwR00waWNQeWVrM3pKekdDNnRYVzF0RHBrcU9RVXdXcy8xRVF4M0MvN0FS?=
 =?utf-8?B?cU1aWHlUWWllS2FnOXNzWVRBUnNLMVQrY0ZrQm1IcVIwR0ROellhUWt0OGF4?=
 =?utf-8?B?L1FveCtrSERIYjQyYW8wWXBzQ2Q0dFlDZnNvNElCbVlIUGlHSSt4UFh4ZE5C?=
 =?utf-8?B?R2VpbExCRnpPMld3YzRqRTJaOVozVHZ6RzFrTk9zRlM0REdhcG95QVliNnIx?=
 =?utf-8?Q?hxajczZRWbkTR3O44oQ9Jv3iptEa3oV2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG91MDQ5ZWd4blU5UkJnMm82UWRsWmU3WnJLRjFPY2J2YWFFcXBwMWdTVjBZ?=
 =?utf-8?B?S2lRMjRBRDVGK3NreEE4cGQ1RkNOdWxNNTY5ZldpZXAvRThRbDlwWkVPVnRk?=
 =?utf-8?B?NnJHY01QSG1oZi8zNy9xbTZPNTh1L0k4cW5jQXU4SWoyL21wbmNyd0tPT3dI?=
 =?utf-8?B?eFRIeU1reTBoajBKNlE0TGhHM2VTZDR4UHI1VVlDblRPSTRNL3FIRG5QbVZr?=
 =?utf-8?B?S2kxZFAzcVN6NWtPNzlpKzFLby9ZVytkTUhOQ2piNEp6MzdNbGdwOENPZlhK?=
 =?utf-8?B?TG1wbTl5RkN0Sy9Rc3Q2b2I3U2d6cERUV2duRkpvZUZ4QzRmMzY2UmZZd1JB?=
 =?utf-8?B?WmVzZ21iV2JTU0UvRGRIbFJXS2xyWFdtZDE3SlYvRjVMYTdZWHZya1NnNWNy?=
 =?utf-8?B?dlNiZ1BwZytSK3cxb3ExcWhyUWJIQXB5WkVYQW96VnMwUTJUak5jVE4zRy9r?=
 =?utf-8?B?NDBrZU54eDl5ZXhqQnNaWVVWYXZkeXZUQjU5UEh5SlNONkpLRS9UVU81MHcx?=
 =?utf-8?B?dnNhclRtWS8rVGc4RVcvODVsbzNvb2pTOWlNOElrSXpDdlRDVFlQZzgrbXds?=
 =?utf-8?B?ZG56OFVKVVptc21RL1lYVEpPaFppSjFreG5Wa2k2OFNPcDV0WHhlRGV2ZEhw?=
 =?utf-8?B?YmwxYk1SQk03MGxQYnhrbmhxTDhpVHA0dEVONGlNOHc1WFJNaGlWeWxNa0JH?=
 =?utf-8?B?am9tV2krQU5UT0ZqM3ZZY2szelhqT09jc25sMVJhL3lMcGV6eXpIaDRBblBW?=
 =?utf-8?B?UlpOaGRiUHhRYi94VzlWTlZHQlllcGdNVHNTOUlTTUZYMHBYd1FINlE3U0FC?=
 =?utf-8?B?Q0JYc2V5VnNYVnFGSVJuQTNyT2xJeEdIanNReU5NeEtWazJoZWtTSWs3dUZP?=
 =?utf-8?B?ZEF1RzJjQSs5YTZ5QWdPcDBqMllIT25mNWhncUtINExFOWtiN3pEaVlVa3Fk?=
 =?utf-8?B?YjlaaVNnT3B6TlE2MGg2Qk5pZXBUMjFiT25iWDBaVUxaLzU3UnhoQlNKd1Nq?=
 =?utf-8?B?Rk9HZjBEU3NkRGVmNkgrMnlDeFlxRjZkeXFtcmkxK21EL3YrM0g5ajNFWXl6?=
 =?utf-8?B?aUQvZ21pdTk3SXQwNVJtR2FuRjgvTTYrckR4dTV3Q0FnejNWQ0FwNUFjdVNM?=
 =?utf-8?B?dEJkMGtNMVlsUmhycEhzMFF5aGZIUDRhMk5SN0tCdGE1UnZPdXpmUllra2w3?=
 =?utf-8?B?c1lJbTZNc2NkcUlPTXowWFNiTHpRZmh2b3RHUmp4VjE1azh0cGE4VHhpTDI0?=
 =?utf-8?B?UE5XbVg4MkV4bGJTamsrVG1JMEpnRXZaaFhob0pndFJHc3UvRmtEODJrc1da?=
 =?utf-8?B?RkhMRndhQWlZY3U4ZStNaGV1NUVrZXJnYjFuQUFvQlljZFlzdmE5S0lSbTNq?=
 =?utf-8?B?ZklIOVBIbDF3UEFNQzUwZ0F2YTdSYW1uSlBVbVdRL0NUT3c0d1FRNDE1dldz?=
 =?utf-8?B?UDI2ZWlFcEhnWWpaZzN6WVp0bVNaQUZOTklUNW5jUW9DWEFZRzJOWkdmek5R?=
 =?utf-8?B?cXU1SklWMW5qelFjVGNWTjUvelE2ZnVSdGZVaGpGaDNtSGNSY2o5d0E3MXJI?=
 =?utf-8?B?VmZ0NHFWUE5kdTFCc01lYXhnOUpJVHFuMVlyM0thOEVEam11bjl5K2tSQUxR?=
 =?utf-8?B?UXlPTFpIQXoyZnRXdWFjNmsvRE1PNU5ncmowUnU4OG11UTgzU1JjdVNxTFpG?=
 =?utf-8?B?ZmppcTdIVmNvSVc1UmFoV1hCWkhuU0ZybyttMVVzcjBEWFQzdko0bnhFSEFF?=
 =?utf-8?B?ZDJFbGZIalExMVU5S0p1VjFVZlpPbjVKRmtlS3FlQWxRQ2pZZ09hUWN2S0F0?=
 =?utf-8?B?WUVuM0cyaFBuZjRybDluS3FlRlFTVldUejVaMHpRL3ZXMURnMDBlb0RjcFNa?=
 =?utf-8?B?WEkzRFg4L3IyYy95eFhZQ3ZFTC81T3kvUTBIakZjSUduQVJGOHpjRUI4ZEh5?=
 =?utf-8?B?d090aWtQTW9JNlZ1Z2t4UDJkSmQ4T1NVbXVWNmdvditaWHowYS82aWRoTkR3?=
 =?utf-8?B?NFJOQU15M3h5SWpnN0h1aTFEeEt0cVZ0Y2lPTXNzK1JTRTAwcXloN3JnRVoz?=
 =?utf-8?B?K3RTeUpVcEc0ZlFqcVNueklla2p3a2JRUDZ0Ry9ZdVhsVUdibUpseGxieWo2?=
 =?utf-8?Q?daiqVUZc9wXffOAedHOM1fns8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e18085-87b0-49e6-19a9-08de2bf4e149
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:33:08.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejcuPOtWKYEr5kfE1wLkk5oFFsSpd0usCIroSO3rABSU48gS0i+amRVybEx/8aTG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9207



On 11/24/25 17:39, Robin Murphy wrote:
> The functional safety features of CMN-600AE have little to no impact on
> the PMU relative to the base CMN-600 design, so for simplicity we can
> reasonably just treat it as the same thing. The only obvious difference
> is that the revision numbers aren't aligned, so we may hide some aliases
> for events which do actually exist, but those can still be specified via
> the underlying "type,eventid" format so it's not too big a deal.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/perf/arm-cmn.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 23245352a3fc..651edd73bfcb 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -210,6 +210,7 @@ enum cmn_model {
>   enum cmn_part {
>   	PART_CMN600 = 0x434,
>   	PART_CMN650 = 0x436,
> +	PART_CMN600AE = 0x438,
>   	PART_CMN700 = 0x43c,
>   	PART_CI700 = 0x43a,
>   	PART_CMN_S3 = 0x43e,
> @@ -2266,6 +2267,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>   	reg = readq_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_01);
>   	part = FIELD_GET(CMN_CFGM_PID0_PART_0, reg);
>   	part |= FIELD_GET(CMN_CFGM_PID1_PART_1, reg) << 8;
> +	/* 600AE is close enough that it's not really worth more complexity */
> +	if (part == PART_CMN600AE)
> +		part = PART_CMN600;
>   	if (cmn->part && cmn->part != part)
>   		dev_warn(cmn->dev,
>   			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",


Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
