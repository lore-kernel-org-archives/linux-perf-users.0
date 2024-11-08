Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2106.outbound.protection.outlook.com [40.107.92.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF811C1F0B
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093101; cv=fail; b=IW5VE7P5QWAjUpJUbbMMhlrTl4KZXXPxeOAM4HBvOSVYlAyXBBOSGQbBFsx0vl4B0XpOzZAXPLrdhUKrBBX3gypy4zS8gkCJj/WupT956H9kSXZfhvSEZman2+MNy5XZ9SjToIsfmlgVyCo1lDrvKsD3E8IJ4YsXP7HA1aB5Cvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093101; c=relaxed/simple;
	bh=PRJOCUp/3e9CKz2quTogCaU6tHml5mbPSeeXCj57ngg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YmNxk/AM/0FdjUW6igE9Ucx4q67vjO9pNwug/nnESDyZu7bqkfs8hWuUbwrN1wheqKcakH5D1X1kyTWsFN+pKjXMy3LYfeLH5T7Pr8rza35OYe7Mbylld4To1tjYkDaj6/Uii5yxI7k3dqyQbYXtJ5wWOn3nC9D7g57NdntVwWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OArtzoVK; arc=fail smtp.client-ip=40.107.92.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OArtzoVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xid2UnOyOXOOcVw3fbrKq0LssndYXeHUPFGe6UhVOCvTjsPuPtVSKthZTvrFzrYk2st/GZjSeWMCViRfxX0pt5VHhmK3n7G7H0azzztceJPLG8+/qiPYxNER19oqxdXmyy5fqTYRf5x7RgArWxVGJbxUoSlAMskM7K1E2CU593OKl/ICM2fMVxy0LdT2ivK1KbJyHWuKO8i/2z58hsqPCJIKoPEiw33BMj6o7DWDG3d6t8G4JGlgS9bWut+qnPvcAEQyzI6LWdqxtBAEiyK09q0UtLkYZs8oeXmzKsoBgEB+JYHX9l6Xd+1SC0W99gZ8+2kepJxms5HW+P5krA66XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU7Y0g0VF+ONxHWmu6ThGdzotKxiOmnMyZ1I0Kb3GRA=;
 b=hwvtNWYQ/m0ueD/RW4ing76YuOMwgYzKmb0KYp6iL+Sw1X4ysY+v0hJEq0Gh4dA9tKph8w/RCNhzrrFsI7IWlcqaAF2Y99W85xdjqMmrJ6KSWv6BzY6FwWcGXKsNPwQEcTJWeud1Q04fscY1Qh7f/LLCaGmWtwB++syuP3NPLpKPLOPzI0YfTUs+6zMYyACaw5jZcirwy7F8+O5aY44ZQoa0TsFdhTqcrAYVOdrfJnO/nB4EgKiq3gO28uWpnYw/bzNa3nHy0UrWpnu4yYplyayqrSs2tm2EiUZWASVhmfEHd1EyuA3l9LoKYcSIi3ZsNkqap94Pg10MZBU09Z1eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU7Y0g0VF+ONxHWmu6ThGdzotKxiOmnMyZ1I0Kb3GRA=;
 b=OArtzoVK8M7S5vymseF3B/J/Y4fsaA0y/g/8F9cQDAFKOA1FMxoS19qwUhYda1MWDS9NWix60UTQQba4AgxSHTMtOJ+bQcofrQPwCyKUU+NPGjuQahr1yloPzB6gCecYnoFmQzqHtrVzhmbHeo5Xy+7Np24YTvQ2hbEdr4qwscE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 BY1PR01MB9089.prod.exchangelabs.com (2603:10b6:a03:5b5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.11; Fri, 8 Nov 2024 19:11:35 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8158.007; Fri, 8 Nov 2024
 19:11:35 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	namhyung@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V11 1/2] perf script cs_etm: Add map_pgoff to python dictionary
Date: Fri,  8 Nov 2024 12:11:18 -0700
Message-Id: <8d9a1142dc58ffa34a000cb7b7a26055df0a37ec.1731027120.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
References: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0036.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::14) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|BY1PR01MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb4ab84-6e6e-4180-5bff-08dd00292a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkhETmI0MDdVV0tRcHdmL3B2RDQ1eDZmc2VXbThNUm9Fc0NXTTJiaUpSZnBw?=
 =?utf-8?B?UEhBaVRhU3FEb1pZR3d3WmtGTnMxbnVIWEkxRU1Jd2FOMi84N05ncFQvbzE1?=
 =?utf-8?B?TnNqbXhVQzB1ZjMvR2hPcHFrNFdOaGNPNUdWWFpzNjVNVUlVOXp4ekMxYzVC?=
 =?utf-8?B?cUNyMlo5aUNFWktGUkpBS0ZIMHpIWmVJRDkrOUN1d0tvOHlDRUVMb1A1RkFh?=
 =?utf-8?B?TVN0NFEvakhkcHFjNTdqUFJHR1dvQWpJZ0thcTc4WjNqY1c3Slk2cndGdWZz?=
 =?utf-8?B?VG9OUkNaaHZtT3lXaVA3TmxrdElEYkhzdjJjKytYNXFhd2hWR3A5amZJL25N?=
 =?utf-8?B?Wnhkdi9xdTNqd2pCZnpZTklXQ2pKQnRReElWeWtwWXNOdFF0eDMzQnJWK2VI?=
 =?utf-8?B?WkZpVzlYVEVUTGJXSnlZRUhFTnFBeVYzRktHbFpscm5qck1kWHE1TlZMSkpp?=
 =?utf-8?B?WFpCMnBVV3ZwQ2MveEVZUnpNOHFaMlRLbUtGQTdQYVhDWDdrbjBjRmw5WHpM?=
 =?utf-8?B?RFlqQTRJNDcvYnlha1ovUkN2cnFTTkNJYXFGdWlhT0k4aFM2R1VCdUgyYXBN?=
 =?utf-8?B?YUxHbWNldTVWYzNpZzBxSGx0ZGwweGlWdXJHNHlYUkc2SjgxbU80WmFZNERn?=
 =?utf-8?B?enh3YVc1NW9WdkR6Z0Q5QmdhUEM2c0MwZVRmOUxGdjhtMHp1T0RNRUg4TzNI?=
 =?utf-8?B?Z0R2T1VsN0JQUVcyWFlmeXFlRndUM2xyUmF6TXAwVTVrQnEvaDZIQnh3WXVR?=
 =?utf-8?B?b0hacCtlcklpZmtsRnY5R3JjREVJbS9yT0FzdUZKTVF2Y0RBRW9oZVNMeS9h?=
 =?utf-8?B?TFZ4emRER3U4YmhyN01WTHduTmgveUZRdDJTL3Y1R0pzVWFFTlM1VW8vUERF?=
 =?utf-8?B?NmRPaCtTVW5IT0JQU1paYjR0OUlaRUkxaUVQVG5SUC9NQ2NKbExVV3Iza05I?=
 =?utf-8?B?MUJOR1YzQktURU03MFRaQ0tCaFZTdWdoV2V4d0ZHU3hSaFdRMm0wdW11bHcy?=
 =?utf-8?B?aFV0aFV2T1RhdW9Sakd4OFJKMmxPRVNDNW9mTlZRVmhseWVMNzJDckVvSE0v?=
 =?utf-8?B?YlhLUzVzRDVzZXNkVm1VbGxSUUJJNGxXSElmSThESFJwWUxHN09YZUgzQ1V1?=
 =?utf-8?B?UG4xSWh6d09nQ0drWDhBcFBHUWovZlA1SDZiOG5udDQwakF3c0ovaDFrc09v?=
 =?utf-8?B?V0p5K3EvS3UvRHQ1WFlHaGdzbVZpeGZFc0p5RVhOOFJtUGpGMXJlbGppdkVG?=
 =?utf-8?B?Zi93aFpvckY1Q1FOM1VHdmlEcE83MTVwNHJ5R2YyOVFYVUpSenhNR3Z2NWd0?=
 =?utf-8?B?VmUwOTBBd0dhWUIxMVBIRkRzRTlRcWdjaDRKS1JxNGZwT2FES2N4M1RJQlRJ?=
 =?utf-8?B?YUtPa0RhZzF3YzZaRkVXSkhaYWQ3anp1eWxUUERMR1VyR0lza1YzbE5HVkdC?=
 =?utf-8?B?SEthSHlEeGZKNi9kMjZsR01jZytxR2crR1Y2Z1AvZi9vWFUzUXdpMVdhYzNS?=
 =?utf-8?B?Q2Q2d01DOUdaeFMzanZLdERGUllHUXlUNWp2OCtENTZjakFqNW1GazNuL0RJ?=
 =?utf-8?B?SUhpT0pJNEg5M3RDOGJzcGxmdlJMZzNIVTRtaVRmcWxzRklVRlllN0dJbXg5?=
 =?utf-8?B?VS9lbWUxRWRUMFYvNCs1d05nb3NZQm9sa0NGZjZ1d2hkTW1sYlBtRTZ3Nk9l?=
 =?utf-8?B?ZUdUYzlGS05OaWtmKzNDVXNEYUN5OWUyU0hqbFFkTi93R2JDNE9RWG1rZlQ4?=
 =?utf-8?B?Sm10UEg4UXdrS05BbjV3aVc1Y3hxbVNMWnFJUklNMWlYY2ZFdDVocjU5K2Ju?=
 =?utf-8?Q?Ebi0fRLoVJlhgeNPEfi2BtvxWr90Tf71XAJUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHJSQk9SaC9jcTVXbUl1YStNNTFjWWRpZFI2c1pINHBmMUZFYjljSmF2dVJa?=
 =?utf-8?B?ODJieHdHWi9zM3BuYWZrTzVWS0MyMVp4STAxSC8xYjU5SlhaZGZIV1RMd1h5?=
 =?utf-8?B?dmczL25jWVJoeDdYMTZqSzJTQWt4Y2NEWmI1TktPRUJGRmh2ck5iUkZGVUp6?=
 =?utf-8?B?ZTlhNkhDdHl2NHBNZ1BHYnpFWWpRalpJdEZKZHpxK0psbFRGNy9tYmdWblJp?=
 =?utf-8?B?dCtwWFJsUHhNUVRWV0hteHlyNWNWanRVZklqL2hnUDRlY2loTm5MdFlhQTNW?=
 =?utf-8?B?TDdoRUdsWjhDTFI2RUZYSTR1UTRubFY3OU42S1ZsOGo5YTl2NGljc3lscWU3?=
 =?utf-8?B?Q1FOaUR3WFZDQUNQeXFsRWYwMWdEVTNHb1Y5V2s0VEErWXYyczhSQnNaYkZG?=
 =?utf-8?B?S3BNQ2xRRUJaUm1wVElheHYvVTBQTGI2djBOSW1LT0N4cktscHYrWGZKZDNj?=
 =?utf-8?B?SnpDd29hQlQ5YkM4UytXejVNTWcxZE5MQ1dzKy9tbXcyb3NqUFZlZTdLWjRU?=
 =?utf-8?B?QmVjeXJQai9wSDB3aFNhRm1iWGJQcUh6RW1KYmx6ZUp4bnRFd2gwVlhpaFVN?=
 =?utf-8?B?eC9uSUdYL2ZEa2I3ZkQyTFd6bXN4STZMcW5TZDY2L0VFQzlUSHF0OGxiNHJa?=
 =?utf-8?B?SC9JNm44WUI5b2F0Q1BxbldZRmVQcWdYTWZTZGNqQmdJSjJtWlNzQnN2cWFY?=
 =?utf-8?B?SWVuMUpUVVZrTUVQbW1Hc09PT2VPU3YxSjlUYjJkVm80cyt5eWtDcTUrM05j?=
 =?utf-8?B?SmpKNWN0Q3pUcUFyU1pkcXlJR0lFeGtQS1lBQmlmOHJKbjMxdDhJYTlNZEFU?=
 =?utf-8?B?eEZwbi9meXZuYzEzWmZ4MHp1VFBLSUNFVk9WSXd5SmxaVzhPenlMVmVKQ2hH?=
 =?utf-8?B?Y05HaU02SFVyUDNVUnk2bmRHUGcvWVF3ZzBZclN1amtDRmV4Sk1DQ1hWRWNw?=
 =?utf-8?B?U3ZpN3dGU2IrVXU5RXFLTU1FTENMNm9aeDFwRTZSM1p0aEY0MnZzbUJqRWtp?=
 =?utf-8?B?M0hzTEhMeGR5SkJjV0p3aTFYc3FQOFVXQUVOQ0E0Rm9KU3ZCZzlmTU00d3FQ?=
 =?utf-8?B?Z0RMVHRNMTVFVEk0T3p0cjlLNEpONU5IdGc3eUpCNmpqK2drWlIxdTdLTFAz?=
 =?utf-8?B?L05oVjdvanNYK3lrYzl1Ymp3YTVPYkhqUll3R0dOa1c2QzJUSUwxVm5GZXR0?=
 =?utf-8?B?dWtrUmtLUlpNNW83VjhQNHVBV2VYT1VFWENEL0lHbWFHQWMxTkVGcmFVc01a?=
 =?utf-8?B?dWVkTyt0WHBjMGxNNDFXRXNDUGJyOUVXMUMvaHRSc3MvSFFmR1EyZ0dsK0h1?=
 =?utf-8?B?VXVyWFRQampTUWNRVUxtTER3alg3OXhTU21aQXZLQURmVVFjcUhOZlllMmo0?=
 =?utf-8?B?cVdzeTJVbElFTHBzcW85REJOS2ZrZjVlQXY4ZnZPK0dKblpiVlhSRTg0VVRp?=
 =?utf-8?B?akZWRENBMlJsRVdocVZ0NDJkWGR3WDNqMHUyYk1YYVdtc0ZYTXVHNmpIQ29n?=
 =?utf-8?B?V2JnQjZrVWtoMnArM2F3NWcvTkVpeXhjQVc2V0FRVjFzWGIydTVMRTVPSndK?=
 =?utf-8?B?OEluY0Z6VnpQZENFcExRTHRQME1BTVZhNFh0d3ByRnhRaGFOVXozdTR4bWla?=
 =?utf-8?B?QUF0KzhWaDAwZDFMTEVWbVc5TE81emtiNkluZ0JqSjEwTXlmR1k2MEVkdGdR?=
 =?utf-8?B?SzdjYVJ3MmRkcWIzcUhmYzN6N09wUVErL2xOb0Vjd0ZzaXZzdDBwOEhxVFhB?=
 =?utf-8?B?Y09EREFNUExCc2hEVjRJaGEwOHBvVVRLMDU5aWNsUWIzdTVNaG0wZGNEenli?=
 =?utf-8?B?Qi9KR2hWdzhFUEJONzVyYVlYMVQvcXlDWHBwR09xcFJXWllTN0xaeWkyU1Ax?=
 =?utf-8?B?TldhdHhCamtvWFdRNS9jYXhyckk4SlpzSmVpenFQWjRNRzRJL3A5SWYwUlox?=
 =?utf-8?B?OERlR25KL3NsTlo2cUtaOUZiTnRtTWgvaGhRQUZJSERWeGhIMU1icTRjWEdE?=
 =?utf-8?B?MytyS2dlaTNKV21TZit6VnJwQXlDZEY5MFdhSW95VUtUcTZINjV2QXFucXgv?=
 =?utf-8?B?T2xOdnRISzN0aXZwNVk3SnBMNVBSaTM5ajZOUlZIMnJHM0FMTU90UXl1bFo0?=
 =?utf-8?B?V0xka25TNFkyQTBDRG5ETzExemFDTTUzNTFHSXJKWTVUcVpaUXM1Tkk4cEIv?=
 =?utf-8?Q?ohQoG1P+irXVDg9VNXbMSZ4KWBYs0KGwXs3iFMn1AIwu?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb4ab84-6e6e-4180-5bff-08dd00292a0c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:11:35.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCLksHzbBIq7QKCWldkxyu8xVfxHc2jl3FKw9UDm+ed1vGFRUggRqCPPjKe5VzdCltIxC7+v9h7YPLe9C9UJLnoeQ5hBvgyFmgcLOv7IuGHnpX1de0JnU5WnrSfSjfpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB9089

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

A zero start_addr is filtered to prevent output of dso address range
check failures. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7183134b669..e6d4711a7d69 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -793,7 +793,8 @@ static int set_regs_in_dict(PyObject *dict,
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *dso_field, const char *dso_bid_field,
 			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field)
+			    const char *sym_field, const char *symoff_field,
+			    const char *map_pgoff)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
@@ -809,6 +810,8 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
 			PyLong_FromUnsignedLong(map__end(al->map)));
+		pydict_set_item_string_decref(dict, map_pgoff,
+			PyLong_FromUnsignedLongLong(map__pgoff(al->map)));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -895,7 +898,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
+			"symbol", "symoff", "map_pgoff");
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -920,7 +923,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyBool_FromLong(1));
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
 				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff");
+				"addr_symbol", "addr_symoff", "addr_map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.44.0

