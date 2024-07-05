Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6613958F;
	Fri,  5 Jul 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172294; cv=none; b=uzlPTZriJFa16Viv3j9vIFRCgjx28Ufg8KI46i1O7vwXcHu1X2P4i6sP2AUlGb1Ny0iUHn7IXNkfnEW659oGMrvkqaF6QMlELiduCac7CghgMTLOdb6WNjQM+6BpzTniAFvd6CQK8iQp1S/FUxiH/mp02V9mO0LKNafeBmkkKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172294; c=relaxed/simple;
	bh=FMcEoxCi8WXEv4E49B88O6NuYPduZfIlmGxqcapk8f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1zlRexij2JNB/aVU/Om8ePp3iUUJGhJwqUwa58FwOVNw1uBrhxadBv84ZLUfk82dX2l6qVgVny+QR20GW2KNDf7R2QYfZ5RrmzwwChscyqYrCHcmo0YpKFTnkBSNBgQFMUxlrXcdwJi806oRrT0avkvr6WZsMz0lOdrzfcYfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP2VETSC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP2VETSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62EFC4AF0A;
	Fri,  5 Jul 2024 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720172293;
	bh=FMcEoxCi8WXEv4E49B88O6NuYPduZfIlmGxqcapk8f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CP2VETSCrQFpLUWVoLrHiVNBKQeWowyKSDapIA55BFd0iQBvrPjg74P5VB/t4dvlo
	 r7N+4IT8vzohgD2hpkfzWDNGuQdSK6EUtU2AgXT2DBHzNEy7YwAxUcHHXlaoPuhNBn
	 dMb7D908vzsQ3LKtQk8CWJgK4TeBYlr3arBkLAF2ER+8rTN5dYk8fotpfByLg6TeaP
	 0HsmUizxDxGsgn5PU+4z78zIdo80IfukCoDs1ufm+awkvtg478pZoTS/yuUbReAKJv
	 qW8/Lhfvj1P2Okg8CRDlbaVpUn7ptJMgo6vkiLfaymgWBJM3gx9ol3XR+IgxE3lMdW
	 cx0lWUQPSVVqQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724a8097deso176333066b.1;
        Fri, 05 Jul 2024 02:38:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK9NQKkgqzKiOIbozidhrq1tkPLn2pLyD1JbHM3ezdkOk6afcbuWy8U/nGA1dUcZRC4cjZ6ijORXZg4R4LrsMob+iuOnj/z/3Ca7LQKzAYmFpwrFPWS+2hNv8GcMnXgqIzYanzZ1yvOECCE9y8Yg==
X-Gm-Message-State: AOJu0YzSZPIWWycr2xPDvWgYDzFdRDzYtyTZrG043zoHeuhch5vPEBFh
	TwQvYVgexpTdoCG+udk+zfLWhX9TZ/bAflmwBl3dyZmaWaiKPJs35DTW7hfVtUPbMbwcfY9psfN
	pENpTtAAQ5u+TbN4Yhh/kTZxkjF0=
X-Google-Smtp-Source: AGHT+IFPEz5Z64bP/NBrbn0I+EgtKz9X87B7IaPM5wpAjlZLf15LkqXjdqVzYcavH34qTIjVjg9PqtGAu086jBhROV4=
X-Received: by 2002:a17:907:94d0:b0:a77:a403:f260 with SMTP id
 a640c23a62f3a-a77ba44c776mr321068066b.4.1720172292172; Fri, 05 Jul 2024
 02:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411121047.2005033-1-maobibo@loongson.cn> <db839f86-6749-e15b-a084-d8a4a6735f1c@loongson.cn>
 <CAAhV-H4MucyKrQdxBtoh7PJZDiWo1kB-9TP2L-x0tw8vh=ypNQ@mail.gmail.com> <83ae11b8-69af-eaf8-8768-dc6d55cdcd90@loongson.cn>
