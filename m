Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46D4C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 21:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FC061002
	for <linux-perf-users@archiver.kernel.org>; Mon,  4 Oct 2021 21:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbhJDVnZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:43:25 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:6849
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235167AbhJDVnY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Oct 2021 17:43:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDcwBnyThZRZZ6JLP4w1RB2Q0InLHTEZ490jieRlwab9tAs/BFaExUo1ytmayCpAegwqLxBzQl23+AOYxM9JRO1Ue/lxC9RJsnmzBDNcSVrIytbPKwhSRqbFjZw6KdoOhYPowXu1g6mhitatywQNNgbGFj0WqY2GEsNOZNYxFokvViiYEucnrkZ4KgKecKynNDWq0C7CjM3yjkiyXXGj/rkpIx6gif1uZ/3GauyXc7Ft2gl/Mmkqmi5GFrXD5u26aR3iW3Ft+x4l1lKsMdEPJ5wj1/QP9l/kUWBI2lN4TPwiavmmpGiqs+TCqJ0jLE8v5nU/EXcQjwr4R0V6P7JKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq3vX9GviMwQJK9SKASuDT3FB77Zbebjg6N4hUsZBuo=;
 b=FyomedHlUz9qBeuPc+bed3L95sxD7BisnKobRtZ/dYxErfRAJzznjB4Nyyi49uQ/DQPHFepFXYAFjEnQVy7Dwrx+Q4LoEE8Yuo/uJ7Bs8vvdSxb35R8ffi0JuDn/wMu083Am/mvT2scNfWaH1rlD3yyQvz3t0QLpeWGabaJhhjEORac4WALXzJi1lLwg2R58K0WajNKufJryzxXiXEgA7YWGIByp1vZYZXTYhiuXfYei3fjxu8Yfai/2TEyfmLle5sLiKzHIb/KUkHpy9jEhLBlayiuvaaRkR67rUWicznksuMz/GSTOlBPZu3Rs+s3PSKdys2mRJdhElHR/kpCi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq3vX9GviMwQJK9SKASuDT3FB77Zbebjg6N4hUsZBuo=;
 b=0Q6FBkdYYxLnZHkRYtpNeNFxOMPavKSdopnYFkXHxcBDQNMdsOmY1aBS5R8t35GgwrHRLZi0aCtgSnqhW/zZGUWZe8QlTjtfqhhs8HU8FvW7KX85aunf7ddkI5TvnG4SBh+11d6qg3EzbQ3K5o+7BsT+73iE7Fra/r9iXvluQYM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN7PR12MB2772.namprd12.prod.outlook.com (2603:10b6:408:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 21:41:32 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 21:41:32 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/2] perf evsel: Make evsel__env always return a valid env
