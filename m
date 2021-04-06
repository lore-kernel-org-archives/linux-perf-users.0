Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927ACC433ED
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D76613CD
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbhDFWAT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:00:19 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:47520
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232271AbhDFWAR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Apr 2021 18:00:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im/AX+p14gQiuwTLcTBmGX0UroEwd+9jcVIHKBHFCP1fAqfNaoQAe7tHDOAInMDBWLkUeHYMgj0v83A9TktubtY0nB5ScNjtAdQfkAE9LgJlcIXJn8oKinXLQ2QG4nJLIsbKBlq5MbacMw4NyxEv08lDOuQQth0gS0ARvczuviIFdDhXb7PXNg28jm1XHrPEC7uazNBVT+Xuqdwfx2vM6ALMuvbGc4WKjbd+TV/MzNoxPcHbJVwv5qyBtI9q/mQ+bttQXcqFjsfxjV5KmVjTcb275r/PAqJ5Z6XdSJfbjcSs6eW/A5nqMRKCf3D9clHTmBSUnWfMOwyJH96Fblcf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOq6qxWboiD6d1A3tssYhQfFJfwJrJA8bOglEb7/LRo=;
 b=A/AA4jCT72p6zkZD+u035UjYfECF7sGnCB8L9N2j7bMkRR8prjx9uIR5bcOr2etTv8O6L6sF05jQuGleafhJjvcZCnZYDJHeCjpHGQWsLDqMEagDCV2LivRfpX5PAfqL9RaYFEsS0g8+9nGkicMag/cpNpMFnz7hHfLCkdHWaZU2+NuPaLTqFLI7mEa6eYcgwxzvnTewdskS/OlOytWKYuE+k89kDLKzBbwDFWDxGgc0/ia0ic3fJO9Nka6wncvkJSp3mIMJwPa9sJfSrobT6PLomULseMEQfAWM2uVN1w3atwrVuuQF8thwWaIVgYOsHlmnx1xV52wZ9mdoVchkmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOq6qxWboiD6d1A3tssYhQfFJfwJrJA8bOglEb7/LRo=;
 b=pkjl2NAklHPKAsZg4EWNYoJse2l/bT9Yj570FIH6CWMzDrBgKA3HLpei2aZjHeQYCVRNgPLuM0q2bZpJQ7QDttfDLQQ1qW6683cxIlc5Cd4lujgPMxXM+BWhv/dl1vy5JJWN3+p3RpbOILnPaUJ6Eos3oK2ewnVKbloZ/WLCqBs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 22:00:04 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:00:04 +0000
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 2/4] perf vendor events amd: Use lowercases for all the eventcodes and umasks
Date:   Tue,  6 Apr 2021 16:59:42 -0500
Message-Id: <20210406215944.113332-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210406215944.113332-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20210406215944.113332-1-Smita.KoralahalliChannabasappa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.78.2) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 22:00:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b71bcec-6a0f-49b3-61dc-08d8f947556d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26406F417813E4545D1229B790769@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rWjjpiI1nmcZXXPyuTGBhZzTa3ys8REK0cOY0m6Uy02Wv9+BiCHUwSYeUUfpwGrSKTF1ySVgDlIO7kdvbOAH9DBpvs+zPUPGJfNJWjiMJ0zVR8WJHG0lv2Y8LXiSWXdoVsGFspKGrRRgSNSjmnUP2Nb0xD41ica1eF56nkZTGuTm4+O/9C56ybp8MU8PK5Q86ZY0hk6mTFHHjjk4Z6lbRPDKMUWnsaOuxN9cH4gKgABoBAGORPOmDcQUY/Bl50hfgHQ6VWH8TlLB9EALTWxsgro/B7Ryf2jnU9txAIVZHKpwz6lki34UbuPAc56/yBWAd3DJKv7ekPW8Q1ZIsWXa78Z7RjHarb1r2z4z9Sj8beAB5qxjWlYnOAFTuU/a2Awa9QP0xTwlEo70G7IUNcJgaqXTKIw2tE5TrM4yhiGSn7iF0oUF/o0J/0kFSiCmQ2Kl6hspf1P6DqDh063//V+ybK8824pwGLsRMmDUsVIyGu9zNk9FVCbGuf3n0oafF3qx53FkjKZbFSfGZfoaXx0WcRrZRfbJ8KgrNdv0ljJTWFGKyAQhBoGPmdXj01pTifkiPZQdDf4YvVCw6UxDmc41KCr9Wxvkv5sWkNxKWv/hdv+cxTaKq4YYCe82RdGy29kRTXCEgdN5saqjtpKEtW8Sj3pOGQro33wxlXhVlKxWs6C47qPHD0M1GOu1ahwGURL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(4326008)(186003)(83380400001)(2616005)(16526019)(8676002)(1076003)(8936002)(38100700001)(66946007)(6486002)(66476007)(38350700001)(7416002)(478600001)(36756003)(52116002)(5660300002)(316002)(54906003)(2906002)(7696005)(6916009)(86362001)(956004)(66556008)(6666004)(26005)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3hUUXFEZkw1MGVHdjljOHNjdDQ5NHRrVUZMV0FCTGdjbmYxcVJlUDA3VmhZ?=
 =?utf-8?B?SGxLeURDSk9IelNPMEVmY1NEalFXelNCTlkvVTRlRzV5VGEzREF2cU1SY3JV?=
 =?utf-8?B?eVFxTlZML1grbnpza0Q4MGFQYmZVc1prS0haV09XRXRlM3BDb3d4eGE1elpv?=
 =?utf-8?B?djNkanIydmMwWEIweTAwVGdUdW1aTXY5S0pLL1lTSXVhbGozS0tyM2Rtbmpx?=
 =?utf-8?B?QVZvYS9kRmFIbDl6Z3Z1WFd0WG0xK0lBS1habmNhY2dNY2FpamVEbW8ybGNz?=
 =?utf-8?B?SXpleGRaOS9HWndpUFdnWmQ3VCsraXh5Ymh4ZWMzKzhBN0x4WUhWU25ieExp?=
 =?utf-8?B?elJlTGJxK1J5Z09MNmNPaDhVcHV2dFR6eTBGRXVrQjd4LzlmSWZvVGZ5dHdz?=
 =?utf-8?B?d21wUFJSZmhIVGppZEJPbzdBdjQreXBTbmU2dElacXpVTnFzNU05VmYrMDFl?=
 =?utf-8?B?ckpJRHhaUERqdTQ2MFZBN3lMenhQM0I3T281aUdzZ090Sys5VHJBSmdxamtt?=
 =?utf-8?B?aGRadE11OVBrekxQRkdhZ3J2T0orNDFHWFVGU3EzeXV6LzNaYTRTSUdWaGYv?=
 =?utf-8?B?RkJSYldlbG10NUxDRGF1ckZ1VHU3ODVwL2FKcGJxam91WVZicjhuS1ZkNS94?=
 =?utf-8?B?Q1FBanA0MTFZK3NUanpodXlCTmlIYTZ1N0hpanJkU010Ui9tSkhQK1VCU3ZF?=
 =?utf-8?B?OFg0d3NsbnBPV2VEN2VBQ1BmYWU3NmFNZTBBV0YxVlBqWDZWclE0OWpKZTNJ?=
 =?utf-8?B?anRTOXAwMGszQUtPOEhSTmVxZ1lrcStvK3RDQUwyVTdjSE9kL2M1MVlaQnRZ?=
 =?utf-8?B?aDYrOEtiMVIwc255VEdxU2pycU9QU0QxaWFmaXgyaGptUFJMUXV4U09YcUVV?=
 =?utf-8?B?RnRSUUVkQUxKRW9RN2hiN05zNG95NGx2NVpRRmJNK0Y5MENEM1lGeGFaRVNI?=
 =?utf-8?B?TWhxc3VFZW1hODBFUGFsZVBOS09nd3lCcFNiRzdvb1Njb21HS20zSDQ5a1J2?=
 =?utf-8?B?c1ljeUlnZGVnb1JKOWhrRFp2NG9BYlFJZlhrL0NEc0FvQ0kwWm5PNkkwelpo?=
 =?utf-8?B?a0lDV211TUNKNW9IRlp6dWl4eWVCSE93a2NleTFjTUtwREJ6dHVXVkpINDZu?=
 =?utf-8?B?THZzcStQQVFrckhobXZlYStKcEo2dVMwNWJjVzZiNExScHFHVjA5UzJUZDBF?=
 =?utf-8?B?TW5Bck1KVHk4SjBWcVZGSmhyRjJtMFBqTGVrMWs4Mk10QVVPdHJoVFN2YnNy?=
 =?utf-8?B?SG9ITGh0OVA2NGpadnpPNjhHY0VXWGRlVElrMlNwTHRNT0R6cFlueEM1bXFO?=
 =?utf-8?B?b29MaHZqOWVjUlZHTjRuZVBVNnl1cmVFYjYvNkNoVjM2YWFTdXhWU2lFQU5Z?=
 =?utf-8?B?eDBkRDErZTJadDF0WWdidlZUNTc0Zmk2S1VSdUNkNklDN3FQTXRXbWRKQkhv?=
 =?utf-8?B?TlZUZmFydllvRUVWaUd3R2k5UmJNclRQdjNETXhySGNORkhxd2drR3V0YVZ2?=
 =?utf-8?B?NmRwZFpsTXdCbUFpNXhHUGtIV2haUlpCQUk0Zm5RUHBnOGNWMm80ekpXTXc3?=
 =?utf-8?B?Sk9rbkorU1NaTVM1dHR5azJsNWpCRlpjcDNLZHRnN1JKbEFqWHBYYlQ1ajVa?=
 =?utf-8?B?U2JwMDFGdTlPN2lWMVR1VnZzNmpLcTRZV3VGMC8zdjVDLy83bnF1cVFBc3pE?=
 =?utf-8?B?VDdZOEdOSkpDU3ZCNlZXK25FaE0raGc0b1R4R3A1bG52b2JZTU5Kck9mYWVu?=
 =?utf-8?Q?OJnXOgpYJwDFZuMWYEPIb1n8jNQlvC4Ydt52MNN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b71bcec-6a0f-49b3-61dc-08d8f947556d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:00:04.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LslSW8D6NtMeOI0+5I/PpyJlWwTPpeqA6fUUFcu8GgYy8IM7+xceaEjROWVJTuvEQsxasfAEFuGGB8NMhCy6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The values of event codes and umasks are inconsistent with letter cases.
