Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488F1DEFDD;
	Fri, 25 Jul 2025 05:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421863; cv=fail; b=Te88tN0tuIwa38PYBJOX+mBlYxi7pCzCpjjP7/08m6Yd/zabnr0sVUy5o5DPhIgIMCtFMR80mccQu05pHLBrqaub3DclRkYsUS2n0wrJWEmvzURjj/VoIpfyVBndz+KZHPgCnB0LUGTmNPgdWnouCL0wYjc6KxXxUQqmtW/MrLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421863; c=relaxed/simple;
	bh=iXyod796ritTo3iLi8RWlDOz+M7sNAninzoyY4UJRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nk1tHP4v/JqixySoy6q554JUfJtcQbArtJgPbsJIiPcfNvrHIX22C8Vu3HiBSbwlSelvTATiA+mpjOTIFiPQHQ4Ja6aXlAgHzZodNdmqrbjknwx9oVQJ857JIHfStlrhbVcP3XqvBS4SZ4SKsDeW12z4jUt+VA5j+Czif6hEBhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y5Cf2Hlm; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5Cf2Hlm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfDKVqV9htfQt8+aLOG8zmVijDUTDJ4yt5bWLXXfVkyNt8q3GT8fs9eMc6f6ThtFgTGJdq6CdKxAuzXEiK7qhh/cRXt3TVLOOUjFMdaPmmz3+t+frspKEtct8dmv1oGyQ/ys4wJR+g1eYPyb91U3V0U3xV46ztQbynOJfmnxU20QsJtOLA6rDX9D5XbY0hH7ddPivkbMpaaAIsNGx1F7yBpAk9uh6MB+PkSgI95F8TpsbwwIIJxZ+kHSOkOpLz1LzA+jnJGD8bMfgeM1BDDgrhWyO0qFuNW8ebhXryZ5Ca11Pf1bbgVQ0OaF6N+vMpWKoNlc+EJVYdBBRUxy5YDukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rp1T2S0dK0e6Ouyex/54Rz68y5pJKeqBQBbQPv3oV6M=;
 b=mEc02IIY6b6KSx7SyZqBu/XWdvvgGA2y7bN0sZXf6Q7xhy3CMPyZa/lqKB1duscjrlOB5kBRG3+TYjVpAsEOoKaUc8iAngZ27A3v+YsSN50IcrhxdSXqJl4a1mhgsh0ONWsyGPObrdjhrdjEqYjr2whN8BQlbpIOgnPCiYk7JW9MN+36l+C8mxa5sQlQTuiYVUDm/uL2ok3nGmsYk8AVbn/lvbRNtLnNqKaDQvDUmgoEdClDikljyf9ure026OT6yHfRsLi3ytX2CxcBBnwCEq6SihDiGPU/K0ZWzQ+lrEXlDt931wvszx1or3lHI3DB+vB89KWcrQAjVuR77cDxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp1T2S0dK0e6Ouyex/54Rz68y5pJKeqBQBbQPv3oV6M=;
 b=Y5Cf2Hlm/fzQKa496MohxqOnXrl+G2GxV0/Xv8PrZl1pPIHHT3Gv2leX5qvLa+0zHLlo0Nk5hMrAGgmA6sBtmTnDRV4C9n0EvmyJrg6VclUDkN13g/SuX3TjRGK5s+qrdG+P+OM8FZTEWSG1TgYu6wh/1pF2Sf/Yj2JT+y0eSc8jQzT0IPHltpL8a3hTD/29ngXMahwI+O1osoUeqfwsQxsqEDLgkvCfSti2x0DQ1XXluDP3z1VPii15lbG60ClLL/mpfZOAmjUeYZ/Jlx6Zw7gSnP2+oc1vxEa4P2ZqFvzVHjL00dOOKer8cGz/1o2XHdmDN9wWT1MfH8Ot6EPh0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9054.eurprd04.prod.outlook.com (2603:10a6:150:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 05:37:35 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 05:37:35 +0000
Date: Fri, 25 Jul 2025 13:32:15 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 11/16] perf ilist: Add new python ilist command
Message-ID: <k56ukpfv77qhoblfagz6naux5mo65hgj4m3ubivq4uz3mar7f4@r4fp25smfbme>
References: <20250723232217.516179-1-irogers@google.com>
 <20250723232217.516179-12-irogers@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723232217.516179-12-irogers@google.com>
