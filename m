Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAEC36B903;
	Sat, 19 Sep 2026 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779343; cv=fail; b=sTfUVUNUF9/xrbK2dhzDsBYsqcRZ9EpmKMHSz1QlhtML/0AquEIIMiTUuOZnpnvw1O2m3RbHMQijaHLAy/7orYoBkbV49L7m2STzc3GPIi277omCZ/eLEs8S9Y2Zb34a+jCu2IYNSv+TIkEbkGBHvzUup8jiENXYftzU2CYWGGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779343; c=relaxed/simple;
	bh=nvuvKbC6hvuFRszpUpLg4Q9m3TULgaRe6OpZkDs83qA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OPpXNbUYmhF+pcWp+BlQr+HosBgO8UI9GoHFGu4J4B81HHljCmbuzsaoAmc26RgLPXUGWzIspZg/OFqfSTOrzKJHLrEz01dxJzZy2jiWFDv5URo24Xe/IUX0sgQaYd8PDwzEKrUk++6IcSLKjNqLgsEAVaZ83sgWtu/3ycyL0Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydITogpcVSGKdKzXW/gkIwVEAD4RY97mRnBuxPiOpwwXggepmeKGaZK4KF9ZKLnxKlDbNjr//uRDyHnz0ALId0gMuTgQ+fZfG2ucQuRjiFIFRMZXAF6M2sBZSNihX2W0Gd/iM5nsQTHuQNTBja/KspB9qH0b6eoRLo8B9mHGN3xEb6xn2nh5EqFQowZHtwg7d+c4aiBtHNI/9vIK7NuzpmXDqJZSzRK8lNBelx3M5l/g6/T+IlYyiq7AZn0A3AUXnpx0p4zsoCiHb+nmEM6bYGjw+hyaOCD9C4pUpljDuko3LiRdXkjCgW89yfdXOUEtfBHEJB+EfkksZOhecKNPVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=m3NbI/5MTV9d+uqPwulcxqVqRxlNT/EDaeBC63bdBqc=;
 b=LXIie7S2BwkPejzsI9BLZLcp14Z/rKKPHG8AsskPKF4aRG1GiaoOic9V+Obpwjv2rRXV6lu2uVIooPaVuplWBWb8/A7Q4jwml2vAICCPHPn1ygZ5xpWPsLPbfnHmuupxz61VA3VsVR4qjcgFq5wJJ3jBpuQ5djOKlgL58qBvVIpVhyAG6W0he0zFSY+BPDfctUO5ZB3R5LQqKbRAGeLodVdz08qUjICFHK70uRKrMk8iNQoHfohLOlZ7Pysatu4bdCAMJs92ZFHTTV+R/sPlRVZeE81Lvr3ZuwAHPRuszhtbbn9/ydm8bTP9YGSzIRk7+FfL66uc/7Z8DX6ewSHeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:34 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:33 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 perf-tools-next 0/7] perf trace: Validate payload bounds across augmented argument beautifiers
