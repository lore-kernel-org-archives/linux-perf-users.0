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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D3C43460
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68630613D0
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbhDFWAa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:00:30 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:57185
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343894AbhDFWAW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Apr 2021 18:00:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC46GeC/qS9iE62VYGYA9qShY8zUxoSTayTpBB/FQbKQhYrmsbrSlBbxNxP3PIeQCR5DsXx0wU2GWz46JOfsWOMAkZCx/MZ3f9zKM551JPhRcpuNmBICZ/80/bbIns0ImHn4FnrpJA5qGAdxalK9VhfWICSeFNQVgriydebDtsnxlKYgONyEs/9utedn8Erg0v9D+e1pk6U97GiRYD3/SqSG7t153IxCL2FGLpe+8GSyBDFXnDgoB0KXwYfPlg9Yjn19zh1pH96HA6bRhdLDVUYCy7gQA8IMd62/0QNVhkUDet9a2pmj46wI+kh/rt2uZEVEh0LjoZWqVXiEY9Ln8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NFq50nez21k2aKYgoFox2pGkPKnQUdoEsbXx1cl85Q=;
 b=eNUhWI+M9xb3bs6zDPmZW5ql8C67truqD/c2/Sg9YwkeIyPpspVNiVZQozNH+X6Tb44vwanXfK/VPsvbwPyw1RywaSGqNdKAw+/zoC4eGPN7H/pWeW12B4gnxIpfEuDuPqIn9IeYvpYypbUJ/zWYMt+bfSVmBeMML7Fa/pfyO5D7F2NHXQPJ0KFIXyfpeY88L/b5EXamolfk65/mJbSbn4/vbquVMT+W4rvmIJskt+S4/oxW8lm9h3Q0Nqlqfh2niT91G5ziqt3P6Vyvnmv95Wyg69uwYtRwIz2vdvO8A6Xk21MOCx4/gSkAKbk3CXsf7gNgvcumjxrU687C8o1PHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NFq50nez21k2aKYgoFox2pGkPKnQUdoEsbXx1cl85Q=;
 b=Kce+ICDjj+Yj4UUU63M+J0tFPe+8LsGB5vJtdXZsu8mDvmr0w9SgMURU5KotUUls8ay6RDSIGuecSGr4M/796kT/izP6BV2VdMU/iYEUSA2syV1TqAlhtgbs5QUPaAP/yqAZ7a9/nVXbduCCLlWq9oXB1DcK/HKYUzACsZeFJnA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 22:00:07 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:00:07 +0000
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
Subject: [PATCH 3/4] perf vendor events amd: Use 0x%02x format for event code and umask
Date:   Tue,  6 Apr 2021 16:59:43 -0500
Message-Id: <20210406215944.113332-4-Smita.KoralahalliChannabasappa@amd.com>
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
Received: from ethanolx50f7host.amd.com (165.204.78.2) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 22:00:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 077d1e10-dcf4-4b92-bca8-08d8f947571b
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23669606B3A77ECEFB9DFD1D90769@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7HNCmFj6qzytKFu6N9mCZMJhygn4yoHjE+Uh71LuAHwMRKOl0jTwLNYdbZkMSbveHTtQukzFAk+4nwjJ+hHrHcq1jeQbte+zHZhMG9gW/QIBSiBiVZrXaRPm2b5f0Tw+x5DffQz5kYl96qWuRJM9Ffm2/hDiE3LpI5ogh6/N1XWbSuVcU9ZlBWld0JYPqY3c0spGzD3fHMWuhtOcgBn7kmuB9lNj8+G09mBcQlMup/uUwHBtkr0OslxA29WOp1Lt+rSHKB6NNJ6PiVIaakwozCHrA/2Py0tfayWfEMJ6OpQiiqhCpKrZxzO1taTEsvd+MiuEDG7smv24WpEFC9/JwIeEUXDZ3nqlnWky+AUvAys1OY4w7a/XfL57HFbwqvTsiLgmNNovVyU9gDCqijeXA4EJ5RFZBkXWIobGxbDFnEhTazyS/5OS0nc3nafp47rBj4wWXVfeF77TGzqi9x0emFE3Pm76qbgdSHiDzcLd7EoAVxRoN3E5Y9MinlmunecLVx5ru0qqeS5AOxY8jAAtOGnbSRu2PEsRmW8ksku2MlujsGQr453kK5adO9WL9AH/75W0RaLk1v/43MCX58wa2CVfxgrmmI8Lhc9NrQnYZYvh8iY9ybMGknf6ll8rOF0SXUhFaKIGko1S8liHrwtGy9qjhxfYshK32MZiuhVutmJVko8YP0mpG3LxjybspwS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(6916009)(30864003)(52116002)(7696005)(66574015)(86362001)(5660300002)(8936002)(1076003)(7416002)(4326008)(36756003)(83380400001)(38100700001)(186003)(6666004)(66946007)(956004)(54906003)(66556008)(478600001)(8676002)(6486002)(316002)(2906002)(26005)(16526019)(2616005)(38350700001)(66476007)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OUdwam5WWFI5OEFvWmdIWEZhbmVNSmxVb2syL1VpVXJ4d1E2L2dlWWtLblAr?=
 =?utf-8?B?U29QS1VydEs4K2VtQ1lqMGFPODg1VGdkNmZ6cHJLMmR5MmE5MWRESG96NXYx?=
 =?utf-8?B?cWlicE84Skpzd241TW9mcXVkQ3cxU1NYcDV4QUxkWXVhdVZKSWtiYWhhVXhp?=
 =?utf-8?B?NnRCNDROd3lXcGczckk4OER3YUtyMmtnMURqTDdFVXJzK0d6dEVDVEppaERC?=
 =?utf-8?B?c0svcVFwTjV3Ymd4N0h1MXpmTHNRbXgvbFN1cWJYV1pKMVRVT1p3ZUU5anlN?=
 =?utf-8?B?UG1vMnBrLzNZK045Q0tjNWt3emJ6U054MXlPL1ZKOTZQVCtmUldaUWowOFNu?=
 =?utf-8?B?Qk5BOTlKR2hXTDJFc0x3QWRhenVqdFczT0JRYWF5dlIzS2U3SUxtQWdtNnIx?=
 =?utf-8?B?cEpVNHQ2aEhSRjh0N0F4RnlLZjlOSXR5RldPSzZEZlRFajJ2M2dWbXphVU45?=
 =?utf-8?B?Qk85S0dYZ1ZtWUJmdml5M0tGd3F0Nk05YldMUU5Cbk9CdHM0OEZFK2Rsc1F0?=
 =?utf-8?B?eGswVlFtckJEalJwS1BIMVFncWpSUVZ1TGVWQ2RmOFgwdnZRazFIcm5UbW5S?=
 =?utf-8?B?K1dqMzMwbEM3UEgvS05JWU5uUEpqaGpZWEtCallIWmdnQ1dGWm45WG5hWFdW?=
 =?utf-8?B?N3VkZ2NBOEtSZFg4cGF6UFAzbGErTlp4QmN2dHIyUnVrQUkybXZsWWlXWEIy?=
 =?utf-8?B?WUVwUTMxKzN2bXdhWmJPL2ZTNFo1eGF4REE0MUtOOXJXTjBURnIxWUxIb2tq?=
 =?utf-8?B?STFIcElVYm1rbzNaUURJOWl0cnk0ZHFPaDhhYTVwSERpQzZ2dFdpRGowMXlU?=
 =?utf-8?B?NmFtbEZBbFdUK2NRNmFjTFJxUmM1c3QrMkVHTVV0Qk9YM0VNcjlGL3EzMUR5?=
 =?utf-8?B?SW1pUWd5cGxkYVFJczRqNk15QmRYeExObXNQd0hrcThEMmJvOTdDelg2V2tY?=
 =?utf-8?B?aURDMEtxMkRsVzRqY1BMS1FPWG43Y2s4cTBkRXVYZXhwYWtSVlFGdjF2SnBY?=
 =?utf-8?B?RE54dUpaSUkxcDJuNTVURFlnQm1DclZueS9VbkNudTdBSjR0T2ZEZTBoK3NW?=
 =?utf-8?B?TjVUOHZzdUNoZmhiaTFTUlJ1RS91VFF5WXBzczJEaEh1cFM5aUJBTUp4Z3NM?=
 =?utf-8?B?cFFKRjRSc3FTbUFMdjZ6amFlY0ZYdG5GNWVKZUdzb0JtVSs3MTVBTExMYXgv?=
 =?utf-8?B?bzdnT2lrbk5Da2dNelFvaHRWRUpWcVdKOTM2bkdmMjdnSEVubHROVzllV0RG?=
 =?utf-8?B?K3diTTFTbXRNYVJ4ZkJCN1VQNlZUZUg3dWtabVdoK1IvQnpYY2ZSbWRMQS9q?=
 =?utf-8?B?T1cxS3VxRjlCY3RFZFV3SHQ0S2Rwb3NPQmFvTXVxOEc2Y3V0NWlmTXk5Y2xk?=
 =?utf-8?B?WG1CT29wNXFvZHNZZHRUUW1ZSDdmcU5uaWlVbTRndi9HUzJtWTFvMERQMlpw?=
 =?utf-8?B?U2VXTkFzTGY0K3d5ZEZBVmN1U0s4MkFna3Z2dm5NOWljMFBLZHJ4MmZBVU9I?=
 =?utf-8?B?ZW9QUFdLU2FHeHFobkRpaUJEQm50NTNYS3Z6aU1UZ1I0dFdraXJRNjl1K2Jr?=
 =?utf-8?B?TGdyOUdjeG9zRVE5MnRNSk9EVDhiT0F4eE14RWl6eVIzaDBWK2NaejcrbHJ0?=
 =?utf-8?B?cTMzT2V3NkUyWmRYZi9Rb28rNEcyRmlSZ0pHQ2pGNWtKTEJVOG5nVHNuRC9B?=
 =?utf-8?B?OWc0U2FkV0FIQVlubDlUdEtTZkI4VHJ3Y2hNYi9VZ0lzOSs3WjgyRlZaOWhm?=
 =?utf-8?Q?6gPc8wZMlBQSWvFvkFjok1fNYq/RgvOuRVIJwEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077d1e10-dcf4-4b92-bca8-08d8f947571b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:00:07.5023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2zfzJAJ2P2YF5uKV9mhKy6ywOTeyd60WytLWzPXEdszoCqE9j/6BwXcTC1C5/y5HTn/IztqfSIbtcX/W+gEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use 0x%02x format for all event codes and umasks as this helps in tracking
