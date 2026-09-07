Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E282F3614;
	Mon,  7 Sep 2026 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745926; cv=fail; b=f8W07TlXDISnrzYH551nR6GFX8JAZyMAPIdgO9IfaCc8SuXXsKfbZKBARG4Ol9VlXkKYbl8RAynjmDbHhJ48kaiRUI5LD77vgRX1cLl8jp4I/uCEbrFkyeaS+GTyHjDz+rQRFHTd2FTqENKxeF94hf32TTi4aieTAhrR3Tn6stE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745926; c=relaxed/simple;
	bh=U8KSIja2UBCU907zkdUIqXz6+I3bx+HWktLYtKi/+vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UNRQrb1E8GjlR1BqUsR3R7Jf2uRL4O0R/anYz4IJoNWlERr8vO8rj8VaBwsx2I7jCf4D/+CMrthKLu8FWnWhGuLhxyu7EymwQv68EWgFe8W296YnDeiM4HU02s8GQ7Zrkf/iyXTVlw76FqWfETyxfowvz4ZYBX1aj8CyFGqowf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxkT51Qwgok2tE5eREQ4L9KcVWqaJrBayYPHw/8MtaOZSeLm7aL11u+/QmZSXkk0nLOwV1deozGqk43+srMqn6SOqWJ8PMLzoAzlglh92MdHVXzIhZzInsr7mRMfOhVCAMYI3IRDJTvVx/Mrt0Yht5bnb6JUAS3GTEIai/asb3WwDlMi4yMdZeD9GIZpcO5DTaVDAQlF0G2r6VBA7Giit1nRtZ8487SyN6bZ3KgetnxMULuDsTciNoR/WOhRk6wtmiJw94pZ78mMuHmt1fphIQqtEwikH6pCNC2G+u/0dgSCxlzVwQxJAkwhGJ+8WeDeBfY9dxIq8yrFcSe8JXEFKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=jcgkStY4dczj06TSKc8pO2Hev1gEEbX35EjxVf1fh4M=;
 b=vd/TYM6H5swppASgJBUO4+AD1KmXgZ3OpJ5GZC8nAzMRrU2OQtX+qgM3R4BrANDZneSXjEWAE8kFZv4pBy5pEUssxDj+rPjGw2/u0LcPjqldn9feJWG0LRnWUguui4ZcBe1oqlQA/BUIvUUrmPk9SWPd/bv1SyoyUjeRiGUF4sthArTz3gO99Vf8HHVnQDFYKNZml7q1MAFGmdJyVOL+SdQuQeWAM823OLIUnjEcpxzuLmYAUgxorO5YRUhjcobEsHnaBl7vjDT/+HCotcEUNXTl6AaIeb8hAZiydWjS2/JmYZeewSMM+xMRigGIjosJiJXtXkMYUio3bQO2CdjlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:52:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:52:02 +0000
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
Subject: [PATCH v2 perf-tools-next 5/6] perf trace beauty: Validate payload size in augmented sockaddr beautifier
Date: Sun,  6 Sep 2026 21:51:39 -0400
Message-ID: <20260907015140.363076-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:408:e5::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 93560f19-4ba8-4475-54b9-08df0c829c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qCut888iCbKQsVQweP6EQAW2tKy0GUU9dPo4af18hs8RX2Vh4ZEvbuoCnS7mF3tCwX/hX2FDQFS0e5GZepRN7GN7UHMcfSjArB1ojUh/iuxn1feNHGrdRbOFJe4y6Mu5VEZjUNqxu7jGROo52KIciZLJ11HKirvd2yUBb6xnu3eDPyEvya5MsSlABwccVZTXvZpuJ+ILeYNYPUZy0rVnDBYXgEWtZJzEO72FmGZs+OZh7WW0fyeYhfCcdB7THPs/+K6++GMQ9KJMixS8jERbZNgig5exJ4hVf2pkEAS9frNz78+LxA8ZCPnNqlcauovWT0sG+9AUjC0bl64QqBeYIsiUhz0jk8jxKcecOCwiL1nK/u7fCE6HMDI4IqiFY+LU6Q6a2AyAWnS/9EbnC1RA8aLTk04HGdFK+bGLxSTs51JLxBRuhSmCVEsFDs7EJFcevrsm865JHPbK061o35ZVl426MkKj0GCvTNII6woEdzkX4PhwoPxLRi7pZ5fxV80pLuPClFEDFNO636CSvV8eBcv5TqzGzVHMLpUT6g4GuOHtdTaKAJIsimBe1toE5kR/2fwTYpySPhqs9PyMKLkEKT0Lxwqgi2n1t/h1fuWjmceyNjPPvt/rlVD29Mo6nbNbKEaVSeg2zkNeyp8BbHQw03SEqDkHnxxNggdhlElBHbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9WJLQV18ir2eJdUGsPw4xIYhvRO/GGFaZvOGt6bhCw0xGPeLVcf7yE4DLLUs?=
 =?us-ascii?Q?8vpGVWQPypbEaQHr9MZOJBr6liEEUbjhbXaIXrlSzhUDveVlVvhOaglJRzZy?=
 =?us-ascii?Q?q+scKNkf3jDT8ZY3PXHs60gS95pamTrm5EiAN9R2+o5wL+uR3ZiSMeZ+PpVU?=
 =?us-ascii?Q?F9+lRLFnMNBr2I10BxjrwzJEHFcu9xo0iRpdV8xmhlj++LEFvRe4CXDoCr6Y?=
 =?us-ascii?Q?tKbtxehO5GVLWItjooafMdXp5Mf2TQTwaX2BNUIMricxB3kRMolAN0iyMMVa?=
 =?us-ascii?Q?13NCUE4HLwHN6jfe4tSzbWsVLq7UasEaA8qnF56V4edc8hA35ouboqFqlH6n?=
 =?us-ascii?Q?sQqS2tXJfASyAbZVtswVYKMfZwVGnnObqWQWxQnWHYTJrJEHTZ0QZfzonWrT?=
 =?us-ascii?Q?dfGDRGCKndTiABn/IHZXn+hdImh0iiKDK10pwbz/Rsc0CR3ew/WzSry4QLob?=
 =?us-ascii?Q?2ddEuMW0SClYyxjjktNttFubumDerAwdib+NKUpKFlY77UR4Ch/Ae+3tWhj2?=
 =?us-ascii?Q?IxE164PpKwg4+enlCDQ9I+XxQmsVrU2ojBeVpNp1/kjgfmPBL8joVpCUKC5z?=
 =?us-ascii?Q?PSuKnLL+Y17CnO+RB2cVcYRrXr4i+18gr/l304HcfJFARWXzI9Y3TAb34jne?=
 =?us-ascii?Q?pnYAEuFI4yR68bsQX/ojMQxfalbBeFZo6236Q0i7ZBR+YnQ+O6YWkgd5DJUk?=
 =?us-ascii?Q?BfKkjockbdueJV7kx5DYn9EPAnNyLzWeFh/1gXjBuniKdkdM0oKMXEyIbtXj?=
 =?us-ascii?Q?19rtwS2OVPbjmQh19LGAeQh3YwcpJ5GLenu0O1ZEGSEtTOijYgZMoDOIfFOC?=
 =?us-ascii?Q?qIg8gMOWHs5YS/AxB23z+7p8/953ERsilwLRJckxRDS72qjlaTEhy0yjyLqX?=
 =?us-ascii?Q?lfg7cM7nndPDt+uezzYUwQMeKj17sAluL+8R+1yDkAKSvk49qfXYSiD2jGgq?=
 =?us-ascii?Q?W/LLz8b119bN3rinVJvtSXtjQwFGZYU8wYi9JxOM+lUC7fUZ0OGHcVY5eG+8?=
 =?us-ascii?Q?HqFYDP2KUH/mgwpnlmnFhoZn9wGmPvyy8jEIgMZfCHn+KXBzoRzoOT7l5HgI?=
 =?us-ascii?Q?kXgAU3KDZYm0lRrQPrWkPKjUuAWI+d/CmbacEgt0ufiDDkZZi82bsmpn2M8P?=
 =?us-ascii?Q?mAHIn9SyXbcKicc5HoXwPOS+WM7WCvivMnkpo0TcW5FuKQH8BVUxW3CPi+H2?=
 =?us-ascii?Q?7tN+Lqx6AopUZ+7d0BSnXNnE/iDtEG4VVvaB+ABF1fnzmUrJCiNX6+vHpQ69?=
 =?us-ascii?Q?tkrAf36GxhUdNRZ9gW8DLtSroxlMLEpQWpoANuLJSvPDTK68OznrB3tOPsly?=
 =?us-ascii?Q?cie+sZ+2ZBUR6oVbGbVPPelkydXQTwKIaPLdp2YSNN9W2HMJX/UG9ymjQ4+f?=
 =?us-ascii?Q?Tj0SnKyXbPlrrhi8AC4yXFwWPmR2ktzhWetnUYSkSIgHUiP/QcK/fPaolZ0V?=
 =?us-ascii?Q?2P5QgvE8pxZRd+p6AyXJY9Z3JxvrI1Qqqa6a428AqOb2NIarVJwAS57PY7Sg?=
 =?us-ascii?Q?19AfKNqOOfbl/s02lt3kNsdz8awW7HC47NFU9yjd90n4LdyGvgeYw1qs4OdA?=
 =?us-ascii?Q?KJbImel8XNOX+mDTb3vSuBPjcIl8TkYnPK+lkIJLNgFv1HrbqpxteO/GKLeP?=
 =?us-ascii?Q?AeAq6UXYuu6bfg1jx7kPoTGc/GMrFuiNc3kNy0KWw8Ur/vxYLTSMRSQ6TFAq?=
 =?us-ascii?Q?3KLPekCRtV8J9JZXKGWr/Z5LDXAe7uamgx6tTg6ctyQB/fXdT8Two1xWbulc?=
 =?us-ascii?Q?b76ZWFYQyg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93560f19-4ba8-4475-54b9-08df0c829c65
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:52:02.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8W269Ymo3Gu8kYNTFVnMVftoLSURiIcaWwI911WvIH0Qkx663hv4Tuw1avVL48jhGD1dhsxotLVDTLw6uyxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing augmented sockaddr arguments via
syscall_arg__scnprintf_augmented_sockaddr(), &arg->augmented.args->value
is cast to struct sockaddr without checking whether the captured payload
is large enough to hold the socket address.