Date: Fri, 18 Sep 2026 20:55:23 -0400
Message-ID: <20260919005530.728615-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:408:e1::33) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: 722052fb-eab3-473a-816c-08df15e8b5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N240bAetMXsUhGAf+SYGXqRVEruvaCn4G2Fda/fAYrm4I7H8dvxq7FscoI5Cx9zlkaXsXEpazqDuRC+pxfki64pdEcV13kQ0emGRLzfVPJaqCBPphGB3hujTf4GwyAVPMX0kLAsQC+oKLPN3cnS4KWWZBT7agjrzFywT2ciKiSwdpDCf0L9e79T2g1Kqs1+JWm5zI5uPyopmkEIQGwvTOOk24yxl4DcHQ5G/9mYxyI5urH/0ZUSBh/MjeOvqWMI0IUY0g/yfKqo86y2T4HtuY0HSglI2EnEJXh6YGPogHeFdOAIS0FI++He++qTcBKBRMTt1Xo4GWpbxpTFyJwADxsOyZio6nvKv5q6ixPgW0Ru0Ar/vzIw/nWwiClHcsEpC07l/uzcmMikKpyvSOSvNdwwq2HPoscarHyVxFyNNPCnI5K+/yFaGzewV6GlmJdUp5f661WCbcRL8xEXaJRXzfb8bosf7Hy5rnaIzLfdH7l9j2SZP7SfLML4Mdo0rPIV5Tvbwhia5GkwkHrReuKeCX2vvmt8AMvifEo8wJ4MQzTVFIHdTOpmnwJLqWcGfCbCEfRKjWs3DHbCAx9ESf4hSz+ptlAP9z8Ln3akIVSJ/DzL+fQKY5AphW2GI61UK7nu650MoAahFBf3M4rwUBHDOZnFoWc8hW9I1IOsEdWAYkYw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9DLMRnf24KpAdq3GJlafQNrafh/WLFrxdsCsWzBEsmMw5QTULmNgIsbRo8X?=
 =?us-ascii?Q?GWcao+jKNKE6sJXhhjFEYBogz9dR5ZRGQNZw/EZDWlpYva/Eh2Xvlfq7cmS1?=
 =?us-ascii?Q?F/9tBULNzLbFJ1U3uYZWj6ghm9IF1z7UM4txSPtahivDddln/LmKBa2JfOFc?=
 =?us-ascii?Q?GZQEpKdjTA5EVbARU0GMiR8jSWmC3acBbn9mQLuSwPczugJ2rNFXKLNfRPpV?=
 =?us-ascii?Q?7iRCPOyLManL6oauIn/T0OsZ920ch5kOnKxSJksK+5wVgyLJlJVwAg779dxP?=
 =?us-ascii?Q?YCJXc7f2tD0pgZN0TzJ316mrjlM3886lJqqBXcvMEm/HpPfE1/8LmX8S20NN?=
 =?us-ascii?Q?yfDo3Te/ZbqsxYqTvnEYdYZIIrgnUyX9xxibCl8nPIImlPJCoqmKFl/CP5lW?=
 =?us-ascii?Q?C8o34mO4wrrZv6UKwmRxrE4jchcpA/Cn+51WhU1FzBRTaPZB0+2spdzBwmCH?=
 =?us-ascii?Q?JUCjOQ5vV5GCdzPWzW6va3NAB5BKsyQeG8LK2/dTGBPOuYetoCXp7MNZ9NnN?=
 =?us-ascii?Q?XSVQEOT9izrNpZkaJhItQNgJJfLvz+i9zgkAkAyTg99bJyvWt2Hr1aFFTT70?=
 =?us-ascii?Q?lqV+qCNE+RHGuaT0HpMCwADuLrWAdpElwjU7AYYSq71015nNi8pvks6kVxiU?=
 =?us-ascii?Q?G1jsBx6nrrz22d7nXyP0OPyUu46vn+7gSMfK6VPudW0L6aP9ODTwERKv24mv?=
 =?us-ascii?Q?bhoYONhmwpTou7MjGUavPaj7PeixZTXUk3ITe2KJNkYcKdpy0TPFveJ7eNFH?=
 =?us-ascii?Q?Cd7AlmOWY9VWe2OqqM+1yzbtX19oUMtgkJFE+HS1br7P6HOKu8iyoJXY7MVD?=
 =?us-ascii?Q?PwX1JX1XSpfwUeb4tuKLh9+D87Uu2k7V2KqBlAAkrYxal9t0zTiMiz7DohwJ?=
 =?us-ascii?Q?0qjzDbx7GUdEF2//Gp6F5dkonDeUX5Tg8m5eE5uiWOk0VoSRd0dPmheMcjlt?=
 =?us-ascii?Q?YT5E+mt/rIiTAh1qjjIN9UG2cuShxJKaL36UAt+TXI2/EThZYw1ssDDc1Gv9?=
 =?us-ascii?Q?UTs1TFxkb7KaQXpIlLBZwPFlK2/jwoDih6SaZOzQBq8TXTvMjOk0nZ4SNbKR?=
 =?us-ascii?Q?IO1nHT2s7j3ivLtaisZ7RhyxQDB1mOfC6bPCuA8+rfKLILQVyHi++4ZOUFxg?=
 =?us-ascii?Q?fPku4IHV0abTxkVMXX9SnjVDWTOl8kThkShv/nFA9kUqZVKm+Mr3Z+V4Dxsg?=
 =?us-ascii?Q?4o3wBo90y941rgQXzo8E3yBl4FdUyWV4SusQ7FUxqtxjfCsBEtbs9YNZlViB?=
 =?us-ascii?Q?H5dGFFOdc6hj4L4IDx4ZfKrfhUlEFKnpetBh8T9luzKh9UOme1J6PmsG+Stt?=
 =?us-ascii?Q?FmZXd39nZDjxOJrnlsHGxm0QvwRK3Bbm4hzS+RhDEsaBBSo3oFPRkiFY0he9?=
 =?us-ascii?Q?7hUhuZ6TBdvVQ6JDe2fRDwXhf8ARDCrFfwhKv9pWnRt1EYo02fzz+LY/Dalh?=
 =?us-ascii?Q?K50zCQ61ooPKMCmO5aJrj09eu7Andg1dJ9Egvf5want8SJ2CSRgg5EyErnZS?=
 =?us-ascii?Q?16wEnbc5erlmvgH+k+NW/bO9TRk8ZUcV8nOQKzE7AB+sWG5vJ+ZlDzdtqwGl?=
 =?us-ascii?Q?6ao5L4nGORriE85v9P2HioOqJoz8d/pSD5hFhaNOcKIF3rPx3gbKeupnY0JW?=
 =?us-ascii?Q?dQKC99Q5NgdYNeZFdYdfAqS+VubGeAKTpcoqiEMdSqDuzd6zBGr1CAp1s5oe?=
 =?us-ascii?Q?DINcmi9A+thsnlOiA9vX9/rSyAh1vR5Dcsas4loqKtzG8B7nWCDlxhOO1qBk?=
 =?us-ascii?Q?5u+CiJBVig=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722052fb-eab3-473a-816c-08df15e8b5b7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:33.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEW/ZliNLuPNg9zJDCwg8C/OwfGFmVO0fGpniBCzG8KP0QXSv9r2tsRjNF2PBZhJJjTk2gG+o+5Kf3SNBDlJkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing augmented syscall arguments in perf trace, raw payload
