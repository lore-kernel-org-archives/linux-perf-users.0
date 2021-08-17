Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D2AC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3328260720
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Aug 2021 22:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbhHQWMP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:12:15 -0400
Received: from mail-mw2nam08on2053.outbound.protection.outlook.com ([40.107.101.53]:12976
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235617AbhHQWMP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Aug 2021 18:12:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAo2osm14zAo0FL52hxiz73B/sN1814IMzh96tXSD/WSTwKDASbbTE6usxdmJ7ZDHCd2LIT2+OiKoZ7qczfGVr94JaHZJMVh68mvx0GjTl6M8wPlkHmBGv51GgZchg680sNtBtTwVBiB1KE7KujTvcrZzuzJfpDB9zpv0I50FBUs3cnXbdpIow0j68ehnR+twZkLwiQbwLzwt+yl/OaZ2JzLRYFESuoxWECHV5+UaGl8S659FtPp6AkxcqpQeF0pCawZ0gZpd3ukezY8wJBq02o0gt9Zv3j/KoXFZjMrIWo3EOYOaGUqbdDGDSt7x0ovB9M28xwJOWGscspEOketog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apBM7GHuEWObjaCqBtaOYF4Ja1fWa4FmM7/3LP7Y6kw=;
 b=DXP+gTlfuGkLKotQ+zowp12U4pF50V5Ar6qRZfN1HHn/q2+K6dRKOoU2RZxt1pSDjI3Df7zVN9Li0zOxzgUcw3v8NwBRIkdXMW2axhzxSjpHrVJJZJdPn1/hUERFp2HSfYLznwPYCTm9mHC+kLEzZyoYyigKK5Dwfdnveku+ekhQmSyFSn7bqdjI1DV/tk+HT3Syncya/RoqzVQvVGiaJNVjXP0c3eApc6bKFjMxTDI9SAkWAueiIKxzVQXsIzkpHiiTK+L4MFHtukNdYhFT7f19HgpasTICPsT4pNAbB0u52+75zLxQmFeFUFmoTjiUdh4le41WHgUviHItEoXEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apBM7GHuEWObjaCqBtaOYF4Ja1fWa4FmM7/3LP7Y6kw=;
 b=JeFKUEB8qR6mWeV7GJAzMcjxi1nw5ahoaH+wMen5tlpI/qPXqBKR+v1wQUzZDe68Vs6aJxM1flNEM6dQXYsEj1xn7OCmRfu6Fh//HUFy+k8fRva3E5FH8JV+q/34IdKP2auA34OPZYFHyEL0wc+96EfyASkyMVM3Gavk6fkxJfs=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Tue, 17 Aug
 2021 22:11:38 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::8836:fe8d:8e90:a420%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 22:11:38 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 2/8] perf/x86/amd/ibs: Add workaround for erratum #1,197
