Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3138DC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 07:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F5161027
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 07:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhJHHqO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 03:46:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231749AbhJHHqN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 03:46:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19867HdP014781;
        Fri, 8 Oct 2021 03:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wx++73eQbg9L2lY7xqYjkC2PwZy7JDjcWRVyq2Ye8Xk=;
 b=kWcV3fuRMo/sDws6Z3LJdRHWVpToq6KmSKGh0c6fDA5gHC6WiuPZXXNGqC4Naz+C7iXZ
 up6c8orZiACtes3ZTt8RK2n5S9tRZOKBAChPddUZxVtuhb+2BA4Lo+ZOaaZeEeO8VIJL
 VS/3P3HMXPKMohF9aFhIwSTmk4wbwG4uxfYdSvi8UV9leoevUbazDOcxegqq/ZaWB0B5
 YFEYqRBzw7Vg+gSEFPhtnaGBWstayGcyW1UiU8uFn6O95V1Lz5NJVEuxu3PxG0rlrkiD
 y/i9YJaVvFZynk5DNuKA9rK+fJgG1fCziq3YC9Lmyvb6g/25STh/NZcU2JCY5pBevum0 Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bjgeh9x8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 03:44:04 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1987V8vp004321;
        Fri, 8 Oct 2021 03:44:03 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bjgeh9x80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 03:44:03 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1987bTgv015268;
        Fri, 8 Oct 2021 07:44:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3beepkc4kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 07:44:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1987hxUT43319704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 07:43:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 064E0A4060;
        Fri,  8 Oct 2021 07:43:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B05BA405B;
        Fri,  8 Oct 2021 07:43:54 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.64.167])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 07:43:53 +0000 (GMT)
Subject: Re: [PATCH 0/3] perf tools: Enable strict JSON parsing
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org
Cc:     Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211007110543.564963-1-james.clark@arm.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <c15fd2bf-104e-6ab0-6496-7e5cf77a218f@linux.ibm.com>
Date:   Fri, 8 Oct 2021 13:13:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211007110543.564963-1-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: stL1JeLwcbXOCYwfMNJtRVkxpgsYcQk9
X-Proofpoint-ORIG-GUID: 2MFVAd99335SJcZMGYByts8YBC9c28SM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/7/21 4:35 PM, James Clark wrote:
> After a discussion on "[PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1 json",
> John Garry suggested that we can just modify the parser to make it more strict. Hopefully this will
> remove the need to apply any future JSON comma fixup commits.
> 
> Applies on top of "[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json" on
> perf/core.
> 
> Also available at:
>   git clone --branch james-json-parse-fix git@git.gitlab.arm.com:linux-arm/linux-jc.git

Hi James,
   Do we have any dependency patches on top of this patch series. I am
reviewing and testing it, but in both powerpc and x86 system I am
getting build issue. Not sure if I am missing something.

I am trying your changes on top of upstream perf.

pmu-events/arch/test/test_soc/sys/uncore.json: json error Invalid
character inside JSON string
make[3]: *** [pmu-events/Build:18: pmu-events/pmu-events.c] Error 1
make[3]: *** Deleting file 'pmu-events/pmu-events.c'
make[2]: *** [Makefile.perf:667: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:70: all] Error 2

Also, Is it possible to add line number along with file name while
showing this error `json error Invalid character inside JSON string`.
It might make it easy to fix.

Thanks,
Kajol Jain

> 
> James Clark (3):
>   perf vendor-events: Fix all remaining invalid JSON files
>   perf tools: Make the JSON parser more conformant when in strict mode
>   perf tools: Enable strict JSON parsing
> 
>  .../arch/arm64/ampere/emag/bus.json           |  2 +-
>  .../arch/arm64/ampere/emag/cache.json         | 20 ++++-----
>  .../arch/arm64/ampere/emag/clock.json         |  2 +-
>  .../arch/arm64/ampere/emag/exception.json     |  4 +-
>  .../arch/arm64/ampere/emag/instruction.json   | 10 ++---
>  .../arch/arm64/ampere/emag/memory.json        |  4 +-
>  .../arch/arm64/hisilicon/hip08/metrics.json   |  2 +-
>  .../pmu-events/arch/nds32/n13/atcpmu.json     |  2 +-
>  .../pmu-events/arch/s390/cf_z10/basic.json    |  2 +-
>  .../pmu-events/arch/s390/cf_z10/crypto.json   |  2 +-
>  .../pmu-events/arch/s390/cf_z10/extended.json |  2 +-
>  .../pmu-events/arch/s390/cf_z13/basic.json    |  2 +-
>  .../pmu-events/arch/s390/cf_z13/crypto.json   |  2 +-
>  .../pmu-events/arch/s390/cf_z13/extended.json |  2 +-
>  .../pmu-events/arch/s390/cf_z14/basic.json    |  2 +-
>  .../pmu-events/arch/s390/cf_z14/crypto.json   |  2 +-
>  .../pmu-events/arch/s390/cf_z14/extended.json |  2 +-
>  .../pmu-events/arch/s390/cf_z15/basic.json    |  2 +-
>  .../pmu-events/arch/s390/cf_z15/crypto.json   |  2 +-
>  .../pmu-events/arch/s390/cf_z15/crypto6.json  |  2 +-
>  .../pmu-events/arch/s390/cf_z15/extended.json |  2 +-
>  .../pmu-events/arch/s390/cf_z196/basic.json   |  2 +-
>  .../pmu-events/arch/s390/cf_z196/crypto.json  |  2 +-
>  .../arch/s390/cf_z196/extended.json           |  2 +-
>  .../pmu-events/arch/s390/cf_zec12/basic.json  |  2 +-
>  .../pmu-events/arch/s390/cf_zec12/crypto.json |  2 +-
>  .../arch/s390/cf_zec12/extended.json          |  2 +-
>  .../arch/test/test_soc/cpu/uncore.json        |  2 +-
>  .../arch/x86/icelakex/icx-metrics.json        |  2 +-
>  tools/perf/pmu-events/jsmn.c                  | 43 ++++++++++++++++++-
>  30 files changed, 85 insertions(+), 46 deletions(-)
> 
