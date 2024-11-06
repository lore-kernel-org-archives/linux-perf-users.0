Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023078.outbound.protection.outlook.com [40.93.201.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA4320D4FE
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937101; cv=fail; b=PcDEAxIzuKMzT/nIAP6bGQpY7zemi9enGjH0ehjNhlEj2yTD8Q1r4iVU00akWLKqtSi7EtN5lHE32jMM5biqmUTyJfwuH8h5AzOqBZKiNnH2f4pd/fa3UYGs6M53e8UhKCYVsqyL9Plrl8NSilk36mRoKFccNhRIj0WxSzOMFFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937101; c=relaxed/simple;
	bh=RWICFGg4RDqX1BrK8dQaV3FNom1GvBdg+M+JNjRqqAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUa+9Ur1PMxsk7eg4PhadMCd58bgo7H8Y0eJuuKxiLhPEhJ3TFV3n11Ngp+RA9UfnSpo2rUGwiR8lm+jBhhoBtzQSWaoAys85oQtiidqqnyp9aVy2SkOpFgiLBJpVBUAyfMEQRlcetVoWHKo/jkggrBNlPPbMM+sMG9RlBsVIdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=l/qxVbMg; arc=fail smtp.client-ip=40.93.201.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="l/qxVbMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE3WO/2RRaR/tzcBmIipmmJrb5qDV0ILK6nDE2mJCJn3rybXydB3u7Glo9KpGfbD7COT1Cm8UTnHn9db81ML40PQdq6xQcF0edYpafsqndW1WYYIPrxT5DeE01bY0IxGgXJtTK5heCQe/QaXL28AK/ixzW1u+iyb7C0gMWEUSjM/pKDvTyyKWxPjIVNxPvT4WjLOh+3iAwTYCYOmByl8ZB7C/tXYc5TE/Dzmqz7OZc6Ds8DYZapZ3/SUBW3m85yH5ByiQI8QoPXwMrtOBF23yrZ53dbTNKH6bGdECh0o5l2HEeByX/33FUoB/pGZN2Ckqxmvv9uPv9672XGDV3O5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ew4dTYsMEOeNmGb4DZVwoyrogMASASsyEaqZ13kkf8=;
 b=wL9POkgl9JUi8lZyg2Jzk7vJLDiQyZEfhnvSJYVux4WhmfReqCF+GFCdK4tI12lrl6nf/cSrUF+2XW6m49/IWgrnhfrn8PhC/9sSfoBhVvY1FLk7/cyKEnQG6NEx3erJJK5fKx4i5Qg+6t/3pl33kLfTaxwn4g5/NqNX73SUNo3+x2IXR9n+ZPQhC5IzDANBZysh953Linxf+Gab8IR65/wht8nmwmNhl9zQ4O4TONuMcEzXlIRk+oR0fWSRuBxgMW6HZ68tRWQxKJZtnIoL7/BVbGVjh3uKy43zRgiTytSRICVhGdDaXJD8CRtsfUTGjn/IoWjX93JYb6+uLorwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ew4dTYsMEOeNmGb4DZVwoyrogMASASsyEaqZ13kkf8=;
 b=l/qxVbMgcke/dW/duvoPEgmwx4OR5Mr9GynBGLlm9aw15Zx87q+N3Cl+VXoQ7d05zpGRKkTKNZyu9wOjJbHln8o7bgJybI+SrAhaZJ0WXEjUcMB2uEoxp2pTn/GmfPVo/pZi/3SDz6tfMpuLhTUAcxXl/I3kBy1EUkPh+OdGAgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7549.prod.exchangelabs.com (2603:10b6:408:17f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Wed, 6 Nov 2024 23:51:33 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8137.014; Wed, 6 Nov 2024
 23:51:33 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	namhyung@kernel.org,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V10 RESEND 1/2] perf util scripting-engines cs-etm: Add map_pgoff to python dictionary
Date: Wed,  6 Nov 2024 16:51:10 -0700
Message-ID: <c0ca69f04ba93f1d05d753a3adc28ad9a09d34fe.1728599785.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:59::32) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: ea17c53f-0c12-4066-ecc4-08dcfebdf152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3zT7yJT3uQax50W3xORUiW/C5BH3ljkRDonyOaA2LP/3PRp38uBHLtDNbsZ?=
 =?us-ascii?Q?boP8iEAxUnXm/3NMDOS4z2aNJ4E+jJ1SiBw2izyNTWu/3DE0EchVOtWCYWPn?=
 =?us-ascii?Q?MgkG693c94IK5ZhBWy54n+nuP26LNbgxHCAyKF8I5uZ92P3mtL2tPmJ8fxk+?=
 =?us-ascii?Q?urIVAW3y0LAg0qmxOwy+jPMa9hPMV85v85ZzlrAQEtLBlLVtntrLWcL6J9Kx?=
 =?us-ascii?Q?J5yw5GhsJt+EknvtNT6zlsVgdtdakcea/qDV7NKTOT1bU41nZn+wI1XQ5XGW?=
 =?us-ascii?Q?fCsYRiFTtJnkU1+TvJPnmJSHaRkkzxhPLcNfCerfSHAUSMSzDLBllQuIVtCH?=
 =?us-ascii?Q?woB22IEDfWsX+y/Ji5F0GI9Jf361YacsDEyjetFocROVAEbBmeTcUzi5lLiM?=
 =?us-ascii?Q?D6Iv+JD2mF9OkL88oA36XKyUmnZvBHv1pNUT/n0YEomBXAJPXAxHlm9QVRcT?=
 =?us-ascii?Q?VGs7ox1R8OAtF1WUhDV2BqZlOP7bvVF3jS58SAei4qKJsweiBbxGIIJZud/y?=
 =?us-ascii?Q?dql7O0rNWeLB9oM40YNOdxENYDHUXMfuzBunZ2634rAUUa2foHxgoZs3mKdd?=
 =?us-ascii?Q?AqkKQQIZijI0DzybDLuxT6IjYYv8y8gosbuZiSzKPSGiTuyFUIzIaadxbwiU?=
 =?us-ascii?Q?t6R7wpjQ9ZNcR8qe9i+GR/yYLLi7EYW9NoSZhq4FLRCxfvG3fXD9vasFR+Ly?=
 =?us-ascii?Q?Jx1AENHNMW8tRHLmaD0aMgdH4asUh/RRCWOhtu6OhAkFs9R8EZrhtJn+q6gS?=
 =?us-ascii?Q?AOIEiRwGvwiNRq0HSzGi157TaSl6m6SLc0Woj8shFppeIHaHNKhvsQWX2XM1?=
 =?us-ascii?Q?JGWN+EzNldmvqhfF3lPFOL4h3PJJgl3reVGK16zFOzzbWeOrFUA0kmveKhlA?=
 =?us-ascii?Q?zPk7zv7eRdZMrbeoTJ0aj4EktCl1grdT6rLxnCTrgdMTdsLZcqfGOqrtcYL6?=
 =?us-ascii?Q?V/arX5FbBmH9uy7l2zDFTSWTB1uj48MbeKwHRvadvTNJ6ahBmmIZu1hHfggE?=
 =?us-ascii?Q?V4s815HminhUskoNeWkVlWlyovtg9VkZxbyNVCtq2YN72S6C+7BP/4bE27WR?=
 =?us-ascii?Q?GvyjhAmEW5b98YQB9TjT5nT3S6pbM/mxZdbfSIb/1D5VEOFrxm7iqDkdzrKP?=
 =?us-ascii?Q?wqAuZFu5oEcW+v0bDQMq/aB/lQISrN8/x1n0SAYCqdXlGC6rAWJKLn4lPSRp?=
 =?us-ascii?Q?tpnokL/pKgViGS4jq8CPcEN81Nc72wM8jbom1nRKgZvwgH0Hn5N3ojim6f+M?=
 =?us-ascii?Q?raf0UsLEdOfUDCBpdL3GiAwBf8Q+dxH51xkbgaAG/TeM803meswOp5qhvLqz?=
 =?us-ascii?Q?f+U3OlSwh9y8OqqHHsMv6JhuUFZP8iADZF63CQKzroq9CYOhle5YnajAJA9i?=
 =?us-ascii?Q?yHj10vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?neWs/UsTquw8MPaaHiezYlV+b4g5ah9BPKtobF0rSte4NGRALA1EAOf7g0tf?=
 =?us-ascii?Q?itkByQlyId5dC8amNKyEfVY/S5MhBbj7bEnriFxLWkyjcPVklBrI1yku/IAd?=
 =?us-ascii?Q?p5oxxpDpx3u0GdLlpb5HfFn+JFTFxEfntSKyrecIt3lSuFdivb3GZKICTj6d?=
 =?us-ascii?Q?0K1uBHP9qYov9OyboatxfuDkTWzfVTPzslFOf7byBOF24txhi0b26anUOfuZ?=
 =?us-ascii?Q?tADyyODe5AFdKK9u/LdsOcY3vuUb0IeeCSGD9RjB6tL2hkNoF2x5XBMzg8VB?=
 =?us-ascii?Q?aAru0ThUl2R5yFwPXHhnyboFY6+G3WeD4ONNgmAfZ43MHDxy+WrmdBKvQDRW?=
 =?us-ascii?Q?vCiXtNQq54Vduj/EslGe3F7A51VAkC8oK5EiUmjN2Djkl7An01cP41NMWO7g?=
 =?us-ascii?Q?U5syV+XIWfm+wrPXG5Eas2Bh9m8JWE6nOpZC4zulv9kNAGU3bw6aOer2F1Wp?=
 =?us-ascii?Q?X5dSXrRayRqJGPsjvesPsf7VRmoCL+weXC9kglt1UNaAuQFBUGRscYbm27l5?=
 =?us-ascii?Q?GPU6gFJFcZ9I5TSrQznEbm0nzoUA8uM7zHk1TVNzK3aEgqb6MNsFxMWwml2Q?=
 =?us-ascii?Q?Vi89/T7vIC+eHmSGDa/rpiwudZ/7WHpZZW3ky6q0aZs9R2U3CwnfrUWtk2pB?=
 =?us-ascii?Q?guq0Nd5EV7TxkTwxpWBbI7/sjK9dUKSnVx5U/pshmHzQ03KIKtpEMq4IU6gz?=
 =?us-ascii?Q?7RSOtb9jWAQu9TE2VhiK4N8g1oc0kieQo08286jRt7csuZqegKeAX51qjzw/?=
 =?us-ascii?Q?0uHddJTb7/nMerCYVp/5Wb1D7/Ch0embYHZlu99gzTwVGz1QAt0JFgcoED57?=
 =?us-ascii?Q?oCNruJA6floChRXCnbkaNPF90dn26aZGVjYvgLf6sWPc5h98wqBADvknDVie?=
 =?us-ascii?Q?qgRtut5AUYgss0heSZVtalDEdGIugPvNgXQDjcUQlhVTthV5yE0Y4bUB6fq+?=
 =?us-ascii?Q?NSunU+5V24l/gr3NGMJW75Hy/SDWKQEpg7n29EcSI7xDbWyIvDj+kegrV6Pb?=
 =?us-ascii?Q?WsIPU9dHR68yqfWHEdWzhHLt3/KvgL0mbfyGiwDMbnS8GkdQziqzR7zWD4zE?=
 =?us-ascii?Q?W/GrSxFBL64KaTY1jBzngHfLXyi4ekpqRbFyPH9Ixk8QkggTd9ZTKvcZG9PG?=
 =?us-ascii?Q?qWdndC5L5qGA8Am2dXwO6XsHUGpDtQzrVewJyYnBPUqIMMMLYKwLf5+fhJyd?=
 =?us-ascii?Q?L+8mdxiM7SvVkeZ1TbPQlaztG3rBLvB7j5sWscZSYbqfVyIpGMeImlSp/Am8?=
 =?us-ascii?Q?oq6cNLGE8geNupAZUpqh9Ld3hWBbsdZ3kV3cQdWYJAF9/e/N3VN2olKTxM5q?=
 =?us-ascii?Q?YL7Rz38IkpKxGQdjhCprtCyu+IYugamB0RIglD8FOnu/0BfODk5MgpwZnZca?=
 =?us-ascii?Q?3Ci96psnzTzQ2Cuc20aHtIsG2wdEHkcxcgLxYOuL0CvLCY68T0xd6bkwrB+N?=
 =?us-ascii?Q?pJTilh+Y61EW/NqJTV5UpEWs0LwivBP60VDUaocYD6gSkwYyE1HnyllhkI9/?=
 =?us-ascii?Q?0+0jVdq1XTz+xICIQWyVEtluL1iXrBwkyTVcts2bgWHf5CHQWPVIYzde+6Db?=
 =?us-ascii?Q?/7wffgJlmEaYEPFAK2stJLgr/HzaULsUE5Bx7EMWh1EL8AQUrUb+dbcrGtLK?=
 =?us-ascii?Q?6iGkNmrsc5YsCKH5AWrYMWr+P5n/HnpidNAxvS/ckp1O?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea17c53f-0c12-4066-ecc4-08dcfebdf152
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 23:51:33.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cW4UaOPzY/dTGk3blnQX6k/sfm88CBnzouxPYbM6dxQ72Fv4JrSi9qweBMCsCb2FroKW44FRmBb75IUjOj2iZ6GUt52+P8zuKNgcqs5joXCfrHfEKJUW6YA8OwnzN6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7549
Message-ID: <20241106235110.5NbhrBJjBk6qY_Sg0BJUbMXfpfpi8KZK5R-y4rZfKXI@z>

Add map_pgoff parameter to python dictionary so it can be seen by the
python script.

Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
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

