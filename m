Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF05A2E2DDD;
	Mon,  7 Sep 2026 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745923; cv=fail; b=ZNiLHuL/qP3ZWZGgbVj+MLhJGL0VqUPzriDPboXDt8+DEOfPTW3HIvV+SW5xdkTOZWvTucPq9JvlDykJBAy1ke2ZO8/eNiwkgVK7mrtinkuWD/jfQA9NjnUvO3g3RWFdKVMTxJQcgXNN6n1q9hG/huPc2R26/2fDeOnQEDMZ4Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745923; c=relaxed/simple;
	bh=PYQXaYnf9EGw1HJA3Jv6xzlFH3wFrGMegCEY5iT99V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HhFQbufL7uhslUFLkC4bzDLOnnlx/gABQsgJJO+ZhGquFRBJhlnc8TS2FpaH7kYjg2RgyslvQ1+mhAXE8MBzOFmCgLWZKP2EyolPwcBgLIHSBZM8xDUuFdp7JvBq02ez9U31z6O+9s9XAChGVQTFZqD80RF44oJP6ibgR8blCKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhVlT9WZ+2OMjSPdXmbM27tj/5rrdwa6HTFlzyveA4FolPUd1xu4gpplB4Em+E+8KWlKNOqUk0gqlaJ6mMcLR7mFTbEsi2ZEgKkDES3rjMCkaGQxI3/zONXUj68GA3v+hJMF2l+MRhqEL0LjlLrcg40WdDOTss+AcwYqxSaso5SZjbT+54c8oi+Ygei+45N8t9SENSQvghtmfrKkTuz8qIL7P1JEqjfvaFppD/md5ucxot0mQcNAO6/ezIMQXH1IdVvGZnYQSHCPWSV7PsDLoFikB64VNhRhqkh5kGupFfDo+CIKa6lBq/RLdMRH1jHjEahnZ1wI+6ZrGYoEyuVP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=0fdEjtYpQ27Thv/rlJc92IsGjW0quzSwQCYFYMYBXrU=;
 b=gi5t/UvVmtxgyVSeQWpYI6hN8CdyW5mSFQ2NpQ3jG1L7sw1U5I4x848PQUiRPYWcCifBqUioMsChDEthXdoEk01CTOVsaukpJlaFynt7I9KrelxxY0bTm1yyrFK0qXMAasOCqdawkWVIIw2hZ5oMHdcqXR6M2ykUUQP8ADvLPI14Wn7Q2w0KT4y/XUvmFP9EQQa0ugOQ8klID6939oNM8DZNR+by0q+2T6hRa784zaXNRk4ZYMPoAoNts9FwKp09+ZGPNm77u56KVyQVzT4//NiZ+SzeaxsiBdKUW9R0aqyI1YMhWcH0fe6f4uTkuNTN7Ef/B6MK5R7NoYjX1f/EeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:51:58 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:51:58 +0000
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
Subject: [PATCH v2 perf-tools-next 4/6] perf trace beauty: Validate payload size in augmented timespec beautifier
Date: Sun,  6 Sep 2026 21:51:38 -0400
Message-ID: <20260907015140.363076-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0057.namprd02.prod.outlook.com
 (2603:10b6:408:e5::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 3710a9c6-bec4-4b2b-7fb1-08df0c829a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4sFr9Lr5f8gjQ5haYhbZCjqG3fwnG6M2Y5zUcqM2BHlYEMnWKC/MJoEZfHPRDm21JbB37wningtIHtIfNSklPJnDUkliGgDbD8U7/ET4mjRlUEO/ZXNd/1IlH9lAoNbEpCeLgKv+KcQKPjy5vtx8hYx+KoBrnXVwIBQV1vV4QH4m8PrXaFMEFwx+ou84KMSwg6e4opjKHrYb8HuHfd2OHzrqCQyNXSH7FOfO7jLJMSoM7DktbrP+kmRxNUmz4T2x3ZKMVsE59f/J4UOP7go1mS0MOtP+GHXFSO1qGzMnOSHnzRhtZ20asmmV4buEj0D9y7SHmx17JWGTfDcaULBg77+t37otNnUeLZhx5mqd/uDhAL36UYWswC8hZ1NflZ9RJBf+5RJeltTtqcNK6XKyfQFwV6/JUQ8/mK/XUSU174SQ6mNDNNftlJcZsvqHDAtHfM4+jeKYFOfxmZ00RoP7ae/c9NhuhWOi84f3PGfrXs4Wx29ZHHtk8NmHrBy25o1DHSj0zoj16jZgzKRAymqOBDGqblqd50yXek/k1CMxwFxxgDYUy5cbd+68HS8e5y5Qgf55iqgzv8cnZ63h29Yx2MKRP/7xQODYsst0dtbNiyJUXPflFpE8kdven4RWyweP4iT+3ENHMnlDpKnJKZSmZZ5zclhQRuZpjBPT9v7EhXQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKtd0iqKFOJHa2bQv3/E66phpyLDl8FsOmkMuMdl7B5F44B+H5xgjQCzP4Oe?=
 =?us-ascii?Q?Sd2ESRK4CxE5d6jv6H0OMP5HX4mbx6NQ2vrP0anAtDb0ZlPEQ++EWDhxySU2?=
 =?us-ascii?Q?YrrlfcBCyvlKfZINhWb6oZe7d1duP5HiZ1fqjNJcZjqbiqDZknoFOLZjPhD4?=
 =?us-ascii?Q?prxMbgwZjJhuQ+W/eGhoys4i27eTlmGvgMXfz3Jce8dlas8dq/ys/SnHbudD?=
 =?us-ascii?Q?EblOMGrv0NsuviTHgmC7V809SJq0kqs+6F41C5/EN9fhK8X7PfGWL0ZKMaTB?=
 =?us-ascii?Q?9f1RM39tZ2zDa9fXZiM3db01l9qLJ73ocTgWXb2Byvf7aiUFkKuMdIIImc6x?=
 =?us-ascii?Q?+rVlsEzCj+TS3oQETuhLuOHnmjVOy4Uv+8osW2saK80BVPau811Nq2Pqxm4E?=
 =?us-ascii?Q?5da7Q+xdWfhnB5SFDUIHlkES5aSNoU5+hiM+pAS7Tw0uRFdjE+P5ezMPtPEx?=
 =?us-ascii?Q?tGM7X5rh1yn7OCeac4wsBAxFyoMtyZzzKqxpV8d4fukdmA/GofKQFMq55CZ9?=
 =?us-ascii?Q?AYoWhu6/x0PyeP+wLFfPzFNKmEfgaRpGJ1OLNNbP51GxrIsfZAQ1IONtmrFd?=
 =?us-ascii?Q?TfYs79F9Sqy4lfUwvo+jJvRuXZ/6/VpMSXRUWcClxSXgfbtHxE3TDG1jv5tP?=
 =?us-ascii?Q?Z8GrtmR8TBzcPp58rEhawM6owYxBIyDmTJWIG9drcoQOKkopfweazR6R26OD?=
 =?us-ascii?Q?TPNawhDYzISAVCmUWqngtc1NnFeT4phz1ZS0JQdchHFd/2yZInATPcdt7IWW?=
 =?us-ascii?Q?qV9o+IGHsugxmGcGCmd0CLu9Nwgk1eaDDuGDOupKsTuTGH7gxOfEyomtCiyD?=
 =?us-ascii?Q?jkqknyHbA+I2n5IpfyIbkqV+qtyn8M3uUCvuOABaxCb15S+kc3UxLyt3t4fD?=
 =?us-ascii?Q?aim2QgMW6ScUw8P5ihJk05Pg0UqBuHbSB0F0bpGCp4Uc3yESIhpbF0L6Dpsj?=
 =?us-ascii?Q?KdNiBB6noX/Yta2hFgcVaC4ZpIiHq0ReurzkelT4mCalix1Gfp4OrHF3ki0t?=
 =?us-ascii?Q?6Pe7z3iFn2qgO2Odk64ajftFZtKqlHrxMkguETuhCgSCKvI+XF6hU7RZdIHm?=
 =?us-ascii?Q?yxK6Uo9gGfc43hIsvmOSjBDVHMl/uIX+AYQC/c8uQoismEHLqWsI492I1l8u?=
 =?us-ascii?Q?qrz3gxjvJaqOogEagzoKjoYToKaJatKaOIXa6N9pfx1kRuSyYApaHHM/mPEw?=
 =?us-ascii?Q?82/YqcxiiphsEDWufElHUwfCZrQMzf+721uwXKrU6HWXA9eTpKjL4XQD83/q?=
 =?us-ascii?Q?VFAhV0gRDshA5OboUpUqm3QrULu4tuXRqRK43l0E6BCm1Jotd+gJ4ZG8p9aZ?=
 =?us-ascii?Q?fVE3KWqBxVWFhI2Z+Otv25EwnjrKjreDlUWXWxA+dTE/1nsFlluaacoCIEm/?=
 =?us-ascii?Q?FINGq+FwDwMifSNum+KWoWIKWlAwoU9yced7Nf9OP97/g1ACjs5w7oe3zPv4?=
 =?us-ascii?Q?Cjbn3/dswYSM1+FLDcDf0gAS4IUp+UtG1umUNwZvJCCEKgsSiMykZfk0gIKH?=
 =?us-ascii?Q?DPcwVPr80LQoEbS9ZMva1Ox3Ca+nh2j9kwMXJdrIiIocZoNHkes30dv4REjY?=
 =?us-ascii?Q?UuRcoUM9+cPMVY/IxkwmR+XKSEx6l8yMiDRrdmvJ0kt0hcd0TP4vj+ORVOzX?=
 =?us-ascii?Q?L4bKsHlP6/4T4ueJn6EW3pfvNkn4fFgeJGY8Ry/VpPRCXWpNVweMXGh1vHBp?=
 =?us-ascii?Q?wvTOKxgOhBj8rkVqxwExIrXiG+sliURm7iNIIlhhn8LKAA8tN7fCc5Jcf6Yp?=
 =?us-ascii?Q?7nOIx9dq/A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3710a9c6-bec4-4b2b-7fb1-08df0c829a26
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:51:58.2291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt6SodSsXNG1PPo4OABrnvw70/ZOA5wvMe19RpaM/wlqa7/VUPORmkL3YuExahLlbkEzD9bJ5pFaHE/4cEIrvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing augmented timespec arguments via
syscall_arg__scnprintf_augmented_timespec(), arg->augmented.args->value
is cast to struct timespec without verifying that the captured payload
is large enough to hold the structure.

If a malformed or truncated perf.data record provides an augmented
payload smaller than sizeof(struct timespec), accessing ts->tv_sec or
ts->tv_nsec reads memory past the end of the available buffer.

Validate that arg->augmented.size is at least sizeof(struct augmented_arg)
and that augmented_arg->size is at least sizeof(struct timespec) while
remaining within the available buffer. If validation fails, fall back to
printing the raw pointer value.

Fixes: 6ac73820993c ("perf trace: Add augmenter for clock_gettime's rqtp timespec arg")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/trace/beauty/timespec.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty/timespec.c
index b14ab72a2738..fad503bd953a 100644
--- a/tools/perf/trace/beauty/timespec.c
+++ b/tools/perf/trace/beauty/timespec.c
@@ -7,15 +7,28 @@
 
 static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct timespec *ts = (struct timespec *)arg->augmented.args->value;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct timespec *ts;
 
+	if (arg->augmented.size < (int)sizeof(*augmented_arg))
+		return 0;
+
+	if (augmented_arg->size < (int)sizeof(*ts) ||
+	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return 0;
+
+	ts = (struct timespec *)augmented_arg->value;
 	return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" PRIu64 " }", ts->tv_sec, ts->tv_nsec);
 }
 
 size_t syscall_arg__scnprintf_timespec(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
-		return syscall_arg__scnprintf_augmented_timespec(arg, bf, size);
+	if (arg->augmented.args) {
+		size_t printed = syscall_arg__scnprintf_augmented_timespec(arg, bf, size);
+
+		if (printed)
+			return printed;
+	}
 
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
-- 
2.55.0

