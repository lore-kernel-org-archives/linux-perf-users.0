Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022107.outbound.protection.outlook.com [40.93.195.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480953A7194
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402649; cv=fail; b=b0vygLXIrRplYAwMK2G+2eBCYyKMwwfuQGfSLT1aXkldWzVG3sAGmkJKQNc0gRj/ljxf692K0StWgKuH8ibUKsl6suyJRgTOlkS8usUC1Z0kdiOjV32TJvOh8HtLKY+KDsETFJrgzdlbdFUsknBNhbRT+9Nzv9RQu0Q5T5ozsMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402649; c=relaxed/simple;
	bh=TT8Im5fFqb/sI23tc/NeIS44qZDrcyqKv8QdPyuOAsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=s04aBaEMn0xzSc0a+h0zqGVcg1MX/5+Ru+8L5oMZfPrYQMgMLHboO0LgqQo8vZsgPRTsexMDjZQqW+gOmLvtUxN3mtDEyS/EZRDT9hKZ7i1iuov9HK5Uy0b20knSXZv/MGD3D7K44a+04m2Sk2Qd4pQTsULvvSHaPhh3HNIOwds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iIu1Iz01; arc=fail smtp.client-ip=40.93.195.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iIu1Iz01"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a16dw6sPC+StIAO9CkubSEwuHHlgQ4naCE/nQ+xDWlv4QSdJ4Uo3wVah/jhIb5KVpD+G3sE9E/uSUgoC9r4ZSjSPq5sI1vDN8Z5fe5OaZ16dH+sMmsWuT2SUPxyJAhj/B5Ied0J0UCga5FMlGknMkRNfrt4V2vtH+lFsMl6G0hXJaugW9PYcMFgH5uenMmmuM1WjD3WW1msb4pakTe68+FjEIxNLjVkt0PtDyWI4x2w1EiXytMkH9dqNMkWGLvptkhzcxBBdXRutegpzbGrCG8r5TmyDRfSl/3uayo+IsWEuMLCyB62yGXIkWpGV0R7fb77PZqK/WS4+idowWQ6piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjuixKwOSpFqVo0486RnOlsx+Vq/hlqOmQ+YBFIVlCY=;
 b=v3Pt6GjUeWFkz3Xi6nBb7FAJKLEkvxP5hT7Cs7hUouXqVYNv6Nqg8gobv55L2HyxkXdvMytpI75z5ImLw8680npwIGABnQ1yQm6uF+PfntWN0NTBndydQeR048CZbs5HUZp5dcumsHRAlxjSjV7nGGwLpM2oP9u/bc1nobSb3f+/uPYnGPLV9x960MXgm6URaEsZFTp3ZS9Kle7QOzqfeYURc4unjBbTCdOobOsiFPKs6b7hZc4P4lRo47hZ0tGpON6b/bGHsJ+4HZbV5yxYgpzAb41pMLvFcgbgTakEICoECIjJHOIGpCdNsLUmrgPgjJOojWcGn6MtREt8RRd1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjuixKwOSpFqVo0486RnOlsx+Vq/hlqOmQ+YBFIVlCY=;
 b=iIu1Iz01ReMLmc1yX4W+W9pD+R9nvnGeTjUoumurVHWdXQQgUZv6jgAl+zbUY7eC5tjNjDiUfN16Q6RFx90xL6jhPn4A98g4vuT1dXTAyOtWGOgYQJ3nqaiIr4MLX8Jh40ueALHIShFxCVtVy4haI+2IrvBfWwMKnV8nH/Rga4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 MN0PR01MB7753.prod.exchangelabs.com (2603:10b6:208:37c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.9; Tue, 7 Jul 2026 05:37:22 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 05:37:19 +0000
Date: Mon, 6 Jul 2026 22:37:16 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 2/5] perf/arm-cmn: Refactor event filter programming
In-Reply-To: <204a29eff358ffd2c6c248738c5e272dbc678990.1782830759.git.robin.murphy@arm.com>
Message-ID: <e9cf7adb-0c52-3484-2e54-5ada14b1c773@os.amperecomputing.com>
References: <cover.1782830759.git.robin.murphy@arm.com> <204a29eff358ffd2c6c248738c5e272dbc678990.1782830759.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:303:b6::23) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|MN0PR01MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc08656-e43e-4ba3-f1ee-08dedbe9cffb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|21046099003|4143699003|6133799003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+c6//E1SRora1/K46rzKO6cSNYISBM5mMr8kY1eMJnXPza7CqLFfwb/ofCQG5OEhpnHCguc/zuMJoJ9r1ELz0v75Wtrl0Uf001cid0vHXBlsawpVtq0jzYOFp5pOT5E9XFUWBj1Zd1Mk86In58CjpNppCBnFUfJtWywJEZSkdtpp9CY1GSi7/l+qyVCUIjpzVacPRL9NTQHeT6G8qXcmRiFwkb3T2950sZLhbACKI7sTi46Pe/yc4VKuzMXESlgbgY0xViJ6XAfvPkhFjCStJvwfvQqWSdKc1Xey1AEmMZNnyFLqKlP+yJ10JpQ4Fx9WgNJb92pGDy9rWlnCkNrfayFYQZT8zacCZ2KHbINrg0UJ1DwgjV4AUQwdD8yLCmCHsuzXywSk8/klKlNN5RXTmh4tQhOLNmyAXmRmKr86UCURE/Jx6WoDIODyjaA9pe82ejcE8ClJ8E70qBq952YntNXb1z+ZxvC3KqeLzGouYcdpViwl5bJ2PB9Idj8UTF/FaDn8EGPZr97AEQESXZCuBTDPVKhS0ef9ZmIn0WmdYhojoHtOCK/MoKAW7u/19ycNq8/pWtPN2GhapiU70gZ7VHTp2+RTBLRTJjm9zVD1ooXsbykzQRhTuBGpZdLeOCknyd/FFKcb3Gf458tihV+yAnzuHpdhCr5D+cRAO1sR+pI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(21046099003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eFsMom4EQ9N5LGTYtWuhjBVlLObqLG5+TgDlWtuGidkjvQMiiXNDJ9qUiVPo?=
 =?us-ascii?Q?QU2Pk/66+RLvUsWC//CaFSvbul7K8DjQj+Pkf/bPQeZrYKDE+QAgPjrOIA53?=
 =?us-ascii?Q?HJHtVbbfmLDa9Xg6ekdDSMoxBle8+xwABxmQWv5SaTtw2xL56fP0iBIGXvlQ?=
 =?us-ascii?Q?PJIpXdqj7qBcOE+kTkCXjyAEL/97I+LMMJdqMaUShq5jZKPeIe3SgOFQAml3?=
 =?us-ascii?Q?Ih4OH4JKAoaScZXv1Z1byc9sJpAgxAAzvLtftdRE/W8hwEebF1g09fDe63cg?=
 =?us-ascii?Q?eMVxe/BLGK5/iUBhJG+SnwLI2hMVbhjrkFyLT4/C6aVojoYRuP2CSWVrkPUU?=
 =?us-ascii?Q?2i/Yn6ERXkZ8DASB7ns0XCsiN2RdzOoj8VR6t79LgmmGglQcQm2Dd8XixndR?=
 =?us-ascii?Q?uh0w00uoT3m8DeIsErSFWR8hSZjqPzKYsG8myyU0vdCoKyWLieXHWS/bqW+p?=
 =?us-ascii?Q?Xt9YA037GhfqHRxWC7ivssNO4P7dVQ7sQ81gUIZRjltcXwfmoOwbO9vmnelS?=
 =?us-ascii?Q?UPKjrh5iS1h4tyOq5Xd8rQx+ljqlkjq41zTVJEc39db4YW7mdITALRdaIbq4?=
 =?us-ascii?Q?j8wR7Myjica+Dpgi95gG5fi6AWUBFn5XYDb8OZBu6Ea1jriQwENwVSqoynEn?=
 =?us-ascii?Q?DnPxZU/X8r5g9FzRvHIgdkrz+JTsRJbGiFmseE/MW4O6E3jNUJs1cajcqPE1?=
 =?us-ascii?Q?4c67q3H/3+Oy5Ily9nbe2hmFVDuC5v/ySU+TomcI9xIVfzUJe6MTnD6VnK3m?=
 =?us-ascii?Q?08vDCtHrMovaSekNLSqcbkKhuAEt8uo5wjdW/LJtcJYJ7p8vaRpq7aquqv7K?=
 =?us-ascii?Q?/Lu4zEs7llKj9bi3dSptZwgTzTYojHe4LM+H2XZGDVogSwFcM10K1TH9xhHS?=
 =?us-ascii?Q?bPGLiNEaZlBUDJISjei2R3yA9699Dvz6Sri6++MR/ie9KZk+LBTlja8yUQzd?=
 =?us-ascii?Q?02RSt4WLwbRi32cThR2vaxnl7f0Om3+6kt8TCaUliQ+OXtp6yKjkU5f7042G?=
 =?us-ascii?Q?oknHO1up8ICj59MLTVtcsz8OGq/0g1r4E4HU5w8Sny9jzQj1Hez4utHmNBBV?=
 =?us-ascii?Q?l1PPOw/8LXqHVK+8RGXicucSXnI+bjNG25L7ruggkJlM7ckAOhuZMyx4jyCL?=
 =?us-ascii?Q?7Io611PMvDl6pmmod6O2jBOHsnItZcRSuXzKkcFXWCzTbtfq07aan7zLiNto?=
 =?us-ascii?Q?xw6go1HKZIeW0iHN+yVbBhUMCX+SdloBJ3F5zfCJuJI6pDDy9M5qlghRM164?=
 =?us-ascii?Q?hWSMdVl2mt96DQKfEEQYm0t1cT2cV00IL3uEZYgbE8kaO4Vx9fmxzaF9v11X?=
 =?us-ascii?Q?C4acdDjZNkpP1jVXGlSGPyQ9DTh8Wgsoo5Jpx0DlW8+6MTPWJO+3ldYzNULN?=
 =?us-ascii?Q?YDONmUWyVc5qwcnlznlnYogdHlFudcv1eAYKi4e4Qi+vQfY1GO2VeJMiCP0g?=
 =?us-ascii?Q?QvoqswQJTA1XQjokaIRKxWHlGdVZSV1xH+j3EQeDz8WAhFZ+H9U2kQimYpF9?=
 =?us-ascii?Q?83rapH/5FFLtDwpP3K4yi4mH0O+4GPHGDf9vOYlvWRBl01GS15ohWQ2W30eT?=
 =?us-ascii?Q?TwiW3WuvKwo7pWr+W46SJSEcG4wlPGvJYEB4YZ8NibK/bL7SiNGKR/oFihAo?=
 =?us-ascii?Q?YhxNSK1VxUQGGz3ubVk02ZXuWY9E9XOraTt0t1V0/8cviuaUS9F42LYzwkdD?=
 =?us-ascii?Q?d+BsoAj1VCray9LKeiwikLJZNXwnBMjuyE8WM0OTMvFj7o6OxkoDoWLljtsk?=
 =?us-ascii?Q?5Md86YbE1A+xx7pW/x4naFsjeLg7yZQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc08656-e43e-4ba3-f1ee-08dedbe9cffb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 05:37:19.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dFn/LDHEWXJM/zraIqSl5cRnmfRo/uZ/A5sFiyyv1MTlw+B6n/Mf9s0SU8hSNZGQlTzx5bl15E09RXGWl8GeVyShRBFfHlQ/MoH4FNssCvxsE2KGW21GOKlqR77G4Wj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7753



