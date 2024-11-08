Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8438DE0;
	Fri,  8 Nov 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731034682; cv=fail; b=IgHhlWyMu9oR4HkrO44/4oRpnk7yyic8MQccYY1+K1WvOvFyTwXYOgyQdLmFAI5DEySd+z0gjETny9UANhqzwio03ZNRCUj+tOorjCeNwI83/eqNk9WqkdsZPLXa5raXBGXCERp6w8JmPK9cgypUh+zslokX5i81RY8BlvQ+IOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731034682; c=relaxed/simple;
	bh=ouWAKfH0rq28Qm9d2OrHiaTbU0oe96NOxaF05tQY560=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oYNDwAM0RfhThSUqJBplgFDMwIESSZ5BHnv9g0qabtlGN7wIi96582phzF5lSbCw/J99/sz9UDH+aCqVxIWh/8V3WdiGq3BNrs2WK43DDLQvuKmNgPMSUkLUv2w0zt6mldJ98X2C+pLChgp3L82LDbLO3BTcOqUtGut92VxiXpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YRQjpR0x; arc=fail smtp.client-ip=40.107.247.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YRQjpR0x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz36aIZIPE3uxo/x99lDh2YhRPN+tDv2MCUEdQ/nOVfycQKJj0706Ma4hsLamonl5YJjeIfAzGi3IB6TCNqmUi3y/ECYbfTc3UPAW2Tpd+e8EkrwtnsXY7tG8LRSBzSpyid9b13RX7IrAFJ5rjf51IvNrvR9X/yOEs/y8vl+XYoB9KZj8RErCl0wu36qhxiMWvK5DHr92wdo3khkBdqVCR4kZJXYXY8FhJUysYAZhTNPshwlL6Idkh/4AtpsVGD73GJ9lfgsM0oxlTY5PiMEvVNR1P7aq4H+hAqv7ygH/Q92Nljfge/KvnZOmU155nMSjz2+dSvWGwdFP6XZ4QxYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUnubRNN8AuAhGJsvv2vCjimaf0THvxM/+YCUEBpKzw=;
 b=UkSYKN1gmrPVn1bR5AIfp+uvLwRjSYpMpw9VD+Cu1UCtQ3zOvtwTV3v8M4s0NWm0vSrcDSdfMhItx8/RkpplhSIQXK+tvrZcKdraG+e7Fe3us55/otLaWzBQHgtQD0tyjahgShS+3/6yv+IW97tzpMBvWP/pyhFEygj+CXBS7bzzqFJqn9zLWwLPFzdbjhW30iZq0SPtXcDWGtCBY/E9yguYqoJNFFXpOM9zuyHM2+NbJiH3NGo/1e1KcjgkaTwN5qMWwz9bZo4B2l1HZ5d5fhrr0cfv1XNW5Lc2aPhid2vfa6RSepUdqUU4sl12eiVdQoYuEYa0h0xYdTVX6RacEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUnubRNN8AuAhGJsvv2vCjimaf0THvxM/+YCUEBpKzw=;
 b=YRQjpR0xCv8ZCK0K123pbpPhPTGunNpfV62RnkyNq8eT3KaLxqLVjWG3kmfpk7ZbWBNGAoPl4oq6aagbI7eAgf0F4tr6KCPKSLm7wBpXlA+dXysM8HkGU95fJ/f1srIF7ALg+AyY24WzwJIi2SwSt9jb5zfCB4Q0K5z1XMaSRfMsqQY7CZay6L59SjUFOrrX7bNCFj/yXLt0+eKx8XZIOZM4ghp126lH4T6CJ82xpf1x/zU3v/93rmgQbX2S3kEWBH8iMYtVKlZN5HFSCjKEpoIRP3gmxzjTYTUy7RWdnqN1KC47SkkU6FOZOMfrOSUTYKpZQwYBmCjrOhjGSRvkFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 02:57:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%6]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 02:57:56 +0000
