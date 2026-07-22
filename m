Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EDB47B438;
	Wed, 22 Jul 2026 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735461; cv=fail; b=pBDLueNIOt1yoP1jBj9dZQhLPM7nLGMIkDXfd7MBkJL1qHKTK+e3Pza3eBRjmpNhoG0xcMHuNef1QdzrPkAI6aktU1OuFy42+E1sr14YBhxVj0iyCRaBMIsYH1VkUoiHFaFhInau9UNoA+TMXlG+bYhqBPh9/AgZ/dpifXTQBHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735461; c=relaxed/simple;
	bh=tJ5PU6rjGVjBMeBx9je1n8Wi1DjMKbu1GllRPiE/Eic=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RdPdaI/IXvbUomkHq/0D11ykbv7JLEYoDlKtJ4oRj3DTEoVzXpCe5KLob3bncLxNCvciW7/SJS8q1+WD0FxsOOI+68MPclJGL2x2Mhq+5n7vgo3mEiMc1kHm1LKTeSPDcy7RsnnNGpAL2AADsScvlooVvvCOEnsFDA5Kqfqln6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LV+CxjrpwOZw1oDaeh/B8k9emQ093Sw8mpW3QUpfOcljYE5tSLuBDs7I5VXga9NhSk8FaKjK6Tx8dq1B/ViiV8086pPh+ZQiyVhbm6egadXt/J6RB9CeNsltLPHc9IUt3rpxC0Bgt++UEnSOWL9URUe68Yzvs/FlVZnkWTfXenIrr1mrdqWqfrvpf9n43yLLm7AUcWvN6B8aM7hqBSMF1EEQq+BCT8KH++BJZ4pppyejTr26H/AWtwTzhHl6s1m15cZodOAFWznlB5YXz8foW/DDBdNmCpVlkE7Fdir0ajFIL4oC9llxqgsznZnRrA9ok5MxjKqI85pSAeEtO3glEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BNadMqQOac1p0tFsZ5RCiJl/g4pMI9TgJTqax64D8AM=;
 b=ObNncxJbZP7Ym9+7OfAYttFfJZlMrYVXORpmytYvGR+Z3Vp6n8jj3FJGvnz2NNZiXYypuSsaYXWXs34Q4+AG2SwIxmaGYEzXJ7m6uQzxcrEkqmDZN9zr7akgAyDmOMbKh8V5O0uVzLX5rUEJpoAYTglgp1b7T2Cg7zeRfCOkHpuytG2+fh6zcu/zM/N2i8Z8eBtucdFhiCIMmpJ4x/DEZITXSasm+L4j3L9b9seVtBvnufTwgGOWfGrcP23dD8PylZQ5gS3oqYbiHcoiCiXMPeFqDqVmERxOyTowVHVDnpVUIsHpl9NIEnPW8I/dxWqINAW/W2FZHX1WcgtclHMS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB7473.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 15:50:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 15:50:54 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] perf trace: Correct cpumask formatting and add --bitmask-list
