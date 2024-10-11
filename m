Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2098.outbound.protection.outlook.com [40.107.95.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230E195FE5
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667053; cv=fail; b=WCvggS+OsGrEDNuEq29MLhhjBgZYpLQyOS4cWqGk00WuxUtw8oeOU+AjKQrzS27Dlp4LkZ9IemWKyG/Qi3D8MMl4lhRhYRXHwNk88qI9zCGe733GWMi4iMqMkuEc6j3KaDxmtk5vRDzGnuZgY8N+TjppNtink8d4+fRtwAqglLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667053; c=relaxed/simple;
	bh=4TUili3kqi+wX11sFY62onyQuJ9VEcQzJNcYBfCYP9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWL/5SpotyDQmWmnP2uE6wpN3HsKo5n7LCfWMYHF4Fv/M9VY/mQpKnMNX3pjUI7VhRqmMb3+HCOhWt7FFhcFv4995d3AoOO+N7xxT8FziY5sqxWeWKPI46X0y4WXCRUL8dhGFCwHMM0yH9hoJbhbAJPd+0HaYKHc/Yc5wm8856Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JX9Zt8HO; arc=fail smtp.client-ip=40.107.95.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JX9Zt8HO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGig83UGtkM2EnXOThyxy5feD/K0MqyrAgNXoVAbCr/w+w9yXI3EPwF4S1go3697H4RrgaWPTnuyqp/jkqkRxhgKMXjfsp4cRphONx2D0nMobQGtl5FEsJICC1rI7Gc38oWlNJyoGbEFs9Lv1f70fOopSNu4ylwEc4Vm64+NnUHlkVYP7/LMgkp/zXGF14kYLcOQxhz5/Athd56WcLwF8ib1h9V4lxBuxYGmAWbu2S3nzBjhiTdJMExNmOrnAtyJLcIL1cntyBRvppyNbvqAEK/ncqaA73aFspL4Ow2tOf38aeHnTsIu4//UjQzCU6r5FkPBUDH+AqNt7wsVVT8+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfdQOlG8n96DGGWV95lXWurrB8AofvWa9oPn9hBbCVg=;
 b=igt4AYxxMQlQfdLTbHCyuAiO3xJy+u2z6L7dNDeM9UqczVI6e0FFyQ5QqS1H9dfJgFi785gFlv4N8by6eGPNRr9BbG95yqGDYAjq36HD0maVKHNlRgfOKGnvJ0tQiDp0g2r1qQ4J6OsKbdkEdXLwbzoxn7/BpayoshWQLO6E5CJBmFdbGkUyNqonupLDvytAp/jrFIWp53Y/A1QYmfInItAo/PtmNexlJ7Ex4B1D6h5HIrQnMYomUMMjarOLTBGLOanmIfIWNFT7Q3V1++8pBxlc3ZJtYl9eBAD08ZbPPIO3QdhqkIXSB97X8IzN0tcWfjUN0cuWiE80GXmrQ2wONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfdQOlG8n96DGGWV95lXWurrB8AofvWa9oPn9hBbCVg=;
 b=JX9Zt8HO83NZfyta7BbZ1RkrZEFs56899nyquqUlaM5alVzh2omqB5iie9HXvokI1QI7u+8ePl5qJYKMHi1ZsG/tqxQ4HwdQhjKCppc66um5+gZhQJdZDBaaIwWO497sSGiF1wAh2lH0fwr1oQ8IAigrJ3MOgWToHxypf+9kUFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SA3PR01MB8451.prod.exchangelabs.com (2603:10b6:806:394::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Fri, 11 Oct 2024 17:17:28 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7982.031; Fri, 11 Oct 2024
 17:17:28 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V9 1/2] Add map_pgoff to python dictionary
Date: Fri, 11 Oct 2024 11:17:09 -0600
Message-Id: <c0ca69f04ba93f1d05d753a3adc28ad9a09d34fe.1728599785.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:610:118::13) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SA3PR01MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: d28e9b9d-5d23-42dd-9720-08dcea189573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yNYVOyy3uVqx58zbX4HEtUmk2V57m/suJqmAa9w3N7Ru528g9TD9mIU1Mbzh?=
 =?us-ascii?Q?8uzueJ7EF+W44vSwJVocWnvqhcXe9/XciWI+b+4mjwjGjE/cBj/4/dbGzh0S?=
 =?us-ascii?Q?aNNfDhy6Xp8jwrc8PsN94W4OsJg+QbtyLIR9rN/5gNuB7IhOaHElxJUKvyLr?=
 =?us-ascii?Q?qbQxybHJzAbUDB5b91VXTgOI2t4ROCUe05HZ32rPIbFjq4tMYLZTKkp/Pw25?=
 =?us-ascii?Q?4/+vzVENeaJZNoTXBB90cq7+Ibiq2BVctYo4NwBIEGEJLofBKNoW7zpq8NSd?=
 =?us-ascii?Q?5JEl9sbyPrr2W7Ul4ZKn3InF+i7ukkHUXidOr+zcPtq5SN/rGJh8twHIr51e?=
 =?us-ascii?Q?h2Yv4mbVqp0jL3vKP2AVbh5CFUmClfg2MrkiDrundXL5zf9VkZ7104oVeW35?=
 =?us-ascii?Q?MpMJKjOUOyweNbPYdSFusksrSLfN3Xi9VdrdbLdWGY+kZLAUOuDkmIKXkqx6?=
 =?us-ascii?Q?qJXa8Lj3DkMy0brkCM78j2ok9erizaqay7qpD2lI+4IfJRf+KZIqBm6vKxsc?=
 =?us-ascii?Q?vZQqwBEcJ3GWW5dZGAWSk9JtKnqpYZOmA5AY4osp1bakKk8NchkN4Fz7r0JN?=
 =?us-ascii?Q?+RsGTOo10QBrEd0Q5FHMZ80JNXe8vNffNzAIcxvII2N1f3hGmeGqtd5W84Ej?=
 =?us-ascii?Q?9bUbaJ/H99W8XIVmvb1JqQ2DdxuNSaw2KzRnXZyDLG1hKFlgiauoiG3e+jlA?=
 =?us-ascii?Q?SKkf5xQz+SYicFG7BGfm9NctXZ9P8Gcp3UvxPcBwAM8uZfK5GBUy4mwKWmZ9?=
 =?us-ascii?Q?Qpn1rvXdWKA8gi7bf83+bgF/b0zXxhCgHV1iGN/Bx0nc3tZT4q9JRLgMlbMm?=
 =?us-ascii?Q?ScLcmJT6YSozD1HD0H3ZnSggcVgEb3EFqkgui2ftVjq/u4w5X0u4EvDXmcFt?=
 =?us-ascii?Q?AgUxyDKqxAZP1jxK2NPKKqkEqjyPyOcTbmRR6JWhNZ6QdS92QmtlPH/UeM89?=
 =?us-ascii?Q?XLFWtBO4W/dWKtwSk8Un1zfn4bmDucOgs4zdJNOtN5zqD3U9skJaWW6OKdon?=
 =?us-ascii?Q?Q0eceNmnTa/swASCuFdJ9B02Bp3M03K9PzYnP2mElyxUvrik5DE6KGtUI6uE?=
 =?us-ascii?Q?QbWt3HiKCCwpacR1Zr3S2HVhUqTK9aWl93UTbRnPgLi7SDauJXcpTF+VGCim?=
 =?us-ascii?Q?bPs1zZzQKYDub1+/MZk+4MSEmRmb8e03EiynzSzjCu+5CxmNxJgX9lbPh/Kb?=
 =?us-ascii?Q?yHEnLWcSZ6rN82qRt+vQ88zNm4eruWVrFlFMuZUcdX6FfAimNfjHGwvO3b+a?=
 =?us-ascii?Q?KPdjPmltFst+bflzAD3PG/bb5ks+x5t9EhIM8tQxZJcRxvT4ekqlIYDK47tG?=
 =?us-ascii?Q?S75P/W6O0WagYMMUgXhLz4rmU4pCjuLNXQS0HhvfW2hAyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xtk91a/W6nvG+OHa5Hf+ibiYJz4lCJGA186inhwBu0gWtAcucmmOCJ2uF/GS?=
 =?us-ascii?Q?yo92i6HCpKa5oGnYlFoHI3zUIyL10Oz3zm19HZ3QTDIWOBpRO6XoxykaEkTp?=
 =?us-ascii?Q?4dhw/777LTkAvPFmuAyR2r0Voj5HsuQ6qIoXl0OBhrVpsWa+ceXdyveYnkRD?=
 =?us-ascii?Q?rjUQNGfMQgZEmMa/Qr61bMu3sfMwynlM0csFl0pAYmLcbLiXfkpDI1LYg+aY?=
 =?us-ascii?Q?tEXlLYEB13uSg9kOMILHZTq+ry4mqEWRkBBDmTTwZV9ntO+Dt4ZZmlthSZrg?=
 =?us-ascii?Q?enVtuAlg0c33WLu6df1HoTDH9rxo2pymbtjnDJqH0+Xh5UoJwljHhFE3SJ1z?=
 =?us-ascii?Q?XXyzEkFAVsDC5YV2Zbh5Z5s3vmcbV19M91k2gvlJ6EKTXbK7AIEYfF0JoJsh?=
 =?us-ascii?Q?HaX1NtghOXzFmfSZXvWC3y1lrXj8bn/VnyB77oDtb2Na52BPHlyyo0GrVhyY?=
 =?us-ascii?Q?oF5MeLRD46PqJAYLVC44ETsRHay8DtQGMcxLxlS7dICL/hYHuCTp1C1A29WE?=
 =?us-ascii?Q?hcgCyDXzeUifNXi+p4VvyXwlhaRWGqbOh6NjPLdDIGMyxbzpPb0/M02l0rPn?=
 =?us-ascii?Q?/1603C95M6EBA/WwUqS7JzFd/78glYLwkP+CTZL+x+YeKY/n3cZA8e/NqLWj?=
 =?us-ascii?Q?3LOI7u3QvG/vsSuLr5/jpHJXjDChhPCGyLRcUZRMXbwENEJKrjoehdQWp38+?=
 =?us-ascii?Q?K96a392jgqSN4PV7IplleAjqxaLVNrySmZ4hN0siFcKlCRIJkSvWT9RD4HVW?=
 =?us-ascii?Q?bMFNOmUWYZwGIVgOHz6xguLB1YiHVLDMmnU+TkokU0Q3qgds0Kncc2d780PQ?=
 =?us-ascii?Q?gvPdi6aHMqKxTHRbEpyL3AbaNfWgk+wTnVfieluhk2RdgZ1geSavjN8C0TIs?=
 =?us-ascii?Q?vVdZLyUSf2UcFx/613Vywk67mM36mP1mqc9qk4e4vQqxhm7vNvzDpwdhEMIs?=
 =?us-ascii?Q?tnNURVK19rgjUXeF9z4jyuHMmFhpb5PPiO0Ag4+I9xWCsrzc+PjZNO/vaWVZ?=
 =?us-ascii?Q?TscJ8Bkf8SQyulQ4Aubud8bSAXOrNc4Tx2SoPpL5R9DHWay/7AH/iYlMXnX0?=
 =?us-ascii?Q?Gz5fipHiVJAyhk8z4TdTxXoeF9WK3JhjXMNnEBOLMV2HC6zCtA+WHg/b8jkg?=
 =?us-ascii?Q?yzNlgKt1v14mmccqvgRgybeqfFec2DqB/nkBwvcNB+nEUn51RW+eiwNeCxl/?=
 =?us-ascii?Q?1QYxnzg6ezkFUuwvbFg19UpeCzS6V8IBKJaiShz+/9iYFmuWGwGcHhBAWUaj?=
 =?us-ascii?Q?md2pdHbTi6QtRLGq0Q6hsl4PoU2WY2/b772Xr3uGUuJXHvUBs0/i3qDa9LUk?=
 =?us-ascii?Q?wQZvNlzVa6sIZwO92rOgXFcg5B/ZFrFuYJw6efSRS44YAkH9+jSnZj2e6unC?=
 =?us-ascii?Q?tUBVxIfpLI8Fs7Dp38I8bSvHK2xK9aDY4+Y7RhpNlyyFElD5sfqZHA9suptF?=
 =?us-ascii?Q?X0m4U61jvuDDoEH0+QRr0r2EP2i+KNTDdqbyrKtOTeO+UlwYRl+NrrW9rNyG?=
 =?us-ascii?Q?TaxtusbxWeqrit7xGoy5/vsuNZt5nG0lz6sBevFXy+LjZupriJJiD6P8BcKd?=
 =?us-ascii?Q?1NG5Oq84zDNccyKAuECJdgIXri9nMO4p/sDR9QDkUKaqw1Rh2yNNZ6xpmP5E?=
 =?us-ascii?Q?h5h56LBmtrkHmfHCCHqYdoRVjryBZvymJkwnm536s6uC?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28e9b9d-5d23-42dd-9720-08dcea189573
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:17:28.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z31VxFm+0c2+h8hN12h6WjZPhkjOob/K0G0XfmoxgOYvdhAO8bRGtyN81Z2V9oWvNM1WVCAZK8SDHvEpmTtWug2uT+1rjYYlOsFqKTDoADii9OfZBkxRM15eCwR6INN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8451

