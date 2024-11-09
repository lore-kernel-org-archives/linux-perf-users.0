Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550214C9A
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112199; cv=none; b=hOZ7mO25zhcqdT5ZMmZxzIsIefed3BWD9JnJ9Ltlh3+XPsiBn8M1KK516t8Jwe0h2q44+LxJjai+z1wv/RNoIv2XLxYk8Qm3GXbINstZ1LNf4n5Oggy4eF71Actrk1CLgriiMUxNWXUHFD9OArkWHPy0ZWW+pxD+g+k/hWGVF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112199; c=relaxed/simple;
	bh=snlNWw1fDPHwUDVwQo1YYrXYfcai/9kZYx0QBsaaUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YyRcPVkzU9U8xYWtRUIGjJletd2AlydSj9R2HRkcek5ui80+PmpEovHv/jHIIk6v1ydUGQ7YZSj5S+XbSEeyyPAsb9dUJE3XkigDyMU9J4iUXcDabnh6QfoOqDBMgYYI4GQN4dH1D5Ce0kBOAOhRhfXiZQoJ5ic2U+wU6UVrr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJ7i6TJU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XJ7i6TJU"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso28925ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Nov 2024 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112196; x=1731716996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmYA8FQqMdwmOynhm+YfrXky1hXgqOQL5xC9uW93CNA=;
        b=XJ7i6TJULhxTpDd6kh9lFN2WDS81wOxJqYmFMJPsuTsxCS5tnxVgGiqCyS+TRkdYPD
         ufKDNx7rFIVz0/+WlrjLAo/PDS2eNLHJQuj6cp5YXGzmgsFYZ40/FaawZ3aKvlEzNCHr
         Mpld2HBhdnIxtGNT6LmtYzfMCkayj3PvhYv44pLve6P+nYzQxBXrS4mDSGAZIy7fLf4n
         zUW6DmW5vDfLUk5m0Ns2Lwlnx7RAzduARjKsAlhO66w3rIOCXd4rfMZV3kgB0IIh9VYK
         Mep2GrWkfR7+vczYZ6AAKkyIjfB/lgNn1woLC0B6R/Fr3LNvFdGPFh3SQP1YqIW3ozcF
         jUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112196; x=1731716996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmYA8FQqMdwmOynhm+YfrXky1hXgqOQL5xC9uW93CNA=;
        b=PjGnZY3Y9WHh9t0yMUw59oXlSnUvYR7+jphqbwgqpgnd856ZGJ4FjDwfgmyQ0Gs/yw
         +/YD+eQvR5GZBiXK67sMzCIPbHhxPwXBXerS6/tJ1EzNfjvI/90GGxIvnUw87E5f+Q/u
         qPoZWBOlYk7j4/7T5gFw5Tzmg0OPWO1oM18KGLZYf0FegtGUOG7F13YeFrnfl4LBgB/O
         XGE1nsL8j8Wjem1+VQT+AyP5gRKJzcrO/RwPWrpvp6r/42MMdBRDsFRJX1TgemGKQolh
         QyLc+QY3/h56+ZKmUoSu1btqymyEKBBwc1m8IJvf5Eo+PY+OcFI9Opvu/jUexnajOcbe
         m+5w==
X-Forwarded-Encrypted: i=1; AJvYcCWNL7Wwh11oyoJekujqlO9lR8yuQg+93fUEkkFFLPJBjagiRZhEw8b633bk4267hbzCKyYzudAkE9MFdmjP7Udm@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbtNOzajx0xDKPaaRzOufap9ygJJVcwZw6t2a612tfBclK+p7
	trl6Ju/2ai2lN+DMnze4pQklFC0uN1Z0Kd7rZAanZBt13DkhyUyy2z99o+MvXDp9suFgCHNdQC6
	mNvyXOe88IwAGgo9L3kl1XZ5d8L21k+HzB6VU
X-Gm-Gg: ASbGncvO862Dtzt1XzA3X7brVtYIePuJfe8MxK+tON6u5QEjpC8acVXuorQGG36aume
	V/vcu32ZUTLKl0ToJFAkK/6QlV4m+hZGQ
X-Google-Smtp-Source: AGHT+IGoNJHKoN6x+zWxbMcbjl/b90SVBx7HZ45s8qML+tSlgik8vUmdVMi5WJbPxRi1Q0Ymi0tL4Bt4QFbX5IRzD98=
X-Received: by 2002:a05:6e02:1c2a:b0:39a:f5a7:50ef with SMTP id
 e9e14a558f8ab-3a6f8a09ba1mr1297405ab.4.1731112196119; Fri, 08 Nov 2024
 16:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108174936.262704-1-irogers@google.com> <20241108174936.262704-3-irogers@google.com>
 <Zy5nfflbnkoG2fGY@google.com>
In-Reply-To: <Zy5nfflbnkoG2fGY@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 16:29:44 -0800
Message-ID: <CAP-5=fUaSCc6z6C36ce4X02tGF4pthULQ9k6+RFzZi1Z2bRDyg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] perf hwmon_pmu: Add hwmon filename parser
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