Date: Wed, 22 Jul 2026 11:50:47 -0400
Message-ID: <20260722155050.503516-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 916f0f45-d053-45fd-3254-08dee8090346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	69er58VN55VZeair71HOYPzYeOuP9gk8jgxncP/1QqBDQgO57ZU1V2n0ocrOJW8hQ11avPTM5JXL04ryL+JBS/2JKWHXJtLeJy/89v0DidAb1QlE4rf5gn4JG9mafURTNNxBSoYx0HbeBfB7jsJhJNvJ5Pb1BX/XHlIjREfI7837UzF33fax6I7P4rSeOCMheoq3vGx6hUFpYimnze1OkUlXoeJklJUruVhlHs5P+H0MRZ7u/qYZ8z+Vo+zHvU6iphPRaRNJ/lAeCRmzBNV+Uh8djNTIeyH7yQtW8AX+AxkftbyyArqk2l6GvTjk9BiyvWcyLvjv2SA8etIwe/Z9Jto4WIRLx0lLjWf9e2XyW+KLyxEbDNU8XJiSRs18sGJhTo5OJsys/v+cerRLHLJ4dmkN/TEA+RH7+v9r1BNsU8lVh7t/Y4GKZxJkjxfMWVUMBob8A9YhPBWqdHMeBea5zhP3Y3jjd+Yz8vMaaShFlA2D31sXRPjynYyrx2IDntgZ5V3bHho9JEcdeXRHq9HlLxVJJ70DGCAT7nvyfoRX7Tgf8H3h/mSYxnZ+qyFCLc2YKYDs7TtMgnCgW08RT15ywEWemWEB4uCAUKw8AreEEyRbMOnwaOw8JPfGy3i+EkZ2p3iPxPd6krAKzFhqu85HA9HMop8BbETBgc4LCnap3aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ot9f0Lsni6kCHcNdJyCCZ9n9J1060PL8imai03RQl5f2o99U5W5gdTjxpW+t?=
 =?us-ascii?Q?I7QT2dN8+nZchRImCp9D68TNL+wEOQsLFeC1SwJ0/KoNG6MXr4077RVb0NDI?=
 =?us-ascii?Q?aDrvNSfkqLgMtTgsWKh2zCMNADffggAQtS83Tqa/hBQM/SDP4StVSB8cv7g/?=
 =?us-ascii?Q?QVPlPUw03V7MINROI8TFpwVCIubf7nS4HTEyyNFQIhdipilQTJHk1GGsXb7z?=
 =?us-ascii?Q?UQzR6eX29r7othsbLm2hiHtxZ/H91+Ci0iwGIO7ZmDp0Cp/dTwPT2ZWk5SAb?=
 =?us-ascii?Q?KlT/elyzQjnTKLGC+ytX5UtG3YYNcuPtahtz2WymsW/gPZ1Ogg5Ew9B9KnCe?=
 =?us-ascii?Q?/Jv+v2ArMaK9sgcQH633VxlhjXAulwEw3Mg82T9EL1m135aR+mNdSOER5/B1?=
 =?us-ascii?Q?ybMXxPXu58+QzPMXQcSPorvLeqOwSkcQ7TVGbj7TNFQXvKBdo6PRvKDoik19?=
 =?us-ascii?Q?cKxDpd0/sY9lXmNvhlJF8FjVHVcaOjq8ztLIW+e/HwhW8/bnv2RhwHpfECLp?=
 =?us-ascii?Q?/L4x7TWa93x80msqnC1UtrUDNnHJWmpjBRBCB2zfslaWjW8kBLp3qb3BIPLk?=
 =?us-ascii?Q?kMwmqOFdDwR57W/uDh+fyvcN7y6pBGzI/DcNfIKbNveP3/pI3DhEy2yMWygJ?=
 =?us-ascii?Q?c/oSalO0p9RqpfkuQ95qaBthdl7TJlL53zo4VloCs2Q2iDq1ZgXQxyXrn+FH?=
 =?us-ascii?Q?ckjXFiOy03qKg89SkXmzDwAavf/xwEoBl0BgyZTnghblVDnyl2a3Gcuzp2Zy?=
 =?us-ascii?Q?qZM9n/F/hZ5lh/rSideCsHJs8PTVZsZlsc1Y/elNzI8vowbxpDJRT8GdKGrb?=
 =?us-ascii?Q?xEkIh/EDi/dXRWa1VtxXz9xPPkkkGDGdVTsB/uQOxv4gjdTVx/QLtXn5N/UE?=
 =?us-ascii?Q?XI9iDebW9SyLNknTH0AklmUHmHOReV1rVQ1Ror6U0QXuOrj1kbRe7buImsVd?=
 =?us-ascii?Q?SaifcIPPtlOO/i1xZvtoDsEb+rWR9JFLEkgEyFD4WrcAbs+YnO6qreyOZ+Zr?=
 =?us-ascii?Q?50e1u8yGZ2PfZVDZ87LtnW7bCy90tWCsg8Y9Z6nBvdaCHE7cjZYm6GEBQXZX?=
 =?us-ascii?Q?llPkIRiAGI+kiWN5/JfzTyvUReAi4zqcymt01YIcA81naiaE6BlZK5SJUikH?=
 =?us-ascii?Q?EIh/7xfbBTMiSXfx0P1IFVyRKptGUoNOsOg0BcQIKeuITp3Ihow56PmOI7ES?=
 =?us-ascii?Q?A0JgXepcU+9wmlUOACGIBJZQLvFMBxUr8rWX8hupKTFAJAa9mHsi2RhO9otk?=
 =?us-ascii?Q?ockSfeZK5YSjyte+acmmqtsQ2ecw2ZiMYQqK6t/jCPwbKyCAwZFDg07Cc6nW?=
 =?us-ascii?Q?R9YS5zTCHF+yNolLt0HPriy08G3bZcGFrma1l10/3jQJ0qFxWE/ybUgK23tz?=
 =?us-ascii?Q?8Lc/zEZVP6YmWqMGgtSVl9a7M0gUjnNT0RYl/seekJ7Q8HPt5HiiMqxl/OMT?=
 =?us-ascii?Q?ub1r+XclMttqRv1jY6ikaQu7Fn4Hx5xa9xGcgWzoFWHq2+6lg0gjjZ0D0xaX?=
 =?us-ascii?Q?mWjL9MPP3PN3ZGdGevTdakhUApLP/i908vZhqGV3/TQC8rceoieirFDrGTUJ?=
 =?us-ascii?Q?C3+GFS4RTnNNhWxXz5FCFKgVbUNuV/o5NK2emgA4C0ZBf1ZFqzHm1xMDuvDT?=
 =?us-ascii?Q?SL4F3VbhJeZgL1s2LDg3CG2gEsQFF5e/Y+RhnmDIv5KuUNc7zay8HGe8+/Fr?=
 =?us-ascii?Q?6xk2+f9DiEndbZb/ltBjcMxsB6CKgTnciLTXGRRMc7yq0oGpNYAiuncbt5aR?=
 =?us-ascii?Q?yzHZcT8N0w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916f0f45-d053-45fd-3254-08dee8090346
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 15:50:54.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xdKBGrE1SYJNikYu0c0NKsDQHBArLYF1fyFjYkB33CzcmRyDOQPxOuVIICY6lZEC8iAQLfgt+xFKUIS3NH2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7473

