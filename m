Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E3381AF
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809838; cv=fail; b=TyllNu0KbFFpar/A4/XO8i10o0I42j+m/RpNGLfaAE3w0rhvaDzi01A97YnQDWLLg4I+z1CsZu2xe8cHHJDJHHmzS2KMKUTKFRdWfut9mF2rjeyVzAnziUM00TclQ8OhQ6AwqZ/VCyKYwwHIqOYPekmrANM70S5w/d4FF1Jm5PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809838; c=relaxed/simple;
	bh=fOtGtNIfviqc+tR0octYlWhz/Ce085hAZNdrGONbAII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kQ6v5aeBOLrsmjlOM+UUNT3nEJ9KFYE/azqSybQG7R2b/XDw2wYZZb9TFbFhgpnPga8cbbdDvcLwAMC51ThVRPxmFI1IoXvKGwaV/zlrnHY7XFHY/IoHf7ogKJfZE2LCdIGW1xIAJbIa65JLZ7g4HvYmAnkjmQrbz1qaOpNzZ/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=f0Nx2w2d; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="f0Nx2w2d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOIN5BFgNPzhwtA4SYO4Cc0HBDrZ6Tya1AQr4JHarh/L7ZOjUYnklDEef9qgicZ9jNgDwtjfmCm7n91FO4J7r24vvVVSsZZtCckgL5/K2JJ1p4jsgloEJOWBDw1d7tA9VIcdNAmg8mIt/MTF48+3qvVj9+W1YSp0lMqoroizCLxomU/crfUS4Wu7KsaFL7de5HdAto66y2a2jHoiXfK6v8mT7Iv2F9XFdtD/IDqz20/fY1H51M690EI+5HF4u0rrlsEDeSnKz2oPlUAfFiaiB1Yh/rgdPKr74/3t+iZg9qSzduzZ9SLn1TddESaqJd77ErC/VcEu2ctBciyYaV6DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YigPosKCyA+QVqyfOxzq74WG+dtaoYHC96nYTYgVgG8=;
 b=LFGcknnEH4Ty3nrMb+QBwW9KqW8+Y1+fs+gXJe98stNq34Ntxzfs8D4Yl1plMv/CMBu6NuxwzX+vQXMJqKS+3lPe8G4crv/dvrrZ28PkP5UgzT/bVfUnJyo/6l8U6PtyMpE5CLJfPmkCnl1opxJHda7izgYGGjYitKU94iPQHljjcBldTfy6P4X79DGBIufbwfVa/UzTdebmPwoTXeWYtPoSixA2zrDJN7CSpg3TZvUvVgClMLmMMQ8M8zgxC4EN7xJbi0oLVY8MVdFT+Y+jNcdA1RxSX4Q6QC2WP3pc5z8B0QoIyuV3VTc2wtB4rUrqk5SLKb8ZLfPJIwmWrcdm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YigPosKCyA+QVqyfOxzq74WG+dtaoYHC96nYTYgVgG8=;
 b=f0Nx2w2dOBZnRkurLyQYMLYF3npO4dTc0TZpmoxsT7k+UB9wRA57l1moyuRc6+3KV5cPZv+Qyp+fNWcHxC+AUJEJ24iYVrcC+rqfqP2GWq7SgjP2+dTtVag7iDW9G0fjEAfaKqwR9frcCBxa0kriOtNPhBLborbAkgdFUAxZRrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7576.prod.exchangelabs.com (2603:10b6:408:17c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:50:34 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:50:33 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V3 4/4] Adjust objdump start/end range per map pgoff parameter
