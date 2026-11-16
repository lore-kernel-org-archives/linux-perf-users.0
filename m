Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794838550;
	b=dztAKqRX4psTsAiXtQAvvZ/JC/rbXTTBefOiFtytYLL9DZK9VFvNFk2nbnlP6xYfwz/Q
	 MPPQsAj/r6b+hCoDf/nTgbgmEejRI9uEIgMSHoKSTRyV02tWhxAcBE2kF5DkzQ3pzpogA
	 RM1aIduW3Gjknvh4cUImfZSNKgqZMcyDnh9poC9fMNzg79QTpWqfsMqBke6iHtoRL7XQU
	 XLFGWBTBIkkxeB2aSxiNKHnqy4C2J515HwtppyeLZ2055ZHl05TQnMmnnAvP2sPU5qGiA
	 kfTvNus18MuQbOqWoaQM7Pz3ViDgFbUOLPppMq5dSfV2R6iO0RORMrxxmUZsejZV4Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838550;
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
	bh=sTiKVJkdvP/fXvnFmUPvlu4owIbmSFmEiDankTRW7v8=;
	b=kPvLmYv2/Mu9PEcw+JeXBLeZ2NP/Q4LyW8G8u5LCT+97TK9IH2W1+zb6ktQxRxZ5Ya0h
	 EXAs181TriyA+PCjGMfane1cxK/Ch0ItupicZeJ+vzLHVylyUTNCf/3DU9/unTtsFxdEw
	 8DJVuA6tBbJLG3uU4IGoAOF2cEYUZTrPiLpKnN5tA7NQTYvY0ih3BsnQMWcBofCivOA2K
	 jd1pmxZ4UNnxyg/cLOjB0qExnfzE4hKMLbzvOB4UVFp+6sHyrMvfHfKe4CGoH0XsyquSx
	 4sFlzPy8sJti1p+Sub4oesDc/mg0Rs3Rs7Y2nt0rFVT7B/4ZNdH9qRC3XJLJuqPa+9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=u1dhb85G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.84
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013084.outbound.protection.outlook.com [52.103.7.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C6160A2604;
	Mon, 16 Nov 2026 14:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C6160A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=u1dhb85G
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlDMYOEQu/TUvgInp4ctoiJPP+F3A8roX/67Oz8VBKXocBT5iLJQ+71j5aImccsLIQ2d/m3ZOLVIfFHHagV780UNuwR2bx7VST/TFOcEWHbGApoC4J7hIqXvHjwXSHvo81BP0M5vVKYejECOCvz+P/8cOBlyKtIGqO/5TEkxwDEwkuB94SAtNExkAs8OBv23GoNsAswo94gO+WpPHrJUFNmufpIB1BD+AliMLmNM7B5I1m18zcUSV8k1Z4V0nd7R4dmqDQvQaFIQK8zRA/DbZRm41J0zzDSl0mi89MsWiXe+Xicm8Z47uKo8F/ORvvNHOlJ/UI887knGNEQi9KmIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTiKVJkdvP/fXvnFmUPvlu4owIbmSFmEiDankTRW7v8=;
 b=kbU6uMAAoW/kqrvD7rCMqme4HIzplJTa2Xoy1Pn0Nczdf9L5M+yHI7JVv7kaTKiK2zBr3Z530dDXQ1wWluJyb3C2gdWsT25AGo9zpSYtlC2mFNptyFCDOYm3euJ7lA9KzUqATSqLa5QCG+FgMFZbWFbT/wWEaZDf1IQVUFNrcJclL0VJ/IL5RNWoa0MCfb8BYm4rxCWWo07I+ad4h2DxjnQtB+a+oCt3FSYpQjkU2tlr7735AuHVPZJgQzbjeotfA4LDIHbK97//HbHY75TsMGrS3wioZac8teZyFifAzP2cic4DqbxC+It9y64IRLFW8v/Zf0I2i/7hS3VALIMz0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTiKVJkdvP/fXvnFmUPvlu4owIbmSFmEiDankTRW7v8=;
 b=u1dhb85G+hXyBO7udjEPvCt7RIVT7InvgP84RQe1XQoF48l+JjJf5XvlP4INvzKiHhrrsdMOvcQxGp9PyAvXxEI39ZAVmhMI4kaJbQIdbM5magxwtmgDoBHxyWSloKrxzWMrqOxYMnDq9w2fRs42KQeD5sDBk9weq3rC9YF9uu3CHuYFG0q3tJPepqS8zuXTkbscH0HiEyVfw1lqVvwBUJLLfpZizyCRe8s03cHdwdhko9skz+Llm2KA9PK7KyXo5FHYPvR7J6sRBiile8JPk6BKi7qC92b+NOm3p21QNhqzUhBLGJb6VZUfpwhjyRleVc6oxh7G8xZ79v5dyREPfQ==
Received: from CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:e8::22)
 by CH8PR84MB4014.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:15:47 +0000
Received: from CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8999:d76e:96a2:a9e5]) by CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8999:d76e:96a2:a9e5%5]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:15:47 +0000
From: Letian Jiang <letian.jiang@outlook.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: jolsa@kernel.org,
	irogers@google.com,
	eranian@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Letian Jiang <letian.jiang@outlook.com>
