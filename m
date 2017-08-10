From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/9] perf: test 15 add s390x support for stat test cases
Date: Thu, 10 Aug 2017 09:15:51 +0200
Message-ID: <20170810071551.GC16932@oc2666213455.ibm.com>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
 <20170809064040.50899-4-tmricht@linux.vnet.ibm.com>
 <20170809152225.GC23060@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750735AbdHJHQD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Aug 2017 03:16:03 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7A78g4e023391
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2017 03:16:02 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2c8f8jjh5a-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2017 03:16:02 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Thu, 10 Aug 2017 08:16:00 +0100
Content-Disposition: inline
In-Reply-To: <20170809152225.GC23060@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On Wed, Aug 09, 2017 at 05:22:25PM +0200, Jiri Olsa wrote:
> On Wed, Aug 09, 2017 at 08:40:35AM +0200, Thomas Richter wrote:
> > The perf test 15 test cases test-stat-detailed[123]
> > and test-stat-default fail for s390x.
> > The reason is missing support of the CPUMF facility
> > for some of the test.
> > 
> > The tests are now marked optional. On s390x some of the
> > individual tests still fail, but when marked as optional,
> > do not cause the complete test to fail.
> 
> hum I wonder we should switch the optional keyword with that
> arch support you introduced recently.. this way we 'disable'
> those tests for other archs

This is correct.
Using the arch support requires several test case files.
So we would have file
  tools/perf/tests/attr/test-stat-default
with an arch = !s390x statement for all arch's that support it
and another fle
  tools/perf/tests/attr/test-stat-default-s390x
with an arch = s390x statement for 390x.

I am fine with this approach. If we all agree I can change the
patch and resend it.

Thanks Thomas
