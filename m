Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FF7E57F;
	Wed,  8 May 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173384; cv=none; b=vEUlIuox9GiLfacL6Mm22X7Vr5ueW/h/5V/dqbsfbJZhOiERdj3M/z9w9S1Xf1lHOqTA5bCv5rHVxHhc6oU1ePvT2jTY2d/mMOnX7Du1ogO1oxWyHFxNBO5ENSUnYPAa2k+gp3libp5Cy/h7GKNPTxPjoQV1rr+AMGGw7s6mp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173384; c=relaxed/simple;
	bh=01LJvPegPkRkhZihRNl/WMO4vMJyZSWpYYOjBKJ/LDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5lXfTvdOaq/PBayPRAltMCgu3EiggO7QhP2ai1j4Qw6l7hU73/VBmeAb0/RyLyoaf5kIj254e4FpCJ7vlzNCbxNfojppwXcNakDN1yTuSMGD9efxS9WIzapdfSuaAZe0ok6eFoT1FL8j/eH83meWTnm0IXorr/2f62gCa2buv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um8A1+Gb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um8A1+Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6CFC4AF66;
	Wed,  8 May 2024 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715173383;
	bh=01LJvPegPkRkhZihRNl/WMO4vMJyZSWpYYOjBKJ/LDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=um8A1+GbLmhUZSQa/iVdTWhjZAyH/DLQiN13SIfEp0+dr+oDxeCY7uQPvwuAghMET
	 8qGPJkH5kf19Lc/ciZohALp6Y+3Ng4i3iYHXXgDgDwF9/XZfwRjlK+0kP4dKf5BT08
	 1LsIYL3u47plEZhSJg/CsDqmoU4TlhwLKraezgeZUs+lhL+JIDgTg0eXVG5NTXj/3n
	 bNCJhAaDHay8CchQXlbtuBcwv3m9aASsIUT26ig7euHW3+i13lq5dCBp0whdKHb9Rd
	 k/u9pudGHgBEsXUiBmZ72N9rTk6b/MIXCedKeOuwV3aOq1IGw1Ygh1Ia27bcuZ/H+c
	 7PxsqKiO5FOFw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so7288129e87.1;
        Wed, 08 May 2024 06:03:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH7LM8KPg0I/g33/UW2ozI6Xn3K3eEK9SWTZKeUyQLLqlcGSD+TJnqfr0bzkE4uuomHbY3LpMi8ZeX7XlyXsyl/5OhuEyIlpQuamU/R5m3PnoCKJGeRQCy+Ayz4+4wUJQciVhIKVN+TnvyC8HKZw==
X-Gm-Message-State: AOJu0Yz2IDYhjQDtauisMRrusoU5uLIPvJ5/Y23DpXM/HkgLC0TtZHZU
	0hwlgMqCepRzGZFooMF7GyrzIqQ7N49Nnq48863zRUPbID8+T1xl5EW0voJB/AipNzQELHkfepp
	jjv3wdHJl3vDt2cIVb3A3jwkUUcE=
X-Google-Smtp-Source: AGHT+IG+00kY9mpFe8s5aIyse0mMpyW1ULwLO8p3m8f7XlHKxR6q519vRQk49KDn8ns8Dfm0olRbRGNIY8yAzjGtAVQ=
X-Received: by 2002:a19:ad06:0:b0:51d:a208:2282 with SMTP id
 2adb3069b0e04-5217cd49611mr2247119e87.51.1715173381671; Wed, 08 May 2024
 06:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411121047.2005033-1-maobibo@loongson.cn> <db839f86-6749-e15b-a084-d8a4a6735f1c@loongson.cn>
In-Reply-To: <db839f86-6749-e15b-a084-d8a4a6735f1c@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 8 May 2024 21:02:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4MucyKrQdxBtoh7PJZDiWo1kB-9TP2L-x0tw8vh=ypNQ@mail.gmail.com>
Message-ID: <CAAhV-H4MucyKrQdxBtoh7PJZDiWo1kB-9TP2L-x0tw8vh=ypNQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf kvm: Add kvm-stat for loongarch64
To: maobibo <maobibo@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>, 
	Ming Wang <wangming01@loongson.cn>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:11=E2=80=AFPM maobibo <maobibo@loongson.cn> wrote:
>
> Hi Peter/Ian/Huacai,
>
> This patch stays one month without response, I know you are busy and
> look through thousands of patch every day.
>
> Just one question, who has permission to merge perf kvm patch for
> LoongArch. Is it LoongArch maintainer or perf kvm maintainer?
It should probably go to perf tree, but if it is allowed, maybe I can
try to merge into LoongArch tree.


