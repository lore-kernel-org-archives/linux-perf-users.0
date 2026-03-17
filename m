Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1E23D28C;
	Tue, 17 Mar 2026 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776364; cv=none; b=ZNe+zmUMSmoZFfKj5YWdxUjBea86uocPCUCO58TW2gX1nzHoMTSVHMCgaaapJXEi3o+akFroEOGa2CFErVvpJje8+11PYieHo7yn71lknMqE8arMFssxggvL4LMaiSy/Q4SW1Afel9/H56abXFk/tzovmZXLRSgLiF0c+Mdrf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776364; c=relaxed/simple;
	bh=Gu7ohhgHsJOJY52IIWi20GSPxiRAjEvUCvJ6WIVJM94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRRZMu459LSJob79V3p4MgOQgVx8iTHc9TKq7smVauWd+Ukurus3jLkAiZbQMcjVfrrJptYjsai+z1KvDeGFJa+YnS5o6Hx3lRwAx/O4RS34DOuxUfsBQJihJDh2fR3iiiV6+rQ0P1EbV1I2jFeAxrVDyxr5dHIrI6RLl1HWSLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwzr+IUX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwzr+IUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A2C4CEF7;
	Tue, 17 Mar 2026 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776364;
	bh=Gu7ohhgHsJOJY52IIWi20GSPxiRAjEvUCvJ6WIVJM94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwzr+IUXcIMfVQ+9jJph7veTUVTKBY9O0Mbdra1h+SGACf0CtqMIWZvbYqemLfCzM
	 hj7D5TUIHa70c9crj2j/jQmDQSipCX3jRsI3i0dOX2/a6cMYYcSwa/L1olZA14XhcH
	 lEQqnioSe767cVu8SHL5iURSBQBkWq4S1pczKT5b8AG/p5f9Vtpe8JUOamNPwUU6Id
	 qR2i4i91jVv+hqpOrViN76YDuvK8fl2VnlWuRbnV1C/RpSPFJAgs1oP4pcORg8glcM
	 cjEfFdB1fEmqpaqS94conD2ct+G7dKJVMK1lr5xwrcE6bpYxzA3FGjiib/FtU3iFKE
	 rHempnQ2Bk6cQ==
Date: Tue, 17 Mar 2026 16:39:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, Jan Polensky <japo@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf stat issue with 7.0.0rc3
Message-ID: <abmt6FhLfWrzWGwU@x1>
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1>
 <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>

On Fri, Mar 13, 2026 at 08:41:48AM -0700, Ian Rogers wrote:
> On Fri, Mar 13, 2026 at 8:19 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Fri, Mar 13, 2026 at 02:13:18PM +0100, Thomas Richter wrote:
> > > I just discovered a strange behavior on linux 7.0.0rc3.
> > > This is the epected output, however when I use the perf version 7.0.0rc3:

> > > bash-5.3# ./perf -v
> > > perf version 7.0.rc3.g1f318b96cc84
> > > bash-5.3# ./perf stat -- true
> > > Error:
> > > No supported events found.
> > > trace.args_alignment

> > And this last line is even stranger, in my case I get something else,
> > also on x86_64:

> > root@number:~#  perf stat -- true
> > Error:
> > No supported events found.
> > addr2line.style
> > root@number:~#

> > On an ARM machine:

> > acme@raspberrypi:~/git/perf-tools $ perf stat -- true
> > Error:
> > No supported events found.

> > acme@raspberrypi:~/git/perf-tools $ uname -a
> > Linux raspberrypi 6.12.62+rpt-rpi-2712 #1 SMP PREEMPT Debian 1:6.12.62-1+rpt1 (2025-12-18) aarch64 GNU/Linux
> > acme@raspberrypi:~/git/perf-tools $

> > I'll try to bisect this later, thanks for the report!
 
> Hi Arnaldo,
 
> Leo has pointed at the fix:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/metricgroup.c?h=perf-tools-next&id=c5a244bf17caf2de22f9e100832b75f72b31d3e6
> This also showed up as missing for the LTS backports:
> https://lore.kernel.org/lkml/ad95d781-7eb2-4c0c-a9e9-aaabae8eb602@kernel.org/
> so I thought it was flagged as a fix for the next PR. I don't see it in there:
> https://lore.kernel.org/lkml/20260313151434.1695228-1-acme@kernel.org/
> Could we get it in?

So, I applied the one Leo pointed out and got this:

root@number:~# perf stat sleep 1

 Performance counter stats for 'sleep 1':

                 1      context-switches                 #   3509.1 cs/sec  cs_per_second
                 0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
                75      page-faults                      # 263181.0 faults/sec  page_faults_per_second
              0.28 msec task-clock                       #      0.0 CPUs  CPUs_utilized
             8,018      branch-misses                    #      4.2 %  branch_miss_rate
           191,108      branches                         #    670.6 M/sec  branch_frequency
           870,234      cpu-cycles                       #      3.1 GHz  cycles_frequency
     <not counted>      instructions                     #      nan instructions  insn_per_cycle  (0.00%)
     <not counted>      stalled-cycles-frontend          #      nan frontend_cycles_idle        (0.00%)

       1.001839832 seconds time elapsed

       0.000727000 seconds user
       0.000000000 seconds sys


Some events weren't counted. Try disabling the NMI watchdog:
	echo 0 > /proc/sys/kernel/nmi_watchdog
	perf stat ...
	echo 1 > /proc/sys/kernel/nmi_watchdog
root@number:~#  echo 0 > /proc/sys/kernel/nmi_watchdog


Which is strange, in the past (see below) instructions and
stalled-cycles-frontend were counted in the default (no -e) 'perf stat'
set of events, now if I disable the nmi_watchdog I get 'instructions'
back, but not 'stalled-cycles-frontend':


root@number:~# perf stat sleep 1

 Performance counter stats for 'sleep 1':

                 1      context-switches                 #   6524.7 cs/sec  cs_per_second
                 0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
                71      page-faults                      # 463256.0 faults/sec  page_faults_per_second
              0.15 msec task-clock                       #      0.0 CPUs  CPUs_utilized
             7,484      branch-misses                    #      4.0 %  branch_miss_rate
           186,108      branches                         #   1214.3 M/sec  branch_frequency
           810,475      cpu-cycles                       #      5.3 GHz  cycles_frequency
           893,290      instructions                     #      1.1 instructions  insn_per_cycle
     <not counted>      stalled-cycles-frontend          #      nan frontend_cycles_idle        (0.00%)

       1.000382345 seconds time elapsed

       0.000443000 seconds user
       0.000000000 seconds sys


If I go back to v6.18 (will try a bisect to see exactly where this
happens), I get the events above, with a different printing order, but
'instructions' and 'stalled-cycles-frontend' successfully counts:

root@number:~# perf -v
perf version 6.18.g7d0a66e4bb90
root@number:~# perf stat sleep 1

 Performance counter stats for 'sleep 1':

           202,103      task-clock                       #    0.000 CPUs utilized
                 1      context-switches                 #    4.948 K/sec
                 0      cpu-migrations                   #    0.000 /sec
                71      page-faults                      #  351.306 K/sec
           895,485      instructions                     #    0.85  insn per cycle
                                                  #    0.56  stalled cycles per insn
         1,048,898      cycles                           #    5.190 GHz
           504,794      stalled-cycles-frontend          #   48.13% frontend cycles idle
           186,002      branches                         #  920.333 M/sec
             7,857      branch-misses                    #    4.22% of all branches

       1.000537221 seconds time elapsed

       0.000542000 seconds user
       0.000000000 seconds sys


root@number:~#

Trying bisection now.

- Arnaldo
