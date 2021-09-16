Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BD5C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D436D60F11
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Sep 2021 12:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbhIPMGR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:06:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238974AbhIPMGQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Sep 2021 08:06:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18GBokCc011984;
        Thu, 16 Sep 2021 08:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5RhjU+LEmgORcq/vv2e0IOKZ6jh2ZKtBlLhFlAHPRHg=;
 b=GHxjWi0AyL+1vvNb7be9plmfgeSx9iPty/SNXCP7Ah0PYh/MLaKRxVTdnkZDvwVOmfcj
 5/AqtcO2CkGgLKgRoqEJahbXoF6E5qsi0dPTaM+QI5l70nV4Lo8jXvuGh+/nzsBpiKyI
 ujvdhfsUk+PtkhwJQql888ydK7g8/Tn9CbVeb07nm3yORXGAzwD3UMkBXeuk/oTIMQrG
 sLY0Vfrt8ILxhtsCWG/JHQ9Mf16fdElDAC4/0zTPMiUc1ug5DHe28gStaOhBpBPf0EVd
 YkFo/8iWBRq1QP+WSF3ANxv+Voa1oZA2+94018gYlpNRdrFxl4dO3gA5+wsFt054xReg Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b44r3hb65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 08:04:39 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18GBpAOe018953;
        Thu, 16 Sep 2021 08:04:39 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b44r3hb5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 08:04:39 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18GBuu0s027838;
        Thu, 16 Sep 2021 12:04:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3b0m3cgswa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 12:04:38 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18GC4cSH22086012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:04:38 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E032528067;
        Thu, 16 Sep 2021 12:04:37 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F378A2805C;
        Thu, 16 Sep 2021 12:04:35 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.160.174.53])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Sep 2021 12:04:35 +0000 (GMT)
Date:   Thu, 16 Sep 2021 07:04:34 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
Message-ID: <20210916120434.GA4498@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210916060525.1890638-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916060525.1890638-1-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QZlgmHlhqgc6bOwf_oeWkoIU_-VfjeQS
X-Proofpoint-ORIG-GUID: WhGUe7YqOAMBCriT8Gea9tpvtlqe3mrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160068
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 15, 2021 at 11:05:25PM -0700, Ian Rogers wrote:
> Test every metric and metricgroup with 'true' as a workload.

Good idea!  (However...)

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
>  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
>  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> 
> diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> new file mode 100755
> index 000000000000..de24d374ce24
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# perf all metricgroups test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in $(perf list --raw-dump metricgroups); do
> +  echo "Testing $m"
> +  perf stat -M "$m" true
> +done
> +
> +exit 0

This always succeeds. Is that what you want?
Maybe check the return code from "perf", at least?

> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> new file mode 100755
> index 000000000000..81b19ba27e68
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +# perf all metrics test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +for m in `perf list --raw-dump metrics`; do
> +  echo "Testing $m"
> +  result=$(perf stat -M "$m" true)

I don't think this is doing what you want it to do, as it just captures the
output of "true", which is always empty.

> +  if [[ "$result" =~ "$m" ]]; then

So this always fails to match, and you'll never fail here, either. :-)

> +    echo "Metric not printed: $m"
> +    exit 1
> +  fi
> +done
> +
> +exit 0

You may want to redirect the output of the "perf" command to a temporary file,
then grep within that.  And, you'll need to remove the file before running the
perf command, because if it fails, it will leave any existing file untouched.

Thanks! :-)

PC
