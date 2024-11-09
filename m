Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06844256D
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112253; cv=none; b=s6pP49y0QQdPOwqpMBRrR+GHj3hkoDRMbrJXjYWkZvaWZbEqwKCjCvjc+ce22ft9yPYVm5JHuErrsVBfXGLKrnWHHhUXrN7XUhyDlVJT1KUYUgZwgLExUGdq1vakbFwL6enEqdFskjLzJtTgk6GA/jAKhi2qNxd7guxHfL6q4fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112253; c=relaxed/simple;
	bh=6l31xFWX6keFP8JX4fQLI3fwS0vikRlxLjLQEplSDDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD3445DKkqppjvTWkh9daB6exa1TbdBGLpuWT3ZN0h+6VdcPgZziqex5wXLP+VNflm18cjGhvsGUHJI26suR0VO9Z8A5ApOG4vm8rOL7n/d2dp9e9pO+mMTZHPLhj1KwJx5F+wQgeBcMNFIIbwwa9l9/IqvD/wnmHHDJGJKG4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBD0GmBh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBD0GmBh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca03687fdso66585ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112251; x=1731717051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeiCkt8yGVZ1cm/cyphqL7nTIFzc03PSz7gvdXhOtfQ=;
        b=KBD0GmBhfflsqOdgOJoiLvYVYUnvgGiv44t8p14FwhDaenuKFXbi7D05tQOhjmWTas
         24ucV4q8joF3iT5Q5YQrYwfdF1wSFipTE7FXuM7eKVZemGw0KJ8qzt/9z4ZXk2U7t+Xe
         9PlNHi0MHcX28ZVO9pO0lQXpCSszBOzuy2VBj6kSoKBP7QdHGxtnA23BOxQ+2vg/RTnK
         hLrR5nBdEC/qzDxwzqMzsSGmjjR2XIQBc9IQVJYki3sR0DYDP6fS8ZlulN84OTSpkuKu
         yDOnEml6JEARuM5dOAq3cURvPByQiTMs3tPVQAqpCJHgA5vTP0dabQbwSobKZ1kr2NKj
         f0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112251; x=1731717051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeiCkt8yGVZ1cm/cyphqL7nTIFzc03PSz7gvdXhOtfQ=;
        b=lKQqfL1wEcFYgUU2cz20nKeZGugTEpadejGlHeyg7cw4Vnup8Q1dlmltVpmBawKJAC
         Cq8hOmshl5ZVVXl2RS7hBgfTHiU3M1q/mXS+6apXe2QI+Oyx4NfBEogLTj7p0eflrpUV
         +E20uQm6aJzd9Wqk+ClaInaTKoZTqrt6/RHNHAZ/ebLRPxwXYdfMtepde7wNLUkN5HrM
         HYfBKcqWXyVSgdBb1Q6o1M38qG5UeJVbFx4y+gd3CrezS8WRMa4OYBZ6qFBreAzmKBoD
         iJ2kKBKQJBn2sa7aq/SZzCELsg8ntNv79n8pYmLqGTcyGQYkVQc679NbHK/01m/vxxbr
         RtXg==
X-Forwarded-Encrypted: i=1; AJvYcCUq1t3Um+VKfre5t4Ih5Jwv/j2hc8ET0rfuTs3+/nacgEPty7OanOw1ZU1HqmphIsqC4j7CPoqyb2zPeMYdVfNB@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzY1V+TkN0aiUihS/dUxcaf3evvmNII/VXzQv87ONOYZVCQlJ
	q0h8l4CVh89ZptlBMoDV/m1B6ISBiuDoSFRubH0TRGtjnvDgHY1I8K+GC54tCjAQDB94rq5KSo0
	iThLjEKmOBxp2NJMVgd4/q2+ZZWbytn/mhWna
X-Gm-Gg: ASbGncs3ytR2ZWHwVQVFd6tB+l926FY8v62nQ+m8nJDuYKTc+P8tl80i6F3jQvSxs+G
	ILRMfyZNwZQCDAZfFFUotS4jl6WsLUlhF
X-Google-Smtp-Source: AGHT+IGtzZApRpWfsQOiUA5wU23LJePmLwYJZ1rd1WeQLwqUmdxWOj2gif2S0uFS+L4qSnEPCxXsiDQejnPC2M+l0mo=
X-Received: by 2002:a17:903:230e:b0:20c:e8df:2500 with SMTP id
 d9443c01a7336-2118f0e657cmr513825ad.3.1731112251033; Fri, 08 Nov 2024
 16:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com> <20241108174936.262704-5-irogers@google.com>
 <Zy5o46RIEZSvX3uw@google.com>
