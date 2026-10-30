Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793374856;
	b=Q8J7U+I31vvITccGBYt1yurEbw0hI+UEp7jQiMNmej98tGq7o4jrK4I8QjI7pFAgBXM9
	 rwuDr0JU6GT8bb8wzTnFzLGTYqj9sMwo+ucUMfUq6Ype8yW+1oP7BiA7uWL5Z+VDIBvkV
	 om1LWtoYRmZxJsAT+8agEFNf6BFvjrYozqd0edjao/UxVyRlxIyP46kwkF4EPNkpfyx8P
	 R9/uggHVzaxMlFcRUUr+HDQxQrTf9iXiaZfVSa4w12AM8+siMHQZs8h+sdfGkFvjm8oDD
	 eNq3Vg65g39wEkKFnqJQ8VKHPiP/XDm4mK4a9a0AflgSZWQUUxNgTTLn0x4ykseKt3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374856;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
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
	bh=jDn1/nWsbA1lHQSy57xcDQhCS8c69DjzSRi/Ify3MoY=;
	b=vSu52jIS7ImHiRLANIJGHwM4jJ5OqVrvU0quOrLHpNdeCoTWRj2qO8uaKcI29H7gLPEi
	 cWHrbuqRpRCzB4IV0wMyz1VP+hNVoF9MD6NXH3iChRHAgT4GLkHtyDFQHY4SuYEL4Vhez
	 5J+spkww7JkzrXZnxdupMF9stw2DIEm4Wae4HoRReE7OG1MVxTC8oKmG9e/VPqS4KNAxX
	 ez9QkZOjQEjjm9dhM8KxzQiWwrdu49iDMJXA7/VFp70M/MwBGt3o+IzDtANkdl+/xGHJU
	 YMD7jXNc9vsid2awl0lCMpvIItKv3d9UCo4EpK5nTRa4pEAXIYORLQQKIuwJW4PMsSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=T4k4YV0x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.59
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012059.outbound.protection.outlook.com [52.103.10.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76D606A31A;
	Fri, 30 Oct 2026 15:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F76D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=T4k4YV0x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEWqXMylIrTeIjVWoLjjIlU8WPeml6hP83mztKEpDDs7T7pGMQG2Vmy73UxLzsXGdS6EsgyY+GtBHCpq/tNz37IfRf0Az9iSMLSIQV5hBg+Lhnz7HotfGIKgtP84r2uR7K1SuNaTEzEN0IdknynWaB6NG/9fyIMvCtgm6DZxfLPk25y92jLTOkLS8HLl3XckuD90ojM5BHeZYaPg+Hm1NBveZcn44A0+JV0Bhhc0l23Z+ToCHcbowBx/Fjq3TVpUzwbp1je/WNzQ89ZpHaYgTmQ8VuOmltvTXRxXKmB6qtYyid114DtQn2wK/1ILnX3QK+WDqrO/AoKcSTc9Gly0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDn1/nWsbA1lHQSy57xcDQhCS8c69DjzSRi/Ify3MoY=;
 b=Hyr8Dy+pUF1RPNYqcEQXDvgEKHwilgxGpdAZzMuZGGXsr9Vpimaxlf8YBxKVYlCzgyLE7xJkbgT9hBZymP44dIm1PSsRqPt4usy9yF2hxLP6y4lTvzapu8tHipJAQxltfHyTptMjVGWkWvT9l/w1jLJ9uopXvioDQa1eXBw1MmQZWWrVb3KcdAxg8MdVAVIQ3TPCL8+eIfbayKf7dfjH0bqhgGGVIKqWr6BfI1Wfud+/DaUyCZW+6KxJhYGt4cTmMgyhRW8kyyhv623hVcMr9n52N66kgJ/5oeuBR5VkU79zp2jgrn4twgXgLlt2tLy2p7e2Z6/LEwB931DWpAD5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDn1/nWsbA1lHQSy57xcDQhCS8c69DjzSRi/Ify3MoY=;
 b=T4k4YV0xCRtbGBXFn6sbomxbSLNIFvQXcREecWc6NO5eZmnOXS70C5hZQXRifWV11qPz8Z/7nlxJLGh5+YqttP5vTeZMfLllVUQJnqMq9XTr4xEpKSgu1OZYt2VrmPR4/rOH4v4s9bfhb668FLbdVFTyr0cL8GETNguC+neyh1/b5SUUsd6Ymow1AZShB9IFl8Ao4172j8TEOX/vM4CeMnDKarXcVEWC6vW0m/bKJ3nntXmvunM72nf4Jzl8XMj9fnEQl1wmUuDaK4tIu6dFvNL96ZUte1+ktIy7Lofd0JX14xS0j46yRvNimKB6lm42kYnnYOUT6OcOvIru0+b9/w==
Received: from CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:e8::22)
 by LV8PR84MB433173.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:40:53 +0000
