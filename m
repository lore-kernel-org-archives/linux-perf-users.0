Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5582E7F3E;
	Mon,  7 Sep 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745929; cv=fail; b=m6/g34OZkkSJHXoMekSO/hVaca6wIKSJhV+lSBEoJCo8yQtU7icCN3xStOzrydEd4xIrnQWy9TXWgErBTUfcpTTmPgMdc5BxNRIKczOr55RicdUhoeYU6+6mFJMeLWzYc8BE7qMr0Ehjt6qrUaW9KMrkw/jVzBMDSwvyZY7UN0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745929; c=relaxed/simple;
	bh=yjYdQ5rDmIE3BqdsC/KePQx6+Z6Y1b6mllvjpv2ifMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHLX5+1FthtSljqEJtsex/gnF3x5f6BW7OQkxx9X2LtC7yyT/PoFJOdccU9C8AXng0KZcBECkeGzYb5kryh/iJLH3bCovPwFj9LNvABIjIq2DwG6t056CbkWXV5Gk26QTPLBoDRxLD8KZ0ppRNB+lkQsEvVA/wacSsM1mfmGieY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6X2i41GnIFT1jxIsRGdHESj5IZaquVi0myXt/ZwgOwLYKqKVxgjWfSI7PufbgkofR50HxGgAaWQtq8IjjOIBr8Ax+hUHFETJc2WjBRX5LBHC5neLzw2+NA3l8F0NH66q8dCxogOw/5opBtus+wjxLdP8VVHaxjYghLN43Le3yJb+XM/ATGAivr89uYWSnaPPMCRwvI0rPoqlSSNpG53aamFrL/q6DZtKwquRdelXbRl1qibRV/lD++J0jcDQ48gcw0JHTmq/tvNvnt20YRM4c6v4WF/wrUAEwiMH9M60JYf8qplU6lBuiMpcvm03CtttvvY1qzKl0bhVEwB5ibRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GpsL4FQW0kQ1tbKtkBn0svhyHb/qQieD8Hoov1EGkMc=;
 b=eyUwD1qv7Avb2iRp7sfiNNMLcZucz5W7r/Q4xsDwKzc3i2xUOl+HlqEnidbnlLHmDMukT7v0YpFvlml0V1s2H8ScDRFQp6m54HN6JTOr1rhlQZzbSPrXn+4yC7Zf88L/aq0QiCUm02MDIf6d65xPIXacP830MxTtDmc+VKJv39ve223CZhx5CtYJubw47p5fK5fyHnbQfi2dmJ62ukIqMR3aOKvYf0AGP4kY8YpKRCygsqUtIfRK2h1+LMyzcAVZiZM/tKrX7XaN+DS/SfHb+Lg6n7yQ3SeZd051BWvWH7wVtf7NJi9qrxhli4ZXWrD2qncI6WtJbm28KufeJ/yw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:52:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:52:06 +0000
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
Subject: [PATCH v2 perf-tools-next 6/6] perf trace beauty: Validate payload size in augmented perf_event_open beautifier
Date: Sun,  6 Sep 2026 21:51:40 -0400
Message-ID: <20260907015140.363076-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:408:e5::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed322a-e8d2-4073-6bc0-08df0c829ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MKvwZEFTO4HnAq0rNApI1ErU6Zi7ROmLYQj6jp5tIfdIltYmlxatAHPe1b+3tPKdytiV26OnxJ2VS9q452/kvrN/oo0k9zT4H+1JnXK5nXHckEET5yS8R25VFAgdn0FQ3JEDVlfnBz3XlMgXBlmChXTxTUZQmN4HjR5GYLNBYQ/I/qkcw75gneVBHkddUmWDofh2MdZ5yWmy4FKIpti+BO1PAcf7vDRDMyPw/lTFRMUpOojdhABRqTFkfYfaZVp0dwcWxNP0IEcifzpt4dONPU4vTgiIWd/Ea5il34mPQ//EkkzbeuE2XiazwCqPf6SfjFf21A4qIN8R9JrfTAGuWcRXrNyHlwBGvHxlP5L+lM6PSNScN50mEyKiIJtZAUlplC2qL8qnnzQKukFxngl+TnUPrBCUcRm0zihLffYvwVA8OXbvf/bpWxqlfln7x1u1Oar5YvRVPwYnbG6OWY5fIlD8F6AW4BTh9gFB/jGZRqhrm7l+1RtbPyrEtpnoAfMB8Y3DZM9evxgwnqMwlHH4fwgVOLQ6mwnQdeVtb3O2pPKPMKboK+tT9RODsFSzN5s3SzYtxrAauSe4MXFSoX2Z6NuXuZpcahVK97jOGU//DklKxyA5E7Z/dF1Dk7VkYHvOFPO8ULX/wvCYgXmxVbNdqh6hC6E71wcXGIRyJWlWumM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8v7kLHO9abapHpgbQ3UcecJsJT4qhGt5AaXNm6lEQnQ4StQpY046bnpxDCS?=
 =?us-ascii?Q?anrZ1lq+09yQFMojgJZdZG9meqimpVinzR3vvMZKGOcFMyl7075Hf1A2VCJb?=
 =?us-ascii?Q?iBIjXh13dL0X5AvQ2LLu7DbbAvf251wt4RGiW/7hqy2cp2RUQL5jLTIIxQ3u?=
 =?us-ascii?Q?UyojCbXbDy7u6kAxJBzuL/0BagEwlVDmQCewhji9j7PYUzPlyhkmcMUx2z4l?=
 =?us-ascii?Q?bRF2VU+H7pzJ8zh8f5n5HS/N7sisLxigvMV4sDydk1jly9O8Jc4fmx8kJE3F?=
 =?us-ascii?Q?IGKBBOWw/LswD4LCkIxG+QW0BaDJq3ISQ7Xwv6cHOuJQR41ms2BvAHMFd+qd?=
 =?us-ascii?Q?MJY2csdfelGeXl+z/ItBkfjGG+X+p30mWU+ZwiSheuSXjFvlNXpYzlK71Ya3?=
 =?us-ascii?Q?rw1Cx+4XiEgIq+pmB9zwOzTHl8bAH11XONrbruqMnlODJNynBUrKCmkinVo9?=
 =?us-ascii?Q?uXuhHKZ5i/+Fm4pMa6EeINtM5t4doxgPCNF3gz2nvRWOmzrDE3GNO0xFkr5L?=
 =?us-ascii?Q?lmKIuUgvOS0j1w6qZiwEhczjVNTD9moi0CT2UUROg7EOy3FiaTmAX0iQjJsY?=
 =?us-ascii?Q?DBuXeXxtD8WyfMO7YfLpGpzVhJyYQ/eM8iyaQS6OJk+XVnaYyCKG/Sf87k5B?=
 =?us-ascii?Q?6aRMDvLm8F8JCrV5DQFrgy8gBHRw+Bk7b6sH9F56CIEPwuq1vIMC011BPm/e?=
 =?us-ascii?Q?XnK8IJYZ7GOdKfG8onxdnhhUUk1ZX/vJpTF11BTfoy1AERZatoCtdIWJzC/n?=
 =?us-ascii?Q?b6kIXkWMfnzVSa8RwtPboewUHZZegsMzQkNd9r/oziMFAgrUZlV8YhxCeuCX?=
 =?us-ascii?Q?g3raA1WSedYqyZHGdRFdNvmUjYO8WMjvsAjcEWHJIBROaCSpQlvlOaaROIVo?=
 =?us-ascii?Q?fvtZltfS2+97/38n+jd89He7POoXRoML+Pfx3Tpzye/QkxDU2guKdab0yF1K?=
 =?us-ascii?Q?mDIs+Uf0Qk1Fmn8qm3Ics4JWUlXmoOFwCqv8opygvHdomJ2IiMpMkxn9s0vm?=
 =?us-ascii?Q?YbVim6lCXVfbdhsNdkzvwtVqp2uUYSfJ1kq+OAXAr6+W0wQSGQhQo4iieuFR?=
 =?us-ascii?Q?LT2QmUoNGsETV8iu2q1EHJoikfYLbLxQQSW8pBKwB06yIBGm77MaJDrYlhTr?=
 =?us-ascii?Q?w798dlTioYljLW0uDRWaThMJFFQ29qAZpGFHGpHCLC9s3HHfUO0kg0Zz3ojN?=
 =?us-ascii?Q?J1UhU9/9gYxt9xAfKj9UC0NksFcmCDKARAmHV6ykhKngk7O+U1GBCZefHXkP?=
 =?us-ascii?Q?rdAdfJBCKsQUSzIDvmkkxzFKCkFpNGlfLoGXLBXUDzC48rnUkD4Pa5o/Irwz?=
 =?us-ascii?Q?JuCYnldaYon9zI8vs0wRND2By8cWnDEtybUB792vAYWoRlR/xRO/bR9bSKIY?=
 =?us-ascii?Q?69mNxqDtyP0krMFtShR+E5pplbMqLUA3k7vb+j0lb9syL/PrbA0aSsjPgyPU?=
 =?us-ascii?Q?Il+Yz4hvaFjqV2olxWvfUpo2ylzCixJPtv6qNUQh5IWqJnCxPcsA8zPLGZAk?=
 =?us-ascii?Q?ybbQH9B4Eq0rNxLOYmB7MqQKwiyBcZ+qci3kU4X2NybvDUn2eijyfKECcD9I?=
 =?us-ascii?Q?+0fzBmQO0HPoutgGZyrR8Hu5zqzkMFyguYb8d7xalfpZla3hQnfOtZOxuC1D?=
 =?us-ascii?Q?T+9jz3oRCixuO+SJEuwUx4prq/1Xkhjo3bn6SJrYqL/SGzP04+DsE7iJzbge?=
 =?us-ascii?Q?fqgR8TES7ig9vN9UZcBs4U0L655U2UIaWITYkPJh2btUjYr5sk0r1/o8GIzq?=
 =?us-ascii?Q?cucFSHFObA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed322a-e8d2-4073-6bc0-08df0c829ec8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:52:05.9850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYO3eIQV63orqNfyD6SlwkN979joCICalRyLJfM0IQGPSF6ZT8sLcbNpuKtFkFO73nGYwGDzTErH76+f5z5bFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing augmented perf_event_attr arguments via