Date: Tue, 27 Aug 2024 19:50:13 -0600
Message-Id: <2c8d8f931a1484939fe0251424477f2e53423417.1724808513.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
References: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d692de0-3c00-4c7e-a574-08dcc703cdc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUhYVkVrZkU0aFlQOXZIVGtjaGFMWVMyK3publBhV2VJcytNcXhCbXF1MjFM?=
 =?utf-8?B?TmFydjJXcVhoM0pmTlVLSHdFb21EZXMyTG04QTM0a25lZkhGclNHemdFOXFh?=
 =?utf-8?B?TGV1cnBjY1ZMZzY2c3RDRHhTaGxKVTVaRmVOaUZOUGhRNlllL3V4ZTB4SE5a?=
 =?utf-8?B?Ry9PUWNXOFBkbldOdGdHOFNxN2NQL1ZpdE1WemtveCthSkxENk1lU1dmOW9p?=
 =?utf-8?B?L1NxSVNxaDVSRE9YMjFwME5adUk4Nm5GWEp2YUFhcTVmZHlOeWs3dC91Q1pM?=
 =?utf-8?B?MzB0Tm9BTjkvT21uYlYzeUczd0srRHJZYWk0TldTQlNvUW9KcFdJSXl5TUhn?=
 =?utf-8?B?YVo2NFljVkhRaGZ0Q1VTTWxDaHBnY3Jmb0YwZnhyQmZmay92UnRjWmdTZ1c1?=
 =?utf-8?B?MlBGYkpaVStPcXhaeEJ1UU00UmhDbFlrYmpzNjcxd2VPVmhLWElyQzg3R1RO?=
 =?utf-8?B?M2g4TnlVZzRTTFZRZ3dKUm92OEhzbmh6ZW40dU01cnVmZCsyU2ljVEhXYlZ4?=
 =?utf-8?B?dW5CYnJSUE4xYWtnczdlQThaS3AvdGp2UWx4TmdUNlhtdzNNaml5bHdqY3Fm?=
 =?utf-8?B?MkVNei81Q01qcFBySjYwYXkxVGhMVVRjbVY4dFVVMXQ5VkRKUWI1NDFLUlov?=
 =?utf-8?B?KzBDbVVPQ3h0VERpa0JiZE1EZXdCdEVFTWVXRldpeDNRWThqN2Nhd00yUUkv?=
 =?utf-8?B?alo0R0tqODUzVkJiclpvQm5BTFFDZHZwYzhxUmpmTkxwZzZpdGdvcDBBem91?=
 =?utf-8?B?WG80NW5aSWszZ3lwaTZNM2JNNjFpNncxajdqU2VydFF0Zm1qWWVuVGJDZ1Mr?=
 =?utf-8?B?aUlKWG5Ea1FpWW5WMDZ1L0R1WHd4NlNJVXdWYUhmUzZlK0NkTzVKaGlXTjNk?=
 =?utf-8?B?SS9DY2dCbWZna1U0OURkRUp2akFhZTFCSmlicWVnZTZlY2h6UWdHd21mOU5W?=
 =?utf-8?B?WTF3d0dhV3RSK1FSZDBybERkWG4wN0dyWFNxNkw2dnRhVWZNRVVxN2d4aGlV?=
 =?utf-8?B?bXZ3cy9UQVNOL1RjOW9LVGtuYjhHUklGMFVWaEE3L0UwdnhFM04yZ0hHTnNu?=
 =?utf-8?B?ay8xS1E0MUtBcFREZmRUZTIzL0hYakRraHBXaXVJRnVVVDVmMndsZHJibGIy?=
 =?utf-8?B?TjRzSHpFd3NXY1FQQlUwa0RqTXBoOC9EdU1sbkgvcldNUEE2WngyNzM5bHRa?=
 =?utf-8?B?ZnVNaWcyNzRaK1JJUWVzYXNpeldtWkFuRzhhRllGVTI5YmxMK0dJeXIzdW0v?=
 =?utf-8?B?c2tqMno4K2FyKzVHbHB0ek54bm1sdlR0QjVYbFpya0ZqRWlhbmUvQlh3ZWMx?=
 =?utf-8?B?Z1lOVjVBMnhKa3pPNG9RZW5XZGtMZDBza1R1b3NpNUViZ1VxUHhsOFBOQ1Qr?=
 =?utf-8?B?NDJOemg0OUQ4cE02SFB4eGMzamdwb1o3Z0EyZ0ExWnZ0Q3E5ekFTTkxtUEs5?=
 =?utf-8?B?Q0JJeTlSTnB6QTJnaUh5REZTUVU3d0tsZFlpQ1pwdFFObmlOUURpN2hSTWJC?=
 =?utf-8?B?YnlFWU5lUWIyL2tVcURVUDRFc3V3OG5tbFZGNmZ0MmgyYldHQStMb0pMOXhm?=
 =?utf-8?B?R25VSmZTcUR5UUp0c2pDZklsbGZOa3FtSU9WTExyTmV3N2RJNzhnM0c4VENE?=
 =?utf-8?B?THppMkRsQ2xVV1BBeDZLVnBHUjBnTkRlUmlPY0dVTFRtZHRUMUducndqd2Rz?=
 =?utf-8?B?MGFSSkRqNjk0cHdUcktGVW9tMHVpaDdNeDZYV0xnMUhrOFRLZ3phNDBKWjhx?=
 =?utf-8?B?U0krWmhETUV2QTFnSzQ1VW5raG8vdUl1aTcwbzN2OW0weFJZV0VwQ0FWbWMr?=
 =?utf-8?B?ajZwcXhYTXI3YkdjMHQ4QWhhSjl6ZjM0TDZXTE5iL0Z6QmIvZUMxeml4cGRu?=
 =?utf-8?B?eUY4UWd0U1ZtMzZGUXdLcFQ5T21ESE9EaDExcjVZSjBhenc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk1veEpxM3NrUTV6ckh3YWJMWE9YS1c3U1FDbmh2NkI2YVBoOTNWa0cwU0VD?=
 =?utf-8?B?VUJ4cXUrbDNqM2NPejlUYXFpTUsweGFOZ2pPRktIVUhBN3h6UUJ2eVVvdHR6?=
 =?utf-8?B?c1M3eWtaNFVqTWxBZ2MrMlZmVi93ZHh6SnZYcVRURWozNXRPc3pscFliMHRP?=
 =?utf-8?B?RTFndU8xVDc0VFVEWEFHbGtLZnB0WDNlbHRUc212NWlOcEMydm9rY3R5SHZT?=
 =?utf-8?B?NlY0U2lKQzMyNGNIa29aRHRhMDY1TlYvRkJmMXd6bkFGTHJwUVl4citmU0Rs?=
 =?utf-8?B?RDB0MDNTRjhrV3VoYnFLeHA4KzIzc0dpZkVZQzFzcWNLbElQQTRZeFRTZCtK?=
 =?utf-8?B?OEFxL1FuVGp3VXVRdC9YcjNmd3hFYjIvRkFqbCt5elhRcm56QjhSOUxlbk5j?=
 =?utf-8?B?WnRrRXF1bVZEUXo0OHAzY3N6SzErT3k4cURxY1VEcXhZYzRtT1JGcEhlMTlK?=
 =?utf-8?B?dnllcUFVRmxtT3dmenV1RXQyeHdmOTUzcWZ1NXA2blZ6aEUyTnU4cERtSUZh?=
 =?utf-8?B?UzBCcG0va0R5MmNIQk44bHZQanJvcDJTWWtBWDBwUVl2MzlIQlFRSFNlVGNV?=
 =?utf-8?B?ZmRITGh3MEZLbTVDQ1FoNjErcjYyNGhwQkdvZWVLL1B1UnJ0dlpqMzJKNTZV?=
 =?utf-8?B?dzV3b2FJWEREbUVmcmxqMkh2c2U1cVlGWlRMVnFyMkNHTTNyWm02UDJFSnJJ?=
 =?utf-8?B?MWREMTY3cmNxTVp3U3pCYXJZOHZOYXEyclh2eWVsUmJLWVQ2VXJmN2poeEVi?=
 =?utf-8?B?d3BoNFQ3VXhVNHF4YjI3UUhkdDVWb3lpZkZlbXpndUtlZitNRFErVk9WbThZ?=
 =?utf-8?B?c1V2cC9ZTk5NWnpKQS9EeWNDSTZhRXp1dEJ1ZDF3MXgzaER5b0N6WGh2Tzhk?=
 =?utf-8?B?RjZTYjhEMVJEODcvdzgvUUh3WGRPUzlEaHJOVEtLUm5xLzJiNlBMeVBxbjkw?=
 =?utf-8?B?elhIQ1BFaUhhQm0rNHY3YXFQQUVEOXB1N2xkTXRmdjBqZzMxRlZXT1ZDNkZj?=
 =?utf-8?B?YTNoZFNPMTAxMGZDYmpRcUxGbk16dW1SM2VoM1Z5akdxWDc0aGRJZk5MNWc5?=
 =?utf-8?B?UUJYakZ1YmV2UmJFR3FiRkJuT0Z2ODRrY2lLS05rcDgrK2RkQ09NM0JFYVE5?=
 =?utf-8?B?SzJtWkVJeCtOa1FNQUd5V2c1TTcwR2YrUDU4T0NNZWRPS0J1a2l5YTVKWlJD?=
 =?utf-8?B?anJtNy80RUlkOXNzKzZFdVhSdWttZWRjcm9jb1pFTUplZUFpQWh3SlFYVDNj?=
 =?utf-8?B?Zk1Ic1MzKzZFUnNwTzdOY0V6MEZLcFlQenBkKzlHaWMrcXppSm1wSnkvVS92?=
 =?utf-8?B?bmhJallOQTRHVUtTdDYzSzVlM3I0QVR2bzhVN2hBN2daMEFTQVRCQ001cGNX?=
 =?utf-8?B?STlMZ0RUMnlHUS94QWc0MHVEdTVuYm5zNUlEQVFNdm5EOHVWTU4xVnFGTzlE?=
 =?utf-8?B?a0t6bjZrWktFQlNpSjVxWGlRczkzZEVVeGZEYnVtZWtTRWN2Y0NLVml1NjhX?=
 =?utf-8?B?UW1yS2wycnhIYlRZVG9uQlFQWDVVNnFSeDlmMnZTOFFsOU5aZ3dlaUpITi8v?=
 =?utf-8?B?MkpidWlMOHU4Nnc0ZDFhcDRqZU0vMVRvSG9vQTRTMmVPazN1aldzbGh4WEty?=
 =?utf-8?B?ZExQcXROQ242Q2hvanQwVXVQTkhnYjhUY0dHcHpTNmNyQXpaTk5BSnFCeUhp?=
 =?utf-8?B?aHZJcXdBY3lWZHpxMzZzeHR5ZnU0MnVZMzJhM0U0dU54c1NpOWkwcHpPQWh6?=
 =?utf-8?B?TUhTUk5xL1JmaW9abnhicGgzTDRERHpRM2t1SWhsT3pVWmFuc1VwdUNiRjJv?=
 =?utf-8?B?Q2hHd2dBcTVYOGZMSC9BVG5rYWNEc1dvZUF4alE1UzdEUXdSMTVEYmsxYWlx?=
 =?utf-8?B?Tk1BN0czaGZXTDNLSUUzYUpWb29UMHQ2SVVFZ2NLSlFxR0hEeTVOOFdxMlZq?=
 =?utf-8?B?aXhHS0d6eTlGa2tuTzBLa0VOcG9XclhaaFZkcUp1WUk1WVJiangxQTBvbEdp?=
 =?utf-8?B?SU1NdHJENUpkUEVLT09XSmdQUWhMeHJna0dVVHZCRSs4QVNueWJRZVdwVjhH?=
 =?utf-8?B?eVptZnJjVCtzR3dnVVBydSsvYVRITDhSNy9VWHRpZlhjbVNUVHRBM1dnZVRY?=
 =?utf-8?B?anZoNVFLdlUyMGc3WVJ1Sk90eVRFT2VxMzBkUWpTM1N5bEFuNnNEVGVXWVNi?=
 =?utf-8?Q?DHMO9Oc6y8rjrvCFXavoy+QezrCTzRO4zNAat0x2MJ9E?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d692de0-3c00-4c7e-a574-08dcc703cdc4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:50:33.1787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RcPW+w4KeqCwm+zfwCLhLLDUPSiwOO4BSSQKY5QOEbI+XN8pVQWOs2fo2cR60jkLI/vqko7ytin1pGPYhhGofc79iNzI7ldNrTwcVbEP7UqsUag1SkzDtN37H8CfX3h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7576

