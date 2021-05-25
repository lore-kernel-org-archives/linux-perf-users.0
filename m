Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE554C2B9F8
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 15:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C57613AB
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 May 2021 15:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhEYP3s (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 May 2021 11:29:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232569AbhEYP3s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 May 2021 11:29:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PF45UT176463;
        Tue, 25 May 2021 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WvPJCjPBzzqyGIhh7fMQZ9p+hJHLv+hItbW/FNQLCuE=;
 b=TUGin3yePZ63bqeZa5Cc7V32lBhIaTUmKDITPgI2nhyhjrtxQZxrDPjPZ+cTUn5XMOoW
 gId04m02Pntoo6NLOs7ustfWoVAMwKG198Zsa4Hyuk9zNnFZI8BxkKSyrLHmfW78Snor
 lha1FFHQfn6BD02cr93Wu6MfiIZdH7UsesJIG10er3FBLpWiJBvAIPhdnKXOMtGSey1d
 14ifHSfgeQsFdap7Hxovm//YSTxPhWxzVDHK4eFiQ0RxhbBkVgkpbKe8hhZY7lhf45i9
 B8BTdYJvXQnSqlYQE4STYL3yy75f7/jv7YM7IjFkEN5P1/k/WEcy/6EENHRnuvMeEo54 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s2xvafcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 11:28:08 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14PF44Pt176403;
        Tue, 25 May 2021 11:28:07 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38s2xvafby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 11:28:07 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14PFRv25001772;
        Tue, 25 May 2021 15:28:07 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 38s1qd14n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 15:28:07 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14PFS5qu25755988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 15:28:05 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA2E1136051;
        Tue, 25 May 2021 15:28:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26646136063;
        Tue, 25 May 2021 15:28:04 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.85.178.250])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 25 May 2021 15:28:03 +0000 (GMT)
Date:   Tue, 25 May 2021 10:27:36 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Kajol Jain <kjain@linux.ibm.com>,
        Nageswara Sastry <rnsastry@linux.ibm.com>
Cc:     acme@kernel.org, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mpe@ellerman.id.au, ravi.bangoria@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf vendor events: Fix eventcode of power10 json events
Message-ID: <20210525152736.GB2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20210525063723.1191514-1-kjain@linux.ibm.com>
 <20210525144215.GA2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525144215.GA2135213@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9btOxma5TmTIucKhsFdjQlylT8J58Jgu
X-Proofpoint-GUID: GKiKfC2dpxACdk2dsSrBe12pbCCB2JJ9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_07:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250092
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 25, 2021 at 09:42:15AM -0500, Paul A. Clarke wrote:
> On Tue, May 25, 2021 at 12:07:23PM +0530, Kajol Jain wrote:
> > Fixed the eventcode values in the power10 json event files to append
> > "0x" since these are hexadecimal values.
> > Patch also changes event description of PM_EXEC_STALL_LOAD_FINISH and
> > PM_EXEC_STALL_NTC_FLUSH event and move some events to correct files.
> > 
> > Fixes: 32daa5d7899e ("perf vendor events: Initial JSON/events list for power10 platform")
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> 
> I checked that everything that was "removed" was actually just moved
> somewhere else, that all the added EventCodes indeed had '0x', the
> number of EventCodes added matched the number removed, and that the
> additional text added seemed reasonable.  LGTM.
> 
> Reviewed-by: Paul A. Clarke <pc@us.ibm.com>

I lost the original message, but Nageswara Sastry said:
> 1. Extracted all the 244 events from the patch.
> 2. Check them in 'perf list' - all 244 events found
> 3. Ran all the events with 'perf stat -e "event name" sleep 1', all ran fine.
>     No errors were seen in 'dmesg'

I count 255 events.

PC
