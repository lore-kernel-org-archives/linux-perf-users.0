Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795783143;
	b=0HtfjEt+U525uwblZX63DWeUpOWpAQcyklgba4rBkH2MdKlpBaAD+EFGF+3iqINrrLwf
	 Gmzy2VWaMOmQ2Aa8/Fh6YIA7TzZCrjNIEvi2pXoxuz6g4Va5NQvdi7XS3TGa9GStGoJmz
	 qzBKq7f6WUPErvHs+t/QlkPkf/M/lHEQp/cD7qSIPlRAeQEjJZ5qxmhQZvkz3ChhL1FB5
	 PiTu1Cf0kesTNuoyo6f6giv8ni6dBS0pZeKOOUdC0GegIOB1DfmydNNQvwFrIu6prPea2
	 yk/bR4QnKnLsq/DnZF/JWOCNHkAmNJYbTtommNJQCaEcavlt3O3IkYdJLe0GuVGHn3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783143;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+Yx4M8aIU8HXkD0jXwZMAB3Gka2Ag+/nXA0eM7i+hSQ=;
	b=0VtdgN59CiSfkFpRr8gvRHlGlONWl552rB6gIb1LU3rbxocGb8G/oIS31g9u6iWdMLRF
	 ncFS6dPwI8uuFTK/ZTSfxFPpNU80fNpjJw13GM+dcAC5PpAllfTz4zjdzHzkau2RYy+jJ
	 s1R1h72FiFlQou0vYz54O8MjSfb4/OMOrkL1qb+cgCGGNr4aior5aMZZt28pHcS4/SZ0V
	 On5gdYJc/hGcNaVKNp7elHhBHaqSwZU1s0k//4i33JxGTLk1sxSiNIePibNsSwPm9jMhP
	 1CfrSIbXYbr2FmwItjPybp5Hh9nL3oKSQlZVr10wxNWp8f8JO+eAS243giIrCcP/0lA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UTyPdS4F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.8
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D457A606A31E;
	Fri, 27 Nov 2026 12:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D457A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=UTyPdS4F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFL6MA/tnCUU3jeQsErEFZpPNbVZEGmUNrxMq36HjiYp38gNdGTqdNQDTyX+t5yVxzZ7G0xOI67yu5M7ZdxXYbgo6pL/Unz4u5sIlVGINH02RghAEoL//66D3excBSURbsR9wcr2kw2Aooocs5fN1LefD9MXQRy8Lacm9le7V7i4LxlMc75JSa0C8I4GNqL+iKHvK/sfLX+aOXgG1d8yxl+rUu2N4RcywMkpBa0ERObvzjv4nVHwlvPTl6RQu+uWZ8GSoIMnn+6PxCJ0PebxuxHhvPdqGVHuuHZVGYiZYy+rL0gawulk0wVRLIj7O9nOO9v4AhBrRRjTyGxVgaXCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yx4M8aIU8HXkD0jXwZMAB3Gka2Ag+/nXA0eM7i+hSQ=;
 b=gFLHNYi2DJX2Dss5z6Ggyc5bGV1KEE3GyLlkj2S1dNVuUR8Bj6yknipkj1nX+DR98Ome26fsTXYd4n6YW2JZrZHQHdVjmp+nwk0SQGWoajHR5YalxIEhI7JdORA9G1kUEvxaktwdF0SA45oapuHf3/YXM5vpzIyvyUgFDJ2bxmVeBLgD82l3GBSQizOIV+El2wWeM7rmcEOF4fZEO0WzCsoBAMc7KHPpWoQgJesLXFB+EwCT+kUpCtJtCeTYXUbKBAp6WfvqME9G9324cNZqxtd42A19AWbM+zxgW/ENTFud+yCdDwqEJrx7Vz4GbxF4KA3bYzQSRskfMiWIAmaZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yx4M8aIU8HXkD0jXwZMAB3Gka2Ag+/nXA0eM7i+hSQ=;
 b=UTyPdS4F4U4V5Lsbto6AUo7AtFEaGl2YFtr1L4SJO4ZckG3v3BQ3uJVx9sutnZSZ3TGMfn0nKXl5V5reAwcymAkewOTCzhO47fIsRcb+7o4HTxGGxEvE2T6i7YeZKwmtv+HjcUWNOn3P410e/BxIIXaRG5sClsB5NbOru2L0q0cpAmFVkPilohl7uH2FM0tLuvqbT//A4xKl+goOMvPpPllhnuRL1x7vlTf4nDhNBRQCsrz+8RE3WJ6kKZ2eWOjvt4mn7FAwQTksxzxYz5G5312qrrBiP1O2JyfmOG4vbb3R9FdjhfX+5Rd9qdqg4CkJZMS4wP4lcoLLoavwlF+qiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by IA4PR12MB561602.namprd12.prod.outlook.com (2603:10b6:207:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 12:38:59 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:38:59 +0000
