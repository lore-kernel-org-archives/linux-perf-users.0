From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf trace: no longer require auditlibs if syscall
 tables are present
Date: Mon, 11 Dec 2017 10:35:48 +0100
Message-ID: <20171211093548.GE4369@linux.vnet.ibm.com>
References: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512635281-20733-4-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171207175352.GH3173@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751307AbdLKJf4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Dec 2017 04:35:56 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vBB9VMmN107903
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2017 04:35:56 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2espbkkhhv-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2017 04:35:54 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Mon, 11 Dec 2017 09:35:51 -0000
Content-Disposition: inline
In-Reply-To: <20171207175352.GH3173@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org

On Thu, Dec 07, 2017 at 02:53:52PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 07, 2017 at 09:28:01AM +0100, Hendrik Brueckner escreveu:
> > Change the Makefile and build process to no longer require auditlibs
> > interfaces when the architecture provides system call tables.
> 
> And this one will have to wait for the fix in how the errno translation
> tables are generated, ok?

Yes, it has to wait.

Regards,
  Hendrik
