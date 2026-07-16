Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAC1FBC8E;
	Thu, 16 Jul 2026 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183566; cv=fail; b=lydQfIAViFjfhJmmyln7UB2BUOCYJ3IxSaZRxFfVX9aDX1PDgs1TT2xFNMUw1RiY5PdWreZ1K+SpwDbR7fFX/Xwo+LLYzP5C1vq1ejvJW6sV26kM+7HbuDC8RvJXqG1vCP59z5+QcD5r72DcFzgBZXujIkUqIBIu2B7BWxvLCww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183566; c=relaxed/simple;
	bh=l67NChAO1/iMlQMUV9t3NT0UcDrl8ZPxSNi8ypj1BU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZB646y2TiahKf+FqsYdeQ5BZHFDg9a5qKBye3JWTzE6ulJP5pYo8O6/HojXLaC3CnVVTbxQMYGtuuQCd5au9ZdNZLVd8IQ48fNfYiY9a/Hk2w9rIG0xGMH9i1vcAoQdC9LUuHi1kYyyVLfFHomK334EtXMJZvE2iSy8YDA/RQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xb8kICDm; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xb8kICDm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRjoWvcr9YhI5lD3c8bmJQhlGRJCUcZDt+hP4h1klkhAlGn4uC0CVQKveFny0VaVqyA9y1JBrnNYkuETGaBdh47IgySzqsm55kGCE24+MYe0pzP3e5HM+Et60CaOqMqNe1Ksc1LoDSPURpWPAqt/cZWsT3K3xXOckPTtgfn1lH/0e+Krg7E8+z/a30q5NYCtKBmDG+JWgMozu00mvljOdzrIQtpqIBk3ztpS68rVsaxG6hIfAr/5pEHslwZSNtvDh7GITIVgHSttNa+uSPJg3MTWeYkYkipABDJQZNXPREiZhGS/bFt0y3nuLKWO5voWJd0Oaok70UN441LCZbU4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlRj7+mNRfzB3Kn/apuZ1HYiJqEY6Hm2d8C3wF1gvE8=;
 b=gV3WxJ8XnCOnWGYsoWmy1UbDxBsiAGYd17XHWSWBog0zCWQvQm548THV2bg4rnTrMNjpzALXEDZm2oNgBcZK4k5tGJwqORP2ld7uFHbkA72auNJ34Q1N5NDX85sFOvgahD3zLTwaaHdnLLbTf2pnSprsx/s47dIyaAjYOb3wFWXriVzNY+4RUUKbbph59vnFCUjt88X47ndXkSyhJtC4h5oTqdGM2KL1QFTLvNtxb57ndxJaAMSTgcwCBTqWGCxTq6FcB/eWN8l8A2IF3NY7s/AkGOSbQvgr7CZd/+na9GuVZZD23lXyQf+hGhUAZeoOhYOzFTXzrpprRzMMs2ezeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlRj7+mNRfzB3Kn/apuZ1HYiJqEY6Hm2d8C3wF1gvE8=;
 b=Xb8kICDmFaZzK8+9py/gyKgY9pwm+3dxruPeqhkKeRmx9pNJ6eXoSPMeYL2vIPR3WnD5IcSkjXrkOGgGhHZ/oDo6HeAM4hii74aOanvhGslVVkGSeCpXPW8cr1O5lBVTHKy7UjIfOqMI+RP73jVH0mtEryA8WBvFOionRGg7eZiEymKVZ13333TQ4QVa5ri8sGSX5PQpVJAikxahqFmJs+Wnph/QwgapF8W0fh/6ClLoILpHIoVnJszLLV62/9zIJw99o9Ln7M7MbXLWMSW6AEfpHanWX5nauxFOd1MuWHDtrNTRZHfkLf/0ojY9JRpkn541M0vK1z9UteoJJzGeRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by SJ1PR12MB6219.namprd12.prod.outlook.com (2603:10b6:a03:456::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 06:32:41 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%4]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 06:32:40 +0000
