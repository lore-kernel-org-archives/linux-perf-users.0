Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF6221DB6;
	Mon,  7 Sep 2026 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745911; cv=fail; b=V+Z0SqEiufWxfDB5Gae154MUOvwuzUzShsicDIug7xHyhWlKfPIM/Hzs6JnkRytgPMthkPFwza3px1G3Umb79iWrKKvoVZk85DihlFL6XHdDJ79lyBPzTUSoRYbR7eUw1J31cYYGoifn8bbsxRjYgKVLsQE3SnFXUDkhBGsr07A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745911; c=relaxed/simple;
	bh=M7pfPr8R9va6hhPTSG0e5puNMROqGaszTN8Ov4KC0nw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BlyzKT/C+qbYWSibSvflqZyaHNomv5GbDW9E9GKOmiV4JnDvGsTGdi3VT1WBdi7Ur9gxwfGA81S8PvvMCOFj+PbNz+H4q6N5aAUVBzHrm8PRLzF2yGi36eRBUBvz5BNgLQEEfVzC8ZyQFk+vTB87DPqZRvmiWle0jOiRy8WFqog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFzQU2A1Whd4RJRP/yCHZd8lY0vp6wgiE0b089KkE/UaY3ZyKJjatwGWIGv1ct8coKH0o/orZNDJ0Sc9uIOidxg7bbI8ye+KI5vqPv9pHMq57dNwlGnvjI3zJCbTdgF4jQMHnba2B6gCpV59Cm8P1usdIVlyay+8yH/uW5CqeIoxe0jEcpAc8mvQsKF5QXwnE4SP4c1vzctxJhZdjHTO4K6ZgscUO8ib74/AXVhypOfA5ak7hrAwx+EG/RsauUK24jOQMIBctbXthih9O26GOtRKe2+YLKo7jbJxCmIYQcIV4jcDuJ0QgUUFh4Fbn7R0FF8iKtaf/3RpPUTD9sipKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=cYMcNmQavEt9MXnwPDg/AD6UXfXo2o/yIBKOcVJNjac=;
 b=qwUT7aVl6LdUej7I0bsnRCJuaN/fooVO46q0WSr7nStqW0fFgaUwKijXlpnRGSbQHFmaVf//iuTABehuZKXVkv+4cO5Yus2jvbmVUX5orC8z30+huzLVjThItsZnz+3u9cFGLM/KUX+kfvmLI2g5n/g47PMrVCy576OVXskQj05SGywj8MmLteFothwk5AjZAjOeB7lJiSrqU2+klXaJTGTdTMFzNErWcfXhMeai95J0lacosnoS/XM4+IAJlwyKGMXSADFDH8OPRir6cD5YNHh+7heIkSJ1Lx4LiUtXtcpywgscVuP6uzpdBoziH8ifmV59zjU26hkCtvDSmTTLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:51:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:51:44 +0000
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
Subject: [PATCH v2 perf-tools-next 0/6] perf trace: Validate payload bounds across augmented argument beautifiers
Date: Sun,  6 Sep 2026 21:51:34 -0400
Message-ID: <20260907015140.363076-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0649.namprd03.prod.outlook.com
 (2603:10b6:408:13b::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d8d991-7a4a-4f36-5cec-08df0c8291da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	i/No1F6oqyL/P1+wyzipxev5snMCSvRkVCX8dwN+rcYxMoOYPWR2iTKW1CRAEGx0XlTGCF7rQZ9ILb+pgA0PJqXOmVlbsOI+nnKXzbAle5Frg2JdGWrFoKsDq32SWJgQmTxGsDk5vRtiG5Nkgs2fmtykeMTFXT790a6DlcK0+BQ2I208pXzYCvIu3LACrzlgpMDA0wpCHKPeLOHXfbvuiSqL19UryY40/p/OruBN6Y2i+XxqEUxxVLrBg7KzCeGH5ernJbNTG70jn2UM+4v1dRqUblgbujyXufQXJm+b5I2irC6RWyxDu4XCzZDYU1HJ481Zba0kzugz3OTy91LKfuxOloCzRJ+Flp6oErCqZrHHC+bl9NuJrFKjMrGmNH6VrUxDWpKkamnPgNsKF30ud8a9qjYssR4RGMTE+KC/3+Yxrn+fDMxoFmBwJoJDCvxgRE4XPsmRQuvwp7B1Q/j/Rg/yNuQ6Yl/cZt71E+OtnqxS4WQ8mT127iiq25EC1mgLkchyRb/tT/1qc9Hel32AUspkZqHpvzrBisi7LuWIXXDBjaj3Mb38i3kxfg2YFa0LHR4Nw8S43oLMGvUObM+JPX48A1BQs5oHAPAcny1ZOaRiuQo3oaHbDbq+PBCZAM/vuJobEC8pGd0ZiORqSm7x/mcgW064FujaLw9jNV/vHTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OEUFQMdyQK70hqOSLLmU0MzVfV5cQAmvVdpo8ojAJI9lCy2/CaAh7RGpkxpc?=
 =?us-ascii?Q?aGmiwNjZbh1RoKQ4AG3d68DTbkcBkkJGcxlA+lSRzR5vQClXSLKgS6/N3Pe1?=
 =?us-ascii?Q?14GbZCgylEy6ETUgrSex3d+5dYXVkSTZmoO02tlz9BZxKB/lVRsqPPSsCxRP?=
 =?us-ascii?Q?ux5INyDI/JwzwivgfWYG4Sn2gzRAQA/TimCHy05KnqJK8omH0/GAOS+dldqp?=
 =?us-ascii?Q?mGIQyRZxjF8jA14Jc3P23DcfGIa0FPA/6DE21LTA1pnYKkX+UKc88UiQw0st?=
 =?us-ascii?Q?65waJPPY2+8sarB1co3VBrDqbq9Ub1C6FFhcaASTw9NXrNORWt3Vd8wlD2mB?=
 =?us-ascii?Q?t6gCwE0UBzXMXY7eO3xmpWsX167QkRo6JxhEjTrm/0FSZcfw/ztkSUhQFyRh?=
 =?us-ascii?Q?J3syE4taPNGhLtaJKCBzZGGY2tx1KmU38IHAnzzkh4/9Hae7qqsE9+gb8aZZ?=
 =?us-ascii?Q?inmtqdD1+D04dovyupUvcHPXmRnQ99zAwhBwgRyAZ7ZoKK6D+wj4JuKusO+N?=
 =?us-ascii?Q?Nh9Of4GbM3bM5/+8S10OacHIRlTi0yqC0p6vIazjJMqs6OlTba46Dywvotwj?=
 =?us-ascii?Q?IWCNC+IAFmvBi83vekZx9woeKSV6bCNaVT6moMZkcuZ2XjgKxR4mkiZoUlac?=
 =?us-ascii?Q?iQsBOr4Tsi/kuFWm1aiwZTHi51zt9N5T62chaX27RuQauY9h/QnFgEgZmSgv?=
 =?us-ascii?Q?1LOrXFIUYhpokK3PEFnojy5kibMmeIrkExAl+ZEkdISBxUBb/Tb2cXk2SKOt?=
 =?us-ascii?Q?wP/LfVZvNHsNgjm1WiUtVWixzZ68pjNzoGpYk1P1jLcNCc+oBHIbQihsA8QX?=
 =?us-ascii?Q?ON4YJgRMtA8oYQzbnbwSHduHc79eSwlBRTFsjwqIpkrVww1AoTF88GaMtzg4?=
 =?us-ascii?Q?eC2ScMbVph2VBT8no0gXIvJNutwXRwtEGZtMxSz+rVFb06n1evac5qIaEtPN?=
 =?us-ascii?Q?uZ9XQ7z8yp75rCg58a+KVaK76UucV94lrIF7IbPNmqPwtdZHwMZuKVMOM6sf?=
 =?us-ascii?Q?6i8EAcOMSaaCB2wCNHu4HK6yxrJVBtJAsfuYXa6n2+cjcs/0IXBpDfBnwm3i?=
 =?us-ascii?Q?5BeJWbs5LR6D7sFLIFOo8L8yswoRU67r4UsR1yj8w6E7YF/fX8fK2UdPVe9T?=
 =?us-ascii?Q?40uI2qJGoOTd+WR9SCEk8HTMY5Cax8P86vYl9GtoltM8sD/aQmB263RFdVdC?=
 =?us-ascii?Q?WbQPE2voXrQYWNJxkfUvYhVgYJ4LYzeZN/KSsJeLYMQkEJ/vBWrH9BX1Ievf?=
 =?us-ascii?Q?wKNYpFCs25jVs4eoL4CZhkz+pu6fnYl3jXdvOS+Yv/UpSSlr7gDQR/QPPCbj?=
 =?us-ascii?Q?TamwyQz8eefO0So4EKyozY+MLN48jAMn1g7vOcQOSMr9LroTMAK+XYg+aF2L?=
 =?us-ascii?Q?TeeFNtcn7mu/E63S08VbBzGL6cSLjOjAXaxmIcVhTlZqEjJTIqMTqHuHYKeb?=
 =?us-ascii?Q?oRXithqNoYybkDDQMccx+hKX59cmJt2sNBN6KYhWuRv6KFT7jKUpKVsUoAP3?=
 =?us-ascii?Q?trh7ldV+x/pgllXxINby5g37mYlC1S3DCZOJxYRlCet9UhRCJ1bLwz4cOd6q?=
 =?us-ascii?Q?Zrh2FVTVA5uYr/LDVSbqqh6CYTuaAUyOVUdOTAifAolugrPpb8S/SemRHkjn?=
 =?us-ascii?Q?HVtsv1f8un2J/QGQyZkV4JKmaDDcDf/im+0LnmwRuugNdcVubWnnN6LAi//1?=
 =?us-ascii?Q?X7J20F5AFZy1mOKeU6h1Qaor9PnvedcZOM31rNm4x1/22pVDyunklsw+qXKJ?=
 =?us-ascii?Q?762ukXYtyQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d8d991-7a4a-4f36-5cec-08df0c8291da
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:51:44.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJFMsyh12SgjFC7I5z6220FFT4e6eM4I9/t4nl72qptt8fsgMfhKE4d54EjDNJmO2eAcEG3i0hAHdoT//YOtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing augmented syscall arguments in perf trace, raw payload
data captured from BPF programs is passed to various argument formatters
via struct syscall_arg.

However, when processing malformed, truncated, or untrusted perf.data
records (e.g., truncated reads in BPF ringbuffers, cross-architecture
replays, or crafted sample records), the payload can be shorter than
expected or contain invalid size fields:
    1.  Dereferencing augmented_arg fields before validating that
        arg->augmented.size is at least sizeof(struct augmented_arg) can read
        past the available buffer.

    2.  Passing augmented_arg->size to formatters or loop counters without
        bounding it against the remaining buffer can cause out-of-bounds memory
        reads.

    3.  In multi-argument syscalls, calculating consumed bytes as:

            consumed = sizeof(*augmented_arg) + augmented_arg->size;

        without bounds checking can overflow signed integer bounds or cause
        arg->augmented.size to underflow. This advances arg->augmented.args
        out of bounds, corrupting parsing state for all subsequent
        arguments in the same syscall.

    4.  Type/family-specific beautifiers (i.e., BTF struct dump, sockaddr,
        timespec, perf_event_attr) can dereference structure fields without
        verifying that the payload contains sufficient bytes for the target
        type.

This series adds comprehensive upper-bound and payload-size checks across
all augmented argument beautifiers in perf trace. If validation fails in
any beautifier, it cleanly falls back to printing the raw pointer/hex
value.

To facilitate clean, conflict-free backports across active LTS kernels,
each formatter fix is isolated to its own commit.

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

Aaron Tomlin (6):
  perf trace: Add upper bound checks for augmented BTF struct printing
  perf trace: Validate payload bounds in augmented string beautifier
  perf trace: Validate payload bounds in augmented buffer beautifier
  perf trace beauty: Validate payload size in augmented timespec
    beautifier
  perf trace beauty: Validate payload size in augmented sockaddr
    beautifier
  perf trace beauty: Validate payload size in augmented perf_event_open
    beautifier

 tools/perf/builtin-trace.c                | 36 +++++++++++++++++------
 tools/perf/trace/beauty/perf_event_open.c | 19 ++++++++++--
 tools/perf/trace/beauty/sockaddr.c        | 35 ++++++++++++++++++----
 tools/perf/trace/beauty/timespec.c        | 19 ++++++++++--
 4 files changed, 89 insertions(+), 20 deletions(-)


base-commit: 02f6847e1822714a4201b87e42f92b0d43e8549d
-- 
2.55.0

