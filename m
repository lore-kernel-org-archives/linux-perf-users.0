Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD23F12E2;
	Fri, 17 Jul 2026 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286507; cv=fail; b=b+pF+fYRQUxYP55fkQgNlXGf4FisJf/MumwlUiutSZk2YoQrexIob5wiIntikyZ6hKaUv+MbRzh29J7rmdBOejOpyFMY2ks6LgqpudiMpafqHkhSFCzH6ReesuF7qGbka3AY5z1BCdoiuieaULAjaIum38hsTA3wHQgiAzkv0W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286507; c=relaxed/simple;
	bh=nAGiLNLFEFeowfiHg8lFTT7vKVo3vxP1kN+y8I9g4kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nrjNK51hL+k6hdLPndQW2rvqup4Tw1x3ofM6PwfO2JcC/VoxpzUtMsc2lG8rX4BhojysvwP1EwmmK//3swcNgnb+QyQA2shq5HUgE9SKb9yl840v4UgudLaEoIV+mSeIJnw39KVX7MVyKJ6lTvP1RTgEqvTzfI7B2uDzlpkcczc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EPvyjyAc; arc=fail smtp.client-ip=40.107.130.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EPvyjyAc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMNHH8Gvj3EfjqDHSZRNVpyuQkkNmzrbue6M4mg7bRfs07pe3qnw4msyZzv3XMhQ8zY/TDzMo5kU6DkztJmTyJGcSOgt0Cp/tzeXqqKUPYjYDcPb1eGa6mZ6A00CHeaSEoY+1ULjjdWu3EMUcLz6knwQJDMzPlKfiZ9WlRGfDaY4vevHNVavkWIg4pxhPagVyTN2JXrUx9S8bq7xRGZmex4t1fRPwMDVhXgFJQJK5Ooc6nIY+TVByCIjUJVCmywvZm0hRudEY82L3W0HTXj+nN9OamJdFhWajQsFm2bBkbBWBnOvo5S4jy2a5lwqbZCaUBvLuSdS6sf//ke/7MOd5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIOso+/f6mheDtStsIgmtOw91R8YgWoOFYrywLkxQdg=;
 b=H7TnxbFI58pOb2Ego1lFd7Zh5GpLlvfB8JUnPjCkOgeQ29gDtygDnute0wJivqnfjCE65jPUnapbYdOr7LCmRQJLuqkvotrgYJv3b1N2I9c2x0yrwRtnvVDOGl4VBS5R1jJsU+q/VlUk/NkarZZRQjY1N+h5rJ3IXYFQggvmt0OMkhH8/wiCsJAJuAJO+wQ3IZqcI4RHaKTi7hJzu0MkSTKi9cE/YPXrvOls/ImbtBGSicpmfA1jwnz8mehs7P9BP2rkYVQwvNIKC+paXU5Bpp426M0drE8trsx66db14SRYgi4YdfmXm2syF7hgSrjsT3D5crfydWbaMq+daiWmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIOso+/f6mheDtStsIgmtOw91R8YgWoOFYrywLkxQdg=;
 b=EPvyjyAc1JoRfjVCpDGmQL4iKDa9NBQfbeiTbwwoat0JIJtXLcZjG1WgKsyqJy19WU9JrPjhNJ0HZgKekE5YRW+BFpCZ8lds0pPRLRsr9/k7/G2LkeUr/JMJEmRWu91pMhB8kN2bAoZayq7FWRLxliNxSzgUUD3j54oSNbPU430s9VTlrL02a0QVVXav1OGpyCnnolzseEpqNWY09/y13LX0395rWT9UQBHjDb7Imr9jhveg7oof+TqR8SKOSXudMwleXD35OfVo9ultX0anx02BL1763QTl0LbVWDFUcgjX8Y/j8kBpRpRYKoe0T3B8UGBgE1CDSZOSkdgzjFVS5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 11:08:15 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:08:15 +0000
Date: Fri, 17 Jul 2026 19:06:50 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Frank Li <Frank.li@nxp.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Khuong Dinh <khuong@os.amperecomputing.com>, 
	"moderated list:ARM PMU PROFILING AND DEBUGGING" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM PMU PROFILING AND DEBUGGING" <linux-perf-users@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 1/3] perf: Remove redundant dev_err()/dev_err_probe()
