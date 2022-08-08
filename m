Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73444C00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 08:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHHI20 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHHI2Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 04:28:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E213DE0
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 01:28:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2788Bl0k003492;
        Mon, 8 Aug 2022 08:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : from : subject : content-type :
 content-transfer-encoding; s=pp1;
 bh=MfwQsULX8jg1xwVnNjqMI8ByjnSs4IIhNFTQdBP5C8g=;
 b=l1Xvc/IxP3MaV1xpQDQkNqKn+zSOrPBbgHqK8xwak8Gxh2+ICwEChVOoTBWMQ9JA/bEy
 6EznaCq3510fowWO9QeaSv/GgLh8z82PZfwVKvyDUq1THnhgSzthJyDVKftzx94kFXcr
 ePwlp5xnJpE3vlgHaNmBlwaUHYcPCUh2kixNf+AkSHREgETUw7XvFxKoXQazOk9Q2HBc
 olR215mWojL3AKMN4aFpuKQKeHOa6EC0JnS3S/LAFzmFwuiySnG9XcA9KDKz7v63VrhI
 ZO8rA1aJCdK9JMR/DomVAL9a017XQqncIAcdz0+up3FM4qbucwQ4PGkZ5GORdaEHCXFS PA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3htxrv8cs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 08:28:18 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2788K2FH004829;
        Mon, 8 Aug 2022 08:28:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3hsfx8hv79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 08:28:16 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2788PlC730933254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 08:25:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81B7911C04C;
        Mon,  8 Aug 2022 08:28:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 441C811C04A;
        Mon,  8 Aug 2022 08:28:13 +0000 (GMT)
Received: from [9.152.212.237] (unknown [9.152.212.237])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 08:28:13 +0000 (GMT)
Message-ID: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com>
Date:   Mon, 8 Aug 2022 10:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        leo.yan@linaro.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Vasily Gorbik <gor@linux.ibm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Subject: perf recording with java runtime broken with commit 2d86612aacb7
Organization: IBM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bjSiSWr6-SJXStVl3K8c3U3xH0k0hNTd
X-Proofpoint-ORIG-GUID: bjSiSWr6-SJXStVl3K8c3U3xH0k0hNTd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=678
 clxscore=1011 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080040
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit 2d86612aacb7 ("perf symbol: Correct address for bss symbols")
brakes perf performance measurement for Java runtimes.

I have a java test program which calculates fractions repeatedly
for several seconds. It is named j_fac1.java and j_fac2.java
and has a class named j_fac2_run() which does the calculation
in a long running loop.

I do the following steps:
1. Execute Java program j_fac1 which does some calculation:
   # perf record -k mono  -- java -XX:+PreserveFramePointer \
        -agentpath:/usr/lib64/libperf-jvmti.so j_fac1 1000 123456789

2. Get the JIT'ted data with
   # perf inject --jit -i perf.data > /tmp/perf-jit

3. Display the contents of the JIT'ted data with:
   # perf report -i /tmp/perf-jit | fgrep 'j_fac2.j_fac2_run()'
    94.52%  java             jitted-28128-319.so  [.] j_fac2.j_fac2_run()
     0.10%  java             jitted-28128-317.so  [.] j_fac2.j_fac2_run()
   #

This procedure works fine until above mentioned commit.
With above commit applied, the step 3 reproduces this result:
 #  perf report -i /tmp/perf-jit | fgrep 'j_fac2.j_fac2_run()'
 dso__load_sym_internal: failed to find program header for symbol:
        _etext st_value: 0x223d0
 dso__load_sym_internal: failed to find program header for symbol:
        Interpreter st_value: 0x40
 dso__load_sym_internal: failed to find program header for symbol:
        Lj_fac2;j_fac2_run()D st_value: 0x40
 dso__load_sym_internal: failed to find program header for symbol:
        Lj_fac2;j_fac2_run()D st_value: 0x40
 #

I see this behavior on s390. I have no machine to test it on x86.
I have identified this patch using git bisect on the latest linux
master branch.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