changes of automatically generated event tables.

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
 .../pmu-events/arch/x86/amdzen1/cache.json    | 46 ++++++------
 .../pmu-events/arch/x86/amdzen1/core.json     | 12 ++--
 .../arch/x86/amdzen1/floating-point.json      | 42 +++++------
 .../pmu-events/arch/x86/amdzen1/memory.json   | 42 +++++------
 .../pmu-events/arch/x86/amdzen1/other.json    | 12 ++--
 .../arch/x86/amdzen1/recommended.json         |  2 +-
 .../pmu-events/arch/x86/amdzen2/branch.json   |  6 +-
 .../pmu-events/arch/x86/amdzen2/cache.json    | 56 +++++++--------
 .../pmu-events/arch/x86/amdzen2/core.json     | 12 ++--
 .../arch/x86/amdzen2/floating-point.json      | 42 +++++------
 .../pmu-events/arch/x86/amdzen2/memory.json   | 70 +++++++++----------
 .../pmu-events/arch/x86/amdzen2/other.json    | 20 +++---
 .../arch/x86/amdzen2/recommended.json         |  2 +-
 13 files changed, 182 insertions(+), 182 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
index 008f1683e540..0d46cb82bd52 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
@@ -38,31 +38,31 @@
     "EventName": "ic_fetch_stall.ic_stall_any",
     "EventCode": "0x87",
     "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ic_fetch_stall.ic_stall_dq_empty",
     "EventCode": "0x87",
     "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ic_fetch_stall.ic_stall_back_pressure",
     "EventCode": "0x87",
     "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ic_cache_inval.l2_invalidating_probe",
     "EventCode": "0x8c",
     "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS). The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ic_cache_inval.fill_invalidated",
     "EventCode": "0x8c",
     "BriefDescription": "IC line invalidated due to overwriting fill response. The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "bp_tlb_rel",
