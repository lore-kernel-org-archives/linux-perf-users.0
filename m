Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022080.outbound.protection.outlook.com [52.101.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A831922E7;
	Sun, 23 Mar 2025 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742755165; cv=fail; b=PijM8qUPgV6vn9W9x3/Jqh3K7ARjQJcF0c882Jk94otmxwuo7NL5Ww5QqtbpaodIY85WtGj9eXlBK1ZUxHzIWAFo322EuOMSfXJ9bYA+me2UBWQ8C8yBqQJwGWbur3Gue58240Sjefj60iI2lIBmIuMz14sGHJjZMnGMjoHhLjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742755165; c=relaxed/simple;
	bh=uiXGfSqThmmEWZkF/r9FAO18uE+r1ma8Y9MvxJHSoiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIr24j8WxPkSVCa8Jr7AbOTIKllLvRLy5b/fE/Iqa5rAkBp40i0/XZiBdOawx7cq9WG1syE4BZFIO5iPvO/7z+ALbWvkUbz06KoNWnxUZhbEHe5wmYbWDwU1DpHy6R4SQrhroG9w4Ps99N9+91GXvmX7Qo883KDol5m192wn52I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGM+pRwkqbV4HzmImuJewcpIVb+TUrbtNtK4U5Yafh79QyWJ6KlE7J2L/jFXWh2rc7VK247jw+IXGMEr/N2ENuIg2aPTP+XmNbzojradPVJRyG9aPdSfEnm0Fqs3iLILGc2qydrv2BfU0Q+xxjm0JA8xnIL/Z2gYuSIwvkJjbOYK8RaCwWU0bHpIWuoo1CaDnM5SeWqF21yIPRxvTUFX1tUae9QOOJCwsFJbmNKUYwBIZbyXUT/t9DFNkPAqcbHjhM6qCZD4k1Xa9oKn0geJJwdmQcYYvQNFFgGIAAd/ObQe2ixr2dVly0tlnok8vLuUEUfCCAqKThpTnzvr1501RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaqMHctHYffqH5RcpM1BZq0DAMAIJXXPAYHJCIQCRnY=;
 b=oKZVcnojNSD+IRcZ6UP/V9dcTZTDqkgXnK0QLx35PeJcdYyHIiplHiPUOnYSiN9YPvqgYr3iswjKaKK3TBSBbhuG54T7dbTpOSDBHPZcptkyHl3PWt5kAgVhqbKuRLv6aP2z1KBLMiXQvY5gsKV0bzitR1KjCx8QpWqQVBfAF2DaUVQaON1NN1BwyoPaQrCrNortfNGEN2ohZpqnJoXZ0fvCLDI8ZAC2lgXbFATsTtPi2hvPU1567u9lviPt25PTCSwXwd4oNobX8Fb8W/6WP2rXGspaCs8ppED36gJqdIoinKJ+Al9cI9rphmL2UMeb7vDG8sNog88CRnlqzq7OxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6861.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 18:39:19 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::5352:7866:8b0f:21f6%3]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 18:39:19 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: namhyung@kernel.org
