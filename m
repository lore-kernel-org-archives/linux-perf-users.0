Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D53BFAE2;
	Thu, 16 Jul 2026 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236421; cv=fail; b=W7393tNlnMQdCuOr9//N7RLuga4cCUK41Us8BXksHNQrv3FMG+xCo4iOKE+TxjNm3TGNISSNGFXW0wn95dYIAdW+jy42CDkhGeQKYkaNU7FEdusLtY2b3ndVNrThBwMRY7mCxV+TmhRNbIeXBV3qPAmBL295Bb3Sw/B1mvbhiaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236421; c=relaxed/simple;
	bh=4nIqia5mhLQzBTmaWkQGmnw6E47e7GcI3IqX2FVtM/4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=c7UIcklHQqcb/DeiKVl/FAW6NZHdQnoJJoF1mrr3C0MVpJY7vLHfgOedVPtzlOEyC+Di9ykUnN4WOYz8/ZpeAoE852wGGfp8CfWn8MPjBi+2q+3x1nEo+247VLichwXx2+4meN7MD/PLdP3u4Oku5Iu1OyAeK6TNIZc9udmIVEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=k9251eDq; arc=fail smtp.client-ip=40.107.208.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="k9251eDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbGFyEqUIW3q5pWwwc68Qm1mHuPUX1EManeJ4Xavp16WMi4F1ZROWt3TrX9aZcd3fWi2FoJjjj7C7tWBzMTShcqQhggjVa3ANyPZJfFamMhj57xqJKh92GgnbJfF8OxQdAiVRs7v9Yf4HhSyjrcEw7CA7VowtBsye2/FLwuYGNIibSp0xKkiFy+TJwhovh7D9HXw94pPaA5rUWpf8KveIcTGZjOKhcm7J6EwoH6bFjaq0Od9tWqNV7K3kjzxVmAWHC1/5bGkIx2Uihh5IcaWGCES+cVMzWbrDMl0qg3gVVFcU/cVe4cUGCek9uZI9y0E6/fbmSzvftOwazEHk7aQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQhQndfAjCCW41vmT/buRxfVcInkS0CvR5/XJnbPAXc=;
 b=T3odd4UIauLQ1fwMnMfL3Fx2p5V+BbD7SvFPyFIu8QppMY1VuHVZ3KwyjnnHmprziusiBETtXjXMjwUUljwQFqpfiT+azSEWMZkBDKrqs01RO5lgfr88o1vKlwDsciX8btjXh/2Dm+BXTcVmEi7/ltAaKsyP/Bif9N4J9Ke+8rNectnyfNw+BYKHiThCK1SoC8YRCtZkm2339lAnK6jeKnU2OmFUH55ogHUHBWQWmWnAjF22rbjX5z+OGdSYg84dzymNSRnS4C6PE3VknN0IC+lxtli/UXFXnk8BDc95Q2B47HyW4bfJFzSzteZFw/v1Ho4S1MRclNyoXyNoIG+dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQhQndfAjCCW41vmT/buRxfVcInkS0CvR5/XJnbPAXc=;
 b=k9251eDqK6w9nGNkUW/YxefZ9cq3OyC+y3NHuwGo94o3dBMBZTMFSznQn3ozT/gHP1F2/uwUAotF7TCRcUMyoa0TY4is3lAQqYwNhhFvES/BtNHON75wTiOudvjm4K1RqTZnSpKQQ21SvIQOsIck2FoofHBI+Ioy87Ew3jNk3pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 DS3PR01MB994655.prod.exchangelabs.com (2603:10b6:8:38f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.14; Thu, 16 Jul 2026 21:13:35 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 21:13:34 +0000
Date: Thu, 16 Jul 2026 14:13:30 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, 
    ilkka@os.amperecomputing.com, bwicaksono@nvidia.com, 
    linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/4] perf/arm_cspmu: Improve APMT-based PMU naming
