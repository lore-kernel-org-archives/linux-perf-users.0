Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C478C433B4
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB69B613CC
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Apr 2021 22:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhDFWAI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:00:08 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:43740
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232271AbhDFWAI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Apr 2021 18:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRfJC1wMGbzITrXAMcz0C39AI5KlTNh8MZb3IYCPnopjsXtM29g/jaBuYkjQE3zN2Co8LBLCj4pRAlOBgsyLcm0xhah+BXwoUJ3mrrisLJUpTkv64nmGd1UhWJtuSVSAxPMNa+dNpcuQqdPVNL+8KttzvL7c0Aw4MapxkE3kpLi/sNCkYl4OCrCg7kybwyUT7fBypwn+G31fuWD64F1B3RvBXCvYLdvOdoT5423sGFUf8GmLc9GYbE2an7jqT5lpDS3V7y67/BXFK1HWW3wnYyob5/n/l9NQOc4dwJvPeCpKotLzOJbSd2fHqAAKg4LP3/yu7zmKsZ4m0dCA42gR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXYN2x7XGzaAYkk4DXlGNbt59fGPJZc9XwLZXsgo3Fg=;
 b=hr6qDFRuAQkEnDy3yYGAjyO81pHksQ1xYbn0UZoz/Rl7QJnIqvmCFvcT5fcdyF/fwh+pkEUW0Qnb++hq8BrYuawiqptHJoPkQcGB9M5FXqhZJ0TP0scXlwtmHQ6FL1efxUfdMaBsW2/hDkEe95yLHSFa2Keo8Zm6UGvfhUiBo9tkUfqXrPKZvon6DJ6+ZKEaK17Ma+RYW7RV2rWi8d0tpY0TE25IpVS9sV9h9rqMwh2FXxNqJJ0YRMPU+I84ijXWWm+Xx9IMscKhi9HktCRVLxYkV3AgC7Qlcl8Uqy8J1nZ+K41VttH725AjGb+i10oPtIbeA8Bz8JYyibtv6sv6eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXYN2x7XGzaAYkk4DXlGNbt59fGPJZc9XwLZXsgo3Fg=;
 b=MMzi6dHvZz+upY9eIC29pc5Fm4awlkifmAz0RJE9B1IlInuBhxoY5Xwd6PA6w+6UpUuUr75hEulNGzLLXgX8F0fpAUQVBybQfqBFXWhNmNJIUOsUHZRM1Eg92yJxUeVMc8Q/88Ju/B3ExDsfz1Tp0yRlPtY/fNbvnP0HGLwQxY4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2685.namprd12.prod.outlook.com (2603:10b6:805:67::33)
 by SN6PR12MB2640.namprd12.prod.outlook.com (2603:10b6:805:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 21:59:58 +0000
Received: from SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28]) by SN6PR12MB2685.namprd12.prod.outlook.com
 ([fe80::6088:2ad2:8012:ff28%2]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 21:59:58 +0000
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
Subject: [PATCH 0/4] perf events vendor amd: Fixes, cleanups and updates for AMD Zen cores
Date:   Tue,  6 Apr 2021 16:59:40 -0500
Message-Id: <20210406215944.113332-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To SN6PR12MB2685.namprd12.prod.outlook.com
 (2603:10b6:805:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx50f7host.amd.com (165.204.78.2) by SA9PR13CA0028.namprd13.prod.outlook.com (2603:10b6:806:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 21:59:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01592ef-c8cb-4a59-cc5f-08d8f9475105
X-MS-TrafficTypeDiagnostic: SN6PR12MB2640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2640D5259E8A8A152D65F61A90769@SN6PR12MB2640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TUaUhN4/a1HJAVt3acgdqG4pR+gBIQBT+cTfrvLJFWH5PBKLOGTZgLvdb7mUfDa4vlH3XB5j+EINJh2n0eYa1576lUULDIjKhZ/wMDKE2yHLeN1n64gSY0ffJsDU67zdUw1qrR6iyaWNdnUcuUhj3eQkkaf6lyRi6EGJnDKXnPEtkKWL3/GFicRupCVjKS4vRe4lDZizG6u4PkI0fRa96J0zmPf+I0bZZ2V4Tnb7JpwN9yZ8CMJdzLNHuZ8dhuyBqJUUogkJEou4M7qbl1+Xa0MMwELwpxpHcVvrdWnBtvNkUWeTJvzzUbtSFNF2AiVUlHoOEOnXDRzHdf6WKri8PiWFLxUW46454hQvheeUev4GcACQivCo5potNGrEQTHweNpbXpaPohkLTBGX8Lqat1c/wAwcFRu5zRy44/a6r52RC7zoMksuhCHecXBMomJMJi0Ujp2Pwse9i1T0kMnPl4NSDy9Lj1XxuQnX/rE63Te6QSsazdyCehu3vcTTV/R38s/sF9P1UM8M68R8id58A5lveuC3RlmAVoo7QIix8AFrKwglq2eQW8FnyvBZaMFyYMOIT1gQ3+W66l4HFPb9TTgocekGUSimHqd6+IzQIuo3IhwGqKkUEwUGv+E50/NqoaJXAWRO6V2fGO+Q+i/b0GchnxEyOBi8IntIHV2Oh0rwOTCxMJ7UP2kbtnjy/CP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(4326008)(186003)(83380400001)(2616005)(16526019)(8676002)(1076003)(8936002)(38100700001)(66946007)(6486002)(66476007)(38350700001)(7416002)(478600001)(36756003)(52116002)(5660300002)(316002)(54906003)(2906002)(7696005)(6916009)(86362001)(956004)(66556008)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UG4zSmcrNWVINVB6ekJiazBaMnlqTVF3SlIvR2ZnbVVaZW90OE5MRjByY0R4?=
 =?utf-8?B?RnZhd3lFY3FTcW5mQTZaTnYxVkcxYkFobkFRaDd6YVkwU09LVWRNOVNIbWI1?=
 =?utf-8?B?NXUzYy9CeVBuWGtXb1hRR3N0UWRPWWordllqbWNTZkJmZjhlMStoRjNycVhw?=
 =?utf-8?B?UVBSNGx2aHFqemlYNXdMT3dENmRBV1dKeEx6Y2dVd00yaUNmK0RNajdPb295?=
 =?utf-8?B?dmoyQnpXOFp1RTZLQlR4Y1hKMmd3YURaYkd5dml5Nm5kK3ljNDBoY2tsMXMx?=
 =?utf-8?B?RXljaWdiczVaaktrRXROYXpKOVA5cklWUlJSR3crYllBZkFxazhzUjVRY2lY?=
 =?utf-8?B?aTVtdXZUYWo2TExVTkxMcUl5ZG9maWdUOU1JWlM0cHlFdWdmYVVlamc1c055?=
 =?utf-8?B?Q1lOQWVyQytYSUF5VXhCeEpVNFlYZWMrbERDdEI2UG1Ic2RzOTNPQm1JVC9C?=
 =?utf-8?B?RHpPZVVhN3FmUWxYUDBvYk90TWxHNzNWM1JTeU1XbzRjTTVqSCsxbGhZakRB?=
 =?utf-8?B?ZmtmdFBNbjZOS3oybmFzZE8vcVNUK2xqSld5ZTlLV1dGdjdFTUhOdFBGTkJh?=
 =?utf-8?B?Wit5eVM1TE90eU1TZUpjNGxwUyswRUhoRUl2eTJ2UVR6RUwvSjduSVh2dk1M?=
 =?utf-8?B?Uzg1aHU3SllxUVZqdzlueGZ2T20wOEdsV1piT1NQQVRDbmZnOGhTVllmTVoy?=
 =?utf-8?B?Q2dhSWx2cUM4LzkzaU1PYkh3b2dCSXlSSjB1UnBwMnByMitTRUljbXNIUFZl?=
 =?utf-8?B?Y3puTXNpMmI1SmV6NUdSb0dtSk1ZNjhsY0pUL1Nid0JLSldvNlQwUjNsL1l4?=
 =?utf-8?B?ZldIRVY1STd6R2kzZjEwUm1DM05yZTYyc1cvU3dmVmtWQmlSUU1iSUlQYXdm?=
 =?utf-8?B?WUtFcUozUmlOZlRLTlNMTm1xL0FDVHBmU1UxeElZS2EzYjZibTFCTVI2L3Bv?=
 =?utf-8?B?cmwzRzJML3VZMVI1dStqdDU4K2tWcnRLM1lIaWJtbzA3OE9zUHc4Qk9PTEpn?=
 =?utf-8?B?L1VhWTM0YmtsWThlaEFmditIa0hWSFhRR1ViOUduMmV1bmU2bi9jWFZJQXFn?=
 =?utf-8?B?UG1SUFpvMHNtMUl5Z2dYaVFzRkpNYlBqTHBJbGc1VTIyay80RDdEa3RXa3BP?=
 =?utf-8?B?b1hXRjlYUGhpZmdxaGVyeU1XbTc0eWRmTC9BOE5NS1pNZDVHdnZFaFFvM3Y1?=
 =?utf-8?B?bTB2dy9Bb214SGRMQ3FkT3Z2UnV1QnNERzEyc2ZkcnFTVG5qbmRoT2JsTzg0?=
 =?utf-8?B?VUdUdFEzNExIVmNrQXZyTW4rYytIemNjdTBmL1RZN0crUldHbWRZb3U3RmVY?=
 =?utf-8?B?Z1VQeGgwYVZEZnNRbnZLMnBxUDIvdnFKM2tOS0Yrdm4rV3dqNFptNTZjSGxX?=
 =?utf-8?B?VHByWDJHWnFUS2VvK21XQ1d3QTJ3TUZYOWFhQXFxT0ZzTnJobkdpS00rYlNP?=
 =?utf-8?B?ZEdVYU5KNG9RM0ladXNxZU5NakZld2JjYjhyZExDbTg0L3FZdHhCeTNLV25P?=
 =?utf-8?B?TkFhc29ZOHQ3eDdKSUNqNWFuOUc0aWZQQ0Q3U3cyZzRUK0toRldEbWh3ZSt0?=
 =?utf-8?B?VjhKWU84dS9OSDRrSlUwQmFMVVlUKytjSmFQSDBhRlpDTjJodlhsRHpkS1V3?=
 =?utf-8?B?eTlqWDZaZytXRmI5YlBQWW1xTWFRdTIzc050M1BMTmNoem1ya3dDbVZKL2JJ?=
 =?utf-8?B?S3dFTDR4ZjZkd3dyaytuRHpxai9iTElzYzFjekdYVHd3QlMzSWVvazY1QUxu?=
 =?utf-8?Q?pJ/lIK7AH5iB8AgLbwVo6Og1bmvk4V7pS76j4IW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01592ef-c8cb-4a59-cc5f-08d8f9475105
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 21:59:58.2097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctThmhQDpwIuG8W3s/oFoojGt7ayWtCqxDclFIjb0T0m8rKdVnsLHe0NlkaMgwYqma5nPC/xUHkeQXE3GNQbLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This series of patches provides a fix for the broken metric and does some
cleanup for AMD Zen1/Zen2 cores. Additionally, adds Zen3 events.

The first patch fixes broken L2 Cache Hits from L2 HWPF recommended event.

The second and third patches addresses the inconsistency by defaulting all
event codes and umask values to use lower cases and 0x%02x as their
format.

The final patch adds Zen3 events.

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

Smita Koralahalli (4):
  perf vendor events amd: Fix broken L2 Cache Hits from L2 HWPF metric
  perf vendor events amd: Use lowercases for all the eventcodes and umasks
  perf vendor events amd: Use 0x%02x format for event code and umask
  perf vendor events amd: Add Zen3 events

 .../pmu-events/arch/x86/amdzen1/cache.json    |  48 +-
 .../pmu-events/arch/x86/amdzen1/core.json     |  12 +-
 .../arch/x86/amdzen1/floating-point.json      |  42 +-
 .../pmu-events/arch/x86/amdzen1/memory.json   |  42 +-
 .../pmu-events/arch/x86/amdzen1/other.json    |  12 +-
 .../arch/x86/amdzen1/recommended.json         |   8 +-
 .../pmu-events/arch/x86/amdzen2/branch.json   |   8 +-
 .../pmu-events/arch/x86/amdzen2/cache.json    |  60 +--
 .../pmu-events/arch/x86/amdzen2/core.json     |  12 +-
 .../arch/x86/amdzen2/floating-point.json      |  42 +-
 .../pmu-events/arch/x86/amdzen2/memory.json   |  86 ++--
 .../pmu-events/arch/x86/amdzen2/other.json    |  20 +-
 .../arch/x86/amdzen2/recommended.json         |   8 +-
 .../pmu-events/arch/x86/amdzen3/branch.json   |  53 +++
 .../pmu-events/arch/x86/amdzen3/cache.json    | 402 ++++++++++++++++
 .../pmu-events/arch/x86/amdzen3/core.json     | 137 ++++++
 .../arch/x86/amdzen3/data-fabric.json         |  98 ++++
 .../arch/x86/amdzen3/floating-point.json      | 139 ++++++
 .../pmu-events/arch/x86/amdzen3/memory.json   | 428 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen3/other.json    | 103 +++++
 .../arch/x86/amdzen3/recommended.json         | 214 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 22 files changed, 1775 insertions(+), 201 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/recommended.json

-- 
2.17.1

