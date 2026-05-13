Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7574C6EE6
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690285; cv=pass; b=sceoVP6uUwu6Bzs5KpCFC7CL+XvLWFR8t2w7J/mxkHZ4RUr2//m6ygPSF57PWaInHf9A66IHq3mMi74rf0baHMlygUf+oLnU0QfzqZXgfLmemFwTPeXfVT8IMOf6CI3EMDJrBP4Xs7vtjpnbv+M2i6UrIgqKFuO9rIieCXXrIDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690285; c=relaxed/simple;
	bh=xvbq5tmhWPGB+rOk2JfATZMuxXWaOZ5dAxDy0mxstbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDvK+ZyxMOhu4wwbbNbMIgtXLASoIhVZTg2hyUd8Jytw2NOkZ0jcZa8omwF+9/2E9K5tpEc5w73qp2iBO3ofa6xDs2doH1g/SuOM2aN9Jv3PmbkXJDUed0udMfJc9XVQW9V2Q4cp3bv3srODqhsWiAMnroetVZa8O+k73RrKEsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYOTvD6/; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYOTvD6/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso3125ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 09:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690282; cv=none;
        d=google.com; s=arc-20240605;
        b=NpJshQ88soy/rMEsEnv5e8UlDmDX3Tyl3Fx98hpP5Vt7aWFrDmLPujJ1Xn+79tZcIg
         kTWuLXAPDhLsII71OcTEHYQIjj+Cul0aAEgzq4zTS1X0BXRLsILIs3coSQJYu/4hyKuu
         ykW1P8iKDmxM6kRYB5XjYewwvMtBovMf6PayLFHD7msLEcnePO+9Lkd7KYt0oLH4Zbue
         JRwQKy2W+jZEQOqZpVKZH2pcJLK5zH3K3LDjbZmAsp7jkica6TwZEwatNoE8vBiKFLQv
         oH2szwTVLvBak33UEbgt2758n1cD5I3ywWgiR+FVfEnmIUBEkCgT0HhjS6PbApAt0MkC
         4/4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lIHA7b7DRML6L+c/pIlmnAAdzoHLQtRaBaV/Cs+OZhQ=;
        fh=k5INyNVP0Sgyz3UWEhzU9iK0RW+qzX6Gpfp2nn2DH34=;
        b=PYo+8Byn05zeJ2Alwf1Yo9YaIcYOhKIMD6CoKOiEdcx+tAeofXH4q73mTqoEN9HNNl
         pGpETrhy9hFNjDvXZkuc4HUf9YOj17v8IA9w6trJrfo65wpfKN58DkqkacEBZXqYFCCB
         sX2k6FQ4Z2V/a/LvD/fb7XCav1pVhOnieKzNqNETlJf5qaNsIrcmXeAW93KUHiOTggkA
         rs4iSaPSDjRkPu01mabc7+HdA9hhNu29b0gppcrSPpUR6OmGM1Fo+6DQBGBqTWxeybUT
         8u8ekgkjRKc8x+ih7bcNzUoUB5Aun5Td/bIiyJJyQRzJv2n7ycN4qLamYT58pgPmKHAF
         1uIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778690282; x=1779295082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIHA7b7DRML6L+c/pIlmnAAdzoHLQtRaBaV/Cs+OZhQ=;
        b=MYOTvD6/L3gnXAzPC4oYkGIVEVTMdTS3ptubVAQr3Z9lRqhhGRYP68Mu533TI1nVf4
         nVnbJQva4LB3rOqFadHHCjrmd5nGxjmjA4U1guBFeSdXokyCVyQuKujf/XCUO5+73dyJ
         JWWKbh0EwTL1PDNsZs/Fu3FwB+PvQuYtu9osgfRPkpabS9n7DnwkZN4MYv6TcizrTzAW
         Ig4BrkzfXH0OSmK93F64ASjF3WhnFK0QoSXousBEHdgZEXUPmSoC5Vnj+B0rDpsrZW3g
         QJWI8Yz6PYR7tIHp42J9x7eKSnpdekTXb7TRj2UAZ/bolqvjL7eQZpMsYOKmDqM49j6+
         SI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690282; x=1779295082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIHA7b7DRML6L+c/pIlmnAAdzoHLQtRaBaV/Cs+OZhQ=;
        b=NACEdEVsxSPW4b9o50V4TAA+HCvlt4iBZPGXOeglv71gNBoh7E+qMyCE5dBVq3MHBZ
         jMd7TL2S5bjwoL6PdJl7AYCdb7BduZ+6kEcP8aAJFywgy3sKBqSokF+0OyWCJeIrFxXd
         ZBXuLs0bhwj6N8AY5p8wuSCn8mvUhOhQ76ft+5jJe9YCV6NRquNftca2d5d5ZE40L0K6
         sLYuUksp/NKq9os3DDOHufFxrfQvN13MpGJD9TSgA1wAj2gLM6e3x+hW7aOfM5/vc9kb
         O1qs4IVMBl+6ciTZ272dqMDfaLO9NcJsTi97zamfZVwbK6alrZuKYKJRoc4/esX0LEWS
         G3Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8i0yJLnHGBReAV8OMPdFyn2/ZN47XvBiKgMZGHIYhVciOiOcTLQYY3onDq5XRg66VHbYk1M3UC30bqWiYQ7iv1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nRWqfrFVTA7IuhNfkslEFx1VqeZd/mQCjwCpvVL+tPJsGman
	TjdD8t7OneVYuLl6FexhbIOTY3rLYtXds7sxaPnb7K1Ovr8V+Xj6P+SzLLnsVrBdvq94JhreutV
	WBiJs8czFB3P1BNt6P7dY78IckmpR3ZXzSbXVr3OY
