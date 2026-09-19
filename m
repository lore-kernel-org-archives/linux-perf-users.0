Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022113.outbound.protection.outlook.com [52.101.101.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3727B340;
	Sat, 19 Sep 2026 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779388; cv=fail; b=aEbajrq+yOmRBMoIBFkWteqGaX1GBQM8nN+dNSWmltWAxFWJnAi6ljn068Svtb/GpdrtymkWwyHcahlLkmUu/0HFLoBBGHsNKEpum9e5vO8CN0jnby6pIyihenWWAIsxoa6ubLnmjBNXPYIDYv1eFw2SPXRwMQM4pJeTGLXkhLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779388; c=relaxed/simple;
	bh=jH3qu7d9Mx7cVb1ScVvACgqBRYhx5hgZpsmJx4fnbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uUiGo0a9TwrDcmCGIDA0t17/rH01AmhHYzUJqC5KnGjoC4hx+Il0cKMDQHI9/fUMONavbqG+5Zz/IheG23ULLHPkoxWvtbZAOoR76GUvMCbCqJbf/pDCEHXzkAeaZnLuCo72kCx6bAyo4SXfNbbY5wR6o6n+fVNy+ShPWsrWsXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+eotpsnjrVzDSaFZrqp3xxqvFIbI2Gx59UQnjiJrPQ0kDn2kS7bOxR960Bq6AW1kGQzn4++mSJthDQJcv3H2bCweQ4Lqr6Da5pJQnlJ7GZnwt3vvQyoYxlDZZLEuzGvAXE5Ipl14/hylajx5eMZknCn6igddLCrhm/xuXZGwL5cUmHB3AOAOor+ZlWaMLRvVmZs0CRYfdfuIEBE4v9+zEgxUTODJGvgZVohARHycQ46a4muPhz3N6o4LbanV9ZaAb6xxz84COlOLbr7YKcYvTjFhwn6/lVmHa8QocdnD3oFlu9zXH7sMTfH08Qd++t2wD6f+zo49jBQ/ovORbe5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=50kc43NtRWXrmpy4u4b8XBnRbirG4XW3xv1AkHnPBnA=;
 b=fp5/wwZ964dhW0DCwKvb9gq+dCHBHW1if+5rSgHMbWAfwnIKThJSA3WYcRetwv5biPNzNZczdbiVpfQUk6stVYjaL6/u7+Xy6HxGsZN/z2Ut9ON7EDuCt4SzEj83tKZagYyAAMhDY97Cwf7GgIiwpRYhcPCAsvKUgr1IghJfCbjBIhUggtKV38NBT514KqmPi9pC1TMQLY22oJSW5bsSOi87DUqvkmhXy8GcHUaEGh2MmyZmF8B86N9iNnHSBipMX6MFXL4ibvFm5baZJi0JJmLpO4V973ibw5Rcne7Mzap1GoSvBx09zIP9CpD0jllaSyjL5TmhH456pgNO5rj/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:56 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:56 +0000
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
Subject: [PATCH v3 perf-tools-next 6/7] perf trace beauty: Validate payload size in augmented sockaddr beautifier
Date: Fri, 18 Sep 2026 20:55:29 -0400
Message-ID: <20260919005530.728615-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0956.namprd03.prod.outlook.com
 (2603:10b6:408:108::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: 551a547e-fa41-4c3f-d276-08df15e8c301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CyDoFgccy1tDL6EDb8S+QpsXZbjIH9rZ3HuJmpFRC0K5q76Vqz+Vtq+qyHIPI8rUAXZGIrH+kXX3QFBDq2RTnoKg0Nmode7RpvLBVRL0Sj66B94DaMU4AwSuQ21XT1whiCRn1fbfygRB58D3VdLvxFAsL1u0vilRqiquBb4Y6kCfh+I2uD1+UENzdzlQvlx3RsTM3pkdHScFnQXBeGkqjH6vEwS0wy4pMKXGW0grPevyVJx+HgBoCARtfoQc+NVdCMGOXiWOcb2mUZjDvgqOmGEr7EM1iKp+eVjeGxaY6bq3eJsWvlCKTuWeSfPsjletAdI+jSjFrsdgqy6SvaUigFYMU9jhLXnJukl2Y+4a1687thQu70eaA+5G8jQywTXtRyz4Hdudxq1m6pnNrvgrbPTkTwr8X+uZtUYydN5Yxz6fz7/RqKjt7N0Tug4BVsAj+SD5HH7vobQSAw7jHWPBDNn01wRYhZs5VXttCi9WlBFcLJrM9ZyWkQ11RyvkrP8u+Ig7Z2WFw8Z9t9262cU7dOUusl9oNz/3qwBVM8192haRuYB8/J3mPkjI5n+vSLf9IuT8LnH/jDWPZAnp9WP0VXR+Ctct69Y4DxTTtoY9cvIYBnFvLBLFI7o6yrPlQ4vRN9t+Uw4z/WShZtMY6uyuIj5jZ7ZkNt9WZfLeoyP/NMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X9b+ZIDveOCL+1FRv2eoqspquu8cPeB10HVZIWgTq+LpAwQDVeA31kagIWnJ?=
 =?us-ascii?Q?UBkxXabjhWojCnGidG1XhDaAWSFfy689VMqNWMvLevAgDS6KIUX2ny6TDKoa?=
 =?us-ascii?Q?R2raBPK3odw0BYlIPdZfswSAT9D4CfF67MtzCy5i1n8l9RXrzdQsoI5+0aOH?=
 =?us-ascii?Q?ducuxG4oJJh9QWZe3LHfNpUFI1u8iPF/r6JXXILDGpHxyxHqBipLB+NrrtTo?=
 =?us-ascii?Q?mzLpjCt05dMxHQ9jbiJ1/u2G6JVGKWJuMNO9GekSj/VdyqnRhG2GV27jX6Dq?=
 =?us-ascii?Q?hA7ja8NOkZsC8Z1WLEApVK4v9oM0Ok6Mqyo6BAf4LTcsqwJgJeJBxj/L/gHR?=
 =?us-ascii?Q?1wYkywOusICGuq3cwPlJygu372DrJZ0ud/T7+cGOnBaxy27erQACW7Uht1dO?=
 =?us-ascii?Q?M6mrG59/Q/rmnonQdpN7ADGSK2dgByPsQh64o2KHJiaGehquS+fJEShSXFoz?=
 =?us-ascii?Q?aULrFUHNKiI4N3+aG9RhgPDuZaO8I6SPknH+/RyKpY45rh5HX/TWt2hDvuBl?=
 =?us-ascii?Q?/eWSv/Fj2xBiDDaxBON4B+VuJwJgfJFEQni+ZFLq4cceE1xchqPiar9BFO4S?=
 =?us-ascii?Q?ExE2FzauaTbAiwGsA4gzi9TG8Nk4RNJmolyRa5ki0hyl3iNfJFdooc11yNxg?=
 =?us-ascii?Q?LJZAjYHJNviHXkTp+ep/IvPiw5FBtNKjqo8uCyp9p39NO65PKoxbDGMJKOfB?=
 =?us-ascii?Q?AdlUbHMIN1P8EMipSrBOerwblEW7MMY30nz0qO6VvMtrcqd56nNhCrIR7Wgm?=
 =?us-ascii?Q?ow8coAsiHZ8CYhx9T5LxmDcoEzu9/vjMQlokrcZaaYcnqGmESnq8gFFlIImo?=
 =?us-ascii?Q?iBuvXZv38DuFhrs+7xmVxzURY/2hRNZv7SsUpfQigm6k69jLOefV5ZFvf1ym?=
 =?us-ascii?Q?3AIzfmvpP/9Z43HSJPOtUvNIc2dsn1AZrUaZBgKbhqxwsR8d0cQtXwuxzth5?=
 =?us-ascii?Q?JxDHXE3VPxn9lHIKRwlc7cDILpvaJb16/AMSymvfrFl7qx09uPp6WIq58aKM?=
 =?us-ascii?Q?LQPPaQ12seFt3DZXoAD7VICoi3lU801O0lZqJGx8bDyUhUQC7otJnD1dtWO7?=
 =?us-ascii?Q?ibwXCF29yezDSWQdBB2ClOxxAMuoUsZ9YUJC6yl0vcwk3EA9w3UzwFbnwDEE?=
 =?us-ascii?Q?GMe4vpPhZJsJeXk2JwZWPE/AJggZNqNItX2zoiFia9GkwikFssXqmOoLwjEZ?=
 =?us-ascii?Q?qmnAeSONWX7hgkvW4z9wdxGJscCyR0X6zbgELRhELlFQY8juuS2XcdXej2BO?=
 =?us-ascii?Q?RQwjkO8huTCAFMaxv3VPd7S8r0fZgSn5URk4nLvYYdrbZ8FX6oDtYqq3TPuS?=
 =?us-ascii?Q?1YdQn3HLf66zw6qU9n0jG81k4aUqcBbBvctLOmzv823lblaMEDBPJa9d5iVx?=
 =?us-ascii?Q?+8vF22bDsu2RnuB7Zp/3mFo35PVYLfB4x1vwwrWyiSlvh4Q3CPfiCTmms9ws?=
 =?us-ascii?Q?aXSWlWqD8aMYvD2VB7oV9HvInzsTLbVFL8eLTdcsvsXDnUsgkFoa2l1IvQcx?=
 =?us-ascii?Q?ncjIHnqqIRyjQ/9WLzoKEcTbFtlS8xZg2Le1aERsLEURL/2VqwTT2N8Vmra6?=
 =?us-ascii?Q?7WzKoaHv4jHpqjN8g9+CuZEzqZ6kLw8UOI1vWL9Y/QsEdvmsZpI699ov6lWX?=
 =?us-ascii?Q?i5pRrxeMcU5pTJak6WCPUZiP0eLXtW6LGcXTZmL09sxjsBbFVxTyDhhlYWSE?=
 =?us-ascii?Q?y1FufxRCzFMiixU+BmU1mZwMOA7xA/H0fLZw+XxFWGr7krqmOgyIdyqZBlFM?=
 =?us-ascii?Q?anZuz3eG7g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551a547e-fa41-4c3f-d276-08df15e8c301
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:56.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf2qkCqrG3f/uhA3ILXi9Y7MMapUGeKp76Ph1KaZMtMbGYorJAPgpokpIrfdrKLKKNMypyl6rdC8rI6Ccb3BTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

When pretty-printing augmented sockaddr arguments via
syscall_arg__scnprintf_augmented_sockaddr(), &arg->augmented.args->value
is cast to struct sockaddr without checking whether the captured payload
is large enough to hold the socket address.

If a malformed or truncated perf.data record provides an augmented
payload smaller than sizeof(sa->sa_family), accessing sa->sa_family or
dereferencing family-specific fields (e.g. struct sockaddr_in,
sockaddr_in6, or sockaddr_un) reads memory past the available buffer.

Validate that arg->augmented.size contains at least
sizeof(struct augmented_arg) + sizeof(sa->sa_family) bytes before
accessing sa->sa_family. Associate each address family formatter in
af_scnprintfs with its minimum required payload size, and ensure that the
captured payload contains sufficient bytes before invoking the
family-specific formatter. If validation fails, fall back to printing
the raw pointer value.

Fixes: d5a7e6613b00 ("perf trace augmented_syscalls: Augment connect's 'sockaddr' arg")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/trace/beauty/sockaddr.c | 35 ++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index a17a27ac2a6f..98fdabc99781 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -39,31 +39,48 @@ static size_t af_local__scnprintf(struct sockaddr *sa, char *bf, size_t size)
 	return scnprintf(bf, size, ", path: %s", sun->sun_path);
 }
 
-static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
-	[AF_LOCAL] = af_local__scnprintf,
-	[AF_INET]  = af_inet__scnprintf,
-	[AF_INET6] = af_inet6__scnprintf,
+static const struct af_scnprintf {
+	size_t (*scnprintf)(struct sockaddr *sa, char *bf, size_t size);
+	size_t min_size;
+} af_scnprintfs[] = {
+	[AF_LOCAL] = { af_local__scnprintf, offsetof(struct sockaddr_un, sun_path) + 1 },
+	[AF_INET]  = { af_inet__scnprintf,  sizeof(struct sockaddr_in) },
+	[AF_INET6] = { af_inet6__scnprintf, sizeof(struct sockaddr_in6) },
 };
 
 static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct sockaddr *sa = (struct sockaddr *)&arg->augmented.args->value;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+	size_t payload_size;
+	struct sockaddr *sa;
 	char family[32];
 	size_t printed;
 
+	if (arg->augmented.size < (int)(sizeof(*augmented_arg) + sizeof(sa->sa_family)))
+		return 0;
+
+	sa = (struct sockaddr *)augmented_arg->value;
+	payload_size = arg->augmented.size - sizeof(*augmented_arg);
+
 	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", arg->show_string_prefix, sa->sa_family);
 	printed = scnprintf(bf, size, "{ .family: %s", family);
 
-	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family])
-		printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
+	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family].scnprintf &&
+	    payload_size >= af_scnprintfs[sa->sa_family].min_size)
+		printed += af_scnprintfs[sa->sa_family].scnprintf(sa, bf + printed,
+								  size - printed);
 
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

