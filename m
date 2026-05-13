Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FB38F934
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688914; cv=pass; b=JIVwiwAMj1CuNpD08ZUX6KNPDplNuWVdoymHaBUHl7eo/xsY5rTmN4/fKvNcHc//o5lvqrTzhVoS1WAtXfiyix1u6P73r5DilIBtmlfmcxVOq7FiksT2DcUWsZ3OA34uMcSShGx/++EKuzLwt4SltjD3FX5p3ZrlpjcWFmE5gj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688914; c=relaxed/simple;
	bh=CwFj9jjoZ/+7KkEN9OBigFXAkNT7/jQ0nP81AR1q1TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXa3uGFprGzgTA+QgzvoCVJIapVCE14UYL41ZMYV0FuuEnLL1Y/PVzNUNTavisdSb8rG1SV9BaJIyUGdttqyHLrm+mTHP5sV/4MN4T9eRUoYmgYpl1oinuczHci5Maa/6itRgDyeKQevH1TaVoF/FetUxOEXiYfjteXafD6atMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyJ4/jFP; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyJ4/jFP"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso5765ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778688912; cv=none;
        d=google.com; s=arc-20240605;
        b=QKzGzavhjIjLZ/t5mHHil7MN/I/XHgMDOHhdqv4iXiq/sIohpU59bAC2jrxszlP4N2
         AV4dmIdH/77Qj6KjDYdJ61e8Z5Iw7QMysRTL/AwRL/BxcnYApwgInnvr+fp2zKznvfrr
         Fd6M8pm2d/Chll2LHVQXHBFgFmQzT5xr+ePH1Prs+xMazYj7DPDOQCv+LJne6rmKx9So
         VuphpfEIoGTWwfWNPoocvV81CPfBe79absLMNxD0F17x8Y7JqmDLGJeV4dBXd/guLNRP
         5aPQwSKiiKwHYleg2OO3EsKQfSis5FCwSd4HojNzAA61+tQMMWGKI+0FlJGbcA0oGoI9
         FjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txqVWm2VQ2fIiO9SGGiJnKn+35VJWI2B5CGmYNs/cEA=;
        fh=0fz9nzhIXhpYGyjUYeISSUOKy2FVHXzxyhd34XneOxU=;
        b=dvqWEWAmt2Cu1PLTsHAIrqaPtGu2t7y6hRD+TxvoBS5OkS7hnJTytVaz+XqT6ybqP6
         9j9XJvlvc3scElkpbHZztXP/KQKT35ZM88/wA9YYPDalLLHCrEtYogSXwbvXVTrdKwr6
         AjZtkOfRD3OEfB04CyDdKiibIL4MIoU+8Jxlm1pWziG01hzGpJBjb3lc9xUSCWFpriUn
         LulFqqkHbprA2j+/lVuM5cepl0CHKarEhx5OyEXzVQQ5s110XpynXH38RywJSGKoEx/g
         XUDiWZNd2VFVpEg5qZqCkvCfGi2ge+DDSPSVREbNFD36Px5dC/ux4MPRKRMdLocAESg7
         R6Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778688912; x=1779293712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txqVWm2VQ2fIiO9SGGiJnKn+35VJWI2B5CGmYNs/cEA=;
        b=UyJ4/jFP+M3SmHhf7ib+M5PJUA5R8CXDcRxRUp9hRDOnxjbGj7kZ36Uluelw/uojy1
         XQeh/wBtWBUYZQLLFHh2p27Nys9w8+Vxw1Zm5aJ5BRftUvjUdKTpUaklqlpeJbnj1k5u
         dIYulem3LF5nKYdKD7Tvv3gqeoipz6z+YOeZKzZglW550CFmt4JRp8/WBGWwFL1VgrAB
         eajw9BMb+7eiJmyKn8OUldZ+6GZoyLuGJ6aV8D2wtV02zJ9tJNBI/4LS5IoIyOGb+uWp
         PmNuJRehh64aYwW+RG2mL0QKJBv0QbknHAC0FTLPtVFgvQPp8RGpPXe2zEsqTtTeP/xE
         X4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778688912; x=1779293712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txqVWm2VQ2fIiO9SGGiJnKn+35VJWI2B5CGmYNs/cEA=;
        b=HbL4mTMUSQ7sxB2SSE3k2O3t39JT2AMnUqp9Uj4P0ONTme5HaXcEWdSwc/cSzCEE8l
         YyJ/eZNkd/xDgHeRtn47OfemZen9DgOweKGeUNsjV3HdsBKzjVoTGzu3qUFJCFiwoPbz
         eyYovNZLw0PyW76DrfIPGo09uBH/eWUX8IH+hqnRvrH+Z4df3Rz4eqmxlSYpbh3zFzWl
         OFoB45QEV0kgfH9Kd4AaeBfbGLFdzDquIVBUVAHHt8nioU+PMIjRe5bwloUX7bHNPLMf
         hyp24sp2eGiUce0SrFVatPFhmL4H4Yr9wLek6u6J+91+QOc/svV29eP706piQDAbc9mI
         2XFg==