X-Gm-Gg: Acq92OGCBTaFEUx6g1RTWlPUByZpHljSVv/lWmzTYzMP5vR+IpSCRTRsILDmYIrBd6i
	jFEtr/+92UdR+gDZEg3Zj4J/1qBl6bFHxRSNpgvCatpagAGfNbc3z96h9JfcGlMdTjZbkC3/W9+
	EvadR1Nzy9LeWPq23Ihsk+Zf7nmHmDwlKKdneBYGfrKnMTto8tZoDHGvbIxjc7NmL/nvhzKFJ49
	vjGdWDySxKyYV6G0MmFPCgbw0pxEFSolhS3wztOQrZ5Nvlqe2OJeo8Wz9CsS+T1NW7PVWQMCH9e
	XxGeZLBLDdp30hRhr32T0ai2QFzhHMAMqKmZQihhdL//4xtO
X-Received: by 2002:a17:903:3c8a:b0:2bd:a61:8533 with SMTP id
 d9443c01a7336-2bd2c0f098dmr2166685ad.5.1778690280979; Wed, 13 May 2026
 09:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513154851.1085334-1-guanli.oerv@isrc.iscas.ac.cn>
 <20260513154851.1085334-2-guanli.oerv@isrc.iscas.ac.cn> <CAP-5=fXNPNCzHbvMFW+_2Ewn-D4NUorwFUYcFLDTUuPHpkXxaw@mail.gmail.com>
 <598c7d7e.15b49.19e222e3590.Coremail.guanli.oerv@isrc.iscas.ac.cn>
In-Reply-To: <598c7d7e.15b49.19e222e3590.Coremail.guanli.oerv@isrc.iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 09:37:49 -0700
X-Gm-Features: AVHnY4IVJY93l7Lhc5YOk6jKzeVDgOdKQbDr9woVhxsnM-CwSmRAuw8bCxg8SMM
Message-ID: <CAP-5=fVns1Wj3fjYhahq45Bu+1Wd9GA5UJSigBjcFG0PrNbVHQ@mail.gmail.com>
Subject: Re: Re: [PATCH 1/3] perf build: Fix cross-arch build failures by
 isolating auxtrace objects
