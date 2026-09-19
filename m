Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7169379C24;
	Sat, 19 Sep 2026 00:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779392; cv=fail; b=GSqxwghuVxByg/npyZaVJd4A7J9GtL4fis22icAHW4az9NiIQ6aT4dBEs2e+IMCdx2NcFSndYy73rWcVC74SX2PgByJ6htCMaT+Db9P5MlvqxmfTAuPBwYCojjA+lFSAoz+6oC3J/RF4NYVnIuZApCiy7RJskGRQ03Ko2nnZpt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779392; c=relaxed/simple;
	bh=JyUe/cdWvtx932N7URigtThCoVHDuEQQD3jM8HoCjto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnPy4qrMxUZlMIMfl8mPnp33p8cZt968sP8XPqLYHtlXEnWzQOocbD2oupZ64fGOO5bjFX3KyWiYs0Rg1xIjr1CDymPUM7DnhW0YyQT+ehUbv9004escpkYuPRlGFnSiKRz4ueBzzbqIW19zBkp+BDnrkWtiE9Nobwk5UtazH4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4OmC9LKbrNzk5ZlYc4xrFDo2x7VgUHuKW3HrRQowr1xL4DaiExK4LJqxeQCPRatzrPc/NpuFPqLwQA83xQbQorzEICZoCFuM5mN2fSeqvePNJcASZtzlpOPRDG5qBRW7NhFBVJCkQ19Z4Cp0yPJVuUDNDsvL4gnogxkVyz5NG+Sy/rswqeCbk+8u1VnbIil2JCh1iVv+7dVkGqb4O7XP4J6lkVvXhJRYKIciQ4KAE9pgBms8K5lik0Q3EDSlE9swaH7WqYcZjWp0pDGHPtyoLktV4BjnF8+As1I4zahSj4Vyik9hwnM6Jn1IxkTtwqajA2kVWk4WgDaim/liuQlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=RR5oXheggDIpsmaDMDkko1nkDJoyPp2gocpNBXOybJw=;
 b=NZNJe/Dase2uDtlz7nuWRWtG8S523/AsEbUdwfDzpoBFDLPcgoNBaavzD1IEkE11YDvZn0z3EZ+xVBnnNFHtCIfviC1gqAVe2982x6ECcHbibItwlZBUHcpjiCLLqWxp/Ix2Li+yOfEFCdyHKJ/SiqP/JufAYVbg8c4j/H+U4UjBCQDkbqeApGnqhFUR1knB1PdQSIMpbRChLR6VvF72WfPbGJBulVX4QG2+L0sg1dLe/5YhUOGzvh8u7Di7ZBB89dKn+NYWMrAvLWx9zonMEae173DMn5CaNn4+N082pg3NPwJfmPP/0IpQIDQMcHdLm0JtIJhNGwyBpBAzlJqivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:59 +0000
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
Subject: [PATCH v3 perf-tools-next 7/7] perf trace beauty: Validate payload size in augmented perf_event_open beautifier
Date: Fri, 18 Sep 2026 20:55:30 -0400
Message-ID: <20260919005530.728615-8-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0661.namprd03.prod.outlook.com
 (2603:10b6:408:10e::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8ce5d7-307d-4d58-695d-08df15e8c515
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HQFFFk3zz4l7wxQd+m5XtG66uYm+ymt/ZFfj/qjPvwttHZrinCZmeG/gq897vqgkB+qi9RnjiQIOe/1g7v2WJwNfxyXwwjvVPAQZNOqHjSgkN2sbVvjK/ojNprg9zudbh8/yzkAL/mpDPZVi1vludYE7EolWX/7+arHpDTjWBppJQRBSPgtOc0xOvQZ60oLMsc8eHOojJci2467z/b/+lv+RfikpODb+ERJHf1qLQCfR8oLoRJfe1PAlcnXEdNT3wMUoA3m+Ll2GZf0SZg72Z7NaW5hSKJbvPtlzzHbxwqA9BCk/SB+OoU7F+bmFjQb3SqfMIet0rxQMsTzaLsIPz2evLiZUdqw9htvBHmYAFOe4lYMtTwCTi+e8e7UNlzHueyRHYzEIMg8Uz1TKa8fTe61v314treC+dM6pp2F5Bu/AdV73F1sMVOoAbcdwCwvlc6946BjZJjXZVKR0hj0X347T6Euoe1MsI9u8Boo2TO798qbifakphaY38vtF9MpVURhpwROWLVpLxKZM2zGHaV/NsMMLkHNg6WHKv5OvUSlHsQA0Pg8rCZ7Oaxk6i8+AikEAY7zFF4z5tGzyzemK0fZ3VhFZtoU7r+T6uvl7E5YeFEj6xyE1DRsTAYxlbcc/XoyrXmI8sinli1b+TdDI6unMv1PRj3pifXtpZW+2ZrY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gWVoZ3RGD/5CANwA7ii+nDz7zp+ltFAfUDAHVWTpUeL8Na9KStLokeio8CsL?=
 =?us-ascii?Q?qg0OfHmXNIWeO3FYsQLwrMvjc9dfzhRZtciNnyF4txcgEdfOHS3K7na90XOF?=
 =?us-ascii?Q?ZxkOr5bxXAVdHJLdielzBPUTewPIrM+FjW7F5Og3hzp1Aaa9DbqIwg5swTeN?=
 =?us-ascii?Q?VUmzEeRJCRjq92hUdMvN0uRpy3SZbC1L/FD11XG9tZaK2SaegmVEMwmCPQFU?=
 =?us-ascii?Q?fAZJ0g4idoKKU5k9sZ5GTnxkkc3gnfxsIAKSwN0cJLqgU7fA9s1L8WbCarZL?=
 =?us-ascii?Q?8zsR5aDKVpkBLtPU8CfG43/KufDAeUO3ThiEztKZg9q5LuYn/L4gADwywmop?=
 =?us-ascii?Q?BzACCqcRh84ak92W4fLsXiMQ5M+LRTea5OoBsJa5MJ0VzIHl7RcNDRsAHRPw?=
 =?us-ascii?Q?kWaphmZ2ChXxP5b9urzEzrWNvFW1azTTzFrqncygHaQZ7D4CdHkGVfwtemUF?=
 =?us-ascii?Q?nmWjuc5GnvTt7FC//k4rpqsq6a8KwQEhoU6SJ2fZ+cvQfHeVZr2t3K70M/9J?=
 =?us-ascii?Q?c40h9Hrqar1Q6jZJQzFq1m9dVqDYuN3glQS4Pei3V9k0I9Dq3UPa7B6xn9kB?=
 =?us-ascii?Q?tYRhkIB7i57tSSIz1kUMBKL3D6hDS24xrakpO6BmjLb3/W3IzOHDrt7Egh63?=
 =?us-ascii?Q?Jh/9CyTq+CR83yfnAUAGK/siCRk+TPxlceou4HzZx4hi0gWmPVqEkyimH7pc?=
 =?us-ascii?Q?OtzIxuMfduC9SU+zHQ+vaXrTJX43wvjynjqdE1Ep12O1i71+y6yhqr1TfrCd?=
 =?us-ascii?Q?U2VeR3NM5Sv84lKsdHU8OzAlL8ayeHKkTGE/d9/h33yMxi1YMjKeWBFm0ine?=
 =?us-ascii?Q?3w1tfTGTtngW5thdMXpjRX0wK61Bs6x4D20APAXADG1is4sZIwaJ2CYvTBc4?=
 =?us-ascii?Q?b6NmbjIfEXJqvUuKJ37URg33wk5EsJBJ03tu1n2opv+qBNFgyAN3huo16DD0?=
 =?us-ascii?Q?CKDldA3t+c8Vl7L2Nchd3SuGGVprtf3itsA046bZOpmkwDHceSUBfEH8oAU4?=
 =?us-ascii?Q?YGnWwPuvw3do88dvMwJ+9VGRggYwO9qpZXnFZma6G3pfZDGK6RnVZS0SA7tG?=
 =?us-ascii?Q?WXylKviaaXWGtcgxJ7Vjf1BFKvqOjwk88M08tSzvihk0X7GqA2/YpBX6FVNQ?=
 =?us-ascii?Q?euDs/C/6i42KH68PZmynurODRuFAMR/VqAKvU6pl3cQKRcsbCR88516ujW4V?=
 =?us-ascii?Q?HNoITw+XjvN65Ccuhvn+10HebjVGOSLnoKM33orYVVu6LsTtSU1gBZGtWrHb?=
 =?us-ascii?Q?bIaCEcinCqEb/CT9l0ae/TYq4b09JRTRbYewysyuf0bpQRipe45qQNZFZQFQ?=
 =?us-ascii?Q?uSni/ZJwg+F/U5P9qzG56sIB4XCGpfYiEXLVA6/XZdG46Llya9k07yuV0E9M?=
 =?us-ascii?Q?6ZIkD3s8UFhbLqWmVlKzRlFv391rUwoK8esiFOkPHbMIwpZNJqdulf08uaSe?=
 =?us-ascii?Q?o6trePKWr/jRFweixX26TCq45R1YD3B0mRmzXS+f+5qWnvQ9JMDuMGcwOslz?=
 =?us-ascii?Q?Ikni4M+uc3Khy6tsBxIpc9rgPvAByN3frAnEvbVsA42w0xNU0jb0PDzV+PGg?=
 =?us-ascii?Q?2SiPdI7PeCxpAOP5Xtd4bAeXeJ1UqwS5bWdRC6sz2kwYNyTu1QBBeioVqMiO?=
 =?us-ascii?Q?FwW3tICQLbs8HPcl+ZMDXExZlynb3bmXJmjKuig6mB35p80j9jHhyXVAumws?=
 =?us-ascii?Q?oDuyurUdQ0iNYsexbwUgr1rDpTfktFLEDHLWgI7YEwaICyfZLaSeOLGG/A7U?=
 =?us-ascii?Q?2nXzidtX7Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8ce5d7-307d-4d58-695d-08df15e8c515
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:59.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a07m34zq/N3DYDHsHKYK0YsbyYdVB2pJcI5l3s9M2c7yoNtNUY4SCJDxgwfe8GzR2LeZ1ZI/T22FxO6b2sSMYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing augmented perf_event_attr arguments via
syscall_arg__scnprintf_augmented_perf_event_attr(),
arg->augmented.args->value is cast to struct perf_event_attr and read
without verifying that the captured payload is large enough to contain
at least PERF_ATTR_SIZE_VER0 bytes.

If a malformed or truncated perf.data record provides an augmented
payload smaller than PERF_ATTR_SIZE_VER0, accessing attr->size or
executing memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0) reads memory
past the end of the available buffer. Furthermore, when attr->size is
specified, accessing fields up to attr->size without verifying that
the captured payload contains at least that many bytes risks out-of-bounds
reads.