X-ClientProxiedBy: AS4P195CA0034.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: ad26d051-44fb-467f-1c55-08ddcb3d5b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICTP2Iswm1kQZfpLG/7Tbe5NIWY27UYsmE33LLQIoSbT3Sya2DJcchMOl7Ai?=
 =?us-ascii?Q?NUWOxYft3yqaJJlA9W0RrZq38q0/bVi8pd34UiLfqrTjYilS5ZnbuoLDVivS?=
 =?us-ascii?Q?0QE72D/vFUsZRegxJvRaRrWq0c3oLRYricg52bzhZwDMMu0AGtipoYyi1w+T?=
 =?us-ascii?Q?5v2wdXOP2KfJdTj8CJiCD2L93uOLZZmQXB38g8cMRbykED0Hc09sUIfeJY8x?=
 =?us-ascii?Q?p5Q4GGYnV2omDN6NMJgiF6ytmwN4VekXBwKiQuan4EEolXTGhO5JJGLI3y7T?=
 =?us-ascii?Q?ku6bnTV4PVywsnbdEa0v3ooFWzOyLUQf1Jmyyio5wRVWRSe6DqIInbp+RtJD?=
 =?us-ascii?Q?NW0ha7I02TAPo4YMenYx40rb9Zb6tV6ZCoBDAT5Z9AraIqw7/h3nwKmiudJN?=
 =?us-ascii?Q?Nm3S8IXXEtSzaDb6iFrxe+wTBvS+L6yIm8Lf8tBq+cfUDpyPsmrawi6XTCjk?=
 =?us-ascii?Q?pyzHvOGl+5XFvcEeasNqG9wmcXbHkccHvgKj4hbo+MakN1EheIwkoG0MAzm2?=
 =?us-ascii?Q?MAQ0yRloUoB2pcgBCy9BpTl5VMHCsShA1sGUGKFm6/I/KrxhbIZY7i8uG+Gc?=
 =?us-ascii?Q?PujkJVMR04o6JQ4ECV+U4tXLGKT+94fSqJvJgbQTvwoOQ4uVhXxAsXfU6tWy?=
 =?us-ascii?Q?9dFCWqtly6k309LXJivedZtpIVVo5uS6+2rbPFglY2UqHVDHpJNXWZcuOVjx?=
 =?us-ascii?Q?d7pAqWITN/fv8n7+w4EfDXfIcz8whATEwNea+2FjOyNfQX/9+BtpLyy6GZJv?=
 =?us-ascii?Q?Pg7u/gt1aA6k6hS6F7PPa1rZG5p6C8TcdvcMqNPaQU2yZ8dlaa9bauYq5X16?=
 =?us-ascii?Q?dUrT2AUuziwCMJmVgq+ygTQnioozyV3HGJN8CIliiOipCfUJHoKSjyloEaEK?=
 =?us-ascii?Q?YFIRF6/0+JiEdGsHjNFY29bYstCVwzueiYtaqlf/J55sdLqZd6TUbagb3A6n?=
 =?us-ascii?Q?DTne8pPAPKK42WJyBJWsN4XQFYnRCs5Qc6FTWjm4LrfE3+I0YrF6gKAJq6fr?=
 =?us-ascii?Q?GlGYbPHz2PjrxIyIr2R7iRdpzWOVazBeqEwgncEoN85xrodn3T8VB/tzYcKI?=
 =?us-ascii?Q?XJg6w2+oJO71HoHKKlxrt7Ds/8nqGxGxDwIVbG4MDcVDYh9hMJ4OnEcaWHts?=
 =?us-ascii?Q?0sCLfHjcN8Cd9hz7B4DUxawcYadpCKxKTPGECaR4br8y/1IEc18gTYbafQ1Q?=
 =?us-ascii?Q?cFRzd0nt6iP+nzKBKZ0PBrB4TSmy4MJ9y6pRZFXfj09W721UCdpZP4+6i98a?=
 =?us-ascii?Q?FgEvikwXLC/T+bSDRGOjBcjNpCqw2Md1KUrzUJQAY8oCbwZCMvvUblXQtgp2?=
 =?us-ascii?Q?gzsikAjIOYnkba1Cc7BYI7OMMqwAFaSXubHsD+eiN0Vw6HAN7vmSjFHr3QJY?=
 =?us-ascii?Q?M9opMYpytxQgMxdSpd+FMHCCBiTaOOOl+0i1Bvgf+Mu04wfZl+nzLe5rXQjv?=
 =?us-ascii?Q?5r+rAyLSkmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ARU4SxBtb28v4iZvXTKOTqZDQUfpZjDf53rMbu8iR5jcs/2VEuULiftzSES?=
 =?us-ascii?Q?/8pUEpMcVJceXZOpFchHnyWDWSJCAOgNom9U1rot1cohW0pyK8Ty6x+LXuAE?=
 =?us-ascii?Q?PeH8BeH9Oism0/oy8ckQ5KfHeBhCqPhAp3Zcfzz3TnSo+Rsz1sVF1KmtGgQv?=
 =?us-ascii?Q?EkNPOSJj/3RpzAkc1lMN+L4gcTrwVnKIiYaf9m+pti0IRLxDzk3qO966am13?=
 =?us-ascii?Q?nu/sHYtq+ENPbkhN8m0uZOn/S9ngjm9YzDg3Rghvt8+WAWs1eUXZUkLELUK0?=
 =?us-ascii?Q?wWxgCEKRnKk0HdUH86G2/TmK1b0ldqxH/bBxc5cxibJIc6oRlVWEjQVcV6AF?=
 =?us-ascii?Q?RePEjLUt/ulJyB9e8nKsui/LOJPUBOdYkopaewQNE6uQzenjtKD0256EKWFz?=
 =?us-ascii?Q?F6xunFV0UwXXz3l/N2p2uVKiaRSVjRRdFCTOPWfYKhzNiqLDJeUQI+HnwO0D?=
 =?us-ascii?Q?/Zl1eRWfWH7lF8Yrs/GV1QGNIt/VfgrYMPFBrOhnu6LMUc1r/l4rz7lBMh3b?=
 =?us-ascii?Q?T6LpikKcRVm1t0+ZzARExIZHy0d6Pz0pIfZO1A87giPIECyw6og3cyuicuiq?=
 =?us-ascii?Q?8/3+f5tvnhQZz5lbKI+g8EjUwD0FDUzwRggrBghbHjPA8DYNFJnBY1IUgXNQ?=
 =?us-ascii?Q?Gv9VC5ypRZsCLo8hw7sVC2Cz69BR4lUsFagoFFxWgliymwhLLAKYWoqO/zFr?=
 =?us-ascii?Q?5uy5K/dP0A5jj9UPKTkVh1kngVnpHji2xgDywGzYjWkM25wlm7nD/B/jDBX3?=
 =?us-ascii?Q?RY7Q6KHZ2D1sc8fjaN0BkdsVxOvKmhJtX+AgB57C6cm0JzIzNRb1CI4SSRTD?=
 =?us-ascii?Q?k4AvAJ9cYn280sBZgLf+wfluwY0y+t4g8NSn5UC/TQF4jDR1e3StjYQ/H4Qp?=
 =?us-ascii?Q?xJ2EtczHG3J/2XN0bQMjoX7CErRMgMnOwmCv/xiWVng0fM9ZmrmjLP37hVMj?=
 =?us-ascii?Q?H14FY7Rwif6QUxkzhNagf54zEyBcBpBohkgTtU4kvybE9poWiauIhRXABRV4?=
 =?us-ascii?Q?AJXVY2q2J8E12hA1sMk8Cz8xp6CMcEZgca2p4EiFhFXy1DQB4CL9wQ2XRi4d?=
 =?us-ascii?Q?pLM3xNf9ghCrck4eIz1hZOJbCYugUjWWLpAillms4Kbr6Eg3CfFQjLCQEm/5?=
 =?us-ascii?Q?78kEvI8FKyvAPgSOrf8cehlMx6mnQSvx6cNmK+C3dcEJvRYNnRBcG/Fc9OdI?=
 =?us-ascii?Q?cumSHEL1DNlrBEf4+KMNcTJiOW0C4O8j788jMI8wdR/vPUS8WYMK4IueJ41l?=
 =?us-ascii?Q?aivX+2snItGxN3tqlof1acSyEC0hZ9wJ1zJNC2vIFy5mq8eq/Q3qAdwDP9an?=
 =?us-ascii?Q?/LXh+Hk3ybONer2uhaApmGlZ3t9K0HfblwIy9bCzpM3rOktG3QLZd6CJ9U+s?=
 =?us-ascii?Q?B6ZAkkSYjPfflppm+zoWhZ88Yj46F9JLvBohCaH3PNv4saXLhifA/RQaQIwn?=
 =?us-ascii?Q?iQjqwhO5TYvl4fFiOAH4G6gnd+UCJLWztOzLbJ2egl3AjvzbyHAp2B8pcDgA?=
 =?us-ascii?Q?wMDRco/fSALBilpMkDEAv5mUisVwx0dt2wqomRfWaTlCwzDhuZD9ICMVmTgt?=
 =?us-ascii?Q?EG7ar+hNWcY+P+ZnS9x7qFsge4dYAI0CozQuySGU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad26d051-44fb-467f-1c55-08ddcb3d5b9f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:37:35.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3FeqYmt+eLiyeKu409KXgggTpZUmdf9REMh6YLS8vzQ2AbpjOQYZBeWl2jVhXL5Gn1/j1Y0bh8RxEmbiZc5EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9054

