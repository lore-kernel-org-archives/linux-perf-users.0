From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] perf/bench/numa: Handle discontiguous/sparse
 numa nodes
Date: Tue, 14 Nov 2017 18:16:02 +0530
Message-ID: <1510663562.24275.38.camel@linux.vnet.ibm.com>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
         <67b88aa2de6dd199d57bacdecf35d26958780feb.1503310062.git.sathnaga@linux.vnet.ibm.com>
         <20171031151658.clq6qmdfw3gj6afg@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754143AbdKNMr5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 07:47:57 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAECi0l1104448
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 07:47:57 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e80p4gdbf-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2017 07:47:56 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <sathnaga@linux.vnet.ibm.com>;
        Tue, 14 Nov 2017 07:47:56 -0500
In-Reply-To: <20171031151658.clq6qmdfw3gj6afg@naverao1-tp.localdomain>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, srikar@linux.vnet.ibm.com, bala24@linux.vnet.ibm.com

Hi Naveen,


On Tue, 2017-10-31 at 20:46 +0530, Naveen N. Rao wrote:
> 
> >  	}
> >  	BUG_ON(nr_min > nr_max);
> > -
> Looks like an un-necessary change there.
> 
> - Naveen
> 
I had hit with this compilation error, so had to move the
initialization above.
Please advice. Thanks.

  CC       bench/numa.o
bench/numa.c: In function ‘calc_convergence’:
bench/numa.c:1035:3: error: ISO C90 forbids mixed declarations and code
[-Werror=declaration-after-statement]
   int processes = count_node_processes(node);
   ^
cc1: all warnings being treated as errors
mv: cannot stat ‘bench/.numa.o.tmp’: No such file or directory
make[4]: *** [bench/numa.o] Error 1
make[3]: *** [bench] Error 2
make[2]: *** [perf-in.o] Error 2
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

Regards,
-Satheesh.
> > 
> >  	BUG_ON(sum > g->p.nr_tasks);
> > 
> >  	if (0 && (sum < g->p.nr_tasks))
@@ -1027,8 +1029,9 @@ static void calc_convergence(double 