In-Reply-To: <83ae11b8-69af-eaf8-8768-dc6d55cdcd90@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 5 Jul 2024 17:38:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7V9crTHnMdHgpZTW_h8vMCz3VJANLmveUsZu6zeoNmHA@mail.gmail.com>
Message-ID: <CAAhV-H7V9crTHnMdHgpZTW_h8vMCz3VJANLmveUsZu6zeoNmHA@mail.gmail.com>
Subject: Re: [PATCH v3] perf kvm: Add kvm-stat for loongarch64
To: maobibo <maobibo@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>, 
	Ming Wang <wangming01@loongson.cn>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Fri, May 10, 2024 at 9:47=E2=80=AFAM maobibo <maobibo@loongson.cn> wrote=
:
>
>
>
> On 2024/5/8 =E4=B8=8B=E5=8D=889:02, Huacai Chen wrote:
> > On Tue, May 7, 2024 at 2:11=E2=80=AFPM maobibo <maobibo@loongson.cn> wr=
ote:
> >>
> >> Hi Peter/Ian/Huacai,
> >>
> >> This patch stays one month without response, I know you are busy and
> >> look through thousands of patch every day.
> >>
> >> Just one question, who has permission to merge perf kvm patch for
> >> LoongArch. Is it LoongArch maintainer or perf kvm maintainer?
> > It should probably go to perf tree, but if it is allowed, maybe I can
> > try to merge into LoongArch tree.
>
>   tools/perf/arch/loongarch/Makefile        |   1 +
>   tools/perf/arch/loongarch/util/Build      |   2 +
>   tools/perf/arch/loongarch/util/header.c   |  88 ++++++++++++++
>   tools/perf/arch/loongarch/util/kvm-stat.c | 135 ++++++++++++++++++++++
>
> All the modification is LoongArch specific, there will be much
> appreciated if it can reviewed and merged.
>
> Regards
> Bibo Mao
>
> >
> >
> > Huacai
> >>
> >> Regards
> >> Bibo Mao
> >>
> >>
> >> On 2024/4/11 =E4=B8=8B=E5=8D=888:10, Bibo Mao wrote:
> >>> Add support for 'perf kvm stat' on loongarch64 platform, now only
> >>> kvm exit event is supported.
> >>>
> >>> Here is example output about "perf kvm --host stat report" command
> >>>
> >>>      Event name   Samples   Sample%     Time (ns)   Time%   Mean Time=
 (ns)
> >>>       Mem store     83969    51.00%     625697070   8.00%            =
 7451
> >>>        Mem read     37641    22.00%     112485730   1.00%            =
 2988
> >>>       Interrupt     15542     9.00%      20620190   0.00%            =
 1326
> >>>           Iocsr     15207     9.00%      94296190   1.00%            =
 6200
> >>>       Hypercall      4873     2.00%      12265280   0.00%            =
 2516
> >>>            Idle      3713     2.00%    6322055860  87.00%          17=
02681
> >>>             FPU      1819     1.00%       2750300   0.00%            =
 1511
> >>>          Ifecth       502     0.00%       1341740   0.00%            =
 2672
> >>>      Mem modify       324     0.00%        602240   0.00%            =
 1858
> >>>          Cpucfg        55     0.00%         77610   0.00%            =
 1411
> >>>             Csr        12     0.00%         19690   0.00%            =
 1640
> >>>            LASX         3     0.00%          4870   0.00%            =
 1623
> >>>             LSX         2     0.00%          2100   0.00%            =
 1050