From: Jan Bernloehr <jbernloehr@nvidia.com>
To: linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@linux.dev>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	John Garry <john.garry@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Matt Ochs <mochs@nvidia.com>
Subject: [PATCH] perf arm-spe: Honor --time ranges when synthesizing samples
Date: Fri, 27 Nov 2026 13:38:54 +0100
Message-ID: <20261127123855.78212-1-jbernloehr@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::8) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|IA4PR12MB561602:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2134ff-0290-407d-4cd4-08df4c836878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261009223027099003|21046099003|18002099003|11063799006|5023799004|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qt2y4udDm1dNKr7c9e5gcgmXSHVkHcIcwvS8+31G+cqYuhDq8tDjUwc09myi2d4whEvsOoSqp7hfiIrAEG0kxN2HefJUBUrrrTP75kfHGbB1bKrDZy5fq6fC99btzOkG66CkM7bzJxS0GOVXUbIsCulzsxgE+F6Op1MlFA6pZfmoKhOmWO8eQDOlNKrdjCnP5HyYKXlF907avQ7kuusiHoeBguug1G7QL5anc4FV5DDG87MYKjYFdWGU1Lv7hshHFfr68D8QDCMjCxDhBDk1XWvce7ikUglbXYeoD5LFGdbBs3T2mwwn1iq2Kox6eB8q/scFBdILB+1I4Lqkmq5nLyKySwwWwM748Vv11XNo/szh1+4X1XSRMIal3Xow6Xl8SMTyUAgLYgnt1mAIBhWG0OPjtQAG5QnmFRLs1GPRl5oEUSyj67XmytUR18a8/ivGlcF5NaAYGcPziU8p7xvkbptSyvymtB7khRziaj9EvetK/zVSP4b/JJ6RsITHyj4p/WZ+OHOyjUaZ/ufDDWOtaaptSmub8molOYeQDV88kUJnAFwHyg0fq0mIrzn2JwXFDS0GK3zBzgyYApJp/h8xCPhK0bwr2//qTWZs6fpKhd0zZ++dbKcpduFu0vC55EfQWpdkFe8LDDlDTRzAJ6E6hRI+o9rR3tTFZd3Ty7BWrY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5126.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261009223027099003)(21046099003)(18002099003)(11063799006)(5023799004)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kX2EUJep17IrSo46COptHNTe/fticodAAMb/KIMa5y2UXbWjkDaIbyAsJiG+?=
 =?us-ascii?Q?pfTh+arhu/ms4VWUXfqxu6ejaorhe4mZAFO27u9ClisYD1wspQAR+zfcz0BJ?=
 =?us-ascii?Q?11JsarqdzYsd++Uda+J6mFqtWhv6DeAOoZs72T7aUIa/xcI5Ze/5xlV9z0ik?=
 =?us-ascii?Q?OZKZ2qW80StShWnoamh24wAtgV8VHA/1/ssBdRsJEjxf+OLump/Tz9sR+9WR?=
 =?us-ascii?Q?JSYM5MTTvNmxdB9eb3iSPM5txj979EmiT3F/YfyFenhDMHIGf+gJby9VkHFM?=
 =?us-ascii?Q?XC/6RIo4Ne0C8CbTI2u6XzpROxBr5MvPjWIEadx6F8QbZv/b//Z0BzLW67/4?=
 =?us-ascii?Q?+MACTwuMLCFvzUcSTy3WnXzKQo5sbec5PilBtUF9yfGPec6Mq//8Enzh9Dla?=
 =?us-ascii?Q?gMAtC2PRIuX/0wWFnvPkzpvGnfntvx4Va32haNVoJXXlL2PNSfklNIU3306f?=
 =?us-ascii?Q?w2Xq1wSMyVX3oH78w+VjCWgTjmJ+RS63Id7WZcxV6f9txrO0imc3mxz8qhC5?=
 =?us-ascii?Q?SlIPdYw7MBI1zGal0jCosYpmYB+1/LY3IaVQcfj4Ivnz78J0pM8hBz0//qA4?=
 =?us-ascii?Q?OEaKgY+tp4tVOZyGibdi5WKu0Y0HLmRbSdhfzY4Ps6RDeWCqpdf8PEIJ0GM5?=
 =?us-ascii?Q?hGnuuwuc1u95dUU3ZY098VuPgsHqnCG3/wegBH5MwP4pHQuB2Ko9VJk91xB5?=
 =?us-ascii?Q?QKMlM4C5nTwaWp8F4NoJt/b3+mZE3SQRwpi1FJcFywSpwPxwDCbohH9uGYCm?=
 =?us-ascii?Q?HRxeJ0w9g/0lzy77BdvVvE95K66uccGatmvIlTjbv4gTp/Ya860DJB0KTtrE?=
 =?us-ascii?Q?pgf1E6Vf8+j6C1XWvQH7T70hFBDpilbJxU9fLgCMYQs0zEB4dLb4YobpRK8i?=
 =?us-ascii?Q?n0+dwP7m5ABsfbm3thBLOSD+GCQHofj2pnkO5FOhGp91uviZakswPoaXBbGd?=
 =?us-ascii?Q?eqINbIt7Xu5kkko5qOSqay1PqXV1qQzxJA5S+nXodvIVexlYu5RQq5nTdhJ2?=
 =?us-ascii?Q?R7lQ3u4fgzAYR/OWtwAoSpckPmuvfT7wB/+0RxNNSaZFPJb15Y7tEN0NqspZ?=
 =?us-ascii?Q?w77wb514nR58VCrEAgAX8Uevb8MIXOCg1ZNUl4/2BwfdX8+yq9Bgrfkg89g2?=
 =?us-ascii?Q?VyD0rSL5wIXY0Iumek/L42qQNPx6jwZmLIhsVYGT9+aFcoTXdFmBRhknbiQQ?=
 =?us-ascii?Q?69HTWfTW4x4YanPVQMGmlmn+VN1J2U/2fE0/lVRKFLSTGl0qCbK9PPUL0E7Y?=
 =?us-ascii?Q?aCoXeKPjlc3wmKZq05YjShloc/p8HRZsej7miYw3FN3rb0szFdFgpHVAcnG2?=
 =?us-ascii?Q?+iSMMD2a/hs8BHlkBk9p8XO7KD4ZWilzyYR39Ce72ewr7L8kkRa0a9vnP76N?=
 =?us-ascii?Q?zTZSR/PlnZWWugbLXbTPkF0MSLRx7QNKS+RlT6cdE47XxlMS2EM5OZcSp8tG?=
 =?us-ascii?Q?0hvHAtL0YgVRuA87afeBicsQjHYT8us3QLU2CqH0cf0gDKmuuUT3yYvZ+Nr6?=
 =?us-ascii?Q?23wo6qNddR9H/8vKdjDwjzsXpCxe7rsztQozbXYBu6EmEpoWWdDT2QIfsf+T?=
 =?us-ascii?Q?D/O18SmwJO8pTegjn0NenxSNtCjYIlujlnLEd8kW3p2hNs83fCQFQLXYI/hv?=
 =?us-ascii?Q?zlInIdxOjaNfVRLDEdNKEG5jz46nbN79i9BTsfVXclZkxcZ4+npgEV1Y/57F?=
 =?us-ascii?Q?q4u19QJcc/yUA4y6z3wNFuYouE+ygg1AKbhh5dFTDKTrf9ahHlX0CYu9dnMD?=
 =?us-ascii?Q?h2JoIYTcrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2134ff-0290-407d-4cd4-08df4c836878
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:38:58.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9XDF2lNwpPU2aSrib8gLL/9iHZOtSXZNqjsv3vHwtWVlanR/NmfaeITt8ir/2KyUnXkGO+HxCBY1vn7eRiAWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB561602

