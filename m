Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260F29ACDD
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389230; cv=pass; b=CQSbiSZkaMPpbEwbHYvnh5TfEclpaScO+aLPcKQQcemTSGV6E0NKj3UJkMx4EUTA14KI7foAaRb8mI6Faqe0LqMrc91udN6HnA5FtGQbNjKTMGryi1r/xdsIPMrL6bn/0LLWauP22TFsEr4PPhSX/Q1mVFW51u52w0PA2SkASSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389230; c=relaxed/simple;
	bh=IdACOMLm2gqBqWZiZX4seqxAEU17F1q06s+lL8LFsVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wkep/LxQwyM8Tn6X5+rjiUZMH6sJb/UitYK2A/MJtHLMYAl2qdYH5GTkmDlzxj53zlKjQpEZB6pso/9fcHnkpph9BlFi4dqK+eIX4nHPklyRn+GxBQnDSRROaevf/fn6piTqZ2zYTD5VZhEMQPTbnsMicxbVD3pHlAg/aTrkmFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ina68Fc9; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ina68Fc9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba180a022dso1335ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 11:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779389228; cv=none;
        d=google.com; s=arc-20240605;
        b=Hsxuje892IznaOPLQ8zjvl5qqT7qEJBH2Sdc1KogPCeqU5iigfa5PB1HCj4qsMN16a
         RcBaUuVXab/P+4jX+3E/JF4xrFq/O2OC+RIan5CUnYRZ6Kd/Sf8l4qGF76kNzc0WsINR
         zq0j7ZBRl8R2V0ohE6kIO8M7ACNrQgpU/BmR9A8xgUU3/m7gfYg0GndIgk/AHqK13VZl
         JqIsTQCCBvay8i0g6crhKDbKIT9fv+9ru0t1K9X6lJpfc2GRt+M0Sm2EUO4ITXQeGLFQ
         yvSUqg1Lc7ZOj7pZ9MbovvVr955D7S6dhX0PDQA91vPWHGFM8eUpQ8Beyn/NGnPhtkJF
         Wnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+aRCBwNLM3cbRGEGHMswFLlSQMnAVNo1LPFrSOCWo8=;
        fh=sSoKUqbrf1qPZAzlSAbGnB9+Jmmi9Z4/veVbjjGf/Lw=;
        b=MsMVQpYJw5ToPe5AiUSkw/zoyDVocXXk8GAChscAsHeVoik1lM8ItwPqn1ovU5uK6H
         QR+Y7h2nfacLzC4T7Wi00plp3C73HoBmkzXRiaL/eHJ1SNNHtkyzgA68soH+RBjvaoRd
         paoEUGmkdu26uflWkNYMTEneDVXIIjEp4kxF0NfK5dN2BM2YP0Pu8Y4/pYxWaz/wWS1K
         AH81110YSpc7dulng1JINXZwbhsJNOr6S1Cm1EqzrOmqdkg5H+B1fHKaeK1FFmP6NoEi
         eVHv8LWlE3ygx9RfKcZGYS00tdh+dAGPv77ftziCR4Tz058/bAa19OFrkaTBRimjb0MS
         lLhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779389228; x=1779994028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+aRCBwNLM3cbRGEGHMswFLlSQMnAVNo1LPFrSOCWo8=;
        b=ina68Fc97DlahFEjnw8Obv63OPbQR/YISbedJS6YgAjuhCuKd34ZX5EP8D1OFZ7Lza
         v+TUnBGrHgbSx41bQxOU2O3VQwgCUekUH5OZxjw/iPj1xo/TOGgBYKTmfKRBXeXROzNX
         +0e9G5+ASxWJA/81r1SkZJVqlOeBO32LGcyrHC5VaIAFC89Px2WriA6GctwFrGad6k/c
         X6bsj3WjDvn0yaDxievCrnEi5IxaM6HR+0qPdlnwlGZOPKs3kF4ftP31gVEKnrxh8nWI
         dSl2LJ+agLrRNiEnsndTsmXFVXRh+7cNxK6AR8QrENDPhl7SeVgILCzG5htsqyRlYvfY
         06zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779389228; x=1779994028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+aRCBwNLM3cbRGEGHMswFLlSQMnAVNo1LPFrSOCWo8=;
        b=XKDVbUS9IZvsthyaMHIkgjRWwnKdpg9fALcLaWiex5mNZb8KkfszxJmPS/3lb/9+OI
         bHxjsDfyI4Kvz2wHyXqW+Tdxm5od92VSExjdDwOtldXR9sPLkEKVxOHWC2pw8GHudkar
         jAI/7QoIwSL2zx2OpmErjWv4NmFy6l21KHYZcuI/Jz/kX9mB6emzdplOD/s7AdP0idGq
         aZ3Mo0ZsEnS3jY3rZcgPFzi5flYEJUJ6lLJzYxnZk4m23hQwh310cfeCC6xOnpB6yP8Q
         OfvHa8dJek7LFXcB+Cs5837fvQzM19zZueNaX8dSvr84m9eWVvbeoCYaiPxct3Fs4ImA
         /R7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8haKTqJ9U07jVpKn1aoQphKkolBW/nPkDEeomfayeM/HY8rh68Uv3yWbO14LLl5Ikvj5MNHXGKyBc9sm5Yurpz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7s8V4Y3zB8qrf4jtKCauRY7NLCY7Q1RxxkQMbTm6g086zdBK
	rcKqwVs5jGQPkRtBp5sxZbD6GSbTHyiIhXKIydbtYzZVd7k45XNllk3BtpH8QUx5/ezZWhePac6
	iFkx7LoWAh64VR/9vwX00j8rpRfS8i+CdL49Io485JiRJmRHJCU8JyEItlq4=