Date: Thu, 16 Jul 2026 14:32:05 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, 
	harshal.t@samsung.com, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 2/3] perf/cxlpmu: Add missing CXL 4.0 events
Message-ID: <alh6vMn9R5_Qivc7@MWDK4CY14F>
References: <20260715191454.459673-1-dave@stgolabs.net>
 <20260715191454.459673-3-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715191454.459673-3-dave@stgolabs.net>
X-ClientProxiedBy: KUZPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:d10:24::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|SJ1PR12MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: c443f793-3bdf-47c6-8c5b-08dee303fbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/TcaO8CxBM0zJVs1uLYe2jxEVTEEmj7Nl/7leHlEQJTYvpgX2kDMBDaDK6i5AkOLhPI5+adZt/1zBFlJRjqwsPn6oLF9jPg8VmnGyccIM9jW4fOB1C3x4t19MfzFpMjrQ2RfK/gcS6neCTmDnopnoRbSqd40KyJlcQ5fvZBXJt4omX5zUy1MWXT9yMzlqFxWU1Jgel7Qh4U5EGgRk383R7P6J7VRSAvfHl3lxqoj46rHzVBP6RSmZU6kZSAf6tIV/ClXtYM7vZkYqigPMXM9tKQ0NtWRGJtOUVflm0gRVu8asSz7y6WgRbmNEdsNDcRRs+kdWEYm510o1mqVoJu0Muc7lmz+qqLq+CS5t1/TrlpSyHcwtUKPr9wo/6VjfF7elvtavFUb9uDjLhJYEeaxoGkt+pAs+BbGV3ZOuTiVX+0PJHKWttxCYqkcCUhx1opxTNT51i7U/Uv31FKszJDdN6mHsMeqe678UcnvysCpCSED3+UQwNgGyW9raK+kYzfRkHEgHwguNXlkd4r59tHnGJHX1ouSkr7Rffo1oThwWV1Btxs999Oi0ZBMWVvyW92x5Q+8jkSMN5QxPw6ckfUrIF4BbnJeD53nCTF6DakRuhEtSZwg8HC7+ZI38oO2udPo0eQEOIP0J2csRAMlT+h/JrHlUdf49HgGnDaE5fU4oPY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jUw7tn9j5kOfZB1YNvzcBuhXP54eoR6gJ8Tvhlzmh0r8BokKnqWh1Hg8hYzF?=
 =?us-ascii?Q?+LDU6+kZbs5xLBEXHth0BKjJ04k1PdDvX7hJ4n5CmpWwhixu5u5SoX+nEr9p?=
 =?us-ascii?Q?1PHLVdJd6Wzgbio2j8Jm2hNvFUrkOx9qPofdazUoTC+x6mNL5RmBGDnl0stF?=
 =?us-ascii?Q?eImrinEdNU1UUh43HqkP7TOuiYILve7AqhCyLNwL8tYQOR2ykK7ueZWEE+Q5?=
 =?us-ascii?Q?XTINZRAE6UJOfQhyC+kqAC9SpbpS8PLbguUxilHFqX95b6uH87+FhZZvofbb?=
 =?us-ascii?Q?FB79JiPrZfKrnv1NLsasTLz9i4NQb17MUhooKDs4pExnrHFkOnM6VNj9tuRc?=
 =?us-ascii?Q?IDYeyQq3QDF/1JeLhWWGFRzUFvbZPwvAQasrvT5EvHDfEGItPb468b8mktNk?=
 =?us-ascii?Q?+BNaGGgN3GB5uO0Qz0bJCasifmbkTRzr6FZkREElXeucZdyb9JN3vWd619jO?=
 =?us-ascii?Q?VKG4SON1pe/y0FJCuGHLLbvsahpPA92m4JmIWnGSzXp9c9vfkEL+h4i3YoCS?=
 =?us-ascii?Q?1KNvv/JKdC9Oy6p4y8eMceA/Pv5OSgka9Jarc/xIL7GKoI5UDZOMQR6ACZuw?=
 =?us-ascii?Q?8OgDbZPp8J3+Lh9gDkTJ4v+aeKGgzmTc/ed8IoAcdJ4vP4xy4wNpaxanE6EI?=
 =?us-ascii?Q?F/H3OKF+nfAiw2qCyqHRFw+W/VDGfFg0ji17Cwayuw0wIIfi0052Y2B1ynxb?=
 =?us-ascii?Q?asaEwNgo0UTsA324KcH8TPPXASIslfREp85BerAmXzOYicdnVN7t+cHHR+/t?=
 =?us-ascii?Q?4btNLp6sr9+PjaLbvbey4hdCImS69uyNMi3xvxA7mk2WnfbuIiPrzX7+szBb?=
 =?us-ascii?Q?/e5SBNs2ajQU003Tq0SyvQE8gStJc00EkTgAJWVz/Xzq+sfS22QvIQnj0gYA?=
 =?us-ascii?Q?nBGByJ4FQ5S9dS3bEMNcGV2paLwjpRFjODGDntGcEW7q+ulEMOwRk8xAhb3/?=
 =?us-ascii?Q?B+Z1yyiYfw6kildP28gJrEXTURqWLm32Hj08de9IR4XJTDyweaDoHFlosyKm?=
 =?us-ascii?Q?d0Oz5pCUQQ55EjgPthorqItMZ5sBqpe1ID7UD0+1UT9moQqDQwWwPDDB8Ntx?=
 =?us-ascii?Q?XbEUVM3DkiJA8KznuP2MhSMkycBAcMsVkdQUR79Pd7WCs7f4BPh2J74xd8Va?=
 =?us-ascii?Q?HFntk4V+QN8mc/pIy/CwkD5hzNXPMD7aAH36mEb23WYb11xzsB2mZ0pfFnTc?=
 =?us-ascii?Q?qgBh+FA04ZLPRZU22CcvIs16tA1u6WF7o2YMVzj0HxDYUJCRu5ieMsGV/FJ5?=
 =?us-ascii?Q?1xUZDHZFvSLNfmJZr2pyi/tRFk23Bhn+hKcaGQ9mLMD3bKIGh4tA0rDowTFy?=
 =?us-ascii?Q?4dUNzpqz2DUK6mpanQ3L77/bOptIf6N1e5wNI1nmlioi4uZYC4QGlDnBTW0i?=
 =?us-ascii?Q?f592HKamGZi/C0ixp8HybqyDx0j4TZgyN7lQhRKQtYoA+TE+dHQo8wzIBJrl?=
 =?us-ascii?Q?DonAHVtjtatiJDV24TzVAauDm0f1ezEtMfFYnHe9Js5as5x+4hv3fIFEDjDX?=
 =?us-ascii?Q?6tWrU2VfUmE24dbTa5zay3pUaaV4/Z22zn2rTtIwFK40UtzisfCwyS3tQUrs?=
 =?us-ascii?Q?aMCgT6X/d9PPEc+whGtcQNz8+pZwJiB+8y+XYcd3smww72zwpYGw7x5RAolT?=
 =?us-ascii?Q?IKdYIw6F8WMZiliV/kC/X5S+Ya63izxE4kb9lbifrEzfD5izZZhvKovseY3p?=
 =?us-ascii?Q?E+3fPUb0sHb8vkM8GhK+4e+DpSf8lAPt3D+NsQam52bgtsXpuxVbTHxw55C7?=
 =?us-ascii?Q?KB2Zm0mYug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c443f793-3bdf-47c6-8c5b-08dee303fbac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:32:40.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qm9GBX8OdulljAB1I0RFaTMKdP9TfGRnOlMqfYEzgrN5kBt4KFbwJfbq6YK6MdrW6uHunJTqJiOsJktg7fL/zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6219