@@ -97,25 +97,25 @@
     "EventName": "l2_request_g1.change_to_x",
     "EventCode": "0x60",
     "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache state change requests. Request change to writable, check L2 for current state.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "l2_request_g1.prefetch_l2_cmd",
     "EventCode": "0x60",
     "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). PrefetchL2Cmd.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_request_g1.l2_hw_pf",
     "EventCode": "0x60",
     "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). L2 Prefetcher. All prefetches accepted by L2 pipeline, hit or miss. Types of PF and L2 hit/miss broken out in a separate perfmon event.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "l2_request_g1.group2",
     "EventCode": "0x60",
     "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_request_g1.all_no_prefetch",
@@ -150,31 +150,31 @@
     "EventName": "l2_request_g2.ic_rd_sized_nc",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized non-cacheable.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "l2_request_g2.smc_inval",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Self-modifying code invalidates.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_request_g2.bus_locks_originator",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus locks.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "l2_request_g2.bus_locks_responses",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus lock response.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_latency.l2_cycles_waiting_on_fills",
     "EventCode": "0x62",
     "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_wcb_req.wcb_write",
@@ -192,13 +192,13 @@
     "EventName": "l2_wcb_req.zero_byte_store",
     "EventCode": "0x63",
     "BriefDescription": "LS to L2 WCB zero byte store requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_wcb_req.cl_zero",
     "EventCode": "0x63",
     "BriefDescription": "LS to L2 WCB cache line zeroing requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
