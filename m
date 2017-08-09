From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/9] perf: test 15 fix python error on empty result
Date: Wed, 9 Aug 2017 12:39:21 +0200
Message-ID: <20170809103921.GA18900@krava>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbdHIKjX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 06:39:23 -0400
Content-Disposition: inline
In-Reply-To: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On Wed, Aug 09, 2017 at 08:40:32AM +0200, Thomas Richter wrote:
> Commit d78ada4a767 ("perf tests attr: Do not store failed events")
> does not create an event file in the /tmp directory when the
> perf_open_event() system call failed.
> This can lead to a situation where not /tmp/event-xx-yy-zz result
> file exists at all (for example on a s390x virtual machine environment)
> where no CPUMF hardware is available.

hi,
what's this patchset based on? I got 2nd patch failing to apply:

Applying: perf: test 15 fix python error on empty result
Applying: perf test: perf test case 15 result ignored
error: patch failed: tools/perf/tests/attr.c:166
error: tools/perf/tests/attr.c: patch does not apply
Patch failed at 0002 perf test: perf test case 15 result ignored

any chance you have this on a git repo somewhere?

thanks,
jirka
