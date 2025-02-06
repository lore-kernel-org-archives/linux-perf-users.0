Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821123C366
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879257; cv=fail; b=WHietjg2gQrOM21wT6LmdE2uR4Hz+iwh0BgxpA9j3WpkpVGHXYvqhKBQr3c9j/y4n6OtYhNIe+8lAF4qJq2hvZVFsBroPCKjYL7eEanTX8Uj0lOKHrCLT5WFSbWASPM+/KZX1wEP3fCtdScMmPA3ccNw64DiVNHkNvI+IuIomdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879257; c=relaxed/simple;
	bh=v783y0OugajbmmRXlLUj4DIo4q2JUoyFTZwQNiiGoq4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=URtuxHYbAoQUNJcJsDrJuADOfckLPIkPz4/T2hddMB4YUoZ1O/M5olzmZq68ODEX4wW3Xb7NGhb37DYAEPRw045Vg4h0ne+XoyKLN1seHxuDOynm2nAFpxsWqd51b7eieitbkFrxgVzGxxLuDDQEQzVSHIQZ1Ms8sXeuh0aI8MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NPNsUyuH; arc=fail smtp.client-ip=52.101.44.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NPNsUyuH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kov3p7yxbyn51qyST0m4/A6PCXvlRAXjupHrbqgwF58SXrv9ouqlAwIZfBabJUqslN5qBl1NUB74oXRX+Xl19rys6ysQKd+PSLfr6wURPFZf7h6G0ZzXrSJdqkQqmCT91VUF5Eo8UpZFBwzQrNJOIGvtROOx8rKtun5H5JbX6gHrtX3iivQoSFj8jgq7pmg7twnjOYwSd1SiazU+WKHoq2Hr4PBGT2UcRjv8wRprYuxu5a9EQZlCM/FyeCgjByBrH0dTxRQ83GjTSHS5qWiyr4jLwprza60/94Fm5PTfuuUk3KlhA3ZKhxu3lOGI6LLgke577NrvucGsHPM3rCGdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSMIqyO7jPzRiaCUYwLv11VSPRxRIhRCwYKl+AeVMXo=;
 b=yrQocGdnWxzdDguIdaMLgLX2GlRZeSoQw1ZJjSm1BTAc8+cBQ41XZp51XPzO0ebRgu2vfyGJBbt3GbI4qK2zFoJrQrxuxV2cvQBSVXE7jNA7wArn81CNHcF4Kk6BcqZEmclpm71G06HKILJhlnR/faeLLZeGryEevLV5s35qrZ2qpKeFmFp4rnHwfDHB8FTbMIxlpWxjtvqSAmN5VOtoFtDRFKtp1xpwnTOHi9XO3CPCv7scf8qwNO4eaBELiWWpFG5yVpIpHR5vuIdp1XqhN4Yl0wv/Ovdt/hnwxGxJBr+l5DlrYvcuLiiLgIyvdxjOaW+I7OMbRifNw0faRvgAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSMIqyO7jPzRiaCUYwLv11VSPRxRIhRCwYKl+AeVMXo=;
 b=NPNsUyuH3TgMyYK9nKwIMPAbz+kv3lj4+I7l9m9EMSCqHh4hkItW1X7KqfhFAT8QLZ0RTs9rF7T1z4DpcOoYTOythxjN+zK7VpgVDr3QAzUJkueI6T+r7b3ougA1Ud/LKRk/wwPduIA80wMi8iZi1u3xIuaIyO1d6q9gTSd2lkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SA6PR01MB8760.prod.exchangelabs.com (2603:10b6:806:40a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Thu, 6 Feb 2025 22:00:51 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%4]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 22:00:50 +0000
