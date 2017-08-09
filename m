From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/9] perf: test 15 fix test-stat-group tests
Date: Wed, 9 Aug 2017 17:15:59 +0200
Message-ID: <20170809151559.GB23060@krava>
References: <20170809064040.50899-1-tmricht@linux.vnet.ibm.com>
 <20170809064040.50899-3-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56337 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbdHIPQB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Aug 2017 11:16:01 -0400
Content-Disposition: inline
In-Reply-To: <20170809064040.50899-3-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com

On Wed, Aug 09, 2017 at 08:40:34AM +0200, Thomas Richter wrote:
> Both test-stat-group and test-stat-group1 fail.
> The reason is an invalid check for the read_format
> return code.  The submitted value is 15 and this
> value should be returned by the perf_event_open() call
> (which it is).
> The comparison however is done against an invalid
> value of 3.
> Fix this by setting the expected read_format value.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/attr/test-stat-group  | 2 ++
>  tools/perf/tests/attr/test-stat-group1 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/attr/test-stat-group b/tools/perf/tests/attr/test-stat-group
> index fdc1596..8fb3a50 100644
> --- a/tools/perf/tests/attr/test-stat-group
> +++ b/tools/perf/tests/attr/test-stat-group
> @@ -6,10 +6,12 @@ ret     = 1
>  [event-1:base-stat]
>  fd=1
>  group_fd=-1
> +read_format=15

I suppose this is on new kernel, which now support group read
it still passes on mine which doesn't supprot that ;-)

the fix needs to allow both values, so it works on older kernels, like:

read_format=3|15

thanks,
jirka
