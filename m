Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021085.outbound.protection.outlook.com [52.101.62.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69E8392C20;
	Tue,  2 Jun 2026 05:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379407; cv=fail; b=cpVXfwxaLIP++SKQ1MRta4KN6mwNGnou9HLVKrLpexRX8thIQZAxo+wtGEu+bYeCJTrEwlaqmhrq8qsiIdKH2Rm9JaD8s4Fcj1pl5YpmMuWi6cCeyK+YC8VJf1RSblYDP+jWFuO4EPaQhgnqlBhIpA3blHEMutlNdUMWGXF5akQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379407; c=relaxed/simple;
	bh=SWtC+QhIAGjCQ6Zx3jQhNUeqqoBDdr5kJN6WjTxh5PQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=V6KCDqqvsxx4LnFsYMjMPvwmAKWUJeFkYYr1DRTfFfu2bE0ysRTI+jUeXsPgxWo56qJPV3BL7v1S1Lta3pBCHCm45DeXnbIgy77pdRD8zN/pER7I4Py07wxUZCydUpXbzxEhB+bdihW/GFkHPJqzt2UnHFpzawlg6qk4+eYDIio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qgFsiXGe; arc=fail smtp.client-ip=52.101.62.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qgFsiXGe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5TwTs6dgEmJ/cL7kIKl1/IrqM+UAa5GbTFzVSZqQ6gxj2UL5L2mZZPmX69zQObREG4ngKBRKgoOOASeSdhU57h/fXlVd49KaNATMXZxgTXuRn2MOE4A1eCqVAJMtBrcHfR4LZM5zyyD8GU4SSPS/JRUGNeM93R66hB8oI9EFuLOACNZQm0uATt7+sUxZ9uMN+Xbko0EgGUciQFpD7/UHwbniQju4lZQzbGL2Q7n/AvaSPulPNpe2zV3wqQbe2VtGKTWDuRAYdp/9Hf3HB3LozVxswkUMVP3X0qznp4pcnmLJnJlXtYxEpifdQTZF1O3Fkmm/4nxyj34i3kh0G8+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2moZZTBKnD/QoATTyu9NTGSMaZpgczqJGNh7toBEbio=;
 b=XNoTiLqCvwC8os4RuHe5gVO6oYkoWTGhChrGnFF0dcEMotVaAXm8xy9qiwkBa3q91NsP+DnZAsUpPjh+aXwhPrszP8caxL+6HS9dMUXSjCtF9Vq75Hv9faM2j13JF984SoUwN1T3KwAXKTtrcWuC7YxXvXvqyzYwtbmqocem5aetkii8McKePIfk5SrEQQWhk3EO7u8sG51ogAQKYLrOmUSzbsqsa+2KJxZU0ZYxIX2ucscbR9Hw7kuqsFqUB2pMg8MbJHG7sJ8ezDmQcs0BQSAByJ8yBhJwzTTG/m61ItO6dnANFHAIOXpHUlOvQNvsSXbxs8cUhmKpUdbTMZ03nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2moZZTBKnD/QoATTyu9NTGSMaZpgczqJGNh7toBEbio=;
 b=qgFsiXGelsPmG6S0pRFxj7b4YYMwUPD2XQInAgfn10cgrxNjuBKJDdINkfi91u/NnRQUVA5X/Yb6BM61eDr70lx2c02NI8aNd9A8buiQXKpD6FrG8Zs4tZaIZXv/OX3/midDyYc8NyOpIPvtajkLhFu1vOjZPBcjK+GQXij2dD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 BN0PR01MB6976.prod.exchangelabs.com (2603:10b6:408:16f::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.17; Tue, 2 Jun 2026 05:49:50 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:49:50 +0000
Date: Mon, 1 Jun 2026 22:49:44 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Aviv Bakal <avivb@amazon.com>
cc: robin.murphy@arm.com, will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org, zeev@amazon.com, blakgeof@amazon.com, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH v4 1/2] perf/arm-cmn: Move DTM index data out of
 hw_perf_event
In-Reply-To: <20260531110447.10095-2-avivb@amazon.com>
Message-ID: <c955cf19-1fd9-142b-9bde-63858db3e5b9@os.amperecomputing.com>
References: <20260524153848.16334-1-avivb@amazon.com> <20260531110447.10095-1-avivb@amazon.com> <20260531110447.10095-2-avivb@amazon.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|BN0PR01MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e62f75-38ff-4b08-d25a-08dec06ac299
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799006|4143699003|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	0rXCXesISfDYUbjrNrDcyeSuzYIt5pVo4XYqW1UVmqbvTBWRixIS5l9UWic0saEir/Icgfe1w4+DoNz/yNgjKclbPM+FWk2r1dPAhV8GpzEJvnDIuLTvCfG8xacEfZqo2I2CywxZiLRQnTrHt+2LRaPv+O8Z6fDUGNjBen9oQcwWnWWVhmLyu7+oK7cpr4v0CbnzAuQHW4ywIJVekT8+uBMkm+62Puu+vlbcETyII9gvbj87pU4UMhtbfINlmRW3SxVRXpsHUiMvXtHRTOTp/cNEiqHIjz3dNd9aG0WXScz02YKC2wkOMlKJrijOFGgmpkjlD8nWJr43xSAU1ZBHKP+/V1TY2OYwbeZXS9+VrayKr4CAndC4/0i0EW9CcIQ+iGM/UQJJ7E4f6M+G66FjeHfuOaziTxl8F3zcxlgaqyCoPhrStcBKz8fE0DBTgJUJyqC7awY52lExqcZOIjvmncIs4zo85qXHDdzBXnTCZloJAIebOQSV/CqOUAZpkxo4okvc08vNW9VYwtI++iF36Dfoddxc5CjNPSsdu2u73UEvUXHWbHq1vOAfpGxNnECh7T55mja3Vb7l1kaPJhAfpa69oHgcRYFqzMKZ3iZZY2SyxjRc4GGr2VikEwAR1ov0fyec47FwLXtlua8KAiTDCjnfB5Cj9i01LNRtY2Vc4qKdmr1OIo5hME9PS/S68HHq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGcPxZkf04zZuGQbftC6ddBZd2WZudUx1E6UfRY3C97psBbQuxt3tOmQo8pM?=
 =?us-ascii?Q?Hzn5QFkvpI/saSkr4KLOLqKjj8cAbUMs/8VwPk93I4mEHQ779jm0m10BW/3N?=
 =?us-ascii?Q?hHM4aVN0SNlSizwrpeOtsQBVuWEDiR94xRZmwSRmFlsyN7ZmT0diuA/GE4m5?=
 =?us-ascii?Q?53V0+Ur3csAM/Sn8dyRf97C/54m5Fjnt6qKJagnNc0Q2Jtre1NEbSLtkKY3K?=
 =?us-ascii?Q?CQw64nBk13mhd3mvEVuD9NDIceRtfszmaiGi5eJ9q+HKyPVnQvSCvuu0sCRK?=
 =?us-ascii?Q?BMe6s9cSOcXIJcXm1ryVSd5G0N5eX0EDjZvG4uiqX9Eu1cMTX4ohYPtH9EAH?=
 =?us-ascii?Q?RQuxOGnjOgq0CifCrk90cYMjDIQK6GgmxvqhmE3cvWutBWwdOiXoqr4hm5hF?=
 =?us-ascii?Q?jNEUu9WU8YZ3ojNBCBXWZNzOJG7OInII/ThGkElJu7c22VjDbHEGx1FvpI8g?=
 =?us-ascii?Q?C4giChHxT142571vx/GJFPBP4fc3ZXm4CoXzA8V8By8cGnAG6sVPIdShOhmc?=
 =?us-ascii?Q?MYqGLWueMUBzHsELmvikWnooIJjvLUXnldTZbIvlqjqKjrMHPEW70Xzrz+im?=
 =?us-ascii?Q?otxIMgFbteoyBreRujevFfKBpys5Ed767672se101llQ+MaWaXu5BeF8YIEF?=
 =?us-ascii?Q?K3vS1OsYsf35mY+0CsVHV3JFhwLqqCY0XVRG+y8ZH3ivYQxW3jYlv3G1Zk3U?=
 =?us-ascii?Q?/qpyxg5C39hETeDwZ0tQigS4sbhpdFfTXm7atpJxgoQEko+GOSM7grxqnngL?=
 =?us-ascii?Q?zcY2po0vWdoMJskiF9HdVQIEy18Q4FzToILlj+ofD3JDvX8XQwF1FJZkzQ4U?=
 =?us-ascii?Q?YqK+RDgEt/kecH3wx+Z2ftUks3ozhGg8xZFWR5tOnlbSzYod0KrEsXfoJRc/?=
 =?us-ascii?Q?vlqPXQUCwjcFGZdVb3cnZts8zhGYIs6VN8nSpRZR/+OcX5D/wjaLvz0+VchX?=
 =?us-ascii?Q?TXq7CkPWMPy5ZaaU/9kDQTPyoJLXTrnh1Ab1OWQ84J6CgWobDJd9jof+acBf?=
 =?us-ascii?Q?QHOnRaSxbjQeJkfjoAFOugiIeHOxvlNvFf1MUTzWZ7FrQjMHo1LEZpbE2lMR?=
 =?us-ascii?Q?ILCBRajk3myZLz2R1GCN0stpY5fnoL9R0sAWUi9/rD6Rt3ahNyZ+NzO91azy?=
 =?us-ascii?Q?J37kun9AYFcDIXG+SPm18K/esyRS4SdCbtbhe9lwfvJthrmlCGVoXi+THVrr?=
 =?us-ascii?Q?00JymOf5yDxwgVM2160lLKlM0oZHqS0w9UZPzMmK3dkt+s+YlUN9LXUVnVRr?=
 =?us-ascii?Q?aYEwjNjx5Svbr8U5hGBptQ0m0Z1hySpwHoL+c6vp8PaP+QilF5ssRAqsu7S5?=
 =?us-ascii?Q?WTjHLt5yCjndu+FcrbCakCSR8f2m+ZDv2Oj/U6iwc7nsY/7oEKvQutdGQEaZ?=
 =?us-ascii?Q?an/3jVpP0Mvrjio84D+v1/W4LhUTfJ/HyqA5knbQKuuNuwZ3Jg/6LdWAmBI0?=
 =?us-ascii?Q?QotfnvTpqiOaPewCGLmGxB5ZGwlOGCxjwsqB8HnenTN6qwNrF+rf9wg+R6kl?=
 =?us-ascii?Q?KeffvaUnqQzMMIceJf7A+4m/JqIsaf8+lVzFakEMb0NOH9Rnvrkp7d2OLPoU?=
 =?us-ascii?Q?Q1nDqS9lGyOgjnXw/tA2ij0lQEEfOgk58f20n9YYSJzf9Pqi9do4Bo6XbDvt?=
 =?us-ascii?Q?7v+AZ4EWGx8aBwyBisuc+gvRvHdh+Pegc7tj0GsjPfEIxSym/5eBRBaA53LI?=
 =?us-ascii?Q?K9prpg+8SRxlcUpKGbHYF8S1cbm73hhaVDX+YZiyn/XroipPrIREi/Zao+va?=
 =?us-ascii?Q?ods6aa6n520E1E4SyA15IjUPOiije7U=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e62f75-38ff-4b08-d25a-08dec06ac299
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:49:50.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUjaOFGz/g4dtE3qJZWH0G1N00UIbwHKti5/qdy1Q5hbNmTr/SVhliq/htkMY8BK5xDL2QqZqmdn/6JHuX/Y8XhaMd7b60kU20VwHqScfgt4gPCTaNrllrVgJQ3cfHYM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6976



On Sun, 31 May 2026, Aviv Bakal wrote:

> The amount of data we need to store all the per-DTM counter and
> watchpoint allocations is already testing the limits of hw_perf_event,
> and future CMNs are only likely to keep growing larger, so move these
> arrays out to separate memory allocations. As part of that we can use
> an explicit union for allocating cycle counters to dtc_cycles events,
> which is arguably nicer anyway.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Aviv Bakal <avivb@amazon.com>

Thanks for the patch. I was wondering a while ago when the mesh grows too 
big to handle it with the old way.

The patch looks good to me,

 	Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka


> ---
> drivers/perf/arm-cmn.c | 89 ++++++++++++++++++++++++++++--------------
> 1 file changed, 59 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index f5305c8fdca4..f1978a53d1c1 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -597,17 +597,14 @@ static void arm_cmn_debugfs_init(struct arm_cmn *cmn, int id) {}
>
> struct arm_cmn_hw_event {
> 	struct arm_cmn_node *dn;
> -	u64 dtm_idx[DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64)];
> +	union {
> +		u64 *dtm_idx;
> +		int cc_idx;
> +	};
> +	unsigned long *wp_idx;
> 	s8 dtc_idx[CMN_MAX_DTCS];
> 	u8 num_dns;
> 	u8 dtm_offset;
> -
> -	/*
> -	 * WP config registers are divided to UP and DOWN events. We need to
> -	 * keep to track only one of them.
> -	 */
> -	DECLARE_BITMAP(wp_idx, CMN_MAX_XPS);
> -
> 	bool wide_sel;
> 	enum cmn_filter_select filter_sel;
> };
> @@ -625,25 +622,42 @@ static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
> 	return (struct arm_cmn_hw_event *)&event->hw;
> }
>
> -static void arm_cmn_set_index(u64 x[], unsigned int pos, unsigned int val)
> +static void arm_cmn_set_dtm_idx(struct arm_cmn_hw_event *hw, unsigned int pos, unsigned int val)
> {
> -	x[pos / 32] |= (u64)val << ((pos % 32) * 2);
> +	hw->dtm_idx[pos / 32] |= (u64)val << ((pos % 32) * 2);
> }
>
> -static unsigned int arm_cmn_get_index(u64 x[], unsigned int pos)
> +static unsigned int arm_cmn_get_dtm_idx(struct arm_cmn_hw_event *hw, unsigned int pos)
> {
> -	return (x[pos / 32] >> ((pos % 32) * 2)) & 3;
> +	return (hw->dtm_idx[pos / 32] >> ((pos % 32) * 2)) & 3;
> }
>
> -static void arm_cmn_set_wp_idx(unsigned long *wp_idx, unsigned int pos, bool val)
> +static u64 *arm_cmn_alloc_dtm_idx(void)
> +{
> +	return kzalloc(DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64) * sizeof(u64), GFP_KERNEL);
> +}
> +
> +static void arm_cmn_set_wp_idx(struct arm_cmn_hw_event *hw, unsigned int pos, bool val)
> {
> 	if (val)
> -		set_bit(pos, wp_idx);
> +		set_bit(pos, hw->wp_idx);
> +}
> +
> +static unsigned int arm_cmn_get_wp_idx(struct arm_cmn_hw_event *hw, unsigned int pos)
> +{
> +	return test_bit(pos, hw->wp_idx);
> +}
> +
> +static unsigned long *arm_cmn_alloc_wp_idx(void)
> +{
> +	return bitmap_zalloc(CMN_MAX_XPS, GFP_KERNEL);
> }
>
> -static unsigned int arm_cmn_get_wp_idx(unsigned long *wp_idx, unsigned int pos)
> +static void arm_cmn_clear_idx(struct arm_cmn_hw_event *hw)
> {
> -	return test_bit(pos, wp_idx);
> +	memset(hw->dtm_idx, 0, DIV_ROUND_UP(CMN_MAX_NODES_PER_EVENT * 2, 64) * sizeof(u64));
> +	if (hw->wp_idx)
> +		bitmap_zero(hw->wp_idx, CMN_MAX_XPS);
> }
>
> struct arm_cmn_event_attr {
> @@ -1376,7 +1390,7 @@ static int arm_cmn_get_assigned_wp_idx(struct perf_event *event,
> 				       struct arm_cmn_hw_event *hw,
> 				       unsigned int pos)
> {
> -	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw->wp_idx, pos);
> +	return CMN_EVENT_EVENTID(event) + arm_cmn_get_wp_idx(hw, pos);
> }
>
> static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
> @@ -1387,7 +1401,7 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
> 	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
>
> 	dtm->wp_event[wp_idx] = hw->dtc_idx[dtc];
> -	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
> +	arm_cmn_set_wp_idx(hw, pos, wp_idx - CMN_EVENT_EVENTID(event));
> }
>
> static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
> @@ -1458,7 +1472,7 @@ static u64 arm_cmn_read_dtm(struct arm_cmn *cmn, struct arm_cmn_hw_event *hw,
> 			dtm = &cmn->dtms[dn->dtm] + hw->dtm_offset;
> 			reg = readq_relaxed(dtm->base + offset);
> 		}
> -		dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		dtm_idx = arm_cmn_get_dtm_idx(hw, i);
> 		count += (u16)(reg >> (dtm_idx * 16));
> 	}
> 	return count;
> @@ -1505,7 +1519,7 @@ static void arm_cmn_event_read(struct perf_event *event)
> 	unsigned long flags;
>
> 	if (CMN_EVENT_TYPE(event) == CMN_TYPE_DTC) {
> -		delta = arm_cmn_read_cc(cmn->dtc + hw->dtc_idx[0]);
> +		delta = arm_cmn_read_cc(cmn->dtc + hw->cc_idx);
> 		local64_add(delta, &event->count);
> 		return;
> 	}
> @@ -1572,7 +1586,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
> 	int i;
>
> 	if (type == CMN_TYPE_DTC) {
> -		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->cc_idx;
>
> 		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
> 			       dtc->base + CMN_DT_DTC_CTL);
> @@ -1590,7 +1604,7 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
> 			writeq_relaxed(mask, base + CMN_DTM_WPn_MASK(wp_idx));
> 		}
> 	} else for_each_hw_dn(hw, dn, i) {
> -		int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>
> 		arm_cmn_set_event_sel_lo(dn, dtm_idx, CMN_EVENT_EVENTID(event),
> 					 hw->wide_sel);
> @@ -1606,7 +1620,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
> 	int i;
>
> 	if (type == CMN_TYPE_DTC) {
> -		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->cc_idx;
>
> 		dtc->cc_active = false;
> 		writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
> @@ -1619,7 +1633,7 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
> 			writeq_relaxed(~0ULL, base + CMN_DTM_WPn_VAL(wp_idx));
> 		}
> 	} else for_each_hw_dn(hw, dn, i) {
> -		int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>
> 		arm_cmn_set_event_sel_lo(dn, dtm_idx, 0, hw->wide_sel);
> 	}
> @@ -1763,6 +1777,14 @@ static enum cmn_filter_select arm_cmn_filter_sel(const struct arm_cmn *cmn,
> }
>
>
> +static void arm_cmn_event_destroy(struct perf_event *event)
> +{
> +	struct arm_cmn_hw_event *hw = to_cmn_hw(event);
> +
> +	kfree(hw->dtm_idx);
> +	bitmap_free(hw->wp_idx);
> +}
> +
> static int arm_cmn_event_init(struct perf_event *event)
> {
> 	struct arm_cmn *cmn = to_cmn(event->pmu);
> @@ -1787,6 +1809,11 @@ static int arm_cmn_event_init(struct perf_event *event)
> 	if (type == CMN_TYPE_DTC)
> 		return arm_cmn_validate_group(cmn, event);
>
> +	event->destroy = arm_cmn_event_destroy;
> +	hw->dtm_idx = arm_cmn_alloc_dtm_idx();
> +	if (!hw->dtm_idx)
> +		return -ENOMEM;
> +
> 	eventid = CMN_EVENT_EVENTID(event);
> 	/* For watchpoints we need the actual XP node here */
> 	if (type == CMN_TYPE_WP) {
> @@ -1797,6 +1824,9 @@ static int arm_cmn_event_init(struct perf_event *event)
> 		/* ...but the DTM may depend on which port we're watching */
> 		if (cmn->multi_dtm)
> 			hw->dtm_offset = CMN_EVENT_WP_DEV_SEL(event) / 2;
> +		hw->wp_idx = arm_cmn_alloc_wp_idx();
> +		if (!hw->wp_idx)
> +			return -ENOMEM;
> 	} else if (type == CMN_TYPE_XP &&
> 		   (cmn->part == PART_CMN700 || cmn->part == PART_CMN_S3)) {
> 		hw->wide_sel = true;
> @@ -1847,7 +1877,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
>
> 	while (i--) {
> 		struct arm_cmn_dtm *dtm = &cmn->dtms[hw->dn[i].dtm] + hw->dtm_offset;
> -		unsigned int dtm_idx = arm_cmn_get_index(hw->dtm_idx, i);
> +		unsigned int dtm_idx = arm_cmn_get_dtm_idx(hw, i);
>
> 		if (type == CMN_TYPE_WP) {
> 			int wp_idx = arm_cmn_get_assigned_wp_idx(event, hw, i);
> @@ -1861,8 +1891,7 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
> 		dtm->pmu_config_low &= ~CMN__PMEVCNT_PAIRED(dtm_idx);
> 		writel_relaxed(dtm->pmu_config_low, dtm->base + CMN_DTM_PMU_CONFIG);
> 	}
> -	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
> -	memset(hw->wp_idx, 0, sizeof(hw->wp_idx));
> +	arm_cmn_clear_idx(hw);
>
> 	for_each_hw_dtc_idx(hw, j, idx)
> 		cmn->dtc[j].counters[idx] = NULL;
> @@ -1882,7 +1911,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 				return -ENOSPC;
>
> 		cmn->dtc[i].cycles = event;
> -		hw->dtc_idx[0] = i;
> +		hw->cc_idx = i;
>
> 		if (flags & PERF_EF_START)
> 			arm_cmn_event_start(event, 0);
> @@ -1947,7 +1976,7 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
> 				goto free_dtms;
> 		}
>
> -		arm_cmn_set_index(hw->dtm_idx, i, dtm_idx);
> +		arm_cmn_set_dtm_idx(hw, i, dtm_idx);
>
> 		dtm->input_sel[dtm_idx] = input_sel;
> 		shift = CMN__PMEVCNTn_GLOBAL_NUM_SHIFT(dtm_idx);
> @@ -1980,7 +2009,7 @@ static void arm_cmn_event_del(struct perf_event *event, int flags)
> 	arm_cmn_event_stop(event, PERF_EF_UPDATE);
>
> 	if (type == CMN_TYPE_DTC)
> -		cmn->dtc[hw->dtc_idx[0]].cycles = NULL;
> +		cmn->dtc[hw->cc_idx].cycles = NULL;
> 	else
> 		arm_cmn_event_clear(cmn, event, hw->num_dns);
> }
> -- 
> 2.47.3
>
>