Hi Ian,

On Wed, Jul 23, 2025 at 04:22:12PM -0700, Ian Rogers wrote:
> The perf ilist command is a textual app [1] similar to perf list. In
> the top-left pane a tree of PMUs is displayed. Selecting a PMU expands
> the events within it. Selecting an event displays the `perf list`
> style event information in the top-right pane.
> 
> When an event is selected it is opened and the counters on each CPU
> the event is for are periodically read. The bottom of the screen
> contains a scrollable set of sparklines showing the events in total
> and on each CPU. Scrolling below the sparklines shows the same data as
> raw counts. The sparklines are small graphs where the height of the
> bar is in relation to maximum of the other counts in the graph.
> 
> By default the counts are read with an interval of 0.1 seconds (10
> times per second). A -I/--interval command line option allows the
> interval to be changed. The oldest read counts are dropped when the
> counts fill the line causing the sparkline to move from right to left.
> 
> A search box can be pulled up with the 's' key. 'n' and 'p' iterate
> through the search results. As some PMUs have hundreds of events a 'c'
> key will collapse the events in the current PMU to make navigating the
> PMUs easier.
> 
> [1] https://textual.textualize.io/
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/python/ilist.py | 392 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 392 insertions(+)
>  create mode 100755 tools/perf/python/ilist.py
> 
> diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> new file mode 100755
> index 000000000000..b21f4c93247e
> --- /dev/null
> +++ b/tools/perf/python/ilist.py
> @@ -0,0 +1,392 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +"""Interactive perf list."""
> +
> +import argparse
> +from typing import Any, Dict, Tuple
> +import perf
> +from textual import on
> +from textual.app import App, ComposeResult
> +from textual.binding import Binding
> +from textual.containers import Horizontal, HorizontalGroup, Vertical, VerticalScroll
> +from textual.command import SearchIcon
> +from textual.screen import ModalScreen
> +from textual.widgets import Button, Footer, Header, Input, Label, Sparkline, Static, Tree
> +from textual.widgets.tree import TreeNode
> +
> +class ErrorScreen(ModalScreen[bool]):
> +    """Pop up dialog for errors."""
> +
> +    CSS="""
> +    ErrorScreen {
> +        align: center middle;
> +    }
> +    """
> +    def __init__(self, error: str):
> +        self.error = error
> +        super().__init__()
> +
> +    def compose(self) -> ComposeResult:
> +        yield Button(f"Error: {self.error}", variant="primary", id="error")
> +
> +    def on_button_pressed(self, event: Button.Pressed) -> None:
> +        self.dismiss(True)
> +
> +
> +class SearchScreen(ModalScreen[str]):
> +    """Pop up dialog for search."""
> +
> +    CSS="""
> +    SearchScreen Horizontal {
> +        align: center middle;
> +        margin-top: 1;
> +    }
> +    SearchScreen Input {
> +        width: 1fr;
> +    }
> +    """
> +    def compose(self) -> ComposeResult:
> +        yield Horizontal(SearchIcon(), Input(placeholder="Event name"))
> +
> +    def on_input_submitted(self, event: Input.Submitted) -> None:
> +        """Handle the user pressing Enter in the input field."""
> +        self.dismiss(event.value)
> +
> +
> +class Counter(HorizontalGroup):
> +    """Two labels for a CPU and its counter value."""
> +
> +    CSS="""
> +    Label {
> +        gutter: 1;
> +    }
> +    """
> +
> +    def __init__(self, cpu: int) -> None:
> +        self.cpu = cpu
> +        super().__init__()
> +
> +    def compose(self) -> ComposeResult:
> +        label = f"cpu{self.cpu}" if self.cpu >= 0 else "total"
> +        yield Label(label + " ")
> +        yield Label("0", id=f"counter_{label}")
> +
> +
> +class CounterSparkline(HorizontalGroup):
> +    """A Sparkline for a performance counter."""
> +
> +    def __init__(self, cpu: int) -> None:
> +        self.cpu = cpu
> +        super().__init__()
> +
> +    def compose(self) -> ComposeResult:
> +        label = f"cpu{self.cpu}" if self.cpu >= 0 else "total"
> +        yield Label(label)
> +        yield Sparkline([], summary_function=max, id=f"sparkline_{label}")
> +
> +
> +class IListApp(App):
> +    TITLE = "Interactive Perf List"
> +
> +    BINDINGS = [
> +        Binding(key="s", action="search", description="Search",
> +                tooltip="Search events and PMUs"),
> +        Binding(key="n", action="next", description="Next",
> +                tooltip="Next search result or item"),
> +        Binding(key="p", action="prev", description="Previous",
> +                tooltip="Previous search result or item"),
> +        Binding(key="c", action="collapse", description="Collapse",
> +                tooltip="Collapse the current PMU"),
> +        Binding(key="^q", action="quit", description="Quit",
> +                tooltip="Quit the app"),
> +    ]
> +
> +    CSS = """
> +        /* Make the 'total' sparkline a different color. */
> +        #sparkline_total > .sparkline--min-color {
> +            color: $accent;
> +        }
> +        #sparkline_total > .sparkline--max-color {
> +            color: $accent 30%;
> +        }
> +        /*
> +         * Make the active_search initially not displayed with the text in
> +         * the middle of the line.
> +         */
> +        #active_search {
> +            display: none;
> +            width: 100%;
> +            text-align: center;
> +        }
> +    """
> +
> +    def __init__(self, interval: float) -> None:
> +        self.interval = interval
> +        self.evlist = None
> +        self.search_results: list[TreeNode[str]] = []
> +        self.cur_search_result: TreeNode[str] | None = None
> +        super().__init__()
> +
> +
> +

