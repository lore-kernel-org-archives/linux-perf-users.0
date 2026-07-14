Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F053DB322;
	Tue, 14 Jul 2026 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011239; cv=fail; b=LzQt3XIFAKxErDTtMCfQXhxSA5lPLhx8iQtrf7ZVChx1l/EvZ7C90D6wKiYKZr+9YoqbNCm3it2behgumEdISLR8BpEQP6N0ZX/8lng184mV2mtHaj+HWSR7mg/tlvnxvzyzy2KnkSZC0MCguWYKUkUetLiMPSKZ6C+j9GW+n1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011239; c=relaxed/simple;
	bh=j0wk6ZOVvNqtF4qQb5F5PCjLbS6bhaErR/Fclx+GQnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4wNbTI+R31Mj7eaxSkZ0n0GLHmygpVDh3rlnxmUQxI2AywB8IFEHrf3AzLtbLvxKlcB5d549jzGT6Nk3owWFP9IKAZs+wC9u7FvRoKegBxHXCjwRd5YZU+HAeSyPF6uJgN8NePKwpI5IFX1WvkRt6srgh3Caq0Juwh9VEnuq/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nOUs7Bqe; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nOUs7Bqe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yriR5nPqX6Tw0nJu00EoOUzCq5y0J89gh3d7GjltLKM3Wq1LKMx9UpJKazsisFP3NDXM6RkMJhHFGdqS7UKd+7gxstzAl9AgSS3Z/3Bya3/dMCq5o/zMn1phSZGaVq02/onA5tRCy+rvhknouXop6T5yX8J1srkcliD7QPZnqjTcHffep7L6vcWldIQhpvP3UqTkj9JQ1msVISYAXgtLAHWKP+Vo7EcXth7Vo6GeM/xdSxKcTQjhS7L1kzKR4d05v+pQhhDam8t7NmTu0SZ8+NBkoQyc2dX+wp8tHGZ8Lne15VkniIFWGaaj27S9lSeAYo8rqAuBTN7JJuJjNr0/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynuKBkSnL+meVqZdsuTJ1K9p4RtTWp3lvtXUwdFNnsg=;
 b=tBhNl+gwZH9y8NqXkoXm/hUFZ11HtIbJ4QDOk9BbAmjDXrj6gcs4l8QVFEqs+SYFKrTio1oUAkhnD3gvGe/+fK2QiDCFz1N1Hj4IJ0ZxqpMBjiCpxe0n+jGYq4z9kUdXCFfp1nVN2OdOhqs8b+BCmYBP34IroQx81r6VB19CxukF6gaV4C2C3lJVS7fn8fZR77jdzU79u5GQkDwLVs+PojVZvgJ9Q/35wgh7v0osttLAyqnxA4uvxA0hfdHCVsN51CrSp7bNmeT2tPRht9g3LRikAkkFLT+LKo1X921d8w+k8EfjIBOPdWCPP01IngTdeDLNrMpbaiuS1kRni5CHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynuKBkSnL+meVqZdsuTJ1K9p4RtTWp3lvtXUwdFNnsg=;
 b=nOUs7BqeNYYs3IBmxIDzTtwBKQz694Z1qdcoCV7vCwgNxVP2felrc8xj8tXmzvcQvUp7EiYK6/n4UlB5yE5DsuV92kOrojkH3mdNAX4x63fTXWQkMeQROsF0JtG1KXWJfAOEORS2wJEDtkIJ5T0NPXRZOwq2dzcWtqLW5C1bOcsnS1U8EpHkInvZZG4gwOU870QuNAOwdBAyyf2+gbkwyGg5kUIurzAYWWN1A5+vsOQpBB6UciMBB+wf2L4KyRoI9N+KJqpaI8YoWwd5iPrdSGmDxnXfbYvWtyWEQ0XHGga6htrPiHLYnOEmlqyMn6qPllylCDYPlY59sAE4ixebOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS5PPFF2923D4C1.namprd12.prod.outlook.com (2603:10b6:f:fc00::669) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 06:40:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 06:40:34 +0000
Date: Tue, 14 Jul 2026 14:40:29 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, 
	harshal.t@samsung.com, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf/cxlpmu: Fix 64-bit write to 32-bit HDM
 filter register