To: guanli <guanli.oerv@isrc.iscas.ac.cn>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	palmer@dabbelt.com, pjw@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:32=E2=80=AFAM guanli <guanli.oerv@isrc.iscas.ac.c=
n> wrote:
>
> Hi Ian,
>
> Thanks a lot for the quick and detailed review!
>
> Regarding Patch 1/3 and 3/3 (the auxtrace decoupling):
> I completely misunderstood the design goal of perf for cross-platform tra=
ce analysis. My apologies for that. I encountered build errors on RISC-V wi=
th GCC 14 when it tried to compile files like intel-pt.c, and I incorrectly=
 assumed they shouldn't be built for RISC-V at all.
> I will drop this approach entirely. I'll go back to the original build lo=
gs to find the exact GCC 14 compilation errors in those decoders on RISC-V,=
 and I will try to fix those specific issues instead. I'll make sure to inc=
lude the exact compiler error messages in the next patch.
>
> Regarding Patch 2/3 (the const qualifier):
> You are right, casting it to (char *) is not the proper way to handle it.=
 I will check the perf-tools-next branch as you suggested. If it hasn't bee=
n fixed there, I will submit a v2 that properly preserves the const semanti=
cs.
>
> Thanks again for pointing me in the right direction!

No worries, thanks for sending fixes and glad to clean up the intent
in the tool. I'm actually trying to push more with this cross-platform
direction, and increase RISC-V support in this series that I'm
currently rebasing:
https://lore.kernel.org/linux-perf-users/20260413024805.1316480-1-irogers@g=
oogle.com/
I'll be cheeky and add you to the cc list as maybe you can help with
building/testing :-)

Thanks,
Ian

