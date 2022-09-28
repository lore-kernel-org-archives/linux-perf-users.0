Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24726C6FA8E
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Sep 2022 14:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiI1O2L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Sep 2022 10:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiI1O2J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Sep 2022 10:28:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E19AB1A0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Sep 2022 07:28:06 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SELFUm011178;
        Wed, 28 Sep 2022 14:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=Zxzxe4yecrWpC1bpeLYg9cJI/D/6HoNdIOzYrSPuvZg=;
 b=IiQnStZ45fOqhezOazmtIF6JYsTctGDt54gzFy+D3oplRxaNmOqBjhW/DJbUeekhD0/I
 CQaqhcJ7gdedctyPEuu0QSiQjhC2bpXl0Z/4gWrHSGYLhl4DLHgblU5e2hCqpHciBWLX
 ha8AbGQnLeZFrV2B+npikGLdqhnn3JWJ0S/wkdZEPbJM9rjNjs995hNWqPfX0MBrdZAE
 IzzCJaw8UsNhfSKrchW0WxJLixhxt1TDoiHimI72K2MmUUITsnH29Rwjbk36R5NesJuJ
 gK4Zn1Nl+x63hM06TLIPSmmp+graXTwNOC4h/LP0WPmtXCKLh5Y5yVFT8/HkPOnHLBk/ uA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jvjn72t0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:27:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28SE65gb001528;
        Wed, 28 Sep 2022 14:27:45 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j5cek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 14:27:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28SERfGS721630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Sep 2022 14:27:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ADDBA404D;
        Wed, 28 Sep 2022 14:27:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DADCA4040;
        Wed, 28 Sep 2022 14:27:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.45.125])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 28 Sep 2022 14:27:38 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH V2 2/3] tools/perf/tests: Fix branch stack sampling test
 to include sanity check for branch filter
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220921145255.20972-2-atrajeev@linux.vnet.ibm.com>
Date:   Wed, 28 Sep 2022 19:57:33 +0530
Cc:     maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FDF5E7C-6D71-4C61-8A0D-804740CA1E7C@linux.vnet.ibm.com>
References: <20220921145255.20972-1-atrajeev@linux.vnet.ibm.com>
 <20220921145255.20972-2-atrajeev@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        German Gomez <german.gomez@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lo6bjr7BTpIVJQ1zlush8gV-pocAsPn8
X-Proofpoint-GUID: lo6bjr7BTpIVJQ1zlush8gV-pocAsPn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280085
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 21-Sep-2022, at 8:22 PM, Athira Rajeev =
<atrajeev@linux.vnet.ibm.com> wrote:
>=20
> commit b55878c90ab9 ("perf test: Add test for branch stack sampling")
> added test for branch stack sampling. There is a sanity check in the
> beginning to skip the test if the hardware doesn't support branch =
stack
> sampling.
>=20
> Snippet
> <<>>
> skip the test if the hardware doesn't support branch stack sampling
> perf record -b -o- -B true > /dev/null 2>&1 || exit 2
> <<>>
>=20
> But the testcase also uses branch sample types: save_type, any. if any
> platform doesn't support the branch filters used in the test, the =
testcase
> will fail. In powerpc, currently mutliple branch filters are not =
supported
> and hence this test fails in powerpc. Fix the sanity check to look at
> the support for branch filters used in this test before proceeding =
with
> the test.
>=20
> Fixes: b55878c90ab9 ("perf test: Add test for branch stack sampling")
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> ---
> tools/perf/tests/shell/test_brstack.sh | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/tests/shell/test_brstack.sh =
b/tools/perf/tests/shell/test_brstack.sh
> index c644f94a6500..ec801cffae6b 100755
> --- a/tools/perf/tests/shell/test_brstack.sh
> +++ b/tools/perf/tests/shell/test_brstack.sh
> @@ -12,7 +12,8 @@ if ! [ -x "$(command -v cc)" ]; then
> fi
>=20
> # skip the test if the hardware doesn't support branch stack sampling
> -perf record -b -o- -B true > /dev/null 2>&1 || exit 2
> +# and if the architecture doesn't support filter types: =
any,save_type,u
> +perf record -b -o- -B --branch-filter any,save_type,u true > =
/dev/null 2>&1 || exit 2

Hi,

Looking for review comments for this change.

Thanks
Athira
>=20
> TMPDIR=3D$(mktemp -d /tmp/__perf_test.program.XXXXX)
>=20
> --=20
> 2.31.1
>=20

