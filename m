Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020111.outbound.protection.outlook.com [52.101.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396837E308
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810182; cv=fail; b=PT6TOEw44orFohWvRbiWUeT3Cm3hP2EMjuuYStYDeKeH4E9wRvWGu1UiMZ49eMa0Y2YF3gCddhiR9nA1Zzz+wbxRwja+gcI4XDkXok6UZXkX7in7htyMoT9LuxBkxJe2+RS0R04VBLWArhgQmGWVXeI4TPL2aywM/rl6eAELDSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810182; c=relaxed/simple;
	bh=llgNXn14wQuBY6cH44CAFUywRFmObEA8MZr8nCbN1+A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=RsGwwrZvm4n0S0n9VuEhREz5UKZR8hAeaqlzkLG2Eo8H2veVbe4SBQhjiFJpzAhye/RbpqxyMvTxxY3/vGGUHUZiX1TkmJDjboAA1Ojaa7uDgUOZHvmaimhOyyJV4prxk6K5mR3whlphfym6d9ke5rkmEeTDSqVYZ41OMwFrRdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=fH10m2k0; arc=fail smtp.client-ip=52.101.201.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="fH10m2k0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA3mBPJoUwZy1NiXWfiLc5/31GOvTC5XlJ6TlT08Qz3wBWqD/TCzuN70myof8QL+OSQ/n9l3EA2wbFmVZjbeq830I2w87JY64JpD95HcfG5OuS8lojDbQTYHM5y/hB0u7m5ZUTl9isPXoEcqfCCJBOc9h+mibKUenHZWuYnoT1IjqdD7Ye+FxpH8tz9JTSCOxrs48hx13Q7enKAQqnvKO2jTeNnEDnRS5A2ObxanVtjbuH1z+nMkmLOAIwzXFOi/Ocis5WscC5AdBSIzYCh0GFK6lcSsgdakOb7uS+RauCYvs9UIZR+dhb/pXRqsGzOgTWBGA7zIiMJbJHO2iGDT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4mbcWu7TbXA5y2ZtqzgzMPuzlmBBWzoEYQ15SLe3tM=;
 b=goxrd+969TPY+Iil/teZxZtkqVxQhs/DUeBlMFrapZJLvHtlq6Q0Nwhd5LwMZVCMwXALVX82bMwFC2bEMBU0MKUwM5e6j7n379psf8YZULwYVF0IBjR0e0/OS/FUa2FgwTXNz5lteCVy7emNNMN+womoJhEaRAaH2AYSDxmGMOo05mht45PxOxOFP72V7jZmGELbSPZZx01y6CHz3e0rHs3e7QXmI6S5oclsg2HxIrhMblD0IN8DycJruMUd/tHbUNHknYn4d5evIp1ogJK7QuvsBEKYaKPMWgMK+ABJziPUqoDasZSurI7uZrGhPHkfECpA5MHQgn/7nlsSBlLMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4mbcWu7TbXA5y2ZtqzgzMPuzlmBBWzoEYQ15SLe3tM=;
 b=fH10m2k0osxDiZVJ0yL9uCm5cVbExm8izwnsOSzARndoURHQTn/XWi74ryNshTjF+ejIWz9bcxdXDav+rSV7nDJfKkssUTQuYziiiUhKegvE2LoslX1dllBJk89rn9+Gwss0npmSHOr2OQdli4+GgRWLsYM8DSz9jF7WVyqNAmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 DS7PR01MB7736.prod.exchangelabs.com (2603:10b6:8:7c::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 02:22:57 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%5]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 02:22:56 +0000
Date: Mon, 3 Aug 2026 19:22:52 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com, leo.yan@arm.com
Subject: Re: [PATCH v2 4/5] perf/arm-cmn: Plumb in new filter types
In-Reply-To: <90465c737b71be5d39c3662c7ba07ab6a1326009.1785252273.git.robin.murphy@arm.com>
Message-ID: <cee843db-c278-943e-7c04-2862a836fbe5@os.amperecomputing.com>
References: <cover.1785252273.git.robin.murphy@arm.com> <90465c737b71be5d39c3662c7ba07ab6a1326009.1785252273.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:303:87::9) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|DS7PR01MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: f619354b-7a6b-4443-415c-08def1cf4bf8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	RHGpVvr678VyIq/3t92TlZUIJ5l/AGfIIcfk/Hai984VO4nige9shfnppa1o8t/RZ6Cxb0QSlq8bH05G3XY2lq8vDaUgMdG26cGp3K+PGkqqRdkgfm1KqIuyKde4dehrdY8jWtWGReTS7M9zX1guGaXGf5NgCKQP9BR8/vyrEFKEiSBMAao1ggMEItOOkHQSJgo/XUwaxaTPtam90QpJA7cwmfB1GHITsjXnePwEGB307monD1klrTQuQlJg6ZEQ6vM817ZfYrw+T1LQc9S8hPEczz94jaxzua2lOZwoCzU44mUwGlvp67P7IAdb1C+Z+KPstOZJ895HXWkbeYFLRxneRnItyU1hUYP1JzGm0lG6KsJ+FuBrSzSOqyGyOydgFkcaWGl4JujSnsz7gGSRQKlnqknfPAyRm0bLifT+7JEFVNVGtPdzCfi/Z53H+JPryMgCxNhXfsGkS5LLlHWG1H6iqOzkjMa7dzVBh/JAWfBQZ9WX29od3kqOXBgicsOXFoqTSt7lJF5noBnpE+IBCDhCATM+2RC8r5EyV+n/x4C6GJrGXPKF8MuE4ZisSnUqh6vUnXqdbBctbITYoQrjVtB3ocwYjOyGu3Ma/2MvhTQ3aApopQHuEGhgWOxdE15wL4xcbsorTmW7/V6rXnmug0HyYJkQJoOn2GYCa32MfB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f72tN6MLEOYLYwd2PCgVGiq8VqODKbFkBAV8yI7W50Fdu4gqyg8ZEWPhQKIn?=
 =?us-ascii?Q?2FzH+zGE9WDtjNNlamIGYuBrHba8Zxq/PHLuPf03Y0RoukAiNsPyEy4KH7rt?=
 =?us-ascii?Q?BqrrXdbdHN0ssOha6GoN1j+7PMcEaYwt8AoKFEwdPjDWnCbfNYj3WTxr/fYH?=
 =?us-ascii?Q?ZXUij50vX63QOCaZC4jBDaqMCOweGUQjVHssj/DLRCQZDkGXSawB25bEkOG/?=
 =?us-ascii?Q?86jCIt05zNveEdwMcIpFF0CUlOtCQv1ssUrqw9tzC0MX2o2ItP7LzjqPm1Ke?=
 =?us-ascii?Q?syS8sbrkqN+fq+gQLdIcv2O5uq1hK0N+NQ8JY7KzLZvReMmHX8LUHMrDR3eM?=
 =?us-ascii?Q?6zVfItE9NCat1I4FSZJ8YaoskIgjx+T/40j5i6fua7+6NleoWUwIWspwrD6l?=
 =?us-ascii?Q?Rv1WPYUENM8xIrJjGcW9Zt/TGkpLPJEfrhd1QtPd9+Yn60X1Ne+fl/9Ew8xZ?=
 =?us-ascii?Q?jK4+m26KdDA/b53lPvCXdufET9TAIjz4CZ0lyEuHnyHljKAaOKwX7Fwvnsqs?=
 =?us-ascii?Q?FQbjzcyfw0IzJYq40QUaovC/qI+V38kKVHS11YGL0VdZlHwEjkcGF/Eh9yzW?=
 =?us-ascii?Q?bmjz3xGL1tK+IiQVBagdIuMQ99j9lcqdoLCOXGCrjCaeYR2CrvutCy9vK63p?=
 =?us-ascii?Q?bKuHJXj73M6nRXI6Vwf4IDfF8PQVY5lrsj5itXl+rsLicKYOOiYEWtR7NiTy?=
 =?us-ascii?Q?ASgHPJGebGt89Hk0FGbGX9r1XWlkiGD1WsYxTDHd0j7BxpIFgNHXmEhI+lrH?=
 =?us-ascii?Q?PJvwzNg7wGS1LuyiXxCTGfPeWDvbD4FjW0NWoCYSyw/sQeBqdaRjIOuE2YEs?=
 =?us-ascii?Q?OD8HKeTHX/5olxcv0PSTzYDfs0ts2ACkse5kAPUpJedgXgWeMNSNrzQTIqA3?=
 =?us-ascii?Q?CjA6Vvn5c5yn0zCP7cSzw/LeM9n9WHyRifs3GCdsK4dOiss7AeeDLz2odiw5?=
 =?us-ascii?Q?EUaPgdd7eOslcYnKhL5FQrV5N9zUQydE/Ir4lhZqR2ONsb2rL2Rui1ncVJOz?=
 =?us-ascii?Q?FhcQ5SEdgOR8nDMB34TV3IUKuyaHbgi5J50kZJ/lEvwqGZYaOyDRVUsExguJ?=
 =?us-ascii?Q?pxcVzYB02YByHt8MdixTqySTx+5XL2CxeXVaid8rM6DvMq+O6qUfTtGWHpNL?=
 =?us-ascii?Q?5THN3GCbc0uZyqJktB5P2pLqLApMNzGrWoFiGfL93jlwYY8tLWAj1KbSLSLa?=
 =?us-ascii?Q?ohId5+rOB21I3DAslzRzKhyXc7FA2qOCbi3py++Nd2U9ruXAwRGpzP78OSPk?=
 =?us-ascii?Q?EAROdTy5gT/PVMQDYoYB241qBLJummJeDG/YFZ8XEtq94qY+wU4Z5ZtTefUP?=
 =?us-ascii?Q?SbiEzTUDlf7WAhKZ4mZSkpMlGHmau/hMPvwVX0olxWP0uhS4CslpwfKAiLIS?=
 =?us-ascii?Q?CKwQjwvwsetdEsE5tHz/tX5v4UbGwfc+ULWglicDUqp3+upiXPt9hORsCEbm?=
 =?us-ascii?Q?WGi9Z2FQHnNnD7iH9jExQ0ZiCLCeK+FPCk1tTUPDJYhXeLJNX1k1c9F/BCNZ?=
 =?us-ascii?Q?Xhgh0zWtWW/6IGa03LC5i/02YNbHQFz9jbnrJRhmKC154Ehi5F1olgvp5Sut?=
 =?us-ascii?Q?B0KUtHnlyxUoeRIboWsEMq/pJX4nFF66cxDl2f5OL1eV7ADM/oeHXycOroqv?=
 =?us-ascii?Q?BFMPzs7oKc//VoonUCyXNWAfCRcSVj50isAJybTAzt/V/wmVsSu9NCOnoaJu?=
 =?us-ascii?Q?NkEABh733NUlopWFIjqYX6ofns9XQzFYwW0RsPh+TfASaDYb9F/YKR1oym5G?=
 =?us-ascii?Q?/2Qp0C43ZWNUwVovNVuoG20KuRv+R6k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f619354b-7a6b-4443-415c-08def1cf4bf8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:22:56.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQgjJEDquPKM7wdzOuYYxyXD10mQUscLYbLhBo0kXitw0yb0+8wPu64Ln6pkViNt+UUO+OhA6VKRKLyC2R/fs+9Zo8KNyosV+NMV7+t9aMxyDOJili75f+Xh9fs8OhVH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7736



