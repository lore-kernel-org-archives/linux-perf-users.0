From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: fix test case probe libc's inet_pton on s390x
Date: Tue, 14 Nov 2017 10:47:24 -0300
Message-ID: <20171114134724.GP8836@kernel.org>
References: <20171114071847.2381-1-tmricht@linux.vnet.ibm.com>
 <20171114071847.2381-2-tmricht@linux.vnet.ibm.com>
 <20171114132625.GM8836@kernel.org>
 <20171114133409.GN8836@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbdKNNr1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Nov 2017 08:47:27 -0500
Content-Disposition: inline
In-Reply-To: <20171114133409.GN8836@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Em Tue, Nov 14, 2017 at 10:34:09AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Different name, same contents, need to look at the inode... ;-\
> 
> Nah, lets ask the kernel how is it that it sees libc, please test the
> following, works for me:

BTW, this is what I sticked on that cset:

    Committer changes:
    
    We can't really use ldd for libc, as in some systems, such as x86_64, it
    has hardlinks and then ldd sees one and the kernel the other, so grep
    for libc in /proc/self/maps to get the one we'll receive from
    PERF_RECORD_MMAP.

- Arnaldo
 
> diff --git a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> index 7a84d73324e3..8b3da21a08f1 100755
> --- a/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> @@ -10,8 +10,8 @@
>  
>  . $(dirname $0)/lib/probe.sh
>  
> -ld=$(realpath /lib64/ld*.so.* | uniq)
> -libc=$(echo $ld | sed 's/ld/libc/g')
> +libc=$(grep -w libc /proc/self/maps | head -1 | sed -r 's/.*[[:space:]](\/.*)/\1/g')
> +nm -g $libc 2>/dev/null | fgrep -q inet_pton || exit 254
>  
>  trace_libc_inet_pton_backtrace() {
>  	idx=0
> @@ -37,6 +37,9 @@ trace_libc_inet_pton_backtrace() {
>  	done
>  }
>  
> +# Check for IPv6 interface existence
> +ip a sh lo | fgrep -q inet6 || exit 2
> +
>  skip_if_no_perf_probe && \
>  perf probe -q $libc inet_pton && \
>  trace_libc_inet_pton_backtrace