Message-ID: <va7tqd5fjr2lwivkbipphkfawkegroyvqf6kugvmbsylaxf3zt@kxo4a524zieu>
References: <20260717103123.34887-1-panchuang@vivo.com>
 <20260717103123.34887-2-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717103123.34887-2-panchuang@vivo.com>
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: f77a84b7-0ca8-446d-7de7-08dee3f3b2fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|23010399003|366016|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	MTDrZtqIvkC0xXBFv1RVBHAHLiecM01HXq/+AJ7FcfpZ1mAeotVP10C1lndcUvy3yVRwN56y028GWQ3+6AzaJI5bLh2c+vHxLMZfn1U9PS6peIbu50KsTK4oLNFJwC2cJ/NmbzTtzc9MAspNdi60CHBKZstnsAORHKShyv1G2MoVsrv2THwy5LTuqnntzHK1jIdCvxOB4wZ4XXhUKpY82XqRP+b4SxKgrPBm2ftuSlM+JecPrRX6qoUrRDb3idUwtKk0mX/PZMVpojmyGJ2QHkZE+FBFQtPRdmFnVi9DSqLdU8xl+MPjtAktMxeBoHag+LcrhqMidFGdg1bMT5/FdEBd/ujqjQi/RV+iAMsuGDffqnFiZPaxMGZC/+68ThmIqZ4P38WkN7Ma2vJcnpnzVb9guqKHk00yIXLACZFR6Ek4YYOG9N5JesfdGzjMvr5n76gg5SkylOblT9/0FZOSoFkoBWaJO1LFYm6OzF3OTSWj9/RfOpyblm3Q7HB3Ks/ro3+PcbdiSXGd6SngLfoIvOkBR5KFWaJivsom6CS/bYS9mynK+DAxAycN8P5RLJ2A33O6/w3qUYpQE/LgkbmrwNh0P+AnK/xQr1nNBD0SpDIWPLTMVaEF+ydNKLHgQRQygT7qPkWtVzQhUsdqzcFK/BeffXS9Cwi20q73fQryVWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmVP4x9lTviJkAnyzUT34DsrLlobdOLH8o5ZdU++hKUBy2zFnN76ZBWqpCcV?=
 =?us-ascii?Q?y/NMhK2GsiIpUYBN4VsIM/2BAcHnf6CJ8Eheh9ZOz6FCds7j/PRWAX4Uh1Bc?=
 =?us-ascii?Q?j1ipnzfy9NIpocwPv95iRAfZAS6FpYgShUXMTky+NExJtkxXvapKo9Zs6QCD?=
 =?us-ascii?Q?RtlaFBCImi9FuZWm76hbqJo7fZcvihB+H7ThhYR8ao0HO2JMJ2b7hxKoBew4?=
 =?us-ascii?Q?nmxPM+rKxhbKAAScbnzD8Qpb2abKYNmyD8fuIJ2KSHyVNDPT6A/gCXsxUfA1?=
 =?us-ascii?Q?lDT8C7fugWRJFhBt/RSS24LKcy/U3ZK4gMTvKz0JJ8wdB/pa5ro66SXr17wt?=
 =?us-ascii?Q?JfhxPSuUEwF9h+ztLBeY3lreISdTBjuXzZjSy7xkL1yq5aJLr0BTEfhIu0jh?=
 =?us-ascii?Q?CLTJ2/4TCCEikTNC2PC+R4HY/t+yLkH4e3dsQ7A6SwMIIrDFvj0afRfMt6n7?=
 =?us-ascii?Q?wc2L5B4a3fPJ9VEphxkoBdgpC6yc4tLabxya7OjYJPRHBG/OiUM+zzOcHJu9?=
 =?us-ascii?Q?MgqOuVObAjaZbHpagSEk8gl4GRzmx/ydWk37jHzYCnF057W+FkSjcDhDXMiH?=
 =?us-ascii?Q?SuYhVhzCsfv9uOY5TBUEWfpEvxmhEnUKoQINVE5b/RHlcTcN7elAk2qjVpRP?=
 =?us-ascii?Q?aUsHWNed9AY1WMNUU/sFwMUJB8NBiN2+IXFF7e368RVEjO8cYhwPGznP2FBE?=
 =?us-ascii?Q?Fb3zrnykX7iM0eLDFK2p6G0JpdMq+lqo4KX79eqMVt3lQ0PL4VMoJQeOVyja?=
 =?us-ascii?Q?Q4it0QHjlLPJq6kugShrJfasA8vSGhFVS7J58UYUwNsv2sPRzhZifBkFMYWG?=
 =?us-ascii?Q?LBkCJdJGAmJj72GZYlEAhXp+ZLGd6R02oGPStOd7uMoqluni4U1BH1mfBQx2?=
 =?us-ascii?Q?pPJ9vqWgO4OrxzD6noU4QOyiRTjJZCquesUg+qdTehoLXWIkxYwJkmM3Blxu?=
 =?us-ascii?Q?EpmygC4D5Nwp03Md3I8AobZnIBxiKflRJtO+sE8USC7eGeFk0ydnjDuHv1rF?=
 =?us-ascii?Q?SUQ1y00eih60nt0Qkkq9hDn+v9TEfX+EeX4qmGSPPrrpusjooA4u47iLv6qj?=
 =?us-ascii?Q?3F9zr87aYYVahYBeuEWYpqN/9Uav6jWluWBAWs/vWYcStRg2C1P51fAel1Vn?=
 =?us-ascii?Q?cUPaZLlGqK8RixXGHuEoFGHSeJKFKif/oXPLgZBkpGxS5Odv8COP+QzZ/yWk?=
 =?us-ascii?Q?e+QpohG68ys4SifszbDqi7KqYNxIFARWQJp9zlVQQMfd7xALg+krmePg1wib?=
 =?us-ascii?Q?o447gafSTI2BkQFfUzZ449f7hSrM/Lo6KmFlT811WgAIXuRF0B7wHcxyWx0n?=
 =?us-ascii?Q?8PMVfy6dtrH/KZ3g4BL9FH/gCwWbIpI0oAlCLEjG5Aly9rHyUEi4mQwQ8AYd?=
 =?us-ascii?Q?Dx5szUww4nGm2KEjoT5c4qP3wLUKIknZfjbq1eZ9Rs56WfrGET2dK1Sf+kBb?=
 =?us-ascii?Q?/czpQ/B0Uea0KPYGIdrnRFIzxpN9gGawjnxoEznXHiSzu+WGqIIHm3Lg67rb?=
 =?us-ascii?Q?Dmn/NGZieme7W6yxDCki1F29UqOtfAxAuyWFibVtuuXUCWgIQMPjdfqYTjK7?=
 =?us-ascii?Q?wcg/QH/iT/rVBbMfUbG8H8Nis/dl45o6G1UA9X9g31pd91ypHr82XqaI6dRR?=
 =?us-ascii?Q?Elu4BsGbkTh84lUmCOVFn0ngpNo1tIxB2NbuFvDWrmF6qFfa0IlhanooXfZ1?=
 =?us-ascii?Q?sacpqAeIPZfKZB6VAK+hpCQBQT6+JHXKxmdYQ05zDqliD2xX8bPMMutqvfyI?=
 =?us-ascii?Q?pSQWoeQOykyTyLySAyb4zCJ/l2jCf/fmSx0zfunSfXbbH/qFK5bQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77a84b7-0ca8-446d-7de7-08dee3f3b2fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:08:15.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kwJl/HWJhjwbkg5FLFo/KytWQfe2Ge9EdYs9VZPQro7CbgzXDqG3TruS1NLy+3EYxtXbTjpMULWgxMRygMcBS0PITt0YFpADJxadx1yZcxz2k79axgWBuQ4p/0Mt7MZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834