Received: from CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8999:d76e:96a2:a9e5]) by CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8999:d76e:96a2:a9e5%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 15:40:53 +0000
From: Letian Jiang <letian.jiang@outlook.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: jolsa@kernel.org,
	irogers@google.com,
	eranian@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Letian Jiang <letian.jiang@outlook.com>
Subject: [PATCH] perf docs: Correct JIT_CODE_UNWINDING_INFO specification
Date: Fri, 30 Oct 2026 23:40:41 +0800
Message-ID:
 <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0012.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::17) To CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:930:e8::22)
X-Microsoft-Original-Message-ID:
 <20261030154041.82691-1-letian.jiang@outlook.com>
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
X-MS-TrafficTypeDiagnostic: CYXPR84MB3476:EE_|LV8PR84MB433173:EE_
X-MS-Office365-Filtering-Correlation-Id: 9182ca79-4609-4997-83e8-08df369c2df7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|25010399006|15080799012|5062599005|39105399006|23021999003|25031999004|22141099003|19110799012|8060799015|260925184616899003|24021099003|4140399003|440099028|3412199025|10035399007|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5n8RU7kVKFUG0/FcVVWAAqQqG0Z+9msUizi7kRQerMFU1EfB/dkvfTxvw5Gy?=
 =?us-ascii?Q?z4C1Rom7VBEsgMUkWWW9zrtaEej26FwhcmUSzboDPfu3sDo2XTMNrXWAGifH?=
 =?us-ascii?Q?phJF2MZPIsMnnLseQk1chaAgSYtlJXk/tor2NNVlo6VV6SNx57VUdmkkqXg+?=
 =?us-ascii?Q?6Ezn5+cnG7zhoNf8QwekMpGOWj5WTaWLKxIX3HRlbJRMHWJqloYIxkMgkRX8?=
 =?us-ascii?Q?jIBnFrt4LfDB6upCdvnLv3SuwJYusacF3mtCPOcjuB8VCO/jTqenZZJd11Ii?=
 =?us-ascii?Q?y62Z4NH6hdlwMNToEpWy3lmNjbMAsCU/I0GtAkGnsj20JgZgtqyJEoUsQPxK?=
 =?us-ascii?Q?FXxY5Z/SOawIib5ta+sg87et7V9WaT4sH4BpgRVGy+Kmb9kLKrr4IfLDcC7K?=
 =?us-ascii?Q?bk2Bc4UUfEtXLnM1Vs2zFsi90l/l+KhlFxzLO/8Kc/3UaWrbp6KDWWA4HRNA?=
 =?us-ascii?Q?lhcf7WkuGbP8JuM1ejwMUmjjiitUPHq45HELsSlr7EmnW7rg1in/Ufj/iMZC?=
 =?us-ascii?Q?p+QCPxeqPNYYKVL7i6BNEiCLjv2pBLK6u7Xdv5g/31Q9bJ6064Q3L8eLV6N4?=
 =?us-ascii?Q?yYJNpO7OghFktn1/QvT5Oy28nmqmPkuDS+Vto7qJ7CjQT2FKwckWEu9fCxoo?=
 =?us-ascii?Q?VR/y2v/8PiYaFvwqn0O0boiMazluFds86DKfdelISrdVmFoKI0WTmkId+LOc?=
 =?us-ascii?Q?eQK87fzgPTgoniweyyrHNhG/qMuz5dyumpw9EXgv11gY1QSZW4oO/nKo20NB?=
 =?us-ascii?Q?5SUiXHaEoYhZz+hcEUVGKxfvrzmUI354GbSPENm8Sx86TdQtx69NfHZt4lut?=
 =?us-ascii?Q?ogbfL05dfkOc6C2mNliVyk15ZyA/XzWUxK3f7KRhhzSJ/vrI3MWVC6xYCd8o?=
 =?us-ascii?Q?Mmk3joBl4le/40pf3ZCTi5CjSDMPWpBxyNT3KtTL4G5Btw23m48wMK9ID4oY?=
 =?us-ascii?Q?+yAbkLfeQWUwyjHPC1boIoM+BBIsH9ZZ4nqWugSVTZ98H/I/VeWNjD/nhFDS?=
 =?us-ascii?Q?S9sJlZx276g6O4Ze8X2CLJltyUIsWy/MN1e+rlGBkqEbId8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNnYh6zm11w7pb7+XRGLoJNrtyzZ2+sOHkn7wNKQwSxy+a5qH7ucVqifdslW?=
 =?us-ascii?Q?2PIsZRgLrWCWjt+qWdHURlRD6FBDUPeJ1ROc7A/EPlZQDMB4l2CH+vKruf8V?=
 =?us-ascii?Q?8qkmynT9D8813hz2yi32ha3qTfXPgnsNf5XS0GPqr078FakfPB1Rhjx1Z66f?=
 =?us-ascii?Q?gO6h78o5Tx4kOMdPW5az6rkGqi0wLDNAa9gchG2G+ojLdOcOpf3HMjMhvXUD?=
 =?us-ascii?Q?F6gq5JZXVxYJAMwyMQAwYyVgnaxOWRHgPmD8Ywt2OoBpBkIUKnzgNW2fEjzW?=
 =?us-ascii?Q?tZS24lhbBTlBNs+NzgUsmRH5Gz1A5NNaPNzxFDOCzNhCLvHHr8VL6Ef8W2wN?=
 =?us-ascii?Q?OmFCqdmuB7HaVlpuGpZjkO/YvvzocO051nhHoP8HkdOrFqldd+lWFa4cEJev?=
 =?us-ascii?Q?dkN3QnWxwxs/LPxtWfTa3JaV1AnaKYmfN03CZuSNrT3DtMTpBhiAzyFO/zbr?=
 =?us-ascii?Q?8uVAb8EO7meAdQj3hJKwUs+gIoefqGA37O+tFm0iEoi1pCZMB042oCGVE5Vi?=
 =?us-ascii?Q?zRYCEujqnVBdAerE3UaacmFcHzexsIo4RTHlmAg4V0TsBt+4C4wfP02uDUhG?=
 =?us-ascii?Q?9EPBT5AeXddRL85lMfifb0rxSnYhgEL/8zOYKijZKQ6AB3vX3X41ZaneagkX?=
 =?us-ascii?Q?lEtZkVrRGksne2WvKCV6BKm/OKO46Ext2kUqNOam6yxBhFWhVlrbq8PRb8SK?=
 =?us-ascii?Q?brM7K1gqa9O8JCqzg4qvBBmpG1u21YQ85xC/H9rHTcShbE2/C4dZvg/kq6JG?=
 =?us-ascii?Q?OxQHGtixpFJOcukAvkk9BFeIaHS3PjbwJZQUW8nt+evWxOgxiwYB4WYYdKC7?=
 =?us-ascii?Q?VZbEHV6grPuYCLYnOxy9DnPrTsKiQnzmfaOBg8x7BUVWwRzXWdPw8GGJC0e0?=
 =?us-ascii?Q?oIhh9FAd/xhLiqmBz65HMdS85jF5wH3IxOkEptAQvt9raUfMS6vqgfphg9Qd?=
 =?us-ascii?Q?O+UsmeHQ7l4/nKV3VfiymJP2LDnF2dfmTnvCCDlpBTgujdAcK8lg4hfKTtPs?=
 =?us-ascii?Q?oidM3o+F/yctJbcNp0hcVZAneY/edsGwTIPx6gpNXH7R3mJDv28Q6LLSDDL3?=
 =?us-ascii?Q?aXXb/6EfGkjtU3xNdXoFjfKrDDaRvjVkEXu3b6fdQGNZhXJAFYeDpMIal1lB?=
 =?us-ascii?Q?jluoZwnmhaKkKojC230oEvbLj5VKmxgfQZ04I06VCONI8F+07NINMGfGJFt/?=
 =?us-ascii?Q?r95GoukQYDV/C9BXicIOgoogQmmxfCTQzioU6K4eCq9SN9Jpzepxzlj3VjcN?=
 =?us-ascii?Q?9m8U/dkd/0S4uhHE90gge5IdCQt6zdfFlkHQPzgQ7uUmwMAYG3/skHDoIwt8?=
 =?us-ascii?Q?lNLAewCUkiSbPCWudxiwnuRzdg/MdnVuHwEyvyVPB1wNQx9UMOzl0dG0ylYF?=
 =?us-ascii?Q?XN4DmpJVJV3KpVjAF4w9La+EYSZpCi+apImUtNPg7H+Nwfi1Ww=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9182ca79-4609-4997-83e8-08df369c2df7
