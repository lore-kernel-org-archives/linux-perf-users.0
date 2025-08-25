Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49B2628C;
	Mon, 25 Aug 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159148; cv=none; b=WToZSsRbB9pmndkrXnMYQo+/6jZwt+Wf2QQFQAkj49aHukPvdl1LvAq+tiX0llzp4LNkaZUcKjo5r3S4129sgf5SfsDtmWD76KG8KXQwKJbkkWX57/11dSSKU/Jm3GxAN0M6Yq7WFrXxp5UADc8Uq4/Jx3vIHjxXMuDaODrisZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159148; c=relaxed/simple;
	bh=XSgbM8+5f2YXQ6p1V1e5owDDEpJM7mdlU0NBHvmXoGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7pKjpeReN1bK0aQElRqJkEN6WgWQ2hEymuQrV2M/v3W/1tkYzh9oocQA2VM6YOm3kWf7hX9HzE2xp+FcISdVgsABga600QFaPVPcHWoSrWS0H3Snhe+fiMosgn6HFrg7lNRRTkfQ7hzFVxGTW7JhQIE0qN/15oJrdYmQ6QLcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD9GHgfg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD9GHgfg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B4FC4CEED;
	Mon, 25 Aug 2025 21:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159147;
	bh=XSgbM8+5f2YXQ6p1V1e5owDDEpJM7mdlU0NBHvmXoGA=;
	h=From:To:Cc:Subject:Date:From;
	b=GD9GHgfgSZc0X3FNKRarvVe6GpqHcwPMePI8ajBUOS5nNam4c/cSvFcrwZ1Jbjp4n
	 ua4Z/mD6rwfUc2FvFBRBPB9KJzSElqfc7wmuwzOppe5HgeyUSlMv0GxEYPM91cUmDE
	 g7RDmlsRItmzhRoYCokyRTv9ZqArPqre3v63bMuaSrtM9Y2Vppi/Z1Y4oDoKGT9BSr
	 de4veFDzXAfoe4rCbshSNW4vxsTxXj2XFLPpBsBgsDFXCcFRYOLYQDWV3PI0kCS6WL
	 VjGaS7Vig/WdljOCEzQv+6ryIhkI65d+cB427H5WjJWDJFk+VL6xgbMRe95I7/2BA/
	 8cJMYtnWFhJ8Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 00/11] perf tools: Sync kernel and tools headers for v6.17
Date: Mon, 25 Aug 2025 14:58:52 -0700
Message-ID: <20250825215904.2594216-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'll carry these changes on the perf-tools tree to update perf tools to
understand new syscalls and parameters.  You can refer to README file in
the tools/include/uapi directory why it's needed.

Thanks,
Namhyung


Namhyung Kim (11):
  tools headers: Sync KVM headers with the kernel source
  tools headers: Sync linux/bits.h with the kernel source
  tools headers: Sync linux/cfi_types.h with the kernel source
  tools headers: Sync x86 headers with the kernel source
  tools headers: Sync arm64 headers with the kernel source
  tools headers: Sync powerpc headers with the kernel source
  tools headers: Sync syscall tables with the kernel source
  tools headers: Sync uapi/linux/fcntl.h with the kernel source
  tools headers: Sync uapi/linux/fs.h with the kernel source
  tools headers: Sync uapi/linux/prctl.h with the kernel source
  tools headers: Sync uapi/linux/vhost.h with the kernel source

 tools/arch/arm64/include/asm/cputype.h        | 28 ++++++
 tools/arch/powerpc/include/uapi/asm/kvm.h     | 13 ---
 tools/arch/x86/include/asm/cpufeatures.h      | 10 ++-
 tools/arch/x86/include/asm/msr-index.h        |  7 ++
 tools/arch/x86/include/uapi/asm/kvm.h         |  8 +-
 tools/include/linux/bits.h                    | 29 ++----
 tools/include/linux/cfi_types.h               | 23 +++++
 tools/include/uapi/asm-generic/unistd.h       |  8 +-
 tools/include/uapi/linux/kvm.h                | 27 ++++++
 .../perf/arch/arm/entry/syscalls/syscall.tbl  |  2 +
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  2 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  2 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl |  2 +
 .../arch/sparc/entry/syscalls/syscall.tbl     |  2 +
 .../arch/x86/entry/syscalls/syscall_32.tbl    |  2 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 .../arch/xtensa/entry/syscalls/syscall.tbl    |  2 +
 .../trace/beauty/include/uapi/linux/fcntl.h   | 18 ++++
 .../perf/trace/beauty/include/uapi/linux/fs.h | 88 +++++++++++++++++++
 .../trace/beauty/include/uapi/linux/prctl.h   |  9 +-
 .../trace/beauty/include/uapi/linux/vhost.h   | 35 ++++++++
 tools/scripts/syscall.tbl                     |  2 +
 23 files changed, 283 insertions(+), 40 deletions(-)

-- 
2.51.0.261.g7ce5a0a67e-goog

