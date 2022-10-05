Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F975C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Oct 2022 04:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJEEyE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 00:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJEEyD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 00:54:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E473313
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 21:54:00 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295423S8009169;
        Wed, 5 Oct 2022 04:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QwZvE0rKr+tVWu2OIsbWSiE3nfSigX2WARZlG7o1AJU=;
 b=g84cM6B0cL1yoRj4JmQyfMjIbiMMQYCf3ehQj1Gx7C9OzTRv2Je9pRIFuDgkDcqR0HQD
 /KsjFtTrJ8mKQLpiio79Sfx2CHUI8UekezrtdCQDMLSf5RJuZQPXSTR44NRYmVfQ3xM/
 tuh9e6RYe5Tl0SW4Ps1ZgkP90DBrx42n+E8NNzWcbrLodvaxfEdbG2hutqV1VgAfwggq
 /FZutYsqwHtfQF3n1eWttkYLBiIH9fQPC/LdC3AEUB8a4+Z2B0IaojhoEuX5X1pAhH/K
 RmOw3tZSIg7dM6gl3K4bxr+rtRIt8RvxgXGMCgOBGNUsF+WbkrsIqV02IV13B/r1hxny gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gu369wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 04:53:50 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2954rnCx031533;
        Wed, 5 Oct 2022 04:53:50 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0gu369vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 04:53:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2954oF62005490;
        Wed, 5 Oct 2022 04:53:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd6952ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 04:53:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2954riWE63439336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Oct 2022 04:53:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36CB1A4053;
        Wed,  5 Oct 2022 04:53:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C351BA4040;
        Wed,  5 Oct 2022 04:53:41 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.106.170])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Oct 2022 04:53:41 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [PATCH] tools/perf: Fix aggr_printout to display cpu field
 irrespective of core value
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <Yzx4ET7QU2VpCcsx@kernel.org>
Date:   Wed, 5 Oct 2022 10:23:39 +0530
Cc:     Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
        atrajeev <atrajeev@imap.linux.ibm.com>, maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <137635B2-F4E8-4C65-B797-5C6511E265A8@linux.vnet.ibm.com>
References: <20220913115717.36191-1-atrajeev@linux.vnet.ibm.com>
 <4792ef3a-8790-a0d4-50f2-4917874d81d6@arm.com>
 <82D5587E-593A-43A7-92D7-7E095E2BE9A9@linux.vnet.ibm.com>
 <6627ae9a-91e3-0923-1234-54e0fc3f4916@arm.com>
 <CAP-5=fVBzLfhfwPjxE_9DNeesPaPxf3k0b5T5S6THzB1H85mrA@mail.gmail.com>
 <993a1391ee931e859d972c460644d171@imap.linux.ibm.com>
 <CAP-5=fWJ0YBxdCarpNSfbzoAZ9uTAtgj4CdR7sQU8748Y-+DVA@mail.gmail.com>
 <6A5D0603-CF66-43B4-A13F-0308CF01967A@linux.vnet.ibm.com>
 <CAP-5=fU=bwv-e_53QagWsKvW8wjibOjfGvnivWFFVba5A55boA@mail.gmail.com>
 <Yzx4A+2I4yWTlbEn@kernel.org> <Yzx4ET7QU2VpCcsx@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NUaoy_VoMEyAIQSK413BidbOiV_TPWrF
X-Proofpoint-GUID: Adt2jxXevuz6GcIXKhBTYaP0M4UMqSzt
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210050028
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 04-Oct-2022, at 11:44 PM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Tue, Oct 04, 2022 at 03:14:27PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Tue, Oct 04, 2022 at 07:49:21AM -0700, Ian Rogers escreveu:
>>> On Tue, Oct 4, 2022, 12:06 AM Athira Rajeev <atrajeev@linux.vnet.ibm.co=
m>
>>>> Thanks for helping with testing. Can I add your Tested-by for the patc=
h ?
>>=20
>>> Yep.
>>=20
>>> Tested-by: Ian Rogers <irogers@google.com>
>=20
>=20
> Thanks, applied.
>=20
> - Arnaldo

Hi Arnaldo,

Looks like you have taken change to remove id.core check:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
tmp.perf/core&id=3Ddb83f447b323958cdc5fedcf2134effb2ec9a6fe

But the patch that has to go in is :
"[PATCH] tools/perf: Fix cpu check to use id.cpu.cpu in ggr_printout"
which is tested by Ian and "pasted" by me in same mail thread.

Re-pasting here for reference:

From 4dd98d953940deb2f85176cb6b4ecbfd18dbdbf9 Mon Sep 17 00:00:00 2001
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Date: Mon, 3 Oct 2022 15:47:27 +0530
Subject: [PATCH] tools/perf: Fix cpu check to use id.cpu.cpu in aggr_printo=
ut

perf stat has options to aggregate the counts in different
modes like per socket, per core etc. The function "aggr_printout"
in util/stat-display.c which is used to print the aggregates,
has a check for cpu in case of AGGR_NONE. This check was
originally using condition : "if (id.cpu.cpu > -1)". But
this got changed after commit df936cadfb58 ("perf stat: Add
JSON output option"), which added option to output json format
for different aggregation modes. After this commit, the
check in "aggr_printout" is using "if (id.core > -1)".

The old code was using "id.cpu.cpu > -1" while the new code
is using "id.core > -1". But since the value printed is
id.cpu.cpu, fix this check to use cpu and not core.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Suggested-by: James Clark <james.clark@arm.com>
Suggested-by: Ian Rogers <irogers@google.com>
---
tools/perf/util/stat-display.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b82844cb0ce7..cf28020798ec 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -168,7 +168,7 @@ static void aggr_printout(struct perf_stat_config *conf=
ig,
					id.socket,
					id.die,
					id.core);
-			} else if (id.core > -1) {
+			} else if (id.cpu.cpu > -1) {
				fprintf(config->output, "\"cpu\" : \"%d\", ",
					id.cpu.cpu);
			}
@@ -179,7 +179,7 @@ static void aggr_printout(struct perf_stat_config *conf=
ig,
					id.die,
					config->csv_output ? 0 : -3,
					id.core, config->csv_sep);
-			} else if (id.core > -1) {
+			} else if (id.cpu.cpu > -1) {
				fprintf(config->output, "CPU%*d%s",
					config->csv_output ? 0 : -7,
					id.cpu.cpu, config->csv_sep);
--=20
2.31.1

If it is confusing, shall I send it as a separate patch along with Tested-b=
y from Ian ?

Please revert https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.gi=
t/commit/?h=3Dtmp.perf/core&id=3Ddb83f447b323958cdc5fedcf2134effb2ec9a6fe

Thanks
Athira

>=20