syscall_arg__scnprintf_augmented_perf_event_attr(),
arg->augmented.args->value is cast to struct perf_event_attr and read
without verifying that the captured payload is large enough to contain
at least PERF_ATTR_SIZE_VER0 bytes.

If a malformed or truncated perf.data record provides an augmented
payload smaller than PERF_ATTR_SIZE_VER0, accessing attr->size or
executing memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0) reads memory
past the end of the available buffer.

Validate that arg->augmented.size is at least sizeof(struct augmented_arg)
and that augmented_arg->size is at least PERF_ATTR_SIZE_VER0 while
remaining within the available buffer. If validation fails, fall back to
printing the raw pointer value.

Fixes: a9cd6c676685 ("perf trace: Add BPF augmenter to perf_event_open()'s 'struct perf_event_attr' arg")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/trace/beauty/perf_event_open.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 6315b46bcdf0..846738225abd 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -81,9 +81,18 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
 
 static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct perf_event_attr *attr = (void *)arg->augmented.args->value;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct perf_event_attr *attr;
 	struct perf_event_attr local_attr;
 
+	if (arg->augmented.size < (int)sizeof(*augmented_arg))
+		return 0;
+
+	if (augmented_arg->size < (int)PERF_ATTR_SIZE_VER0 ||
+	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return 0;
+
+	attr = (void *)augmented_arg->value;
 	/*
 	 * augmented_raw_syscalls.bpf.c (shipped with perf) copies
 	 * PERF_ATTR_SIZE_VER0 bytes when the tracee passes size=0,
@@ -107,8 +116,12 @@ static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_ar
 
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

