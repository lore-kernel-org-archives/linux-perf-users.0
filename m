Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2E18FDDE;
	Fri, 17 Jul 2026 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784255502; cv=fail; b=h+w2/9N0uELyi9lnA+R23BW55swrjDgQxpUe94JMN4SGiU26CBvQpAiHmV1z1UmXhhZfqFp/YmyqrMgq8lT/7I7FpD1xsvEUQFF7U9lBldhWwWd52Zvwb69f6l9yl+ALx+3Q6bV/pnM+p+IMSXmC1+jjcWDYmkTkikSuYMGXspg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784255502; c=relaxed/simple;
	bh=pEYiT4X1aDOeUxAbZMWcikQutkzcaSScTeQyNGgD4jw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MGaTJ86nkMkV4JXvudVS2KRFOWPOa5APYD2iC3fjjXVaqKSWbIX22Sev/Pbve7z5n1+S0bW3DUJD/VTYIxZvD71uDnlPBixmY1+EtR0xCK5Qdrj7vwGvFqqvDNlm+igIBh5qAxTgwGRLLjuvr8Ogdp7Ts3H8YG837FMHUev+Qx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6PrdBnk5oOFnIuSX+XLAZPZO9MqpgaxVxYZ/GbR7kK8JOS6Y0KpMf0hTThAB662tz0dp125zBjc3a6yHEKhjk85rE6UvGS3ZLhZGb4fUHQ7Bq7EMF6lWkrdx742Jajia32qRrEAKoJwwtZ6CKkMaXpudsYnZt1HCGJeKFcmI0yJ678m0B+fhjxM7tvOa47VeLe6UDeal24eIKn9HV4hde7YT5bHQ2wQ5dlsuEsR4pMQqNFrC/LVVGYhIx6I+7kaAL7HJbj02tdJclw3wAGotJ5aeUXKgnex4FBHfW+cOYXyjBoy0XL4+1+BmwGQMSIvIsfWfpd5vMsc/b01KIGInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=qyZ+t/WMweA/lSUisKthei0bCa/U70ChpxuO5SjlwbQ=;
 b=k9qOEfxcd0LNThY3ZejtLY0t/W6kDCt/pQp+h5Gygzx8AH2jr/JT1/1jcGMXttN2RJXV+zLsMxGPYwSwjtzjcwa1nvHCMW7pg8eTL1Wc4fTI8DMzpvObIlIay/IpmcIlIDS+NrxNt3i105GImA39NdXf+sIW4ycerEiZnvlhCUebnx7gMh7ts9E4ud1IalyO2tIZXFbPPSjCZm/OLdmBYeNm+8Tk/FfNnvu8XqOm+jINcWMO8t5dsPWWNXCDyXsCII90o7mC5cUIwOOakzAXl+5zjCVvphm4O+MpVY/eA0DQtPFF4Fycr6jZJ0CbOiHhXyITWJyCjXF/EGBNvsDqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8334.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 02:31:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 02:31:37 +0000
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
Subject: [PATCH] perf stat: Add --hide-zero-events option to suppress zero-count events
Date: Thu, 16 Jul 2026 22:31:34 -0400
Message-ID: <20260717023134.272578-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:408:e7::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: a9deaafc-1c70-4b4e-8d06-08dee3ab86a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|56012099006|5023799004|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	waIVjZnP1khgmlss5LAIwOBXLLEb3/GCvXKO1fClGngPPkqzNkJ40DkyYMfjLUT0bVB4Z96b2CL4772FZ00qAcpKCCOa4+6oFR2xIp0oSvZ4L+tnyAId1l0EUcUZynD2Xud04JviUotxV4Hwbu3Q9NfJ8bMre5Voau8JFrPHy5FnVJzblQ9dfG/DdWsnjtavaAeYWChQcIlWf0En8aFg/HzL/2/J0vJSTLLRtYyxHpKloZDbFy2Re84h4+g7//5RNRDMDbI4a4sdlC71letBxJ7vtxVyX3WNAtcnRroDu94ltLo5CllsuHfcyT4b+RQdFoQ8ENs3sAzmfgQj1CqwnXN22Jv/HjTbC2PvdhaMKYgZ9faESLusoqd099Ijephvp1G/wQi7M8pDUY3pcXvnJMxWcTKs2A0EGpdY31QK9HXCSSwSiMBmOls1fZJr4G4MLhTMv6sU/M308OkSozG/4S9gQm6qiDlHNrrsVdF3L6Q6Bb3cXvdQo+yuEkt8z5FzD+3jJF1TdhZiLbP2j2UWZ1plAv1xAmkqqiussK3scfVHQR+ocaXT0fk4d53yGsu0JopDzXlRvvqFmIGcolwAatkCso+zFcM/4iBvF9tih2x5yghAeCPmFomEBmztafY2KBDn4nigh4ZAkyvD/grRhLlZJ2J72KNZ+syHoUqLeRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(5023799004)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTP4+nQBnrYrcu1h0K0/8liROBpb6EwODNSBGRHjc97amw8Q9bPbzmVs8D3w?=
 =?us-ascii?Q?BCBXzwUzIvf2QBriIevl75aCtgNrhqhZZezGAQYk2UeohFxuHotzGK04nHBc?=
 =?us-ascii?Q?DjWgEN0gsINLS2AZiKHM0adABssTFipVrv69fpYvCRGmr7Fa+gPhWnWcWkfO?=
 =?us-ascii?Q?s8FH+oBRwR3UH2CGqP4txZa6tnCpSlcWQDEYqsNzgLjGLIJbmfkVJSCYIUrn?=
 =?us-ascii?Q?UPQw/X54F6+Dup2S3WBHlcZQHBCh8VAPhbY+6Z8BL8biWv7f/Ft/i7rwvjAp?=
 =?us-ascii?Q?uSFqh9fNuE5N9Db8X+UO8YdcvTGu5S0Q679Fz1BasDC56muaxOqMp/s8fM1h?=
 =?us-ascii?Q?rzZke8fGme+WnoTGTTem3+hYIdNqpHYAZhYx85dDYeVAa1moh96w75VKJPXG?=
 =?us-ascii?Q?noYZQ0AgDqJWwu/7gW1Pw8n73FnX/1HHY3KZTMOY5LgNTHluY/knzi/jHZe2?=
 =?us-ascii?Q?x0e9PObqq3strEbtLNdvxjxkldepbnVf8EYsXckTSUf6Sal2bp7TB4Wrns1j?=
 =?us-ascii?Q?x3LjWQtFiP05JfOlcuXGoMlgZHL1bBE0ZE21X7c5VK1u3q35OiRYIZ3EJ7bA?=
 =?us-ascii?Q?OI5l0ZR0HQ5GEQRHQUD0bL4GshuHf2/zAOArdXXJ9t4xzBfbIh5UtkDXxdi9?=
 =?us-ascii?Q?z0o19Y7wGNucFJy4WrvbP8q7Ka4eTkQ/XMwY5HfTv5BZMPY+DWi/xjLB9QHe?=
 =?us-ascii?Q?bGrWUlIzCJthOkdgL8vFXm71umDrOZaoY4XQgrNS2NrNv/UIHJF9LRGQNZWf?=
 =?us-ascii?Q?xBnkwrOOUgHZam4+vUM85ta0I/9MTGIIAFalBc1P6EKW6bpxL6+QKk4twcs5?=
 =?us-ascii?Q?2zy2WVZcw504y/t2QWOs7QpXDIc+9H+PeUhf/IQAh5H6kTiQV4iWjABxDb6u?=
 =?us-ascii?Q?T2CEaKo7UL0JFj5vaqqUi1SAwgdszcdXN4+iUOmRt9sqQkNLMTWSaLpl9bnI?=
 =?us-ascii?Q?SGqiytiBOOhjxcPcvOMb9nWXdBfyr4Q74jXFBCR2TaQdWaRMeyBjjJl6HfVw?=
 =?us-ascii?Q?H11AnsobULCHtaYnMbKgf6zKgFf8CYG/CUWLS3cqzec0GsXsdEAIm22iUjPj?=
 =?us-ascii?Q?SsXVj9ZhUXHCzRQSbpUBRTNHVn75i3kyOKuUdQj6yNcnQEi72bN+Pe9KS/FG?=
 =?us-ascii?Q?ivg3BpPnvYOSnswEAecFOjae6tuRSS2LRV3sbx28y6q78MGxdVNa44Fo/Hn4?=
 =?us-ascii?Q?r68FSaMxwQtya4LOgQsEr+ee50825rEhHcxlGwNcrxw/ATy//dsCLUdQ240r?=
 =?us-ascii?Q?CrE7RA3nmVwCp4BFFPKBZ2vsJbJk2aofX7yjT61/cG2QWP15sMnPxV5Kl4B4?=
 =?us-ascii?Q?qM5C4YS+gUEc76Us7vNOLBpb7IRXvIp9/VWg8XHTmlHhSRnxt2thSI+vYhgo?=
 =?us-ascii?Q?TjSfNZWcEHZpJoGQ2GzpS4+R/04DllqhRT6uUQNxBFMx0tdY2sqtpe3DedVZ?=
 =?us-ascii?Q?X74g68scLk8Hoaq3FKQoV/iTkf328PqYaMbxsdeUoqmJhs0weGWkyfZTApAK?=
 =?us-ascii?Q?iYKolztA5geTGgaW9NqYmjIsPTp5iqBX+gUxHFbwRZskTX8xZQwBicQHXBVy?=
 =?us-ascii?Q?5ZA1CqvxfWSRN/IOCNVmC09FHKfN1hd81jCRBiq4gkFxu2VZYNW4dd6i4vj8?=
 =?us-ascii?Q?pBysp6whIY7pMeUmfvuHCb1XugdIOpFizPxrjFOLGhM3nbQgNt7Dmtp9WTUT?=
 =?us-ascii?Q?x6MeRc+A3VK6PoBKkkQj7HRByqBgbhkwSFetO02HDN/mxvLAP6LWERtkGbYM?=
 =?us-ascii?Q?BeLmhYkC0w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9deaafc-1c70-4b4e-8d06-08dee3ab86a6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:31:37.3346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyDJ2L9xTIDidufZ1boy66Ky8jUxYg9L9VU0chsXCIuNGwXmLJOE8qViHtlPQvNQzU5pjikbv5fXWDExMneNpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8334

