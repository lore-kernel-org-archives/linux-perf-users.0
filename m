Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469A3921E6;
	Fri, 24 Jul 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903349; cv=fail; b=TA8SQsfC9zHBA8WDHuhYiT36ZrsBghhdstxpUDGmxFaEZIzDHuwaNLQbAJAUhIuCCc31BCfMktNwRr1rfhPQ5Wz/mHVQ8pvaULA94xlBjNfuph9T5Tpzg+QIcegNL9AKiKIyp08o8Rvr2gFM7nDZMXJz/ozDGK035ouCWCUE9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903349; c=relaxed/simple;
	bh=AzVE2MAho7EV9YVirdBmkAbeLSab3RHkh5abS+u/n20=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P3cRadrhdWJnpQnpkwvf+kV2b3PKo4v1j+g17og1cGKVj1ptc3ktLJFp+BMY4hj3+A8WsxMLYolz94GtqPHQzqe29E8NdQ+P/+gbSGG9/k6gQHAesClU0p+0nl9YmvXZX2UPpnI5i86hAuidT5me3I9P6dI92BOn8a+6bdgnMYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQhK5LId/Oa7NkvMfkzPHNczqsG1vHDvmVuUAElIO8ZNWSNgVFZsBJGnEB0Jax8RIVoM/Wrr6fIzEcN6Ow7fAveyqo0KoJ7EU/z5nnkeS18oNbQxmbJxqWgHiZCs8+pEcADyTwTVIRufrH3SAAtAbt6sWSAdKYVVgt8hMj8SnzgSI2xGViiJMDwpNjzVPk/UjZmgT+OzTa4io27Q2KKhN2MeIAjpppOVa3ZsyNM+9/F9n+Q7yeQAlB38OjHBfnKcT3UUBIaR7yo1U7Lk41gqYdJS+Zqznj/mhzp1qJG/LTd9IAhe1Ux08kS1Fj3/2p3F+uVoOXj1Tm+mniPpo/z02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5CsDdTm9aotaWc3LfQHuysx/jE6ZIKMr8aQuIY87R7U=;
 b=EAAkw96ww2hnLAW8L2ZsBDcCrVZFzJ9Ixple9ka327vHIo9ioBWRvmujoW8G1EB8Y4Zxri4KbZv1Qd/uL8GYJWzAu/6UfazLjwagxQ2bwzt7hchoBhmlIIFt9HfIL3atveLwjRJ+JkgKcY1+dU5pg5ObFrI3BldAeeQ48YQiULrP7XcU71HksiFrQvW3o+xhPxVCU+B3vaAVYq3QX7x7EF90TMYL5oyKmiJj1gP0lGHphTGcjbJa1VnUqrcLMe1yYKLN0xBhDgiSnOAnMbyhBFe4E1Gk+nfTV8f2Mo9NAOM4KIPiBjrT1yAbAbZiRdVw0rAkrj0ug4or20NGRt/Tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8364.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 14:29:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:29:04 +0000
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
Subject: [PATCH] perf sched: Suppress latency table output when trace samples are missing
Date: Fri, 24 Jul 2026 10:29:01 -0400
Message-ID: <20260724142901.634761-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0df951-d74d-4932-9518-08dee98fe9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|3023799007|56012099006|5023799004|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8sSew4Ww05Lf+nTc50ZcLkaFQna9lwcPHfbdf8SDpOWMupdOwJQlvvZI2nkS7AsLVkYBSXV3EsCHpA4mhVcxd8KT1o3cMTF05EtGcixaCOCYi8gse4PM4NzGmC9YFf95Y6xMA7DcSJL2XIwq5d8IoRfBmJ+1Urh0/2lNLGNaz8Jc3UONURQFpW0ybY6MvIqtovhViEG+bNUYOe2w3My0CNK9wslKQ9+DcGCyAxAM6Wa+o7+LxN4RXzKJR/emmp73i24hs9yR2rX2qTmBaLqStNZpby82kQFwveRofV8KKcgdJvQR1yrF594v4/XJgkdopzAd9+JkFOks3laXOZKNF5jwD+fCWNbyWt9x+JHNhtiJ/c29qtwgr69/fTji0/9VWHCEM+Ll8rPB6NiVz4XeB63HEaFvVZ2b61MXaQuAA7n41Pxs4v8beQ+92G9uaBQaT8IYby4s8LO8dw2WaIM0EFlAWf5TPub2F+8jd03KTSniepxdan3afoEXpiU9YJiP1ZQVb9+hmp19JTfI87JVImldr1If2PYOGZ8KAVZ6onzg6Rn3MlS6bkF6VcIMG5bH5+apf9DZroIWqsaMsuIx/i7RT5h0HOcYRYcomLndJ5/vkfMzUMmLBqJzpLh+JLi9SAjPUCtiHHyTSGLJUdFfQ81nBYoDEcMXo5nTlN+MxNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(5023799004)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oA6a4XWTyVVrsftb1SUxqsoQXMTteXuK4yMYZ5TdB3yC9LY+pmHGe3dNFPhP?=
 =?us-ascii?Q?h3rQGblEn4/Bim6mIJiskpgwZBQJLR524yte92PhP5U9SlnKDXmiDv8Ix0rh?=
 =?us-ascii?Q?Rd3/4NvLqSOp4VRflGrM0KZ9DxvgHPwreY/ayZYbJvk36kG6ilDOjup8Qu0r?=
 =?us-ascii?Q?SlmzOsff3KEhU9GBubfP8w9Ax7NN2XkBucVM+5oz6OhskwioF5YrzWdRHxJc?=
 =?us-ascii?Q?ZsLx82Y8Qp0qZUYiD/jWYaOm4a7ZQm5Yx9VVo7KHp1xhLfiHYgrKFgsgFA1n?=
 =?us-ascii?Q?a8Ddhtjn7chUj9+xzOf4rlODimZj4PkFR4b+szGqanzNrHuFy596H3N5xsB4?=
 =?us-ascii?Q?Pps6q/G1d4fcewHKyKGOgR5pYvsII3/qwMO76pUVnN+2GnhV65p+LGVnnpUE?=
 =?us-ascii?Q?kTII2CCerKxqJiirKCaiQG4G5ui8P5qf45ZGe4JQrRHaXD2p0g2dG5fGqBmN?=
 =?us-ascii?Q?dStLXCXqD/Z8zR9vcPkcEA+yGVRpv5HgqmHRLxISy3n2/u2Mz/aIvlI1oBnQ?=
 =?us-ascii?Q?lz9VlTuiKktvFxgo2ES6FJ1zuG71ceBOtD7jOPbRC3qd4uA22Sx0cDfib3vC?=
 =?us-ascii?Q?3SrXJ0pmrpUGmLZC08d+j2JBZQ70m/rxX2zuwrWdQcqnXvMfqSIV0U/+9Eed?=
 =?us-ascii?Q?OQ8Y5HPGPhZj0/F9MKqCqxFBAyRFHlq4eeioaXnXoGnPp9Sfx9qK731PRVSN?=
 =?us-ascii?Q?Y1v83OzlnGtJ5Y/MjZQCs6xo5bqCkA08xEuV7gJwZL7Rtzc9SozshpqZRvn/?=
 =?us-ascii?Q?X8K9l6RjeXlpW+78p4h4Ly++FQ1E8f0+AHwXL+Ibdygh0e1qQ8R3bHEeEccB?=
 =?us-ascii?Q?qr8uUKA+rpIhGhWdjhM+ocC0RGIUWXL3Zh74x8aIWnrjWC6LuBrUEKkQ8Y3M?=
 =?us-ascii?Q?7fGWLio5fCT1gMaCgygGN/5p8p79clWnTWrbVZttb4j6BnuNt2lIO5x/ml5v?=
 =?us-ascii?Q?/qPB5vgp8O1tUiqnoGrarintMQcv/vkqwE/PcCFfhKl7IH8vGP2MHG8dGMQQ?=
 =?us-ascii?Q?omkPyyBVD7aapil3jqPRo1l7/Pwj+QRd6DVgrBwqVTpWCZf27ORSXteIJ4Kk?=
 =?us-ascii?Q?WOSuXFXMafA+1E8XG/KxeuwFPj1cZOic/4LhepkXNUtCH6qNg4NrwJwTePIl?=
 =?us-ascii?Q?pA+pAAU0Okft638rkjy8lWhy9f62Dpm2R/nmp6YS1g+vjQ0s0Iv0X5k2W7CU?=
 =?us-ascii?Q?sUaCEhZo7+cc99kPr53Jdxvs4AW8XKoN1lgoSU3tqc0oxOvs2v7GdbwJLL0d?=
 =?us-ascii?Q?OKoFP+e8Uyffx3e6bMw/jRLPHW/jCOyUlPhAMdva2KQmhpRZnvW2PzAmmUch?=
 =?us-ascii?Q?3iuYT8/mDvjwBg2fUYhA31M3MaXIvFb7U1UrkjjgJbVsDLUtlHIE54y6aWVL?=
 =?us-ascii?Q?VzLcBx5LGDb86vL2d+I0SoPUbMko0A/YhKuhU8fOGpxnEd3I8B+OoAvljMGP?=
 =?us-ascii?Q?ezaYXjgjYCwZv0fpE+fHBqenzr8/43nAU6k6wgxXlcNxIKzWGKqbWVcDoWAa?=
 =?us-ascii?Q?dJU/6UaJIJk71v7cbgySGZargURdp/vu+A7MZId666w/raMrEiB7KFQ+tIXO?=
 =?us-ascii?Q?MJc4VB9hdDoeXZ8ljYHs1DabrIRTp+Jeo8tnUTE2yUTnxNo21bomK5R8wOsP?=
 =?us-ascii?Q?Yvqi1M3GLQQoynwmeLcXseJihqJXq5nE9GBQgCAyIc1YW7CB758Y4yf2qvbj?=
 =?us-ascii?Q?Qbu50t0rB5/AwHHnxvGz3zvx3fOjOgYtJCHu2t7tPAmTA1iufqgjEfHnP/Oa?=
 =?us-ascii?Q?/GzSkk5MLQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0df951-d74d-4932-9518-08dee98fe9be
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:29:04.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUb/eG+C2dqqiMod8+X1bLBtJ31N8ilkk9ZSuxuKY7Npyhf7thzP26OIl7Us5Unj77Wx1javA+hyHkUX+ZbZwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8364

