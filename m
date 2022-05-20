Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FD2C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 May 2022 06:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiETGfg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 May 2022 02:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345899AbiETGfd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 May 2022 02:35:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88DB14CA21
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 23:35:32 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K3gj6D024642;
        Fri, 20 May 2022 06:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=v9YYjzHU11NbkyrnI5KQ5A1goiZHidYQ+j6W7mt2Rr8=;
 b=bP1qSjNUOAOWqLMBGOxLuy2Z8DS+8C660nu4vK05w2wB63pSF96nrwClFuBXjhtjIuBM
 5YDTjixSFzHdI15IRGnoKbtEIyraXQOkPIRNkPYoIQU/sfA3U+O+nFtf3x6zn3jkqQSQ
 +bU2kzc/Y91JqAge2BrNtXbCzt90VumVb3OPuG+7ssbRrVlCZQd8SSPubBD5zvNGGaXE
 xwg8kHMkTyo2qSK4VtnpnTjt9BD3NCID4GxKJT5GmnniOEMjtHxc4p06gRrmpIqHZvLx
 qzSX/tJ25ijEihM/rTvh1sKRyZdSWtOmCbVcOX7Z/aQ7ZSgPshhe3kVwU6hT26dU+pjP bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g63a92rqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 06:35:24 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24K6Dkp3014087;
        Fri, 20 May 2022 06:35:23 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g63a92rq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 06:35:23 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24K6R3iU000696;
        Fri, 20 May 2022 06:35:21 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3g2428q3fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 06:35:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24K6ZHEP51970470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 06:35:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E87652050;
        Fri, 20 May 2022 06:35:17 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.163.31.125])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 558D05204F;
        Fri, 20 May 2022 06:35:12 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH V2] tools/perf/test: Fix perf all PMU test to skip
 hv_24x7/hv_gpci tests on powerpc
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <CAP-5=fXrtTe=6-z8-OMzG60XZmA92nHEhc94+NyCJK-ZPDekPQ@mail.gmail.com>
Date:   Fri, 20 May 2022 12:05:08 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.vnet.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <93469FA8-07C5-4710-953C-5C74B197FAE3@linux.vnet.ibm.com>
References: <20220519154324.12531-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fXrtTe=6-z8-OMzG60XZmA92nHEhc94+NyCJK-ZPDekPQ@mail.gmail.com>
To:     Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ohRuhBXWmGj7TmEN1k3g7ss7qg6GbSH
X-Proofpoint-ORIG-GUID: KNckq4WJro7mebAgbYypzXhBB0z6GBRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_02,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200048
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 20-May-2022, at 12:15 AM, Ian Rogers <irogers@google.com> wrote:
>=20
> On Thu, May 19, 2022 at 8:43 AM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
>>=20
>> "perf all PMU test" picks the input events from
>> "perf list --raw-dump pmu" list and runs "perf stat -e"
>> for each of the event in the list. In case of powerpc, the
>> PowerVM environment supports events from hv_24x7 and hv_gpci
>> PMU which is of example format like below:
>> - hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
>> - hv_gpci/event,partition_id=3D?/
>>=20
>> The value for "?" needs to be filled in depending on
>> system and respective event. CPM_ADJUNCT_INST needs have
>> core value and domain value. hv_gpci event needs partition_id.
>> Similarly, there are other events for hv_24x7 and hv_gpci
>> having "?" in event format. Hence skip these events on powerpc
>> platform since values like partition_id, domain is specific
>> to system and event.
>>=20
>> Fixes: 3d5ac9effcc6 ("perf test: Workload test of all PMUs")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> Changelog:
>> v1 -> v2:
>> Instead of checking for platform, used the pmu name
>> ie, hv_24x7 and hv_gpci to skip the test since this
>> pmu name is specific to powerpc as suggested by
>> Michael Ellerman.
>>=20
>> tools/perf/tests/shell/stat_all_pmu.sh | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>=20
>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh =
b/tools/perf/tests/shell/stat_all_pmu.sh
>> index b30dba455f36..7d046bb8a7b9 100755
>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
>> @@ -5,6 +5,16 @@
>> set -e
>>=20
>> for p in $(perf list --raw-dump pmu); do
>> +  # In powerpc, skip the events for hv_24x7 and hv_gpci.
>> +  # These events needs input values to be filled in for
>> +  # core, chip, patition id based on system.
> nit: s/patition/partition/
>> +  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=3D?,core=3D?/
>=20
> I've no problem with this patch, we may need to do similar for other
> architectures. For this specific problem I wonder if rather than
> skipping the event the event can be fixed with domain and core set to
> 1 ? This would provide a little additional coverage.

Hi Ian,

Thanks for review. Yeah, we looked at the option of having default value =
of 0.
But then we could still fail due to the partition privilege. These PMU =
counters expose per-core and per-chip
data and partition needs additional privileges to get these pmu data.
Hence the skip :)

Thanks
Athira

>=20
> Thanks,
> Ian
>=20
>> +  # hv_gpci/event,partition_id=3D?/
>> +  # Hence skip these events for ppc.
>> +  if echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then
>> +    echo "Skipping: Event '$p' in powerpc"
>> +    continue
>> +  fi
>>   echo "Testing $p"
>>   result=3D$(perf stat -e "$p" true 2>&1)
>>   if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q =
"<not supported>" ; then
>> --
>> 2.35.1

