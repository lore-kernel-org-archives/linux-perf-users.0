Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E9565C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Oct 2023 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LO+3nPGE"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49CE9E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 23:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC9fL/Expep7jRdkiXD5fINNn9TAWqHPX5kQd35D0/A71iQwj4G0iZlz3fmiZpuzSGmgUc07zezjDoOJJNj53NowBVlIbO5dnIaXJM/qDGCGCIrymK1+Ba0vtVPE1JSXBwRGwr4hNEXU713kPbQf8tJHOrTnQauZSuwVPiIUnAJaLB60R8Teuf8KY7PgcO7xy2H/1y55EbSyNK6xBc/i41ZafJGrEbcMyScXtzYvAmmSjUYhwKfmrYknQ+7UlFCyFSLe2Kwl6ceahp09MKjmxgsFb8HMsQX1S/jLSnyfBgDl592MPSyv/z5VdVRmwcityvPFgJwVJ8sxg89kBpFzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptiYoAln2z8ZSesBq+EoIslmp6lhHFOOgPrNH1cbRi4=;
 b=jsLUTO9wYi7IyEMPVvIxsYMaCxsm9wGVZF2pDHfxuO8lx1Ktw/CtNSy8lH/i36/XHSOu3sdPB93nobINAFXWMfBtHbeWd67ZNsuRXn1FaeI7w5EZ1DUwViGzMGdHgkgxyOGMFzVD37ZzjU/AIfcm8KsgMt5iRBBssu8NXHmOmb3hhzg0McC0ug7GQfjdrWqgQPMlIhUom0Iq7jJPX1I4R9JHglpn9VRnMweGjxclsfvcssILmFU6Q/56Kn/Yj7YuvGvI/fq0PJVZJ2YPGNZNRoX5o4JUufwD8LGlhnfTAxkkDo7YDMckgsUELrPlaVKyEEv7xLvbEX9jqzXFjSX8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptiYoAln2z8ZSesBq+EoIslmp6lhHFOOgPrNH1cbRi4=;
 b=LO+3nPGEHAqNBXVOO0nQOtyCdyHY6KDjnIU0c1LMKfZsjVLn5/mWnFglxSTJ158jJlcf2pK9nFoGWEpWA+TQVX2LfZ+Y9LTCSAx87ld+P+yrCIM/osQgVyrp5GToJId4AYg57YMVFHYmRmoz9yy0mUA1x4xwrUMRxkhHs6+ZPgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by VI1PR04MB9858.eurprd04.prod.outlook.com (2603:10a6:800:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:52:41 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::f4f8:a4d6:fe5a:3e1]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::f4f8:a4d6:fe5a:3e1%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:52:41 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org