X-Gm-Gg: Acq92OHLzhayWZdfGZNXeI2WinrL4faIjGgTUZCTKGLvkeJ9XPBtUzmyRLRTyUmrti1
	PmIRcI5ByycAoL+g9WOcfj24tEUGJs9e5z0/EIMYSePMx3Y8cVJB9RCcAX02Z/U+2mz1TQyZt+H
	DNjw5Rp8CEEL2PYfUzv1BUPzmUFx2P6Xp7spZ93lLFNx8N2im9x/CrPHJfP+ifAzAG7zkC6uQTM
	3Z2kyn+IAocvt4AUdQIZCfJAhT3x7bshszLb+1c3FyaO/btCNT08G4FQoK5DVbcpz7vtPhpTs7o
	EZTy2md94+i1zf5q8BPifyNog8RkXWFJ+TBcqFVOQf6tIkd9
X-Received: by 2002:a17:902:e548:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2bea20056bcmr2948025ad.4.1779389227616; Thu, 21 May 2026
 11:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag88OnWBm2Ce6A2s@x1> <ag9HuKNPbV3X4vDa@x1>
In-Reply-To: <ag9HuKNPbV3X4vDa@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 May 2026 11:46:55 -0700
X-Gm-Features: AVHnY4JoNm3ARx_Krt9bSYAZ26wwxbgfyTPJoAwZO2PIJi4MVoY-7JRo-SwNNL8
Message-ID: <CAP-5=fUvJ1JOw=La85Vp-JL8BsZ7zBiCqnNgm2vF9wkm5ZXhkw@mail.gmail.com>
Subject: Re: [FYI] [PATCH] merge resolution commit for perf trace beauty conflict
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thorsten Leemhuis <linux@leemhuis.info>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:58=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, May 21, 2026 at 02:09:14PM -0300, Arnaldo Carvalho de Melo wrote:
> > Just FYI, this is the merge commit solving this conflict.
>
> Ian,
>
>         Please take a look at tmp.perf-tools-next, it has this all
> hopefully solved, I'm running the container builds, so far so good:
>
> toolsbuilder@five:~$ export PATH=3D~/git/linux-tools-container-builds/bin=
/:$PATH
> toolsbuilder@five:~$ export BUILD_TARBALL=3Dhttp://192.168.86.5/perf/perf=
-7.1.0-rc4.tar.xz
> toolsbuilder@five:~$ time dm
>    1   128.07 almalinux:8    : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5=
.0-28), clang version 21.1.8 ( 21.1.8-1.module_el8.10.0+4172+b6b13d75) flex=
 2.6.1