Cc: arnaldo.melo@gmail.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf probe: Extend the quiet option
Date: Sun, 23 Mar 2025 18:39:17 +0000
Message-ID: <20250323183917.230567-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z5PP3vPpYOccGWIv@google.com>
References: <Z5PP3vPpYOccGWIv@google.com>
Reply-To: Z5PP3vPpYOccGWIv@google.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb08edb-c1aa-4da4-fd11-08dd6a3a05fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVFnMW0xME5WaWptMzh4YVNqOXpVWEhwRGluSlpBVUxYMlNXdDJwNjRsRkxm?=
 =?utf-8?B?MGZoTW0xeVdFdWk3OWp2d1FrSFh4czZaYVpQMm9wdEpycWxINjI0NmgvVHla?=
 =?utf-8?B?Tm15VjdIa3duMVE2Z2ZtUklhb2JKNUZQT3JPcWNQMGVLZmE1SkJkZ3N4K0xX?=
 =?utf-8?B?WFdoRFRTaUpFT0NQZWlzOGwzVVM5WjUzMGxua0srNlUyZEtYSnJYL0JWWFJH?=
 =?utf-8?B?aWk5aG9PNG1NcE1NT1dWcmpUdVRrUGdvMWZIdjBKdEM4SUZvbzByYWY0aEh5?=
 =?utf-8?B?bUgrajJwb09ZeEpIWnJzWmc5TWRvWmlpUFI4WVM0ejJlcjFxVjRlZ3IzRVhB?=
 =?utf-8?B?WnNRdWJCRVFlVTErYWxGbGlRU2RYTjBwT01tMFpsWVFnMFFDbG9tMFI0b2pK?=
 =?utf-8?B?UUQ0RUlQOS8vMFhmMzJ4Sk4xaUVpM3dFYTl5UjdFNmNXa0krdnZta1JPLy9S?=
 =?utf-8?B?T1dWNDZ5MlI1a2IvbEM5bnJVMllSU2syUEJodmlXVjJtcXlqU2J4VnI0VTJl?=
 =?utf-8?B?VldDOWJFa0dheDUxMEdLd2U4bzVSZFE1TmNyenc2d2twdVd4VFExTXlwYm0x?=
 =?utf-8?B?TFNWSkErdnFnVTJyOUdNYXFQRGVENldHWDdiOG1XaEZmOFRFaHFTZEc4Rm5V?=
 =?utf-8?B?ZnNKZFNaeVNIejRvTlNJeW5LbmxXNEFjajVKS0ZyTlRtRHdhME1FMHBOMDdz?=
 =?utf-8?B?Q2ZTSVRHUEtpM3VPdzM0eFFkWFhhdTNmR1dkR2Jjdlp3T3JENC9KOGlQNG94?=
 =?utf-8?B?elgrRTJtRzkvcy9oUGZyWGRGZmxmUTdtdEFRQXgwcktaVXNrY0pTbjNkSXNJ?=
 =?utf-8?B?MlNyanBNWUhhem9RSUZRSkphS2JiOTdJaGJDdUVEdnBXZzZucmhXNmV3a05N?=
 =?utf-8?B?bmJPdXBKVzFKV2tKUisrM0F4ZzZGZUhUcWtmcXpIT1B4NGVPQVdNYWhVWkF5?=
 =?utf-8?B?OGFyUms1T2RWNEJDSEJjbWlveEVNbEZnVWc4aWlCUmJkQVZhbWNDMGV5SnI3?=
 =?utf-8?B?d3QvbGovSUV2NHpvejcrdG5xMUNWQkNES2NzajJmQ0dLam9BZFpOMStSYmF1?=
 =?utf-8?B?L2Z2S01iaUxrMHZvcndGeUd2emtPUzNWWVlxM0hCdkwxTnVYalVqRnRldm5n?=
 =?utf-8?B?QkJhZURXUzZCZ3JXNkY1T1Y3L3k0cCtiRkl6MXVnRjM3RkR5WGJodFBkUGY1?=
 =?utf-8?B?NkJxdGd3MnJnb1VpdC8vMHZVRXNyU3o3NFBmaW85S2tMQzZ2eFNMZThDeCsr?=
 =?utf-8?B?dXM0ZldiS282OFpLc2hteEtDQ3piTXQxNEhSdnFiZnFqdldlQmdRL29yb2VR?=
 =?utf-8?B?aVliU3VwYk1DWjg4MWFURTBKVWx6QUcxMXlpbDZkc2VvRk45YWhtKzdKbk9r?=
 =?utf-8?B?b2Jid3N5cklNTUNYcDNaSC9TT3VVRzNmaUJzcVRjcFZia0hvOTFGN0MwYytV?=
 =?utf-8?B?cElsNmpUdm0wSUE0OUxXRkdIeVNjeVo1ejd3UVBUbytGUVUwSTJBL0twWUJl?=
 =?utf-8?B?Ny9BM1UvWERiY3F5ZUoycFVwK0JIU1l2Z3RqY2xXL3g0SFlBeWV2dXdTOUtx?=
 =?utf-8?B?WDNuTHNBUXZ1bFJXekNJTnJUcXRiNW5PKy9YdDNCUVQ2Um5FNjJvcDZ3TmF2?=
 =?utf-8?B?bVBoMlVNdlN2VW15S1pRUGN3RTliYk42cU16bjlLNWlSZWxybXl6cDBDblRv?=
 =?utf-8?B?TEppYktidGdmZmtGZG85d3ZvQ0dUbjVnRTVTdFl6Z2JhOWttbXZkQ0hiVmZM?=
 =?utf-8?B?bHczZUUwQ2hWdEhYOE56WWRCTnlwTDNrNUY0Ullkb2ZwMXlTSitna1MzdjNv?=
 =?utf-8?B?MGhYRHdjQUovdnBrYnI3S2RKVDEyZlVycmtZa0JZSHcrTnI1Z1k2TytMaDBI?=
 =?utf-8?Q?JKZC7hEAA1oWl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFVBTkNDSEJwMHZyRkJqeHJzT0MxVWZEVjlkeWQ5VHhqWFkzdmI5QTIvUXBW?=
 =?utf-8?B?UXlaNHcwMGxFMERoN1hOQ1ZQQ0IyeGxuRDIwSzdzM3pCVXpCWWFoMFpsWHZS?=
 =?utf-8?B?Q1h0QTVUMzJXYkg3Zjd5a25HZU4vTVljR1A0V0tUL1FERVV5SWZkSnJ3V29C?=
 =?utf-8?B?RGhoNEtjTWE3UHduTEVsYjVmelIvSUQ2MVZ5RCsvajJPZ0hlY05UL3U4dDd0?=
 =?utf-8?B?bW9pMkNSbmtsZklXalJZL2FMSXBmdEJkTmUvSFBXWDdCek5nNy9ScE1rUVQ0?=
 =?utf-8?B?SittSkwyN2diV25rMDZXaWY2TEJYVUx6Uzd1Q2VHUFVTWEIvLytFWnBFbXIw?=
 =?utf-8?B?bGZxOWx2WUc2U2x3RU1CWlZVL01Ra0hMWWtCd3ZKVVh4dHh6RkhIWHBOa1ZV?=
 =?utf-8?B?Szkrc3FUVnFHT2p3NlVPMUliQThWd1ArZ1hheEFHeiswYjlQaWsxTVhlMjh2?=
 =?utf-8?B?bEtDYnpOa0dYUE1ONFd4UEJQT3JUdmtuWVhNZm9iakVibDVaRnJMYVVzdnI0?=
 =?utf-8?B?RUlob0F1akFwMHFIY0c1WVdHOGVQWXRjWEV0K3ArOG1wR2FlMFBZSXZoWjRK?=
 =?utf-8?B?aWwrMDVaUUlEVEpseGovaWhla3F3UmxDWXhKNmZBNG5RYzJ4UHYyZ0IrcFRO?=
 =?utf-8?B?MGJTcmtic3NsVjRXWHJsa2xDemV0QTVnNjhqN1JhZEF1bHo0R3dkZ2xpZHFF?=
 =?utf-8?B?MEk4TnhHWDZxU1hIK2hxQmNnbENnQjkvWnhhNmdtN2RiQ2lqaldsbEtNcG51?=
 =?utf-8?B?THZDYlphdkJPcTIvdklqVFc0emdlTmZoVHdkVzZ4dVNhMFRMTGRlR09RK1BZ?=
 =?utf-8?B?QituN1RVS1hOSTRYK1dxa3E5ZVVmcldpd1FZT1JQMVJ0bmg4ay9OWEVXbjRB?=
 =?utf-8?B?K2hSWlprejVQM09kbVg5ak10eDIrajB1V2IwMnUzeE41c1N6R1drelFEWkty?=
 =?utf-8?B?a2tLNVBiaWJneE13b2tyazVEeEJhZi9QOER2RDk0TmtmQTNOclUzUUZhbU5j?=
 =?utf-8?B?M1NYU2ZNK3l6bEt2dGdnNGFYQUNNVnVRQTJJWEhKZzNIcWhDK0wvVzJDdHRY?=
 =?utf-8?B?Q21kbEpsanNlYkxzMWkraTl1TENaVXRFQ3A5MG8yOGlaZldvaTNXSXc0OFNK?=
 =?utf-8?B?cFpOWDNLb1ZhZEZxNXMrajVSWk43Mk1nemRYZ2hHSm9EZ3RGZXhHYWZHa0VG?=
 =?utf-8?B?NGpUNjB3L2Z4cE1QMkRPc2o3Rzg4K0xSSDNQTW1weXNSQVFNdlYzY1NNSldM?=
 =?utf-8?B?RnFSMTRidDNOM2pRUUlXa0w3Y3luNkVQT1o3K3pLNVJUUHU5QTY3YmlOWVRR?=
 =?utf-8?B?TEZKVXVZanVnNnRMbGc5RktXdGpqRU9OMDN3Sy9ISU9jcGI0cVRmWnBoeTNw?=
 =?utf-8?B?WmlWSms0aGFTNDRVTitMNXNWWUNMVXp2S1hrUFlxbnRMWmlyeDlyRmxKbTYw?=
 =?utf-8?B?bnZuTGhJK2FHMVRDK21GWWQ2NnhIZ1o2MG1SN3BqWmNXbnhxRXl4RjduWHRZ?=
 =?utf-8?B?YXNNaXlObzJJNXFSZUh4bnlWUGtnUFlNNFVwMkViUGg4UWw5WjdGQmp5ZHUz?=
 =?utf-8?B?SDMvSithZmM3UVlvcTBFWWFBcjQ5cm14dXkrR2Z3TnU0Q3o2YTFZUUtHY3RX?=
 =?utf-8?B?NTVqRDZnYUg2RkVVZXRJMStBam9hTXJEc1lGaWVtOGJlbGVkVjFwOFJKQmd6?=
 =?utf-8?B?R0tLd0tsN0lYN2NBc1p6MUo3WWJHQ0hCckQyRnhLTmFPV3JVMVYvcURhSVZk?=
 =?utf-8?B?OXVxZGlZUUIwSHptT2RxN2xFNGxad3VaSTdrV29LU2cxMm41L3ExSXhoWW0z?=
 =?utf-8?B?a24zb2VGbEFKZ3hWVjB0ZSt3aEIxalp6M0VnN1h1amlvbGxoK25DVFNHMWJ4?=
 =?utf-8?B?YStKVWtpZ2lyVGNnT3I0c1BOMm90SmQzWU53QzN5UEFtLzI1bG5yNk9FYkha?=
 =?utf-8?B?bFpIVWVDWHlpV2NqUm8zQ2VlandFUTg5NmM2UVlwVmw2UlI5Ung5UWpVbEJZ?=
 =?utf-8?B?Q1ArU2hUOUFManJYMXdVWTRvazNjcWpRNFBad0RvMEkxQ0R3WU93Z2l4N1o2?=
 =?utf-8?B?TUVIcGRsckludjRic09jV1RvR3N5UlB5R0ZMNkpOVE9jcmVwQTVERFNvYU9F?=
 =?utf-8?Q?NnQ57TnigxpwjvRkKR7NHlWRc?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb08edb-c1aa-4da4-fd11-08dd6a3a05fb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 18:39:19.8264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXQV2rUkvHJfOYdClLxOO+L0AN+SYFkM/uK0zxC7kOK/Q5W/0XbIrZKG8kiZWDfHlDW4g65xXVwgb4YxJedSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6861