On Fri, Jul 17, 2026 at 06:31:17PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() and dev_err_probe() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 5 +----
>  drivers/perf/fsl_imx8_ddr_perf.c      | 4 +---
>  drivers/perf/fsl_imx9_ddr_perf.c      | 4 +---
>  drivers/perf/fujitsu_uncore_pmu.c     | 2 +-
>  drivers/perf/qcom_l2_pmu.c            | 5 +----
>  drivers/perf/qcom_l3_pmu.c            | 5 +----
>  drivers/perf/starfive_starlink_pmu.c  | 2 +-
>  drivers/perf/xgene_pmu.c              | 4 +---
>  8 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index 74786a5dd6a2..fc934bccf4a6 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -449,11 +449,8 @@ static struct ali_drw_pmu_irq *__ali_drw_pmu_init_irq(struct platform_device
>  	 */
>  	ret = devm_request_irq(&pdev->dev, irq_num, ali_drw_pmu_isr,
>  			       IRQF_SHARED, dev_name(&pdev->dev), irq);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev,
> -			"Fail to request IRQ:%d ret:%d\n", irq_num, ret);
> +	if (ret < 0)
>  		goto out_free;
> -	}
>  
>  	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
>  	if (ret)
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index 3760ebe02674..dd8046265584 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -858,10 +858,8 @@ static int ddr_perf_probe(struct platform_device *pdev)
>  					IRQF_NOBALANCING | IRQF_NO_THREAD,
>  					DDR_CPUHP_CB_NAME,
>  					pmu);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Request irq failed: %d", ret);
> +	if (ret < 0)
>  		goto ddr_perf_err;
> -	}
>  
>  	pmu->irq = irq;
>  	ret = irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu));
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 6fee5eb5087a..d59bc5ea3155 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -830,10 +830,8 @@ static int ddr_perf_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(&pdev->dev, irq, ddr_perf_irq_handler,
>  			       IRQF_NOBALANCING | IRQF_NO_THREAD,
>  			       DDR_CPUHP_CB_NAME, pmu);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "Request irq failed: %d", ret);
> +	if (ret < 0)
>  		goto ddr_perf_err;
> -	}
>  
>  	pmu->irq = irq;
>  	ret = irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu));

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>

Thanks,
Xu Yang
