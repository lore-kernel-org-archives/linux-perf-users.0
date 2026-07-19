Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020089.outbound.protection.outlook.com [52.101.196.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E92D3A7C;
	Sun, 19 Jul 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784488211; cv=fail; b=Th5Utawr7oQvxD09SrF9H1pWe1a5S5blMtu24CXAAd9Riwdgm6+Anll9C0q1B62fpS7jbuOmzAiW5TcBG2Gomq+dv74JDxMBStiiozaQKcqWCa4w6moktkoC6FCbXKiMMIPz5S6rXHtIVd8rqk8ebr/j7UDNoYiXZ5K7WpehmOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784488211; c=relaxed/simple;
	bh=Umb3/RVpaZp93wjRlomz/x4iShh5Tn16y2S87DojfsY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KmyVm+X4dXBP71WCLHSHpGZIGj1+i8JTh+i+M3/TT4R8EY0shMgLS0Y942WLAAMRyPrlc3vG9GCnR8lU587gXSrbN1ISSqOuDJ0gdqBTNRHZZ6uFaNsPai8hAr5K+XjOSR2FgUCZ9QjhZ4V79ie6/X0fCRG3ERXHaqZq1RMOJdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLLaSUFwq+ztyWa2If8g0/CgJbFpIXa5r7Fbt15NrnAeh+oVaoKWfEfqWXo2Np4XdfXt8l8V/57Ojyn8a0WPjMBGWp2U32dHEIWr0F1kAlkcy8s21fHPGffcfwJEioPlostSokXpO5+TMioYOZq3Ni6zBeZtSG4IuIMNoSu/dEJiTqE/8qIj/X30dgh3J83OJRNvVlq3iv8x9bxW6AojbSXRSRSK+zDlCa683X2yvPbvhF1TEdvF/CAGy8P91WRPOnIh3X8Q3HCZUhccQhmzC+kVqoyhB5DqY2bmhXBmwlPhpYhQ/kbm4YykDyRlE6hUjp1u1iUIcdpZ3aqLJgQCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=FOhEMjWcXZKB2swzbArLWRXr37tFbkaWjUx+HBRvyHM=;
 b=L+pU5PX1t2ZnV7A8dzRy2Ek/RuRSncQkdY+AiIkZExLIGy+XsKXp1h6Dmd9KYbDmlKcFwiKH76PzKdWtEB44nBsm9s5oZcEASuW2PAnISOM82MYOIftPCip3w+S+GgnwU9Ft1BExFObnQ+XqTwuukBvPG1FWpQO0sUFcqL6BNsYxYaH0sxzqTAA1EcGPYI2qrF36e91UhGpnwc0RTitH6GfJTxJu7MleKtvcz7wcuaT6OAd67JTJgfzp/DHoggCJhFfXv1nUuUx9b313hw2WUMCs40hvvRJI5/cPV1V9p6G0A4aP/9GSB+e6gmJyCB1nuqgVTjMaTcvOEccYQ43vSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8395.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:267::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Sun, 19 Jul
 2026 19:10:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 19:10:04 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace: Format instruction pointer fields as hexadecimal
Date: Sun, 19 Jul 2026 15:10:00 -0400
Message-ID: <20260719191000.441985-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:408:ec::8) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8395:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d18bbe5-1129-4ec2-c2a2-08dee5c95720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	JdIr/NzTuzj+yWMwP5SKYrl7o7LdtN/4Pc5uK7rOJLQ4C1KAZGWAQm3IusN4RwxzDv5iuw0GVUWJjHi7RbGXIIv3e+nb7XwjbaBLuHUxJS4kESFeLHrcTgrGa3E58JaZqbu8tGMPsGdvV2LieKoIO3e6MWbhtYCCbaSjoRY80aj6Rb5NZv4ikteS/qiD2pcEWpQKGYwUlMqASiHBQXnMCYjYyVxTnHVeiN9KL3e/ytjruVxrP39d40x9t28ynUaUDiqNWcI7Fl7ay0yEE1+BTz0CgpbHny/rRNPKX8bNzLy8pug6RkZOXdU6OXW4omuEjaVMVKYBE9A8NpR7qQtCuGvQWPNisc612u7gozKilbyAKUiLT7G0t3EanccH7Mc5qq8ti0Iq/mOxxooqdUodoWx6t3ZZSBxg/LvXspo+lT7Mv7adI8RvlbOya4VO5+nfkXzc31Z2kbCZdfQDJlAymW/QFmDEJ5vfIqbNWTflXkCyFyGqfVZQ++nufl/YqW8+ODQMk8Ci4In155b1t0gjs5cfZ5CZOaDWuQuPOZG0LlmNrJqddDoLtdFR1KZoc1m2uAyGD80/GDkn6GY+uUITjKSri8dMwB0Z/Zc9Ke2Yfzr+jfhztylHjyOZFVhSOyGzK5M4xykcYkjAM4ga6F5VlcLucxnRwosjvtHqZjhI+Ys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(3023799007)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WJiojmFcaYIpqn0txWoT5ebJ+KHVUgPbMfwXzHt3/SDI3y+dxmiFHsmactLg?=
 =?us-ascii?Q?QAcgrjWcZdX7EG+FJg4MNyomQgxwiOevL/7kIMiLwS2ocPgA5spDfnJBn99D?=
 =?us-ascii?Q?sQjA+JHxxqgxtUwxqPNw3MXY8lxZl04yMHJ2IcfphACm0gmgrBVJCfQZhgdh?=
 =?us-ascii?Q?BG1oALIWmmLiKskCvsnIeUevjTRAN041bhuW6TJ0jkk2b2G1HlFAa+1lJuWv?=
 =?us-ascii?Q?ApHa/IW9bPSxfyta0yZHZuMZeAhmJMem3LC7eVPuHslzNynFs86ki2ws8Zl3?=
 =?us-ascii?Q?ihWPwS1plpuBBlAulNJbe0La2Xmj/b1to3KDEPBfvEtjdLm8sNxLCtk7R1nt?=
 =?us-ascii?Q?rfl0HjjSDF1m/saAIcs/fzGgm/p6fcjvsDwHoi1VBoFI527ckHK7kpm8UGLh?=
 =?us-ascii?Q?F8alAdMOV32YWeRn+ag6FArWyKiwJhPyUAjN4qB8VICRqy/RYk9UB9woiFZq?=
 =?us-ascii?Q?5RFBEvfUbAGb1bFzUwHVTIAtfMygNeQPFkRm2bgBXdEXA4wZx6H8+jCxGE5/?=
 =?us-ascii?Q?/Z80TubCZ+4fw+DrE6NYy6G+odpOij7eAKzwCzqF0Y4szXVa9i/MOa6U8hmE?=
 =?us-ascii?Q?og34SbLn7wsrTNaKog6GwWRx2GmHUOlU9XDEVGs9qeipnmbIj/xqBPcTcXDF?=
 =?us-ascii?Q?RfXwTYrILCDoiPhVGH8utovJScJhS9LYXDX5HpH66ro5JSTZKwcGigT2nQhq?=
 =?us-ascii?Q?EQ+P6iwsaQlVoxPiezdrngPpxs3jdUgZHm2dSn+pwBob90UbKjFcppuGC0gr?=
 =?us-ascii?Q?VuOWHJxv1XIznU4rc5qfrNezveWrgQLYFrHSR+NG+jOf1QaUPNEP1dE/XjF3?=
 =?us-ascii?Q?gtM0TcHeAyeOgJBHhaUFMklQc9MUBUtcgqwxNtoHCHb5iiMtHK0LuM7EfHcL?=
 =?us-ascii?Q?EVCadIwc6/smD0WxKhGMQpyFOcIlYx3C3pTnHKgNYNn67Sz81lWxQUinRaIT?=
 =?us-ascii?Q?Qjz03xMcLn2zFA6TEg4YGDRRVsLvgAslh73bOHwwnz8diZ+rhgO7jrm3DWI8?=
 =?us-ascii?Q?+PAmAWu5NUZ2SN7s4+5t+b+U5M4PKwN4OsZSXKjtBwaqCvvBaRucumeZwhV7?=
 =?us-ascii?Q?muuGhmNaganKBq4Houyz2DD1HV6GK71ed3nfAbbuaS9cI4kbggn8N8VJ+rq6?=
 =?us-ascii?Q?+/pmvUrZuagaHUJtyprC4kXHhYO3t0bkBkqnquqaH8L4Qq3srVuAyXsxRcws?=
 =?us-ascii?Q?tWBttW57fNJgSpgpQohQHnLsRUIBpK1mYGntvNEIi+Y8NphX9IXt8ymuwlV0?=
 =?us-ascii?Q?3BWqknS5C73pmqgf7/XWKNWagLDzmWyUfaJ5jVvnXk3DyN+4iynCCZyJHDBU?=
 =?us-ascii?Q?6K2liuW/QWaiZoZ8VdOKSYpbCsX4edIMjsB7Fzlmh7Adv2xKp3x/eXHtBV1V?=
 =?us-ascii?Q?07CCvPXyVbbW6j1UY5VmgE9DGdCf73ZWf9hQ/8VeABB9c4SzHGOeAa7xa4JW?=
 =?us-ascii?Q?Q+aqJkU6PwaPUEZTm/ylbxfzeLEuuB2AIOKFEzpfjtQ41Z6cb1bUx7JL3xNf?=
 =?us-ascii?Q?0Dar/8mE3NGgkUQRzAFfvFYrk8T4+Rt2UyQoWyoD3iSkbvOqRy77oXMqDDpE?=
 =?us-ascii?Q?pM7Gt+3hSiTtL5SMndkc5TDdG8CGguZamjVDgU2JEfq7XM1OpCSSAkEtQv3K?=
 =?us-ascii?Q?Juy9KqDDTOGnVfAO8ugZxEyW5Tp7+jrNo5b/s08WWqb9ihm6JLwKvJLF1/FK?=
 =?us-ascii?Q?ZJtC/4PmAj1gMKDriMjgCtKMxXONVF1RtZLFMuIrcYFPnf0bHVEeqYpKO11t?=
 =?us-ascii?Q?ON21j6QYog=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d18bbe5-1129-4ec2-c2a2-08dee5c95720
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 19:10:04.8270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJY9cinvUlBFoJxX+FVWUbix+O3E1tkkB6gh9TEv32MYSUe1q0GmFicUxFZkxuuN/RFuxfv1B8PdJ3rSGKgR0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8395

