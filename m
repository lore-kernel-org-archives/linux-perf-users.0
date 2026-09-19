Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C7377AB3;
	Sat, 19 Sep 2026 00:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779355; cv=fail; b=DyxKYcFQOTWmmyNJ+/RR2Go5FuJXwy0WFFK4z3q6xtf8z7k6FsFPjjkjy/gPwLafgkLcwL1fa3583X22mu+wHfyGyoWdyx/9+NCbSVCfNEXh44F9yQTm1E1hfGSgsuWoKYBTVm4mhihvHdM7wdGnnFScJ6jM+pamY/DCQOSVWkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779355; c=relaxed/simple;
	bh=ZpnpghZ0z524mR0DKZs2zFnsVNI0s4Sm6Xpdy7qOwao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qc0vym55G76ms5Ye+wVqMV5AIrwWtEFLNM1RwIivrl9+bsngJZfnPAjzMkoNZBZSavyylDR2PpZoq3HYLC6RuRO18vjXYf6hi/IpE2r3ChGiqn8z0NRgpIE816OVzPre0mkdVNRLApEgVqRNXKdGRP906lLmULPpf6PqRE8vHFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL2TpNSuL3SlX6cuBFKTR7WPgAFWBFUN6VAUD8MRPLPD5yqgMX0P31/oqKhOF/Q7XDlMpghbMnouBq92DDJ0y7JTtH2Rvlp2URAs8lFNAh6twd5oEYDqJ/R53MUm4c7N38YD+52PK71PeVJxOl1AB1lNc6q8jASlLX8BGFa1JpU5oBeA9DPZXsdm9unWHfMiM+K/5lcouzoGKbuSNPgN7v8EATRvwjQtcxpH5edf25J3r15lHr3llEyAAM6EZSEbYfhdDDkUOJbCnLR8CcepVhk04Cn3OR5wskKz26z4w6YClR7NvgRIH2mIiUM5rs/nLbXIy9yq9zWTrZQiTg30FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=u8N9PIlQkD1JtlRBzMDFvp9S8jRdFuxaB5wRbbyP+yI=;
 b=TUMuJ1MXENwgML8tOVrQWDWMeY4U95wOHquF6bS5IJDYIGQ5tudSThKPxQ0fnZ3VjXs71OtzjGspqXzLoq3kbD296Ehn9Hqse1s4AmTmi1C3VgRhHVFxWnLSIP0x+2wy07ObWT0DYhTeROoAQcfU4lAqOhfRy4XLjUQM1FDXpMaVpOJes4AOjNfYRNaN3swmnf1hr4Gt49cpR8Lr+qlZIhBET87s6PDTx3qK/73LR0/50H5lRF77AtYmfNaVtFFr8q3HvBXsMNvEVUn8GK1O2n5R9n6ndshGOBRV40AG3mO9rA5Fd79brbEuXaLdAnjcOqf9UIJB+30sJj6uYJ+stg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB2769.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 00:55:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Sat, 19 Sep 2026
 00:55:37 +0000
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
Subject: [PATCH v3 perf-tools-next 1/7] perf trace: Add upper bound checks for augmented BTF struct printing
Date: Fri, 18 Sep 2026 20:55:24 -0400
Message-ID: <20260919005530.728615-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919005530.728615-1-atomlin@atomlin.com>
References: <20260919005530.728615-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:408:f9::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB2769:EE_
X-MS-Office365-Filtering-Correlation-Id: db5e5c77-8e83-4053-1280-08df15e8b80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uisjBZ7DHg8qmbr1V+b9OR7QfjT0DHUAyo45hs+CcVzbbGamES6BoiNs2Tkl+RwFyqbLlUzGolljmDdbX62xengNkf5ELgVapW3/FYKu8y56kaQWPM0um+RhMKFzgA2M6Em9Gb3uBNi/rL/ntD6qQcjc3EhDBmeHv0XCUaaMgOz+SZpW9LoK2Vs1se5Gx/KCzF3joEiM292A4MqDnQ8kHgrTs1p6SIS7Io6ZyeNy7Z2r6ljBewdET9n7WEad+2H/3bhg9sgSaXC8iCRObxJXUVUKzraCBtyCoVYtZAArwJnCqm6TVV8OnTjV8j6XDV3XnNUP7MajwFcLWqpJlRHkmFDmniKguINJ33PfNEZAoTe+2GVHcrxuVFoROPz7rjkcI+L8ZYjBAOqWiwIlaxojagFAbwbZ4ZRVlew3rb4VlsDtG0oDdmlG+zo6w0Z770/D0f5Xi2DDZ8DRoUYEqzBFVIPAyA2QCF+StfeR6Izue0p5yjhLaxIuWL5nylyAdot8w0teeBN0uIqioAo/R3eos+NvNBW4J3yXSz4yzpFASEe2CDv/Y6KGATG1MtLWY7VJ7Zfrpq00CNM2c1V7R6XJvafStvRyzg+1sVoTqTc+u5qzPRWtU6PmoeOrRNDlpvs9aIl59ByJUgAyYYYfCIqo+x3psxvH9q26tJb4Zg7WoTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HN19nIfgCvCa6RkrkdGW2uYx7d6To9dzrbYMozpALgAnjEEYi8X7MTL7tDUi?=
 =?us-ascii?Q?rHx3tBQK8RpqX0E2+mz/x2vUJsNC8bHezHTHDU6FWkqvLs/mW1xCEbc79gzr?=
 =?us-ascii?Q?jF2YfrDIFpHNRtbbY4Iaxg830T65mj1PWr5bCUANkD/aoiYUwES/Q9ednLsE?=
 =?us-ascii?Q?eGd1tC4mLa2G5DBDcn7+5RXskq665YxZVcftAoLbkdBOyhu4B8/A0xihNhih?=
 =?us-ascii?Q?MDfgG/eR0L28+xjjKDNN9TJmzaZb1zPRxgr6rv8SmFWDMugD5S1jOs09ZDeX?=
 =?us-ascii?Q?mhJvUrJVfW4JHICAIXAXdYQ2ld1IAIIUKV8WgnsCrdMjOktO3VqXH5eaYbr2?=
 =?us-ascii?Q?WutuajEEakws47Xg4vfzc/ScEpkSflLgG35keYx3yoPife3Nw2h4Tf22CF/Q?=
 =?us-ascii?Q?CofPAzXRkpv/9wNzqYnFVSBxydZGOoJDyNX8qn88SnDkGH/yAb7tS3Itrx3c?=
 =?us-ascii?Q?6L+Tl2RVnK5NgR7YEAx8y2Ss0bwxNlZiFveMQIPcSR4dpsUfk+Q199kn0zLD?=
 =?us-ascii?Q?SQ4WdfFmZvsC82549RURByVBd3Qii8sI41A7kQST2MCdj8m1V+DTH63UBzVs?=
 =?us-ascii?Q?yCxVOXwoNQe05mC6bmGRwF/MjNahJxtWEKW+AnTT54+6Wc8WVZGNYy4K+5U8?=
 =?us-ascii?Q?/xOjjdr56mzsFYdoXRU6YEevnAw9PLuNm5WcbLtyI5h9/oW+QhODLs/tjt7i?=
 =?us-ascii?Q?dzrQA6hWPjG/eHJK12cteRMStkOH03B3a3RMTq1U2EOVTjJxN7UbjQnwUnbs?=
 =?us-ascii?Q?KLnAvSGoLy9fIPn9otAyEsD5Y2aplhodfv8G2Yo+ppemYjwu7N5PbDJk9G5v?=
 =?us-ascii?Q?PxmEDHmxPOSteMUJiXTg1htgEuBlHnwrgp6KPGNywoqlaNocQF9FTWNf2iLx?=
 =?us-ascii?Q?cjNKwhndxP7bIh3yjyjpDGubmbRiBYljaxTsi6ZorzxiLVp6betRDVXf5sBM?=
 =?us-ascii?Q?8QLzAb3lheshGkBRi+RBT+ZxlF0E03BmDUdm/PGDD8nP+X+GWhd74tOVvyx+?=
 =?us-ascii?Q?wtc5+hBgy7F4fivi/+A7+312tLX+JU9ZF2UbqRLr+aEQ9FXOH0rdzkfW5Zl7?=
 =?us-ascii?Q?r60BHRrPSgBDkcf+uXvDAFJgkh78mt8WmaBAR98Qo+ZzC0oqiR9L+oh9Ov1L?=
 =?us-ascii?Q?o9i14uQIgDpSaS2YLfplUT1u5oEbNajS53e/dgKGnNjfdbH+qhZFvltq4gb/?=
 =?us-ascii?Q?9iqhjst84MXgOUDOVbaetGV7gpeMdZ+ok5XBAAEvTXxehgxoIT1E3she5GcQ?=
 =?us-ascii?Q?jiGmyvvuVi9Ce4b+cH4i53muX7yueJzfBb1FFwpceu11+fiMcWKbYv0MyrMM?=
 =?us-ascii?Q?mNyPyBLvsRGO590domN1dI3Nm/qZFIRQlU1ZUwy/IRrRgE1/oL+7n6pOJPX7?=
 =?us-ascii?Q?aC0m55YYCJFwia3Ygo//Iqoz/+BBhas9VCaVqjeeVXk2BiFhrCik+LS4ZWho?=
 =?us-ascii?Q?xQ+KUl7iUK/lj73bAMlP7o21nDY6Kqn95nNp9wBeV21kBoaO/iDnwci0cpcF?=
 =?us-ascii?Q?+rSGR0fkPfpYeBMs4LGXIf2vwEIYnNp6Uz1Bo6hjwOC/jL8OlhpvumTKlXZk?=
 =?us-ascii?Q?lHESrR+u+NfQCFtPmfvtmeQAah2AswtYLV5cxLrqkviMZqlNaey4gbhQCYc2?=
 =?us-ascii?Q?jrX24LtUusE1TYC5tOhnfE5v3kbT7oBevzq1/M99rym1eacU0gni3jdd/zIB?=
 =?us-ascii?Q?fDlSQhs8FocHC/WcTmkZOAoDzIDZsJXiqOpJp5pJwUe4KI4Cs5RzajA1qhFf?=
 =?us-ascii?Q?6X1lgSFt0w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5e5c77-8e83-4053-1280-08df15e8b80d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 00:55:37.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAB4Pb7PW6CLjQFgwcfJrrK88YGznUJ2IdyGxqsuwmMelqrha18iDxheuksjFOGgN+sGidIX7HgjH1kfks8bsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2769

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

