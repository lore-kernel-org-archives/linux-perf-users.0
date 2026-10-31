Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793427156;
	b=nJ1mBwBCiTkFXqpiXqIgD2ygT6ngROtZYyKliNufnLNngUBGzsAhG058vTQhRjvwXvg8
	 /OS+6N8iHMB2bEBwluNT/7LyS3QrARC8VFRwVHwkKsRb6JFqapBVxMCsu0LckRKVgPdUz
	 VF7y+3JL3aAElHO+jeWHhmaE2JyKzfbiFfK1/8/7cHV6/HsP87pnzJj2hT7ExhcGMhYHk
	 KPntGDPccod7wbMCkewUcrt0ZRyvh2qIxaC0Ru2cpBm0Md+cTMLUkj8bkI6cKTvmly5jf
	 KeLMnQvfY/G7AnYFBJvALyDXz8aluHj4CeNNXDGO5C2YyxPpxfhs3M/JMVrkMNOJrZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793427156;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mL4ecXEZH1HxbRLPLp3QMtZaLqWk7iVf67W3atOHfVw=;
	b=cxhpBR0uR278HrAjiuhuOusRtlwaUozIbZT+GrOSHK3E6EBmgrNfqIvvCDoSuQeLd6T1
	 L/Qf7CSTiFxOs00YL0sCHBTm43g/M4wP83qQ+UJiripDFaad3SP9QTcad3C7qOW0fLJtJ
	 4m4D0eS5nv22mMf1Igm7EJRCYH6QTSEMD5LPT/Hrip0WLLIl1fbYHM3fs3WhXXyIYpcCQ
	 ez6yv1oa9+al//XNLHcx1WbZs5Yqgw+HadHF8nNnmPyKqW8EnLotHfpSZ9Hllgcj7Jfow
	 L9JeUM9P43PVGeWxRKK5tLJ2uUaIVPeiGSW6iBpwd46LUHNqtioEZQl8dw/JCMxa7fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=dWbA8L69;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.18
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010018.outbound.protection.outlook.com [52.103.12.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC06606A31A;
	Sat, 31 Oct 2026 06:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=dWbA8L69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kChLtzTe6txrp5v2FmhFIHqaivR0MrxhjfDR3cb3WyzWsaCWq6UY7Orkkr+Hxe7nbGE/xo/E7xtuw6ema8NQwUYKKizupwdVC0c2nnYQ6v3QmXZWB+PBfdKZZ6s/vk+govG2o8ZJOz+jxxq9EhvbxOQvG7xTxCQi2aqjSkJSY1K2Qfo+J/FKx04sjXnT3sovZcz2KqZ9FGxLbKXbXOVu3y1Z5i88I+N16OesPITV1droNJlmdXqZN9bXrX5IrT6lUSgS5GmW1ivYVMBpjcvNbq6eGfqJwMw0rmFKHRoDlKs9euFD8MyaIW6HqxFl2Z6S+6n4m0XGJ7KONK9sr0/RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL4ecXEZH1HxbRLPLp3QMtZaLqWk7iVf67W3atOHfVw=;
 b=vab8p4MvQ0hYg3OcluhaG+eC6THLqLSfPR9xG5BNDzM3oAOAFUhI0msM5gsRq+Ri2/hqUxX73HaBlY09s6V8p5IyRLKLmHbDVLYU99oSPtWuDgKDg9LUC7OaYw6ZXs3askRoOOcqJzqig0QrRhTnd/NYzAMmfag5Yb/4vOucpBMl/4sXj8t4+0//yV0c1Ea22dSyJ0fy2/x0/wnvIwmbLXRPD4nDDIhXAcZBJAcED7t9d6Yupijb/cF1AkGkrX6RQY+37oFz8GQL/vPobEkdVGlMq7uY6aIZWJIpg528U1NsQXL3WO6fmhyMLxYvTotjgSAxcmpmqkY7dvtwc6xK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL4ecXEZH1HxbRLPLp3QMtZaLqWk7iVf67W3atOHfVw=;
 b=dWbA8L69DrfER0hT4yHGUNwz2UxW4FSJ0BR16KmURm9j9C+QurCPP3QQ8a9mDWnTjfJ8JsN6Bj6nWItyM0vJYR/c8aW8iowwq1YlHz1bS3b7lHP3wmNyjmfYtG9nLl+NUBpHkfHveRJs1fpM3BmON9tIz/9di/ol+ZypqjDXSbmjFScGCixu2m/PHABDXCZ2wfAqCW8aTDPG82bPu2kIdDDgkmqigEceTrxE0hKeShgMbrn66yVwGJJmuVdBLAm18qKOEwzcaRIwDsRB4S8lgX6rGFqJ5QiuhkLZLX9gGtdSMj+SRzbTkbwismQACcv1KB2I+AsQBnDhGpe6KHiLUw==
Received: from CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:e8::22)
 by LV8PR84MB3925.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 06:12:33 +0000
