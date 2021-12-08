Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F5C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 23:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbhLHXg4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhLHXg4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Dec 2021 18:36:56 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D2EC061746
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Dec 2021 15:33:23 -0800 (PST)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.1.2/8.16.1.2) with ESMTP id 1B8LWaUO007451
        for <linux-perf-users@vger.kernel.org>; Wed, 8 Dec 2021 23:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=jan2016.eng;
 bh=4tW3/uWz7pscOI/+4VxbINvQugMurupO+xqy2oZtdhw=;
 b=QHi/e4g0dSDRb5nRP1uEU8LYZeHwEWelRF5JLExePhpbQZe/m89+Gw1CXf9Rsx1O8rev
 suhaBcCZ26Kr9/B6gAXkYkhBkvZLTM00iJhE3T6Q1rqidAGwA9HCfkZSMUT4C/dJgw5h
 lfYa986RgpJM0YukSzsbUmkPIOKM4gZhw5YqlLJq8appnBWN9pxMDkmmL4XY/QlpgQRQ
 Lg/53Do+UZhHNXZfXS0ASm3moN1ctXM9aC+dTjcWuTutzJHW7Cv/7Tsi4K776knPwsHt
 ovdbvViUrlJTKPgUwebq/CQZEJHwCZCw4dcz4/ZAk/hUjjHGWsjEq0Lz3IkqTDoDmENM rQ== 
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
        by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 3ctxbm3agn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Dec 2021 23:33:21 +0000
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
        by prod-mail-ppoint8.akamai.com (8.16.1.2/8.16.1.2) with SMTP id 1B8N4ZAu014171
        for <linux-perf-users@vger.kernel.org>; Wed, 8 Dec 2021 18:33:19 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint8.akamai.com with ESMTP id 3ct8cs94tb-1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Dec 2021 18:33:19 -0500
Received: from [0.0.0.0] (prod-ssh-gw02.sanmateo.corp.akamai.com [172.22.187.166])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 3E4A0604D5
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Dec 2021 23:33:19 +0000 (GMT)
To:     linux-perf-users@vger.kernel.org
From:   Josh Hunt <johunt@akamai.com>
Subject: perf record per-thread vs per-cpu behavior
Message-ID: <40cd791f-c9fd-bf2f-2119-7225460a5e2c@akamai.com>
Date:   Wed, 8 Dec 2021 15:33:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-08_08:2021-12-08,2021-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=579 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080127
X-Proofpoint-GUID: gWnM4scpQ5wPWcmT833Qn27aH1qDE6-Z
X-Proofpoint-ORIG-GUID: gWnM4scpQ5wPWcmT833Qn27aH1qDE6-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=542
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080128
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi

I'm seeing what I believe to be incorrect behavior when running perf 
record -p and was hoping I could get some clarification from someone 
here. We have an application which has around 800 threads and when I run 
perf record -p <pid> on that the # of samples returned seems impossible 
given the # of cpus, sampling freq, and duration of profile.

I'm running on a 5.4 LTS kernel and the machine has 40 hw threads.

Running with -p <pid> I see:
# perf record -p 7297 -s -F 49 --call-graph lbr -- sleep 5
[ perf record: Woken up 32 times to write data ]
[ perf record: Captured and wrote 11.798 MB perf.data (58430 samples) ]

and I've confirmed there are actually 58k samples in the data file, but 
the # of samples should be closer to 5 * 49 * 40 = 9800.

Running with -a I see something closer to what I would expect:

# perf record -a -s -F 49 --call-graph lbr -- sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 3.405 MB perf.data (9745 samples) ]

Running with -p on applications with fewer threads seems to produce 
something closer to what I would expect since the pid being profiled 
isn't on cpu 100% of the time:

# perf record -p 11629 -s -F 49 --call-graph lbr -- sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.279 MB perf.data (1324 samples) ]

It's very possible I'm doing something wrong or don't understand things 
:) but if anyone has any insights into the above I'd appreciate your help!

I should also say that the resulting reports look different and it has 
me questioning the validity of the -p data.

I'm happy to provide more info if needed, and thanks for any guidance 
you can provide.

Josh
