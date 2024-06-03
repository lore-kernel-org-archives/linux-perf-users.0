Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAC4A0A
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Jun 2024 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433549; cv=none; b=emD3JsHSZDCT3scQ7Q2DnfCU9SFt/I9rNplj5KVrlkF3rdBTl2HkGCrZ8Q5MChF4lSAqm9S1OA1F2l+8/Ftif052VmSw0Mqal1Mx4d0m9Gop1dATThCwAQOJdUwhvuHcFUhPBoB6gyRo509/qFh+me4TlDzJHCeZ3JpFIkPMJl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433549; c=relaxed/simple;
	bh=7bbMMx35Lkzpu2sIpK2fSOilM52beTXlFemB8pNEi7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddesJw4fgncw0Nc042xLNYZtOgZKDOebGAdVQBqrpvnfKPesIveX2X48P7FgftHXnsLTG6uX/ALxxUT43MZMBntZehqiZFOpIxBRs+1gSOFcGBnq3i9o4Nvzdds6EtVbIpp+8Gmbm76PHU6pJQVFJCR71MaFNdljgXMSuNsS1DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nm7PsrVv; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nm7PsrVv"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3748a185da1so2805ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jun 2024 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717433547; x=1718038347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJcLm5ZpSkzvbycg4N/ncJTb6gnjJ0KZfkcYCAHjp+4=;
        b=nm7PsrVvgvl7nuW3kPwH7oCYnVVVcRKZ4O4l5ob8DM2HtaQ1Tq2LJ7765kzVF8t0CN
         ZYaHm1LU+IOL9AcrAOMgRi8Yy2KyzWFD8SuN2voGKSqJkodKV6I0dSNn575DJuJTgOqm
         YG1yS2FlEkNVe5ZBwYprpMNYBA4H8hQnDskZo5CSKstTy3TZqCL1AGN4jQAMvBBRnxwg
         DSoBN0rs/RJVrvHSe6xlHRmtzg/QkZdDQDwmeSx0KmndhvSPnGsU1KmVbZsfcJYEGpmT
         5dRTWYr9VEanCH3bYWZq27aOkPxgSpYLuQzeO2dDOwhCh3QQd/VrRIAF9JRPLgMI5jH9
         lUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433547; x=1718038347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJcLm5ZpSkzvbycg4N/ncJTb6gnjJ0KZfkcYCAHjp+4=;
        b=SZlryWnHQZib7TVcy8Dn9R+7uKvo/fLZ0xJBeR0jRrGsyL07wT/n2RrPfruerVss45
         EkdrxWpIGODtZknEtfVCmsXT0YHY+Tcj1K9E1cElPkvv9KAzKdkDFCCUURyutR+QSbOU
         x6N1/NLhb/OuMzI1H1dsrb3O6kDkYvQ8fowfQfmxzixhcjLRNn+ZoAZMed+TIXyJOBaW
         RrvpIp38pyxGEZ//LIEsNdHWx1ejmbGMv1wJoVZfAKTh4x1TOGdDEEHtkVODHEGVo6G+
         kHmmXG2lBCmv3a61E76MEPEOQj5oKOnYkWwaRcA0Coji2KM1fnNZ+ApnCt+nlgXoj2eS
         6xgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRatq78s1Yl8ibpd+Synk3WrJ2urwbx4FhUb/B1CEEKR6yH/r3nsTvezszDFk7oE6yRzcYJ8xWrOtzDeuOTKAdVs64M/ZiYVQoXZOXM8Du9g==
X-Gm-Message-State: AOJu0Yy4giQiZqHA15zQYePZOA5W6uqbHk1Mm62ysObbtKIOmKH7qhdZ
	FomBC9LDtA1HGbaeB71u3f4y6Ur8kGlfoE0T+ELRVA/XKy2fqYtuYeUsbyNKBFQOsj7YMxn3A8d
	h9QD+PKNJpovilMLOT6oSy0HLqFCog7Lt9z8m
