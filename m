Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C53D7D76
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866750; cv=none; b=BHO/d1JztKmpq+6cNSunFZ77il4jHgBcb1TA43TX/QAZY0+sRJ7RlcXe2p/9yNVG2+5PRK4qOOkqRu0dgbRY8mWzmc7NsQ2+WZ9dt8R+upVhnkVAURn7cMIpXoQeLhEjkaRz057S6+vBfrNu9SH8Wb8Rp9ZTZdKt64poOxN3Wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866750; c=relaxed/simple;
	bh=Fe8gKaAoxmBrnXKFIsHy9D2jio602d2Hb+xYIlY7jqc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a1w8a5Wymul5sS0tcZkcJgi6tuVpyrBReUmh+ah8jpM+8aiiS7biyvdQManlDwDE8rFMCKuo7BaJP2/vWq6Ve9rmn7qkFa75oURVpFjwXYsQEC2fn0XUm4b0M8jQZmVmrue8EHcpoe0SgKOAOBkLnQ13VbUhPf28zXA4FEUUNcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU9w8D1c; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU9w8D1c"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ef62078ee7so117169eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866746; x=1779471546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGwNldacOVCvHmvUdji2eOK+t9zrcgmlfdJtC+b5nNE=;
        b=UU9w8D1cE177SX5ZEJU8ovKwJ+ThCoGtBCn45C4k++ZW5YsWiqEqSdy9S32c91tDGa
         icBtPEcBXLArTEopTqDmzRc8HEAHS5Q1wd9NecMfeKZ1IwqTQ27XT01LWPngS6qZ3K3B
         ixP3qADWpyKEUY5sAjKrvOfp6RlvIsqtOuMTDX+dTyYUjwVM/H8SaFQY6l9WxIZl5NBs
         /K+USAst0QLL7FPYYVavLMzCd0Yejz/p3OFcVn0pAxCjjah8c9nbDfKi6EQ5QTwy0y97
         rvQhC9HJfW/RzmJ0bEkSCuz6XrUI54dV8SAHbrftreLNPGdwUChArZQmVcBaqp9kKEzR
         Tk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866746; x=1779471546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGwNldacOVCvHmvUdji2eOK+t9zrcgmlfdJtC+b5nNE=;
        b=PQh3PY7EzMLlhgcCwEUGYlNPCgZSrJ2ZS/NIwGe/U8hH2WyfY7R0U7n4BleHkKLaA6
         d0L2AM9u916Yyg53Q6Un722mZ70bIqE33IMTODYVrYZXdi7GSvnH4TQ+7MyvxhnRs2lp
         ckDmucnG1/ZikLH1NZUK+c9+FJyRorjVIl2Mm5A4SnNG6LCv9QHPRFeLApgOzwQsQPz8
         yrsQopR3CvyaIYhP3l92CWl/nNePuwwiq4a2td4RwIxT+I4DWP5boHRaF+n1Xd7+nz4u
         Cjmd2zY/IwxjJOBfgJMaAg7Bn/EU6FyeDGN0y6ZiT42Y0sXC8r1L2k15wf85PoAO2lyt
         oEJg==
X-Forwarded-Encrypted: i=1; AFNElJ+N8y9UJsDOsRQ0OGyEAVBdiMoQvTmU4pzRNasi+L29Ht5lbLM8wczARQ4FgcVNCz8Fe8e7QZc6cSbRpWs9i5Vc@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiXJPsVPwyO9d0hY0OdLdxi62/v/C7ossVDteP5Se0zjmwZYi
	BHZ48tfnl7CpWxhNteGmBRDxcdQ/1VRuYNAgpqTmK5ZWkhQKIZvrf4BZqaw/dzqZKH/KY7UIfVh
	W4qv5uehuHA==
X-Received: from dyng37.prod.google.com ([2002:a05:7300:7f25:b0:2f9:af7:5044])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e6c6:b0:2ea:e93a:ff9b
 with SMTP id 5a478bee46e88-303982b72e9mr2319552eec.13.1778866745315; Fri, 15
 May 2026 10:39:05 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:39 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-3-irogers@google.com>
Subject: [PATCH v4 02/14] perf trace beauty: Make beauty generated C code
 standalone .o files
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Previously, builtin-trace.c directly included 15 embedded C files
(e.g. trace/beauty/mmap.c and fsconfig_arrays.c), which in turn depend
on dozens of generated beauty script arrays. To satisfy these embedded
inclusions, the global Makefile.perf would define all the generator
variables/rules and include them in the prepare umbrella target, choking
parallel build startup.

Furthermore, tools/perf/util/syscalltbl.c included its own generated mapper,
and util/env.c conditionally included arch_errno_names.c inline, splitting
consumers across directories and preventing clean Make encapsulation.

Refactor the framework to achieve better encapsulation:
1. Move util/syscalltbl.[ch] into trace/beauty/ to co-locate with all
   generated code consumers.
2. Create fsconfig.c and flatten embedded beauty .c files to compile as
   independent standalone objects via trace/beauty/Build, exporting their
   formatting functions via beauty.h and env.h. Switch arch_errno_names.o
   and syscalltbl.o assignments directly to perf-util-y and add an
   unconditional top-level recursive kbuild hook (perf-util-y += trace/beauty/)
   to compile them into libperf-util.a, resolving remote linkage for util/env.c,
   util/bpf-trace-summary.c, and standalone python extensions.
3. Bridge private opaque references (struct trace) securely via accessors
   trace__show_zeros() and trace__host(), avoiding header entanglements.
4. Consolidate all generator variables, script paths, and array generation
   rules entirely out of Makefile.perf and place them directly inside the
   exact local Build files where their output objects are compiled
   (trace/beauty/Build and trace/beauty/tracepoints/Build), binding
   prerequisites locally. Use  directly inside
   generator recipes to guarantee dynamic directory creation before script
   redirection, and append  across all rules to print
   clean, standardized GEN ... file.c output during compilation.
5. Clean up clean target to recursively remove the generated directory
   instead of relying on dozens of individual variables.

This unchokes the "prepare" target parallel barrier, allows make to evaluate
generation scripts purely locally where consumed, and flattens the tracepoint
formatting architecture.

Testing a parallel build (make -j28 all from scratch) shows improvements:
  Before:
    real    0m28.689s
    user    2m38.490s
    sys     0m30.148s

  After:
    real    0m27.642s
    user    2m32.356s
    sys     0m26.683s

So reclaiming ~9.6 seconds of raw CPU time and over 1 full second off
overall real-world build latency, by overlapping sub-make startup and
avoiding top-level double-parsing overhead.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build                              |   2 +
 tools/perf/Makefile.perf                      | 282 +-----------------
 tools/perf/builtin-trace.c                    |  32 +-
 tools/perf/trace/beauty/Build                 | 276 +++++++++++++++++
 tools/perf/trace/beauty/arch_errno_names.c    |   2 +
 tools/perf/trace/beauty/arch_errno_names.sh   |   2 +-
 tools/perf/trace/beauty/beauty.h              |  60 ++++
 tools/perf/trace/beauty/eventfd.c             |   6 +-
 tools/perf/trace/beauty/fsconfig.c            |   5 +
 tools/perf/trace/beauty/futex_op.c            |   5 +-
 tools/perf/trace/beauty/futex_val3.c          |   5 +-
 tools/perf/trace/beauty/mmap.c                |  24 +-
 tools/perf/trace/beauty/mode_t.c              |   6 +-
 tools/perf/trace/beauty/msg_flags.c           |   8 +-
 tools/perf/trace/beauty/open_flags.c          |   2 +
 tools/perf/trace/beauty/perf_event_open.c     |  21 +-
 tools/perf/trace/beauty/pid.c                 |   5 +-
 tools/perf/trace/beauty/sched_policy.c        |   8 +-
 tools/perf/trace/beauty/seccomp.c             |  12 +-
 tools/perf/trace/beauty/signum.c              |   6 +-
 tools/perf/trace/beauty/socket_type.c         |   6 +-
 .../perf/{util => trace/beauty}/syscalltbl.c  |   0
 .../perf/{util => trace/beauty}/syscalltbl.h  |   0
 tools/perf/trace/beauty/tracepoints/Build     |  21 ++
 tools/perf/trace/beauty/waitid_options.c      |   8 +-
 tools/perf/util/Build                         |   4 +-
 tools/perf/util/bpf-trace-summary.c           |   2 +-
 tools/perf/util/env.c                         |   4 -
 tools/perf/util/env.h                         |   1 +
 29 files changed, 447 insertions(+), 368 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)