Date:   Mon,  4 Oct 2021 16:41:13 -0500
Message-Id: <20211004214114.188477-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:806:24::15) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by SA9PR13CA0100.namprd13.prod.outlook.com (2603:10b6:806:24::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend Transport; Mon, 4 Oct 2021 21:41:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab9b4e2f-765b-4bf8-a0d7-08d9877fbb51
X-MS-TrafficTypeDiagnostic: BN7PR12MB2772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2772DE5B9748FD10172AAAF487AE9@BN7PR12MB2772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eG+p48r2SBk3dS3oUtIm/nR+3nU3sNASh2+80XAAAc2zK/BsXExfbPNX6AODtYnS5lAdxZhvkhrEJhBvlc0J63tG8SEOWX14c/kW3QFOBwIcMHa62aN2xI0cOH1hCthRAFrBeX4aS2pWtV6vvuSFi5QUkVEzg9oGrUCy6jEIYir9O87OQ8HyPmaY5HQ6hrQ9UwvFfJuXOD5kIOUCtn6otIwe/tHitxT4L9MY/Eo3msqf93A7SjD3yw3SJOa8I9VQJxSOaN4Q7gX8fwB+xLYGouMECubf9BH175+/q3TMD/SXye1dgvrs7k9CCF9tBkd+9d4GrUkka8M/8hNHUjXYQFFSQWvwwNGvgn6fsO/dKSBab+Yk9hWyJeeYX11BOFPpjQt3cqX2KzqVqoHJk0m0iVGdy0AhI08noLwg6YbvcNGftz46XfMcc2IY1OIGGqXmtQCo6w3uH9kffatZvTsKMDI/o552MQFe4uTXyHaR86P90XzA29qRFWl3nzl5R0D7gCAAIjUxFgg5x06mQgeK6peda3vzVkPTm9c++dGB2sLdmy5adzsJZDS1MkquB24LD74t0va/5/LX4XZ0sNgcZLnL651LE8Ghw6gQX1xMhZAhI7LgmZMF/SbZuSFFqkeFGgnsFFB2gnrppWXK+IQLeR/lECGzkMNMCG8TRNrsSL9alM6FuyRwEQ0gaTt46wSUphC6mKFA/GVIqXx0yVMw7gbjCuSgloIklscVG8IK/feiKDbsvvD/bBzMRffYJkA+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(8676002)(44832011)(86362001)(52116002)(26005)(66946007)(66476007)(66556008)(508600001)(7696005)(7416002)(6486002)(38100700002)(316002)(6666004)(1076003)(5660300002)(956004)(2616005)(38350700002)(83380400001)(36756003)(4326008)(2906002)(54906003)(186003)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0fVePb4QjEtrvhSobzWyD7oltC3M+unyX0dpBI1jFdnooa1BT1DwYS8fsuU?=
 =?us-ascii?Q?f0x6hMBzrJa4MxRWz7mU4Sns8ohBf+oYTzbun03F1aafsk3sLMwtFvzxG1Kz?=
 =?us-ascii?Q?6SB3mQHtCXnqRbZRierGG0eCTgIY+feMwQ/FBDi0A1xbMq6Lzn76I3+GNReE?=
 =?us-ascii?Q?JzH54Yu9/PmXMRUBFpXN3UCWNjBkNJhimsbAuOtEpK5/wRywMfb2Lg/Zsn1H?=
 =?us-ascii?Q?prGCS/UTvgwToyztJAgKKGAdhyrOt85plLhQohUF5Us65e8HDDi11Ks1KJWt?=
 =?us-ascii?Q?LoXC97mD3rOKe2cx1OtQSsVh2PeL+3iCS9s+IzuXMmXNl7tyu06Mo1U2STRq?=
 =?us-ascii?Q?ylpbF3V3rscls5ET8u3Ax0Q3nWB9+XlCKE4OmnseXJcrtpzEp5w+zzA39sbB?=
 =?us-ascii?Q?sii/UtUPebdhfJ3YfXa4u6AMuQsDbhQb55AN1BTwlwyZfZZPIRdo275HAe2b?=
 =?us-ascii?Q?ys0iBVo4KOi4kvNZ5F6YTzjXIO6CCb1pRfuJaHesGwjhvoUEw4iwUzby++Gx?=
 =?us-ascii?Q?DPjsnNycwe0Hz4QVseVqgI3gBT0RlYR4hkQPTkv1XAwvAc+K/mXlHLdE2INk?=
 =?us-ascii?Q?BCu+ApDaGREE4zC31OwXl1TK31w1KaN5inf0Hhj3FwAzVTga+fk0GR7vYouQ?=
 =?us-ascii?Q?PlPw6+yrxpeWwWQkUxw4QXo8IW5WnmpBOt335T/aHHd2+IQ5QIBVgg+kteEP?=
 =?us-ascii?Q?pYKX3vMIST6CGTFOll9x08Lm/C4Tv2kzhkaIr5Dp0s72HYZ5PkPQFEaZPcfm?=
 =?us-ascii?Q?KYdDFAXDgzbLV0V9FBAZRu9jD0pycB9XUL97xMijT/oenBp7fweybNarxBn3?=
 =?us-ascii?Q?MThN7vACOugnxjiHI/xgRacmkt8BlYnzL59X0SMDKJ4D8XlHygBwx/BUJDHt?=
 =?us-ascii?Q?AyV1GsZ9gmEd6KKAPNZPsW1lnjEwxVbOSRYbIodCeuyFtz6PO0KVszeuvOQM?=
 =?us-ascii?Q?aEMAJjna3ShN91DPq/xb7PS5qTyCKxVBFpuJFmpWclB5olNOIjQTtLWkQww8?=
 =?us-ascii?Q?cZg6ty45wniT7bgfCcDThKlBEJT4PeNbb7vGJvx1vkZpjbuHakQEQYjLV3qW?=
 =?us-ascii?Q?4QTrT+TjWGf3hBhd69f3vf/B1vkl3d5A1K4bXvOAxUf44QRrw+MjhhOviy5i?=
 =?us-ascii?Q?wY2CsEFcokWyaBfR93Ehac6G2OoyJR+taEr1OzsoXutSFtvSdXv8uybgx+eH?=
 =?us-ascii?Q?6l99+Cpa7Usq6YYT3cqxGqkyXIjDv8Ef2KzB/fkUG7WtlqkGYsXyP+YU+VC/?=
 =?us-ascii?Q?VxpHdtBMAu2/FxhWJt7SRHJTW0/VG2Nnmdx697Xq4mePPhPNWClgHNg8GaM3?=
 =?us-ascii?Q?QsEwx9omnbkPVAeSBqZrQTeO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9b4e2f-765b-4bf8-a0d7-08d9877fbb51
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 21:41:32.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiwXplgao2OPtSkWHmJT+Wnj5N7VLAAz9jVz4ZNIILZbWHqyG7Q/3nlr+kC3F0c06Jdxua6YVm5raRFLDWgWog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2772
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It's possible to have an evsel and evsel->evlist populated without
an evsel->evlist->env, when, e.g., cmd_record is in its error path.

Future patches will add support for evsel__open_strerror to be able
to customize error messaging based on perf_env__{arch,cpuid}, so
let's have evsel__env return &perf_env instead of NULL in that case.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <robert.richter@amd.com>
Cc: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..b915840690d4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2857,7 +2857,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist)
+	if (evsel && evsel->evlist && evsel->evlist->env)
 		return evsel->evlist->env;
 	return &perf_env;
 }
-- 
2.31.1

