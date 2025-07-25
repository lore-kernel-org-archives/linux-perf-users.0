Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B2E8F6E;
	Fri, 25 Jul 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422493; cv=fail; b=e3La+Wp+SInEoW5sGdpxDfj359zEEVYuJ9oBmlJZ1E4solSuw4iuJGJE+17QkHOqa+BE3MDb+hGOwXW/hv7DhJDky8uK2rJqMG6T0fwWqAVQ0J313ZLD2Y2g3iWHf118t0R+C/3bjjO++EnS3me44PJGRFgM2HHK/E8pT9chjT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422493; c=relaxed/simple;
	bh=G6SD80Qo4CxsdIwDiuDC/8A0WlyA2+u+C02CbcFfi4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNwAog8ZnJCRuoyEN00FMwK9/YzzeiYpdtogLU6V7s5rS+7bOTl6BFXtmx7GGDcZbqktVyogn9fLmwBupowEP4Ln81RUJlejnckVlX6EtBLYKuixBLQfdqpM0QarEHHwX0gLIn2zNb6HCLfXb8RKkIUL0bc1uTZn9lWvyaYsbOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ToV9ZChu; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ToV9ZChu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPMj1FGc0YZ4T2qBVTZJ8N7wh4M4SzvGIcHMgYCSSiZYwVlzcFJzkEheiVjwBootcsusQYmowf52A/i3Tl4YcPjWj0hdCaw0PGjfErqwETw0+ZCeVW1qb1RWfibP95epJ4teIwcuKtAKd8AtttsEMNu4++9fYvmHywHl0R268GhBH0eh+lh08Ua2JRK+BphGbfLSjMhegKifzxcbv1ZlbvPSxH4EurPwE6jiWilGvQ23yYsgCQvky1AIFxhZCxGWbc3rSZqhkvGsTBw2JsBoVgozDQizP/daw/heihDu0Noi9DZyVBSnXIWBY4loYWu4VUKLKnbg7+jf4fug9o1fDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCZjj5yyJ+LHoX/sTjmDjC0qMc1QzhhF4mlTYMFq+ic=;
 b=EqeahgipI3KyJoLrIrKYAVyNq+omV8RdVQQ6YdoCc8t3gLxacFg0I8+wcknHTGNVhgHfVCuxzOaHilNLIdM+b6iEmJcfw97wgIC6Kti8che/6Hl0rNfA2xNzTOvdg+UsQvs32ymxcgdRWoM51MwTnDFR/X+2CuLVFg2Jlurjm5pvaLe2THFMM11gMhg0y809/y9BsNTVYxPeZDJicyrRc4RHo4FqwrMmRtNhzI/WxCs0Od1nqgBx1jyKSV0hxi2Wslnd0ofOpBSG9wRf4d9cKFc/oOp8HpZwMVmp0FNLumSRRfX0a0nrT+ghzelNoSuG34QXlDlptTDG3l0AArfjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCZjj5yyJ+LHoX/sTjmDjC0qMc1QzhhF4mlTYMFq+ic=;
 b=ToV9ZChuZhqZqSxYDEKwm0toWEreoMrKsPNRDVdgQD9oepD+vJIRcCSs+QiboKoUvwsvO58tAB8YH8ZQmUH3ALcZSV+xVRkN6LLGQ4Pvqsv0r1hyo+DxzmdzghflZrAjpw/vSbqekxXGuoZJfZiYJLv9x/a0iHnZXhP78SP+4dg3qqSAygrowwhsyqWmQpy/q3a13zIxSumcAmJpZVpUU4tyxMGKc3n09sXT/8bWPuWsNOttmIrWcvCGFKRhd3WkiwZOTR8DW5vnuH6IgqHsuwCWay35LyumYPM+mvKSTY5p8aUJ+M4zeOuH06x4AWjDHWE23VmJxxw6VF5699hycg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8079.eurprd04.prod.outlook.com (2603:10a6:102:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 05:47:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 05:47:53 +0000
Date: Fri, 25 Jul 2025 13:42:34 +0800
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
Subject: Re: [PATCH v8 15/16] perf python: Add metrics function
Message-ID: <fui4zmtpolivpmrmhwwacahlh5ld256lhsd5pdnsvr4l3iicqp@lttgjcpumt4v>
References: <20250723232217.516179-1-irogers@google.com>
 <20250723232217.516179-16-irogers@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723232217.516179-16-irogers@google.com>
X-ClientProxiedBy: AM0PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:208:1::38) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: d1726fd2-500e-4002-7b30-08ddcb3ecc09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aacv6e8Ex7UkZWTGriX7FwDU593PH4iOEUwZvbMX1VCzgLPDjOUbfVoj8agu?=
 =?us-ascii?Q?U44c/p3F/ef3xuAaU1eEcCNLgxt60fiV+juasxGIY31V/SKzUb02TCEilYkI?=
 =?us-ascii?Q?uLyZ57tHFpr4OqPmYQ8nECy/pdX1Y3LIpKkAbt0ZhDmZwhJhsqJSfxnYTRbb?=
 =?us-ascii?Q?U0+6xsRos/gVVA5VvjC2x4Nt48IUBlYnCNCuwySxUkaCHArqp5OGqjc/QcQO?=
 =?us-ascii?Q?pHS09+eomoWXi0WJrullCUaBNS8PbKCY2kQB1lRc/LaN1qlWVxVPHuY5bOVg?=
 =?us-ascii?Q?Ap5oVXX/4d/lZoQ3WOa0Xr1DRHsovdKPNIaA1Siz+RYeNuaoxmY8ic2VpN+4?=
 =?us-ascii?Q?SjFiM+9Nhgj69nYpc3h88p/Zj/u9wzdnEbqW7mMYpGKMPcxXPR+zUcIHSxdQ?=
 =?us-ascii?Q?RBilBDlaJ9qgQlJ+EEj7NUuq+btA0WZ4eGd5vY90gT9iUElhKasAuozDZyeQ?=
 =?us-ascii?Q?6PDENpz9QhIbtytX6DKkSqlSy99E5IiTE4coA+4ug9RIR+/5szgs16meBRLI?=
 =?us-ascii?Q?v3jEJ23w0DT984ZO+0hKrTLhQpCUtG8FvVtQg5Jkw6koTPZHbjZ75LXS2S02?=
 =?us-ascii?Q?8CBUUS4VnLY2xo5EwQZ5hALYywVpH2NW4sWCjqgiQvxXtaBphpiL4wDOcPF5?=
 =?us-ascii?Q?Ixb6xVTVycbEw6zs5L7wGL5e4V8sN1vg9mgRwp5XpFjcBsDm/KB0fTq80ArS?=
 =?us-ascii?Q?u2M8lTZSNpcbpcFtcPM528v3TJlERHCFp8rWAjbuFjD8YIh+RF+dUa9VORMA?=
 =?us-ascii?Q?q41h1NSFIZZwBxJXOKTGTPfoiC6cK143HZucRPY1NDqfhKDcsE4QKF4Vylix?=
 =?us-ascii?Q?w1Lmx/rc2wXFKR48GRhFlKv0YNNT1jDqYVdtus7mS0Kgpl/Aua9KqTSHjCdV?=
 =?us-ascii?Q?tHBof5FE2mYwCHlleWX026YF0O3EMGxkWgpvxR8+qTWBNpjX+VH5cthAsjtO?=
 =?us-ascii?Q?IxIjJtUHtU60xBUwev1g4EWXoMr8KidtntPujmPPpT8fZkWpQckTP04lwKmG?=
 =?us-ascii?Q?KpQRlKAjyubwHzIHupNYtghTZqVlo+Gz1ROlrpsM5fNIqDNHpUdDc+sRL5d/?=
 =?us-ascii?Q?DjvX/s9Q9sCef2/Tm++nKqqvniE6drju5tE8Ek4yrZS1ULKMcfbTvh+e40ch?=
 =?us-ascii?Q?zzpNIaw5fGcfc0IrkpT/6nr+SziZfxittU/O1DLeLBRY2PBS9/nbCWqWAHt9?=
 =?us-ascii?Q?ZfwZuHdAQoqLU7T8VxdX2efIYXxkIb9d6J99J9S1DQc5bVNUmWr6nlUtnD1v?=
 =?us-ascii?Q?1hsd1gzMUdFO7r4H1yRo4iNY/mQBM7R4rdAAoLU0uhX7xY5BHhnhnya5Zt6U?=
 =?us-ascii?Q?f4vaFOFvzuf7V2kD11lxl0fPAOCAUeptp5XRgxEZC2YAIfsuseUK7nIhOIKM?=
 =?us-ascii?Q?f2MP53PrtoZP7vek1s6JpehT28KTJb6QA9xrHrTHEZMTI8BIwJcf9E0XFtNy?=
 =?us-ascii?Q?QCuON1oAbEVJQ0PYEG24o5B/UthBZla4H87QXl6A7UdUTVc2We9Q6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V6fmcDMzwDaweU0MUYgooTVhjrl60FJdjdWecXbJJiPJLm0yUq766cZhxPtJ?=
 =?us-ascii?Q?4bLaYLjM4UqrCb5zb5DbiCuNVx4moiresL986+R2005E07UlTr0uyqNMNrFo?=
 =?us-ascii?Q?9jnVCHnOBBjSg/PXKrJ34lsxn4kQqADP7qJ36lEyJhJh7YA4r9Y2jdAmCxop?=
 =?us-ascii?Q?uJSCq3JP+AWdynEk8zB4uPD6EAtXSofISAZGmdsnHsDHvm5hqCLft9wXAQkv?=
 =?us-ascii?Q?xH0eACC4mvj3bs56TioIwOWKxpWI2VFifSEO4HVSdplw3GgimFbIgGiO9yAb?=
 =?us-ascii?Q?/FkzYx6frck+D2mJcndbDYUoR2DFYfasrC2quF/W5oCqt7loyFTWhNMaDqf4?=
 =?us-ascii?Q?ciqEOS0ZywvUsjSlf21zDHw25CFHPR9an2Zrh5RVHHcM/4FprIzHwFf9b0JF?=
 =?us-ascii?Q?DEvOd09d04wUwaFml3WmPqdt0m8lCtQdeLCF4UaKX9oF1mM7iVEXg6OovBlh?=
 =?us-ascii?Q?nIYrnf+JFCtpeiD7SHCHp6e+qNkhtrQbMhtp+UJTpkLBmlaVbpP/wsJIBoJC?=
 =?us-ascii?Q?dLF5RQLUWibRqtJqNI8IaEWZMTfMTM2ICFsXyCmHAScUn/pSLEZ2nETLKdEY?=
 =?us-ascii?Q?d/NygoHjR1xBCQZVluEW9M9Omsb0Opc75WRqu1wwt1KLB0MigrXt14NQc0dW?=
 =?us-ascii?Q?GL932J2jPPUKqUU4qX/NdcsAjUE/MslC0O8shrIWTaXFmIdRQ2IKeh8/xh0h?=
 =?us-ascii?Q?2mtvNtWeJpfzdArQElgTzpVWC4WhTTPJo657epv7lOdBQ9ue8z2+HVuTELbZ?=
 =?us-ascii?Q?rsptIDx93T50FzqAeAQoKTUS08JGlXVQCEp1OZ3DnI37zRHXsHfPD+J193Ll?=
 =?us-ascii?Q?/Reztn4zgOrz+stR/VVUvEGDy92lXhpVUBiZTIvihTXUkvlJwxcvP+JppvGM?=
 =?us-ascii?Q?1TyWq/E6TYMHJPstecC+PCMfrSx4W2P3fmPPhphA4D98mGK5Q1fsOUjjDmgR?=
 =?us-ascii?Q?g/tNXhFWMBarr5fydRKaH7IS+c6p9le8i8SxabE9RBLMggWBBaHhBwi+gsvQ?=
 =?us-ascii?Q?o8FNR1pZki7JbsbpyyNboCYKGEYc/lHjmA8A1p48D5wYCo6Z4P8Eydi8ZzjP?=
 =?us-ascii?Q?2Xq3OThewFuS5pEOhFYMjqf7tkDJMGzP3NqwznvXpkjYl4qHHL8UAKG0q+yv?=
 =?us-ascii?Q?cAgDTQRADnynChc4guNgEK43+KAA4+2wB33NWycC2OKKSyEMq7LeA3fIclZK?=
 =?us-ascii?Q?jPbHc+7mUzk7qq+QvC11bebQwCv7IiwpAvVt3y/ZproFx1m3cv8zoZl7N2TW?=
 =?us-ascii?Q?kMYo85T9jAFY9/hK7ffDxJuW4bQYGn7FpyFvIwa4nN5elnrj/TdBaxAmw7TH?=
 =?us-ascii?Q?WO/QwyUv8jsx/UBQmlSuC/CY6SugkQ+Hkzb28uYUAWRKuw96GyN0nsa9UI8C?=
 =?us-ascii?Q?grXLszlL5CW34Wb6EzimRvokhcC0oiZaU/H4CmjH/+2QfAhmkymmFgGppMQp?=
 =?us-ascii?Q?Cu6l5eEqisKWhBggZcSNsNyF4bjBXO2fUQeMl5wgxTqdjEc7gFXRSLk3I6XE?=
 =?us-ascii?Q?5S/8J8Qrho/aJOCxOXWnFQUy7fIj3kzhzxagwiwuRFxpoBgfTTBFMYQRI0Qo?=
 =?us-ascii?Q?Rtjh5eCD/2oV8Dp+66hSryhkabS8Snm2XDseuFGB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1726fd2-500e-4002-7b30-08ddcb3ecc09
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 05:47:52.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6gyoEtv+YBTqdvDc33eYZyov7/Ds35JxEACMjvDdWiN2FteqzLq9NZodazg+5BmtwhYsi/dImdWWafyc+sljw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8079

