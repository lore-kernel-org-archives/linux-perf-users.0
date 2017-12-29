From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/2] perf-probe: Improve warning message for buildid
 mismatch
Date: Fri, 29 Dec 2017 11:52:48 +0900
Message-ID: <20171229115248.51bec125a52f84df690f650c@kernel.org>
References: <151358211494.25261.16134489192749792799.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752196AbdL2Cwv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Dec 2017 21:52:51 -0500
In-Reply-To: <151358211494.25261.16134489192749792799.stgit@devbox>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Hello Arnaldo,

Could you review it?

Thank you,

On Mon, 18 Dec 2017 16:28:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hello,
> 
> This series ensure the build-ids for target binary and debuginfo
> are matched. If there is a mismatch, it warns user to check the
> package versions.
> 
> To reproduce the problematic environment (on Fedora26),
> I did following operations;
> 
>   =====
>   # rpm -q glibc glibc-debuginfo
>   glibc-2.25-12.fc26.x86_64
>   package glibc-debuginfo is not installed
> 
>   # dnf debuginfo-install glibc
>   [...]
>   Installed:
>     glibc-debuginfo.x86_64 2.25-12.fc26
>     glibc-debuginfo-common.x86_64 2.25-12.fc26
> 
>   Complete!
> 
>   # dnf downgrade glibc        
>   [...]
>   Downgraded:
>     glibc.x86_64 2.25-6.fc26                 glibc-common.x86_64 2.25-6.fc26   
>     glibc-devel.x86_64 2.25-6.fc26           glibc-headers.x86_64 2.25-6.fc26  
>     glibc-langpack-en.x86_64 2.25-6.fc26     libcrypt-nss.x86_64 2.25-6.fc26   
> 
>   Complete!
> 
>   # rpm -q glibc glibc-debuginfo
>   glibc-2.25-6.fc26.x86_64
>   glibc-debuginfo-2.25-12.fc26.x86_64
>   =====
> 
> OK, so you can see now we have different versions of glibc and
> glibc-debuginfo. Each debuginfo must be different.
> 
> With this series, defining new events also warns :)
> 
>   =====
>   # perf probe -x /usr/lib64/libc-2.25.so -a malloc_get_state\\@GLIBC_2.2.5
>   WARN: There is a build-id mismatch between
>    /usr/lib/debug/usr/lib64/libc-2.25.so.debug
>    and
>    /usr/lib64/libc-2.25.so
>   Please check your system's debuginfo files for mismatches, e.g. check the versions for the target package and debuginfo package.
>   Added new event:
>     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
> 
>   You can now use it in all perf tools, such as:
> 
> 	  perf record -e probe_libc:malloc_get_state -aR sleep 1
> 
>   =====
> 
> And listing up events warns.
> 
>   =====
>   # perf probe -l | more
>   WARN: There is a build-id mismatch between
>    /usr/lib/debug/usr/lib64/libc-2.25.so.debug
>    and
>    /usr/lib64/libc-2.25.so
>   Please check your system's debuginfo files for mismatches, e.g. check the versions for the target package and debuginfo package.
>     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
>   =====
> 
> With [1/2], this warning messages repeated on same target (glibc). To suppress
> this, [2/2] introduces no-debuginfo blacklist to skip it 2nd time as below.
> 
>   =====
>   # perf probe -l | more
>   WARN: There is a build-id mismatch between
>    /usr/lib/debug/usr/lib64/libc-2.25.so.debug
>    and
>    /usr/lib64/libc-2.25.so
>   Please check your system's debuginfo files for mismatches, e.g. check the versions for the target package and debuginfo package.
>     probe_libc:malloc_get_state (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_get_state_1 (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
>     probe_libc:malloc_get_state_2 (on malloc_get_state@GLIBC_2.2.5 in /usr/lib64/libc-2.25.so)
>   =====
> 
> Arnaldo, would this match to your request?
> 
> 
> Thank you,
> ---
> 
> Masami Hiramatsu (2):
>       perf-probe: Ensure debuginfo's build-id is correct
>       perf-probe: Skip searching debuginfo if we know no debuginfo
> 
> 
>  tools/perf/util/probe-finder.c |   34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> --
> Masami Hiramatsu (Linaro Ltd.) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