X-Forwarded-Encrypted: i=1; AFNElJ+NJBFyuzNfDtp2iNmRAkYPBcwb70GCKqLGy1o5bxajxEnoqd32NXh2txHlSrdQz4J+33vkahFHn7ehzdfOe2fT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9M1Osl870h1Mu1N+1vSGff3GhlFQc7FPkLWV6loWyNTApflgz
	bRQG54GztCVKQV69lDaBneDYY0Jf4leVid0W9YJim/ZZl3DdAmmZs0IM+hzcRIaE/uurQgy02IM
	kKa+xXVSeEPHuU4TxVy91NqphEJMpSqxT3mFrP0x5
X-Gm-Gg: Acq92OEtFC+jndDAS5VqdFT+kd3pjJevd6YBqmeYIjaXRxKhHGxtsEkc5cbZZY3mKzn
	0vznRoyBIKBh0BE+KImvIiASE4jVs5Do3dflBUIl7rciCrke71hp00rjVE73zwsfL4a3jZFZihg
	7UGeOPZPdvq+ncWiWM0E8Iy4S8atbWPHpWM//CKdI+Cgs+IbRmQUBsJnm1otOsbYet/V8A6Slvk
	DuyYj7jnXRQFb6rNmDV6s2UfccyQ4py/oePGr3iqCHMcdvNPfyQEVj/EowJtlmriRgUX8+I3K5k
	yJfZUZ3CK3s5LAzNZHa2FCBU0zvSPVFaeLvRTNGGNyBbIvTy
X-Received: by 2002:a17:902:f542:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2bd2c10220bmr2858455ad.13.1778688911626; Wed, 13 May 2026
 09:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn> <20260513154851.1085334-2-guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <20260513154851.1085334-2-guanli.oerv@isrc.iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 09:14:59 -0700
X-Gm-Features: AVHnY4I1OqnGmt0DC5ttpBlGE6KNa_ZClt9g6cGux5HSErwT8cKe7d8vX97n7Bo
Message-ID: <CAP-5=fXNPNCzHbvMFW+_2Ewn-D4NUorwFUYcFLDTUuPHpkXxaw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf build: Fix cross-arch build failures by
 isolating auxtrace objects
To: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	palmer@dabbelt.com, pjw@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 8:50=E2=80=AFAM Li Guan <guanli.oerv@isrc.iscas.ac.=
cn> wrote:
>
> Currently, tools/perf/util/Build hardcodes architecture-specific hardware
> tracing objects (e.g., intel-pt.o, arm-spe.o, cs-etm-base.o) into the
> generic perf-util-y list. When compiling on architectures that lack
> these features (such as RISC-V), the compiler skips generating these
> objects, causing the linker to fail with "No such file or directory"
> or undefined references.

So it is intentional to build these into the perf binary so that you
may generate a perf.data file on an x86 or ARM machine and then
analyze it on an RISC-V machine. I'm not sure how you've managed to
break the build, you didn't provide a message, but the build expects
these decoders for cross-platform support.

> Fix this by decoupling the architecture-specific hardware tracing drivers
> from the generic build process:
> 1. In Makefile.config, explicitly export CONFIG_PERF_XYZ feature flags
>    only for their corresponding target architectures.
> 2. In util/Build, conditionally link these hardware tracing objects
>    based on the newly exported feature flags.
> 3. In util/auxtrace.c, provide __weak stub functions returning -ENOSYS
>    for the arch-specific processing routines. This ensures successful
>    linking and graceful degradation when specific drivers are omitted.

This is a complete misunderstanding of the code, please don't
implement this. If anything, more code should move out of the
tools/perf/arch directory and into tools/perf/util guarded by
perf_env's arch or e_machine values for cross platform support.

Thanks,
Ian

> Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
> ---
>  tools/perf/Makefile.config | 21 ++++++++++++
>  tools/perf/util/Build      | 20 +++++------
>  tools/perf/util/auxtrace.c | 70 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/auxtrace.h |  6 ++++
>  4 files changed, 107 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 06d7a3f999..13f4b98b2e 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -107,6 +107,27 @@ ifeq ($(SRCARCH),loongarch)
>    endif
>  endif
>
> +ifndef NO_AUXTRACE
> +  ifeq ($(SRCARCH),x86)
> +    $(call detected,CONFIG_PERF_INTEL_PT)
> +    $(call detected,CONFIG_PERF_AMD_PT)
> +  endif
> +
> +  ifeq ($(SRCARCH),arm64)
> +    $(call detected,CONFIG_PERF_ARM_SPE)
> +    $(call detected,CONFIG_PERF_HISI_PTT)
> +    $(call detected,CONFIG_PERF_CS_ETM)
> +  endif
> +
> +  ifeq ($(SRCARCH),s390)
> +    $(call detected,CONFIG_PERF_S390_CPUMSF)
> +  endif
> +endif
> +
> +ifeq ($(SRCARCH),arm64)
> +  $(call detected,CONFIG_PERF_ARM64_UNWIND_SUPPORT)
> +endif
> +
>  ifeq ($(ARCH),s390)
>    CFLAGS +=3D -fPIC
>  endif
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 70cc91d008..79ade6066d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -132,21 +132,21 @@ perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>  perf-util-y +=3D kvm-stat-arch/
>  perf-util-y +=3D lock-contention.o
>  perf-util-y +=3D auxtrace.o
> -perf-util-y +=3D intel-pt-decoder/
> -perf-util-y +=3D intel-pt.o
> -perf-util-y +=3D intel-bts.o
> -perf-util-y +=3D arm-spe.o
> -perf-util-y +=3D arm-spe-decoder/
> -perf-util-y +=3D hisi-ptt.o
> -perf-util-y +=3D hisi-ptt-decoder/
> -perf-util-y +=3D s390-cpumsf.o
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-pt-decoder/
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-pt.o
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-bts.o
> +perf-util-$(CONFIG_PERF_ARM_SPE) +=3D arm-spe.o
> +perf-util-$(CONFIG_PERF_ARM_SPE) +=3D arm-spe-decoder/
> +perf-util-$(CONFIG_PERF_HISI_PTT) +=3D hisi-ptt.o
> +perf-util-$(CONFIG_PERF_HISI_PTT) +=3D hisi-ptt-decoder/
> +perf-util-$(CONFIG_PERF_S390_CPUMSF) +=3D s390-cpumsf.o
>  perf-util-y +=3D powerpc-vpadtl.o
>
>  ifdef CONFIG_LIBOPENCSD
>  perf-util-y +=3D cs-etm.o
>  perf-util-y +=3D cs-etm-decoder/
>  endif
> -perf-util-y +=3D cs-etm-base.o
> +perf-util-$(CONFIG_PERF_CS_ETM) +=3D cs-etm-base.o
>
>  perf-util-y +=3D parse-branch-options.o
>  perf-util-y +=3D parse-regs-options.o
> @@ -168,7 +168,7 @@ perf-util-y +=3D clockid.o
>  perf-util-y +=3D list_sort.o
>  perf-util-y +=3D mutex.o
>  perf-util-y +=3D sharded_mutex.o
> -perf-util-y +=3D intel-tpebs.o
> +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-tpebs.o
>
>  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
>  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter_cgroup.o
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index a224687ffb..f6e426c3c5 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -51,6 +51,7 @@
>  #include "cs-etm.h"
>  #include "intel-pt.h"
>  #include "intel-bts.h"
> +#include "intel-tpebs.h"
>  #include "arm-spe.h"
>  #include "hisi-ptt.h"
>  #include "s390-cpumsf.h"
> @@ -2960,3 +2961,72 @@ bool auxtrace__evsel_is_auxtrace(struct perf_sessi=
on *session,
>
>         return session->auxtrace->evsel_is_auxtrace(session, evsel);
>  }
> +
> +/*
> + * Stub functions for architecture-specific features to support cross-pl=
atform building.
> + * These weak symbols are overridden by strong symbols when the correspo=
nding
> + * architecture-specific code is compiled in.
> + */
> +#ifndef HAVE_ARCH_X86_64_SUPPORT
> +int __weak intel_pt_process_auxtrace_info(union perf_event *event __mayb=
e_unused,
> +                                         struct perf_session *session __=
maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int __weak intel_bts_process_auxtrace_info(union perf_event *event __may=
be_unused,
> +                                          struct perf_session *session _=
_maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int __weak evsel__tpebs_open(struct evsel *evsel __maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +void __weak evsel__tpebs_close(struct evsel *evsel __maybe_unused)
> +{
> +}
> +
> +int __weak evsel__tpebs_read(struct evsel *evsel __maybe_unused,
> +                            int cpu_map_idx __maybe_unused,
> +                            int thread __maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int __weak insn_decode(void *insn __maybe_unused, const void *kaddr __ma=
ybe_unused,
> +                      int len __maybe_unused, int mode __maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
> +
> +#ifndef HAVE_ARCH_ARM64_SUPPORT
> +int __weak arm_spe_process_auxtrace_info(union perf_event *event __maybe=
_unused,
> +                                        struct perf_session *session __m=
aybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int __weak hisi_ptt_process_auxtrace_info(union perf_event *event __mayb=
e_unused,
> +                                         struct perf_session *session __=
maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +int __weak cs_etm__process_auxtrace_info(union perf_event *event __maybe=
_unused,
> +                                        struct perf_session *session __m=
aybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
> +
> +#ifndef HAVE_ARCH_S390_SUPPORT
> +int __weak s390_cpumsf_process_auxtrace_info(union perf_event *event __m=
aybe_unused,
> +                                            struct perf_session *session=
 __maybe_unused)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 6947f3f284..474e9445b4 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -699,4 +699,10 @@ void itrace_synth_opts__clear_time_range(struct itra=
ce_synth_opts *opts)
>         opts->range_num =3D 0;
>  }
>
> +/*
> + * Prototypes for architecture-specific functions that require weak stub=
s
> + * to support cross-platform builds on non-x86 architectures.
> + */
> +int insn_decode(void *insn, const void *kaddr, int len, int mode);
> +
>  #endif
> --
> 2.54.0
>