> >>>
> >>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>> ---
> >>> v2 --- v3:
> >>>     1. Add NULL check with cpuid in function get_cpuid()
> >>>     2. Add example output from /proc/cpuinfo before function get_cpui=
d()
> >>> v1 --- v2:
> >>>     1. Add child_ops for kvm exit event, split kvm:kvm_exit_gspr even=
ts
> >>> into cpucfg/csr/iocsr/idle child events by decoding detailed gspr
> >>> instruction.
> >>>     2. Remove some exception code type which does not happen in curre=
nt
> >>> kvm implementation, such as meomry NR/NX/priviledge exception.
> >>> ---
> >>>    tools/perf/arch/loongarch/Makefile        |   1 +
> >>>    tools/perf/arch/loongarch/util/Build      |   2 +
> >>>    tools/perf/arch/loongarch/util/header.c   |  88 ++++++++++++++
> >>>    tools/perf/arch/loongarch/util/kvm-stat.c | 135 ++++++++++++++++++=
++++
> >>>    4 files changed, 226 insertions(+)
> >>>    create mode 100644 tools/perf/arch/loongarch/util/header.c
> >>>    create mode 100644 tools/perf/arch/loongarch/util/kvm-stat.c
> >>>
> >>> diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loo=
ngarch/Makefile
> >>> index 3992a67a87d9..c89d6bb6b184 100644
> >>> --- a/tools/perf/arch/loongarch/Makefile
> >>> +++ b/tools/perf/arch/loongarch/Makefile
> >>> @@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS :=3D 1
> >>>    endif
> >>>    PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> >>>    PERF_HAVE_JITDUMP :=3D 1
> >>> +HAVE_KVM_STAT_SUPPORT :=3D 1
> >>>
> >>>    #
> >>>    # Syscall table generation for perf
> >>> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/l=
oongarch/util/Build
> >>> index d776125a2d06..b12d374d7096 100644
> >>> --- a/tools/perf/arch/loongarch/util/Build
> >>> +++ b/tools/perf/arch/loongarch/util/Build
> >>> @@ -1,5 +1,7 @@
> >>> +perf-y +=3D header.o
> >>>    perf-y +=3D perf_regs.o
> >>>
> >>>    perf-$(CONFIG_DWARF)     +=3D dwarf-regs.o
> >>>    perf-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> >>>    perf-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >>> +perf-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> >>> diff --git a/tools/perf/arch/loongarch/util/header.c b/tools/perf/arc=
h/loongarch/util/header.c
> >>> new file mode 100644
> >>> index 000000000000..a4ed732b49c6
> >>> --- /dev/null
> >>> +++ b/tools/perf/arch/loongarch/util/header.c
> >>> @@ -0,0 +1,88 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Implementation of get_cpuid().
> >>> + *
> >>> + * Author: Nikita Shubin <n.shubin@yadro.com>
> >>> + */
> >>> +
> >>> +#include <stdio.h>
> >>> +#include <stdlib.h>
> >>> +#include <api/fs/fs.h>
> >>> +#include <errno.h>
> >>> +#include "util/debug.h"
> >>> +#include "util/header.h"
> >>> +
> >>> +/*
> >>> + * Output example from /proc/cpuinfo
> >>> + *   CPU Family              : Loongson-64bit
> >>> + *   Model Name              : Loongson-3C5000
> >>> + *   CPU Revision            : 0x11
> >>> + */
> >>> +#define CPUINFO_MODEL        "Model Name"
> >>> +#define CPUINFO              "/proc/cpuinfo"
> >>> +static char *_get_field(const char *line)
> >>> +{
> >>> +     char *line2, *nl;
> >>> +
> >>> +     line2 =3D strrchr(line, ' ');
> >>> +     if (!line2)
> >>> +             return NULL;
> >>> +
> >>> +     line2++;
> >>> +     nl =3D strrchr(line, '\n');
> >>> +     if (!nl)
> >>> +             return NULL;
> >>> +
> >>> +     return strndup(line2, nl - line2);
> >>> +}
> >>> +
> >>> +static char *__get_cpuid(void)
> >>> +{
> >>> +     char *line, *model, *cpuid;
> >>> +     unsigned long line_sz;
> >>> +     FILE *file;
> >>> +
> >>> +     file =3D fopen(CPUINFO, "r");
> >>> +     if (file =3D=3D NULL)
> >>> +             return cpuid;
> >>> +
> >>> +     line =3D model =3D cpuid =3D NULL;
> >>> +     while (getline(&line, &line_sz, file) !=3D -1) {
> >>> +             if (strncmp(line, CPUINFO_MODEL, strlen(CPUINFO_MODEL))=
)
> >>> +                     continue;
> >>> +
> >>> +             model =3D _get_field(line);
> >>> +             if (!model)
> >>> +                     goto free;
> >>> +             break;
> >>> +     }
> >>> +
> >>> +     if (model && (asprintf(&cpuid, "%s", model) < 0))
> >>> +             cpuid =3D NULL;
> >>> +
> >>> +free:
> >>> +     fclose(file);
> >>> +     free(model);
> >>> +     return cpuid;
> >>> +}
> >>> +
> >>> +int get_cpuid(char *buffer, size_t sz)
> >>> +{
> >>> +     char *cpuid =3D __get_cpuid();
> >>> +     int ret =3D 0;
> >>> +
> >>> +     if (!cpuid)
> >>> +             return EINVAL;
> >>> +
> >>> +     if (sz >=3D strlen(cpuid))
> >>> +             scnprintf(buffer, sz, "%s", cpuid);
> >>> +     else
> >>> +             ret =3D ENOBUFS;
> >>> +     free(cpuid);
> >>> +     return ret;
> >>> +}
> >>> +
> >>> +char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> >>> +{
> >>> +     return __get_cpuid();
> >>> +}
> >>> diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/a=
rch/loongarch/util/kvm-stat.c
> >>> new file mode 100644
> >>> index 000000000000..cc50adb0835a
> >>> --- /dev/null
> >>> +++ b/tools/perf/arch/loongarch/util/kvm-stat.c
> >>> @@ -0,0 +1,135 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +#include <errno.h>
> >>> +#include <memory.h>
> >>> +#include <errno.h>
> >>> +#include "util/kvm-stat.h"
> >>> +#include "util/parse-events.h"
> >>> +#include "util/debug.h"
> >>> +#include "util/evsel.h"
> >>> +#include "util/evlist.h"
> >>> +#include "util/pmus.h"
> >>> +
> >>> +#define LOONGARCH_EXCEPTION_INT              0
> >>> +#define LOONGARCH_EXCEPTION_PIL              1
> >>> +#define LOONGARCH_EXCEPTION_PIS              2
> >>> +#define LOONGARCH_EXCEPTION_PIF              3
> >>> +#define LOONGARCH_EXCEPTION_PME              4
> >>> +#define LOONGARCH_EXCEPTION_FPD              15
> >>> +#define LOONGARCH_EXCEPTION_SXD              16
> >>> +#define LOONGARCH_EXCEPTION_ASXD     17
> >>> +#define LOONGARCH_EXCEPTION_GSPR     22
> >>> +#define  LOONGARCH_EXCEPTION_CPUCFG  100
> >>> +#define  LOONGARCH_EXCEPTION_CSR     101
> >>> +#define  LOONGARCH_EXCEPTION_IOCSR   102
> >>> +#define  LOONGARCH_EXCEPTION_IDLE    103
> >>> +#define  LOONGARCH_EXCEPTION_OTHERS  104
> >>> +#define LOONGARCH_EXCEPTION_HVC              23
> >>> +
> >>> +#define loongarch_exception_type                             \
> >>> +     {LOONGARCH_EXCEPTION_INT,  "Interrupt" },               \
> >>> +     {LOONGARCH_EXCEPTION_PIL,  "Mem read" },                \
> >>> +     {LOONGARCH_EXCEPTION_PIS,  "Mem store" },               \
> >>> +     {LOONGARCH_EXCEPTION_PIF,  "Ifecth" },                  \
> >>> +     {LOONGARCH_EXCEPTION_PME,  "Mem modify" },              \
> >>> +     {LOONGARCH_EXCEPTION_FPD,  "FPU" },                     \
> >>> +     {LOONGARCH_EXCEPTION_SXD,  "LSX" },                     \
> >>> +     {LOONGARCH_EXCEPTION_ASXD, "LASX" },                    \
> >>> +     {LOONGARCH_EXCEPTION_GSPR, "Privilege Error" },         \
> >>> +     {LOONGARCH_EXCEPTION_HVC,  "Hypercall" },               \
> >>> +     {LOONGARCH_EXCEPTION_CPUCFG, "Cpucfg" },                \
> >>> +     {LOONGARCH_EXCEPTION_CSR,    "Csr" },                   \
> >>> +     {LOONGARCH_EXCEPTION_IOCSR,  "Iocsr" },                 \
> >>> +     {LOONGARCH_EXCEPTION_IDLE,   "Idle" },                  \
> >>> +     {LOONGARCH_EXCEPTION_OTHERS, "Others" }
> >>> +
> >>> +define_exit_reasons_table(loongarch_exit_reasons, loongarch_exceptio=
n_type);
> >>> +
> >>> +const char *vcpu_id_str =3D "vcpu_id";
> >>> +const char *kvm_exit_reason =3D "reason";
> >>> +const char *kvm_entry_trace =3D "kvm:kvm_enter";
> >>> +const char *kvm_reenter_trace =3D "kvm:kvm_reenter";
> >>> +const char *kvm_exit_trace =3D "kvm:kvm_exit";
> >>> +const char *kvm_events_tp[] =3D {
> >>> +     "kvm:kvm_enter",
> >>> +     "kvm:kvm_reenter",
> >>> +     "kvm:kvm_exit",
> >>> +     "kvm:kvm_exit_gspr",
> >>> +     NULL,
> >>> +};
> >>> +
> >>> +static bool event_end(struct evsel *evsel,
> >>> +             struct perf_sample *sample __maybe_unused,
> >>> +             struct event_key *key __maybe_unused)
> >>> +{
> >>> +     /*
> >>> +      * LoongArch kvm is different with other architectures
> >>> +      *
> >>> +      * There is kvm:kvm_reenter or kvm:kvm_enter event adjacent wit=
h
> >>> +      * kvm:kvm_exit event.
> >>> +      *   kvm:kvm_reenter means returning to guest immediately
> >>> +      *   kvm:kvm_enter   means returning to vmm and then to guest
> >>> +      */
> >>> +     return evsel__name_is(evsel, kvm_entry_trace) ||
> >>> +             evsel__name_is(evsel, kvm_reenter_trace);
> >>> +}
> >>> +
> >>> +static void event_gspr_get_key(struct evsel *evsel,
> >>> +                     struct perf_sample *sample,
> >>> +                     struct event_key *key)
> >>> +{
> >>> +     unsigned int insn;
> >>> +
> >>> +     key->key =3D LOONGARCH_EXCEPTION_OTHERS;
> >>> +     insn =3D evsel__intval(evsel, sample, "inst_word");
> >>> +     switch (insn >> 24) {
> >>> +     case 0:
> >>> +             /* cpucfg inst trap */
> >>> +             if ((insn >> 10) =3D=3D 0x1b)
> >>> +                     key->key =3D LOONGARCH_EXCEPTION_CPUCFG;
> >>> +             break;
> >>> +     case 4:
> >>> +             /* csr inst trap */
> >>> +             key->key =3D LOONGARCH_EXCEPTION_CSR;
> >>> +             break;
> >>> +     case 6:
> >>> +             /* iocsr inst trap */
> >>> +             if ((insn >> 15) =3D=3D 0xc90)
> >>> +                     key->key =3D LOONGARCH_EXCEPTION_IOCSR;
> >>> +             else if ((insn >> 15) =3D=3D 0xc91)
> >>> +                     /* idle inst trap */
> >>> +                     key->key =3D LOONGARCH_EXCEPTION_IDLE;
> >>> +             break;
> >>> +     default:
> >>> +             key->key =3D LOONGARCH_EXCEPTION_OTHERS;
> >>> +             break;
> >>> +     }
> >>> +}
> >>> +
> >>> +static struct child_event_ops child_events[] =3D {
> >>> +     { .name =3D "kvm:kvm_exit_gspr", .get_key =3D event_gspr_get_ke=
y },
> >>> +     { NULL, NULL },
> >>> +};
> >>> +
> >>> +static struct kvm_events_ops exit_events =3D {
> >>> +     .is_begin_event =3D exit_event_begin,
> >>> +     .is_end_event =3D event_end,
> >>> +     .child_ops =3D child_events,
> >>> +     .decode_key =3D exit_event_decode_key,
> >>> +     .name =3D "VM-EXIT"
> >>> +};
> >>> +
> >>> +struct kvm_reg_events_ops kvm_reg_events_ops[] =3D {
> >>> +     { .name =3D "vmexit", .ops =3D &exit_events, },
> >>> +     { NULL, NULL },
> >>> +};
> >>> +
> >>> +const char * const kvm_skip_events[] =3D {
> >>> +     NULL,
> >>> +};
> >>> +
> >>> +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __mayb=
e_unused)
> >>> +{
> >>> +     kvm->exit_reasons_isa =3D "loongarch64";
> >>> +     kvm->exit_reasons =3D loongarch_exit_reasons;
> >>> +     return 0;
> >>> +}
> >>>
> >>> base-commit: 2c71fdf02a95b3dd425b42f28fd47fb2b1d22702
> >>>
> >>
>
