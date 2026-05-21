Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820F2385D86;
	Thu, 21 May 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383360; cv=none; b=bYeOK8+bnUzipGSbGnX7oRlY5lnHfF4AMmq4aScbPXCQXrCitt6+qElaajlVPP9dObgOtEOKUQ2zmLXb/dId8Z5PMbJLkqkgwA7PLQqnJ0eIlIhJv7rJAsjavJOddFsWsmoOuL3+y3GfEhDQ4l/uKRtsofdmq20WOGABz2pbDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383360; c=relaxed/simple;
	bh=k9NDHxgSRRRlUPyGXzQS7ArtVuQim0+AMrp7GVychT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AJnVet83aASNFL5Nm72EmbRZtfEdI1nhtISYDjYs4CK5x8MgHqZNdQgrmF3XpHeXji9doOeHKseGx/r25rYyC7FVlD9AzwdIi+Aau86RMMxfDaNVCMEVs1PZ5hfWt9QLvCymMm3mZoHzQ7EsBkIKPv9K7elrbEpnmtzXdWfEnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSB5juoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSB5juoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C281F000E9;
	Thu, 21 May 2026 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779383358;
	bh=N7rdurVOY81pPwP6N/Ai72Xe1ivFv8B8LDiiWJWqO3w=;
	h=Date:From:To:Cc:Subject;
	b=FSB5juoWv/iZg3fxNPROt2whTx9XCmaN9e1ykqSngY33d0wLcQjbrAv/Ce2vgDUbr
	 jMF9xd6MS87MmA68v2CD4YbhoSylov51+ocT6uAQJixkdY8MvxGhE4KgORTnGAWU65
	 5xcTxJUClQdwcAAVT5nsQsVXoXYWQ/FxefQQ54IbZ9KNfFXR4QAR4mmx4aHldcyYp8
	 xWbUmWRQF9N0hfy7VCjvoVtUbtUgDvX8YJuf5MooDozjvHGzui7bnRigyLEx4vxtqA
	 L1g7YUQyKF3hjcFL7od8x364twZIUS+NueczkXXDniDDv0FAfVUgY3js27PRRg2Oej
	 zbTNZFlfO8vfQ==
Date: Thu, 21 May 2026 14:09:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [FYI] [PATCH] merge resolution commit for perf trace beauty conflict
Message-ID: <ag88OnWBm2Ce6A2s@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just FYI, this is the merge commit solving this conflict.

Author: Arnaldo Carvalho de Melo <acme@redhat.com>
commit 86c8774ce08b931debdaa3f61f5a033639c183ca
Merge: f8d0db39bcc536ef 758c807bb943138f
    Merge remote-tracking branch 'torvalds/master' into perf-tools-next
    
    Fixup clash of:
    
      552636b9317c8a84 ("perf trace: Add beautifier script for fsmount flags")
    
    That went via Namhyung upstream and the following ones in the
    perf-tools-next tree:
    
      32969ef6e3e1979a ("perf build: Pre-generate BPF skeleton tooling during umbrella prepare phase")
      537609924c43715e ("perf trace beauty: Make beauty generated C code standalone .o files")
    
    This complements sent by Ian Rogers.
    
    Cc: Ian Rogers <irogers@google.com>
    Cc: Mark Brown <broonie@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Thorsten Leemhuis <linux@leemhuis.info>
    Fixes: f8d0db39bcc536ef ("perf build: Fix fsmount.o build")
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --cc tools/perf/Makefile.perf
index fc92d6ceac5b0c98,76b35ac19acbfb20..4ac2a0cec9ee22a2
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@@ -509,7 -508,232 +508,6 @@@ arm64-sysreg-defs-clean
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
 -fsmount_attr_arrays := $(beauty_outdir)/fsmount_attr_arrays.c
 -fsmount_attr_tbls := $(srctree)/tools/perf/trace/beauty/fsmount_attr.sh
 -
 -$(fsmount_attr_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_attr_tbls)
 -	$(Q)$(SHELL) '$(fsmount_attr_tbls)' $(beauty_uapi_linux_dir) > $@
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
--
  TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
  
  tests-coresight-targets: FORCE
diff --cc tools/perf/builtin-trace.c
index 0730c1d9f0b3adc7,48615ddccd93a1e8..2530b4035e4f57e1
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@@ -783,11 -771,10 +783,6 @@@ static const char *bpf_cmd[] = 
  };
  static DEFINE_STRARRAY(bpf_cmd, "BPF_");
  
- static const char *fsmount_flags[] = {
- 	[1] = "CLOEXEC",
- };
- static DEFINE_STRARRAY(fsmount_flags, "FSMOUNT_");
 -#include "trace/beauty/generated/fsconfig_arrays.c"
 -
 -static DEFINE_STRARRAY(fsconfig_cmds, "FSCONFIG_");
--
  static const char *epoll_ctl_ops[] = { "ADD", "DEL", "MOD", };
  static DEFINE_STRARRAY_OFFSET(epoll_ctl_ops, "EPOLL_CTL_", 1);
  
