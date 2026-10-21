Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618220;
	b=t0zLF9/Km7lAcdWC22ugVu4oaGi8773Gp7TdKaSsyqpDQwdljPHjjESmsXrtxhy5rzdm
	 KbSMBpCFjOS/EPQKovp3ZnMkWxvrxFkjRUhwOb3I+IBUdmeoehl34ZsrSbcz43sBRazM8
	 jzw6XiPO7Aab0yFHcS8oOGNrW/tqcZaxScZyQYmYB92AHVlXSwzvBAz5qWz8YxYnPx1Vb
	 8rXbJ6toxCGsUnswzZZ2a+eavVy2ovv62o/0v1l2ty1ltHde04gah0G/db+6Zgjs5S3fv
	 3857nQS6oCe2gzmBGlQvipNkB3pkX3SQketLf6PtpFadi75O0oiCL8MQpA2P2Y8rBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618220;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WPw28dfRXeTVxbOZb7+owbVEk5wOHw5m37JMTo4jBjI=;
	b=I6oKDET1XZ3AXnNdJhpiGvFG9XoIkeQPyubOShski3RGld5qDqDEdJGtJKIf5LQaBBSr
	 iNoJbqJbPew8xFowlvZLY489JONEaehQVCKxwASroRVeU3dQ7/ZGrvCvOd3wCDqH830KN
	 D7enQSp/ekPXJsJp7QRhCXX2AZfckSjKGRewCRtjtkM2V5vixI+DdctWrN92nRUURubUm
	 2Rg7IJgcflvHzt3FSmkfzftCknvIxonw2wwX/rDrkjAyBDgsc3Hv7rgpYgboI5+HoaijC
	 pbv6UaBTl9pJc2bIX6vvkU25ag8vgGVXcnFYtskhA940wMb2+IYjTXLTemq2qFJuQGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EN3fGuUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D963606A31A;
	Wed, 21 Oct 2026 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EN3fGuUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19E1F000C1;
	Wed, 21 Oct 2026 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618220;
	bh=WPw28dfRXeTVxbOZb7+owbVEk5wOHw5m37JMTo4jBjI=;
	h=From:To:Cc:Subject:Date;
	b=EN3fGuUSbmKMQevJO+mnyHwfj5Su/JI3Ug1/nHhVoDKMPCtpPtR5tg4H2cDZB6feb
	 l54ctDZZyJfwBurIU46qsmr+OsLSxLZej/yDfPawrk1u7YLGcfIsNHYA7QI/LyQGT+
	 arLeRz/A4wNfcMwpURjYe8JHve40x6VzmBWFwe/5gphLHqDuQSeVjVtnuLsG6BI95H
	 jKu9dptGszz6sA+Hbmb4Fj2hCKu9hh6BKe8ixo8H1FrBexRaJtF56q2HucgP3fAJAe
	 DFawBYkJKThri6vHTfxwsd8eKWzB4a23y5Ru2WCzQTORADvHSqTU7SD451UQIBXe7w
	 jcFvwCR/Eoa3w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Christian Brauner <brauner@kernel.org>,
	Congkai Tan <congkai@amazon.com>,
	Ewan Hai-oc <ewanhai-oc@zhaoxin.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kir Kolyshkin <kolyshkin@gmail.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuyang Huang <sigefriedhyy@gmail.com>
Subject: [PATCH v1 00/12] perf tools: Add a script to sync the header copies with the kernel sources
Date: Wed, 21 Oct 2026 18:29:54 -0300
Message-ID: <20261021213007.21046-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The tools/ tree carries copies of kernel headers that are refreshed by
hand: check-headers points at the stale ones, then one looks up the
kernel commits that changed each of them, pastes the relevant bits into
the commit message, regenerates the beauty string tables, builds the
consumers and commits, one header at a time.

This adds tools/perf/scripts/sync-headers.sh, also available as 'make -C
tools/perf sync-headers', and patches 2-12 are what it produced for this
branch: for each stale header it finds the kernel commits since the last
sync, copies the file, runs the beauty scripts before and after for the
beauty copies, builds perf and the other consumers of the header and
creates a commit in the usual format, grouping the headers that share a
consumer, as with the KVM ones.

As for the state of the copies, only two headers are newer in this branch than
in the kernel sources, perf_event.h and perf_regs.h: changes to them this time
went to tools/ first, with the kernel picking them up later, so the script
checks if the kernel file matches an earlier tools/ state and leaves those
alone.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (12):
  perf tools: Add script and make target to sync the header copies with
    the kernel
  tools headers UAPI: Sync linux/if_addr.h with the kernel sources
  tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
  tools headers: Sync linux/gfp_types.h with the kernel sources
  tools headers x86 cpufeatures: Sync with the kernel sources
  tools arch x86: Sync the msr-index.h copy with the kernel sources
  perf beauty: Update copy of linux/socket.h with the kernel sources
  tools headers: Sync UAPI linux/fcntl.h with the kernel sources
  tools headers: Sync UAPI linux/fs.h with the kernel sources
  tools headers: Sync UAPI linux/mount.h with the kernel sources
  tools headers: Sync UAPI sound/asound.h with kernel sources
  tools headers: Sync KVM headers with the kernel sources

 tools/arch/arm64/include/uapi/asm/kvm.h       |    1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h     |   18 +
 tools/arch/x86/include/asm/cpufeatures.h      |   15 +
 tools/arch/x86/include/asm/msr-index.h        |    9 +-
 tools/include/linux/gfp_types.h               |    5 +-
 tools/include/uapi/linux/if_addr.h            |    1 +
 tools/include/uapi/linux/kvm.h                |    4 +
 tools/include/uapi/linux/rtnetlink.h          |   25 +
 tools/perf/Makefile                           |    5 +-
 tools/perf/Makefile.perf                      |    3 +
 tools/perf/scripts/sync-headers.sh            | 1256 +++++++++++++++++
 .../perf/trace/beauty/include/linux/socket.h  |   11 +-
 .../trace/beauty/include/uapi/linux/fcntl.h   |    1 +
 .../perf/trace/beauty/include/uapi/linux/fs.h |    1 +
 .../trace/beauty/include/uapi/linux/mount.h   |    1 +
 .../trace/beauty/include/uapi/sound/asound.h  |  200 +--
 16 files changed, 1452 insertions(+), 104 deletions(-)
 create mode 100755 tools/perf/scripts/sync-headers.sh

base-commit: 9b435ebe2ddd69af06e6d0bbe52c590179b1ff9f
