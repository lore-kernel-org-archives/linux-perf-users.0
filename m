From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/1] perf/bench/numa: Fixup discontiguous/sparse
 numa nodes
Date: Wed, 22 Nov 2017 22:18:13 +0530
Message-ID: <1511369293.11553.2.camel@linux.vnet.ibm.com>
References: <1511336642-15389-1-git-send-email-sathnaga@linux.vnet.ibm.com>
         <1511366847.k4y13an79p.naveen@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751259AbdKVRGt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Nov 2017 12:06:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAMH5STW049625
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 12:06:48 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2edcbm2seg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2017 12:06:45 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Wed, 22 Nov 2017 10:06:42 -0700
In-Reply-To: <1511366847.k4y13an79p.naveen@linux.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@kernel.org
Cc: bala24@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com

On Wed, 2017-11-22 at 21:39 +0530, Naveen N. Rao wrote:
> >               sum += nr;
> >       }
> >       BUG_ON(nr_min > nr_max);
> > -
> >       BUG_ON(sum > g->p.nr_tasks);
> 
> Looks like that change to remove a blank line did slip in, but that's
> a 
> small nit. Apart from that, the patch looks good to me.
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
Hi Naveen,

Thanks, have sent v5 with that addressed :-)

Regards,
-Satheesh
> - Naveen