Date: Fri, 8 Nov 2024 10:55:35 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ian Rogers <irogers@google.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dima Kogan <dima@secretsauce.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
Message-ID: <20241108025535.wfhke3btch5af4fu@hippo>
References: <20241107162035.52206-1-irogers@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107162035.52206-1-irogers@google.com>
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA4PR04MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: a719aff7-2811-4cf2-c186-08dcffa12523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/D1MRNc0e0Br2OcV6pwZCnoFXwDPjrEdwq0Z8AF5clKgk3yqQ77zRZeCShs/?=
 =?us-ascii?Q?1VX1SKM7zDrW343ljP9XjlFNrGZnodhP+2TFwg5KDu5dCSX4UnrHcp8nD/Az?=
 =?us-ascii?Q?nekxUYGjVNfsp+D6QePPikP815dWcjo4TesYZLUaJNmC0di87nI4oydkLjgd?=
 =?us-ascii?Q?ovosxDabQArXG2JOqYLgSJNGeTkIbu/Ho5nGOC4AORkZM5EarPI2ImqVV5lb?=
 =?us-ascii?Q?ZEbvPJ2KuPhCyIGwEY0AxkL3lVQt4zj1ZON/PNcA3vQboIAgLJMkihwosZnc?=
 =?us-ascii?Q?sw6Rl9NwxdPF7DbszJrXf58JStUvWiCNmS8dVyP3Nptduwb8VrFu74sejfHx?=
 =?us-ascii?Q?12hwH2JQXYtm0ehES4Row5CZ3e4ZdRn1EeXGSJI6DAez1Z4eFPi93iuOiXqm?=
 =?us-ascii?Q?u2Ug6xhZsuOKQefGeb3iBoOo2yRiGUOR776cg2Ryl1L92mez4Eski8AEi8Ys?=
 =?us-ascii?Q?9wOu1Qz2aaBpRFVLXyeY/ZJKBg7DMXPyMiP2alOAuyUoWntI5ZanUvfjwtC1?=
 =?us-ascii?Q?vpJ3ES4wQS4gDGAvhSXRGSBz4XOna/XW07NG12Mb4v0F6r+Od18WD+WZ4YTz?=
 =?us-ascii?Q?J8BfeAkBm12jsp52Sae/BLCNASJMvlH7zIWP+Ajo27WuqZqV3+C5RIG5YuHm?=
 =?us-ascii?Q?UUylPKpCANacp+XIE/HpzLDFSMtYEae8DpjnIDOnrZAmxLT1clGpxN6CVTwv?=
 =?us-ascii?Q?9IH6pRM1HVPOUGvTN8G/3da9c+1LhUqrBfr1L6uTEFIRRj7Su5ir0QqAIvSj?=
 =?us-ascii?Q?256+n57ruYaWHxEEyefsP6DdA57RK4E2O93zyAk4I76RjE8Z2WkspCY+XiMC?=
 =?us-ascii?Q?QtCoixNuSKipbbGKsqJvcVTWhLXZjK7jxbaxPm8K3w6nAymUF/XUDaq0gldv?=
 =?us-ascii?Q?57UYdcB/BaZStyH1eCwi4Kzl513pAJxFu0/icoiyWX56cy/aE+MEKBfBvGdC?=
 =?us-ascii?Q?k2sFxfRn1J6OA49D6VPRGttkpytXEf+TZq9D472ZuBcVzshvElLBG8AmyMjf?=
 =?us-ascii?Q?LILc5nv9GzkY6hWUszLR0DCVhtezluwgKmH+eOBI/dqFrlRYVss/+hRfjNHe?=
 =?us-ascii?Q?A96T+3oA5iJnmSAAj4v2ZxFvB2GWiJja1Gl9nKWkEM7eafnUkjzWvKptwx57?=
 =?us-ascii?Q?rceQT+TjCfgYHyYbN4c2JEFwb7i4e/yHbJGJ/RKED48NuWl9H01tjn4NRU7N?=
 =?us-ascii?Q?8A6yt3ymq9S+AACTW6+LLlqsztKiSoMoQZHxEdPrQ1zMJeeCjKPPL4RXQj/o?=
 =?us-ascii?Q?z1QBMgWlUreYVi1xtbIW1+CKvr6GlY8B43YETnJBu4DzjdLiXhOs5SSm7xBb?=
 =?us-ascii?Q?tSneVYGSPr1j3Wq8xowUZxYGhix3Vd415+Im2uhSenl4UmMOvXxMWdoyUIOM?=
 =?us-ascii?Q?YKse6pc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSPB6/tTRKhCVoq0ntU2EDvXheywFf7GfHqMZqpMR7FaAZuqCo1/fRmk5W98?=
 =?us-ascii?Q?xC3PFIGGbnEsEAzonRT1FgL3O0gK+02jHIDB2/grw+HbGD2roZNE44Y3rs5Q?=
 =?us-ascii?Q?KBdSH6Apq3jftOrMH1jJ57ubKF9iqycOTYfE/HlOIcCYZ0ckew6DzzI07G2e?=
 =?us-ascii?Q?WlAhqvlW4vDLrytxbY8sw6S6pKcrZEGTW/VpLqZU2kL+5gm12DjXUV+UsAj3?=
 =?us-ascii?Q?rGOMyeKSFvyZVhVUlPH/IUMOQ73f9JrCFnuVDZKd4S0c60vfSOGNAtMTXkcL?=
 =?us-ascii?Q?JnmAJa4doDDgMTcavHRudUCpAt4mXxFugmRAZlyuugupoSvK4u9GZPjBfYIN?=
 =?us-ascii?Q?REFwsY1NGWzRPcknXAP7VPdiVZ+K7Ld24zmuBR8ZbGu0BbPn9McruCjSDhUc?=
 =?us-ascii?Q?WA9Cq+3/SuJHIqN/wcYeUHxtcsFLh/XoGJKKvdhiVeNYKEwGQJN80Wh21SKV?=
 =?us-ascii?Q?Ti2NZFNGqBRHDYXltKXmS54mEDKusGDz6DbiyQSbFMYkypwaGe4SKOm8d+L8?=
 =?us-ascii?Q?uPpd/Mhl5wJNqt3TTgMwetgSR5q/wpX3qEPIbtovpXBlx3h2U0f5NkBkdNfQ?=
 =?us-ascii?Q?ouEN+lHvbc2K9QHHhW09ef0643AXnIRW/Yk+fegNjqDygRZbZNE1SEeW0FEW?=
 =?us-ascii?Q?d2VoOYJkF/1NjnHilIqpHeMC6q/ePyJoHaxPv18onJzp68Xm9sQI+GVPNuJt?=
 =?us-ascii?Q?RMIw1FPd7TPDCu4n8tq54Fnj0GepDbUDVlCYRmFD+A2LwrKB2fCDzqPCVt65?=
 =?us-ascii?Q?BET/HKrhAk4GI+0SosZNjHmmwy0BH6+cCsMSTPwEOZ5TTA+Tq6TPKqKvHuiU?=
 =?us-ascii?Q?UGQGfLAdo9BRWQkG3hOh+TryS5yVheZEBZqiEIvqNYpIO06Vprb5Wi0yqI4C?=
 =?us-ascii?Q?g6pfdvkdgWnZhTVGR1lfIXeIy7aktHU8+TbSVCJ9lS5fllpB60DARV7EPDo7?=
 =?us-ascii?Q?VdbSKgq/MDO69S2I69Kpqt9ggXTewJacuMMgLG5F5cx6uW6qrUYrwBxzGv4Z?=
 =?us-ascii?Q?7W2j5ABaFjJZJSImiu00Z0ubxlFc/PDIwMrffDl/hrD2PbiCiW39nfz2hEyx?=
 =?us-ascii?Q?zlTNBVeRFM2UDxAun4UZuaQlQBwmIkwPQO35dYDK3U8XZ4pUSCgWVvIo2dLU?=
 =?us-ascii?Q?mw/ta6Vvm2vP/QZW3iFqzOwkofpIRl9wxz1lDdZhKNL3SV8ah3N/b7jlKunF?=
 =?us-ascii?Q?hsK05liOYl+VWu7n0eGTZOvS8CrIzrkoXPSoEcbaOQDUvP3ZZpvdSbEFry3u?=
 =?us-ascii?Q?xiOsXctxOS61t22q5Fr70tToPvHTwuS61BwQTFfLRp8SDlpd8DtdrITzk0dL?=
 =?us-ascii?Q?SYxWacy70Z3vge6zsd+5M6gZdVur3avhEzQrqF/ghOhWvO1lCA51CcjpymDS?=
 =?us-ascii?Q?GmjLP9jtfd+l74M4M6KDgIchC4rDYHGNCJl/7u9m7A+OjQCeSessDeFUGFNW?=
 =?us-ascii?Q?4g9FjisqEU6VnW+nq+t34bOKzHAQHde3HiGW0mIxJ5/ycP6uvWHT14lKemck?=
 =?us-ascii?Q?pauWhyfphYpQbYWE8BUBulsYmxv5lcatREj7SlJSw4Lz2WPxJCBIniieNAif?=
 =?us-ascii?Q?zfmhAgNbnZ+uF5Grz8E+NIz8CSsM2T81clpQTtKH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a719aff7-2811-4cf2-c186-08dcffa12523
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 02:57:56.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOybxuEWfVGcoyuDIDdHOE4UM8R1/wIhDYR3SyDntewoNns/dCG3WzLCby94rNp6tdXvdVa0ae5OToMmayrb2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7982

