Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7581C207A11;
	Fri,  7 Mar 2025 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339126; cv=fail; b=FxvRisXXtPGptAslt5sBLLhZwm2AICSJiCIgSWYVAh5c8yW/ZB+E6rcAuWNPSMaMwkWQZ5QS8KEOljS1001JyClmvFAmwIp9sA+Boeelz0BXBi3MEkWkieYnAqHBeTtIwt+k49HJNoSbZsYND/s0x/t+vULpQqn+7EuDqYJWwzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339126; c=relaxed/simple;
	bh=uSmLhSW73OZpLRx7AWXo3KqtrwUwu4AVZeUh8NdfPvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ovEdVN4YvBz0pgV4L+RdpFtDbXsNSfshm5drVvQ/5t5e+rZyXPI9Lvt9J1e9dtUYiEsBYRw/PTeeYXBrRX19XV32mwM1gZwfmc/lpRe57vsh8i0YqN4/1WUxdwrLcx/NLOKirxiYzMwKp0R/mssqEawwM7XT2G0QAbGBfJJVtFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEHds2ee; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEHds2ee"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741339125; x=1772875125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uSmLhSW73OZpLRx7AWXo3KqtrwUwu4AVZeUh8NdfPvo=;
  b=kEHds2eejGfWLIv4eLuLW9zlC2/OzhpNU7o+AcF5DWFMFktufvG5pVA1
   KAuMwZXhbmDHizmuBeX8Zzm2cSWjdnwvG5HA7e+gMZYMNPsRSUxhCtS7f
   6znLOjnsueBtP9Kb1MBFb6OyIOYEYaLwvwjPh6XTJGCG8E4ShL4iaWuqc
   YN/aUW3dwJ8SZWdTz9iAVOmQbrgSYg9/LbVwSTaUzRXgE20JJleaIsvOO
   8gnOWHQaluqiQlDxvZmPbzZ8MY7mmwEDlUT1js0H3joPTPv5c7nFwTIWN
   hl24reObcKB5u8lIT70jhJKIcwxeVNd+0DI7pcZtWRHYfATGIhlP8EIAW
   g==;
