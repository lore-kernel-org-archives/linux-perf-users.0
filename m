Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2129.outbound.protection.outlook.com [40.107.220.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76C79C4
	for <linux-perf-users@vger.kernel.org>; Sun, 29 Jun 2025 01:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751162089; cv=fail; b=lHiJrWdB5SaC9+jAICMLB/Y8rp+2Mjd0QTfM6kfo1XHROVvy0f/prjAV02P81SFSRq3gF4sTjTzX8iQ4w2Qo8qMYOfdEGmFrCAoSTPWlf4IChbcpu2F5/EpWCdXg7EjgFp1j1nTl6+/VOHHvhKj00nG8BELGVhvtihlkQpy/xW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751162089; c=relaxed/simple;
	bh=I6W5mLU1+WQmGIz+xVgjA/xiGYTxKgs5nReZrEjzuug=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=idNkMBXhJSjN9h9Pkz/Za7UVCbiKq1q9IAtu2s5JE5GYltlCKDCUSU4lUm/qUOQraCPsLcK+AcbYtbMqb6AYgyZNmZfMJ9/v14TxNUNRPaDnX2G/dR5351jNJAoGUakth3Mlwgp5Xza3ouMm75UgGxlmw1VJe0rfEOD0TmFO4ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hyIDbVde; arc=fail smtp.client-ip=40.107.220.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hyIDbVde"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFm98gs8u2j81ZDcnuZBNNB8IeeR3RRac+21SHLc1hxgQkGN0gkh+lEb068fzeE4+7us+zvso9CcFrRrYIlJGfAQMjUr4l3WHyEGSBtarZXYXQxZvcUsLBwYqDMPXM3IAoS7I1ZHbgykjsf+3r5xSoq3r6Q2Fl+qnWatwUPvBgcS6/YOR3mnFcqE88MVz0WWcKW4ZxNyeSJ8YqjqvNqKCfXi0pAlnXn79JTr71C7QvUSQsfnD8jD2545ar04keQtj8+tI874JEcBzkgfXnxXy7T1YMNgtd3EHgcKvhluNiRUf6rcwlfcXmi3GbZfv2lSnBTTfdZqmPwRqFBOUOP2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ihokIbb9pgTXxt+zQ5GEHJY4uG9niVvmwavBJommpU=;
 b=piBLbeN8BGOYsPvdbYQKN4YOiclAfa8ycWxaAPF4x3J+lqBWQltvd+wy3XHowg31fMLwlP4D9pQrcuXD/Znx9qY0hSUbLziCoCAUnjI0BzjcZBGi44gzBVxZcKCaOIHIYQzKM7+fMHvqFGYaFCVqQVkuB6sw/EbmtMjyWPxpPnBwQMgagVmYLDrpZmk83j5SsG1AzuHsNcE95gY754PXU0JhqfALhI3aQGWqwN74j0c4y5Q0Zo79psKmrHjW9oAxpRRIGIvIcL/2pQgXxskPZh9D9AkdRe6kV+2w8Jgg4j/GnbpmbUW4ynM+YKpmf31kTStAyiqMeKFYBkXZElhh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ihokIbb9pgTXxt+zQ5GEHJY4uG9niVvmwavBJommpU=;
 b=hyIDbVderWGzhq5pZjHOdw6lK/RGpIcy8mcEO7dUV/ye0xyr7pavy0RIrTzEl/WfUITtppAtOFLnPuJAinHSIiibJFLhPK49uE4WtPRUBiFOSZmxhkWSZ4Wc3RQA2n7ZF+HXtdI9BuQMxdRuC2fJFuYUJlO8lpiKfCmsy9P0vgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CO1PR01MB6552.prod.exchangelabs.com (2603:10b6:303:d7::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.26; Sun, 29 Jun 2025 01:54:42 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%5]) with mapi id 15.20.8880.026; Sun, 29 Jun 2025
 01:54:41 +0000
