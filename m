Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622165;
	b=SIEPk2W2ynvKYFtxNpPREx8kdhKcmAza2lBVhkbOvNk/NlFVs5QbxzggYrInho9Acn7b
	 IO0TGv1mq4JIUDiH2/kDgKijFGyxIFhdwVGAhUpX0aI0NVczPrUPyAMvniAh1P/tCQCzN
	 o9/BrJE6AU/tzRyRiz1tuP6p9JCOwXx55+wnT8/izbde688lfMLklzs+RrjQa4qtdXd9D
	 yIuQYDLQcymqHGguInUgzLAeC7cQFGsQ5pMa8eXJiEc1EmHyGDcm6vwUlCtH4CnEhGi6x
	 R2PA9ImgQ//SIR/kF32+NKdt9cXdljxwY9gTWF9Hk/nkO2XeJjindKseo/MgXjGVDbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Cpq/V+RoHAaZTDXORyra9QvqXbTu2Pgc3YLNS7j1yPw=;
	b=Mi+y/+5ir1dBhOdxnkZiwaAoliok/XOfL4B8b+agGV1CkPm9LjLFDs0GfnIi0S0Ijeo0
	 GD5gQfNqXEkgQUbCpirpzuJUlpa0f5a9evoe2M0j1xHCSK+i+4A8J0i3bSVyIGoeYS526
	 QfDC5aUeXZkIa0YrxxNvJXFmuaM9JpEkO3tsSzHMDc7Ubq+RgXkIuDWPR+dPbjN8YHQob
	 HK5ndxhV7E79BZEL1qahZvYzTXKs3DPMmp2qSKRehnyQuvjYh0wjHoyzdPf2WfvmfwcqE
	 sernvbvkz1ovUGK88ufmQX1dljVtbifx8PV6A7rXyHMNeryM7uyKIP4RdSBPU9Lm0xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPz8Onxo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B1606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPz8Onxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4231A1F000C1;
	Wed, 21 Oct 2026 22:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622165;
	bh=Cpq/V+RoHAaZTDXORyra9QvqXbTu2Pgc3YLNS7j1yPw=;
	h=From:To:Cc:Subject:Date;
	b=gPz8OnxoEv18SUQt1if1E57jYAVDld7ZgDJGTZP6IL7zz1ASzgRVjECJmb73dgrDV
	 nOj/5/Bu51F8i8zk3249Yd/Gja+LVdGyiyd5qh+dLgErESKOQ+iUmmNWGf01UqTZua
	 aIUBYXy7G+fBOfCd4y1E7ctNHcj0zUOEYInwowyqg3iaLa3iTIZsTM9FwTgOsjSIfX
	 dxK6XEFwRcy9AV35uifpx+XktXo5qrBVqeigkhcKx8kQBBN9x2EzpZEspre8Nv/RG1
	 prEp+XvTpfqmEDT1UNJnVWuePGXnN+c9GE9o25c0l1Wvh716dwmlygH06NcC8WQpQX
	 ThQK31/jgxvwA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 00/12] perf tools: Add a script to sync the header copies with the kernel sources
Date: Wed, 21 Oct 2026 19:35:39 -0300
Message-ID: <20261021223555.28372-1-acme@kernel.org>
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

As for the state of the copies, only two headers are newer in this branch
than in the kernel sources, perf_event.h and perf_regs.h: changes to them
go to tools/ first, with the kernel picking them up later, so the script
checks if the kernel file matches an earlier tools/ state and leaves
those alone.

Best regards,

- Arnaldo

What changed from v1 (e038fb24a0925576):

  PATCH 07/12, "perf beauty: Update copy of linux/socket.h with the
  kernel sources" [Mahe Tardy, <atk1cuJe3pqUvBya@gmail.com>]:

  - Added his Acked-by, no code change.

  v1 went out with just the files matching '000*.patch', which stops at
  0009, so patches 10/12 to 12/12 were never sent; they are all here now,
  sorry about that.

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



base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
v1-head: e038fb24a0925576ac82b065f32b3c72bebe4b62
