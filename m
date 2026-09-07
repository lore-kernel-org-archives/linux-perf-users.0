Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13A2E2DDD;
	Mon,  7 Sep 2026 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788745912; cv=fail; b=erQcJ04StZI70WYJePy9v9JNAW/McggSx79Ok30ywfghDMsg9aT+MTDLs5ec0wC4GNQvI1j5W59SwUtpK+UzAqlgLAGufWqUxITXsZaiCj6AkKrDBUCdN+uEYxgpGBKZmjTfzZnCc0da7Wwo1lRT0VYRs3kR+7QFNMJLZ//eGb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788745912; c=relaxed/simple;
	bh=ZpnpghZ0z524mR0DKZs2zFnsVNI0s4Sm6Xpdy7qOwao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RND4NVYYHkUoAc8hey8KHsnWTwmFRyQxrcKlSsFjYfWZA/3nz1wcw+eBgiym0faZCms4K4M1XI6pyq/4i5H/AY8Z8P91i+TFA42u2FG2sOw1W1D2BJPvVj6SvCpQlWTKzfvzH+RY8I4xgipxNr1SvA+j/i1Eg/nbkG/OD3BalV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PT0xClBoAXRh+qdxddYlb4g0xAk09lyr/0O/OAB1ICXuIDxNWC3SNVKshXNIMLznF/OSYO650vbDKZw5fUp1i7RfCKcYRTRGTd5KN0wpg059zRfkUjpBri4VNKtM4tgHpeI8CWv/dnzfbgZrcYzFTpL3ERB9hRrqgTE0AZKzvqwme3U3dBGzvq7ycV4IfpamNgUx2T+atWgNzsGwQcQeJN/O3ZqQOuiM5fEE9A3h1IYkOcPkv4/UeR+VRKzyWe/+5xjcdEUMAo9dhgrZ+OLNDiNutOp6CTEUw5Kbyozkh20/QSHbFitke82BqpHG2tf1Y3CzkHdBHxvHE0N844V6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=u8N9PIlQkD1JtlRBzMDFvp9S8jRdFuxaB5wRbbyP+yI=;
 b=gcS1OnwIZHkM81wSUupOyOMeRNxB1AMIVaCjiSf5VAMWNAVhIouy41/E8mf+oXfxcUuVs3KtUyTn4mVXUIcBZRe8oxBwy6gvYBG7+7Z9gM5IKNiDl4VvlTxPYb+viKwTdo2/Yei5tIH6gfKlGB7AECrNZUgvxfao8aLqXdNuQDBf9Vj3RDyei4lpVbaf3zZTzqStq7ljF99+NLIUnBrQmh3YpBBANK/ekHiuZUXu36sI7E732f1uhXYEcQNelzmR6Pd+ykODsDj4KUQCGUj6S0fzZYuoSodJaqPAKDhWiHG62szOaUNG8I5Lf2HlUtlR/nds1buJ+uJOtRiZqGq5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7403.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 01:51:48 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 01:51:48 +0000
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
Subject: [PATCH v2 perf-tools-next 1/6] perf trace: Add upper bound checks for augmented BTF struct printing
Date: Sun,  6 Sep 2026 21:51:35 -0400
Message-ID: <20260907015140.363076-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907015140.363076-1-atomlin@atomlin.com>
References: <20260907015140.363076-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0736.namprd03.prod.outlook.com
 (2603:10b6:408:110::21) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 6985aac2-d75c-48c2-12af-08df0c82941a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PQpqg3jln+R0uDOSRyVnUX3bJRuKrsL+138B9pjyZN0cnFMyj3IVb+WKNd5f9Y0eYJgNZ4t5DMAzr41COqIb+hWvp7gFxR5HZHIkZgvkCvzLMBv0KiPoJbqVzjbhSQJ/G1L3F9RDl5r61jplfIGcfVrQP6wadxltWrLEdf8juI58pAWRdb2ts3SNmC/f45duqUJ6Cg60ml5VZbRanzCOXFXV98aLHLB1wcgSREUQKD2+AUDpy79kG6cC7+esslHeKhEccTZhDeqjEYk4unb9dh7NBgnASld7+tZwBof7qU8bjNJH523Mzzv1U37KSsjrTRuconr8jFMgqfgvJxZVFCwv5r5ds3Irp4X0XY7LMQfd5yctO22vuQQg7zdySGwNm3oDm4VM6csw5DISllZ87JuMXC1ni17ztxUcJm8xSwPLKZJKhPObm+T46wUMIzrbcBpxWyW8BKrmnBxUImtvU7gz6hONNqJnqxrUGn2M8a94o8xmVzxbenooE6EK5tBZ2lEMFAX/kyhyouj5r46gnybifRO0c+746j9H0V6TMInbRLH5l6mznuvTQ/kxSBH8mQLpFPBDjm3+Gv+/Zze1G2rNXXfO2Jf/dU7uLVPZwrbNor7H7LoNLgo8sF69uqUEZ6CDjpJekGg4nmmDFUzWm2V8zfSr4RcAkxHaevBLvss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+GJfCGSY/YSiJVy8Tr3AAQjomZsOiFOgsGGmlOLiqtoZ7Z6RQfwM7TOriQ03?=
 =?us-ascii?Q?rNgg8TrGg7h9JOChV6+PsVCxshLxRHB9DZn/lPiB0Jx3iuRdxmW9q+JWMB3O?=
 =?us-ascii?Q?Uk1pbyMtRdYCLixtj/timMm0zMR9u2Z3v7F6t3/PH+U+jsdm3VRObP1OaeXh?=
 =?us-ascii?Q?dhpzcLmyC/Fi1rQWfqBlLfIuTvmcGpfc60rA/Co2Qcp8HUMFgJkvEAgD5/nE?=
 =?us-ascii?Q?V7qlFriNbai7sYOKeY06h+hCDbF7ufxsYDT4/DsH7IBUcMcictx63byHCs23?=
 =?us-ascii?Q?kTzEhMMyWqg6uOkvtvt9q2pP43GF09utjkdHUGAdeNYdJCPec6NkGUQcMguw?=
 =?us-ascii?Q?jXuSShiOr0YH0mwoGkUuLNRKzAkxSjBbySsjjRyICud3IEfddeAhmxQe9nuA?=
 =?us-ascii?Q?sUvNMrkDA/0vyX5C6fRN4USTQWu0eYngX6NADcUXeE1RwuuiymdhxM/tPxqm?=
 =?us-ascii?Q?bBUiybvOlnaGo38dRE5SI37rATIsgcjSUdBtBTR2j+hSRcgUoKrgCWybixCr?=
 =?us-ascii?Q?MiZUBfPM+CEcbcjDQi/iLFXBVlsVK6QMMVB3zci1txZizBUxejfUYTxQz2iK?=
 =?us-ascii?Q?gXlHyrcNjWlugIe2yy1mFybYdiim/fHlwmsbaHhhERcxl0ls9wiVrGpmmZQ9?=
 =?us-ascii?Q?4JG9U7puPIzca7wb2eDzds/yIkGxKDMfwq5n8Z7Rj5y4sBCgTYP12mmrlBpG?=
 =?us-ascii?Q?xY9pl8HvB+VbE96SEi2ZL258XW0/sOflvInTAUDZA5UigSZJzVtt4hDwFDKM?=
 =?us-ascii?Q?1wKeEvKRgteXOfV3RNaobdiII6/q+qHLN4wr87WAOTcdV4KjWDR0h4RObmx7?=
 =?us-ascii?Q?jT0qX6isD4o9mO2ti34VybJoEcMfaHApMNpEJA4jtlcGwFh9zSeRqQtcQF4h?=
 =?us-ascii?Q?9fKQbAgj7WI7pvL1LOcZZL6XvIu2Pgl9cIevRUb/76j/+qvLByi7DLwOILUr?=
 =?us-ascii?Q?du7yeMT2NYtgByEHZ1/Rrkcs4bsv+jfk6ASsG6uHZfSSgkFB8cEQdTJsHfwy?=
 =?us-ascii?Q?C8FBMrJ4yaR0CtIazzDFVics3ptE3oYGF+LVS7XVEjTfsogu1mn9IQfVskMP?=
 =?us-ascii?Q?spAGWNMNZWZtdfFlhAF3yrqTEUfGTfY0Yl08IN4x5v6q6BqNh2HNHFshz0J5?=
 =?us-ascii?Q?7b6n0ohMK8BiTeCs5XxI6GJOHl+uo/PfX9aA3ZnTmtvtDTIKlTgM+K3IH9jN?=
 =?us-ascii?Q?0w55EEwa2kdSazEjigCavD9vNBRi2rJzuSwvnMHrL+Ep4r3kh4RpTfta/CKZ?=
 =?us-ascii?Q?RG/uDpfyzLHI5pA1c09GqJoAO/vznJtY+AIAqPViA/KfJcZZZ3HLjo2wv38e?=
 =?us-ascii?Q?M+mtLH7rMsVDsXPneguDmZKOQcR0LAdRlgC4I+lWEklu8Kz4h5tW/ThdLiNV?=
 =?us-ascii?Q?PEqQIOx8Ik2uo30AfrJ8nJRa23528pZy4UGCTcyATT4Kzr3qi/n3lkdlRn9h?=
 =?us-ascii?Q?e95AvIz5nE9WxPUPOlHGVAxjpBlM+tmxJ/3Q5xSoyaaItVEp9c+Vzoyx6IuR?=
 =?us-ascii?Q?BkMAqtNUV6L9aUASmcmjCLP2OQt2Jes6NGx9qtGhdskW1cajOjH85czgwqdJ?=
 =?us-ascii?Q?HzFZZaJ+IUnR7meEuyxRvDqzOkSVR2F+12q47sfnyS8jk77LhUdH1JueByqE?=
 =?us-ascii?Q?JpBvK3THieN7sjc8Q0iihXFgx376z2xJSUbsvQsILALjhyof4RLIdt1/+91V?=
 =?us-ascii?Q?kfc8PLdeqLMGYE54eKCbDNqrf+xDndft3lTACjF4c1qPchLo6BebAzvaCIEa?=
 =?us-ascii?Q?t8Mx3jp8Mg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6985aac2-d75c-48c2-12af-08df0c82941a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 01:51:48.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUoelcRJ/9t6mhwVmZUDhttgX23JZgrPRF8VFI769rh3h6Qtd6HqFjGW0pto9iYY9xyEdzAbycPtHcDFSnDZYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7403