Date: Sat, 28 Jun 2025 18:54:35 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, ilkka@os.amperecomputing.com, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] perf/arm-cmn: Reduce stack usage during discovery
In-Reply-To: <e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com>
Message-ID: <385e2d1-1d1b-b9d9-d65-727dcd716d54@os.amperecomputing.com>
References: <e7dd41bf0f1b098e2e4b01ef91318a4b272abff8.1751046159.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SA9PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:806:22::10) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CO1PR01MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ba98d1-726c-4c6d-c823-08ddb6afe99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nn2amkgzM47mwfydPTGjfNlQO0BfdKmjJ3Vwh9wv3U9Z8fR4mqo5ssTfzbq8?=
 =?us-ascii?Q?T/gzXhgqjxeGdbDggmDdLYhZjOB+TaPaIqPKo+8lit3ZugBRWJPovSSKrApu?=
 =?us-ascii?Q?cvo3QnAU6nhv9hKQ3oxkFhPbesssqpRNOQa43xxCHjia+Eqb3rU5ZwL0OqQ3?=
 =?us-ascii?Q?8GI8PiUJWlXBgjehjDC0uDsb3jUfc3QnokH1BdGMdPY4ZJxmZIDvMHwoGJXh?=
 =?us-ascii?Q?h4K9nSr7KyZJj2x4uQ2BaH+4m4nzSwgT2PONBFKumFfry6bLhpLFWUU3m5tn?=
 =?us-ascii?Q?Vl3IXEUja4XZ/F7lO2qMbYJ2MbMgfY5FhQJnNe+qx+5wf/4WiuA4rvz927Zu?=
 =?us-ascii?Q?Mh/xD2bbmNwC6xyXCGfnq4Z8LwqqBLRh645H21fsAWwq99PPMNsRDk9PD2P9?=
 =?us-ascii?Q?5i9SVoFl8mIUgAj3MmsF8jlcjJ0tPMTwHWV5Wurrw6MlgCkJG+78WB5Qej2N?=
 =?us-ascii?Q?7WsP++R1bES30g+tMOcdj6o7mUWpEt5uVsb3NcWdEqiUJSQnRs8WVu9ic8Ab?=
 =?us-ascii?Q?wJ/mnz5Fn01FVv7qMD+FcHuJ2DGAgrpATR/0bySkjR3wk0gssGsHn0TYvvlj?=
 =?us-ascii?Q?HKayUccCeDt3+rYsCCdJN/n0mHE+8343N60y5bKI4VRi7kTqTrlPBxPqeA9H?=
 =?us-ascii?Q?SFMV4PeIxX3GOas8XtROxtKvngTdMr8aLt4zCtVY4nP4tKLB8dn2VMKizIxC?=
 =?us-ascii?Q?I4i9eSUJjBFt2Qluxvc1B7n/1+HlVKXGZRrXA3bZO5ck8+MqXp5z70OS9J/N?=
 =?us-ascii?Q?XZCpieWCDgsddh4dPyUq4s4SHs1+KfPCnuuVvPqa4+7g8YecsQILYrl1c/MY?=
 =?us-ascii?Q?KmlszeQFRrZlpXrhZeGcqFcVen2bJEff/HdqjgVa/mZOS8abGKz8osXYU28x?=
 =?us-ascii?Q?yOkm8LnNdARcxK/uXPEW/bmIdGHpn/lkL3CZ0w1eIDu7wCkBt0eL0Zd8KSkm?=
 =?us-ascii?Q?xnKFHmeM1mM16Nb5MTri8g0fjUMP6AZ0G+2V11qwCc10WtUz0tXEfPuAJBk6?=
 =?us-ascii?Q?2HuYXWtQDLEzue1vbUlnRR1ihcaPGVAon1vsQiLTzF7QjQdnqhlOAgkNoNle?=
 =?us-ascii?Q?b0ldr09D7oGo0TC29xS8umI97q9ppsl37ApJDh6FEGyyBAOI+1ppP2n3jLqX?=
 =?us-ascii?Q?vkbPa9OVVnXpRpFdVn7HRP8B2tGKMw+S5xX2VRldFnBSYz9x+RF3dMrzO75G?=
 =?us-ascii?Q?2Bt4pK4CxPqvm7a5RFq/f0FPpKglBFIwV0qE11FlOgqJP/xeqFd5cInsNhVU?=
 =?us-ascii?Q?j7OO2feJvlDw8z7yq8QOVYn1HrPbtGvwguOx+15C/wX9RV7tpeXkjh8R+THE?=
 =?us-ascii?Q?JoMEc1x9zhnEb+5RaV1bDKh+RYpZrB/LzxY0KIWyzX+osAyjgDBbpv+XGMj9?=
 =?us-ascii?Q?/ueJ6vBUqHuorvIabJgPEmF6qDxEmlLwpYOEZYcGu8hVDTXCV0rlb9LVWIwm?=
 =?us-ascii?Q?MHCU9O/+VB2kdTlrkFyAtWwEwFdklq7qphgZRt19SgeYpFqvs6wduA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mwImfN2d+584kJyr6UDi4JySMBjpJerEbcPglOqi/ebYgKxDal8UHj20vO96?=
 =?us-ascii?Q?0fdMEy9VzclN8cQxm0hDyinrXd0JXyh1qhzWkOyOhiH8UwKjETj0o3idSu1p?=
 =?us-ascii?Q?QjGKEtoXgSVfg/vMDVYmIHmofvAhRFjw/pjxRC16v18owya8hhWPg323zrg7?=
 =?us-ascii?Q?NIE4K+KbM6VZmlzSiksCwN38y1/3/cqZ9dHQNTkJASOD0Zw0e9+6n4N9jkVg?=
 =?us-ascii?Q?+T2MT+cOuXZl6YvIelJLHrtpVWpntgKbeXAdkdqrjFD5QoA8e/F9zHgd6SYL?=
 =?us-ascii?Q?U+Mu4T+zEInb98yIIHCJ15MkPksYdZWqrdeACvz/tv6eHXcEBaOV54JWjEMq?=
 =?us-ascii?Q?D7GRwl7CJs6XiWb2cfazHYlCIfw3HyClu7L1Xc3MHqO7Mh5u7vvw8T+NnJbx?=
 =?us-ascii?Q?8WihevsXl+sk5aT6zsel1uFppClMn/hR+6dqK4iLhBB1TvAYPQogtbaHrubV?=
 =?us-ascii?Q?8e1O76i9/ntWuIXtbpnbl2k8Csu96GH1rCHEEJXuhJGjnzVujgGlBeyBUT+q?=
 =?us-ascii?Q?mwre2na0O2vIZ4ThO16AnjSrQtOX+Uy+EDszhcpIvuuymWQ4JvAd9xYZ/aPG?=
 =?us-ascii?Q?d30FA/i5zFRkTrw01inW6GR+sKWNdzS3MOTIrB2Xr2MVZz6vB7wIttUveGgK?=
 =?us-ascii?Q?dDPpY4WiAx2gySg8NhlydRPiE4qHANI6c/yqvjkVJIThGhEvRBkrltQ1/2B0?=
 =?us-ascii?Q?dBFaTWvFU3nGvD55ERmE+BioHXeIKOdQMeEJucSBf4DNxrRL+9PFTbY13xA7?=
 =?us-ascii?Q?fnBr5+S7FfVjKmU5rDquMEXooOUEQRsMY2NLhz4EbDPm8aETuYzP5q2iO+Ms?=
 =?us-ascii?Q?/215S0uOLZij7ecg5EDEMYKHRCqQT/7LrGfzI1GTH9U2fOWpUgwa0G7rsGUx?=
 =?us-ascii?Q?kEXcGCky8LJTFiC60z1lAcgryETMTi9ajciGy7TOUwN+dRsdDuFVLZkrhK5W?=
 =?us-ascii?Q?P4khQ4aNOmH8bRfMp21OwmEpYZSExsqM6zqBYaHgX48cZja+M1uX9tu76rJr?=
 =?us-ascii?Q?SPgG/WnLHu0soIRwWasfVeg4vA+qhzkWtrUkYLae25o64t9js2Z6OADuPEjL?=
 =?us-ascii?Q?QMJ9H9iiadzUukfkHpDJDmiGQzLgwxiWUXVF7N11c8Nrl8IGI6w3av98eu/M?=
 =?us-ascii?Q?gHTfxpgyxFFG9LgmdFcAVAEt4ZFCpPiB5ZBZjt7TUsdJHAvcU6A+vcr46Bew?=
 =?us-ascii?Q?vsdDCeL0Zim43ArJV9YLGbm/pfT4Z4+/JYfH2xhMISoFhrRf16YCImxlj9nE?=
 =?us-ascii?Q?puok123zxlMRa1NSf8y2QdhqkrhaCKbg5JXOdq6q85NnEcxL7Z58qpZ6Fvpq?=
 =?us-ascii?Q?zvmToLmJmDSO5K0L0PQBJqB6WNwHagikUs7mLzZ2iNxeiJJ3d89hK/f3W5zw?=
 =?us-ascii?Q?CDNIbZnLTzOzMa1y/KOx/Qr4Nat/KTFQ0PaILN+9bID9JOrJoH+zFhYiL56o?=
 =?us-ascii?Q?nxWKcfxhRpW2uqvDwmkZ6ybUZikMiSLgngEBoRPmXpUFdBkkrTdBwrZMCBtb?=
 =?us-ascii?Q?hr9RkwAMSF0WVI0e+hJZ4pqsetHbZVbZAPdJyRB4NOTwA+XPaThLnkSgkR5c?=
 =?us-ascii?Q?yvYFNqg0twhoFItwgrqutiR74twQ3w6tXR7ndtfM2Ud3YU9PEe+EwGqWkU4n?=
 =?us-ascii?Q?pcSFA8YvA6UN1BJUDujzECA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ba98d1-726c-4c6d-c823-08ddb6afe99d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 01:54:41.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYmWoAg/6D1fhsK8R+SpkA3Usn9ga8SmhjWWQzHBXth1Cd3F24bZRGE/fcYi3eocuGkk6u0lYiYs6qSVO4Oh6fwyqRm+LkPueF70MW1LmSi9o7m8qL8Lkwjw+FzDHJ5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6552