In-Reply-To: <Zy5o46RIEZSvX3uw@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 16:30:39 -0800
Message-ID: <CAP-5=fUpwgtLcSs37ab9Hpauf6EwoBVOePFgQoa0HZzd6LRVxQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] perf hwmon_pmu: Add a tool PMU exposing events
 from hwmon in sysfs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, James Clark <james.clark@linaro.org>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 11:39=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 08, 2024 at 09:49:33AM -0800, Ian Rogers wrote:
> > Add a tool PMU for hwmon events but don't enable.
> >
> > The hwmon sysfs ABI is defined in
> > Documentation/hwmon/sysfs-interface.rst. Create a PMU that reads the
> > hwmon input and can be used in `perf stat` and metrics much as an
> > uncore PMU can.
> >
> > For example, when enabled by a later patch, the following shows
> > reading the CPU temperature and 2 fan speeds alongside the uncore
> > frequency:
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
> >
> > The PMUs are named from /sys/class/hwmon/hwmon<num>/name and have an
> > alias of hwmon<num>.
> >
> > Hwmon data is presented in multiple <type><number>_<item> files. The
> > <type><number> is used to identify the event as is the <type> followed
> > by the contents of the <type>_label file if it exists. The
> > <type><number>_input file gives the data read by perf.
> >
> > When enabled by a later patch, in `perf list` the other hwmon <item>
> > files are used to give a richer description, for example:
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
> >  tools/perf/util/hwmon_pmu.c | 683 ++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/hwmon_pmu.h |  45 +++
> >  tools/perf/util/pmu.h       |   2 +
> >  3 files changed, 730 insertions(+)
> >
> > diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> > index f4b7b3b6a052..3f1bf9a9cfdf 100644
> > --- a/tools/perf/util/hwmon_pmu.c
> > +++ b/tools/perf/util/hwmon_pmu.c
> [SNIP]
> > +struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, int hwmon_dir,=
 const char *sysfs_name, const char *name)
> > +{
> > +     char buf[32];
> > +     struct hwmon_pmu *hwm;
> > +
> > +     hwm =3D zalloc(sizeof(*hwm));
> > +     if (!hwm)
> > +             return NULL;
> > +
> > +
>
> Two blank lines.

Fixed.

> > +     hwm->hwmon_dir_fd =3D hwmon_dir;
> > +     hwm->pmu.type =3D PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name =
+ 5, NULL, 10);
> > +     if (hwm->pmu.type > PERF_PMU_TYPE_HWMON_END) {
> > +             pr_err("Unable to encode hwmon type from %s in valid PMU =
type\n", sysfs_name);
> > +             goto err_out;
> > +     }
> > +     snprintf(buf, sizeof(buf), "hwmon_%s", name);
> > +     fix_name(buf + 6);
> > +     hwm->pmu.name =3D strdup(buf);
> > +     if (!hwm->pmu.name)
> > +             goto err_out;
> > +     hwm->pmu.alias_name =3D strdup(sysfs_name);
> > +     if (!hwm->pmu.alias_name)
> > +             goto err_out;
> > +     hwm->pmu.cpus =3D perf_cpu_map__new("0");
> > +     if (!hwm->pmu.cpus)
> > +             goto err_out;
> > +     INIT_LIST_HEAD(&hwm->pmu.format);
> > +     INIT_LIST_HEAD(&hwm->pmu.aliases);
> > +     INIT_LIST_HEAD(&hwm->pmu.caps);
> > +     hashmap__init(&hwm->events, hwmon_pmu__event_hashmap_hash,
> > +                   hwmon_pmu__event_hashmap_equal, /*ctx=3D*/NULL);
> > +
> > +     list_add_tail(&hwm->pmu.list, pmus);
> > +     return &hwm->pmu;
> > +err_out:
> > +     free((char *)hwm->pmu.name);
> > +     free(hwm->pmu.alias_name);
> > +     free(hwm);
> > +     close(hwmon_dir);
> > +     return NULL;
> > +}
>
> [...]
> > diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> > index df0ab5ff7534..ebfdfe3b295a 100644
> > --- a/tools/perf/util/hwmon_pmu.h
> > +++ b/tools/perf/util/hwmon_pmu.h
> > @@ -2,8 +2,12 @@
> >  #ifndef __HWMON_PMU_H
> >  #define __HWMON_PMU_H
> >
> > +#include "pmu.h"
> >  #include <stdbool.h>
> >
> > +struct list_head;
> > +struct perf_thread_map;
> > +
> >  /**
> >   * enum hwmon_type:
> >   *
> > @@ -87,6 +91,14 @@ enum hwmon_item {
> >       HWMON_ITEM__MAX,
> >  };
> >
> > +/** Strings that correspond to enum hwmon_type. */
> > +extern const char * const hwmon_type_strs[HWMON_TYPE_MAX];
> > +/** Strings that correspond to enum hwmon_item. */
> > +extern const char * const hwmon_item_strs[HWMON_ITEM__MAX];
>
> Belongs to the patch2?  But it'd be nice if we can remove them.

Made static in v8.

Thanks,
Ian
