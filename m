Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338C189528;
	Wed,  9 Oct 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466836; cv=fail; b=M0im4dV4bcFwXD4aeGUT+xeCXSNw1sjC+HJV0xsn5FuJW68yw/pjheQfgMqZocZvM0bmbSBqyyGB8qpxe6n8QUc5ZUr6PYFFf74cvHcnoHuU+7GE+rpprM54QvoPCc4h1bSqr6HMCsmwA/eRitoOMLIz7wjOvICYVTy9VpZTpP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466836; c=relaxed/simple;
	bh=TJbC/a3NXUY3h2XFrBt6vwve5vPAm7MQdM4TCxSAIP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WrPWkiEGj1IWJUM7/d/LQVhJS8kLlszHUo5wLjjD+xKpzuqELTRin24Xtk5jrk4Tk1jD+8rzCXl0o/Yq1S1cve2n7B//hEAuEZi13z5kR2lBEYjhSieciuM3l/LM2IPQ0sWnaEBm0OIcxUVu0w0LhY8LCdmTPzpLdn6WtpOxWqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Oxy9ua1s; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oxy9ua1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2l7cOHhxew7BKr9HkZgS3DdNcW0+/QzNIpbT3F/lahV+CzYmrWZNx3Wbjz0KHIcqSN7ECySVLrSB/317r2dZrCyMNrRFar3B7nQS8RYnZhpJhM6foPCTMHtb5eaIuk9BZSYSnEIdBU4/qI5Jx1FnYxSuG+VIGbOTXmv0T42VHn/UkURg1jlKyjqGcbTIqaJamjq9su9bjj0SyeuP7co1vGSeFifkKt8h2hKUHDu7bnydAuLR/O6NHf4Onn4YHbV2/FajsYIvrh+tSkelb5XV+s0AhPNiQFxz4exU14/T1G9yiXl07241ggq2mWO5Yiziug1dG5NX33lPMQXuobVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+xcbBLo+vpS6ZBioXe0YZWW/mwPzTEpB90Ed8N7l8U=;
 b=h+IxAW9NCpTcC3cvZ69YICUtCyRRe59C5p7EvQpxLVIAYiCv5EdfysSEr4dzL/Um87hN6wdubGGIfBQI9pdYWtQozwSbVUHyhmy7ieYgnaK7DQwmRns1nFiAAt/KKfLMSt6f0RzxTSdgQmM2THcb9uBKjuHlvNyAwrVVNfjOPN7lrZBpLfeIZWcwvU7CL9wYnJswjNlZ7JSB8grKw/8iQUnifXHGVWFXLlfJSTNASgXPB80IjFF2dgmwZKx7l8N0MqXrlC0+gMnZVBVJwX+AyLNd446qJQv42DIm5knafWQgcKSEcy6A2dO56cMwhcoVDLqN6zGGFmCnHZCXV8ISZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+xcbBLo+vpS6ZBioXe0YZWW/mwPzTEpB90Ed8N7l8U=;
 b=Oxy9ua1s8sZXNUPXzX4FjWTE0h2jIwp0J0h6nE351K0RH2cHOWiUcNt4/AyyRJnMNxaA7rmvfWMj5OXPTQ3OopE7WTTrdLuECR9HM25u0XT2zsJ12/C5DSmSCU/dJofLXgQNIJnLbtiA4eybAN99fgpLfFK8+w7Wbt3RQf05snX1xMBCJ2wv4TQA54QHG8qYjmXLx7fiMBDoer4U8XGRfZsdFb+nl3HrEbdHkehEwrxFmcgfb6jfr+7+BZHqrJy0QHtnqXeJcdaB61Cf88l4N0QdG+6k4HRhf/Zy4aI+VfxBLmNzLczXXKhQlg+qwNYyBv+g24DXqxqbZcpQS+cNKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 09:40:30 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 09:40:30 +0000
Date: Wed, 9 Oct 2024 17:38:25 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf vendor events arm64: Add i.MX91 DDR Performance
 Monitor metrics
