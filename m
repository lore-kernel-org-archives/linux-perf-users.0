Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01785495FB
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jan 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwozLKfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE0C433C7;
	Thu, 11 Jan 2024 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704988408;
	bh=scqdwrjRTf2KN7vabMEb+tsj5fbMIcldD0MhdeBn09U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwozLKfgQp0yt0PPFrfdX1dsJSSy4A+7BSAXu7D7UQZZu21L2P73DZy7r+5beaAHU
	 CL5dmaSpI+eAim4UBEHwM9xaizD5mrTVrAlOPMnNKBp+C5cEeXLj6CdXdlPURfmwun
	 uyfLqL0u70RHdwVpPITnlUxfMoK9d5qlYSWYbKlhAmn3LA1k9YDyXp8EdJ+MmpYwGs
	 xes3v+6bUxZuWMMtM4jDfSMSx+cZbM32dXKz143vdSPlG7noqnuRN6Dnq8o0kfBNpG
	 zhYICSn4idEeKhF+u4sBRezSPtbCvIXz/O+N2H+dFj0vp4POLYC6t09UoFDzCuKfxE
	 bSCpvAMS0Mo0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B7486403EF; Thu, 11 Jan 2024 12:53:25 -0300 (-03)
Date: Thu, 11 Jan 2024 12:53:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Getting PMU stats on specific syscalls
Message-ID: <ZaAO9cKhjbmTM0tJ@kernel.org>
References: <202401091452.B73E21B6C@keescook>
 <CA+JHD90kw0CX9=E18A7NBJrxdPDQuwrew355RV47oBhn_1s_QQ@mail.gmail.com>
 <01A077C8-95CA-4EBC-9504-CB971C284547@kernel.org>
 <ZZ32p0LRSt5-vFPX@kernel.org>
 <202401101640.21C835A8A@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401101640.21C835A8A@keescook>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 10, 2024 at 04:40:57PM -0800, Kees Cook escreveu:
> On Tue, Jan 09, 2024 at 10:45:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jan 09, 2024 at 05:04:54PM -0800, Kees Cook escreveu:
> > > On January 9, 2024 3:30:32 PM PST, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > >On Tue, Jan 9, 2024, 7:55 PM Kees Cook <keescook@chromium.org> wrote:
> > > >> I'd like to get PMU stats only on specific syscalls. I haven't been able
> > > >> to figure this out. i.e. how do I run:

> > > >>         perf stat -e some_syscall_name_here make -j128

> > > >> Try with the technique described here:

> > > >https://www.spinics.net/lists/linux-perf-users/msg09253.html

> > > >Using the syscalls:sys_enter_syscall_name and
> > > >syscalls:sys_exit_syscall_name as on off switches.

> > > Yeah, I can get walk-clock time, but I'm trying to get much more
> > > detailed stats (cache hits, cycle counts, etc).

> > > It seems I can only get PMU counts from a whole process. I was hoping
> > > to avoid creating a synthetic workload that only exercises the one
> > > syscall and instead get a view of the PMU counters under a real load
> > > but only for the duration of the syscall...
> > 
> > This is the sequence I thought would do what you want:
> 
> Oh cool! Thanks for the example. I will give this a shot.

Hope it helps, but adding support for perf stat to run while some
function runs seems like a great new feature to have, something like:

  perf stat --function FOO make -j128

That would enable the default events but would aggregate only when the
kernel function FOO runs (for userspace one would do -x /path/to/binary
as with 'perf probe') seems a great addition.

Similar, in implementation to using BPF in the tool below, that may be
of your interest as well

Using the function graph tracer:

root@number:~# perf ftrace latency -T schedule
^C#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |     318459 | ##########                                     |
     1 - 2    us |     455298 | ###############                                |
     2 - 4    us |     214732 | #######                                        |
     4 - 8    us |     154981 | #####                                          |
     8 - 16   us |     175314 | #####                                          |
    16 - 32   us |      19021 |                                                |
    32 - 64   us |       1066 |                                                |
    64 - 128  us |        502 |                                                |
   128 - 256  us |        435 |                                                |
   256 - 512  us |        219 |                                                |
   512 - 1024 us |       1188 |                                                |
     1 - 2    ms |        172 |                                                |
     2 - 4    ms |        262 |                                                |
     4 - 8    ms |        535 |                                                |
     8 - 16   ms |        788 |                                                |
    16 - 32   ms |        513 |                                                |
    32 - 64   ms |        379 |                                                |
    64 - 128  ms |         82 |                                                |
   128 - 256  ms |         65 |                                                |
   256 - 512  ms |        111 |                                                |
   512 - 1024 ms |         15 |                                                |
     1 - ...   s |          0 |                                                |
root@number:~#

Aggregating using BPF:

root@number:~# perf ftrace latency --use-bpf -T schedule
^C#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |      49377 | ###                                            |
     1 - 2    us |     169563 | ############                                   |
     2 - 4    us |     166872 | ############                                   |
     4 - 8    us |      90711 | ######                                         |
     8 - 16   us |      64548 | ####                                           |
    16 - 32   us |      77211 | #####                                          |
    32 - 64   us |       4567 |                                                |
    64 - 128  us |        486 |                                                |
   128 - 256  us |        339 |                                                |
   256 - 512  us |        174 |                                                |
   512 - 1024 us |        112 |                                                |
     1 - 2    ms |        602 |                                                |
     2 - 4    ms |         76 |                                                |
     4 - 8    ms |         65 |                                                |
     8 - 16   ms |        223 |                                                |
    16 - 32   ms |        315 |                                                |
    32 - 64   ms |        258 |                                                |
    64 - 128  ms |        175 |                                                |
   128 - 256  ms |         54 |                                                |
   256 - 512  ms |         42 |                                                |
   512 - 1024 ms |         63 |                                                |
     1 - ...   s |         35 |                                                |
root@number:~#

With a syscall:

root@number:~# perf ftrace latency -bT __x64_sys_write find /
<BIG find / output SNIP>
/var/www
/var/www/cgi-bin
/var/www/html
/var/yp
/var/.updated
/wb
#   DURATION     |      COUNT | GRAPH                                          |
     0 - 1    us |    5286452 | #######################                        |
     1 - 2    us |    5205312 | ######################                         |
     2 - 4    us |      35561 |                                                |
     4 - 8    us |       3852 |                                                |
     8 - 16   us |        957 |                                                |
    16 - 32   us |        281 |                                                |
    32 - 64   us |         54 |                                                |
    64 - 128  us |         37 |                                                |
   128 - 256  us |         20 |                                                |
   256 - 512  us |          6 |                                                |
   512 - 1024 us |          5 |                                                |
     1 - 2    ms |          4 |                                                |
     2 - 4    ms |          3 |                                                |
     4 - 8    ms |         44 |                                                |
     8 - 16   ms |        226 |                                                |
    16 - 32   ms |        742 |                                                |
    32 - 64   ms |        229 |                                                |
    64 - 128  ms |          9 |                                                |
   128 - 256  ms |          0 |                                                |
   256 - 512  ms |          0 |                                                |
   512 - 1024 ms |          0 |                                                |
     1 - ...   s |          0 |                                                |
root@number:~#

root@number:~# perf ftrace latency -h

 Usage: perf ftrace [<options>] [<command>]
    or: perf ftrace [<options>] -- [<command>] [<options>]
    or: perf ftrace {trace|latency} [<options>] [<command>]
    or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

    -b, --use-bpf         Use BPF to measure function latency
    -n, --use-nsec        Use nano-second histogram
    -T, --trace-funcs <func>
                          Show latency of given function

root@number:~#

The BPF code basically puts a kprobe at function entry and a kretprobe
at function exit, and goes on aggregating the time deltas, we would
instead do deltas on free running perf counters and at the end provide
it just like 'perf stat' does instead of the histogram above, the BPF is
straightforward:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/bpf_skel/func_latency.bpf.c

The userspace part just associates the function of interest to those the
kprobe (function entry) and kretprobe (function exit) BPF programs in
func_latency.bpf.c:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/bpf_ftrace.c#n86

- Arnaldo
