Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021105.outbound.protection.outlook.com [52.101.57.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28A3EBF23;
	Thu, 23 Jul 2026 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784846328; cv=fail; b=gsOCDDCnTB+/cMyWlSbozLBIRZObtO68RvElSZx4QcNDd1WZQxwoipUiDV85hOa3X9xS4wTBW24u+lDuXCccjn4EgPMHe83FMS81YFYkf4zmX8N1hJ+vKN+a1I8Ys+YnImt6vLcjRzhnX0d9S6o1j1VusbDgV+rpn/fujqjQ/14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784846328; c=relaxed/simple;
	bh=OPYHI7sz3f98/JpqCMwf9vHWELnwJDARNmwIzwIwuxg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=Hx9AdmzlSUThM/UY6wOTSrzLqt0DqqFj41LN02lmfi3QbYEvidmE4qLGdcKIVlGRdQl6wThNxFBwsekIxCfi7yBO35Ns8HVomn2IsoFgqgtbplSDd9mvbp6RRfwdeUM9G0p0btJpdA5G9X+D553VxsfHD2UP1eJr1PKVUGpU5qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IHofsjOt; arc=fail smtp.client-ip=52.101.57.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IHofsjOt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osH/uUmWnDeDo81H8AQnLtC0x/6T1uQUKQEfb2nAdUdebYZlLIME4otvYaluU6NuVm63ksaQ2TeWbYqRA7rSuBF2zD4/Iqzch0FxLL6/D0NkcUAIKWAnlrUWkFAyIjKHvKAqIaWdds4pRVW40tubGQ2v9TawcuU5cgyfBHWdc/Y5Gj8l4b9Cbh09v9u042/RiDOIIkSdjZN+nJ2vuir8GKGn9/eOH6p9wOnZ0zg6P9dm07jzm3uolN3EXOlBJanXUB5w+L6TMjb7F906tv7eD6x+ky4UyGl9b5HxzHhTO9jBIY8ZVShE0jEnqDdn2F+RZeg8fH7a9fMs7q9wEQAaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKnKo+vX1+r7hnSa5pH+sQFU1em7L7ecM3TiNNqUjPw=;
 b=BAgaOiHTgFzOv3SbkJazx/ext6uorsYDNJUj27jHGjEXp+q4jN4TzeCnX2jGTie9rMzqPT3J2hQtXQYQ2ZBaOS742BYqH+NSDpTUc/cHkcMLDrs5zOL8FQ0LWgLl8FQJieswOif57/tDEFafJfzxgOxOOlfUC3O0HBN6z2N+7Wezt6IlVQXK1Vq+Pq2LWw8Mg0KQ8qAiYHVwdBNNtx9vJuicHR8UoCsrJMwLZQTJg+LlaHdSKfmWRjC642T3Ug/r31xaOGhU1DVhUR4CIQ8YrzhBMzkJ2dWHnVC9yUFt9I1+P6k4+9ActEPSRmbJG8y+UjI6GmCjN2NA8HtP6+eU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKnKo+vX1+r7hnSa5pH+sQFU1em7L7ecM3TiNNqUjPw=;
 b=IHofsjOtLDdkX9gHoGXn//0J7wf4FHCFrwcXYdOjY3YbaxlwAeeLMB/XgT+WRof1eLx3X9pkxsaHgZFoBrgrv7hm+UsFi4n6d2qMrUGHvyouXyFjbcvYZH29dLSOF/SrQL2BedJg0gXGmwEhgDhv75O4uXBQMLdQaRbNezBTx5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5615.prod.exchangelabs.com (2603:10b6:208:11c::29) by
 PH0PR01MB6454.prod.exchangelabs.com (2603:10b6:510:1b::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.11; Thu, 23 Jul 2026 22:38:41 +0000
Received: from MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e]) by MN2PR01MB5615.prod.exchangelabs.com
 ([fe80::996f:e4f2:dbd8:120e%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 22:38:41 +0000
Date: Thu, 23 Jul 2026 15:38:36 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Pan Chuang <panchuang@vivo.com>
cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Besar Wicaksono <bwicaksono@nvidia.com>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
    Yury Norov <ynorov@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, 
    "moderated list:ARM PMU PROFILING AND DEBUGGING" <linux-arm-kernel@lists.infradead.org>, 
    "open list:ARM PMU PROFILING AND DEBUGGING" <linux-perf-users@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] perf: arm_cspmu: Remove redundant dev_err()
In-Reply-To: <20260717103123.34887-3-panchuang@vivo.com>
Message-ID: <d7591f47-8b34-4648-2af7-b1c339ff6f4b@os.amperecomputing.com>
References: <20260717103123.34887-1-panchuang@vivo.com> <20260717103123.34887-3-panchuang@vivo.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:303:b8::21) To MN2PR01MB5615.prod.exchangelabs.com
 (2603:10b6:208:11c::29)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5615:EE_|PH0PR01MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 772dae94-d5f7-4eee-d0f8-08dee90b2512
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7zhUOUpaf2tR8Pjwe0kRQuvhgO0bfbQ7wacoonaQhrtE7fJZa3JwMu+i+GodQqxNjHeJlPD0Qq51CP1BJglQ94JjXxyieCOsltNmTgJlCHHHzR84GSmrcoT7rB6PorDZ505pbs84gFnaOqxvlab1W8P9Q0czl7NNmj3wUocCTaiKfgcqektuCJBzKsyVB1cyl+hM9e872nsS0wVA2FOmleNsMOUGJCfR4DXKsLNDDJMoyg7uec7iiOGg78f9aGIpUJQQQP5kS9YA2pMq++gDkrNPckj9NBrSaHI6OXPHx3a849YW/bfMObm3mq46uKuPfzoiI/4wCO4i1QLBHRlGp+oNxUB1fS1Wjnso/p8L3pSgMD3tu38zw2MZ5ASkTPvvTj5WeOA/xCoofEJhQyHPvG3BtfvZQNxrD7kPXIlU/Xka9xM+Hu7OiHkyOHEo8HjGLnfdGgebJZV3KiISp62NHkGAmYWq/hRINCP+osQhwZtJFvqD3h3jKVz314GGRvHHDnEUI0y6yjzlQoU2utdpqdPbA3tAUt/b+rvlRgCT51ewekih14PlNzGyJh38E27EdpRc74i+aY/xf7JqT7ZEsOLJf3bEUGGXUbfQcVs4H0HMa/gYpgK3QX2h31cZGMnTomB1Wc1aVBF0/kVvw1EipMr5Eht8YFsrm6JFtlDiV88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5615.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQdKLCIUd8l6sAW5pnwJ92lcv8OBd3iYLBF2qOJDyfEd4YZuILk9C46yOeFm?=
 =?us-ascii?Q?pNUJ/Emz4S+L6jna88YsjRX747i9qS+3Rw+WrQ18+zqCgznWxqOp1s8LA2pS?=
 =?us-ascii?Q?8/6I4CY7Yujo6K/9Ui8I19hpc8AcK5E7hpZz/RfRSnykKwKz/5LMlyegjMkZ?=
 =?us-ascii?Q?VNek4A71kKIR5V8Rg4TlpWYS2o6gId3PS13LAae+t++zyU9rLbDT4vWnEQv0?=
 =?us-ascii?Q?BKmy34Nud2jm4Gkz4Umge9FqiqC9udvF9JfbH/ey9PKev643yTC3RdPdNOOi?=
 =?us-ascii?Q?6ohW73s2GpPtI00DYpJ9MW0Hn5W2WRvqk8ena+6mp5cxdTeh5LGBZ0YJqd3e?=
 =?us-ascii?Q?jlmTXY70QNYLycTBSyp9NcYyfpi0Nz5c+n0xydnDpD+fMUkha1Ov12veE460?=
 =?us-ascii?Q?rBSWwRE2Lr0p46bckTletiimnRkdTQjyCfNTHxVBAwvCCAj53x6Dupl0wANu?=
 =?us-ascii?Q?EgDnOXMuiyUYgKRHklyC5SAKYCETf3uHB9JaeZL7jJjm9lrE+GEhRhZHsdGT?=
 =?us-ascii?Q?UfyzILBSE/0trU77yEuSeRizsz8IT3sDBdt2/OzDRATXPQOZ1AVkjtwFL9+f?=
 =?us-ascii?Q?tVcMqiTUYFxwdgCfxbtkPJgvfdQc/3DrNFJVzghnEy4x8gE5jCZ4d6lw8im5?=
 =?us-ascii?Q?5CsIr4RPrssWkSpPmz6avWHR61/emvRKDBzjdRLMk1n6t3OsbsErw8bfUoJc?=
 =?us-ascii?Q?zInwsmeQaAs8B81spk2hkXqqIKMUVECyPzzN/W0XvJAw/xi6G52MmaWA4KWl?=
 =?us-ascii?Q?+y1V3pZp89SnFBKi2Q8hN1eIg3ITwgfAKmUfUaVGWP/ygp7v7kT9UTZygNUA?=
 =?us-ascii?Q?aM/Say9YO4VSltj/+mqvJQV0Yb+p1UWhVMElTkYeFO1DwTJTjLocf73BepVT?=
 =?us-ascii?Q?dt0VytFeIzm0VJWIOOrfmxtX8OxwBxp1f9ovpTc932SPoFFbULVlSRLMopbh?=
 =?us-ascii?Q?FDVmbFemqsWJi/fpI8PZ9zCSVb4iBPT0qgMj1XTl65Ry8cbZCWU/85tkkzRC?=
 =?us-ascii?Q?c+/Tc3RVCyrAgTnm8z6FqckKyEE62zgaVOOTEeHD2nwpjna/BG+5Fb+HzRSt?=
 =?us-ascii?Q?y+90mRRxTjxJNet19qff10NQr6gsCJNZEQ61MZJP7J3A8Rsbgbet49d0X2is?=
 =?us-ascii?Q?XK0Ez87416DlsKIJjrAXYzOS5GCmx/5qL65eZxioN7wBoUI4jaGW5B99YFJ6?=
 =?us-ascii?Q?d6zHCzIaCgYO3LQ1Tpk2jOsifBnvT+MLs8VLFwhjU/i3yeD6W33tZbXOYS0Q?=
 =?us-ascii?Q?nhPtudPAd9oQS/Rri16azRjf61VnvqvDKeBu6/++kzHFSJOb3nKw0aF3aDlk?=
 =?us-ascii?Q?oQLXJoWdtYvu1rLO2zJn6KgNG7xWmhDYeEukNEhkC0FBe54k7mL4VOjOllGM?=
 =?us-ascii?Q?of/XEelXyJKmUSM4UIYYUQaKl+FF12FiEFDM5QctQ8jw1GZ3piHuq6k3O2Bz?=
 =?us-ascii?Q?tt9PjSfXKe9nkel5UyKCZW9kq0kOOoNszdGv7wKJze3gZ0oWgmtEl0oLwiKq?=
 =?us-ascii?Q?7UOoYTSg6CODVx0p9JomLLZNqYP+Trt5gIhub/ROWLT0dhr9Z2UtzcxuAL/H?=
 =?us-ascii?Q?TBmrRgOPWpifpGjSsGHRsab/PfeSyVgxzKdL8Gy1HM/I8eR36zYOnkVIeLG8?=
 =?us-ascii?Q?fkQl78+77HBpI5WpbYROTkr7GTFaYOJB0c7xVA/2wsMa4G9zxeF3z+bTNeHT?=
 =?us-ascii?Q?d9hWA/kiXoNg42j3LMYYYICYqtF7uu88QgIl4X8ajPVWOUOcoDdPx2s+PVoc?=
 =?us-ascii?Q?dGH3aAKRbV16a8GitaNkEQCF2siW4Bs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772dae94-d5f7-4eee-d0f8-08dee90b2512
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5615.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 22:38:41.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BRWdGqmcEflM6CRsjlm1av/b8ZRZy7aCh2bE2ELVBJsmnbOoTahrStJ1jm7EWwhXv0wQAiIdmB3+WUWy8ZG8soy0jtf8WIKT+h9f54ArPNwl9a5/Lpt9vON/MpUrjYj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6454



On Fri, 17 Jul 2026, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Looks good to me,

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e6292021f653..ae754363fba8 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1070,10 +1070,8 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
> 	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
> 			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
> 			       cspmu);
> -	if (ret) {
> -		dev_err(dev, "Could not request IRQ %d\n", irq);
> +	if (ret)
> 		return ret;
> -	}
>
> 	cspmu->irq = irq;
>
> -- 
> 2.34.1
>
>