diff --git a/tools/perf/Build b/tools/perf/Build
index b03cc59dabf8..e18c80a5c1bc 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -34,6 +34,8 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-$(CONFIG_TRACE) += trace/beauty/
 endif
 
+perf-util-y += trace/beauty/
+
 perf-$(CONFIG_LIBELF) += builtin-probe.o
 
 perf-bench-y += bench/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0aba14f22a06..c81797ceec42 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -509,225 +509,6 @@ arm64-sysreg-defs-clean:
 	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir) \
 		prefix= subdir= clean > /dev/null
 
-beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
-beauty_uapi_linux_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/linux/
-beauty_uapi_sound_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/sound/
-beauty_arch_asm_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/asm/
-beauty_x86_arch_asm_uapi_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/uapi/asm/
-
-linux_uapi_dir := $(srctree)/tools/include/uapi/linux
-asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
-arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
-x86_arch_asm_dir := $(srctree)/tools/arch/x86/include/asm/
-
-beauty_outdir := $(OUTPUT)trace/beauty/generated
-beauty_ioctl_outdir := $(beauty_outdir)/ioctl
-
-# Create output directory if not already present
-$(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_outdir)')
-
-syscall_array := $(beauty_outdir)/syscalltbl.c
-syscall_tbl := $(srctree)/tools/perf/trace/beauty/syscalltbl.sh
-syscall_tbl_data := $(srctree)/tools/scripts/syscall.tbl \
-	$(wildcard $(srctree)/tools/perf/arch/*/entry/syscalls/syscall*.tbl)
-
-$(syscall_array): $(syscall_tbl) $(syscall_tbl_data)
-	$(Q)$(SHELL) '$(syscall_tbl)' $(srctree)/tools $@
-
-fs_at_flags_array := $(beauty_outdir)/fs_at_flags_array.c
-fs_at_flags_tbl := $(srctree)/tools/perf/trace/beauty/fs_at_flags.sh
-
-$(fs_at_flags_array): $(beauty_uapi_linux_dir)/fcntl.h $(fs_at_flags_tbl)
-	$(Q)$(SHELL) '$(fs_at_flags_tbl)' $(beauty_uapi_linux_dir) > $@
-
-clone_flags_array := $(beauty_outdir)/clone_flags_array.c
-clone_flags_tbl := $(srctree)/tools/perf/trace/beauty/clone.sh
-
-$(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_tbl)
-	$(Q)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
-
-drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
-drm_hdr_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/drm
-drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
-
-$(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
-	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
-
-fadvise_advice_array := $(beauty_outdir)/fadvise_advice_array.c
-fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
-
-$(fadvise_advice_array): $(beauty_uapi_linux_dir)/fadvise.h $(fadvise_advice_tbl)
-	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(beauty_uapi_linux_dir) > $@
-
-fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
-fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
-
-$(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
-	$(Q)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
-
-fspick_arrays := $(beauty_outdir)/fspick_arrays.c
-fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
-
-$(fspick_arrays): $(beauty_uapi_linux_dir)/mount.h $(fspick_tbls)
-	$(Q)$(SHELL) '$(fspick_tbls)' $(beauty_uapi_linux_dir) > $@
-
-fsconfig_arrays := $(beauty_outdir)/fsconfig_arrays.c
-fsconfig_tbls := $(srctree)/tools/perf/trace/beauty/fsconfig.sh
-
-$(fsconfig_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsconfig_tbls)
-	$(Q)$(SHELL) '$(fsconfig_tbls)' $(beauty_uapi_linux_dir) > $@
-
-pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
-asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
-pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
-
-$(pkey_alloc_access_rights_array): $(asm_generic_hdr_dir)/mman-common.h $(pkey_alloc_access_rights_tbl)
-	$(Q)$(SHELL) '$(pkey_alloc_access_rights_tbl)' $(asm_generic_hdr_dir) > $@
-
-sndrv_ctl_ioctl_array := $(beauty_ioctl_outdir)/sndrv_ctl_ioctl_array.c
-sndrv_ctl_hdr_dir := $(srctree)/tools/include/uapi/sound
-sndrv_ctl_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
-
-$(sndrv_ctl_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_ctl_ioctl_tbl)
-	$(Q)$(SHELL) '$(sndrv_ctl_ioctl_tbl)' $(beauty_uapi_sound_dir) > $@
-
-sndrv_pcm_ioctl_array := $(beauty_ioctl_outdir)/sndrv_pcm_ioctl_array.c
-sndrv_pcm_hdr_dir := $(srctree)/tools/include/uapi/sound
-sndrv_pcm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
-
-$(sndrv_pcm_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
-	$(Q)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(beauty_uapi_sound_dir) > $@
-
-kcmp_type_array := $(beauty_outdir)/kcmp_type_array.c
-kcmp_hdr_dir := $(srctree)/tools/include/uapi/linux/
-kcmp_type_tbl := $(srctree)/tools/perf/trace/beauty/kcmp_type.sh
-
-$(kcmp_type_array): $(kcmp_hdr_dir)/kcmp.h $(kcmp_type_tbl)
-	$(Q)$(SHELL) '$(kcmp_type_tbl)' $(kcmp_hdr_dir) > $@
-
-kvm_ioctl_array := $(beauty_ioctl_outdir)/kvm_ioctl_array.c
-kvm_hdr_dir := $(srctree)/tools/include/uapi/linux
-kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
-
-$(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
-	$(Q)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
-
-socket_arrays := $(beauty_outdir)/socket.c
-socket_tbl := $(srctree)/tools/perf/trace/beauty/socket.sh
-
-$(socket_arrays): $(linux_uapi_dir)/in.h $(beauty_linux_dir)/socket.h $(socket_tbl)
-	$(Q)$(SHELL) '$(socket_tbl)' $(linux_uapi_dir) $(beauty_linux_dir) > $@
-
-sockaddr_arrays := $(beauty_outdir)/sockaddr.c
-sockaddr_tbl := $(srctree)/tools/perf/trace/beauty/sockaddr.sh
-
-$(sockaddr_arrays): $(beauty_linux_dir)/socket.h $(sockaddr_tbl)
-	$(Q)$(SHELL) '$(sockaddr_tbl)' $(beauty_linux_dir) > $@
-
-vhost_virtio_ioctl_array := $(beauty_ioctl_outdir)/vhost_virtio_ioctl_array.c
-vhost_virtio_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
-
-$(vhost_virtio_ioctl_array): $(beauty_uapi_linux_dir)/vhost.h $(vhost_virtio_ioctl_tbl)
-	$(Q)$(SHELL) '$(vhost_virtio_ioctl_tbl)' $(beauty_uapi_linux_dir) > $@
-
-perf_ioctl_array := $(beauty_ioctl_outdir)/perf_ioctl_array.c
-perf_hdr_dir := $(srctree)/tools/include/uapi/linux
-perf_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/perf_ioctl.sh
-
-$(perf_ioctl_array): $(perf_hdr_dir)/perf_event.h $(perf_ioctl_tbl)
-	$(Q)$(SHELL) '$(perf_ioctl_tbl)' $(perf_hdr_dir) > $@
-
-madvise_behavior_array := $(beauty_outdir)/madvise_behavior_array.c
-madvise_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
-madvise_behavior_tbl := $(srctree)/tools/perf/trace/beauty/madvise_behavior.sh
-
-$(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_tbl)
-	$(Q)$(SHELL) '$(madvise_behavior_tbl)' $(madvise_hdr_dir) > $@
-
-mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
-mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
-
-$(mmap_flags_array): $(linux_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
-	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(linux_uapi_dir) $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
-
-mremap_flags_array := $(beauty_outdir)/mremap_flags_array.c
-mremap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mremap_flags.sh
-
-$(mremap_flags_array): $(linux_uapi_dir)/mman.h $(mremap_flags_tbl)
-	$(Q)$(SHELL) '$(mremap_flags_tbl)' $(linux_uapi_dir) > $@
-
-mount_flags_array := $(beauty_outdir)/mount_flags_array.c
-mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
-
-$(mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(mount_flags_tbl)
-	$(Q)$(SHELL) '$(mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
-
-move_mount_flags_array := $(beauty_outdir)/move_mount_flags_array.c
-move_mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/move_mount_flags.sh
-
-$(move_mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(move_mount_flags_tbl)
-	$(Q)$(SHELL) '$(move_mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
-
-mmap_prot_array := $(beauty_outdir)/mmap_prot_array.c
-mmap_prot_tbl := $(srctree)/tools/perf/trace/beauty/mmap_prot.sh
-
-$(mmap_prot_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_prot_tbl)
-	$(Q)$(SHELL) '$(mmap_prot_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
-
-prctl_option_array := $(beauty_outdir)/prctl_option_array.c
-prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
-
-$(prctl_option_array): $(beauty_uapi_linux_dir)/prctl.h $(prctl_option_tbl)
-	$(Q)$(SHELL) '$(prctl_option_tbl)' $(beauty_uapi_linux_dir) > $@
-
-usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
-usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
-
-$(usbdevfs_ioctl_array): $(beauty_uapi_linux_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
-	$(Q)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(beauty_uapi_linux_dir) > $@
-
-x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
-x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
-
-$(x86_arch_prctl_code_array): $(beauty_x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
-	$(Q)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(beauty_x86_arch_asm_uapi_dir) > $@
-
-x86_arch_irq_vectors_array := $(beauty_outdir)/x86_arch_irq_vectors_array.c
-x86_arch_irq_vectors_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
-
-$(x86_arch_irq_vectors_array): $(beauty_arch_asm_dir)/irq_vectors.h $(x86_arch_irq_vectors_tbl)
-	$(Q)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(beauty_arch_asm_dir) > $@
-
-x86_arch_MSRs_array := $(beauty_outdir)/x86_arch_MSRs_array.c
-x86_arch_MSRs_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_msr.sh
-
-$(x86_arch_MSRs_array): $(x86_arch_asm_dir)/msr-index.h $(x86_arch_MSRs_tbl)
-	$(Q)$(SHELL) '$(x86_arch_MSRs_tbl)' $(x86_arch_asm_dir) > $@
-
-rename_flags_array := $(beauty_outdir)/rename_flags_array.c
-rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
-
-$(rename_flags_array): $(beauty_uapi_linux_dir)/fs.h $(rename_flags_tbl)
-	$(Q)$(SHELL) '$(rename_flags_tbl)' $(beauty_uapi_linux_dir) > $@
-
-arch_errno_name_array := $(beauty_outdir)/arch_errno_name_array.c
-arch_errno_hdr_dir := $(srctree)/tools
-arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
-
-$(arch_errno_name_array): $(arch_errno_tbl)
-	$(Q)$(SHELL) '$(arch_errno_tbl)' '$(patsubst -%,,$(CC))' $(arch_errno_hdr_dir) > $@
-
-statx_mask_array := $(beauty_outdir)/statx_mask_array.c
-statx_mask_tbl := $(srctree)/tools/perf/trace/beauty/statx_mask.sh
-
-$(statx_mask_array): $(beauty_uapi_linux_dir)/stat.h $(statx_mask_tbl)
-	$(Q)$(SHELL) '$(statx_mask_tbl)' $(beauty_uapi_linux_dir) > $@
-
-sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
-sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
-
-$(sync_file_range_arrays): $(beauty_uapi_linux_dir)/fs.h $(sync_file_range_tbls)
-	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(beauty_uapi_linux_dir) > $@
 
 TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
 
@@ -848,38 +629,6 @@ build-dir   = $(or $(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE archheaders \
 	arm64-sysreg-defs \
-	$(syscall_array) \
-	$(fs_at_flags_array) \
-	$(clone_flags_array) \
-	$(drm_ioctl_array) \
-	$(fadvise_advice_array) \
-	$(fsconfig_arrays) \
-	$(fsmount_arrays) \
-	$(fspick_arrays) \
-	$(pkey_alloc_access_rights_array) \
-	$(sndrv_pcm_ioctl_array) \
-	$(sndrv_ctl_ioctl_array) \
-	$(kcmp_type_array) \
-	$(kvm_ioctl_array) \
-	$(socket_arrays) \
-	$(sockaddr_arrays) \
-	$(vhost_virtio_ioctl_array) \
-	$(madvise_behavior_array) \
-	$(mmap_flags_array) \
-	$(mmap_prot_array) \
-	$(mremap_flags_array) \
-	$(mount_flags_array) \
-	$(move_mount_flags_array) \
-	$(perf_ioctl_array) \
-	$(prctl_option_array) \
-	$(usbdevfs_ioctl_array) \
-	$(x86_arch_irq_vectors_array) \
-	$(x86_arch_MSRs_array) \
-	$(x86_arch_prctl_code_array) \
-	$(rename_flags_array) \
-	$(arch_errno_name_array) \
-	$(statx_mask_array) \
-	$(sync_file_range_arrays) \
 	$(LIBAPI) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
@@ -1299,35 +1048,8 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
 		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
-		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
-		$(OUTPUT)$(fadvise_advice_array) \
-		$(OUTPUT)$(fsconfig_arrays) \
-		$(OUTPUT)$(fsmount_arrays) \
-		$(OUTPUT)$(fspick_arrays) \
-		$(OUTPUT)$(madvise_behavior_array) \
-		$(OUTPUT)$(mmap_flags_array) \
-		$(OUTPUT)$(mmap_prot_array) \
-		$(OUTPUT)$(mremap_flags_array) \
-		$(OUTPUT)$(mount_flags_array) \
-		$(OUTPUT)$(move_mount_flags_array) \
-		$(OUTPUT)$(drm_ioctl_array) \
-		$(OUTPUT)$(pkey_alloc_access_rights_array) \
-		$(OUTPUT)$(sndrv_ctl_ioctl_array) \
-		$(OUTPUT)$(sndrv_pcm_ioctl_array) \
-		$(OUTPUT)$(kvm_ioctl_array) \
-		$(OUTPUT)$(kcmp_type_array) \
-		$(OUTPUT)$(socket_arrays) \
-		$(OUTPUT)$(sockaddr_arrays) \
-		$(OUTPUT)$(vhost_virtio_ioctl_array) \
-		$(OUTPUT)$(perf_ioctl_array) \
-		$(OUTPUT)$(prctl_option_array) \
-		$(OUTPUT)$(usbdevfs_ioctl_array) \
-		$(OUTPUT)$(x86_arch_irq_vectors_array) \
-		$(OUTPUT)$(x86_arch_MSRs_array) \
-		$(OUTPUT)$(x86_arch_prctl_code_array) \
-		$(OUTPUT)$(rename_flags_array) \
-		$(OUTPUT)$(arch_errno_name_array) \
-		$(OUTPUT)$(sync_file_range_arrays)
+		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c
+	$(Q)$(RM) -r $(OUTPUT)trace/beauty/generated
 	$(call QUIET_CLEAN, Documentation) \
 	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e58c49d047a2..f362fa7ab1af 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -60,12 +60,13 @@
 #include "callchain.h"
 #include "print_binary.h"
 #include "string2.h"
-#include "syscalltbl.h"
+#include "trace/beauty/syscalltbl.h"
 #include "../perf.h"
 #include "trace_augment.h"
 #include "dwarf-regs.h"
 
 #include <errno.h>
+#include <sys/stat.h>
 #include <inttypes.h>
 #include <poll.h>
 #include <signal.h>
@@ -234,6 +235,16 @@ struct trace {
 	const char		*uid_str;
 };
 
+bool trace__show_zeros(const struct trace *trace)
+{
+	return trace->show_zeros;
+}
+
+struct machine *trace__host(const struct trace *trace)
+{
+	return trace->host;
+}
+
 static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
 {
 #ifdef HAVE_LIBBPF_SUPPORT
@@ -776,10 +787,6 @@ static const char *fsmount_flags[] = {
 };
 static DEFINE_STRARRAY(fsmount_flags, "FSMOUNT_");
 
-#include "trace/beauty/generated/fsconfig_arrays.c"
-
-static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
-
 static const char *epoll_ctl_ops[] = { "ADD", "DEL", "MOD", };
 static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, "EPOLL_CTL_", 1);
 
@@ -1128,21 +1135,6 @@ static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size _
 	    .parm	= &strarray__##array, \
 	    .show_zero	= true, }
 
-#include "trace/beauty/eventfd.c"
-#include "trace/beauty/futex_op.c"
-#include "trace/beauty/futex_val3.c"
-#include "trace/beauty/mmap.c"
-#include "trace/beauty/mode_t.c"
-#include "trace/beauty/msg_flags.c"
-#include "trace/beauty/open_flags.c"
-#include "trace/beauty/perf_event_open.c"
-#include "trace/beauty/pid.c"
-#include "trace/beauty/sched_policy.c"
-#include "trace/beauty/seccomp.c"
-#include "trace/beauty/signum.c"
-#include "trace/beauty/socket_type.c"
-#include "trace/beauty/waitid_options.c"
-
 static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 561590ee8cda..93cde93461a3 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -19,6 +19,23 @@ perf-y += socket.o
 perf-y += statx.o
 perf-y += sync_file_range.o
 perf-y += timespec.o
+perf-util-y += syscalltbl.o
+perf-y += fsconfig.o
+perf-y += eventfd.o
+perf-y += futex_op.o
+perf-y += futex_val3.o
+perf-y += mmap.o
+perf-y += mode_t.o
+perf-y += msg_flags.o
+perf-y += open_flags.o
+perf-y += perf_event_open.o
+perf-y += pid.o
+perf-y += sched_policy.o
+perf-y += seccomp.o
+perf-y += signum.o
+perf-y += socket_type.o
+perf-y += waitid_options.o
+perf-util-y += arch_errno_names.o
 perf-y += tracepoints/
 
 ifdef SHELLCHECK
@@ -34,3 +51,262 @@ $(OUTPUT)%.shellcheck_log: %
 	$(Q)$(call echo-cmd,test)$(SHELLCHECK) "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-y += $(SHELL_TEST_LOGS)
+
+beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
+beauty_uapi_linux_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/linux/
+beauty_uapi_sound_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/sound/
+beauty_arch_asm_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/asm/
+beauty_x86_arch_asm_uapi_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/uapi/asm/
+
+linux_uapi_dir := $(srctree)/tools/include/uapi/linux
+asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
+arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
+x86_arch_asm_dir := $(srctree)/tools/arch/x86/include/asm/
+
+beauty_outdir := $(OUTPUT)trace/beauty/generated
+beauty_ioctl_outdir := $(beauty_outdir)/ioctl
+
+syscall_array := $(beauty_outdir)/syscalltbl.c
+syscall_tbl := $(srctree)/tools/perf/trace/beauty/syscalltbl.sh
+syscall_tbl_data := $(srctree)/tools/scripts/syscall.tbl \
+	$(wildcard $(srctree)/tools/perf/arch/*/entry/syscalls/syscall*.tbl)
+
+$(syscall_array): $(syscall_tbl) $(syscall_tbl_data)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(syscall_tbl)' $(srctree)/tools $@
+
+fs_at_flags_array := $(beauty_outdir)/fs_at_flags_array.c
+fs_at_flags_tbl := $(srctree)/tools/perf/trace/beauty/fs_at_flags.sh
+
+$(fs_at_flags_array): $(beauty_uapi_linux_dir)/fcntl.h $(fs_at_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fs_at_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
+clone_flags_array := $(beauty_outdir)/clone_flags_array.c
+clone_flags_tbl := $(srctree)/tools/perf/trace/beauty/clone.sh
+
+$(clone_flags_array): $(beauty_uapi_linux_dir)/sched.h $(clone_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(clone_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
+drm_ioctl_array := $(beauty_ioctl_outdir)/drm_ioctl_array.c
+drm_hdr_dir := $(srctree)/tools/perf/trace/beauty/include/uapi/drm
+drm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/drm_ioctl.sh
+
+$(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
+
+fadvise_advice_array := $(beauty_outdir)/fadvise_advice_array.c
+fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
+
+$(fadvise_advice_array): $(beauty_uapi_linux_dir)/fadvise.h $(fadvise_advice_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fadvise_advice_tbl)' $(beauty_uapi_linux_dir) > $@
+
+fsmount_arrays := $(beauty_outdir)/fsmount_arrays.c
+fsmount_tbls := $(srctree)/tools/perf/trace/beauty/fsmount.sh
+
+$(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
+
+fspick_arrays := $(beauty_outdir)/fspick_arrays.c
+fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
+
+$(fspick_arrays): $(beauty_uapi_linux_dir)/mount.h $(fspick_tbls)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fspick_tbls)' $(beauty_uapi_linux_dir) > $@
+
+fsconfig_arrays := $(beauty_outdir)/fsconfig_arrays.c
+fsconfig_tbls := $(srctree)/tools/perf/trace/beauty/fsconfig.sh
+
+$(fsconfig_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsconfig_tbls)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fsconfig_tbls)' $(beauty_uapi_linux_dir) > $@
+
+pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
+asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
+pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
+
+$(pkey_alloc_access_rights_array): $(asm_generic_hdr_dir)/mman-common.h $(pkey_alloc_access_rights_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(pkey_alloc_access_rights_tbl)' $(asm_generic_hdr_dir) > $@
+
+sndrv_ctl_ioctl_array := $(beauty_ioctl_outdir)/sndrv_ctl_ioctl_array.c
+sndrv_ctl_hdr_dir := $(srctree)/tools/include/uapi/sound
+sndrv_ctl_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
+
+$(sndrv_ctl_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_ctl_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(sndrv_ctl_ioctl_tbl)' $(beauty_uapi_sound_dir) > $@
+
+sndrv_pcm_ioctl_array := $(beauty_ioctl_outdir)/sndrv_pcm_ioctl_array.c
+sndrv_pcm_hdr_dir := $(srctree)/tools/include/uapi/sound
+sndrv_pcm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
+
+$(sndrv_pcm_ioctl_array): $(beauty_uapi_sound_dir)/asound.h $(sndrv_pcm_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(sndrv_pcm_ioctl_tbl)' $(beauty_uapi_sound_dir) > $@
+
+kcmp_type_array := $(beauty_outdir)/kcmp_type_array.c
+kcmp_hdr_dir := $(srctree)/tools/include/uapi/linux/
+kcmp_type_tbl := $(srctree)/tools/perf/trace/beauty/kcmp_type.sh
+
+$(kcmp_type_array): $(kcmp_hdr_dir)/kcmp.h $(kcmp_type_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(kcmp_type_tbl)' $(kcmp_hdr_dir) > $@
+
+kvm_ioctl_array := $(beauty_ioctl_outdir)/kvm_ioctl_array.c
+kvm_hdr_dir := $(srctree)/tools/include/uapi/linux
+kvm_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/kvm_ioctl.sh
+
+$(kvm_ioctl_array): $(kvm_hdr_dir)/kvm.h $(kvm_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(kvm_ioctl_tbl)' $(kvm_hdr_dir) > $@
+
+socket_arrays := $(beauty_outdir)/socket.c
+socket_tbl := $(srctree)/tools/perf/trace/beauty/socket.sh
+
+$(socket_arrays): $(linux_uapi_dir)/in.h $(beauty_linux_dir)/socket.h $(socket_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(socket_tbl)' $(linux_uapi_dir) $(beauty_linux_dir) > $@
+
+sockaddr_arrays := $(beauty_outdir)/sockaddr.c
+sockaddr_tbl := $(srctree)/tools/perf/trace/beauty/sockaddr.sh
+
+$(sockaddr_arrays): $(beauty_linux_dir)/socket.h $(sockaddr_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(sockaddr_tbl)' $(beauty_linux_dir) > $@
+
+vhost_virtio_ioctl_array := $(beauty_ioctl_outdir)/vhost_virtio_ioctl_array.c
+vhost_virtio_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/vhost_virtio_ioctl.sh
+
+$(vhost_virtio_ioctl_array): $(beauty_uapi_linux_dir)/vhost.h $(vhost_virtio_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(vhost_virtio_ioctl_tbl)' $(beauty_uapi_linux_dir) > $@
+
+perf_ioctl_array := $(beauty_ioctl_outdir)/perf_ioctl_array.c
+perf_hdr_dir := $(srctree)/tools/include/uapi/linux
+perf_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/perf_ioctl.sh
+
+$(perf_ioctl_array): $(perf_hdr_dir)/perf_event.h $(perf_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(perf_ioctl_tbl)' $(perf_hdr_dir) > $@
+
+madvise_behavior_array := $(beauty_outdir)/madvise_behavior_array.c
+madvise_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
+madvise_behavior_tbl := $(srctree)/tools/perf/trace/beauty/madvise_behavior.sh
+
+$(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(madvise_behavior_tbl)' $(madvise_hdr_dir) > $@
+
+mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
+mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
+
+$(mmap_flags_array): $(linux_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(mmap_flags_tbl)' $(linux_uapi_dir) $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
+
+mremap_flags_array := $(beauty_outdir)/mremap_flags_array.c
+mremap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mremap_flags.sh
+
+$(mremap_flags_array): $(linux_uapi_dir)/mman.h $(mremap_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(mremap_flags_tbl)' $(linux_uapi_dir) > $@
+
+mount_flags_array := $(beauty_outdir)/mount_flags_array.c
+mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
+
+$(mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(mount_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
+move_mount_flags_array := $(beauty_outdir)/move_mount_flags_array.c
+move_mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/move_mount_flags.sh
+
+$(move_mount_flags_array): $(beauty_uapi_linux_dir)/mount.h $(move_mount_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(move_mount_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
+mmap_prot_array := $(beauty_outdir)/mmap_prot_array.c
+mmap_prot_tbl := $(srctree)/tools/perf/trace/beauty/mmap_prot.sh
+
+$(mmap_prot_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_prot_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(mmap_prot_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
+
+prctl_option_array := $(beauty_outdir)/prctl_option_array.c
+prctl_option_tbl := $(srctree)/tools/perf/trace/beauty/prctl_option.sh
+
+$(prctl_option_array): $(beauty_uapi_linux_dir)/prctl.h $(prctl_option_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(prctl_option_tbl)' $(beauty_uapi_linux_dir) > $@
+
+usbdevfs_ioctl_array := $(beauty_ioctl_outdir)/usbdevfs_ioctl_array.c
+usbdevfs_ioctl_tbl := $(srctree)/tools/perf/trace/beauty/usbdevfs_ioctl.sh
+
+$(usbdevfs_ioctl_array): $(beauty_uapi_linux_dir)/usbdevice_fs.h $(usbdevfs_ioctl_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(usbdevfs_ioctl_tbl)' $(beauty_uapi_linux_dir) > $@
+
+x86_arch_prctl_code_array := $(beauty_outdir)/x86_arch_prctl_code_array.c
+x86_arch_prctl_code_tbl := $(srctree)/tools/perf/trace/beauty/x86_arch_prctl.sh
+
+$(x86_arch_prctl_code_array): $(beauty_x86_arch_asm_uapi_dir)/prctl.h $(x86_arch_prctl_code_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(x86_arch_prctl_code_tbl)' $(beauty_x86_arch_asm_uapi_dir) > $@
+
+
+rename_flags_array := $(beauty_outdir)/rename_flags_array.c
+rename_flags_tbl := $(srctree)/tools/perf/trace/beauty/rename_flags.sh
+
+$(rename_flags_array): $(beauty_uapi_linux_dir)/fs.h $(rename_flags_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(rename_flags_tbl)' $(beauty_uapi_linux_dir) > $@
+
+
+statx_mask_array := $(beauty_outdir)/statx_mask_array.c
+statx_mask_tbl := $(srctree)/tools/perf/trace/beauty/statx_mask.sh
+
+$(statx_mask_array): $(beauty_uapi_linux_dir)/stat.h $(statx_mask_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(statx_mask_tbl)' $(beauty_uapi_linux_dir) > $@
+
+sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
+sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
+
+$(sync_file_range_arrays): $(beauty_uapi_linux_dir)/fs.h $(sync_file_range_tbls)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(sync_file_range_tbls)' $(beauty_uapi_linux_dir) > $@
+
+$(OUTPUT)trace/beauty/syscalltbl.o: $(syscall_array)
+$(OUTPUT)trace/beauty/fsconfig.o: $(fsconfig_arrays)
+$(OUTPUT)trace/beauty/clone.o: $(clone_flags_array)
+$(OUTPUT)trace/beauty/fs_at_flags.o: $(fs_at_flags_array)
+$(OUTPUT)trace/beauty/fsmount.o: $(fsmount_arrays)
+$(OUTPUT)trace/beauty/fspick.o: $(fspick_arrays)
+$(OUTPUT)trace/beauty/ioctl.o: $(drm_ioctl_array) $(sndrv_pcm_ioctl_array) $(sndrv_ctl_ioctl_array) $(kvm_ioctl_array) $(vhost_virtio_ioctl_array) $(perf_ioctl_array) $(usbdevfs_ioctl_array)
+$(OUTPUT)trace/beauty/kcmp.o: $(kcmp_type_array)
+$(OUTPUT)trace/beauty/mmap.o: $(mmap_prot_array) $(mmap_flags_array) $(mremap_flags_array) $(madvise_behavior_array)
+$(OUTPUT)trace/beauty/mount_flags.o: $(mount_flags_array)
+$(OUTPUT)trace/beauty/move_mount.o: $(move_mount_flags_array)
+$(OUTPUT)trace/beauty/pkey_alloc.o: $(pkey_alloc_access_rights_array)
+$(OUTPUT)trace/beauty/prctl.o: $(prctl_option_array)
+$(OUTPUT)trace/beauty/renameat.o: $(rename_flags_array)
+$(OUTPUT)trace/beauty/sockaddr.o: $(sockaddr_arrays)
+$(OUTPUT)trace/beauty/socket.o: $(socket_arrays)
+$(OUTPUT)trace/beauty/statx.o: $(statx_mask_array)
+$(OUTPUT)trace/beauty/sync_file_range.o: $(sync_file_range_arrays)
+$(OUTPUT)trace/beauty/arch_prctl.o: $(x86_arch_prctl_code_array)
+
+arch_errno_name_array := $(beauty_outdir)/arch_errno_name_array.c
+arch_errno_hdr_dir := $(srctree)/tools
+arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
+
+$(arch_errno_name_array): $(arch_errno_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(arch_errno_tbl)' '$(patsubst -%,,$(CC))' $(arch_errno_hdr_dir) > $@
+
+$(OUTPUT)trace/beauty/arch_errno_names.o: $(arch_errno_name_array)
diff --git a/tools/perf/trace/beauty/arch_errno_names.c b/tools/perf/trace/beauty/arch_errno_names.c
index ede031c3a9e0..156c6537e747 100644
--- a/tools/perf/trace/beauty/arch_errno_names.c
+++ b/tools/perf/trace/beauty/arch_errno_names.c
@@ -1 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "util/env.h"
 #include "trace/beauty/generated/arch_errno_name_array.c"
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index b22890b8d272..d48d8561a7bb 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,7 +57,7 @@ create_arch_errno_table_func()
 	archlist="$1"
 	default="$2"
 
-	printf 'static arch_syscalls__strerrno_t *\n'
+	printf 'arch_syscalls__strerrno_t *\n'
 	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 0a07ad158f87..931c4a80fea9 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -35,6 +35,8 @@ bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
 bool strarray__strtoul_flags(struct strarray *sa, char *bf, size_t size, u64 *ret);
 
 struct trace;
+bool trace__show_zeros(const struct trace *trace);
+struct machine *trace__host(const struct trace *trace);
 struct thread;
 
 struct file {
@@ -265,4 +267,62 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 				    size_t (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg));
 
+extern struct strarray strarray__fsconfig_cmds;
+
+size_t syscall_arg__scnprintf_eventfd_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_EFD_FLAGS syscall_arg__scnprintf_eventfd_flags
+
+size_t syscall_arg__scnprintf_futex_op(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FUTEX_OP syscall_arg__scnprintf_futex_op
+
+size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_FUTEX_VAL3 syscall_arg__scnprintf_futex_val3
+
+size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
+
+extern struct strarray strarray__mmap_flags;
+
+size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MMAP_FLAGS syscall_arg__scnprintf_mmap_flags
+
+size_t syscall_arg__scnprintf_mremap_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MREMAP_FLAGS syscall_arg__scnprintf_mremap_flags
+
+size_t syscall_arg__scnprintf_madvise_behavior(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MADV_BHV syscall_arg__scnprintf_madvise_behavior
+
+size_t syscall_arg__scnprintf_mode_t(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MODE_T syscall_arg__scnprintf_mode_t
+
+size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_MSG_FLAGS syscall_arg__scnprintf_msg_flags
+
+size_t syscall_arg__scnprintf_perf_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PERF_FLAGS syscall_arg__scnprintf_perf_flags
+
+size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PERF_ATTR syscall_arg__scnprintf_perf_event_attr
+#define SCA_PERF_ATTR_FROM_USER(argname) \
+	{ .scnprintf	= SCA_PERF_ATTR, \
+	  .from_user	= true, }
+
+size_t syscall_arg__scnprintf_sched_policy(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SCHED_POLICY syscall_arg__scnprintf_sched_policy
+
+size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SECCOMP_OP syscall_arg__scnprintf_seccomp_op
+
+size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SECCOMP_FLAGS syscall_arg__scnprintf_seccomp_flags
+
+size_t syscall_arg__scnprintf_signum(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SIGNUM syscall_arg__scnprintf_signum
+
+size_t syscall_arg__scnprintf_socket_type(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SK_TYPE syscall_arg__scnprintf_socket_type
+
+size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_WAITID_OPTIONS syscall_arg__scnprintf_waitid_options
+
 #endif /* _PERF_TRACE_BEAUTY_H */
diff --git a/tools/perf/trace/beauty/eventfd.c b/tools/perf/trace/beauty/eventfd.c
index 4bab106213c6..18b661282834 100644
--- a/tools/perf/trace/beauty/eventfd.c
+++ b/tools/perf/trace/beauty/eventfd.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #ifndef EFD_SEMAPHORE
 #define EFD_SEMAPHORE		1
 #endif
@@ -11,7 +13,7 @@
 #define EFD_CLOEXEC		02000000
 #endif
 
-static size_t syscall_arg__scnprintf_eventfd_flags(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_eventfd_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "EFD_";
@@ -35,5 +37,3 @@ static size_t syscall_arg__scnprintf_eventfd_flags(char *bf, size_t size, struct
 
 	return printed;
 }
-
-#define SCA_EFD_FLAGS syscall_arg__scnprintf_eventfd_flags
diff --git a/tools/perf/trace/beauty/fsconfig.c b/tools/perf/trace/beauty/fsconfig.c
new file mode 100644
index 000000000000..98aa05315673
--- /dev/null
+++ b/tools/perf/trace/beauty/fsconfig.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+#include "trace/beauty/generated/fsconfig_arrays.c"
+
+DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
diff --git a/tools/perf/trace/beauty/futex_op.c b/tools/perf/trace/beauty/futex_op.c
index 00365156782b..05d2111e504b 100644
--- a/tools/perf/trace/beauty/futex_op.c
+++ b/tools/perf/trace/beauty/futex_op.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
 #include <linux/futex.h>
 
 #ifndef FUTEX_WAIT_BITSET
@@ -17,7 +18,7 @@
 #define FUTEX_CLOCK_REALTIME	256
 #endif
 
-static size_t syscall_arg__scnprintf_futex_op(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_futex_op(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "FUTEX_";
@@ -59,5 +60,3 @@ static size_t syscall_arg__scnprintf_futex_op(char *bf, size_t size, struct sysc
 
 	return printed;
 }
-
-#define SCA_FUTEX_OP  syscall_arg__scnprintf_futex_op
diff --git a/tools/perf/trace/beauty/futex_val3.c b/tools/perf/trace/beauty/futex_val3.c
index 9114f7620571..fe4e82741ffc 100644
--- a/tools/perf/trace/beauty/futex_val3.c
+++ b/tools/perf/trace/beauty/futex_val3.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
 #include <linux/futex.h>
 
 #ifndef FUTEX_BITSET_MATCH_ANY
 #define FUTEX_BITSET_MATCH_ANY 0xffffffff
 #endif
 
-static size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct syscall_arg *arg)
 {
 	const char *prefix = "FUTEX_BITSET_";
 	unsigned int bitset = arg->val;
@@ -15,5 +16,3 @@ static size_t syscall_arg__scnprintf_futex_val3(char *bf, size_t size, struct sy
 
 	return scnprintf(bf, size, "%#xd", bitset);
 }
-
-#define SCA_FUTEX_VAL3  syscall_arg__scnprintf_futex_val3
diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 3c5e97b93dd5..c8a4cd49c845 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include <linux/log2.h>
+#include "trace/beauty/beauty.h"
 
 #include "trace/beauty/generated/mmap_prot_array.c"
 static DEFINE_STRARRAY(mmap_prot, "PROT_");
@@ -8,8 +9,7 @@ static size_t mmap__scnprintf_prot(unsigned long prot, char *bf, size_t size, bo
 {
        return strarray__scnprintf_flags(&strarray__mmap_prot, bf, size, show_prefix, prot);
 }
-
-static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long prot = arg->val;
 
@@ -19,18 +19,18 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size, struct sys
 	return mmap__scnprintf_prot(prot, bf, size, arg->show_string_prefix);
 }
 
-#define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
+
 
 #include "trace/beauty/generated/mmap_flags_array.c"
-static DEFINE_STRARRAY(mmap_flags, "MAP_");
+DEFINE_STRARRAY(mmap_flags, "MAP_");
 
 static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
        return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, show_prefix, flags);
 }
 
-static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
-						struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
+					 struct syscall_arg *arg)
 {
 	unsigned long flags = arg->val;
 
@@ -40,7 +40,7 @@ static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 	return mmap__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
 }
 
-#define SCA_MMAP_FLAGS syscall_arg__scnprintf_mmap_flags
+
 
 #include "trace/beauty/generated/mremap_flags_array.c"
 static DEFINE_STRARRAY(mremap_flags, "MREMAP_");
@@ -50,7 +50,7 @@ static size_t mremap__scnprintf_flags(unsigned long flags, char *bf, size_t size
        return strarray__scnprintf_flags(&strarray__mremap_flags, bf, size, show_prefix, flags);
 }
 
-static size_t syscall_arg__scnprintf_mremap_flags(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_mremap_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long flags = arg->val;
 
@@ -60,7 +60,7 @@ static size_t syscall_arg__scnprintf_mremap_flags(char *bf, size_t size, struct
 	return mremap__scnprintf_flags(flags, bf, size, arg->show_string_prefix);
 }
 
-#define SCA_MREMAP_FLAGS syscall_arg__scnprintf_mremap_flags
+
 
 static size_t madvise__scnprintf_behavior(int behavior, char *bf, size_t size)
 {
@@ -73,10 +73,8 @@ static size_t madvise__scnprintf_behavior(int behavior, char *bf, size_t size)
        return scnprintf(bf, size, "%#", behavior);
 }
 
-static size_t syscall_arg__scnprintf_madvise_behavior(char *bf, size_t size,
-						      struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_madvise_behavior(char *bf, size_t size,
+					       struct syscall_arg *arg)
 {
 	return madvise__scnprintf_behavior(arg->val, bf, size);
 }
-
-#define SCA_MADV_BHV syscall_arg__scnprintf_madvise_behavior
diff --git a/tools/perf/trace/beauty/mode_t.c b/tools/perf/trace/beauty/mode_t.c
index 29a8fadfb7f9..9304b0bf3094 100644
--- a/tools/perf/trace/beauty/mode_t.c
+++ b/tools/perf/trace/beauty/mode_t.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -20,7 +22,7 @@
 #define S_IXUGO         (S_IXUSR|S_IXGRP|S_IXOTH)
 #endif
 
-static size_t syscall_arg__scnprintf_mode_t(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_mode_t(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "S_";
@@ -67,5 +69,3 @@ static size_t syscall_arg__scnprintf_mode_t(char *bf, size_t size, struct syscal
 
 	return printed;
 }
-
-#define SCA_MODE_T syscall_arg__scnprintf_mode_t
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index 2da581ff0c80..be7f82677cbf 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <sys/types.h>
 #include <sys/socket.h>
 
@@ -27,8 +29,8 @@
 # define MSG_CMSG_CLOEXEC	0x40000000
 #endif
 
-static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
-					       struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
+					struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "MSG_";
@@ -72,5 +74,3 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 
 	return printed;
 }
-
-#define SCA_MSG_FLAGS syscall_arg__scnprintf_msg_flags
diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 78f6566ef110..c2c7769e6595 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 9f1ed989c775..c1c7445dcff9 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+#include "util/evsel_fprintf.h"
+#include <linux/perf_event.h>
+
 #ifndef PERF_FLAG_FD_NO_GROUP
 # define PERF_FLAG_FD_NO_GROUP		(1UL << 0)
 #endif
@@ -15,8 +19,8 @@
 # define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
 #endif
 
-static size_t syscall_arg__scnprintf_perf_flags(char *bf, size_t size,
-						struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_perf_flags(char *bf, size_t size,
+					 struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "PERF_";
@@ -43,7 +47,7 @@ static size_t syscall_arg__scnprintf_perf_flags(char *bf, size_t size,
 	return printed;
 }
 
-#define SCA_PERF_FLAGS syscall_arg__scnprintf_perf_flags
+
 
 struct attr_fprintf_args {
 	size_t size, printed;
@@ -76,19 +80,14 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
 
 static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	return perf_event_attr___scnprintf((void *)arg->augmented.args->value, bf, size, arg->trace->show_zeros);
+	return perf_event_attr___scnprintf((void *)arg->augmented.args->value, bf, size,
+					   trace__show_zeros(arg->trace));
 }
 
-static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
 {
 	if (arg->augmented.args)
 		return syscall_arg__scnprintf_augmented_perf_event_attr(arg, bf, size);
 
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
-
-#define SCA_PERF_ATTR syscall_arg__scnprintf_perf_event_attr
-// 'argname' is just documentational at this point, to remove the previous comment with that info
-#define SCA_PERF_ATTR_FROM_USER(argname) \
-          { .scnprintf  = SCA_PERF_ATTR, \
-            .from_user  = true, }
diff --git a/tools/perf/trace/beauty/pid.c b/tools/perf/trace/beauty/pid.c
index 8f9c9950f8ba..cca4a3a5d9bd 100644
--- a/tools/perf/trace/beauty/pid.c
+++ b/tools/perf/trace/beauty/pid.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+#include "util/machine.h"
+#include "util/thread.h"
 
 size_t syscall_arg__scnprintf_pid(char *bf, size_t size, struct syscall_arg *arg)
 {
 	int pid = arg->val;
 	struct trace *trace = arg->trace;
 	size_t printed = scnprintf(bf, size, "%d", pid);
-	struct thread *thread = machine__findnew_thread(trace->host, pid, pid);
+	struct thread *thread = machine__findnew_thread(trace__host(trace), pid, pid);
 
 	if (thread != NULL) {
 		if (!thread__comm_set(thread))
diff --git a/tools/perf/trace/beauty/sched_policy.c b/tools/perf/trace/beauty/sched_policy.c
index 68aa59eeed8d..3fb6d9e0fae9 100644
--- a/tools/perf/trace/beauty/sched_policy.c
+++ b/tools/perf/trace/beauty/sched_policy.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <sched.h>
 
 /*
@@ -14,8 +16,8 @@
 #define SCHED_RESET_ON_FORK 0x40000000
 #endif
 
-static size_t syscall_arg__scnprintf_sched_policy(char *bf, size_t size,
-						  struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_sched_policy(char *bf, size_t size,
+					   struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SCHED_";
@@ -46,5 +48,3 @@ static size_t syscall_arg__scnprintf_sched_policy(char *bf, size_t size,
 
 	return printed;
 }
-
-#define SCA_SCHED_POLICY syscall_arg__scnprintf_sched_policy
diff --git a/tools/perf/trace/beauty/seccomp.c b/tools/perf/trace/beauty/seccomp.c
index 637722e2796b..f345c66c1bfa 100644
--- a/tools/perf/trace/beauty/seccomp.c
+++ b/tools/perf/trace/beauty/seccomp.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #ifndef SECCOMP_SET_MODE_STRICT
 #define SECCOMP_SET_MODE_STRICT 0
 #endif
@@ -6,7 +8,7 @@
 #define SECCOMP_SET_MODE_FILTER 1
 #endif
 
-static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SECCOMP_SET_MODE_";
@@ -24,14 +26,14 @@ static size_t syscall_arg__scnprintf_seccomp_op(char *bf, size_t size, struct sy
 	return printed;
 }
 
-#define SCA_SECCOMP_OP  syscall_arg__scnprintf_seccomp_op
+
 
 #ifndef SECCOMP_FILTER_FLAG_TSYNC
 #define SECCOMP_FILTER_FLAG_TSYNC 1
 #endif
 
-static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
-						   struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
+					    struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SECCOMP_FILTER_FLAG_";
@@ -51,5 +53,3 @@ static size_t syscall_arg__scnprintf_seccomp_flags(char *bf, size_t size,
 
 	return printed;
 }
-
-#define SCA_SECCOMP_FLAGS syscall_arg__scnprintf_seccomp_flags
diff --git a/tools/perf/trace/beauty/signum.c b/tools/perf/trace/beauty/signum.c
index 21220c56500a..6817e9febab9 100644
--- a/tools/perf/trace/beauty/signum.c
+++ b/tools/perf/trace/beauty/signum.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <signal.h>
 
-static size_t syscall_arg__scnprintf_signum(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_signum(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SIG";
@@ -53,5 +55,3 @@ static size_t syscall_arg__scnprintf_signum(char *bf, size_t size, struct syscal
 
 	return scnprintf(bf, size, "%#x", sig);
 }
-
-#define SCA_SIGNUM syscall_arg__scnprintf_signum
diff --git a/tools/perf/trace/beauty/socket_type.c b/tools/perf/trace/beauty/socket_type.c
index bed8d5761ca8..059e3041d338 100644
--- a/tools/perf/trace/beauty/socket_type.c
+++ b/tools/perf/trace/beauty/socket_type.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <sys/types.h>
 #include <sys/socket.h>
 
@@ -18,7 +20,7 @@
 #define SOCK_TYPE_MASK 0xf
 #endif
 
-static size_t syscall_arg__scnprintf_socket_type(char *bf, size_t size, struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_socket_type(char *bf, size_t size, struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "SOCK_";
@@ -59,5 +61,3 @@ static size_t syscall_arg__scnprintf_socket_type(char *bf, size_t size, struct s
 
 	return printed;
 }
-
-#define SCA_SK_TYPE syscall_arg__scnprintf_socket_type
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/trace/beauty/syscalltbl.c
similarity index 100%
rename from tools/perf/util/syscalltbl.c
rename to tools/perf/trace/beauty/syscalltbl.c
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/trace/beauty/syscalltbl.h
similarity index 100%
rename from tools/perf/util/syscalltbl.h
rename to tools/perf/trace/beauty/syscalltbl.h
diff --git a/tools/perf/trace/beauty/tracepoints/Build b/tools/perf/trace/beauty/tracepoints/Build
index e35087fdd108..9924ad24a6f1 100644
--- a/tools/perf/trace/beauty/tracepoints/Build
+++ b/tools/perf/trace/beauty/tracepoints/Build
@@ -1,2 +1,23 @@
 perf-y += x86_irq_vectors.o
 perf-y += x86_msr.o
+
+beauty_outdir := $(OUTPUT)trace/beauty/generated
+beauty_arch_asm_dir := $(srctree)/tools/perf/trace/beauty/arch/x86/include/asm/
+x86_arch_asm_dir := $(srctree)/tools/arch/x86/include/asm/
+
+x86_arch_irq_vectors_array := $(beauty_outdir)/x86_arch_irq_vectors_array.c
+x86_arch_irq_vectors_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh
+
+$(x86_arch_irq_vectors_array): $(beauty_arch_asm_dir)/irq_vectors.h $(x86_arch_irq_vectors_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(x86_arch_irq_vectors_tbl)' $(beauty_arch_asm_dir) > $@
+
+x86_arch_MSRs_array := $(beauty_outdir)/x86_arch_MSRs_array.c
+x86_arch_MSRs_tbl := $(srctree)/tools/perf/trace/beauty/tracepoints/x86_msr.sh
+
+$(x86_arch_MSRs_array): $(x86_arch_asm_dir)/msr-index.h $(x86_arch_MSRs_tbl)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(x86_arch_MSRs_tbl)' $(x86_arch_asm_dir) > $@
+
+$(OUTPUT)trace/beauty/tracepoints/x86_irq_vectors.o: $(x86_arch_irq_vectors_array)
+$(OUTPUT)trace/beauty/tracepoints/x86_msr.o: $(x86_arch_MSRs_array)
diff --git a/tools/perf/trace/beauty/waitid_options.c b/tools/perf/trace/beauty/waitid_options.c
index d4d10b33ba0e..78ead5df985a 100644
--- a/tools/perf/trace/beauty/waitid_options.c
+++ b/tools/perf/trace/beauty/waitid_options.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: LGPL-2.1
+#include "trace/beauty/beauty.h"
+
 #include <sys/types.h>
 #include <sys/wait.h>
 
-static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
-						    struct syscall_arg *arg)
+size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
+					     struct syscall_arg *arg)
 {
 	bool show_prefix = arg->show_string_prefix;
 	const char *prefix = "W";
@@ -25,5 +27,3 @@ static size_t syscall_arg__scnprintf_waitid_options(char *bf, size_t size,
 
 	return printed;
 }
-
-#define SCA_WAITID_OPTIONS syscall_arg__scnprintf_waitid_options
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..abc9a2926e85 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -75,7 +75,7 @@ perf-util-y += sample.o
 perf-util-y += sample-raw.o
 perf-util-y += s390-sample-raw.o
 perf-util-y += amd-sample-raw.o
-perf-util-$(CONFIG_TRACE) += syscalltbl.o
+
 perf-util-y += ordered-events.o
 perf-util-y += namespaces.o
 perf-util-y += comm.o
@@ -441,3 +441,5 @@ $(OUTPUT)%.pylint_log: %
 	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
 
 perf-util-y += $(PYLINT_TEST_LOGS)
+
+
diff --git a/tools/perf/util/bpf-trace-summary.c b/tools/perf/util/bpf-trace-summary.c
index cf6e1e4402d5..9a31dbf06cbb 100644
--- a/tools/perf/util/bpf-trace-summary.c
+++ b/tools/perf/util/bpf-trace-summary.c
@@ -6,7 +6,7 @@
 #include <stdlib.h>
 
 #include "dwarf-regs.h" /* for EM_HOST */
-#include "syscalltbl.h"
+#include "trace/beauty/syscalltbl.h"
 #include "util/cgroup.h"
 #include "util/hashmap.h"
 #include "util/trace.h"
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1e54e2c86360..20953ef7b9d8 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -635,10 +635,6 @@ const char *perf_env__arch(struct perf_env *env)
 	return normalize_arch(arch_name);
 }
 
-#if defined(HAVE_LIBTRACEEVENT)
-#include "trace/beauty/arch_errno_names.c"
-#endif
-
 const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
 {
 #if defined(HAVE_LIBTRACEEVENT)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index c7052ac1f856..739d884fc236 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -189,6 +189,7 @@ void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__arch_strerrno(struct perf_env *env, int err);
+arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
 const char *perf_env__cpuid(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
-- 
2.54.0.563.g4f69b47b94-goog