If a malformed or truncated perf.data record provides an augmented
payload smaller than sizeof(sa->sa_family), accessing sa->sa_family or
dereferencing family-specific fields (e.g., struct sockaddr_in,
sockaddr_in6, or sockaddr_un) reads memory past the available buffer.

Validate that arg->augmented.size is at least sizeof(struct augmented_arg)
and that augmented_arg->size is at least sizeof(sa->sa_family) while
remaining within the available buffer. Furthermore, ensure that the
payload contains sufficient bytes for the given sa->sa_family before
invoking the family-specific formatter. If validation fails, fall back
to printing the raw pointer value.

Fixes: d5a7e6613b00 ("perf trace augmented_syscalls: Augment connect's 'sockaddr' arg")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/trace/beauty/sockaddr.c | 35 +++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index a17a27ac2a6f..00c702ff4465 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -47,23 +47,48 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
 
 static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct sockaddr *sa = (struct sockaddr *)&arg->augmented.args->value;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct sockaddr *sa;
 	char family[32];
 	size_t printed;
 
+	if (arg->augmented.size < (int)sizeof(*augmented_arg))
+		return 0;
+
+	if (augmented_arg->size < (int)sizeof(sa->sa_family) ||
+	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return 0;
+
+	sa = (struct sockaddr *)&augmented_arg->value;
 	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", arg->show_string_prefix, sa->sa_family);
 	printed = scnprintf(bf, size, "{ .family: %s", family);
 
-	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family])
-		printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
+	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family]) {
+		bool valid = false;
+
+		if (sa->sa_family == AF_INET && augmented_arg->size >= (int)sizeof(struct sockaddr_in))
+			valid = true;
+		else if (sa->sa_family == AF_INET6 && augmented_arg->size >= (int)sizeof(struct sockaddr_in6))
+			valid = true;
+		else if (sa->sa_family == AF_LOCAL &&
+			 augmented_arg->size > (int)offsetof(struct sockaddr_un, sun_path))
+			valid = true;
+
+		if (valid)
+			printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
+	}
 
 	return printed + scnprintf(bf + printed, size - printed, " }");
 }
 
 size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
-		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
+	if (arg->augmented.args) {
+		size_t printed = syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
+
+		if (printed)
+			return printed;
+	}
 
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
-- 
2.55.0