Date:   Tue, 17 Aug 2021 17:10:42 -0500
Message-Id: <20210817221048.88063-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210817221048.88063-1-kim.phillips@amd.com>
References: <20210817221048.88063-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0053.namprd02.prod.outlook.com
 (2603:10b6:803:20::15) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by SN4PR0201CA0053.namprd02.prod.outlook.com (2603:10b6:803:20::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend Transport; Tue, 17 Aug 2021 22:11:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 007aea88-a3cc-4e3b-03ce-08d961cbfbd7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3505:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB35050619DA2B3BB2173487F887FE9@BN8PR12MB3505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P0v07ZLCaiNbJEyFaZrHDOE8shM469iSPAW49zsNFqknsc0mt3x5xW4qqEPpKgciQ0s464IJvVZfywenymJwB/lrrr2WCY3Qze0SQzVg0cRfXd9ptviKFyWVwhHkJaRozhk0GemY7EcKOib3Xcoojh9HySZtbUz8Rq7E9cCLovgaNkbQs2bDQFPHH/ZhC6dH+VZisfj44CaFDcGt+/rb31GC71HACqR7UGNUrrf6Sbk1QPbnR6SYlECOPF8gDtNW66X/NGPQxLkmin7clKRLfBETeWRpS/iuPjBkuiTRkzWabRqRbifL4DESvXwQlo9+L679XG4JRq3UqNO0gW35G8Is3oh82lTLcf9MGv50nw2FfIpUVuypAA2/5Oeh04VOVjKF+QHH/+Hw5zSVCTumBI5AACQrSlnE4C/V7063puLRp/ZUeIRy0Dha/F87YRCortvmbXs7bc99GpF0yUtTMbN4Ml6P4YgzhT6xDcdamieizslCO5KoWDVlAQjpVuA5EjB1nRwlhNvR25rETka81uwQRUdvo9OnBzKSnetAOIqNAlAm39CVxq6bIzO/36KNsofb1thqokALT/Qa/M5wrFEBjk34FaPCVPHTCgvNw36LfXtSaXs4RhrS2QBpD4ChnU5pjE17uWAWawiXCEc8bGEUb5Kja1WhyjCc2nzqjE5qdOyfjBvcfHWs90r3/q5ntuIBsJgtlj62FQfmQNL0KWa8CwZ8Lhnb4Re6oaQDq+Vpd4YrI7ZgFz+jqY8TkEjHQIw8dMnahXZWXit6twDp/V3eo4GwwlgA3xm/lSsNFAcZjrMrbLyxV7j9nOQUj+S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(38350700002)(66946007)(52116002)(110136005)(86362001)(54906003)(6486002)(2906002)(66556008)(83380400001)(66476007)(186003)(26005)(7696005)(7049001)(5660300002)(956004)(36756003)(478600001)(8936002)(7416002)(1076003)(6666004)(8676002)(44832011)(966005)(4326008)(2616005)(316002)(38100700002)(17413003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/enSDV1URvjwQoVbRkgknQJv7kj6SGEU/5ZSUvm8W6lBdwc9X4PoB/vKlplZ?=
 =?us-ascii?Q?z93DrPwFXNe2l7himxNPip76PDvBEdMAKuPW18yM2sZ3287MH2gBRhk4aaJj?=
 =?us-ascii?Q?ImaYHWW9sa9lBGB284RxwiOARpXVLtUrKNsjKwda/FQOVY0jAt3ABZ3VIvlZ?=
 =?us-ascii?Q?LViI19/zapdN3RgrsoUBmrS9pLBtNzPzWstMB7ShHofFND8C2uIvF/8m4lN0?=
 =?us-ascii?Q?4isc4VNi2BnVs5Cu4jf/LSk7otOVIi2bE6IIgfx6dE7OG2tF1sRMakC0fxpK?=
 =?us-ascii?Q?ockw3Wxye2gj080q+3aFLPrWoPWJk0/JupTRck8fV6ydkIFwX2fDBfrwaHyI?=
 =?us-ascii?Q?zGSVfTxAsivFfa0IDHji80Anqo3Z7LS9NtWrg3aHCWE57dfVem+yEpASOMY/?=
 =?us-ascii?Q?/97OTMFE+s7U2rtL9BgB+wqj4K7KNEkMhvnnkJKSQ+waGQP/akVc8TX9BWcf?=
 =?us-ascii?Q?TNuHL/sA1SNCjsQ7GjVLgJmEGd3j+/WBWF7zfKnalx38JIxVeP+2e9zoT4BZ?=
 =?us-ascii?Q?Y5vSZsf2pDVr/OtEsnMZiZDJ7hlNreUQ9dno88Mb+DgqpgWoDOqFt8K0e16A?=
 =?us-ascii?Q?JHLyz6w2Vx0wKem4l0LzNFFgFOj7rU30+vAERRO9XGpR+PoTPZD5yMRdNDXP?=
 =?us-ascii?Q?teTi9AysWkxn7XfI4mQaYh5yk33swCqXy6aR9rOwDUYfJLuoFyUX0kxRif2b?=
 =?us-ascii?Q?w2XMGio/dNesYtwTjts5s2bf+gyNGuFEbIZm4YZ+uYhJodjCDgGliK6CFE14?=
 =?us-ascii?Q?GYIxn1Dr/1l31kSWDKqyBs4wBAmhvM/InwBfgwp75IXkpY52+3yfkFmRg6jW?=
 =?us-ascii?Q?Jo6OdOptH4OosN6VbvNwH+p+AvrXdSn9/o56UnOE0SYpNBDofq4dghNQt68C?=
 =?us-ascii?Q?Hza2oVZjFDwJbcAcyn1z9W9G1gp854HDTa4z4LooSIqx4faBpeljbtXGfWSA?=
 =?us-ascii?Q?uwlsZanuXbDiD4zXyfgnjjWe/Z9quFM+3YmzskjA/rM8RjTZpUtR7gyOZw8S?=
 =?us-ascii?Q?6Xogx2mVU24igTPXvqcmDmz1FyK00gTKZh3YmcDqJzhZGg4UHpvQv4vGG47d?=
 =?us-ascii?Q?HXbms3eAzBADYcpcj/t3aQhSKUBVEG70HmexYONlRVAJFpD8fdfozugutOAD?=
 =?us-ascii?Q?D9UvYSpDx7lA9osLdl2sO40pJOyGm451kBZfv50Te5nWFEbQ7ff3TkXhR/LE?=
 =?us-ascii?Q?jEiCaes6ZdRtdUi4JynaVcSITUDvkRtp0skLaQLV2pE7POmlyfh0/tZoDmGR?=
 =?us-ascii?Q?aK8t9Z01FvwpQkaGGos3vsjJrDXJqyytUwqUTGk4IWvI7ovcUmAxW9RW4ajI?=
 =?us-ascii?Q?4tC9njvKQ1jwxJeFs9POfHLb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007aea88-a3cc-4e3b-03ce-08d961cbfbd7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 22:11:38.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJi5kTfzEFxApaG3MnPxhgtMk4DCMyVdlUN30aq2h5dxkaFBpWQROKmh6eWs8ZuhM05RraZd/sJjGa0ueXgZIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3505
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Erratum #1197 "IBS (Instruction Based Sampling) Register State May be
Incorrect After Restore From CC6" is published in a document available
at the link tag below:

"Revision Guide for AMD Family 19h Models 00h-0Fh Processors"
56683 Rev. 1.04 July 2021

Implement the erratum's suggested workaround and ignore IBS samples
if MSRC001_1031 == 0.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/events/amd/ibs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 8c25fbd5142e..222c890527a2 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -90,6 +90,7 @@ struct perf_ibs {
 	unsigned long			offset_mask[1];
 	int				offset_max;
 	unsigned int			fetch_count_reset_broken : 1;
+	unsigned int			fetch_ignore_if_zero_rip : 1;
 	struct cpu_perf_ibs __percpu	*pcpu;
 
 	struct attribute		**format_attrs;
@@ -673,6 +674,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (check_rip && (ibs_data.regs[2] & IBS_RIP_INVALID)) {
 		regs.flags &= ~PERF_EFLAGS_EXACT;
 	} else {
+		/* Workaround for erratum #1,197 */
+		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
+			goto out;
+
 		set_linear_ip(&regs, ibs_data.regs[1]);
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
@@ -770,6 +775,9 @@ static __init void perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 >= 0x16 && boot_cpu_data.x86 <= 0x18)
 		perf_ibs_fetch.fetch_count_reset_broken = 1;
 
+	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
+		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
+
 	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
-- 
2.31.1

