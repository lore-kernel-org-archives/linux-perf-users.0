From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/2] perf test attr: fix python error on empty result
Date: Fri, 15 Sep 2017 20:45:03 +0200
Message-ID: <20170915184503.GA31734@krava>
References: <20170913081209.39570-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbdIOSpG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Sep 2017 14:45:06 -0400
Content-Disposition: inline
In-Reply-To: <20170913081209.39570-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

On Wed, Sep 13, 2017 at 10:12:08AM +0200, Thomas Richter wrote:
> Commit d78ada4a767 ("perf tests attr: Do not store failed events")
> does not create an event file in the /tmp directory when the
> perf_open_event() system call failed.
> This can lead to a situation where not /tmp/event-xx-yy-zz result
> file exists at all (for example on a s390x virtual machine environment)
> where no CPUMF hardware is available.

those 2 were already sent earlier if I'm not mistaken,
I think I've already acked them, if not:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
