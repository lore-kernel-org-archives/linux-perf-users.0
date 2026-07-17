Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3A373BF1;
	Fri, 17 Jul 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304065; cv=fail; b=YYqwE+tFPHYHvUILr0CJ2Tkuso6Rjf7XVMJJGWAUTa5h6cCMWiLAcGT6kDLHxLYLbMyTcnTIwWo4gdTIqqOYwjNU7UTVjTKQZiEz/a0yFhH15v1EDgtsaXlgOyT2juUwkD9InseItNO/nZUZVUrBQcLit1GhnH6KVBO/OSFwULw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304065; c=relaxed/simple;
	bh=WuJlWJ56OBZI+88YRp2BjTxoVY3O4YANZfjh1NGcSs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vCjc9SmpBsYiVfQbnizMpzT9ClZVaZT0cfgo5ASP8GrH82Y4sJHzpUg+B+ZVT/B9F5w68IwHiwwjfn5ZEQ3EfaIvk/1OUItU+ehkoLiCf4whhzTaDV4e+WQlUki963pXluyS2Jx0PQeVe0Zs5VNL9XNQhnxhvF2QmnJNgXlfdg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PoMWAeEv; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PoMWAeEv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrl/oZoEOFVKpK1296IyzJ+kGBAFkXKpwy3bjp1m7t/BEeUsU9ngrTN4lqVEaO9zo3ZqOqRN7agmdk4KNECNcikVFEALHbW73YwwAGILxqLDcJ/51Z5MgRTRRCi7SEKMNPXBs5FjpYsUbdr1JyBPeqfGGBexsFHEvFY9dIxa2RdZRexs5TNs+Z6wx6B+M0tkeecXfImm+/KnQ7Z4f/g5r9rDIavgROvr3EgFmkkfFT/0T1xH3JvsGWQYDX+apGXC4tVWj5JryVBo8fgRMeq1xAaqyZ2LzoEDlSylEpihBss32rNi8TR0ZjoMsssS9yciF6zKQNY0JJOuxr9FkGepaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b518yO1BGkJvdZAaSEazGiO276NMnJIP8Vx9USQaPa8=;
 b=HI2z7RlcoXnaqDGU06wYqVwY2VFJB+gsc6IEj5/nKORBlGt8xygmM90OiROMxXifGJiajXBSQOtZQ5UCcceKioI6zGLJhbYjhQTwRR8GGnLdl0VR75/SFs5UondOfozi6OEY9f8sLb+MkoI17tln+dkE0nv8BCnSQKwRBJS+D8qEq2lqd17T2nj95nkeOZSivNZvU15hFE2lg1CjQf/kwQ6evQVbp1MiHaC6fzxZOzPmskFX2MV9jv+kY5vDhM6l+7Hn+ZcqgC2o4F1+iLSSO1UhvXsjq5UZ1sAeWocZh3ZhfIhiorNDUdEYADJx/WMglk1GAZnJdP+AKVmkH5bAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b518yO1BGkJvdZAaSEazGiO276NMnJIP8Vx9USQaPa8=;
 b=PoMWAeEv0G6GpHfya4s5XabuknIPCYOSLkr0cPHQMY1Q+8ebSTzXDL9mAj0o/z76nwiHpO2Uj9S8aAG7Es8WE6XV6K43/aIZCxW3k+mR7oacsMEl3hV2w4F463dNJXCnfVoQoA/iqB2g+JZOHUZyGhTmNetA1RYujxjVHhSXyzI0REPN6dtRE+gA/2dRXLh8B2T85uhaH+rWLe5Z8WkyQj7PbzYZJEwQUOFlJl74fslCFLCHxJ3nP0XN03J1gz37t7vHTECZRKiP1dWt76EtLn3tFyP1AFmtG3UViJZ+wTTTWRnxQqSsitXqcnzy6HVfucLo6agy8Ubb9lq0J2/yVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 16:00:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 16:00:53 +0000
