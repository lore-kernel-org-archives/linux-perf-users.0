Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098EEEAA5B
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Sep 2023 17:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjINRUN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Sep 2023 13:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbjINRUM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Sep 2023 13:20:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05621FE6
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Sep 2023 10:20:08 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EHCWm2005915;
        Thu, 14 Sep 2023 17:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=avH8+mxmhwqCIMnPZE8I8mk0Q7/Z1FlHsnnVaPy2EBU=;
 b=oFwmglvKR9zidaWy0zWDFoDOBAKM4DYrHUpMVABON6lDWwQEG4XfcFp0eGzAhecUiOZM
 r4pjipQvE1hjJAfAKqN4umOgHOO5Ywb0mTL+OfjldTqIT1djYA4BEAZkK92/2xDzGjA6
 iaVS/sNWIDnnHe9VH8U7MowYfhUNxm1OBwHv0NuGnXAuB98XCaIiUIp9UQ/GjIVocbBg
 oUf/n1jURSzag4H6b3k605lm8c3RMv02Cn4XY/CFsnrl85VZapbyDAofLTtSo7mR0hGf
 WWeIEoFfmFar93cdbKfyfCKafOf6gEuxkvN+r2dYWaK3KOANkTuS1iPB8n5sB+3AJoFG qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46c887e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:20:01 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38EHCYFT005950;
        Thu, 14 Sep 2023 17:20:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t46c887ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:20:01 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38EGHp4r002755;
        Thu, 14 Sep 2023 17:20:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hmcdur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 17:20:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38EHJu1642926408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 17:19:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D212720040;
        Thu, 14 Sep 2023 17:19:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30BA620043;
        Thu, 14 Sep 2023 17:19:55 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.35.47])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Sep 2023 17:19:54 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH V3] tools/perf: Add includes for detected configs in
 Makefile.perf
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <ZQC9zp14T92/fwCN@kernel.org>
Date:   Thu, 14 Sep 2023 22:49:43 +0530
Cc:     Kajol Jain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42FC748E-BE50-41E2-8528-357675714351@linux.vnet.ibm.com>
References: <20230912063807.74250-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fU644=VvHf1JcQ1LN7tb_wAkrnrE+n4xCVyWae=UxTFyg@mail.gmail.com>
 <ZQC9zp14T92/fwCN@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uGKklXrV4Sk2ZJBEqYJfIBNb-og4KlAr
X-Proofpoint-GUID: K3h6sJKca62q1gCQIRKRPy7du-Al4OGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140148
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 13-Sep-2023, at 1:06 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Tue, Sep 12, 2023 at 07:00:00AM -0700, Ian Rogers escreveu:
>> On Mon, Sep 11, 2023 at 11:38=E2=80=AFPM Athira Rajeev
>> <atrajeev@linux.vnet.ibm.com> wrote:
>>>=20
>>> Makefile.perf uses "CONFIG_*" checks in the code. Example the config
>>> for libtraceevent is used to set PYTHON_EXT_SRCS
>>>=20
>>>        ifeq ($(CONFIG_LIBTRACEEVENT),y)
>>>          PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# =
util/python-ext-sources)
>>>        else
>>>          PYTHON_EXT_SRCS :=3D $(shell grep -v =
'^\#\|util/trace-event.c' util/python-ext-sources)
>>>        endif
>>>=20
>>> But this is not picking the value for CONFIG_LIBTRACEEVENT that is
>>> set using the settings in Makefile.config. Include the file
>>> ".config-detected" so that make will use the system detected
>>> configuration in the CONFIG checks. This will fix isues that
>>> could arise when other "CONFIG_*" checks are added to Makefile.perf
>>> in future as well.
>>>=20
>>> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>>=20
>> Reviewed-by: Ian Rogers <irogers@google.com>
>=20
> Thanks, applied.
>=20
> - Arnaldo
>=20

Thanks Ian for the review and thanks Arnaldo for picking this fix

Athira
>=20
>> Thanks,
>> Ian
>>=20
>>> ---
>>> Changelog:
>>> v2 -> v3:
>>> Added -include since in some cases make clean or make
>>> will fail when config is not included and if config-detected
>>> file is not present.
>>>=20
>>> v1 -> v2:
>>> Added $(OUTPUT) prefix to config-detected as pointed
>>> out by Ian
>>>=20
>>> tools/perf/Makefile.perf | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>>> index 37af6df7b978..f6fdc2d5a92f 100644
>>> --- a/tools/perf/Makefile.perf
>>> +++ b/tools/perf/Makefile.perf
>>> @@ -351,6 +351,9 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
>>>=20
>>> python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r =
$(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
>>>=20
>>> +# Use the detected configuration
>>> +-include $(OUTPUT).config-detected
>>> +
>>> ifeq ($(CONFIG_LIBTRACEEVENT),y)
>>>   PYTHON_EXT_SRCS :=3D $(shell grep -v ^\# util/python-ext-sources)
>>> else
>>> --
>>> 2.31.1
>>>=20
>=20
> --=20
>=20
> - Arnaldo


