Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020095.outbound.protection.outlook.com [40.93.198.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A91B12CE
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575336; cv=fail; b=FKHkaOiBqnC9JXxamzP/X/LOrr8IWq7AZU1ZB9w8LNzkKwdCrrsW6PSA7RKW2Nqk0BT5KVstUEuAPbxaA845igM/SkzLyNBDqxqaaQPMHulMAJBi9z3Lq2jSP4j76m/4PGHATAUfgTCgXNJIFHN/Tm8fApRNfzTLbKmreNrZikY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575336; c=relaxed/simple;
	bh=BeLPYFl64LSniXEZIGog1MrtXr7blpk2yYUe4/PG9Yo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tui+IhSQ9DJSIDAgTHSvG49Zgy1X/jJxS1IX3olzZrVgzno8r96Z2PaiSoHb8GTTfsdX58z0bdXTmm016JLSjJW1Nfeq/tyxKK5IENyL0G72bsDYUflyBU4xRn+IakIu1PiEFFQ/+HpzRGjx9cVn+9nWFZgURjTZEyrGdZ6fhps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GjRgyKJs; arc=fail smtp.client-ip=40.93.198.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GjRgyKJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHVK8Bqdo30yuKRmlmgaLyaIWop+CzNRTiXzBibMOk5NukjYYgMQV3i3TyseI22O5/G2i6HCOvFISKaPheYiVx8yMi87/SgjXC7ZwA0xWU0aYZ7/DlHmpTYeDvn/ubNDwttUNh6DVxe3YsfqGV7vFMZk0mH8qa3MuzbUp5438F7vxAuocRukgc/s91hzQNCCMhkwu8JyWTq1lRljf/LW5DZtA0E+2kJkutyOhI7vdzAhLt4Q/rQa3+vvV5oqGsbmwOC1JlDZ4uzB9dOo74rGA4c9daUE2QcHoIWuGwAX5CapLlGFqbvwIUFCdmJoKtjQw1fLN3q+DBCdlU4rzK5ICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQI6vLsSQ0lgbkgvDRirR2m1bIxppjDlCXwnX/HohjY=;
 b=jLqR/DkbYgFmLtHU4JcmX/i7N5GKW/kLibQBNSzI2E0VLGyTLhJhxs4x5XxDAsxBHo/9p1xDHKBd5vTUFn+LfVb6PGB3Rz2ghIV31bvDVza+9Zwa9TutJpf3Zh7R6eT9QYjXiZFuohC/JBC8gJdjMHSOZ2d/5KCR/lRixo+p7Vj3ck+DiGsZQcQ5P7BAayUJBtRwwLBCK0WiGhKtmVO0KH8r2cOX+pTVeQscjlqJDm/j4kI7tpnotUV/17ZYrnPgnw6cCzX3Qp3Y43Kt/lrSx/K65ruX2+9RWzgDplhfM+neYLSYKX5DefXMJnyJqyE/QL38c91zILfE8cCZ6YFyMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQI6vLsSQ0lgbkgvDRirR2m1bIxppjDlCXwnX/HohjY=;
 b=GjRgyKJso3FVufNs7AiW8vJePLu5RHLm7gwUNbDoEtP9ceAOopwylHCn1GuD2s29M7SIjzNamyBrZ4bM9G5G0auqXdIqK9Fu9fOkfUlOVP3YFLYw4dkxRRQbmEJgJe78VthLWrMlJniix9DzmOUMnKiPidIAZXZkjcF6qisb0GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB6501.prod.exchangelabs.com (2603:10b6:510:15::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 22:28:49 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 22:28:49 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V7 0/4] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Thu,  5 Sep 2024 16:28:29 -0600
Message-Id: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
References: <cover.1725573309.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0056.namprd18.prod.outlook.com
 (2603:10b6:610:55::36) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f43f9a6-b148-4374-f80d-08dccdfa1d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zMFxKvepyis9BAI811NO9oTpP8MN58+glH7humzZoPyQJ1JiISAmkt1bAZlc?=
 =?us-ascii?Q?kQiszgH9XPy0C3jE8hOYmCfgP5G/w3ysRqhVhc+fcym5X38Ds9LAP+ILo49a?=
 =?us-ascii?Q?ec+0F7jIIWxWNmgP8uqwgifvbLLzWrH0l6MJPRXzrbL3zv1KM9mvGM5XuBJV?=
 =?us-ascii?Q?DzDE5RjZQLBE32AFWKGeJBZpKAbmGfGRjYA3WqAAMqo8xSPw1PYmCckalej3?=
 =?us-ascii?Q?niUVpC6YQchjld6DkN4MEumC6W+i1NUeDctz4H718v/RNm6TGZNBTuTlFFak?=
 =?us-ascii?Q?EjCRrKtLA3VgcXYlgty/5vH2yu2hafBEQpEFCuXS6se0ObPMuoU9vhtOT7Cl?=
 =?us-ascii?Q?rygcPlw/xUYHaCHT2yPkc6vJxPBm6edvWMDHxEagrAARPGEPs5v8ZQVgnZTx?=
 =?us-ascii?Q?SUtoLgLN9tv/UsXitqq23DscRn5Ewf4FlEjnsDb9QiMHvwvEF6jHTkG06Ua5?=
 =?us-ascii?Q?SbAIDML1ueWCxPmgEXqdVatzbbbRQwA+6SVE0J+tkmDTUmjq9wA1wEsaZrb3?=
 =?us-ascii?Q?bClGE1CFMFjmShOUTm4Kd01Zz/k6815vg3RE1SqIM77GFH8ps1G+jLS3+xrg?=
 =?us-ascii?Q?8Q3dQ1wERz+9hPyzOb2qCMkBgPRZ5F4axOPplzzWRLsZR1mfIs9fBpxT5MXE?=
 =?us-ascii?Q?c3tzlPmAbLhjt4fqKDbib3CYzExGhT39dTgC56RUtDhxw0anDScYWjD3W815?=
 =?us-ascii?Q?m86v16fDsLRu3Pd4CWF5Gm9CzdCeC3g3XNtM3cDYcKbq6r4cn7NkqmCVJ2On?=
 =?us-ascii?Q?vJ/YQDHVCPXSP1NPWuHnQs5l0xKm7R/weMAofcnzg7BKdgEO6EynDW3Sc1xb?=
 =?us-ascii?Q?lqUBVhcW/3WtsGh860SXtlaj8NAWQFwW6j64wbB7u6XDb+9baH+sVtXfSaK6?=
 =?us-ascii?Q?Mim9ln97XDlu/IXdZE8parJtBRnimdOZDT+G4tedXj4xTF4ZiNEZoTVJv1s/?=
 =?us-ascii?Q?eqP4X73g0eCf4ZtzwUVk8ThPoIoam+N/avRHfEIsMvAAtfqscZNQn4NFGpSq?=
 =?us-ascii?Q?RgAkMkPD9N6/HtR74yX+vOaO3r1mcNVHVNgHvr9SjDg90oZ9TrTAPXLaax2L?=
 =?us-ascii?Q?/zYbMoPM3klYSMkf3AbYuw7hQ6GR16H/m5r9USqBoGSVueJpRzI4SbKwkPZB?=
 =?us-ascii?Q?qDv9gGAM9e/GNGLMtfN+R7svjr6JnrXcThx89Xcm5BKXojsiFEYf4uhKYGI6?=
 =?us-ascii?Q?h8YjY+x8SZdeL9SM+iMWnoD4vwrLozEB6HxH7jqar0JMudo66YUVvbN1zj6m?=
 =?us-ascii?Q?U8xS4ON3VSjeV1p5tDEQyW8b+NnOp5o6YN0vOj6BxXxaKANmVQQVE1wwhtd7?=
 =?us-ascii?Q?nuMkMH4TmqCBZUqyO3TE5k0vwtT+l+hn9LE1jz2ph/I2ufz2xX/HrG50b/xu?=
 =?us-ascii?Q?OLde9x4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dk4EnJ6SHUo0KWh+5P8BKmGC3FNSo0g4kbuKOvH1+2Koo/Ffb2xY8pESP/Sl?=
 =?us-ascii?Q?JORrzgBmA+81BumaGd748bWAMChWMwEiGSt3blN2lypCQv0Q7dkGXj696TFi?=
 =?us-ascii?Q?t7HIq1dOT0Os1PSiCR0r5MHdTwQMjN9eyDzQCHRwWGW4AuK2bZnjTvecUPcL?=
 =?us-ascii?Q?Q2MCyDrYjnZKeT5KXJElY/Ahi2JjFRNySyAgmfWq/iICNKODNb9Ob1ce67KY?=
 =?us-ascii?Q?8R5/6duz0b7pdEfB6O3ywQYcPaP34XSamGI810o4gKxdacWLS9VnmOAv06SR?=
 =?us-ascii?Q?Ph4mylMyBg57r5w+maXUTKU9N83jU8+y4oQYOIoqerP4K5M7YPe+ZnSv0pa/?=
 =?us-ascii?Q?51+iM5MpdTzk7PAn46wxjy7EJloBwvuNni248OnsUTkncBCDIhMxqOqgk4XV?=
 =?us-ascii?Q?LCKdJD9nDcMLPAUhU+xgP2/8E91R3khugWgObyIyCQzG5KFjfSvfEfaEfIFu?=
 =?us-ascii?Q?QZ21LPKaBDWCWQsMgjij/blF4O/qL09lod0dQFraGF8HuTr7D9LDJ+IZthG+?=
 =?us-ascii?Q?G8jl28g2V/An4L0OBXBSXSnvd2ORyX72O7RLz0RW7PXyP4upyUywnPF8iw2E?=
 =?us-ascii?Q?Q9LxWmjfx1PMzb09v/hW4IVeR9+oO97bDrYEQy34n3HJabrL+pBxJnkIpSZy?=
 =?us-ascii?Q?HFoG6ZUG2ySl1d7IWhTnP2Ep2jAjYyZ7NR5M1z4yAPFLDeVBu0XXLztvDjpX?=
 =?us-ascii?Q?kd9o7I6QGo/3gFQ0qNFtJ2fKqQgUVOp5v/QRn39j8t8d/kTVfQlowkvbv8I7?=
 =?us-ascii?Q?lO5jbAL8kj+sOmTetUlrUmNif9jzrWYZe9ZRSs1bHuOtSKXObbAYKx2T1fOn?=
 =?us-ascii?Q?LWJbIm/PqociBZlocjlRzb+T3nijDXkMgWUwRbKUwiaSYD6StHJQuIHjKk2F?=
 =?us-ascii?Q?tWTp1MN5fv8yHVCgGS8aLZ3Fd21tsk/4cr8LxVswN3/l1hgJjNq+IWo9g5yt?=
 =?us-ascii?Q?r6+e9BE5JiEeL69htdlFi78DbLL5wM9Oa9CB9YAWKgoXhUKL9/LaPFr6Z95v?=
 =?us-ascii?Q?OAb8iPfc8e+tDHbkN8OD7rdg4YWNLeajWvxecd6gaLaGT8Yf2/oqdE6H4Kw/?=
 =?us-ascii?Q?QDUrba2o8Y1ZlT0MdJDBtxvfSIRF/N0/zbrAzh07tNzZq5X4eAlFmnwRAhPv?=
 =?us-ascii?Q?9S9z98lhjU1+1pN4gv+H9C61m22TelqYKpwDJeZBpsYL3gBxwVMQG4Gj22I5?=
 =?us-ascii?Q?47sWIIT3x0no3M4OXoG8Lpp+82boWEQnVB91VyBL+F2ASiT2Z8b7ZT7RB61j?=
 =?us-ascii?Q?BBEIn66kFtXnqF5TQ1gxldwS9BeV+p2xsG7JxehicRb2SF+nbvgTK6b4gxHq?=
 =?us-ascii?Q?ZaOEiuRr4DU/vnj5lJrIvfdn6ZAQxjRKIgrmEaIQqIRM4za91s9DUBlbQwMh?=
 =?us-ascii?Q?Kw0nV9wTpUAw2By4fPLmC6VxhB7fN5FvsaNf2zUz8LvMGr0gI+WhqAL95zSe?=
 =?us-ascii?Q?asFXTxG7flqvBYFAYH1YDaU20zlNfc7HUwkwC0jEuDo8tOQRcaMPiCSwd0ze?=
 =?us-ascii?Q?NYSRTSSFxCmUWE+KgmyIEEchUHR57EbnwYC1nQpGROd5SnUPdmPde7xzfpvD?=
 =?us-ascii?Q?/KfvvVjTs5EydLjuXh7FjGJu2MEaIjhmkVPm/xEsL8Dlteu2OzCaNAw5+Ysi?=
 =?us-ascii?Q?FoyvR2JvNBLFlngdkJnOizhqtawnfyEozjx2o8CWNa3R?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f43f9a6-b148-4374-f80d-08dccdfa1d39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 22:28:49.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p07/Uw373K6AOy9p/s8BfMiu/5G140gSBJzEpwGs4FSJofGEMNikbbIF9XQB3WWnHONq1DFH+q2E5p+nvg5+OZODFZ3LJkdiCbMHtFl7N1HFbIqO/PdZqdX8PAqNig6o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6501

Changes in V7:
  - In arm-cs-trace-disasm.py, fix print message core dump resulting
    from mixed type arithmetic.
  - Modify CS_ETM_TRACE_ON filter to filter zero start_addr. The
    CS_ETM_TRACE_ON message is changed to print only in verbose mode.
  - Removed verbose mode only notification for start_addr/stop_addr
    outside of dso address range.

Changes in V6:
  - In arm-cs-trace-disasm.py, zero map_pgoff for kernel files. Add
    map_pgoff to start/end address for dso not found message.
  - Added "Reviewed-by" trailer for patches 1-3 previously reviewed
    by Leo Yan in V4 and V5.

Changes in V5:
  - In symbol-elf.c, branch to exit_close label if open file.
  - In trace_event_python.c, correct indentation. set_sym_in_dict
    call parameter "map_pgoff" renamed as "addr_map_pgoff" to
    match local naming.

Changes in V4:
  - In trace-event-python.c, fixed perf-tools-next merge problem.

Changes in V3:
  - Rebased to linux-perf-tools branch.
  - Squash symbol-elf.c and symbol.h into same commit.
  - In map.c, merge dso__is_pie() call into existing if statement.
  - In arm-cs-trace-disasm.py, remove debug artifacts.

Changes in V2:
  - In dso__is_pie() (symbol-elf.c), Decrease indentation, add null pointer
    checks per Leo Yan review.
  - Updated mailing list distribution.

Steve Clevenger (4):
  Add dso__is_pie call to identify ELF PIE
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     | 14 +++--
 tools/perf/util/map.c                         |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 83 insertions(+), 10 deletions(-)

-- 
2.44.0