On Fri, 27 Jun 2025, Robin Murphy wrote:
> Arnd reports that Clang's aggressive inlining of arm_cmn_discover() can
> lead to stack frame size warnings, and while we could simply prevent
> such inlining to hide the issue, it seems more productive to actually
> heed the warning and do something about the overall stack footprint.
> The xp_region array is already rather large, and CMN_MAX_XPS might only
> grow larger in future, however it only serves as a convenience to save
> repeating the first level's worth of register reads in the second pass
> of discovery. There's no performance concern here, and it only takes a
> small tweak to the flow to re-extract the offsets instead of stashing
> them, so let's just do that and save several hundred bytes of stack.
>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


Sounds reasonable, the patch looks good to me, and no changes in the map 
file, just as expected. Thus,

 	Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm-cmn.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 031d45d0fe3d..02ffc8d09328 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2245,12 +2245,11 @@ static enum cmn_node_type arm_cmn_subtype(enum cmn_node_type type)
>
> static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> {
> -	void __iomem *cfg_region;
> +	void __iomem *cfg_region, __iomem *xp_region;
> 	struct arm_cmn_node cfg, *dn;
> 	struct arm_cmn_dtm *dtm;
> 	enum cmn_part part;
> 	u16 child_count, child_poff;
> -	u32 xp_offset[CMN_MAX_XPS];
> 	u64 reg;
> 	int i, j;
> 	size_t sz;
> @@ -2302,11 +2301,12 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	cmn->num_dns = cmn->num_xps;
>
> 	/* Pass 1: visit the XPs, enumerate their children */
> +	cfg_region += child_poff;
> 	for (i = 0; i < cmn->num_xps; i++) {
> -		reg = readq_relaxed(cfg_region + child_poff + i * 8);
> -		xp_offset[i] = reg & CMN_CHILD_NODE_ADDR;
> +		reg = readq_relaxed(cfg_region + i * 8);
> +		xp_region = cmn->base + (reg & CMN_CHILD_NODE_ADDR);
>
> -		reg = readq_relaxed(cmn->base + xp_offset[i] + CMN_CHILD_INFO);
> +		reg = readq_relaxed(xp_region + CMN_CHILD_INFO);
> 		cmn->num_dns += FIELD_GET(CMN_CI_CHILD_COUNT, reg);
> 	}
>
> @@ -2332,11 +2332,12 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 	cmn->dns = dn;
> 	cmn->dtms = dtm;
> 	for (i = 0; i < cmn->num_xps; i++) {
> -		void __iomem *xp_region = cmn->base + xp_offset[i];
> 		struct arm_cmn_node *xp = dn++;
> 		unsigned int xp_ports = 0;
>
> -		arm_cmn_init_node_info(cmn, xp_offset[i], xp);
> +		reg = readq_relaxed(cfg_region + i * 8);
> +		xp_region = cmn->base + (reg & CMN_CHILD_NODE_ADDR);
> +		arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, xp);
> 		/*
> 		 * Thanks to the order in which XP logical IDs seem to be
> 		 * assigned, we can handily infer the mesh X dimension by
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