On Tue, 28 Jul 2026, Robin Murphy wrote:

> Add the logic to handle events with the upcoming new filter controls.
> Since for now we will have the sole invariant of all EVICT_STATE_SEL
> events having HBT_LBT_SEL as a secondary filter, for the sake of
> simplicity we can just special-case that, and save the complication
> of a full multi-filter abstraction until unavoidably necessary.
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

LGTM:

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
>
> v2: Tweak commit message
>
> drivers/perf/arm-cmn.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 74bc2aae4a06..e25f46c38c23 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -166,12 +166,14 @@
> #define CMN_CONFIG_FILTER		GENMASK_ULL(30, 27)
> #define CMN_CONFIG_BYNODEID		BIT_ULL(31)
> #define CMN_CONFIG_NODEID		GENMASK_ULL(47, 32)
> +#define CMN_CONFIG_FILTER2		GENMASK_ULL(51, 48)
>
> #define CMN_EVENT_TYPE(event)		FIELD_GET(CMN_CONFIG_TYPE, (event)->attr.config)
> #define CMN_EVENT_EVENTID(event)	FIELD_GET(CMN_CONFIG_EVENTID, (event)->attr.config)
> #define CMN_EVENT_FILTER(event)		FIELD_GET(CMN_CONFIG_FILTER, (event)->attr.config)
> #define CMN_EVENT_BYNODEID(event)	FIELD_GET(CMN_CONFIG_BYNODEID, (event)->attr.config)
> #define CMN_EVENT_NODEID(event)		FIELD_GET(CMN_CONFIG_NODEID, (event)->attr.config)
> +#define CMN_EVENT_FILTER2(event)	FIELD_GET(CMN_CONFIG_FILTER2, (event)->attr.config)
>
> #define CMN_CONFIG_WP_COMBINE		GENMASK_ULL(30, 27)
> #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
> @@ -284,6 +286,9 @@ enum cmn_filter_select {
> 	SEL_CBUSY_SNTHROTTLE_SEL,
> 	SEL_HBT_LBT_SEL,
> 	SEL_SN_HOME_SEL,
> +	SEL_SNP_VC_SEL,
> +	SEL_ENHANCED_HBT_LBT_SEL,
> +	SEL_EVICT_STATE_SEL,
> 	SEL_MAX
> };
>
> @@ -1377,6 +1382,7 @@ static struct attribute *arm_cmn_format_attrs[] = {
> 	CMN_FORMAT_ATTR(filter, CMN_CONFIG_FILTER),
> 	CMN_FORMAT_ATTR(bynodeid, CMN_CONFIG_BYNODEID),
> 	CMN_FORMAT_ATTR(nodeid, CMN_CONFIG_NODEID),
> +	CMN_FORMAT_ATTR(filter2, CMN_CONFIG_FILTER2),
>
> 	CMN_FORMAT_ATTR(wp_dev_sel, CMN_CONFIG_WP_DEV_SEL),
> 	CMN_FORMAT_ATTR(wp_chn_sel, CMN_CONFIG_WP_CHN_SEL),
> @@ -1745,6 +1751,8 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
>
> 		if (sel)
> 			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
> +		if (sel == SEL_EVICT_STATE_SEL)
> +			val->filter[dtm][SEL_HBT_LBT_SEL] = CMN_EVENT_FILTER2(event) + 1;
>
> 		if (type != CMN_TYPE_WP)
> 			continue;
> @@ -1799,6 +1807,10 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
> 			goto done;
>
> +		if (sel == SEL_EVICT_STATE_SEL && val->filter[dtm][SEL_HBT_LBT_SEL] &&
> +		    val->filter[dtm][SEL_HBT_LBT_SEL] != CMN_EVENT_FILTER2(event) + 1)
> +			goto done;
> +
> 		if (type != CMN_TYPE_WP)
> 			continue;
>
> @@ -1943,6 +1955,8 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>
> 		if (hw->filter_sel)
> 			hw->dn[i].filter[hw->filter_sel].count--;
> +		if (hw->filter_sel == SEL_EVICT_STATE_SEL)
> +			hw->dn[i].filter[SEL_HBT_LBT_SEL].count--;
>
> 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
> 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
> @@ -1961,6 +1975,11 @@ static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf_event *
> 	if (fsel)
> 		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
>
> +	if (fsel == SEL_EVICT_STATE_SEL && !ret) {
> +		ret = arm_cmn_set_event_sel_hi(dn, SEL_HBT_LBT_SEL, CMN_EVENT_FILTER2(event));
> +		if (ret)
> +			dn->filter[fsel].count--;
> +	}
> 	return ret;
> }
>
> -- 
> 2.54.0.dirty
>
>
