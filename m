Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D572040B6;
	Fri,  7 Nov 2025 03:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484598; cv=fail; b=HzaXSbQSsznQFToTDv5YyBDhKAhfndlqYHdF9aan4i700BIq3h6hD8ZTm/FI6PUdi2Y/RvNttsM4jDJQYFd8DOZwxTX8t61Fy8agp/AWneezSl0ZvWondUr1B0InBqexe3+VQTypOD5+xXlFpKbCQu7rZQzTkWmWRzu1Ue0jTVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484598; c=relaxed/simple;
	bh=/LmtzWQIFiLyuC7GJqTJEK7kCwQbMleM4pwT3XQG4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AumFsAs642oiouwsRftAz4CMFR7DX2eHMNi6lCXXWwBORZ9LHhvZaR5lKTG70CvJ0v3oOhQgu93iXQcjZZzYiRvZMM0PIV9rbc85+HxjHb9MlQk2A0p+ZjDOPS2iLdM4W7EoyWGWnfeKoZnn1j/2CL9jq1/uYb1ZeRh9tlMBQ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FPPffCJB; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FPPffCJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mf603/K6mtzsB7F/bparcmtaEoJ9jUzkoQGSKVpvuwWZu+YeKvGMIwjJFVKptaxDetxKCd+KnMeLOC/I8fPNJ9eum73YJAk5emDeLUquIO4ttMViohlYVrDsZBXAXbVWAJezTThTHU1NdM+GeuLhUO/l8RJAMNYHltfd8eSqdrzBoCh2TNw/p7vTLvrQpO/rOuCuMrsmlkOeHocwyz9G7SVo7BzAdfwUWwvfHrQ66UvPyg/r8EOCMzcOO/7ZGjZP3yfNH6NwlTYXixVsb2QnO3uSMhGXRH8ARSnvo8cTlvgvrxHXooNcLOC6eoEYysntNTgwu16icIbcFkLpj+JBiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/VC7k7q8tyx4oVrSHopZcl2j5ObpkdekyjGnOBGeuY=;
 b=dofORXaMjdQ3/CdYANeoLbtu46RBbR8TTn94sleMccSC6S2FqvNG2h8yIamq+fv8l+2Q/v7AHi/bZMIjTyQ5ffzS2f3DMFO9fWoyRKJVEy74DeQ61o06O/E8tOqKphB/0nCrSmpsmuIOhtBKkRgiyUPIFgvIDREWWvyQr3K0GY13gyfV9LjarooRdX8zuHIrwtyLQ7XgAvSjuhpk3vgZdjJ7M9meEQNvlWmCtNvpBuKNP8kGB+fq+2vQYSXbwweScd6NdLrdUagAK/yHw2XXQ74sX13rzYeD5upyrum74JdUxkGfJFpmVpYZqGtdDS35hSkllkbHYPkAhOSTAbPs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/VC7k7q8tyx4oVrSHopZcl2j5ObpkdekyjGnOBGeuY=;
 b=FPPffCJBx4PZIsACd/Nslx4vtcrUyCWBys+Ysoadi40NwPsY2ADl+3+BvFWFjj91stB9TFaSeHG7zN3XnjR0zIarIwlmaDcpMu169RBBR8AvZFbUmuceg11PHofQ4NQydsq9+ibOGQ9t/OlYCHwamPnbh6ejmI6z9Kikckrw3jtfpMSLnTzzqvaHgF0IXY2N/EYrf9KVwsCYjvvX+yl7QRTgJ4HlW8Tr4o756rGZB8PM61mKKOejxAMLBMnQmykwImsYK7Wbjc3Aoe354WetOQYXQcLxz3x6a/Aia/UFP7+i/l1fSnVxHQYQtYfkYDLQGADIzOcn97+JVzlOjjXOoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PA1PR04MB11010.eurprd04.prod.outlook.com (2603:10a6:102:490::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 03:02:38 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 03:02:38 +0000
Date: Fri, 7 Nov 2025 10:55:57 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Ian Rogers <irogers@google.com>
Cc: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/5] perf vendor events arm64:: Add i.MX94 DDR
 Performance Monitor metrics