Date: Fri, 17 Jul 2026 11:00:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Frank Li <Frank.li@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	"moderated list:ARM PMU PROFILING AND DEBUGGING" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM PMU PROFILING AND DEBUGGING" <linux-perf-users@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 1/3] perf: Remove redundant dev_err()/dev_err_probe()
Message-ID: <alpRq-4qhxCTwy8R@SMW015318>
References: <20260717103123.34887-1-panchuang@vivo.com>
 <20260717103123.34887-2-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717103123.34887-2-panchuang@vivo.com>
X-ClientProxiedBy: SN7PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:806:120::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7166819f-729f-40d1-c639-08dee41c9420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|376014|7416014|1800799024|366016|6133799003|11063799006|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XCBCO1buIkOIVDnMDnl2eMEI1OUDZme2wmzoAXK+LA2pf7nGTgu68Idzxhv7BnKsTbLFm+X7vRbTKoItK3UOXbRAgDyFIqrlvOahNoSJaCU1/Qv91Oc2zQurQylLoQyNNtAVnsA40dpj5oZrXFMbDl4nNa/Wum1Rx3Rw+ZvF2lIGcLWzirr8/7ksZ/rKN2L7abDw8O9zz86Oa8smoEYQXq8mcjf1WZ/o8XUBuHVMH2g3Zvt1Xf5o8CAxf7Gjrd+bmwROpXVUSmF6ig6kuzbI2oWzzKj4sgbusTuo1Chv8DVeOq29RMKZoa6B55D+KDVMCr8+pv0E2hUrLvsXOIXc854Yr9RqlcZtJ/jsdtaLE475kAlufGDJfPSSWku7K6wK9KbuC331DY9v9lMSX5gjd1q4TvBv5cWcOgYGy6yl1IzS0VCHkoonfBj4Ocfbz/AL7D3waArASMSB2Rb0/JveCrfrl/QsQ2/O3Lh8QEtvuq6wohzeZTYDx38MupNE0tfIHueAu+ePcM7kf4bbcKBDR5L8AqO4AIe1eI+8UFWjPXeD2RlKdUMTfh20HDpKv7lDtocRop0ZpBkOZb1b6PBqvYRJEa9fEtYcKZqHHiVeBlYMdgvoz18tKFIKJRTzo3d417LfRyng7r/JP9HotoNQ/r4e7fbMkPmf4Gv/KJ/9BJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(376014)(7416014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oltIm0ajfgbO2BOi9FBZluWKdFrhoI3XmLIb/w4UuJa8M/w8z2JiI6WjJ/3R?=
 =?us-ascii?Q?JpltUm4Q/yjEAYj5psCN/q2y1733v6aQYzbp9o3VFis5gOWxwSOvzFb+ODIk?=
 =?us-ascii?Q?fwy6H+Xf/1D8zVDVruKuCkQIDKrQ+L0HW9vMI+b+Z3AdxKKaIT2J61041Ysx?=
 =?us-ascii?Q?6bcmqNF16MaWyRYLB/4vFMLWRWnZcmIpg+pPyHiwkpj6EPty7gtpY45H35z1?=
 =?us-ascii?Q?vf86Z6PE2dQyP9qqWUXRNi/pbpvoitVCxT2DPXk/sXJV5gtHmpV0OuVa9wRM?=
 =?us-ascii?Q?jYZZib1wsHdcyu1S5EHzNCtwJ7n9uwScwjETGIy0lqBLunQKmTsQvGWte4jN?=
 =?us-ascii?Q?jx6yTTQVYMWavnF6oMr4uOPM7y8HDwWIBiEYpZeCjEXzNFj86bOHcdNlN3d7?=
 =?us-ascii?Q?EM0aUo0U6SWDttRDPbM7BYmGVIpfubVt35AeBUOwt+LkMrd5wc8CjaiOlMoP?=
 =?us-ascii?Q?+WV+mCfiLf/uL39VZH2wzKsXXVwZorlSBo5G72+amqFw1WRY5Ks2DtoSRrqc?=
 =?us-ascii?Q?9bvsdDnYxPOjCAsFiS1UKqALnTB/Ngmi0EEJhx0/YQmutRvZkOwZbzMXRpH2?=
 =?us-ascii?Q?RY7mVq+LRUYPJZiFiTQ4BKgN4pA2RmtaDccW/ZUDUwp2Fv8JMm7PdAtpnNKP?=
 =?us-ascii?Q?7qkdDDpcOPyzWregGipRy4FqEn0cvHNRhIlWHNjGSas0YfRQnLST3NKct40Q?=
 =?us-ascii?Q?D10Bx4WrZiZ9aqC4vdNgJV1dtjSdW+2ZCZSSoEL0wyEqP4+ZK0OeUor+DOkE?=
 =?us-ascii?Q?Bpl5rTEDT6n6RXEzyADzKhcPaOhsLdglSdAB5o4aNDJBmBH65nUpsO9WCGSX?=
 =?us-ascii?Q?n7+i2GPRGdJDuqcIyuy2WSteCVP8cHX2+aUyfXSCP5T23ZTVNeZ6RteF20nS?=
 =?us-ascii?Q?p4C+qLqsTsUSCTH291MwAcuNdHDuC9MhM8L8jZ+m9uKODRnGXaMCmSqsdrm7?=
 =?us-ascii?Q?oQ5elQZMWy45DIWZFy4+TGmTapj1TONuGZwZqpqCN0lw4VTamft48e/e6/dO?=
 =?us-ascii?Q?qwJzyeB4IL9uFAuISkuNo67YpYOcECVnVSx4CiRfXtSlfDezRDrGQ5p4jMfY?=
 =?us-ascii?Q?yocJH3tn62ilLaLaC89Mj1Xz9OygdbaqeS92ptSmQi6rgewYDn30OUR437dw?=
 =?us-ascii?Q?83XNdXCwokRV4RVWR4c9lD3RDrAltp421uMAExs6dFdv8JNDM8Pz5bv/p8ZZ?=
 =?us-ascii?Q?FbXI0SzkeRxah4VVNGXtG+9+IvXqjh7yjnIp4RxjhKm0e/7WpemPPOxJ1oJS?=
 =?us-ascii?Q?HkeauhIf/TfHo2Z3OzNvGRbSI9e5KC+OVkb1E2wQskw6aU4ozxYYVCca1rLb?=
 =?us-ascii?Q?REZhxrv56tSerA38SGClb54dRp40Rcb9DXyaqZafjM8kaDrtjEZ+E64rWsLj?=
 =?us-ascii?Q?Rg9AyJVBYQ+Oo/rPr8H9qO5DQdA5Bkg/TMCiyrcD3m66Dyd3RLP6y8u3tQCO?=
 =?us-ascii?Q?dq/QMN72u8pQ4i9LFPUxBdGladn/QQGNJ49fb1S8Us6L3n7ZnYa+U10oopjB?=
 =?us-ascii?Q?YiAEccANR/W+NqQW7+7Fkc5H+Y//D/ahGY7NYHLQNxO3pjhSfPkazIK4vRD3?=
 =?us-ascii?Q?4taFmf9Dz4xAhj+fEi9E2//EtaXAJJJADGqzGacxsGnKF+RMZ2AUg+9d3HOE?=
 =?us-ascii?Q?UgMYAHhcOE2pls6stoHOWYhDmfFVd4FesyrRSfsrUDkycw+lvtScsAoHjko4?=
 =?us-ascii?Q?gvTYHkjeoDHuuKV67yM6iOJy9XFI2NwLfSvwRygMKwrQUOTPUmXTOmi6BxsS?=
 =?us-ascii?Q?lm4kuliCK6/gMW/67IV6DxQCe/nSfipo9dASYoNIv65GKABasK1k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166819f-729f-40d1-c639-08dee41c9420
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:00:53.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx/pjDfOfdPJ5hK/Lwa38m90MueFOD9HukGaRrRO3lz/67YgRyUZAseREtSzutygObcj2o7tqkk+OGQGe3YeHEPxJE/I1UGCIM/Y9gKZgjKmId5Zr9PKAKSh6iPK1UxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824

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

for imx part

Acked-by: Frank Li <Frank.Li@kernel.org>