data captured from BPF programs is passed to various argument formatters
via struct syscall_arg.

However, when processing malformed, truncated, or untrusted perf.data
records (e.g. truncated reads in BPF ringbuffers, cross-architecture
replays, or crafted sample records), the payload can be shorter than
expected or contain invalid size fields:
    1.  Dereferencing augmented_arg fields before validating that
        arg->augmented.size is at least sizeof(struct augmented_arg) can read
        past the available buffer.

    2.  Passing augmented_arg->size to formatters or loop counters without
        bounding it against the remaining buffer can cause out-of-bounds memory
        reads.

    3.  In multi-argument syscalls (e.g. rename*), calculating consumed bytes
        without 64-bit alignment advances arg->augmented.args to unaligned
        addresses. Furthermore, calculating consumed offsets without bounds
        checking can overflow signed integer bounds or cause arg->augmented.size
        to underflow, advancing arg->augmented.args out of bounds and
        corrupting the parsing state for all subsequent arguments.

    4.  Type/family-specific beautifiers (i.e. BTF struct dump, sockaddr,
        timespec, perf_event_attr) can dereference structure fields without
        verifying that the payload contains sufficient bytes for the target
        type, or trust embedded size fields (such as attr->size) that exceed
        the actual captured buffer.

This series adds comprehensive upper-bound and payload-size checks across
all augmented argument beautifiers in perf trace, enforces 64-bit pointer
alignment when consuming multi-argument payloads, and ensures extensible
dispatching for address family formatters. If validation fails in any
beautifier, it cleanly falls back to printing the raw pointer/hex value.

