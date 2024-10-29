Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B91E048B;
	Tue, 29 Oct 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190801; cv=fail; b=Sz0dOrkOUUiG0GbBbAdKGGV504iNxfDy+lSyfvHj2DEh0c9EQwA///fd/dw0blyoEIdwRB0+peEKxaDuw2Vo496MLYBLDAUN1dV5EdnATo68fPJ8IHePCGKGYaFI2TmHpJ+lH8usenlBifBrcpOghpJ1A6IuSv0a5ka+nbqvXzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190801; c=relaxed/simple;
	bh=crSLtyXr/JI16lvMG0XrvyYzHQQ3iCBNCxTa8U2BM7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DKL2bf/tK4pNf/v7ewI7P9cPmMfR44oXbch238Py0yOZuY7NNN5sDxK9qM0XwAdCcfUjCeFdepjszqibYmVUPD7h4i6AsElecaADfGAkfw0P6fi5Cfsy6etY76AWDWKsoI+fLZtHkwYItMm3Dbsg41E640MwielALkc3PrJlcss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LQo2M9Ku; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LQo2M9Ku"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgG0id/JqRNTodpy4NZFvIfYWe9UgQCiSNzA+FNcgzZbhwmFcCFGb+YHxxly+U4RQKRaHLgXTy7tk+Gao8HbNS9BXYyJ+KN3FxKfhvgfBUzQV7I0pYy4znKlyRnjoV3DCeDsGYRNu1+jy20VoFGBxZJE7y1Doysj/WSobN2TzuOLi2QON0nTNXX9np6ESgb7el2P3AoqlD7FVw+satsL4xvDRkJKY+856IFJDa8BMVfK+V2XPWDe37GvDDfhO6eJB4tOd3lBYBuxUfI4DXifF0GueVlNVy/VBBm+dcoofM1HMEzELEnJuBYRGg9tfMmwiy4P0YaY+mk+V7YARnZc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyIH1bW2KsD/TUZwBUuJwBar25QbDxNoYznx/gWjyIw=;
 b=WpyguKxGKmdOYI4lvCO7Xo7oGny/tXj971G0gQRRNe2tBDTDoJoctNOYC9HkogalwIb9i8/3Gtog/JOsWHUac25h8Az/1xSU8C2CIQ0aJU0t8zhNxCFdJuwK2LpEeyxhA8QjDcyHcgynEJca48TEJdmwpghZIp/iKSePZjejjL5XXQFBuwHafzfI4FxA3irl0/8Plp9CxV2zl8K9vByhb6LBJ42xp8frQjWvpXZpBi2mycemguFz7pfm9QYxeSngvr2HYivbvdDJYCp75IOVgSTBbraw2TlwttosjmPtAI5Q/YWO5ANYuECsZkZl8tmYuzLLbCQ9fkM7/brdQtEqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyIH1bW2KsD/TUZwBUuJwBar25QbDxNoYznx/gWjyIw=;
 b=LQo2M9KucqtG9jF0ogvLBJjJXhkQ55M4hmC6KHrMO6SO1ek1f78o8c2+f8hP3T579qxo8Hzgusy8gLaC98HKv0jdiFfP3g5GA4sb0t6Lpl0P88TflGSp5E96Qy3vYFaNBOEcVoKB2WXp5paNG+9IcKUGC8y6g4oVk/xyeHgtgURiY+E+D44z1xXWT0uHCvbYAOmt8d6qvO+CBmcN6EiXlyd3tGQ5y2fYpte4AqFb03zW4nuScCjiKR4wMPxHrIdD47lnxkfHSIv762mphT5MO1ZQhIXm1Xwftrz3WkKwx5RelRFnQjTjpQqh2lV5Ndkz1ByWKZ38odl2OLIZeitvgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 08:33:16 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%4]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 08:33:15 +0000
Date: Tue, 29 Oct 2024 16:31:01 +0800
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
Message-ID: <20241029083101.w72zvykliwmua7z3@hippo>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
 <ZvsTJ47yHFUjo1uw@google.com>
 <20241008054935.zi2kqcaj4fwf2bda@hippo>
 <ZwYncyUlAtTAeOjo@google.com>
 <20241009093750.6mbq3zkmupahrzmm@hippo>
 <ZwceDV3xNXijFF_8@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwceDV3xNXijFF_8@google.com>
