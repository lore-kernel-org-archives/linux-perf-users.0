Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C51FA8
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 06:02:52 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E311A7
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:02:49 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38U5BL1M021854;
	Sat, 30 Sep 2023 06:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=/q+Yt1gwlDGfoo77DfjiZsIwixQ5EIAb5kLFFfYjAUQ=;
 b=sN22dCf4TWjFuUQ2EpHJy2HDYHTL7HvP3mgm4NL0FKoaKyn0UISyoKZ9XUGx109COx6m
 K3kojJFMQhJe1a5F95JEImJl6eKKa3kP9w/0QHc5XmJ2JlGlv5Bq5vkAAEbKWYlNXbOv
 QqbHiVnOTqpBWfaNbNO1wrzGH+q7r3Q1TupyrQOdlXmzxh88eZNVejycBA3tYCmEzaGz
 muHex0m49m/CQqhJhWidd5OhbQH+iwiS8Bx0oj4Znmh4CdPYsqS+ac2leJI7kTv2mJQs
 P9HPB5WLmGpsAii3CfJzJF8vCCGGUAtsGSMLm9rzTSTSPB27oXatXFq2fKCf7y9UqS58 kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3techf9j17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Sep 2023 06:02:36 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38U5ud4N005940;
	Sat, 30 Sep 2023 06:02:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3techf9j11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Sep 2023 06:02:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38U3EaBe008427;
	Sat, 30 Sep 2023 06:02:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtjntf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Sep 2023 06:02:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38U62Wwb21562034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Sep 2023 06:02:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E54452007A;
	Sat, 30 Sep 2023 06:02:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9CDF2010F;
	Sat, 30 Sep 2023 06:02:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.118.116])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 30 Sep 2023 06:02:03 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH V3] perf test: Fix parse-events tests to skip parametrized
 events
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAM9d7ciNutXBM1LHMfkjLPKiT=8b0TMfiTRkn9w4=Tw53ACUNw@mail.gmail.com>
Date: Sat, 30 Sep 2023 11:31:51 +0530
Cc: Ian Rogers <irogers@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00BF2AA1-F414-47A6-AAC4-2FB2CECA563B@linux.vnet.ibm.com>
References: <20230927181703.80936-1-atrajeev@linux.vnet.ibm.com>
 <CAM9d7ciNutXBM1LHMfkjLPKiT=8b0TMfiTRkn9w4=Tw53ACUNw@mail.gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W-FEkDnY3EsnkSVDdOFMSb7XKQ4bPppz
X-Proofpoint-ORIG-GUID: kdE4cJu6jz6WYbMA_oqmIVq3VplAc_bf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309300048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 30-Sep-2023, at 11:23 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Wed, Sep 27, 2023 at 11:17=E2=80=AFAM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
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
>> Tested-by: Ian Rogers <irogers@google.com>
>> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
>> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
>=20
> Applied to perf-tools-next, thanks!

Thanks Namhyung,

Athira


