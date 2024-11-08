Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2106.outbound.protection.outlook.com [40.107.92.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2C1C1F15
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093103; cv=fail; b=TynPNGnOgZq4SWEckUo23FTc07tn6Q8m0V7pVojeL0vVvraiR6Z2iuEVyljJwwJRnP0p7iR9YopKBUEqiqRGZMAMB3WUt2OkDkqbANszsTdTKYaHeuGLXHhLq8cJjPeQgkc7lDg/NFQPS0t55FNvnuTTvZ4XXx3aiSPNTZs2usY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093103; c=relaxed/simple;
	bh=y+DfCNmgIzVZvNKMf1DKAmTf7cJGIp9f50GL7nTBUwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQjUFmXw6rQJaN7N1E9KFBp1+TKVzjDC72HWQALOII3Ip7Wve4Dc8IrcPbaBNX0z198t0yMy526BmG4+Ce/s+nt+c0FSMS/yB1oX5840cMn98bnvoeXNhrRPuf/8u2oxDoJdgAp7iAYhD6/+K+HwMJbsB1aOEmngbnhVJKMJ1Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ep9I7LN0; arc=fail smtp.client-ip=40.107.92.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ep9I7LN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdtJX+D1g9KPbUBT0eISsPxoFb1f0ZFElUnQyE7Wh2FSZZtoAOiDtleUJjIMT3HwqKcXFA57dl4J/gS7pwN2KjX2BrA6V5zO28EkW+UEi2ZCuv7dZ1OryGaJyaywmbCex+z4tPfxybVJd5XczbEz2IxDOjVvpNu9wpCLdiTwY30zjZ/r/qL1ltqKbFtyvXSd6eB9Cvt/cNYZ6lniplu5v2IYQ2Vjtm8ksNFFY2EHCW271+3gwcPlCCgH3Lj4mEVIhtxOML78cD4ddchSkgi9rn7+cFQYXxQuN3vZbloAARZMOjH2jNNc82fn4VX/it2iiR8pZmbqxxV7vSv7mb3cIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5ZxlDAmWDjjqFnop0njH6zZ91cLq20qaIj9E6Ppz8U=;
 b=cTz36mBmgnKywuQquOT/FRWytvy6o61UMZyp2VDfWCMl7uT2m6BqY4x0VNt49IFc8cvofAb7slbxUqEnlT1/68kRp/vtNzrfyleGAAg/Fi7FLDoxTN/H7u77MAwRseVCvgtyG4p1NL3PLLeq4/+NIfDWZp1l2gwLE7KIUPcy+/oNg13WoKBg54baRW/3llEnS+Lq46pNVwKOv8darBZj/S3B0voVikW3PQqI2K67IpEJ+phmQz8VJuwcy3XW9Zw7Ow9B9rttzpYqy47BuG1r4zjv6KV/Fm1Mdo4f7aXs5TORs02a91coR92BXsZkA0i8FvHZw52ThMUw+Tf/43zmnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5ZxlDAmWDjjqFnop0njH6zZ91cLq20qaIj9E6Ppz8U=;
 b=ep9I7LN0tRMIz21Ra0hhZYY9lH51apzVaDRmqcmF/PUIMipTRAtvwkBVndQL55h3tm/BEynM3GqC0V2s0rvilaUU5vi598gKvI9myH7VMOjjAlDfqR7J1VpkzXvf6GYDypUfbWAR2I0MdB9bfcXfEsXXjAJfAXZhDPalZ4LxF48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 BY1PR01MB9089.prod.exchangelabs.com (2603:10b6:a03:5b5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.11; Fri, 8 Nov 2024 19:11:38 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8158.007; Fri, 8 Nov 2024
 19:11:38 +0000
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
Subject: [PATCH V11 0/2] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Fri,  8 Nov 2024 12:11:19 -0700
Message-Id: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
References: <cover.1731027120.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: b737d769-384f-4bfd-a647-08dd00292b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3ezQ83P9iCLwZFKPyoby3e71/s9ERVhccHfUvwnWxV4olxAJ+KKY/kPOkF0?=
 =?us-ascii?Q?mAAeN9+3m9/I5uh2GZxBss1k9VvyQ1wkyTNeM+nRcaTZrNfUFwlrYdEydsqn?=
 =?us-ascii?Q?3j6uKW6B4LmD4MUXhLMm2IYLF6MPgi7PxEZb8ERTeNnUwKJJw5DgZHxYhIVT?=
 =?us-ascii?Q?F3lm5dNs00FEK5pCOKhz0o/QQm+ft/F8UvN4dr4EOCsMKlPemwTYGqgt4vBf?=
 =?us-ascii?Q?QK7hPe3Gsxgaw7vbB0oCVIOamW2ETYd5lecYkzbuMpCtNCKPSE7Ox7e0wH2m?=
 =?us-ascii?Q?evaqzvXZlflc1ljo2i49nfOv3quprCc3XBz/1LPDZQJmkTzKMhXg1ngbgstP?=
 =?us-ascii?Q?1nCOxZd95ozfCf+fegZ/6GaJWnJ+teCEiBpgVe1w414Nb8yUq2l0PGPQQxvD?=
 =?us-ascii?Q?8Qh4xDXvOBWuKLd575H8whZIjY9B47r5IO5vhAZSZPRsmBuSopWOWlUSKdSI?=
 =?us-ascii?Q?jGmZVvNXWlrbTTDdr7Fd+hbHfABw/WTfUBq7xnYrVTIAOoaAq1VV0hFMFeMJ?=
 =?us-ascii?Q?Xt/5UHXhj8WNAz3mstpqnR4A95VmOqoOCgGF8CbSzYwaHDU4LdISl0vUiWnF?=
 =?us-ascii?Q?GlOKIwJOqI1hOfTomwuKiLQz+N4c7ecNWAKXA0keHM6xgulIbpmRciRwcR/a?=
 =?us-ascii?Q?Pj40895S31X5Hea4wpmifopvjnaDaEWdD2RtDeecxpkIORLy7oRnX2C9iuZo?=
 =?us-ascii?Q?hggg67gKoE7Ro05azm3Ow7cDN2nkwfEZouBPUxp8RsIYf5hxFSnpEkoWxuCa?=
 =?us-ascii?Q?PddAYrRCuaLwJSkxrOxCUZBZ4sYsuYI4lMqlkNndEvOUKpHo3oMtPPvVuhP0?=
 =?us-ascii?Q?an1TYB84+v4WvrWjK6O1sB/d1ZMWxIvNXXZDXrOQHmov7gFSbs1Q4RpvE2gD?=
 =?us-ascii?Q?fJaAqafOPHQHvqjzJzKV92egfTOuSg0WsSGAKDUMQvybtLMxqNEURlrO3HGB?=
 =?us-ascii?Q?/7ekjoSygDpqg0hJL8DbxzhpvTkuBDKcwFM2ipLeg8G6Sg+N1BF/GCF18+oY?=
 =?us-ascii?Q?YEzL7eeEPtxVOlvEf9EIAfGkkvSjBFN15ovQUiSRinNxLAWoqQyzkx3MwUAr?=
 =?us-ascii?Q?y1KvQ0FF1qMIAb0UZLs2fQjVR4aaS3IPeXgM/lqpVxCXdxHbbONEi6SbpWsR?=
 =?us-ascii?Q?rBRbAWMqWp5ITJ8oa49zeMCYrQHPfKE4sYXxBFYLvFMN1pa4LA5WyWrols/X?=
 =?us-ascii?Q?SOxOyqiwrjp0K7PL1mrtjwtvDryMCaySoqRi2p4L9/SJvmY+e1jQ3GHT3fC+?=
 =?us-ascii?Q?Hnr+wKXRK6acZWgbcl9aTgsjWfps9m9RtyJb85eZcIuQc0d+rDnh9Mlhe9hn?=
 =?us-ascii?Q?QPCJoSB2Vk33FTxbZuhJyvdy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9rNAb65HMxiIhqLu1Tycv2btCHZtKvPT16CdG/J27RrBLw/fHZhJsVLBu7x?=
 =?us-ascii?Q?ES92vEEtgf0LFSHlfOXKOJeJoC1L4vXeQESr8m3sKcjTjaqIH7dTn65dT2RE?=
 =?us-ascii?Q?sw0SChCPA6BvImAZRgi+w6+9dSlgjrmvfgrdp7zie1nVCyEBLPvfAU+u/ohW?=
 =?us-ascii?Q?LPvyBXh7wBujPfu+4KoW/FK1AW+a6YxckCO/XNl/w2Ill4tuT5MiKt7toqDP?=
 =?us-ascii?Q?b2SEhwz75aJdnsmp/K4LaTQ+MhFgwdiFfmewMVhy9cAs4C1KIvO2NxbBXOKA?=
 =?us-ascii?Q?2IdYT+h85aaVz0i3ihlRX3MLqpP8XzlWRxfj+RaBJfNBAcnjpgUBVFlo23bl?=
 =?us-ascii?Q?4XG3nwdP7CKMRpVEFoktDGB2d54IDzhQGGlCRwUdHUTrdo6U10CbzFQ9uKJp?=
 =?us-ascii?Q?NSNLC5n5wZZ5BuQtVDm8v4wGXk7vZTL6DMUldAnYnMgPwCej3VExHUnrl646?=
 =?us-ascii?Q?l/djkUDQhbotwE93AgSShAi95F3PuB4OD+2LlIqZX6+8QLEWKZwcIB8nnbEh?=
 =?us-ascii?Q?gHv1o8cyFxQYBzcvBjXb1Ea4Wt8Fhjx3Qbo9O8ZVTyJqlprAaERwoZk6AyRF?=
 =?us-ascii?Q?mvmNxTCydP1RPVRV2TTzhXHpK2vbLeMcYVDQAm9Qy3RpkLmph7u1Ea7lp+Jl?=
 =?us-ascii?Q?w+B5KEuqM0ieqCbSfg13Z3u9A1L0LxV3pRf2BAnU6asOev7a6zVvcngFONGX?=
 =?us-ascii?Q?Wz5X7kFMTd3ffmjUXPQ94hLVZfwtxAcvUsj5XMoCeztzQER9S0QH2JBkvDtE?=
 =?us-ascii?Q?K9L0ujEfass3epCgqWA76VApA5pDoXsT+hM+I5h1tIrwYc2KMG9YlExiTQ2V?=
 =?us-ascii?Q?4Z1fNKvqWpsBAlOa2wmK6TikETspUQ8x4fhKWu3vWzPL2ZV/1kvxpV48jgG+?=
 =?us-ascii?Q?WUthG94pZRWroIVRD5NdO0j7SV6tkJlNHJ5mQSuL4GGcRAG3lxHYaKzQZF0D?=
 =?us-ascii?Q?EU4nIuN4kj6JV8qlrsy/ck/EVMXPqWaSRT9oCp5nqLgsf2+N8URmwO+3zZ6G?=
 =?us-ascii?Q?8tGxXBZmrKW5s+whN2SwC6Zd4Ni7mn/qQ3ssb2ioxJ5ifhCyQQBX/Glgq8cK?=
 =?us-ascii?Q?EpOnBWlekg3z+FceObNAFk4uNhnpJ3/N37+M4wiQVl/3MLVaUhit6i1SApAg?=
 =?us-ascii?Q?eesEWRrjvu+P2UHrHSbKz9CJihtJXS5ah3ZCP6uNm8m0Ce9N3axKD7p4axFk?=
 =?us-ascii?Q?oJBmdlwi7I9jY0sb/3DK3Na66+sX0cAqmztRWbg+4DyRbBJ8VpWTtgvCjk1P?=
 =?us-ascii?Q?8YPERpZYaFsTlh1MekbgKmhKt0MhqoSZ6NXwrOlDKcQxkr5hgO2tygOAPX4+?=
 =?us-ascii?Q?zMMeUUoM7q4orKLJsF6lv/cr9e/e3MqoddHJnQBJdkiMqR7i8z03kBR+VQcM?=
 =?us-ascii?Q?biW3Usn6tI+kzcGro8ipT9fahRYw5vy470Dd/iH5OxKncEE/SNuOJ8iz2jWi?=
 =?us-ascii?Q?fnOQRlRK1ndMfRp4O1C28gIUmOnExJhkIeRyfOpbnYx5hpZlhB0HWP30vLvs?=
 =?us-ascii?Q?VPy+3nYng2rPX3D8xpVF+fMbDDwSn5ptJRjl2uo+beCzgJu0CXsq8lpfJI9L?=
 =?us-ascii?Q?N9mOz8RtZKNhDkCM0GeUiga933DMf57axs5AMBQGP7MAC75u5vB1Z9YiViRZ?=
 =?us-ascii?Q?npXqsYhyXeJGtR3iQLyvKRus5IXCcYJs2++g/WeRGnPD?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b737d769-384f-4bfd-a647-08dd00292b5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:11:37.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4iRTxCT2xM5KKk4o97KMHP/Sxfj4a6yDYS8+s0rAzH9rpsvOrzJv4UAsfqYdwC2xpJVXISrxCgWV+YiF68tUViwA8WR7at6/1o2gcsua6eG53E4AMf086VovQc7GSbR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB9089

Changes in V11:
  - Corrected prefix.
  - Fixed compile-time error for perf debug build by substituting in
    the map__pgoff macro (trace_event_python.c).

Changes in V10:
  - Removed errant space in patch file 0002. Passed 'git apply --check'
    at perf-tools-next, 6.11.0-rc6.
  - Added back missing prefixes.

Changes in V9:
  - Removed V8 patch files 1/4 and 2/4.
  - Modified set_sym_in_dict (trace-event-python.c) to add map_pgoff
    in dictionary as-is without regard to MAPPING_IDENTITY. This patch
    file is now patch 2/2.

Changes in V8:
  - in arm-cs-trace-disasm.py, ensure map_pgoff is not converted to
    string.
  - Remove map_pgoff integer conversion in dso not found print
    message.

Changes in V7:
  - In arm-cs-trace-disasm.py, fix print message core dump resulting
    from mixed type arithmetic.
  - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
    CS_ETM_TRACE_ON message is changed to print only in verbose mode.
  - Removed verbose mode only notification for start_addr/stop_addr
    outside of dso address range.

Changes in V6:
  - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
    map_pgoff to start/end address for dso not found message.
  - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
    by Leo Yan in V4 and V5.

Changes in V5:
  - In symbol-elf.c, branch to exit_close label if open file.
  - In trace_event_python.c, correct indentation. set_sym_in_dict
    call parameter "map_pgoff" renamed as "addr_map_pgoff" to
    match local naming.

Changes in V4:
  - In trace-event-python.c, fixed perf-tools-next merge problem.

Changes in V3:
  - Rebased to linux-perf-tools branch.
  - Squash symbol-elf.c and symbol.h into same commit.
  - In map.c, merge dso__is_pie() call into existing if statement.
  - In arm-cs-trace-disasm.py, remove debug artifacts.

Changes in V2:
  - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
    checks per Leo Yan review.

Steve Clevenger (2):
  perf script cs_etm: Add map_pgoff to python dictionary
  perf script python: Adjust objdump start/end per map pgoff parameter

 tools/perf/scripts/python/arm-cs-trace-disasm.py | 16 +++++++++++-----
 .../util/scripting-engines/trace-event-python.c  |  9 ++++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.44.0

