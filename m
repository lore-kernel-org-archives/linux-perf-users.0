Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B114BF8D
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887099; cv=fail; b=re4hKWj9PN+6ugt6AnGwJLsQcxfqZXAtL6rIK+MvQiMV4lToZIrCzFcVNLDak88rIddGAcGuxCLko1NjAMeHr3+gYVyNMOpRHQr6pqiKPFyhvnzhli5vB7Sym4V3Bg5tvkhoSuMPZ8ZnCXaYXvhkV2EmhoQ7FCShGntJdqSUkhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887099; c=relaxed/simple;
	bh=czCAxMPOlLNEwOyw8iq5qAzfpqSjN75eizrQJ7X4avc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHF8TWBV9NYdp4nmQ0p3mFXUpS8QnXH+nmmIs12X6WRN60JEDaxQA5kcHkBh2Fk3VmjiLiQYp2oldYgosLyYqvx144hvMToAcl9jJGmn3OL9L+uY8o1YI5d3COaYRfP3xafZSRkkK3oqHhmgKh2yAqZTi/84+R81xawTTHOd/cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MScw1ToT; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MScw1ToT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3ysuXwPY45dRCZuqFJzSPFaHxlzl7Fa1gSM3KXTP6Ep3l/Oj7XMNC97qZ9ZdE5SMN1WnHkNEZ75Loh0TvoYX4SBhQWpvwF4w6mTGOAKx9gejMq/svW+wg97jloIGba8+sGGxo65VOm4nGjuPFCfhhAckWvkGoBwuPe0X/5M8TUc2fcrEcrB7Yz5N2DVvDD4t03lkSADq/ub1dpCdxxhkpH0vygFYTRcSIHwTyNQcDL/IDXB2jVpBA1CNutFsxH6snBj8oFVe5NE2a6kjibAPxsaU1L6rStROGVIyeDJrivVhrz+WnkUP4RgCzpzjVrHRZgPooNKbqLii/GI5D0I7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TbPovjZNBNXh/GT67apuayFIV+YMHPFXW1udh43QOQ=;
 b=wyfL/K+9kUK1VAc4QHd8tIkHd3BqpFU28/1fwDAKM0XYhOboKX07c9KeQsC82aaRVjl03xRMbjPL4dfxMjUK2QCtChTtKawzlWMPXYWCzpxkR2iWQFAE3MJato3XwQGaetWQiJqR8rKcOXBu0Q7gtcJNtF26M7laDZR/DpQUL0SHBKNZymgPUr1OmRMbOET32GLxWSTVPhHT0XUoChKJpTRq9jQYA+TXAuAvlRWZe6j3oqBDtdEz+2H6RKWvxwFqegwVTcW4T1Y2JCE4aV9hraJIMP5XTWwGXEVfEcYU7JD5mYd+y/IvWnHGHMzG66moyu193Ko3SLRO+sRTohtVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TbPovjZNBNXh/GT67apuayFIV+YMHPFXW1udh43QOQ=;
 b=MScw1ToTtpeJv2pxh+0Gv26dYmYXebxEHuY2gs9olo96ntlzeTDHK1pJKhFxCRx0XysaQmHuoXqIJV1qAH0A/mon5VY2XwP44Hdyz3NHaKndzulUB1AMI7N/cllcbNnFH0lYvs6r+IyNQ0Zm3nLgyTa1naGGHEuikazIwE5IEgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB7895.prod.exchangelabs.com (2603:10b6:510:28a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 23:18:13 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:18:13 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 3/4] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Wed, 28 Aug 2024 17:17:56 -0600