Received: from CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8999:d76e:96a2:a9e5]) by CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8999:d76e:96a2:a9e5%5]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 06:12:32 +0000
From: Letian Jiang <letian.jiang@outlook.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: jolsa@kernel.org,
	irogers@google.com,
	eranian@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Letian Jiang <letian.jiang@outlook.com>
Subject: [PATCH v2] perf docs: Correct JIT_CODE_UNWINDING_INFO specification
Date: Sat, 31 Oct 2026 14:12:22 +0800
Message-ID:
 <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
References: <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:930:e8::22)
X-Microsoft-Original-Message-ID:
 <caba47c82e7e56fb15e3fa42ea5907870ab8e704.1793426831.git.letian.jiang@outlook.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR84MB3476:EE_|LV8PR84MB3925:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7d1342-087d-425e-e9fd-08df3715f317
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|260925184616899003|24021099003|51005399006|25010399006|15080799012|5072599009|25031999004|23021999003|1602099012|10035399007|40105399003|3412199025|4302099013|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZsCqW/wopxaKXlEJ0k6EUD1Uxsyz22mfZgbSyEYXAWtqGIodnm69D3Ou33DX?=
 =?us-ascii?Q?F5JaVqJFzZ4iwEacMFD3tcRZoiqEadslnzy0Y2FEOUdLJeNxX5PR19LJY2ro?=
 =?us-ascii?Q?C745F12o4uv1fz6izsqWZmtpPQPOuRNczIBOoA8PTz54Bh2cX7HoCK8KEZg4?=
 =?us-ascii?Q?4jwtQzQO75Pk0C7A9IXODq0XW9fi/WceEXu5a5QxKoiI7WMPh8EDSJB7J3np?=
 =?us-ascii?Q?nY4Vx6ZPy1Ic7FAjQ3OT74/Q5NJF15A7Uikl/nehr48y0+RM2O4XvpJXjPGN?=
 =?us-ascii?Q?1r9HY1cKslehZUxKwzm2aRsMeVGxUc1STurpzhon2jfb7Bp/XgZcjPBuzsUW?=
 =?us-ascii?Q?lkxGMl82MRYUe+fi/VNwSkrtx+n7KjSG5qYRGLKpRMlp5FbwtlHObxMb/WQl?=
 =?us-ascii?Q?ojyrpOo5cEnY4uYg0i52xxp+iscYuAh3tab/F74ZXFTg6BqKUAlbPuOwL28+?=
 =?us-ascii?Q?FC3bm42d7LWdFCWaUpEHUyq5TOv9KdFJe8KT2it8mg+xpztCYmwbOP0jCJLt?=
 =?us-ascii?Q?GY1oCKhZErbFAbcuuEBJyThi8Cze640YC/XE+u74VifvyZ/FQUkpkoj7HJp3?=
 =?us-ascii?Q?jq913OtI9gkhAYp9VWsOaFbW+m1o0wxMYawdQXO6tCYMe8lQw4fSG+I/42XR?=
 =?us-ascii?Q?GXEwnRdo9kpgL9msCfXio/MMlxqRfSo4/nJRiCxrqmOy1lH8aSaydWgYe1OB?=
 =?us-ascii?Q?rf6T2ZXlBNwH5fdqzMIisJt27uFOEsKiAlrnPW525jhHyq6s6TKWy3HPGdpX?=
 =?us-ascii?Q?hX2UboISarJv+sHewCqxMMbJZktJSybxRnU4f0o+4AayaQJF9n3SQPv93q/3?=
 =?us-ascii?Q?GK3JkUcl9Kn1NKn9kBUJ+9i4otS0e/y+oEPRWVqZ/MxIMUWJHKB1P9hq8n1y?=
 =?us-ascii?Q?jSDbbcxmLaJcQTickzfrhjb98eOPOBSyQ2sD+zVmS/x+S7Z6ExcrqtO+cnma?=
 =?us-ascii?Q?ENnGf2eg7AdPLzuLqiDrc2frlGmZsr0YZ1BRuGSCDOUkKVO68OaRq6MiOPdD?=
 =?us-ascii?Q?teQuzE39E/2hsKf5+zFXoIt+i1ee663zs8uCna5d3k2BtgI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0MzGf8PqznVxILGyxAUnHijJhhim3eECGKfxXNTgHt33X2jHtfpnaDMJtazn?=
 =?us-ascii?Q?l6bz3sXNT/aAmvWqTr35ZDBo0//Kjv6WTG8IoA9YBnN7NxBAcC7b4smo4fOC?=
 =?us-ascii?Q?5waHIwjPwcF3O7824tuuoPjVslvVS/sO4Uv1LfyeS/Hvb5wDrjTMJtA1WmGD?=
 =?us-ascii?Q?+BfsBEy+h3JBc9xkQZvz1WWkrhM44BJ79coPgbbGu/M5gXw8g9y1+jzDYIzV?=
 =?us-ascii?Q?OS02GihEl691Zm2izQynwJMJmcFEC/A0ue8/0PLVfx4MLWx32gG/ZvQ1pRLs?=
 =?us-ascii?Q?+gO42HVhMjknb+CXJhv2MtgoCBFimGaiBT4EG/HBZqe7EIm0z0dOug5RX421?=
 =?us-ascii?Q?jOC0vgM5bUg+pVSAYphHwZo1LSZm22PokYOXbGC30w7zgr007/o2XfIpIr5c?=
 =?us-ascii?Q?fsOZFNbUKUDhaev++S+q2f+sZQ0wkSscvnO3pqjOH6EtvQrTPQEwlyEVZKxB?=
 =?us-ascii?Q?PXwrmJpT/jFpf0G6rBANElUN/NthHO6u6ioaz4L0aS/h9pvZded78GFNQj83?=
 =?us-ascii?Q?74Zgco7tfJq+eWJrF5nnXT3rOY5pNAzWM8aU/SUmozCmUSC3rFhMxdblW3uf?=
 =?us-ascii?Q?0LjBUck5Ig5RmbJzEzvqoKZjXHHv6Z6PAbxBYpMqgQvu3Dg+FqyTf4xsxIxT?=
 =?us-ascii?Q?SJzKoEBSv50+7xoGaQc9Ctc9XGz3RJRW+SECaynjSWo2vHIgImeifF97OATU?=
 =?us-ascii?Q?qW/xUwD9a9581tbeOIV0DVAzudEAJ1ul9kZ60rNk86cvU4BkhGEu0V/8mMjS?=
 =?us-ascii?Q?0jd/Mxm1MuLBKSeP5C2I+Au1pW0D2JGPGp5wTG9bfa3Dm1n4cr7msDhROVcp?=
 =?us-ascii?Q?gBubHTRyibj65DIRC+MQWgfmnYPuCZnertw/1HQ+bMy2fKBOP5516K0Zge0g?=
 =?us-ascii?Q?GGPl8lPJk14PjMP8kix4TzPYFPYoj2WEcAe6cK6tMGron/0Sb4iOCjdtlNVQ?=
 =?us-ascii?Q?CHLvReTWLZR5RDPx2aLJmN4Cu1eeI9iM+c2yWszEfTXNkv7QYIF/lLprduJN?=
 =?us-ascii?Q?cvoQ7GTDvM58oLx197QhN8v9K2eM1OCZmyJu6FkHRhuW+Yo9JbSOm/rFL4Wa?=
 =?us-ascii?Q?SZ96c7lJlKlYkQLJtijB0hEoKqQmNWe98zhXG0hUHf+ElgJ+bDX1Q4cxfLLL?=
 =?us-ascii?Q?LQQ/YrKlhXl+B5zliYqrsQCwnyGQbt6nUq3jkU12krgmdrC2soKuRO7D+O4F?=
 =?us-ascii?Q?CWXNfs/6ta9w9bDjbqrGAemXrN8sd1mnQeWfH/yKsAM2Ey3D6yecxf06RUv5?=
 =?us-ascii?Q?D8u8vcOTM0g/1oJ3R1XBcn9s5yyi41IO+AEXjKejbzQBhSSDPCfMkxXryN8O?=
 =?us-ascii?Q?0ESSMBDS5NokyWHjBMIMkJ9bCdse6N4tFnp37wi3xjO30MovIQiy1Y5+yTuV?=
 =?us-ascii?Q?sr3Q9emtbx1mhFWu/BF0RDTJ3Fa0CK/6VYGQ+edFxeng59f1Hw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7d1342-087d-425e-e9fd-08df3715f317