Subject: [PATCH] perf pmu: add loaded_json_aliases firstly for perf_pmu__num_events()
Date: Tue, 10 Oct 2023 14:57:38 +0800
Message-Id: <20231010065738.2536751-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|VI1PR04MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: 96eeaf65-aae7-4282-2e1f-08dbc95d7f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	41gOW2d0LrwX8PriVo0gJEcGI4wIverauYA3x+F/308cmW4fpXsjNQFuInLuC1/IsBNpOdLs6+IDkEKaw0ZhYiJAJ0wxFLB77+GkvZFj0Wnu5GT+84ETFkWTUtqbcNn+JFHldqBGbRWmrnEKH5Es2udBNMzih3pR6iWbDYOer4lVtmDBSNeSL4Iaj75ctANjnLfTmTDwDJypOtZ33PITfTz4VV+WJDRCNyAFrQHnEz4sLVO2/aj0JACuI3oHLI/0/E4Os79g/aVrlLRIL7tK2l8mxiXjh9DHlsmO0a/PcjmVsBP+tRiaMxMZPFirPLh+M+FUHnLl1za2r2lM2hvWX6vxCSp61t/pK5jpz5p4Wktr3wedccoE8BOEAFZf0II7mZnYYgH9wz3ZfP4nQnZUvPuPfN+qVp29mmDjzG11Ri4gxLb9Zj6Y7HHfZUNFaTEShZ0Gs3BfIIeEk5+hVeiGTCgA8YkDSYfLL6UcmixsMkTInM2sbMfHov01Hvtp8SRYtW/pE53kHs094faaTBC09liyoNpzTOOD/J3D+fu3CFzeBdn0WJwiONEjW+7gxSjnCRqIHcR4GEEhzO/EwVBDxUQ1q+/gJxz9IU/h9KxFkpBs5vUzR4zs86VN9CpwJJ+2DZ6ggA6zzVEFTPi+wtSWWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(86362001)(36756003)(41300700001)(2616005)(1076003)(5660300002)(52116002)(6486002)(2906002)(7416002)(66946007)(66476007)(66556008)(478600001)(6512007)(316002)(6666004)(6506007)(26005)(8676002)(8936002)(4744005)(4326008)(38100700002)(38350700002)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eUiwMUj35QAPRa8pCl1YefXv9K/3jNCKWNSDHVUt6uet8F8evP1ebk1O1dJq?=
 =?us-ascii?Q?wV6GE8tKkv6T16EJZ1u0mf2cxDW+zaH+9ehQyWdG2iB16O2RrTBxWkJQCPBX?=
 =?us-ascii?Q?6JRSnNQNeBfseT9nXIkLmMDq+Lv7+r+abzpt4Wa+7JAxk5SujUyTYBUdzV81?=
 =?us-ascii?Q?S8pDLUgEJFOBxYDBJ/s+f+vRQLj6ab2aqGMNhs1fAKHliKvmVcf1cG9roltQ?=
 =?us-ascii?Q?KoXfNUTqj/pF7NWzaF2ynNCinWuWGH3ABYVMvUeomJVf5/hAuYUiVyKoDlar?=
 =?us-ascii?Q?SAilnUFBiGDKRkutEIj4eZVFvbAbhuy6SVNPyoID5zBGZ5lzHx35e+C2u/k0?=
 =?us-ascii?Q?UlnP1U8cIhb0NzcBwwPB7vCWxIp0Kv8H7pGCxw2DoNIKvKnd6/wOOj35w+Hr?=
 =?us-ascii?Q?nmdXOZ++YE5EaOb4UzGUjKldGWloj6tdWlMgg6nk7uVg5wMrPrvT9Qa7YXLm?=
 =?us-ascii?Q?JBAJCYFc/wdf2/gZHExwGCGFh/3BJli7ZsqMMnQLlAEVVNWR3t5I7UKEG1O2?=
 =?us-ascii?Q?7nsEexOEEZRO0EJn1+XcoqsLTh/jmFyMSkszyiKaLjvk2BH1/qqZ4ujg6MUG?=
 =?us-ascii?Q?FIGR6gizCuX7uv39SP8OrrXXCl+R/X+GrjQcGId9tro0EyXf9wFa7YR6aeSE?=
 =?us-ascii?Q?Qnqqwgo6QKUgxUVSA/2k1xL2mHP+ggwcbZJZCzbrN+JVEnlQsjWAW2igDMV/?=
 =?us-ascii?Q?yMvJ/8NVrk07Jh0+nNuzgOcTBzvXvLm916lMZ3qgjQnj6Juphbx+KC2O+w2Y?=
 =?us-ascii?Q?LRxTLhR9GrrJUVFZ16+EbHpcAReboq9Wv0jWiVhADIHAbsjv0Q4yuClLan5s?=
 =?us-ascii?Q?kkisZ4TzMh5OFz4zImo/GkMD6J2AJfhj6GyofyXkmaf0YA0jovPXXFYaAbiY?=
 =?us-ascii?Q?lIsLZFA0Ieb/etqvjvsFUHVvr8IMiSyJh1b9ypH5tiMHJdoX0j5BD/vNTk4n?=
 =?us-ascii?Q?hPRooV13QREFLkzzoXk1OClZ9EQixjxi1BAFAx3b/Xt1KlapQCTb73s4qCTw?=
 =?us-ascii?Q?abRMX4pfL2SZ3E79KBUeQ1YpyeUx0HHnyCQbzs1uPDjJzXP+2yBPIVjwtofz?=
 =?us-ascii?Q?JOZjwljd/GJFzB5ARTSBvm/+x+Ti/issyXvHFkJI7wpDmVws7th949Q0XVg/?=
 =?us-ascii?Q?621uPvNalj+MsKxqkOKTTQmQzEHwlL6h6GTQJ8vXzViKjMtjM7DAAmDahffx?=
 =?us-ascii?Q?rk9OGM3jarp+Qn6B+nNXC2TMYhQA6nLkMIcd8Z0FVngauE5qBrH+lffr1oH/?=
 =?us-ascii?Q?6qVnBHmOIVgJzD3b23OeDrlPvnYBKK4UgfYVfi3KP4jNBlj9JjAUB6mahqE0?=
 =?us-ascii?Q?VuBfv25dAH//PUDq1XxMlmBUT+dH3CQfFzlx17fDh+U5Me53zoeOvG+dVUFz?=
 =?us-ascii?Q?XdR6ZCcTntnr8iiLcmEkhUgEN2BXYBSiwxUy9LlqJ2oilLM6t58YvX5BmnmY?=
 =?us-ascii?Q?ksvtMsHbW0m2OvO+v4ixqN6eFmE/V2nkmRaVgEl92QnXN0LHI3sliOkX7BWj?=
 =?us-ascii?Q?Yrd5w4z6+McVoaiGfLRJ09UpPe777QRcfyXM10R/q62NHHXxQHScMwkc2ZMd?=
 =?us-ascii?Q?k8stBhx7Gxv48kJnI9naK0kSq2jvQZNo2UViPgHp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96eeaf65-aae7-4282-2e1f-08dbc95d7f6d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:52:41.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMqf4m6y0pn/D2GH5xqULZEFoj/chclGjIKgyHrB4pVp7gFJCQWCK+ixdcrT1kxI4QOHggtWkzxVBlKVWTe0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9858
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After pmu_read_sysfs(), event aliases in json may be loaded for non-core
pmu. And pmu->event_table is NULL for non-core pmu.
If perf_pmu__num_events() didn't add loaded_json_aliases to the total
number, perf list will show below error:

Unexpected event imx8_ddr0/imx8_ddr0/write-command//
...

This is because perf_pmu__num_events() didn't count correct events number.
This will allow perf_pmu__num_events() to get corrent events number.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 tools/perf/util/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8de6f39abd1b..920ab1c2e93b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1609,6 +1609,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 		pmu_aliases_parse(pmu);
 
 	nr = pmu->sysfs_aliases;
+	nr += pmu->loaded_json_aliases;
 
 	if (pmu->cpu_aliases_added)
 		 nr += pmu->loaded_json_aliases;
-- 
2.34.1

