Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022080.outbound.protection.outlook.com [52.101.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791E2D1911;
	Sat, 25 Jul 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000832; cv=fail; b=Um7UOPGRHLCE3bbpg8qoWixGy3TNuVnxv51U2PMrZlygvJqK7fif/Shfv2K3SLKtAaeOZo+n/btS+xAnkF2mJIW1pnkTLEWDCWvJzDQzaRkrAt3V6ez0LeY/TT5epBj1HtJ6AlR/g9aP3Mq1fWuUCVlX8FVy/KI37SpO6RVmwqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000832; c=relaxed/simple;
	bh=fsD8trp/Rbv4RsONKMfAlNe+8NqB0UtgH5qV1JBN9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kN8nRF352HaCBE7izl8aEweFdg90Gcai1C9ux3rVRXaGR4OVpXU76GUgWQa9KfkIU+zrRIyA2IckwLPcgl+dMplfM/qIlC0eN9A5rGhIdg2IOeeryoZxwGmj6N3+cY30ZjcOjZNjRpKvjido5R4n9Ixr7SxjEcOoLipuF7+mEAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJjEvCyRZlgnf1+eVZqDPDXcd+NE9i5vIkrqA9QKgZXFcEFY5btucItTBrDqQzBdt7T1D+85HXAH3yYjMuboe7M2Ypndt+6z9ui0MiZRXG0juGhsVxUvU9JFYR/T9KKY6f6rNNkZW/Pv+pQISDhdi/M3ifKrqCAd3oJKJDfFPX80N7vlwGXNNCWF33jXI7a/W2nd1nlhWOHraDF7KET6cXhfTK//QvU1bkFGGdEGvc8L9SpTHjzZx+xsdWmMMjl8TU5KCynO/HtDo9D2eP7E8UuEqjMOTQvvLjBxH4Lh/wFd+wHNePhyyMAtyrqR+z+//koInk7ReIyJE+SLQFLsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=IhBvuZUFWWb7OnJe+cEMsioCF5tQujYrAgAnhSIRdn0=;
 b=mlQ5UrlmR0GY8xBhtfc+6UjTFVv6QVokIxG8gZMzSW7LTZXd4nj8RF7V8gYJemz65w39aZ7gpNAeQ3Sue/5BViTM/DqVDNw0197wTVU4J1+7mVAiXnAW0jqctUYiPJLEDo5pGkBMkU4tOZR4DbUiQ7h4omuZRU3ejOY4/LX9ojKa5Bke3VrqdXam5l6/cSQyA/0JymyfnUiwA3kmCywTz57IgUlbFnZkT11dPxko/DE2GJ1lHpImBU4JoTeXjF3vg4sqJbfIuXZ07ZioL35LfK93jDmM0VDBI5RI+07mhmQWLsrwzprMeEbN9scWWEAdEM2i7nZLsdzBavg4ekpdQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6915.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 17:33:46 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 17:33:45 +0000
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
Subject: [PATCH v2 0/3] perf sched latency: Refine outputs, unit scaling, and histogram support
Date: Sat, 25 Jul 2026 13:33:38 -0400
Message-ID: <20260725173341.679782-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0493.namprd03.prod.outlook.com
 (2603:10b6:408:130::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a2b8cc0-d7ff-4e37-5c98-08deea72e115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LXEVJRozmutmjvpyp0O5P7vO6/NENqpv80b/nzyGj3kkmPXoKwWsOjaNxntTQPCp1eVSAhVRHzjOgLKvz2BIWNWK/AC+CQHQMAFYIqIRx9Y20kIT8GTGD2SBeLxdM0XbKqq+lW4Zgqj7zaN8CJAHUgQWlZo51kw9h/R8Zi+W/p46w3IWKsil/vS71kVSWGvB8dkE7XTxK5dUnfMG+FC/ulLfaXORwLJN9QtDusjfgluq6D3x8xrCtaLNOfOFnID0duEM/+54hHT53AzQk6RiR9D7VmjWSdrX0ZCzxUFZ5yEpsP+BmUKKvSoW3y0by7sJLxzVFfCqMMn81uSn9RCHDHiaw3HZq1UXseWeVuRleepxyZhzgH/Hcq389opm1jud50FhhOJ2GGGK25GmxmFVfjfMlSGQ+oLrC5b6WCVXWiYkoaYFHBKJYQq0gmCiHozDaEDslSEIZ7eFMX8MJ8ENQX3Tlj6RKyf9ZZHXOpUWsM9ceNkvKSNaGMT/WtSAXlXANVtI+MYyiQYbDpqJ0oOqL3O9cyNe1XjmglZNCvPgj8kNgLqrNGZaU9ib3MjqYC6amcb1evermmI9Rjx5//jelsrvYONMdBQMIfUAi1AIr8rZzBgyC2ktYycSrOY71bpt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OSF+QDO7gpbLs4HULGf1/vYhzKlVRYXvtBkOSHgDIcQhZku+jv7BAaYGSkCo?=
 =?us-ascii?Q?NfsNmhL6N8vMEAJGYmemo9JbEDVh4dm4VGJf19o3lT/MUQ95wLyR+Iin1CQi?=
 =?us-ascii?Q?z3d37buyNV7g2E7Ukr2AAi6QmdAi5xP+pHZKXphceJUY5uWHEBYjoT3O2obv?=
 =?us-ascii?Q?/KSYPqtUFDOTCTtXBiYQXdFJnrZ64g9wGEsAx6XJXpU6UOe2RbGLZVJWsTGS?=
 =?us-ascii?Q?Vv9n819QhbXfi1IBSlo5xFvilhwSTsElPfh2GEJtQIIB1rxLolrCxOlD+9p4?=
 =?us-ascii?Q?3FQc8eGLiXt78gfqhe6oYBPzScJK/bJroJv2IXhq+HPdzTnH4SqsVMMveQbM?=
 =?us-ascii?Q?9HDIEr1Cz64alDu/vfPyWzrlnCMgiQG3Z/cbWyWzJw8Cd1WRpg4IW8VnGdS/?=
 =?us-ascii?Q?jo+49txoPD5J9rFvpr/AhmQUtGFM0Pt/bWn663ekr/AiAcTJKDgQyHJhYED9?=
 =?us-ascii?Q?o6ZXI1nVLi1WGxfYN0JlQIAHpDmfXZH9qIYJE78ncLLNhN7ME3tIQFIVKwI4?=
 =?us-ascii?Q?u79zInY3vucaro3DXSoKB/jo0wj0h/bYw7+m+ptu86L3yvYko7mKakL5EzJH?=
 =?us-ascii?Q?UUVZ4XntbB4G/yUy3ohh2qNIBa8qUyWVMxQeaOXT/k+UNMwu98BjwCK1D8bR?=
 =?us-ascii?Q?xOTP5KdYOiIVkj4lGTZMP3BhcHW+TN+IDfAv6wiShKH01+WrInH6AB6vSs7z?=
 =?us-ascii?Q?ErYWRSQYbvtM4zxhz6iaT6Hv2/sUPF1QUp88uEm7Q37zzmH/n4K5azD+lZRa?=
 =?us-ascii?Q?rnmwiiHu/UCzy9PjxVtrC8ob51Dy9dnOz5dEkOr4U5gPyTSpTKXgglSKSB3Y?=
 =?us-ascii?Q?PSs1YQT7rhl82SOIs4v+PDKQf1dud/pq329zWxsw1UCXEWh4uicSJel+2izT?=
 =?us-ascii?Q?VFHTnzdDOkHHmy3yrJLEaP3uOkFZfm7byPgQ6g98hoFd5iitSWnCqr2ZCW/Z?=
 =?us-ascii?Q?+wN9TUQt195rU774rndJiG3r9qEPDj8INcP2MEWNKKWZ6Qv8axVmE1w+ZFpI?=
 =?us-ascii?Q?z10g0oOofhI6Fp81PDn/MDNTP2WCPs6stSrRpVoSgVzqetEc4p5lH4qIaprm?=
 =?us-ascii?Q?U/viXhWYeDiweJJwdZxzE/0QBbSAWUim644A+TwLfysDGcl6q2EKfZtbTDhh?=
 =?us-ascii?Q?/E4p6TTJPfC+TyYemIh7ZehHf+ftkOZkoxi+TNQv67xDFAE/LMxb7PgKFYGH?=
 =?us-ascii?Q?aJ5L0v4J1esiL4Nr6W6TYQiWIi0oBsDDkbUhz7p8VqWZuo+I0htokO1skz1r?=
 =?us-ascii?Q?ksZRwWlcd6nGUN/4IQm3ABiJavQBxZjT9gsELhQPnX5ScICtRqlMy5ZbtxFQ?=
 =?us-ascii?Q?OngoKbDVclrCPD1VOHEv2Vxk2qHoxDFNkuYZeQfbj8/VGR8czq7BhMplS56a?=
 =?us-ascii?Q?7NwZGjfccmV1SFoh93LmqMUmvCB6m+NhctUu7AuZl9VxjEMU91n5Jy5qeyiJ?=
 =?us-ascii?Q?u4NOahNkosqm6T89Zw7xB/kNn5rOuUACCcNBfQpeiX2A1i89I2vZ6PH4XWwZ?=
 =?us-ascii?Q?1EvD+FcWpCZNRk+ru6EFQv45YRB7YXbe8NlmJsTmqqKjIjFfQTk3zdCGiJdj?=
 =?us-ascii?Q?E6glLH2JQaNtV/vHopsPmsK/2QfTMEb8WzGM9AOALp5r/WI3OrrYQnLEJ+fI?=
 =?us-ascii?Q?8iDmHEgAPo6dISPSQc4mskbXtLeYi8t5HwDhmUAwaGx7mBZZZYPKMIO4FeXF?=
 =?us-ascii?Q?/fkutKLCE2KmMqQ4VqVpQIGiLolUYBH+EYfVCSe8RMvT747jx7Y7vqIkVs2X?=
 =?us-ascii?Q?ZVyt+Kseqw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2b8cc0-d7ff-4e37-5c98-08deea72e115
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 17:33:45.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eur/8aQpyUOAGFyEDHUJAxXCwSjPFHpx+ADpYv68TYJ51UGptvfUjvTzijGEqDteMVdNmYlPFh2N35om3plp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6915

This patch series improves 'perf sched latency' by fixing misleading empty
table output, introducing dynamic unit auto-scaling for latency and runtime
statistics, and adding latency histogram visualisation alongside time-span
filtering.

Patch 1 fixes a bug where 'perf sched latency' would fall through and
return success (0) when perf_session__has_traces() failed due to missing
tracepoint events in perf.data. This resulted in empty header tables and
zeroed summary statistics being printed. The fix ensures an early return of
a suitable error code.

Patch 2 introduces dynamic auto-scaling for display columns (Runtime, Avg
delay, Max delay). Previously, all values were unconditionally formatted in
milliseconds (ms), making microsecond or second-scale latencies difficult
to read. Columns are now scaled dynamically to the most appropriate unit
(ns, us, ms, s) and headers are updated accordingly.

Patch 3 adds three new command-line options to 'perf sched latency':
    --histogram (-H):
            Displays an ASCII bar chart of CPU wait latencies between
            snapshots

    --hist-mode:
            Configures the bucketing scheme to either logarithmic (log) or
            100 us equal-width linear (linear) mode

    --time:
            Filters event processing to a specified [start,stop] time span

Changes since v1:

 - Fixed integer overflow in latency_bucket() (Ian Rogers)

 - Linked to v1: https://lore.kernel.org/lkml/20260724142901.634761-1-atomlin@atomlin.com/

Aaron Tomlin (3):
  perf sched: Suppress latency table output when trace samples are
    missing
  perf sched latency: Auto-scale latency and runtime display units
  perf sched latency: Add histogram and time interval options

 tools/perf/Documentation/perf-sched.txt |   6 +
 tools/perf/builtin-sched.c              | 234 +++++++++++++++++++++---
 2 files changed, 219 insertions(+), 21 deletions(-)

-- 
2.54.0

