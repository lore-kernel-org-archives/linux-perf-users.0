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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBFC433ED
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19666610E5
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbhDFWAb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:00:31 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:13664
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343925AbhDFWAX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Apr 2021 18:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASsQO0541BDLI0WJ53oAc6a042Yh/W6VYKobCf5ls1De1v+IyMMwwi0enDmdFVF3FK+7UNXTyF/YYwXrYY3uWkyJE060tKwkRKbq//MBd1tqhpJDqcbTaLAYAft7lrE3OT9CS6Vt9W2u5Qjao4EZ9i3MEJY7iWTtqxCrs9jDfIemdTP5wZ25LbDnofqT0l7Z/jKdh434gEm9Keymfi64SjW7gk7CxJvMNuFO4pdTdU9nzhfHBDHjrTM/WLItfKLRGytt8MzfgpONaCafQcDUcN0OoqPz6XiI5Bmc1heTdxuGvciHaf2/ATc6CyP8dDZH6Mrw3VZkJcNm/HNWDxsKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RREgHmlnXZq8CrzmRrkZcksRqNkKaP6DJDCN7cttTVY=;
 b=aoBEgjILgDrqffuVHoRJ9C0l7HPz0bJejbcqyglsAO8Wx13EVQ2kWWUcEourseWqFRq6OMZSLUKWecRMWml4FLorN8EfoAQCV1VEIC7YhpqJ2Naz1FnRyQX1cRF78vTxTlMY5WzAaYw90SXwlnQedNOxvsMh3clKsLOFQVR3EPG9FV/x83FeF7XNpC8RU7/iVuivxfyTcS8ZC7rb83rMpGcWRhu/392NNJf6e7QImO2F3/7eHETPGdi1yLmUsjZCF1JTDgAZiltFdPXXeEtJVGQEziTg3MO9bBoQ8mc2eVEXTFZa4HZRza6FHtdYn+4GgFCc68v0iydZYIpqFB6mfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RREgHmlnXZq8CrzmRrkZcksRqNkKaP6DJDCN7cttTVY=;
 b=W2E+VENYqAY3kzv1i5VPQ4NIF1KXthRmSC6W1qRqneNHopaJ7g1m6n52uUcqzVNzWU6ttFFbuKZaLB0lVvwPdUAs77GAtD+/0TKBdOqfVAxb9UhvoBJ0FpvqPBhY8R0uOpBhp5wW3gRth5DUZNjHBOhQS2Hev07II2JjcH4u2Tg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 22:00:11 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:00:11 +0000
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
Subject: [PATCH 4/4] perf vendor events amd: Add Zen3 events
Date:   Tue,  6 Apr 2021 16:59:44 -0500
Message-Id: <20210406215944.113332-5-Smita.KoralahalliChannabasappa@amd.com>
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
Received: from ethanolx50f7host.amd.com (165.204.78.2) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 22:00:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a090dbaf-9f5c-46aa-b9f4-08d8f9475927
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45257D9135A4EE5B2B35F9F290769@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7NNEaS0HmILAWDhpkwuiRvn4pLj4TG5Bqa9o69ETLCSZDbN2iDwyoIa9T2BdRAAAr7DQ1RZfDvmOHXzkgw3dprRxLIrCAuEVrCziIwvgGumI8RAK4yVjwiEd9UIHdj+ieEPMuocguajSi1evZTOW7a9Dv2URb+FkHuBcWrX5kRAPXTLJitXA3+7llX5WmQp7Y7qoCnXc43fh6ql1YUib/5mYFLxK3T5xbJo0vK8APSMINU6eTNaOelhmYt+WqI4q0e5Q+L0pIKLYWhi/ij/3H6qguAQosDABHKwSvV+koXckPrdG1Rbhs7IwPBzyjRrYsPqqDLSHYQYHVy6V/e/RbE8VRW+qEU07Vgt72vy5GtQotLrt59fbzg5fSafhWgHC+Tqq6qFqxzkCxfE8SFOutdE2yVV+KOXCwu+OfZPIDfohopDEpfYaYtOHznSwjMEYVkXupbJtwfPBwJU20wKpirTVviJ2MWz1HdUsNcnx0Ir+PCKVsCdXZ2ylXRMYG9CKbMIrTG1QNSuXK8GOaiZyEcB8SQGOobPi7wK0O9B1y7qXA3oqdHbkLtakOhATomyrsIIQs/V0Y0BE0rtHCmpMNu7XQl7Cx8KnhDBruUF8fO1k+inS3il64IrwwiToYv6tPhRGUebTzN/TvmVG4vyseKvzt6z0GOjegycPmje+gsBp2NoHJ4Z9FN38SV4X9xGC9gL1iw9A3/jOc0rf/ub6NsKNyINcOxEe26FGiD/Ve/rmKDIKPj/W7CSse93eZqGkbE/Hdm0eW6pzKS5E6hbVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(7696005)(30864003)(52116002)(8676002)(36756003)(316002)(2906002)(26005)(2616005)(4326008)(54906003)(478600001)(16526019)(66574015)(38350700001)(86362001)(1076003)(8936002)(66946007)(83380400001)(7416002)(66556008)(5660300002)(6916009)(186003)(966005)(956004)(38100700001)(6666004)(66476007)(6486002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bXdoMUM2akxMWDBUSUlRV2VZRUJVMDVPSktPUEZuMW05akdia2Qvb2hUWFJo?=
 =?utf-8?B?V29HMFZwKys2QXhkZmJhSVVtbjNzWC80TWZWVTBtWGw2S0VaQ2ZUdTkzc05W?=
 =?utf-8?B?MzhBYnJueGdnT0EvbmpBYmMwdnhvUng3ZHRXVi80Rzk4dVVzc0JoWklRczdP?=
 =?utf-8?B?aUFudm1sUDRJeDFJcnF3OWZXK1NEUW55U2JYLy83SmR1bmkwYU9wVis4WjZM?=
 =?utf-8?B?R3FDVGZiZVR6OFR2RTBQQjQzRkFwQXQ2L1h0aEdWdEpNYkNvbWVaaHJhOW11?=
 =?utf-8?B?RSswUjhvTklmQThJeEVlZXZaRjFsSjFKM1p1VDF1NjNqUjE5KzhWZlowZUQ4?=
 =?utf-8?B?UmVoV1R6QjZmUk93aHJYUDl3di9vOFV6KzZOZWRpOFkwb0ZhVFB1NHRUdG9m?=
 =?utf-8?B?MTV6NjJ1cmJOOEVTelBML2RtSUd4YStxNnRUY2dNTnBCTFhKejY1anJPM2VG?=
 =?utf-8?B?azE0Z3YxL1g1cWhLNVFFV2FsNlMwOHRvODJkcS9nL05EdHVnQjk5NENsY2FL?=
 =?utf-8?B?cHVDWnVTdHdPdWlldmVNaU41dFcrOFRCU0ZDRGoxUTRpZVR2MEZCejJGVVpk?=
 =?utf-8?B?VDBZOS9teU1xcmtiVFk3MG9NamdrNnlGcE1rQ20xZ0RzVUF4YlVrMHN3N0I2?=
 =?utf-8?B?SFZNV3RBK09LN3RsNDU0RXJkY3IxUWxsZjlCWVJvczhjTFZkNk13cU00OXJV?=
 =?utf-8?B?YmxOQ1lIMUJvRnordHhsYXo0Y0h5M2tLTC8xaTdBMzYrbGs4MFlQVGhtdUtl?=
 =?utf-8?B?dTByRFJnVnNtNHBJU2FFMG5LOGtMMDZDL2NHekZqUXRTRldzbk9PUHF4R3Bl?=
 =?utf-8?B?RTU0a255L2NNdXhQOUcxZWU1eXg0WDQ5NnNrcE83SENGV2pmUVJwZGpLSjlH?=
 =?utf-8?B?eXNKelVlM2NlQ3hrb3UwZitObXNNbFdnZVpSNitlbmV5UUFJaDdCMG8wdEx6?=
 =?utf-8?B?SFZza1FyZkhGeVg1UHRiSlFCaDUydGhEZkwrQlprZU1EazZZSythdmRnR202?=
 =?utf-8?B?Qk1FMnVnd015WTlYVlhOK0doSXQxSWhCZS90OVkxdG5UNVlBM3cyQkNpT1lX?=
 =?utf-8?B?Qnp1OWIyb0RyMUpUMmVmWDZoTXcvb01VU05jaU5wZFNkTEFJbUI5MytlbitL?=
 =?utf-8?B?bmJYbFpNcjRQUnNQSFpkV0J0OTZzeFFFT01TZlkvRnpYMUNOUHdTNWJYS3Vy?=
 =?utf-8?B?a296ZlJvV3VQL2c1SWg0YWFZOUIvZGZiakltMWhMR2xlL1AvZDYwOVFDUSts?=
 =?utf-8?B?dUJpTThScFk2TTlZV0ZBTFpFak85cG1sMERnU3l2R2o3KzFhN1lUUitzemF5?=
 =?utf-8?B?U3ZwdkNmbVA2bG15M2hXYnhyR1pSRXZ3ajFId0hSQnZtSVpkMkZIL05xbFNn?=
 =?utf-8?B?OHhwNkhuN3VtQ2RQYWZwZlNQbDI5Y0xlVFZYNlN1SU5CdEdicDFwd1VLMGND?=
 =?utf-8?B?OXFWeW9VcmVQUjd5dXlsTGpuQUNSeWZXcmVRMzNnUXZ6UEdOZVVSQkNtZmRq?=
 =?utf-8?B?enpTdWdIa1RkaXVIOHhzRW14SUtJR2hiVkZUSXpnZU8zcVppK0RleEw2U0ZX?=
 =?utf-8?B?WE9xdjl2UjVBWG02R2lRN0pEQUozU3FvbHFyKy9ScmtOVE01alhGODVhcFZi?=
 =?utf-8?B?bVFrSkxkNUJEbGVEcmN3N2tNaCtnUjloV0pLQ1FQTi9zWlZvYjZxNjhGcTJO?=
 =?utf-8?B?SS91UmlsbFlFUlhMeUdXR0k0ck1HZENXUjFYVHh6c3MrTGI3ZTlkLzVSQWQz?=
 =?utf-8?Q?2d+cYTAKo4ucL0cKMWOyQOTs/x0f0I3GyTUwbGo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a090dbaf-9f5c-46aa-b9f4-08d8f9475927
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:00:10.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhpYpHMUk0ojApXCsVIpU0ZthumIXW+P2AjTOl83Uxim5nSYi6AK1N84QG65yEtFb136OPXDYoHUOv9bWC4cMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add PMU events for AMD Zen3 processors as documented in the AMD Processor
Programming Reference for Family 19h and Model 01h [1].

Below are the events which are new on Zen3:

  PMCx041 ls_mab_alloc.{all_allocations|hardware_prefetcher_allocations|load_store_allocations}
  PMCx043 ls_dmnd_fills_from_sys.ext_cache_local
  PMCx044 ls_any_fills_from_sys.{mem_io_remote|ext_cache_remote|mem_io_local|ext_cache_local|int_cache|lcl_l2}
  PMCx047 ls_misal_loads.{ma4k|ma64}
  PMCx059 ls_sw_pf_dc_fills.ext_cache_local
  PMCx05a ls_hw_pf_dc_fills.ext_cache_local
  PMCx05f ls_alloc_mab_count
  PMCx085 bp_l1_tlb_miss_l2_tlb_miss.coalesced_4k
  PMCx0ab de_dis_cops_from_decoder.disp_op_type.{any_integer_dispatch|any_fp_dispatch}
  PMCx0cc ex_ret_ind_brch_instr
  PMCx18e ic_tag_hit_miss.{all_instruction_cache_accesses|instruction_cache_miss|instruction_cache_hit}
  PMCx1c7 ex_ret_msprd_brnch_instr_dir_msmtch
  PMCx28f op_cache_hit_miss.{all_op_cache_accesses|op_cache_miss|op_cache_hit}

Section 2.1.17.2 "Performance Measurement" of "PPR for AMD Family 19h,
Model 01h, Revision B1 Processors - 55898 Rev 0.35 - Feb 5, 2021." lists
new metrics. Add them.

Preserve the events for Zen3 if they are measurable and non-zero as taken
from Zen2 directory even if the PPR of Zen3 [1] omits them. Those events
are the following:

  PMCx000 fpu_pipe_assignment.{total|total0|total1|total2|total3}
  PMCx004 fp_num_mov_elim_scal_op.{optimized|opt_potential|sse_mov_ops_elim|sse_mov_ops}
  PMCx02D ls_rdtsc
  PMCx040 ls_dc_accesses
  PMCx046 ls_tablewalker.{iside|ic_type1|ic_type0|dside|dc_type1|dc_type0}
  PMCx061 l2_request_g2.{group1|ls_rd_sized|ls_rd_sized_nc|ic_rd_sized|ic_rd_sized_nc|smc_inval|bus_lock_originator|bus_locks_responses}
  PMCx062 l2_latency.l2_cycles_waiting_on_fills
  PMCx063 l2_wcb_req.{wcb_write|wcb_close|zero_byte_store|cl_zero}
  PMCx06d l2_fill_pending.l2_fill_busy
  PMCx080 ic_fw32
  PMCx081 ic_fw32_miss
  PMCx086 bp_snp_re_sync
  PMCx087 ic_fetch_stall.{ic_stall_any|ic_stall_dq_empty|ic_stall_back_pressure}
  PMCx08a bp_l1_btb_correct
  PMCx08c ic_cache_inval.{l2_invalidating_probe|fill_invalidated}
  PMCx099 bp_tlb_rel
  PMCx0a9 de_dis_uop_queue_empty_di0
  PMCx0c7 ex_ret_brn_resync
  PMCx28a ic_oc_mode_switch.{oc_ic_mode_switch|ic_oc_mode_switch}
  L3PMCx01 l3_request_g1.caching_l3_cache_accesses
  L3PMCx06 l3_comb_clstr_state.{other_l3_miss_typs|request_miss}

[1] Processor Programming Reference (PPR) for AMD Family 19h, Model 01h,
Revision B1 Processors - 55898 Rev 0.35 - Feb 5, 2021.

[2] Processor Programming Reference (PPR) for AMD Family 17h Model 71h,
Revision B0 Processors, 56176 Rev 3.06 - Jul 17, 2019.

[3] Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019.

All of the PPRs can be found at:

https://bugzilla.kernel.org/show_bug.cgi?id=206537

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
 .../pmu-events/arch/x86/amdzen3/branch.json   |  53 +++
 .../pmu-events/arch/x86/amdzen3/cache.json    | 402 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen3/core.json     | 137 ++++++
 .../arch/x86/amdzen3/data-fabric.json         |  98 ++++
 .../arch/x86/amdzen3/floating-point.json      | 139 ++++++
 .../pmu-events/arch/x86/amdzen3/memory.json   | 428 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen3/other.json    | 103 +++++
 .../arch/x86/amdzen3/recommended.json         | 214 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 9 files changed, 1575 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/recommended.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/branch.json b/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
new file mode 100644
index 000000000000..018a7fe94fb9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/branch.json
@@ -0,0 +1,53 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 Branch Prediction Overrides Existing Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 Branch Prediction Overrides Existing Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic Indirect Predictions.",
+    "PublicDescription": "The number of times a branch used the indirect predictor to make a prediction."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Decode Redirects",
+    "PublicDescription": "The number of times the instruction decoder overrides the predicted target."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. L1 Instruction TLB hit (1G page size).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. L1 Instruction TLB hit (2M page size).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. L1 Instrcution TLB hit (4K or 16K page size).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_tlb_rel",
+    "EventCode": "0x99",
+    "BriefDescription": "The number of ITLB reload requests."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/cache.json b/tools/perf/pmu-events/arch/x86/amdzen3/cache.json
new file mode 100644
index 000000000000..fa1d7499a2e3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/cache.json
@@ -0,0 +1,402 @@
+[
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache reads (including hardware and software prefetch).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache stores.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache shared reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Instruction cache reads.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache state change requests. Request change to writable, check L2 for current state.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). PrefetchL2Cmd.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). L2 Prefetcher. All prefetches accepted by L2 pipeline, hit or miss. Types of PF and L2 hit/miss broken out in a separate perfmon event.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_request_g1.group2",
+    "EventCode": "0x60",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_request_g1.all_no_prefetch",
+    "EventCode": "0x60",
+    "UMask": "0xf9"
+  },
+  {
+    "EventName": "l2_request_g2.group1",
+    "EventCode": "0x61",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g1 (PMCx060).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized non-cacheable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized non-cacheable.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_request_g2.smc_inval",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Self-modifying code invalidates.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_originator",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus locks.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_responses",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus lock response.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
+    "EventCode": "0x62",
+    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_write",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB write requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB close requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_wcb_req.zero_byte_store",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB zero byte store requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_wcb_req.cl_zero",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB cache line zeroing requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache shared read hit in L2",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit in L2. Modifiable.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit non-modifiable line in L2.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache store or state change hit in L2.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache request miss in L2 (all types). Use l2_cache_misses_from_dc_misses instead.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit modifiable line in L2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit non-modifiable line in L2.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2. Use l2_cache_misses_from_ic_miss instead.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache requests in L2.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2 and Data cache request miss in L2 (all types).",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request hit in L2 and Data cache request hit in L2 (all types).",
+    "UMask": "0xf6"
+  },
+  {
+    "EventName": "l2_fill_pending.l2_fill_busy",
+    "EventCode": "0x6d",
+    "BriefDescription": "Cycles with fill pending from L2. Total cycles spent with one or more fill requests in flight from L2.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_pf_hit_l2",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetch hit in L2. Use l2_cache_hits_from_l2_hwpf instead.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetcher hits in L3. Counts all L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit the L3.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetcher misses in L3. Counts all L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ic_fw32",
+    "EventCode": "0x80",
+    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
+  },
+  {
+    "EventName": "ic_fw32_miss",
+    "EventCode": "0x81",
+    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "Instruction Cache Refills from L2. The number of 64 byte instruction cache line was fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "Instruction Cache Refills from System. The number of 64 byte instruction cache line fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "L1 ITLB Miss, L2 ITLB Hit. The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.coalesced_4k",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of valid fills into the ITLB originating from the LS Page-Table Walker. Tablewalk requests are issued for L1-ITLB and L2-ITLB misses. Walk for >4K Coalesced page.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of valid fills into the ITLB originating from the LS Page-Table Walker. Tablewalk requests are issued for L1-ITLB and L2-ITLB misses. Walk for 1G page.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of valid fills into the ITLB originating from the LS Page-Table Walker. Tablewalk requests are issued for L1-ITLB and L2-ITLB misses. Walk for 2M page.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of valid fills into the ITLB originating from the LS Page-Table Walker. Tablewalk requests are issued for L1-ITLB and L2-ITLB misses. Walk to 4K page.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_snp_re_sync",
+    "EventCode": "0x86",
+    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_any",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ic_cache_inval.l2_invalidating_probe",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS). The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ic_cache_inval.fill_invalidated",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to overwriting fill response. The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.all_instruction_cache_accesses",
+    "EventCode": "0x18e",
+    "BriefDescription": "All Instruction Cache Accesses. Counts various IC tag related hit and miss events.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.instruction_cache_miss",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction Cache Miss. Counts various IC tag related hit and miss events.",
+    "UMask": "0x18"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction Cache Hit. Counts various IC tag related hit and miss events.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC Mode Switch. OC to IC mode switch.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC Mode Switch. IC to OC mode switch.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "op_cache_hit_miss.all_op_cache_accesses",
+    "EventCode": "0x28f",
+    "BriefDescription": "All Op Cache accesses. Counts Op Cache micro-tag hit/miss events",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "op_cache_hit_miss.op_cache_miss",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op Cache Miss. Counts Op Cache micro-tag hit/miss events",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "op_cache_hit_miss.op_cache_hit",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op Cache Hit. Counts Op Cache micro-tag hit/miss events",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types. All L3 cache Requests",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1",
+    "EventCode": "0x9a",
+    "BriefDescription": "L3 Misses by Request Type. Ignores SliceID, EnAllSlices, CoreID, EnAllCores and ThreadMask. Requires unit mask 0xFF to engage event for counting.",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/core.json b/tools/perf/pmu-events/arch/x86/amdzen3/core.json
new file mode 100644
index 000000000000..4e27a2be359e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/core.json
@@ -0,0 +1,137 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired Instructions."
+  },
+  {
+    "EventName": "ex_ret_ops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired Ops. Use macro_ops_retired instead.",
+    "PublicDescription": "The number of macro-ops retired."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired Branch Instructions.",
+    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired branch instructions, that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired Taken Branch Instructions.",
+    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired Far Control Transfers.",
+    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_brn_resync",
+    "EventCode": "0xc7",
+    "BriefDescription": "Retired Branch Resyncs.",
+    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired Near Returns.",
+    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired Near Returns Mispredicted.",
+    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of indirect branches retired that were not correctly predicted. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction. Note that only EX mispredicts are counted."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "MMX instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "x87 instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_ret_ind_brch_instr",
+    "EventCode": "0xcc",
+    "BriefDescription": "Retired Indirect Branch Instructions. The number of indirect branches retired."
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired Conditional Branch Instructions."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Div Cycles Busy count."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Div Op Count."
+  },
+  {
+    "EventName": "ex_ret_msprd_brnch_instr_dir_msmtch",
+    "EventCode": "0x1c7",
+    "BriefDescription": "Retired Mispredicted Branch Instructions due to Direction Mismatch",
+    "PublicDescription": "The number of retired conditional branch instructions that were not correctly predicted because of a branch direction mismatch."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_ret_fused_instr",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Counts retired Fused Instructions."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json b/tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
new file mode 100644
index 000000000000..40271df40015
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
@@ -0,0 +1,98 @@
+[
+  {
+    "EventName": "remote_outbound_data_controller_0",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 0",
+    "EventCode": "0x7c7",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_1",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 1",
+    "EventCode": "0x807",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_2",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 2",
+    "EventCode": "0x847",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_3",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 3",
+    "EventCode": "0x887",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_0",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x07",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_1",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x47",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_2",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x87",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_3",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0xc7",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_4",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x107",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_5",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x147",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_6",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x187",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_7",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x1c7",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
new file mode 100644
index 000000000000..98cfcb9c78ec
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
@@ -0,0 +1,139 @@
+[
+  {
+    "EventName": "fpu_pipe_assignment.total",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps.",
+    "PublicDescription": "Total number of fp uOps. The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps assigned to pipe 3.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one-cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 3.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps assigned to pipe 2.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps assigned to pipe 1.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 1.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps  on pipe 0.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 0.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "All FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply-Accumulate FLOPs. Each MAC operation is counted as 2 FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPs. The number of events logged per cycle can vary from 0 to 64. This event requires the use of the MergeEvent since it can count above 15 events per cycle. See 2.1.17.3 [Large Increment per Cycle Events]. It does not provide a useful count without the use of the MergeEvent.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Divide/square root FLOPs. This is a retire-based event. The number of retired SSE/AVX FLOPs. The number of events logged per cycle can vary from 0 to 64. This event requires the use of the MergeEvent since it can count above 15 events per cycle. See 2.1.17.3 [Large Increment per Cycle Events]. It does not provide a useful count without the use of the MergeEvent.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply FLOPs. This is a retire-based event. The number of retired SSE/AVX FLOPs. The number of events logged per cycle can vary from 0 to 64. This event requires the use of the MergeEvent since it can count above 15 events per cycle. See 2.1.17.3 [Large Increment per Cycle Events]. It does not provide a useful count without the use of the MergeEvent.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Add/subtract FLOPs. This is a retire-based event. The number of retired SSE/AVX FLOPs. The number of events logged per cycle can vary from 0 to 64. This event requires the use of the MergeEvent since it can count above 15 events per cycle. See 2.1.17.3 [Large Increment per Cycle Events]. It does not provide a useful count without the use of the MergeEvent.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.optimized",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Scalar Ops optimized. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass). This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops eliminated. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE/AVX bottom-executing ops retired. The number of serializing Ops retired.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE/AVX control word mispredict traps. The number of serializing Ops retired.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 bottom-executing ops retired. The number of serializing Ops retired.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits. The number of serializing Ops retired.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. YMM spill fault.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. YMM fill fault.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. XMM fill fault.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. x87 fill fault.",
+    "UMask": "0x01"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/memory.json b/tools/perf/pmu-events/arch/x86/amdzen3/memory.json
new file mode 100644
index 000000000000..a2833955dcd2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/memory.json
@@ -0,0 +1,428 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons. Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason.",
+    "PublicDescription" : "Store-to-load conflicts: A load was unable to complete due to a non-forwardable conflict with an older store. Most commonly, a load's address range partially but not completely overlaps with an uncompleted older store. Software can avoid this problem by using same-size and same-alignment loads and stores when accessing the same data. Vector/SIMD code is particularly susceptible to this problem; software should construct wide vector stores by manipulating vector elements in registers using shuffle/blend/swap instructions prior to storing to memory, instead of using narrow element-by-element stores.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_hi_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. High speculative cacheable lock speculation succeeded.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_lo_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Low speculative cacheable lock speculation succeeded.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_locks.non_spec_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Non-speculative lock succeeded.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Comparable to legacy bus lock.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "The number of retired CLFLUSH instructions. This is a non-speculative event."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "The number of CPUID instructions retired."
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Load-op-Store Dispatch. Dispatch of a single op that performs a load from and store to the same memory address. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Dispatch of a single op that performs a memory store. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Dispatch of a single op that performs a memory load. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2b",
+    "BriefDescription": "Counts the number of SMIs received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2c",
+    "BriefDescription": "Counts the number of interrupts taken."
+  },
+  {
+    "EventName": "ls_rdtsc",
+    "EventCode": "0x2d",
+    "BriefDescription": "Number of reads of the TSC (RDTSC instructions). The count is speculative."
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Number of STLF hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
+    "EventCode": "0x37",
+    "BriefDescription": "A non-cacheable store and the non-cacheable commit buffer is full.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dc_accesses",
+    "EventCode": "0x40",
+    "BriefDescription": "Number of accesses to the dcache for load/store references.",
+    "PublicDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
+  },
+  {
+    "EventName": "ls_mab_alloc.all_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "All Allocations. Counts when a LS pipe allocates a MAB entry.",
+    "UMask": "0x7f"
+  },
+  {
+    "EventName": "ls_mab_alloc.hardware_prefetcher_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Hardware Prefetcher Allocations. Counts when a LS pipe allocates a MAB entry.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_mab_alloc.load_store_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Load Store Allocations. Counts when a LS pipe allocates a MAB entry.",
+    "UMask": "0x3f"
+  },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. DC prefetcher.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. Stores.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. Loads.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.mem_io_remote",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. From DRAM or IO connected in different Node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.ext_cache_remote",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. From CCX Cache in different Node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.mem_io_local",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. From DRAM or IO connected in same node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.ext_cache_local",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. From cache of different CCX in same node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.int_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. From L3 or different L2 in same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.lcl_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. From Local L2 to the core.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.mem_io_remote",
+    "EventCode": "0x44",
+    "BriefDescription": "Any Data Cache Fills by Data Source. From DRAM or IO connected in different Node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.ext_cache_remote",
+    "EventCode": "0x44",
+    "BriefDescription": "Any Data Cache Fills by Data Source. From CCX Cache in different Node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.mem_io_local",
+    "EventCode": "0x44",
+    "BriefDescription": "Any Data Cache Fills by Data Source. From DRAM or IO connected in same node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.ext_cache_local",
+    "EventCode": "0x44",
+    "BriefDescription": "Any Data Cache Fills by Data Source. From cache of different CCX in same node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.int_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any Data Cache Fills by Data Source. From L3 or different L2 in same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.lcl_l2",
+    "EventCode": "0x44",
+    "BriefDescription": "Any Data Cache Fills by Data Source. From Local L2 to the core.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "All L1 DTLB Misses or Reloads. Use l1_dtlb_misses instead.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that also missed in the L2 TLB.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that also missed in the L2 TLB.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload coalesced page that also missed in the L2 TLB.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that missed the L2 TLB.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that hit in the L2 TLB.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that hit in the L2 TLB.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a coalesced page that hit in the L2 TLB.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that hit in the L2 TLB.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_tablewalker.iside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on I-side.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 1.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 0.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_tablewalker.dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on D-side.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 1.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 0.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_misal_loads.ma4k",
+    "EventCode": "0x47",
+    "BriefDescription": "The number of 4KB misaligned (i.e., page crossing) loads.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_misal_loads.ma64",
+    "EventCode": "0x47",
+    "BriefDescription": "The number of 64B misaligned (i.e., cacheline crossing) loads.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_pref_instr_disp",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative).",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchNTA instruction. See docAPM3 PREFETCHlevel.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchW instruction. See docAPM3 PREFETCHW.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchT0, T1 and T2 instructions. See docAPM3 PREFETCHlevel.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.mem_io_remote",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From DRAM or IO connected in different Node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.ext_cache_remote",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From CCX Cache in different Node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.mem_io_local",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From DRAM or IO connected in same node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.ext_cache_local",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From cache of different CCX in same node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.int_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From L3 or different L2 in same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.lcl_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. From Local L2 to the core.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.mem_io_remote",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM or IO connected in different Node.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.ext_cache_remote",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From CCX Cache in different Node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.mem_io_local",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From DRAM or IO connected in same node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.ext_cache_local",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From cache of different CCX in same node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.int_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From L3 or different L2 in same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.lcl_l2",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. From Local L2 to the core.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_alloc_mab_count",
+    "EventCode": "0x5f",
+    "BriefDescription": "Count of Allocated Mabs",
+    "PublicDescription": "This event counts the in-flight L1 data cache misses (allocated Miss Address Buffers) divided by 4 and rounded down each cycle unless used with the MergeEvent functionality. If the MergeEvent is used, it counts the exact number of outstanding L1 data cache misses. See 2.1.17.3 [Large Increment per Cycle Events]."
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Cycles not in Halt."
+  },
+  {
+    "EventName": "ls_tlb_flush.all_tlb_flushes",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes. Requires unit mask 0xFF to engage event for counting. Use all_tlbs_flushed instead",
+    "UMask": "0xff"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/other.json b/tools/perf/pmu-events/arch/x86/amdzen3/other.json
new file mode 100644
index 000000000000..7da5d0791ea3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/other.json
@@ -0,0 +1,103 @@
+[
+  {
+    "EventName": "de_dis_uop_queue_empty_di0",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles where the Micro-Op Queue is empty."
+  },
+  {
+    "EventName": "de_dis_cops_from_decoder.disp_op_type.any_integer_dispatch",
+    "EventCode": "0xab",
+    "BriefDescription": "Any Integer dispatch. Types of Oops Dispatched from Decoder.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dis_cops_from_decoder.disp_op_type.any_fp_dispatch",
+    "EventCode": "0xab",
+    "BriefDescription": "Any FP dispatch. Types of Oops Dispatched from Decoder.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_flush_recovery_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. FP Flush recovery stall.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. FP scheduler resource stall. Applies to ops that use the FP scheduler.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. Floating point register file resource stall. Applies to all FP ops that have a destination register.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.taken_brnch_buffer_rsrc",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. Taken branch buffer resource stall.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Scheduler miscellaneous resource stall.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.store_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. Store Queue resource stall. Applies to all ops with store semantics.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.load_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. Load Queue resource stall. Applies to all ops with load semantics.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a Token Stall. Also counts cycles when the thread is not selected to dispatch but would have been stalled due to a Token Stall. Integer Physical Register File resource stall. Integer Physical Register File, applies to all ops that have an integer destination register.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Insufficient Retire Queue tokens available.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.agsq_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch3_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. No tokens for Integer Scheduler Queue 3 available.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. No tokens for Integer Scheduler Queue 2 available.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. No tokens for Integer Scheduler Queue 1 available.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls2.int_sch0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. No tokens for Integer Scheduler Queue 0 available.",
+    "UMask": "0x01"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
new file mode 100644
index 000000000000..988cf68ae825
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
@@ -0,0 +1,214 @@
+[
+  {
+    "MetricName": "branch_misprediction_ratio",
+    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-Speculative)",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "100%"
+  },
+  {
+    "EventName": "all_data_cache_accesses",
+    "EventCode": "0x29",
+    "BriefDescription": "All L1 Data Cache Accesses",
+    "UMask": "0x07"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses",
+    "BriefDescription": "All L2 Cache Accesses",
+    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_accesses_from_ic_misses",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Misses (including prefetch)",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_accesses_from_dc_misses",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (including prefetch)",
+    "UMask": "0xe8"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
+    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_misses",
+    "BriefDescription": "All L2 Cache Misses",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_misses_from_ic_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misses",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_misses_from_dc_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
+    "UMask": "0x08"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Misses from L2 Cache HWPF",
+    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_hits",
+    "BriefDescription": "All L2 Cache Hits",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_hits_from_ic_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "l2_cache_hits_from_dc_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "l2_cache_hits_from_l2_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 Cache Hits from L2 Cache HWPF",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l3_cache_accesses",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 Cache Accesses",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_misses",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 Misses (includes cacheline state change requests)",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "MetricName": "l3_read_miss_latency",
+    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
+    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1core clocks"
+  },
+  {
+    "MetricName": "op_cache_fetch_miss_ratio",
+    "BriefDescription": "Op Cache (64B) Fetch Miss Ratio",
+    "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit_miss.all_op_cache_accesses)",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "ic_fetch_miss_ratio",
+    "BriefDescription": "Instruction Cache (32B) Fetch Miss Ratio",
+    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_tag_hit_miss.all_instruction_cache_accesses)",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "100%"
+  },
+  {
+    "EventName": "l1_data_cache_fills_from_memory",
+    "EventCode": "0x44",
+    "BriefDescription": "L1 Data Cache Fills: From Memory",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "l1_data_cache_fills_from_remote_node",
+    "EventCode": "0x44",
+    "BriefDescription": "L1 Data Cache Fills: From Remote Node",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "l1_data_cache_fills_from_within_same_ccx",
+    "EventCode": "0x44",
+    "BriefDescription": "L1 Data Cache Fills: From within same CCX",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "l1_data_cache_fills_from_external_ccx_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "L1 Data Cache Fills: From External CCX Cache",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "l1_data_cache_fills_all",
+    "EventCode": "0x44",
+    "BriefDescription": "L1 Data Cache Fills: All",
+    "UMask": "0xff"
+  },
+  {
+    "MetricName": "l1_itlb_misses",
+    "BriefDescription": "L1 ITLB Misses",
+    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_miss",
+    "MetricGroup": "tlb"
+  },
+  {
+    "EventName": "l2_itlb_misses",
+    "EventCode": "0x85",
+    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l1_dtlb_misses",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Misses",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_dtlb_misses",
+    "EventCode": "0x45",
+    "BriefDescription": "L2 DTLB Misses & Data page walks",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "all_tlbs_flushed",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLBs Flushed",
+    "UMask": "0xff"
+  },
+  {
+    "MetricName": "macro_ops_dispatched",
+    "BriefDescription": "Macro-ops Dispatched",
+    "MetricExpr": "de_dis_cops_from_decoder.disp_op_type.any_integer_dispatch + de_dis_cops_from_decoder.disp_op_type.any_fp_dispatch",
+    "MetricGroup": "decoder"
+  },
+  {
+    "EventName": "sse_avx_stalls",
+    "EventCode": "0x0e",
+    "BriefDescription": "Mixed SSE/AVX Stalls",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "macro_ops_retired",
+    "EventCode": "0xc1",
+    "BriefDescription": "Macro-ops Retired"
+  },
+  {
+    "MetricName": "all_remote_links_outbound",
+    "BriefDescription": "Approximate: Outbound data bytes for all Remote Links for a node (die)",
+    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_data_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data_controller_3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3e-5MiB"
+  },
+  {
+    "MetricName": "nps1_die_to_dram",
+    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
+    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.1e-5MiB"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 2f2a209e87e1..9f97b32533a0 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -38,4 +38,4 @@ GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
-AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2,core
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen3,core
-- 
2.17.1