> Best regards,
> Li Guan
>
>
> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Ian Rogers" <irogers@google.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026-05-14 00:14:59 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Li Guan" <guanli.oerv@isrc.iscas.ac.cn>
> > =E6=8A=84=E9=80=81: acme@kernel.org, namhyung@kernel.org, adrian.hunter=
@intel.com, palmer@dabbelt.com, pjw@kernel.org, linux-perf-users@vger.kerne=
l.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
> > =E4=B8=BB=E9=A2=98: Re: [PATCH 1/3] perf build: Fix cross-arch build fa=
ilures by isolating auxtrace objects
> >
> > On Wed, May 13, 2026 at 8:50=E2=80=AFAM Li Guan <guanli.oerv@isrc.iscas=
.ac.cn> wrote:
> > >
> > > Currently, tools/perf/util/Build hardcodes architecture-specific hard=
ware
> > > tracing objects (e.g., intel-pt.o, arm-spe.o, cs-etm-base.o) into the
> > > generic perf-util-y list. When compiling on architectures that lack
> > > these features (such as RISC-V), the compiler skips generating these
> > > objects, causing the linker to fail with "No such file or directory"
> > > or undefined references.
> >
> > So it is intentional to build these into the perf binary so that you
> > may generate a perf.data file on an x86 or ARM machine and then
> > analyze it on an RISC-V machine. I'm not sure how you've managed to
> > break the build, you didn't provide a message, but the build expects
> > these decoders for cross-platform support.
> >
> > > Fix this by decoupling the architecture-specific hardware tracing dri=
vers
> > > from the generic build process:
> > > 1. In Makefile.config, explicitly export CONFIG_PERF_XYZ feature flag=
s
> > >    only for their corresponding target architectures.
> > > 2. In util/Build, conditionally link these hardware tracing objects
> > >    based on the newly exported feature flags.
> > > 3. In util/auxtrace.c, provide __weak stub functions returning -ENOSY=
S
> > >    for the arch-specific processing routines. This ensures successful
> > >    linking and graceful degradation when specific drivers are omitted=
.
> >
> > This is a complete misunderstanding of the code, please don't
> > implement this. If anything, more code should move out of the
> > tools/perf/arch directory and into tools/perf/util guarded by
> > perf_env's arch or e_machine values for cross platform support.
> >
> > Thanks,
> > Ian
> >
> > > Signed-off-by: Li Guan <guanli.oerv@isrc.iscas.ac.cn>
> > > ---
> > >  tools/perf/Makefile.config | 21 ++++++++++++
> > >  tools/perf/util/Build      | 20 +++++------
> > >  tools/perf/util/auxtrace.c | 70 ++++++++++++++++++++++++++++++++++++=
++
> > >  tools/perf/util/auxtrace.h |  6 ++++
> > >  4 files changed, 107 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 06d7a3f999..13f4b98b2e 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -107,6 +107,27 @@ ifeq ($(SRCARCH),loongarch)
> > >    endif
> > >  endif
> > >
> > > +ifndef NO_AUXTRACE
> > > +  ifeq ($(SRCARCH),x86)
> > > +    $(call detected,CONFIG_PERF_INTEL_PT)
> > > +    $(call detected,CONFIG_PERF_AMD_PT)
> > > +  endif
> > > +
> > > +  ifeq ($(SRCARCH),arm64)
> > > +    $(call detected,CONFIG_PERF_ARM_SPE)
> > > +    $(call detected,CONFIG_PERF_HISI_PTT)
> > > +    $(call detected,CONFIG_PERF_CS_ETM)
> > > +  endif
> > > +
> > > +  ifeq ($(SRCARCH),s390)
> > > +    $(call detected,CONFIG_PERF_S390_CPUMSF)
> > > +  endif
> > > +endif
> > > +
> > > +ifeq ($(SRCARCH),arm64)
> > > +  $(call detected,CONFIG_PERF_ARM64_UNWIND_SUPPORT)
> > > +endif
> > > +
> > >  ifeq ($(ARCH),s390)
> > >    CFLAGS +=3D -fPIC
> > >  endif
> > > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > > index 70cc91d008..79ade6066d 100644
> > > --- a/tools/perf/util/Build
> > > +++ b/tools/perf/util/Build
> > > @@ -132,21 +132,21 @@ perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat=
.o
> > >  perf-util-y +=3D kvm-stat-arch/
> > >  perf-util-y +=3D lock-contention.o
> > >  perf-util-y +=3D auxtrace.o
> > > -perf-util-y +=3D intel-pt-decoder/
> > > -perf-util-y +=3D intel-pt.o
> > > -perf-util-y +=3D intel-bts.o
> > > -perf-util-y +=3D arm-spe.o
> > > -perf-util-y +=3D arm-spe-decoder/
> > > -perf-util-y +=3D hisi-ptt.o
> > > -perf-util-y +=3D hisi-ptt-decoder/
> > > -perf-util-y +=3D s390-cpumsf.o
> > > +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-pt-decoder/
> > > +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-pt.o
> > > +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-bts.o
> > > +perf-util-$(CONFIG_PERF_ARM_SPE) +=3D arm-spe.o
> > > +perf-util-$(CONFIG_PERF_ARM_SPE) +=3D arm-spe-decoder/
> > > +perf-util-$(CONFIG_PERF_HISI_PTT) +=3D hisi-ptt.o
> > > +perf-util-$(CONFIG_PERF_HISI_PTT) +=3D hisi-ptt-decoder/
> > > +perf-util-$(CONFIG_PERF_S390_CPUMSF) +=3D s390-cpumsf.o
> > >  perf-util-y +=3D powerpc-vpadtl.o
> > >
> > >  ifdef CONFIG_LIBOPENCSD
> > >  perf-util-y +=3D cs-etm.o
> > >  perf-util-y +=3D cs-etm-decoder/
> > >  endif
> > > -perf-util-y +=3D cs-etm-base.o
> > > +perf-util-$(CONFIG_PERF_CS_ETM) +=3D cs-etm-base.o
> > >
> > >  perf-util-y +=3D parse-branch-options.o
> > >  perf-util-y +=3D parse-regs-options.o
> > > @@ -168,7 +168,7 @@ perf-util-y +=3D clockid.o
> > >  perf-util-y +=3D list_sort.o
> > >  perf-util-y +=3D mutex.o
> > >  perf-util-y +=3D sharded_mutex.o
> > > -perf-util-y +=3D intel-tpebs.o
> > > +perf-util-$(CONFIG_PERF_INTEL_PT) +=3D intel-tpebs.o
> > >
> > >  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
> > >  perf-util-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter_cgroup.o
> > > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > > index a224687ffb..f6e426c3c5 100644
> > > --- a/tools/perf/util/auxtrace.c
> > > +++ b/tools/perf/util/auxtrace.c
> > > @@ -51,6 +51,7 @@
> > >  #include "cs-etm.h"
> > >  #include "intel-pt.h"
> > >  #include "intel-bts.h"
> > > +#include "intel-tpebs.h"
> > >  #include "arm-spe.h"
> > >  #include "hisi-ptt.h"
> > >  #include "s390-cpumsf.h"
> > > @@ -2960,3 +2961,72 @@ bool auxtrace__evsel_is_auxtrace(struct perf_s=
ession *session,
> > >
> > >         return session->auxtrace->evsel_is_auxtrace(session, evsel);
> > >  }
> > > +
> > > +/*
> > > + * Stub functions for architecture-specific features to support cros=
s-platform building.
> > > + * These weak symbols are overridden by strong symbols when the corr=
esponding
> > > + * architecture-specific code is compiled in.
> > > + */
> > > +#ifndef HAVE_ARCH_X86_64_SUPPORT
> > > +int __weak intel_pt_process_auxtrace_info(union perf_event *event __=
maybe_unused,
> > > +                                         struct perf_session *sessio=
n __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +int __weak intel_bts_process_auxtrace_info(union perf_event *event _=
_maybe_unused,
> > > +                                          struct perf_session *sessi=
on __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +int __weak evsel__tpebs_open(struct evsel *evsel __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +void __weak evsel__tpebs_close(struct evsel *evsel __maybe_unused)
> > > +{
> > > +}
> > > +
> > > +int __weak evsel__tpebs_read(struct evsel *evsel __maybe_unused,
> > > +                            int cpu_map_idx __maybe_unused,
> > > +                            int thread __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +int __weak insn_decode(void *insn __maybe_unused, const void *kaddr =
__maybe_unused,
> > > +                      int len __maybe_unused, int mode __maybe_unuse=
d)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +#endif
> > > +
> > > +#ifndef HAVE_ARCH_ARM64_SUPPORT
> > > +int __weak arm_spe_process_auxtrace_info(union perf_event *event __m=
aybe_unused,
> > > +                                        struct perf_session *session=
 __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +int __weak hisi_ptt_process_auxtrace_info(union perf_event *event __=
maybe_unused,
> > > +                                         struct perf_session *sessio=
n __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +
> > > +int __weak cs_etm__process_auxtrace_info(union perf_event *event __m=
aybe_unused,
> > > +                                        struct perf_session *session=
 __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +#endif
> > > +
> > > +#ifndef HAVE_ARCH_S390_SUPPORT
> > > +int __weak s390_cpumsf_process_auxtrace_info(union perf_event *event=
 __maybe_unused,
> > > +                                            struct perf_session *ses=
sion __maybe_unused)
> > > +{
> > > +       return -EOPNOTSUPP;
> > > +}
> > > +#endif
> > > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > > index 6947f3f284..474e9445b4 100644
> > > --- a/tools/perf/util/auxtrace.h
> > > +++ b/tools/perf/util/auxtrace.h
> > > @@ -699,4 +699,10 @@ void itrace_synth_opts__clear_time_range(struct =
itrace_synth_opts *opts)
> > >         opts->range_num =3D 0;
> > >  }
> > >
> > > +/*
> > > + * Prototypes for architecture-specific functions that require weak =
stubs
> > > + * to support cross-platform builds on non-x86 architectures.
> > > + */
> > > +int insn_decode(void *insn, const void *kaddr, int len, int mode);
> > > +
> > >  #endif
> > > --
> > > 2.54.0
> > >
