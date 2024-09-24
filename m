Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020131.outbound.protection.outlook.com [52.101.193.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6295A188CD5;
	Tue, 24 Sep 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221197; cv=fail; b=KoRWccbPOxe6ILUBq1nttnqJ3SQxwx/UHzr8CfDFhzALmNn+VVLgL1HJe985FeKRLOjvgWnZuoKiPZdu09I6cJ5UFEduYcNXzvgkrWqdGk1qoN+fZYPDoSFVMb/1vO940sHeOEUnAI8buKiIFxV5AJyvA9X1liAWW0DBFad0Yj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221197; c=relaxed/simple;
	bh=gK6xCcnFrFSLxGfkgWUS0d5IzhXnWZ/J2ONJNBixIww=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NN90kVwrz0bQUzqNeO+bTnBcOOAnw+fgAveMcZ0s1scmYDT2LLIYHnOR6x5wJNbmdzx3xqYUIqArLzK1xWXEzlqo5cC0l9m2zcD5r8s8uzJlvKJIQbFUrRCA9RnGHBoLqesU5y2HQGaLR7eB3mnojfPiH7QPiTVSsV9YgZ/SeLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VwZI05cW; arc=fail smtp.client-ip=52.101.193.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VwZI05cW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXJXJ3VmlBPsbZkMH+wu9TVvwlfNlM0w3b1Xi0Q8DIf/nenx2iYkohXPztSmjvY5BHvgUyeYt5mLy9d1JpU8HXs7b7Mzgxo7dZ0CKdsL54KiPoz+FffsfUJnU3fojfRviY3dNjt+G/QYwU+2LLUlhIOTpZ3Ba858L2sP0mXfBzKuj6za/YfaD6LnCKazRscABuplkWw/1AKf5Xk2YuArrDq8iJkoNh0xh4v9LavntN1V7iX6q7O+Q6PVsX4Ha8UdCJpWIB3g9f4tC/5Aex6xLGu/Vv9hu4x5fNNoQrwpyw1VGML/cBxd22HvK2DN72UGA1PM2Ztv1OvHVl6zDCHjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYfHtq99ybCfWIaUuCw30Xkvjx0GsyzDqazqNcMg0Gs=;
 b=h+l5sPXU9WClsHHH3xhr5qUatCVAyXRMVvS9Q7+9xYW/jqbNW8s7igr4IEksC6JTfg+o7R5mpnPCThjy3bQ+7eHOOqsK/8UCC4tR3ytDGgJj4VPCAN1ITYElbatK0yXMJCOuxI77YAQIT5ZeVJ66+TIgIzjSwxr7/DNNRJZRWvrWYgdqYY7xAynLnP7Qn+bPONJxKVqDqUlfqTyulfoRJ+E8TDOlHbqH6s14z9Qh3AG9Ra/lhL+h4P6xJnMXtFbc+O6Bvv7YQg+wUUjsLRThncQHXnk5HFuAf56Dx2cBY2Sa9oE4FySTBMrc1KLLkfHpXxByF0x6C9fC/gBcBAfQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYfHtq99ybCfWIaUuCw30Xkvjx0GsyzDqazqNcMg0Gs=;
 b=VwZI05cWDIpEayCYCMuq51HR7UZyBHKKO2JMtmvsuhtxySeVXYey3MspBg5Kyo/0IgN4Bl+8UCD/b8a0WolHJGpviTSrs4hHlXmLxp4YFuC9z2D8mem6ABLBqKnEnJj8khLPAo5KZKHYal899jOzGS5DJVQSCdFczAVQO8eB1wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 BY1PR01MB8922.prod.exchangelabs.com (2603:10b6:a03:5b6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 24 Sep 2024 23:39:52 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 23:39:52 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Cc: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] perf: cs-etm: Fix the assert() to handle captured and unprocessed cpu trace
Date: Tue, 24 Sep 2024 16:39:30 -0700
Message-ID: <20240924233930.5193-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:610:e5::14) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|BY1PR01MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 423c77f3-25fe-43eb-c879-08dcdcf23006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odJzWoEp+WE9Kjl4UjyxgCIuWcqKKLvrvMAswzDMPjHBFqCiPMguHOT8k2n2?=
 =?us-ascii?Q?M41DFpUGm9Uy2PQ8C3hENr9EjTT6u8pxIpqefEpPr4z6clGyrgbaR+R41zY1?=
 =?us-ascii?Q?yAF7mz1BR6xHHmCm7/0Kpx9gLTxmyFEVg0traYvJqw8J3F46+9NeNI/FbtNU?=
 =?us-ascii?Q?RE8k3+55OB80iBDFgk7rk865q+EArP+St9x9XQT9mpjkNqQBwomA6o/C/NHE?=
 =?us-ascii?Q?L4cnqytE81wR/9IlPgCSatLx/7vvsDSPdzDbbUupcYUO8XC9q3iZJOf+rwz0?=
 =?us-ascii?Q?jBH3q5wtSxMw6BMKu0Px+1HsyO69uQbq/SgfIyzMu8a3VLpVQ1vodZdl8/Uy?=
 =?us-ascii?Q?0VYtrr1IvBq9V57SIecfMFf09k9+Qrio6XXDffrNYnrkgd2fRymKYwudCmKn?=
 =?us-ascii?Q?ImO5H0rJha+w+CHK0m1c66H3R3nmDlEJIhpD0obWsP/ScGkBfsFl2CUqBOBX?=
 =?us-ascii?Q?lyD/jPlAHODPL5+rrNNlAJiiG0PKt83twJdwu7wectxstN6psVir87DOMeD0?=
 =?us-ascii?Q?q5R2Dp3BR8DYjDfQOJvHjbxlM8mdA1E4ynHMTRcWtRt4SJJE4/twI6+DsOUK?=
 =?us-ascii?Q?uzqN12txL/McmruVIlK+1XCfQnv4Rw2l6u5hgypmm8idWcohiiwuIBw4Gf+/?=
 =?us-ascii?Q?9/DUPxL+jNWD19ZOWve8XW1JBkYQM1iLWMNQDYVMEDjL6miAh0vEhWXaY3Ch?=
 =?us-ascii?Q?iv3+BuJAXRh03fOopRa/WmR/KZ5w76tHlSE3zbLiYCOlYs9i7gV3ZRMEE8Ei?=
 =?us-ascii?Q?rgqile+NC57Rd77lbcoU0+DN0nO5WZtPvLmmSkqaMfJvnsARzJ1Nnl+6TxAh?=
 =?us-ascii?Q?dAWILifzl/FwjDsjs6/KDa06T3oPiAuy+IG7txSDWq4QIAZIY6nhnFUIB6K3?=
 =?us-ascii?Q?hU7oYir/787/GX0ikNMEPD8z+CD03mw0KD+OKwpBXVVABg5ualY8odG2UrGv?=
 =?us-ascii?Q?DXzwoSx/CPlJ1Hxu+LHRoSj8LtyKtPfEODVG2XJrVoML07rFRRXSyzRjk0Na?=
 =?us-ascii?Q?+o7ocM3a19qXpusjDywNg6Cshf1EN5UXFz0JLQhr8U/laTSoixviNmwYr/hd?=
 =?us-ascii?Q?Jn2qGNf72yzv/LCXVfNFuF07+IBFbVpU3K4HC7hARNAGzdm0jq+hx+qejOho?=
 =?us-ascii?Q?3HfOArvb7aOzN4L0lYLDPyRqGEhcfW1bwkJ6YJwkioH9rDlh10fwFY2+Bubi?=
 =?us-ascii?Q?inLHzfk5Px98Udg7jd6zl4dVsYXyyNpVZ317iRAOVNMq+W5LgehJPL5jZGYw?=
 =?us-ascii?Q?lgdbBeyFTD1oRPaRh0wNwx4udzNEyZzSUjDv6oVI7Aa6BgX6NC8v0ofheOeo?=
 =?us-ascii?Q?h7wQfhApj/jOaHgkpffnJSsJMMgKnE9BWXLH8xVtlInZYM8ftqyeVBoptATN?=
 =?us-ascii?Q?x+BG3OOi6bifQxiCyCOxbrUUxICs+PI9CEnI+EhN5+xYPlIjAIEJuQ67owC9?=
 =?us-ascii?Q?1fTuBc85dkk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZ+YBWMOGNhMzBHqZ3YHUqaoN6AGuQda46Hn8V1/duCYLII3NQu7MdznAwRH?=
 =?us-ascii?Q?MZ/4OWneF4Z/cPZwrh+C1slhJ2P3ZvzKNox1lXc9mcLFNefCgc7z82B9LZps?=
 =?us-ascii?Q?1oE/8BtnzhTv1cYfLtPryhdct6IaftW2Xj9pTUAfZVsB7ybeZ9M93PnRL2nQ?=
 =?us-ascii?Q?Rektice047+b8VtP6OsQazsGh8phYMb1cv3HrXxfjgKng0qJRsdeGQYPZfSx?=
 =?us-ascii?Q?V6Hp5Xx/1xZ6Ml2XGBBw1/egAWyVUQgJeAPWyd7py2WR7sJJnaNeT6KIW/Ui?=
 =?us-ascii?Q?EzSUTOYTVGWM/69EDi9knkaBwbYH6A5nUu4WEv6yZd8r/kcXXn2ve9vQKSpp?=
 =?us-ascii?Q?6KZy+crCqyP5Ku7AFr+LRBqKu2i3Q/4J7GSgQ8TrFDUe9PlSH0EXOgMIQNnC?=
 =?us-ascii?Q?lsZmX8X3rdYp+iO+yf2R+gTEx+TbR19tunTsP6x7NAZUiJrFozbpeW7HHaXx?=
 =?us-ascii?Q?LYY+F8++ElNAkLMJqV9pYbLfBx0G85dPIzG7MGOA+WoPnyd4JKFMUYSUmEi7?=
 =?us-ascii?Q?gAmCq/qxfK07JlH5NYwbuUM/wXibi5uZHi48JVrEcybbxKWnqvc4+xfkxWYm?=
 =?us-ascii?Q?7m54lQAktEzSH3nJQYl4MNGuSmrVi41usvtOFnaZc+71OJA7S8KY4i1u1wkp?=
 =?us-ascii?Q?y2+eT281wrlqW71fL2xkTmr2ONI+Y222oICBsPu829uRDJzJG0JUlUucpVyo?=
 =?us-ascii?Q?4wHO2x2RFlK2ZNTkoA3LhsPLLFSAvo13f05vGgsXxBCxOlCXoFAx7kAkRdt9?=
 =?us-ascii?Q?uaReb70TTq1DhmZe2HAjY+2aUsDjJ4cyxjM5K5Ch0WQ32+qTqHY2jEzvYQAx?=
 =?us-ascii?Q?3q8XpW2VDRmrsoF4YUsDcCU9cJAsITCFutxS1n/UsmttWQ9TYV9Aq0LvhY4e?=
 =?us-ascii?Q?6/NMjrJXiiyYGvC7XI2iSY1yWta2Yk2DBTw6wrZGdwS5KyNmy+gnLmpqIFR+?=
 =?us-ascii?Q?P6KN17KQo683CL+gW/fbv2/4fXn1o9fmsLbj7mpdZkbYQzAA00V7vm7suR+Q?=
 =?us-ascii?Q?Iwypwrq3wffC3cqMDcNysQjrqChq307GhuOe6OSvzFMg3Bqjvn5yfCWWO/bK?=
 =?us-ascii?Q?9x4cL7XcPiF0nQxfZGYwWsl+jTuFEVaCeTtIxL5+zLIsCbZ4cMQ+MAzX00aS?=
 =?us-ascii?Q?ttoo37ULmzMLHJmlmHcDk8fFqnX3vanUvjr5SFYDkCAtmRpuDHVvrmfuXCcc?=
 =?us-ascii?Q?Rg8HvDFgdh7keO8ethABV5ngmvikEQMxuNDCvJ8c8+VRqtnhKqBBAC4uySl8?=
 =?us-ascii?Q?3aLK/fhUa+ZHZS2ypBRh/zUcN75wNc3E2+qhoxgOBZBALsGwlFLW767hnup4?=
 =?us-ascii?Q?AKkemxwZhPoxhYu2OA0Aa8b2fGwAKHpxTpiOYjy/VO3u7TN2hLpDSU3tvUU6?=
 =?us-ascii?Q?807M54PX6a09X64whJZ8w7+hK6bZl3XaALlvlqHIPamKM4EUIUlXQqSicKqg?=
 =?us-ascii?Q?7Cssju53br6OL5XLa21sp37kCgoyxSjpg9GrDtJXRxrqZidgH8N2o4Oiv+Wn?=
 =?us-ascii?Q?Yw1WgQSr0bfwkCuPqJjTcpiy+73PmjlkCyaEvCh59pvgBR/+xC78tPir06Jb?=
 =?us-ascii?Q?2mB/fLOjU36Hl5SS5XVrXEV1TMtgGZs2B0Bu9gHutRMEd4iK+E+G6Kedt50B?=
 =?us-ascii?Q?8D73rPMrFy2kpCgppL5XIS4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423c77f3-25fe-43eb-c879-08dcdcf23006
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 23:39:52.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwcZ8NqpamIz11zXykQfP/0/cQ/7e7Cfld7dRN1lpAP/3JjJvZNke7yz1fcViphz/5ZVGJR2SJjSOzIB0Y0ebJdrjZGSq2OaZM4yCcoZ/94zCeWOonIPbQiCa3/7nv+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8922

If one builds perf with DEBUG=1, captures data on multiple CPUs and
finally runs 'perf report -C <cpu>' for only one of the cpus, assert()
aborts the program. This happens because there are empty queues with
format set. This patch changes the condition to abort only if a queue
is not empty and if the format is unset.

  $ make -C tools/perf DEBUG=1 CORESIGHT=1 CSLIBS=/usr/lib CSINCLUDES=/usr/include install
  $ perf record -o kcore --kcore -e cs_etm/timestamp/k -s -C 0-1 dd if=/dev/zero of=/dev/null bs=1M count=1
  $ perf report --input kcore/data --vmlinux=/home/ikoskine/projects/linux/vmlinux -C 1
  Aborted (core dumped)

Fixes: 57880a7966be ("perf: cs-etm: Allocate queues for all CPUs")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 90f32f327b9b..40f047baef81 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3323,7 +3323,7 @@ static int cs_etm__create_decoders(struct cs_etm_auxtrace *etm)
 		 * Don't create decoders for empty queues, mainly because
 		 * etmq->format is unknown for empty queues.
 		 */
-		assert(empty == (etmq->format == UNSET));
+		assert(empty || etmq->format != UNSET);
 		if (empty)
 			continue;
 
-- 
2.42.0

