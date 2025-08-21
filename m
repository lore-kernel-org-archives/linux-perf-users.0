Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60B2F0C43;
	Thu, 21 Aug 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774156; cv=fail; b=MhboZopO4yySFWtpXcwjZTMSy5274E+sOYSOfSmkAfLt9JJnEMd7dYmDr9vgxGYqNLCwUEs3897ibYyb4PxkRWBRsYuQqrNIyXCR/W31B0WK5NMFGDO3XEXSFt1ymXWOlwnlWXXk4TviALX0sDk7XK91qicVKAHagxaMu7NM8kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774156; c=relaxed/simple;
	bh=/6Ijjr7qT6M9DhiMK4RsbKb+y14cljroYGPzPwOJWNQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CI3j52DI5UZ0czMebAYm+QevdoFrFgOCpQ4+haxI5g4HpvnmaT09xtn4ur/buOc+A+8fwh3VbfR3UznEYW24Oj5onowrNPqoD+2dUra0Y6RdJU95nAB1FzTqM8fr8sK9ED9xVj1VgMik9ruUrTQGr2WWs6XIXQhxddHKXaGdDuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OUsINIev; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OUsINIev"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKtYZcF3lpVzJMJn9qnX5z0oZs65+riMTWIFmnvD1abZzlI0gsDquTKUogHb/NPXLdtHZDpyxV0VgZgyneIvBG3Vw/EuzvVb+pxKJDL+LNlsEZjL3QBLEzvBdv87aPtEuKFkMRlaxFxb/tPnxroUPRvuLieCaYQ/WoBL6s3Tu2/1gWFT2e9pQS4Wr4m9i+hsUkPWxjxYNqL+H5Xp1bXbPhi9TCf3DJKOPexcZe7XUFEC2c4teGx9M+TQQKwng8wAqz43Y4lchmA5iLXK+iFkvarWVCelfUMF1A4FISLFmDLduSVt8ttwcXlkDY0sksaSyS64W9oo6jFoSieGFF7Q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31tkmq/z9e1CIZxDbPBAssQ3712SFFAbsKeNqxBetKo=;
 b=Y4fyCBeM3CxG5Sj7bJy2pecfl6DhtwrkiJLU6m1NV40nCJxsh1Vv+bbtcUYY32tvFRsJ6kRYr5OCLztmC2KPB9zDvArnBQ/K/h/OwmdcJgoWaUXj9exxH8X7sDhganIgiSnS2suXYSgvI3SD63ZRzOBJqDP1dtBvBqe65DYmntSbxn3A0w8ySnJUWEn9tyYYuhbzIGK63r1tFcRCUo6pflV+w9Q+QfhReBkIdgF5uBQI2LUoVK3i4zRxkCe7XVgFXitiI8qbXcaAasiy+gvQW+hthmai5dsAdrUCyzEUXab0GOvgdwP30hUwWlKYKiHLtSbmZ4TUrJBfyS0kXisKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31tkmq/z9e1CIZxDbPBAssQ3712SFFAbsKeNqxBetKo=;
 b=OUsINIev07jvao/f6TxB3MJvKrqtke4P0PHCHnas681hETKDG7H+IdRgGI7aWJcYnMLeeSiOLnHzoKrWlg5BinMin64UK8qrKsW4PFsEMkNasUDVNL3t0sZP53oUO3Gx+ONz+F3b4C1WpEKCZ/k1tcJFAAZT2uhy2p5pCRYjlpUWXtTbhYqq9UWEKja+/gkIoQYT3B7uD3pPK97yNKlRfo9VjEU+YTuJRgiIabcZlFwDydyeqmmIMRu/02WuJMHrqhH60pMoriEElyKDYa64EBInkNFkH53JXAFIN+DhrnXfpVAq58xPjvuaFN8k424YgD1gZNWV2QCsq/dvPjj9YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by VI0PR04MB11540.eurprd04.prod.outlook.com (2603:10a6:800:2c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 11:02:29 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::4e24:c2c7:bd58:c5c7%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 11:02:29 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Thu, 21 Aug 2025 19:01:51 +0800
Subject: [PATCH v2 3/5] perf vendor events arm64:: Add i.MX94 DDR
 Performance Monitor metrics
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
In-Reply-To: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com>
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
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755774118; l=18015;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=/6Ijjr7qT6M9DhiMK4RsbKb+y14cljroYGPzPwOJWNQ=;
 b=OJV9yLMPjpT6Dy1Awh7XSRw5k9QsuQ6p6NDeVfV7pZnL6toGsiztPO5NHqqfbFz94GGAla1cX
 wmczbdXSIsVDlymcoX7kcQYkixRZDN0eN8cgRbaSh2mNG6PAs5s268F
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|VI0PR04MB11540:EE_
X-MS-Office365-Filtering-Correlation-Id: cf84ee7b-89c3-4c3d-0f12-08dde0a2388e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHdDUUFLWjQyam1sVEU0SmhDYVlMQVRiVUFycmhMa0drdnp4Mndxb0xkVzZ5?=
 =?utf-8?B?bnBhb2wrVXc4dWJ1M2hmcHZ0YTgrYmF3MGZaT3RQa1krT3BPZDMxZlIvZkE0?=
 =?utf-8?B?R051TFpOQnNzcjFiN0VuY2xUVE1nRmpzL3MrYXpNZjMzY2lSRUp0bjVIQmZL?=
 =?utf-8?B?U3V5TjhacWUvUUpabGIvZ0ZTUWJFeGdBR0tZYnB3VTU1MDB2SGVhbGIzZWtE?=
 =?utf-8?B?ekFMV1g3QmxzU1JaT3hGQXBmOHJmZm5kRkg5ZEpHY0toekZDeTR6Uk11Mm5F?=
 =?utf-8?B?Wk5GYjJoekprM2s1Y2d3QW9oRkJHaGtGTnNYYWpiSU5uMXlUby9rME5yMTRh?=
 =?utf-8?B?Q0x2ZzVHSExJMlZmL0VwM211VkFZb1dYWkFReFhZQXp6a245ZGlsYStjcGNN?=
 =?utf-8?B?ZXRmdWRjL1dEUjJXNEpmcUI2azV4dU5OZWdVYm5JT0o4bGZaV0w5MnZkZ1ph?=
 =?utf-8?B?K2lGcGRMSURSejA3eURncEJleUk1MXQ1OU42OCtOSXRqcFdveVZXaDI1Um5p?=
 =?utf-8?B?UWRhNlBwZm1xVzBhVVJITm5jV1ZyTG1nR0JIKzJCVTUyQ1ZyL1UxN1QyNzV6?=
 =?utf-8?B?ZXBCaUFlZ21JUlFzTVNZY0xOeUpqRnFkbzZkK25EcStYTllqSE9ETlNLZ3B1?=
 =?utf-8?B?OFVqdGwwQU41Mmhmcmd1YXoyY2xNNTJxMWRsTStIQmRVSDhKckJrbmR3K0R5?=
 =?utf-8?B?Q2dDWlcxQis1czdweEg2L2NZbGhmOVFVaVpDU1pRT0NLRThHNWVqc1JaTGNq?=
 =?utf-8?B?VVhwZktFQTdwUUhVSERKVEpLblN4Z1NXTmEyYkxIbzdINk96K2hHakY5dC8w?=
 =?utf-8?B?dnZaVVBpaDg3TXNoSHp3RnVHbWVaMlFFaTBLTGJOWlNFYVZpTys4M3kvUndV?=
 =?utf-8?B?RExEclNjV1BpZkgzMkZ5djYrOVE3eXVhTGlyczFqRXQxcG8wUTV5VmROOWRr?=
 =?utf-8?B?cjhZWGhvRzR1ejdFK3ZoYk5GRFgwRGpkOVFOQUpkTW5nVzU4WS9LcVVXeEs3?=
 =?utf-8?B?K0Q2bmNDejlBTE5GNkdXN29oVjJhY1hpd0pwdDB1enI2TDdqMkhrdzFJQU1G?=
 =?utf-8?B?VTRiUXhBVWs3MktrOGFEcUozcG1scUJ3OXU0eFhPdGg5ZnVWUTZLRFU5OU1Q?=
 =?utf-8?B?WGFpTlErNHZJNHEwVXU4VHhLeDJua2JtV2U4R0hpR2dhNTl4c3lpb2ttTnJp?=
 =?utf-8?B?c2hkNkdhUW9XYmRIcEw0TTBTYUw5MDMwR0l3VWc3SStLVWg0NUFQR1pnSVgr?=
 =?utf-8?B?MXM4OWRSSG4yNElydHkreWorVlFONVpKZlVMSWhLbGVZUk0rdW5sMDRmMEE0?=
 =?utf-8?B?YzZpeGxINWtmYVhUaFZ6cmRLZ08wMWdTZEd4VmRSZVo4bjBzWVFuK0NZdDJq?=
 =?utf-8?B?K2RmOXpMSmZoTnFiUjNsS1QyeTBYb2d6OURGdUxiMmhvSVU1eWhIeUlpRFNm?=
 =?utf-8?B?Z043OTFVQjNsWmpDSm1oclllUmRQaVplOWdYZC9vTW16aCtucXhwbWpHb2pT?=
 =?utf-8?B?L2tURHhkZ1VKd0pFd2ZWV1RHUkMvVWFxOVdOcG5iNFB6NFRTeWFTYzJWeTkx?=
 =?utf-8?B?cWlUVWtEVlJidmoyYXdVTFFxZ2hxUGNVRmlUTnJyWTNNZktmZExVczNHMXBl?=
 =?utf-8?B?NDlrOWZVcm5HdmI3ZEx5U3NUS3JoQmRGMGNjWmdzenprenlEa1VhN1I3TVN4?=
 =?utf-8?B?ZmdVZXNFSkxIYmMzMldjTXNldTZVQXBrdmM4eUEwREFlNHBaV2c5UFloaXhN?=
 =?utf-8?B?T3VHQkY0dmhJdkpWMFNaemVVeHlHcmxPNWczS3BhSHR5eEg0YlVFYlFIOHJl?=
 =?utf-8?B?cmRLdVh0V3ZWLzRtYnN3QjhzWEljTnVzSDkwZ3IzQmM0RGFEdnA5WHRsVmlV?=
 =?utf-8?B?eUJPR3M1YVdNTHhDalR4eHZ6TkpCMi82SHRJNlp0YXpTNDNSUWEyVDZhV0t4?=
 =?utf-8?B?dVRJbGxhY1ZaQnJpTlQ0WWRUSVJ2MGlpU2VmU0FnY3FnZUxueGxFMVVja3Nx?=
 =?utf-8?Q?l12+4zcWw3NC6X6VlKzWgTiaT0A70Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEViRWswYmRrSWtxcmsxa1hhZ2ZlenZmakhJRUZxYlMxYU9RdXYvcXZhM2g3?=
 =?utf-8?B?MDlzNkZVeG1mbjAzVThZdXJpWHZuaXhFSis3UHd2c1hoeVpkUmYyQ09jNHJH?=
 =?utf-8?B?ZWsvWUVHMVZpbG9OWk9Nb0V2K21adnU5VHBIK2dJdkEwRklFVVFkcFlXK2RE?=
 =?utf-8?B?MVJ0cE1ENGxxQ1JqOUV3eUhwb0FtV2NPOHpMRFFXcWlIUmFBc2tMMFFsWDVp?=
 =?utf-8?B?QjhNS3FsSkFoVGRkemJ4eXUxdjQ2MnFOMC82dkxKbWcxc3V4UG5QdkxoMWJq?=
 =?utf-8?B?N3hYSVgrT2hpZENWODV5bVJQSEpaQkk2ODE1MFhYQUNCcUdnZjZWbUMvVmUx?=
 =?utf-8?B?amV0ak4xL2JGL2xHYmtTK3d2b0NxRk5CY1Z6S1d2SXJBdm03VVFSSnRNanpp?=
 =?utf-8?B?YU9lZmJFU2R0YmdSRGo2SUs2azBjUHN0aUIxam9wcE1SWFZnZHNtcUJ6b3RQ?=
 =?utf-8?B?MW5kQ3RCbExwYU9kRW5rakR1YWVyMUlQbnRZRUU2VVV1NUlBU1U5U0wxQXhI?=
 =?utf-8?B?V2Q1L1I0dzBZVWlaUmcvZ09WRGQ4cHJ4dWN6amU1S3h5eDFOdi9YYXFPMTJt?=
 =?utf-8?B?MWFEYUowRkxYdUFzZm9jWXJxWXNmSEJLVG03WS9GTFN6VnNXWkdKaTVpQmsy?=
 =?utf-8?B?b1FYZHFTbDRKOWx0VEVaanZUeWJvVVY5NjZ4NW5GSHBPV1pOamJCMmpQaWNw?=
 =?utf-8?B?WGVjby92OXNnSFgwTjJhOERzbTZRaUxoQ2lCelZzSnVGblNjVXlBajV4MGJZ?=
 =?utf-8?B?aHFtSUN2T0M5U3VIYTBtQzN3Y2xLR2JTb3RWbUNsZXluVnVzQU90QjdEMlNX?=
 =?utf-8?B?OXZheFZnSGMzS3RJNmp4bzk4b3Bxb2FZQjlIR1JKK1V5YVl3YWxuc2h1NDdH?=
 =?utf-8?B?NUxHVmJHNk9qS3NGeWFrZFRWaFRaaW43OEV4TllJdEVJTkxQWFlQWXUvQjg1?=
 =?utf-8?B?dHI5SUNHN1VEKzNZMGMxNmlaQjg1VFh1TEtMck0xUnlXdzJ6YlNqbGt0YzJN?=
 =?utf-8?B?L3ViRGhadmNMNFdxMUpOQjZuc3JBNDNRVkZDWGtGeVRYSld3Sys5WUNJbytw?=
 =?utf-8?B?anRYWFdQTFdRb0pYK0pLMXpCa1hERWNOSmU4R2JXbWRnSkErRnJEOGxKWTZC?=
 =?utf-8?B?RnRpb2lBanZMN3UvaFhaMC9pUVZ5TDJwdTJlTlFaYm5Td1M2YkRrV2kwTDBl?=
 =?utf-8?B?TXlocFVYQ3lIaVVzM2dtV3A5WlN2dy8xL0VSK2NKWm9yMzNIUGhJb0NSdE9G?=
 =?utf-8?B?YXhZN0ZsNmxvL1Q4NWdiWWFReTEyWklERWc3NDl6MVB4d2ZPeHpqb0VUOWRK?=
 =?utf-8?B?dFNSKzVKYit5UnBuN3R0ODR3YTB1NVVEejlKekk5RkxGSzhyRkh6Tkd6dzhI?=
 =?utf-8?B?WXp5UHJ4bnMxNFo2UHRERThRRi9zcVFHWW5zOHQ2N1VXbXd0eEVBTnJLM1k5?=
 =?utf-8?B?bjdsWnFkaFZwT1Foc3l0b1d6dTZ2di9sbnpQelRuNnA3SXRlUzJscU9uUHZ5?=
 =?utf-8?B?M1FTYWVBRjF5a25yRDgxRVU0NVFzeXBWME9rT3lxYzZhQ0V5c2YzWjdNTEY0?=
 =?utf-8?B?WVhlMHQwc2FLQnpsMHA0N0lsVkZmZXAyeUErZUs2Z0l2R3lLc0xkcjBGTnJE?=
 =?utf-8?B?YjRBVW5XcWVXa1FyUnBmUE05VE1GbW5aQ29ZMm9tMXhFanp0S09Xa25sRGhl?=
 =?utf-8?B?WHp5Z21sOVhSbmZuZkVXbFVrWG8rTkFQdXhKL1dwWlppeEt5WmRDSzNKQlZX?=
 =?utf-8?B?Z0xnaDFqL2ptVG5zMHFoaTZDS3hzTGpMamdXSUhFWklkQVp5RGZnNGF2WlJh?=
 =?utf-8?B?WlZ2M3pLc3N6bE04U0ROM3FJTUlMcnhCc2F5MERMVURBQ3N4RStod3FuaXgr?=
 =?utf-8?B?U3ZVMzczanV5TklxaE90Z0trUXJRZnZkRTFHd3h2MHlRNFNhcmFoUEpZM1FS?=
 =?utf-8?B?aWpCekpFUzhlSXpLUzVuMmRCb0lYY3h2dy9jbTdLcVJXL20vd041ajQ1WEFr?=
 =?utf-8?B?WWZVYnBOZlhOeUFEOCtSc2VKQlN5cW43VG9wcXNoOS9PN3hrMjE0b2hkaTQ3?=
 =?utf-8?B?QkF3U0FodW1BUk56RWNpRjFKREJGSkhISDhrYkdJMkVKRXRQbDVxaG1ZQlFR?=
 =?utf-8?Q?HsR3QhoNnkTsNlmrF5XkPPgA9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf84ee7b-89c3-4c3d-0f12-08dde0a2388e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:02:29.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXn0B4//CQuWuA14zy4E7mSfU/CO/z8yGc85/K+xAKQ3KGN5mImDCKzkRqZtHLZaVdtii5cXyERLCjKKxkPZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11540

Add JSON metrics for i.MX94 DDR Performance Monitor.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - add Rb tag
---
 .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
 .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++++++++
 2 files changed, 459 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
new file mode 100644
index 0000000000000000000000000000000000000000..aa7b58721dc7e23dc9d9905a79e0c1778b7bbf11
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx94_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx94"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
new file mode 100644
index 0000000000000000000000000000000000000000..629f1f52761e2210ef43a9cbba175871817e1230
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
@@ -0,0 +1,450 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx94_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bandwidth usage for lpddr4 evk board",
+		"MetricName": "imx94_bandwidth_usage.lpddr4",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (4266 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx94_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx94_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write from ddr",
+		"MetricName": "imx94_ddr_write.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx94_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx94_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core1 read from ddr",
+		"MetricName": "imx94_ddr_read.m7_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core1 write to ddr",
+		"MetricName": "imx94_ddr_write.m7_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core1 (in netc) read from ddr",
+		"MetricName": "imx94_ddr_read.m33_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core1 (in netc) write to ddr",
+		"MetricName": "imx94_ddr_write.m33_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx94_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx94_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx94_ddr_read.cortex_a_dsu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx94_ddr_write.cortex_a_dsu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core0 read from ddr",
+		"MetricName": "imx94_ddr_read.m33_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m33 core0 write to ddr",
+		"MetricName": "imx94_ddr_write.m33_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core0 read from ddr",
+		"MetricName": "imx94_ddr_read.m7_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of m7 core0 write to ddr",
+		"MetricName": "imx94_ddr_write.m7_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx94_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx94_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx94_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx94_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx94_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx94_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx94_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx94_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of aonmix read from ddr",
+		"MetricName": "imx94_ddr_read.aonmix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of aonmix write to ddr",
+		"MetricName": "imx94_ddr_write.aonmix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00f@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of npumix read from ddr",
+		"MetricName": "imx94_ddr_read.npumix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of npumix write to ddr",
+		"MetricName": "imx94_ddr_write.npumix",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx94_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx94_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx94_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx94_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx94_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx94_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx94_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx94_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx94_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx94_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx94_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx94_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx94_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx94_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pxp read from ddr",
+		"MetricName": "imx94_ddr_read.pxp",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of pxp write to ddr",
+		"MetricName": "imx94_ddr_write.pxp",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of dcif read from ddr",
+		"MetricName": "imx94_ddr_read.dcif",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	},
+	{
+		"BriefDescription": "bytes of dcif write to ddr",
+		"MetricName": "imx94_ddr_write.dcif",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx94"
+	}
+]

-- 
2.34.1

