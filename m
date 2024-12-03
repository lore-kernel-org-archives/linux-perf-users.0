Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623437FBA2;
	Tue,  3 Dec 2024 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198033; cv=none; b=DWXJSDVpt9ocQCJftPXYMIZwWMa/k8vN+aMAnsk2bJ8Ar9RBvSQ3dY6clSGV+YnapJ6d/3SdgnCHvubAVm0lZSevp4wyzZXPxZTFVOLjW0dM1j44+BH65aq1y5pqC7/GBCP3iw9s7ndkXQzF9ajuVliXfiAR5VTQWZexqQlCHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198033; c=relaxed/simple;
	bh=i+1TykJrvocX686qkNoJijuFziYBVWVJhJhg6QtaBQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n4ozeEXLDfe9cu5+v8mjADbs7nEdA2hEyL5S3ubH1QgboEvIptnOQVX5v6yo02/Lp0Ni39EqBVHBakU+SCiyFCQXAyjnmT/osdGsvljFwMpSqtLMl09j4zVvkz3v3Y5xnX8YsEllvoXHd89sBLvymijOUJp7Q9yrj6f36ZraM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gba7vAeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gba7vAeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95790C4CECF;
	Tue,  3 Dec 2024 03:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198032;
	bh=i+1TykJrvocX686qkNoJijuFziYBVWVJhJhg6QtaBQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=Gba7vAeLbz8pKkkQCMiPYYQqo97Zz2v2XTx2ftf1Pw2nGOHSsn9Ij17AhJSuxT6cz
	 nsgW+Y/IrZUGWUctdc0MYioCbrsaUXGlJW6kYhcC9UJpiUeUFu0QvLr62n3TfWL72N
	 IcyYLjg+zu/vGGSpam9EbVPaEKnJgNQimTBkOSGtlNxHQ03O8NimfQndKK6tg8v5DZ
	 pXGH356GDEh0gMM7pMOnCoLIhMKDX0uKZYM0jZUHMLQwyF5TXmcOTp2ZxgdvmyQcgL
	 7Yc4Myh7Ichs0F4yES/IOSz1s9xltPBS0WKa0VAhCmv22m3iu8Ipl3KKpqHJQY/Pb7
	 WMumf2kqSs2SA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 00/11] perf tools: Sync tools and kernel headers for v6.13
Date: Mon,  2 Dec 2024 19:53:38 -0800
Message-ID: <20241203035349.1901262-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'll carry these changes on the perf tools tree to update perf tools to
understand new syscalls and parameters.  You can refer to README file in
the tools/include/uapi directory why it's needed.

Thanks,
Namhyung


Namhyung Kim (11):
  tools headers: Sync uapi/drm/drm.h with the kernel sources
  tools headers: Sync uapi/linux/perf_event.h with the kernel sources
  tools headers: Sync uapi/linux/kvm.h with the kernel sources
  tools headers: Sync x86 kvm and cpufeature headers with the kernel
  tools headers: Sync arm64 kvm header with the kernel sources
  tools headers: Sync *xattrat syscall changes with the kernel sources
  tools headers: Sync uapi/asm-generic/mman.h with the kernel sources
  tools headers: Sync uapi/linux/fcntl.h with the kernel sources
  tools headers: Sync uapi/linux/mount.h with the kernel sources
  tools headers: Sync uapi/linux/prctl.h with the kernel sources
  perf tools: Fix build error on generated/fs_at_flags_array.c

 tools/arch/arm64/include/uapi/asm/kvm.h       |  6 +++++
 tools/arch/x86/include/asm/cpufeatures.h      | 11 ++++++--
 tools/arch/x86/include/uapi/asm/kvm.h         |  1 +
 tools/include/uapi/asm-generic/mman.h         |  4 +++
 tools/include/uapi/asm-generic/unistd.h       | 11 +++++++-
 tools/include/uapi/drm/drm.h                  | 17 ++++++++++++
 tools/include/uapi/linux/kvm.h                |  8 ++++++
 tools/include/uapi/linux/perf_event.h         | 11 +++++++-
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  4 +++
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  4 +++
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  4 +++
 .../arch/x86/entry/syscalls/syscall_32.tbl    |  4 +++
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  4 +++
 tools/perf/trace/beauty/fs_at_flags.sh        |  3 ++-
 .../trace/beauty/include/uapi/linux/fcntl.h   |  5 +---
 .../trace/beauty/include/uapi/linux/mount.h   | 14 ++++++++--
 .../trace/beauty/include/uapi/linux/prctl.h   | 27 ++++++++++++++++++-
 17 files changed, 126 insertions(+), 12 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

