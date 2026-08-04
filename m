Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020112.outbound.protection.outlook.com [52.101.61.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477343FA5F1
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 02:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809924; cv=fail; b=gcUcApn5GethKsiHZCuwb7m7EubxFKpkb9P8VMXpDRdXJltsOTZI6PNarSpOBQnxdqG2tJGVqn8RSqezz4jo0u2qbysOszSq2mPEOrw2reyLQ0yP5PQWvpvo0aU5jH1fE4yqn0jcgTRYViulhgqb6NH9OZ/uSsVZve16Zc7PNtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809924; c=relaxed/simple;
	bh=spT1l2qmjk1GwPU+onyUVfUdpbXoDNKADOK6zesq1d0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=XHY6Idi6Kba0U8iEmZdrCJlWqBYf6QQ8GT55FyBnYqDITiMGQ6GoWpW4jV/WdYEm7pXtBSatObHT+Dz/oeIUI/f+EUNAtgXbt7ysu4hnNuq9OnOA5RxVkE2KkGC0XzWd0MND/gHLZ0QN7dFQZmuFbmbehneckIdM8q+yrjOSxcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=B1XPyomB; arc=fail smtp.client-ip=52.101.61.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="B1XPyomB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTSfw1fXSSbzPvsLJh4DumW2numQ8LAt8F3zYbVB/4r5mtf+Cw0UY0QqzR+D/MltFR7OOc0ssdT+Krun40Ujyag9gfMMpRMcfOgjhtkvOZkrhExSP5RHfWBe5aweunXKGfQtggysptNriQ4VvxGJaMyC6TqooED+Ateo6urFQUD5K9YwNgLCk3PTc8cQIzEbO5V0ITEA8i9bJlvLcinH/oC8XZcs/rpRVnIH7OPxquAmnWEKgYr48u8olfDsodP+fj94O2c8wl7GFqI1LFc38F4+4dY0Y1HDhuHkhAtOPi1oLgcxpk11sy4Y4eQuEWUSB+BMVsn6bkFp+Ps8weWyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5tdGgO3rh3DOEuP9ubO12HY8fLsSjsQffIZJUkeIrI=;
 b=xq7tv05Jh0UnmqVoct1qgRwkcgJA5FqGv9gRX5e/YJQDlPgLI0Mxnnwq86IpkR/De+QoyavFAgLdV3V72o7CRp1kt6Z1nKTOMEHUOfKm97Tchq7XmMKytO/4hp6IEfESvnA9aLlItskC6+vx5z5IRAzsLOJ/g1jHFu5khtD5fXZZpxdngtxfQGkDquIHLFqLKYuFeH4MSmMPG8cckzExuxe0cvPvpKfoHO8np5nBC5uNOyPxIyeBakfECC9/tMAd7Qzlx9xd0D63sg21lkUh0ltEcHgDC/5WumnBlzMedIecfFl7E9SGuNJ6ByeYO+PwoKAmzXfT68CHAET+dD54QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5tdGgO3rh3DOEuP9ubO12HY8fLsSjsQffIZJUkeIrI=;
 b=B1XPyomBI/WvWASnr4Arzq2o457h1X7mqMMcN/I7qynv5WIsZj5KTFWpmOMPGfiBknXN5EjE345ebXm/5M2adwi9WDgQ5arAbWc1zPeB8Etfr8POlRRkA/7uVIbd0MCAOQcUYTG68Iog60aDla539SERJ9dnViVvU+FoBSbwqxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 SJ0PR01MB6351.prod.exchangelabs.com (2603:10b6:a03:2a2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 02:18:39 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%5]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 02:18:39 +0000
Date: Mon, 3 Aug 2026 19:18:35 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com, leo.yan@arm.com
Subject: Re: [PATCH v2 3/5] perf/arm-cmn: Refactor event filter data
In-Reply-To: <2f1dee73fe016249e13fe74d6137a044c900c9e4.1785252273.git.robin.murphy@arm.com>
Message-ID: <a2ceb76d-e234-24b3-9813-1f3bf95f2be2@os.amperecomputing.com>
References: <cover.1785252273.git.robin.murphy@arm.com> <2f1dee73fe016249e13fe74d6137a044c900c9e4.1785252273.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|SJ0PR01MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e8837a-fa1b-4c0c-053d-08def1ceb22f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|3023799007|21046099003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	SojYlQWs8OLVMM/6QD9VsraHQnXYFOgirP/JX8Q4JoiarQS5FGdIeW9KyQWXfdsQpJNq7ynr3130WA0/Z0FWtfWNcE8co2KavDje9nsK1Z3Vo+7c0dQc5zXi87t8p3tfZObIqqv654gVg5Mo1IwONe1uk1P1kCbnSnAWqeRBavZBPhS1osXCkAE3zaqwzdNlNMl5zavN9ejY6E1gcQBAvJPyycRNjNfAOKWs5SHLUggYiDxjpfmi/wW7cgMwdyHvtBxlwQYh5U08eE/0aLaBnDITlR6ZBUrma+Ii/MJA6+pmdEW3FvK8ycW4syDO513yW2I8rcG4L9EDJDjIwNGeSG8F+Hwt8VHXgvGdZnxIsNy+9mOFCUOvUi8kjS2QmruH9fwtiUhoQJ5KoDj4tLSbjA8mIfKJ0OTyrxOsgSVGDvHPXgbfA9m7FyApVvjkyXggTnOLC9W8MCSNakCY4hBiJBYfoj0y34v1VHiz55fVAqIjaDUT74Miz464/zXBNtsLN8/zF5O95bknrElsVVDVHdYqyf/klHTX48YCtsFRM+m23xT0SMkGVy9jfKbzoqbAEQ6GF6cKtDmO7eRVUjTXGeMfYhs0KQE9m0+uxxJVmj3Y3Y2TxOOa8eESnsVp/DsNKbiGKVhW9T9gxfMHK6i1+ynDjwzoRvlk2T24SMpx56Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(21046099003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DUKgwdIBgJC5JYFjXXi0UWHvQ9TQTPKB+C0F/6AdqCsfWYf+AFBEvSMwr/cO?=
 =?us-ascii?Q?U6s2ve3KTWeN5vwTiyKkSE+rmqJZbOZL/6d4jZeZHz/yIBJr5iRSZppc1RaL?=
 =?us-ascii?Q?1kIDpV/E73SE5AzPUdOsLzIJetPfuO2PaMUS097yzXRnasmzB79vouvI33h7?=
 =?us-ascii?Q?fyA1EthDrGccS7szOtolTPhy38lfSg9LQ6i5WKIjx62YoYAye15TJf94swOE?=
 =?us-ascii?Q?BHvw+jKZQfH579MlSRi0ytN/mrGURiBkLXvvS06QW2AtkyXVmEe+AX/0bT1i?=
 =?us-ascii?Q?jIyJgGozC3Jd0pRdW7ySqcJjMJA0SinvxXxKwuvHqIdQkH82eB9CDjZJfpZA?=
 =?us-ascii?Q?LGo9TCpCYom4xDB/vYTw29/2bkW3T/mOU1/H8lt0/8i5WbN49HAuMGJmyPFb?=
 =?us-ascii?Q?P3b1Euazr2EBsJWTb/YqVBl4zvqdHpYUVu/QZuORZFDFFPAQZB0zX6b2F+Vm?=
 =?us-ascii?Q?yTWYA6HZ6oSR+0hisQI0xhpISQB5BVG8F+MUKqGPDuEndQvAq/p77iOk+Su8?=
 =?us-ascii?Q?WIo/BHfVxbXDtC1OWh31cpCzYcQhpjMy7CwvvnMqSAml727zkpnLka81wO0l?=
 =?us-ascii?Q?Aail8tn1artpmLKlBSYs8gm6lkRkC5qy9QaunO7Fzm5pCKeI+Llq0EWszHQ+?=
 =?us-ascii?Q?k4jrsWDdMimD9O5RgwlZfEjmnxGvzaidwgf5yr/JagleEU27fmHwXNGsInNM?=
 =?us-ascii?Q?uIOWhFjinz31QOtufmnxF4eI1En/qMSbi/HG/dshAkyK5M8t55oavnqcNM4A?=
 =?us-ascii?Q?zZL2pBGarGE7CzEd1qpuj0fUrq6i7QgcX9twwB2XuWTs9ujX5Y46HjdqowR9?=
 =?us-ascii?Q?MIF+SmZad5eLHEe4yU6aPJi7dCqMGnH0BzARc2/elK/ct4sNSgZHopUWrXwN?=
 =?us-ascii?Q?xsuVq0iS4JlyRLnd+e5k2eJ04adlqXTDcPjwvh9pJFb/Tt3lSgXCMBFkv6lT?=
 =?us-ascii?Q?TXBhG2PiebzFehchGsKEAH7ndb3lhr1VrIopn8g3d8ageyAGdqAXpapZ8Em+?=
 =?us-ascii?Q?AO0pJ83iiq8L7QYUyZL2zePo+s++MbwA7F5p1l24Zx/v5VLSHohoJlmelO/N?=
 =?us-ascii?Q?hIXQk+HPHAwKY9M+dDworhRB6cQl+UTPVZRj5x2XL+EsopVf74TP0R0S9ZNa?=
 =?us-ascii?Q?g0xBqqS01F6vlY+87Yt18y1cefxWPLWDMJSlxJOg2wrC1XeXx1A/gOYf9Idq?=
 =?us-ascii?Q?rmd1KFlmvleJy8+H7axU22fglTCcREdHdP1mm3ykeoEgzMDcUpj6nOhsWZDD?=
 =?us-ascii?Q?yxKTOofeyHKfj8fEisgKYXLSrxlTP4Tyss+UXhnivzjTOeslDIlMuQ/7Mf4X?=
 =?us-ascii?Q?KghUsJNlRhsuPKKavrrDkewO44MARXySYA6zs/8+OtTFjUcbe6dd3Y3u780+?=
 =?us-ascii?Q?6oNUvmcOPYLhrdXMBqyNB4iH7wMlE/NhE18oHIQYuEwNPhB0OOhFwixRpxTi?=
 =?us-ascii?Q?9A8hVJNDCozX1hn2JY0lpcWITl3DywwzhzVQy7SE8vQyo+ePA3WFj+lezRHm?=
 =?us-ascii?Q?Y3ZORcdk09vZfnMtW6wofFYrXWWkTAA/MW1NmKBcEn5G0mhsR/PTABjzEVqk?=
 =?us-ascii?Q?2R7KNa28Ivb3gZFpElPf+sEX2HZa/ka/uCjoFxzBTkvDBbGWCeVNApJ3dr5z?=
 =?us-ascii?Q?+sDIpIq79EW60dnlpMt+wvcH8xP4eSXgymK4BJfPzU6lFKYRcU9UN1WFurSb?=
 =?us-ascii?Q?5fSmXe/xMpUSwIUUJGNdZO8+sw8VmnaoqjLCZbJ911ywTz0bDahIQSMd/B8q?=
 =?us-ascii?Q?px0Fp4oPk/5Nq0RWhW+j9rZXmKUm3fY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e8837a-fa1b-4c0c-053d-08def1ceb22f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:18:39.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3KWoEfNqSNYfvtBDgHAZ/jTnx2I+g0d8VoKbAXRtU6ZiAkvQAhSaLPVUXnLjM9n+frdxdHz0kHFL5hT5r/GwIGalpCCfKF8vJgSssN8OdhGNxoZs1/LBrlO3x2wmlk6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6351



On Tue, 28 Jul 2026, Robin Murphy wrote:

> The ABI hole I have dug myself into requires the driver to know which
> event encodings are associated with which particular filter control.
> Since we will soon have a notion of multiple filters per event, refactor
> the event data to encapsulate filters in an explicit structure, which
> can then more easily scale as an array in future.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

LGTM:
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
>
> v2: Avoid transient bug with filter.val in _CMN_EVENT_ATTR()
>
> drivers/perf/arm-cmn.c | 95 ++++++++++++++++++++++--------------------
> 1 file changed, 49 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 14c267d2e2f9..74bc2aae4a06 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -717,13 +717,17 @@ static void arm_cmn_clear_idx(struct arm_cmn_hw_event *hw)
> 		bitmap_zero(hw->wp_idx, CMN_MAX_XPS);
> }
>
> +struct arm_cmn_filter_attr {
> +	enum cmn_filter_select sel;
> +	u8 val;
> +};
> +
> struct arm_cmn_event_attr {
> 	struct device_attribute attr;
> 	enum cmn_model model;
> 	enum cmn_node_type type;
> -	enum cmn_filter_select fsel;
> 	u16 eventid;
> -	u8 filter;
> +	struct arm_cmn_filter_attr filter[1];
> };
>
> struct arm_cmn_format_attr {
> @@ -732,24 +736,25 @@ struct arm_cmn_format_attr {
> 	int config;
> };
>
> -#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter, _fsel)\
> +#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _fa, _fb, ...)	\
> 	(&((struct arm_cmn_event_attr[]) {{				\
> 		.attr = __ATTR(_name, 0444, arm_cmn_event_show, NULL),	\
> 		.model = _model,					\
> 		.type = _type,						\
> 		.eventid = _eventid,					\
> -		.filter = _filter,					\
> -		.fsel = _fsel,						\
> +		.filter = {{_fa, _fb}},					\
> 	}})[0].attr.attr)
> -#define CMN_EVENT_ATTR(_model, _name, _type, _eventid)			\
> -	_CMN_EVENT_ATTR(_model, _name, _type, _eventid, 0, SEL_NONE)
> +#define CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter...)	\
> +	_CMN_EVENT_ATTR(_model, _name, _type, _eventid, ##_filter, 0, 0)
>
> static ssize_t arm_cmn_event_show(struct device *dev,
> 				  struct device_attribute *attr, char *buf)
> {
> 	struct arm_cmn_event_attr *eattr;
> +	struct arm_cmn_filter_attr *filter;
>
> 	eattr = container_of(attr, typeof(*eattr), attr);
> +	filter = eattr->filter;
>
> 	if (eattr->type == CMN_TYPE_DTC)
> 		return sysfs_emit(buf, "type=0x%x\n", eattr->type);
> @@ -759,9 +764,9 @@ static ssize_t arm_cmn_event_show(struct device *dev,
> 				  "type=0x%x,eventid=0x%x,wp_dev_sel=?,wp_chn_sel=?,wp_grp=?,wp_val=?,wp_mask=?\n",
> 				  eattr->type, eattr->eventid);
>
> -	if (eattr->fsel)
> +	if (filter[0].sel)
> 		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
> -				  eattr->type, eattr->eventid, eattr->filter);
> +				  eattr->type, eattr->eventid, filter[0].val);
>
> 	return sysfs_emit(buf, "type=0x%x,eventid=0x%x\n", eattr->type,
> 			  eattr->eventid);
> @@ -849,8 +854,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	return attr->mode;
> }
>
> -#define _CMN_EVENT_DVM(_model, _name, _event, _occup, _fsel)	\
> -	_CMN_EVENT_ATTR(_model, dn_##_name, CMN_TYPE_DVM, _event, _occup, _fsel)
> +#define CMN_EVENT_DVM(_model, _name, _event, _filter...)	\
> +	CMN_EVENT_ATTR(_model, dn_##_name, CMN_TYPE_DVM, _event, ##_filter)
> #define CMN_EVENT_DTC(_name)					\
> 	CMN_EVENT_ATTR(CMN_ANY, dtc_##_name, CMN_TYPE_DTC, 0)
> #define CMN_EVENT_HNF(_model, _name, _event)			\
> @@ -880,32 +885,30 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> #define CMN_EVENT_HNS(_name, _event)				\
> 	CMN_EVENT_ATTR(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
>
> -#define CMN_EVENT_DVM(_model, _name, _event)			\
> -	_CMN_EVENT_DVM(_model, _name, _event, 0, SEL_NONE)
> #define CMN_EVENT_DVM_OCC(_model, _name, _event)			\
> -	_CMN_EVENT_DVM(_model, _name##_all, _event, 0, SEL_OCCUP1_ID),	\
> -	_CMN_EVENT_DVM(_model, _name##_dvmop, _event, 1, SEL_OCCUP1_ID),	\
> -	_CMN_EVENT_DVM(_model, _name##_dvmsync, _event, 2, SEL_OCCUP1_ID)
> +	CMN_EVENT_DVM(_model, _name##_all, _event, SEL_OCCUP1_ID, 0),	\
> +	CMN_EVENT_DVM(_model, _name##_dvmop, _event, SEL_OCCUP1_ID, 1),	\
> +	CMN_EVENT_DVM(_model, _name##_dvmsync, _event, SEL_OCCUP1_ID, 2)
>
> #define CMN_EVENT_HN_OCC(_model, _name, _type, _event)		\
> -	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_OCCUP1_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 1, SEL_OCCUP1_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 2, SEL_OCCUP1_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, 3, SEL_OCCUP1_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, 4, SEL_OCCUP1_ID)
> +	CMN_EVENT_ATTR(_model, _name##_all, _type, _event, SEL_OCCUP1_ID, 0), \
> +	CMN_EVENT_ATTR(_model, _name##_read, _type, _event, SEL_OCCUP1_ID, 1), \
> +	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_OCCUP1_ID, 2), \
> +	CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, SEL_OCCUP1_ID, 3), \
> +	CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, SEL_OCCUP1_ID, 4)
> #define CMN_EVENT_HN_CLS(_model, _name, _type, _event)			\
> -	_CMN_EVENT_ATTR(_model, _name##_class0, _type, _event, 0, SEL_CLASS_OCCUP_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_class1, _type, _event, 1, SEL_CLASS_OCCUP_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_class2, _type, _event, 2, SEL_CLASS_OCCUP_ID), \
> -	_CMN_EVENT_ATTR(_model, _name##_class3, _type, _event, 3, SEL_CLASS_OCCUP_ID)
> +	CMN_EVENT_ATTR(_model, _name##_class0, _type, _event, SEL_CLASS_OCCUP_ID, 0), \
> +	CMN_EVENT_ATTR(_model, _name##_class1, _type, _event, SEL_CLASS_OCCUP_ID, 1), \
> +	CMN_EVENT_ATTR(_model, _name##_class2, _type, _event, SEL_CLASS_OCCUP_ID, 2), \
> +	CMN_EVENT_ATTR(_model, _name##_class3, _type, _event, SEL_CLASS_OCCUP_ID, 3)
> #define CMN_EVENT_HN_SNT(_model, _name, _type, _event)			\
> -	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_CBUSY_SNTHROTTLE_SEL), \
> -	_CMN_EVENT_ATTR(_model, _name##_group0_read, _type, _event, 1, SEL_CBUSY_SNTHROTTLE_SEL), \
> -	_CMN_EVENT_ATTR(_model, _name##_group0_write, _type, _event, 2, SEL_CBUSY_SNTHROTTLE_SEL), \
> -	_CMN_EVENT_ATTR(_model, _name##_group1_read, _type, _event, 3, SEL_CBUSY_SNTHROTTLE_SEL), \
> -	_CMN_EVENT_ATTR(_model, _name##_group1_write, _type, _event, 4, SEL_CBUSY_SNTHROTTLE_SEL), \
> -	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 5, SEL_CBUSY_SNTHROTTLE_SEL), \
> -	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 6, SEL_CBUSY_SNTHROTTLE_SEL)
> +	CMN_EVENT_ATTR(_model, _name##_all, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 0), \
> +	CMN_EVENT_ATTR(_model, _name##_group0_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 1), \
> +	CMN_EVENT_ATTR(_model, _name##_group0_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 2), \
> +	CMN_EVENT_ATTR(_model, _name##_group1_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 3), \
> +	CMN_EVENT_ATTR(_model, _name##_group1_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 4), \
> +	CMN_EVENT_ATTR(_model, _name##_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 5), \
> +	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6)
>
> #define CMN_EVENT_HNF_OCC(_model, _name, _event)			\
> 	CMN_EVENT_HN_OCC(_model, hnf_##_name, CMN_TYPE_HNF, _event)
> @@ -916,21 +919,21 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
>
> #define CMN_EVENT_HNS_OCC(_name, _event)				\
> 	CMN_EVENT_HN_OCC(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event),	\
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, 5, SEL_OCCUP1_ID), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, 6, SEL_OCCUP1_ID), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, 7, SEL_OCCUP1_ID)
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, SEL_OCCUP1_ID, 5), \
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, SEL_OCCUP1_ID, 6), \
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, SEL_OCCUP1_ID, 7)
> #define CMN_EVENT_HNS_CLS( _name, _event)				\
> 	CMN_EVENT_HN_CLS(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
> #define CMN_EVENT_HNS_SNT(_name, _event)				\
> 	CMN_EVENT_HN_SNT(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
> #define CMN_EVENT_HNS_HBT(_name, _event)				\
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_all, CMN_TYPE_HNS, _event, 0, SEL_HBT_LBT_SEL), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, 1, SEL_HBT_LBT_SEL), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, 2, SEL_HBT_LBT_SEL)
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_all, CMN_TYPE_HNS, _event, SEL_HBT_LBT_SEL, 0), \
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, SEL_HBT_LBT_SEL, 1), \
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, SEL_HBT_LBT_SEL, 2)
> #define CMN_EVENT_HNS_SNH(_name, _event)				\
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_all, CMN_TYPE_HNS, _event, 0, SEL_SN_HOME_SEL), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_sn, CMN_TYPE_HNS, _event, 1, SEL_SN_HOME_SEL), \
> -	_CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_home, CMN_TYPE_HNS, _event, 2, SEL_SN_HOME_SEL)
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_all, CMN_TYPE_HNS, _event, SEL_SN_HOME_SEL, 0), \
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_sn, CMN_TYPE_HNS, _event, SEL_SN_HOME_SEL, 1), \
> +	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_home, CMN_TYPE_HNS, _event, SEL_SN_HOME_SEL, 2)
>
> #define _CMN_EVENT_XP_MESH(_name, _event)			\
> 	__CMN_EVENT_XP(e_##_name, (_event) | (0 << 2)),		\
> @@ -1814,9 +1817,9 @@ static int arm_cmn_validate_group(struct arm_cmn *cmn, struct perf_event *event)
> 	return ret;
> }
>
> -static enum cmn_filter_select arm_cmn_filter_sel(const struct arm_cmn *cmn,
> -						 enum cmn_node_type type,
> -						 unsigned int eventid)
> +static enum cmn_filter_select arm_cmn_event_filter(const struct arm_cmn *cmn,
> +						   enum cmn_node_type type,
> +						   unsigned int eventid)
> {
> 	struct arm_cmn_event_attr *e;
> 	enum cmn_model model = arm_cmn_model(cmn);
> @@ -1824,7 +1827,7 @@ static enum cmn_filter_select arm_cmn_filter_sel(const struct arm_cmn *cmn,
> 	for (int i = 0; i < ARRAY_SIZE(arm_cmn_event_attrs) - 1; i++) {
> 		e = container_of(arm_cmn_event_attrs[i], typeof(*e), attr.attr);
> 		if (e->model & model && e->type == type && e->eventid == eventid)
> -			return e->fsel;
> +			return e->filter[0].sel;
> 	}
> 	return SEL_NONE;
> }
> @@ -1889,7 +1892,7 @@ static int arm_cmn_event_init(struct perf_event *event)
> 	}
>
> 	/* This is sufficiently annoying to recalculate, so cache it */
> -	hw->filter_sel = arm_cmn_filter_sel(cmn, type, eventid);
> +	hw->filter_sel = arm_cmn_event_filter(cmn, type, eventid);
>
> 	bynodeid = CMN_EVENT_BYNODEID(event);
> 	nodeid = CMN_EVENT_NODEID(event);
> -- 
> 2.54.0.dirty
>
>
