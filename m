Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1830C2B9F8
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A4561417
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 14:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhEYOn6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 10:43:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233982AbhEYOn5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 10:43:57 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PEb9BX103437;
        Tue, 25 May 2021 10:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=o7F+Sp6lJ2xB4IakTrZySBRmGFa97r7bU8BtCYkJT1U=;
 b=IVXjeAHjMGCAlkOGLynosC9TH5cFlvKE79Jg436TThPkgulBkG2O918m1Gl25IUs8zjh
 B2L50n05X62XuYPG6xhQOT+jqKyNFY+w5//OLv+mJNkYJDh5drn6rKTJiYhQ3nJHNzKP
 FpsDuY9IW/0VfSAAITZ0kS0Zzg9ZeXAZj8dBgUbE/dF8sMnBmJMs7UEDWf0wyXhLsA6G
 yWhkajQGXXiiGtj2GnOnsutA+rTeYIrIouCLRwIt4HLK3is2ZQe01Z8w7yfjnF4G9Y0F
 xuvhSUANy9jGl3pv4vJGJ+OXTJNZKD44CXycFKxJU8q00KH4KXQTD+1im3rs+/xTR4LM GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s1h5v4ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:42:20 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PEbC6k103729;
        Tue, 25 May 2021 10:42:19 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38s1h5v4e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 10:42:19 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PEWV2X030723;
        Tue, 25 May 2021 14:42:18 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 38s1gw0xmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 14:42:18 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PEgI1a37683556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 14:42:18 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A5CB28058;
        Tue, 25 May 2021 14:42:18 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6044528059;
        Tue, 25 May 2021 14:42:17 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.85.178.250])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 25 May 2021 14:42:17 +0000 (GMT)
Date:   Tue, 25 May 2021 09:42:15 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        rnsastry@linux.ibm.com
Subject: Re: [PATCH] perf vendor events: Fix eventcode of power10 json events
Message-ID: <20210525144215.GA2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210525063723.1191514-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525063723.1191514-1-kjain@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9CI8T5O3JgyyXU8psLmowTOOe5SP3-YQ
X-Proofpoint-GUID: v0tTdXDK-VZlqHG6TCJTcyG6cNFNo5WT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105250090
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 25, 2021 at 12:07:23PM +0530, Kajol Jain wrote:
> Fixed the eventcode values in the power10 json event files to append
> "0x" since these are hexadecimal values.
> Patch also changes event description of PM_EXEC_STALL_LOAD_FINISH and
> PM_EXEC_STALL_NTC_FLUSH event and move some events to correct files.
> 
> Fixes: 32daa5d7899e ("perf vendor events: Initial JSON/events list for power10 platform")
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

I checked that everything that was "removed" was actually just moved
somewhere else, that all the added EventCodes indeed had '0x', the
number of EventCodes added matched the number removed, and that the
additional text added seemed reasonable.  LGTM.

Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
