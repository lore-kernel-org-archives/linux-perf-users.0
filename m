Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020104.outbound.protection.outlook.com [52.101.85.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145E433B0
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809845; cv=fail; b=N7clcjKrgGlWLP8YBogtUdzKyu0+sjEBezQcErRF6I091IDOzj8n+F/BoaiTEU1PoqqXOL8BwZ+7B5AYW++a0uteNwW/PO3fV9xbuTCDJGK7bqX8wPw9suTfVOcZmljEmEE5LkkEBZctESmOPfdgJhhKh34ixijarymUAGiySD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809845; c=relaxed/simple;
	bh=G60IaSLDQ98GiNIPs51zWzFBDNJr1BjBJbs5siSv88A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=diPQmO3BnFmitTcQrTizOTp+Ww+650qL/7x3LRujW29FFEq0vlmiw1oNa6riE2BS4TQFV0VDfiEGujWtEKB6y2cTVGcHO2Ba/DyroVLs06BNUUn/lI7rcyMhqqoa8CZychJSfRLK24JQzybGBAFxSn0ZBb5MBlgSmcM8R5R1zM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q9AU+2Ac; arc=fail smtp.client-ip=52.101.85.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q9AU+2Ac"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp4+gXUWRFk6KuywfLz8ul1lcrdnbplXbwdCLsDxDJJYdr09f4EuFMa15RZJ5nwID48DkrW/2sZ8oVmeeM4H/IxRQ++OTnqlVyDCzieI1Gn/xrzByvQMyQiuM8j+IAuqAXRQ8tvaoqyM3O7/8GdWehuCJlK2S2Jpqc5pVmHtvzwNcK1GEpQx0Qa7sV9YLHdz1H/+9XUtIwYr2km/BCK8l5rEADrLa9QYx9UNzNnncKCQBwAuETk5l5n7ogstd+XvnYgQ0Hmgo6Ry3VHfUo5mTW7drCk6TFObxn5og5J7TBk3yQwIyRhdKjrYULbSWI509ilR2Pna0YM7laTM22l3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czhYmkK9bQySdWek7NVuIDE0j/g2H8moMSE7Bg+fmkc=;
 b=rmKifujpSujBBGACfbMUOCijwBbHQI3cS64QT/RBhwYEshDwUY0h7q2+qtbeO2lXXTy3BrKYwVwjOpg6GxDnWgG4lQV73jTk2B05rUY3qWuLKhVk+yWg8G8HOhixD+c5aZ/LvaOEh5sFpAab+8bThZ7SV40SwZJdTyo5tdAmIbRH4jNSnMF2KPZwxn3pH4U8ALxbbsdNFpr/FeLEdcorP4qxWK2SBUVhY/c/CS6uKcn+5rDH7BWEdJ9dWUe30/kXkDy3X02oWoT5/h8wjZ8Ad2Vrqooxp/3tz1pXWTsQhPidDTi5DuOGJVuFG8aRhMMGni4waM4O0qO9tNmuUaNtTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czhYmkK9bQySdWek7NVuIDE0j/g2H8moMSE7Bg+fmkc=;
 b=Q9AU+2AcsfkGrqsU4PYY0WmThG48/sEOLWtFXzJQGGj/W0WzOjJ3nf80GJtUfil1X6JKShyrQnxVGqmvmOZBbn3JRIstVOPugBuVKxT4iBudIm4ko5ktTs5m1QmzIWsnhMtsG0VUepxVTaxL3kAymlWG2c/OcqqpB20KxZ/EHoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 LV2PR01MB7576.prod.exchangelabs.com (2603:10b6:408:17c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Wed, 28 Aug 2024 01:50:40 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 01:50:40 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V3 0/4] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Tue, 27 Aug 2024 19:50:17 -0600
Message-Id: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
References: <cover.1724808513.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|LV2PR01MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8c25d8-cfb2-448e-551f-08dcc703d1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3wUUXpydHVcVOlnkv5VKzNfGP3gJ5FkGslrUWyymV6DBvkVaAC5nBRkb9FJi?=
 =?us-ascii?Q?8+qc+EbN83SUy7q4NnG8lRzieghv7XCPZLJRR6vDgl+K79W6D9rh0SItzFqK?=
 =?us-ascii?Q?kD0zVVfFzrgAygVLhQdvCYwqaUjUyLym6bM4cjpE51L/Sd02YDjEtd7iEfAf?=
 =?us-ascii?Q?B/H9zoADaVdPn/YQbCU1Q4l+Gy+IInKDa66e8EpMKMRuquuxRJP+JKTErixT?=
 =?us-ascii?Q?r7RmsBdW8n4CXpIyfvq382cvmA8kAbSqqlkKAAA4d6crfK94/ClWZpLSBQlN?=
 =?us-ascii?Q?sldfXLmBoU8LwgyAIMN1g6bKDS7910WWDPQGPkHX7/zYvM3OQj129nMVNpsR?=
 =?us-ascii?Q?0GJlDe8SaW9AzGKdOmTvoOKCSWsy02FPjwiOXBgzBivaWZwSls2FgHGbn74k?=
 =?us-ascii?Q?2KyNudZP0vpOn/W5RurCGBy4qpRt0Wqh+3/zqas6K3gDDUc6JN4+Yo5LAqH7?=
 =?us-ascii?Q?i4h7tzr5Nx/1AkC+6AZcq/bBY3uiEDjyX/XGs6J7Hy4ATW6KKLiGlQy32H8v?=
 =?us-ascii?Q?bKIWMV7Dp09+p6jPwkz8FkJy7hC3KQbWC7U85yvnZokvC6sFAHvpGaja16lw?=
 =?us-ascii?Q?Mt05XAiFszQZt+CjQzttXlDxuYivtnwu7iSOh4s4rrpg8Rz4PQjHJ3Pb5Swu?=
 =?us-ascii?Q?j34qhEs8/yYb4422bVttumnNbDd0ukBv/7rw+3TqRF/G4D+4qO8TQM53V4eK?=
 =?us-ascii?Q?f2Xvcbnlqyue8d2x3fxyA7DxyF9vYjCJQ5Jax5zvN4k2CvZrRkWy7/n+lJR2?=
 =?us-ascii?Q?h+4xQ0LnkLGdtwyxymAOnp13VFf+pN+Fy7I+B2NH2Lr7QOZSPSsNzyE5sfIP?=
 =?us-ascii?Q?6qQYDlVb4BUlrUUhfFams2XceUSlVVUExkj5/sQ8ecVwLYflnIoyFQSbcf06?=
 =?us-ascii?Q?BGiIR4F472d0avwWG7He1bw+5ipEGhQbSB0by0CMUm/JPyjIV/ETH3FwD7ZH?=
 =?us-ascii?Q?pRLSPKBKHqm9kORMvgffvimHiC0L/PPVDLTC95Pgs+o1ByMPgUF6JpiRrmTG?=
 =?us-ascii?Q?/ryaPw0T+VboxdFHJmA61HHwNWBIreAt0eucrhj9nxoZGgFfHYRf2PHQvQNj?=
 =?us-ascii?Q?y5YdPgPh9vitugq5AFamY8a58qxfM0CFbFat5Mok1vQUpODTFpA0iALIkr90?=
 =?us-ascii?Q?6UrKwVCH7zgrYgaBDQc3BTOTxdh7fpz8ctlERyHv3zOMfMwBIFNttAzeuTJW?=
 =?us-ascii?Q?1N47YeqWyYDVUYHsnZbJbWaJJg/vq/ClBc1ox9oULN1S2MlMKL+c35jqsHL3?=
 =?us-ascii?Q?yTu2akPbN4Y7fjIH4PY6m/37ajDCIcUJdRl7D5KasQTvp6fz5Rt/xs0h3qqA?=
 =?us-ascii?Q?Qi4k/uhuPGuRgLiOv0ARoceVizIj5J4sO9fcj3S90KX+iR2H9KS3UDY1Fu+D?=
 =?us-ascii?Q?RZnx2Lk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fFhLYw6wLBiK43AmPUxQWiRlutUWf1cQFq3bpJDJCmxezt5rkWiHMEas8e7T?=
 =?us-ascii?Q?zxTEax9OHsBvZM53QnUBNgRyxwrsFbYsxkfRq+lG4KTyYp923MU65WWzTYIG?=
 =?us-ascii?Q?liygFL/67u/3xAfrZge797rRkYZ78Zgxak/sF0Mn1WHzxKr3xc4DQQn8uP4X?=
 =?us-ascii?Q?KbyThyfkWinnZl/gYzZ/PV31Z23ewdGlEHhSeM6cm3bwUUBeQCRvoOQdjCWI?=
 =?us-ascii?Q?ko00y7nWZjXhfS/3rRNNGTc1CJolnh0Jr8bne4Vy91WvbKUDxm8XyLZy3IxF?=
 =?us-ascii?Q?GCyaPs+g66r+pKQ0Krinmlg74cus8RVYrVgzVqtuc81yQglTbDW8eVwyhcHM?=
 =?us-ascii?Q?EgWc9aLSxX/JsBEZhjq4C/ztxxW2LUUTxuSw1xBl/UilR9RffsErgkexjViV?=
 =?us-ascii?Q?88ge2jDuNbHcAIW/tp9wCkkz07xiQAmFrdoA///fl/bcSbgb4tFGb0faCQZ1?=
 =?us-ascii?Q?RRPikqiMbbfbnU83WqjUZKcS+Tp/Yqm7WjsTJ29JYhJ4IiGkFm/gcozkznll?=
 =?us-ascii?Q?kPsVXSxAnk6N1lq28M1Yn55srSbC3nMBeIi1POvetCcKUEmtzcx9JUvkaD04?=
 =?us-ascii?Q?KdlJc2H2Fl1KBdjFVxbrPBxT/f1qnayCSlvFp2AM9FIGAOSXpMRHBr1DpJDM?=
 =?us-ascii?Q?5GkkT6erRs8dLOCPG3jdxI5jkkH1AGT7kQvqNyGI82wRhQm76EjFk+9+mXl1?=
 =?us-ascii?Q?OLhqhTNk6G4vQx7Z0zsHRfaSIXtiOeHaEt4giSLlNfxx8pPCjf8SdqO0ybxt?=
 =?us-ascii?Q?ghWI7YcCv4dTnxkjEAddfF0neIE6s8gSMkWgoaY9V2NKIJoWYxoiMJEZbEBl?=
 =?us-ascii?Q?UpEI5Oc6UzFrz1elwRX8bkFJ1UuMZhxP0H0Ah32m090jFPScI5WZIPTGQ4cj?=
 =?us-ascii?Q?Z978Ba+tNiE+u9FqbxWhEAuPs70kc04k+b5W4LMrPz4H8WxBYA6oLitqJcUA?=
 =?us-ascii?Q?t6iSPq3N+wXZglBbV6vKwV78splVn20BdpXR2FE2JkTVilSedJAssloEnBEu?=
 =?us-ascii?Q?YoED6UT/YbmLTm/bd97mBgCghlBKE9PbRoshiIroonhgcsZQoZZzQzl8smAx?=
 =?us-ascii?Q?lTeEuR8l0iVN1Zcod5Gv1GVQo/Upqzk0GsOgngRZQ84Y2KRHP6eUtB+tcr+S?=
 =?us-ascii?Q?L1OO3yHKuvtyoxE2bCdA3/jXyUPxvfvXNSSBiGB1gmBDBopSfFDBqED29R0F?=
 =?us-ascii?Q?bL4q7SX+Exyh5bTZjh3etzmmanKR92FYmQM9V8KSjQ9u73KiG5HmLLLZtIu8?=
 =?us-ascii?Q?bAMC1CFRbi/hIlV6pT42PmlgPmtkzY9tsGHceIkQPLArPte0LpX8R3WjrTym?=
 =?us-ascii?Q?XiYmqGM+7kh09uOfWnwYgihU3oT66Xc0lSY2e6oIjja49knb2QfEAUV80CYZ?=
 =?us-ascii?Q?fLOaTS2iyCa1LRxakZZhw+5xs5Gr2YJBPfTkiwCwBSgumYQvLdOeDVG+au6V?=
 =?us-ascii?Q?hZdU8TK+uB8r2xoS/crvUFRIht7I7gm7RfkEoHwTp3JB8FUC/xf6hCwRBmRD?=
 =?us-ascii?Q?2y3I+q3Ta5QeexXkTy50DkRZdJUSZJ1deshUqheEANEwRnHEE5hDXG13Rdqs?=
 =?us-ascii?Q?LQ2NgfapPLNdgrP0ydK00gCECfoaER9eds5OSblRt8FlUAt8CEZDGuMl8l2D?=
 =?us-ascii?Q?yBPpMWsT/DlbnBS25Pb1ViQyfIAaxjHmmK4sXmluMlpg?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8c25d8-cfb2-448e-551f-08dcc703d1ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 01:50:40.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DyTE0zNwRZZs6o2CWIFd6WQSzkVZtunMdqKFLQlr077kCu3MPNMqoxj2JcR7PSof/Pi/VhNgcfOl7UAw3k5yBsDu6IXW0WIEE7ygYgV2fnJzNGfBlPe4ii/bu0/3izo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7576

Changes in V3:
  - Rebased to linux-perf-tools branch.
  - Squash symbol-elf.c and symbol.h into same commit.
  - In map.c, merge dso__is_pie() call into existing if statement.
  - In arm-cs-trace-disasm.py, remove debug artifacts.

Changes in V2:
  - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
    checks per Leo Yan review.
  - Updated mailing list distribution

Fedora 37 distributed shared binary and executable mapped files show a
zero text section offset. Starting with the Fedora 38 distribution, the
shared binary and executable mapped files show a non-zero text section
offset for some binaries. The text offset parameter is never passed into
the arm-cs-trace-disasm.py script to allow the script to adjust the
start/end address range passed to objdump. This adjustment is required
to correctly offset into the dso text section. Not doing so results in
an incorrect user instruction trace display for Fedora 38 (and later)
user trace output.

Steve Clevenger (4):
  Add dso__is_pie call to identify ELF PIE
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     |  9 ++-
 tools/perf/util/map.c                         |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 60 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 79 insertions(+), 8 deletions(-)

-- 
2.25.1