X-ClientProxiedBy: AM8P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::24) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 810043c1-11c5-4ea4-617b-08dcf7f4555e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HhikydiTmpnXks/VlWZonQrb8SRkK8L8dt3+9C68nb3VBrZR7iJGvq0FzM5v?=
 =?us-ascii?Q?eaL7pllhNgmxWAk5xgFDwqw1JldlO9W1RNoreWIX4iF658zHUJF+00ycp/xH?=
 =?us-ascii?Q?h+P4+vZTwffyUVLflANZyu2n/ouJaJnT4GQg8rubOIsgZvkr2odA5NQVZ3aO?=
 =?us-ascii?Q?qjxkFVp052e842pXgRVELtnUAhBIVPO12M1AoWkJY6I3lptFIZOtJNTclFzg?=
 =?us-ascii?Q?lPUTPd176HzAFzEubrI5BAGV4zta+1Mw7akWFQAfpMgtx6dAODP5N7Euhr62?=
 =?us-ascii?Q?LWb+mcwqaib7SkjEvlK/Al7TRPxqYxJJ/8D+z+4X2oLtpfIRmv/h3M07g36V?=
 =?us-ascii?Q?cWtPQb9EpiByJQ3twHJA1lOCJAKxrsjSXBtiS4RmyJgS+bsas0SdBDur7CbK?=
 =?us-ascii?Q?OgFCh5Pv53hxTPHcJUlkKbiTmRlhmdTrf5qq0gftAsmhjdY6D0GHmXx4GW5q?=
 =?us-ascii?Q?cryE+55k/CBFYjraYyacQqsAeGbeENPS85Rlq4ebc+gFevugM4TaPDikaehl?=
 =?us-ascii?Q?RGgkzFUXPQz5YLut+oPW9C6cNJbbL7nmvFh6/ydiTa481VcjEWFlFZlSoHTM?=
 =?us-ascii?Q?HTOOFfFptArCA8hAbQWYsJsNrJSR7wyF0xC6wgbghXil1DFoPWZyb1zZVvlI?=
 =?us-ascii?Q?x8DR/aYK/6q16vStbgxwLQHurJ8oiyqVNedTyCP58JG9ea93YO2cE01bwPQc?=
 =?us-ascii?Q?6CgoFHo6Fcp/n+KoigQFlJBHLqe+PA85jXGEVYFmvjz4fOAODxX3eG0GD1Ap?=
 =?us-ascii?Q?3qGa1O+mGXfY6Oj6thSUM8W1EUZVY5wXVdrjF+GQgHfQ5jSXUFjqfC+t9rcx?=
 =?us-ascii?Q?SPNtLtQtGN/VGki8TYS/69t6UqGM8dIpl4ysws/E/RGbkMyZzvvp6XXSwJK2?=
 =?us-ascii?Q?E6XQuZMJVl6ut691NCgS/6Fv8WKdHWuLNLwNn25+u288VH1W/Y8ExV/o9OpI?=
 =?us-ascii?Q?B/lCiURlYSR/9x+iS4CxtVoGov/2wuEP2vATDuUi1TUo9HtbjNutWTd6SZfo?=
 =?us-ascii?Q?aRcGv5TrsYyyFGhyfasTU1701MMIhtIEuQbDj6GsrP17y8sfN377R2vyoYAf?=
 =?us-ascii?Q?p5UlESGATj6pxzKZABCVFGUJ9KXY+abGamSfebAYrZanCUy1hKE0V4BQm8DQ?=
 =?us-ascii?Q?yMfP644xu1RWyp9zqtCb6NRyzctba4g/KocfgPVb8/BsGa5BNKwls4QFi7Vl?=
 =?us-ascii?Q?l3/oq/zyP12Z63m+RRKTaaD2yggSewsCUi56eOpVQfdIpkiLKq/o3rxIZhMp?=
 =?us-ascii?Q?HYCIRyAQv3sXFESWoDm213vmxZLaoMciUZhSLmmwUlbqTUEbuAdPUDZG62Vd?=
 =?us-ascii?Q?x57wJor2i+yrrb2dm2mQIZII510K265RRxFi+pYnqHmy/0wa5ZsJ9VaAw5/w?=
 =?us-ascii?Q?NfEA+oM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NYH1hCgvX9PVyulmnlIo3Qj90RbghJlBzeCntFJONV0WRIjWWpkAEAZN7MD?=
 =?us-ascii?Q?SwfOk+JsUmTV2MUKX/mnlDsl5dm1y6WG1sCdsncoL/wqxlNdAyKZt7vt3K4s?=
 =?us-ascii?Q?/9cIh/JJQG87pCAxsNFz3GM6SgWN4EtTyCmEFb3gfBL7sL+dGc7BaZinvEfU?=
 =?us-ascii?Q?PBMZkAYPhDQeBkE8QPZZAlXI/qN/yPoBrNcgHujKvwUnhzrc53efp7s8LRPL?=
 =?us-ascii?Q?YVr4/+iJAgET3hYJ/fHqE/SsFE1Uyqoz8cRuzHIPaRxcVEOiTu7wHfOyjeq4?=
 =?us-ascii?Q?GhoKsaHAksth6nn4mfcfJ7Lb/7akM3QR1d1r0b9dOwyS1ndrMNUzin/n5OgK?=
 =?us-ascii?Q?qYuK1c5GB9I0rs7sIDpCiK3l/N47IMMKd3Jx0gBGe4enfio2kUazAItZ+RUK?=
 =?us-ascii?Q?Mft0ra63EfMfmOimWOArhbV5PmLK7ohYaqN0ztpk0s0KxhQLeinFurjAs0w+?=
 =?us-ascii?Q?ySXx6VV2Wh4v6XC4jPzUu+TzQt0Q1ud3XukW45pkHlkjdK9WbDd5p1EP/1WA?=
 =?us-ascii?Q?BRbtGvIg8YNJQ0q+GC9+xNoAEHcPO93XMFlYheaWvbzYdMqQfQ+lGqUCjtTY?=
 =?us-ascii?Q?YMdmh6ZDv4Sa3JBI9q2xWGMgb9Tg0NeWC33STWGo5/6d28L6nJj9F1jJNyG5?=
 =?us-ascii?Q?dUT8BVyBJHH0qZGrrEc5XeCZgUkng33YV0Ig0DZXANEEE2zFp0vwaAugPPl1?=
 =?us-ascii?Q?QrLq8rsssuacySxGUDCzamM7Tbm5k+PwFAiLwTgkbPK6AR5AwiNjxUie+rNX?=
 =?us-ascii?Q?YNCWT/rG6iS63BkuRyOcs/6ua/HafTZ3JEhtQQN3VAToQGmF5VKabv+M6S1W?=
 =?us-ascii?Q?2AHbH7mK1A7Mv6sMmY5/iwjJzpksN8GAvjdVxtWwFwzkklw5JisSKV03hAHD?=
 =?us-ascii?Q?33mMTtDslbSOWfauHHjs+HIfUal1hqARibs5Zo0AtkCogWHnnAQ3Mch6TFEu?=
 =?us-ascii?Q?6HKofHdreRbGx7m5QobxdBihmYhFIdtpt1T1D45FnmnwDBHiWWDzn3uxSUNR?=
 =?us-ascii?Q?jr/VK/zVWfHOIIA7mtCzN4VQMuojBVHnnlsBAqhN+ECEtrDuL5eGrb67Do1K?=
 =?us-ascii?Q?cmAI0+zJsZenb7FtW/rflipFVREPGM2BLgOnJQ4zUDA+C2GgwTAgLSUI8QSv?=
 =?us-ascii?Q?SEMUnC8D211eVoFq2fhZq+SyLsxgyPfFd0qwqxs1/dwU08G/dAqRMU61x0cm?=
 =?us-ascii?Q?/bZBcOyaRkiOMGLVvpjZzNdx12PVuxps2ZZAs1mpWR5xbXfqL5vaJKsmheEU?=
 =?us-ascii?Q?xQAH9fh9wxWAFkQIS0Cc/C4rTYG5ge7JxObiIpHq42/9zSbLlV4QkEztetzS?=
 =?us-ascii?Q?AST5D7V+54ozo5/Alt7SmuyIWK0ErW3D7zZwKDMWNIG8wCcOZHXQeCaM3c3F?=
 =?us-ascii?Q?Zz2YlibqkqVevZVMLyKVj97QxmBKidLgNrPa4qhFOfC6TR7Zd0G/0cYvlxIP?=
 =?us-ascii?Q?UNJT7MIyWMDCRwWgcdg8upcKX977cOVdaMEgSwLE6SL/7iGUw9UKDa/9hFy5?=
 =?us-ascii?Q?o9Xv4inFvfd6x0hdQkk6AiwBTA/lHO4ap+A2G/nQgaUjmHhpOt/pFtoIDmRz?=
 =?us-ascii?Q?t9aZ2MUWjuDhiqVg8lTmqnh1Airk3pi0I4FyPWEx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810043c1-11c5-4ea4-617b-08dcf7f4555e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:33:15.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqPT3/N0Shul32PpwTuw1NKPqgyBDPVzM1xgbw2tI1RfNgV9FoxAY3Yw3OHsqZantwxQV1jwX7GphN7/KXd5IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177