Nit: could you keep consistent blank line code style? Because I see 3
blank line here and 2 or 1 blank line elsewhere.

Refer to:
https://peps.python.org/pep-0008/#blank-lines

Thanks,
Xu Yang

> +    def expand_and_select(self, node: TreeNode[Any]) -> None:
> +        """Expand select a node in the tree."""
> +        if node.parent:
> +            node.parent.expand()
> +            if node.parent.parent:
> +                node.parent.parent.expand()
> +        node.expand()
> +        node.tree.select_node(node)
> +        node.tree.scroll_to_node(node)
> +
> +
> +    def set_searched_tree_node(self, previous: bool) -> None:
> +        """Set the cur_search_result node to either the next or previous."""
> +        l = len(self.search_results)
> +
> +        if l < 1:
> +            tree: Tree[str] = self.query_one("#pmus", Tree)
> +            if previous:
> +                tree.action_cursor_up()
> +            else:
> +                tree.action_cursor_down()
> +            return
> +
> +        if self.cur_search_result:
> +            idx = self.search_results.index(self.cur_search_result)
> +            if previous:
> +                idx = idx - 1 if idx > 0 else l - 1
> +            else:
> +                idx = idx + 1 if idx < l - 1 else 0
> +        else:
> +            idx = l - 1 if previous else 0
> +
> +        node = self.search_results[idx]
> +        if node == self.cur_search_result:
> +            return
> +
> +        self.cur_search_result = node
> +        self.expand_and_select(node)
> +
> +    def action_search(self) -> None:
> +        """Search was chosen."""
> +        def set_initial_focus(event: str | None) -> None:
> +            """Sets the focus after the SearchScreen is dismissed."""
> +
> +            search_label = self.query_one("#active_search", Label)
> +            search_label.display = True if event else False
> +            if not event:
> +                return
> +            event = event.lower()
> +            search_label.update(f'Searching for events matching "{event}"')
> +
> +            tree: Tree[str] = self.query_one("#pmus", Tree)
> +            def find_search_results(event: str, node: TreeNode[str], \
> +                                    cursor_seen: bool = False, \
> +                                    match_after_cursor: TreeNode[str] | None = None) \
> +                    -> Tuple[bool, TreeNode[str] | None]:
> +                """Find nodes that match the search remembering the one after the cursor."""
> +                if not cursor_seen and node == tree.cursor_node:
> +                    cursor_seen = True
> +                if node.data and event in node.data:
> +                    if cursor_seen and not match_after_cursor:
> +                        match_after_cursor = node
> +                    self.search_results.append(node)
> +
> +                if node.children:
> +                    for child in node.children:
> +                        (cursor_seen, match_after_cursor) = \
> +                            find_search_results(event, child, cursor_seen, match_after_cursor)
> +                return (cursor_seen, match_after_cursor)
> +
> +            self.search_results.clear()
> +            (_ , self.cur_search_result) = find_search_results(event, tree.root)
> +            if len(self.search_results) < 1:
> +                self.push_screen(ErrorScreen(f"Failed to find pmu/event {event}"))
> +                search_label.display = False
> +            elif self.cur_search_result:
> +                self.expand_and_select(self.cur_search_result)
> +            else:
> +                self.set_searched_tree_node(previous=False)
> +
> +        self.push_screen(SearchScreen(), set_initial_focus)
> +
> +
> +    def action_next(self) -> None:
> +        """Next was chosen."""
> +        self.set_searched_tree_node(previous=False)
> +
> +
> +    def action_prev(self) -> None:
> +        """Previous was chosen."""
> +        self.set_searched_tree_node(previous=True)
> +
> +
> +    def action_collapse(self) -> None:
> +        """Collapse the potentially large number of events under a PMU."""
> +        tree: Tree[str] = self.query_one("#pmus", Tree)
> +        node = tree.cursor_node
> +        if node and node.parent and node.parent.parent:
> +            node.parent.collapse_all()
> +            node.tree.scroll_to_node(node.parent)
> +
> +
> +    def update_counts(self) -> None:
> +        """Called every interval to update counts."""
> +        if not self.evlist:
> +            return
> +
> +        def update_count(cpu: int, count: int):
> +            # Update the raw count display.
> +            counter: Label = self.query(f"#counter_cpu{cpu}" if cpu >= 0 else "#counter_total")
> +            if not counter:
> +                return
> +            counter = counter.first(Label)
> +            counter.update(str(count))
> +
> +            # Update the sparkline.
> +            line: Sparkline = self.query(f"#sparkline_cpu{cpu}" if cpu >= 0 else "#sparkline_total")
> +            if not line:
> +                return
> +            line = line.first(Sparkline)
> +            # If there are more events than the width, remove the front event.
> +            if len(line.data) > line.size.width:
> +                line.data.pop(0)
> +            line.data.append(count)
> +            line.mutate_reactive(Sparkline.data)
> +
> +        # Update the total and each CPU counts, assume there's just 1 evsel.
> +        total = 0
> +        self.evlist.disable()
> +        for evsel in self.evlist:
> +            for cpu in evsel.cpus():
> +                aggr = 0
> +                for thread in evsel.threads():
> +                    counts = evsel.read(cpu, thread)
> +                    aggr += counts.val
> +                update_count(cpu, aggr)
> +                total += aggr
> +        update_count(-1, total)
> +        self.evlist.enable()
> +
> +
> +    def on_mount(self) -> None:
> +        """When App starts set up periodic event updating."""
> +        self.update_counts()
> +        self.set_interval(self.interval, self.update_counts)
> +
> +
> +    def set_pmu_and_event(self, pmu: str, event: str) -> None:
> +        """Updates the event/description and starts the counters."""
> +        # Remove previous event information.
> +        if self.evlist:
> +            self.evlist.disable()
> +            self.evlist.close()
> +            lines = self.query(CounterSparkline)
> +            for line in lines:
> +                line.remove()
> +            lines = self.query(Counter)
> +            for line in lines:
> +                line.remove()
> +
> +        def pmu_event_description(pmu: str, event: str) -> str:
> +            """Find and format event description for {pmu}/{event}/."""
> +            def get_info(info: Dict[str, str], key: str):
> +                return (info[key] + "\n") if key in info else ""
> +
> +            for p in perf.pmus():
> +                if p.name() != pmu:
> +                    continue
> +                for info in p.events():
> +                    if "name" not in info or info["name"] != event:
> +                        continue
> +
> +                    desc = get_info(info, "topic")
> +                    desc += get_info(info, "event_type_desc")
> +                    desc += get_info(info, "desc")
> +                    desc += get_info(info, "long_desc")
> +                    desc += get_info(info, "encoding_desc")
> +                    return desc
> +            return "description"
> +
> +        # Parse event, update event text and description.
> +        full_name = event if event.startswith(pmu) or ':' in event else f"{pmu}/{event}/"
> +        self.query_one("#event_name", Label).update(full_name)
> +        self.query_one("#event_description", Static).update(pmu_event_description(pmu, event))
> +
> +        # Open the event.
> +        try:
> +            self.evlist = perf.parse_events(full_name)
> +            if self.evlist:
> +                self.evlist.open()
> +                self.evlist.enable()
> +        except:
> +            self.evlist = None
> +
> +        if not self.evlist:
> +            self.push_screen(ErrorScreen(f"Failed to open {full_name}"))
> +            return
> +
> +        # Add spark lines for all the CPUs. Note, must be done after
> +        # open so that the evlist CPUs have been computed by propagate
> +        # maps.
> +        lines = self.query_one("#lines")
> +        line = CounterSparkline(cpu=-1)
> +        lines.mount(line)
> +        for cpu in self.evlist.all_cpus():
> +            line = CounterSparkline(cpu)
> +            lines.mount(line)
> +        line = Counter(cpu=-1)
> +        lines.mount(line)
> +        for cpu in self.evlist.all_cpus():
> +            line = Counter(cpu)
> +            lines.mount(line)
> +
> +
> +    def compose(self) -> ComposeResult:
> +        """Draws the app."""
> +        def pmu_event_tree() -> Tree:
> +            """Create tree of PMUs with events under."""
> +            tree: Tree[str] = Tree("PMUs", id="pmus")
> +            tree.root.expand()
> +            for pmu in perf.pmus():
> +                pmu_name = pmu.name().lower()
> +                pmu_node = tree.root.add(pmu_name, data=pmu_name)
> +                try:
> +                    for event in sorted(pmu.events(), key=lambda x: x["name"]):
> +                        if "name" in event:
> +                            e = event["name"].lower()
> +                            if "alias" in event:
> +                                pmu_node.add_leaf(f'{e} ({event["alias"]})', data=e)
> +                            else:
> +                                pmu_node.add_leaf(e, data=e)
> +                except:
> +                    # Reading events may fail with EPERM, ignore.
> +                    pass
> +            return tree
> +
> +        yield Header(id="header")
> +        yield Horizontal(Vertical(pmu_event_tree(), id="events"),
> +                         Vertical(Label("event name", id="event_name"),
> +                                  Static("description", markup=False, id="event_description"),
> +                                  ))
> +        yield Label(id="active_search")
> +        yield VerticalScroll(id="lines")
> +        yield Footer(id="footer")
> +
> +
> +    @on(Tree.NodeSelected)
> +    def on_tree_node_selected(self, event: Tree.NodeSelected[str]) -> None:
> +        """Called when a tree node is selected, selecting the event."""
> +        if event.node.parent and event.node.parent.parent:
> +            assert event.node.parent.data is not None
> +            assert event.node.data is not None
> +            self.set_pmu_and_event(event.node.parent.data, event.node.data)
> +
> +
> +if __name__ == "__main__":
> +    ap = argparse.ArgumentParser()
> +    ap.add_argument('-I', '--interval', help="Counter update interval in seconds", default=0.1)
> +    args = ap.parse_args()
> +    app = IListApp(float(args.interval))
> +    app.run()
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