X-MS-Exchange-CrossTenant-AuthSource: CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:40:53.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR84MB433173

The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
.eh_frame_hdr.

Correct the unwinding_data description and the eh_frame_hdr_size field
description to match the layout consumed by perf.

Also document that an unwinding record precedes and applies to the next
JIT_CODE_LOAD record. perf caches the unwinding data and uses it when
processing that load record.

Keep the first sentence of the mapped_size note unchanged and remove the
second sentence, which claims that only the EH Frame Header is read when
the unwinding data is not mapped and associates this with FP-based
unwinding. perf copies the entire unwinding payload regardless of
mapped_size; the field affects the length of the synthesized MMAP event,
not which unwinding data is read.

Signed-off-by: Letian Jiang <letian.jiang@outlook.com>
---
 tools/perf/Documentation/jitdump-specification.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 7993635..c813c6e 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -153,12 +153,15 @@ The record type is optional.
 
 The record is used to describe the unwinding information for a jitted function.
 
+The record must precede the corresponding JIT_CODE_LOAD record. It applies to
+the next JIT_CODE_LOAD record in the file.
+
 The record has the following fields following the fixed-size record header in order:
 
 uint64_t unwind_data_size   : the size in bytes of the unwinding data table at the end of the record
-uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the start of the unwinding data table at the end of the record
+uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the end of the unwinding data table
 uint64_t mapped_size        : the size of the unwinding data mapped in memory
-const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame Header, followed by the actual EH Frame
+const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame, followed by the EH Frame Header
 
 
 The EH Frame header follows the Linux Standard Base (LSB) specification as described in the document at https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html
@@ -167,4 +170,4 @@ The EH Frame header follows the Linux Standard Base (LSB) specification as descr
 The EH Frame follows the LSB specification as described in the document at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
 
 
-NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, then only the EH Frame Header will be read, which can be used to specify FP based unwinding for a function which does not have unwinding information.
+NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process).
