From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/2] perf test attr: fix ignored test case result
Date: Thu, 28 Sep 2017 12:26:51 -0300
Message-ID: <20170928152651.GB7264@kernel.org>
References: <20170913081209.39570-1-tmricht@linux.vnet.ibm.com>
 <20170913081209.39570-2-tmricht@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753367AbdI1P0y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Sep 2017 11:26:54 -0400
Content-Disposition: inline
In-Reply-To: <20170913081209.39570-2-tmricht@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, jolsa@redhat.com, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com

Em Wed, Sep 13, 2017 at 10:12:09AM +0200, Thomas Richter escreveu:
> Command perf test -v 16 (Setup struct perf_event_attr test)
> always reports success even if the test case fails.
> It works correctly if you also specify -F (for don't fork).

So, now I'm getting:

[root@jouet ~]# uname -a
Linux jouet 4.13.0+ #3 SMP Mon Sep 25 11:51:22 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
[root@jouet ~]# perf test -vv 16
16: Setup struct perf_event_attr                          :
--- start ---
test child forked, pid 10932
running '/home/acme/libexec/perf-core/tests/attr/test-stat-group'
  'PERF_TEST_ATTR=/tmp/tmpI_lp9P /home/acme/bin/perf stat -o /tmp/tmpI_lp9P/perf.data --group -e cycles,instructions kill >/dev/null 2>&1' ret '1', expected '1'
expected read_format=3, got 15
FAILED '/home/acme/libexec/perf-core/tests/attr/test-stat-group' - match failure
test child finished with -1
---- end ----
Setup struct perf_event_attr: FAILED!
[root@jouet ~]#

Jiri?

- Arnaldo
 
>    root@s35lp76 perf]# ./perf test -v 16
>    15: Setup struct perf_event_attr               :
>    --- start ---
>    running './tests/attr/test-record-no-delay'
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 0.002 MB /tmp/tmp4E1h7R/perf.data
>      (1 samples) ]
>    expected task=0, got 1
>    expected precise_ip=0, got 3
>    expected wakeup_events=1, got 0
>    FAILED './tests/attr/test-record-no-delay' - match failure
>    test child finished with 0
>    ---- end ----
>    Setup struct perf_event_attr: Ok
> 
> The reason for the wrong error reporting is the return value of the
> system() library call. It is called in run_dir() file tests/attr.c
> and returns the exit status, in above case 0xff00.
> This value is given as parameter to the exit() function which
> can only handle values 0-0xff.
> The child process terminates with exit value of 0 and the parent
> does not detect any error.
> 
> This patch corrects the error reporting and prints the
> correct test result.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index c9aafed..25ede44 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -166,7 +166,7 @@ static int run_dir(const char *d, const char *perf)
>  	snprintf(cmd, 3*PATH_MAX, PYTHON " %s/attr.py -d %s/attr/ -p %s %.*s",
>  		 d, d, perf, vcnt, v);
>  
> -	return system(cmd);
> +	return system(cmd) ? TEST_FAIL : TEST_OK;
>  }
>  
>  int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
> -- 
> 2.9.3
