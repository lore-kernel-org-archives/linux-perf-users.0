Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C3EE800C
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjIHOTC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 10:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjIHOTB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 10:19:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC88F1BF5
        for <linux-perf-users@vger.kernel.org>; Fri,  8 Sep 2023 07:18:57 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388EA46R001015;
        Fri, 8 Sep 2023 14:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=77JCQ8Lmwz5Ie23gE/3EVga4oCS+ouD/d2NJY+8oP4A=;
 b=Yrv7MK0i/SGonNRGDAQrolmyiLgJBss9kK0dv6FavMMWl5Pr9hXU9WinFB+urH8SB+GW
 Y6735pcEcD4daKIYnmzvUdiGz4rOebM2sNt2//BEhRE6CDeR07x3UQNDCOATTsRxvSIQ
 KlqOjKpyDvQ5GkEGzX1zaYJLn70iXZLanzoy4HpF2Up9i73KNKPJf/4FeI8qJZWCG6N3
 ZJjlMXrs88dpwftf1fGKb7bbqX4HIxlJn59JKD3T3jmp572kX0kYXeLNSAvEgLJHBhap
 bBpMD6sGON1aPpgqoEMxMhB9bZl/GZW3UoC4Wrag49BiNx3yOpOIT8/H3XbdpV1LWwY8 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t04uw0qey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 14:18:50 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 388EAMs0004508;
        Fri, 8 Sep 2023 14:18:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t04uw0qep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 14:18:50 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 388CRmNw001603;
        Fri, 8 Sep 2023 14:18:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfctcgux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 14:18:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 388EIkEk46334652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 14:18:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4857520049;
        Fri,  8 Sep 2023 14:18:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E1B62004B;
        Fri,  8 Sep 2023 14:18:44 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.123.252])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Sep 2023 14:18:43 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH V2] perf test: Fix parse-events tests to skip parametrized
 events
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1F3D650F-91B5-4570-85D2-A925320BE7AE@linux.ibm.com>
Date:   Fri, 8 Sep 2023 19:48:33 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <298307AE-8AB5-40B6-A9CC-C1DBE720450C@linux.vnet.ibm.com>
References: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
 <1F3D650F-91B5-4570-85D2-A925320BE7AE@linux.ibm.com>
To:     Sachin Sant <sachinp@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QUrJhZwUdGipWa-Nddd0PumYwkCV3Lfq
X-Proofpoint-ORIG-GUID: NF6ozHIsVwxztddr_9GUoBDOzwkxQneB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080130
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 08-Sep-2023, at 11:04 AM, Sachin Sant <sachinp@linux.ibm.com> =
wrote:
>=20
>=20
>=20
>> On 07-Sep-2023, at 10:29 PM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>> Testcase "Parsing of all PMU events from sysfs" parse events for
>> all PMUs, and not just cpu. In case of powerpc, the PowerVM
>> environment supports events from hv_24x7 and hv_gpci PMU which
>> is of example format like below:
>>=20
>> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
>> - hv_gpci/event,partition_id=3D?/
>>=20
>> The value for "?" needs to be filled in depending on system
>> configuration. It is better to skip these parametrized events
>> in this test as it is done in:
>> 'commit b50d691e50e6 ("perf test: Fix "all PMU test" to skip
>> parametrized events")' which handled a simialr instance with
>> "all PMU test".
>>=20
>> Fix parse-events test to skip parametrized events since
>> it needs proper setup of the parameters.
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> Changelog:
>> v1 -> v2:
>> Addressed review comments from Ian. Updated size of
>> pmu event name variable and changed bool name which is
>> used to skip the test.
>>=20
>=20
> The patch fixes the reported issue.
>=20
> 6.2: Parsing of all PMU events from sysfs                          : =
Ok
> 6.3: Parsing of given PMU events from sysfs                        : =
Ok
>=20
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
>=20
> - Sachin

Hi Sachin, Ian

Thanks for testing the patch

Athira


