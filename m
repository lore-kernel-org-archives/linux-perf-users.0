Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AE1AC44E
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989568; cv=none; b=VU+s2hpnS8hua96/Y5HVFH2EN09Xhr7uOkde+uTD8lZVFL1SZgvKehEj8zTpO9FWaI09pCjX/YWHu/hKAm7tay9V6wCVRT4plkmz8jdbIbcDMpvwPeK66c6ySp1HbR44GvWCyZ6+oqKQJohsD/aQjzkdHuv9xWDFy+oh3z3Uko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989568; c=relaxed/simple;
	bh=hJWLc2aZDQ4XE0vmgQ98zVAfEpcEJjgDSOw7cqkBSZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1dh3tAm85sFIzqzfYaMsb4glphso0o2y9iLXBSyPqPR4DeVDNQA6jqYCjxDza0Zk4UvgaxTIBwbsshT/uBaNjJx6cvUfofGXk8AN1FkJ/7cdkK3aG6Xa2Sz/HPg7TyECqMRfFIMx1Ecqw4M2xJkbo2U/VS1zAeXwORz/BUjLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcH96Hs1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcH96Hs1"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d41b61178so248395ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725989565; x=1726594365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDS2ntxZodwto0JRkb0hXSmRGIXhk9p4+kYp5pPQ67c=;
        b=bcH96Hs1pgi8ic5Jfe0/u/NVvGJ5JYSnDYUdDe6tFwfPAyCzOBnA68QvjMn1repUaP
         sRqptnt/dIPWrvTZHtDdAX6BF2aQ/SV+9gOL3wHVu0CHaUGdAZtpSneX4idkYHql1FKA
         h2fGpZ33+IfNmJUeAPyNC/CLc8hF3ht7zOPbXOIc1pnNie50wPPdaTlw5v6kyXcR3qON
         PIaiU6MyIBKqYp3zhCkaQcPfaZABCKAn9wjfv6Qy9aDo1kyC57bo/6MuDn3q5LllWpGk
         LlRQnU9HQRuPFK9EUcoStQ786+Dyyl7ygrpC+L35s3XyShf2BVL+KCtJLIrIB6Zf9j90
         S5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989565; x=1726594365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDS2ntxZodwto0JRkb0hXSmRGIXhk9p4+kYp5pPQ67c=;
        b=ZwEIKqrbHkiam3hnaljQYeQ35Ba31ieTwBK0H4IXqthg+Tdbry8kQngf3W1USRSRGl
         29hPURKBGOt9Bbxd9RBTtXknXtMkPMuwg3CNVpJjrcJ7NhemyTeNavDKjM17paXsWeF5
         t2Z4Uy0K8R32lmR4ZeIVIOPovePcEBLTVGFpT3FlAczMUJiKpjdfDcR//wrlnrOrE0IL
         CXwUkLj1f6354pJv3AiAShnJJR/jEeKX/w2CxGX0aAJ0d7kYL9O3G+aXk5rXYRXCb5GG
         ++LmHsDJdMhOERnhvsB9iOoF2FO2AxEb34cr6Up1n7xC3yxy9msnFEGBpUtmwnZgWbjd
         Wbfg==
X-Forwarded-Encrypted: i=1; AJvYcCX+tyCFoSMmDOf6GF17hgh0Y+PHFGVB42Qok98eQddDNmDbB++v89HilDqpGuvnKyAcwkH/MGeQuP7KYbOcFJL1@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8LZO2h0YPSzUAUm/HAMno7wPqH5niKn3gfZCqBZ//XVzR0/5
	CREY3yNvAnw+YJiVFecZL9kqODggD623H5mFzaz4z8+N7Ys7GNugdZ5eMjVdyPDtx7WTev8u2Ze
	yGZy9u+iOQjYhFTUd321BhB5dFLqyNlmlduAc
X-Google-Smtp-Source: AGHT+IH0Kus3XuIUIeJ4xCS55mAXRKV5KZ4cH+ZVhRyC5K4lYGuxyxo6cID6lv8Hf+Hb8OhBeIShtoUcreoHeXJ4K3I=
X-Received: by 2002:a05:6e02:20ea:b0:39d:24db:d515 with SMTP id
 e9e14a558f8ab-3a075087e5dmr68905ab.4.1725989564471; Tue, 10 Sep 2024 10:32:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com> <20240907050830.6752-15-irogers@google.com>
 <Zt_tsEJfOOSM1VuU@google.com>
In-Reply-To: <Zt_tsEJfOOSM1VuU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Sep 2024 10:32:32 -0700
Message-ID: <CAP-5=fVoqw-ZnynnykB3c=wdz17F5CJZ0O8hC=rbwJYzK72xYw@mail.gmail.com>
Subject: Re: [PATCH v1 14/15] perf hwmon_pmu: Add a tool PMU exposing events
 from hwmon in sysfs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Sep 06, 2024 at 10:08:29PM -0700, Ian Rogers wrote:
> > The hwmon sysfs ABI is defined in
> > Documentation/hwmon/sysfs-interface.rst. Create a PMU that reads the
> > hwmon input and can be used in `perf stat` and metrics much as an
> > uncore PMU can.
> >
> > For example, the following shows reading the CPU temperature and 2 fan
> > speeds alongside the uncore frequency:
> > ```
> > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/=
 -M UNCORE_FREQ -I 1000
> >      1.001153138              52.00 'C   temp_cpu
> >      1.001153138              2,588 rpm  fan1
> >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> >      1.001153138                  8      tool/num_cpus_online/
> >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET              =
   #     1.08 UNCORE_FREQ
> >      1.001153138      1,012,773,595      duration_time
> > ...
> > ```
>
> Interesting!  While they don't seem to be counters, it'd be useful to
> see the values from various sources/PMUs especially for interval mode.
>
> >
> > The PMUs are named from /sys/class/hwmon/hwmon<num>/name and have an
> > alias of hwmon<num>. The events are naned using the _label files as
> > well as the <type><num> prefix, the latter guaranteed to be unique.
> >
> > In `perf list` the other hwmon files are used to give a richer
> > description, for example:
> > ```
> > hwmon:
> >   temp1
> >        [Temperature in unit acpitz named temp1. Unit: hwmon_acpitz]
> >   in0
> >        [Voltage in unit bat0 named in0. Unit: hwmon_bat0]
> >   temp_core_0 OR temp2
> >        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=3D1=
00'C crit_alarm=3D0'C. Unit:
> >         hwmon_coretemp]
> >   temp_core_1 OR temp3
> >        [Temperature in unit coretemp named Core 1. crit=3D100'C,max=3D1=
00'C crit_alarm=3D0'C. Unit:
> >         hwmon_coretemp]
> > ...
> >   temp_package_id_0 OR temp1
> >        [Temperature in unit coretemp named Package id 0. crit=3D100'C,m=
ax=3D100'C crit_alarm=3D0'C.
> >         Unit: hwmon_coretemp]
> >   temp1
> >        [Temperature in unit iwlwifi_1 named temp1. Unit: hwmon_iwlwifi_=
1]
> >   temp_composite OR temp1
> >        [Temperature in unit nvme named Composite. alarm=3D0'C,crit=3D86=
.85'C,max=3D75.85'C,
> >         min=3D-273.15'C. Unit: hwmon_nvme]
> >   temp_sensor_1 OR temp2
> >        [Temperature in unit nvme named Sensor 1. max=3D65261.8'C,min=3D=
-273.15'C. Unit: hwmon_nvme]
> >   temp_sensor_2 OR temp3
> >        [Temperature in unit nvme named Sensor 2. max=3D65261.8'C,min=3D=
-273.15'C. Unit: hwmon_nvme]
> >   fan1
> >        [Fan in unit thinkpad named fan1. Unit: hwmon_thinkpad]
> >   fan2
> >        [Fan in unit thinkpad named fan2. Unit: hwmon_thinkpad]
> > ...
> >   temp_cpu OR temp1
> >        [Temperature in unit thinkpad named CPU. Unit: hwmon_thinkpad]
> >   temp_gpu OR temp2
> >        [Temperature in unit thinkpad named GPU. Unit: hwmon_thinkpad]
> >   curr1
> >        [Current in unit ucsi_source_psy_usbc000_0 named curr1. max=3D1.=
5A. Unit:
> >         hwmon_ucsi_source_psy_usbc000_0]
> >   in0
> >        [Voltage in unit ucsi_source_psy_usbc000_0 named in0. max=3D5V,m=
in=3D5V. Unit:
> >         hwmon_ucsi_source_psy_usbc000_0]
> > ```
> >
> > As there may be multiple hwmon devices a range of PMU types are
> > reserved for their use and to identify the PMU as belonging to the
> > hwmon types.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build       |   1 +
> >  tools/perf/util/evsel.c     |   9 +
> >  tools/perf/util/hwmon_pmu.c | 879 ++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/hwmon_pmu.h |  30 ++
> >  tools/perf/util/pmu.c       |  17 +
> >  tools/perf/util/pmu.h       |   2 +
> >  tools/perf/util/pmus.c      |   2 +
> >  7 files changed, 940 insertions(+)
> >  create mode 100644 tools/perf/util/hwmon_pmu.c
> >  create mode 100644 tools/perf/util/hwmon_pmu.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 80187e3a52be..b1dd5d176d1c 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -83,6 +83,7 @@ perf-util-y +=3D pmu.o
> >  perf-util-y +=3D pmus.o
> >  perf-util-y +=3D pmu-flex.o
> >  perf-util-y +=3D pmu-bison.o
> > +perf-util-y +=3D hwmon_pmu.o
> >  perf-util-y +=3D tool_pmu.o
> >  perf-util-y +=3D svghelper.o
> >  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D trace-event-info.o
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 9e748ed20988..64883d2aa1bb 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -50,6 +50,7 @@
> >  #include "off_cpu.h"
> >  #include "pmu.h"
> >  #include "pmus.h"
> > +#include "hwmon_pmu.h"
> >  #include "tool_pmu.h"
> >  #include "rlimit.h"
> >  #include "../perf-sys.h"
> > @@ -1657,6 +1658,9 @@ int evsel__read_counter(struct evsel *evsel, int =
cpu_map_idx, int thread)
> >       if (evsel__is_tool(evsel))
> >               return evsel__tool_pmu_read(evsel, cpu_map_idx, thread);
> >
> > +     if (evsel__is_hwmon(evsel))
> > +             return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
> > +
> >       if (evsel__is_retire_lat(evsel))
> >               return evsel__read_retire_lat(evsel, cpu_map_idx, thread)=
;
> >
> > @@ -2094,6 +2098,11 @@ static int evsel__open_cpu(struct evsel *evsel, =
struct perf_cpu_map *cpus,
> >                                           start_cpu_map_idx,
> >                                           end_cpu_map_idx);
> >       }
> > +     if (evsel__is_hwmon(evsel)) {
> > +             return evsel__hwmon_pmu_open(evsel, threads,
> > +                                          start_cpu_map_idx,
> > +                                          end_cpu_map_idx);
> > +     }
> >
> >       for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
> >
> > diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> > new file mode 100644
> > index 000000000000..cc8816b787ca
> > --- /dev/null
> > +++ b/tools/perf/util/hwmon_pmu.c
> > @@ -0,0 +1,879 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "counts.h"
> > +#include "debug.h"
> > +#include "evsel.h"
> > +#include "hashmap.h"
> > +#include "hwmon_pmu.h"
> > +#include "pmu.h"
> > +#include <internal/xyarray.h>
> > +#include <internal/threadmap.h>
> > +#include <perf/threadmap.h>
> > +#include <sys/types.h>
> > +#include <ctype.h>
> > +#include <dirent.h>
> > +#include <fcntl.h>
> > +#include <api/fs/fs.h>
> > +#include <api/io.h>
> > +#include <linux/zalloc.h>
> > +
> > +enum hwmon_type {
> > +     HWMON_TYPE_NONE,
> > +
> > +     HWMON_TYPE_CPU,
> > +     HWMON_TYPE_CURR,
> > +     HWMON_TYPE_ENERGY,
> > +     HWMON_TYPE_FAN,
> > +     HWMON_TYPE_HUMIDITY,
> > +     HWMON_TYPE_IN,
> > +     HWMON_TYPE_INTRUSION,
> > +     HWMON_TYPE_POWER,
> > +     HWMON_TYPE_PWM,
> > +     HWMON_TYPE_TEMP,
>
> Where does this list come from?  Is it exhaustive?

The list incorporates everything in:
Documentation/hwmon/sysfs-interface.rst
It's exhaustive in that it covers everything that is documented. It
can't cover future expansion and undocumented types. There are debug
messages so hopefully we can catch these and remedy the situation.
Originally I was looking into a parse-events.[ylc] style parser but it
was overkill. The lists fell out from creating the lists of tokens.
I'll add some comments.

> > +
> > +     HWMON_TYPE_MAX
> > +};
> > +
> > +static const char * const hwmon_type_strs[HWMON_TYPE_MAX] =3D {
> > +     NULL,
> > +     "cpu",
> > +     "curr",
> > +     "energy",
> > +     "fan",
> > +     "humidity",
> > +     "in",
> > +     "intrusion",
> > +     "power",
> > +     "pwm",
> > +     "temp",
> > +};
> > +
> > +static const char *const hwmon_units[HWMON_TYPE_MAX] =3D {
> > +     NULL,
> > +     "V",   /* cpu */
> > +     "A",   /* curr */
> > +     "J",   /* energy */
> > +     "rpm", /* fan */
> > +     "%",   /* humidity */
> > +     "V",   /* in */
> > +     "",    /* intrusion */
> > +     "W",   /* power */
> > +     "Hz",  /* pwm */
> > +     "'C",  /* temp */
> > +};
> > +
> > +enum hwmon_item {
> > +     HWMON_ITEM_NONE,
> > +
> > +     HWMON_ITEM_ACCURACY,
> > +     HWMON_ITEM_ALARM,
> > +     HWMON_ITEM_AUTO_CHANNELS_TEMP,
> > +     HWMON_ITEM_AVERAGE,
> > +     HWMON_ITEM_AVERAGE_HIGHEST,
> > +     HWMON_ITEM_AVERAGE_INTERVAL,
> > +     HWMON_ITEM_AVERAGE_INTERVAL_MAX,
> > +     HWMON_ITEM_AVERAGE_INTERVAL_MIN,
> > +     HWMON_ITEM_AVERAGE_LOWEST,
> > +     HWMON_ITEM_AVERAGE_MAX,
> > +     HWMON_ITEM_AVERAGE_MIN,
> > +     HWMON_ITEM_BEEP,
> > +     HWMON_ITEM_CAP,
> > +     HWMON_ITEM_CAP_HYST,
> > +     HWMON_ITEM_CAP_MAX,
> > +     HWMON_ITEM_CAP_MIN,
> > +     HWMON_ITEM_CRIT,
> > +     HWMON_ITEM_CRIT_HYST,
> > +     HWMON_ITEM_DIV,
> > +     HWMON_ITEM_EMERGENCY,
> > +     HWMON_ITEM_EMERGENCY_HIST,
> > +     HWMON_ITEM_ENABLE,
> > +     HWMON_ITEM_FAULT,
> > +     HWMON_ITEM_FREQ,
> > +     HWMON_ITEM_HIGHEST,
> > +     HWMON_ITEM_INPUT,
> > +     HWMON_ITEM_LABEL,
> > +     HWMON_ITEM_LCRIT,
> > +     HWMON_ITEM_LCRIT_HYST,
> > +     HWMON_ITEM_LOWEST,
> > +     HWMON_ITEM_MAX,
> > +     HWMON_ITEM_MAX_HYST,
> > +     HWMON_ITEM_MIN,
> > +     HWMON_ITEM_MIN_HYST,
> > +     HWMON_ITEM_MOD,
> > +     HWMON_ITEM_OFFSET,
> > +     HWMON_ITEM_PULSES,
> > +     HWMON_ITEM_RATED_MAX,
> > +     HWMON_ITEM_RATED_MIN,
> > +     HWMON_ITEM_RESET_HISTORY,
> > +     HWMON_ITEM_TARGET,
> > +     HWMON_ITEM_TYPE,
> > +     HWMON_ITEM_VID,
> > +
> > +     HWMON_ITEM__MAX,
> > +};
> > +
> > +static const char * const hwmon_item_strs[HWMON_ITEM__MAX] =3D {
> > +     NULL,
> > +     "accuracy",
> > +     "alarm",
> > +     "auto_channels_temp",
> > +     "average",
> > +     "average_highest",
> > +     "average_interval",
> > +     "average_interval_max",
> > +     "average_interval_min",
> > +     "average_lowest",
> > +     "average_max",
> > +     "average_min",
> > +     "beep",
> > +     "cap",
> > +     "cap_hyst",
> > +     "cap_max",
> > +     "cap_min",
> > +     "crit",
> > +     "crit_hyst",
> > +     "div",
> > +     "emergency",
> > +     "emergency_hist",
> > +     "enable",
> > +     "fault",
> > +     "freq",
> > +     "highest",
> > +     "input",
> > +     "label",
> > +     "lcrit",
> > +     "lcrit_hyst",
> > +     "lowest",
> > +     "max",
> > +     "max_hyst",
> > +     "min",
> > +     "min_hyst",
> > +     "mod",
> > +     "offset",
> > +     "pulses",
> > +     "rated_max",
> > +     "rated_min",
> > +     "reset_history",
> > +     "target",
> > +     "type",
> > +     "vid",
> > +};
> > +
> > +struct hwmon_pmu {
> > +     struct perf_pmu pmu;
> > +     struct hashmap events;
> > +     int pmu_dir_fd;
> > +};
> > +
> > +/**
> > + * union hwmon_pmu_event_key: Key for hwmon_pmu->events as such each k=
ey
> > + * represents an event.
> > + *
> > + * Related hwmon files start <type><number> that this key represents.
> > + */
> > +union hwmon_pmu_event_key {
> > +     long type_and_num;
> > +     struct {
> > +             int num :16;
> > +             enum hwmon_type type :8;
>
> Why not plain int types?  I'm not sure how much we care about 32 bits
> but you could use short int then.

I've not seen the number be in the 20s so 16-bits is sufficient and as
you point out avoids issues around 32-bit builds for i386, arm32 and
the like. Switching to a short is more intention revealing so I'll do
that.

> > +     };
> > +};
> > +
> > +/**
> > + * struct hwmon_pmu_event_value: Value in hwmon_pmu->events.
> > + *
> > + * Hwmon files are of the form <type><number>_<item> and may have a su=
ffix
> > + * _alarm.
> > + */
> > +struct hwmon_pmu_event_value {
> > +     /** @items: which item files are present. */
> > +     DECLARE_BITMAP(items, HWMON_ITEM__MAX);
> > +     /** @alarm_items: which item files are present. */
> > +     DECLARE_BITMAP(alarm_items, HWMON_ITEM__MAX);
> > +     /** @label: contents of <type><number>_label if present. */
> > +     char *label;
> > +     /** @name: name computed from label of the form <type>_<label>. *=
/
> > +     char *name;
> > +};
> > +
> > +bool perf_pmu__is_hwmon(const struct perf_pmu *pmu)
> > +{
> > +     return pmu && pmu->type >=3D PERF_PMU_TYPE_HWMON_START &&
> > +             pmu->type <=3D PERF_PMU_TYPE_HWMON_END;
> > +}
> > +
> > +bool evsel__is_hwmon(const struct evsel *evsel)
> > +{
> > +     return perf_pmu__is_hwmon(evsel->pmu);
> > +}
> > +
> > +static size_t hwmon_pmu__event_hashmap_hash(long key, void *ctx __mayb=
e_unused)
> > +{
> > +     return ((union hwmon_pmu_event_key)key).type_and_num;
> > +}
> > +
> > +static bool hwmon_pmu__event_hashmap_equal(long key1, long key2, void =
*ctx __maybe_unused)
> > +{
> > +     return ((union hwmon_pmu_event_key)key1).type_and_num =3D=3D
> > +            ((union hwmon_pmu_event_key)key2).type_and_num;
> > +}
> > +
> > +static int hwmon_strcmp(const void *a, const void *b)
> > +{
> > +     const char *sa =3D a;
> > +     const char * const *sb =3D b;
> > +
> > +     return strcmp(sa, *sb);
> > +}
> > +
>
> Can you please add some examples of typical filename in a comment here?

Good idea. This prompts me to think it'd be good to have tests for
"fan0_input" maps to type "fan", number  0 and item "input". I'll move
things around and add a test patch.

> > +static bool parse_hwmon_filename(const char *filename,
> > +                              enum hwmon_type *type,
> > +                              int *number,
> > +                              enum hwmon_item *item,
> > +                              bool *alarm)
> > +{
> > +     char fn_type[24];
> > +     const char **elem;
> > +     const char *fn_item =3D NULL;
> > +     size_t fn_item_len;
> > +
> > +     assert(strlen("intrusion") < sizeof(fn_type));
>
> Why intrusion?

It is the longest string in hwmon_type_strs, ie the assert is making
sure the buffer is sized big enough to hold the biggest parse-able
thing. Worth adding a comment.

> > +     strncpy(fn_type, filename, sizeof(fn_type));
> > +     for (size_t i =3D 0; i < sizeof(fn_type); i++) {
> > +             if (fn_type[i] >=3D '0' && fn_type[i] <=3D '9') {
> > +                     fn_type[i] =3D '\0';
> > +                     *number =3D strtoul(&filename[i], (char **)&fn_it=
em, 10);
> > +                     if (*fn_item =3D=3D '_')
> > +                             fn_item++;
> > +                     break;
> > +             }
> > +             if (fn_type[i] =3D=3D '_') {
> > +                     fn_type[i] =3D '\0';
> > +                     *number =3D -1;
> > +                     fn_item =3D &filename[i + 1];
> > +                     break;
> > +             }
> > +     }
> > +     if (fn_item =3D=3D NULL || fn_type[0] =3D=3D '\0' || (item !=3D N=
ULL && fn_item[0] =3D=3D '\0')) {
> > +             pr_debug("hwmon_pmu: not a hwmon file '%s'\n", filename);
> > +             return false;
> > +     }
> > +     elem =3D bsearch(&fn_type, hwmon_type_strs + 1, ARRAY_SIZE(hwmon_=
type_strs) - 1,
> > +                    sizeof(hwmon_type_strs[0]), hwmon_strcmp);
>
> Can we make the first entry an empty string rather than NULL to make
> this simpler?

It would remove the +1 and -1 but both of those are to constants that
I'd expect the compiler to find ways to fold away. So we'd be
increasing the "n" feeding into the O(log n) of the binary search. It
is a minimal thing but I'd prefer to avoid it.

> > +     if (!elem) {
> > +             pr_debug("hwmon_pmu: not a hwmon type '%s' in file name '=
%s'\n",
> > +                      fn_type, filename);
> > +             return false;
> > +     }
> > +
> > +     *type =3D elem - &hwmon_type_strs[0];
> > +     if (!item)
> > +             return true;
> > +
> > +     *alarm =3D false;
> > +     fn_item_len =3D strlen(fn_item);
> > +     if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm=
")) {
> > +             assert(strlen("average_interval_max") < sizeof(fn_type));
> > +             strncpy(fn_type, fn_item, fn_item_len - 6);
> > +             fn_item =3D fn_type;
> > +             *alarm =3D true;
> > +     }
>
> A comment to explain why it handles the "alarm" differently would be
> great.

Sure, but the short answer is that it has to give that _alarm is a
potential suffix.

> > +     elem =3D bsearch(fn_item, hwmon_item_strs + 1, ARRAY_SIZE(hwmon_i=
tem_strs) - 1,
> > +                    sizeof(hwmon_item_strs[0]), hwmon_strcmp);
> > +     if (!elem) {
> > +             pr_debug("hwmon_pmu: not a hwmon item '%s' in file name '=
%s'\n",
> > +                      fn_item, filename);
> > +             return false;
> > +     }
> > +     *item =3D elem - &hwmon_item_strs[0];
> > +     return true;
> > +}
> > +
> > +static void fix_name(char *p)
> > +{
> > +     char *s =3D strchr(p, '\n');
> > +
> > +     if (s)
> > +             *s =3D '\0';
> > +
> > +     while (*p !=3D '\0') {
> > +             if (strchr(" :,/\n\t", *p))
> > +                     *p =3D '_';
> > +             else
> > +                     *p =3D tolower(*p);
> > +             p++;
> > +     }
> > +}
> > +
> > +static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
>
> Maybe better to use other short name ('hwm'?) than 'pmu'.

SGTM, I'll try to clean this up consistently.

> > +{
> > +     DIR *dir;
> > +     struct dirent *ent;
> > +     int dup_fd, err =3D 0;
> > +     struct hashmap_entry *cur, *tmp;
> > +     size_t bkt;
> > +
> > +     if (pmu->pmu.sysfs_aliases_loaded)
> > +             return 0;
> > +
> > +     /* Use a dup-ed fd as closedir will close it. */
> > +     dup_fd =3D dup(pmu->pmu_dir_fd);
> > +     if (dup_fd =3D=3D -1)
> > +             return -ENOMEM;
> > +
> > +     dir =3D fdopendir(dup_fd);
> > +     if (!dir) {
> > +             close(dup_fd);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     while ((ent =3D readdir(dir)) !=3D NULL) {
> > +             enum hwmon_type type;
> > +             int number;
> > +             enum hwmon_item item;
> > +             bool alarm;
> > +             union hwmon_pmu_event_key key;
> > +             struct hwmon_pmu_event_value *value;
> > +
> > +             if (ent->d_type !=3D DT_REG)
> > +                     continue;
> > +
> > +             if (!parse_hwmon_filename(ent->d_name, &type, &number, &i=
tem, &alarm)) {
> > +                     pr_debug("Not a hwmon file '%s'\n", ent->d_name);
> > +                     continue;
> > +             }
> > +             key.num =3D number;
> > +             key.type =3D type;
> > +             if (!hashmap__find(&pmu->events, key.type_and_num, &value=
)) {
> > +                     value =3D zalloc(sizeof(*value));
> > +                     if (!value) {
> > +                             err =3D -ENOMEM;
> > +                             goto err_out;
> > +                     }
> > +                     err =3D hashmap__add(&pmu->events, key.type_and_n=
um, value);
> > +                     if (err) {
> > +                             free(value);
> > +                             err =3D -ENOMEM;
> > +                             goto err_out;
> > +                     }
> > +             }
> > +             __set_bit(item, alarm ? value->alarm_items : value->items=
);
> > +             if (item =3D=3D HWMON_ITEM_LABEL) {
> > +                     char buf[128];
> > +                     int fd =3D openat(pmu->pmu_dir_fd, ent->d_name, O=
_RDONLY);
> > +                     ssize_t read_len;
> > +
> > +                     if (fd < 0)
> > +                             continue;
> > +
> > +                     read_len =3D read(fd, buf, sizeof(buf));
> > +
> > +                     while (read_len > 0 && buf[read_len - 1] =3D=3D '=
\n')
> > +                             read_len--;
> > +
> > +                     if (read_len > 0)
> > +                             buf[read_len] =3D '\0';
> > +
> > +                     if (buf[0] =3D=3D '\0') {
> > +                             pr_debug("hwmon_pmu: empty label file %s =
%s\n",
> > +                                      pmu->pmu.name, ent->d_name);
> > +                             close(fd);
> > +                             continue;
> > +                     }
> > +                     value->label =3D strdup(buf);
> > +                     if (!value->label) {
> > +                             pr_debug("hwmon_pmu: memory allocation fa=
ilure\n");
> > +                             close(fd);
> > +                             continue;
> > +                     }
> > +                     snprintf(buf, sizeof(buf), "%s_%s", hwmon_type_st=
rs[type], value->label);
> > +                     fix_name(buf);
> > +                     value->name =3D strdup(buf);
> > +                     if (!value->name)
> > +                             pr_debug("hwmon_pmu: memory allocation fa=
ilure\n");
> > +                     close(fd);
> > +             }
> > +     }
> > +     hashmap__for_each_entry_safe((&pmu->events), cur, tmp, bkt) {
> > +             union hwmon_pmu_event_key key =3D {
> > +                     .type_and_num =3D cur->key,
> > +             };
> > +             struct hwmon_pmu_event_value *value =3D cur->pvalue;
> > +
> > +             if (!test_bit(HWMON_ITEM_INPUT, value->items)) {
> > +                     pr_debug("hwmon_pmu: removing event '%s%d' that h=
as no input file",
> > +                             hwmon_type_strs[key.type], key.num);
>
> What is the input file and why is it required?

The input file is the one that actually tells you the fan speed,
incoming voltage, etc. If you don't have one there is nothing to read.
There are other files like max and average that we could potentially
read but I'm ignoring that for now (those values will appear in
perf-list though).

> > +                     hashmap__delete(&pmu->events, key.type_and_num, &=
key, &value);
> > +                     zfree(&value->label);
> > +                     zfree(&value->name);
> > +                     free(value);
> > +             }
> > +     }
> > +     pmu->pmu.sysfs_aliases_loaded =3D true;
> > +
> > +err_out:
> > +     closedir(dir);
> > +     return err;
> > +}
> > +
> > +static int hwmon_pmu__new(struct list_head *pmus, int pmu_dir, const c=
har *sysfs_name,
> > +                       const char *name)
> > +{
> > +     char buf[32];
> > +     struct hwmon_pmu *pmu;
> > +     int err =3D 0;
> > +
> > +     pr_debug("Hi Ian, '%s' -> '%s'\n", sysfs_name, name);
>
> Forgot to remove? :)

Whoops :-)

> > +
> > +     pmu =3D zalloc(sizeof(*pmu));
> > +     if (!pmu)
> > +             return -ENOMEM;
> > +
> > +
> > +     pmu->pmu_dir_fd =3D pmu_dir;
> > +     pmu->pmu.type =3D PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name =
+ 5, NULL, 10);
> > +     if (pmu->pmu.type > PERF_PMU_TYPE_HWMON_END) {
> > +             err =3D -EINVAL;
> > +             goto err_out;
> > +     }
> > +     snprintf(buf, sizeof(buf), "hwmon_%s", name);
> > +     fix_name(buf + 6);
> > +     pmu->pmu.name =3D strdup(buf);
> > +     if (!pmu->pmu.name) {
> > +             err =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +     pmu->pmu.alias_name =3D strdup(sysfs_name);
> > +     if (!pmu->pmu.alias_name) {
> > +             err =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +     pmu->pmu.cpus =3D perf_cpu_map__new("0");
> > +     if (!pmu->pmu.cpus) {
> > +             err =3D -ENOMEM;
> > +             goto err_out;
> > +     }
> > +     INIT_LIST_HEAD(&pmu->pmu.format);
> > +     INIT_LIST_HEAD(&pmu->pmu.aliases);
> > +     INIT_LIST_HEAD(&pmu->pmu.caps);
> > +     hashmap__init(&pmu->events, hwmon_pmu__event_hashmap_hash,
> > +                   hwmon_pmu__event_hashmap_equal, /*ctx=3D*/NULL);
> > +
> > +     list_add_tail(&pmu->pmu.list, pmus);
> > +err_out:
> > +     if (err) {
> > +             free((char *)pmu->pmu.name);
> > +             free(pmu->pmu.alias_name);
> > +             free(pmu);
> > +             close(pmu_dir);
> > +     }
> > +     return err;
> > +}
> > +
> > +static size_t hwmon_pmu__describe_items(struct hwmon_pmu *pmu, char *o=
ut_buf, size_t out_buf_len,
> > +                                     union hwmon_pmu_event_key key,
> > +                                     const unsigned long *items, bool =
is_alarm)
> > +{
> > +     size_t bit;
> > +     char buf[64];
> > +     size_t len =3D 0;
> > +
> > +     for_each_set_bit(bit, items, HWMON_ITEM__MAX) {
> > +             int fd;
> > +
> > +             if (bit =3D=3D HWMON_ITEM_LABEL || bit =3D=3D HWMON_ITEM_=
INPUT)
> > +                     continue;
> > +
> > +             snprintf(buf, sizeof(buf), "%s%d_%s%s",
> > +                     hwmon_type_strs[key.type],
> > +                     key.num,
> > +                     hwmon_item_strs[bit],
> > +                     is_alarm ? "_alarm" : "");
> > +             fd =3D openat(pmu->pmu_dir_fd, buf, O_RDONLY);
> > +             if (fd > 0) {
> > +                     ssize_t read_len =3D read(fd, buf, sizeof(buf));
> > +
> > +                     while (read_len > 0 && buf[read_len - 1] =3D=3D '=
\n')
> > +                             read_len--;
> > +
> > +                     if (read_len > 0) {
> > +                             long long val;
> > +
> > +                             buf[read_len] =3D '\0';
> > +                             val =3D strtoll(buf, /*endptr=3D*/NULL, 1=
0);
> > +                             len +=3D snprintf(out_buf + len, out_buf_=
len - len, "%s%s%s=3D%g%s",
> > +                                             len =3D=3D 0 ? " " : ", "=
,
> > +                                             hwmon_item_strs[bit],
> > +                                             is_alarm ? "_alarm" : "",
> > +                                             (double)val / 1000.0,
> > +                                             hwmon_units[key.type]);
> > +                     }
> > +                     close(fd);
> > +             }
> > +     }
> > +     return len;
> > +}
> > +
> > +int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_e=
vent_callback cb)
> > +{
> > +     struct hwmon_pmu *hwmon_pmu =3D container_of(pmu, struct hwmon_pm=
u, pmu);
> > +     struct hashmap_entry *cur;
> > +     size_t bkt;
> > +
> > +     if (hwmon_pmu__read_events(hwmon_pmu))
> > +             return false;
> > +
> > +     hashmap__for_each_entry((&hwmon_pmu->events), cur, bkt) {
> > +             static const char *const hwmon_scale_units[HWMON_TYPE_MAX=
] =3D {
> > +                     NULL,
> > +                     "0.001V", /* cpu */
> > +                     "0.001A", /* curr */
> > +                     "0.001J", /* energy */
> > +                     "1rpm",   /* fan */
> > +                     "0.001%", /* humidity */
> > +                     "0.001V", /* in */
> > +                     NULL,     /* intrusion */
> > +                     "0.001W", /* power */
> > +                     "1Hz",    /* pwm */
> > +                     "0.001'C", /* temp */
> > +             };
> > +             static const char *const hwmon_desc[HWMON_TYPE_MAX] =3D {
> > +                     NULL,
> > +                     "CPU core reference voltage",   /* cpu */
> > +                     "Current",                      /* curr */
> > +                     "Cumulative energy use",        /* energy */
> > +                     "Fan",                          /* fan */
> > +                     "Humidity",                     /* humidity */
> > +                     "Voltage",                      /* in */
> > +                     "Chassis intrusion detection",  /* intrusion */
> > +                     "Power use",                    /* power */
> > +                     "Pulse width modulation fan control", /* pwm */
> > +                     "Temperature",                  /* temp */
> > +             };
> > +             char alias_buf[64];
> > +             char desc_buf[256];
> > +             char encoding_buf[128];
> > +             union hwmon_pmu_event_key key =3D {
> > +                     .type_and_num =3D cur->key,
> > +             };
> > +             struct hwmon_pmu_event_value *value =3D cur->pvalue;
> > +             struct pmu_event_info info =3D {
> > +                     .pmu =3D pmu,
> > +                     .name =3D value->name,
> > +                     .alias =3D alias_buf,
> > +                     .scale_unit =3D hwmon_scale_units[key.type],
> > +                     .desc =3D desc_buf,
> > +                     .long_desc =3D NULL,
> > +                     .encoding_desc =3D encoding_buf,
> > +                     .topic =3D "hwmon",
> > +                     .pmu_name =3D pmu->name,
> > +                     .event_type_desc =3D "Hwmon event",
> > +             };
> > +             int ret;
> > +             size_t len;
> > +
> > +             len =3D snprintf(alias_buf, sizeof(alias_buf), "%s%d",
> > +                            hwmon_type_strs[key.type], key.num);
> > +             if (!info.name) {
> > +                     info.name =3D info.alias;
> > +                     info.alias =3D NULL;
> > +             }
> > +
> > +             len =3D snprintf(desc_buf, sizeof(desc_buf), "%s in unit =
%s named %s.",
> > +                     hwmon_desc[key.type],
> > +                     pmu->name + 6,
> > +                     value->label ?: info.name);
> > +
> > +             len +=3D hwmon_pmu__describe_items(hwmon_pmu, desc_buf + =
len, sizeof(desc_buf) - len,
> > +                                             key, value->items, /*is_a=
larm=3D*/false);
> > +
> > +             len +=3D hwmon_pmu__describe_items(hwmon_pmu, desc_buf + =
len, sizeof(desc_buf) - len,
> > +                                             key, value->alarm_items, =
/*is_alarm=3D*/true);
> > +
> > +             snprintf(encoding_buf, sizeof(encoding_buf), "%s/config=
=3D0x%lx/",
> > +                      pmu->name, cur->key);
> > +
> > +             ret =3D cb(state, &info);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
> > +
> > +size_t hwmon_pmu__num_events(struct perf_pmu *pmu)
> > +{
> > +     struct hwmon_pmu *hwmon_pmu =3D container_of(pmu, struct hwmon_pm=
u, pmu);
> > +
> > +     hwmon_pmu__read_events(hwmon_pmu);
> > +     return hashmap__size(&hwmon_pmu->events);
> > +}
> > +
> > +bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name)
> > +{
> > +     struct hwmon_pmu *hwmon_pmu =3D container_of(pmu, struct hwmon_pm=
u, pmu);
> > +     enum hwmon_type type;
> > +     int number;
> > +     union hwmon_pmu_event_key key;
> > +     struct hashmap_entry *cur;
> > +     size_t bkt;
> > +
> > +     if (!parse_hwmon_filename(name, &type, &number, /*item=3D*/NULL, =
/*is_alarm=3D*/NULL))
> > +             return false;
> > +
> > +     if (hwmon_pmu__read_events(hwmon_pmu))
> > +             return false;
> > +
> > +     key.type =3D type;
> > +     key.num =3D number;
> > +     if (hashmap_find(&hwmon_pmu->events, key.type_and_num, /*value=3D=
*/NULL))
> > +             return true;
> > +     if (key.num !=3D -1)
> > +             return false;
> > +     /* Item is of form <type>_ which means we should match <type>_<la=
bel>. */
> > +     hashmap__for_each_entry((&hwmon_pmu->events), cur, bkt) {
> > +             struct hwmon_pmu_event_value *value =3D cur->pvalue;
> > +
> > +             key.type_and_num =3D cur->key;
> > +             if (key.type =3D=3D type && value->name && !strcasecmp(na=
me, value->name))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +static int hwmon_pmu__config_term(const struct hwmon_pmu *pmu,
> > +                               struct perf_event_attr *attr,
> > +                               struct parse_events_term *term,
> > +                               struct parse_events_error *err)
> > +{
> > +     if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER) {
> > +             enum hwmon_type type;
> > +             int number;
> > +
> > +             if (parse_hwmon_filename(term->config, &type, &number,
> > +                                      /*item=3D*/NULL, /*is_alarm=3D*/=
NULL)) {
> > +                     if (number =3D=3D -1) {
> > +                             /*
> > +                              * Item is of form <type>_ which means we=
 should
> > +                              * match <type>_<label>.
> > +                              */
> > +                             struct hashmap_entry *cur;
> > +                             size_t bkt;
> > +
> > +                             attr->config =3D 0;
> > +                             hashmap__for_each_entry((&pmu->events), c=
ur, bkt) {
> > +                                     union hwmon_pmu_event_key key =3D=
 {
> > +                                             .type_and_num =3D cur->ke=
y,
> > +                                     };
> > +                                     struct hwmon_pmu_event_value *val=
ue =3D cur->pvalue;
> > +
> > +                                     if (key.type =3D=3D type && value=
->name &&
> > +                                         !strcasecmp(term->config, val=
ue->name)) {
> > +                                             attr->config =3D key.type=
_and_num;
> > +                                             break;
> > +                                     }
> > +                             }
> > +                             if (attr->config =3D=3D 0)
> > +                                     return -EINVAL;
> > +                     } else {
> > +                             union hwmon_pmu_event_key key =3D {
> > +                                     .type =3D type,
> > +                                     .num =3D number,
> > +                             };
> > +
> > +                             attr->config =3D key.type_and_num;
> > +                     }
> > +                     return 0;
> > +             }
> > +     }
> > +     if (err) {
> > +             char *err_str;
> > +
> > +             parse_events_error__handle(err, term->err_val,
> > +                                     asprintf(&err_str,
> > +                                             "unexpected hwmon event t=
erm (%s) %s",
> > +                                             parse_events__term_type_s=
tr(term->type_term),
> > +                                             term->config) < 0
> > +                                     ? strdup("unexpected hwmon event =
term")
> > +                                     : err_str,
> > +                                     NULL);
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> > +int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
> > +                         struct perf_event_attr *attr,
> > +                         struct parse_events_terms *terms,
> > +                         struct parse_events_error *err)
> > +{
> > +     const struct hwmon_pmu *hwmon_pmu =3D container_of(pmu, struct hw=
mon_pmu, pmu);
> > +     struct parse_events_term *term;
> > +
> > +     assert(pmu->sysfs_aliases_loaded);
> > +     list_for_each_entry(term, &terms->terms, list) {
> > +             if (hwmon_pmu__config_term(hwmon_pmu, attr, term, err))
> > +                     return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +
> > +}
> > +
> > +int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct pe=
rf_pmu_info *info,
> > +                        struct parse_events_error *err)
> > +{
> > +     struct parse_events_term *term =3D
> > +             list_first_entry(&terms->terms, struct parse_events_term,=
 list);
> > +
> > +     if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER) {
> > +             enum hwmon_type type;
> > +             int number;
> > +
> > +             if (parse_hwmon_filename(term->config, &type, &number,
> > +                                      /*item=3D*/NULL, /*is_alarm=3D*/=
NULL)) {
> > +                     info->unit =3D hwmon_units[type];
> > +                     if (type =3D=3D HWMON_TYPE_FAN || type =3D=3D HWM=
ON_TYPE_PWM ||
> > +                         type =3D=3D HWMON_TYPE_INTRUSION)
> > +                             info->scale =3D 1;
> > +                     else
> > +                             info->scale =3D 0.001;
> > +             }
> > +             return 0;
> > +     }
> > +     if (err) {
> > +             char *err_str;
> > +
> > +             parse_events_error__handle(err, term->err_val,
> > +                                     asprintf(&err_str,
> > +                                             "unexpected hwmon event t=
erm (%s) %s",
> > +                                             parse_events__term_type_s=
tr(term->type_term),
> > +                                             term->config) < 0
> > +                                     ? strdup("unexpected hwmon event =
term")
> > +                                     : err_str,
>
> Probably better to move the asprintf() out to a statement.

Okay, it a c&p from parse-events.c so I'll need to add in a refactor patch.

>
> > +                                     NULL);
> > +     }
> > +     return -EINVAL;
> > +}
> > +
> > +int perf_pmus__read_hwmon_pmus(struct list_head *pmus)
> > +{
> > +     char *line =3D NULL;
> > +     DIR *hwmon_dir;
> > +     struct dirent *hwmon_ent;
> > +     char buf[PATH_MAX];
> > +     const char *sysfs =3D sysfs__mountpoint();
> > +
> > +     if (!sysfs)
> > +             return 0;
> > +
> > +     scnprintf(buf, sizeof(buf), "%s/class/hwmon/", sysfs);
> > +     hwmon_dir =3D opendir(buf);
> > +     if (!hwmon_dir)
> > +             return 0;
> > +
> > +     while ((hwmon_ent =3D readdir(hwmon_dir)) !=3D NULL) {
> > +             size_t line_len;
> > +             int pmu_dir, name_fd;
> > +             struct io io;
> > +
> > +             if (hwmon_ent->d_type !=3D DT_LNK)
> > +                     continue;
> > +
> > +             scnprintf(buf, sizeof(buf), "%s/class/hwmon/%s", sysfs, h=
wmon_ent->d_name);
> > +             pmu_dir =3D open(buf, O_DIRECTORY);
> > +             if (pmu_dir =3D=3D -1) {
> > +                     pr_debug("hwmon_pmu: not a directory: '%s/class/h=
wmon/%s'\n",
> > +                              sysfs, hwmon_ent->d_name);
> > +                     continue;
> > +             }
> > +             name_fd =3D openat(pmu_dir, "name", O_RDONLY);
> > +             if (name_fd =3D=3D -1) {
> > +                     pr_debug("hwmon_pmu: failure to open '%s/class/hw=
mon/%s/name'\n",
> > +                               sysfs, hwmon_ent->d_name);
> > +                     continue;
>
> close(pmu_dir)?

Done.

>
> > +             }
> > +             io__init(&io, name_fd, buf, sizeof(buf));
> > +             io__getline(&io, &line, &line_len);
> > +             if (line_len > 0 && line[line_len - 1] =3D=3D '\n')
> > +                     line[line_len - 1] =3D '\0';
> > +             hwmon_pmu__new(pmus, pmu_dir, hwmon_ent->d_name, line);
> > +             close(name_fd);
> > +     }
> > +     free(line);
> > +     closedir(hwmon_dir);
> > +     return 0;
> > +}
> > +
> > +#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> > +
> > +int evsel__hwmon_pmu_open(struct evsel *evsel,
> > +                      struct perf_thread_map *threads,
> > +                      int start_cpu_map_idx, int end_cpu_map_idx)
> > +{
> > +     struct hwmon_pmu *hwmon_pmu =3D container_of(evsel->pmu, struct h=
wmon_pmu, pmu);
> > +     union hwmon_pmu_event_key key =3D {
> > +             .type_and_num =3D evsel->core.attr.config,
> > +     };
> > +     int idx =3D 0, thread =3D 0, nthreads, err =3D 0;
> > +
> > +     nthreads =3D perf_thread_map__nr(threads);
> > +     for (idx =3D start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
> > +             for (thread =3D 0; thread < nthreads; thread++) {
> > +                     char buf[64];
> > +                     int fd;
> > +
> > +                     snprintf(buf, sizeof(buf), "%s%d_input",
> > +                              hwmon_type_strs[key.type], key.num);
> > +
> > +                     fd =3D openat(hwmon_pmu->pmu_dir_fd, buf, O_RDONL=
Y);
> > +                     FD(evsel, idx, thread) =3D fd;
> > +                     if (fd < 0) {
> > +                             err =3D -errno;
> > +                             goto out_close;
> > +                     }
> > +             }
> > +     }
> > +     return 0;
> > +out_close:
> > +     if (err)
> > +             threads->err_thread =3D thread;
> > +
> > +     do {
> > +             while (--thread >=3D 0) {
> > +                     if (FD(evsel, idx, thread) >=3D 0)
> > +                             close(FD(evsel, idx, thread));
> > +                     FD(evsel, idx, thread) =3D -1;
> > +             }
> > +             thread =3D nthreads;
> > +     } while (--idx >=3D 0);
> > +     return err;
> > +}
> > +
> > +int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int th=
read)
> > +{
> > +     char buf[32];
> > +     int fd;
> > +     ssize_t len;
> > +     struct perf_counts_values *count, *old_count =3D NULL;
> > +
> > +     if (evsel->prev_raw_counts)
> > +             old_count =3D perf_counts(evsel->prev_raw_counts, cpu_map=
_idx, thread);
> > +
> > +     count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> > +     fd =3D FD(evsel, cpu_map_idx, thread);
> > +     lseek(fd, SEEK_SET, 0);
> > +     len =3D read(fd, buf, sizeof(buf));
>
> pread() instead?

Done.

> > +     if (len <=3D 0) {
> > +             count->lost++;
> > +             return -EINVAL;
> > +     }
> > +     buf[len] =3D '\0';
> > +     if (old_count) {
> > +             count->val =3D old_count->val + strtoll(buf, NULL, 10);
> > +             count->run =3D old_count->run + 1;
> > +             count->ena =3D old_count->ena + 1;
>
> I'm not sure if it's meaningful to use the old value for hwmon.
> Oh.. is it just to make interval logic work correctly?

Yep. Otherwise the interval logic sees values not moving or going
backward and other bad things. I'm not a fan of this logic but I don't
like interval mode not working more. The logic also needs to use
old_count, not just count, otherwise 1 in 3 intervals break.

Thanks,
Ian


> Thanks,
> Namhyung
>
>
> > +     } else {
> > +             count->val =3D strtoll(buf, NULL, 10);
> > +             count->run++;
> > +             count->ena++;
> > +     }
> > +     return 0;
> > +}
> > diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> > new file mode 100644
> > index 000000000000..49e1683d5bce
> > --- /dev/null
> > +++ b/tools/perf/util/hwmon_pmu.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +#ifndef __HWMON_PMU_H
> > +#define __HWMON_PMU_H
> > +
> > +#include "pmu.h"
> > +
> > +struct list_head;
> > +
> > +bool perf_pmu__is_hwmon(const struct perf_pmu *pmu);
> > +bool evsel__is_hwmon(const struct evsel *evsel);
> > +
> > +int hwmon_pmu__for_each_event(struct perf_pmu *pmu, void *state, pmu_e=
vent_callback cb);
> > +size_t hwmon_pmu__num_events(struct perf_pmu *pmu);
> > +bool hwmon_pmu__have_event(struct perf_pmu *pmu, const char *name);
> > +int hwmon_pmu__config_terms(const struct perf_pmu *pmu,
> > +                         struct perf_event_attr *attr,
> > +                         struct parse_events_terms *terms,
> > +                         struct parse_events_error *err);
> > +int hwmon_pmu__check_alias(struct parse_events_terms *terms, struct pe=
rf_pmu_info *info,
> > +                        struct parse_events_error *err);
> > +
> > +int perf_pmus__read_hwmon_pmus(struct list_head *pmus);
> > +
> > +
> > +int evsel__hwmon_pmu_open(struct evsel *evsel,
> > +                      struct perf_thread_map *threads,
> > +                      int start_cpu_map_idx, int end_cpu_map_idx);
> > +int evsel__hwmon_pmu_read(struct evsel *evsel, int cpu_map_idx, int th=
read);
> > +
> > +#endif /* __HWMON_PMU_H */
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 5ff6556292fd..c31d3409c787 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -18,6 +18,7 @@
> >  #include "debug.h"
> >  #include "evsel.h"
> >  #include "pmu.h"
> > +#include "hwmon_pmu.h"
> >  #include "pmus.h"
> >  #include "tool_pmu.h"
> >  #include <util/pmu-bison.h>
> > @@ -1529,6 +1530,9 @@ int perf_pmu__config_terms(const struct perf_pmu =
*pmu,
> >  {
> >       struct parse_events_term *term;
> >
> > +     if (perf_pmu__is_hwmon(pmu))
> > +             return hwmon_pmu__config_terms(pmu, attr, terms, err);
> > +
> >       list_for_each_entry(term, &terms->terms, list) {
> >               if (pmu_config_term(pmu, attr, term, terms, zero, apply_h=
ardcoded, err))
> >                       return -EINVAL;
> > @@ -1661,6 +1665,11 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, =
struct parse_events_terms *head_
> >       info->scale    =3D 0.0;
> >       info->snapshot =3D false;
> >
> > +     if (perf_pmu__is_hwmon(pmu)) {
> > +             ret =3D hwmon_pmu__check_alias(head_terms, info, err);
> > +             goto out;
> > +     }
> > +
> >       /* Fake PMU doesn't rewrite terms. */
> >       if (perf_pmu__is_fake(pmu))
> >               goto out;
> > @@ -1830,6 +1839,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, c=
onst char *name)
> >               return false;
> >       if (perf_pmu__is_tool(pmu) && tool_pmu__skip_event(name))
> >               return false;
> > +     if (perf_pmu__is_hwmon(pmu))
> > +             return hwmon_pmu__have_event(pmu, name);
> >       if (perf_pmu__find_alias(pmu, name, /*load=3D*/ true) !=3D NULL)
> >               return true;
> >       if (pmu->cpu_aliases_added || !pmu->events_table)
> > @@ -1841,6 +1852,9 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
> >  {
> >       size_t nr;
> >
> > +     if (perf_pmu__is_hwmon(pmu))
> > +             return hwmon_pmu__num_events(pmu);
> > +
> >       pmu_aliases_parse(pmu);
> >       nr =3D pmu->sysfs_aliases + pmu->sys_json_aliases;
> >
> > @@ -1904,6 +1918,9 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu=
, bool skip_duplicate_pmus,
> >       int ret =3D 0;
> >       struct strbuf sb;
> >
> > +     if (perf_pmu__is_hwmon(pmu))
> > +             return hwmon_pmu__for_each_event(pmu, state, cb);
> > +
> >       strbuf_init(&sb, /*hint=3D*/ 0);
> >       pmu_aliases_parse(pmu);
> >       pmu_add_cpu_aliases(pmu);
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index c4ca359d4215..32f95a1060d8 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -37,6 +37,8 @@ struct perf_pmu_caps {
> >  };
> >
> >  enum {
> > +     PERF_PMU_TYPE_HWMON_START =3D 0xFFFF0000,
> > +     PERF_PMU_TYPE_HWMON_END   =3D 0xFFFFFFFD,
> >       PERF_PMU_TYPE_TOOL =3D 0xFFFFFFFE,
> >       PERF_PMU_TYPE_FAKE =3D 0xFFFFFFFF,
> >  };
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 19673b9991c6..4e3b19a2db00 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -15,6 +15,7 @@
> >  #include "evsel.h"
> >  #include "pmus.h"
> >  #include "pmu.h"
> > +#include "hwmon_pmu.h"
> >  #include "tool_pmu.h"
> >  #include "print-events.h"
> >  #include "strbuf.h"
> > @@ -234,6 +235,7 @@ static void pmu_read_sysfs(bool core_only)
> >       if (!core_only) {
> >               tool_pmu =3D perf_pmus__tool_pmu();
> >               list_add_tail(&tool_pmu->list, &other_pmus);
> > +             perf_pmus__read_hwmon_pmus(&other_pmus);
> >       }
> >       list_sort(NULL, &other_pmus, pmus_cmp);
> >       if (!list_empty(&core_pmus)) {
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >
