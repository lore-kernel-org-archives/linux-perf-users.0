Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B24D5AD;
	Wed, 22 Nov 2023 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqMGV6Ef"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772B4C433C8;
	Wed, 22 Nov 2023 16:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700669977;
	bh=fouog/Xb7wmwXW9eFuP6KgCbqL6WmR1O6M7kQuJhWRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqMGV6EfEclqRNWCP+8zvwiNVrs9/jewshE2jdobpwzZOvYzLAA57vSv0bb5eEe/A
	 3JwUawXzlZH+nTNsdhrQMpo0t1/vrDMjxl1KV50f9iL13JtOGbr26fPVu32ub7znQ2
	 MJ1nIpUJyLnUS5xGHBCS6kTrs+9u7OjFZuIVUGsVCdTmRsmOYw/937EdZEO9qn8KfP
	 TJQSPnunjvP3/sYm+l8UbUOuEkIv/0XSuY2yeRZi+omlhZEjpHVmdnxbapVKuXS1iQ
	 WVvZ7b8F3ztS34kf/0OQw47W0mblcJ6Yi+UEGvUf9NRNFwyoEqUZ7VTFXqximBCAeM
	 LL2BytudzMJMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D606840094; Wed, 22 Nov 2023 13:19:34 -0300 (-03)
Date: Wed, 22 Nov 2023 13:19:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Hector Martin <marcan@marcan.st>, Ian Rogers <irogers@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV4qFtFctJ9emXvd@kernel.org>
References: <86o7fnyvrq.wl-maz@kernel.org>
 <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <930bfb9a-dcbe-4385-9ae3-26e2aa14c50e@marcan.st>
 <ZV38z3+p2S2ETtzG@kernel.org>
 <ZV4i_lrhbOVdEpwH@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV4i_lrhbOVdEpwH@FVFF77S0Q05N>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 22, 2023 at 03:49:18PM +0000, Mark Rutland escreveu:
> On Wed, Nov 22, 2023 at 10:06:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > The point is that "cycles" when prefixed with "pmu/" shouldn't be
> > considered "cycles" as HW/0, in that setting it is "cycles" for that
> > PMU.
 
> Exactly.
 
> > (but we only have "cpu_cycles" for at least the a53 and a72 PMUs I
> > have access in a Libre Computer rockchip 3399-pc hybrid board, if we use
> > it, then we get what we want/had before, see below):
 
> Both Cortex-A53 and Cortex-A72 have the common PMUv3 events, so they have
> "cpu_cycles" and "bus_cycles".

root@roc-rk3399-pc:~# ls -la /sys/devices/*/events/*cycles
-r--r--r-- 1 root root 4096 Nov 22 12:35 /sys/devices/armv8_cortex_a53/events/bus_cycles
-r--r--r-- 1 root root 4096 Nov 22 12:35 /sys/devices/armv8_cortex_a53/events/cpu_cycles
-r--r--r-- 1 root root 4096 Nov 22 12:35 /sys/devices/armv8_cortex_a72/events/bus_cycles
-r--r--r-- 1 root root 4096 Nov 22 12:35 /sys/devices/armv8_cortex_a72/events/cpu_cycles
root@roc-rk3399-pc:~#

But on x86, on a AMD machine:

⬢[acme@toolbox ~]$ ls -la /sys/devices/*/events/*cycles
-r--r--r--. 1 nobody nobody 4096 Nov 22 12:48 /sys/devices/cpu/events/cpu-cycles
⬢[acme@toolbox ~]$

And an Intel:

[acme@quaco asahi]$ ls -la /sys/devices/*/events/*cycles
-r--r--r--. 1 root root 4096 Nov 22 13:11 /sys/devices/cpu/events/bus-cycles
-r--r--r--. 1 root root 4096 Nov 22 13:11 /sys/devices/cpu/events/cpu-cycles
-r--r--r--. 1 root root 4096 Nov 22 13:11 /sys/devices/cpu/events/ref-cycles
[acme@quaco asahi]$

Slight difference with those - and _.
 
> The Apple PMUs that Hector and Marc anre using don't follow the PMUv3
> architecture, and just have a "cycles" event.

I see, and even being prefixed with the PMU name, as
"apple_icestorm_pmu/cycles/" it ends up trumping that and moving that to
(PERF_TYPE_HARDWARE, PERF_HW_CPU_CYCLES) instead of
(/sys/devices/apple_icestorm_pmu/events/type,
/sys/devices/apple_icestorm_pmu/events/cycles) as I noticed with:

sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x7<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)

I.e.:

type=PERF_TYPE_HARDWARE, config=0x7<<32|PERF_COUNT_HW_CPU_CYCLES

It should be:

type=/sys/devices/apple_icestorm_pmu/events/type, config=/sys/devices/apple_icestorm_pmu/events/cycles

That is the minimal patch to address the regression reported, even if
using some kludge to buy time for a longer term more elegant solution,
Ian?

> [...]
 
> > So what we need here seems to be to translate the generic term "cycles"
> > to "cpu_cycles" when a PMU is explicitely passed in the event name and
> > it doesn't have "cycles" and then just retry.
> 
> I'm not sure we need to map that.
> 
> My thinking is:
> 
> * If the user asks for "cycles" without a PMU name, that should use the
>   PERF_TYPE_HARDWARE cycles event. The ARM PMUs handle that correctly when the
>   event is directed to them.
> 
> * If the user asks for "${pmu}/cycles/", that should only use the "cycles"
>   event in that PMU's namespace, not PERF_TYPE_HARDWARE.

And thus, armv8_cortex_a53/cycles/ and armv8_cortex_a72/cycles/ should
just fail as there is no "cycles" for that PMU, no fallback.
 
> * If we need a way so say "use the PERF_TYPE_HARDWARE cycles event on ${pmu}",
>   then we should have a new syntax for that (e.g. as we have for raw events),
>   e.g. it would be possible to have "pmu/hw:cycles/" or something like that.
> 
> That way there's no ambiguity.

- Arnaldo
