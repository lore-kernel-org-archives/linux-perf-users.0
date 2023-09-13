Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2713EE0212
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 00:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjINAVv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 13 Sep 2023 20:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjINAVu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2023 20:21:50 -0400
X-Greylist: delayed 1854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 17:21:46 PDT
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD991713
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 17:21:46 -0700 (PDT)
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DLGUXK011909
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 00:50:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
        from:to:subject:date:message-id:content-type
        :content-transfer-encoding:mime-version; s=jan2016.eng; bh=duL6C
        BNGJAdo9BdZiR0/EzBBS5MCdam/J7lXeC0MBUE=; b=T7zGd8pXQfl67snJntDNR
        ptUw4wYD76Y60hkrHOUUEHnyNyfHCnie4lZt8AkwHxVvTLIfmM4bxnb3lI6/yRxq
        cK/XGE+Mbn5lh6gm1dRNnCgnerQcmTFT0tsEf/G4doJzKCnUFMqU8DFQn9ywiNwA
        3z/7yEXnpzlgp2FaaxCB30g2IgZYr4tm9vFdBwvIobqeJbiuJ5kDsK6gdhfGOpRy
        LaIKkX8k/5+t25cb67OWyezrqtF3YMcEisEPTakCwW2OVEiaN+PEiAvpWEW5US1J
        cqyQGFmTvp2tPCVk61o2SNFgeJSMFl6GcMKkN59Ot4RmoOm63n8s/hZvPXkbhEPa
        A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3t0gbxcm7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 00:50:51 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 38DL3Hvl021073
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 19:50:50 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.25])
        by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 3t0m1xhse6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2023 19:50:42 -0400
Received: from usma1ex-dag4mb8.msg.corp.akamai.com (172.27.91.27) by
 usma1ex-dag4mb6.msg.corp.akamai.com (172.27.91.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.25; Wed, 13 Sep 2023 19:50:42 -0400
Received: from usma1ex-dag4mb8.msg.corp.akamai.com ([172.27.91.27]) by
 usma1ex-dag4mb8.msg.corp.akamai.com ([172.27.91.27]) with mapi id
 15.02.1258.025; Wed, 13 Sep 2023 19:50:42 -0400
From:   "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Symbol resolution when text in hugepages
Thread-Topic: Symbol resolution when text in hugepages
Thread-Index: AQHZ5ptoJXbmX9KFXk+orVacilbbkg==
Date:   Wed, 13 Sep 2023 23:50:42 +0000
Message-ID: <2fb5c263fce545b0a5b745e6122fa88e@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.27.164.27]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_18,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=609 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130195
X-Proofpoint-GUID: 0phVr9xSGV2Eq_XNzVP83W6GaUS4c8e1
X-Proofpoint-ORIG-GUID: 0phVr9xSGV2Eq_XNzVP83W6GaUS4c8e1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=589 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309130198
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi all,=A0

We have an application that has its text section backed by hugepages. In ou=
r new build environment the text section of the binary is split up into rea=
d and read/execute sections with offsets into the segment. This is breaking=
 the perf symbol resolution. Previously, everything was in one segment and =
there was no offset, so perf functioned fine. I know we can dump the symbol=
s from readelf into /tmp/perf-PID.map file. I was wondering if anyone has a=
 cleaner solution? I'd appreciate any pointers you have.=20

Thanks
Sri=