To facilitate clean, conflict-free backports across active LTS kernels,
each fix is isolated to its own commit.

Changes since v2:

 - Expanded the series from 6 to 7 patches by splitting the string
   beautifier pointer advancement and 64-bit alignment logic into a
   dedicated patch

 - Added a new patch to round up consumed payload bytes to 64-bit
   boundaries using PERF_ALIGN(), matching the alignment produced by the
   BPF tracepoint probes (sys_enter_rename*) in
   augmented_raw_syscalls.bpf.c

 - Reset arg->augmented on buffer overrun to prevent corrupted parsing
   state from reading out of bounds on subsequent arguments

 - Validated payload size directly against arg->augmented.size instead of
   reading augmented_arg->size, which is unpopulated by the BPF tracer
   (sys_enter_{clock_,}nanosleep) and contains stale per-CPU map data

 - Refactored af_scnprintfs into a dispatch table associating each
   formatter with its minimum required payload size (.min_size), preserving
   extensibility for future address families without hardcoded conditionals

 - Used offsetof(struct sockaddr_un, sun_path) + 1 for AF_LOCAL rather than
   sizeof(struct sockaddr_un) to correctly accommodate variable-length
   domain socket paths

 - Validated payload size against arg->augmented.size and payload_size
   rather than reading uninitialized augmented_arg->size

 - Validated payload size directly against arg->augmented.size instead of
   reading uninitialized augmented_arg->size, which is unpopulated by
   sys_enter_perf_event_open()

 - Verified that when attr->size is specified, it is at least
   PERF_ATTR_SIZE_VER0 and does not exceed payload_size, preventing
   out-of-bounds reads in perf_event_attr__fprintf() caused by malformed
   records or TOCTOU mutations during trace capture

 - Link to v2: https://lore.kernel.org/lkml/20260907015140.363076-1-atomlin@atomlin.com/

Changes since v1:

 - Expanded the original single patch into a 6-patch series in response to
   reviewer feedback from sashiko-bot regarding similar bounds check
   omissions across other augmented formatters in perf trace

 - Added new patch validating payload bounds and consumed offset
   calculations in syscall_arg__scnprintf_augmented_string()

 - Added new patch validating payload bounds before byte traversal in
   syscall_arg__scnprintf_buf(), isolated to ensure an independent Fixes:
   tag for stable backports

 - Added new patch validating payload size against sizeof(struct timespec)
   in syscall_arg__scnprintf_augmented_timespec()

 - Added new patch validating payload bounds and family-specific lengths in
   syscall_arg__scnprintf_augmented_sockaddr()

 - Added new patch validating payload size against at least
   PERF_ATTR_SIZE_VER0 in
   syscall_arg__scnprintf_augmented_perf_event_attr()

 - Link to v1: https://lore.kernel.org/all/20260906011132.279321-1-atomlin@atomlin.com/

Aaron Tomlin (7):
  perf trace: Add upper bound checks for augmented BTF struct printing
  perf trace: Validate payload bounds in augmented string beautifier
  perf trace: Align pointer advance in augmented string beautifier
  perf trace: Validate payload bounds in augmented buffer beautifier
  perf trace beauty: Validate payload size in augmented timespec
    beautifier
  perf trace beauty: Validate payload size in augmented sockaddr
    beautifier
  perf trace beauty: Validate payload size in augmented perf_event_open
    beautifier

 tools/perf/builtin-trace.c                | 45 +++++++++++++++++------
 tools/perf/trace/beauty/perf_event_open.c | 23 ++++++++++--
 tools/perf/trace/beauty/sockaddr.c        | 35 +++++++++++++-----
 tools/perf/trace/beauty/timespec.c        | 15 ++++++--
 4 files changed, 91 insertions(+), 27 deletions(-)


base-commit: 02f6847e1822714a4201b87e42f92b0d43e8549d
-- 
2.55.0