Validate that arg->augmented.size is at least
sizeof(struct augmented_arg) + PERF_ATTR_SIZE_VER0. If attr->size is
non-zero, verify that it is at least PERF_ATTR_SIZE_VER0 and that the
captured payload contains sufficient bytes before proceeding with
pretty-printing. If validation fails, fall back to printing the raw
pointer value.

Fixes: a9cd6c676685 ("perf trace: Add BPF augmenter to perf_event_open()'s 'struct perf_event_attr' arg")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/trace/beauty/perf_event_open.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 6315b46bcdf0..92f84472e7fd 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -81,8 +81,16 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
 
 static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct perf_event_attr *attr = (void *)arg->augmented.args->value;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct perf_event_attr *attr;
 	struct perf_event_attr local_attr;
+	size_t payload_size;
+
+	if (arg->augmented.size < (int)(sizeof(*augmented_arg) + PERF_ATTR_SIZE_VER0))
+		return 0;
+
+	attr = (void *)augmented_arg->value;
+	payload_size = arg->augmented.size - sizeof(*augmented_arg);
 
 	/*
 	 * augmented_raw_syscalls.bpf.c (shipped with perf) copies
@@ -93,7 +101,10 @@ static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_ar
 	 * without writing to the potentially read-only augmented
 	 * args buffer.
 	 */
-	if (!attr->size) {
+	if (attr->size) {
+		if (attr->size < PERF_ATTR_SIZE_VER0 || payload_size < attr->size)
+			return 0;
+	} else {
 		memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0);
 		memset((void *)&local_attr + PERF_ATTR_SIZE_VER0, 0,
 		       sizeof(local_attr) - PERF_ATTR_SIZE_VER0);
@@ -107,8 +118,12 @@ static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_ar
 
 size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
-		return syscall_arg__scnprintf_augmented_perf_event_attr(arg, bf, size);
+	if (arg->augmented.args) {
+		size_t printed = syscall_arg__scnprintf_augmented_perf_event_attr(arg, bf, size);
+
+		if (printed)
+			return printed;
+	}
 
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
-- 
2.55.0