When monitoring a large number of events (e.g., with wildcards such as
--event 'syscalls:sys_enter_*'), many matched events will return a count
of zero. This clutters the output, making it difficult to spot the
active events.

Add a new option --hide-zero-events to suppress printing events that
have a count of zero.

To prevent formatting and diagnostic issues, the zero-skipping logic
implements the following rules:

    1. In metric-only mode (i.e., --metric-only), columns must remain
       aligned in the output grid. We evaluate config->metric_only first
       to avoid skipping zero-valued columns, preventing values from
       shifting left and aligning under incorrect headers

    2. For explicitly requested events, we ensure they are not silently
       hidden if they are unsupported. We only hide a zero-count event
       if counter->supported is true, ensuring that unsupported explicit
       events still report "<not supported>"

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-stat.txt | 3 +++
 tools/perf/builtin-stat.c              | 2 ++
 tools/perf/util/stat-display.c         | 3 +++
 tools/perf/util/stat.h                 | 1 +
 4 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index b72a29c9223c..f334aabdc809 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -162,6 +162,9 @@ null run - Don't start any counters.
 This can be useful to measure just elapsed wall-clock time - or to assess the
 raw overhead of perf stat itself, without running any counters.
 
+--hide-zero-events::
+Do not show events with a zero count.
+
 -v::
 --verbose::
         be more verbose (show counter open errors, etc)
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a04466ea3b0a..8d340c2ae76c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2493,6 +2493,8 @@ int cmd_stat(int argc, const char **argv)
 			"display details about each run (only with -r option)"),
 		OPT_BOOLEAN('n', "null", &stat_config.null_run,
 			"null run - dont start any counters"),
+		OPT_BOOLEAN(0, "hide-zero-events", &stat_config.hide_zero,
+			"Do not show events with a zero count"),
 		OPT_INCR('d', "detailed", &detailed_run,
 			"detailed run - start a lot of events"),
 		OPT_BOOLEAN('S', "sync", &sync_run,
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 0a5750bb59fa..1579e3e2c445 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -907,6 +907,9 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	/* Metric only counts won't be displayed but the metric wants to be computed. */
 	if (config->metric_only)
 		return false;
+
+	if (config->hide_zero && counter->supported)
+		return true;
 	/*
 	 * Skip value 0 when enabling --per-thread globally,
 	 * otherwise it will have too many 0 output.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 4bced233d2fc..e3598037a6aa 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -69,6 +69,7 @@ struct perf_stat_config {
 	bool			 interval_clear;
 	bool			 metric_only;
 	bool			 null_run;
+	bool			 hide_zero;
 	bool			 ru_display;
 	bool			 big_num;
 	bool			 hybrid_merge;
-- 
2.54.0