Hi Ian,

On Wed, Jul 23, 2025 at 04:22:16PM -0700, Ian Rogers wrote:
> The metrics function returns a list dictionaries describing metrics as
> strings mapping to strings, except for metric groups that are a string
> mapping to a list of strings. For example:
> ```
> >>> import perf
> >>> perf.metrics()[0]
> {'MetricGroup': ['Power'], 'MetricName': 'C10_Pkg_Residency',
>  'PMU': 'default_core', 'MetricExpr': 'cstate_pkg@c10\\-residency@ / TSC',
>  'ScaleUnit': '100%', 'BriefDescription': 'C10 residency percent per package'}
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/python.c | 83 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index bee7c8a69bad..a8ba1379cf21 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -2073,7 +2073,90 @@ static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *args)
>  	return result;
>  }
>  
> +static PyObject *pyrf__metrics_groups(const struct pmu_metric *pm)
> +{
> +	PyObject *groups = PyList_New(/*len=*/0);
> +	const char *mg = pm->metric_group;
> +
> +	if (!groups)
> +		return NULL;
> +
> +	while (mg) {
> +		PyObject *val = NULL;
> +		const char *sep = strchr(mg, ';');
> +		size_t len = sep ? (size_t)(sep - mg) : strlen(mg);
> +
> +		if (len > 0) {
> +			val = PyUnicode_FromStringAndSize(mg, len);
> +			if (val)
> +				PyList_Append(groups, val);
> +
> +			Py_XDECREF(val);
> +		}
> +		mg = sep ? sep + 1 : NULL;
> +	}
> +	return groups;
> +}
> +
> +static int pyrf__metrics_cb(const struct pmu_metric *pm,
> +			    const struct pmu_metrics_table *table __maybe_unused,
> +			    void *vdata)
> +{
> +	PyObject *py_list = vdata;
> +	PyObject *dict = PyDict_New();
> +	PyObject *key = dict ? PyUnicode_FromString("MetricGroup") : NULL;
> +	PyObject *value = key ? pyrf__metrics_groups(pm) : NULL;
> +
> +	if (!value || PyDict_SetItem(dict, key, value) != 0) {
> +		Py_XDECREF(key);
> +		Py_XDECREF(value);
> +		Py_XDECREF(dict);
> +		return -ENOMEM;
> +	}
> +
> +	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
> +	    !add_to_dict(dict, "PMU", pm->pmu) ||
> +	    !add_to_dict(dict, "MetricExpr", pm->metric_expr) ||
> +	    !add_to_dict(dict, "MetricThreshold", pm->metric_threshold) ||
> +	    !add_to_dict(dict, "ScaleUnit", pm->unit) ||
> +	    !add_to_dict(dict, "Compat", pm->compat) ||
> +	    !add_to_dict(dict, "BriefDescription", pm->desc) ||
> +	    !add_to_dict(dict, "PublicDescription", pm->long_desc) ||
> +	    PyList_Append(py_list, dict) != 0) {
> +		Py_DECREF(dict);
> +		return -ENOMEM;
> +	}
> +	Py_DECREF(dict);
> +	return 0;
> +}
> +
> +static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
> +{
> +	const struct pmu_metrics_table *table = pmu_metrics_table__find();
> +	PyObject *list = PyList_New(/*len=*/0);
> +	int ret;
> +
> +	if (!list)
> +		return NULL;
> +
> +	ret = pmu_metrics_table__for_each_metric(table, pyrf__metrics_cb, list);
> +	if (ret) {
> +		Py_DECREF(list);
> +		errno = -ret;
> +		PyErr_SetFromErrno(PyExc_OSError);
> +		return NULL;
> +	}

Could the system metric be supported?

I notice that "perf list metric" shows some system metrics, but this python
binding doesn't show these metrics:

root@imx93evk:~/python# perf list metric

List of pre-defined events (to be used in -e or -M):

Metrics:

  imx93_bandwidth_usage.lpddr4x
       [bandwidth usage for lpddr4x evk board]
  imx93_ddr_read.all
       [bytes all masters read from ddr]
  imx93_ddr_write.all
       [bytes all masters write to ddr]

root@imx93evk:~/python# python3
>>> import perf
>>> perf.metrics()
[]
>>>

If I add below code here, it can be shown too.

pmu_for_each_sys_metric(pyrf__metrics_cb, list);

Thanks,
Xu Yang

> +	return list;
> +}
> +
>  static PyMethodDef perf__methods[] = {
> +	{
> +		.ml_name  = "metrics",
> +		.ml_meth  = (PyCFunction) pyrf__metrics,
> +		.ml_flags = METH_NOARGS,
> +		.ml_doc	  = PyDoc_STR(
> +			"Returns a list of metrics represented as string values in dictionaries.")
> +	},
>  	{
>  		.ml_name  = "tracepoint",
>  		.ml_meth  = (PyCFunction) pyrf__tracepoint,
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 