Subject: [PATCH v3] perf docs: Correct JIT_CODE_UNWINDING_INFO specification
Date: Mon, 16 Nov 2026 22:15:38 +0800
Message-ID:
 <CYXPR84MB34769BAF18918C609FCD3327827C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
References: <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:930:e8::22)
X-Microsoft-Original-Message-ID:
 <a21faa584a216ccec69f5ae39bbac5227cc0cb05.1794838271.git.letian.jiang@outlook.com>
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
X-MS-TrafficTypeDiagnostic: CYXPR84MB3476:EE_|CH8PR84MB4014:EE_
X-MS-Office365-Filtering-Correlation-Id: 5263edaa-d529-4489-f222-08df43ec1be9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|260925184616899003|51005399006|19110799012|23021999003|15080799012|25031999004|25010399006|24021099003|5072599009|10035399007|1602099012|40105399003|4302099013|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4ORbQ+V+W2hCZildjHAbCsQKa+u78PZQXygyL8phwPfTyQX4m2jSLkFefwe?=
 =?us-ascii?Q?i4ADL/XCOm9XovDE+HS7Y9AyqUwjwliq4o0Zd8P3jxfd56Uf1Z1tVQHtQrTX?=
 =?us-ascii?Q?5TESwlRX9osup6FZU7GQAG8/T74qLOh6xKCKPRP2cXj5mMNJb8KZ0hCANeuM?=
 =?us-ascii?Q?X7UgjpWBOF3nVEQf/ivLCc+a/6SNSmZbXAiq17FATyiXWHYHTnvKDvtbiVKk?=
 =?us-ascii?Q?iRuxTcck6viVZhlxu9XK/JqABjBBmWhHytKAuExpUd+6sT1X8FJzX9NHgFrJ?=
 =?us-ascii?Q?1Ujyi9eQ5PegP8fYfKmWMBLmae+QZyBb3qrg4tFajhE/sIMe3xbPStkTu5c/?=
 =?us-ascii?Q?TZWGCVQzORe4Cakt5jjwCA48p9WoLCKt7p00X3GGdLcTikR1QqD8jf+Ig3bl?=
 =?us-ascii?Q?2/cmLJGBgEsjNphsw8tIuTBmiUdFnxIzq45qUepWraTEBsoPi5ewGiWIrv7S?=
 =?us-ascii?Q?IqRVJU8mjtgie1M7boksAMVshG72A7SI1s23xsilxAr+FuH7m0UM5z5dcrVf?=
 =?us-ascii?Q?JwOAy94DBKSExj9OqELa21EfBuKctf1ik+pxqKf7fMli47Ioco1DRy10c8Aw?=
 =?us-ascii?Q?TL5ES0aLsj8hf7KQOVjw6B0snduHC/lKX6kEnjRFXLaEuNiqJhSQHA+Z7Gox?=
 =?us-ascii?Q?D6zUAcvO2ONthgPAt+3ejlmdO/ZclqbwHhoTZmJUGdggx6PqFMForydRqXEz?=
 =?us-ascii?Q?fPxv0f3JTJT4eEVJis7atyEe/vj7T7Eavkxj5v5QQ2VIQNdr6d8tdPR6xxjE?=
 =?us-ascii?Q?JczARYMrvspVnYyzRueZbDWekkOogWVPVhi4ZWJUESOubgJvev22BVg/WfSG?=
 =?us-ascii?Q?IAozUTOhBB1QfDvakwOUesxtysmOIbzakkPkBwnDz8bkNd2Gu735QOLFe8AI?=
 =?us-ascii?Q?ImKSQvkO+YhK6kilzcseP9UbNYvuyqH4S9iSXeaxH0DfoBVZSugVFazuCaJp?=
 =?us-ascii?Q?xLC7UoGY2ZxoIbn9BGKmqYFsv3J1105Rl2Q/Zj7e773h1gntJcvBVEfXwtEY?=
 =?us-ascii?Q?Ijx/IxH0OzxAGcDcQpx6hPBgNZd6/5g60xf9/dvh+asSHKg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k90x9pVb1WBvDrR5dLNOjL95gLv/tuIP5OJfSnAlfpu4/Y7ZITIjzvfrRTeX?=
 =?us-ascii?Q?EoHbamirTSPztUYDvnFVNbaU+0K7D+Lm3YC7a0v88lOix7Dj7LQZl+aTM2p9?=
 =?us-ascii?Q?hLmceLYRKMtKRCZG9QglLO6gty+tMplzLdl1aFjN85UlqvUgiipLwklS9YLT?=
 =?us-ascii?Q?gJNDJFiR3dF13/uwMCOPeHZbLX++1D+4CHvsozlNhEPaXBU6go6W88EjQPzf?=
 =?us-ascii?Q?NXvFVT4vtSPOflVeZhEzJJhSW+EMQSt0pXn+c76oHuZYJ3kN46bkuZdYYc99?=
 =?us-ascii?Q?5SnfWod3uW3908vFgUeHya2BQQzosqjVMcCiSNEIhjwlKieerteA45AbavA8?=
 =?us-ascii?Q?0iEpBR2te75100czKfnhyf2vxRI+o2r1knmPppJFITups0nKUU/CwaZmlvGW?=
 =?us-ascii?Q?5a7amAfe3ltdMPDZIWHCd1xIEmhV68HcY54pfuwFQsJC621//16ZFxGYLRBY?=
 =?us-ascii?Q?YiahQyhazFF+rIYYP1ZcFZ1DpO3IVdflJXaTalO7X0Ypgh9Y4PuT9PpbqQX5?=
 =?us-ascii?Q?xvOTCZM82J06iqn2mgv7wHEEYOUBVxAlWPbtMYjBWPhpGBMDOXMFvy85FlNV?=
 =?us-ascii?Q?+s8pzlxM767Xn0Iewaj4EZN7kUareQLAtU+vfPU/B2CoGnkQxuFksazYgLQL?=
 =?us-ascii?Q?KCHWXX7U5dRRZ0odftJDUoMgkqo7CIZgj9oEbRlkZZrMlrnZ8oGfeQXsJhus?=
 =?us-ascii?Q?Gs98Ni/8DNb17cVMnsVdnaloDbb9IzmfZJgSV4lZOV62QZfIqU7hRAu/ZcvF?=
 =?us-ascii?Q?bkc8eLclbZpcMYthMP/ljekCgTizshNdm8SdjqJh49EGxp7S89vjf+VAFGkU?=
 =?us-ascii?Q?Tzemgj/rf9N/D3yI01SwQjTSyIeSiXhnBRHcc+q7ZJZCZPdMdLoLtgQ+RXg5?=
 =?us-ascii?Q?d6IsDif4/UJv1676xbfWHeVGxOgHTw9b11XEq8muHg8xx9yZsxhbxtjKUj7t?=
 =?us-ascii?Q?Jtk9is+99+SpbycqROFE1XGD8aw+HABxr9EDmpwzfZUtBBc0gslbYKzwZL1/?=
 =?us-ascii?Q?TQa4ZvPeydA3Ftunp3oNc0Fug5+gU7A1nQCr9VBEBcFYOjH4WxZuY94ZhwfM?=
 =?us-ascii?Q?ZMC9uDERmcrnApgUKLL2pAl7gT05Lue54CQRYK25vOajifCueHktOfJQnlUF?=
 =?us-ascii?Q?5MsofkhAcczwVvUTlErgWHNUPqX9TcKrwWDGbenfP3zD/QcmMQL6J0oUZmXX?=
 =?us-ascii?Q?bEFK4emBKdDZZ3JRm64UTy1QiTKH5jG6fJye2a4b/4gOx+6z3P9Q6qeW8+xA?=
 =?us-ascii?Q?Z2Pmd9l3noM15SxR2yR09SoQBpoUcs40XJ9jK6fcOBuFWyj97fyNKQiujw9k?=
 =?us-ascii?Q?z87+khMZdaCV/utdRpNEBkUIeLN7Kaq44Paq9sTjevRsM7DIiwbq+cQfpdwo?=
 =?us-ascii?Q?ngWY/D0SJIin42onQBnYsKjoECEMhRBEfPzl5En37Bs34yxXnQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5263edaa-d529-4489-f222-08df43ec1be9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:15:47.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR84MB4014