Date: Thu, 6 Feb 2025 14:00:37 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH] perf/arm-cmn: Minor event type housekeeping
In-Reply-To: <ef46a47fc4ab909093f14b2b4289a4835836ab6c.1738851844.git.robin.murphy@arm.com>
Message-ID: <60ad53bb-5672-b2f6-ed25-6f1e748de151@os.amperecomputing.com>
References: <ef46a47fc4ab909093f14b2b4289a4835836ab6c.1738851844.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SN1PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:802:20::32) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SA6PR01MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9e211f-ca54-4499-cdac-08dd46f9b823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/gD2bGVHpCB+Fu3qehuycmO1NXR+HsCw6a+TjvF5g6kZtjAgelhx93JZdUa?=
 =?us-ascii?Q?r4RDCyTcRPjm2p4tJvpOjsEFa8PgID70B0MckjPXtmOGD4EH0nAExwfEFfOe?=
 =?us-ascii?Q?hVaGrZCGuPOGyY45k1sT0fJ04JsTwcP/2Xv66YGE4jji1cfv2WDO1tlNGIEn?=
 =?us-ascii?Q?/T+2XTPIguSEGknOO8355449HwpsG8JMEml3CfzrOYFYeso/9CVOxzkhvtU+?=
 =?us-ascii?Q?qZEewuLKYjTKtVluZTFpwBB8nO+5VsSHSfmDYQ0uRw/O5G7ILjlhu3TMtwip?=
 =?us-ascii?Q?vjOrE35fxdkkpX2SrVizvxvX6IFyp5I7oMzQB8b9GV/sAQAvP9fhxpwM/cha?=
 =?us-ascii?Q?Hyah3Z2K2RtEgR51h4aCH9eIuuSCxtJtcZT+lZGQ74coZp5r+63ecNVRiQ99?=
 =?us-ascii?Q?P+qvqfYIbIzOoq2LGvtnXuBMW/3bzla4Me2vgMKAwev+4kRZAMHIF/GFLmOe?=
 =?us-ascii?Q?pBC16WARBDsrs+9C3v+1PGpDQPM/plprAH8omRFoVVGyU7wMCBBq2woQM4zq?=
 =?us-ascii?Q?2NPlkCO4aft2Al4FxuqRVERoxQiR/SyaW39E/GHv8wFCizS6tlsffu2MjEvw?=
 =?us-ascii?Q?LaYFo7se78hxlugkv0EGBN1EOMYsBe9E96B1mojf2g5jI9Y3bKqU/NMJzY0P?=
 =?us-ascii?Q?hcFuysdaln641K7wr1UeriH3OtN9Puj7vTfnUIx9nXcE/ZvXBu6Opmj3VH4Z?=
 =?us-ascii?Q?j4rpPZidipq5oJDmC1SdGM0tvoxkv9X3hxVqWPSn0E4jpZIhNEuHgj0VhgCf?=
 =?us-ascii?Q?leNSNj8Wyphygk9A7ZuYcFL6tq9plHZQX0kqPolr+Oe+3EXVpO6SnqurVs/c?=
 =?us-ascii?Q?hwSkJaJkyNH73t9KzF1LOedO46gqMgSvReDSehc3uky+q28w0qhQjw13mkjj?=
 =?us-ascii?Q?uu8y+z8pMtjPFXojcK1WhS+2iYGAHvx8GGYLWE06BZ7DT/umn4fXIx9Hp5+X?=
 =?us-ascii?Q?Pc7JCxCzDSMOrB4fNnAgVcoVloAbDHSdSuOhyQabMRagfc0Q4IlSf2b5IIZC?=
 =?us-ascii?Q?kG612N4pfYWnyGq6zletXHC0sD6ryDb0CAonmTXcpsLRtKXJ5hiilunR3qFt?=
 =?us-ascii?Q?N5MUbDFcWvYAtDfPJYAWrnalkJLeZbzVKzi4JSUHCyh7b2uRf55GBKoHi5vD?=
 =?us-ascii?Q?HMAJoW0j8oIJ7uEP6m7bl5wL1HNcPKXUaQYVmaOUktto3DEVDA7v0fP6ItOV?=
 =?us-ascii?Q?1rsg8bkjx2hfRN7HFYhOYqozym++Kmjgt+8OQp0xcwQlSG2VAr/AdONtn3WU?=
 =?us-ascii?Q?7SeeG6M2F3JH+bg8rD6Lzz3P8mvrIoMZfHEjpn9LICvA6RqJXBHE3zt0JVHr?=
 =?us-ascii?Q?eTkXNKb3IO5Rv1vRe5cgy9fUIkm+6DCytDDwTdcu4FRlJSfGWV9gcKmzLvZs?=
 =?us-ascii?Q?od8sTZPBUEfwpu31fiTfqf0Hg5rI12Hf3lIK4m7LsVJg/VO+nLsGoIWghZaB?=
 =?us-ascii?Q?UH1VgqjdLr3OLfj/ve6M97HIVIwhjQl3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P43kLNud2uIgedjVOSU/WDbnp4r2Zv6glDBdGFqOr3V/P4DGgcX9w6nFipoR?=
 =?us-ascii?Q?xyWiTzeDPi1P6jNTuuOroY5pyCn0PRWMy2PbJ2udCHS3IyeCQH8U69x1k8hv?=
 =?us-ascii?Q?rS8A64Sbo4HzZus8TqbpF8dITErLnbJBoi58bt8+G16dYfhrwxOEV71I2mov?=
 =?us-ascii?Q?WQirCL4ZugN1frcoUAjziafsYk9DooxMpj81Fmf1iyCfl4JQYXho45jVLJfU?=
 =?us-ascii?Q?QpwU1k9Uv5L1k6/qs6X4Fh+TTW8dBKOgtbxSIpEpCmLQF7WmP7w3mtiX0Mwo?=
 =?us-ascii?Q?k5lzC8BsL1OI9Giti+K6C1TIdVPfnwwtSB1aJT+DFHOjmAdKmua5T0gZSSTR?=
 =?us-ascii?Q?t3tYlXyGNduXfDo4rvHDY87DH1A0BH3AkN0TLA+T5gvXtZh+X1VLsxPsN+TP?=
 =?us-ascii?Q?hJcvAyzj9jQx77logT+ZiauUTjPtsFTR5lyYzryNBS49ytNsW2cOinDPXtUu?=
 =?us-ascii?Q?NiW3V3X+eWXHjKdiqaDG8LtAI8/LiC7aQZ9fZVAsPSGO6xTwb5R4rXAL1nIp?=
 =?us-ascii?Q?3dOhscM/PeTdICkQR1XaRJjrclUJF38Fr2LFKOtOL5fiqZMh68yQRC1nzyH7?=
 =?us-ascii?Q?SsXKjt8FvY/6iIM6zl57Cl+6VJOXf8/a0hfufO1CvmOh98/xajIJlk6/Ysa4?=
 =?us-ascii?Q?2Nj7QhlPiZIVKZaKv4U+ZJZGxzkAZmySAV/oUnA6ZDlANrrLJWfQzhkKwpqD?=
 =?us-ascii?Q?wvTcqksZe4BRIhmorNrwxQVY8n0ID4xxjH++XCTK/hbpSY/dpIXqI7bLlu5k?=
 =?us-ascii?Q?GIn4M4ttuZX5sl+VDh/1NrdpQMbPNgtAKbBmgJGuTq+brPX58tXpMN2RzM2o?=
 =?us-ascii?Q?mclqzTOh2/D9fXAd3KbfE8Kkg+6LGjGRfT40D3bsP55mc90IJwY6x0Dxb9yM?=
 =?us-ascii?Q?/qogk4+oiUS98ge/ySNAlEWRFuh/7kZY1SrTYrLkdby/xKIqZAYT6wRvpnif?=
 =?us-ascii?Q?YlwSM7WrXw7q4gIig5aB8wYpqVwMxZ2F91GHPBpKwIuQ+MXZKSQ8/WaAcHl2?=
 =?us-ascii?Q?CdzvvsxPpFMRSFeUyU1TEQBO48bIqG7T0vZ+S4DKCNrwtsxOYrvBxa79DnFT?=
 =?us-ascii?Q?/ZvjactqIY7oSAo9CF5L78UYHgVpVvTcXjghnec6pGSfOYOlmLmQRUpNeCpX?=
 =?us-ascii?Q?YzlW/wYriSnyQzk0XbWxILIEiVDAvwFEqXR3apfqfrNMJX8PycF4XDrcqfWG?=
 =?us-ascii?Q?lqmABGhKO0LR/6m4n0t2z1PmJCpdsQqlO8ogDBwWFzfk90KP2brnNmqj/EZ1?=
 =?us-ascii?Q?BcZIQ/r4ogK/TnQ3i0K1hHkHR5wtzBIEO8TtdH8So6pSlezYD1VvcFfqHKJW?=
 =?us-ascii?Q?v8kod7mj+prIdyvXtdSoRl3rDRhjZWmwsjtdVaXpPUa0lhNdyGynfvn4tNDQ?=
 =?us-ascii?Q?/JR+WnXjXWSGHhSw1KnyHNza6zDLI25aZUwBkbQ+/5Zgl9MVBNytvkbPX7y/?=
 =?us-ascii?Q?34GhwGDEfpMkRUxdbTBC1sdQtgH3/pPN/OksLTQ3bH3VKLZwDW/aggZQoxOP?=
 =?us-ascii?Q?F09Hr1Ut1cqEkWDc7GYTKVSI5Xdyg+eB6i4ZDCLfXLdN3BbyB7ooDTf0J7VN?=
 =?us-ascii?Q?M8Ov3QKRURGl6Tiw1CGJhC+nfAph07nVYiM59Vb/Eemx7uC9iIj34mj++kFV?=
 =?us-ascii?Q?zB2oaC3CkXm+TuGZAtQ+PAw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9e211f-ca54-4499-cdac-08dd46f9b823
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 22:00:50.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ipr9t9Wjb5u6izVGjOqagnQcVJutYLNxYEIj422pGgaRGRxLXta8gw4dPkzm+bRgQElSWT6DJCJ5sIOeh9dF6znzjvSGa79yv3/XxkGaaqCcCe7Jdh2/k5lrwJlD2Qt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8760



