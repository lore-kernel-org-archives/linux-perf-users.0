Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCA2D839F;
	Wed, 10 Sep 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533956; cv=fail; b=OO8/6lTZdqH69HDGxqdvnXsvVirdDSiwnutAzy+QBTLkpsOjpenb8YsvKFtn2iRF64btJ+SpeddVV3GC5kjE66iJoxl6oRKtpM/iiycN+IzcubrXq2ZDN70eUMsDdLV5fH1mCVDxj8E91b+UJAC7Fnyk9kKeWGvce8J38KNvCUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533956; c=relaxed/simple;
	bh=K8PSo8ktRXbhlnlOkYM9JoWxilC6oE6CxzxUWKIvyNA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rd0q0awhbSYkda8/hWR3Wrwe/jZkrO9S2zcj553B1SjUmHxSCznU36tpUH0XNhktIHp8A5+DaN9qX2l0J551WBssqr3flWARL4xOeNkNCa5EKqHPkhDfaK3cM1ee3+40KX2p54iiyi+vetbrV+Ph1GRtMmU1kiKB8rHA0jB5zoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pu99nH11; arc=fail smtp.client-ip=40.107.93.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pu99nH11"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTt7LS8hiArVOQFuqeYv9Sez+JitcZ/wNZrR9W0Uywa96NaINefpMNx4ZzslfzgHmaMTY7J/+GO3z+gz/8/Ynf74BkIyeOaQ6chLLFkff+s1me/cc1lPbzBhdDF6cn2kSE9AzQBkG7maXtv2L7Z1cHmH/lFSwBaIriU2UMczuiFd9fhxLhTrIyLCn5ODvEhJnXKOVIfN+qDYi9LKf46XQCmcf9ol3uWhZPTacNSRYc32El5BRXap9mGlMrXb2nilRxRNSTLjylmphU4vfjPJTrB84OGjcPhqqksBfq5j83y2Iw6UyJ+ABSwW7OWn67SRTW56dPi9qolVnqLxn/C3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Iu05JwPayxEH8ZsL26cv6WkSDYtrYNbTjT0fPhxar4=;
 b=AFFtLMjCX9pTME2BrojUEV63YszTf5hfDThi2TW9njcdPbhVNNoowY63Clf+zydRPPLcYjHXWJAzjHu/pvQYqrKLpZL1gpTIMsVo8Kbs7NMtPQ11fHojG2ss2zE8gt34igm13sEtmEGNmdW0Gd02WZBBtEgHgD+k2K1nw/pYKXKg1DxCzoEv9797wRV0bzDGJIxziRYsOuEJvn88venN4ysiEe7Z6QnAu1XqHHR/aNrbDKvKVvqO/+zYZFiJcJoBWeQl4BFhtUWh/9H2+kVXrV8O8UEYo0rHFRyMPXodqzBRXw/fZ4uJNHTJzWrf03J9fH1jnacMaiSlHerBRMrmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Iu05JwPayxEH8ZsL26cv6WkSDYtrYNbTjT0fPhxar4=;
 b=pu99nH116+53pJJO4tYJzwmE6PbVqugCsoXor5XhBUZdEY+8XL4qcu4fJ7p1EwkGRyd+fpwGoo1DjXDCpY+FdfgN6Nf2Pa+XllDKhnGp7z9BWUpfGSp2Ch7l6XlMI9MvqBeEe8CpNJNK3LnELNfB5Tr9O7pMRkN5872Sat8OiEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 IA0PR01MB8379.prod.exchangelabs.com (2603:10b6:208:485::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 19:52:31 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 19:52:31 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf vendor events arm64 AmpereOneX/AmpereOne: Fix typo in  l1d_cache_access_prefetches and a few typos in metrics descriptions
Date: Wed, 10 Sep 2025 12:52:11 -0700
Message-ID: <20250910195214.50814-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:930:3::8) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|IA0PR01MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0a5260-c35c-42e9-8a70-08ddf0a3940e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ViU+3Od6aqNsrkWNU6IHHoIs7SXoNWuWuTfd50QGP7bNSuUcMXNVplX3+FxN?=
 =?us-ascii?Q?FP5PPiz+0fzhgnPBEY5krSWoFx4lhODJLVOTspgaHBeDtl5Xcc8xRp1Usvf6?=
 =?us-ascii?Q?zjFTs7AnI+On/NwM0d/Y0g6CiQ5IdnwdnHqnxES4Fb9ArtDCnmwhmEt2II/E?=
 =?us-ascii?Q?G2D9s4foenjV6lwjMcTxgznT3+IZThKWVnAUf5HwxJuwS4RV3fASF+JTVFHa?=
 =?us-ascii?Q?a7Ia7lgqCDATHuyfVwOFSe6Z9yEtDXs6Kh2hswxqFqnP8ULECJXbIwmhG5J1?=
 =?us-ascii?Q?vxJuIVEh12PRx4qdrdbNGA4nyeWN/Cf+mOF4v4ydADImKqoH2BDjsVD6CVls?=
 =?us-ascii?Q?8znxnLmnu8ibAfRT2D4WRChOtWCGxmfJu5lOAMtfUTQ/I4wPElOnZwG31XmW?=
 =?us-ascii?Q?rpsACAhqHYyxX6bQhnxumMJw36jr0Pwe//8w8BSUVYzBgXLHUTVzd+p+bKrN?=
 =?us-ascii?Q?6X8hQZ2tAE2JZwafKf123SMKOEMUWc0EPH+X9lAEIlb3IHdSru0ZdE+yer0S?=
 =?us-ascii?Q?2gMFb13nnwkDFbgVHTTEoSB/izj/CJB7xzgprPFCZlmfN4b0H/DydCB+VAZo?=
 =?us-ascii?Q?fSJOhCS1RBJXX7KvrkWBG3AyZNd3tv79CrYsdiPczyfvcDg2aOkvcxvzVFx5?=
 =?us-ascii?Q?3Wumqt+HEo/kC6aQvm/9D60q2O8F1h+hgy0LOf8xdk/4CqXqVDkwVq82Dles?=
 =?us-ascii?Q?dgXCZaWooDt30oWcyAFqJulDFgCfsK/JmohbUcF/IyhZ8ISzC6Eqz8WTuRWg?=
 =?us-ascii?Q?f2igYHzoZVfX09nNo2uyS+IKiEzrhEpPo+u4qVjhRLjpgeJrahqtp7KB6uP8?=
 =?us-ascii?Q?enmGr1MM00iq1KZWfRgnfh/FQJDc2K/M+2hWcX45Ny3iXzsns86Z+vNuyGom?=
 =?us-ascii?Q?gVdUa3HAQ/FP6cTEzHzTRShdzuU4Tk5q+htY1jy9SGSSouFoMR7ChEYSOQVb?=
 =?us-ascii?Q?2kKR95qRrTcfCq62l8Rx+1EX/+/xyIja+SGe9Yiirbb8WX8iYwO1T8zhhwN9?=
 =?us-ascii?Q?bWANt9UWhlv8sO/S2PrFowuauN5yZEPBEZYXN6tkhodJAI2aLqVEMAisoYSl?=
 =?us-ascii?Q?EpBlKOilzfPLl1M2efQYwWbAV5z6OW8TcfzQtwpLNJ8UiJef8z+LYRz/tZF+?=
 =?us-ascii?Q?JxTWjRbUcpNVf0SPmhibH9Z03z7Hoa0rCmLaDP12KGQTtyms7oxHzaURZlUG?=
 =?us-ascii?Q?9X+F+CPZzExiPJzN/6/eQOFs/AtW945MO8Ig3qVd5tvug/mPbnUQbh3R19Ye?=
 =?us-ascii?Q?vhyeH0+rxSV62NxcWZKyfha/x9Akde8S+t00s4XVIjPzFx+nyv2IiCCCcvQo?=
 =?us-ascii?Q?rCEQSc2rgWIDMqpLVkus7WPxiHfnHnUiaGE7TCHwjZS0rlBrAh1MIAJuVWki?=
 =?us-ascii?Q?tLTAQGcTt6aTFFJ2SEA31dmmZXroebiLa73Ky2+Z66whcppzPI7l9m/ZskL9?=
 =?us-ascii?Q?GqtRxqJYu8OG9SrMHd/tuJggybanb6UAwe1XuG6usL6myIeuLxSmr2yEPuxZ?=
 =?us-ascii?Q?aQ6Nunl66WQaB0ZRSFuQ4XiH0iM8toacY0Xq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmcb5dEp43IXmWvYcP8nidVpWROCvCrMvMHAVLZVGEY7iS3qZNPt5O+c4302?=
 =?us-ascii?Q?hL6tPbpC/zVvPXcrkKa0psUmowiNxrqh7eoLTwFOYfpnzEUQSdhTnB3rXYEM?=
 =?us-ascii?Q?qhQqi98eCguP0IwV14xI0zUWE0rv5Jcz0lRNuo6BF3YOBokcucZWtfenqsO0?=
 =?us-ascii?Q?Sk6s4vALhgaohbt3njojm0/Y9pUmfqY2NK+KtCKf56IrI9p8XHSGAcoTOpQA?=
 =?us-ascii?Q?tZtl8/eRbmTQTojDNvN95Gc1Sk2k/xVfIUXsfJZg+wKb64UGW5L9azD0kpYp?=
 =?us-ascii?Q?hY5D2m662Q3LwKfprU0uRvGYJfGaE7CMdQqrbn1c2gf0saEn+o38XVMQDZeA?=
 =?us-ascii?Q?OGShxOsRVyyXKUks+5Udv8dSFvvqY1HJcSCto7rBChS5xZdELi4mQjZ3vu52?=
 =?us-ascii?Q?5QXHkSgPUGTHs9WU//xOTl2hvfqL53HWHeoGwQicjkrWIfLxCYFwJfTwFs4V?=
 =?us-ascii?Q?rTTn0+eZ5tMyekvimX0NV1/nR/2j4WBlFI+PvcP6C4aImgyv/AdJsY+zM4k9?=
 =?us-ascii?Q?Gx1TiKI7zDLW+Lee07TgPNdlqqcO24Z5NxJKn5QvdrzXrjxCHakdNojZdu+f?=
 =?us-ascii?Q?SwCbRFXJzgiTWd5kspPTPqEv+TqtJM10Y10Y3j4u/4+vnMgJA5qSh0LANlK/?=
 =?us-ascii?Q?WflBDIFI+/DCVkZFSFJbFRnDm7ofUVyhRt1IohVykiMbSIa4hxIzAW2EBO1o?=
 =?us-ascii?Q?eWC7kH+Lg6V2ucGgSXrqUHOKr9gcLSK8OoWjaFfYOrEMS6yjZl6WKAD/j3++?=
 =?us-ascii?Q?qL7iS7OUKu39D0h3Db7R3LKPlO7ow4TZjcwlc7rlq4HwOiIZMAR7Vbh7LcMk?=
 =?us-ascii?Q?E+7xFjSMqyKJgrCb8LYy9q69b5Ao3S/vpehMjA0lUPgb/8YZta9iPfuXjdyI?=
 =?us-ascii?Q?xJ5xJUYwa07mWSTLy504BB2UGfz14FwWAR5ck4sclN0yEyI0zZnZF5d/Sz4f?=
 =?us-ascii?Q?6fk35Q7mCvM4ZFoxYGN/PPncNrBrehbCtW6mTpl6G2OVZk1TuBdh0M/z6WO6?=
 =?us-ascii?Q?hlZ5vxx6gojXxWDEvLMlfstL+DUgv2b33GQaHWCOtVTW2FlTPvVeUjyxv+TJ?=
 =?us-ascii?Q?U1MJGqDYOspDNqgx2y4pzGnl62b7r5kYu3/NGuOq2j4Yb0sPJYLFam7Ig4RN?=
 =?us-ascii?Q?OBQkloW/AtQZoYQmD5uGclvdk6nZKMw6iSOlX+tWTDGthfKCF243aqJ0rt3a?=
 =?us-ascii?Q?njusdOmLjYJNWJVxfR8Zk35yCiXLC9zUE8qKktgeFsiS+ROxe8bBG1tDw8sp?=
 =?us-ascii?Q?DfCvUC6NYI8RUXdhtJDCXbyRiuuxJSyR70A1HeD+HGu8vo7FNoFAgzbfa5r2?=
 =?us-ascii?Q?6bTv/oH+7XzYFdR4H32IG3efJjUkDaiMS11yilsB33UCfIT0My2F6JGnce4E?=
 =?us-ascii?Q?ECsAKruVuWVbJblkhVpLFJ5xV/8g4VYD2aKNeBAJtvI9QUnZXie+GXmfJDPE?=
 =?us-ascii?Q?VApaH9H32YGcYDm8VgGsy/MiDq9etTk16ASwjwuKxo0ozL+qFn/CGZBDa/qd?=
 =?us-ascii?Q?kjPy85tZEZym68Mv+h+gbw7x148TcLdrogo05sKl0Kk0C6+g2GzSt7Jqg5Iy?=
 =?us-ascii?Q?cfzxmqoyj7u1yX2GHj2iiOYg1AlEVDtfKn63/Ux1aHSMN7c47KrHSutT05Ro?=
 =?us-ascii?Q?q7Cn8BbrmvpBRRYSuQXs9Ew=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0a5260-c35c-42e9-8a70-08ddf0a3940e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 19:52:31.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOrmuh9hQd8an+Y1SxZ8t+XZtJ0h9WgQXqlgdHTlgNMO1S2UDsk1HxdVTwkbbVyIzkuplC57OXf2Tr84x/hYJoEhGVTBO62KPHYZEhR/vb1UcOnGCQPnlY38EJFZY7kf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8379

* Fix a typo in AmpereOneX metrics name ("l1d_cache_access_prefetces")
* Fix a few typos in AmpereOneX and AmpereOne metrics

v2: Add a patch to fix AmpereOne typos

v1: https://lore.kernel.org/all/20250909210120.9823-1-ilkka@os.amperecomputing.com/

Ilkka Koskinen (2):
  perf vendor events arm64 AmpereOneX: Fix typo - should be
    l1d_cache_access_prefetches
  perf vendor events arm64 AmpereOne: Fix typos in metrics' descriptions

 .../arch/arm64/ampere/ampereone/metrics.json           |  8 ++++----
 .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.51.0