Message-ID: <f2hpij4ln7zq5e42net4xuuvvcfggbl6uazlnl7wdrdov4npj2@oh3c7bv2ny6t>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
 <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
 <CAP-5=fUd24kWOG7=8DpmiaMXkwdf9=BOzmoTrjn9b5Da0ZfP3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUd24kWOG7=8DpmiaMXkwdf9=BOzmoTrjn9b5Da0ZfP3g@mail.gmail.com>
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|PA1PR04MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad568f7-3169-465e-0e11-08de1daa1bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU9YQUswd2EwWDhzRGVSTlpEMmVXQUt0M05NRnVGYkdlNVFFSHdlejdoOVR3?=
 =?utf-8?B?NURNcUZPZm9Zdjg1N25NSEx5eE4wRm5YUGtPYW1YQnUrdUpvVEZMOXBuMXE1?=
 =?utf-8?B?Y2hIMlRkQ295RmZ5NGlaUlI2VExRNFZZWkRzOEJEUDE2RkRUV0xUUkpCSFMx?=
 =?utf-8?B?aFJYbUlIRTVHKzVRUFBzcUZOT0NMWmpLZ0lVR2gveFpZN2xDb3dlSEl2OFpE?=
 =?utf-8?B?S1RnZVIwTXZQSHViWG9VWWQ3QVlkZDZLS0diU0trKzdaN1RFZTBNUmVCYWxX?=
 =?utf-8?B?UHhOd3F5QkppSUw1T0hUYWRLcXBuZHNVTFlDZWVaeW92SHQySU44aXZ0b1NP?=
 =?utf-8?B?ZDJTbkhPN1RPZXk5SjBHNzIrakk3K0Z3ZUk0ZDJNVmdqdzZpUVJXSTFTM3l6?=
 =?utf-8?B?TlhObUxOOGhySG1hYkwyVDdmc0tKUWt6aU9mUHVHM3NwWEpjNkhjUDIvYnZI?=
 =?utf-8?B?cndkODhRTCtzNjVMN1lLTDBkTUZYa0EwZmxzOGd1SktoL0lhMVFvM0J2c3NH?=
 =?utf-8?B?QkpsMmtROTFkdlFFNmdCYzhDWWlKN0E3Q3lIU2lkTi96Rll1OVpVMHZpOUMv?=
 =?utf-8?B?L3kwdE56cVo2V1BZUmk0MlBYY2NPMFJSL2FyUXdWOUxKZ01MYlgxTlYvL3cr?=
 =?utf-8?B?YXFoQU5OZVhlTjgxUThkdHFTeTZxSnJzaXpGdC82WllaUVhOUW1ENTY1alVS?=
 =?utf-8?B?VFhNRVlnQUQwOTBaeVlIT2NCOHN5cS84YXZMTnI4eTNYWmV2ZkR0WS9zVnNY?=
 =?utf-8?B?ZFcvK0dTSk5WMitxZnpXb1daN2lhUGZNU3FjUUtLeU90TDVMdGFINlYyYkJL?=
 =?utf-8?B?WDVLSUg2ZVVDSEdEK3MwM2s0T1JmNXdGU1hlR2tLSXNSdWhGcmg3R1pPbUhG?=
 =?utf-8?B?dGZRWjBubHJtOERUczFpTlcxcDVYcXExT3k5YlpObUJzU29IRkFKWGU4MTla?=
 =?utf-8?B?eGdrU0VIdzIxbEFvNkdFNm9RWGVLVXVTazVOZU0vcXZsMWlqVGU0ODRJQWQx?=
 =?utf-8?B?VXQyZjJxM0NzM0ZwUUdSY0dvMWFjbjlVQ05GOW9kY2F1TnltUXAvTllOcFp2?=
 =?utf-8?B?bGtySVBrZTFEUVp1Z2t5UGIzTWJjYjl4eE4rT2IrQkluUXE0MjVsMTFvRjZL?=
 =?utf-8?B?SWx2aDZheXVLaXdQcm9zbGt0MWVIYUROY1dpNXRxY3YwaTIvWXVrR2hjMHJi?=
 =?utf-8?B?Uko3TXpRL3cvUDUvWDlmRHc0enIwWWpNYUNPRXJjUzVLZmxlTzFxY0t5UEh5?=
 =?utf-8?B?UGtOS3lYcU1yT3h0WERhUVNvRFdPQnVHWER1bmtRL0lMa0UxSXY0elFJRE1C?=
 =?utf-8?B?UWZkenFHbndJYk54Z1NhQWRTNVhzcEpYeEtVclBOSndPV0hzZWZCclcyYmJN?=
 =?utf-8?B?UFh4NUJiaUdzUzdqREt0QzZSSHVXeWVyc1lrOE94RmgrbEg3WUZ4OWJrelBu?=
 =?utf-8?B?T0ZMTTF4dStsOE8vOHZEZDZoZElvb2x3OUNSdHRPUFk5LzVrUHYxZXRsQjh6?=
 =?utf-8?B?WFpwSVZzNDByTGxXWHV2b0lJcmNuTDRSUFg5dkhET3NFeFYyVVNXemo4U3g4?=
 =?utf-8?B?cjh0NXV1Nnp5eUN5U3V2WEFNbmkxUTc5RmsrMU9BQ0Y0THR3VldJVC9zSEZs?=
 =?utf-8?B?ekk4YVpVcWRTR21FZVJyekNBNGhXdklxUmgyUE9KVWQzek14ZlJkakhLc0VM?=
 =?utf-8?B?Ykt1MXdTWnZ5eDhVYUFCMWpOaktHQ09UZnNjc3dpdTVxQVZQZ1J2M0Z0SVQr?=
 =?utf-8?B?TkJCU0F5RFQ2L0pEVHIwWktPUWoxbmFMUkExQ1JzUVZXakxpZldpY09CMFY4?=
 =?utf-8?B?YkhxZWJkQVI5TXdJekN0b3RjNVl0Y0NGVjA0QkIwQUlWSWdWejVwM1FwZEFr?=
 =?utf-8?B?UW1ya3RyZnJIUjR2cS9Nc3lLMHJwbzEycW5aaDI4Z3ZGWUR2bUoyQi9ycVJo?=
 =?utf-8?B?Q0gxZUlJemdQM3lRUGV6aWpES0xkM09aS1VuSXVNOTFQOENRU3JOcGxzdlZ4?=
 =?utf-8?B?Y05ockJSMUk4WGZEREtWc2V4a3pPeUZwdUh2K2FnMGRHUlJJK0VqQldDb1I3?=
 =?utf-8?Q?6wheuY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzdIcE9wdS90U1RHbEZBLzBKbW01WmZmcVJ6RGQ1YTNlQ0R2ZWVSRzFydEV2?=
 =?utf-8?B?WU5pdjdRbFJFUWJNOVpNaWxsZmlWMGFMTURtSGwzQTgrS3JSZ1R2eDZRcmtR?=
 =?utf-8?B?eXJKSXIwRmtTQVlySEt4MThna1hPdnJZR0J5bWlNSHF0NlRKWWFLWHFkZ2VN?=
 =?utf-8?B?a3UrWEdPdUgvRTgxVXBSTUhqU0xlek1INU1nVlJFZm5iNWVVdXNac0l3dHM0?=
 =?utf-8?B?dWc2TStsRFU3SHZjUCtZTW4wc05FeDBucnlIRHZDTEVMc3NncVdRWkthZjA1?=
 =?utf-8?B?cHJoRHFZTU9kVS8vaEpOTVQ5VTFFdDdlczkyWTBTeHRYN09VOVVYdExHeGhl?=
 =?utf-8?B?ZmxTck9qUzY2SUkzc1NwT1F2RmZDdE5QekpBZm9TRlBoVnNxQlRCdTRpdURM?=
 =?utf-8?B?QkViUmE5dDl0VVM0UWhYMVRSMDRxNnlBcWFGWStlcFZNMXppZmlIM3lvd0V0?=
 =?utf-8?B?alAvNXN4T0hELzNORStTdG1MNGl4NkluaEEzRkhRRlkyNUFrTG9LU3luTFhw?=
 =?utf-8?B?RzBxRXJoR1RuQjlLbFBrMCtFdFBLS1J1NU9rVlNhbmN3WHRwMndKdkJTZlBq?=
 =?utf-8?B?SWZaNmJEMUttMENRb0JDTEhZSlZyNTc0a0E4UkY2cHBCYk01elU4aEhIYUZT?=
 =?utf-8?B?bXNSdS85eEZ6eERza2tmNGFNN3hsUmZQSnB2N0UzWEZ4ZGlPSzd3OW9PcTZH?=
 =?utf-8?B?b2JZM0h4WXRPWE85c1g0by9mWDljcyt3ZXB6NjRNTSt3QmRnemhYQk1kbU5O?=
 =?utf-8?B?V1BOTk1XTDYvWUhrSjVXUVVuRXhyL1BHWVdBakVLejF0blZ4SllSeGltOC9W?=
 =?utf-8?B?QlBxa0k4ejdUc1Rjd0VoSnNzLzdQZDBwa1I1SFRZVVhFWGJVZ1pTSW9WQnBH?=
 =?utf-8?B?S2E4SlJvdHBTR1JyQkovQlBCNitKSmpTYW9CQlA5cGJyc1JkRENJK0JmTkFV?=
 =?utf-8?B?eXAyMi9EYVdYM2RDbmZGY3ByNVgxVnRjbllYU2N5aUhPa1J4Y0cvNzc0amp6?=
 =?utf-8?B?TFVrVnhJbXlVMVR6OEc0T1ZPdW9iaTBQaFVGWXJQU25abmRlUlJYeGxxcEhE?=
 =?utf-8?B?aUJjbzNia3lDeGZsSmsvS2IvOWVieTdhL2dZNXcvM1ZtQkUxWCt2dzVsT2hE?=
 =?utf-8?B?S0x3QkRaU1hhcEk5VXZLTmkzVFdpZ09JZy9rdUpDRnEyQmNDNnJ0d21PSFV6?=
 =?utf-8?B?ZThGTjg0SUtzNnlzVDMzUUFRWDVqMnppd1Ntb21KcTg4aDZHZ1N6NUI1aDFO?=
 =?utf-8?B?bVQ3czdvekg0QWluRDZVcHpIdFVmcGRaZnhxYXhpSkpSc2JZbzF3SC9tU3N6?=
 =?utf-8?B?dXE3dDFEamlXSTNCZ2l6WlBuK1JNZzRsakF2eXRHUmYvWGNyYW9HQktSdXlo?=
 =?utf-8?B?c092aktBUlZJM2Z5WXY5Qk16NG9BYkw3RkhscEZjN2ZleXMxblVNRDF2Y3hx?=
 =?utf-8?B?ZGVlR1paNnY0bEhrYVhBdFA2WXlCTmh2eWpCNEdLb0JhQTFXY1oxLzNvTVBM?=
 =?utf-8?B?bnQvT3FaNWhWRVFQa0lDN3FTcXNRRkJIZDdjbGZVR1EybXlxeTVaazNGKyt3?=
 =?utf-8?B?czZCZFp3TjY0TXBsd3BBcHRKZFYwVld2bC8yWktmeHFEdlltaHZLOFJmMVJt?=
 =?utf-8?B?eDcyTmJuWi91QkIzd2NWaENua2N5eWVwQlc0Q0ZuTVJ6S09DaUJ5VGlvSGZr?=
 =?utf-8?B?WUFxTk41V3lSdk16Rm15VkhqQ0I4MGNZcHBHOE1OWkRqcUNYbzJmaDYrMGFE?=
 =?utf-8?B?blIwYUYyWWZMR1J5VjdTTXlZdEdZcWVyM01ielB2Mm1VbVk1cE5RMFFyVlBW?=
 =?utf-8?B?WTBZbHhlK1pnQVF3bTVqeGFFRmRmOEVHY0FRSFVZaUNYVFJyRDhBbXUvcSts?=
 =?utf-8?B?VmxlQ0RONHRUYUl0c2pOWHNBSWVqQ3JxdmRWMUQrWmR0eFNaVHFlM3pMWE5l?=
 =?utf-8?B?dUMyUXFpM2FVdTZoSHdLU25BSlBFV2dXM1R3T3N2Qks2aTJDYTRsZS8rbUxQ?=
 =?utf-8?B?bkFKUW9lSDQraDlyOFlxMzZ3UU9BL0tMM2poTVNxUkNTUTVOM054OUp3MGY3?=
 =?utf-8?B?UXNqQTdFVVpWU1N5aFYzLzhPOG01cDhncWt0Vll1ZnkwVi83b1hTTm13OFNE?=
 =?utf-8?Q?FTgbs468pFfr3Pq910GEp9I3J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad568f7-3169-465e-0e11-08de1daa1bd4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 03:02:38.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GUSfJ3ONrqWZ8zRSV5Gc4Eq5omO/ssix7HeftUL20+QIy+Pd0OoRteBdqEj+hO4Je5KV6EPPniY5MrnecC2Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11010

