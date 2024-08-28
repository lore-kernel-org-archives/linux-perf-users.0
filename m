Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422141AC8AC
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887106; cv=fail; b=j6O4qdOE6Uqsic0VQ2r3aXmDQzaX+TqgdtapzjwFA2CAV6zzyWDuY5RVQySoruOOUCcwaak5PNJLB+ZxsxrkiZM6KnYYsPPfFRH8ifQc1SOzKZhW+7OdD0o0bE8ECArYufw/Q3WOqkou9OaHRvwKvvxCyziiIcXZIQGtqFEzMPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887106; c=relaxed/simple;
	bh=k+UDaANLGypx62Y4UeeBspz2KqtIYoAQWvdXR3sMsNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAVBS4vC2HBUVXlKRgrpK3brJUwKFULDhy9xDYHtyNgQZ13yONpfuvo6Vw+lNkDMxgVgoxc/bAA16ooiq0lYlM65w3813SbgQWxpyGwYKCeVsUuZxaQpVUlGmM0KMcNW0469i4wQOZalajs15qQfj2GswyYsxcMBPlMvqI4SGiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AET66BKP; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AET66BKP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIoV5HVqWYeRkMlXDVhfcU6rFZrhvE9xjH5SdKIgWQegpwpMbyE8IR6GeGACQis49erEt/hMcAxAhcBRJSabsJxwtBBAyBng8zil6YURon6P+GPszGD8w6tSO4FkA+zq1nM5XAoxsAZWE+uWm5iC84taVE+mhtlEUiabVSOHroMRjG2zDAyXKgP823aSb36mzksqKEDMfrftk8XGaFJD4Pttv3FXn/yaJwFvftBDxzFQi5BWY2s1I/wYVGJ5cCBbEt25upWCrbxMXUsBti7TnX1C5u38eTHHQ5lGWjCf8IyFTPbSf7ZL/4pIj/86ZnMBDjIyVEexuhJLEpXbqCyrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4kXjmyo86JTD/IQw/bB0THRSQfH7h/hHx5M3CvHMM4=;
 b=CuGrHHxyKtPrkXQjHa1yLnRrUEUWXL+1qAB8h5aDSOqLF88ayxTKMByDVpAADIthJezMST2N8o6eR4/WFsWm2QBZPnYH3ORRi7owrY/Ee+RiaUC8o47/UYQGPrlkiJdif0b0J0i4cKx4BVRbB1IbfPF5qPG+4/UP6ZxaIjz0GUMOLvRVwQDAtz8RdKN0alrR3EJg41XZqOBhTWfVqS1J3oxFXcWEYywmtEonATJ+C5sZP86c/1HfnIY5sIwaDQyfxv0q1R6oXOR4pr8Upuuzj9+lN3XmPMyOdQHCeBx8P+DElJuDLLqnbZmUp8xDRJ0Pn29E76MmA1xRNBwmrgJQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4kXjmyo86JTD/IQw/bB0THRSQfH7h/hHx5M3CvHMM4=;
 b=AET66BKPzi7yKBM0Og1UcnS+UAxD3ChIc4A/3/j+x5RYWuyYL+jg8f77keKNHLdGLooIOjx05iU0O9pglhoA4xUJQaFFBkntjb/GuYQVCPZ1j693609EgAYKH/hJ1fq22gO0Z7kAetETVpzImDsk9FMzz+tXPDbcp1DnwU5jNE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB7895.prod.exchangelabs.com (2603:10b6:510:28a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Wed, 28 Aug 2024 23:18:20 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:18:19 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: leo.yan@arm.com,
	james.clark@linaro.org,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 0/4] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Wed, 28 Aug 2024 17:17:59 -0600
