Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB9EB64DD
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 06:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHGGKu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 02:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGGKt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 02:10:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598810F9
        for <linux-perf-users@vger.kernel.org>; Sun,  6 Aug 2023 23:10:48 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37765ZII001845;
        Mon, 7 Aug 2023 06:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=J1saXD6lKUsQF9f0FBv7MqIMAgdIE5q/6fO5Zb6lFuM=;
 b=ZxFkqhU9SucuJEark9mBFAz6QlSOGoDxYNt1sTWMP2c+bCceWVVz/EJ3L1oTV6F9cJiq
 ZJNctLJVF6MTG/sm1W1OoaT8gDnSY3Xc4WEokimgFdx769GYtAQWvYuVliobYebW04uh
 hQiluMVWHEk82uerJ6VZc21R4YMTQLjV/9GKqL1/bUrOMRLQfZkMpJSBkE/mwMfP8WAG
 awnD1JSPHfF2hmWKAZE1Khl2TGlptu9eOC/BT9miAuJ/CLTO8EaD368i/NOji6BKyFIu
 jFBoGp8+iLyQHdsA4ZAqQsJQPmLaNp5kU3qkiKuFeMuZ8RWggARKKnvlwgD3/deT32Dq aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sau1s0616-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:10:35 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37765lAZ002651;
        Mon, 7 Aug 2023 06:10:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sau1s05tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:10:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3774coxe001619;
        Mon, 7 Aug 2023 06:10:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa2yjj4qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:10:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3776ASKr20841130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 06:10:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EAB520049;
        Mon,  7 Aug 2023 06:10:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C736E2004B;
        Mon,  7 Aug 2023 06:10:26 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.241.238])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Aug 2023 06:10:26 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] perf test: Fix parse-events tests to skip parametrized
 events
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20230807045016.23409-1-atrajeev@linux.vnet.ibm.com>
Date:   Mon, 7 Aug 2023 11:40:16 +0530
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A776945C-DDE0-4A12-960E-50641D237C6F@linux.ibm.com>
References: <20230807045016.23409-1-atrajeev@linux.vnet.ibm.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rSC2f4S_ChqHxkz94Re4MW6ghsvcgIVt
X-Proofpoint-GUID: 2xWYGe8x1HyYwmoR9QX3ADz9UW6E60DZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070055
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 07-Aug-2023, at 10:20 AM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
> Testcase "Parsing of all PMU events from sysfs" parse events for
> all PMUs, and not just cpu. In case of powerpc, the PowerVM
> environment supports events from hv_24x7 and hv_gpci PMU which
> is of example format like below:
>=20
> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
> - hv_gpci/event,partition_id=3D?/
>=20
> The value for "?" needs to be filled in depending on system
> configuration. It is better to skip these parametrized events
> in this test as it is done in:
> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
> parametrized events")' which handled a simialr instance with
> "all PMU test".
>=20
> Fix parse-events test to skip parametrized events since
> it needs proper setup of the parameters.
>=20
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> =E2=80=94

Thanks Athira for the fix. With this fix applied the reported problem
Is fixed.

6.1: Test event parsing                                            : Ok
  6.2: Parsing of all PMU events from sysfs             : Ok
  6.3: Parsing of given PMU events from sysfs        : Ok

Tested-by: Sachin Sant <sachinp@linux.ibm.com>

- Sachin
