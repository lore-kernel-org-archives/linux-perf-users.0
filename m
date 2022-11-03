Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F99C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Nov 2022 06:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiKCG51 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Nov 2022 02:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCG5T (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Nov 2022 02:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82F1836A
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Nov 2022 23:57:18 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A36pCTq011468;
        Thu, 3 Nov 2022 06:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=sVRK6nDEGoLzroIO2FhoIFQv1+Wda59OiiWXairbzXo=;
 b=V3QXvbbaghZkh6N8EfbiVoKt8chVFgRc9QQaEG62JE54buk6jLbimw6p0L03Zw5JW7L2
 ruaCTsdEjc3uUKhFF18UHUOWsra7nxTq5KaJbgBsbc1NO5TKnMD+MEmL+EIlIEhEF5fL
 6maCX5Vx7RRol8TwITYcmsk3jFLBBZJrjPF3+185xLrdkVjLdqcan+BMCy0hlkeKpSF3
 YfoEYks0nfvE8g1gqcdD54QZHss4q55vWHIzMrEaw/B8DAn3FMbvC2VV8roKJyDviN0V
 FHnOIm2/n8d0P6M8hPptyGkpCSOtvepl51URvCCC7tBG64aulLhVr3pSeVKxgc7UTjz6 Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km8r6850n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 06:57:11 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A36qv0I016910;
        Thu, 3 Nov 2022 06:57:11 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3km8r684yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 06:57:11 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A36oqmD029461;
        Thu, 3 Nov 2022 06:57:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kgueje5g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 06:57:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A36v5eQ39977456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 06:57:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DA024203F;
        Thu,  3 Nov 2022 06:57:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8506C42041;
        Thu,  3 Nov 2022 06:57:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.108.240])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Nov 2022 06:57:03 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] perf test bpf: Skip test if kernel-debuginfo is not
 present
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20221028154230.140709-1-kjain@linux.ibm.com>
Date:   Thu, 3 Nov 2022 12:27:01 +0530
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, disgoel@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7B7E3F1-161D-4B1A-A4FE-E4A77EE06F1A@linux.vnet.ibm.com>
References: <20221028154230.140709-1-kjain@linux.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NwhlF43BXDXYZsOXq-EusgJzeKd_3ktI
X-Proofpoint-GUID: Y7MEHUJ2fXWIW47ILn2NCnX8DgCz6jf1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030046
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 28-Oct-2022, at 9:12 PM, Kajol Jain <kjain@linux.ibm.com> wrote:
>=20
> Perf BPF filter test fails in environment where "kernel-debuginfo"
> is not installed.
>=20
> Test failure logs:
> <<>>
> 42: BPF filter                            :
> 42.1: Basic BPF filtering                 : Ok
> 42.2: BPF pinning                         : Ok
> 42.3: BPF prologue generation             : FAILED!
> <<>>
>=20
> Enabling verbose option provided debug logs, which says debuginfo
> needs to be installed. Snippet of verbose logs:
>=20
> <<>>
> 42.3: BPF prologue generation                                       :
> --- start ---
> test child forked, pid 28218
> <<>>
> Rebuild with CONFIG_DEBUG_INFO=3Dy, or install an appropriate =
debuginfo
> package.
> bpf_probe: failed to convert perf probe events
> Failed to add events selected by BPF
> test child finished with -1
> ---- end ----
> BPF filter subtest 3: FAILED!
> <<>>
>=20
> Here subtest, "BPF prologue generation" failed and
> logs shows debuginfo is needed. After installing
> kernel-debuginfo package, testcase passes.
>=20
> Subtest "BPF prologue generation" failed because, the "do_test"
> function returns "TEST_FAIL" without checking the error type
> returned by "parse_events_load_bpf_obj" function.
> Function parse_events_load_bpf_obj can also return error of type
> "-ENOENT" incase kernel-debuginfo package is not installed. Fix this
> by adding check for -ENOENT error.
>=20
> Test result after the patch changes:
>=20
> Test failure logs:
> <<>>
> 42: BPF filter                 :
> 42.1: Basic BPF filtering      : Ok
> 42.2: BPF pinning              : Ok
> 42.3: BPF prologue generation  : Skip (clang/debuginfo isn't
> installed or environment missing BPF support)
>=20
> Fixes: ba1fae431e74bb42 ("perf test: Add 'perf test BPF'")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
> tools/perf/tests/bpf.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 17c023823713..57cecadc1da2 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -126,6 +126,10 @@ static int do_test(struct bpf_object *obj, int =
(*func)(void),
>=20
> 	err =3D parse_events_load_bpf_obj(&parse_state, =
&parse_state.list, obj, NULL);
> 	parse_events_error__exit(&parse_error);
> +	if (err =3D=3D -ENOENT) {
> +		pr_debug("Failed to add events selected by BPF, =
debuginfo package not installed\n");
> +		return TEST_SKIP;
> +	}

Hi Kajol,

Here, you have used ENOENT to skip the test. But there could be other =
places in the code path for =E2=80=9Cparse_events_load_bpf_obj=E2=80=9D
which also returns ENOENT. In that case, for any exit that returns =
ENOENT, test will get skipped.

Can we look at the logs, example we have this in commit logs:

	Rebuild with CONFIG_DEBUG_INFO=3Dy, or install an appropriate =
debuginfo
	package.

so as to decide whether to skip for debug info ?

Thanks
Athira

> 	if (err || list_empty(&parse_state.list)) {
> 		pr_debug("Failed to add events selected by BPF\n");
> 		return TEST_FAIL;
> @@ -368,7 +372,7 @@ static struct test_case bpf_tests[] =3D {
> 			"clang isn't installed or environment missing =
BPF support"),
> #ifdef HAVE_BPF_PROLOGUE
> 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test,
> -			"clang isn't installed or environment missing =
BPF support"),
> +			"clang/debuginfo isn't installed or environment =
missing BPF support"),
> #else
> 	TEST_CASE_REASON("BPF prologue generation", bpf_prologue_test, =
"not compiled in"),
> #endif
> --=20
> 2.31.1
>=20

