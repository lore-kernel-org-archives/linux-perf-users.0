Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5705802;
	Fri,  7 Jun 2024 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719432; cv=none; b=qS59/2zvDRMwj1k3b+DX/rxsFdtJhkSsD4TARkLYtE48hhz2xdPczwMlXg9kmk3JpRZnomuZnTbe3Z7n0F5VIzdnubYKdtfhe69OjTajY/heMpQne48xuFZwU1EapIpU7A4VsQUtsslm7eO3bHruG6zm81NUae5qGUAOXDkULwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719432; c=relaxed/simple;
	bh=zQyKFE7i3cSnb1OcKCL8pH1n8i1hiqh2qkfclisckRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJI1M+p0opmEtxkzpmmWEmLWLmrXm2EdyhlkSWl/tQMDDg7w2pMXLwmhMQLJMQpyKzpFgkD8it9BJBxJ+OiI6bHnQi0mb3DISf/hnXmyK4uBcohpHwWlR5/09aoa6quDuUuYVHx1YcZjcxZ0S2bRRmYUIm51pjRQvg16Akxtnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5v1hJaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5v1hJaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB558C32781;
	Fri,  7 Jun 2024 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717719431;
	bh=zQyKFE7i3cSnb1OcKCL8pH1n8i1hiqh2qkfclisckRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5v1hJaMVcxxJxKaKAhyIdyWRWgcXppCMx72DrHAE3ph3cyX8WUj8TG5fi21RfNnV
	 nqlcuOaYbrDA73MFi3+j+MgwgYVAmxT8wjhTfj4iyfuIfxcH0AaXkntfrW/Bew2GpS
	 L94Rl9iBv4DdxuLC4WilcJNjAwZ+667u9PuHXW+OTKV+WnbR6sWu811PDE7vaJ/+aN
	 e3ay6Cdd+Z9+zbYm9N8pAeIUW/t58m0xZk3Y/uEbND+AiWCXMAO4uZDv0/ZtGm2qZ1
	 pNYYY5DwNZyX+bO2M/yYpMJxYlU+8JiTtFFXVfBrB2lKUfZQM6I0w3UHk7CZg9qOH/
	 gWZAqvlRLTQXw==
Date: Thu, 6 Jun 2024 17:17:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Ian Rogers <irogers@google.com>, yangyicong@hisilicon.com,
	will@kernel.org, mark.rutland@arm.com, acme@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	james.clark@arm.com, dongli.zhang@oracle.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH 2/3] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
Message-ID: <ZmJRhSWYxb-zLAhD@google.com>
References: <20240603092812.46616-1-yangyicong@huawei.com>
 <20240603092812.46616-3-yangyicong@huawei.com>
 <CAP-5=fXDPor-WsO-TGB3z6QpSWZOFJC31GJpuwZUA3qz_3WsYQ@mail.gmail.com>
 <b348d9dd-75cb-6b83-a4be-cfd29e15eb99@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b348d9dd-75cb-6b83-a4be-cfd29e15eb99@huawei.com>

On Tue, Jun 04, 2024 at 03:43:35PM +0800, Yicong Yang wrote:
> Hi Ian,
> 
> On 2024/6/4 0:20, Ian Rogers wrote:
> > On Mon, Jun 3, 2024 at 2:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
> >>
> >> From: Yicong Yang <yangyicong@hisilicon.com>
> >>
> >> When there're CPUs offline after system booting, perf will failed:
> >> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
> >> Error:
> >> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
> >> /bin/dmesg | grep -i perf may provide additional information.
> > 
> > Thanks for debugging this Yicong! The fact cycles is falling back on
> > cpu-clock I'm confused by, on ARM the PMU type generally isn't
> > PERF_TYPE_HARDWARE and so this fallback shouldn't happen:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n2900
> > I note your command line is for system wide event opening rather than
> > for a process. It is more strange the fallback is giving "No such
> > device".
> > 
> >> This is due to PMU's "cpus" is not updated and still contains offline
> >> CPUs and perf will try to open perf event on the offlined CPUs.
> > 
> > The perf tool will try to only open online CPUs. Unfortunately the
> > naming around this is confusing:
> > 
> > - any - an event may follow a task and schedule on "any" CPU. We
> > encode this with -1.
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n24
> > - online - the set of online CPU.
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n33
> > - all - I try to avoid this but it may still be in the code, "all"
> > usually is another name for online. Hopefully when we use this name it
> > is clearly defined:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/internal/evlist.h?h=perf-tools-next#n23
> > 
> >> Make "cpus" attribute only shows online CPUs and introduced a new
> >> "supported_cpus" where users can get the range of the CPUs this
> >> PMU supported monitoring.
> > 
> > I don't think this should be necessary as by default the CPUs the perf
> > tool will use will be the "online" CPUs:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/evlist.c?h=perf-tools-next#n40
> > 
> > Could you create a reproduction of the problem you are encountering?
> > My expectation is for a core PMU to advertise the online and offline
> > CPUs it is valid for, and for perf to intersect:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n44
> > those CPUs with the online CPUs so the perf_event_open doesn't fail.
> > 
> 
> Thanks for the comments and detailed illustration!
> 
> Actually it can be reproduced easily using the armv8_pmuv3's events. Tested on 6.10-rc1 with
> perf version 6.10.rc1.g1613e604df0c:
> # offline any CPU
> [root@localhost tmp]# echo 0 > /sys//devices/system/cpu/cpu1/online
> # try any event of armv8_pmuv3, with -a or without
> [root@localhost tmp]# ./perf stat -e armv8_pmuv3_0/ll_cache/ -vvv
> Control descriptor is not initialized
> Opening: armv8_pmuv3_0/ll_cache/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             10 (armv8_pmuv3_0)
>   size                             136
>   config                           0x32 (ll_cache)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
> Opening: armv8_pmuv3_0/ll_cache/
> ------------------------------------------------------------
> perf_event_attr:
>   type                             10 (armv8_pmuv3_0)
>   size                             136
>   config                           0x32 (ll_cache)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -19
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for event (armv8_pmuv3_0/ll_cache/).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> As you can see, we're trying to open event on CPU 0 first (succeed) and then CPU 1 but
> failed on CPU1. Actually we don't enter any branch which handle the evsel->cpus in
> __perf_evlist__propagate_maps() so the evsel->cpus keeps as is which should be initialized
> from the pmu->cpumask. You referenced to [1] but in this case perf_evsel->system_wide == false
> as I checked. perf_evsel->system_wide will set to true in perf_evlist__go_system_wide() and it
> maybe only set for dummy events. Please correct me if I misread here.

Yes, this is confusing.  IIRC evsel->system_wide is for tracking (dummy)
events to collect side band events (like for Intel-PT) regardless of
command line options (like -a or -C).

Thanks,
Namhyung

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/evlist.c?h=perf-tools-next#n40
> 
> Thanks.
> 
