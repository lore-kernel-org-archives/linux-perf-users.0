Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3F78C80;
	Tue,  7 May 2024 06:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064680; cv=fail; b=DS5cZ8fRKBVJO2L8sOD5itrFNrwjJKaDbfEynqyyfl87kH9dp0smnk7N/vGYancEqt+GNjma+iZGEqUU5tn3Ym4x9oE1AdbI+h76WXXY0I1IQaPpjlz1b8/TgBeeLFZDRqVq49eIcY0xkV8pbzadeBLNpWvnlBEb3pdmT7lH35I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064680; c=relaxed/simple;
	bh=1Dp0rj2DrTlLgwwVQwKLTLlnGy9rldBAuqR4G563msA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=URdJ1MPtHAqWbHGYU0UNjmmb5zwJPQ01SkgbdzjN28Z3Imv1IilQpTwNMMSk4JLeLGU3H/dFRr+BjSHLLfe4QYEpMRNiEasQtReahycXdAPfMR0VHIQCr6/D7GCMEgOqrjEzQDNEsXhHWMZ99PCyKhs7fDMl2PqvJ7lWCN4llGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=jQ3XW17S; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="jQ3XW17S"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446MrNaj017227;
	Tue, 7 May 2024 06:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=FglXVag+D07sMukdmz
	IeUeteF4/gtq3w2rdSmQmDIU8=; b=jQ3XW17S+rWe3k5unBFnv+GRhn8SS6aoHZ
	vuhgnP0a3LZMwYQCEyiAgvtJ6KUa1OBPsXW3c3B+fSCpZMt3eB/A4T7XT7kjUHiJ
	EThevmbi+rxJyRbTRZ53eH21NnC4jUMKFYGL+KE6DIjDZW5LW1hOah9dnluR0Aln
	+tHqcuh8sLoDRTeut4ySqpBgzDU1UieS4aj4RUv5A45gusFWIKe3ndOugs3cwY8K
	RBZrrdYjuffK3xwR1syWpJKHVAlLNqMmoitAylt416ylzRVcco+z9erDmILkhz1A
	6OW49Qf0rOzlXxV/V4Gzqc+tQ5Buv4v0ZWsWv5r3YfTleURXHLQw==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xwc052h1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 06:50:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzaTMafchkoqiomNQogj7JCYBL4GPaD2Qyh3xGaOQrpjpxbMsrzTBmsU2L1GydO6SgVptrSv+14VC590bh9yDQ+5oNXxvtExs3+e42SL2KqwkzddqYlfY72xlPY807wSDpk6U4VYCBcqnQW9EukP3cq0iWfIuehF5EK5z8oB1UpSjEZ5de85otQkjNbP9rd1VdH7BTakF2xI69LdCnF5bRL7jM2SSbVXf3F18xMTIpBqkuAlP33kCfCkhCCjFqMKTdE+VkWGS6NxSwhq4BpaOSAHBAI3Us6ApIRW7cim/Qfz2h3IVNIPm6+CZU+NM59Wg9/vtoIO/0sdhbwCyDYBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FglXVag+D07sMukdmzIeUeteF4/gtq3w2rdSmQmDIU8=;
 b=jNxCOCM97t6OC71sy8pNcogsk0twsHDzBdo050XopzlFZO6prgU63y71ntDf2VyzjkgLlKVBSnxAMkhX5HajhDlmpefW73vk0SZzU++voMuZIUAOGg3Y8SgYNxB+dRvZl3G9znfQhbVHFDn6Sp7Yk9PgCfTVYJzQEWuSKmwT/FqW2zoIAD5IeJd3bRyJUJHOy0dz77tWMLCtJF68majhwS8qpQ3hKJqQnIjf1dRXWBJPVYNeYOzVOEyrW2YNz88vtiPcADL+80n7e7QjqrTFenQgD5jRLxPsyujxXwoR+rDLGgnkBt/Le/F3D7TL0bOBeK+6xuxQs57hqbcZtAMJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Tue, 7 May 2024 06:50:50 +0000
Received: from SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::9135:7397:16e6:258c]) by SA3PR11MB7527.namprd11.prod.outlook.com
 ([fe80::9135:7397:16e6:258c%3]) with mapi id 15.20.7544.036; Tue, 7 May 2024
 06:50:49 +0000
