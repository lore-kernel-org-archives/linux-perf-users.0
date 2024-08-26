Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020089.outbound.protection.outlook.com [40.93.198.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4019B5AA
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Aug 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708190; cv=fail; b=rgTHUyWDrXFrm1Eomot3Phbhh6IJzB3EAL4Zv2WrtgNUHL37cb0mm4EX56THuHNBZTVuBPndP/oSwQX7SxijSEof9UzNGaqBLnUhNRezgiOMTZ9BC39Z90db0Ghz2sbCaAoO2H0Gat061Bn/K5o/26iZZr1T7sBoZgHbw5DokLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708190; c=relaxed/simple;
	bh=pzcQQW6ETt6ObYofAH2vcN7Yo/n5fJ0HgOGeRB26oJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBQ10y9Ft+v1Um0gY0iVeMLqevpoQL8pnDBXpqduE9pNF9WKVkDS0Nov7513Kg4Oma7MhZI4fSjvIcIfd6K2IPCtyo1Wauu5GuvEtWEVASSiopkxQcpvRuxW2MOPt1PVo9zHsd8zMVCfL6A1dS+kd5AdvjP+/Q5iOngQLDvpDxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mPGuSbq+; arc=fail smtp.client-ip=40.93.198.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mPGuSbq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZARjnmlo8HyEowPZhQbADL26iJccZmtF3ivEozqx6+RXoyHzAKinsdEBOPVWiXazW/IE/Qq3QxqFjRTWaIxZILfcR42XCXlzzKz4zj6YF8iXAv8uDA1OZKKXUwHEYlfVzIJw0bTFnINmvp/uFn55vuQCqW1GgDntl6sFAi0ycjUTzw9BP5rYo+AAovW7YEUxfvExKuP+yr7PGtK93Fo+cvxPPJ+B84TbPOspm46tHXHVJxl0MApmz/vrvg9f3NSZQAK6QGQIkVmb6OvhHDQIdrWageCOqPOGd8aIvFuItSmGqVPw+J/5WHdn+CTJX3yAz8z86NFmC4qz7GrnHbbKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF4CYNTIu0NqhJYudqQhlCpPTWvHVbPzYHOfnd9s5jE=;
 b=hz7icNZBeSrQiWOfZWtXFVzyQEwDmaXu78BvuKoeOwCgjvzA3znFbxZUlevoHk9du1BHYXOCqUSYK9s44+43GigEYiuO0ohxjAvhrVd35OwD19d4MdFB9KPjSgN5t2v05ZWGlv4U1G27cyPCI9LknAqMWkuGnGIjNvwWdg8+lZK0RmCQ1ZWdtbJGeU3DwoiTkAML+xH+7rvklpNa4kcaurhNoYTEFs5iNlM3/l503A6YiH1pnYrup8DoSGRHloSZVbybD/+r3Ts655sEV/NhvxHi79lyQQOSVQDU4KY/eqtw/DbFq6pRi+W/gfd5OcVjprycrKxmuaYPvQ5nGwrlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF4CYNTIu0NqhJYudqQhlCpPTWvHVbPzYHOfnd9s5jE=;
 b=mPGuSbq+Ex6X4iyfy/pSnKFWXealKEVgX3RuNoLxOA7nyn3TlVuiT1JK9dvqgq0xOQvbMkzoI4pzo2OtaIoTOqv7GvSZCqJebrAmhiziLBk7PZv7YvqxkVIyiuREhcuhWPLmv8tI9RA6EgcL6Yt0upu3fpl3VMAW67Kn+qsPuXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8150.prod.exchangelabs.com (2603:10b6:a03:4ff::5) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 21:36:27 +0000
Received: from SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea]) by SJ2PR01MB8150.prod.exchangelabs.com
 ([fe80::72ca:29db:7676:9fea%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:36:27 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V2 0/5] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Mon, 26 Aug 2024 15:35:57 -0600
Message-Id: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724707494.git.scclevenger@os.amperecomputing.com>
References: <cover.1724707494.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To SJ2PR01MB8150.prod.exchangelabs.com
 (2603:10b6:a03:4ff::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8150:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a44154-0443-4ced-9ae3-08dcc6172405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0cphHd8G+nOOT/f37r2Wtei7833mXbHKciBB5W38EcVkXUUENPwTV+uTVDK?=
 =?us-ascii?Q?1D4vr3XoH/+YDUlaZMXHECWgJT7AFdmiHLPLQcO35YdFChQMkMk31M0dV0jL?=
 =?us-ascii?Q?mc2dI7CXIpycUhEAtjOo7z2qd/mImHgNOakqcPc483jghlCiN9spL0uzLNh0?=
 =?us-ascii?Q?D6AHTQAm5YRTHp7v3ngxGXz4Iet3yRXSNgzSetbEHf/YIvUJPItCybEwyzoz?=
 =?us-ascii?Q?CizW7Ss1wE0KjJ2UZkJwAi7GwO0bnfMiqrkgN31PyuwNDaVk9fkBQq33fael?=
 =?us-ascii?Q?4osDI0Gtd83OyviKm1peQSF8qQK+Xf6ZmnVCp97eNb8US4IEFv0keJDgvSLF?=
 =?us-ascii?Q?Ngwx7HyKN6yzBWyykGS+PC3EOgPGJtlie7nLiEIzf7ePbg1x/L5BzBIE0q4c?=
 =?us-ascii?Q?BrNN6c5jjLe1yN77KOdk+wksNWHN9vkSgNkkgOQpSrYvNqyoravYSbYoKrx4?=
 =?us-ascii?Q?Eyq2Va+0ks1R9kQ3mfmvE8/3RXB/UZTCrOCBzL3kQjPknbcdNCZH/sOI3Eqm?=
 =?us-ascii?Q?pualAeDlRIoZ6SFNiesfFft1d2PGIsMrsKwP8n/N6QylY0HSNTqZ2NE0WSw1?=
 =?us-ascii?Q?OthiRAAWSb8ABbrwrAyQJUIiSWsL+Omisnmu5vGRMtqT8alKAtlpFJedb05K?=
 =?us-ascii?Q?WYbemani4IT+V0NRPEu+t/ZrNXKlucDNpIVItpDoha2EtpjNc9zFZGq5oJ8W?=
 =?us-ascii?Q?pWoWQBcyUn7lfn2beDRfKLX/9HyFqwIvBiDs8ctQH3dNYMULnhQ+Qsz/YLBD?=
 =?us-ascii?Q?NsYT9zHsMUZ4e7pnokUZD/nH17W8dAi7RycqZMo4/6AerKkW4cGgRM4O/KdG?=
 =?us-ascii?Q?eNbnSHj5ab2d+m85eJry9d08WOmvQEbat0E1eUXqIIr2UMoja0R5G7j2QAyd?=
 =?us-ascii?Q?MeR54hUtRFD6rmwA4noTJa+mguQHfEm3so3a65YidoCLPqijSk1fRWEByey6?=
 =?us-ascii?Q?iK4q8XgaLTEzyyq72WQhKvOHOOamZjHwSZ0gwBNX0AbUp2bwAT+do2GKTKXj?=
 =?us-ascii?Q?VLrIqy9q09wxd0xVaJM6ROxft/+YIgHbzZ9akfs8hTFQeIwshXPDft8MVkGY?=
 =?us-ascii?Q?sP6Uy7wOdI/ACqzJpkgILN+018Jzm3xDQTKi9x7jGyaWy3/xf3xRFlCSf3/f?=
 =?us-ascii?Q?qukRrreSvk2iUJw20e4XQT0AjKT+zKZ+k1dhq/jwEXFSprr1bbc9MkCiQtUf?=
 =?us-ascii?Q?o5uUvdDl0CL7OJV+VDxVaV70jfuXKTh4B0gTC2br9eorNGcGGYI4OHXGFANa?=
 =?us-ascii?Q?xoYnqUXc2I0nb3wtdUAbHwjEb8G+vne1xNtPRpymmF+y8UBHAhCDjr6FgzQF?=
 =?us-ascii?Q?pjJ/IQtiZRMRUAZlDLYX+a4FSCPXnrggSoDvKtlrJpALzb4ZFj0OK7Af+giC?=
 =?us-ascii?Q?0dGYx8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8150.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIqLiHbVFvPdJxRP6vgdLGnTeh8VoR9atwI1dOFXKxJC5SEO5H8c27s6QGLE?=
 =?us-ascii?Q?wPmpJ3gFgRXWw/Hk9YqgwA4NT3gFjs2NcmmctOCY1pg1rSlpTg+D/ZjWMd29?=
 =?us-ascii?Q?MECaQCH44IJTaPikmtBj9WMEHaQ9Ehtr2ub6FlmJ3IC+D/LZhJ2Hgxf1Ly56?=
 =?us-ascii?Q?YiqGvUr7epky6I2Hg6SRLEJZX7bfVs3EaM39xfp75t8ap78z/Tr4AJ82H3EJ?=
 =?us-ascii?Q?S2VjODVPPvlAv1gSY804o3CSq27k9y8bwt5l0dLLTIk9H8J2CqnszsGPvyTD?=
 =?us-ascii?Q?mypu3aapTo/Ggs5PIbMp2vgP+3vJ4iRz4JZvZlrxunwkxb2E/aJLmk368etI?=
 =?us-ascii?Q?nXTHmOHuzOAb2DqB7TXOvFvuhJhrBwlO1kb2F/bovbu/XmOZ1M1mQ9HSDBKF?=
 =?us-ascii?Q?srTMcx/2X5MmyqTBcV5TsM1MvM2JoUnvbvi0s4U/IBHxkFRWPgnmrXAKQGLC?=
 =?us-ascii?Q?HOCEoMHa0MYBxl9HTY7soX7KeZuoOqfEL0XMA2T2ZMhDIHeQopRZY6hkjFrx?=
 =?us-ascii?Q?Wed/yosRIxEyTkK+7BLf0XRML1fl7j1hMuyKvVmo2T31rqYeV0zPCHshqI+3?=
 =?us-ascii?Q?GheQ9G6j/TEgDG+Q+EA/7Q61VHXTogr8xiZtnGhnUpt/+V4OORVZaqMwK3Yv?=
 =?us-ascii?Q?qd5f7MZpFq0N6ghgpA7Szu+ZEyM0nd8rtUicFRQTrWb3FiTzLgCczNhm78oa?=
 =?us-ascii?Q?of+AVT0mgtFqzYoMcXgwlX0dAsJotw2BCDtxnfaXPJqy4HT/r3fjjSr8JYxz?=
 =?us-ascii?Q?8DDjA+hcT9CDsbtdSwdWLTegnRhp4p3UZK4issIHHROStlnFJptecP2IlnGl?=
 =?us-ascii?Q?R20agVY1nBcJ7Mhzv49xk3UdCOmIC11MujQRYT08MJacPYaGdT+O9gxcAc14?=
 =?us-ascii?Q?brZepXk6XqG2gB6TaOdN+HRmg/2IlzKPPBl9/J5pyh63xxX17m6JGQMMP7gF?=
 =?us-ascii?Q?QVt+rSTeDXsUWyjrYwUWawjnEwjd0YZKcOkXMRHeQ60PaNBIzKo/bN0R6HGz?=
 =?us-ascii?Q?qMjzCwZBmleXEnvDIBycTx2xqszWWucIbSU95LVoQK22irJb69qMY+428yPz?=
 =?us-ascii?Q?maa7GbfRuojmy1yo9zVosVKcfG0KZIamUakq1OX8iHaYDMrfFn14cfTmZNQV?=
 =?us-ascii?Q?OqhZdYKpborUdOwLMqc/F/OkDBt/b3EyVP7nFIm3npMC9KIjcKVdqbXIkYyO?=
 =?us-ascii?Q?k2zLI1rqmVa7RMOsRc++VO9YTSOranolgq4L80Z3blfghSLBfNoLbWS0RrK+?=
 =?us-ascii?Q?RqVHtSOCG9VrznjK9iS9nt5/bDLM4/kSq8K4kRlxopy76PenuAYc6KLHFNzX?=
 =?us-ascii?Q?ng7uwk2jHMyamWHaBf1xI/3Fae5FUUW38V6jicz0RiUUSxbLbERqI2LG5+++?=
 =?us-ascii?Q?RRnY4J8IoAO8SqbkfKZXh54MIG6OP1XnB1L1o9zxOtVRZ4RFPl7yxZbc8fXi?=
 =?us-ascii?Q?1YlXquXS0ReiX4AidJzDSYZ7acjLrX10iskJ4zcSrv5pYhGNY0T4x2avm4C7?=
 =?us-ascii?Q?SlQv54V3M+K10i5UvQeOM0nhyZ3+43vS7WiCmuvdEB6jCmIDeX+zhfli5p8X?=
 =?us-ascii?Q?cXEcCRtNWFz0pSw/+qcXd2WPZyLBK+YXTzPa7wUm1yNZ6k2J8pfSqcwnHyd8?=
 =?us-ascii?Q?ebAHuIcgRKqiGArKLmObB2d3ddRu7T07tOxqIV+XNfBb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a44154-0443-4ced-9ae3-08dcc6172405
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8150.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:36:27.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6iQe9PGrqrj8MlGBglrdgsyExaLAJgQg4xzR2cDOlSMzyCJwfSmWugVV3kk3LOHr4Ke+UI9kJPXbBmfzbKAr6ERefmHOBXw26suL5w9UkHKM8Kht8bwqWKc9nNRHe5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Changes in V2:
  - Updated mailing list distribution

Fedora 37 distributed shared binary and executable mapped files show a
zero text section offset. Starting with the Fedora 38 distribution, the
shared binary and executable mapped files show a non-zero text section
offset for some binaries. The text offset parameter is never passed into
the arm-cs-trace-disasm.py script to allow the script to adjust the
start/end address range passed to objdump. This adjustment is required
to correctly offset into the dso text section. Not doing so results in
an incorrect user instruction trace display for Fedora 38 (and later)
user trace output.

Steve Clevenger (5):
  Add dso__is_pie call to identify ELF PIE
  Add dso__is_pie prototype
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     | 17 +++++-
 tools/perf/util/map.c                         |  5 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 60 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 90 insertions(+), 6 deletions(-)

-- 
2.25.1

