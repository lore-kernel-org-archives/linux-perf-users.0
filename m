Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 09:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhKZJzE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 04:55:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1376564AbhKZJxE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 04:53:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ9iC6V013741;
        Fri, 26 Nov 2021 09:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=JxwmMPWnjU4ayvBmgR6H2tJICxhtE//tq5JQb1By7DU=;
 b=FWYbB1/XCXIPC4tkwDTptDhrdCdbiAihSZ3/6043bFCY/Kyt6PkAWmagMv+IipdncMQP
 E9Y173Ig9x9B2CYzSFKaEtdgfiBDcrbcOMUlbaDnL06rEupWrq2aEoJKaGbKZvliKI6q
 lbj0I7YDC+pSN2wQXjPDU09rGyyiosaojZ2+hr/C6KffQgF7MjtouKI+kX/wM/OhPOaS
 Cb4kuoeCGL/eRr5JBzmHa7YMmxHc76qNr4kzmbML2DlPeOMc9hZa2wfBT6No4xU2M5B5
 N+VlCirEOprTZpLrUCMFxSSJRL+DQDsb5rLFt/sRulE2+6YBUsDQAscwF9tHtpsX2bii Fw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cju4ytuar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 09:49:44 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ9mWEP005482;
        Fri, 26 Nov 2021 09:49:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3cernafg4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 09:49:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AQ9neZp28115310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Nov 2021 09:49:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48632AE058;
        Fri, 26 Nov 2021 09:49:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F10AEAE059;
        Fri, 26 Nov 2021 09:49:36 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.41.253])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Nov 2021 09:49:36 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [FYI][PATCH 1/1] tools headers UAPI: Sync powerpc syscall table
 file changed by new futex_waitv syscall
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <YZ/1OU9mJuyS2HMa@kernel.org>
Date:   Fri, 26 Nov 2021 15:19:32 +0530
Cc:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <308BB8D5-95DF-40EF-9155-CEAC0422BBD4@linux.vnet.ibm.com>
References: <YZ/1OU9mJuyS2HMa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fbN4_fUIog3PZ4ymGyPlK_yW6G7e6Kge
X-Proofpoint-ORIG-GUID: fbN4_fUIog3PZ4ymGyPlK_yW6G7e6Kge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_02,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111260055
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



> On 26-Nov-2021, at 2:12 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> To pick the changes in this cset:
>=20
>  a0eb2da92b715d0c ("futex: Wireup futex_waitv syscall")
>=20
> That add support for this new syscall in tools such as 'perf trace'.
>=20
> For instance, this is now possible (adapted from the x86_64 test =
output):
>=20
>  # perf trace -e futex_waitv
>  ^C#
>  # perf trace -v -e futex_waitv
>  event qualifier tracepoint filter: (common_pid !=3D 807333 && =
common_pid !=3D 3564) && (id =3D=3D 449)
>  ^C#
>  # perf trace -v -e futex* --max-events 10
>  event qualifier tracepoint filter: (common_pid !=3D 812168 && =
common_pid !=3D 3564) && (id =3D=3D 221 || id =3D=3D 449)
>  mmap size 528384B
>           ? (         ): Timer/219310  ... [continued]: futex())       =
                                     =3D -1 ETIMEDOUT (Connection timed =
out)
>       0.012 ( 0.002 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: =
WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>       0.024 ( 0.060 ms): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: =
WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) =3D 0
>       0.086 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: =
WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>       0.088 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d424, op: =
WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
>       0.075 ( 0.005 ms): Web Content/219299 futex(uaddr: =
0x7fd0b152d420, op: WAKE|PRIVATE_FLAG, val: 1)     =3D 1
>       0.169 ( 0.004 ms): Web Content/219299 futex(uaddr: =
0x7fd0b152d424, op: WAKE|PRIVATE_FLAG, val: 1)     =3D 1
>       0.088 ( 0.089 ms): Timer/219310  ... [continued]: futex())       =
                                     =3D 0
>       0.179 ( 0.001 ms): Timer/219310 futex(uaddr: 0x7fd0b152d3c8, op: =
WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>       0.181 (         ): Timer/219310 futex(uaddr: 0x7fd0b152d420, op: =
WAIT_BITSET|PRIVATE_FLAG, utime: 0x7fd0b1657840, val3: MATCH_ANY) ...
>  #
>=20
> That is the filter expression attached to the =
raw_syscalls:sys_{enter,exit}
> tracepoints.
>=20
>  $ grep futex tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
>  221	32	futex				sys_futex_time32
>  221	64	futex				sys_futex
>  221	spu	futex				sys_futex
>  422	32	futex_time64			sys_futex			=
sys_futex
>  449	common  futex_waitv                     sys_futex_waitv
>  $
>=20

Hi Arnaldo,

I checked this in powerpc by using :
perf trace -v -e futex_waitv=20
And also using functional selftest from =
'tools/testing/selftests/futex/functional/futex_waitv=E2=80=99, to make =
sure =E2=80=98futex_waitv=E2=80=99 comes in the perf trace result.

Just a minor suggestion change. Below warning mentioned in this patch is =
for s390. But I verified that this patch fixes the perf build warning in =
powerpc also. So would be good to put the warning logs for powerpc:

Warning: Kernel ABI header at =
'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest =
version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl =
arch/powerpc/kernel/syscalls/syscall.tbl

Reviewed-and-Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira

> This addresses this perf build warnings:
>=20
>  Warning: Kernel ABI header at =
'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest =
version at 'arch/s390/kernel/syscalls/syscall.tbl'
>  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl =
arch/s390/kernel/syscalls/syscall.tbl
>=20
> Cc: Andr=C3=83=C2=A9 Almeida <andrealmeid@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl =
b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> index 7bef917cc84e6499..15109af9d0754d5f 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -528,3 +528,4 @@
> 446	common	landlock_restrict_self		=
sys_landlock_restrict_self
> # 447 reserved for memfd_secret
> 448	common	process_mrelease		sys_process_mrelease
> +449	common  futex_waitv                     sys_futex_waitv
> --=20
> 2.31.1
>=20
>=20