From: He Zhe <zhe.he@windriver.com>
To: namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com
Cc: zhe.he@windriver.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench: Fix trap divide error of perf bench internals inject-build-id
Date: Tue,  7 May 2024 14:50:26 +0800
Message-Id: <20240507065026.2652929-1-zhe.he@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To SA3PR11MB7527.namprd11.prod.outlook.com
 (2603:10b6:806:314::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7527:EE_|DM4PR11MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bac93f-ed66-4e3e-a275-08dc6e620737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nuBVVulkUsmSlbwSawQ/ao9FLVFkigFWbMeYrY9k7iSZHQIZJ/PR4h1SZ1XH?=
 =?us-ascii?Q?ZUCPgwxWXDNXuSR2G+U8DgVvjT1/2Vsyk2KtVOqDpG8IERs1BIbq/Y0+OYJs?=
 =?us-ascii?Q?T2D+fJRcBr6zfF4B1a6SXF2dPj8pydqApkct4doAIj71XPgSAXsTA2f8/d0n?=
 =?us-ascii?Q?DrwILAzw8jtEFA2TLJ4z+fE7kYAT/9uNbmfpXRsbyrAE4BSzqOyyA9vqwbNG?=
 =?us-ascii?Q?7ENcBSM1JcJQXa14tYsDM4ByqVTmmPsIfjrhBpJELbfde7flHNpE5QEV70eo?=
 =?us-ascii?Q?C4Q5+CCh/hxu0UCClSy2FwFZrzaFtMFJNWIMQyEncd7kIYBxb1+TQIxB+4vg?=
 =?us-ascii?Q?YbztiwGbcmxgHIWR9sg+Qyl7/fGrR2e0uFnXnWJ3SzciryQXunMS+qVtnA61?=
 =?us-ascii?Q?50do3U8MBvtsY0Tto3GRrp1qicVK5S1G7V5ZCAkzax0lUDYV6rdyt01RE+nj?=
 =?us-ascii?Q?jYtCFVcmWpqZBReJPfJfUkGTfChjLouFYB/1VS6MCOCxrPrmS77sjnzWN+A/?=
 =?us-ascii?Q?+oKRaBd9IUu35+cKvZzs0R9wIeKBtZ5UA67zkULH7thO5bBfdJVjO4EPwkSk?=
 =?us-ascii?Q?/fY3C3OoxLLHtXDkCpYgWmY+J6yYw0VjmgHItE/pH+pWmkVo51rF+B64S/yO?=
 =?us-ascii?Q?kDtI1PZkJiNPdAZcF0R/UnGuAOq5GWtUIjoBCkyxGSF5zjyK775SfkFW6GFM?=
 =?us-ascii?Q?xshJHxjyVUmJNrOXu8+UNLkEZiY7jv8WQiCqamQm06mdSSakEb1N/mgAWMLQ?=
 =?us-ascii?Q?fZj71O6hP4qnBrNjeU4N7yfBCICIHjd+GtKj//LRxfeK0zKw9wPDm0HwS/9/?=
 =?us-ascii?Q?wIBQFvhw0JlSaVfz2RJW/75FmQNHmvAKpbza84f2UdxL/SUpbVeo6yR37ghI?=
 =?us-ascii?Q?B+xYrE4I9C0dtTru4NV4CwrVWiJ7f+l2ZOvAs54TL9k+3DQTL9b3PRHZsiEF?=
 =?us-ascii?Q?l8Qhnciqun6aMm2BH5gUY5zYzkL4U6ipDkIRDqNr0UN84LeP7w66TX+TYc/3?=
 =?us-ascii?Q?SqBARiF805uwFFBbruqJXcFqNCVhbOBlEeqysi/yZlQNOjPUNa/495/Mr4Mg?=
 =?us-ascii?Q?63QHEdl6t9KjqKSfsmWgjA+sZBby2QEB/WqVvZr+xn6TDXXswDffbNHyyl12?=
 =?us-ascii?Q?I3VFm0AYa4PMYrRLr8c0s5XBqjIwwD49daKTp1e6QX2rqrFl31sVSf0lzSGY?=
 =?us-ascii?Q?5wzDCyPRXZWT/ibpIDBGtzHYrH680Elb1VZSiIoKSIjmaFVheZZFyG3xz0SB?=
 =?us-ascii?Q?eWlrMVa3qJS8nixEy7rsb260wDVf2a/0VD/v+LI0YbuwVLCJXBaaU0ZhISg2?=
 =?us-ascii?Q?v8EEdwBVDiVsT4lQPk6z79NeGqd2LrUO/lq7imEkcgZmAQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SY0GFv9QyjVFykE8k8r6Da7VhCcuwV2d7wJGKYiPgEzdtKipTHoJElqhKwER?=
 =?us-ascii?Q?p1nS5q4pxKn1YPrG8wLcN0SPqBJ9LtrojQLGy/jDYAUlQxUvNGvVbKT8nQP/?=
 =?us-ascii?Q?RAro9237Y2jAjE/oct+OKy7E6PgM81s70pfNqpBGrk2gTo8dhhAX4KFvYVwX?=
 =?us-ascii?Q?FuJ4nXtrXLKurUDV/iqGlhXX1eP1qg0S9vXw6PPnC6USa2aE92/bFB0lZDOR?=
 =?us-ascii?Q?D1ck7cJiKVrRarWzWg3jCgmmq8C3AK+20wc3bWQb61g2itTsk03aB/rItcnx?=
 =?us-ascii?Q?H37coh+u7z3tq0dUVX8gQVysRtOErNQfjLXlxCOoEfJubOuoHUiRf1Bs/i83?=
 =?us-ascii?Q?Pq5qDvZfc5hGyh5NjNZQwIWHV+9ttyEFsTofSe2qXMDHVuELpBxdrJ2/tDXi?=
 =?us-ascii?Q?XSkIdFUdexeGmyJ5BOPR7ytGz5EE/d5e3tLg/S6emup8SlMj9SGYDuonLktX?=
 =?us-ascii?Q?lVmpOJM1EOD7wk0soz2fxuzjf8LWHE36/j4tjUJ4lf7JZhnIP0SqeC868bif?=
 =?us-ascii?Q?q/ERhllAW0MrtkIz7WiwUn+mgdwCZZiA0+gNlKg3C/8bJB7HmtC2mcMIrAV8?=
 =?us-ascii?Q?ZRgwNEEqgAVbxOsGXsc7YfRtV+lHsJzITp8kLNhpwUhfeNF02hWDbzmhCoo6?=
 =?us-ascii?Q?kKi1BIjS3Gou+OZnGhWZsOlmN5DhUUcFTQzUeTeGKXo7LtFCG7XhCtr+PT8g?=
 =?us-ascii?Q?L2Saq8kPQkRdsNMpsj/E0MvwLp9PPP4QiVgvEHS5cU2+WiI5zRUyUJsThN55?=
 =?us-ascii?Q?SBEPF/e0XM6Wr1A98D+4OYgE1bdIzPU21VBhyyySK7aup2ClrU2PejBpjZT4?=
 =?us-ascii?Q?Rii1FNVAdejfqRrq7MajP4XjkmLVKvGPWmwHk9ksIzYYXTiX1F9ESrXnVAcg?=
 =?us-ascii?Q?uMjujmOBmeSd5Ggrl0FBMZ+A067xU/avV4fMiIIQhSRxecGeicqr8VzOfgBB?=
 =?us-ascii?Q?+ZyzaCYa2aRDrTKIHSoldkugUmVjWUm7rKTSBUF30jwAikf9koRIUF1eEtrU?=
 =?us-ascii?Q?/AZ1Mvc+qTGbb4vSSc6YenUJ9500xr+UR30ZsZhfXInEvEGoA/MGIlhUgyUP?=
 =?us-ascii?Q?QLW1lJVD2dtbBPblzPYA50RJl4QBxlzBLwJbtL0ICJ07TLosq0qBHo8H57Jz?=
 =?us-ascii?Q?QWWWvBKZoMOcq7hd/OTQKBsrMsJEtRAvibfVZKYIr7xulZvgBKfKx4pNAmPI?=
 =?us-ascii?Q?GMz+t0AguuXS/WD9F+Cr/br+qCl+k58SOr33U+yVntaXybJ21C5amhn7ldA6?=
 =?us-ascii?Q?oGfY2aY1HxGjBuBBD5oRPfWyeZtG4uuTBlBW4KSyqLMU95+7fa00Hj9fschL?=
 =?us-ascii?Q?R5zBYHiiB9q5hru5NVix2PhXynuAkP8ZLvrEff9TK7ToTIBreFEGCiacG4oh?=
 =?us-ascii?Q?s2zs06O2t/MpXz+FVupayI09vO465dz2tklADCK7CVleda2q2wJf2B+eZVUU?=
 =?us-ascii?Q?FIGMupC7h9LzxpgpO4Z3Hk/39QvF76lBmpnEsa+15I4Y6PF+89U3rQ6wy9oc?=
 =?us-ascii?Q?tPAOfZk+Val+vNB8qGPBOVXHVhZZCfC50nQuTQZ6k9alRaiJ5kuKmlqMMqxs?=
 =?us-ascii?Q?mDOIqQC20MJfunEhU96Ua1ZcD54RPSGfsWLZGuoO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bac93f-ed66-4e3e-a275-08dc6e620737
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:50:49.0415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1RgLr+tG+qPVwYVC+0+sAXKn/WU9fXD5cwOV4lGWm1cOaC613SYrxiG040BGWW3UqAckV02Vx8C8VbAUmjDdxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
X-Proofpoint-ORIG-GUID: yXRIa_82cqGIDP4xKt32oqVefADkagrJ
X-Proofpoint-GUID: yXRIa_82cqGIDP4xKt32oqVefADkagrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405070046

perf bench internals inject-build-id suffers from the following error when
only one DSO is collected.

perf bench internals inject-build-id -v
  Collected 1 DSOs
traps: internals-injec[2305] trap divide error
ip:557566ba6394 sp:7ffd4de97fe0 error:0 in perf[557566b2a000+23d000]
  Build-id injection benchmark
  Iteration #1
Floating point exception

This patch removes the unnecessary minus one from the divisor which also
corrects the randomization range.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/bench/inject-buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 49331743c743..a759eb2328be 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -362,7 +362,7 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 		return -1;
 
 	for (i = 0; i < nr_mmaps; i++) {
-		int idx = rand() % (nr_dsos - 1);
+		int idx = rand() % nr_dsos;
 		struct bench_dso *dso = &dsos[idx];
 		u64 timestamp = rand() % 1000000;
 
-- 
2.25.1

