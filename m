Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC8EE57C5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Sep 2023 05:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjIHFfD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Sep 2023 01:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIHFfC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Sep 2023 01:35:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A219AB
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Sep 2023 22:34:58 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3884dFNv030246;
        Fri, 8 Sep 2023 05:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=IojGGN4k9PhjOTjGTzYF5mBqzccJUXOLnP6JomWQxyY=;
 b=SFD9zNUy+cgxSbXtBnR9nuY36hbHjyvV4TyV7GzJP4bzzwV1egU36P/t1DHr3IUcMNou
 r/CsJpLysyC1drxN0plmYUXtLXKQIj/AAnRmG69/UHikulmk5jOFcf73vdPW3ALyUT2x
 PLPM60P3r6COonKFaup8vTTysjS1GEBeIDNIBEEJeshEnZur2jIJw8i18U0pBDicZhoq
 gUG+GDEsX26WZeFCFd7D36r6GwWbKC/RE5igg5kvBTmAcIDIh6HmGC9Z1mg90yMEO5Se
 H/TNA4w6vZf6FhqCdFwZYSk/ceEOXxa8duf6Q7T7n4bBuzo8+E9FDkHSa9jWHVo8UGjo Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sys0j4u14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 05:34:32 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3885GKaQ026040;
        Fri, 8 Sep 2023 05:34:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sys0j4u09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 05:34:32 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3883mVSk001624;
        Fri, 8 Sep 2023 05:34:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfct9rpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 05:34:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3885YSe846334228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 05:34:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA33B2004B;
        Fri,  8 Sep 2023 05:34:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CE1720040;
        Fri,  8 Sep 2023 05:34:26 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.241.220])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  8 Sep 2023 05:34:26 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH V2] perf test: Fix parse-events tests to skip parametrized
 events
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
Date:   Fri, 8 Sep 2023 11:04:14 +0530
Cc:     acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F3D650F-91B5-4570-85D2-A925320BE7AE@linux.ibm.com>
References: <20230907165933.36442-1-atrajeev@linux.vnet.ibm.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ncwsrs04b4s9ZRI7YTYEROvyP4bbozc5
X-Proofpoint-ORIG-GUID: 6YcKZ6TZ9YDNIE33NRW5NF3B0g7Xvwaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_02,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080046
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 07-Sep-2023, at 10:29 PM, Athira Rajeev =
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
> ---
> Changelog:
> v1 -> v2:
> Addressed review comments from Ian. Updated size of
> pmu event name variable and changed bool name which is
> used to skip the test.
>=20

The patch fixes the reported issue.

6.2: Parsing of all PMU events from sysfs                          : Ok
6.3: Parsing of given PMU events from sysfs                        : Ok

Tested-by: Sachin Sant <sachinp@linux.ibm.com>

- Sachin=
