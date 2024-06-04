Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D2BA39;
	Tue,  4 Jun 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491010; cv=fail; b=YS15H83uEuzBB8SFicywUxV0Z9NpexZk1NhKUezgXngx7NFCGhk13VucSaVPOnOxhpJZt9ETfFa1eyd52/eA79tgSYWUB6kGE1YwVX7m5OphLnXy3mk2aeXSQAtufgrF7xko9aiD5n7/EFiHFoiEFUTQJK8QjymBs42GARBSq4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491010; c=relaxed/simple;
	bh=g2Wj5U60qTepDXzgdrQGKVPLB1Gl4G+h6DkbmYLHusw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RfeW5fyqGmfRU9dk+wL4/ZgLi1mOn9VEL2MmZIGRfdau9BCtDkooNcfHv0iJZo5f7rjFo3EUZhrKXZeZChrhpur1fVZQowPLMfmYKAT657bXN5jmYfJVPuUSOaVlTiavbOIvmcmvP6QD+jENPwhDRjrehBHxWcbj3jlv9qgCSHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YqRp2jnQ; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YqRp2jnQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYctWApK6CuAsB0zMs1uj6XMeqZKhyfggyl8OaHtWRna569WUPLddj1IINpbWzsq/zSEUvKtym+eg1fwWHzmOj/NCukLakti3ME+QAnGz8XSuSEvSgueTxP1xqX9dh4elD8SzSv7nVuMyiKApnLznOuhMPXWKUWQ50se2OBlnnHU+ttkgose+os5QhUh3Cf63vAMILItGPz5Nc+beYFBoYkhiTLljqAYHKz0TW2qiofZv9PeOmLQLIqRx//2bAbcYSjFcL8QAM/KdmFtty6lZQv42fczNru15zjHRrdHYDBR8qqw5Wp8CLuHlfCgVuvDLqFtmxXJnyTi7eoXmOVnvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma4VkIModAHkbSeFvTtM6VgcKldTFKxuFLI/MesELEw=;
 b=RqV0W62rPKlqY9XJ3TmaII+QZ6IX7QsbEF+JFI3BMbHH9zIm7Jl6y8+ORd5EykPKsdtVyM1W4o6r3LSQzP5EUE0SLqFCnsKhwa+LSx/yGRzYAz+c6s7zaNVjViFsskOPZCRfuxT5F6OTvMR1L4pmfzM7StL/AeRB7wTgaQw8mb21MtLYlPvY/3frLlMr9r+E4Kr4LaJclxWqF7zKwE6ZmyJPdaRsuOoRZEbSyqDadbYBipTDV1+IDO9syUjC164mwZu09E1UfatQRD3S1XU3T24kvQarX/a0kIo4G6yxwmdeAgqLMjuChm8m4k/TukwqPo7aWe5QUjJjnngweQbSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma4VkIModAHkbSeFvTtM6VgcKldTFKxuFLI/MesELEw=;
 b=YqRp2jnQCV6n+Om3hbW53X+A8u2bgh4xnG7X/WrTlIDup9YFpe/fSUn/2D6NYVRyY2EQYEeJkIcPMHurIAcvcrXnX7xpDt0+y+3vS9dYEENzpHsFn62wXh97shjKVRzStl5Kmv31zF93PSHHPX/l0A3kKqGwH59rUzwWxFmPUzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8724.eurprd04.prod.outlook.com (2603:10a6:20b:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 08:50:05 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%5]) with mapi id 15.20.7633.018; Tue, 4 Jun 2024
 08:50:05 +0000