To provide a consistent and complete quiet mode, this patch expands the
scope of the [-q|--quiet] option to suppress all informational messages,
including those indicating successful event creation, in addition to the
currently suppressed warnings and messages. For example:

    ❯ sudo ./perf probe --quiet --add proc_sys_open
    ❯ echo $?
    0

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-probe.c    | 16 +++++++++++-----
 tools/perf/util/probe-event.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 69800e4d9530..aee756aad19d 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -391,7 +391,7 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 
 	/* Note that it is possible to skip all events because of blacklist */
-	if (event) {
+	if (event && !probe_conf.quiet) {
 #ifndef HAVE_LIBTRACEEVENT
 		pr_info("\nperf is not linked with libtraceevent, to use the new probe you can use tracefs:\n\n");
 		pr_info("\tcd /sys/kernel/tracing/\n");
@@ -467,8 +467,11 @@ static int perf_del_probe_events(struct strfilter *filter)
 
 	ret = probe_file__get_events(kfd, filter, klist);
 	if (ret == 0) {
-		strlist__for_each_entry(ent, klist)
+		strlist__for_each_entry(ent, klist) {
+			if (probe_conf.quiet)
+				continue;
 			pr_info("Removed event: %s\n", ent->s);
+		}
 
 		ret = probe_file__del_strlist(kfd, klist);
 		if (ret < 0)
@@ -478,8 +481,11 @@ static int perf_del_probe_events(struct strfilter *filter)
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
 	if (ret2 == 0) {
-		strlist__for_each_entry(ent, ulist)
+		strlist__for_each_entry(ent, ulist) {
+			if (probe_conf.quiet)
+				continue;
 			pr_info("Removed event: %s\n", ent->s);
+		}
 
 		ret2 = probe_file__del_strlist(ufd, ulist);
 		if (ret2 < 0)
@@ -531,7 +537,7 @@ __cmd_probe(int argc, const char **argv)
 	struct option options[] = {
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show parsed arguments, etc)"),
-	OPT_BOOLEAN('q', "quiet", &quiet,
+	OPT_BOOLEAN('q', "quiet", &probe_conf.quiet,
 		    "be quiet (do not show any warnings or messages)"),
 	OPT_CALLBACK_DEFAULT('l', "list", NULL, "[GROUP:]EVENT",
 			     "list up probe events",
@@ -631,7 +637,7 @@ __cmd_probe(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, probe_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (quiet) {
+	if (probe_conf.quiet) {
 		if (verbose != 0) {
 			pr_err("  Error: -v and -q are exclusive.\n");
 			return -EINVAL;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 71905ede0207..55771113791f 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -10,6 +10,7 @@ struct nsinfo;
 
 /* Probe related configurations */
 struct probe_conf {
+	bool	quiet;
 	bool	show_ext_vars;
 	bool	show_location_range;
 	bool	force_add;
-- 
2.47.1

