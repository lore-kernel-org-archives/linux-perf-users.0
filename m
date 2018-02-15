From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] Revert "tools include s390: Grab a copy of
 arch/s390/include/uapi/asm/unistd.h"
Date: Thu, 15 Feb 2018 14:37:55 +0100
Message-ID: <20180215133755.GA4491@linux.vnet.ibm.com>
References: <1518090470-2899-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1518090470-2899-2-git-send-email-brueckner@linux.vnet.ibm.com>
 <20180215130535.GA22818@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031533AbeBONiB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Feb 2018 08:38:01 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1FDYGno028995
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2018 08:38:01 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g57de1nx2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2018 08:38:00 -0500
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <brueckner@linux.vnet.ibm.com>;
        Thu, 15 Feb 2018 13:37:59 -0000
Content-Disposition: inline
In-Reply-To: <20180215130535.GA22818@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>

On Thu, Feb 15, 2018 at 10:05:35AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 08, 2018 at 12:47:48PM +0100, Hendrik Brueckner escreveu:
> > This reverts commit f120c7b187e6c418238710b48723ce141f467543 which is no
> > longer required with the introduction of a syscall.tbl on s390.
> 
> I'm applying this now, but putting this 1/3 patch, i.e. the first in
> this series, to be the last, as only after applying "perf s390: Rework
> system call table creation by using syscall.tbl" is that we can remove
> the unistd.h copy, right?

Correct.  After patches 2 and 3, the unistd.h copy is no longer used.

Thanks for that reordering.

- Hendrik
