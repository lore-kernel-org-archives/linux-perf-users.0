Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B3EB64D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjFNJhS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjFNJhR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 05:37:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC7BDC
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 02:37:16 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E9XsNM026222;
        Wed, 14 Jun 2023 09:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=q3yUkZ+IiAXQeU9eIs/vZJfUNIBVVesrMKr1FDx0po0=;
 b=SeGIj/c+Zp+UHrxGxamY0N9sNGB5v9XxG6xHRjZCJwN4Rjv+n009RnGjt+eOEV5X1Oem
 T0y2jfBf+tWYHsHz26KLXxyr+MV3u9tma6zbpnhUQ3fImS131HKygxiwNu87rXsZ5ZG2
 HQg+rRJIGBYNtEh5pbIVxs0Fz7sgwKd1r2V0EXpIKK90Zjznb7j3zn8ymUnRexNTLKPu
 2+smEO7T5Jn4u0O+tQY4K6cVaFtLg1PfIZoP9W9ovyn7M0S6ljjtQiNSRn9nKFMBBBEV
 CbzTGxiM5bDfmOGdOvNZjVaY9meqjucORwqpOEIyHxYV8fPIOh1pi2Vsk4ibxXjZA+Jd UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ay3ga92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 09:37:05 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35E9a0dC012215;
        Wed, 14 Jun 2023 09:37:05 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r7ay3ga71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 09:37:05 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35E6sfBj015633;
        Wed, 14 Jun 2023 09:32:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r4gt4t209-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 09:32:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35E9Vxwh34996590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 09:31:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B0492004F;
        Wed, 14 Jun 2023 09:31:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0114A20040;
        Wed, 14 Jun 2023 09:31:57 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.215.188])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 14 Jun 2023 09:31:56 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH 00/17] tool/perf/test: Fix shellcheck coding/formatting
 issues of test shell scripts
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZIjSxwyna2ExW8JQ@kernel.org>
Date:   Wed, 14 Jun 2023 15:01:44 +0530
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.vnet.ibm.com
Message-Id: <53B7D823-1570-4289-A632-2205EE2B522C@linux.vnet.ibm.com>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <ZIjSxwyna2ExW8JQ@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bvxO6Tq66AEUSBCuuPSRRRqVUGB7td_d
X-Proofpoint-ORIG-GUID: 2mbZJoUs3v9w5D-FVmw1tYvwc7OdjRLp
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140081
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 14-Jun-2023, at 2:04 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> Em Tue, Jun 13, 2023 at 10:11:28PM +0530, Athira Rajeev escreveu:
>> Patchset covers a set of fixes for coding/formatting issues observed whi=
le
>> running shellcheck tool on the perf test shell scripts. Shellcheck is a =
static
>> analysis tool that can find semantic/syntax bugs in the shell scripts.
>=20
> Thanks, applied the series.

Hi,

Thanks Arnaldo for picking up the patchset.
We will check and resubmit patch 6.

Thanks
Athira
>=20
> - Arnaldo
>=20
>> Patches 1-14 fixes the issues found with shellcheck. Patch 15, 16
>> and patch 17 address a fix in task_analyzer test.
>>=20
>> This cleanup is a pre-requisite to include a build option for shellcheck
>> discussed here: https://www.spinics.net/lists/linux-perf-users/msg25553.=
html
>> Also this is first set of patches. There will be one more set which will
>> include build option for shellcheck as discussed in the mail thread.
>>=20
>> Abhirup Deb (2):
>>  tools/perf/tests: fix test_arm_spe.sh signal case issues
>>  perf/tests/shell: fix shellscript errors for lock_contention.sh
>>=20
>> Aboorva Devarajan (1):
>>  tools/perf/tests: Fix shellcheck issues in test_task_analyzer.sh file
>>=20
>> Aditya Gupta (3):
>>  perf tests task_analyzer: fix bad substitution ${$1}
>>  perf tests task_analyzer: print command on failure
>>  perf tests task_analyzer: skip tests if no libtraceevent support
>>=20
>> Akanksha J N (1):
>>  tools/perf/tests: Fix shellcheck warnings for
>>    trace+probe_vfs_getname.sh
>>=20
>> Anushree Mathur (1):
>>  perf/tests/shell : Shellcheck fixes for perf test
>>    "test_arm_coresight.sh"
>>=20
>> Barnali Guha Thakurata (1):
>>  tools/perf/tests/shell/stat_all_metrics: Fix shellcheck warning SC2076
>>    in stat_all_metrics.sh
>>=20
>> Disha Goel (1):
>>  tools/perf/tests: fix shellcheck warning for stat+json_output
>>=20
>> Geetika (1):
>>  tools/perf/tests: Fix all POSIX sh warnings in perf shell test
>>    test_brstack.sh
>>=20
>> Korrapati Likhitha (1):
>>  tools/perf/tests: Fix shellcheck warnings for stat+csv_output
>>=20
>> Samir Mulani (1):
>>  tools/perf/tests: fixed shellcheck warnings for perf shell scripts
>>=20
>> Shirisha G (1):
>>  tools/perf/tests: fix shellcheck warnings for daemon.sh
>>=20
>> Sourabh Jain (1):
>>  perf: get rid of unused import
>>=20
>> Spoorthy S (2):
>>  shellcheck : fixing signal names and adding double quotes for
>>    expression in test_arm_callgraph_fp
>>  tools/perf/tests: Fix all POSIX sh warnings in stat+shadow_stat.sh
>>=20
>> .../scripts/python/arm-cs-trace-disasm.py     |   1 -
>> tools/perf/tests/shell/buildid.sh             |  12 +-
>> tools/perf/tests/shell/daemon.sh              | 113 ++++++++++++------
>> tools/perf/tests/shell/lock_contention.sh     |  70 +++++------
>> .../shell/record+probe_libc_inet_pton.sh      |   6 +-
>> .../shell/record+script_probe_vfs_getname.sh  |   4 +-
>> tools/perf/tests/shell/stat+csv_output.sh     |   4 +-
>> tools/perf/tests/shell/stat+json_output.sh    |   2 +-
>> tools/perf/tests/shell/stat+shadow_stat.sh    |   4 +-
>> tools/perf/tests/shell/stat_all_metrics.sh    |   6 +-
>> .../perf/tests/shell/test_arm_callgraph_fp.sh |   6 +-
>> tools/perf/tests/shell/test_arm_coresight.sh  |   6 +-
>> tools/perf/tests/shell/test_arm_spe.sh        |   2 +-
>> tools/perf/tests/shell/test_brstack.sh        |  12 +-
>> tools/perf/tests/shell/test_task_analyzer.sh  |  98 ++++++++-------
>> .../tests/shell/trace+probe_vfs_getname.sh    |   6 +-
>> 16 files changed, 203 insertions(+), 149 deletions(-)
>>=20
>> --=20
>> 2.39.1
>>=20
>=20
> --=20
>=20
> - Arnaldo