>    2   107.40 almalinux:9    : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11=
.5.0-11), clang version 20.1.8 (AlmaLinux OS Foundation 20.1.8-3.el9) flex =
2.6.4
>    3  141.36 almalinux:9-i386: Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11=
.4.1-3), clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2=
.6.4

I did a test build and it worked. I looked at the changes and they
make sense to me. I still see the libunwind build-test failure that's
fixed by:
https://lore.kernel.org/linux-perf-users/20260521072429.1283423-2-irogers@g=
oogle.com/

Thanks!
Ian

> - Arnaldo
>
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > commit 86c8774ce08b931debdaa3f61f5a033639c183ca
> > Merge: f8d0db39bcc536ef 758c807bb943138f
> >     Merge remote-tracking branch 'torvalds/master' into perf-tools-next
> >
> >     Fixup clash of:
> >
> >       552636b9317c8a84 ("perf trace: Add beautifier script for fsmount =
flags")
> >
> >     That went via Namhyung upstream and the following ones in the
> >     perf-tools-next tree:
> >
> >       32969ef6e3e1979a ("perf build: Pre-generate BPF skeleton tooling =
during umbrella prepare phase")
> >       537609924c43715e ("perf trace beauty: Make beauty generated C cod=
e standalone .o files")
> >
> >     This complements sent by Ian Rogers.
> >
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Mark Brown <broonie@kernel.org>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Thorsten Leemhuis <linux@leemhuis.info>
> >     Fixes: f8d0db39bcc536ef ("perf build: Fix fsmount.o build")
> >
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --cc tools/perf/Makefile.perf
> > index fc92d6ceac5b0c98,76b35ac19acbfb20..4ac2a0cec9ee22a2
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@@ -509,7 -508,232 +508,6 @@@ arm64-sysreg-defs-clean
> >       $(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=3D$(arm64_gen_sysreg_out=
dir) \
> >               prefix=3D subdir=3D clean > /dev/null
> >
> >  -beauty_linux_dir :=3D $(srctree)/tools/perf/trace/beauty/include/linu=
x/
> >  -beauty_uapi_linux_dir :=3D $(srctree)/tools/perf/trace/beauty/include=
/uapi/linux/
> >  -beauty_uapi_sound_dir :=3D $(srctree)/tools/perf/trace/beauty/include=
/uapi/sound/
> >  -beauty_arch_asm_dir :=3D $(srctree)/tools/perf/trace/beauty/arch/x86/=
include/asm/
> >  -beauty_x86_arch_asm_uapi_dir :=3D $(srctree)/tools/perf/trace/beauty/=
arch/x86/include/uapi/asm/
> >  -
> >  -linux_uapi_dir :=3D $(srctree)/tools/include/uapi/linux
> >  -asm_generic_uapi_dir :=3D $(srctree)/tools/include/uapi/asm-generic
> >  -arch_asm_uapi_dir :=3D $(srctree)/tools/arch/$(SRCARCH)/include/uapi/=
asm/
> >  -x86_arch_asm_dir :=3D $(srctree)/tools/arch/x86/include/asm/
> >  -
> >  -beauty_outdir :=3D $(OUTPUT)trace/beauty/generated
> >  -beauty_ioctl_outdir :=3D $(beauty_outdir)/ioctl
> >  -
> >  -# Create output directory if not already present
> >  -$(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_o=
utdir)')
> >  -
> >  -syscall_array :=3D $(beauty_outdir)/syscalltbl.c
> >  -syscall_tbl :=3D $(srctree)/tools/perf/trace/beauty/syscalltbl.sh
> >  -syscall_tbl_data :=3D $(srctree)/tools/scripts/syscall.tbl \
> >  -    $(wildcard $(srctree)/tools/perf/arch/*/entry/syscalls/syscall*.t=
bl)
> >  -
> >  -$(syscall_array): $(syscall_tbl) $(syscall_tbl_data)
> >  -    $(Q)$(SHELL) '$(syscall_tbl)' $(srctree)/tools $@
> >  -
> >  -fs_at_flags_array :=3D $(beauty_outdir)/fs_at_flags_array.c
> >  -fs_at_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/fs_at_flags.s=
h
> >  -
> >  -$(fs_at_flags_array): $(beauty_uapi_linux_dir)/fcntl.h $(fs_at_flags_=
tbl)
> >  -    $(Q)$(SHELL) '$(fs_at_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -clone_flags_array :=3D $(beauty_outdir)/clone_flags_array.c
> >  -clone_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/clone.sh
> >  -
> >  -$(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_=
tbl)
> >  -    $(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -drm_ioctl_array :=3D $(beauty_ioctl_outdir)/drm_ioctl_array.c
> >  -drm_hdr_dir :=3D $(srctree)/tools/perf/trace/beauty/include/uapi/drm
> >  -drm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
> >  -
> >  -$(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(=
drm_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
> >  -
> >  -fadvise_advice_array :=3D $(beauty_outdir)/fadvise_advice_array.c
> >  -fadvise_advice_tbl :=3D $(srctree)/tools/perf/trace/beauty/fadvise.sh
> >  -
> >  -$(fadvise_advice_array): $(beauty_uapi_linux_dir)/fadvise.h $(fadvise=
_advice_tbl)
> >  -    $(Q)$(SHELL) '$(fadvise_advice_tbl)' $(beauty_uapi_linux_dir) > $=
@
> >  -
> >  -fsmount_arrays :=3D $(beauty_outdir)/fsmount_arrays.c
> >  -fsmount_tbls :=3D $(srctree)/tools/perf/trace/beauty/fsmount.sh
> >  -
> >  -$(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
> >  -    $(Q)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -fsmount_attr_arrays :=3D $(beauty_outdir)/fsmount_attr_arrays.c
> >  -fsmount_attr_tbls :=3D $(srctree)/tools/perf/trace/beauty/fsmount_att=
r.sh
> >  -
> >  -$(fsmount_attr_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_at=
tr_tbls)
> >  -    $(Q)$(SHELL) '$(fsmount_attr_tbls)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -fspick_arrays :=3D $(beauty_outdir)/fspick_arrays.c
> >  -fspick_tbls :=3D $(srctree)/tools/perf/trace/beauty/fspick.sh
> >  -
> >  -$(fspick_arrays): $(beauty_uapi_linux_dir)/mount.h $(fspick_tbls)
> >  -    $(Q)$(SHELL) '$(fspick_tbls)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -fsconfig_arrays :=3D $(beauty_outdir)/fsconfig_arrays.c
> >  -fsconfig_tbls :=3D $(srctree)/tools/perf/trace/beauty/fsconfig.sh
> >  -
> >  -$(fsconfig_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsconfig_tbls)
> >  -    $(Q)$(SHELL) '$(fsconfig_tbls)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -pkey_alloc_access_rights_array :=3D $(beauty_outdir)/pkey_alloc_acces=
s_rights_array.c
> >  -asm_generic_hdr_dir :=3D $(srctree)/tools/include/uapi/asm-generic/
> >  -pkey_alloc_access_rights_tbl :=3D $(srctree)/tools/perf/trace/beauty/=
pkey_alloc_access_rights.sh
> >  -
> >  -$(pkey_alloc_access_rights_array): $(asm_generic_hdr_dir)/mman-common=
.h $(pkey_alloc_access_rights_tbl)
> >  -    $(Q)$(SHELL) '$(pkey_alloc_access_rights_tbl)' $(asm_generic_hdr_=
dir) > $@
> >  -
> >  -sndrv_ctl_ioctl_array :=3D $(beauty_ioctl_outdir)/sndrv_ctl_ioctl_arr=
ay.c
> >  -sndrv_ctl_hdr_dir :=3D $(srctree)/tools/include/uapi/sound
> >  -sndrv_ctl_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/sndrv_ctl=
_ioctl.sh
> >  -
> >  -$(sndrv_ctl_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_c=
tl_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(sndrv_ctl_ioctl_tbl)' $(beauty_uapi_sound_dir) > =
$@
> >  -
> >  -sndrv_pcm_ioctl_array :=3D $(beauty_ioctl_outdir)/sndrv_pcm_ioctl_arr=
ay.c
> >  -sndrv_pcm_hdr_dir :=3D $(srctree)/tools/include/uapi/sound
> >  -sndrv_pcm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/sndrv_pcm=
_ioctl.sh
> >  -
> >  -$(sndrv_pcm_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_p=
cm_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(beauty_uapi_sound_dir) > =
$@
> >  -
> >  -kcmp_type_array :=3D $(beauty_outdir)/kcmp_type_array.c
> >  -kcmp_hdr_dir :=3D $(srctree)/tools/include/uapi/linux/
> >  -kcmp_type_tbl :=3D $(srctree)/tools/perf/trace/beauty/kcmp_type.sh
> >  -
> >  -$(kcmp_type_array): $(kcmp_hdr_dir)/kcmp.h $(kcmp_type_tbl)
> >  -    $(Q)$(SHELL) '$(kcmp_type_tbl)' $(kcmp_hdr_dir) > $@
> >  -
> >  -kvm_ioctl_array :=3D $(beauty_ioctl_outdir)/kvm_ioctl_array.c
> >  -kvm_hdr_dir :=3D $(srctree)/tools/include/uapi/linux
> >  -kvm_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
> >  -
> >  -$(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
> >  -
> >  -socket_arrays :=3D $(beauty_outdir)/socket.c
> >  -socket_tbl :=3D $(srctree)/tools/perf/trace/beauty/socket.sh
> >  -
> >  -$(socket_arrays): $(linux_uapi_dir)/in.h $(beauty_linux_dir)/socket.h=
 $(socket_tbl)
> >  -    $(Q)$(SHELL) '$(socket_tbl)' $(linux_uapi_dir) $(beauty_linux_dir=
) > $@
> >  -
> >  -sockaddr_arrays :=3D $(beauty_outdir)/sockaddr.c
> >  -sockaddr_tbl :=3D $(srctree)/tools/perf/trace/beauty/sockaddr.sh
> >  -
> >  -$(sockaddr_arrays): $(beauty_linux_dir)/socket.h $(sockaddr_tbl)
> >  -    $(Q)$(SHELL) '$(sockaddr_tbl)' $(beauty_linux_dir) > $@
> >  -
> >  -vhost_virtio_ioctl_array :=3D $(beauty_ioctl_outdir)/vhost_virtio_ioc=
tl_array.c
> >  -vhost_virtio_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/vhost_=
virtio_ioctl.sh
> >  -
> >  -$(vhost_virtio_ioctl_array): $(beauty_uapi_linux_dir)/vhost.h $(vhost=
_virtio_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(vhost_virtio_ioctl_tbl)' $(beauty_uapi_linux_dir)=
 > $@
> >  -
> >  -perf_ioctl_array :=3D $(beauty_ioctl_outdir)/perf_ioctl_array.c
> >  -perf_hdr_dir :=3D $(srctree)/tools/include/uapi/linux
> >  -perf_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/perf_ioctl.sh
> >  -
> >  -$(perf_ioctl_array): $(perf_hdr_dir)/perf_event.h $(perf_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(perf_ioctl_tbl)' $(perf_hdr_dir) > $@
> >  -
> >  -madvise_behavior_array :=3D $(beauty_outdir)/madvise_behavior_array.c
> >  -madvise_hdr_dir :=3D $(srctree)/tools/include/uapi/asm-generic/
> >  -madvise_behavior_tbl :=3D $(srctree)/tools/perf/trace/beauty/madvise_=
behavior.sh
> >  -
> >  -$(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise=
_behavior_tbl)
> >  -    $(Q)$(SHELL) '$(madvise_behavior_tbl)' $(madvise_hdr_dir) > $@
> >  -
> >  -mmap_flags_array :=3D $(beauty_outdir)/mmap_flags_array.c
> >  -mmap_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
> >  -
> >  -$(mmap_flags_array): $(linux_uapi_dir)/mman.h $(asm_generic_uapi_dir)=
/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
> >  -    $(Q)$(SHELL) '$(mmap_flags_tbl)' $(linux_uapi_dir) $(asm_generic_=
uapi_dir) $(arch_asm_uapi_dir) > $@
> >  -
> >  -mremap_flags_array :=3D $(beauty_outdir)/mremap_flags_array.c
> >  -mremap_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/mremap_flags=
.sh
> >  -
> >  -$(mremap_flags_array): $(linux_uapi_dir)/mman.h $(mremap_flags_tbl)
> >  -    $(Q)$(SHELL) '$(mremap_flags_tbl)' $(linux_uapi_dir) > $@
> >  -
> >  -mount_flags_array :=3D $(beauty_outdir)/mount_flags_array.c
> >  -mount_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/mount_flags.s=
h
> >  -
> >  -$(mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(mount_flags_=
tbl)
> >  -    $(Q)$(SHELL) '$(mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -move_mount_flags_array :=3D $(beauty_outdir)/move_mount_flags_array.c
> >  -move_mount_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/move_mou=
nt_flags.sh
> >  -
> >  -$(move_mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(move_mo=
unt_flags_tbl)
> >  -    $(Q)$(SHELL) '$(move_mount_flags_tbl)' $(beauty_uapi_linux_dir) >=
 $@
> >  -
> >  -mmap_prot_array :=3D $(beauty_outdir)/mmap_prot_array.c
> >  -mmap_prot_tbl :=3D $(srctree)/tools/perf/trace/beauty/mmap_prot.sh
> >  -
> >  -$(mmap_prot_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi=
_dir)/mman-common.h $(mmap_prot_tbl)
> >  -    $(Q)$(SHELL) '$(mmap_prot_tbl)' $(asm_generic_uapi_dir) $(arch_as=
m_uapi_dir) > $@
> >  -
> >  -prctl_option_array :=3D $(beauty_outdir)/prctl_option_array.c
> >  -prctl_option_tbl :=3D $(srctree)/tools/perf/trace/beauty/prctl_option=
.sh
> >  -
> >  -$(prctl_option_array): $(beauty_uapi_linux_dir)/prctl.h $(prctl_optio=
n_tbl)
> >  -    $(Q)$(SHELL) '$(prctl_option_tbl)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -usbdevfs_ioctl_array :=3D $(beauty_ioctl_outdir)/usbdevfs_ioctl_array=
.c
> >  -usbdevfs_ioctl_tbl :=3D $(srctree)/tools/perf/trace/beauty/usbdevfs_i=
octl.sh
> >  -
> >  -$(usbdevfs_ioctl_array): $(beauty_uapi_linux_dir)/usbdevice_fs.h $(us=
bdevfs_ioctl_tbl)
> >  -    $(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(beauty_uapi_linux_dir) > $=
@
> >  -
> >  -x86_arch_prctl_code_array :=3D $(beauty_outdir)/x86_arch_prctl_code_a=
rray.c
> >  -x86_arch_prctl_code_tbl :=3D $(srctree)/tools/perf/trace/beauty/x86_a=
rch_prctl.sh
> >  -
> >  -$(x86_arch_prctl_code_array): $(beauty_x86_arch_asm_uapi_dir)/prctl.h=
 $(x86_arch_prctl_code_tbl)
> >  -    $(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(beauty_x86_arch_asm_u=
api_dir) > $@
> >  -
> >  -x86_arch_irq_vectors_array :=3D $(beauty_outdir)/x86_arch_irq_vectors=
_array.c
> >  -x86_arch_irq_vectors_tbl :=3D $(srctree)/tools/perf/trace/beauty/trac=
epoints/x86_irq_vectors.sh
> >  -
> >  -$(x86_arch_irq_vectors_array): $(beauty_arch_asm_dir)/irq_vectors.h $=
(x86_arch_irq_vectors_tbl)
> >  -    $(Q)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(beauty_arch_asm_dir)=
 > $@
> >  -
> >  -x86_arch_MSRs_array :=3D $(beauty_outdir)/x86_arch_MSRs_array.c
> >  -x86_arch_MSRs_tbl :=3D $(srctree)/tools/perf/trace/beauty/tracepoints=
/x86_msr.sh
> >  -
> >  -$(x86_arch_MSRs_array): $(x86_arch_asm_dir)/msr-index.h $(x86_arch_MS=
Rs_tbl)
> >  -    $(Q)$(SHELL) '$(x86_arch_MSRs_tbl)' $(x86_arch_asm_dir) > $@
> >  -
> >  -rename_flags_array :=3D $(beauty_outdir)/rename_flags_array.c
> >  -rename_flags_tbl :=3D $(srctree)/tools/perf/trace/beauty/rename_flags=
.sh
> >  -
> >  -$(rename_flags_array): $(beauty_uapi_linux_dir)/fs.h $(rename_flags_t=
bl)
> >  -    $(Q)$(SHELL) '$(rename_flags_tbl)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -arch_errno_name_array :=3D $(beauty_outdir)/arch_errno_name_array.c
> >  -arch_errno_hdr_dir :=3D $(srctree)/tools
> >  -arch_errno_tbl :=3D $(srctree)/tools/perf/trace/beauty/arch_errno_nam=
es.sh
> >  -
> >  -$(arch_errno_name_array): $(arch_errno_tbl)
> >  -    $(Q)$(SHELL) '$(arch_errno_tbl)' '$(patsubst -%,,$(CC))' $(arch_e=
rrno_hdr_dir) > $@
> >  -
> >  -statx_mask_array :=3D $(beauty_outdir)/statx_mask_array.c
> >  -statx_mask_tbl :=3D $(srctree)/tools/perf/trace/beauty/statx_mask.sh
> >  -
> >  -$(statx_mask_array): $(beauty_uapi_linux_dir)/stat.h $(statx_mask_tbl=
)
> >  -    $(Q)$(SHELL) '$(statx_mask_tbl)' $(beauty_uapi_linux_dir) > $@
> >  -
> >  -sync_file_range_arrays :=3D $(beauty_outdir)/sync_file_range_arrays.c
> >  -sync_file_range_tbls :=3D $(srctree)/tools/perf/trace/beauty/sync_fil=
e_range.sh
> >  -
> >  -$(sync_file_range_arrays): $(beauty_uapi_linux_dir)/fs.h $(sync_file_=
range_tbls)
> >  -    $(Q)$(SHELL) '$(sync_file_range_tbls)' $(beauty_uapi_linux_dir) >=
 $@
> > --
> >   TESTS_CORESIGHT_DIR :=3D $(srctree)/tools/perf/tests/shell/coresight
> >
> >   tests-coresight-targets: FORCE
> > diff --cc tools/perf/builtin-trace.c
> > index 0730c1d9f0b3adc7,48615ddccd93a1e8..2530b4035e4f57e1
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@@ -783,11 -771,10 +783,6 @@@ static const char *bpf_cmd[] =3D
> >   };
> >   static DEFINE_STRARRAY(bpf_cmd, "BPF_");
> >
> > - static const char *fsmount_flags[] =3D {
> > -     [1] =3D "CLOEXEC",
> > - };
> > - static DEFINE_STRARRAY(fsmount_flags, "FSMOUNT_");
> >  -#include "trace/beauty/generated/fsconfig_arrays.c"
> >  -
> >  -static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
> > --
> >   static const char *epoll_ctl_ops[] =3D { "ADD", "DEL", "MOD", };
> >   static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, "EPOLL_CTL_", 1);
> >