On Fri, Nov 8, 2024 at 11:33=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 08, 2024 at 09:49:31AM -0800, Ian Rogers wrote:
> > hwmon filenames have a specific encoding that will be used to give a
> > config value. The encoding is described in:
> > Documentation/hwmon/sysfs-interface.rst
> > Add a function to parse the filename into consituent enums/ints that
> > will then be amenable to config encoding.
> >
> > Note, things are done this way to allow mapping names to config and
> > back without the use of hash/dynamic lookup tables.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/Build       |   1 +
> >  tools/perf/util/hwmon_pmu.c | 142 ++++++++++++++++++++++++++++++++++++
> >  tools/perf/util/hwmon_pmu.h | 111 ++++++++++++++++++++++++++++
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 tools/perf/util/hwmon_pmu.c
> >  create mode 100644 tools/perf/util/hwmon_pmu.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1eedead5f2f2..78b990c04f71 100644
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
> > diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> > new file mode 100644
> > index 000000000000..ee5fb1c41da3
> > --- /dev/null
> > +++ b/tools/perf/util/hwmon_pmu.c
> > @@ -0,0 +1,142 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "debug.h"
> > +#include "hwmon_pmu.h"
> > +#include <assert.h>
> > +#include <stddef.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <linux/kernel.h>
> > +
> > +const char * const hwmon_type_strs[HWMON_TYPE_MAX] =3D {
>
> Can we make this array static?  I don't think it's used elsewhere.
>
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
> > +#define LONGEST_HWMON_TYPE_STR "intrusion"
> > +
> > +const char * const hwmon_item_strs[HWMON_ITEM__MAX] =3D {
>
> Ditto.

Done in v8. The testing no longer uses the values.

Thanks,
Ian

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
> > +#define LONGEST_HWMON_ITEM_STR "average_interval_max"
> > +
> > +static int hwmon_strcmp(const void *a, const void *b)
> > +{
> > +     const char *sa =3D a;
> > +     const char * const *sb =3D b;
> > +
> > +     return strcmp(sa, *sb);
> > +}
> > +
> > +bool parse_hwmon_filename(const char *filename,
> > +                       enum hwmon_type *type,
> > +                       int *number,
> > +                       enum hwmon_item *item,
> > +                       bool *alarm)
> > +{
> > +     char fn_type[24];
> > +     const char **elem;
> > +     const char *fn_item =3D NULL;
> > +     size_t fn_item_len;
> > +
> > +     assert(strlen(LONGEST_HWMON_TYPE_STR) < sizeof(fn_type));
> > +     strlcpy(fn_type, filename, sizeof(fn_type));
> > +     for (size_t i =3D 0; fn_type[i] !=3D '\0'; i++) {
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
> > +             assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
> > +             strlcpy(fn_type, fn_item, fn_item_len - 6);
> > +             fn_item =3D fn_type;
> > +             *alarm =3D true;
> > +     }
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
> > diff --git a/tools/perf/util/hwmon_pmu.h b/tools/perf/util/hwmon_pmu.h
> > new file mode 100644
> > index 000000000000..df0ab5ff7534
> > --- /dev/null
> > +++ b/tools/perf/util/hwmon_pmu.h
> > @@ -0,0 +1,111 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +#ifndef __HWMON_PMU_H
> > +#define __HWMON_PMU_H
> > +
> > +#include <stdbool.h>
> > +
> > +/**
> > + * enum hwmon_type:
> > + *
> > + * As described in Documentation/hwmon/sysfs-interface.rst hwmon event=
s are
> > + * defined over multiple files of the form <type><num>_<item>. This en=
um
> > + * captures potential <type> values.
> > + *
> > + * This enum is exposed for testing.
> > + */
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
> > +
> > +     HWMON_TYPE_MAX
> > +};
> > +
> > +/**
> > + * enum hwmon_item:
> > + *
> > + * Similar to enum hwmon_type but describes the item part of a a sysfs=
 filename.
> > + *
> > + * This enum is exposed for testing.
> > + */
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
> > +/**
> > + * parse_hwmon_filename() - Parse filename into constituent parts.
> > + *
> > + * @filename: To be parsed, of the form <type><number>_<item>.
> > + * @type: The type defined from the parsed file name.
> > + * @number: The number of the type, for example there may be more than=
 1 fan.
> > + * @item: A hwmon <type><number> may have multiple associated items.
> > + * @alarm: Is the filename for an alarm value?
> > + *
> > + * An example of a hwmon filename is "temp1_input". The type is temp f=
or a
> > + * temperature value. The number is 1. The item within the file is an =
input
> > + * value - the temperature itself. This file doesn't contain an alarm =
value.
> > + *
> > + * Exposed for testing.
> > + */
> > +bool parse_hwmon_filename(const char *filename,
> > +                       enum hwmon_type *type,
> > +                       int *number,
> > +                       enum hwmon_item *item,
> > +                       bool *alarm);
> > +
> > +#endif /* __HWMON_PMU_H */
> > --
> > 2.47.0.277.g8800431eea-goog
> >
