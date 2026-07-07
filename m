Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021133.outbound.protection.outlook.com [52.101.52.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62649620
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402278; cv=fail; b=ix7BZ8+Vx23xImUAjKv0EF8owQu5TZShNTz/KGScyxtYTfelcSJEAQ8NaXTGGyvMC5+z/Ooax81EH7u1RIklwyhgmlVznWhcCgdrsepmZ6fPAsMi/nuJsylkBz8YImZqFQRUnaHbIe9Prv5dk2VnDoQi/jB3yMwJju5tLtvSlpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402278; c=relaxed/simple;
	bh=4BfiAp8NTYOPtSffmS5a9iWPMq1TRCSZo8nlvHbmrOc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=eMh6nK9hvvlTbbCz0WKZmwKYngER7uxhtZcp0S/UXegzbtteHVTbi7aJDzNKhjTSb4k74/cl9VFdclZpZ8Y1gY3Ow2Ksl4YJKlERJ2h/UyftoX2l+qwdpi65OwIZGYK5xcoz5L1rWPZ7L5fdFrTRxByZ+zMbsvGCi1lFtXmNjwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Hj/IZIry; arc=fail smtp.client-ip=52.101.52.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Hj/IZIry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRt3+1Eqq1g3hgAewIZVGIO/xn+4tlcxnlWRVFu9ha8ME7k5/o6vVWA6L8JqXv+D5n3z3AY6pq70FLeZtEah1S53AusNQngdILaP8x9I5QrHGReBS1r/8kWgUixbKlyle4xDflHKp1BZAI+rQXXSo72kwTh8q2+YZvl2W7xvJPgUYhw93itCsc/odqpqrCBB8JMkQXtDsUNehpLyr3H+69aBpecNny5ZNyuT2Zlid8f99iFHL5GRkI5WgiJzNkh9VUU+Rvy1bUeYRN5rcWfREluWlGs8zI07cAN3EJaTGH8s4D1PIvTqsn7fxFaXQ4LFW7cXsyUURP6vbGOiSC2Orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkHq5c0WdPERIfAOsePlmqHmZKAi31vcpKwHmCmT2hk=;
 b=SYoPyHH0oFyfRDMVsdi+g4vO6+fDhhRucu540lI6wphT2BpPo4CbDzNnWznkJA4GGFc+DRZm+tJaTzJTuF9sm21Bq0vxx3mtmOjekBTFNM038d2O5a2jCCWU0ynpMbjNUI5ePzk+k0p1rjaJ+Gy7VCWHe55In1ugreMlFlIpq6kPEyItWc8SqPexdzHsJnIiDMfO/mK4YXG+IBRr6HEzStPlOa7nixtTtfmzCw6b1E5NUYoB+xDVnE4ItO7OPpsrhxxOJHaMVOrXeIYK2xYDXusgBul5WIMAKaUNFPKQ0SMgFcSKTZg3o66z0zwmHQrLBoySzOBvMMG0FDDiqIQZcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkHq5c0WdPERIfAOsePlmqHmZKAi31vcpKwHmCmT2hk=;
 b=Hj/IZIryQf8oFo8/7YziYUQxF9T8ixfxEo/OBafy2MRU7I2vGoIlvwWGVO8z3/fJZvIl9oVH13ohw3NdMhqDvAr9OcGScKY/u9c7rc1I0jbRirengv0UwE2gP2gRpIUi8yjJNiZB42brInj7knLmGvtkzWkxiPUthTprx+PmW/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 CH0PR01MB7017.prod.exchangelabs.com (2603:10b6:610:106::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.13; Tue, 7 Jul 2026 05:31:11 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:31:09 +0000
Date: Mon, 6 Jul 2026 22:31:03 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 1/5] perf/arm-cmn: Rename filter variables for clarity
In-Reply-To: <7022c44c7ef30cacf9923a704eca6953ffaea6b7.1782830759.git.robin.murphy@arm.com>
Message-ID: <13b5ef38-fda1-d760-25cb-d92171fd707a@os.amperecomputing.com>
References: <cover.1782830759.git.robin.murphy@arm.com> <7022c44c7ef30cacf9923a704eca6953ffaea6b7.1782830759.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0259.namprd04.prod.outlook.com
 (2603:10b6:303:88::24) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|CH0PR01MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e629e4d-434a-4a98-8cf8-08dedbe8f21c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|55112099003|11063799006|56012099006|4143699003|18002099003|22082099003|21046099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7z7wTxGniIjfUQYFCwo4yV8JFSQW/qUF7ukbtJGicORqgE8/D5Z7B3lj/1mclXl21bgsv3OKltCHTklMjH06IdG9vnaFAn9r5Zh7cI53oUX86qLJfNi8f1jM/y5W2ddjJ3OXM55W9Kyyn9HBJT9cYtg1fwk0tt1XzN6YdVF7ldXVQoS+QA61EbSiKvpPRY7rdzmQiKCt26kozHo2a4EKq0E0KhDyW3nhCYBH0co6IuuRtlEGS8R27XOi5629RYv1bcx9XC3U0nw9BMl3YWD+GiJV/eJ1F1xgSISNJSmjn0ajROey7SReO/Vtsl8tTJyv/48L0dokwEyQkcWDnDULMRdzBMuxsYTIqT52ZRmjHDryIIPo1JErae2PwM5G96HavQr6NCzd2cNjgqak2Z4bx3I/NrpD1fVhBDLvyg7tibaOmiuMj3A7uAAaxtqUlpYdJG5FUCbanIaE+Mbc6p5l9f5I7h/2gfqGbI/OZ3nKUgtGz2ed6z8fOIasiX39f6Vg4DiRHtGcX0GZkG9EVcQTqLHWJ6f+qX6+6dbUVoSqlazR/zf1VKMqvCWfhXW2kFh0NT64yScpsYnyS08cQeJtrwBi6biJik5LyhbX22kOImXqyGf8V+EQzGuF4ekIt7t7NGyqjdFp1TRtUgEOxTMdqwa5fBwCfbgCem6RHAO7N+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(55112099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003)(21046099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZIW+rk7th/kTwHYySBwdb+ej1nEa1QqT0SoGPGgnQeXN0EFASxqALHbZ+w7?=
 =?us-ascii?Q?B2E/eLBs3iOf6DblUSNTJ85HhYlizOvnlyfMVyQ+b5FKXNO+mqLDrd3lmdX3?=
 =?us-ascii?Q?f/g/hEo8Sb8SU+rSaDv9QqsC02gMMKIVfXL6cY8UVm+x/CTmPjaL613ZtXlv?=
 =?us-ascii?Q?YpqcxJ4jAdrBw/Y+nC7BPBcA+UNYJGpnBKqrAGKSMmUnG5jyBpsbxRmjjgYk?=
 =?us-ascii?Q?DXteL9Tv5FodqxTdDZ/VgmghSNxdDz875DtH2GGVGnshclxlh0KgI+5n1841?=
 =?us-ascii?Q?Xv50nifTfSN9nvKHEebjO/zxWQdbZvz+oOsHwt/wZLP0RWU/xtOpP8jNnM5p?=
 =?us-ascii?Q?iwXzlbpth3F7DmkL+aY8BH2hDuNPoNjZOlosETiHJv0VVjX6MT5Xc3vW1bmG?=
 =?us-ascii?Q?1nI7hThWPD5GjUbcHGRuwtSLCNsZysXRyLzkwWEO2KoHdjofd6ErVIkyEM3v?=
 =?us-ascii?Q?bP0l2WWJuQ+E9vt2mFqAxCc7+uk6DQNTELo4V0bRA0+bgyyVRWOydHh4dYCH?=
 =?us-ascii?Q?yEkQ84CnwpTByP+S4hyiOOKWIfknNV+A3Tw/ihfP9t2WECuflJPEXNF3LUFj?=
 =?us-ascii?Q?y9e9qgljTPYZAmyI8sQD1nQ5O5dNAzL0tYG4GoyvRB4rz5kYCwPVVQPTe2xU?=
 =?us-ascii?Q?De/7CqyqoehlcywOMjGCDtvYrwJsK5a5EcC2JP+BiDaN8QNb6RZqf4yJAHX4?=
 =?us-ascii?Q?cLSwVCa81FQ2odB1LG/tDKtgMKYD8QMAtkbzpUX+gp+X05lw/xskIMWhF8ln?=
 =?us-ascii?Q?iyEebdxcqqHdVGsmfcKIERy06lp6AkSuC4WOJdXiPJ6R1cnRif60Uz1rlbkc?=
 =?us-ascii?Q?BGS/bzFu9NkSy6vMqPfVVgyitk/UI2STMFpw46HEfpEmhOdOy5hwJ4IjH3dc?=
 =?us-ascii?Q?xb+WlftSd+JwH4yfDavCXVUR0GcXljJRupCjeS8EnE2DhTLaN2pGvCyPt1eS?=
 =?us-ascii?Q?cT48p6GWGltVKkh0jMQgFh5Pv5STClAdM5DbHayeVEcbukqfBmzTJgVMb+fx?=
 =?us-ascii?Q?dci4mnEVgcJ1j69DEYUHWi04AS4rwYlkZ8A4ZFw0+636kuMFqad0Xo+uUFAF?=
 =?us-ascii?Q?afNOQHivQBKohzI8N6yjsm+5rDim/pjMJJWrJNbzY+/t3u/voeeu0MX2XYrx?=
 =?us-ascii?Q?FU5EjKFPtlCIBoQRs9thN0/8I7TkTWaZFy3u0MHFBFlBPF+isCtRg/YABhIB?=
 =?us-ascii?Q?z2zImWimeeFHMVG0Camq53Fu2zBj/H++9PnEgjkwDJ2MPtq+8Pf2PJv35RHV?=
 =?us-ascii?Q?/VA0RJbbHX789n4PXgxLav1Prr0biu9NAu7UBu6lKrNXxO80FgQ966ht4nA8?=
 =?us-ascii?Q?T33aHW7HNfR2xU2Z2435nx7ozqRdfkhkXEKOTcst8RLyOWQiluH3wBkMF15a?=
 =?us-ascii?Q?2OyTJl7XEh7Xn8lk8N6m9owWCP5m+7QMeP/MutAk1il+70GVpGfHsgAClT6L?=
 =?us-ascii?Q?czPsd+upuh7n89hcuntJtp4lUOTM4TvvMnI7vStg0j604LFQIYtWThokwUCp?=
 =?us-ascii?Q?GhrrcAEjL72duFKJTU8cMj+xTEDerj3sRO0IQbD0Ikl6KW182GS+f/mzwqGf?=
 =?us-ascii?Q?aBMW7vmClKP5fu8V5fXvBUCTyVHpu6ZDKLt2+StL4xIIN5SQIK5oaSVfW9w5?=
 =?us-ascii?Q?SlLtBBQjuPm6BnwmnIgZ5r3+terlvu4s4dSJ4fMD3vYiY+tuclsXKwde83EV?=
 =?us-ascii?Q?2ENUGZdSQj3n6r7EGLJntcM36KKeLzVDEbgwjT+6Ud6yXQzSZtzZbp2wqEnA?=
 =?us-ascii?Q?sdxAIZLd3xRo+FPZS2UZcwgsLBsL9PU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e629e4d-434a-4a98-8cf8-08dedbe8f21c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:31:09.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDM0FDd2qFtGabArM0hpvVuRv2cXuQWyNEWzrTZC0zxmLM6U/h+FXfzL4U+XVnVEUmIrCwt7A9DX4Ut9Y0zHh1r/uJSTkwKdnAGWI5jb4N4AFOhs9jk5e/YFQ3GJLkbl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7017



On Tue, 30 Jun 2026, Robin Murphy wrote:
> CMN has already grown many more event-specific filters than the original
> Occupancy ID, but since they are all independent of each other we've
> just overloaded them onto the same name. Before we add yet more, and
> they begin to overlap, rename all our "occupid" variables to "filter" so
> that things can be a bit clearer and more consistent (but leaving the
> format attribute itself, to avoid UAPI concerns).
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 53 ++++++++++++++++++++++--------------------
> 1 file changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 50402bc4a21d..2a8a67da72c3 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -163,13 +163,13 @@
> /* Event attributes */
> #define CMN_CONFIG_TYPE			GENMASK_ULL(15, 0)
> #define CMN_CONFIG_EVENTID		GENMASK_ULL(26, 16)
> -#define CMN_CONFIG_OCCUPID		GENMASK_ULL(30, 27)
> +#define CMN_CONFIG_FILTER		GENMASK_ULL(30, 27)
> #define CMN_CONFIG_BYNODEID		BIT_ULL(31)
> #define CMN_CONFIG_NODEID		GENMASK_ULL(47, 32)
>
> #define CMN_EVENT_TYPE(event)		FIELD_GET(CMN_CONFIG_TYPE, (event)->attr.config)
> #define CMN_EVENT_EVENTID(event)	FIELD_GET(CMN_CONFIG_EVENTID, (event)->attr.config)
> -#define CMN_EVENT_OCCUPID(event)	FIELD_GET(CMN_CONFIG_OCCUPID, (event)->attr.config)
> +#define CMN_EVENT_FILTER(event)		FIELD_GET(CMN_CONFIG_FILTER, (event)->attr.config)
> #define CMN_EVENT_BYNODEID(event)	FIELD_GET(CMN_CONFIG_BYNODEID, (event)->attr.config)
> #define CMN_EVENT_NODEID(event)		FIELD_GET(CMN_CONFIG_NODEID, (event)->attr.config)
>
> @@ -301,7 +301,7 @@ struct arm_cmn_node {
> 	struct {
> 		u8 val : 4;
> 		u8 count : 4;
> -	} occupid[SEL_MAX];
> +	} filter[SEL_MAX];
> 	union {
> 		u8 event[4];
> 		__le32 event_sel;
> @@ -672,7 +672,7 @@ struct arm_cmn_event_attr {
> 	enum cmn_node_type type;
> 	enum cmn_filter_select fsel;
> 	u16 eventid;
> -	u8 occupid;
> +	u8 filter;
> };
>
> struct arm_cmn_format_attr {
> @@ -681,13 +681,13 @@ struct arm_cmn_format_attr {
> 	int config;
> };
>
> -#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _occupid, _fsel)\
> +#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, _fsel)\
> 	(&((struct arm_cmn_event_attr[]) {{				\
> 		.attr = __ATTR(_name, 0444, arm_cmn_event_show, NULL),	\
> 		.model = _model,					\
> 		.type = _type,						\
> 		.eventid = _eventid,					\
> -		.occupid = _occupid,					\
> +		.filter = _filter,					\
> 		.fsel = _fsel,						\
> 	}})[0].attr.attr)
> #define CMN_EVENT_ATTR(_model, _name, _type, _eventid)			\
> @@ -709,8 +709,8 @@ static ssize_t arm_cmn_event_show(struct device *dev,
> 				  eattr->type, eattr->eventid);
>
> 	if (eattr->fsel > SEL_NONE)
> -		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,occupid=0x%x\n",
> -				  eattr->type, eattr->eventid, eattr->occupid);
> +		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
> +				  eattr->type, eattr->eventid, eattr->filter);
>
> 	return sysfs_emit(buf, "type=0x%x,eventid=0x%x\n", eattr->type,
> 			  eattr->eventid);
> @@ -1320,7 +1320,7 @@ static ssize_t arm_cmn_format_show(struct device *dev,
> static struct attribute *arm_cmn_format_attrs[] = {
> 	CMN_FORMAT_ATTR(type, CMN_CONFIG_TYPE),
> 	CMN_FORMAT_ATTR(eventid, CMN_CONFIG_EVENTID),
> -	CMN_FORMAT_ATTR(occupid, CMN_CONFIG_OCCUPID),
> +	CMN_FORMAT_ATTR(filter, CMN_CONFIG_FILTER),
> 	CMN_FORMAT_ATTR(bynodeid, CMN_CONFIG_BYNODEID),
> 	CMN_FORMAT_ATTR(nodeid, CMN_CONFIG_NODEID),
>
> @@ -1333,6 +1333,9 @@ static struct attribute *arm_cmn_format_attrs[] = {
> 	_CMN_FORMAT_ATTR(wp_val, 1, CMN_CONFIG1_WP_VAL),
> 	_CMN_FORMAT_ATTR(wp_mask, 2, CMN_CONFIG2_WP_MASK),
>
> +	/* Old name for UAPI compatibility */
> +	CMN_FORMAT_ATTR(occupid, CMN_CONFIG_FILTER),
> +
> 	NULL
> };
>
> @@ -1544,30 +1547,30 @@ static void arm_cmn_event_read(struct perf_event *event)
> }
>
> static int arm_cmn_set_event_sel_hi(struct arm_cmn_node *dn,
> -				    enum cmn_filter_select fsel, u8 occupid)
> +				    enum cmn_filter_select fsel, u8 filter)
> {
> 	u64 reg;
>
> 	if (fsel == SEL_NONE)
> 		return 0;
>
> -	if (!dn->occupid[fsel].count) {
> -		dn->occupid[fsel].val = occupid;
> +	if (!dn->filter[fsel].count) {
> +		dn->filter[fsel].val = filter;
> 		reg = FIELD_PREP(CMN__PMU_CBUSY_SNTHROTTLE_SEL,
> -				 dn->occupid[SEL_CBUSY_SNTHROTTLE_SEL].val) |
> +				 dn->filter[SEL_CBUSY_SNTHROTTLE_SEL].val) |
> 		      FIELD_PREP(CMN__PMU_SN_HOME_SEL,
> -				 dn->occupid[SEL_SN_HOME_SEL].val) |
> +				 dn->filter[SEL_SN_HOME_SEL].val) |
> 		      FIELD_PREP(CMN__PMU_HBT_LBT_SEL,
> -				 dn->occupid[SEL_HBT_LBT_SEL].val) |
> +				 dn->filter[SEL_HBT_LBT_SEL].val) |
> 		      FIELD_PREP(CMN__PMU_CLASS_OCCUP_ID,
> -				 dn->occupid[SEL_CLASS_OCCUP_ID].val) |
> +				 dn->filter[SEL_CLASS_OCCUP_ID].val) |
> 		      FIELD_PREP(CMN__PMU_OCCUP1_ID,
> -				 dn->occupid[SEL_OCCUP1ID].val);
> +				 dn->filter[SEL_OCCUP1ID].val);
> 		writel_relaxed(reg >> 32, dn->pmu_base + CMN_PMU_EVENT_SEL + 4);
> -	} else if (dn->occupid[fsel].val != occupid) {
> +	} else if (dn->filter[fsel].val != filter) {
> 		return -EBUSY;
> 	}
> -	dn->occupid[fsel].count++;
> +	dn->filter[fsel].count++;
> 	return 0;
> }
>
> @@ -1649,7 +1652,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
>
> struct arm_cmn_val {
> 	u8 dtm_count[CMN_MAX_DTMS];
> -	u8 occupid[CMN_MAX_DTMS][SEL_MAX];
> +	u8 filter[CMN_MAX_DTMS][SEL_MAX];
> 	u8 wp[CMN_MAX_DTMS][4];
> 	u8 wp_combine[CMN_MAX_DTMS][2];
> 	int dtc_count[CMN_MAX_DTCS];
> @@ -1694,7 +1697,7 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
> 		val->dtm_count[dtm]++;
>
> 		if (sel > SEL_NONE)
> -			val->occupid[dtm][sel] = CMN_EVENT_OCCUPID(event) + 1;
> +			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
>
> 		if (type != CMN_TYPE_WP)
> 			continue;
> @@ -1745,8 +1748,8 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
> 			goto done;
>
> -		if (sel > SEL_NONE && val->occupid[dtm][sel] &&
> -		    val->occupid[dtm][sel] != CMN_EVENT_OCCUPID(event) + 1)
> +		if (sel > SEL_NONE && val->filter[dtm][sel] &&
> +		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
> 			goto done;
>
> 		if (type != CMN_TYPE_WP)
> @@ -1892,7 +1895,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
> 		}
>
> 		if (hw->filter_sel > SEL_NONE)
> -			hw->dn[i].occupid[hw->filter_sel].count--;
> +			hw->dn[i].filter[hw->filter_sel].count--;
>
> 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
> 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
> @@ -1978,7 +1981,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 			input_sel = CMN__PMEVCNT0_INPUT_SEL_DEV + dtm_idx +
> 				    (nid.port << 4) + (nid.dev << 2);
>
> -			if (arm_cmn_set_event_sel_hi(dn, hw->filter_sel, CMN_EVENT_OCCUPID(event)))
> +			if (arm_cmn_set_event_sel_hi(dn, hw->filter_sel, CMN_EVENT_FILTER(event)))
> 				goto free_dtms;
> 		}
>
> -- 
> 2.54.0.dirty
>
>