@@ -228,37 +228,37 @@
     "EventName": "l2_cache_req_stat.ls_rd_blk_c",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache request miss in L2 (all types).",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_hit_x",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit modifiable line in L2.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_hit_s",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit clean line in L2.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_miss",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_cache_req_stat.ic_access_in_l2",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache requests in L2.",
-    "UMask": "0x7"
+    "UMask": "0x07"
   },
   {
     "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2 and Data cache request miss in L2 (all types).",
-    "UMask": "0x9"
+    "UMask": "0x09"
   },
   {
     "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
@@ -270,7 +270,7 @@
     "EventName": "l2_fill_pending.l2_fill_busy",
     "EventCode": "0x6d",
     "BriefDescription": "Cycles with fill pending from L2. Total cycles spent with one or more fill requests in flight from L2.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_pf_hit_l2",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/core.json b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
index 653b11b23399..4dceeabc4a9f 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/core.json
@@ -68,21 +68,21 @@
     "EventCode": "0xcb",
     "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
     "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
     "EventCode": "0xcb",
     "BriefDescription": "MMX instructions.",
     "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ex_ret_mmx_fp_instr.x87_instr",
     "EventCode": "0xcb",
     "BriefDescription": "x87 instructions.",
     "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ex_ret_cond",
@@ -103,19 +103,19 @@
     "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
     "EventCode": "0x1cf",
     "BriefDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
     "EventCode": "0x1cf",
     "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
     "EventCode": "0x1cf",
     "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ex_ret_fus_brnch_inst",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
index a35542bd3b36..3995b528ebd6 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/floating-point.json
@@ -39,35 +39,35 @@
     "EventCode": "0x00",
     "BriefDescription": "Total number uOps assigned to all fpu pipes.",
     "PublicDescription": "The number of operations (uOps) and dual-pipe uOps dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to all pipes.",
-    "UMask": "0xf"
+    "UMask": "0x0f"
   },
   {
     "EventName": "fpu_pipe_assignment.total3",
     "EventCode": "0x00",
     "BriefDescription": "Total number of fp uOps on pipe 3.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one-cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 3.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fpu_pipe_assignment.total2",
     "EventCode": "0x00",
     "BriefDescription": "Total number of fp uOps on pipe 2.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 2.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fpu_pipe_assignment.total1",
     "EventCode": "0x00",
     "BriefDescription": "Total number of fp uOps on pipe 1.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 1.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fpu_pipe_assignment.total0",
     "EventCode": "0x00",
     "BriefDescription": "Total number of fp uOps  on pipe 0.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 0.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_sched_empty",
@@ -79,28 +79,28 @@
     "EventCode": "0x02",
     "BriefDescription": "All Ops.",
     "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8.",
-    "UMask": "0x7"
+    "UMask": "0x07"
   },
   {
     "EventName": "fp_retx87_fp_ops.div_sqr_r_ops",
     "EventCode": "0x02",
     "BriefDescription": "Divide and square root Ops.",
     "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Divide and square root Ops.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_retx87_fp_ops.mul_ops",
     "EventCode": "0x02",
     "BriefDescription": "Multiply Ops.",
     "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Multiply Ops.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_retx87_fp_ops.add_sub_ops",
     "EventCode": "0x02",
     "BriefDescription": "Add/subtract Ops.",
     "PublicDescription": "The number of x87 floating-point Ops that have retired. The number of events logged per cycle can vary from 0 to 8. Add/subtract Ops.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.all",
@@ -142,83 +142,83 @@
     "EventCode": "0x03",
     "BriefDescription": "Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
     "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single precision multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.sp_div_flops",
     "EventCode": "0x03",
     "BriefDescription": "Single-precision divide/square root FLOPS.",
     "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision divide/square root FLOPS.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.sp_mult_flops",
     "EventCode": "0x03",
     "BriefDescription": "Single-precision multiply FLOPS.",
     "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision multiply FLOPS.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.sp_add_sub_flops",
     "EventCode": "0x03",
     "BriefDescription": "Single-precision add/subtract FLOPS.",
     "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15. Single-precision add/subtract FLOPS.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.optimized",
     "EventCode": "0x04",
     "BriefDescription": "Number of Scalar Ops optimized.",
     "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Scalar Ops optimized.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.opt_potential",
     "EventCode": "0x04",
     "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
     "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
     "EventCode": "0x04",
     "BriefDescription": "Number of SSE Move Ops eliminated.",
     "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops eliminated.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
     "EventCode": "0x04",
     "BriefDescription": "Number of SSE Move Ops.",
     "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
     "EventCode": "0x05",
     "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
     "PublicDescription": "The number of serializing Ops retired. x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_retired_ser_ops.x87_bot_ret",
     "EventCode": "0x05",
     "BriefDescription": "x87 bottom-executing uOps retired.",
     "PublicDescription": "The number of serializing Ops retired. x87 bottom-executing uOps retired.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
     "EventCode": "0x05",
     "BriefDescription": "SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
     "PublicDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_retired_ser_ops.sse_bot_ret",
     "EventCode": "0x05",
     "BriefDescription": "SSE bottom-executing uOps retired.",
     "PublicDescription": "The number of serializing Ops retired. SSE bottom-executing uOps retired.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
index b33a3c308019..385022fb026e 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/memory.json
@@ -3,25 +3,25 @@
     "EventName": "ls_locks.bus_lock",
     "EventCode": "0x25",
     "BriefDescription": "Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_dispatch.ld_st_dispatch",
     "EventCode": "0x29",
     "BriefDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Load-op-Stores.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_dispatch.store_dispatch",
     "EventCode": "0x29",
     "BriefDescription": "Counts the number of stores dispatched to the LS unit. Unit Masks ADDed.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_dispatch.ld_dispatch",
     "EventCode": "0x29",
     "BriefDescription": "Counts the number of loads dispatched to the LS unit. Unit Masks ADDed.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_stlf",
@@ -37,13 +37,13 @@
     "EventName": "ls_mab_alloc.dc_prefetcher",
     "EventCode": "0x41",
     "BriefDescription": "LS MAB allocates by type - DC prefetcher.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_mab_alloc.stores",
     "EventCode": "0x41",
     "BriefDescription": "LS MAB allocates by type - stores.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_mab_alloc.loads",
@@ -85,61 +85,61 @@
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_tablewalker.iside",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks on I-side.",
-    "UMask": "0xc"
+    "UMask": "0x0c"
   },
   {
     "EventName": "ls_tablewalker.ic_type1",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks IC Type 1.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_tablewalker.ic_type0",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks IC Type 0.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_tablewalker.dside",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks on D-side.",
-    "UMask": "0x3"
+    "UMask": "0x03"
   },
   {
     "EventName": "ls_tablewalker.dc_type1",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks DC Type 1.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_tablewalker.dc_type0",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks DC Type 0.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_misal_accesses",
@@ -150,31 +150,31 @@
     "EventName": "ls_pref_instr_disp.prefetch_nta",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_pref_instr_disp.store_prefetch_w",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_pref_instr_disp.load_prefetch_w",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_inef_sw_pref.mab_mch_cnt",
     "EventCode": "0x52",
     "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
     "EventCode": "0x52",
     "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_not_halted_cyc",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/other.json b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
index ff780098d36e..7626986ce1fb 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/other.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/other.json
@@ -3,13 +3,13 @@
     "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
     "EventCode": "0x28a",
     "BriefDescription": "OC Mode Switch. OC to IC mode switch.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
     "EventCode": "0x28a",
     "BriefDescription": "OC Mode Switch. IC to OC mode switch.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
@@ -33,24 +33,24 @@
     "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3_0 Tokens unavailable.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
index 3c954543d1ae..bf5083c1c260 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
@@ -10,7 +10,7 @@
     "EventName": "all_dc_accesses",
     "EventCode": "0x29",
     "BriefDescription": "All L1 Data Cache Accesses",
-    "UMask": "0x7"
+    "UMask": "0x07"
   },
   {
     "MetricName": "all_l2_cache_accesses",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
index f5d16846aa1d..84fb43fa59ad 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
@@ -30,19 +30,19 @@
     "EventName": "bp_l1_tlb_fetch_hit.if1g",
     "EventCode": "0x94",
     "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 1GB page.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "bp_l1_tlb_fetch_hit.if2m",
     "EventCode": "0x94",
     "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 2MB page.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "bp_l1_tlb_fetch_hit.if4k",
     "EventCode": "0x94",
     "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 4KB page.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "bp_tlb_rel",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
index 899ccc81263c..c858fb9477e3 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -27,25 +27,25 @@
     "EventName": "l2_request_g1.change_to_x",
     "EventCode": "0x60",
     "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache state change requests. Request change to writable, check L2 for current state.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "l2_request_g1.prefetch_l2_cmd",
     "EventCode": "0x60",
     "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). PrefetchL2Cmd.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_request_g1.l2_hw_pf",
     "EventCode": "0x60",
     "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). L2 Prefetcher. All prefetches accepted by L2 pipeline, hit or miss. Types of PF and L2 hit/miss broken out in a separate perfmon event.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "l2_request_g1.group2",
     "EventCode": "0x60",
     "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_request_g1.all_no_prefetch",
@@ -80,31 +80,31 @@
     "EventName": "l2_request_g2.ic_rd_sized_nc",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized non-cacheable.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "l2_request_g2.smc_inval",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Self-modifying code invalidates.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_request_g2.bus_locks_originator",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus locks.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "l2_request_g2.bus_locks_responses",
     "EventCode": "0x61",
     "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus lock response.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_latency.l2_cycles_waiting_on_fills",
     "EventCode": "0x62",
     "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_wcb_req.wcb_write",
@@ -122,13 +122,13 @@
     "EventName": "l2_wcb_req.zero_byte_store",
     "EventCode": "0x63",
     "BriefDescription": "LS to L2 WCB zero byte store requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_wcb_req.cl_zero",
     "EventCode": "0x63",
     "BriefDescription": "LS to L2 WCB cache line zeroing requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
@@ -158,37 +158,37 @@
     "EventName": "l2_cache_req_stat.ls_rd_blk_c",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache request miss in L2 (all types).",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_hit_x",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit modifiable line in L2.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_hit_s",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit clean line in L2.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "l2_cache_req_stat.ic_fill_miss",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_cache_req_stat.ic_access_in_l2",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache requests in L2.",
-    "UMask": "0x7"
+    "UMask": "0x07"
   },
   {
     "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
     "EventCode": "0x64",
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2 and Data cache request miss in L2 (all types).",
-    "UMask": "0x9"
+    "UMask": "0x09"
   },
   {
     "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
@@ -200,7 +200,7 @@
     "EventName": "l2_fill_pending.l2_fill_busy",
     "EventCode": "0x6d",
     "BriefDescription": "Cycles with fill pending from L2. Total cycles spent with one or more fill requests in flight from L2.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l2_pf_hit_l2",
@@ -255,19 +255,19 @@
     "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
     "EventCode": "0x85",
     "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 1GB page.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
     "EventCode": "0x85",
     "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 2MB page.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
     "EventCode": "0x85",
     "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 4KB page.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "bp_snp_re_sync",
@@ -278,43 +278,43 @@
     "EventName": "ic_fetch_stall.ic_stall_any",
     "EventCode": "0x87",
     "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ic_fetch_stall.ic_stall_dq_empty",
     "EventCode": "0x87",
     "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ic_fetch_stall.ic_stall_back_pressure",
     "EventCode": "0x87",
     "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ic_cache_inval.l2_invalidating_probe",
     "EventCode": "0x8c",
     "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS). The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ic_cache_inval.fill_invalidated",
     "EventCode": "0x8c",
     "BriefDescription": "IC line invalidated due to overwriting fill response. The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
     "EventCode": "0x28a",
     "BriefDescription": "OC Mode Switch. OC to IC mode switch.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
     "EventCode": "0x28a",
     "BriefDescription": "OC Mode Switch. IC to OC mode switch.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "l3_request_g1.caching_l3_cache_accesses",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
index 4b75183da94a..bed14829f0bc 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/core.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
@@ -68,21 +68,21 @@
     "EventCode": "0xcb",
     "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
     "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
     "EventCode": "0xcb",
     "BriefDescription": "MMX instructions.",
     "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ex_ret_mmx_fp_instr.x87_instr",
     "EventCode": "0xcb",
     "BriefDescription": "x87 instructions.",
     "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ex_ret_cond",
@@ -108,19 +108,19 @@
     "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
     "EventCode": "0x1cf",
     "BriefDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
     "EventCode": "0x1cf",
     "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
     "EventCode": "0x1cf",
     "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ex_ret_fus_brnch_inst",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
index 622a0c420e46..91ed96f2580b 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
@@ -4,35 +4,35 @@
     "EventCode": "0x00",
     "BriefDescription": "Total number of fp uOps.",
     "PublicDescription": "Total number of fp uOps. The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
-    "UMask": "0xf"
+    "UMask": "0x0f"
   },
   {
     "EventName": "fpu_pipe_assignment.total3",
     "EventCode": "0x00",
     "BriefDescription": "Total number uOps assigned to pipe 3.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one-cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 3.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fpu_pipe_assignment.total2",
     "EventCode": "0x00",
     "BriefDescription": "Total number uOps assigned to pipe 2.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 2.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fpu_pipe_assignment.total1",
     "EventCode": "0x00",
     "BriefDescription": "Total number uOps assigned to pipe 1.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 1.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fpu_pipe_assignment.total0",
     "EventCode": "0x00",
     "BriefDescription": "Total number of fp uOps  on pipe 0.",
     "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 0.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.all",
@@ -45,96 +45,96 @@
     "EventCode": "0x03",
     "BriefDescription": "Multiply-add FLOPS. Multiply-add counts as 2 FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
     "PublicDescription": "",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.div_flops",
     "EventCode": "0x03",
     "BriefDescription": "Divide/square root FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.mult_flops",
     "EventCode": "0x03",
     "BriefDescription": "Multiply FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
     "EventCode": "0x03",
     "BriefDescription": "Add/subtract FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.optimized",
     "EventCode": "0x04",
     "BriefDescription": "Number of Scalar Ops optimized. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.opt_potential",
     "EventCode": "0x04",
     "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass). This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
     "EventCode": "0x04",
     "BriefDescription": "Number of SSE Move Ops eliminated. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
     "EventCode": "0x04",
     "BriefDescription": "Number of SSE Move Ops. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_retired_ser_ops.sse_bot_ret",
     "EventCode": "0x05",
     "BriefDescription": "SSE bottom-executing uOps retired. The number of serializing Ops retired.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
     "EventCode": "0x05",
     "BriefDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_retired_ser_ops.x87_bot_ret",
     "EventCode": "0x05",
     "BriefDescription": "x87 bottom-executing uOps retired. The number of serializing Ops retired.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
     "EventCode": "0x05",
     "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits. The number of serializing Ops retired.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "fp_disp_faults.ymm_spill_fault",
     "EventCode": "0x0e",
     "BriefDescription": "Floating Point Dispatch Faults. YMM spill fault.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "fp_disp_faults.ymm_fill_fault",
     "EventCode": "0x0e",
     "BriefDescription": "Floating Point Dispatch Faults. YMM fill fault.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "fp_disp_faults.xmm_fill_fault",
     "EventCode": "0x0e",
     "BriefDescription": "Floating Point Dispatch Faults. XMM fill fault.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "fp_disp_faults.x87_fill_fault",
     "EventCode": "0x0e",
     "BriefDescription": "Floating Point Dispatch Faults. x87 fill fault.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
index 609d9e3da3f7..89822b9ddb79 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
@@ -4,31 +4,31 @@
     "EventCode": "0x24",
     "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons. Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason.",
     "PublicDescription" : "Store-to-load conflicts: A load was unable to complete due to a non-forwardable conflict with an older store. Most commonly, a load's address range partially but not completely overlaps with an uncompleted older store. Software can avoid this problem by using same-size and same-alignment loads and stores when accessing the same data. Vector/SIMD code is particularly susceptible to this problem; software should construct wide vector stores by manipulating vector elements in registers using shuffle/blend/swap instructions prior to storing to memory, instead of using narrow element-by-element stores.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_locks.spec_lock_hi_spec",
     "EventCode": "0x25",
     "BriefDescription": "Retired lock instructions. High speculative cacheable lock speculation succeeded.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_locks.spec_lock_lo_spec",
     "EventCode": "0x25",
     "BriefDescription": "Retired lock instructions. Low speculative cacheable lock speculation succeeded.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_locks.non_spec_lock",
     "EventCode": "0x25",
     "BriefDescription": "Retired lock instructions. Non-speculative lock succeeded.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_locks.bus_lock",
     "EventCode": "0x25",
     "BriefDescription": "Retired lock instructions. Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type. Comparable to legacy bus lock.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_ret_cl_flush",
@@ -44,19 +44,19 @@
     "EventName": "ls_dispatch.ld_st_dispatch",
     "EventCode": "0x29",
     "BriefDescription": "Dispatch of a single op that performs a load from and store to the same memory address. Number of single ops that do load/store to an address.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_dispatch.store_dispatch",
     "EventCode": "0x29",
     "BriefDescription": "Number of stores dispatched. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_dispatch.ld_dispatch",
     "EventCode": "0x29",
     "BriefDescription": "Number of loads dispatched. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_smi_rx",
@@ -93,19 +93,19 @@
     "EventName": "ls_mab_alloc.dc_prefetcher",
     "EventCode": "0x41",
     "BriefDescription": "LS MAB Allocates by Type. DC prefetcher.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_mab_alloc.stores",
     "EventCode": "0x41",
     "BriefDescription": "LS MAB Allocates by Type. Stores.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_mab_alloc.loads",
     "EventCode": "0x41",
     "BriefDescription": "LS MAB Allocates by Type. Loads.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
@@ -123,19 +123,19 @@
     "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
     "EventCode": "0x43",
     "BriefDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
     "EventCode": "0x43",
     "BriefDescription": "Demand Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
     "EventCode": "0x43",
     "BriefDescription": "Demand Data Cache Fills by Data Source. Local L2 hit.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.all",
@@ -171,61 +171,61 @@
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that hit in the L2 TLB.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that hit in the L2 TLB.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss. DTLB reload hit a coalesced page.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
     "EventCode": "0x45",
     "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that hit in the L2 TLB.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_tablewalker.iside",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks on I-side.",
-    "UMask": "0xc"
+    "UMask": "0x0c"
   },
   {
     "EventName": "ls_tablewalker.ic_type1",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks IC Type 1.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_tablewalker.ic_type0",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks IC Type 0.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_tablewalker.dside",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks on D-side.",
-    "UMask": "0x3"
+    "UMask": "0x03"
   },
   {
     "EventName": "ls_tablewalker.dc_type1",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks DC Type 1.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_tablewalker.dc_type0",
     "EventCode": "0x46",
     "BriefDescription": "Total Page Table Walks DC Type 0.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_misal_accesses",
@@ -242,31 +242,31 @@
     "EventName": "ls_pref_instr_disp.prefetch_nta",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchNTA instruction. See docAPM3 PREFETCHlevel.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "ls_pref_instr_disp.prefetch_w",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). See docAPM3 PREFETCHW.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_pref_instr_disp.prefetch",
     "EventCode": "0x4b",
     "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). Prefetch_T0_T1_T2. PrefetchT0, T1 and T2 instructions. See docAPM3 PREFETCHlevel.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_inef_sw_pref.mab_mch_cnt",
     "EventCode": "0x52",
     "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
     "EventCode": "0x52",
     "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram",
