Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2121.outbound.protection.outlook.com [40.107.92.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752521537B5
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917425; cv=fail; b=gh6Z8Q5p0wFVCKM2WtJroYxULv0hjPgoNG31/027nctXgfkUVTx36kpp4gbsjhSmnlo9ewf9nidrVBgmhWZdnjtRxlek6FovmzIS9dMcXoqTSNhTAd0aiTVwzYyGt1qqmq6dd6RQGH83xhSW4CsKcYHf+qxbkMUtzHnPGyZQJZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917425; c=relaxed/simple;
	bh=BUnhNTJQVQe74axfRWPVRUZ0205LgQFtTVfKZrEnGrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9cjMYdoYzRY1Sq5telL3v1Y6tORAvX4kOt6jOHrAwUfby9q+o3k9INCtihpfBicagllgi7LtG8M6VEazaOUBVkHWjItmqkAPf30Bqj3KPJLw/zgvCnAV1r5DSiwOzxTltY0/U2mt20pzPbYLrEf4WmW3W5rKdmBHR6DwOGQgFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nuT1CG25; arc=fail smtp.client-ip=40.107.92.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nuT1CG25"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rljFgZTn0AkQwpx00rclzEsXwQEzB6GNfTnNEK6LSwGWF9DaFsRiWSmo9DTXnWUFcJaeCnL7qv0ZQ74zDGct+1e9pRpE3v/PY8NisfOLgB38jzGnk+d3XrHQ14NM1kw2RuMMjiEeyCjMNtYfU7tMIvClu8D56vLlwJ05mW2rNMgTURtc0QuTM3pc190YR2sBtjASUuT/6EITcH/UUdHjaKJ1GORO8wTv5Bk4trt1ovCeoNwnuqVhcLZopFPVGcdJHG2gZ5owiUXxBSdatZymtqYOu38xaOmqcb/V/33AmKc1qcN7nvZRiCLUrBe6sHjI2vdO5xUKDEGxZ8w3U8qb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/d8sKDDfqhX0VFAITI+x4NbusmqUD10ZNAfW0BKTdEY=;
 b=NCSaUwzIQPrB4mPPx20JWL6RrG4rkdZnklxJ8a7ZiIL7SJN8+S/BtQ3gn1SHozArbSL+YWml6x1JZg5T6rt9MhLUDUPZh8kKZE0RpelhyRNyN74t/7+xPMy6w5qQWV1NPiYIY1DG8pvcRf9Xk27jExQKtOKxthfm22FRMa8VYm7EcmtIWNPlxRjYBgnIEpOaQfIR/sFQxZ00Gdypvtj7tSuzYQw0M4Y/P7va/kqxFC1mVyTxs1JyJKi4xPPFlpNAMmvaejYkW9aGyQxwaeaVq0B3t8+HKKPZ0ivhBC5b56QKGuEx2OlnAePgJap9HQVtg1d2no+QyfDjJusasnDwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d8sKDDfqhX0VFAITI+x4NbusmqUD10ZNAfW0BKTdEY=;
 b=nuT1CG25wJ3a8Yxys3GQV8RdY1OponRee1VO+f4pvB3wO85J/WyMBmh2RgcSqGo7UFqOUwi5EfmJmJH3s5JJhEHG+C86KKZKsnV+KpN5om42axYvONhfDdoclkDVbre9qNya5jbQiwX7jHH7pfOKOIXc97jjOQXZm9fnlTEjWLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 DM8PR01MB6919.prod.exchangelabs.com (2603:10b6:8:14::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.24; Mon, 9 Sep 2024 21:30:17 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 21:30:17 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V8 3/4] Add map pgoff to python dictionary based on MAPPING_TYPE
Date: Mon,  9 Sep 2024 15:29:59 -0600
Message-Id: <8ac2631b113ad83553981795bcc509d9c6f55495.1725667397.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
References: <cover.1725667397.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::20) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|DM8PR01MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: f941c3bf-cfde-4ae2-fcd4-08dcd11699a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2f73kLhrIMsU9H+QpUf/nqm0MPkLTg9JwX9vcApASZ+7viFNCX9g5sFzJLVf?=
 =?us-ascii?Q?ylVNMXfIxmUh8L2yjUWnSceMmW5hb2XdyMqQUqDyEQFeXlCvdAakIKwQzPI/?=
 =?us-ascii?Q?9Kt/Kj4UohUoxa1SsUVWWIV7XXhMXHThnzoImp7IPj52ys4nXxqX9UGZs8zR?=
 =?us-ascii?Q?LLcJ1ye+cqkj79bEWkBDAc3JzZfnJKhGgSgjlxZdCS0kRpdsbRnG1+JaDD9w?=
 =?us-ascii?Q?P3NcvBJFKfJoHyPtMaIt5fqTn/x76vx7f/ypy1+unDeN2dOhnFF6i30w+tNU?=
 =?us-ascii?Q?y2kEx2vflFaxsxDtIOO7FXIsvO6l0r5RLdP0yQWW1XCqnsguGjimJrWvd30Y?=
 =?us-ascii?Q?WVQRhI6r9xk6oZsAJr2ZLS5HYAdutgneGGxTo2bsf0h/PGPw/bhDxVaCuHYd?=
 =?us-ascii?Q?xGPynlxGlJWTP/8NH7EaYhZJsbO/GCjTJsOf513Uh7fT3BxXbc8TAnYSBJ1D?=
 =?us-ascii?Q?67cm0yHdPfYueV1MCclnqNOgEVDFnO1Txh8s4f4yVYBH4kS8bqzoc5tRloMk?=
 =?us-ascii?Q?P4tvOYU/JM9Y22zTemi309r0x2uLXFZimYYg2mGV5io57MZVvq3QDjksMxxw?=
 =?us-ascii?Q?19oLxpNxX9LnYPWLHdyr7cPUxczIPIuwVjzzjeNWMLJCn35zn3cnikPB/Pj5?=
 =?us-ascii?Q?3s2BTd/v/HLasyjbXPUaPaZ+W+tmc/tT958/u6BKYHewt0DDSVpEpGcIbRx8?=
 =?us-ascii?Q?81rSJZONmCFTN5Ow1gAYpCltb6UJ0mtw/x/RqwhIpnF23afXsMYVAiT196W7?=
 =?us-ascii?Q?UmYZHJ1wdrmRDnYiThIeKRjemTnpP96wEVkHCQETDN/UUG6raKf82IrLRpzC?=
 =?us-ascii?Q?zGfkteRc/ITtTXReVG/nibKsB8XYmbkSaxNeOImlFqz/x9pyXLQa0dKfub5p?=
 =?us-ascii?Q?Iw7TZ8vOfjaWTpJTwClhfvQR8Go06/popTn4FZ0xr2ua/VqdC8TD+Hh+31QE?=
 =?us-ascii?Q?pw+ioLl2TpLK83OTsenWYKznOme0hAAZbmjGQLbNtc2LKjIJMqxvVcqNAULx?=
 =?us-ascii?Q?JN3zwy+iU2rVgwrUFF+oQC5Cl5PJHqKxGb86K9ym2wqhQ7S4/lPezRharQ0z?=
 =?us-ascii?Q?8aubjNwoibjMgKIG5l812LBSquaHpStMytQD6/WUJ4yK//UhbTMCbFL/Ty/G?=
 =?us-ascii?Q?d6xXE1BgmVuLmyzXs+pTyCR/ZYINqkP7/2k3xddUV52AFc/1UDe1t4Iq7iAr?=
 =?us-ascii?Q?knAd8FG5n7flJhRy/SKQsWimQkPMQ8nY8Qc9LLs/T7cL9OTEf+RrDYlq8d5z?=
 =?us-ascii?Q?NQhcUsxxYUGiQ/3F0WoEpRo8faUBbseRV78DLlWHrG1stqF7CHEwN5Kjto4w?=
 =?us-ascii?Q?CKcV8uTxYANPLl3Apc0nrG8T2fQLFcjqtZsDsyB7tY3ejY8sIJTPlCiKIPGy?=
 =?us-ascii?Q?LUNE7RlqDdSGaC/xgtw3zPukLxnAqdcHuTQkFqUZUJ2rmHrlYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7gpSRd7KZP3KbuFTvEFtTZKkyUKq3adCE4ksGC4Paq48t7uAP7/utWfGM5J?=
 =?us-ascii?Q?pUlRgI2VSnC5inOgHqB7YqGrQ5OoP9cnAgGjgs+bH6Kqm5NCjzR6zPHNtffB?=
 =?us-ascii?Q?X/9f1WbAZeSUJYZ/EjaAavZwj11qzbt7ikBo192QifvwvvWaWQpA/ESROv+0?=
 =?us-ascii?Q?3ZjnNJJBCOQNB6K1t1Dhflo7vgX4yNJjGup9O0SHwpA91XOIJ7EzcTeEwQH7?=
 =?us-ascii?Q?7UUwhdeec4Rj3l5KXcztmbadxvUKp5J7nx+Z1liADXRqEan7D/Sk5JbOTH6O?=
 =?us-ascii?Q?pIOyzv7QIHIaWu1DCz29iRTF20MQ5HBygHOwyWgCti2yxttvJtftMozZ+l7/?=
 =?us-ascii?Q?BTORt2mYP5CJ4NRwOHXhFnRleo8tYJTTK0fdMuRgPJtQw7OiKQvFCLN62NMv?=
 =?us-ascii?Q?6nsTA1pH41K0Ppf3YU6I6uq1FSPpjuoql4SU/0NJJJBt77PXo7L3tPRUkHCj?=
 =?us-ascii?Q?tO/gUwWZSYwyIcF7EqIyftV6Ko4dvogShsf2ef7QUtg9VSdaeNpNX0k5n4aU?=
 =?us-ascii?Q?k3c+3UxvpY85sb70MjxToRulWU0O3Ex+ttXxq+5pLVzexj7wRBDi9oyiyvTl?=
 =?us-ascii?Q?n0dIvcqiVcQvw4Bw/NaBFmI7/ZwoXupHVIX0kqTiuvpstWhF4NhcWMN9ZIj8?=
 =?us-ascii?Q?YQ4LrbWEQa472vjcRI09rnDGt4EriFzDSFTbj7LYPbxShpmr9mW+ruNSTCDL?=
 =?us-ascii?Q?MMF6Mq7hSMQIx/P+YEYd+uMPtPmZ8xqI5+hUgeoHgKx/nxV1cb6BSDtTTHz3?=
 =?us-ascii?Q?wlKqeJ8+NZsZ0IZKq2B5fYtF+rJ0u8Y6x2EgnL5//IwGTg973TM5zmLCLei+?=
 =?us-ascii?Q?yX1j5/IHiNeuCafTI/fUjW70oNj0t1aqbOyVZkv3GR9K+dfz/Ok8R82Rxm2d?=
 =?us-ascii?Q?cza0P3o4UoGNw2tq1zxs6Fmzyh6VsisRw1sY3YaW9Ln/6AVDcS98hPkE9Jms?=
 =?us-ascii?Q?CmUKpcGTP5cV518A3IGZAMZOEr1NiptWBt1RefiC34GPv0snwDPChkRDUIxa?=
 =?us-ascii?Q?v0EtaSkgx2Dh8w+jtWS9xBeNlk5dH9OCue8JS9JlZSc+aEgg7+TAD7BLGIhV?=
 =?us-ascii?Q?o43F2KVeMbWc0bXVZ552RP4EVA3MKh5MVS07b7jZmP2UIWmRvAokfqv+dx66?=
 =?us-ascii?Q?P+uLjdosqStABXiC6Pcde6IdXRhRnyChVIjD7WNSW1J1pFyIBT0pXUw4PTxj?=
 =?us-ascii?Q?Wb7MzmFNEIfw/6C84bwE9Eh8JwZZwx3TqVvMe03YoNWlhlnnN93873zA3oXG?=
 =?us-ascii?Q?KS2/1lfJ8N9Sdu60vfW1WUE9fKzBW8HbSPYUIokMk7p0d3tZEGt7gczAGQbY?=
 =?us-ascii?Q?2R0QQPz1lkGJPDn45tuDWEVarEMZpwCOHvads4TAm3tCi/k4Zkv4YdFrIlNv?=
 =?us-ascii?Q?9sJtCbLrcf/QPLMJBaEOAzqlETWb67x4UojpKkejGvYB4ugxjMG/Ts6lCY98?=
 =?us-ascii?Q?mR3djpsPHMBj05+uAudq/ww+UQmsJ33T4kbWtBoXCf87sPZ0YA1n99WQdsLA?=
 =?us-ascii?Q?p71CDUqYhwWS76W9Kj73KBvgyHcD2a/f4vrNSmJLvX774iE5CuCDavykaqGa?=
 =?us-ascii?Q?FazlvYDKJX7QgMiA5mDF7EmXyk3XrqlmFXV11fdeU3Npd7WByygRKUbAyn1j?=
 =?us-ascii?Q?17ct15fF/gOw44xkUvVhub3YvmjJqsHMktOALDUJiNZI?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f941c3bf-cfde-4ae2-fcd4-08dcd11699a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 21:30:17.8064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THfXKaeC09GNBn1MffUJq6txHafAmKth0Ncr6mLJv3TrIJy/rGRl8xxkGJOTHAtv8lUmZUs1q7ez0ovunW3yjxJGQS7FaVk3QcX3olBTlDE4wOZ8ViJ433Pr/8FO1JzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6919

Add map_pgoff parameter to python dictionary so it can be seen by the
python script, arm-cs-trace-disasm.py. map_pgoff is forced to zero in
the dictionary if file type is MAPPING_TYPE__IDENTITY. Otherwise, the
map_pgoff value is directly added to the dictionary.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
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
2.44.0