Enforce a unique style and default everything to lower case as this helps
in tracking changes of automatically generated event tables.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Vijay Thakkar <vijaythakkar@me.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: linux-perf-users@vger.kernel.org
---
 .../perf/pmu-events/arch/x86/amdzen2/branch.json |  2 +-
 .../perf/pmu-events/arch/x86/amdzen2/cache.json  |  2 +-
 .../perf/pmu-events/arch/x86/amdzen2/memory.json | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
index ef4166a66288..f5d16846aa1d 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
@@ -24,7 +24,7 @@
     "EventName": "bp_l1_tlb_fetch_hit",
     "EventCode": "0x94",
     "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB.",
-    "UMask": "0xFF"
+    "UMask": "0xff"
   },
   {
     "EventName": "bp_l1_tlb_fetch_hit.if1g",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
index 8ba84a48188d..899ccc81263c 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -353,7 +353,7 @@
   },
   {
     "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
-    "EventCode": "0x9A",
+    "EventCode": "0x9a",
     "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
     "UMask": "0x3f",
     "Unit": "L3PMC"
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
index 715046b339cb..609d9e3da3f7 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
@@ -60,17 +60,17 @@
   },
   {
     "EventName": "ls_smi_rx",
-    "EventCode": "0x2B",
+    "EventCode": "0x2b",
     "BriefDescription": "Number of SMIs received."
   },
   {
     "EventName": "ls_int_taken",
-    "EventCode": "0x2C",
+    "EventCode": "0x2c",
     "BriefDescription": "Number of interrupts taken."
   },
   {
     "EventName": "ls_rdtsc",
-    "EventCode": "0x2D",
+    "EventCode": "0x2d",
     "BriefDescription": "Number of reads of the TSC (RDTSC instructions). The count is speculative."
   },
   {
@@ -300,31 +300,31 @@
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
-    "EventCode": "0x5A",
+    "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM (home node remote).",
     "UMask": "0x40"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache",
-    "EventCode": "0x5A",
+    "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From another cache (home node remote).",
     "UMask": "0x10"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
-    "EventCode": "0x5A",
+    "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM (home node local).",
     "UMask": "0x8"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
-    "EventCode": "0x5A",
+    "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From another cache (home node local).",
     "UMask": "0x2"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
-    "EventCode": "0x5A",
+    "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. Local L2 hit.",
     "UMask": "0x1"
   },
-- 
2.17.1

