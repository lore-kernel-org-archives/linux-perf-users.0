Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC061C05027
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Feb 2023 14:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBFOAZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Feb 2023 09:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjBFN7p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Feb 2023 08:59:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD641125BB
        for <linux-perf-users@vger.kernel.org>; Mon,  6 Feb 2023 05:59:17 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316DqL6r018523;
        Mon, 6 Feb 2023 13:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0ZCrXCqr5kA7cgj5nrdH4hjki7+411vIC45X1YAHwck=;
 b=aCk71elYeDzalHOnwldZ+X0CwAjCgwEbkI1ZcejMuBJ7PHBdIMMI7zw3iBYWO4N3WtRM
 Rtqfgg8axSMfrtx9guKInKUA8M1MV6RNkFUKOUTsMaelRt88m9vKnIy/eCbLcokfAZVJ
 1slSuw4yrZGuMAGiPk1ivRRD17P7X5YIFQwLXa0d34Zdn8pMQOguDIZbFB4lo7cqtTIV
 1Q/5If1PRuesfLBLe3rZBNfKTmkr+K1SdxLJSVmOa6x6kMwx70sJapy7sd5oZzAP2zmw
 B2wQQrZd5nhDmcJ0+AoUj5w+BouyVkE1QXIyNQHqxaqCR0EWd0T1fcL0pY0SCTF+nL/z +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1qctfbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:59:00 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316DqieM020900;
        Mon, 6 Feb 2023 13:59:00 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk1qctfar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:59:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3161E5Z2002393;
        Mon, 6 Feb 2023 13:58:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06jfa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 13:58:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316Dwss536700462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 13:58:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73DFF20040;
        Mon,  6 Feb 2023 13:58:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 131E120067;
        Mon,  6 Feb 2023 13:58:52 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.64.42])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Feb 2023 13:58:51 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH 2/2] perf test bpf: Skip test if kernel-debuginfo is not
 present
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Y7bIk77mdE4j8Jyi@kernel.org>
Date:   Mon, 6 Feb 2023 19:28:49 +0530
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>, disgoel@linux.ibm.com
Message-Id: <8B8A7CCE-E007-4C0C-AF1F-17B679F9A86D@linux.vnet.ibm.com>
References: <20230105121742.92249-1-atrajeev@linux.vnet.ibm.com>
 <20230105121742.92249-2-atrajeev@linux.vnet.ibm.com>
 <Y7bIk77mdE4j8Jyi@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e5f9LLreKoBDoVk2ZYLqISharV3D0fa4
X-Proofpoint-ORIG-GUID: uhxaN6PAtBv47TXt2ffDOh4B2DJEmyIv
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302060116
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 05-Jan-2023, at 6:24 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> Em Thu, Jan 05, 2023 at 05:47:42PM +0530, Athira Rajeev escreveu:
>> Perf BPF filter test fails in environment where "kernel-debuginfo"
>> is not installed.
>=20
> I'll apply this to perf/core, for the next merge window, as its more an
> improvement than a fix, i.e. we know why it fails, we're just improving
> the user reporting to make that clear at first sight.
>=20
> - Arnaldo
>=20

Hi Arnaldo,

Just wanted to check when we can have these two patches in perf/core.
I didn't find these in https://git.kernel.org/pub/scm/linux/kernel/git/acme=
/linux.git/?h=3Dtmp.perf/core
Not sure if I missed.

Thanks
Athira

>> Test failure logs:
>> <<>>
>> 42: BPF filter                            :
>> 42.1: Basic BPF filtering                 : Ok
>> 42.2: BPF pinning                         : Ok
>> 42.3: BPF prologue generation             : FAILED!
>> <<>>
>>=20
>> Enabling verbose option provided debug logs, which says debuginfo
>> needs to be installed. Snippet of verbose logs:
>>=20
>> <<>>
>> 42.3: BPF prologue generation                                       :
>> --- start ---
>> test child forked, pid 28218
>> <<>>
>> Rebuild with CONFIG_DEBUG_INFO=3Dy, or install an appropriate debuginfo
>> package.
>> bpf_probe: failed to convert perf probe events
>> Failed to add events selected by BPF
>> test child finished with -1
>> ---- end ----
>> BPF filter subtest 3: FAILED!
>> <<>>
>>=20
>> Here subtest, "BPF prologue generation" failed and
>> logs shows debuginfo is needed. After installing
>> kernel-debuginfo package, testcase passes.
>>=20
>> Subtest "BPF prologue generation" failed because, the "do_test"
>> function returns "TEST_FAIL" without checking the error type
>> returned by "parse_events_load_bpf_obj" function.
>> Function parse_events_load_bpf_obj can also return error of type
>> "-ENODATA" incase kernel-debuginfo package is not installed. Fix this
>> by adding check for -ENODATA error.
>>=20
>> Test result after the patch changes:
>>=20
>> Test failure logs:
>> <<>>
>> 42: BPF filter                 :
>> 42.1: Basic BPF filtering      : Ok
>> 42.2: BPF pinning              : Ok
>> 42.3: BPF prologue generation  : Skip (clang/debuginfo isn't
>> installed or environment missing BPF support)
>>=20
>> Fixes: ba1fae431e74 ("perf test: Add 'perf test BPF'")
>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> ---
>> Note: This is dependent on patch 1:
>> tools/perf: Update the exit error codes in function
>> try_to_find_probe_trace_event
>>=20
>> tools/perf/tests/bpf.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
>> index 17c023823713..6a4235a9cf57 100644
>> --- a/tools/perf/tests/bpf.c
>> +++ b/tools/perf/tests/bpf.c
>> @@ -126,6 +126,10 @@ static int do_test(struct bpf_object *obj, int (*fu=
nc)(void),
>>=20
>> 	err =3D parse_events_load_bpf_obj(&parse_state, &parse_state.list, obj,=
 NULL);
>> 	parse_events_error__exit(&parse_error);
>> +	if (err =3D=3D -ENODATA) {
>> +		pr_debug("Failed to add events selected by BPF, debuginfo package not=
 installed\n");
>> +		return TEST_SKIP;
>> +	}
>> 	if (err || list_empty(&parse_state.list)) {
>> 		pr_debug("Failed to add events selected by BPF\n");
>> 		return TEST_FAIL;
>> @@ -368,7 +372,7 @@ static struct test_case bpf_tests[] =3D {
>> 			"clang isn't installed or environment missing BPF support"),
>> #ifdef HAVE_BPF_PROLOGUE
>> 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test,
>> -			"clang isn't installed or environment missing BPF support"),
>> +			"clang/debuginfo isn't installed or environment missing BPF support"=
),
>> #else
>> 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, "not com=
piled in"),
>> #endif
>> --=20
>> 2.31.1
>=20
> --=20
>=20
> - Arnaldo