When 'perf sched latency' is executed on a perf.data file that lacks
tracepoint samples (i.e., a file recorded without the -R flag or
containing only non-tracepoint events), perf_session__has_traces()
correctly outputs an error message. However, perf_sched__read_events()
subsequently falls through and returns 0 (success).

Consequently, caller functions such as perf_sched__lat() assume event
processing succeeded and proceed to render empty latency header tables
and total summary statistics.

Fix this behaviour by ensuring perf_sched__read_events() aborts early
and returns a suitable error code when perf_session__has_traces()
evaluates to false. This prevents superfluous table output from being
generated when no trace data is available.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..b3cf678573e0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = sched->force,
 	};
-	int rc = -1;
+	int rc = -1, err;
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
@@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out_delete;
 
-	if (perf_session__has_traces(session, "record -R")) {
-		int err = perf_session__process_events(session);
-		if (err) {
-			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
-		}
+	if (!perf_session__has_traces(session, "record -R"))
+		goto out_delete;
 
-		sched->nr_events      = session->evlist->stats.nr_events[0];
-		sched->nr_lost_events = session->evlist->stats.total_lost;
-		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
 	}
 
+	sched->nr_events      = session->evlist->stats.nr_events[0];
+	sched->nr_lost_events = session->evlist->stats.total_lost;
+	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
-- 
2.54.0