X-CSE-ConnectionGUID: KVl5BnqxQzubf56bKqYepw==
X-CSE-MsgGUID: H+/fPNnIRYSedvowM1CHJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41549252"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="41549252"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:18:41 -0800
X-CSE-ConnectionGUID: Q1U0YxoxRB2Z2g8IRM8vMw==
X-CSE-MsgGUID: mJ7jr2YkQBurjon+IN6WSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120193767"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:18:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 01:18:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 01:18:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 01:18:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez5gZR7KjfjiKeojr6UCVyHZNQLtWZUXkQghmzwRoFFPVqL0ydIeTQofzbuFiLDHrxufxbQCVyzQh0tXikAp3Xl8w00l4C1L+jDim3hexh48hJsZcu8OC4e7x1fpGdCMRwVguunzIn8h5j1PKMvoCsY4nX+AJoz/lBiFDKBtfGWzhkNHiaL8AWjfRMZdrd77P6GnJpBX555Pq2A3R3tWH66Zr/yEYPsyAOhBZbfwl+ug32rjQOq1OmaXy2SY1sq1zjJr4okUuEYyQjQRBg7vdkrAaWhObFcz/GmGN1FD8CHvl7TU3TMSrbq7CyshfPq8UevOk7MYaUHZZ8ikwMcppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Nfk0qY75l0CxuJYHMeRPTp78DJepSnCDdtEUinswc=;
 b=xKdI22MuYarlbs/dwBa8NaPjWw9zYsXeRpSLZoZSkh2IxNDTng9d91gbQwISwN9dKMs3qb1ywHBmgfSEBJHO39G4UlQNLJ5lkLC5k2ykPcDDrMehf6uODoKkyf+6E1uDKC+wU+MlRP2gA4BgqgE2O7ehOOoevPLjUJT6Y0IHRj0X8IsUL0il0SN4b/+Wm55UJOoNvaZeNgwIFuSeFMe+1eZuFqlRUkU1du748utDgFBSo+DpT37e3ZqLsYYOAvpCHaqTzhQWVN5P75AAIaMHEQbeRv8IoZf0C5Bjm8sFiKfe0wBZEhA61EKNdjIT7DjgenY6zFHf5xiz7SDEh6IvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by DS7PR11MB6061.namprd11.prod.outlook.com (2603:10b6:8:74::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 09:18:22 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::1835:328e:6bb5:3a45%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 09:18:22 +0000
Date: Fri, 7 Mar 2025 17:18:12 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	Martin Liska <martin.liska@hey.com>
Subject: Re: [PATCH] perf script: Update brstack syntax documentation
Message-ID: <Z8q51Mcz/9QenjnC@yujie-X299>
References: <20250225061736.1698175-1-yujie.liu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250225061736.1698175-1-yujie.liu@intel.com>
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|DS7PR11MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 713a0455-edaa-4791-5ed4-08dd5d5901db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dnP80hb9MXMcOU7GhEqb+E9NNSDVeXyfZ3oq5o+GwPiVZlCRK1xvaNF49j+S?=
 =?us-ascii?Q?GYp+v8FFKo2eUEn23zuzvBslr8uYq8mtJs1ONk9Wsg5df4FZ4uZ0L5B6Ftv/?=
 =?us-ascii?Q?+6OYnkwAVFadrD9aAm97EmazchAt86W83TM6H6nNvNnlC+U+nIllT/eDmLUs?=
 =?us-ascii?Q?WgYyB6KeHYg4kqoOleZHwdoAqfl+ixXtWwxJ+E7KZ0OXJOmx4ykHiWcDbfhz?=
 =?us-ascii?Q?2YDpQWaBV0sn276Z6Xb+orO9oeurMTxI7/9uYf2/B4jBmpF8QOq7eZ8z4fXV?=
 =?us-ascii?Q?lNfmGeyKeLYTuyhipR6thXOfi2uPbzMtEgXlZrKxiqcjo0XYHP2bzjioCT2k?=
 =?us-ascii?Q?YX7Edswz97wrSxr1ISkJj84nAKGDGBtZqj2Zv8a+snYSdIKE/YYRZjR0G7zq?=
 =?us-ascii?Q?pFkOZAm+Wk78+I5sonvEAyuDy7M0FR7BOxN6TOfNtHe29YP/isFieYPn+PXV?=
 =?us-ascii?Q?H3qjde157oTYmilyOrXiljk0z5OHKYpnrEwaENXSvw/dpGpU8XqJY4EKCYIg?=
 =?us-ascii?Q?WPUGwaPeAM1liU18pwW+DVLRHHxiWn3tDLf3VnUrC6jIiRdotVpUJA/SLGuq?=
 =?us-ascii?Q?IKavZrOLPjFgFAB5GW9UVK1+M9wQGWJW84AcaNP4F0iIbTZ1Fn1Lbcmj3wXQ?=
 =?us-ascii?Q?swYodw6Qe6sqrs6Ypl6aOcFWkuwaJ34n4z4Dk4rji542ODhZRyKUIncmMYQk?=
 =?us-ascii?Q?vy938/EQYBfuuWkESVK7NgoZlE4O7k9H7T7+DC+JsE8ef60T3rV384yCOXmT?=
 =?us-ascii?Q?Y3/Gthy+spJVlHtp3r+bAKJrVHkhAIf9KZ8FWMN7o80Hyo0muYzB/cOC9dth?=
 =?us-ascii?Q?T7dui+n6ZJZkO20pPuQ3w6Hjqc09BFubnfg9z8iHtn5j0YfYF94XrMFpdBeO?=
 =?us-ascii?Q?c9tlPc6m7AhNNj4jIry4BvhrhpKi+JCbLhfS2hzlArsjIEnVCWiLwM7+Upaq?=
 =?us-ascii?Q?5+DuyxHzm53uHQ1hmHlKf8NdD1yB2fSfJKHXwEBYGKM4yd5z5GmoyosA4P7R?=
 =?us-ascii?Q?b9C7wJBsx++8Ju0N3IwbR1DZtY8WsmiB5Jx4FY/4kmRL6tD+AvXEIyFeUXpH?=
 =?us-ascii?Q?5NX0/WSJzhIq0ypzKb0CCxwQaOTRUf/blh6D64gk7y6eyQhhAq2E3skX1IfH?=
 =?us-ascii?Q?DcnPV7UT4zE0EGBd+Y8/+oOBaxJjHsfWUDgIcQz090HcsUT73f8fMzgbKoO4?=
 =?us-ascii?Q?wggLcQSmmWBPeM8CWPtA9D7Rd4lkdyGnTMAN/XPZS5jVJNTwnj6yy/IOu/o+?=
 =?us-ascii?Q?oSZYTK9vjObj51sqM7hXu8v8ESYDnpBrktD8lmVRjCrY0rcMij85bczYq6M6?=
 =?us-ascii?Q?iKnC3mk97kK1J0TGUVdYsr9sUbW5Mb0tPOsYRvPLjP6274nKjdF4F5j0LXXp?=
 =?us-ascii?Q?Oq5+ts2bZBOO5CqpPtzm5vZ6ZvsT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDAV0lxC5TM1+Z8E0d/ysIHF1TbkcqwOng8L6QBQvpnGYGxCXMsEYWpjytVd?=
 =?us-ascii?Q?aCj7Uf6B3zZyve0NKpjVDxEv/XkKLg/DxpBzqtJzCAGniqbbyhfc333rGN6l?=
 =?us-ascii?Q?lvqHGPqDRnVbaanCxIp2BX36ApdkwEZ8VMS6a3fCaP4mL1Ar8sca/AQOrhGJ?=
 =?us-ascii?Q?00unDvMtGEOgxs6+6T26hdGwfX2cujNRKDYF9upV8/fdTm/uXhjujV9v8X56?=
 =?us-ascii?Q?n/vDdRJ+gqAmGa7zCnvrWsM076uNwHg51joy/ZOsZ7S0BKIa1xp3+ZwmT9pM?=
 =?us-ascii?Q?oSz6v2wMPdyXIsPHOQNOEGadluEugqJaVh0+kQT2vQWZ6AI9Cy54R2ppSX+f?=
 =?us-ascii?Q?rrP92IVDg/JR8t9JmxUa7adktks4qIjVGKDn+zu/jwwdxDdVZoVaE4Ti0dFs?=
 =?us-ascii?Q?RMc0+/25tug5ULyHJLJ/Uw6mHlMRd/1NRwoSM1val0rsqDDFCXKuiSMdOj79?=
 =?us-ascii?Q?xI18qbNVJJGtoojRAP4hjD5lMN1xT+sCyafGoCxOSy4ByCBvkoLiJq4EVBmq?=
 =?us-ascii?Q?Jg/NXM2jUq306+RSM3+4GGaJdwvjp69EDtIzrvuiwMvvFcGnDRZGd/O0iR7p?=
 =?us-ascii?Q?Z178cXJGJEVllvC64Hw24W6aJaK/kyqvyEfosNF43X92Jpj3IIOw4l4PUQRz?=
 =?us-ascii?Q?B/ZfVhLOjNg0bXIODyyuJQP3i/WOn59wnI8jyTOsVPqs/sKtw692howIMGwo?=
 =?us-ascii?Q?9NuRka9Scq30JwFfadp74S85OKj+Wjo2I/bFftM91dCRscJGbddw7EC0Ggm+?=
 =?us-ascii?Q?2Z/tAdkok/4JxzLbS5X9tP06LUmb3t2sUCdyzd98DqmuTlX5R32uQr1DYsTc?=
 =?us-ascii?Q?HPLJQQY4FJmNKxvOHuPgKgAgTiz0hqYS6H4aYN+cW4vzFB6N++YK6aIh/ZCu?=
 =?us-ascii?Q?s/sRD/nJjABtWGV0Ln9HlkxCT9iyUJGV/XmU78LMIO2y4gHiXqiClX3rsTfM?=
 =?us-ascii?Q?LCPoy0BYQsxq2ahrvHgmM/MphIvjIFHgyry9OGYoJ5a6tCit4doDuzWhj1Cw?=
 =?us-ascii?Q?wPd35hAUc2HEE8yUmoGcSRuxFM3zO/z4Ho3rX5w57itqtyFJzdInZS/T94DX?=
 =?us-ascii?Q?T7i23b6kbIgYr064TSU2AURJvof9CGEFCqD8DLetb9vkuOBPurMIhTqi1TSv?=
 =?us-ascii?Q?xl3oFXQqE2PtXMvxN3TViPnObMXfvstH1kohHLXR+1px3vyq9fdDkzXKzZwR?=
 =?us-ascii?Q?c0FW1QwfUqn4RnI8zMrHGjYJCBT4ouQhCGEfY35ttMrVAQ0NFx4vkMYpkn8B?=
 =?us-ascii?Q?g3h6aCjgU1sESDz+jopiKL4PuoUYwB74BMu6+R+0gMtJVMtfqDszBjpeC6Xd?=
 =?us-ascii?Q?6JflD6dyfWgktkZnHpbwD2WV2nzu6TU9mtsGm7CwkmH/l0nojNyBxf8KdrGI?=
 =?us-ascii?Q?WB/7jjiLSh6+cq+97ysbVg6F36LrDSOYqlAJvpvSq8WkTT+7w7pl/qt8j8ks?=
 =?us-ascii?Q?T5jLYstQrvoI6InOEF9CFFtUM6zJ70BC7OcMYrw85KqQjXPM44LtCyyq0zRW?=
 =?us-ascii?Q?1JGoWM6D8yMVFR8SBybDArNhjGrsEO/j2gL9KipW78ecbpSWRSoW5WiSiSF6?=
 =?us-ascii?Q?I9pAxwLYzJKsGUgGiBdNmitiuB3LRaSyUWsYe8fi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a0455-edaa-4791-5ed4-08dd5d5901db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:18:22.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaWmWaXICZ/ROtfxnDPq+TDbvVeEzZA7FJ6IRozxkLKlZgIX/Nv2l2EQyTeKTRlPoXIdTHh0LW8DfmP1AXneZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6061
X-OriginatorOrg: intel.com

Hi, friendly ping on this perf script doc fix. Thanks.

On Tue, Feb 25, 2025 at 02:17:36PM +0800, Yujie Liu wrote:
> The following commits appended new fields to the end of the branch info
> list, such as branch type and branch speculation info.
> 
> commit 1f48989cdc7d ("perf script: Output branch sample type")
> commit 6ade6c646035 ("perf script: Show branch speculation info")
> 
> Update brstack syntax documentation to be consistent with the latest
> branch info list. Improve the descriptions to help users interpret the
> fields accurately.
> 
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index b72866ef270b..8bd105084280 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -239,13 +239,15 @@ OPTIONS
>  	i.e., -F "" is not allowed.
>  
>  	The brstack output includes branch related information with raw addresses using the
> -	/v/v/v/v/cycles syntax in the following order:
> -	FROM: branch source instruction
> -	TO  : branch target instruction
> -        M/P/-: M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> -	X/- : X=branch inside a transactional region, -=not in transaction region or not supported
> -	A/- : A=TSX abort entry, -=not aborted region or not supported
> -	cycles
> +	FROM/TO/PRED/INTX/ABORT/CYCLES/TYPE/SPEC syntax in the following order:
> +	FROM  : branch source instruction
> +	TO    : branch target instruction
> +	PRED  : M=branch target mispredicted or branch direction was mispredicted, P=target predicted or direction predicted, -=not supported
> +	INTX  : X=branch inside a transactional region, -=not in transaction region or not supported
> +	ABORT : A=TSX abort entry, -=not aborted region or not supported
> +	CYCLES: the number of cycles that have elapsed since the last branch was recorded
> +	TYPE  : branch type
> +	SPEC  : branch speculation info
>  
>  	The brstacksym is identical to brstack, except that the FROM and TO addresses are printed in a symbolic form if possible.
>  
> -- 
> 2.34.1
> 