Add map_pgoff parameter to python dictionary so it can be seen by the
python script.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index d7183134b669..367132b3a51a 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -793,7 +793,8 @@ static int set_regs_in_dict(PyObject *dict,
 static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *dso_field, const char *dso_bid_field,
 			    const char *dso_map_start, const char *dso_map_end,
-			    const char *sym_field, const char *symoff_field)
+			    const char *sym_field, const char *symoff_field,
+			    const char *map_pgoff)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
@@ -809,6 +810,8 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			PyLong_FromUnsignedLong(map__start(al->map)));
 		pydict_set_item_string_decref(dict, dso_map_end,
 			PyLong_FromUnsignedLong(map__end(al->map)));
+		pydict_set_item_string_decref(dict, map_pgoff,
+			PyLong_FromUnsignedLongLong(al->map->pgoff));
 	}
 	if (al->sym) {
 		pydict_set_item_string_decref(dict, sym_field,
@@ -895,7 +898,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	pydict_set_item_string_decref(dict, "comm",
 			_PyUnicode_FromString(thread__comm_str(al->thread)));
 	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
-			"symbol", "symoff");
+			"symbol", "symoff", "map_pgoff");
 
 	pydict_set_item_string_decref(dict, "callchain", callchain);
 
@@ -920,7 +923,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyBool_FromLong(1));
 		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
 				"addr_dso_map_start", "addr_dso_map_end",
-				"addr_symbol", "addr_symoff");
+				"addr_symbol", "addr_symoff", "addr_map_pgoff");
 	}
 
 	if (sample->flags)
-- 
2.44.0

