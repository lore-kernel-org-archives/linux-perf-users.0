Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A5AC64EC3
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Feb 2023 04:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBBESL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 23:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjBBESI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 23:18:08 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA4559B
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 20:17:59 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3124CitY015373;
        Thu, 2 Feb 2023 04:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=UJyx33X2mEFICKmRbx6pJHu3630595wm5XGur++GdNw=;
 b=LEC/R8+vpe2FLWoRKJrfK9WkXmPCZ/h44Mtd2gS+sW3tjGD5dN+rnTgp02c2cSfgXkvV
 /xsSyidRis01UMVzLAWqMa+GiJebLbYVdpfLpQ/B9Z7jS1uVFD78gjyMoQd8uCtXBf76
 V8dYx/d8eZkCflIYtEf7zvIkMTq0W3JJEqb+7OjL3HnLiavJ9UWpLZ6htLocFPmB57Av
 OYMBBAcXMC12X6ksXrhUVO8zYgP3SERsngi8HWzXVZD3SZ64RjMdsjXRis5g2owl1Yg6
 6w5UAc6bVKyvHmospTxGTXlvBxJcunrg1WTt4+5LNr7n4kR9Iv/9uumtsqskItnQzuT4 HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ng5ga8m4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 04:17:41 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3124FUHG020865;
        Thu, 2 Feb 2023 04:17:41 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ng5ga8m43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 04:17:41 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 311Kddn1013277;
        Thu, 2 Feb 2023 04:17:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ncvtydnp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 04:17:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3124HZaS47251948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 04:17:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F50120043;
        Thu,  2 Feb 2023 04:17:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFA3020040;
        Thu,  2 Feb 2023 04:17:32 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.7.19])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Feb 2023 04:17:32 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] tools/perf: Fix usage of perf probe when libtraceevent is
 missing
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y9sIyTLHssijIFLT@kernel.org>
Date:   Thu, 2 Feb 2023 09:47:32 +0530
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, james.clark@arm.com,
        mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <2874491F-C1DA-4EFB-96CC-7772D6A7A61A@linux.vnet.ibm.com>
References: <20230131134748.54567-1-atrajeev@linux.vnet.ibm.com>
 <Y9sIyTLHssijIFLT@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XewyGZcKMJuUQPijdG0WMAishWfPMMwF
X-Proofpoint-ORIG-GUID: WyV9akE3EBXrSvQQcDIM-TgoLByYfhcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020031
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 02-Feb-2023, at 6:20 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Tue, Jan 31, 2023 at 07:17:48PM +0530, Athira Rajeev escreveu:
>> While parsing the tracepoint events in parse_events_add_tracepoint()
>> function, code checks for HAVE_LIBTRACEEVENT support. This is needed
>> since libtraceevent is necessary for tracepoint. But while adding
>> probe points, check for LIBTRACEEVENT is not done in case of perf =
probe.
>> Hence, in environment with missing libtraceevent-devel, it is
>> observed that adding a probe point shows below message though it
>> can't be used via perf record.
>=20
> Thanks, applied.
>=20
> - Arnaldo

Thanks Arnaldo

Athira
>=20
>=20
>> Example:
>> Adding probe point:
>> 	./perf probe 'vfs_getname=3Dgetname_flags:72 =
pathname=3Dresult->name:string'
>> 	Added new event:
>> 	  probe:vfs_getname    (on getname_flags:72 with =
pathname=3Dresult->name:string)
>>=20
>> 	You can now use it in all perf tools, such as:
>>=20
>> 		perf record -e probe:vfs_getname -aR sleep 1
>>=20
>> But trying perf record:
>> 	./perf  record -e probe:vfs_getname -aR sleep 1
>> 	event syntax error: 'probe:vfs_getname'
>> 				\___ unsupported tracepoint
>> 	libtraceevent is necessary for tracepoint support
>> 	Run 'perf list' for a list of valid events
>>=20
>> The builtin tool like perf record needs libtraceevent to
>> parse tracefs. But still the probe can be used by enabling
>> via tracefs. Patch fixes the probe usage message to the user
>> based on presence of libtraceevent. With the fix,
>>=20
>> # ./perf probe 'pmu:myprobe=3Dschedule'
>> Added new event:
>>   pmu:myprobe          (on schedule)
>>=20
>> perf is not linked with libtraceevent, to use the new probe you can =
use tracefs:
>>=20
>> 	cd /sys/kernel/tracing/
>> 	echo 1 > events/pmu/myprobe/enable
>> 	echo 1 > tracing_on
>> 	cat trace_pipe
>> 	Before removing the probe, echo 0 > events/pmu/myprobe/enable
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/builtin-probe.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
>> index ed73d0b89ca2..e72f6cea76f7 100644
>> --- a/tools/perf/builtin-probe.c
>> +++ b/tools/perf/builtin-probe.c
>> @@ -383,9 +383,18 @@ static int perf_add_probe_events(struct =
perf_probe_event *pevs, int npevs)
>>=20
>> 	/* Note that it is possible to skip all events because of =
blacklist */
>> 	if (event) {
>> +#ifndef HAVE_LIBTRACEEVENT
>> +		pr_info("\nperf is not linked with libtraceevent, to use =
the new probe you can use tracefs:\n\n");
>> +		pr_info("\tcd /sys/kernel/tracing/\n");
>> +		pr_info("\techo 1 > events/%s/%s/enable\n", group, =
event);
>> +		pr_info("\techo 1 > tracing_on\n");
>> +		pr_info("\tcat trace_pipe\n");
>> +		pr_info("\tBefore removing the probe, echo 0 > =
events/%s/%s/enable\n", group, event);
>> +#else
>> 		/* Show how to use the event. */
>> 		pr_info("\nYou can now use it in all perf tools, such =
as:\n\n");
>> 		pr_info("\tperf record -e %s:%s -aR sleep 1\n\n", group, =
event);
>> +#endif
>> 	}
>>=20
>> out_cleanup:
>> --=20
>> 2.39.0
>>=20
>=20
> --=20
>=20
> - Arnaldo

