Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D93C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 13:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170E861056
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 13:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbhJGNt4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 09:49:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63884 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241536AbhJGNt4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 09:49:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197D7OKe030374;
        Thu, 7 Oct 2021 09:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FiAyj+X+y5/IyCfXO7F3VRxntxo6XoOu/dw9JbbDB2Y=;
 b=eL2KlNIqIUV8C0YgFryIw4rMR8gpwCRD6gLX/1MuxBdEAZmfHqp7C0+tm1iVbm3DNUUR
 QARL+q4F5KeLIt2XZLKOQIoknFMkg9aaaffi2KlmPCTw5VlHiMCVppjnF/EivKEmkKSC
 kAj8/h1eV47hr5+wheFw27XR1gCjwQrb1PXZ7He9UjnbR8OGZeM5xwpaXy3e2GFvMMXQ
 U13sXSmBsJos7M3hLSzuV62VRxgpxgeCb5b/J5wtUQSLkYPdeW6IIhD3tPehV/KCmUrY
 fYB+AKCfK46+2z/y1TKNCJBqik+c++pPLrT/TGHBFyT+oKdLgqeU0BKgd6XCmKcAACpi Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhksyadhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 09:47:56 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 197D8ASZ003008;
        Thu, 7 Oct 2021 09:47:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhksyadhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 09:47:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 197DcAiT012729;
        Thu, 7 Oct 2021 13:47:55 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3bef2dhaka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 13:47:55 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 197Dls5B44892634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Oct 2021 13:47:54 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0B77C607F;
        Thu,  7 Oct 2021 13:47:53 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B11AEC6063;
        Thu,  7 Oct 2021 13:47:52 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.160.40.117])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu,  7 Oct 2021 13:47:52 +0000 (GMT)
Date:   Thu, 7 Oct 2021 08:47:50 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, atrajeev@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf vendor events power10: Add metric events json file
 for power10 platform
Message-ID: <20211007134750.GA243632@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20211006073119.276340-1-kjain@linux.ibm.com>
 <20211006173248.GA7389@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006173248.GA7389@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Smn2mgYwX25dnRXqKmiHLNPLX2XAYLvY
X-Proofpoint-ORIG-GUID: bxvGvEuneP8OjqU1yMDF0RuGYm4V-sJu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_01,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070092
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Oct 06, 2021 at 12:32:48PM -0500, Paul A. Clarke wrote:
> > +    {
> > +        "BriefDescription": "Average cycles per instruction when the instruction finishes at dispatch",
> 
> I'm not sure what that means.

After doing a bit of research, I think it might be a bit more clear as:
"Average cycles per instruction when the NTF instruction finishes at dispatch"

> > +        "MetricExpr": "PM_EXEC_STALL_FIN_AT_DISP / PM_RUN_INST_CMPL",
> > +        "MetricGroup": "CPI",
> > +        "MetricName": "FIN_AT_DISP_STALL_CPI"
> > +    },

PC
