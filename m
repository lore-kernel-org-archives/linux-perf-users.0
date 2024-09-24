Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97D649641;
	Tue, 24 Sep 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201403; cv=fail; b=uKJlEiROeZ8HF03dBL698GvOGEhaI8Vvr51bpnydz3/D3Zu0hyO9W9M2jSf0G1qb/fJZ62y6exJnT+tU8goj/Clsv1CmZ5uloat2ny+COAcJVnl4oDzjcreNaJHgubd+wFQcnDoyuVh7kX1qZXDukuxlK3m4R8yF8HdPDkICqRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201403; c=relaxed/simple;
	bh=puoramhT9J1eIBQlYKugbAB8XhLD/HoNtHZX3m0ZCtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hzgjpffukQa1G7LRtx2r45/vRLjMdjyIeKPDBA+gLzhni30NQ7KM85yTwpihdaSdDnBC1f3XYKdo+VXffBXr+KF+2z9GrEvqRlmEZr+GdEyoPAjOOMAL4QrouMbMWffrgRktuHZCOlYaRtnpXAj8VyjDeA5PqLe3602Ab8zH62E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TZxmBTSs; arc=fail smtp.client-ip=52.101.67.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZxmBTSs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjiXFBvhBzq///R6c/mhhutmTqYglr7FCQ6qu8GT5vy0EsVHpceg2DKXIWnKblM0hhRuWXN33vlRIpHjFjURMb9xlwYWtLpQCEiBb0IyAfjpaBRlr0ZqfkjsOjwzuwF4InCIf0JbmSGQIexR1dh29nLBqGOA/8evom4dcHILpp9AW5W5lOpmFFh6cS2cijTnQWe9yHA6Z4tZsx/ObhLSqL/RJmscSS8EsF5//KQuarcpWntCoOvcmEw37VqblHS+KCT23eBJWCkesRGu5496AH9XzEQjPj+tyyP6HAdDJyXe0zusRMSD+amRzOJsnahrnC9/WWtATrIk2jQdOg+WJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyMVthmam6eCkrqhkUNUtVt2A5+sqDee/iFw1aTl1rY=;
 b=T/xYGvEgbVmKprHabHC9fJZm6bTdzEZoOsqmJFOWMN4MG8f6vzGKj0yq/CdGMQcGL7q8OqyknzUe/Syh4CiYLZsF/UAF1W0Bk4grdWf7pIsc42JdRflckLS3k3Vou14bftd4QQgszNSyDD0/uuMLFtzgnfvY8QmBxdrCyXmSMLxae5jAra5YflFPBzK6UNV1BIFP/q/qgAX0bXC1uBPfvwKpEBX2WOQort3eVOKjjLkq3Mj3EN/rAFBFVv105KqZkisAUhgAWbo+nE3BtWeFU8MNwnOMZ2yKPPa95jl2/K3UKOSHaHDe3/D+lvecb881U63q4D7CTyMiB6TMSj65tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyMVthmam6eCkrqhkUNUtVt2A5+sqDee/iFw1aTl1rY=;
 b=TZxmBTSsJmiCDLi93SSoWNPGfd9sYVFHDUH7CKb2yM7hZUKpXM+KqKmTZPdnew+h3yyolbn3ToPaQuSTmETRC98JLVmrgSTsIWJNiljkjJfkqw8v41Vd+lulMFu/QPFBGIf0iMopx5ZYFO8Qxi2QQprVOF+K05hSoJE/Xj9tLa2/+Jt050c6Ly5wWwAAcbMapO/rC6Pa1Af8B1m9fpz2YdwY1SD/sR78mXQO6KeFN2Q9SHhg3mzbv8UaibTKuTDOUqk4ilDKZ87LUE38AEpWEWZQsCLXs24gQJzidTE3LKFnFqewV1Lv5mfbk0eMQQMtipLw6k1ocSvhz5Ffdzyw4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 18:09:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 18:09:52 +0000