Provide a helper function trace__field_is_ip() in
trace__fprintf_tp_fields() to ensure that tracepoint fields representing
instruction pointers such as "__probe_ip", "caller_ip", and
"call_site" are always formatted as hexadecimal memory addresses rather
than signed integers.

For example, when running a kmem:kfree tracepoint:

    # perf trace --show-cpu --event kmem:kfree --max-event 1

    Before this change, "call_site" was represented as a signed integer:
      0.000 [003] xfce4-terminal/2201 kmem:kfree(call_site: -1714572588, ptr: 0xffff8afee0303000)

    After this change, "call_site" is correctly represented in hexadecimal:
      0.000 [003] xfce4-terminal/2201 kmem:kfree(call_site: 0xffffffff99cf1194, ptr: 0xffff8afee0303000)

This improves the readability of perf trace output by making code
addresses straightforward to parse and map to kernel symbols.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0142a16830de..207d46d073c1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3223,6 +3223,13 @@ static unsigned char bitmap_byte(const unsigned long *mask, int byte_idx)
 	return b_val;
 }
 
+static bool trace__field_is_ip(const char *name)
+{
+	return !strcmp(name, "__probe_ip") ||
+	       !strcmp(name, "caller_ip") ||
+	       !strcmp(name, "call_site");
+}
+
 static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *sample,
 				       struct thread *thread, void *augmented_args, int augmented_args_size)
 {
@@ -3235,6 +3242,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 	size_t printed = 0, btf_printed;
 	unsigned long val;
 	u8 bit = 1;
+	bool is_probe_ip;
 	struct syscall_arg syscall_arg = {
 		.augmented = {
 			.size = augmented_args_size,
@@ -3322,9 +3330,14 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
 		 * Suppress it by default to avoid cluttering the output.
 		 * If verbose mode is enabled, ensure it is formatted as a
 		 * hexadecimal memory address rather than a signed integer.
+		 *
+		 * caller_ip and call_site are also expected to be instruction
+		 * pointers and should always be represented in hexadecimal.
 		 */
-		if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {
-			if (!verbose)
+		is_probe_ip = evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip");
+
+		if (is_probe_ip || trace__field_is_ip(field->name)) {
+			if (is_probe_ip && !verbose)
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed,

base-commit: ef06fd2704cafbcf04e220f2103ca5488508f13e
-- 
2.54.0

