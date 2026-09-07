Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022120.outbound.protection.outlook.com [52.101.101.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487462D73B9;
	Mon,  7 Sep 2026 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745918; cv=fail; b=PBTMJAKBN58aWnkp9K11pZgfty301XQaKy/viTxQ3T/hpicmnMfi2eBGHwcn/hVM53lrt+RbdQxPdf8V5gTfyUMTPu63y12f5Wxj9zJ1e9vm9z47sBJVo7CeyuTB+Dvy271aOU+VLhSXoobHyJjHtZFC6JSR4CpYzQ0L3AE/oyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745918; c=relaxed/simple;
	bh=RGFS2X/KQMHNJkgST3azAycYtBzyxPbtb74WYLTgxCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGgpWdBX2VvaEwkbHafZ/90Q0po6JMaVXzdg8HUSsdQX0hZgVTR2oNfryoZPJ+ZGGoEPf42v5NtYMxe/TwFeJkD4JNmq9X0rk2t72iIc9rGhFMeuaS21SckVQ3e2u8PXmxIGMPd0TKPfaEnCsq/HfLrNQ7OMKIoTyRhbS7twvIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmWxzRAlxo6d70TDPYmiFIHQd0PYAgJs/5ekAZAsqsNPcikDaKsVVSNRwkLFOp7xiOYsaD3ZZrUMEYfe4MYYHnhuIiveLe2UEY+88Qb0LLcpU5FhatY/cDny7pvcAFgJywqD5zLwWtDUEapJZlITK0KvX9nsSvWE8wLG/LEjBKq+uDEw8OBLUI3ocQidD7osSszve3GwYFZo1kJFW76/IgqTkGZZKF4C9SQfgD1PuY7E2TQfhkWZRHULcenJwVz/R2BD+DYVhPsqDG0XX32GMwv6sHlfdAt3/afF8oj1sSbNgS2aMXlOT3vC3G5cZpRIBTSZKU5xCIkaz/l1XuVx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=SwDfJ/hWHypatmSql7kw420SmWri7a4VENtP3/iMWIo=;
 b=tjWo+bb3WL4qnnYxSsXs+nM5tLsFQuwwVWCwztEYA3k9m9ja8kKtBqvcSiavZu8b25z55KXyf6LlU3BmuZterKQ52r8osdhdVnITMWjMaM+OSZG87zYSTbKVO5OJM2Wq6ZayCgqY/z7wbo5l59Gpba9OiPHY4/KEe6GD7Njp9cHH5VJy/kgZL9vcUB4ccicSwm4+ofhPoqEn6NRP7MKLAkcL9wV+5LZY2eipq+jwhgi8/EQ7+OFq0YyOfQhqgn6X1TvkejudTQle/UyqGiMlGs3syc4hlhT1sfklqkdMHqkFVZMVGE7hTzRnA6qRUZNR9DpfqyrEdhcm0HgYBdEycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:51:55 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:51:55 +0000
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
Subject: [PATCH v2 perf-tools-next 3/6] perf trace: Validate payload bounds in augmented buffer beautifier
Date: Sun,  6 Sep 2026 21:51:37 -0400
Message-ID: <20260907015140.363076-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:408:e6::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3594d7-85f4-4eec-6200-08df0c829820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mYbiVN2k/xBucSSegpkGDZyLk/gzEmu78aEolQ0DGn7zlm5UUYLhmEdFL8aAtJNizh4EZbXm7B0YcY59jjzEI3vqwOhA5QkKh0AYgSp9AIF9l+AisX6q1BcC6NB+JOy01pNuZZzTTYhTJKuYhiE1ilAvvoY+FtFwfirDF7b3iPz9Q6mjO8thVwCaiRXPholnI/DPs96YDxk/MmCkAySrnyf+kSwyzoj/HUSzfG4WE3IolVp/fBvLMaLbkTXFY16DkYDgipQqBx1gkwa7mSBSFcdIFmVp8X4ScUEvXo0+LFQh/66uwF3a2ESTT20n5N4gry2OvWkud+ER8CfVyGkK9Qo6tuy+FCo9qdmRNn/yMgKYGFuffkVAXQoX9LlXM3FBQh274kprxbLFFWm3zbVBvuMZBPPwQC4ut1wr8i9vCphdQ2QjTZ0KxLN7IL2NENQ8PCCTiRnYR6ied2CbV+7+FOBjdR+ujvCE2EPCJZD0gRFK67e+MtDlUYIDEiMPrP/mt96ckFJLCieHsxR/8RdRo/DlKqSLj40+7uzJwaZwHqmeP+XMOrSyUEvFdJGfN3L2Lp3S+bpVS2n6iJzWsI4KwcOnl7WShRAh5qM2mAOZbg9cx+dff6+dbMAgDCp4Zj3IpiO/TAFhINWgN+TIf6ur2GWYtJF0SldmSBROGFa9AqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/E46d6Zt7NwBMGYjyc8v4DzbBKlWx7IljbN6hDOqp5x+i2c+3EW+mbnJdVDO?=
 =?us-ascii?Q?CMmEPVKWRyoZB7BlJSISxopYMR5gnYp+iEN3rY4YX9nK1ms5QCjtYiDYmETa?=
 =?us-ascii?Q?ysN4xvNqsyWCkXkLCfVW2VTjPbENHtZ/l8hOu1kXPok5eDa7ACmVnaocdHhm?=
 =?us-ascii?Q?ZsJmvURC5NmM8o21NFmTQaOZFEWEFYzkZ3LZMjpRchIfAVdoCXD/GT+7d8nK?=
 =?us-ascii?Q?ejvtO7vILE8AAWtGrsxnK2hhijyTAqVUL+KjNlUZF0bgPMw4ugEJ7oKgclmP?=
 =?us-ascii?Q?/T1yiQ9AbZoMbmOOxXvTNMqzfUxTifT7c3BaNgJOR/jXnzWiOhjFWQAgxE1/?=
 =?us-ascii?Q?qYDp0D07qJHB+JDyDF7CYIQn96Lt6oIlhreoprlKVYyreV1LNta4yIX1tFeJ?=
 =?us-ascii?Q?vLrqcWB3a2XryvJ3RhqhcFKQ4WMfzD8ziUtxtHmX0jos3dbx1T9ggXI4s5Jx?=
 =?us-ascii?Q?wCVt2TEjyj6PuXgtTH1NWdG+o0dBVk2Ps3hlS7C6ghRjvVRFwUSwwIHaDhNe?=
 =?us-ascii?Q?FZo8Rq4qOMjFQdtt7gpzbL7IYqvYjosCkMwtXVxk89jMHrAxVh1ohqGkabeF?=
 =?us-ascii?Q?lPaVa6omz8sGQAWZMwtP5ER2sUT4KKQp43W4mTwy6qzpMrnV6n0WnvJObbMX?=
 =?us-ascii?Q?twlu/ZS9BzXgPgoxA0TnCkEm5OxoopY41AWD+XV3Qd+/QEEJD1MVT73SfMXU?=
 =?us-ascii?Q?xf81vvpC0WC9U62DLR50ZpYCBbtbDn1kaBCLVq4UAc3fe9rS2u+QklTOAIiF?=
 =?us-ascii?Q?/9QjMDfPRSA57MuQisCRVgn5WX7RFH1ctpb3LVosdkE1ZqVm+8sxnQd2rvr4?=
 =?us-ascii?Q?YGbkg7WuHppDHfLXtTCEea7ILn1Mz9Zzwegc1XlPkerewdJlYVBtnd9jTwOy?=
 =?us-ascii?Q?KcJsi6hC7zhmKkP8Z2tNSeSnk7uh6LBOl4X0QsxdHYZZGYq5UodEX4zaYSRh?=
 =?us-ascii?Q?S8nlQN5QFmgo/QFgwgKcACqBY8kQrUoOOsScjoqPRm2zAYmLpOOKh0bjylHJ?=
 =?us-ascii?Q?mc8UZ/6IV3MB8K0K3M6Ky7xstvGfl6kyNmRyYrOlR0gQ98gTxL6bqQFNMYbc?=
 =?us-ascii?Q?vyntQdhiAI6cuSKUxqOa0BWrMVkIbaqU/k/RrwO8FXTpxnqFi7LIsreqXkff?=
 =?us-ascii?Q?L1oukAncLes66n7rWitwtadllQpRkK32qrLRzw4uS4g4SZ4E5cLSZ0Tcad/1?=
 =?us-ascii?Q?hb0hx1ijOqzf/FJ/vIIxbnIxxMT0qwY47HLUcwYZOU+5/zGQXdmNHEQ6dJwo?=
 =?us-ascii?Q?b1DcfoXbg9wBKp7OmyChXn2xUpqnT1DnCovHMCt+0tIh80dI94TpCmQoJNzP?=
 =?us-ascii?Q?B5tjsexmZjp8DWOgvZG2TfFRR9lc7baS2ekDc+1Ok/DEFl+CxM2yugCe7RRu?=
 =?us-ascii?Q?HelkuI2qppswCrB+3kopB8J7pgFfCry+Xh9dJXQSJHBTfZgufIj5NVx9v/02?=
 =?us-ascii?Q?YQ8u9KMRbmjI/EoXSpuRuegNWIVOmhTlKR5C/VKLnWa+i+tYX34T5Re6Faha?=
 =?us-ascii?Q?tgyVJa+J/PKM+dzUsZMnUqWBIsQ9sFmPuGcAZu6eLOXYiUlC3UXlKiJ11O+X?=
 =?us-ascii?Q?snNxVx/uAAVDJGg+rY9VDLhiap4pJEYNnIouC9JKz338bm7LNt3O9qMcx/6X?=
 =?us-ascii?Q?fDawSdZY/XvlUzM0Q3egJSEd6cgFSOBvg8kO1DmdTyoWgC5f7OiStcsqt6YD?=
 =?us-ascii?Q?9Ui7GStQiSvPLH7HaUjicvIbLH2Nleye1PcdeaKR8P5qKksYipELP7MLjjGR?=
 =?us-ascii?Q?rnieePESSQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3594d7-85f4-4eec-6200-08df0c829820
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:51:54.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT3ZaJTIrrIyL/DXqVChfrO1YhN9N4NAEvZuVxmdMyK5l6CnrCcK38P0rqPfo1oUge8oQVwb86GXxXh1FubZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing non-string augmented buffers via
syscall_arg__scnprintf_buf(), augmented_arg->size is not validated
against the remaining buffer size (arg->augmented.size).

If a malformed or truncated perf.data record provides an invalid or
excessively large augmented_arg->size:
    1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
        dereferencing augmented_arg->size reads past the available
        buffer.

    2.  The loop reads up to augmented_arg->size bytes from
        augmented_arg->value without verifying that they exist within
        the buffer, leading to buffer over-reads.

    3.  Calculating consumed = sizeof(*augmented_arg) +
        augmented_arg->size can overflow signed integer bounds or cause
        arg->augmented.size to underflow, advancing arg->augmented.args
        out of bounds and corrupting the parsing state for subsequent
        arguments in multi-argument syscalls.

Validate that arg->augmented.size is large enough to hold
sizeof(*augmented_arg) and that augmented_arg->size is within the bounds
of the remaining buffer before iterating or calculating consumed bytes.
If validation fails, fall back to printing the raw pointer value.

Fixes: b257fac12f38 ("perf trace: Pretty print buffer data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 91461ab927b6..4277de761a54 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1945,13 +1945,17 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
-	unsigned char *orig = (unsigned char *)augmented_arg->value;
+	unsigned char *orig;
 	size_t printed = 0;
 	int consumed;
 
-	if (augmented_arg == NULL)
-		return 0;
+	if (augmented_arg == NULL || arg->augmented.size < (int)sizeof(*augmented_arg))
+		return scnprintf(bf, size, "%#lx", arg->val);
+
+	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return scnprintf(bf, size, "%#lx", arg->val);
 
+	orig = (unsigned char *)augmented_arg->value;
 	for (int j = 0; j < augmented_arg->size; ++j) {
 		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
 		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
-- 
2.55.0

