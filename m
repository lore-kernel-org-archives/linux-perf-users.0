Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA6C433E9
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC3E64EE7
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Feb 2021 08:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBZI7f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 03:59:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229537AbhBZI7d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Feb 2021 03:59:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q8Y0af025565;
        Fri, 26 Feb 2021 03:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=X1GrCObucAtuxzgUZJIwUcEe4Q2Ni3AAro0eKrvL1Ww=;
 b=TVydO6aiqqpdDzMcncqMe3nUWhvGiFn8mT0M6cLsJGFJGBJUqpd+3QJZww+wOglM3zvE
 +vcp5ar7XKicaelqgY7tXIyY+R7A5bZVB+wI/XJuqUd9t4UDjzTT8xQZHolMyxpaesMN
 sFRDuQZN9+pq3OHFAxTyYnQuBkxK4/DLIBwmF5M5U8t+iVBHqRWIllzqtglkYSbornPg
 L2ZKIyL3NLxv7bIxVB60mxy7zDvCE1oCRh82nAOeYBhs70uGqgHZL0X/OpFzkt6J44Ob
 nyWOwPXLt+XW4rNShAXlNIEZu6ujyW7NfMFPwegrQle3tl7pzRz1qFFq3ddHTGtpw67i MA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36xvgy2ggb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 03:58:35 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11Q8vKRH031645;
        Fri, 26 Feb 2021 08:58:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 36tt28apud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 08:58:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11Q8wUtb45351260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 08:58:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B1552051;
        Fri, 26 Feb 2021 08:58:30 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 6B71452059;
        Fri, 26 Feb 2021 08:58:28 +0000 (GMT)
Date:   Fri, 26 Feb 2021 14:28:27 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mpe@ellerman.id.au,
        acme@kernel.org, jolsa@kernel.org, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH] perf bench numa: Fix the condition checks for max number
 of numa nodes
Message-ID: <20210226085827.GF2028034@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1614271802-1503-1-git-send-email-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1614271802-1503-1-git-send-email-atrajeev@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_02:2021-02-24,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260065
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

* Athira Rajeev <atrajeev@linux.vnet.ibm.com> [2021-02-25 11:50:02]:

> In systems having higher node numbers available like node
> 255, perf numa bench will fail with SIGABORT.
> 
> <<>>
> perf: bench/numa.c:1416: init: Assertion `!(g->p.nr_nodes > 64 || g->p.nr_nodes < 0)' failed.
> Aborted (core dumped)
> <<>>
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
