Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6B2C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 11:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhKZLek (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 06:34:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56274 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230219AbhKZLcj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 06:32:39 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQApawP030397;
        Fri, 26 Nov 2021 11:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RAoJ8ERUIPhq2HQo6BdwVY1EOAR94woqPfGEvA1nzMA=;
 b=C7AyUTJo8QZIH/1MoHU52+4RwqGHJwRkDnq1fN80N/vsToAhLkrBJmfUoff0g9i99ziZ
 gS1gbSYFcYCPDj3dUmzxNJNu5lZZEthU89ah8Vu9pcCJ940j5pMjpK9hTdYk9019JFUZ
 s1Q7dpQXUJ9eYKa9nEppRJn6YXMeK6i/KLvE2RddxuryGs4HIbUzCdsVZMgNCsY/sz4D
 HaFAHEQULFSPRMi+YBXRvk0E7ygM4xa8MtonSPx5T4ChFCVX6iYix9q159j/1UplSVdd
 qlb44Q2ZYsfg1k/Vve3r/q8eJdzTJORhP9CxJpv02W4CXQWAqRsWRWyP5VQCuB6bBPtC 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cjx6u0rb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 11:29:22 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AQBSPof006913;
        Fri, 26 Nov 2021 11:29:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cjx6u0ram-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 11:29:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AQBJ785028017;
        Fri, 26 Nov 2021 11:29:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3cernatw2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 11:29:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AQBTHIS2163392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Nov 2021 11:29:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76F111CE9A;
        Fri, 26 Nov 2021 11:29:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B26C11CE9B;
        Fri, 26 Nov 2021 11:29:17 +0000 (GMT)
Received: from osiris (unknown [9.145.84.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Nov 2021 11:29:17 +0000 (GMT)
Date:   Fri, 26 Nov 2021 12:29:16 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI][PATCH 1/1] tools headers UAPI: Sync s390 syscall table
 file changed by new futex_waitv syscall Reply-To:
Message-ID: <YaDFDApOMj8TQ4IJ@osiris>
References: <YZ/2qRW/TScYTP1U@kernel.org>
 <YaCug8LEHYmZ9G6E@osiris>
 <E1590C4C-2941-4922-A388-30780C9E01FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1590C4C-2941-4922-A388-30780C9E01FA@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ASwv_q_ORYXc_v93xA2JMv5-ZH8opu79
X-Proofpoint-GUID: iy5zF_CnFidP8Gd984eQLPFhq0DVjZjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_03,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111260065
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 26, 2021 at 07:01:16AM -0300, Arnaldo Carvalho de Melo wrote:
> >> To pick the changes in this cset:
> >> 
> >>   6c122360cf2f4c5a ("s390: wire up sys_futex_waitv system call")
> >> 
> >> That add support for this new syscall in tools such as 'perf trace'.
> >...
> >> This addresses this perf build warnings:
> >> 
> >>   Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
> >>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
> >> 
> >> Cc: Heiko Carstens <hca@linux.ibm.com>
> >> Cc: Vasily Gorbik <gor@linux.ibm.com>
> >> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> ---
> >>  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 +
> >>  1 file changed, 1 insertion(+)
> >
> >I can happily pick this up for the s390 tree, but I'm not sure if that
> >is want you want?
> 
> Just FYI and to give the opportunity to people to chime in in case something is wrong somehow.
> 
> Also to advertise the feature.
> 
> I'm pushing this upstream myself,

Thanks for taking care of this! FWIW:

Acked-by: Heiko Carstens <hca@linux.ibm.com>