On Tue, Nov 04, 2025 at 09:40:15AM -0800, Ian Rogers wrote:
> On Thu, Aug 21, 2025 at 4:02 AM Xu Yang <xu.yang_2@nxp.com> wrote:
> >
> > Add JSON metrics for i.MX94 DDR Performance Monitor.
> >
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> > ---
> > Changes in v2:
> >  - add Rb tag
> > ---
> >  .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
> >  .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++++++++
> >  2 files changed, 459 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..aa7b58721dc7e23dc9d9905a79e0c1778b7bbf11
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> > @@ -0,0 +1,9 @@
> > +[
> > +   {
> > +           "BriefDescription": "ddr cycles event",
> > +           "EventCode": "0x00",
> > +           "EventName": "imx94_ddr.cycles",
> > +           "Unit": "imx9_ddr",
> > +           "Compat": "imx94"
> > +   }
> > +]
> > diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..629f1f52761e2210ef43a9cbba175871817e1230
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> > @@ -0,0 +1,450 @@
> > +[
> > +       {
> > +               "BriefDescription": "bandwidth usage for lpddr5 evk board",
> > +               "MetricName": "imx94_bandwidth_usage.lpddr5",
> > +               "MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
> 
> nit: It is possible to have metrics use other metrics, this may read
> better as (although I can't recall if the '.' needs escaping - I'm not
> sure if the 4266 is significant):
> 
> ((imx94_ddr_read.all + imx94_ddr_write.all) / duration_time)  / 17064e6
> 
> > +               "ScaleUnit": "1e2%",
> 
> nit: I think this would read more easily as "100%"

Thanks for your suggestion, Ian. 

I tried, escaping is necessary otherwise perf will report error.
But if I use imx94_ddr_read.all and imx94_ddr_write.all in imx94_bandwidth_usage.lpddr4x,
perf stat won't show correct result on my side.

root@imx95evk:~# ./perf stat -a -M imx95_bandwidth_usage.lpddr4x -I 1000
#           time             counts unit events
     1.001115585         1001234752 ns   duration_time
     2.002746508         1001632840 ns   duration_time

The previous result was:

root@imx95evk:~# perf stat -a -M imx95_bandwidth_usage.lpddr4x -I 1000
#           time             counts unit events
     1.001080251              13966      imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x000,axi_id=0x000/ #      0.0 %  imx95_bandwidth_usage.lpddr4x
     1.001080251             119741      imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x000,axi_id=0x000/
     1.001080251         1001275128 ns   duration_time

Thanks,
Xu Yang

> 
> Thanks,
> Ian
> 