perf script and perf report pass their --time ranges to the AUX trace
decoders through itrace_synth_opts. Intel PT uses them to skip decoding
outside the ranges, but Arm SPE ignores them: it synthesizes a sample
for every record, only for the tool to drop the samples outside the
ranges in its sample handler.

Check each record's timestamp against the ranges before synthesizing
samples for it. The check runs after the --itrace period count and
converts the record timestamp with tsc_to_perf_time(), as
arm_spe_prep_sample() does for sample->time, so the tool receives the
same samples as before. Without timestamps (timeless decoding) nothing
changes.

Decoding still runs to the end of each queue rather than stopping at the
first record past the last range: record timestamps do not always
increase within a queue, and on Neoverse V2 traces such an early stop
dropped samples that were inside the range.

On 28 GB and 55 GB Neoverse V2 traces, perf script --itrace=i1i with
--time=70%-95% goes from 212 s to 188 s and from 383 s to 339 s, and
with --time=70%-70.01% from 101 s to 72 s and from 188 s to 131 s, with
byte-identical output.

The code and this message were drafted with an AI coding assistant
(Claude Opus 5.5).

Signed-off-by: Jan Bernloehr <jbernloehr@nvidia.com>
---
Tested on GB200 (Neoverse V2) with two perf.data files (28 GB, 55 GB)
recorded with
  perf record -e 'arm_spe_0/branch_filter=1,event_filter=0x2,jitter=1,period=4096/u'