On Wed, Jul 15, 2026 at 12:14:53PM +0800, Davidlohr Bueso wrote:
> From: Harshal Thakkar <harshal.t@samsung.com>
> 
> Add support for CXL 4.0 events that are exposed by the CPMU hardware
> but not present in the driver. Such events are defined in Table 13-5
> of the spec.
> 
> Signed-off-by: Harshal Thakkar <harshal.t@samsung.com>
> [davidlohr: add missing throttle and queue occupancy events]
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/perf/cxl_pmu.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 39b46550a510..1fc83858f653 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -77,6 +77,10 @@
>  #define CXL_PMU_GID_S2M_NDR		0x0024
>  #define CXL_PMU_GID_S2M_DRS		0x0025
>  #define CXL_PMU_GID_DDR			0x8000
> +#define CXL_PMU_GID_QUEUE_OCC           0x8001
> +#define CXL_PMU_GID_QUEUE_RESID         0x8002
> +#define CXL_PMU_GID_RETRY_EVENTS        0x8003
> +#define CXL_PMU_GID_THROTTLE            0x8004
>  
>  static int cxl_pmu_cpuhp_state_num;
>  
> @@ -385,13 +389,23 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memwrfwd,		CXL_PMU_GID_M2S_REQ, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdtee,		CXL_PMU_GID_M2S_REQ, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddatatee,		CXL_PMU_GID_M2S_REQ, BIT(6)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvtee,               CXL_PMU_GID_M2S_REQ, BIT(7)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrd,		CXL_PMU_GID_M2S_REQ, BIT(8)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvnt,		CXL_PMU_GID_M2S_REQ, BIT(9)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memcleanevict,		CXL_PMU_GID_M2S_REQ, BIT(10)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvptee,		CXL_PMU_GID_M2S_REQ, BIT(11)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrdtee,		CXL_PMU_GID_M2S_REQ, BIT(12)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_teupdate,		CXL_PMU_GID_M2S_REQ, BIT(13)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memclnevcttee,		CXL_PMU_GID_M2S_REQ, BIT(14)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memclnevctu,		CXL_PMU_GID_M2S_REQ, BIT(15)),
>  	/* CXL rev 3.0 Table 3-35 M2S RwD Memory Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwr,			CXL_PMU_GID_M2S_RWD, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptl,		CXL_PMU_GID_M2S_RWD, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_biconflict,		CXL_PMU_GID_M2S_RWD, BIT(4)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memrdfill,		CXL_PMU_GID_M2S_RWD, BIT(5)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrtee,		CXL_PMU_GID_M2S_RWD, BIT(9)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptltee,		CXL_PMU_GID_M2S_RWD, BIT(10)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memrdfilltee,		CXL_PMU_GID_M2S_RWD, BIT(13)),
>  	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_i,			CXL_PMU_GID_M2S_BIRSP, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_s,			CXL_PMU_GID_M2S_BIRSP, BIT(1)),
> @@ -406,15 +420,25 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curtee,		CXL_PMU_GID_S2M_BISNP, BIT(8)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datatee,		CXL_PMU_GID_S2M_BISNP, BIT(9)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invtee,		CXL_PMU_GID_S2M_BISNP, BIT(10)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblktee,		CXL_PMU_GID_S2M_BISNP, BIT(12)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datablktee,		CXL_PMU_GID_S2M_BISNP, BIT(13)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblktee,		CXL_PMU_GID_S2M_BISNP, BIT(14)),
>  	/* CXL rev 3.1 Table 3-50 S2M NDR Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,			CXL_PMU_GID_S2M_NDR, BIT(3)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,		CXL_PMU_GID_S2M_NDR, BIT(4)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee,			CXL_PMU_GID_S2M_NDR, BIT(5)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee_s,		CXL_PMU_GID_S2M_NDR, BIT(6)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee_e,		CXL_PMU_GID_S2M_NDR, BIT(7)),
>  	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,		CXL_PMU_GID_S2M_DRS, BIT(1)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatatee,		CXL_PMU_GID_S2M_DRS, BIT(2)),
>  	/* CXL rev 3.0 Table 13-5 directly lists these */
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_act,				CXL_PMU_GID_DDR, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_pre,				CXL_PMU_GID_DDR, BIT(1)),
> @@ -423,6 +447,32 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh,			CXL_PMU_GID_DDR, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_selfrefreshent,		CXL_PMU_GID_DDR, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_rfm,				CXL_PMU_GID_DDR, BIT(6)),
> +	/* CXL 4.0 Table 13-5 DDR add-on events opcodes */
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_cas_rd_ap,			CXL_PMU_GID_DDR, BIT(7)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_cas_wr_ap,			CXL_PMU_GID_DDR, BIT(8)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh_all_banks,		CXL_PMU_GID_DDR, BIT(9)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_refresh_same_bank,		CXL_PMU_GID_DDR, BIT(10)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_pwrdn_entry,			CXL_PMU_GID_DDR, BIT(11)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_pwrdn_exit,			CXL_PMU_GID_DDR, BIT(12)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_rd_wr_ddr_bus_switching,	CXL_PMU_GID_DDR, BIT(13)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_incoming_rd_req,		CXL_PMU_GID_DDR, BIT(14)),
> +	CXL_PMU_EVENT_CXL_ATTR(ddr_incoming_wr_req,		CXL_PMU_GID_DDR, BIT(15)),
> +	/* CXL 4.0 Table 13-5 QUEUE OCCUPANCY events opcodes */
> +	CXL_PMU_EVENT_CXL_ATTR(rd_queue_occ,			CXL_PMU_GID_QUEUE_OCC, BIT(0)),
> +	CXL_PMU_EVENT_CXL_ATTR(wr_queue_occ,			CXL_PMU_GID_QUEUE_OCC, BIT(1)),
> +	CXL_PMU_EVENT_CXL_ATTR(rd_wr_merged_queue_occ,		CXL_PMU_GID_QUEUE_OCC, BIT(2)),
> +	CXL_PMU_EVENT_CXL_ATTR(pwrdn_event,			CXL_PMU_GID_QUEUE_OCC, BIT(3)),
> +	/* CXL 4.0 Table 13-5 QUEUE RESIDENCY events opcodes */
> +	CXL_PMU_EVENT_CXL_ATTR(mc_rd_resid_cnt,			CXL_PMU_GID_QUEUE_RESID, BIT(0)),
> +	CXL_PMU_EVENT_CXL_ATTR(mc_wr_resid_cnt,			CXL_PMU_GID_QUEUE_RESID, BIT(1)),
> +	/* CXL 4.0 Table 13-5 RETRY events opcodes */
> +	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_rd_crc,      CXL_PMU_GID_RETRY_EVENTS, BIT(0)),
> +	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_wr_crc,      CXL_PMU_GID_RETRY_EVENTS, BIT(1)),
> +	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_ca_parity,   CXL_PMU_GID_RETRY_EVENTS, BIT(2)),
> +	CXL_PMU_EVENT_CXL_ATTR(retry_event_trig_by_ecc,         CXL_PMU_GID_RETRY_EVENTS, BIT(3)),
> +	/* CXL 4.0 Table 13-5 THROTTLE events opcodes */
> +	CXL_PMU_EVENT_CXL_ATTR(thermal_throttle_event,		CXL_PMU_GID_THROTTLE, BIT(0)),
> +	CXL_PMU_EVENT_CXL_ATTR(power_throttle_event,		CXL_PMU_GID_THROTTLE, BIT(1)),
>  	NULL
>  };
>  
> -- 
> 2.39.5
>

Reviewed-by: Richard Cheng <icheng@nvidia.com> 
