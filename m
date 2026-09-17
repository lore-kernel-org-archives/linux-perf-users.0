Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022142.outbound.protection.outlook.com [40.107.200.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A22931D5
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609918; cv=fail; b=BQrB/kajGVHTPQO7ZSaEVc32oWFab77BdfaGhU6KXfrvubRjCwqxEdVEbfhFBJLGg5ktcVzcMz6qjw/rwf+nIBWafJM4D+P3ef1vpKnB/tEWdh0PGjq2yEArVaTKc0kwtQPibDvcfW2gUHDsxrJkT0CCs3NniAZsDGnvU0Ws5po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609918; c=relaxed/simple;
	bh=shK+m09wbWqPekZU+43ut9flQaHmWvVM0N+zXatxTEU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=WsEuMAd4LqpnEPzi9OuzuIXtA4ZM/r0b2vKpXYerpUGmh0SVuB/kpCCNJhjOux38yETkmynWhMMeYLjIntS9lnQ1vIydXLQFe6uI/pkIqAr4B4iVxQejKwLF1VaYA9w5cSjCASSZDCam8d2FHyzXBVcU6QWRixB8YKbfmAwcV0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cipouyF0; arc=fail smtp.client-ip=40.107.200.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cipouyF0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g912cKWwwhkulMvTj2PiFrlh1+lMMxOEcaz27dly7HjIMkX/2RNaY8n8WEaw/mooDwE6/wzXgWdIlYpatBfEL77NxSXu+fpmQcRwpnlzMLVvdU60AkAo/hppNtUN8h08Qrjfm3v3ZhIyMWL8R/dutq5B9jM1qArm8ibr2sly3234LqVIir89nQI6ZbSAE7Fc/BW3piXCc0u5q+pzz5Zaz7Po5l0Mj45QJQNj1PLdny6GRXh3Shdudwnn5Kky5U1Boke5mkdjo6nwyxWkAHKmXeaIfisRw/3XCQLmqhBW6/PBOborjgIG7D5tAPMSQU2G86OEsbYClnVg+KJzf8Ppmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui/DZNuFV1lfTC8BArSoe/QZMWoES/IR9f3RK1Wh4NY=;
 b=DzzXBmXmUhYs6426wj2HjRwFW8AlcwfIbFe346Ks1+Z3bHb3zTGm3rGwmu3XsSkH725Zvh9MCp3aKckgMqrdw755yN/IACFZltvsAMnqikK/XlUD1pFwsf+7YRodEerW760zDKpxwhN86on0hCJkE+o0eEkWWz246ENgbINKlKnv6jvnxdHj93ueVYUj4rzF6/7wQaWEtRSnTKRBrUXqOKfBGPtfnNOy+jGUCXeSiG+UarIE112/xnssHy8Py0vv9mKk1v1i0LJ6l/G52ft2MeHkwBfOHiszRsV04on0V9qyA+FPvA9oH6nRvj6k7ocnJn+SWZoYPkTlPP2H8pf3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui/DZNuFV1lfTC8BArSoe/QZMWoES/IR9f3RK1Wh4NY=;
 b=cipouyF0SjK1YdV85ULD9xVQQFQxJJttG1l5WbQJz5BEMLTQa8zzlIlCGkfbuWaJ7CE/yubBS600Hrtty7oOZAVtJpYW1HApEMT/y9e30sPSifWxzlieSVdDuPxNmjnBp/56U3WFG4pZZgVS9DUWfINs3TEs7DwRSIaSoERQRTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 SAWPR01MB994596.prod.exchangelabs.com (2603:10b6:806:4c2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.9; Thu, 17 Sep 2026 01:51:54 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%6]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 01:51:54 +0000
Date: Wed, 16 Sep 2026 18:51:49 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, ilkka@os.amperecomputing.com, 
    leo.yan@arm.com, linux-perf-users@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-cmn: Fix multi-filter encoding
In-Reply-To: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
Message-ID: <614aa3c0-b9b1-815e-f9e3-d1844f4d2587@os.amperecomputing.com>
References: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:303:86::25) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|SAWPR01MB994596:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad0f582-9053-484f-3342-08df145e3f9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q6i5C5eLkkzi37JVjLJIhVYwPaxOMflaDaZ8SkphTdtuVvoBsQvCcOty82ZOQwhDb1dC4UJBfYHtjJZQUhhu2UHZn5h8MjFnyq6ZhsKDRrF961V4bfGy9nb1NpADOrcCLy2Ty5zROAfFIlBGUTiSwb242C0Y/SA2ELUcZApUX36lxsgiM0dZLxurhqrDLs7N6tboNFmW8gbH3mR9gulAHbg+UxVryu4WcjJNzgP4s+3GD1O7xOUcXAbTjWPFTf9UkRggfcmfFunTDR5Wc5j2RCZgTfiaggevuOmncrhzN6mHTvWrbvLd7HCNtmV8uu3JUVWZvf1CmZOizT0fka9jj7F1J1NBZAKhWQsLF2Fx6gq1FPPCSwnxs+B/cL3yMXlw77YNGpvTy8pgXjSxp2wtVhPM55v/qRmQZSD7MF1rOYXcw4Ymd8cEZA3/GsaY+MCy7HsGX7UPOcB4ZXyrbmRVwglDL0FgSoi9DPeeUXv7gsM9xEYd3fjFBmgwYmQZ8WZvj0OKItnyPHFcDkhjfXaYen+Uu7naH6oBiK6qOnZKIDIe2dkWFE0SgHwwT3fJqQPdOHjW0kH9h49lfg5U20ADy6Fm6QfiL2tVTCH4AhfYtREa7Xby0tb5/tQJNsXmGWgl2IWYHI9/irWHPHL0vO0+z9w+hxdtA+wuJEOZqVFjjJs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLYcsmD1OPGtYue2DsBi9SzeRpmnVQ6nCSjj4GMgjwlBfmGLzaTJpcQkEYfw?=
 =?us-ascii?Q?86c8pEq95KAvzNccCPGHclVuZvV3hjwt4T/nB3TGjsOJS1bh7meTwQ3EXLQa?=
 =?us-ascii?Q?PtIpBQfpQU8lewgZbCwfQ5eGb+bfb19NV2+X91IifYz/tqNbKfCttcDjl9S/?=
 =?us-ascii?Q?q/4G6wK+oNmsdpus+ufItxKqOlE+jOqyaal7tkoV6qqeziQ1TcsqzTzCK+Aa?=
 =?us-ascii?Q?uVP3IrYOUia9rjU70DyPVwRQ9w3nl5qEAuJ59jz01QY/iB37VO9/Uv/OIHwU?=
 =?us-ascii?Q?Cr8HxRABGbdH6KEykdwGWUlW3qQu6iwnmFjPmNjGRNshvlMOHXz/PvL54rZM?=
 =?us-ascii?Q?I0z08D4rhnl/zYPySczlPvJjSwE1Qoo3l6TWNcDv/A1JB+7UndOSuXLcdcXr?=
 =?us-ascii?Q?awMP17RbsGe59roHhJdPB1TYn7+amn4cAYjZJnk9RscXNWR9x6NZZZwDOZxD?=
 =?us-ascii?Q?iXBvtAfJYXW/7Y2BlTF6kLxBreSSezrF/3dsX+PKcqxAUpDl6OCdAtfGKSUv?=
 =?us-ascii?Q?nwJyADt3F6QSabiAfWtaLq51f+m2WOzmoJA8DjfmMLzmMrYHwy7qAw947M3y?=
 =?us-ascii?Q?YnB5ntOQdn3/jS6z3DKsey8W1PeYjv5gixDPoQ7f7XE7x9VnW4XEMsZI3Tyu?=
 =?us-ascii?Q?1KsfkKDVgG4mpxiIR/qbpul2hnST/fGl2hcTBbPd9AyAgy3/sw8Kn/2D+tgX?=
 =?us-ascii?Q?6rtXFl1Dg9bvrGMo0GfYJu6Z0z3AUQcANfxQzmSWZ56dPQKJKeHlBsOxCyMp?=
 =?us-ascii?Q?Ps4uWX74UQeQEibb1Gq0JWIAFvG+NYCAP1zTnGiJMNQwiDARmtG7842xQGds?=
 =?us-ascii?Q?EeLOLz50odX5m0cUVFbJchfJHBwqByhNxfq7mzSxUnduv7V0IW6Kp40wkizq?=
 =?us-ascii?Q?GSP88QsPX3o3iAwvJo6IsHOnSVlnOOV4ObUzL0E3Yb6PBkYEsiXUyujDwnQt?=
 =?us-ascii?Q?mDqP+lVCsqUmUXWnGYKSQSdOzGJDr/8apdZydCytRqMAZjsZnxg5TvIlX+tA?=
 =?us-ascii?Q?HNPn0V176GxL/eEqyIYM1HfX1otk2cLuODLMN6sV7tNQvQZrlHpquoMg1Hvs?=
 =?us-ascii?Q?jo9fxwHiOVnwJLttV/TMkMUiVgVn09hB43eF+KPL8LGcvJPPnPxRYlPP2P7u?=
 =?us-ascii?Q?2Y5xImHsd32I4gpZRZGywX47yAvqJxcRveqBP9s1Jew5g/fnYicJl3JxVCo9?=
 =?us-ascii?Q?u6Aslt6wDL9lxgVYVE6Ehi5X1fZ/FsO5wTqxdGLPVUBjoRuVU/G5cI6h4wnq?=
 =?us-ascii?Q?4W25zHraxdhGiwPm4Gx7kut+PW3IqBM3/XBIQpTLmVFzKgvPifQ6OFW0D5sR?=
 =?us-ascii?Q?pnWFGYLW/5dup5TMsbsNT8ACY4S/+0a2S1ccz7bTshJl4GDB9tlFiBqSclLR?=
 =?us-ascii?Q?gjRg7zppqItyaSRlQTYNl3aacEsKAPF2FNL3N+uZX9xtpBG6LZK2VOLr3lvb?=
 =?us-ascii?Q?oqmRepGEH5HU7YJ9538o/dtjfvejO8xBj7JnYP14fl0uZzjX4fuDGngmDwhO?=
 =?us-ascii?Q?2gHCvMNGP0VL8AHmRA/v1uigdQHsXNAZsrSNJEgGazLjSRie2IqzQpG68cAh?=
 =?us-ascii?Q?65hUSidihu/DwljNoeF7ws5l5ALL/hAl9l3zLFR3LJ2dWyPRTE9wAgPLmUcX?=
 =?us-ascii?Q?RDbQK9mb6764L9jHuVy/BfHneeq9LF0zis3krBEi2hWhwy0s55WDVK8fsQnr?=
 =?us-ascii?Q?dw6n1vzPmqTD5XW2Eew8lJH03PDbcarKZpCopSK99u8wXsY7GBpHfZH/p9BI?=
 =?us-ascii?Q?bPpB9yzMwyVWDedKrHMyhSXgZ7gzrgU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad0f582-9053-484f-3342-08df145e3f9c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 01:51:53.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLgxH92JkJxkcVEpIi4WGbnAP4fBPCoE1PhMQx/8u61LOqdu3DC9+pIo+2Ie6f5DqGWhmWF1sM4PvuYx7UPD9JlTLFe7cYuLYhNEgl000WTMJLtc3gG3kIQdUIGzXwM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR01MB994596