Extract map_pgoff parameter from the dictionary, and adjust start/end
range passed to objdump based on the value.

The start_addr/stop_addr address checks are changed to print a warning
only if verbose == True. This script repeatedly sees a zero value passed
in for
      start_addr = cpu_data[str(cpu) + 'addr']

These zero values are not a new problem. The start_addr/stop_addr warning
clutters the instruction trace output, hence this change.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..e8cf5d80d850 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -187,6 +187,7 @@ def process_event(param_dict):
 	dso_start = get_optional(param_dict, "dso_map_start")
 	dso_end = get_optional(param_dict, "dso_map_end")
 	symbol = get_optional(param_dict, "symbol")
+	map_pgoff = get_optional(param_dict, "map_pgoff")
 
 	cpu = sample["cpu"]
 	ip = sample["ip"]
@@ -249,11 +250,13 @@ def process_event(param_dict):
 		return
 
 	if (start_addr < int(dso_start) or start_addr > int(dso_end)):
-		print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (stop_addr < int(dso_start) or stop_addr > int(dso_end)):
-		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
+		if (options.verbose == True):
+			print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
 	if (options.objdump_name != None):
@@ -267,7 +270,7 @@ def process_event(param_dict):
 
 		dso_fname = get_dso_file_path(dso, dso_bid)
 		if path.exists(dso_fname):
-			print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
+			print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff, stop_addr + map_pgoff)
 		else:
 			print("Failed to find dso %s for address range [ 0x%x .. 0x%x ]" % (dso, start_addr, stop_addr))
 
-- 
2.25.1