On Thu, 6 Feb 2025, Robin Murphy wrote:

> While handling RN-D nodes under the functionally-identical RN-I type
> works fine for perf tool users using the "rnid_" event aliases, and that
> is the documented and expected ABI, there's little reason not to be
> permissive and accept the actual RN-D type as an additional encoding for
> the same events as well. This may be convenient for other tooling
> generating event configs directly from its own topology data.
>
> In the RN-I event mood, it also seems as good a time as any to clean up
> a forgotten macro for CCLA_RNI events which ended up being unnecessary.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


Looks good to me.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm-cmn.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index ef959e66db7c..d4fe30ff225b 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -802,8 +802,6 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	CMN_EVENT_ATTR(_model, ccha_##_name, CMN_TYPE_CCHA, _event)
> #define CMN_EVENT_CCLA(_name, _event)				\
> 	CMN_EVENT_ATTR(CMN_ANY, ccla_##_name, CMN_TYPE_CCLA, _event)
> -#define CMN_EVENT_CCLA_RNI(_name, _event)				\
> -	CMN_EVENT_ATTR(CMN_ANY, ccla_rni_##_name, CMN_TYPE_CCLA_RNI, _event)
> #define CMN_EVENT_HNS(_name, _event)				\
> 	CMN_EVENT_ATTR(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
>
> @@ -1798,6 +1796,9 @@ static int arm_cmn_event_init(struct perf_event *event)
> 	} else if (type == CMN_TYPE_XP &&
> 		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
> 		hw->wide_sel = true;
> +	} else if (type == CMN_TYPE_RND) {
> +		/* Secretly permit this as an alias for "rnid" events */
> +		type = CMN_TYPE_RNI;
> 	}
>
> 	/* This is sufficiently annoying to recalculate, so cache it */
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
>