Huacai
>
> Regards
> Bibo Mao
>
>
> On 2024/4/11 =E4=B8=8B=E5=8D=888:10, Bibo Mao wrote:
> > Add support for 'perf kvm stat' on loongarch64 platform, now only
> > kvm exit event is supported.
> >
> > Here is example output about "perf kvm --host stat report" command
> >
> >     Event name   Samples   Sample%     Time (ns)   Time%   Mean Time (n=
s)
> >      Mem store     83969    51.00%     625697070   8.00%             74=
51
> >       Mem read     37641    22.00%     112485730   1.00%             29=
88
> >      Interrupt     15542     9.00%      20620190   0.00%             13=
26
> >          Iocsr     15207     9.00%      94296190   1.00%             62=
00
> >      Hypercall      4873     2.00%      12265280   0.00%             25=
16
> >           Idle      3713     2.00%    6322055860  87.00%          17026=
81
> >            FPU      1819     1.00%       2750300   0.00%             15=
11
> >         Ifecth       502     0.00%       1341740   0.00%             26=
72
> >     Mem modify       324     0.00%        602240   0.00%             18=
58
> >         Cpucfg        55     0.00%         77610   0.00%             14=
11
> >            Csr        12     0.00%         19690   0.00%             16=
40
> >           LASX         3     0.00%          4870   0.00%             16=
23
> >            LSX         2     0.00%          2100   0.00%             10=
50
> >
> > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > ---
> > v2 --- v3:
> >    1. Add NULL check with cpuid in function get_cpuid()
> >    2. Add example output from /proc/cpuinfo before function get_cpuid()
> > v1 --- v2:
> >    1. Add child_ops for kvm exit event, split kvm:kvm_exit_gspr events
> > into cpucfg/csr/iocsr/idle child events by decoding detailed gspr
> > instruction.
> >    2. Remove some exception code type which does not happen in current
> > kvm implementation, such as meomry NR/NX/priviledge exception.
> > ---
> >   tools/perf/arch/loongarch/Makefile        |   1 +
> >   tools/perf/arch/loongarch/util/Build      |   2 +
> >   tools/perf/arch/loongarch/util/header.c   |  88 ++++++++++++++
> >   tools/perf/arch/loongarch/util/kvm-stat.c | 135 +++++++++++++++++++++=
+
> >   4 files changed, 226 insertions(+)
> >   create mode 100644 tools/perf/arch/loongarch/util/header.c
> >   create mode 100644 tools/perf/arch/loongarch/util/kvm-stat.c
> >
> > diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loong=
arch/Makefile
> > index 3992a67a87d9..c89d6bb6b184 100644
> > --- a/tools/perf/arch/loongarch/Makefile
> > +++ b/tools/perf/arch/loongarch/Makefile
> > @@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS :=3D 1
> >   endif
> >   PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> >   PERF_HAVE_JITDUMP :=3D 1
> > +HAVE_KVM_STAT_SUPPORT :=3D 1
> >
> >   #
> >   # Syscall table generation for perf
> > diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loo=
ngarch/util/Build
> > index d776125a2d06..b12d374d7096 100644
> > --- a/tools/perf/arch/loongarch/util/Build
> > +++ b/tools/perf/arch/loongarch/util/Build
> > @@ -1,5 +1,7 @@
> > +perf-y +=3D header.o
> >   perf-y +=3D perf_regs.o
> >
> >   perf-$(CONFIG_DWARF)     +=3D dwarf-regs.o
> >   perf-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> >   perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> > diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arch/=
loongarch/util/header.c
> > new file mode 100644
> > index 000000000000..a4ed732b49c6
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/header.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Implementation of get_cpuid().
> > + *
> > + * Author: Nikita Shubin <n.shubin@yadro.com>
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <api/fs/fs.h>
> > +#include <errno.h>
> > +#include "util/debug.h"
> > +#include "util/header.h"
> > +
> > +/*
> > + * Output example from /proc/cpuinfo
> > + *   CPU Family              : Loongson-64bit
> > + *   Model Name              : Loongson-3C5000
> > + *   CPU Revision            : 0x11
> > + */
> > +#define CPUINFO_MODEL        "Model Name"
> > +#define CPUINFO              "/proc/cpuinfo"
> > +static char *_get_field(const char *line)
> > +{
> > +     char *line2, *nl;
> > +
> > +     line2 =3D strrchr(line, ' ');
> > +     if (!line2)
> > +             return NULL;
> > +
> > +     line2++;
> > +     nl =3D strrchr(line, '\n');
> > +     if (!nl)
> > +             return NULL;
> > +
> > +     return strndup(line2, nl - line2);
> > +}
> > +
> > +static char *__get_cpuid(void)
> > +{
> > +     char *line, *model, *cpuid;
> > +     unsigned long line_sz;
> > +     FILE *file;
> > +
> > +     file =3D fopen(CPUINFO, "r");
> > +     if (file =3D=3D NULL)
> > +             return cpuid;
> > +
> > +     line =3D model =3D cpuid =3D NULL;
> > +     while (getline(&line, &line_sz, file) !=3D -1) {
> > +             if (strncmp(line, CPUINFO_MODEL, strlen(CPUINFO_MODEL)))
> > +                     continue;
> > +
> > +             model =3D _get_field(line);
> > +             if (!model)
> > +                     goto free;
> > +             break;
> > +     }
> > +
> > +     if (model && (asprintf(&cpuid, "%s", model) < 0))
> > +             cpuid =3D NULL;
> > +
> > +free:
> > +     fclose(file);
> > +     free(model);
> > +     return cpuid;
> > +}
> > +
> > +int get_cpuid(char *buffer, size_t sz)
> > +{
> > +     char *cpuid =3D __get_cpuid();
> > +     int ret =3D 0;
> > +
> > +     if (!cpuid)
> > +             return EINVAL;
> > +
> > +     if (sz >=3D strlen(cpuid))
> > +             scnprintf(buffer, sz, "%s", cpuid);
> > +     else
> > +             ret =3D ENOBUFS;
> > +     free(cpuid);
> > +     return ret;
> > +}
> > +
> > +char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> > +{
> > +     return __get_cpuid();
> > +}
> > diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/arc=
h/loongarch/util/kvm-stat.c
> > new file mode 100644
> > index 000000000000..cc50adb0835a
> > --- /dev/null
> > +++ b/tools/perf/arch/loongarch/util/kvm-stat.c
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <errno.h>
> > +#include <memory.h>
> > +#include <errno.h>
> > +#include "util/kvm-stat.h"
> > +#include "util/parse-events.h"
> > +#include "util/debug.h"
> > +#include "util/evsel.h"
> > +#include "util/evlist.h"
> > +#include "util/pmus.h"
> > +
> > +#define LOONGARCH_EXCEPTION_INT              0
> > +#define LOONGARCH_EXCEPTION_PIL              1
> > +#define LOONGARCH_EXCEPTION_PIS              2
> > +#define LOONGARCH_EXCEPTION_PIF              3
> > +#define LOONGARCH_EXCEPTION_PME              4
> > +#define LOONGARCH_EXCEPTION_FPD              15
> > +#define LOONGARCH_EXCEPTION_SXD              16
> > +#define LOONGARCH_EXCEPTION_ASXD     17
> > +#define LOONGARCH_EXCEPTION_GSPR     22
> > +#define  LOONGARCH_EXCEPTION_CPUCFG  100
> > +#define  LOONGARCH_EXCEPTION_CSR     101
> > +#define  LOONGARCH_EXCEPTION_IOCSR   102
> > +#define  LOONGARCH_EXCEPTION_IDLE    103
> > +#define  LOONGARCH_EXCEPTION_OTHERS  104
> > +#define LOONGARCH_EXCEPTION_HVC              23
> > +
> > +#define loongarch_exception_type                             \
> > +     {LOONGARCH_EXCEPTION_INT,  "Interrupt" },               \
> > +     {LOONGARCH_EXCEPTION_PIL,  "Mem read" },                \
> > +     {LOONGARCH_EXCEPTION_PIS,  "Mem store" },               \
> > +     {LOONGARCH_EXCEPTION_PIF,  "Ifecth" },                  \
> > +     {LOONGARCH_EXCEPTION_PME,  "Mem modify" },              \
> > +     {LOONGARCH_EXCEPTION_FPD,  "FPU" },                     \
> > +     {LOONGARCH_EXCEPTION_SXD,  "LSX" },                     \
> > +     {LOONGARCH_EXCEPTION_ASXD, "LASX" },                    \
> > +     {LOONGARCH_EXCEPTION_GSPR, "Privilege Error" },         \
> > +     {LOONGARCH_EXCEPTION_HVC,  "Hypercall" },               \
> > +     {LOONGARCH_EXCEPTION_CPUCFG, "Cpucfg" },                \
> > +     {LOONGARCH_EXCEPTION_CSR,    "Csr" },                   \
> > +     {LOONGARCH_EXCEPTION_IOCSR,  "Iocsr" },                 \
> > +     {LOONGARCH_EXCEPTION_IDLE,   "Idle" },                  \
> > +     {LOONGARCH_EXCEPTION_OTHERS, "Others" }
> > +
> > +define_exit_reasons_table(loongarch_exit_reasons, loongarch_exception_=
type);
> > +
> > +const char *vcpu_id_str =3D "vcpu_id";
> > +const char *kvm_exit_reason =3D "reason";
> > +const char *kvm_entry_trace =3D "kvm:kvm_enter";
> > +const char *kvm_reenter_trace =3D "kvm:kvm_reenter";
> > +const char *kvm_exit_trace =3D "kvm:kvm_exit";
> > +const char *kvm_events_tp[] =3D {
> > +     "kvm:kvm_enter",
> > +     "kvm:kvm_reenter",
> > +     "kvm:kvm_exit",
> > +     "kvm:kvm_exit_gspr",
> > +     NULL,
> > +};
> > +
> > +static bool event_end(struct evsel *evsel,
> > +             struct perf_sample *sample __maybe_unused,
> > +             struct event_key *key __maybe_unused)
> > +{
> > +     /*
> > +      * LoongArch kvm is different with other architectures
> > +      *
> > +      * There is kvm:kvm_reenter or kvm:kvm_enter event adjacent with
> > +      * kvm:kvm_exit event.
> > +      *   kvm:kvm_reenter means returning to guest immediately
> > +      *   kvm:kvm_enter   means returning to vmm and then to guest
> > +      */
> > +     return evsel__name_is(evsel, kvm_entry_trace) ||
> > +             evsel__name_is(evsel, kvm_reenter_trace);
> > +}
> > +
> > +static void event_gspr_get_key(struct evsel *evsel,
> > +                     struct perf_sample *sample,
> > +                     struct event_key *key)
> > +{
> > +     unsigned int insn;
> > +
> > +     key->key =3D LOONGARCH_EXCEPTION_OTHERS;
> > +     insn =3D evsel__intval(evsel, sample, "inst_word");
> > +     switch (insn >> 24) {
> > +     case 0:
> > +             /* cpucfg inst trap */
> > +             if ((insn >> 10) =3D=3D 0x1b)
> > +                     key->key =3D LOONGARCH_EXCEPTION_CPUCFG;
> > +             break;
> > +     case 4:
> > +             /* csr inst trap */
> > +             key->key =3D LOONGARCH_EXCEPTION_CSR;
> > +             break;
> > +     case 6:
> > +             /* iocsr inst trap */
> > +             if ((insn >> 15) =3D=3D 0xc90)
> > +                     key->key =3D LOONGARCH_EXCEPTION_IOCSR;
> > +             else if ((insn >> 15) =3D=3D 0xc91)
> > +                     /* idle inst trap */
> > +                     key->key =3D LOONGARCH_EXCEPTION_IDLE;
> > +             break;
> > +     default:
> > +             key->key =3D LOONGARCH_EXCEPTION_OTHERS;
> > +             break;
> > +     }
> > +}
> > +
> > +static struct child_event_ops child_events[] =3D {
> > +     { .name =3D "kvm:kvm_exit_gspr", .get_key =3D event_gspr_get_key =
},
> > +     { NULL, NULL },
> > +};
> > +
> > +static struct kvm_events_ops exit_events =3D {
> > +     .is_begin_event =3D exit_event_begin,
> > +     .is_end_event =3D event_end,
> > +     .child_ops =3D child_events,
> > +     .decode_key =3D exit_event_decode_key,
> > +     .name =3D "VM-EXIT"
> > +};
> > +
> > +struct kvm_reg_events_ops kvm_reg_events_ops[] =3D {
> > +     { .name =3D "vmexit", .ops =3D &exit_events, },
> > +     { NULL, NULL },
> > +};
> > +
> > +const char * const kvm_skip_events[] =3D {
> > +     NULL,
> > +};
> > +
> > +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_=
unused)
> > +{
> > +     kvm->exit_reasons_isa =3D "loongarch64";
> > +     kvm->exit_reasons =3D loongarch_exit_reasons;
> > +     return 0;
> > +}
> >
> > base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> >
>
