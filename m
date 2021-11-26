Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBD0C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 09:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376650AbhKZJ63 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 04:58:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344369AbhKZJ43 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 04:56:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ9aDD7021453;
        Fri, 26 Nov 2021 09:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=w3s2JswelhibpatfNg2vp8/iV4BlLtwf3idng4Y6stI=;
 b=sVOg+mIQl+fnYMWd/NJMEskM4klb2954WFmVZm6erjqrKKAOhlsVRlUdfCJbHqv0K/KB
 0qHZJi+2P7X6UGjoymivDICDL0NYITV/1GoMwuJ1/vh1DNf04t1LKNWXWpGqz3gBSzpr
 VEVesDI9nrTcZKSlVgG7k0aWZyz82ItC0mbHvW2rbrJ9k0TGtkJHevaqCGHnqEUqSdkk
 sScCtNqZuNhC3tk9QrMGsiWW2F9CiGgMQra/5CxqzG3XMPghVOiBEyDjwKpS2CWjb0BA
 TlwUPYwOMbewQwoqqs8Ktxm4pDfmfXwZEOvd2g7PgNJXtN8BVrzYnEadkBpd9tZvAikC +Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cjmwj16cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 09:53:13 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AQ9lHh8001912;
        Fri, 26 Nov 2021 09:53:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3cjm1fk479-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Nov 2021 09:53:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AQ9r9nH20185386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Nov 2021 09:53:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FD6852051;
        Fri, 26 Nov 2021 09:53:09 +0000 (GMT)
Received: from osiris (unknown [9.145.84.79])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id AF4E252057;
        Fri, 26 Nov 2021 09:53:08 +0000 (GMT)
Date:   Fri, 26 Nov 2021 10:53:07 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI][PATCH 1/1] tools headers UAPI: Sync s390 syscall table
 file changed by new futex_waitv syscall Reply-To:
Message-ID: <YaCug8LEHYmZ9G6E@osiris>
References: <YZ/2qRW/TScYTP1U@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/2qRW/TScYTP1U@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FomuBOPZCCuCyv6ggXu_pkH8uLmJqIsp
X-Proofpoint-ORIG-GUID: FomuBOPZCCuCyv6ggXu_pkH8uLmJqIsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-26_02,2021-11-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111260055
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

> To pick the changes in this cset:
> 
>   6c122360cf2f4c5a ("s390: wire up sys_futex_waitv system call")
> 
> That add support for this new syscall in tools such as 'perf trace'.
...
> This addresses this perf build warnings:
> 
>   Warning: Kernel ABI header at 'tools/perf/arch/s390/entry/syscalls/syscall.tbl' differs from latest version at 'arch/s390/kernel/syscalls/syscall.tbl'
>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 1 +
>  1 file changed, 1 insertion(+)

I can happily pick this up for the s390 tree, but I'm not sure if that
is want you want?