Message-ID: <alXZx8VlmC5RRofg@MWDK4CY14F>
References: <20260713061112.105419-1-dave@stgolabs.net>
 <20260713061112.105419-2-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713061112.105419-2-dave@stgolabs.net>
X-ClientProxiedBy: SI3PR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:4:297::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS5PPFF2923D4C1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebfa941-96cd-44d4-0f4a-08dee172ceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|4143699003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	3ZF2m1/M08nrYB3OP4Qpy4gjE4KGpg+pwggcl50/tkSZO4qUjNzu8Ucb0nGqjln7VGmXGbWm9vTc3J0871+l8ZZ3YYiDtBNKyV8m1uXqZgK40B1vw9/I7wdW8ac3onqwQEK9LuQ70Mibt8xieb/k0GDm8qJSPj/tBDPbo/lM4d3H90pizhoZ1IuL8dv9GLxJBO7tKNXrJwk4Xu2kZTgZ4ogGNwZRcFjZpbIvyFCj/RrILD8WbgoIaJMMwboEz8WhO5jQtD/KqJhNbK9kCZzBiuY+QtcuNoEVQsYHjRA781YXcjY4KwjvaTMpnGE5xuw8tdpD5XcttKzKYLrgLj0Qbw0fGY2Pk86QhYVEPuXB11AhuNuYGO2nOqZtsbGQEmXLDASpVotWyOw32Mec+nsvSPKnlwofB5Q5xqHm4xh6pqFFGBJVvivW1UQN0PcN1TveYh0h7aJ9F5h5Di2VMsnLf8JtYvtgGYtFRd7a17HC3oOgd+GnpTZNY4YNZ35+Dp8OInpM3nvAs5yL7uVlnszQdMnIGAtmggTnGqTkIttxH0bLdXSTSuguFHamuPNiojTHJNB0BAFZf7EMFsX/iJzDd/1FHmYqsuPMdn6k+tNaaN/yVd+MN06XGhdSyfTef4cWODj46C8W4EHJC/XhIEPIaZYO8S6+sl6fCZ7Bj2P/dC8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(4143699003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJcaaRko/4W4itfd1ZWK6CKP7iBBPNE+Xj0mqqDLUbhz1bqyNUibWGI8NBZr?=
 =?us-ascii?Q?2MQS2cFcMX1Tx5aJh3C1EyNHAqNRcfJBTGFLdzHeD80hcUKe54CIPzcZ8qgc?=
 =?us-ascii?Q?rKOYTfDE+VrPc3ZxnrPoL4OBwFvqEvt/VsUtDRxRI321bFVdrkzFKSVrCEP1?=
 =?us-ascii?Q?FhwegvRPkJ8JLzjiFOTVHBESS8YpGP3M4AF7hUYL0jjQZO24yeJT75gf10lH?=
 =?us-ascii?Q?MhOBhGCx9ytKTukWvxs5Oce7rW7fhf4pKuyrBgxRDwyMQvWjXHGWce4fPj5B?=
 =?us-ascii?Q?Mn9ELl5WjsQCqvQOvZlr06LgKKZoRDHjWtzqXO8wZKXInXikWYdX2V0WBwx3?=
 =?us-ascii?Q?7dYy0lS1wvIDgE2O4nsjnUAO+2BO7BPJx8BNVFdjZoUIqKlXy8xdGlhJq4E0?=
 =?us-ascii?Q?MF1xba9oHPu0LoCEBL2wTlImJVep/7bIKJxeKX57Wfp/Piyhrn8ZMPqGkc60?=
 =?us-ascii?Q?58WoVE0xmTrBk9Iog2WRVeJJQtRGxN7Hc89dcXA087ZDs5LwBWx7P1vkdKbB?=
 =?us-ascii?Q?g60jKOOVIvPuwLgJyfzaUoDZj5jaFyYqyF/dj3HSGirCjhg6A/hI34PwjPFq?=
 =?us-ascii?Q?lIDJrsMTL9Q3hlmkIWCt1ouRZR4rFrsmsKIYiGctemQ9Do926EXnVPwwqLwR?=
 =?us-ascii?Q?GVwnXJ6c2bsDnKziRygZgVniJ44E49gWdWyNPwAZQUVXVgoMR9vrtjGizgHz?=
 =?us-ascii?Q?uh7sDyBrIR6k4HSobBMc8QALt9xT0bj66gcbOStUk9TA/9qpd+bagFw0BRTL?=
 =?us-ascii?Q?f8tgqdTNsdrqdYsU2+FbwI85j1qkqNsJCNOn8peZqjerl2ncb2imB0dk0mHX?=
 =?us-ascii?Q?WIpKmfMgw1foa6b8KEvwIJEr1ScacGN71vCKCQFrxhiOdjN6huCYG8AlhXXt?=
 =?us-ascii?Q?xpqtzhe5Pe/kqUttDMFRu7cN9gSFVq19fGCEdVyHNbscsQ3yaUQ8d0JM3dVM?=
 =?us-ascii?Q?+vqpw34Ywll4Cz9WyVwiH50l7z41/9gFSHMDqRtwrMWQ8pBuQIo6mygghA++?=
 =?us-ascii?Q?fBOqU9ED5NpaJ6mSpHSjX9X4mwlogZM870JEsfVxJoyVlE7pmMznxqQIXl89?=
 =?us-ascii?Q?sGoetfXcrqofWQq3bVvm+qm2ICkH6SZS7KX3gvz/lFzWo2RxUyLumWGfq4Hq?=
 =?us-ascii?Q?RC5LCOtAg1G44JiAwG1H9QX6G7d7Pvd1Y48QmbAgLdAPOzjTzgua0JLQMahr?=
 =?us-ascii?Q?3j/w32tUI8eYWdEtS7dtR4E2090P0+qELOXRWxW5czapsIxm3H98uVDKuYjG?=
 =?us-ascii?Q?c+CyElojUEnHa7G4RAjdsXOp+UYAMY2LC3gxiJNdFNCxmRJ8IUgWm0LPfHiI?=
 =?us-ascii?Q?hwF2ZJI04lU86srMXrhCl6iKDbZa1auDiugB11IRC4Z1Pv06PyiQtOAg6toN?=
 =?us-ascii?Q?E+X594pgirh12ts1cH7eM0jlouyRVCVQcvES4YarTjjDs+dSSqmsLUzyFj3H?=
 =?us-ascii?Q?F7gnYtwcE38kwJ8o/ROqaMKnGO3OOdcMUcznrFxScfRnSo5X+Y6inHMzpa7p?=
 =?us-ascii?Q?0OoZJuLeMNOAah/xeMB6OZX66JFzWuNDgXZNOWXfObz1scygKiEClGIfTjK2?=
 =?us-ascii?Q?jP+j2PzWTJstvyoiiA0N16Wo3CW9K3P1ipgmk5zPx0lxYWmnNOVUTuFnZYPs?=
 =?us-ascii?Q?nnkb3Itce+Vzf53UDb2QXTxQ3+P/8+xDRhTmC/8npViBQYWkYy9k3G30/wwW?=
 =?us-ascii?Q?jwdp7jm8BIgdqHzrZAGsFAWVMi2klsj+4AyuPfgRVc1bW+wt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebfa941-96cd-44d4-0f4a-08dee172ceb2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 06:40:34.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AvDBmfgMLlqiufGP9/W/wbteshol15S/eI1pwoD/FxaU6yJIvK5hdeC31p02nPFVxslANMlcY5hWaAaYwefTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF2923D4C1

On Sun, Jul 12, 2026 at 11:11:10PM +0800, Davidlohr Bueso wrote:
> The HDM decoder filter configuration register is 32 bits wide, but the
> driver programs it with a 64-bit writeq(). The upper half of the write
> is always zero and lands in the adjacent Filter ID 1 (Channel/Rank/Bank)
> configuration register at offset+4.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 68a54d97d2a8..39b46550a510 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -635,7 +635,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>  			cfg = cxl_pmu_config2_get_hdm_decoder(event);
>  		else
>  			cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
> -		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
> +		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
>  	}
>  
>  	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
> -- 
> 2.39.5
>

Reviewed-by: Richard Cheng <icheng@nvidia.com> 