Message-Id: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: a19caa1f-e3a4-4128-87c2-08dcc7b7b44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2l9z9nVNsiOJf1uFdzXyiFfWuBbE8IlfHRq0o70siiNjjFkfQJ32njxRpcnu?=
 =?us-ascii?Q?CcYa9JMtIyJzqpAxsfoPLWBLTwovKSrmY2ip1TWASQw98VjS3bu/1xtopLBt?=
 =?us-ascii?Q?9nlQVHL8o64ryTmvteGLDN5Q3Apl+kXHZyOsNjTb1CnM3Z7lnZW/OPO4uIp+?=
 =?us-ascii?Q?PHSUJ7BV5pPH129lVMdwT8RWMedp1HHsnwdDM0EKNhi8J32wTf26apPybYUi?=
 =?us-ascii?Q?nrvfYT6oWlo5WkHsj0k7bIcf5ZFwVeZl6ZRQN+9kn2pc42oqEoLXZ5AgB71C?=
 =?us-ascii?Q?1ffIMFMnX+mWqBlJE8lhn5fNfZBqbsObrh2fi1UofSZw9TZfvTlIXkaXlIP/?=
 =?us-ascii?Q?emzeCL+yGOVeCgzNz1O6Fh+HZsu8TWMEH/pGFS36wk6Rtc6ogwdh1BmpALlM?=
 =?us-ascii?Q?2lcn9VQMbkN639OkTVFyYA/3H/Ji8Tvl0y7a8U2L5ZQYRb8wlHFIyo3OryPD?=
 =?us-ascii?Q?Agb2qb2EbtewJ8f1iBOeU+550JgVRrx/HzbqL28s+ZrnN1AqiTc1ClA/tAc+?=
 =?us-ascii?Q?To3nzlylx47US2hqJPC8T4EvAXrZUQpf5ONqv/Ht8Sjf1nQscQXk+BP9/aW1?=
 =?us-ascii?Q?DU5njQwe+bwR4xXeCZssH4rd9onOIRU2sKxLEn8dy3o9Nc8K7cG75RsoihHw?=
 =?us-ascii?Q?2mMwq7H9FW95KmVfeGNrNY9AmZiskRPh3VjaNAblPZgSC8QzsW2rGzOKjfqT?=
 =?us-ascii?Q?nR0X0D/0JVJvM90qdUqlCKCMAyD9VzmDtlpJL6goW9Ca3BG3ox2X67g+aBue?=
 =?us-ascii?Q?UYnIhWn1NOBpoSxCkvREnl8nUhg+8RYnp5Y0EVy7jSy/EQrRFqV7dXsGXFCq?=
 =?us-ascii?Q?q9dIVzSKhJraeNfcfy1GmlnH/juf2pW0vL00ZJcACeLLNM8s92p9sf9M9d41?=
 =?us-ascii?Q?Euq0HqMExO7u9ChxXi1RbDqOlGcG6o6wYPczBrWPA4r4H1vHB5PVGak3mQ5Q?=
 =?us-ascii?Q?rJo7bPqf+h7SrryRGW6dWJJWuT9yvMX/wx91yR4Ts5QyP2uUOs8iGlP7dYof?=
 =?us-ascii?Q?gBqLr7OhAoneVsxcN6HE/dXpzdcoGhf/VVazEozo4jvBt812026P2BpuT9YA?=
 =?us-ascii?Q?fxgdP9uY1Nv6M6+oqeWyCZanczuppd0vVWW6TzejooTffzlfbbcUUoFhk2D7?=
 =?us-ascii?Q?HIWxIELTPqH9kwlMOh2ytvz3/UF1wgE2GjluDiCkK/BU8pa9KEF7iuGj0l8y?=
 =?us-ascii?Q?JrTFYOumjmj338MGUh7t5LCZ2N9jps0v+5Px8nwpaIxGfpIHJ/d3xSj7Xk/x?=
 =?us-ascii?Q?5MvcSuTouReNhNXD+l8X37YVB1j/0llHuCZz9TzJX0dbK4nXhk6Oc+/i7vXb?=
 =?us-ascii?Q?gzmf2qM6j/Bvl+CHkxRhm/lmzpmLTMdKOZeLXsf4i3S3BfBeImsJg1HtA2Ia?=
 =?us-ascii?Q?v6GSU3g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQvORNO/Rm9TDkvs4X0wq6OTEvlJSCwRJ/lUpVczazOPZGm7IKATHRkueSy0?=
 =?us-ascii?Q?CiiavEbK4aPZRlc5heaQLY+PS01JpcXbUUO9XA8g9OBy/b1W3lgkGiFPL5GE?=
 =?us-ascii?Q?3g1WGdPY99IFMRcobV9jsbhvm5f+mEnfvG0eULqfRs+0LtcmI/SYs2M2VlXy?=
 =?us-ascii?Q?4VpcmYQ4xSP2RwYvSX3RQ9OTQKtCwoxgB+CD9pMrkegA6umhiVvP48fS/cKK?=
 =?us-ascii?Q?IjE9hmzZk721EYNT/g/SmkqtyL4dK7poi4HN4SXAYcfXvtJ2zv6hbvIm1P/C?=
 =?us-ascii?Q?ioRk0RgDDIgrYuJ3nr6+/Ya05f17NEQz8IKjyb8Rl9G/na4P8dteK9TlwGKB?=
 =?us-ascii?Q?7pGVb6z0Lg3AEGGnDrlJgpQCRI1MybsnAZAGozEl5hn++lsmex8CqHR0aYwF?=
 =?us-ascii?Q?zT7TecjZssWANOARCEL3QPO5lsDe81IfmD95CUQ1DllMxPhIGqvBMKWQy9W6?=
 =?us-ascii?Q?P2VCCJYValM6McD2ZgvkU49+XWG2qo6FhrIPohSkIml9ZxHrLKX3TE49zM3u?=
 =?us-ascii?Q?l6c8q7a5I5pb8fc/mJdcq2OPk7oLpjqbv6h0M/PVkvIYhECwDYSL2MCg+i12?=
 =?us-ascii?Q?yhQCVqguN5SfE0rm4PyrR3UAuE/Y+Jl+Yu4ofAwhEYkuGM+QlGMjU+KxcTHD?=
 =?us-ascii?Q?XzsFtaPEYEDs6XRHPdM2n4Ytcq33HYDs3YxpyX51IszsEgM0t3//sx2rzWCT?=
 =?us-ascii?Q?0NoeVeasRxU72PDuPTqeDIkSrUaQbUnGHCFBTnSUL3y0Bii6UCoLfmgo6H1U?=
 =?us-ascii?Q?z4ffDUrq6c5L5ZFK+HS93GWuxK9QGO1A5CICy3rlvZfcszYHueCFHNNu9a6X?=
 =?us-ascii?Q?vpLMk1+pJTqnmUWG8eZQ6aiEwaK/4n2b0e68qIdmkldv/W2iRDkrGeAJCzkB?=
 =?us-ascii?Q?jQu7Ll7XcbSbhK3Ct2KypL7MTFk2SOM5iYNLPp6YvJMlj7vFylDSMTFCt2bo?=
 =?us-ascii?Q?qFe22j0ZF8DHbpxHmhN7ZmjA9nxMjgVq75CKdF8zjVFF9h52dBT/2ytkwLZt?=
 =?us-ascii?Q?IZ64l3vKXqY8lcrzTIGgHFOE/Z/vyKCRYBAxbfBo4vHg8EnoeK4rrH4o2uIr?=
 =?us-ascii?Q?sA777es9W1bCNlUI5vwRmtRd/qjrME/w8ZtShLDv8kEYHM16h8Ksw53yMKHU?=
 =?us-ascii?Q?qVrePmLz9fFeVlENHQNbqc8JHAe/DypAwTYoEuWNg/mwqX1te7TM3zmhnH6m?=
 =?us-ascii?Q?OAG5KQX3fAypyiPyeb/jmzlF2p0Jl0FnZW5Jxr5fTN2BTXEdIsRsy/RTCZSp?=
 =?us-ascii?Q?WF+w/+lvLOcZlbfuCvZQqIqZCQiZoKSvAF9Dx0EzxW8l/35PvJJAk69bqVdq?=
 =?us-ascii?Q?JrcdppPHqURwhp+qQQTHZGl7e3wL1LEHU+5hTMKyXaU97hYMbf+5ObpR06wF?=
 =?us-ascii?Q?9pMVeXaIm2998kg7C6PUjWWEH7rj9LGUdDKF3+Bdbtxc3m2A6xJg7Z9JClft?=
 =?us-ascii?Q?XavP9/OaW4Gesxq/YxFaSSO2d0snpkj9iHFbcNqKskLf8/zjItUctOvAhDl7?=
 =?us-ascii?Q?+Av+3yfzrtBr9Mdyi8Kghe2uEjbL69hkgsugT6/uDDuiGfF5PDE5i24Fd5fN?=
 =?us-ascii?Q?WpaziTZnuYD7EXZBOglLqd1ldXDUr/BAydlUuygeNVLr2luZRrTm+znYGLn1?=
 =?us-ascii?Q?orVmB9ElfhUjhd2pvYj+h5WUrnqQ01fUemXwLHT2JoGS?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19caa1f-e3a4-4128-87c2-08dcc7b7b44e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 23:18:19.9469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQ8Vbdie0VVYvj/9CiE1kEoCl0XHKe2DeYtWerqX+xF9pMwG9jkuX4hiCcDYJkEoM7DcWQJGHwKNQY8w4gti5NgFRhWdUiwOWNrxSNn/yZhlyGUXryg7KwHRYkk9vIbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7895

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
  - Updated mailing list distribution

Steve Clevenger (4):
  Add dso__is_pie call to identify ELF PIE
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     |  9 ++-
 tools/perf/util/map.c                         |  4 +-
 .../scripting-engines/trace-event-python.c    | 13 +++-
 tools/perf/util/symbol-elf.c                  | 61 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 80 insertions(+), 8 deletions(-)

-- 
2.25.1