Date: Tue, 4 Jun 2024 16:48:20 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ian Rogers <irogers@google.com>
Cc: Jia He <justin.he@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v1] perf pmu: Count sys and cpuid json events separately
Message-ID: <20240604084820.u5v5nvcpcxrlu2oi@hippo>
References: <20240511003601.2666907-1-irogers@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511003601.2666907-1-irogers@google.com>
X-ClientProxiedBy: SG2PR06CA0238.apcprd06.prod.outlook.com
 (2603:1096:4:ac::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa3d004-c711-4b35-a2b4-08dc84735416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TP0J2fDO22AoN6LkyMaeKeTWuhiDhP5+wpBVlAh9ilyWXSSK8fJz6Z0QzDRy?=
 =?us-ascii?Q?Q5INZbIkfLmh8QAagUoLWvaz0uNL7qgcyAoubK3eLit41DIs6X0IhR++FXVA?=
 =?us-ascii?Q?BSlL1+yk4hU08B7wzfQYd6cwT+jlyvEVwr0w4NqQs+VmzPx60/8Z6k88Zgus?=
 =?us-ascii?Q?vfLAgQKg3Mq5SnBYX7exlTOGcY2eolSE+tu6ZjmKzI9dZoaN+dIXFe/kSq1z?=
 =?us-ascii?Q?gO8ipbH8iv8TpdmZJcdOGhFoKx8WtuvRmrTF/AMQnUKxkerPI7sCLP+FV6j/?=
 =?us-ascii?Q?s5I9q4dUf9fHRrLQcX1HIck57/Phwxigww3MuzF+UMmA2DlUq3F0ZixaAEKA?=
 =?us-ascii?Q?qUodAdsQAb4rZPDnxN4YkmTiNwzEBThuT0hBzJbyBYen9KXQHtRLGQ/RB942?=
 =?us-ascii?Q?oIjNJN8xVCZjC8YrhPDsoJoSljHZQjKBpLoBANLaJgWVLekehxxgaJ7uy9ml?=
 =?us-ascii?Q?DxrtXiie0Q3smS4N39KQW5rw6H+FW3GFbHtNM55ZdX+ta1MR9FoaWbxs2+Zh?=
 =?us-ascii?Q?u+0t3hKw9QoHg0y+u6lHDSKqM12FCB4++/VL78y1tBLuHQRh+Cw6T4DbHMwE?=
 =?us-ascii?Q?eOk8evEmU5tmA4l2lwgLp/FjsRa3EUge384It1M0uwyKcIs1ouJPixeoDkiz?=
 =?us-ascii?Q?zgYY4r0BGHrVxPZMPjawz/xGZldmpUzUKg3zPVc552NLDDCRMBn7orBYVrvx?=
 =?us-ascii?Q?IcAQz0nHRagt88VwXeREUxU5PADk/ElQDxGUSk6vKsKBxYKKJCXSUtPGbhjT?=
 =?us-ascii?Q?3tjjs2SoquUiJeaRYCXOfzrRM/TbK6guEjtMfgbn0M1mYePI5VMmk8BGnjxM?=
 =?us-ascii?Q?1KSk5k34svt79FTsJTogJppDmVlcX1uPq5hI4ERda+5g9w4KTcVOmH0Q41A5?=
 =?us-ascii?Q?nTL7MDj6+5RyFRWyclp9kew+0AKy/Ky0voQBl0Pu1jAeegZpYi4VNJ6p0PM1?=
 =?us-ascii?Q?svppAD4AfGXgfzwNHxRsahzIWsTL5IH3Yd4gefweb8yAm/vT2srom9PaBYPS?=
 =?us-ascii?Q?mlmYA7xrp2P+GTZ9udP4X16reVKodu26qgqICOQWEF8Ew07MS+RKvRuMc76b?=
 =?us-ascii?Q?4Kl00x0k9t1pfII2qG3y7bEMBZhyJRORzwXrCHG3OK36KxIqKL7yLWt24G6U?=
 =?us-ascii?Q?BGE3ihctpcabVunnS4YBfqY82oeIPTkeW9Nrjd5AzuDiPhYrgMN8CCHQ0Skw?=
 =?us-ascii?Q?os/Yyqu7UiYVxY2AKIVIECm3FEP37QLTyt1zx8GkqHqPcAJE4UkFNJvC6VoJ?=
 =?us-ascii?Q?M8a3ygJFJVdPgvfNlxg+GAz6yh4d95vjCYm6/S9LIVFZQXT5yIU/60OwTMO1?=
 =?us-ascii?Q?HUSSH3bYmbEQlFzFDOFaOF/ebFBfBJpZMEdD9GnG2FI7cQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6OEjKlkILK9A2HPFArHu1F+GvF28Uf7d7dAoTASLgZi+k1SZgL7EgfY9Oy/C?=
 =?us-ascii?Q?UJ9jV+IbCT7647F2/OJYfW0UhYAy7HsnyfRFkblsW9hLgJ3nnj3rhpZL7AjD?=
 =?us-ascii?Q?LBNbRGW6hACT4hsGircRrumv6GL5MgCDTQFx7Y/qYNUiPHs1/dHG5ChJmoMW?=
 =?us-ascii?Q?orUGqGtjDdq9mxD0Zkxlsx5e7T55dmMwIJOwf5UlYEwg5qVvsFcuAT5yJ8yW?=
 =?us-ascii?Q?I8yx46lLGjHuwJ/FgtgP3eo7SW/VjXHbPqG941ByyMNYzJcMec3AA/EhHayu?=
 =?us-ascii?Q?hgxPwAjgk6YFjLbzUu/0496VHMiaPN5vShP2KihyIzW1tJIVplZulNd1pBxE?=
 =?us-ascii?Q?Wnux2vV3C3wQwlHUyprjp7vqSinvbAEiW/YsVMYvNqrxu6SmblVilVEhkOdj?=
 =?us-ascii?Q?a8K37I8VZDSbC3a+wNrkdpkEFItTHP8Nekxhnjd7i77e+D1WtUqMVdzZS9t1?=
 =?us-ascii?Q?3xdCnQsLR6XndsZeaPNSAzfovWqiJgGF+2pRvuNWcho7Kh9Iru6U0hxjPTGl?=
 =?us-ascii?Q?HthbqKEfQ9mtpbyUrxRdYGLDoXL4rjJXWNm2pqQ2aWJzsA68Z3yI8K8Ofcm8?=
 =?us-ascii?Q?DMFIe8E25I0164PuxopeMaDePSsuZuuh0btl2dFf3VcJraH+BmLe4y5O6A0x?=
 =?us-ascii?Q?O0ywc8bv2Z9de6z3hAdqUxbM+/UKQqpQUdZmyK8eKsMdK3oLBybaRs71mAsA?=
 =?us-ascii?Q?gs516F+ZXXL2HCnQ8Tp1hxADyr7A/HOG0XU8bPWeNr4+UftfPxNLqbcldL/w?=
 =?us-ascii?Q?KGI3wWKz0I/lWWUsyDhMxWBo9G4SXdaMUB62jViY83PtCHBOHOAn08jCYA/1?=
 =?us-ascii?Q?YJ4ogPOpt/9hOx7TjLK++EoTOo0TXVscrnrs9gYrhTMKsRRKHmYdqXhLdNlS?=
 =?us-ascii?Q?b4q2LDxIMc4BogyRY5GNRlU4LvK12m0UDyubUl224YZfNwNp85k8RuvBpU2w?=
 =?us-ascii?Q?nKumJIHck3YhdW8MReok6vbqEXEZ5GoM29K7T/wqkf4KRlTZMmnXEJx3d23o?=
 =?us-ascii?Q?9/kejavGFslw90kBiljKzZ1qmv8VOFJ+ny1jib7VOuBS+oFkA1/af4cfWdsL?=
 =?us-ascii?Q?ng+twX9WAq/uV7UQH9BoK/LOA9165q7qZ2VbfAtMibGGBMm9xqIrOaN5NYr+?=
 =?us-ascii?Q?isV2njF8xLzczmJVcraSml999VbDiXX7CDbmYswUwDEtyEqydxLnVY4O/0zU?=
 =?us-ascii?Q?2x6Q4c07NRewxKF9XCOUXdhw03RcS8daUIIcfE4uHFePVDBeGT6BbMucDQto?=
 =?us-ascii?Q?fMerxfYGx72wT8+D7R3+SAkyYcrjv1L7pE5R0xBJDvO+G2jg8YEAcOLKq9Yp?=
 =?us-ascii?Q?rwqgzVVdCRcdCOdfIJXGUXfkLV3sQGRXAwYRmHDz0X12Ojr9esDe20JbRZ2L?=
 =?us-ascii?Q?Gaihopzy/c+u9k4plxHyNSoUG4L9zQskdUVYKhS/eBC+rVnejx2KjxOT97Yt?=
 =?us-ascii?Q?3X5kwL7l0khNbFFvFnX1/Xxrm0BjHVxYy14ZVD+chAio2IZYrFi2Egt9IC0s?=
 =?us-ascii?Q?ufyoLT6BIZUHfqLK2Lt5V5fVvrcVix39s4ph/SRjrCvZVRZg01b8iEPrEyzc?=
 =?us-ascii?Q?wyLzR6GHhbP1Oq07b4K2K9i6T0Z7Tjq2OxxwW1Xq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa3d004-c711-4b35-a2b4-08dc84735416
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:50:05.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7sOT2hwszbunOzAwhagPB9GX+Qs1mgryOPksUTJIO9ZOoNb0JBttO/ru2Q7kwcbD+WOHismN3pq7I0MEd8zog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8724

On Fri, May 10, 2024 at 05:36:01PM -0700, Ian Rogers wrote:
> Sys events are eagerly loaded as each event has a compat option that
> may mean the event is or isn't associated with the PMU. These
> shouldn't be counted as loaded_json_events as that is used for json
> events matching the CPUID that may or may not have been loaded. The
> mismatch causes issues on ARM64 that uses sys events.
> 
> Reported-by: Jia He <justin.he@arm.com>
> Closes: https://lore.kernel.org/lkml/20240510024729.1075732-1-justin.he@arm.com/
> Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
> Signed-off-by: Ian Rogers <irogers@google.com>

This patch also fixes my previous same issue:
https://lore.kernel.org/linux-perf-users/20231010065738.2536751-1-xu.yang_2@nxp.com/

Thanks,
Xu Yang

> ---
>  tools/perf/util/pmu.c | 70 ++++++++++++++++++++++++++++++-------------
>  tools/perf/util/pmu.h |  6 ++--
>  2 files changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b3b072feef02..888ce9912275 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -36,6 +36,18 @@ struct perf_pmu perf_pmu__fake = {
>  
>  #define UNIT_MAX_LEN	31 /* max length for event unit name */
>  
> +enum event_source {
> +	/* An event loaded from /sys/devices/<pmu>/events. */
> +	EVENT_SRC_SYSFS,
> +	/* An event loaded from a CPUID matched json file. */
> +	EVENT_SRC_CPU_JSON,
> +	/*
> +	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
> +	 * file.
> +	 */
> +	EVENT_SRC_SYS_JSON,
> +};
> +
>  /**
>   * struct perf_pmu_alias - An event either read from sysfs or builtin in
>   * pmu-events.c, created by parsing the pmu-events json files.
> @@ -521,7 +533,7 @@ static int update_alias(const struct pmu_event *pe,
>  
>  static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>  				const char *desc, const char *val, FILE *val_fd,
> -				const struct pmu_event *pe)
> +			        const struct pmu_event *pe, enum event_source src)
>  {
>  	struct perf_pmu_alias *alias;
>  	int ret;
> @@ -574,25 +586,30 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
>  		}
>  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>  	}
> -	if (!pe) {
> -		/* Update an event from sysfs with json data. */
> -		struct update_alias_data data = {
> -			.pmu = pmu,
> -			.alias = alias,
> -		};
> -
> +	switch (src) {
> +	default:
> +	case EVENT_SRC_SYSFS:
>  		alias->from_sysfs = true;
>  		if (pmu->events_table) {
> +			/* Update an event from sysfs with json data. */
> +			struct update_alias_data data = {
> +				.pmu = pmu,
> +				.alias = alias,
> +			};
>  			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
>  							 update_alias, &data) == 0)
> -				pmu->loaded_json_aliases++;
> +				pmu->cpu_json_aliases++;
>  		}
> -	}
> -
> -	if (!pe)
>  		pmu->sysfs_aliases++;
> -	else
> -		pmu->loaded_json_aliases++;
> +		break;
> +	case  EVENT_SRC_CPU_JSON:
> +		pmu->cpu_json_aliases++;
> +		break;
> +	case  EVENT_SRC_SYS_JSON:
> +		pmu->sys_json_aliases++;
> +		break;
> +
> +	}
>  	list_add_tail(&alias->list, &pmu->aliases);
>  	return 0;
>  }
> @@ -653,7 +670,8 @@ static int __pmu_aliases_parse(struct perf_pmu *pmu, int events_dir_fd)
>  		}
>  
>  		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
> -					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
> +					/*val=*/ NULL, file, /*pe=*/ NULL,
> +					EVENT_SRC_SYSFS) < 0)
>  			pr_debug("Cannot set up %s\n", name);
>  		fclose(file);
>  	}
> @@ -946,7 +964,8 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
>  {
>  	struct perf_pmu *pmu = vdata;
>  
> -	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
> +	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
> +			    pe, EVENT_SRC_CPU_JSON);
>  	return 0;
>  }
>  
> @@ -981,13 +1000,14 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
>  		return 0;
>  
>  	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
> -			pmu_uncore_identifier_match(pe->compat, pmu->id)) {
> +	    pmu_uncore_identifier_match(pe->compat, pmu->id)) {
>  		perf_pmu__new_alias(pmu,
>  				pe->name,
>  				pe->desc,
>  				pe->event,
>  				/*val_fd=*/ NULL,
> -				pe);
> +				pe,
> +				EVENT_SRC_SYS_JSON);
>  	}
>  
>  	return 0;
> @@ -1082,6 +1102,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
>  	pmu->max_precise = pmu_max_precise(dirfd, pmu);
>  	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
>  	pmu->events_table = perf_pmu__find_events_table(pmu);
> +	/*
> +	 * Load the sys json events/aliases when loading the PMU as each event
> +	 * may have a different compat regular expression. We therefore can't
> +	 * know the number of sys json events/aliases without computing the
> +	 * regular expressions for them all.
> +	 */
>  	pmu_add_sys_aliases(pmu);
>  	list_add_tail(&pmu->list, pmus);
>  
> @@ -1739,12 +1765,14 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  	size_t nr;
>  
>  	pmu_aliases_parse(pmu);
> -	nr = pmu->sysfs_aliases;
> +	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
>  
>  	if (pmu->cpu_aliases_added)
> -		 nr += pmu->loaded_json_aliases;
> +		 nr += pmu->cpu_json_aliases;
>  	else if (pmu->events_table)
> -		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
> +		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->cpu_json_aliases;
> +	else
> +		assert(pmu->cpu_json_aliases == 0);
>  
>  	return pmu->selectable ? nr + 1 : nr;
>  }
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 561716aa2b25..b2d3fd291f02 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -123,8 +123,10 @@ struct perf_pmu {
>  	const struct pmu_events_table *events_table;
>  	/** @sysfs_aliases: Number of sysfs aliases loaded. */
>  	uint32_t sysfs_aliases;
> -	/** @sysfs_aliases: Number of json event aliases loaded. */
> -	uint32_t loaded_json_aliases;
> +	/** @cpu_json_aliases: Number of json event aliases loaded specific to the CPUID. */
> +	uint32_t cpu_json_aliases;
> +	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
> +	uint32_t sys_json_aliases;
>  	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
>  	bool sysfs_aliases_loaded;
>  	/**
> -- 
> 2.45.0.118.g7fe29c98d7-goog
> 