This series corrects cpumask formatting inside 'perf trace' and introduces
a new command-line option to display these masks as human-readable CPU
lists.
  
Currently, when parsing tracepoints containing 'cpumask_t' fields (which
are represented as dynamic non-array fields in libtraceevent), 'perf trace'
incorrectly interprets and prints the raw length and offset descriptor as a
decimal integer (i.e., "cpumask: 524320") rather than formatting the actual
mask data.
  
The first patch addresses this anomaly by introducing helper functions to
correctly parse and extract raw bits from dynamic fields that do not have
the TEP_FIELD_IS_ARRAY flag set. Once the raw bytes are resolved, 'perf
trace' displays them as a zero-padded hexadecimal string by default.
  
The second patch introduces a '--bitmask-list' option. When specified,
formatting is delegated to bitmap_scnprintf(), allowing the resolved
cpumask to be rendered as a condensed, human-readable list of CPUs
(e.g., "0,2-5,7").

Changes since v3:

 - Added a blank line in the code block for bitmap_byte() to improve
   readability (Namhyung Kim)

 - Refactored the bit iteration loop to use an early break, reducing
   indentation (Namhyung Kim)

 - Linked to v3: https://lore.kernel.org/lkml/20260719001510.398616-1-atomlin@atomlin.com/

Changes since v2:

 - Provided an example output of the newly introduced '--bitmask-list'
   option (Namhyung Kim)

 - Updated the documentation to include the new option (Namhyung Kim)

 - Linked to v2: https://lore.kernel.org/lkml/20260717013544.257768-1-atomlin@atomlin.com/

Changes since v1:

 - Refactored cpumask parsing by moving the dynamic bitmask
   reconstruction logic into a new helper function,
   format_field__get_cpumask()

 - Made bitmask parsing cross-platform, word-size, and endianness-safe

 - Added a new helper function, bitmap_byte() to extract bytes from the
   host-native bitmask in a host-endianness-independent manner,
   simplifying hexadecimal cpumask formatting

 - Cleaned up trace__fprintf_tp_fields() to remove complex inline
   parsing logic

 - Linked to v1: https://lore.kernel.org/lkml/20260714162947.214270-1-atomlin@atomlin.com/


Aaron Tomlin (2):
  perf trace: Correct default cpumask formatting to hexadecimal
  perf trace: Add --bitmask-list command-line option

 tools/perf/Documentation/perf-trace.txt |  4 ++
 tools/perf/builtin-trace.c              | 76 ++++++++++++++++++---
 tools/perf/util/evsel.c                 | 91 +++++++++++++++++++++++++
 tools/perf/util/evsel.h                 |  6 ++
 4 files changed, 168 insertions(+), 9 deletions(-)

-- 
2.54.0

