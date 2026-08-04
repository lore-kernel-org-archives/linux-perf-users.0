Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020118.outbound.protection.outlook.com [52.101.46.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28B35966
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Aug 2026 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810840; cv=fail; b=YUlSHCO2xhNuHmuAKJp5/btePOwegn71hAq8JANHkidn9EOz6mMJrI6A7cPZmNUVntXyjZN8h3q0pbU1BISoCHWtteJXjp2MOJ3dCKZUlbaGKCHU44zd9SioQBwPTL2U6VxlPiPYtNOJYFto/BlnzBzMrFaZ/7APeB9/1F8XzDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810840; c=relaxed/simple;
	bh=mQVyDbnkgzm1DPYKajm4DmJ7n78Qobfs1okd81LwstQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=VjxD/rP7l1ja0w3cdPr8L9xWCnXdPtBXyw7dNevKHagY3sBh1JW6ivauOZ6hZgikG5/WckrUATiuXDfOP2986DmLV7SWDOW8NdrxZU/pGUrnRnLk9Vr0iPnu/pjAL6ldsH/qkw0wzZtGgaNIRf7btVgUWejfrM17whT1y692unE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Gp2ta5JA; arc=fail smtp.client-ip=52.101.46.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Gp2ta5JA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zkd9pwbc24ONwRBThgEZRoAlg2rrCFgdanrJaZhG1pynAcchnYuJnmLZ3ZqptgP04GwfS42Or671DiDK2QWNDzUFXA9TRKEgChX+TyOhNMfNSs2wstvn4bhKP3Le7iav94v9TqF6CdaFiyJtOU0Lk1pkjG6AfEPEJA4M4uy84ceIwM5QUpphGj+YsbPeboW4JmbtAkNu98lISZZzwXjwDrh/u1JMg+oBlQe5jslNvf45iyZkWMKfr6pu5Rt2dNqpg3LR8BZSIYxnj8IfTAR05vn4w2e8NpL2exEG2OQgwn0maRTiL+HW7p2RyUGSBCOVrTTa0x1FK+CctKM3P8udmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNp6cNF9oxraVTZYTA+hhU2p542xZ/tkaqN3TbGucuk=;
 b=Zh5YAfQFdUkcvjWkhgyWFJ7vRCcuq2LfZVmpXV3Pw7N05Zjx/qb+EYOUbNy7MN4lleGCiiTBjTxnsABcWNvYw92bRwY1HWVSUjWNrzRYds8bL9HFZwC9KlEvxKQk+C/2/8KDIPWs0XU0fE5dSn8txatv7/z9bImBPeWtDmr+fyA+6aDo3J388cGhB555w3Aynp2KqpRBXqPA1NXHKpQrJVWIvdNwgdEFMVKXM88EHEdGTHx/uqhz+cd1s1H5YJyutCvOj89uRHqktZFWZ4fqHKURmKQeSUHKAOWGaN5RLWibB6xh+DoLmSFSvxnurCwELsk7XYXvrPPRXw+cnnCLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNp6cNF9oxraVTZYTA+hhU2p542xZ/tkaqN3TbGucuk=;
 b=Gp2ta5JAw6LN9W/ZZZOYJa0es8so+PAgWa94YGugu8K+t+sw6CP8df/uSewzvBMUiB2PpS81cBmbuq236uxPWWBQ7vadoPK1F+/8AQl+PzNyTiUwoo1YaLQE6m5Z9apCjR9vq9TxdD24PBQGE8nG6kVzsIsOYA2P+mx9V4qiYT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 BL3PR01MB7058.prod.exchangelabs.com (2603:10b6:208:35d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 02:33:54 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%5]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 02:33:54 +0000
Date: Mon, 3 Aug 2026 19:33:50 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    ilkka@os.amperecomputing.com, leo.yan@arm.com
Subject: Re: [PATCH v2 5/5] perf/arm-cmn: Support CMN S3 r2
In-Reply-To: <86b7093bc5de0f2aedc63fc4826ce911cb22d16f.1785252273.git.robin.murphy@arm.com>
Message-ID: <f85da4a6-bec8-af41-d63a-d894d057a344@os.amperecomputing.com>
References: <cover.1785252273.git.robin.murphy@arm.com> <86b7093bc5de0f2aedc63fc4826ce911cb22d16f.1785252273.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|BL3PR01MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: ce06087c-1367-4be1-47a1-08def1d0d39b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|6133799003|21046099003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TC4WNmz8EJ+oajrmRauBYXIMlxpT1zDRNX0K7WPLiCvGovZhUfCH9yRNVv1mQJrUQwvFaInQmKq+wSmy/LUrQkzBlgz9DPgkazLvmcO6xD+XMaGkXVgXiOvPPdCftdaghxEGulUoXF13JrmJUZgm51d/BDR8bm0E0FwR7Znc2TdDcTv/+F+G9ni3WDzxSra1J6XYZHRwQN/Ie8WMO/uMpJn+FO1+ayLjWJlYVTcFtuq1WMxIScX8WQA0r5ELLpLtYm6rlrl1wWO9/VZQfnJmlIdY3fAx2GMv4ek+XYfmSaFkQONDmYTMXwKt1REsUBVvjsN1hxRXg7QvIKtwIlo6487Z8WXsslYoipH/IEMFwtQpaGm9AptUiMmkdkSEdkFs6322okjTtdH3Iop6h4nKOOszBSJBAlMGe91TgBjpT5I1IiLpTQ5LsZ6A+ug09V7NnVtEBTfLpl1Y5RWEbD/VTErCnvr5l7v/LVfy+6J52A0JSE4fwvLpZHWAmDTunIdHMileNr6QkUOwo7kDdF9n7RP/SMf4UGblo+NRDpEUj2nw4y0x17cEZKeRtC+By2hP7wbT/MpZrlBpbke2VVLSYJCre6QjeDo7raWoYrWfQOxcatmurSNBxiSQYrePQ92EJU3jaQccanq0c73DO/fT+hoSuV/4lE3V0dcRpPDgh/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(21046099003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sbyIYNwUY7G3kWV0EwElbm1kA42QIqBllEOHEz74SU7VOQeQEg07iPDBjROc?=
 =?us-ascii?Q?mod6iEpJw7xLoBUDmLk0Rv/cwGvZhSXj17hZPp9KyteeRODqNxsi2tDr4fEo?=
 =?us-ascii?Q?4IgCXQl2lSgYha9KYZXGWyF22EyZcCxS88jmS1OBIduoCw28GJ/83rtWSsBu?=
 =?us-ascii?Q?SacsuEDeRmdj54rqeMCmzk9z56fedTyuOybBWW5imkTNb1mTQRPj4cwfKuyF?=
 =?us-ascii?Q?uwv3jzVSYEusKcw+VuQZO2VJGMIfLrLlmkxnWEUrc8x5SRxXu0z8K6dzqHTT?=
 =?us-ascii?Q?M+Fj8ji5HvtuMo4JjDwdy3eaQTutcWD02c2ogHgFIDGnOOTBenfEVTblV4Rd?=
 =?us-ascii?Q?CdiKFbJVqxO+MAfktp9ARYfhy6EX7thioPY4K3kWSOn8BB/m4h7Hr+GMYMZX?=
 =?us-ascii?Q?0YZD7L5jOUdLvMj/1RLLkD7wPXTZiTFU42XRSfxtTiEnRdvYBliL/6DB2JRz?=
 =?us-ascii?Q?TkbspjtyalL5ZN7APLHqseGjSWi0x8qbvKILXYseu0NUWuRkg5XBL6k1Hqy7?=
 =?us-ascii?Q?pVpSTPByLh+oHwG9p8J/xzeOQqAI/Ev06l7hhxakNigzSqoeZOXQhu6LZXh6?=
 =?us-ascii?Q?mwwsHk2wqK9sAud6waVTQM9NVZC20hXcTqfmIxfZijirXGeJM6jdvs7wE1v+?=
 =?us-ascii?Q?1AbOFv2TcxjfhpLR284fx2wiP0Sc3DxlrY0l3oN5t44PV36PGYw+B1dgtvbx?=
 =?us-ascii?Q?Lo06bBLA/vUjZ73TEKr+4nnfcZ6lkBCzgblRi/XQng/66OtUBZQHS55ztUw6?=
 =?us-ascii?Q?C77zN/Y7jEay2SGxxktHhthBtIFSDGDykDtSK2pdvQb3Wv1t7lmqaQ2T2xdR?=
 =?us-ascii?Q?f/yNDj14rkXxSIdjF42uu435jt1O5uTgYzoG+iVGNzmVUQwJlMl7rOqgw9Xn?=
 =?us-ascii?Q?savWWquHboh86+8OsWQwKn0WmbgkpNGodwfD4wQyvtmJJs9DlEpZ7f75TmCe?=
 =?us-ascii?Q?O513s2B2RxmMxYgnshwnbtTJ5ls0Mq45Myc7H900CJJMgRAEyCBoAMz8cNro?=
 =?us-ascii?Q?D/JbjsRzMh5/AlLzRZBHfi4f8jDQHtvhRKoVdfg7nUVTHtNuG8KEDjUlU8rc?=
 =?us-ascii?Q?zt5/n43FGUYIur+cUpmndAE/z5haR7e7MdIJw7Vp+4VSYMwS2dacY8aSgh1P?=
 =?us-ascii?Q?c9g07FQEdyWLox0FkHdrFOMpCq58+X8ComItXlIfW69tTsGWP3Trs7qB88Tt?=
 =?us-ascii?Q?nD4D7E9ABBou5+gi8pqD3llDftD7UCjwYRa1+AjRdomgxr7ipPb6OFVwiJtg?=
 =?us-ascii?Q?Zd4MDeh2KEUkLHfebGlrvCWUTHvghZ4iIQFXpbjW9YMdhba2yAtsuAoYjZ5k?=
 =?us-ascii?Q?0v5nz+k5/WXLiFwO01y8V2VQfEEUezVcg8Aq+/Y1Y3vgGLnA3wdzcaMK6Hn/?=
 =?us-ascii?Q?LBtnKyCD8gFFQxsJEgQ+DQVLjc4pgx3SWVx9WZ1VzKRPDgjuSQRhUPAKVpxG?=
 =?us-ascii?Q?j1E+4BqNEKQOLit4ZkT0ecc7NcgT/Ax+FsxpwSYfGsfanq92tAsxIrbHezMY?=
 =?us-ascii?Q?WaYWkLZu4kzHVD6UWNdWr71FOy8HYc1Vlja4oCVRDZGkR1irX/MVHcjIQj9a?=
 =?us-ascii?Q?cE3e2b0nGztPKXuZrWJ166WPuPgEbKuPj3P5nvcSY59PiAXJ8NBvTboR1xHK?=
 =?us-ascii?Q?7flmJXPeq29rkv6QDx9ovOhrW8/4TuggKe757S4F0raaCz6SndWJjQsKdAot?=
 =?us-ascii?Q?OaPlmHmN/228WYqXaBAw/akOt5/HVOR256qWVz2WUTDy13IGsqiQyqMvjuRE?=
 =?us-ascii?Q?wbshc2H+BDLuwIiaTeGvebA6rK+mGS8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce06087c-1367-4be1-47a1-08def1d0d39b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 02:33:53.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQsjMCkoEmvIcZ7tWaw/4ee/zoYPoCRuWbsdXwr36H+LOrWfYFS0VH9if1G0yzoJ6/XtFKOWiJJve61hoATDufUzowLyDIbBqkf8j2EjPiat/an1JjjXWO0brK7rXOEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7058



On Tue, 28 Jul 2026, Robin Murphy wrote:

> If you were disappointed at how minimal the initial CMN S3 support
> looked compared to previous versions, then oh boy is it time to put your
> party hats on... The biggest batch of incompatible changes yet comes not
> with a new CMN product, but a point release of an existing one. We've
> got new filters, loads of changes to existing events, register fields
> moved around for no good reason, and much, much more! On the upside, we
> do at least gain a means of working around the isolation feature.

That's just great...

>
> As such, for the sake of sanity in the driver it is easiest to split it
> into a distict "model" for our internal abstractions despite it bearing
> the same part number as r0/r1.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

The patch looks good to me:

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka


> ---
>
> v2: No change
>
> drivers/perf/arm-cmn.c | 270 +++++++++++++++++++++++++++++------------
> 1 file changed, 193 insertions(+), 77 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index e25f46c38c23..a03e2a8ca41e 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -29,6 +29,7 @@
> #define CMN_CI_CHILD_PTR_OFFSET		GENMASK_ULL(31, 16)
>
> #define CMN_CHILD_NODE_ADDR		GENMASK(29, 0)
> +#define CMN_CHILD_NODE_ISOLATED		BIT(30)
> #define CMN_CHILD_NODE_EXTERNAL		BIT(31)
>
> /* Some implementations use a mesh larger than the architectural max of 12 */
> @@ -48,11 +49,16 @@
>
> #define CMN_CFGM_INFO_GLOBAL		0x0900
> #define CMN_INFO_MULTIPLE_DTM_EN	BIT_ULL(63)
> +#define CMN_S3_R2_MULTIPLE_DTM_EN	BIT_ULL(59)
> #define CMN_INFO_RSP_VC_NUM		GENMASK_ULL(53, 52)
> #define CMN_INFO_DAT_VC_NUM		GENMASK_ULL(51, 50)
> #define CMN_INFO_DEVICE_ISO_ENABLE	BIT_ULL(44)
>
> #define CMN_CFGM_INFO_GLOBAL_1		0x0908
> +#define CMN_S3_R2_RSP_VC_NUM		GENMASK_ULL(11, 9)
> +#define CMN_S3_R2_DAT_VC_NUM		GENMASK_ULL(8, 6)
> +#define CMN_S3_R2_SNP_VC_NUM		GENMASK_ULL(5, 3)
> +#define CMN_S3_R2_REQ_VC_NUM		GENMASK_ULL(2, 0)
> #define CMN_INFO_SNP_VC_NUM		GENMASK_ULL(3, 2)
> #define CMN_INFO_REQ_VC_NUM		GENMASK_ULL(1, 0)
>
> @@ -78,6 +84,16 @@
> /* Technically this is 4 bits wide on DNs, but we only use 2 there anyway */
> #define CMN__PMU_OCCUP1_ID		GENMASK_ULL(34, 32)
>
> +/* But then... */
> +#define CMN__PMU_EVICT_STATE_SEL	GENMASK_ULL(54, 52)
> +#define CMN__PMU_ENHANCED_HBT_LBT_SEL	GENMASK_ULL(51, 48)
> +#define CMN__PMU_SNP_VC_SEL		GENMASK_ULL(47, 46)
> +#define CMN__S3_R2_CBUSY_SNTHROTTLE_SEL	GENMASK_ULL(45, 42)
> +#define CMN__S3_R2_SN_HOME_SEL		GENMASK_ULL(41, 40)
> +#define CMN__S3_R2_HBT_LBT_SEL		GENMASK_ULL(39, 38)
> +#define CMN__S3_R2_CLASS_OCCUP_ID	GENMASK_ULL(37, 36)
> +#define CMN__S3_R2_OCCUP1_ID		GENMASK_ULL(35, 32)
> +
> /* Some types are designed to coexist with another device in the same node */
> #define CMN_CCLA_PMU_EVENT_SEL		0x008
> #define CMN_HNP_PMU_EVENT_SEL		0x008
> @@ -202,12 +218,14 @@ enum cmn_model {
> 	CMN650 = 2,
> 	CI700 = 4,
> 	CMN700 = 8,
> -	CMNS3 = 16,
> +	CMNS3R01 = 16,
> +	CMNS3R2 = 32,
> 	/* ...and then we can use bitmap tricks for commonality */
> 	CMN_ANY = -1,
> 	NOT_CMN600 = -2,
> 	CMN_700ON = ~(CMN700 - 1),
> 	CMN_650ON = CMN_700ON | CMN650,
> +	CMNS3 = CMNS3R01 | CMNS3R2,
> };
>
> /* Actual part numbers and revision IDs defined by the hardware */
> @@ -243,6 +261,10 @@ enum cmn_revision {
> 	REV_CMNS3_R0P0 = 0,
> 	REV_CMNS3_R0P1,
> 	REV_CMNS3_R1P0,
> +	REV_CMNS3_R2P0,
> +	REV_CMNS3_R2P1,
> +	REV_CMNS3_R2P2,
> +	REV_CMNS3_R2P5,
> 	REV_CI700_R0P0 = 0,
> 	REV_CI700_R1P0,
> 	REV_CI700_R2P0,
> @@ -429,7 +451,9 @@ static enum cmn_model arm_cmn_model(const struct arm_cmn *cmn)
> 	case PART_CI700:
> 		return CI700;
> 	case PART_CMN_S3:
> -		return CMNS3;
> +		if (cmn->rev >= REV_CMNS3_R2P0)
> +			return CMNS3R2;
> +		return CMNS3R01;
> 	default:
> 		return 0;
> 	};
> @@ -609,8 +633,10 @@ enum cmn_filter_type {
> 	FILT_OCCUP1_ID,
> 	FILT_HNF_700,
> 	FILT_HNS,
> +	FILT_HNS_S3R2,
> };
> #define CMN_FILTER(_sel)	[SEL_##_sel] = CMN__PMU_##_sel
> +#define CMN_FILTER_V2(_sel)	[SEL_##_sel] = CMN__S3_R2_##_sel
>
> static const u64 arm_cmn_filters[][SEL_MAX] = {
> 	[FILT_NONE] = {},
> @@ -632,6 +658,17 @@ static const u64 arm_cmn_filters[][SEL_MAX] = {
> 		CMN_FILTER(HBT_LBT_SEL),
> 		CMN_FILTER(SN_HOME_SEL)
> 	},
> +	/* Newer HN-S */
> +	[FILT_HNS_S3R2] = {
> +		CMN_FILTER_V2(OCCUP1_ID),
> +		CMN_FILTER_V2(CLASS_OCCUP_ID),
> +		CMN_FILTER_V2(CBUSY_SNTHROTTLE_SEL),
> +		CMN_FILTER_V2(HBT_LBT_SEL),
> +		CMN_FILTER_V2(SN_HOME_SEL),
> +		CMN_FILTER(SNP_VC_SEL),
> +		CMN_FILTER(ENHANCED_HBT_LBT_SEL),
> +		CMN_FILTER(EVICT_STATE_SEL)
> +	}
> };
>
> static enum cmn_filter_type arm_cmn_filter(enum cmn_node_type node,
> @@ -651,7 +688,9 @@ static enum cmn_filter_type arm_cmn_filter(enum cmn_node_type node,
> 			return FILT_OCCUP1_ID;
> 		return FILT_HNF_700;
> 	case CMN_TYPE_HNS:
> -		return FILT_HNS;
> +		if (model < CMNS3R2)
> +			return FILT_HNS;
> +		return FILT_HNS_S3R2;
> 	};
> }
>
> @@ -732,7 +771,7 @@ struct arm_cmn_event_attr {
> 	enum cmn_model model;
> 	enum cmn_node_type type;
> 	u16 eventid;
> -	struct arm_cmn_filter_attr filter[1];
> +	struct arm_cmn_filter_attr filter[2];
> };
>
> struct arm_cmn_format_attr {
> @@ -741,16 +780,16 @@ struct arm_cmn_format_attr {
> 	int config;
> };
>
> -#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _fa, _fb, ...)	\
> +#define _CMN_EVENT_ATTR(_model, _name, _type, _eventid, _fa, _fb, _fc, _fd, ...) \
> 	(&((struct arm_cmn_event_attr[]) {{				\
> 		.attr = __ATTR(_name, 0444, arm_cmn_event_show, NULL),	\
> 		.model = _model,					\
> 		.type = _type,						\
> 		.eventid = _eventid,					\
> -		.filter = {{_fa, _fb}},					\
> +		.filter = {{_fa, _fb}, {_fc, _fd}},			\
> 	}})[0].attr.attr)
> #define CMN_EVENT_ATTR(_model, _name, _type, _eventid, _filter...)	\
> -	_CMN_EVENT_ATTR(_model, _name, _type, _eventid, ##_filter, 0, 0)
> +	_CMN_EVENT_ATTR(_model, _name, _type, _eventid, ##_filter, 0, 0, 0, 0)
>
> static ssize_t arm_cmn_event_show(struct device *dev,
> 				  struct device_attribute *attr, char *buf)
> @@ -769,6 +808,10 @@ static ssize_t arm_cmn_event_show(struct device *dev,
> 				  "type=0x%x,eventid=0x%x,wp_dev_sel=?,wp_chn_sel=?,wp_grp=?,wp_val=?,wp_mask=?\n",
> 				  eattr->type, eattr->eventid);
>
> +	if (filter[1].sel)
> +		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x,filter2=0x%x\n",
> +				  eattr->type, eattr->eventid, filter[0].val, filter[1].val);
> +
> 	if (filter[0].sel)
> 		return sysfs_emit(buf, "type=0x%x,eventid=0x%x,filter=0x%x\n",
> 				  eattr->type, eattr->eventid, filter[0].val);
> @@ -887,8 +930,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	CMN_EVENT_ATTR(_model, ccha_##_name, CMN_TYPE_CCHA, _event)
> #define CMN_EVENT_CCLA(_name, _event)				\
> 	CMN_EVENT_ATTR(CMN_ANY, ccla_##_name, CMN_TYPE_CCLA, _event)
> -#define CMN_EVENT_HNS(_name, _event)				\
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
> +#define _CMN_EVENT_HNS(_model, _name, _event, _filter...)		\
> +	CMN_EVENT_ATTR(_model, hns_##_name, CMN_TYPE_HNS, _event, ##_filter)
>
> #define CMN_EVENT_DVM_OCC(_model, _name, _event)			\
> 	CMN_EVENT_DVM(_model, _name##_all, _event, SEL_OCCUP1_ID, 0),	\
> @@ -913,7 +956,12 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> 	CMN_EVENT_ATTR(_model, _name##_group1_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 3), \
> 	CMN_EVENT_ATTR(_model, _name##_group1_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 4), \
> 	CMN_EVENT_ATTR(_model, _name##_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 5), \
> -	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6)
> +	CMN_EVENT_ATTR(_model, _name##_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 6), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_ccg_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 9), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_ccg_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 10), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt_read, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 11), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt_write, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 12), \
> +	CMN_EVENT_ATTR(CMNS3R2, _name##_lbt, _type, _event, SEL_CBUSY_SNTHROTTLE_SEL, 13)
>
> #define CMN_EVENT_HNF_OCC(_model, _name, _event)			\
> 	CMN_EVENT_HN_OCC(_model, hnf_##_name, CMN_TYPE_HNF, _event)
> @@ -922,23 +970,75 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
> #define CMN_EVENT_HNF_SNT(_model, _name, _event)			\
> 	CMN_EVENT_HN_SNT(_model, hnf_##_name, CMN_TYPE_HNF, _event)
>
> -#define CMN_EVENT_HNS_OCC(_name, _event)				\
> -	CMN_EVENT_HN_OCC(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event),	\
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_rxsnp, CMN_TYPE_HNS, _event, SEL_OCCUP1_ID, 5), \
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, SEL_OCCUP1_ID, 6), \
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, SEL_OCCUP1_ID, 7)
> +#define CMN_EVENT_HNS(_name, _event)					\
> +	_CMN_EVENT_HNS(CMN_ANY, _name, _event)
> +#define CMN_EVENT_HNSR0(_name, _event)					\
> +	_CMN_EVENT_HNS(CMN700 | CMNS3R01, _name, _event)
> +#define _CMN_EVENT_HNS_HBT(_model, _name, _event, _sel)			\
> +	_CMN_EVENT_HNS(_model, _name##_all, _event, _sel, 0),		\
> +	_CMN_EVENT_HNS(_model, _name##_hbt, _event, _sel, 1),		\
> +	_CMN_EVENT_HNS(_model, _name##_lbt, _event, _sel, 2)
> +#define _CMN_EVENT_HNS_HBT2(_model, _name, _event, _fsel1, f1)		\
> +	_CMN_EVENT_HNS(_model, _name##_all, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 0), \
> +	_CMN_EVENT_HNS(_model, _name##_hbt, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 1), \
> +	_CMN_EVENT_HNS(_model, _name##_lbt, _event, _fsel1, f1, SEL_HBT_LBT_SEL, 2)
> +
> +#define CMN_EVENT_HNS_OCC(_model, _name, _event)			\
> +	CMN_EVENT_HN_OCC(_model, hns_##_name, CMN_TYPE_HNS, _event),	\
> +	_CMN_EVENT_HNS(_model, _name##_rxsnp, _event, SEL_OCCUP1_ID, 5), \
> +	_CMN_EVENT_HNS(_model, _name##_lbt, _event, SEL_OCCUP1_ID, 6),	\
> +	_CMN_EVENT_HNS(_model, _name##_hbt, _event, SEL_OCCUP1_ID, 7),	\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rnf, _event, SEL_OCCUP1_ID, 8),	\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rni, _event, SEL_OCCUP1_ID, 9),	\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_OCCUP1_ID, 10), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_OCCUP1_ID, 11)
> #define CMN_EVENT_HNS_CLS( _name, _event)				\
> 	CMN_EVENT_HN_CLS(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
> -#define CMN_EVENT_HNS_SNT(_name, _event)				\
> -	CMN_EVENT_HN_SNT(CMN_ANY, hns_##_name, CMN_TYPE_HNS, _event)
> -#define CMN_EVENT_HNS_HBT(_name, _event)				\
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_all, CMN_TYPE_HNS, _event, SEL_HBT_LBT_SEL, 0), \
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_hbt, CMN_TYPE_HNS, _event, SEL_HBT_LBT_SEL, 1), \
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_lbt, CMN_TYPE_HNS, _event, SEL_HBT_LBT_SEL, 2)
> -#define CMN_EVENT_HNS_SNH(_name, _event)				\
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_all, CMN_TYPE_HNS, _event, SEL_SN_HOME_SEL, 0), \
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_sn, CMN_TYPE_HNS, _event, SEL_SN_HOME_SEL, 1), \
> -	CMN_EVENT_ATTR(CMN_ANY, hns_##_name##_home, CMN_TYPE_HNS, _event, SEL_SN_HOME_SEL, 2)
> +#define CMN_EVENT_HNSR0_CLS( _name, _event)				\
> +	CMN_EVENT_HN_CLS(CMN700 | CMNS3R01, hns_##_name, CMN_TYPE_HNS, _event)
> +#define CMN_EVENT_HNS_SNT(_model, _name, _event)			\
> +	CMN_EVENT_HN_SNT(_model, hns_##_name, CMN_TYPE_HNS, _event)
> +#define CMN_EVENT_HNS_SNH(_model, _name, _event)			\
> +	_CMN_EVENT_HNS(_model, _name##_all, _event, SEL_SN_HOME_SEL, 0), \
> +	_CMN_EVENT_HNS(_model, _name##_sn, _event, SEL_SN_HOME_SEL, 1),	\
> +	_CMN_EVENT_HNS(_model, _name##_home, _event, SEL_SN_HOME_SEL, 2)
> +#define CMN_EVENT_HNS_VC(_name, _event)					\
> +	CMN_EVENT_HNSR0(_name, _event),					\
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_vc0, _event, SEL_SNP_VC_SEL, 0), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_vc1, _event, SEL_SNP_VC_SEL, 1), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_vc2, _event, SEL_SNP_VC_SEL, 2)
> +#define CMN_EVENT_HNS_ENHBT(_name, _event)				\
> +	_CMN_EVENT_HNS_HBT(CMNS3R2, _name, _event, SEL_ENHANCED_HBT_LBT_SEL), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rnf, _event, SEL_ENHANCED_HBT_LBT_SEL, 3), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_rni, _event, SEL_ENHANCED_HBT_LBT_SEL, 4), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccglcn, _event, SEL_ENHANCED_HBT_LBT_SEL, 5), \
> +	_CMN_EVENT_HNS(CMNS3R2, _name##_ccgrn, _event, SEL_ENHANCED_HBT_LBT_SEL, 6)
> +#define CMN_EVENT_HNS_EVICT(_model, _name, _event)			\
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_all, _event, SEL_EVICT_STATE_SEL, 0), \
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_eu, _event, SEL_EVICT_STATE_SEL, 1), \
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_en, _event, SEL_EVICT_STATE_SEL, 2), \
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_su, _event, SEL_EVICT_STATE_SEL, 3), \
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_sn, _event, SEL_EVICT_STATE_SEL, 4), \
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_mu, _event, SEL_EVICT_STATE_SEL, 5), \
> +	_CMN_EVENT_HNS_HBT2(_model, _name##_mn, _event, SEL_EVICT_STATE_SEL, 6)
> +
> +#define CMN_EVENT_HNSR0_HBT(_name, _event)				\
> +	_CMN_EVENT_HNS_HBT(CMN700 | CMNS3R01, _name, _event, SEL_HBT_LBT_SEL)
> +#define CMN_EVENT_HNS_R2SNH(_name, _event)				\
> +	CMN_EVENT_HNSR0(_name, _event),					\
> +	CMN_EVENT_HNS_SNH(CMNS3R2, _name, _event)
> +#define CMN_EVENT_HNS_R2HBT(_name, _event)				\
> +	CMN_EVENT_HNSR0(_name, _event),					\
> +	_CMN_EVENT_HNS_HBT(CMNS3R2, _name, _event, SEL_HBT_LBT_SEL)
> +#define CMN_EVENT_HNS_HBT_ENHBT(_name, _event)				\
> +	CMN_EVENT_HNSR0_HBT(_name, _event),				\
> +	CMN_EVENT_HNS_ENHBT(_name, _event)
> +#define CMN_EVENT_HNS_HBT_OCC(_name, _event)				\
> +	CMN_EVENT_HNSR0_HBT(_name, _event),				\
> +	CMN_EVENT_HNS_OCC(CMNS3R2, _name, _event)
> +#define CMN_EVENT_HNS_HBT_EVICT(_name, _event)				\
> +	CMN_EVENT_HNSR0_HBT(_name, _event),				\
> +	CMN_EVENT_HNS_EVICT(CMNS3R2, _name, _event)
>
> #define _CMN_EVENT_XP_MESH(_name, _event)			\
> 	__CMN_EVENT_XP(e_##_name, (_event) | (0 << 2)),		\
> @@ -1288,65 +1388,72 @@ static struct attribute *arm_cmn_event_attrs[] = {
> 	CMN_EVENT_CCLA(pfwd_sndr_stalls_static_crd,	0x2a),
> 	CMN_EVENT_CCLA(pfwd_sndr_stalls_dynmaic_crd,	0x2b),
>
> -	CMN_EVENT_HNS_HBT(cache_miss,			0x01),
> -	CMN_EVENT_HNS_HBT(slc_sf_cache_access,		0x02),
> -	CMN_EVENT_HNS_HBT(cache_fill,			0x03),
> -	CMN_EVENT_HNS_HBT(pocq_retry,			0x04),
> -	CMN_EVENT_HNS_HBT(pocq_reqs_recvd,		0x05),
> -	CMN_EVENT_HNS_HBT(sf_hit,			0x06),
> -	CMN_EVENT_HNS_HBT(sf_evictions,			0x07),
> -	CMN_EVENT_HNS(dir_snoops_sent,			0x08),
> -	CMN_EVENT_HNS(brd_snoops_sent,			0x09),
> -	CMN_EVENT_HNS_HBT(slc_eviction,			0x0a),
> -	CMN_EVENT_HNS_HBT(slc_fill_invalid_way,		0x0b),
> -	CMN_EVENT_HNS(mc_retries_local,			0x0c),
> -	CMN_EVENT_HNS_SNH(mc_reqs_local,		0x0d),
> +	CMN_EVENT_HNS_HBT_ENHBT(cache_miss,		0x01),
> +	CMN_EVENT_HNS_HBT_ENHBT(slc_sf_cache_access,	0x02),
> +	CMN_EVENT_HNS_HBT_ENHBT(cache_fill,		0x03),
> +	CMN_EVENT_HNS_HBT_OCC(pocq_retry,		0x04),
> +	CMN_EVENT_HNS_HBT_OCC(pocq_reqs_recvd,		0x05),
> +	CMN_EVENT_HNS_HBT_ENHBT(sf_hit,			0x06),
> +	CMN_EVENT_HNS_HBT_EVICT(sf_evictions,		0x07),
> +	CMN_EVENT_HNS_VC(dir_snoops_sent,		0x08),
> +	CMN_EVENT_HNS_VC(brd_snoops_sent,		0x09),
> +	CMN_EVENT_HNS_HBT_EVICT(slc_eviction,		0x0a),
> +	CMN_EVENT_HNS_HBT_ENHBT(slc_fill_invalid_way,	0x0b),
> +	CMN_EVENT_HNS_R2SNH(mc_retries_local,		0x0c),
> +	CMN_EVENT_HNS_SNH(CMN_ANY, mc_reqs_local,	0x0d),
> 	CMN_EVENT_HNS(qos_hh_retry,			0x0e),
> -	CMN_EVENT_HNS_OCC(qos_pocq_occupancy,		0x0f),
> -	CMN_EVENT_HNS(pocq_addrhaz,			0x10),
> -	CMN_EVENT_HNS(pocq_atomic_addrhaz,		0x11),
> -	CMN_EVENT_HNS(ld_st_swp_adq_full,		0x12),
> -	CMN_EVENT_HNS(cmp_adq_full,			0x13),
> +	CMN_EVENT_HNS_OCC(CMN_ANY, qos_pocq_occupancy,	0x0f),
> +	CMN_EVENT_HNS_HBT_ENHBT(pocq_addrhaz,		0x10),
> +	CMN_EVENT_HNS_HBT_ENHBT(pocq_atomic_addrhaz,	0x11),
> +	CMN_EVENT_HNSR0(ld_st_swp_adq_full,		0x12),
> +	CMN_EVENT_HNSR0(cmp_adq_full,			0x13),
> 	CMN_EVENT_HNS(txdat_stall,			0x14),
> 	CMN_EVENT_HNS(txrsp_stall,			0x15),
> -	CMN_EVENT_HNS(seq_full,				0x16),
> +	CMN_EVENT_HNSR0(seq_full,			0x16),
> 	CMN_EVENT_HNS(seq_hit,				0x17),
> -	CMN_EVENT_HNS(snp_sent,				0x18),
> -	CMN_EVENT_HNS(sfbi_dir_snp_sent,		0x19),
> -	CMN_EVENT_HNS(sfbi_brd_snp_sent,		0x1a),
> +	CMN_EVENT_HNS_VC(snp_sent,			0x18),
> +	CMN_EVENT_HNS_VC(sfbi_dir_snp_sent,		0x19),
> +	CMN_EVENT_HNS_VC(sfbi_brd_snp_sent,		0x1a),
> 	CMN_EVENT_HNS(intv_dirty,			0x1c),
> -	CMN_EVENT_HNS(stash_snp_sent,			0x1d),
> -	CMN_EVENT_HNS(stash_data_pull,			0x1e),
> -	CMN_EVENT_HNS(snp_fwded,			0x1f),
> -	CMN_EVENT_HNS(atomic_fwd,			0x20),
> +	CMN_EVENT_HNSR0(stash_snp_sent,			0x1d),
> +	CMN_EVENT_HNSR0(stash_data_pull,		0x1e),
> +	CMN_EVENT_HNS_VC(snp_fwded,			0x1f),
> +	CMN_EVENT_HNSR0(atomic_fwd,			0x20),
> 	CMN_EVENT_HNS(mpam_hardlim,			0x21),
> 	CMN_EVENT_HNS(mpam_softlim,			0x22),
> -	CMN_EVENT_HNS(snp_sent_cluster,			0x23),
> -	CMN_EVENT_HNS(sf_imprecise_evict,		0x24),
> +	CMN_EVENT_HNS_VC(snp_sent_cluster,		0x23),
> +	CMN_EVENT_HNS_R2HBT(sf_imprecise_evict,		0x24),
> 	CMN_EVENT_HNS(sf_evict_shared_line,		0x25),
> 	CMN_EVENT_HNS_CLS(pocq_class_occup,		0x26),
> 	CMN_EVENT_HNS_CLS(pocq_class_retry,		0x27),
> 	CMN_EVENT_HNS_CLS(class_mc_reqs_local,		0x28),
> -	CMN_EVENT_HNS_CLS(class_cgnt_cmin,		0x29),
> -	CMN_EVENT_HNS_SNT(sn_throttle,			0x2a),
> -	CMN_EVENT_HNS_SNT(sn_throttle_min,		0x2b),
> +	CMN_EVENT_HNSR0_CLS(class_cgnt_cmin,		0x29),
> +	CMN_EVENT_HNS_SNT(CMN_ANY, sn_throttle,		0x2a),
> +	CMN_EVENT_HNS_SNT(CMN_ANY, sn_throttle_min,	0x2b),
> 	CMN_EVENT_HNS(sf_precise_to_imprecise,		0x2c),
> 	CMN_EVENT_HNS(snp_intv_cln,			0x2d),
> 	CMN_EVENT_HNS(nc_excl,				0x2e),
> -	CMN_EVENT_HNS(excl_mon_ovfl,			0x2f),
> +	CMN_EVENT_HNSR0(excl_mon_ovfl,			0x2f),
> 	CMN_EVENT_HNS(snp_req_recvd,			0x30),
> 	CMN_EVENT_HNS(snp_req_byp_pocq,			0x31),
> 	CMN_EVENT_HNS(dir_ccgha_snp_sent,		0x32),
> 	CMN_EVENT_HNS(brd_ccgha_snp_sent,		0x33),
> -	CMN_EVENT_HNS(ccgha_snp_stall,			0x34),
> +	CMN_EVENT_HNSR0(ccgha_snp_stall,		0x34),
> 	CMN_EVENT_HNS(lbt_req_hardlim,			0x35),
> 	CMN_EVENT_HNS(hbt_req_hardlim,			0x36),
> 	CMN_EVENT_HNS(sf_reupdate,			0x37),
> -	CMN_EVENT_HNS(excl_sf_imprecise,		0x38),
> +	CMN_EVENT_HNS_R2HBT(excl_sf_imprecise,		0x38),
> 	CMN_EVENT_HNS(snp_pocq_addrhaz,			0x39),
> -	CMN_EVENT_HNS(mc_retries_remote,		0x3a),
> -	CMN_EVENT_HNS_SNH(mc_reqs_remote,		0x3b),
> +	CMN_EVENT_HNS_R2SNH(mc_retries_remote,		0x3a),
> +	CMN_EVENT_HNS_SNH(CMN_ANY, mc_reqs_remote,	0x3b),
> 	CMN_EVENT_HNS_CLS(class_mc_reqs_remote,		0x3c),
> +	CMN_EVENT_HNS_ENHBT(readonce_hazard_detected,	0x3d),
> +	CMN_EVENT_HNS_ENHBT(readonce_fwd_data_completed, 0x3e),
> +	CMN_EVENT_HNS_SNT(CMNS3R2, cbusy00,		0x40),
> +	CMN_EVENT_HNS_SNT(CMNS3R2, cbusy01, 		0x41),
> +	CMN_EVENT_HNS_SNT(CMNS3R2, cbusy10,		0x42),
> +	CMN_EVENT_HNS_SNT(CMNS3R2, cbusy11,		0x43),
> +	CMN_EVENT_HNS_ENHBT(ro_rnsd_new_alloc_hint,	0x44),
>
> 	NULL
> };
> @@ -2431,21 +2538,33 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	/*
> 	 * With the device isolation feature, if firmware has neglected to enable
> 	 * an XP port then we risk locking up if we try to access anything behind
> -	 * it; however we also have no way to tell from Non-Secure whether any
> -	 * given port is disabled or not, so the only way to win is not to play...
> +	 * it; however prior to CMN S3 r2p0 we also have no way to tell from
> +	 * Non-Secure whether any given port is disabled or not, so in that case
> +	 * the only way to win is not to play...
> 	 */
> 	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL);
> -	if (reg & CMN_INFO_DEVICE_ISO_ENABLE) {
> +	if (reg & CMN_INFO_DEVICE_ISO_ENABLE && model == CMNS3R01) {
> 		dev_err(cmn->dev, "Device isolation enabled, not continuing due to risk of lockup\n");
> 		return -ENODEV;
> 	}
> -	cmn->multi_dtm = reg & CMN_INFO_MULTIPLE_DTM_EN;
> -	cmn->rsp_vc_num = FIELD_GET(CMN_INFO_RSP_VC_NUM, reg);
> -	cmn->dat_vc_num = FIELD_GET(CMN_INFO_DAT_VC_NUM, reg);
> +	if (model < CMNS3R2) {
> +		cmn->multi_dtm = reg & CMN_INFO_MULTIPLE_DTM_EN;
> +		cmn->rsp_vc_num = FIELD_GET(CMN_INFO_RSP_VC_NUM, reg);
> +		cmn->dat_vc_num = FIELD_GET(CMN_INFO_DAT_VC_NUM, reg);
> +	} else {
> +		cmn->multi_dtm = reg & CMN_S3_R2_MULTIPLE_DTM_EN;
> +	}
>
> 	reg = readq_relaxed(cfg_region + CMN_CFGM_INFO_GLOBAL_1);
> -	cmn->snp_vc_num = FIELD_GET(CMN_INFO_SNP_VC_NUM, reg);
> -	cmn->req_vc_num = FIELD_GET(CMN_INFO_REQ_VC_NUM, reg);
> +	if (model < CMNS3R2) {
> +		cmn->snp_vc_num = FIELD_GET(CMN_INFO_SNP_VC_NUM, reg);
> +		cmn->req_vc_num = FIELD_GET(CMN_INFO_REQ_VC_NUM, reg);
> +	} else {
> +		cmn->rsp_vc_num = FIELD_GET(CMN_S3_R2_RSP_VC_NUM, reg);
> +		cmn->dat_vc_num = FIELD_GET(CMN_S3_R2_DAT_VC_NUM, reg);
> +		cmn->snp_vc_num = FIELD_GET(CMN_S3_R2_SNP_VC_NUM, reg);
> +		cmn->req_vc_num = FIELD_GET(CMN_S3_R2_REQ_VC_NUM, reg);
> +	}
>
> 	reg = readq_relaxed(cfg_region + CMN_CHILD_INFO);
> 	child_count = FIELD_GET(CMN_CI_CHILD_COUNT, reg);
> @@ -2545,15 +2664,12 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 			reg = readq_relaxed(xp_region + child_poff + j * 8);
> 			/*
> 			 * Don't even try to touch anything external, since in general
> -			 * we haven't a clue how to power up arbitrary CHI requesters.
> -			 * As of CMN-600r1 these could only be RN-SAMs or CXLAs,
> -			 * neither of which have any PMU events anyway.
> -			 * (Actually, CXLAs do seem to have grown some events in r1p2,
> -			 * but they don't go to regular XP DTMs, and they depend on
> -			 * secure configuration which we can't easily deal with)
> +			 * we haven't a clue how to power up arbitrary CHI requesters,
> +			 * and none of them have standard PMU events anyway. Isolated
> +			 * nodes effectively just do not exist at all from our PoV.
> 			 */
> -			if (reg & CMN_CHILD_NODE_EXTERNAL) {
> -				dev_dbg(cmn->dev, "ignoring external node %llx\n", reg);
> +			if (reg & (CMN_CHILD_NODE_EXTERNAL | CMN_CHILD_NODE_ISOLATED)) {
> +				dev_dbg(cmn->dev, "ignoring external/isolated node %llx\n", reg);
> 				continue;
> 			}
> 			/*
> -- 
> 2.54.0.dirty
>
>
