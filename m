Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF1C433B4
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9458C613CC
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbhDFWAR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:00:17 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com ([40.107.93.41]:47520
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343894AbhDFWAN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Apr 2021 18:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYcbKA1rdy0kZfCk2UQHJh5bf5c3JWVYXV31mVTeHjMhifh3LOduUt7n8NzvSrzLN6CKtH6mxtxXMyzasl5wUNtvVPX3rPNZwQ+Js7F1W4DvFqtIeV9WS2xZGiLm5R0X0QKUtid3OrcWblU4pMW9ZQ4GPK6BZrwGqmmOlB+TLtqtwS08LD8otyuovdGQvWLZMKsnzj6S/uR3x/IV+YMZ+iK0CDo5s+2AD9F5BvNcR36hto3qhre/OgrStB1iCQA/g0+3L6zv2erPREYzcQVpPFbX0GudhzfglNz9pMVqRFsuuThMe6jLybjz27VbF+01zDqpUYcOY/mI7gEpYMzMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAx8WZMNrjqb/owMXjQzhe4J5PuGtBlG74cVQITWREU=;
 b=oaulzD9kTAzWl+7obfi+Rb1hPmR7cQdSbaLQ+Scy5Z8UVlqleYENqZIdO5QFgqGFDOshKZEehiYHPf7vwwWD41/AbSU0bpVggwY14jllrai953kgWEr/a9kJMKy7UmV1CwXxClBTVGH/kb5AwTFq1ifaxoAXNa7Tr8YX+la19bsq6Dlt5+Y5KzoAGQFfYGZzlBIZ0iAtynsDA8hXuq3D0pHTKr3DgLwJOIE75qEuI9x4HU+FVt46bDyPFeGkNVXpN0T8e1O3TJbMcDsyVWFK6Vy/KtIer/0362wWqL4VWsyAGfqgd76K/g8jmACYBTHdx7r4UQP1UzJFLUnz78Lyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAx8WZMNrjqb/owMXjQzhe4J5PuGtBlG74cVQITWREU=;
 b=czIFxJuPUreiFypuz7f8TgdKmqydBJQkkvEvcC6vIqb6Wulyu5ywzEPhW+1VVyTVe3zbgsLXbRksXIdMPMTvSlD1YTBQzeG+pYwvDP2PIsTfEtUD7MPiKS1xwMh1KKz6rBSZhLLpzRLVHbJadlvEu6mgspA3oC8fc0ANHi1sYCU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 22:00:02 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:00:02 +0000
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
Subject: [PATCH 1/4] perf vendor events amd: Fix broken L2 Cache Hits from L2 HWPF metric
Date:   Tue,  6 Apr 2021 16:59:41 -0500
Message-Id: <20210406215944.113332-2-Smita.KoralahalliChannabasappa@amd.com>
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
Received: from ethanolx50f7host.amd.com (165.204.78.2) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 22:00:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c8b3410-7b8b-4f59-3484-08d8f94753df
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640F952AEA8AAFEED82078390769@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5m0spVnvmaGpXcs/jeYYEiH7PmqTYPLFk7vIpdYD6l5QkjrVpLCE9k3GmUkUjwG15P/+yXdNXgnHUJZBH/mOhQ3VLmjE9PtNKwQWDNvEWSvJE4VG+TdfTDcjIMORigwxQyI7kx+YgRO+4DJCPKKPRt40H1Doi5kOtVAV/XDGEKxgToUqshS6YgtJ8gjCj3B3rHrIDM3kiCf4gv91Tl0xdqdU9jPg8SblKqpVTjawYf2LoU/cQGsrB1kHHJdyM+5FgB8G+geY3Wb6q+ADeNzmjt/ZhoieEk/kj91Iq1iNberlgvJ5bTXA8a+gKwqbwDB+LYGRYUujn2mmiuQFPWiac6oZVUL0U4uZyfQz9i7p4opAjMHA6m8B31Zk0BuQjHKBMPhTBhKQgw65cwXtvW2XTfzNQb8pbwtqqULsUTFTkB0dowlvFb6NKlhPzi6kWvs4ecAp0Oeryp2tVS2tuKtTc2DH2mrHftNtG1bMtKl2PRS1ypwac4dFX2BTsotgCKHldbxPFrHPSCbc3MxXjL6/nXk1Wf3n3P9CEhU+tJw6nDHIXAZyHVQf/gq8Zp6ixG9VlN6JrCT39kXtHdoQAbHyjE0fnPkbBP1jiHQIl+8W9/FV4X01MdBfufC4HGZFBiYraDoG1Dh4RI8dewrULm7lkVqLiD+xyn0oIPR+4y+RtPqe1d/jrjF93fjybuVobwQDtzdbDt+P+7G61cKGmjyI0BwSMUPXfc+O7u+KquRNRH/qga/XpwAB78W7TAie3AtleT18gNM8KccXuRv8xoszQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(966005)(4326008)(186003)(83380400001)(2616005)(16526019)(8676002)(1076003)(8936002)(38100700001)(66946007)(6486002)(66476007)(38350700001)(7416002)(478600001)(36756003)(52116002)(5660300002)(316002)(54906003)(2906002)(7696005)(6916009)(86362001)(956004)(66556008)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c05vVFFlZnlSUXkrZ2wrTFpYSXNRVGg1QmM4VnRpYW9XcWt3OUtOUGxsbkZ6?=
 =?utf-8?B?Vk9uOE9TRmErV1RiL2RsME5UM0s3TVVFeXBQNklrL3doM1AreEJzdk5lM1JN?=
 =?utf-8?B?eTdheWlvN0t1RGJTQk5JT1NpU0NRRHIrMHJNWnJCbS91SEQ3MXhaMnU1eU0w?=
 =?utf-8?B?cW5XeEYwSTJrTk5PTS9UNzA2SEoxVjg2RzRoWUtTZmNQdVBVV09ZRTluTDVR?=
 =?utf-8?B?ZHZ4NGpQanJvdml3TlpMUmRYdzExMFJzZmQ5bE9sdXBXZWlVekM4Q2hzeWZ1?=
 =?utf-8?B?SHNhOEZrWldnWitDNzRGWENkSXZPR3lRZ2NGMWc1WXh3Zjd6anBGcHJhem9W?=
 =?utf-8?B?cVVZTGVpSTVTVHBxc2trQ0hJT3JCcUdkdVZKQW54WVBpdGV0UUI0eDVMbElP?=
 =?utf-8?B?bWh1Q3F4bklRWElLY3FXMmRtc0hGMmVocXpvSlhQVFpDSGJVSkFhc3M5Y3Nx?=
 =?utf-8?B?ZS9jVk5UOFdCS1BJdEpiY0RhaTBtRWJsMzAxdjc0ZTZBaW5iMkhzU0pnaDVG?=
 =?utf-8?B?Qnk1SnFEUnNiN1BrWmZIU3dFVHh3RGE3N0llUGdoZVFpVXQ3TmJKREhGa2hq?=
 =?utf-8?B?eUdFK05CbWEzSnU0MmZzNUV0S3BSVVYwaE9GSHJZdGRkOE1WYzZaVndQY3d0?=
 =?utf-8?B?enpZcTFFMzM3dDMzMmhCQUl5ZERxZmhNdVZ5ckNhWDN3NVhLZUpjRXJjUFBj?=
 =?utf-8?B?K1VzN3RPMWVsaFBQSUMrWEFZZFd2d0VzZnd3ZSt1UW44NVdnU29XTUZyazMx?=
 =?utf-8?B?LzdEWFhISytJaW9oUW5OVENnWnk4TWNjVXU5VURtRVNRSkx3aVBsTTBBOWlm?=
 =?utf-8?B?NlpKSFlaU2VEQncxb0VFeEVDcW13SHZ2YnBRZk1hcjNYeVVnQ1FIcFh1T3lv?=
 =?utf-8?B?eW5lQk1sdTVBby9qM1BMRWc5d3N3ZkJ5UVdqUGVqV2d5cDQwbHZ0dURLTVd0?=
 =?utf-8?B?N2x0L3dQSVlIZUhEdE1VdG1vOUl0c0VQbUV2S3pFNzNQQ1l4VStKc0tXWFBL?=
 =?utf-8?B?M1RRZEdyT2VoalljSWRHTzduNytDcnBwK1hRVGlCRE5pdHlVY3hRS3NCM2dq?=
 =?utf-8?B?YkZyVzBaRXhFcVhCK0hZK3laQmRTMitzTHByK3JlOEx4djhhMmtYbis2OUV6?=
 =?utf-8?B?Y2xkcUVYZ0ZiL3VJU0ZHUHBOcm5hYW1mbncvbmZEYll6c1p0RHloU09YdjFO?=
 =?utf-8?B?OGtZa1FDNUo3QjJ1Y0VIN1dUSDUrSkZZMkRTanNIRTFlZEhBc0huK3dUKzlh?=
 =?utf-8?B?T2p4TVJhaW9TVitURjNIWGU1Qy9nc2Z0V0xGbVNEK1A4MWtUak5TRzFyM0VN?=
 =?utf-8?B?eXdyKzhIOEN0REFBY21oUG1la3Zjc0xseXhVNjI3RWJMREovZ3AwaW82Mm5J?=
 =?utf-8?B?L0ZCSWJENXc3QVRBZlIwS3NwcmtkV29FU2x3NVF4cHhBL1YvUlZnTENRM2xX?=
 =?utf-8?B?dEYrWTV4Rk1nb0JPSXJQbTJHb1BVM0xjWHRkNWVQcmpobis0cXFaOU5GVFJx?=
 =?utf-8?B?OXE4YWNmbjJYREMxMHpQN21VU1R3U0M4MCtGQ3p1UEZ4RldrcXBWNnpUNDBU?=
 =?utf-8?B?bkRDbGt2SlViKzMydDRtM3RDTVJ5bnI4Q0lTUExzdHRMWGU5T0xIWXB5bkFT?=
 =?utf-8?B?Yi85MnVWa3ovUnYvQU1TY2FNbFJ3VldYczNia2ttQWVPYzFoMTh1WUhOTVJi?=
 =?utf-8?B?QXdVclFTcmJJYlNrZFlhQWE0L0I1ZXAvWUpSZzZzOFQ0TXNYSGR1dTJEMGVN?=
 =?utf-8?Q?wwY4D6bDbp9lk4Jah2tyK0JHlXV0VBI6+IeWngc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8b3410-7b8b-4f59-3484-08d8f94753df
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:00:01.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a40otDF9T6DkPKXXt1gm+F2ZhpPn37fNjkl+y8L45IgrwE9uLBYCPSBLPOMUj6InZWJbtTZouAf27XGy68IZiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 08ed77e414ab ("perf vendor events amd: Add recommended events")
added the hits event "L2 Cache Hits from L2 HWPF" with the same metric
expression as the accesses event "L2 Cache Accesses from L2 HWPF":

$ perf list --details
...
  l2_cache_accesses_from_l2_hwpf
     [L2 Cache Accesses from L2 HWPF]
     [l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3]
  l2_cache_hits_from_l2_hwpf
     [L2 Cache Hits from L2 HWPF]
     [l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3]
...

This was wrong and led to counting hits the same as accesses. Section
2.1.15.2 "Performance Measurement" of "PPR for AMD Family 17h Model 31h
B0 - 55803 Rev 0.54 - Sep 12, 2019", documents the hits event with
EventCode 0x70 which is the same as l2_pf_hit_l2.

Fix this, and massage the description for l2_pf_hit_l2 as the hits event
is now the duplicate of l2_pf_hit_l2. AMD recommends using the recommended
event over other events if the duplicate exists and maintain both for
consistency. Hence, l2_cache_hits_from_l2_hwpf should override
l2_pf_hit_l2.

Before:

 # perf stat -M l2_cache_accesses_from_l2_hwpf,l2_cache_hits_from_l2_hwpf sleep 1

 Performance counter stats for 'sleep 1':

             1,436      l2_pf_miss_l2_l3          # 11114.00 l2_cache_accesses_from_l2_hwpf
                                                  # 11114.00 l2_cache_hits_from_l2_hwpf
             4,482      l2_pf_hit_l2
             5,196      l2_pf_miss_l2_hit_l3

       1.001765339 seconds time elapsed

After:

 # perf stat -M l2_cache_accesses_from_l2_hwpf sleep 1

 Performance counter stats for 'sleep 1':

             1,477      l2_pf_miss_l2_l3          # 10442.00 l2_cache_accesses_from_l2_hwpf
             3,978      l2_pf_hit_l2
             4,987      l2_pf_miss_l2_hit_l3
       
       1.001491186 seconds time elapsed

 # perf stat -e l2_cache_hits_from_l2_hwpf sleep 1

 Performance counter stats for 'sleep 1':

             3,983      l2_cache_hits_from_l2_hwpf

       1.001329970 seconds time elapsed

Note the difference in performance counter values for the accesses
versus the hits after the fix, and the hits event now counting the same
as l2_pf_hit_l2.

Fixes: 08ed77e414ab ("perf vendor events amd: Add recommended events")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
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
 tools/perf/pmu-events/arch/x86/amdzen1/cache.json       | 2 +-
 tools/perf/pmu-events/arch/x86/amdzen1/recommended.json | 6 +++---
 tools/perf/pmu-events/arch/x86/amdzen2/cache.json       | 2 +-
 tools/perf/pmu-events/arch/x86/amdzen2/recommended.json | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
index 4ea7ec4f496e..008f1683e540 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
@@ -275,7 +275,7 @@
   {
     "EventName": "l2_pf_hit_l2",
     "EventCode": "0x70",
-    "BriefDescription": "L2 prefetch hit in L2.",
+    "BriefDescription": "L2 prefetch hit in L2. Use l2_cache_hits_from_l2_hwpf instead.",
     "UMask": "0xff"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
index 2cfe2d2f3bfd..3c954543d1ae 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
@@ -79,10 +79,10 @@
     "UMask": "0x70"
   },
   {
-    "MetricName": "l2_cache_hits_from_l2_hwpf",
+    "EventName": "l2_cache_hits_from_l2_hwpf",
+    "EventCode": "0x70",
     "BriefDescription": "L2 Cache Hits from L2 HWPF",
-    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
-    "MetricGroup": "l2_cache"
+    "UMask": "0xff"
   },
   {
     "EventName": "l3_accesses",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
index f61b982f83ca..8ba84a48188d 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -205,7 +205,7 @@
   {
     "EventName": "l2_pf_hit_l2",
     "EventCode": "0x70",
-    "BriefDescription": "L2 prefetch hit in L2.",
+    "BriefDescription": "L2 prefetch hit in L2. Use l2_cache_hits_from_l2_hwpf instead.",
     "UMask": "0xff"
   },
   {
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
index 2ef91e25e661..1c624cee9ef4 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
@@ -79,10 +79,10 @@
     "UMask": "0x70"
   },
   {
-    "MetricName": "l2_cache_hits_from_l2_hwpf",
+    "EventName": "l2_cache_hits_from_l2_hwpf",
+    "EventCode": "0x70",
     "BriefDescription": "L2 Cache Hits from L2 HWPF",
-    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
-    "MetricGroup": "l2_cache"
+    "UMask": "0xff"
   },
   {
     "EventName": "l3_accesses",
-- 
2.17.1