Message-ID: <20241009093750.6mbq3zkmupahrzmm@hippo>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
 <ZvsTJ47yHFUjo1uw@google.com>
 <20241008054935.zi2kqcaj4fwf2bda@hippo>
 <ZwYncyUlAtTAeOjo@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwYncyUlAtTAeOjo@google.com>
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdd7d20-cf5a-4434-7a20-08dce8466a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82ajroL+4DGp/IMhdgbPRPTfyTBvfMZPSPVAsV2STAcDRFxxqcstvEi/rmnR?=
 =?us-ascii?Q?CAleTrv7/WOk4e2nDKFiUwwgr5pYyjwSgDilynXaijz+0br0x98y3+usVmkG?=
 =?us-ascii?Q?C/jFerLsznD59AEaq0tjCHI9L07pft23y5DCBeX34RxCCd6BSPwz6v9demmw?=
 =?us-ascii?Q?n6YLAjS+tg6vpdA5p24QXr+Rhl027WWjAaUEdifJ36eaKjSB0EwrwxFnYrmb?=
 =?us-ascii?Q?Syx+d3DSHodcbT6+a8UTJLcKBGkxwIP+1K9ieEabWXohGrK0KUKalrbPQCCL?=
 =?us-ascii?Q?LUNnx1diq2pHU0OrpMUZkBLIws4M9ALRtS7zXVxVtvFpZUqVtG8FV/Ou0Gst?=
 =?us-ascii?Q?EKeoic/9pEnuvco16PlcVM8tGKOEoH2IFwe/JUZSmBw9Gfhq4igQdi0r+VlS?=
 =?us-ascii?Q?d1W9oA+YudCRLnAuIsOQuYJMxcaeOWrmEQdRwcCu8qBAakgXB4kgqpuAybqz?=
 =?us-ascii?Q?yJU6Zyg67Hcb6AYFoTKn+C0uhpyR1WgngnH/qbIePvdxwNP6F7kJHAxmvDFU?=
 =?us-ascii?Q?dGv4W4sJxVqH4vzZPsg/vh1fA/ChiLJSfgQvobSBRok1mQnekKuSdcjii7+s?=
 =?us-ascii?Q?op23hUCrulonzRzFPokSkMYQ0SSLQ1a7n1fJWMwpvRdRRygfk8aHXX7jHRpg?=
 =?us-ascii?Q?nOpBRPay9a5PFFrAh7TXN0nEkfO0o5W1qidC/KpulPIMplv1s3wV9aiUl/mw?=
 =?us-ascii?Q?vfHDoR1wMCI1TQ8e53lXu2WKdxbdzcddqDxdO/+kn13MRsySwHrOblGLYLv/?=
 =?us-ascii?Q?hYIPwsjJTOvwF6X97LJ9E7Wd0QNL6GMWfH43ojSDBdtD2pYizS7FUtjSwhjO?=
 =?us-ascii?Q?gZU4+uDWWZ0GSvXVSKzlX2chW7U8Wt9lIHb6Wen6ttFrtmt+MG97aeJx1z55?=
 =?us-ascii?Q?vUxhIZe+CzqdPjrr8vF6gn6Qwh8/EMQEoNPqAgJkGrxjzFVQYFzjMC5IePKq?=
 =?us-ascii?Q?mSD79bJJW4Ctzu4ndj7TGb5ysc93KZcQzStDHyT+IqYxJYt1DNvHXaHeX5uT?=
 =?us-ascii?Q?hsDnbmFSqln/A1cs9uHxo8zAldc2BSV4o+6YGrzUJ+yrMNX1vyPZXNJI38t8?=
 =?us-ascii?Q?bHyvuylYFCPjvAd1Ri9M9LBkX6KfF6rJVG57B2jpjiBkmfzqbZ8KNZGnpCmV?=
 =?us-ascii?Q?8HQCFKBbKIMuqq6oKEI3WlaAtGDF4xrDBLRi4skfOcou4ZRzsh70OMsGJNQu?=
 =?us-ascii?Q?l9jSKDpqc8123S5KhdmqbqDeON41/3Ti/eo364rfzLc54TQQOFnfpMHk8D4m?=
 =?us-ascii?Q?NkyYD+T0D1QIklsudvGlZVboHdAim6YYQX50631zGRIKYbwAEjIxvFKCFiBw?=
 =?us-ascii?Q?C4JFMgHYm9wM+a5thl2Qau9YcGrD9XXzGlRNDSdszfaJGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyj+rIVdyxY8FDnYSxK4B3s5R1wJNsS0LqfK6+Atn+upFlwBPcL5IqPksdkI?=
 =?us-ascii?Q?8/gGy1AZixd4D8ynFRJY66JsRYBvRJpIt+vgU//2FX/MEgs13hHlpn4qldCe?=
 =?us-ascii?Q?4qbGd6GPfz5yrjb1J808HuR5ji8NN8gZS/tOkkupH6xf7IycnWdMB96Dgrur?=
 =?us-ascii?Q?S1lvDOao0KjJwod+D3cpnAW8DsHIWw4xo0CN5YIljgaKGh+sY4QyulxRxRzj?=
 =?us-ascii?Q?RJTA9cek8Gop8CexeHzQEhMpM+1rXbbT89JXI6rJd4qS3662I2ULWKxr/J/b?=
 =?us-ascii?Q?wFvU8cBJzuuAlYUyGP2I0lSfBw3b6674zk2zPV5NeVwSqcePS4JYAvuRWSHg?=
 =?us-ascii?Q?0YLsfmKQbV0t8R7YCeQLKM8Cygj+4Z9i28h1XDbXMkFWu9nuATyIRLKzOl5f?=
 =?us-ascii?Q?h6+vGvYkOT9upZzTZegolpKc28GdVyxcmzEZFb3IW23O+W2Qli0exh/bM7cN?=
 =?us-ascii?Q?ebLPHPYipf3RINLWFjFEh66GV08sGt3ihIaz8QgIu4xLvrJo6WbsZPW9KtOX?=
 =?us-ascii?Q?P6axQztwbHjUX/FZMQXdNqq118yabBjBpgFm3fddMEItGgJO9X6PucYgtopd?=
 =?us-ascii?Q?RR2DCv2JYMje8Mx+73jvU5GH4WSlf+qxYF2xCZ3UHFfAPWhGbj3H0fbrnO5M?=
 =?us-ascii?Q?5XW1EGxxge1K7O2LjWpmgllThKzGg642YrgJHeTR5VoyO/IVfOMU6NVs/OJd?=
 =?us-ascii?Q?cceNlO+OYgYxtxXUh4HMzdJfMfLWbE0SlQ394v8vrXm+Z9jnWGmoSDpmniXz?=
 =?us-ascii?Q?PEdA0E80urvGsKTYno1R6gX0r1f03Jx7s6HW5HfebuTsTDwQZlHXbnoJWufW?=
 =?us-ascii?Q?XtCs84OIR5BoO7hWf2UrnNjE0JGk+Sj7Fg2NQIm8NjmZh52TPM6s44V8in9a?=
 =?us-ascii?Q?XABeG2t05/0WduU2fdYpXEH6paDXU8CumWmzllJml4Q5kNSdZMn2z4lh8y0F?=
 =?us-ascii?Q?QpSxHWRrZcURLfVqs9GyJS9uKTEpPksKdkt+S3i7Su6cfu3/uCklPG30XbB1?=
 =?us-ascii?Q?RLveodQZY4mOaa2r+medxCXbPDcQle/uebZVpPzk0pk1CXrh/C1BkjJiwlZQ?=
 =?us-ascii?Q?ZX11FOTynOle+6/hVJWphsj+H8EoLAMv9CdVmAjTFRG7n8qn3yKIkmK6wB5r?=
 =?us-ascii?Q?jeaeRwX0i4OUD6ksRutxCju79KgxPgm702HqaUHg5itMDAqSxR64rmGEXjid?=
 =?us-ascii?Q?UsL5OwjRHTvdYC/p92hlwKBJsD08dblOhGQPLw8uCUJwZTtDIxYcsyAAPF3o?=
 =?us-ascii?Q?XwNKXsJlwmmX0zHKhW8RCciXuzD+B7Mx99bLTTWTGOmMH2cP/jLH8NGr6Pf7?=
 =?us-ascii?Q?mZvG5TqktM3SnVEXwfENE+WqAOvFHOKzQLseiyKnPu3adibJjbS1g0RoUIpL?=
 =?us-ascii?Q?sHNA5FiWl/v70twaaZM/+SDnPOruwlUbER43oQmkP0dT16YTBH9mpILZX/GM?=
 =?us-ascii?Q?MB2/s7ZEwBPmYNz/qxterrmYCPsr3Ghn3lq3f08+bi75kV3slA46ma8KJ+X3?=
 =?us-ascii?Q?nP5zWuty6tZh4sAVcI2LYaWkWgaw5A3NcATSUy6C1oxMEDHvFvIRyqN6Nx18?=
 =?us-ascii?Q?+2IDsbxxCPsv12HywMge9LhfsWV9mrHLf6cdHZAT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdd7d20-cf5a-4434-7a20-08dce8466a0e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:40:30.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RKm27so2G9GjxulcmbOZOM5T8pIF32JmVttVQJa5vDQ59Sd/8kWxGErjQ8RDPsrQ75JNJCm7xqIdMUDTDwYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092

On Tue, Oct 08, 2024 at 11:49:23PM -0700, Namhyung Kim wrote:
> On Tue, Oct 08, 2024 at 01:49:35PM +0800, Xu Yang wrote:
> > Hi Namhyung,
> > 
> > On Mon, Sep 30, 2024 at 02:07:51PM -0700, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> > > > Add JSON metrics for i.MX91 DDR Performance Monitor.
> > > > 
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > > ---
> > > >  .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
> > > >  .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
> > > >  2 files changed, 35 insertions(+)
> > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> > > 
> > > How do you want to route this?  As it's mixed with kernel changes, I
> > > would generally request to split but it's a change just to add new
> > > files so it should be ok to go with other tree.  In that case,
> > 
> > Sorry for late.
> > 
> > How about you pick up this one to perf-tools tree and Will Deacon pick up
> > the first 2 patches to his tree? I didn't see Will apply perf-tools patch
> > before.
> 
> Did Will pick up the kernel patches already?

Not yet. I could ping you once it's done, is it ok?

Thanks,
Xu Yang
