Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021130.outbound.protection.outlook.com [52.101.62.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD817D2
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495144; cv=fail; b=dzN6NSwcHHdVaIoF2CwSVQ+hyAvd7NNOVemxrL866+OBV0JUnRHf0DOwgEaCpFSB1/Ccjp92JulXo66goLk/uDsa5WlEYC3z8gK9fBswRADOoXmOapOMO/pH+vWCp5+LDES1ZngUQZqXzM/zgZi3rQODR6qi5wNRyLpcL1xKazw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495144; c=relaxed/simple;
	bh=pKTvzrtlWh3KERBT2PpwrabrGQgIq6pIaPsPBa0fcwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r77sdG8QHf8QCyZ5ejUr+/X9tbWz2mFWPNv8IJLEVAhF2wBKp2UPQJI4xXBJ5szlzuWbFmDPRvagz2sFAQVsvntycm5irFyX0bpi9dOTi9PSE4HQcnF2Hynfm0ZsKGvEySDioZokMHmE6Mm5i7hKVcRGpfcXNH3UVGuRh3LZxPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eNWWAFp2; arc=fail smtp.client-ip=52.101.62.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eNWWAFp2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHKmMstH547ba8qMupac/IWIdKmRLawROfPC717l3Tg/c7HA+TTPdnyjvZ3UUCb6lwpuqG/3nSK9jODRwELM2IgNR9xTKD1t+yoH9pbwPO2mQk0b13yYywQW4VaJV1tVLtllyIehp2quFba28FilFiCEzbTZ1RhXRUkIGfxKV0E5BBkJBL8z4VkYOULkNejH53metslydyp2vVqJPNhEqUdza7ybtGdpBxE1XAQKk7wAJd4kvd2diD8mrCYOpOkmgZ69uY2DERJCIOzSaodV1p0VetAYrE6v1/4oC3te5y0KqIJ5GYD9FqsW9sLt89r2Gc5V4XaLZPkrKP+vZy1DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E92Z8axw+PF/hw8s7yBM5yMtbfWmL0E3tdVe3o1qOO0=;
 b=SFMe9Mz8awjV5JT+jjfMgwXCYNO1petYXf+vb0LUkDNTbM0W+XHSZb2mSX7wRdifIITtwYPSNjDxRBwASClj/JNvp4sHKSssg8Ei5aiN3YKaBUVTVgI0ikkWB2msnYsEdR3JUow8IiyjRyQFlAWXcEER8xVI5GuOf6EjXTzh8cVAI8V/jf5sft8gJ/lBI+bwfbenU4iG/2ogQ0QoeGhZZaSAqFlk/6yWAR/aGIO5DCrcS+YLYdE3IpTE8e4LobCLTX1l2B9rp1yv8X4dZHRKRnmNij2v6eNSEK1BLX/YeOLb0ArKz/pjsK8C2YSdqjk0ms3qCM89mwDNHorrASKUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E92Z8axw+PF/hw8s7yBM5yMtbfWmL0E3tdVe3o1qOO0=;
 b=eNWWAFp2/HFsWFXr4dnrn72dbipdyM8+gh2wppauChvIHHByeW5XfuTpjFcfDJNu4gKTOmJOb3+65xW5wpLRWXHX7Bl0hpuzly1bnHbe9O/6PwImfg6Uyv7kq8wyA36M9MxhUj2Yjfo55/TMILXmsS9KCubOzBLfaZ2JZEPXcvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 MW6PR01MB8365.prod.exchangelabs.com (2603:10b6:303:248::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Thu, 5 Sep 2024 00:12:16 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 00:12:16 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 0/4] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Wed,  4 Sep 2024 18:11:33 -0600
Message-Id: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
References: <cover.1725493961.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:610:5b::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|MW6PR01MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 9199cfb7-ee34-42e1-74a7-08dccd3f6662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1gPYh316hNitbw9rZPTDVwaC7cvbNjROFwSehlRNhW1kFHS5uGxv5UfIMfA?=
 =?us-ascii?Q?AVbPCh/8Zqu61OhjqL9awA3bEFyvxGuhKvgYskvxJxfuDpX5qx1ZvZ3BWrzQ?=
 =?us-ascii?Q?zWF4nhLrxI3OQq2XHKtGQsOXmiH6D1k5+1liVrQkXF4XuBHZAkmZY3SMmOhm?=
 =?us-ascii?Q?EoafWPGPVvemIyF0dgaMrNbhdFrxXSBVZH01MPXCdgZCPJDxK5c/3OdDT2vy?=
 =?us-ascii?Q?n9yJ+leZ6iqX90+HrtYRKH9rU9uqvz2ZbfW0dkIemD0phgRvQHb4pL/bRMHJ?=
 =?us-ascii?Q?RWNX9TFBopEHF3b/6i8UvY8Dt9AaFu9EDMCGCCYJMQVSra2Eh5YjecxF6P/+?=
 =?us-ascii?Q?VoCLfyuPYh26w85klvd9tk3E4vww32BsRkpYz4aI3cO3kVqy/ksVtE5iPiYK?=
 =?us-ascii?Q?8L7k+6+T1DKbJZ1U3bASytqy4zL7jWFyD8H+fvqAj0U/yW6GIWeKMMJ26Nco?=
 =?us-ascii?Q?0lsmJT2D1jfSW1mvwTXoZrKJhdPfqAKGxzshOMJyXjYzp82rQcizjuof+EJh?=
 =?us-ascii?Q?TxwRrGJGfeFFYptQzpmqMkZ8lNZhYkxiv5vPDZIeyPq39f1yE7QxLy+CvdrC?=
 =?us-ascii?Q?BZG7u3nVBpvfTjtAOvIABrCu3GRmq0LVCZb/2MlgFZ6Ksbhqybbm/vYJ1UbJ?=
 =?us-ascii?Q?4akRn8UQgnSvvPM9OXkHnV9TU6wD6jk5wuYO5Ru0uuqx6WSjFpW8QtY46CGQ?=
 =?us-ascii?Q?ya/TkFIyS35Ole/FTtendc2WCG9zyIBt4Tn4DDt01jbNYxWpry4DoGkP5vQE?=
 =?us-ascii?Q?59QpOJzgBa5d8NXjsJuJ+KjyIR/DTzZk1QQosvccK/rioGFY0mKFayil8Uyi?=
 =?us-ascii?Q?aRe7Gkq2CL+c9B68LyLJ8e2K4uHK7hwf0ikY2RZYddsEH5ykdzoR4fA3UCV1?=
 =?us-ascii?Q?VfNRw/YKqw8wrdmpS5xWv5+zzYjQDTAtt01QPE5FC2z7rpEmD03puokhIt+8?=
 =?us-ascii?Q?z5DoGNiJU6g6G9c7FLNEpoKda05JyFMj7UmtGOYqu7uT5Fr8hkIiN7yI3DI5?=
 =?us-ascii?Q?/TkNCG3axY43J5DEBc7HGxhWIR/8k701UENRBMSG8UTrCJ4nxqp5jmzZdOMG?=
 =?us-ascii?Q?dLvbeWi0rqi30iqZLfm3DhTcj3WgB6IvAA26ObNuR8RJVbhWWnhcWr/+ob6F?=
 =?us-ascii?Q?90nG9WEOhY/O6J2WwYLVDo4Nl7iy8RKHmVb4ltQeVW/Z/ywCuCBwUsDo9e0X?=
 =?us-ascii?Q?0VUCcyaR8R3nnhbdPS5aIuu8xJ4pcCfJSWBzbCmG+B3KTpDoF2R3eSRqNFKu?=
 =?us-ascii?Q?iaHOPg98V/T/XGS4ZMNmYCxIg/3J6F65n+8iMChntKHUPbEZEcRy5KRJeqHi?=
 =?us-ascii?Q?CyGxsesU93n3yVykJEMfidQH3XzwJ7HtnqMpFwgOyAeOkvq0pXtvaSfDhwzp?=
 =?us-ascii?Q?oiYsCqM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1PhycOyRyE2WVUoOb75bEkDN3uCT8B8TVjnb3Yw3tWDaafbGwKcIo6BgL0Bi?=
 =?us-ascii?Q?IugiRb6PC/7BL8rVL2A8l6XY5qPk+V3IIeoQrgvL5ZO7d03qx1MvfvUX7t2y?=
 =?us-ascii?Q?a0H7LWDw5cO+7O0busnY08PE2Q02XZKnFRwGkH1rW8ZSYpyJ4wBRAk0X6tNE?=
 =?us-ascii?Q?usW9Ubi06qI4ADvzvJ5Fgn2HYprrhFPzd09l99AZPe5z61KE05IOHWmqDcja?=
 =?us-ascii?Q?/pRr+bo4FIMnyYgrf1KpqW4f/wIMlZ0M9bDsNi27CjpH3BH0b8x5a5BecMwD?=
 =?us-ascii?Q?ilbagkE2LEnHrPMarX/JAec9heXQ1avx9weWg8utks/U0fenQ1eLXObreMnp?=
 =?us-ascii?Q?GoIAJCiW4Pj4pCD0jATEiuQv0JZID+QgTxJrSz6y/dwLJPrJp97RDfmsJD5O?=
 =?us-ascii?Q?RfTWhD1K8Vx3cWkE+n7dFmu+ADXW10pGJFPLKa6ZzmG0GSCHEp9AjFZK+dAx?=
 =?us-ascii?Q?m95F2+/NOeRiUjstxS45tJ8jsHnGnm/ifLdYCudhfRMEZwNK4LWvegXiE1R7?=
 =?us-ascii?Q?vX62hVaPyB3X22B+8hvgKON5C2Ox4kc6/Sk1tzKH5kZwJzpXoz2zdSa3smN0?=
 =?us-ascii?Q?tSVXlER/YkVxpY5kgXQTrPjWFNTM83vHsjtMDk9hA9B6pyqq4UEiqnmtXbz+?=
 =?us-ascii?Q?//x4/pqAf7iR4/INsrPEOE/KhobJm2FFJbhodSrXwVF7MNdIT4eeoCQJEIqW?=
 =?us-ascii?Q?ORJg4dhuXUaj+LLbFHFYCxubv7ljvYRtCBLthZpLtB5RmqNOB+NL4lTr0Eh/?=
 =?us-ascii?Q?7+97S+4vCqZ1F0gYzjsI+J03LDTxyvBmUG8WEBUDFlHBpCFKHdcNLUaNjw5u?=
 =?us-ascii?Q?YqRoRmaLJ0LQkyElTBYYZilLpWONTmAoUbDKdk0bLz/PxK2SxWLQgDD81jAU?=
 =?us-ascii?Q?iG1AB1sIt62Tf06QFgSiKQ5WgVyg4gsmQL8x3WFA9zlH1F/8+9vekxfq4eTi?=
 =?us-ascii?Q?UdKfhOH3bdPMKO1DlYTJJpNFvVY3M63b/4VzuJn80XvPPL5K+I6baA7Kq4d7?=
 =?us-ascii?Q?DC4a0hWqTbXx8j972LZJ6r/0NrbYRYQr9X9v04fNEgUvS++mkcce86oZPr3v?=
 =?us-ascii?Q?HyHny0y5OCYgrdXHW0Vg8OCrncY3CatDn80cI0VY2AE/g3uWdqS7obK8FNEJ?=
 =?us-ascii?Q?xVU5id7CIRZ2f/AUQofckhmA17/fjDbfTkpoCc9dVn1p4TTWv3SLnAOjsLGa?=
 =?us-ascii?Q?CS6yy4+eXuvH1IfVNGEfCtvn4AlNXiqTxRV8jC+pdhGGDQqwDZPz3kOAXeED?=
 =?us-ascii?Q?wX4cSgoh0ROxvF0GyVzA738J/BNxo8XPEQE37F0Oe9l9+8d06sv8xDO81kkS?=
 =?us-ascii?Q?ZUxkkdikI2Ho4/G/EOtXdPYa3T8i9xf4YuXUSVFW8dQTwJKMyLFXk/zKo3xZ?=
 =?us-ascii?Q?dbt4rDjZpv5Lxh3brm0/zQ3fbiGgdW1/xxWCXBnR55ouVTAkB3WzqG9REGLI?=
 =?us-ascii?Q?bPbgth7XdxTWY10T1kaghyQxx9kLDCOvM8rmxxmbcSr7AyXreeoGFmfPjObz?=
 =?us-ascii?Q?277BrN/ptE9su6V0VSLk8o3PTDC1Cr9Q7WqvS5cudHpzbhPevUgRaJ4vj7eI?=
 =?us-ascii?Q?IKBEv65qkzJ8j0Ez7uwbm8vlW3DDzGUfPwPuNH+Vwsv0otVdoLvsR+SoTuWm?=
 =?us-ascii?Q?5vRIcR6KP6h3v+xgEj8FUNRwNXTL3pgKvhIUWWwynfs6?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9199cfb7-ee34-42e1-74a7-08dccd3f6662
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 00:12:16.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65mQ6kLIy4ybdzckR/6QNWDR0gWCJLEVN0qNAWurOvr74DkZf88J/InJ4ckd6wlZ9dJ1lXCsGcP1j/kCYW7SAaJ+qqR00rg74fn+wqCJK0zcK/dV8k0GB5wHZVHoG+oY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8365

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
  - Updated mailing list distribution.

Steve Clevenger (4):
  Add dso__is_pie call to identify ELF PIE
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     | 12 ++--
 tools/perf/util/map.c                         |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 82 insertions(+), 9 deletions(-)

-- 
2.44.0

