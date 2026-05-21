Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62313383982;
	Thu, 21 May 2026 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382176; cv=none; b=Peb0a0LeAHHNlFbZmWBsOIYZ9qxcyH8LgrohVraJ1Zqsv2Y41yNxIgTz++0bMA8NKkKCzT3R8SYMr1kmv3yIpZvcxZ2nODeNROlhPNrhIjMHcGFybHQPF9nkrciXA9pnu+5vXS31HERZR1myj4NSFabvdaNk4va3PHaQT6ICstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382176; c=relaxed/simple;
	bh=uwIa0Z/ok4zc2TAdzNwVt3NEcQIHZ6z91FWezO15WdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vv2voWX8aYZ0/Ru4knvhboa+SRQ6eMtizaDA9YRx7cvOAwbHV3i7gR2NEHCldvR/cc6+qMADSIiBnm2OCO69ua9iiqlKHxb4a2gY0Lh1k+o6ffN3woyqMiMcFcBI5XXqmQRys1hNY6VJ4HILwjcbL+gNVe6ho1wmjeo3uTFpc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj5Gznu+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj5Gznu+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9681F000E9;
	Thu, 21 May 2026 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779382173;
	bh=zcenPJOvfJLDezljSJNclDrIU4pp2pyRhFZrVvbE1kk=;
	h=Date:From:To:Cc:Subject;
	b=Bj5Gznu+vAFsARABlgaKf/OHi2GZWGW22hJjbC2gJsJxir8Xn4ocwoQnS7+M7Nlfh
	 XCRNaFXnilDHAWSRGr9X4jLBoMlx7SbGma2oFqMAk4NqD0HAnu4AeepmiI4pVyRpKA
	 aiESz2+jIxM1lAaCvja81pHTdszHJUWuicplTxYjm7/2N2Impaxrzl7mdJzw/kznaV
	 febdlsJiB868tiI/zd/ay+2DIK0XEuT00tSRKOgRlySAdbnsLvr/aA6UbzxPHgJwyT
	 0j6MMnxY9wyKzhgRY4SJNqGbII+9IdKEnsp7fT+XRaKrTKc/KUydsMoc93SzvjXvrF
	 YuIA6PFk7Wiyw==
Date: Thu, 21 May 2026 13:49:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
	Mark Brown <broonie@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf build: Fix fsmount.o build
Message-ID: <20260521153558.1421014-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> A merge conflict between:
> commit 552636b9317c8 ("perf trace: Add beautifier script for fsmount flags")
> commit 32969ef6e3e19 ("perf build: Pre-generate BPF skeleton tooling during umbrella prepare phase")
> Resulted in a missed build dependency in the merge:
> commit 61da860eee07 Merge branch 'perf-tools-next' of https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

> Fix the build by adding the necessary build dependencies.

This is not enough, after applying this I still get a conflict when
merging torvalds/master into perf-tools-next, working on it now.

And yeah, my bad, I should've test merged this before pushing out
perf-tools-next to avoid this issue.

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/r/20260521153558.1421014-1-irogers@google.com
> Cc: arnaldo.melo@gmail.com
> Cc: broonie@kernel.org
> Cc: namhyung@kernel.org
> Cc: linux@leemhuis.info
> Cc: acme@redhat.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-next@vger.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
> tools/perf/trace/beauty/Build | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
> index 93cde93461a3..996e63cdf765 100644
> --- a/tools/perf/trace/beauty/Build
> +++ b/tools/perf/trace/beauty/Build
> @@ -111,6 +111,13 @@ $(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
> 	$(call rule_mkdir)
> 	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
> 
>+fsmount_attr_arrays := $(beauty_outdir)/fsmount_attr_arrays.c
>+fsmount_attr_tbls := $(srctree)/tools/perf/trace/beauty/fsmount_attr.sh
>+
>+$(fsmount_attr_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_attr_tbls)
>+	$(call rule_mkdir)
>+	$(Q)$(call echo-cmd,gen)$(SHELL) '$(fsmount_attr_tbls)' $(beauty_uapi_linux_dir) > $@
>+
> fspick_arrays := $(beauty_outdir)/fspick_arrays.c
> fspick_tbls := $(srctree)/tools/perf/trace/beauty/fspick.sh
 
>@@ -285,7 +292,7 @@ $(OUTPUT)trace/beauty/syscalltbl.o: $(syscall_array)
> $(OUTPUT)trace/beauty/fsconfig.o: $(fsconfig_arrays)
> $(OUTPUT)trace/beauty/clone.o: $(clone_flags_array)
> $(OUTPUT)trace/beauty/fs_at_flags.o: $(fs_at_flags_array)
>-$(OUTPUT)trace/beauty/fsmount.o: $(fsmount_arrays)
>+$(OUTPUT)trace/beauty/fsmount.o: $(fsmount_arrays) $(fsmount_attr_arrays)
> $(OUTPUT)trace/beauty/fspick.o: $(fspick_arrays)
> $(OUTPUT)trace/beauty/ioctl.o: $(drm_ioctl_array) $(sndrv_pcm_ioctl_array) $(sndrv_ctl_ioctl_array) $(kvm_ioctl_array) $(vhost_virtio_ioctl_array) $(perf_ioctl_array) $(usbdevfs_ioctl_array)
> $(OUTPUT)trace/beauty/kcmp.o: $(kcmp_type_array)
-- 
2.54.0.746.g67dd491aae-goog