and decoded with
  perf script --itrace=i1i -F comm,tid,cpu,time,period,event,addr,ip,dso --no-demangle
using perf-tools-next 29fd95dbd25 with and without this patch:

                          28 GB            55 GB
  --time=70%-95%          212 s -> 188 s   383 s -> 339 s
  --time=70%-70.01%       101 s ->  72 s   188 s -> 131 s
  --itrace=i10i 70%-95%    84 s ->  81 s   150 s -> 147 s

Output was byte-identical to the unpatched perf in every case.

An earlier version also stopped decoding a queue at its first record past
the last range. On the 55 GB trace that dropped 21% of the in-range
samples, because some queues produced in-range records after a record
stamped past the range, so this version decodes every queue to the end.

 tools/perf/util/arm-spe.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8d95df23be6..bf1e824ea76 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -26,6 +26,7 @@
 #include "symbol.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "time-utils.h"
 #include "tsc.h"
 #include "tool.h"
 #include "util/synthetic-events.h"
@@ -93,6 +94,9 @@ struct arm_spe {
 
 	u64				kernel_start;
 
+	struct perf_time_interval	*ptime_range;
+	int				range_num;
+
 	unsigned long			num_events;
 	u8				use_ctx_pkt_for_pid;
 
@@ -1077,6 +1081,19 @@ arm_spe__synth_data_source(struct arm_spe_queue *speq,
 	return data_src;
 }
 
+/*
+ * Check a record against the --time ranges. Samples outside them would only
+ * be dropped by the tool, so do not synthesize them.
+ */
+static bool arm_spe__skip_record(struct arm_spe *spe, u64 timestamp)
+{
+	if (!spe->range_num)
+		return false;
+
+	return perf_time__ranges_skip_sample(spe->ptime_range, spe->range_num,
+					     tsc_to_perf_time(timestamp, &spe->tc));
+}
+
 static int arm_spe_sample(struct arm_spe_queue *speq)
 {
 	const struct arm_spe_record *record = &speq->decoder->record;
@@ -1092,6 +1109,9 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 		return 0;
 	speq->sample_count = 0;
 
+	if (arm_spe__skip_record(spe, record->timestamp))
+		return 0;
+
 	arm_spe__sample_flags(speq);
 	data_src = arm_spe__synth_data_source(speq, record);
 
@@ -1255,6 +1275,17 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
 	return 0;
 }
 
+static void arm_spe__setup_time_ranges(struct arm_spe *spe,
+				       struct itrace_synth_opts *opts)
+{
+	/* Without timestamps, samples cannot be filtered by time */
+	if (!opts || !opts->range_num || spe->timeless_decoding)
+		return;
+
+	spe->ptime_range = opts->ptime_range;
+	spe->range_num = opts->range_num;
+}
+
 static int arm_spe__setup_queue(struct arm_spe *spe,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr)
@@ -2055,6 +2086,8 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	 */
 	spe->synth_opts.period = spe->synth_opts.period ?: 1;
 
+	arm_spe__setup_time_ranges(spe, session->itrace_synth_opts);
+
 	if (spe->synth_opts.period > 1)
 		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
 			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
-- 
2.54.0 (Apple Git-157)