Date: Tue, 24 Sep 2024 14:09:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: will@kernel.org, mark.rutland@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: imx_perf: add support for i.MX91 platform
Message-ID: <ZvMAZmyeH+tNrx+u@lizhi-Precision-Tower-5810>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-2-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924061251.3387850-2-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9af8e1-b7d6-4a29-98e7-08dcdcc4164a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?duveeg0bsNiXryFyiDeFvPl/GPYAdjtRV7qDjsgnaBACqNlhejeuMBvdaxIo?=
 =?us-ascii?Q?h1U180NOAHIVumzLGh+cW/aOcvchmHJBpt4cNjIRe/qXERjxHpYvdlW9Ky7E?=
 =?us-ascii?Q?zzLhuFb1Zb3v3xK92Kst4dvAVOXX7Lq1VpKrlW3fPcEtffa51XP8wJ0w+8zd?=
 =?us-ascii?Q?rRzixyNaOqMjv1BzWL5E8cZP8V31d9SPbOL2UrbO9Mj/GIT+1O31I5F/nizs?=
 =?us-ascii?Q?/8rZzpZr8AmwwcMqL8d/MXpvcA3N+yHpVAjrOhcRNoJn0TFB2YtKEjg8Dy3n?=
 =?us-ascii?Q?cZiRNbZ4XnlafQl1ocdRggUKa+UnX9k0tzBWtFJFXfBr5SBqmnmo3Kj40Tzm?=
 =?us-ascii?Q?HK28Q69IjM66zacU/u1/lTG/JPyjr79kkbg8D+SXepdbR4XIZLBL7YtuiFJx?=
 =?us-ascii?Q?Ess1klRxjq6lonXAilw5k2SfLM4NIAu4Zx+COMtAOUx69stMu0HulKfnHsY+?=
 =?us-ascii?Q?rC3kysGQbB6IigN3/2hIoIdtKJ72leYgktedcwc7W1XF55WVL3nxfO0dTC/d?=
 =?us-ascii?Q?wgTkq3yO33MGRdfZprpLFlVLt7eRbpLTWS5A4tT1O62bP5K6mK6lixioXzru?=
 =?us-ascii?Q?DbqCRSdol6qhQCFO1RgXNy1GBU1Gzt3S5yh1D1Oz7IFSYVOGLKGRQC4F4vwo?=
 =?us-ascii?Q?vI5UH65etX26khtVqgs9vvtuK+oSYAqqSFrdFOVQZsAMcQGT8A5go/ys7ZJV?=
 =?us-ascii?Q?h9Q3HiNY9JgdrJeNZ1HhX5a7Gy4NEGtDeLtoSb1jkEAv+tZskkWw8wEj6lLg?=
 =?us-ascii?Q?eA8QEa08O5J/5nINgf69txEmoNKjkpBPaHU4DGdaWpUp29bGC0/UUFgqtSYN?=
 =?us-ascii?Q?+KUlZVPexbtTEsHwcR/k99Nqw5do3203jUQvQMs5Umc3OCr61dyg2nkx/v04?=
 =?us-ascii?Q?Ndxt6mDkwqwJDzTUp6KqXAzqe3AUDpqf5BF6lpzASyF486Y9i2eGB6rPXyzj?=
 =?us-ascii?Q?YQ4yoV6ORQzQPZSRTqhhADJkxMEhddEJBq9do8NPS++05Go0sp75Ydc16s8X?=
 =?us-ascii?Q?4tmMXiSJiWL1Wf8RiWP3Wi0q4v7/Y35/Ot51b1tt+j2yKowuJqE0DmVP57BO?=
 =?us-ascii?Q?iPOMoP99gwcHnTiAb5E54uqFqwB0w5Xbx02L054RQ9NM0j4fUKLzYfHhsBCP?=
 =?us-ascii?Q?d0BrcV7zCNjja0IGcS9xVEZ+n/9ZgdGF40NMIHty/mIcJrPwSYO8rWyAnqzX?=
 =?us-ascii?Q?EOmLqiEh8+HzTm/8drdstSO3yVt8BNWQ7t3uWCUgy4U5wuzltY6a3bth3W5Z?=
 =?us-ascii?Q?rQLqOVhWPxuHzYuvNuR9Vm5EAWICcERGZDnEIik1YYnfHH4Gs3O+Fn6P1ntG?=
 =?us-ascii?Q?yd+8vc3aC0v4uE6Hzp/IdHajwLNAw69F1rjUGaEgV1/SFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8a/tm81SeL7XXGuKK6vtsc9cZKTTHg0/9qJ7vc43f9F8FP0AhRb4MsbfLqem?=
 =?us-ascii?Q?n4O2LAaZzZyAy2L902iJg0HsHcUo3ssiDesewEAGG8CKj0JKDkDiXBDGj4+i?=
 =?us-ascii?Q?rnI7K50e0PMxLlwKy3egU/FY171y7Z3DNZFA2/YVkiGZuxDkD8g2f0ruMDOI?=
 =?us-ascii?Q?scX2EH6TrIVgRbR0MZc0YDuSsynJCCYxalhbvs7xzvbEmfPerTxkqsrFW6+x?=
 =?us-ascii?Q?4G6YHRzzXcfg87oFqwou7Ldr0j063p5LxcQ4G+ixf1N8UloodprRx1XP4bgY?=
 =?us-ascii?Q?L7EvLJhi/cEndUp5dJ1PSVffU1gFjbgrSkpnHw62tHLFdSpXXyi0hy0hvBQA?=
 =?us-ascii?Q?x0k9qh/Kds6ZLhNMK/P+GNDfxlkIlWHS8pXkXvquTdmhSKEW+EH2/ehvf38P?=
 =?us-ascii?Q?DFevrq8fcrAOsZwJgOZfWasv0QhD0wa1mTfWMgAeGcbcTzkbRDBBh6MCXhnO?=
 =?us-ascii?Q?Bp5ICFpW+IMQ6G7t7f6Z+noK3Q6ZRlynrGLXPZ1HLsJxC/SXjO8mtCF9JwGl?=
 =?us-ascii?Q?6BhEzd4ACvdiLoXpKBhX2/yV+7wE5S/H40TpSQdOtFl3Xp9CA1AVb2LezpQr?=
 =?us-ascii?Q?FxsZyspK2tt5yozS7bVyLgyqgVcmPZunqH4WSFzhGrQ87XcuYT3aothM6uT/?=
 =?us-ascii?Q?LWAyi0z9iOJljmZTUi/QKHlQTO7DXSlejNX8bIYvqNHLAGIlw91Re/8rgrLV?=
 =?us-ascii?Q?PraiE22U508JcU5PDeXQM0eR+XxLSq8odqCDD1p7byx97dJxZT110N9fRPDk?=
 =?us-ascii?Q?6aMt/rv3wD24x+e78PquEem0cMRiBqj/wZNbSVcZmYbbt5c0oefUSCyQQZj6?=
 =?us-ascii?Q?3blzWZIu87EbZ1T491SMGtlvXVVU2+or5gPM0orfo8yJga0fOnou6aNH5wUR?=
 =?us-ascii?Q?HRMQkN50vpihXSvnA9wlpoWmSjVfGcLiBcrOdhKMKv1s7YKWdmMrD5A/65Sz?=
 =?us-ascii?Q?1HCgAY1CDB0xlETy2ZlEVd5m4FsUULQ5bHuz5ZDfhvMPRfN/krXuOJMtyKM7?=
 =?us-ascii?Q?izoMIdHmt1VJ2ljAZ4/5BtG+sktpwTntm8qqjHDCUWQv+/rl94t705+I8IwC?=
 =?us-ascii?Q?HIXpt4sdhtZtVj3eY6E03hlPFm8+NdDdjT5dCj/zsNI+aZNml5xD8X0Ok5Ij?=
 =?us-ascii?Q?jn+ueDdVXrtd7FEVOlR6ll1w+8/+JxhVn0xxjT8lKIbFP14d+PeAzJLpziVo?=
 =?us-ascii?Q?GtUCcx9SUdtVMKT6iD8od6l/W9po2Y5HLF59NYfkgpPa/J3CGFxAoLWPrm1p?=
 =?us-ascii?Q?B0CwzYausceTBdrKZEj2OwCFTeuAd7kc7e1szd+vsePz/rhhXz1ujWBDS30m?=
 =?us-ascii?Q?MJW6OPJsbQk0ptk3YCtG1RnjFxv3JimjyCTDWxeqKgRki/unevd8d0GpkQOH?=
 =?us-ascii?Q?8W7TKyzsdecsZ7NL7JpmnFydxdrcOxmp5FlLLaqsUEGVgGDPbPZApxjcbFpd?=
 =?us-ascii?Q?W/JTCXHYYLFnbdUMNYS8qJdH7eAIUVs7D5yiWSJjSqNAP4PnDg/2LN8kVd2U?=
 =?us-ascii?Q?Nq1fd2T3BTPmsZt5JuaWRZKrDmqbQW7FwoLm57gnkdutA/pFRgYXkVtDVTvc?=
 =?us-ascii?Q?eRBXohUlpacFyTdgXRGEZOtYiQVKwDZdMDhdgOJp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9af8e1-b7d6-4a29-98e7-08dcdcc4164a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 18:09:52.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k26OSw7ktm2UVDZMsjwqS5bhK44mtwZapGavgbfQITUt9UAD9aZ9dNisDcn5ouRjsFBikb4PmzxyM4sYdIOvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923

On Tue, Sep 24, 2024 at 02:12:50PM +0800, Xu Yang wrote:
> This will add compatible and identifier for i.MX91 platform.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/perf/fsl_imx9_ddr_perf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
> index 69f920b1caf2..fe1a51f64751 100644
> --- a/drivers/perf/fsl_imx9_ddr_perf.c
> +++ b/drivers/perf/fsl_imx9_ddr_perf.c
> @@ -81,6 +81,10 @@ struct ddr_pmu {
>  	int id;
>  };
>
> +static const struct imx_ddr_devtype_data imx91_devtype_data = {
> +	.identifier = "imx91",
> +};
> +
>  static const struct imx_ddr_devtype_data imx93_devtype_data = {
>  	.identifier = "imx93",
>  };
> @@ -100,6 +104,7 @@ static inline bool is_imx95(struct ddr_pmu *pmu)
>  }
>
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
> +	{ .compatible = "fsl,imx91-ddr-pmu", .data = &imx91_devtype_data },
>  	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
>  	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
>  	{ /* sentinel */ }
> --
> 2.34.1
>