On Tue, 15 Sep 2026, Robin Murphy wrote:
> The current special-case for EVICT_STATE_SEL filtering effectively
> assigns the "filter" and "filter2" controls in the opposite order from
> how the CMN S3 r2 TRM states "Filtering is programmed in pmu_hbt_lbt_sel
> and pmu_evict_state_sel". On reflection, not only does this seem
> unnecessarily non-obvious to users, but it's also likely to be a problem
> for scaling to a full multi-filter abstraction in future. There is a
> logical order to filters based on their bitfield positions in the
> pmu_event_sel register, which the TRM descriptions allude to, and the
> cmn_filter_select enum already (almost) follows, so let's fix the UABI
> to follow suit while it's still unreleased.
>
> Fixes: 09178f536bb9 ("perf/arm-cmn: Plumb in new filter types")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Uh, I just realized I replied to v1 although I reviewed v2...
Anyway, this patch looks good to me

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
>
> v2: Also fix filter lookup order and missing return in set_event_filter
>
> drivers/perf/arm-cmn.c | 58 +++++++++++++++++++++++++-----------------
> 1 file changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index b162de3d9d16..33e8a040c903 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -305,9 +305,9 @@ enum cmn_filter_select {
> 	SEL_NONE,
> 	SEL_OCCUP1_ID,
> 	SEL_CLASS_OCCUP_ID,
> -	SEL_CBUSY_SNTHROTTLE_SEL,
> 	SEL_HBT_LBT_SEL,
> 	SEL_SN_HOME_SEL,
> +	SEL_CBUSY_SNTHROTTLE_SEL,
> 	SEL_SNP_VC_SEL,
> 	SEL_ENHANCED_HBT_LBT_SEL,
> 	SEL_EVICT_STATE_SEL,
> @@ -978,10 +978,14 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	_CMN_EVENT_HNS(_model, _name##_all, _event, _sel, 0),		\
> 	_CMN_EVENT_HNS(_model, _name##_hbt, _event, _sel, 1),		\
> 	_CMN_EVENT_HNS(_model, _name##_lbt, _event, _sel, 2)
> -#define _CMN_EVENT_HNS_HBT2(_model, _name, _event, _fsel1, f1)		\
> -	_CMN_EVENT_HNS(_model, _name##_all, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 0), \
> -	_CMN_EVENT_HNS(_model, _name##_hbt, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 1), \
> -	_CMN_EVENT_HNS(_model, _name##_lbt, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 2)
> +#define _CMN_EVENT_HNS_EVICT(_model, _name, _event, _fsel1, f1)			\
> +	_CMN_EVENT_HNS(_model, _name##_all, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 0), \
> +	_CMN_EVENT_HNS(_model, _name##_eu, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 1), \
> +	_CMN_EVENT_HNS(_model, _name##_en, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 2), \
> +	_CMN_EVENT_HNS(_model, _name##_su, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 3), \
> +	_CMN_EVENT_HNS(_model, _name##_sn, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 4), \
> +	_CMN_EVENT_HNS(_model, _name##_mu, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 5), \
> +	_CMN_EVENT_HNS(_model, _name##_mn, _event, _fsel1, f1, SEL_EVICT_STATE_SEL, 6)
>
> #define CMN_EVENT_HNS_OCC(_model, _name, _event)			\
> 	CMN_EVENT_HN_OCC(_model, hns_##_name, CMN_TYPE_HNS, _event),	\
> @@ -1014,13 +1018,9 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_ENHANCED_HBT_LBT_SEL, 5), \
> 	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_ENHANCED_HBT_LBT_SEL, 6)
> #define CMN_EVENT_HNS_EVICT(_model, _name, _event)			\
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_all, _event, SEL_EVICT_STATE_SEL, 0), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_eu, _event, SEL_EVICT_STATE_SEL, 1), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_en, _event, SEL_EVICT_STATE_SEL, 2), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_su, _event, SEL_EVICT_STATE_SEL, 3), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_sn, _event, SEL_EVICT_STATE_SEL, 4), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_mu, _event, SEL_EVICT_STATE_SEL, 5), \
> -	_CMN_EVENT_HNS_HBT2(_model, _name##_mn, _event, SEL_EVICT_STATE_SEL, 6)
> +	_CMN_EVENT_HNS_EVICT(_model, _name##_all, _event, SEL_HBT_LBT_SEL, 0), \
> +	_CMN_EVENT_HNS_EVICT(_model, _name##_hbt, _event, SEL_HBT_LBT_SEL, 1), \
> +	_CMN_EVENT_HNS_EVICT(_model, _name##_lbt, _event, SEL_HBT_LBT_SEL, 2)
>
> #define CMN_EVENT_HNSR0_HBT(_name, _event)				\
> 	_CMN_EVENT_HNS_HBT(CMN700 | CMNS3R01, _name, _event, SEL_HBT_LBT_SEL)
> @@ -1856,10 +1856,12 @@ static void arm_cmn_val_add_event(struct arm_cmn *cmn, struct arm_cmn_val *val,
>
> 		val->dtm_count[dtm]++;
>
> +		if (sel == SEL_EVICT_STATE_SEL) {
> +			val->filter[dtm][sel] = CMN_EVENT_FILTER2(event) + 1;
> +			sel = SEL_HBT_LBT_SEL;
> +		}
> 		if (sel)
> 			val->filter[dtm][sel] = CMN_EVENT_FILTER(event) + 1;
> -		if (sel == SEL_EVICT_STATE_SEL)
> -			val->filter[dtm][SEL_HBT_LBT_SEL] = CMN_EVENT_FILTER2(event) + 1;
>
> 		if (type != CMN_TYPE_WP)
> 			continue;
> @@ -1910,14 +1912,17 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 		if (val->dtm_count[dtm] == CMN_DTM_NUM_COUNTERS)
> 			goto done;
>
> +		if (sel == SEL_EVICT_STATE_SEL) {
> +			if (val->filter[dtm][sel] &&
> +			    val->filter[dtm][sel] != CMN_EVENT_FILTER2(event) + 1)
> +				goto done;
> +			sel = SEL_HBT_LBT_SEL;
> +		}
> +
> 		if (sel && val->filter[dtm][sel] &&
> 		    val->filter[dtm][sel] != CMN_EVENT_FILTER(event) + 1)
> 			goto done;
>
> -		if (sel == SEL_EVICT_STATE_SEL && val->filter[dtm][SEL_HBT_LBT_SEL] &&
> -		    val->filter[dtm][SEL_HBT_LBT_SEL] != CMN_EVENT_FILTER2(event) + 1)
> -			goto done;
> -
> 		if (type != CMN_TYPE_WP)
> 			continue;
>
> @@ -1946,7 +1951,7 @@ static enum cmn_filter_select arm_cmn_event_filter(const struct arm_cmn *cmn,
> 	for (int i = 0; i < ARRAY_SIZE(arm_cmn_event_attrs) - 1; i++) {
> 		e = container_of(arm_cmn_event_attrs[i], typeof(*e), attr.attr);
> 		if (e->model & model && e->type == type && e->eventid == eventid)
> -			return e->filter[0].sel;
> +			return e->filter[1].sel ?: e->filter[0].sel;
> 	}
> 	return SEL_NONE;
> }
> @@ -2077,16 +2082,21 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
> static int arm_cmn_set_event_filter(struct arm_cmn_node *dn, struct perf_event *event)
> {
> 	enum cmn_filter_select fsel = to_cmn_hw(event)->filter_sel;
> +	bool evict_state = fsel == SEL_EVICT_STATE_SEL;
> 	int ret = 0;
>
> +	if (evict_state) {
> +		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER2(event));
> +		if (ret)
> +			return ret;
> +		fsel = SEL_HBT_LBT_SEL;
> +	}
> 	if (fsel)
> 		ret = arm_cmn_set_event_sel_hi(dn, fsel, CMN_EVENT_FILTER(event));
>
> -	if (fsel == SEL_EVICT_STATE_SEL && !ret) {
> -		ret = arm_cmn_set_event_sel_hi(dn, SEL_HBT_LBT_SEL, CMN_EVENT_FILTER2(event));
> -		if (ret)
> -			dn->filter[fsel].count--;
> -	}
> +	if (ret && evict_state)
> +		dn->filter[SEL_EVICT_STATE_SEL].count--;
> +
> 	return ret;
> }
>
> -- 
> 2.54.0.dirty
>
>