On Thu, Nov 07, 2024 at 08:20:27AM -0800, Ian Rogers wrote:
> Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
> lookup:
> https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
> These patches remove a lot of the logic relating CPUIDs to PMUs so
> that the PMU isn't part of the question when finding a metric table.
> For time reasons, it doesn't go as far as allowing system metrics
> without a metric table as a metric table is needed for metrics to
> refer to other metrics, and the refactoring of that resolution is a
> hassle.

For this patchset:
Tested-by: Xu Yang <xu.yang_2@nxp.com>

Thanks,
Xu Yang

> 
> Ian Rogers (7):
>   perf header: Move is_cpu_online to numa bench
>   perf header: Refactor get_cpuid to take a CPU for ARM
>   perf arm64 header: Use cpu argument in get_cpuid
>   perf header: Avoid transitive PMU includes
>   perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
>   perf jevents: Add map_for_cpu
>   perf pmu: Move pmu_metrics_table__find and remove ARM override
> 
> Xu Yang (1):
>   perf jevents: fix breakage when do perf stat on system metric
> 
>  tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
>  tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
>  tools/perf/arch/arm64/util/pmu.c         | 20 ------
>  tools/perf/arch/loongarch/util/header.c  |  4 +-
>  tools/perf/arch/powerpc/util/header.c    |  4 +-
>  tools/perf/arch/riscv/util/header.c      |  4 +-
>  tools/perf/arch/s390/util/header.c       |  6 +-
>  tools/perf/arch/x86/util/auxtrace.c      |  3 +-
>  tools/perf/arch/x86/util/header.c        |  5 +-
>  tools/perf/bench/numa.c                  | 53 +++++++++++++++
>  tools/perf/builtin-kvm.c                 |  4 +-
>  tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
>  tools/perf/pmu-events/jevents.py         | 39 ++++++-----
>  tools/perf/pmu-events/pmu-events.h       |  2 +-
>  tools/perf/tests/expr.c                  |  5 +-
>  tools/perf/util/env.c                    |  4 +-
>  tools/perf/util/expr.c                   |  6 +-
>  tools/perf/util/header.c                 | 82 ++++++++----------------
>  tools/perf/util/header.h                 | 23 +++----
>  tools/perf/util/pmu.c                    | 25 --------
>  tools/perf/util/pmu.h                    |  2 -
>  tools/perf/util/probe-event.c            |  1 +
>  22 files changed, 189 insertions(+), 229 deletions(-)
> 
> -- 
> 2.47.0.199.ga7371fff76-goog
> 
