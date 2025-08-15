Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714972F83BF;
	Fri, 15 Aug 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250645; cv=fail; b=S8xNSgO+z/ZRyDtGMdb4LKfO4nvwYXDyMR29u00HI96HqJH3OdtrPU0OPjjWQCvb0h0bLNJrYRJgfYJmpkhR83b0QSFYq0RGCT4Pt+Au94EHc2+e0XiCc0kMr5Po6+ePfePy5Tv1DDUplSvD9CSG3saP+zlRdJnNmnoXwaFgi8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250645; c=relaxed/simple;
	bh=fxCkpllvucj6wLYnc2n7kZSdfbTU4Zthfl9hu+nLZGc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=T7g162PYhmUqveWEm1XE/5T15KhF7e5hL98rRam4geXXeWhB3Sl2zRxJCPCRbsJGqXuNHD95/hywd1T9IcDB+CqIhcDf/WToxLDLFLxLWUBzOaYAQWVxTI41JHirJiZR/ZCsmeWAPpXNVRzfTMtHkASglpnNCT1RM76wlizuamk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ej9geBda; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ej9geBda"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgIAteFbYu3GqQ9bDLnbnOC6gQLGnCzZhcN8CF6VcKrGojUzixbEGBz28ZovGXw77XCT2JSD8fENzELI8GrPxQBC7NLNJqS5jPMN+x45EIxc6ahtcpi3O/2UjLSnxG/9GG7uUzNLrrXVLtlgK38FPiTZuNTyUFiUStSsm+qY2eITgIRghAik9snCW7f5b7gCYnS1sceVZjSPEmRBTQKa8KEaTZ22VxBlqePzcKQyp0OCOkBks01UGCSPk5BBmAGIw0vX3DqRsPmrmKd+t9m0I9sAXcUcEGYRTZFD3UF+eKMiET7/BPOxH+7yWa6OX0PQxccoqQkAWomvqsNpOOdRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7R1joyBRMuKUQp7CSC/w4NG2DmyS75IncSp4JaoqB4=;
 b=had9Aa7IGb3MhV/7ELy1GF3pHEs4hLwhkiw+EwruZCR1QSvt/DStLxnDdAKUCYshQScc/e5cOZhTZXzBE+Dh4LyipQjSAUJkP1OUtLdG5VkRnZ86dPHQLHXCJGeXqBu0GfoIXPkOX2ajfZiyCWVPXjthOIDgCQ254JiSUYhoa+l4Edfw/XznztKYmOTCVWepf5fuIelRQbYMSOfcNGTeA+2pFJ4Wb7TcR6b+qcmhVyx4Pnp23W5GvluXRYy3h9v3DYx1P4ZFrTeDW2m3EzHcMIgUg0nBdw3IQezL3AoDtwRNYZgStUkxBVDGUCI336QNfgS110+d+43X72Pdcrn0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7R1joyBRMuKUQp7CSC/w4NG2DmyS75IncSp4JaoqB4=;
 b=ej9geBdaXbYG/YWUxPkSXbP3mP9AOj5J0Po153bQvdp1c8+vEXzu0pq9K1qtvZg+j42sntZ4C/CSSBgnY9iooeoB3a0aX6XsSaux5+oZW/2P/yFjGvjhaWEFlEMVoFbLKuMzWEe5YDa+g4efBkY6Lj1Oedo5BQ67pNQ8vN2eUA9UUoC2Sww5k0nVfgzM4AUQm9lOctQC/SegpYDUMtrXlMuuy3CP3Cg4IygEad9JomWIDnp0AwSRtL6Idz/sx1o/6obJk7lFsJM0Lny4RqhzDN1ukA7oMHCKMol1wfxNbnMraj37Hh6cbR0TyK3tUGrbcom1IGc4mwvo9wdTiucKqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB7991.eurprd04.prod.outlook.com (2603:10a6:20b:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 09:37:21 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:37:21 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 15 Aug 2025 17:36:28 +0800
Subject: [PATCH 2/5] perf: imx_perf: add support for i.MX94 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx94-ddr-pmu-v1-2-edb22be0b997@nxp.com>
References: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
In-Reply-To: <20250815-imx94-ddr-pmu-v1-0-edb22be0b997@nxp.com>
To: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, John Garry <john.g.garry@oracle.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755250614; l=1363;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=fxCkpllvucj6wLYnc2n7kZSdfbTU4Zthfl9hu+nLZGc=;
 b=/okFuak4TUxYy++IlBiz3ZpVBMWsUb4FNLfk9QOTT3frNbkagK7pVzsWLQ+WE7L0gF/upc1/o
 a/aSd2PMSC6CPV+6dCjIA5rBwVjMcfGwPRz7LKLckayQQJYuTyZ+Yo0
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SGBP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::28)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e39a525-07a3-4c1d-8f0a-08dddbdf5530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|52116014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3g1OEJxaWp6aDFJYmFUOWt1Y052L1pXR2dhTDQrSzVENXE4MjhVTTRWQSsy?=
 =?utf-8?B?SnBNVjRIUVhHaUtiaGx6L1BNWjd0SXlZN1h5NFVNL1pYMG5RbUxvRDN1aTVE?=
 =?utf-8?B?NU9ZcWoyQmdtMDJWNUdNKy9vMmRtN1VOTVI4bGkzWDBaV09KRFZkbHFCNzNo?=
 =?utf-8?B?Zzg2ZHpXd2dUR3FuRnpJUnBlblliS3dYb3NyU2JLZnVIWllVaEMxQ0U3RjAv?=
 =?utf-8?B?K3JlSlRjbU9Ka1dIbTdhM0RWWS91WW9ranc5V01sUEwvQXEzc3Q1ZVNxS0V4?=
 =?utf-8?B?WnQwMWpMKy9YNUQ2dzRVTlcxWHhUTXBuRnkzdERWWGpQbWUyU3ZDSmp1aTBr?=
 =?utf-8?B?amIyTVlOYjNwc3dvL082bFlRc3drYzQrYlI4V0QyV2xuRjlBSzdqKzlkODdp?=
 =?utf-8?B?NkNqbmlmYisvcFZ3S0JvUEtlcGNSaURCMlNPdGg1eVlkMlVaZ1ppMDB4clVI?=
 =?utf-8?B?TEdnbkt5dWlDY2tZTmRJcTJ0M1JJeGRidHoxN1pJYmtRMFFzbnNuWFlkbkZz?=
 =?utf-8?B?UGllaFRuZTJTZGJQeS90WjVHRytzY0J6ckhrRnp0amRseHV4ekRlc1ROU0Z5?=
 =?utf-8?B?MW9yWFVnRVBMNVVXQ2M0ZWg3UGVwZlU3b2hYdkNoOVRvNi84NzdLQ3FzcTlX?=
 =?utf-8?B?eWRXT2IydndUUUJpR2IxemFrb24zeVFGTnIveXRpSEhOWUh3UmM2ZFdKMEsx?=
 =?utf-8?B?Y2IzY21PU3ZLOUZQbEMxemE3UVF5cWVHR1Bqc2VUM0dzNTUyMUJYNm85UDZY?=
 =?utf-8?B?b28zZk55Sll4YkRIL1h6RERQbEROSE93akZDRmJFL2Q4NEE0ODhubXZwQUgv?=
 =?utf-8?B?S1RUY0NIalRMbUV2b1dhcnZUbUhhWXc2bkV0QXU4anZkUHV5a0d1bll2cUdC?=
 =?utf-8?B?eHFtcjRpb25TWEpwZnVGNyttaVVrcTlYNjBNRFQrM1NZaDNDOEZUT3ZoUVFY?=
 =?utf-8?B?QUVVVk1CTXVNbFA5YWlPZU1mdEJzVjM1TnJNSWRJVTZ3NUROMXlsNThSNUxE?=
 =?utf-8?B?QlFEWFlneFEwVE9vc25mc3d2UW5RSEU3WkpIbE5yT3o1ZUsrZzJQd0ZvcVR1?=
 =?utf-8?B?RHFQYzJkNXdKWkk4U0grOUN6YzVYYm5UM2J2TG43QWVXMXZNb2xZdHhOM0ZN?=
 =?utf-8?B?L3F4VHVnL3R2SUJtOXBpUmdNUkNkWWlmTGRCN05kU3lldGJJd1J4SWRmQmhH?=
 =?utf-8?B?bDlkdkFocWZQcHJ6akFQMDE3OUhNdEY5RTJRQUhJVmFQbkFqSUVwZU1VRk1E?=
 =?utf-8?B?UTh3R0lEcUlLMFBnSnFieXVrR0RmanJ6UWxITk5lM25oMHc5VmRhKzhqZjRQ?=
 =?utf-8?B?TWtYUkg4R3JHZ2Zwa0ZWc2MrbXgxZGZUSFRjZitPT1orbzBSVkk3NXVKbmFq?=
 =?utf-8?B?SndocEtNNzA3R0szK0xMSWVLNGs4YWNaSzY4OGRmTkVHTzlPdXRvazBJL2w2?=
 =?utf-8?B?WjNFNS9JMG9uUHh6VmNZd3ZOdFBkOFJBaHpLMTRjanlRUTNwU3dWQWhCbkcv?=
 =?utf-8?B?K1BSYlVqOVdBRHR6YXNsZHlqK3g1STN4bmlhUlMvaHl5YkpvMDYvTE1kNkE3?=
 =?utf-8?B?V0lqSTYydERQaUwyelRlYkRpd2I1YkF1b2JIbVNNNlY0Rk1SNC85SlNGbGFn?=
 =?utf-8?B?SWtZaC9Dc0k5M2VFdXl1ME9PSGsxU29ZZlFya3A1cGdTS0pweUlJL01UYTl2?=
 =?utf-8?B?cEQ3d2xic0o1YjA3WHlWWThxdXV3YzM0dHhoL3VmMnB6NnhtdEZMbEY1WHJH?=
 =?utf-8?B?aUlrMXUvT3cxazkvam9BNUVxNEMyZUhVM3hmVUo0d2wxelFreTFUZXlRbytE?=
 =?utf-8?B?bndjWkVHM05pWXo3clErOWtOS3Q2WEg4dm5qcXpuektQTWdYRkZmcnA2Vmgz?=
 =?utf-8?B?bDgybWlSdUpwSHVEbE5iOXJYcVJvbUxUSFNCcnpFRTV6N013OWRFUHBvajhr?=
 =?utf-8?B?ci93elBxWElvYXF3YTNUa25ST3NFcHhhSFNOWUtBUU43Z2xvaitDaDNwT1NF?=
 =?utf-8?Q?s/PUVMxZQ34Cv42w1TrzPgxHEWypx4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(52116014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0ZkWGdadDBtNDdlcEloeVJmMjdaK2lJcW1yeWlQT2dMbkI4aDNBYlZRVkh5?=
 =?utf-8?B?Mk1CRGowbUQ5c0p5VDhqUWExejlQaUxHUVVKc3ZkcGFwMDdVYXNrZ2ZzVkVY?=
 =?utf-8?B?SGpiSTdsUXB5cWxxaUlJZVVMK1ZKelhXZVdza0dHY2QxWE5LVEgzMC9qSWQ5?=
 =?utf-8?B?N2lYdFFoYU8yeC9LaStQRE40VUZVZGkxNS9paWVFaVJzM0xuTzZIRnBHczFD?=
 =?utf-8?B?Q0NId0tjVEQrTHdLYmNNM3g1cUE0RzdHenFGUmVaeFJQNVJQOFZ5OWIxemxZ?=
 =?utf-8?B?RnQ4aC9CQUExNHk1UE1BU29OaGZuNE9VWktMMWI1WSszZmhsQkgzTnF5Y2tY?=
 =?utf-8?B?WU5NYXRreG1jWUJGMGZnYXRGL29tSDRkTnJjc0FDa25sb2lWczltTnVNcjRX?=
 =?utf-8?B?VnNlbmhnYjJFbC80NzJmQWFMYThUYUsyVEhmSnhLVno4Rm9NTkVZUlIzSmFV?=
 =?utf-8?B?akxERnFWUEZlZXV5WEl6RXZkOUEycTlzallrVzNDUC9pdzNCek5yTGdvU0dr?=
 =?utf-8?B?Vkd5TndmL2hPUmNXaElYdzE1NTdWZ1ptV3pMZnYxa0Vob1phZjVGQU8xZ0xq?=
 =?utf-8?B?dnNJQ3NRMDZiUS9NemRFcjhGWG5lWU1UY2Q3aEY5ZkdhOFIwb0E3M2d0MDRv?=
 =?utf-8?B?RmFwK2RIRU01YXZMcE1UdkMydU1lcnVIM1ZObXowN2hSaE1xa0VmTzh5cFZo?=
 =?utf-8?B?NlBOcDNUOTRXcmwxK2o3VURRSTZTS0tnRVo5WnlQTXpzVnlUZHVkbGk0aEhp?=
 =?utf-8?B?SWhEOUhJSWhrQ3dma0hVNmNMUFBvRFVkemppUGxCd2d4blJKR2hiV055eTV1?=
 =?utf-8?B?VVE0em8rVG0xZUtYQXEwSHEzWUxUNTB0YzcxRGsxck1heUNCL0kvRS80RDkz?=
 =?utf-8?B?S3hVaTdSK29WOXJPN2RaU0NiNVc3QXcyTU5iVHkxYlNtWlJNRlpXcXVnT3JX?=
 =?utf-8?B?V3hVem9VTVhQcGZ0bVNFTjNYa2ZDWnZoNElGblk3a251Vmt0YVFQWjRUamh2?=
 =?utf-8?B?RXlWV3UyZEZIcEtibEJXQUFxVUdKRXRnblVJcHB6Q0ZoanlIT2xyZU9JSFFM?=
 =?utf-8?B?MTZVMFpyVU8wUmxmbHdqTHpzcHg3a2xUZE01a0JBeEorMk1NbUVDeVhCeVpw?=
 =?utf-8?B?TkQrQWQvcnhlTGpaWHNramNJald5eGJQOTl0TmhsaFJxb29VVElQUVBJRlpB?=
 =?utf-8?B?OUl2NDFBQXBnNzByWmIwY3d4c3pxdm9LRUVOa2lLNjZheS93OTdoQnFYUHQz?=
 =?utf-8?B?N3NXTEpuMC9VNElGb0lPRWNZMm85c0tHNEROcTVCZVpJbGh1NnFGWXZTT2VY?=
 =?utf-8?B?b0dMQlNzMFFxMnFZeGEyZTh3a1dUTzcyZURIcmJwR216R2dtZEo0b09CSk12?=
 =?utf-8?B?T0k0WVhmQzNlekt4Nkl2eDQ4TGVXTSsrRHNKVTFlUkhnRFZIclVLRHdmemoy?=
 =?utf-8?B?SnBhYzBIYVdRdWlkVE0vSkN4RE0wNGtPMXFGYTBNNnJuZ20vTU5yVC9uNmQv?=
 =?utf-8?B?RUpoNTNrRlkvNnYrS1F0U1VJZ3o1TTNWbTd1VVVKY0pxOW5JT3pYR0ZLS1Yx?=
 =?utf-8?B?dnlsdXk2QmJsaElVU2pMKzVKWCtQT2JOcUxNNUt5a21jb3BsWVNtM2dTZzlV?=
 =?utf-8?B?K1Rmb0F6ZWlUamsyNGFCUjVzdmhGYVo2YXhvTUlMbGRocmgzS2pUalZzRElr?=
 =?utf-8?B?OEJLTnRyekFuaFhJbFgrY3lKd1dFaDFqS2lYMko2RnpHbGM4ejVGYXluUEJO?=
 =?utf-8?B?SjFrRU0yQ1lEd0VXRUJGQVNIOHVlNHM0SFhzSC95TGpoUWlLUUFLenBxeWVU?=
 =?utf-8?B?Vk5nTlBJeXZhOUdXd2N5MWxMSmtjMGEydG9qTHZTZk5ZWmIrY0NPOVo2alFD?=
 =?utf-8?B?NHJOc1BwK1ZLMjBHZFpDR2xWKzlPOGUzaW92L1JSdE1SaXZSMnhlTFovbzFv?=
 =?utf-8?B?MmxQMnFkNFF6OVVJZXdwNVlPTjVnVndjUnVlSE9DZDFlaURud0FhdXFWL1hs?=
 =?utf-8?B?SzVEUjZ0Y1ZFRSszS3ZBQWRudVdRZnpTZmZiRlUrY3Ivcyt1M1V6cWxoeGIv?=
 =?utf-8?B?anVuUUlBbXJ3dmpxRTdCcFAzdlZHc1U5VlJ2VHhVMVVpeFJCR2k2ZkthMHpq?=
 =?utf-8?Q?y5flDsqCvO/j6Kf5b9VajQW9P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e39a525-07a3-4c1d-8f0a-08dddbdf5530
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:37:21.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVYSYCZ9+60T2g7vvQgsXRwoi3reLcY5YBZpY83i9JrohECTwjkAc+M+CMALSPZEqrRgBJuXjna3BwtL4pfBHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7991

This will add compatible and identifier for i.MX94 platform.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 267754fdf581469642c4485c28a2b00050fe785f..7050b48c04671759e8cad0e93359c088a2bf342a 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -104,6 +104,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.filter_ver = DDR_PERF_AXI_FILTER_V1
 };
 
+static const struct imx_ddr_devtype_data imx94_devtype_data = {
+	.identifier = "imx94",
+	.filter_ver = DDR_PERF_AXI_FILTER_V2
+};
+
 static const struct imx_ddr_devtype_data imx95_devtype_data = {
 	.identifier = "imx95",
 	.filter_ver = DDR_PERF_AXI_FILTER_V2
@@ -122,6 +127,7 @@ static inline bool axi_filter_v2(struct ddr_pmu *pmu)
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx91-ddr-pmu", .data = &imx91_devtype_data },
 	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx94-ddr-pmu", .data = &imx94_devtype_data },
 	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };

-- 
2.34.1

