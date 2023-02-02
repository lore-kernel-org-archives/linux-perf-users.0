Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601D6C64EC3
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Feb 2023 04:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBBERa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 23:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBBER3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 23:17:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12742761CD
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 20:17:27 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3123pP7F003640;
        Thu, 2 Feb 2023 04:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=/POkZCafX/DOVFHNoPLmxpEqGJOiPJ/P+NyH+2fCYIA=;
 b=LlrS16CEc3Wr0dE8QXh6YRbSkAvsaKFJU9WPvDbeCj0I9XF7xGow/HFjj7ReON8IaOTl
 Ko0CQhs5qdNFgwWfoL+VmM4+bh1E0TBff5xDoAauziLH6HUi/dvzfgkbZPmj5WJkuRyc
 EbXGwgUMPqMs1yMI3yUU6UXzvSsJS160ecdsA/zlfa4gmap3e1XyBFfUV5MHefKoL191
 b2Dhi9+V3AnA2sH5u0XtdCbD3YjrS6itx2i9uVDJEWiS80drcvljsgOi42HTfNybwr0+
 uiOiwomNQwEOTuctzzHeI1mI2exIQT3scxRRm76wSrKpw3PLo0+wvZUzrMfESPDyZVre tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ng5mx0g3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 04:17:12 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3123sReB012012;
        Thu, 2 Feb 2023 04:17:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ng5mx0g2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 04:17:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3123LqSs019551;
        Thu, 2 Feb 2023 04:17:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ncvt7m2ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 04:17:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3124H57O42336574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Feb 2023 04:17:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DB0D20043;
        Thu,  2 Feb 2023 04:17:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C5922004B;
        Thu,  2 Feb 2023 04:17:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.7.19])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Feb 2023 04:17:02 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/2] tests/shell: Add check for perf data file in
 record+probe_libc_inet_pton test
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y9sGlo2tnSvYX2uF@kernel.org>
Date:   Thu, 2 Feb 2023 09:47:00 +0530
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6130F47D-EE25-40E4-96DD-472FA6EDD01B@linux.vnet.ibm.com>
References: <20230201180421.59640-1-atrajeev@linux.vnet.ibm.com>
 <Y9sGlo2tnSvYX2uF@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fMSPCMnb4U57PUW5f2zkgGoHj0fnb0rf
X-Proofpoint-GUID: bHTZo3bU1NiJy7QrL14HQPxK9iMR_txx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302020036
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 02-Feb-2023, at 6:10 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Wed, Feb 01, 2023 at 11:34:20PM +0530, Athira Rajeev escreveu:
>> "probe libc's inet_pton & backtrace it with ping" test
>> installs a uprobe and uses perf record/script to check
>> the backtrace. Currently even if the "perf record" fails,
>> the test reports success. Logs below:
>>=20
>> # ./perf test -v "probe libc's inet_pton & backtrace it with ping"
>> 81: probe libc's inet_pton & backtrace it with ping                 :
>> --- start ---
>=20
> Please add spaces before --- as this separates the commit log message
> from the patch and ends up chopped up when I use git-am.
>=20
> I'm fixing it now.

Hi Arnaldo,

Sorry for that, will take care in next patches and thanks for fixing it

Athira
>=20
> - Arnaldo
>=20
>> test child forked, pid 304211
>> failed to open /tmp/perf.data.Btf: No such file or directory
>> test child finished with 0
>> ---- end ----
>> probe libc's inet_pton & backtrace it with ping: Ok
>>=20
>> Fix this by adding check for presence of perf.data file
>> before proceeding with "perf script".
>>=20
>> With the patch changes, test reports fail correctly.
>>=20
>> # ./perf test -v "probe libc's inet_pton & backtrace it with ping"
>> 81: probe libc's inet_pton & backtrace it with ping                 :
>> --- start ---
>> test child forked, pid 304358
>> FAIL: perf record failed to create "/tmp/perf.data.Uoi"
>> test child finished with -1
>> ---- end ----
>> probe libc's inet_pton & backtrace it with ping: FAILED!
>>=20
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh =
b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> index 57e7a6a470c9..08cdd902d0cf 100755
>> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
>> @@ -58,6 +58,11 @@ trace_libc_inet_pton_backtrace() {
>> 	perf_data=3D`mktemp -u /tmp/perf.data.XXX`
>> 	perf_script=3D`mktemp -u /tmp/perf.script.XXX`
>> 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c =
1 ::1 > /dev/null 2>&1
>> +	# check if perf data file got created in above step.
>> +	if [ ! -e $perf_data ]; then
>> +		printf "FAIL: perf record failed to create \"%s\" \n" =
"$perf_data"
>> +		return 1
>> +	fi
>> 	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > =
$perf_script
>>=20
>> 	exec 3<$perf_script
>> --=20
>> 2.39.0
>>=20
>=20
> --=20
>=20
> - Arnaldo