In-Reply-To: <8f260d150da4fd8acbe0a070033c9b9e045fced2.1784213435.git.robin.murphy@arm.com>
Message-ID: <8954907b-9ec0-8a58-8cff-c7c3fc1f6aa6@os.amperecomputing.com>
References: <cover.1784213435.git.robin.murphy@arm.com> <8f260d150da4fd8acbe0a070033c9b9e045fced2.1784213435.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|DS3PR01MB994655:EE_
X-MS-Office365-Filtering-Correlation-Id: b39b5da0-17c6-4644-dd47-08dee37f1881
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|55112099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	YeI23aHpgSh6FYjS0JIOgcmakKZBsPzbdvTQp9sdusFQrBbXWFI3JlvtP77kjxUvFltcjkF0+TiaqfM5B0Z4tIEddw+oCTrxqwbdNeXg69PfLtHwbVuWasj5nTbWD/kh51YvptJhWWICbZuo4irabSBrM+vNwF1sAW3MoTjGH5WM4ng64xk/3QgliMtOc2A6odiN6HGr9M0pEamu7apHEWOstUqu3SNH3k1ozuN6uxB2TVXrdTaz/TX2i8HEY4XHirtj+PQXQ5p0ldoaPPUzGA5dIZxRLDyLGAl/lOAyEGWbSXMf0VVNwmBk0cnNLj/5dzuNso9h1vYSliWW4u5uvyOHnBlvqo/4h1zC56nTJIuDikEwhJuJ1uOL2fduGD4bUK7xq3tgZK0jVF/kIdpczWpH9CTqYNN/C5Uegh20ZYzKvknPBslEH7vysQdjFlAh+plCk9ABQCNNQ2+BOueoPnugOy9zuuyxXGQRLk5rp48/CfDA1Ez8J83qsO1HZAUzOaCZDubxnoSYhcFxicMPF6DKoPikJvXq6NpqKJyS1bwZV0otOs0cvHazEN2/PZjg84QdQiYj0pDXBuLVbFyhKaPbVV0TaVjony5umdUUTVHvnTNgEb8dSU/sW4kP0P9R2RsnGZhwDXF7HaDVQxZORTqAYkIBLL/clRo2IayNr2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(55112099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cQ5q/qQkSoYrjBmP8eFRLm4fMi4xBrvEYBApwrWZ816w7/heU8uDbE7RBWwM?=
 =?us-ascii?Q?uftHt7/rilfXGWQlj+tkWteUCgWR+BFdYTZquoFJWim4y+MM0wnVBw8rlkf+?=
 =?us-ascii?Q?AwmByWaKzhj9k1NT+9zzxvbFiwjDfzij0UJukOO8fvjd3d5/x22M7vGngjAa?=
 =?us-ascii?Q?9IGfLMhtvKgwc82DjJcQc+PfF8vpL0ZoaoL9VkbRgGz8gL7jHXQHpKXmj12+?=
 =?us-ascii?Q?uz1kzSM++daC6NQW4siBwWk22DQicd07387jzSxbCZeN9QIGOg7w8aO73Sik?=
 =?us-ascii?Q?XV4pYGrPheiBkAon/o4r0GRt8urDdcgmwXld3k6+elFbVrdfzVbpBYRyOiKu?=
 =?us-ascii?Q?J0OzyWmo/E9lnLGikz+KXP8gXIVhkF87m3QsIm16PJa4v5p0j0ZCJusVAdcH?=
 =?us-ascii?Q?ijZ8Lv+dseMubewQ/p9BR8X98sbwWARC3UWRBtiBlNa78m3gRhsGZKWXWtsG?=
 =?us-ascii?Q?pt3n4EbHkF0GrNbqlx+vxzEthr6M/g4lxcZvgjwJhX9Wdo7eF6AHS/8RFXBu?=
 =?us-ascii?Q?QuLwiC0Op+nFLe/u/3CXO3DSklnlbfyug9u480KPR/dHUyNhWC10o/dsRvT0?=
 =?us-ascii?Q?ecTl8LJs8m97aiLcZbBtcFPFghrNwQ3kZX5opapgGysJh8oMCY+JeOA0vaVk?=
 =?us-ascii?Q?RRNjRMR/mI0m+bIL36xCL2pb1jQ8kC2RalXoJjqf7p0CHf0iSAy4JtpQBkeO?=
 =?us-ascii?Q?x91GJkd5D7TwN9OkX+38pCCaSlYpkhJuSPfR7OB8VKZbVCWMMCDYrJzsHygJ?=
 =?us-ascii?Q?NcFPeOGCx68/WREo1j9tsGDkHRfkL1rw1M+uVjt9tWz+f+nkiGX8+YuUD5Rd?=
 =?us-ascii?Q?YU/rtiMfpTvAfizx+Ebqn1WVqLGkcBC0WtZFeekROS0cMXesMKqjMxciL7mT?=
 =?us-ascii?Q?2FjnKGWi5E51OeIgcjymisH6d+VDRMCvczkfMzBTLVv+PB83QHBfjX5mpkHx?=
 =?us-ascii?Q?QaKEZGHLiTGT+wGnnCdhHY9tNawnPmwNFhn2co6j2oQn5GLEp46z8Odf5NFO?=
 =?us-ascii?Q?tLk8MR76tTBTd4LjEBb30uYrFKwoMVOWmFcN79cunQXr3fbo1GIjuoQA+Wca?=
 =?us-ascii?Q?RmLJ37+c3roG1zJqj2kmb1ul2qM9QJWUqEL7weFGGESrp8WSRShqlB79EFtA?=
 =?us-ascii?Q?YrbonDlfgNmEJsl+H9ijffNnnU+py3tj9CLfiAWmujVsPliQqGCSyZeA7wzf?=
 =?us-ascii?Q?IwSmt/I+Gm4BaLHJ8pMWWL8LMxUhARr5n6jIztAgFziSbqm6Lf5MbzZMqjXY?=
 =?us-ascii?Q?t2CAk8YmaVkAxUVNQBlNnG4CbpRfGxpUezLCi22i55yEhhTSJfsptxEMpFRo?=
 =?us-ascii?Q?JlCdvJBYJS5TtqW38+kxGlTDU0mJjp9y7r4Txhy2iGtmGqg8cN04mV9nmt4d?=
 =?us-ascii?Q?t+m95DvJvzljRsK/8uAN9DEYnhABPdZew1ZFI/nzjoyPVq+tYQvYM/zStZhW?=
 =?us-ascii?Q?3K81/MFT67qDq18L9Wa1FCioDkkumg8tzutBal4hfLPfK3ML0iCsm4awATO9?=
 =?us-ascii?Q?QylLr863Qbjm1o8J6KcA5CwQPhA22Szg1M6oEPzHLxNvk15MGCWl3cn+jkob?=
 =?us-ascii?Q?QpkgDwsZa4y4mvOrxAClwQxz+NaPGr5TX3qwdi9tHJSNkVs+F3dDaZ4xbzN+?=
 =?us-ascii?Q?P8tZKylHhsi1rCXFfh3SaprzmxdMuytTEXMMyJPvb8siqKZlgr8K9+t3ccCf?=
 =?us-ascii?Q?ARxCx4VJdeLqT3TXaV2z+9TZXADwfaTDIwDlRU2xrDCVodonC+3CKjcNGnYn?=
 =?us-ascii?Q?xJ2HizudMIi1rdFBXQrwGtygMkDAxrA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39b5da0-17c6-4644-dd47-08dee37f1881
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:13:34.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39/Y6/pR00b0YJ6rdBmZKAoYWor/vkroJm/0ZPYsuGMqqdSF4pTS+0jhRpvB/ZIeAdEiPHgzVr/edRc6HfhEPvzOnSBoAyV/U2TiPqGXgU0AXEUQwJ4h3PB49XEtbCoy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR01MB994655



On Thu, 16 Jul 2026, Robin Murphy wrote:
> On ACPI systems, it has not actually been possible for userspace to
> reliably tell which PMU corresponds to which APMT entry for types
> other than "ACPI device" - the evidence trail only leads from the
> arbitrarily-numbered PMU device to its arbitrarily-numbered parent
> platform device that has no distinguishing features either.
>
> While we've now improved the platform device creation to associate the
> actual APMT unique ID, we may as well also tweak the PMU devices to
> substitute the arbitrary number with a different arbitrary number that
> might be more directly meaningful based on the APMT definitions.
>
> We don't have an equivalent for Devicetree, but in that case the
> platform devices are at least identifiable via their sysfs-visible
> of_node.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
> ---
> v2: Actually use the instance-based ID where different from node->id


Looks good to me now,

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 35 +++++++++++++++++-------------
> 1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 80fb314d5135..8c2dda17d73e 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -250,38 +250,43 @@ static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
> 	struct device *dev;
> 	struct acpi_apmt_node *apmt_node;
> 	u8 pmu_type;
> -	char *name;
> 	char acpi_hid_string[ACPI_ID_LEN] = { 0 };
> -	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
> +	static atomic_t pmu_idx;
> +	u32 id;
>
> 	dev = cspmu->dev;
> 	apmt_node = arm_cspmu_apmt_node(dev);
> 	if (!apmt_node)
> 		return devm_kasprintf(dev, GFP_KERNEL, PMUNAME "_%u",
> -				      atomic_fetch_inc(&pmu_idx[0]));
> +				      atomic_fetch_inc(&pmu_idx));
>
> 	pmu_type = apmt_node->type;
> -
> -	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
> +	switch (pmu_type) {
> +	default:
> 		dev_err(dev, "unsupported PMU type-%u\n", pmu_type);
> 		return NULL;
> -	}
> -
> -	if (pmu_type == ACPI_APMT_NODE_TYPE_ACPI) {
> +	case ACPI_APMT_NODE_TYPE_ACPI:
> 		memcpy(acpi_hid_string,
> 			&apmt_node->inst_primary,
> 			sizeof(apmt_node->inst_primary));
> -		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
> +		return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%s_%u", PMUNAME,
> 				      arm_cspmu_type_str[pmu_type],
> 				      acpi_hid_string,
> 				      apmt_node->inst_secondary);
> -	} else {
> -		name = devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%d", PMUNAME,
> -				      arm_cspmu_type_str[pmu_type],
> -				      atomic_fetch_inc(&pmu_idx[pmu_type]));
> -	}
> +	case ACPI_APMT_NODE_TYPE_MC:
> +		id = apmt_node->id;
> +		break;
> +	case ACPI_APMT_NODE_TYPE_SMMU:
> +	case ACPI_APMT_NODE_TYPE_PCIE_ROOT:
> +		id = apmt_node->inst_primary;
> +		break;
> +	case ACPI_APMT_NODE_TYPE_CACHE:
> +		id = apmt_node->inst_secondary;
> +		break;
> +	};
>
> -	return name;
> +	return devm_kasprintf(dev, GFP_KERNEL, "%s_%s_%u", PMUNAME,
> +			      arm_cspmu_type_str[pmu_type], id);
> }
>
> static ssize_t arm_cspmu_cpumask_show(struct device *dev,
> -- 
> 2.54.0.dirty
>
>