Message-Id: <e6dd76f87048721f6a7306f4d3864f0b4c0537b2.1724879699.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::24) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b97ef2c-bbb6-414c-ef6f-08dcc7b7b0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GXcZPfE871BtOS+AKRKMV5wkU8PF5j84qPb0CYdMju4iv0OhBfqQhPFfuiw?=
 =?us-ascii?Q?UWMETbp9GfoIHE/3OZs62+5/C0XcPl9i2xDMXkHShmKsVTGV/6dOQgmkpYVh?=
 =?us-ascii?Q?70DyWP68O4CiC6HDI5mhCX6gFQhu/6B6RzthAvN58tmE9WdWn/fBPz+vK35Y?=
 =?us-ascii?Q?Lr9f+z5fhRdsdnTj+W96e9q/VCZ/n5UD6Yp1FqpRtCIOpJZ7cm8U44rPNz3F?=
 =?us-ascii?Q?Tz2P4qQaPGimsBwe5lRipaw+XCccbJlmbwgHpbygBbJ7TGg/a7rfC35rESwb?=
 =?us-ascii?Q?BnaCLOB9yQ4sQoZnqdf0ZxLEw+mQfATuo/K3P3lmOrkJa89Rxmac8e2ph/rT?=
 =?us-ascii?Q?GAeMXKCTP1590U4PFws3tgFf8RwthxRXrhtT3fsuzwYwXIww43zmy67sTiA4?=
 =?us-ascii?Q?lVzVEmXh/ISqnx4Vhg1isoc/99yVt/clPfMnBSANUStKSJfsLuIKK2GXJOtQ?=
 =?us-ascii?Q?PxbP1mggx1RqI2NRIuhGb9BonYy64KOtnr2GtTNCgQwWUXPC15rWziZ3OJxK?=
 =?us-ascii?Q?bTwFVqxBYSMXDKXNbFpJ1gfJBe9oKD2ZyoQbRoriUjlvzOX2vEvR3FJw2O17?=
 =?us-ascii?Q?efary6e0QuYb95u7bYwaZhnfoda/Bwf/qAUXGD3o47YE1sje++CHyWyFveQ+?=
 =?us-ascii?Q?hwVnskIS9TGht6n2GeD1ZjgB4ANRkhi87XaFbSo93NM06hF/ciyrxL/Eo6T4?=
 =?us-ascii?Q?bEdQ9hk63y5mpNmomR11sD6zpxeMc1vuS2J2W1KEwP+ayDfKD6RQmizwex4U?=
 =?us-ascii?Q?OGNoBWNGMpVxtorwwRM9cewK/oLspb59Pc1NZwVkqqI00oEEUcrPt/JJfTaE?=
 =?us-ascii?Q?deNmqzGlDckCtAYJV6ua4GdD2krF3Xa/mqfNCs/3YWfmrhKZ90oF8348QzUs?=
 =?us-ascii?Q?ALx/W5DTeEmYq5t4xXTcgXi3cF8rwhwiJhhkXqHQaTaTuARTbfOe/9u9k5ys?=
 =?us-ascii?Q?VMm0mRR/oi6dqkoA7XunN0bo+/I7kLra05VgAWblmfU0Q/Fe+ASe1Bb+sJPi?=
 =?us-ascii?Q?UKXUFwMVeA/WaqgGyZ2tug3PWOnNQuYq8ejsLYpwwACI9tUlbS1tCtVrjCQT?=
 =?us-ascii?Q?1vw6w6w3S6ly5UjQasNeCLIl+VINomGB2OKcCpyG0H9rPQ1e7AXtxVe8VP+q?=
 =?us-ascii?Q?XhZP8T7Jd9BX6tMRnkvnrCMXPAMw3D5vhHmai2OJDpsjzy1oojFwzKwU0Rct?=
 =?us-ascii?Q?QCIkfhaoNR9YGt4ubRPd9e11+qbXccI9nGIjnwtGU8xuBR2V1XHDXfqgpuBq?=
 =?us-ascii?Q?gnh+NECQmjmSP6juBPxN8zSbTt2RRli0hwZrKbXXl5mW+5lcgpJkrxxmt9Yn?=
 =?us-ascii?Q?e1yKczrQ8DlCHj1DjgelT37UAAb0nxY0V5i+VW4DRjnTsAwoE71imCk+Nnb4?=
 =?us-ascii?Q?aQvQD9uwhXnbDrDb8ti3lX5XKo/9diOkF5fseDRHjgt0ol9/pA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AJ10Sz+fZuUExzdGEQGtQr4+LVGK+2dliJDnR9tpf0rsFyX4symS4VtVSmEz?=
 =?us-ascii?Q?gmq3gjj4H30w9dwM7/fZR6x7r+fK7gNCANbjiJ8WpJ1bIt2bY+Mtu/Y/wHS9?=
 =?us-ascii?Q?ou7RZwDJs8RNh3r01pfPIx6Kw8KqwE1g6UhEwnvod04VeABAGFYyEQb/Bxy9?=
 =?us-ascii?Q?uxij3Zo5eTWxlYxnJDIU6f1EBIAttiI7BJXxLej9iU9SxOJLaQVenPWHhLSx?=
 =?us-ascii?Q?CaBuRlaNs2uBgQ4XhygpHaCi0oBpgcS2Niub8RYpgjHMSu8Y5zV7GwFslzqp?=
 =?us-ascii?Q?2yQHhJuiLBxnpKUkc6PWDVyI6rWuQQwyGYElfBoHOZYRNW5kDtpVdRr8QM+x?=
 =?us-ascii?Q?EIXvGs9yZJ8nWkubaXppuZUjccTFecQLW30rpQqTXDBkKCMK9NQnMrWlA65d?=
 =?us-ascii?Q?Enp4djZPfHUX+aSOG8mZJnyX5QK6/ziAQcaeDh4pbB6+HFMaTLxigIorfyXO?=
 =?us-ascii?Q?vvJtTIbkjZBzt89lsmASz5mz7n/VcxgD0g+owyKsP6DLeNDiyHadc6alHmo0?=
 =?us-ascii?Q?iMxOQpmJVhTBztxOmy1xIzsP/i95gsvyHDMwQ20W+86HVcG2szvcjjjYr35Q?=
 =?us-ascii?Q?9Mbtl5Zc4rcWhs1QG7/Cbr3teozqGeO85o3P/r2pS8oIWWaWao6GmOPw9aau?=
 =?us-ascii?Q?5hrT+GZuCL7iYR4VmDokTlFpjMsqQhMh5ndKnKWWISk9ArJEaELnH6E4MM2/?=
 =?us-ascii?Q?5cuTGbNVvzee8KreGfnyf8or5Cv785AppIVxWfhFncOvlsg3LIIqPSyHZx+B?=
 =?us-ascii?Q?DuPtr0jSiG/9z5J0iwoJkT0O/Bg+tRSz4svbKY1/S9LYxzbAapISTglw1AMD?=
 =?us-ascii?Q?R4dDCMpF/MED2VE6uU0Qdlt61aMG8p5R8tAXarQDWRV+XzhgPxTEZB3vAyV5?=
 =?us-ascii?Q?EWWdu4JlbfC2ukFZi4y7a8npTFVWKY8ON+LKV/vKYaxl6hetQhf3asMHXMeN?=
 =?us-ascii?Q?exE6JuHTrkm6At7cOalXFDHGOWqCvPcrpAKyvQoZmjkkulunfbhuH7M0K/2+?=
 =?us-ascii?Q?QuLqlx/eVO2hZheyuoBrgvlnEcPeZuRLLlgKD7GzLLicYxk/0Zz2kmBxh963?=
 =?us-ascii?Q?Lj41gv7Q9qkI/VNJCd9n0G0pkJjyA78Pekiw/xWTlEeoyrjwiJP6wjMZmoGf?=
 =?us-ascii?Q?AiRrhPEZj4DdgS3U8xkn7UkA5Dcb9GDTTa6sZkeAwhSIv8GzTweFlBN5WOeG?=
 =?us-ascii?Q?J21AzWiAa2YNAlX2Ok3JkLMP7DjeUzf9HF8HEVulnlsiTK4bswaybp6PQNeo?=
 =?us-ascii?Q?djMjmtQtzU1Dheb70IHkSLI0cN4qgvV7RSxLNP4kGYXe/zAtVtLdfCK3+6rF?=
 =?us-ascii?Q?JsTdmUkQEzAJkHU0UBP/6VVv7DcZzU/94v9djNM28zEj0w1mkgormwGQMV1P?=
 =?us-ascii?Q?WI7aBtcIAhqXtxKpjrRYRJfHotGtZzMBCl6Q+RhS9yySBzLZs/QBwj2rt234?=
 =?us-ascii?Q?K26Mv+fVFI+WAbHX7FkgTPSegcsMRwaJUlK2UnfkPPNwh78iSKLz6MO5MDXL?=
 =?us-ascii?Q?CwbiUwRW8sWyp/DXEnpCsWggvWoIIbjxw52yBtw4ssz/uAjif+t9Xp70Garm?=
 =?us-ascii?Q?blHLQ20N3nF36prYbmRgVCk1hL5tlqoapYW2Bt8/fuDuv8TpjxBhAkcLg5wl?=
 =?us-ascii?Q?mXm8yVzJRMrJWQHYhnSl2jsz6pGNIvt95LidtMWCRl8C?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b97ef2c-bbb6-414c-ef6f-08dcc7b7b0bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 23:18:13.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iV3wBXs9omSVyzicOPKefhigOuTxuWVCDt/0vxYzk2jmHdXO1PmT7QRf5tGSHfSKWyeP6uxq4wOBf9OQrA+gMXoAPVt/6IF9CeKskYv7g+3QOlt3d974BjEwW1IJEp9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7895

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 .../util/scripting-engines/trace-event-python.c     | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 6971dd6c231f..7b96504d5406 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -798,7 +798,8 @@ static int set_regs_in_dict(PyObject *dict,
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *dso_field, const char *dso_bid_field,
 			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field)
+			    const char *sym_field, const char *symoff_field,
+			    const char *map_pgoff)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
@@ -814,6 +815,12 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
 			PyLong_FromUnsignedLong(map__end(al->map)));
+		if (al->map->mapping_type == MAPPING_TYPE__DSO)
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(al->map->pgoff));
+		else
+			pydict_set_item_string_decref(dict, map_pgoff,
+				PyLong_FromUnsignedLongLong(0));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -900,7 +907,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
+			"symbol", "symoff", "map_pgoff");
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -925,7 +932,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyBool_FromLong(1));
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
 				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff");
+				"addr_symbol", "addr_symoff", "addr_map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.25.1