X-MS-Exchange-CrossTenant-AuthSource: CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 06:12:32.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB3925

The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
.eh_frame_hdr.

Correct the unwinding_data description and the eh_frame_hdr_size field
description to match the layout consumed by perf.

Also document that an unwinding record precedes and applies to the next
JIT_CODE_LOAD record. perf caches the unwinding data and uses it when
processing that load record.

Revise the mapped_size note to describe frame-pointer-based unwinding as
a possibility depending on the backend and valid frame pointers in the
generated code.

The libunwind-specific use case still matters: its EH Frame Header fields
through fde_count are read directly from the ELF file, while lookup-table
and EH Frame accesses require a mapping covering those addresses. An
empty lookup table can trigger frame-pointer-based unwinding fallback
without mapping the unwinding data. This does not impose the same access
requirements on other unwinding backends.

Signed-off-by: Letian Jiang <letian.jiang@outlook.com>
---
Changes in v2:
- Revise rather than remove the mapped_size note's frame-pointer use
  case, making it conditional on backend support and valid frame pointers.
- Explain the libunwind empty lookup table use case in the commit
  description while keeping the specification backend-neutral.
- Keep the record-ordering paragraph on one line to match the existing
  specification style.

v1: https://lore.kernel.org/linux-perf-users/CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM/

 tools/perf/Documentation/jitdump-specification.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 7993635..ab43aa8 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -153,12 +153,14 @@ The record type is optional.
 
 The record is used to describe the unwinding information for a jitted function.
 
+The record must precede the corresponding JIT_CODE_LOAD record. It applies to the next JIT_CODE_LOAD record in the file.
+
 The record has the following fields following the fixed-size record header in order:
 
 uint64_t unwind_data_size   : the size in bytes of the unwinding data table at the end of the record
-uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the start of the unwinding data table at the end of the record
+uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the end of the unwinding data table
 uint64_t mapped_size        : the size of the unwinding data mapped in memory
-const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame Header, followed by the actual EH Frame
+const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame, followed by the EH Frame Header
 
 
 The EH Frame header follows the Linux Standard Base (LSB) specification as described in the document at https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html
@@ -167,4 +169,4 @@ The EH Frame header follows the Linux Standard Base (LSB) specification as descr
 The EH Frame follows the LSB specification as described in the document at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
 
 
-NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, then only the EH Frame Header will be read, which can be used to specify FP based unwinding for a function which does not have unwinding information.
+NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, frame-pointer-based unwinding may still be possible, depending on the unwinding backend and whether the generated code maintains valid frame pointers.
