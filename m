From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Per thread sampling
Date: Thu, 20 Feb 2014 09:04:18 +0100
Message-ID: <20140220080418.GA1122@krava.brq.redhat.com>
References: <CALbiyZwOjpfppitvPgJkHa8=L9XhD0Bq9d0sxgucMBo6tukk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510AbaBTIEX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 20 Feb 2014 03:04:23 -0500
Content-Disposition: inline
In-Reply-To: <CALbiyZwOjpfppitvPgJkHa8=L9XhD0Bq9d0sxgucMBo6tukk=Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, Feb 19, 2014 at 04:00:45PM +0100, Manuel Selva wrote:
> Hi all,
> 
> I just tried in a 2-threaded application to call twice (one call for
> each thread) perf_event_open syscall with parameters configured to do
> sampling on MEM INST RETIRED.LATENCY ABOVE THRESHOLD event. Both call
> succeed.
> 
> "mmaping" the file descriptor return by the first call succeed but
> "mmaping" the second file descriptor results in a "Operation not
> permitted" error (errno = 1).

seems like you might have crossed the perf mem user limit?

[jolsa@krava ~]$ sysctl kernel.perf_event_mlock_kb 
kernel.perf_event_mlock_kb = 516

you can either split the memory amount between those
threads or you can increase that limit.. or run your
app under root ;-)

jirka

>mit 
> A work around could be to sample all threads (with pid = -1) including
> pid and tid in samples and filter samples at processing time. Before
> switching to this solution I wanted to ask if this a known limitation
> of the syscall, an error from my side, or a bug  (the man page doesn't
> answer to this question) ?
> 
> Thanks,
> 
> Manu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