X-Google-Smtp-Source: AGHT+IEsp6V45TBw2JP7tZOMI7fzyinIOWiPjdrnPxAAGdXewgE+WOZ4b0+9mdZyeN9H9AIThrhCqlA1vYPrFURxTSM=
X-Received: by 2002:a92:c00c:0:b0:373:8081:23d0 with SMTP id
 e9e14a558f8ab-37490ecd770mr4635645ab.18.1717433546712; Mon, 03 Jun 2024
 09:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603092812.46616-1-yangyicong@huawei.com> <20240603092812.46616-2-yangyicong@huawei.com>
In-Reply-To: <20240603092812.46616-2-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:52:15 -0700
Message-ID: <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf pmu: Limit PMU cpumask to online CPUs
To: Yicong Yang <yangyicong@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, acme@kernel.org, 
	namhyung@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, james.clark@arm.com, dongli.zhang@oracle.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com, 
	yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:33=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> We'll initialize the PMU's cpumask from "cpumask" or "cpus" sysfs
> attributes if provided by the driver without checking the CPUs
> are online or not. In such case that CPUs provided by the driver
> contains the offline CPUs, we'll try to open event on the offline
> CPUs and then rejected by the kernel:
>
> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --time=
out 100
> Error:
> The sys_perf_event_open() syscall returned with 19 (No such device) for e=
vent (cpu-clock).
> /bin/dmesg | grep -i perf may provide additional information.
>
> So it's better to do a double check in the userspace and only include
> the online CPUs from "cpumask" or "cpus" to avoid opening events on
> offline CPUs.

I see where you are coming from with this but I think it is wrong. The
cpus for an uncore PMU are a hint of the CPU to open on rather than
the set of valid CPUs. For example:
```
$ cat /sys/devices/uncore_imc_free_running_0/cpumask
0
$ perf stat -vv -e uncore_imc_free_running_0/data_read/ -C 1 -a sleep 0.1
Using CPUID GenuineIntel-6-8D-1
Attempt to add: uncore_imc_free_running_0/data_read/
..after resolving event: uncore_imc_free_running_0/event=3D0xff,umask=3D0x2=
0/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off cloexec flag
------------------------------------------------------------
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0
sys_perf_event_open failed, error -22
switching off exclude_guest, exclude_host
------------------------------------------------------------
perf_event_attr:
  type                             24 (uncore_imc_free_running_0)
  size                             136
  config                           0x20ff (data_read)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 =3D 3
uncore_imc_free_running_0/data_read/: 1: 4005984 102338957 102338957
uncore_imc_free_running_0/data_read/: 4005984 102338957 102338957

 Performance counter stats for 'system wide':

            244.51 MiB  uncore_imc_free_running_0/data_read/

       0.102320376 seconds time elapsed
```
So the CPU mask of the PMU says to open on CPU 0, but on the command
line when I passed "-C 1" it opened it on CPU 1. If the cpumask file
contained an offline CPU then this change would make it so the CPU map
in the tool were empty, however, a different CPU may be programmable
and online.

Fwiw, the tool will determine whether the mask is for all valid or a
hint by using the notion of a PMU being "core" or not. That notion
considers whether the mask was loading from a "cpumask" or "cpus"
file:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n810

Thanks,
Ian

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/perf/util/pmu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 888ce9912275..51e8d10ee28b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -771,8 +771,17 @@ static struct perf_cpu_map *pmu_cpumask(int dirfd, c=
onst char *name, bool is_cor
>                         continue;
>                 cpus =3D perf_cpu_map__read(file);
>                 fclose(file);
> -               if (cpus)
> -                       return cpus;
> +               if (cpus) {
> +                       struct perf_cpu_map *intersect __maybe_unused;
> +
> +                       if (perf_cpu_map__is_subset(cpu_map__online(), cp=
us))
> +                               return cpus;
> +
> +                       intersect =3D perf_cpu_map__intersect(cpus, cpu_m=
ap__online());
> +                       perf_cpu_map__put(cpus);
> +                       if (intersect)
> +                               return intersect;
> +               }
>         }
>
>         /* Nothing found, for core PMUs assume this means all CPUs. */
> --
> 2.24.0
>