Hi Namhyung,

On Wed, Oct 09, 2024 at 05:21:33PM -0700, Namhyung Kim wrote:
> On Wed, Oct 09, 2024 at 05:38:25PM +0800, Xu Yang wrote:
> > On Tue, Oct 08, 2024 at 11:49:23PM -0700, Namhyung Kim wrote:
> > > On Tue, Oct 08, 2024 at 01:49:35PM +0800, Xu Yang wrote:
> > > > Hi Namhyung,
> > > > 
> > > > On Mon, Sep 30, 2024 at 02:07:51PM -0700, Namhyung Kim wrote:
> > > > > Hello,
> > > > > 
> > > > > On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> > > > > > Add JSON metrics for i.MX91 DDR Performance Monitor.
> > > > > > 
> > > > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > > > > ---
> > > > > >  .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
> > > > > >  .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
> > > > > >  2 files changed, 35 insertions(+)
> > > > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> > > > > >  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> > > > > 
> > > > > How do you want to route this?  As it's mixed with kernel changes, I
> > > > > would generally request to split but it's a change just to add new
> > > > > files so it should be ok to go with other tree.  In that case,
> > > > 
> > > > Sorry for late.
> > > > 
> > > > How about you pick up this one to perf-tools tree and Will Deacon pick up
> > > > the first 2 patches to his tree? I didn't see Will apply perf-tools patch
> > > > before.
> > > 
> > > Did Will pick up the kernel patches already?
> > 
> > Not yet. I could ping you once it's done, is it ok?
> 
> Sure!

You could pick up this path #3 now. :)

Thanks,
Xu Yang