When pretty-printing augmented struct payloads using BTF via
btf_struct_scnprintf(), augmented_arg->size is currently only validated
against values <= 0.

However, several edge cases can result in size mismatches or buffer
over-reads:
    1.  If arg->augmented.size is smaller than sizeof(*augmented_arg),
        dereferencing augmented_arg->size reads past the available
        buffer.

    2.  If augmented_arg->size exceeds arg->augmented.size -
        sizeof(*augmented_arg), calculating consumed =
        sizeof(*augmented_arg) + augmented_arg->size can overflow signed
        integer limits (e.g., with crafted INT_MAX values in an
        untrusted perf.data file) or cause arg->augmented.size to
        underflow. This advances arg->augmented.args out of bounds,
        corrupting the parsing state for subsequent arguments in
        multi-argument syscalls.

    3.  If the captured payload is truncated (e.g., short reads in BPF,
        or during cross-architecture analysis such as replaying a 32-bit
        perf.data on a 64-bit host where host BTF type->size exceeds the
        32-bit target payload), passing type->size to
        btf_dump__dump_type_data() causes libbpf to read past the end of
        the payload buffer.

Enforce an upper bound on augmented_arg->size against the remaining
buffer (arg->augmented.size - sizeof(*augmented_arg)) and verify that the
captured payload contains at least type->size bytes before passing it to
btf_dump__dump_type_data().

Fixes: cb32035214b9 ("perf trace: Pretty print struct data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index be19d70eba09..20fffc24507b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1133,12 +1133,13 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 	LIBBPF_OPTS(btf_dump_opts, dump_opts);
 	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
 
-	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size <= 0 ||
+	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
 	    arg->fmt == NULL || !arg->fmt->from_user)
 		return 0;
 
 	augmented_arg = arg->augmented.args;
-	if (augmented_arg->size <= 0)
+	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
+	    (size_t)augmented_arg->size < type->size)
 		return 0;
 
 	dump_data_opts.compact	  = true;
-- 
2.55.0

