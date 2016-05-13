From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [Perfapi-devel] Lack of aarch64 checks for perf events
 schedulability
Date: Fri, 13 May 2016 13:58:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1605131345560.19648@macbook-air>
References: <5ce079ab-2a31-36f1-713a-8b355888e73d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36837 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbcEMR6l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 13:58:41 -0400
Received: by mail-io0-f196.google.com with SMTP id k129so16059181iof.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2016 10:58:40 -0700 (PDT)
In-Reply-To: <5ce079ab-2a31-36f1-713a-8b355888e73d@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org, PAPI Developers <perfapi-devel@cs.utk.edu>, Michael Petlan <mpetlan@redhat.com>

On Fri, 13 May 2016, William Cohen wrote:

> When running the PAPI testsuite on RHEL for aarch64 Michael Petlan
> found that the test overflow_allcounters was failing.  I investigated
> and it looks like the the RHEL for aarch64 linux kernel perf support
> suffers from a problem similar to MIPS kernels where perf_event_open
> doesn't properly check that events can be scheduled together; then a
> later read of the counters will fail.  This has been observed on the
> RHEL for aarch64 4.5.0 based kernel. I have not tried this on the
> latest kernel, so I don't know if this is still a problem with newer
> kernels.

Let me see, yes I can reproduce this on my arm64 dragonboard running Linux 
3.16.

Your fix does fix things in that the test runs but it fails for other 
reasons at the validation stage.

Only 6 out of 7 counters are used, but it's picking a weird set of 
counters to use for the test.  I forget what overflow_allcounters actually
does.

I doubt it's worth the trouble of trying to get this fixed at the Linux 
level but it would be interesting to see why the 7th counter can't be 
scheduled.

Vince
