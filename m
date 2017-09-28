From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Ping for perf patches
Date: Thu, 28 Sep 2017 11:42:13 -0300
Message-ID: <20170928144212.GA7264@kernel.org>
References: <25eec9de-ec47-9651-9fde-3f73e27814f2@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbdI1OmQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Sep 2017 10:42:16 -0400
Content-Disposition: inline
In-Reply-To: <25eec9de-ec47-9651-9fde-3f73e27814f2@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>

Em Thu, Sep 28, 2017 at 08:48:16AM +0200, Thomas-Mich Richter escreveu:
> Hi all,
> 
> I recently posted a few patches, which probably got lost in the meantime:
> 
> These 2 are for the perf test attr (now test 16):
> 
> - [PATCH 1/2] perf test attr: fix python error on empty result
> - [PATCH 2/2] perf test attr: fix ignored test case result
> Both have been ack'ed by Jiri.
> 
> The next 2 are s390x specific changes I submitted back in July/August but
> need to be reverted and I submitted the reverting patches some week ago:
> 
> - [PATCH 1/2] perf test: fix vmlinux failure on s390x
> - [PATCH 2/2] perf test: fix vmlinux failure on s390x part 2
> 
> I am not sure if they are still in the review process or if they
> got lost? Should I resubmit them?

I'm procesing them now, sorry for the delay, I've been doing some other
activities, have a backlog of perf patches to review/test/process :-\

- Arnaldo