The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
.eh_frame_hdr.

Correct the unwinding_data description and the eh_frame_hdr_size field
description to match the layout consumed by perf. Clarify that
unwind_data_size includes both sections. perf subtracts
eh_frame_hdr_size from unwind_data_size to obtain the .eh_frame size.

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
Changes in v3:
- Clarify that unwind_data_size includes both the EH Frame and EH Frame
  Header, as requested by Namhyung Kim.

v2: https://lore.kernel.org/linux-perf-users/CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM/

 tools/perf/Documentation/jitdump-specification.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 7993635..4698b03 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -153,12 +153,14 @@ The record type is optional.
 
 The record is used to describe the unwinding information for a jitted function.
 
+The record must precede the corresponding JIT_CODE_LOAD record. It applies to the next JIT_CODE_LOAD record in the file.
+
 The record has the following fields following the fixed-size record header in order:
 
-uint64_t unwind_data_size   : the size in bytes of the unwinding data table at the end of the record
-uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the start of the unwinding data table at the end of the record
+uint64_t unwind_data_size   : the combined size in bytes of the EH Frame and EH Frame Header
+uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the end of the unwinding data table
 uint64_t mapped_size        : the size of the unwinding data mapped in memory
-const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame Header, followed by the actual EH Frame
+const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame, followed by the EH Frame Header
 
 
 The EH Frame header follows the Linux Standard Base (LSB) specification as described in the document at https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html
@@ -167,4 +169,4 @@ The EH Frame header follows the Linux Standard Base (LSB) specification as descr
 The EH Frame follows the LSB specification as described in the document at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
 
 
-NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, then only the EH Frame Header will be read, which can be used to specify FP based unwinding for a function which does not have unwinding information.
+NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, frame-pointer-based unwinding may still be possible, depending on the unwinding backend and whether the generated code maintains valid frame pointers.