On Tue, 30 Jun 2026, Robin Murphy wrote:

> We're soon going to need to cope with events having multiple filters,
> plus the filter fields themselves moving around, wherein any more inline
> if/else logic will struggle to scale. Add a more general abstraction for
> the node-specific filter controls, and rejig the pmu_event_sel filter
> programming around it in a more extensible manner.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm-cmn.c | 139 ++++++++++++++++++++++++++++++-----------
> 1 file changed, 101 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 2a8a67da72c3..14c267d2e2f9 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -278,8 +278,8 @@ enum cmn_node_type {
> };
>
> enum cmn_filter_select {
> -	SEL_NONE = -1,
> -	SEL_OCCUP1ID,
> +	SEL_NONE,
> +	SEL_OCCUP1_ID,
> 	SEL_CLASS_OCCUP_ID,
> 	SEL_CBUSY_SNTHROTTLE_SEL,
> 	SEL_HBT_LBT_SEL,
> @@ -599,6 +599,57 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id)
> static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
> #endif
>
> +enum cmn_filter_type {
> +	FILT_NONE,
> +	FILT_OCCUP1_ID,
> +	FILT_HNF_700,
> +	FILT_HNS,
> +};
> +#define CMN_FILTER(_sel)	[SEL_##_sel] = CMN__PMU_##_sel
> +
> +static const u64 arm_cmn_filters[][SEL_MAX] = {
> +	[FILT_NONE] = {},
> +	/* DVM etc. */
> +	[FILT_OCCUP1_ID] = {
> +		CMN_FILTER(OCCUP1_ID)
> +	},
> +	/* Newer HN-F */
> +	[FILT_HNF_700] = {
> +		CMN_FILTER(OCCUP1_ID),
> +		CMN_FILTER(CLASS_OCCUP_ID),
> +		CMN_FILTER(CBUSY_SNTHROTTLE_SEL)
> +	},
> +	/* HN-S */
> +	[FILT_HNS] = {
> +		CMN_FILTER(OCCUP1_ID),
> +		CMN_FILTER(CLASS_OCCUP_ID),
> +		CMN_FILTER(CBUSY_SNTHROTTLE_SEL),
> +		CMN_FILTER(HBT_LBT_SEL),
> +		CMN_FILTER(SN_HOME_SEL)
> +	},
> +};
> +
> +static enum cmn_filter_type arm_cmn_filter(enum cmn_node_type node,
> +					   enum cmn_model model)
> +{
> +	switch (node) {
> +	default:
> +		return FILT_NONE;
> +	case CMN_TYPE_DVM:
> +	case CMN_TYPE_CXRA:
> +	case CMN_TYPE_CXHA:
> +	case CMN_TYPE_CCRA:
> +	case CMN_TYPE_CCHA:
> +		return FILT_OCCUP1_ID;
> +	case CMN_TYPE_HNF:
> +		if (model < CMN700)
> +			return FILT_OCCUP1_ID;
> +		return FILT_HNF_700;
> +	case CMN_TYPE_HNS:
> +		return FILT_HNS;
> +	};
> +}
> +
> struct arm_cmn_hw_event {
> 	struct arm_cmn_node *dn;
> 	union {
> @@ -708,7 +759,7 @@ static ssize_t arm_cmn_event_show(struct device *dev,
> 				  "type=0x%x,eventid=0x%x,wp_dev_sel=?,wp_chn_sel=?,wp_grp=?,wp_val=?,wp_mask=?\n",
> 				  eattr->type, eattr->eventid);
>
> -	if (eattr->fsel > SEL_NONE)
> +	if (eattr->fsel)
> 		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
> 				  eattr->type, eattr->eventid, eattr->filter);
>
> @@ -832,16 +883,16 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> #define CMN_EVENT_DVM(_model, _name, _event)			\
> 	_CMN_EVENT_DVM(_model, _name, _event, 0, SEL_NONE)
> #define CMN_EVENT_DVM_OCC(_model, _name, _event)			\
> -	_CMN_EVENT_DVM(_model, _name##_all, _event, 0, SEL_OCCUP1ID),	\
> -	_CMN_EVENT_DVM(_model, _name##_dvmop, _event, 1, SEL_OCCUP1ID),	\
> -	_CMN_EVENT_DVM(_model, _name##_dvmsync, _event, 2, SEL_OCCUP1ID)
> +	_CMN_EVENT_DVM(_model, _name##_all, _event, 0, SEL_OCCUP1_ID),	\
> +	_CMN_EVENT_DVM(_model, _name##_dvmop, _event, 1, SEL_OCCUP1_ID),	\
> +	_CMN_EVENT_DVM(_model, _name##_dvmsync, _event, 2, SEL_OCCUP1_ID)
>
> #define CMN_EVENT_HN_OCC(_model, _name, _type, _event)		\
> -	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_OCCUP1ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 1, SEL_OCCUP1ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 2, SEL_OCCUP1ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, 3, SEL_OCCUP1ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, 4, SEL_OCCUP1ID)
> +	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_OCCUP1_ID), \
> +	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 1, SEL_OCCUP1_ID), \
> +	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 2, SEL_OCCUP1_ID), \
> +	_CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, 3, SEL_OCCUP1_ID), \
> +	_CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, 4, SEL_OCCUP1_ID)
> #define CMN_EVENT_HN_CLS(_model, _name, _type, _event)			\
> 	_CMN_EVENT_ATTR(_model, _name##_class0, _type, _event, 0, SEL_CLASS_OCCUP_ID), \
> 	_CMN_EVENT_ATTR(_model, _name##_class1, _type, _event, 1, SEL_CLASS_OCCUP_ID), \
> @@ -865,9 +916,9 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
>
> #define CMN_EVENT_HNS_OCC(_name, _event)				\
> 	CMN_EVENT_HN_OCC(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event),	\
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, 5, SEL_OCCUP1ID), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, 6, SEL_OCCUP1ID), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, 7, SEL_OCCUP1ID)
> +	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, 5, SEL_OCCUP1_ID), \
> +	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, 6, SEL_OCCUP1_ID), \
> +	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, 7, SEL_OCCUP1_ID)
> #define CMN_EVENT_HNS_CLS( _name, _event)				\
> 	CMN_EVENT_HN_CLS(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
> #define CMN_EVENT_HNS_SNT(_name, _event)				\
> @@ -1547,27 +1598,20 @@ static void arm_cmn_event_read(struct perf_event *event)
> }
>
> static int arm_cmn_set_event_sel_hi(struct arm_cmn_node *dn,
> -				    enum cmn_filter_select fsel, u8 filter)
> +				    enum cmn_filter_select fsel, u8 val)
> {
> -	u64 reg;
> -
> -	if (fsel == SEL_NONE)
> -		return 0;
> -
> 	if (!dn->filter[fsel].count) {
> -		dn->filter[fsel].val = filter;
> -		reg = FIELD_PREP(CMN__PMU_CBUSY_SNTHROTTLE_SEL,
> -				 dn->filter[SEL_CBUSY_SNTHROTTLE_SEL].val) |
> -		      FIELD_PREP(CMN__PMU_SN_HOME_SEL,
> -				 dn->filter[SEL_SN_HOME_SEL].val) |
> -		      FIELD_PREP(CMN__PMU_HBT_LBT_SEL,
> -				 dn->filter[SEL_HBT_LBT_SEL].val) |
> -		      FIELD_PREP(CMN__PMU_CLASS_OCCUP_ID,
> -				 dn->filter[SEL_CLASS_OCCUP_ID].val) |
> -		      FIELD_PREP(CMN__PMU_OCCUP1_ID,
> -				 dn->filter[SEL_OCCUP1ID].val);
> +		const u64 *filter = arm_cmn_filters[dn->filter[SEL_NONE].val];
> +		u64 reg = 0;
> +
> +		dn->filter[fsel].val = val;
> +		for (int i = SEL_OCCUP1_ID; i < SEL_MAX; i++) {
> +			if (filter[i])
> +				reg |= field_prep(filter[i], dn->filter[i].val);
> +		}
> +
> 		writel_relaxed(reg >> 32, dn->pmu_base + CMN_PMU_EVENT_SEL + 4);
> -	} else if (dn->filter[fsel].val != filter) {
> +	} else if (dn->filter[fsel].val != val) {
> 		return -EBUSY;
> 	}
> 	dn->filter[fsel].count++;
> @@ -1696,7 +1740,7 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
>
> 		val->dtm_count[dtm]++;
>
> -		if (sel > SEL_NONE)
> +		if (sel)
> 			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
>
> 		if (type != CMN_TYPE_WP)
> @@ -1748,7 +1792,7 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
> 			goto done;
>
> -		if (sel > SEL_NONE && val->filter[dtm][sel] &&
> +		if (sel && val->filter[dtm][sel] &&
> 		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
> 			goto done;
>
> @@ -1894,7 +1938,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
> 			dtm->wp_event[wp_idx] = -1;
> 		}
>
> -		if (hw->filter_sel > SEL_NONE)
> +		if (hw->filter_sel)
> 			hw->dn[i].filter[hw->filter_sel].count--;
>
> 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
> @@ -1906,6 +1950,17 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
> 		cmn->dtc[j].counters[idx] = NULL;
> }
>
> +static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf_event *event)
> +{
> +	enum cmn_filter_select fsel = to_cmn_hw(event)->filter_sel;
> +	int ret = 0;
> +
> +	if (fsel)
> +		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
> +
> +	return ret;
> +}
> +
> static int arm_cmn_event_add(struct perf_event *event, int flags)
> {
> 	struct arm_cmn *cmn = to_cmn(event->pmu);
> @@ -1981,7 +2036,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 			input_sel = CMN__PMEVCNT0_INPUT_SEL_DEV + dtm_idx +
> 				    (nid.port << 4) + (nid.dev << 2);
>
> -			if (arm_cmn_set_event_sel_hi(dn, hw->filter_sel, CMN_EVENT_FILTER(event)))
> +			if (arm_cmn_set_event_filter(dn, event))
> 				goto free_dtms;
> 		}
>
> @@ -2311,6 +2366,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	void __iomem *cfg_region, __iomem *xp_region;
> 	struct arm_cmn_node cfg, *dn;
> 	struct arm_cmn_dtm *dtm;
> +	enum cmn_model model;
> 	enum cmn_part part;
> 	u16 child_count, child_poff;
> 	u64 reg;
> @@ -2342,12 +2398,14 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 			 "Firmware binding mismatch: expected part number 0x%x, found 0x%x\n",
> 			 cmn->part, part);
> 	cmn->part = part;
> -	if (!arm_cmn_model(cmn))
> -		dev_warn(cmn->dev, "Unknown part number: 0x%x\n", part);
>
> 	reg = readl_relaxed(cfg_region + CMN_CFGM_PERIPH_ID_23);
> 	cmn->rev = FIELD_GET(CMN_CFGM_PID2_REVISION, reg);
>
> +	model = arm_cmn_model(cmn);
> +	if (!model)
> +		dev_warn(cmn->dev, "Unknown part number: 0x%x\n", part);
> +
> 	/*
> 	 * With the device isolation feature, if firmware has neglected to enable
> 	 * an XP port then we risk locking up if we try to access anything behind
> @@ -2500,6 +2558,11 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 				dev_err(cmn->dev, "Node ID invalid for supported CMN versions: %d\n", dn->logid);
> 				return -ENODEV;
> 			}
> +			/*
> +			 * We can utilise the "wasted" filter array slot to store
> +			 * the index for referencing the filter encodings later.
> +			 */
> +			dn->filter[SEL_NONE].val = arm_cmn_filter(dn->type, model);
>
> 			switch (dn->type) {
> 			case CMN_TYPE_DTC:
> -- 
> 2.54.0.dirty
>
>
