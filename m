Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A83D6B;
	Fri,  7 Jun 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717718968; cv=none; b=cig8UAoxgVAfMKVXz6V1q30tqEgdfof/4+R1ztPicm0TpfPBgdpmKn8H6VAkrdeVHciJToxk+J5mtshSHj1yQP1xJsBiAkPcCWKzLZYwQY4Exsbd8jq57c+TPJbegbn9G3prnyhSZNxupdlDAWN0w+ZCDjVJPP0UrJHcjxnY2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717718968; c=relaxed/simple;
	bh=P43Z2erwmj8B2vWbpL7QxA/jRM327Bp3f0gHcM9G67E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anE6KNFePlF2CGrVFq5BGPdf/ZELBKBpTYYVenfTQTYNDcb9/UHJMt4fSUFX7+DzqJNB0wBmaVCY7szYH+yedqSp6lFKDiCaPtZV2Sjy5Ja6XnuzQuHzviwA4++/ASokFnoV5+FGzCR+CRGyNjzkbAZH7+PaOExVgjisYpLw/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJHEqC4J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJHEqC4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BAAC2BD10;
	Fri,  7 Jun 2024 00:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717718967;
	bh=P43Z2erwmj8B2vWbpL7QxA/jRM327Bp3f0gHcM9G67E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJHEqC4J7HehJfPWzhQ/cjyAHrYLtAV9X9BmAti3FrMgtKmj680wY62uULiAveCrC
	 rGyTDg8mg+sbhOL+PGPKHPuZPX+aZ5vAWgjSlQEzUwS9jNaCIIUverI2uuj/Mg5E6F
	 GF2v8OlqfdkRc4TWbZt6oFEMLMNUkns4ShGCST3E6oAkd7uFKopa0hFhsmuERO8Q1J
	 dE5xqlrqQSX56NZPGWHRfhPKHdbUSuYCyjzCs8t7nOpj+j37Hntt9dd36IUo8Rgv2I
	 +SIhe8S+ScFZgel8DRvx/d4r6LkYTKpgvhAZe1QTP1yaWGCkOLL/cFwUrkQjdRy7hf
	 +wJI8IUS/l5vg==
Date: Thu, 6 Jun 2024 17:09:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yicong Yang <yangyicong@huawei.com>, will@kernel.org,
	mark.rutland@arm.com, acme@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	james.clark@arm.com, dongli.zhang@oracle.com,
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
	linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH 1/3] perf pmu: Limit PMU cpumask to online CPUs
Message-ID: <ZmJPtZvWr3kgx4xF@google.com>
References: <20240603092812.46616-1-yangyicong@huawei.com>
 <20240603092812.46616-2-yangyicong@huawei.com>
 <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com>

Hello,

On Mon, Jun 03, 2024 at 09:52:15AM -0700, Ian Rogers wrote:
> On Mon, Jun 3, 2024 at 2:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
> >
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > We'll initialize the PMU's cpumask from "cpumask" or "cpus" sysfs
> > attributes if provided by the driver without checking the CPUs
> > are online or not. In such case that CPUs provided by the driver
> > contains the offline CPUs, we'll try to open event on the offline
> > CPUs and then rejected by the kernel:
> >
> > [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> > [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --timeout 100
> > Error:
> > The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
> > /bin/dmesg | grep -i perf may provide additional information.
> >
> > So it's better to do a double check in the userspace and only include
> > the online CPUs from "cpumask" or "cpus" to avoid opening events on
> > offline CPUs.
> 
> I see where you are coming from with this but I think it is wrong. The
> cpus for an uncore PMU are a hint of the CPU to open on rather than
> the set of valid CPUs. For example:
> ```
> $ cat /sys/devices/uncore_imc_free_running_0/cpumask
> 0
> $ perf stat -vv -e uncore_imc_free_running_0/data_read/ -C 1 -a sleep 0.1
> Using CPUID GenuineIntel-6-8D-1
> Attempt to add: uncore_imc_free_running_0/data_read/
> ..after resolving event: uncore_imc_free_running_0/event=0xff,umask=0x20/
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff (data_read)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off cloexec flag
> ------------------------------------------------------------
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff (data_read)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0
> sys_perf_event_open failed, error -22
> switching off exclude_guest, exclude_host
> ------------------------------------------------------------
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff (data_read)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 3
> uncore_imc_free_running_0/data_read/: 1: 4005984 102338957 102338957
> uncore_imc_free_running_0/data_read/: 4005984 102338957 102338957
> 
>  Performance counter stats for 'system wide':
> 
>             244.51 MiB  uncore_imc_free_running_0/data_read/
> 
>        0.102320376 seconds time elapsed
> ```
> So the CPU mask of the PMU says to open on CPU 0, but on the command
> line when I passed "-C 1" it opened it on CPU 1. If the cpumask file
> contained an offline CPU then this change would make it so the CPU map
> in the tool were empty, however, a different CPU may be programmable
> and online.

I think Intel uncore PMU driver ignores the CPU parameter and set it to
CPU 0 in this case internally.  See uncore_pmu_event_init() at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/uncore.c#n761

> 
> Fwiw, the tool will determine whether the mask is for all valid or a
> hint by using the notion of a PMU being "core" or not. That notion
> considers whether the mask was loading from a "cpumask" or "cpus"
> file:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n810
> 
> Thanks,
> Ian
> 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  tools/perf/util/pmu.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 888ce9912275..51e8d10ee28b 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -771,8 +771,17 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, const char *name, bool is_cor
> >                         continue;
> >                 cpus = perf_cpu_map__read(file);
> >                 fclose(file);
> > -               if (cpus)
> > -                       return cpus;
> > +               if (cpus) {
> > +                       struct perf_cpu_map *intersect __maybe_unused;
> > +
> > +                       if (perf_cpu_map__is_subset(cpu_map__online(), cpus))
> > +                               return cpus;
> > +
> > +                       intersect = perf_cpu_map__intersect(cpus, cpu_map__online());

So IIUC this is for core PMUs with "cpus" file, right?  I guess uncore
drivers already handles "cpumask" properly..

Thanks,
Namhyung


> > +                       perf_cpu_map__put(cpus);
> > +                       if (intersect)
> > +                               return intersect;
> > +               }
> >         }
> >
> >         /* Nothing found, for core PMUs assume this means all CPUs. */
> > --
> > 2.24.0
> >