@@ -284,19 +284,19 @@
     "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram",
     "EventCode": "0x59",
     "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. DRAM or IO from this thread's die.  From DRAM (home node local).",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache",
     "EventCode": "0x59",
     "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From another cache (home node local).",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2",
     "EventCode": "0x59",
     "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. Local L2 hit.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
@@ -314,19 +314,19 @@
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
     "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM (home node local).",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
     "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From another cache (home node local).",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
     "EventCode": "0x5a",
     "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. Local L2 hit.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "ls_not_halted_cyc",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/other.json b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
index e94994d4a60e..1bdf106ca785 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/other.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
@@ -14,13 +14,13 @@
     "EventName": "de_dis_uops_from_decoder.opcache_dispatched",
     "EventCode": "0xaa",
     "BriefDescription": "Count of dispatched Ops from OpCache.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "de_dis_uops_from_decoder.decoder_dispatched",
     "EventCode": "0xaa",
     "BriefDescription": "Count of dispatched Ops from Decoder.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls1.fp_misc_rsrc_stall",
@@ -50,25 +50,25 @@
     "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
     "EventCode": "0xae",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Scheduler miscellaneous resource stall.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls1.store_queue_token_stall",
     "EventCode": "0xae",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Store queue resource stall. Applies to all ops with store semantics.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls1.load_queue_token_stall",
     "EventCode": "0xae",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Load queue resource stall. Applies to all ops with load semantics.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_token_stall",
     "EventCode": "0xae",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Physical Register File resource stall. Applies to all ops that have an integer destination register.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
@@ -92,24 +92,24 @@
     "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
-    "UMask": "0x8"
+    "UMask": "0x08"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ3_0_TokenStall.",
-    "UMask": "0x4"
+    "UMask": "0x04"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
-    "UMask": "0x2"
+    "UMask": "0x02"
   },
   {
     "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
     "EventCode": "0xaf",
     "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
-    "UMask": "0x1"
+    "UMask": "0x01"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
index 1c624cee9ef4..a71694a043ba 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
@@ -10,7 +10,7 @@
     "EventName": "all_dc_accesses",
     "EventCode": "0x29",
     "BriefDescription": "All L1 Data Cache Accesses",
-    "UMask": "0x7"
+    "UMask": "0x07"
   },
   {
     "MetricName": "all_l2_cache_accesses",
-- 
2.17.1

