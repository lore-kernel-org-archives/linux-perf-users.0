Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693482;
	b=m5C8J03y8x2j5I0cqwE24e1lwKI5DAIpPWZKTcQgOxan3fZa31PCgC7ATvj737euFX2N
	 A114ZL+1mnRw9tninCZiuAy4bTl6UGjq7BnuDBcLMQUeopunAXJs3OWGWJKlNag9Vdgob
	 4J9hpSpTiUnDw44E+Qo1ZQwztNaV0TCW87mY0MBPOWggkMyo7lmYNp1u06J2RHO6HO61c
	 3uF6MKTbkIzsQtuYuOocIcZJ4WvM6cPtNDE8vhilnBuaTkyqcUl5Jlt8JvRKPt7aP7Qb6
	 fqxOp9rHLKX6C7FphvKddyYF6oV+BXPlcUG7wHv6Vk9qR2QVxltjPdSH1W8oDqnUUsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0q5daHZWV+XT4wSwCmjzN5FmswVZxnNepsuZ1zSLX+w=;
	b=rs/jKRRQDKHI89DxzP0hUK84V+nwF9f+8nSb9NAPYgRy9aeNUlVdod8pF2hXwFLTTFJi
	 YYgVQ/Ef/swReOBCdYshowPnaR0vQThaGJYuYm1Uc37K068q9EOUwE28+Ht52Bu6lHJcf
	 /hsKWV6aJsZ54wh87/pvyMSfQrKffBJjegLpBcENLU0tIpxIJWcSvYCIQdXU6RMNL356B
	 j3G4ITXNMcLKikr7g/U5ZFNvyhwu9CJ3Ugh5fjorPaHqv8Qx9RYEvS4JlCvPkdq2AdDpp
	 YwcydT1Aj3j8ggHUAv4dydbJue8ZwzH0LbnnTYv4CzfmXSLUn3zSYyrq2cdC+iQwT0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBGSv5Rz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5C606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBGSv5Rz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF63E1F01825;
	Thu, 22 Oct 2026 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693482;
	bh=0q5daHZWV+XT4wSwCmjzN5FmswVZxnNepsuZ1zSLX+w=;
	h=From:To:Cc:Subject:Date;
	b=VBGSv5RzdMuY1VAKJ7MpgATK5W9ZN22sLgCnl1zCxRKlGkDPX4S8YuW4aEMecPXaM
	 IGmxmhhmo6K/7cOkM3d8+p4IcQphbt40z5d013UwSTczhExFDY05cUq5Qo6HzBFzhh
	 fz6uKbP6rzk3phogCbnf6EO86CxEysB6XPDPEmE0SzD9AZ1A/FV3skDAGI0pQSYy+4
	 azi2vmdSpRtm+Qj/4jNWmrbf6eVhcvECHOsAXkZqDj+d3fa0FvD/pDdGGeWnwi/dhJ
	 Kqa7/jDZ0RQK5jTNlwFHzeErCQt4o6RDUYwuRXq46D2TFzgNEchheHCbPFa5NBnGWH
	 2Osisk/vOqhqA==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Christian Brauner <brauner@kernel.org>,
	Congkai Tan <congkai@amazon.com>,
	Ewan Hai-oc <ewanhai-oc@zhaoxin.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Kir Kolyshkin <kolyshkin@gmail.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuyang Huang <sigefriedhyy@gmail.com>
Subject: [PATCH v3 00/10] perf tools: Add a script to sync the header copies with the kernel sources
Date: Thu, 22 Oct 2026 15:24:19 -0300
Message-ID: <20261022182431.25673-1-acme@kernel.org>
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
tools/perf sync-headers', and patches 2-10 are what it produced for this
branch: for each stale header it finds the kernel commits since the last
sync, copies the file, runs the beauty scripts before and after for the
beauty copies, builds perf and the other consumers of the header and
creates a commit in the usual format, grouping the headers that share a
consumer, as with the KVM ones.

The kernel is the source of truth, but a sync is skipped when only the
tools/ copy changed or when the copy carries intentional edits, and when
both sides have content the other lacks it stops for a manual look (as
with gfp_types.h and msr-index.h, left out of this series for manual
handling); '--force' can then sync and record in the commit the tools/
additions that are dropped.

As for the state of the copies, only two headers are newer in this branch
than in the kernel sources, perf_event.h and perf_regs.h: changes to them
go to tools/ first, with the kernel picking them up later, so the script
sees that only the tools/ copy changed since the last sync and leaves
those alone.

Best regards,

- Arnaldo

What changed from v2 (593c116cb5ff1ea4):

  - 10 patches: the gfp_types.h and msr-index.h syncs are left out for a
    manual investigation.
  - A tools/ copy ahead of the kernel is left alone; a copy that diverged
    stops for a manual look, --force lists the tools/ lines it drops (sashiko).
  - Copies with intentional edits are not synced: their kernel commits and
    Cc list are printed for a manual sync (sashiko).
  - Beauty scripts taking an output file are run with a temp file, and the
    script/header mapping comes from the Build files (sashiko).
  - Merges that brought content of their own since the last sync are
    credited, e.g. a capability renumbered to avoid clashing with another.
  - PATCH 04/10, 05/10 and 09/10 have new subjects; 05/10 keeps Mahe
    Tardy's Acked-by.

What changed from v1 (e038fb24a0925576):

  - PATCH 05/10 (was 07/12) carries Mahe Tardy's Acked-by, no code change.
  - v1 was posted with only the files matching '000*.patch', which stops at
    0009, so 10/12 to 12/12 were never sent.

Arnaldo Carvalho de Melo (10):
  perf tools: Add script and make target to sync the header copies with
    the kernel
  tools headers UAPI: Sync linux/if_addr.h with the kernel sources
  tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
  tools arch x86: Sync the cpufeatures.h copy with the kernel sources
  tools headers: Sync linux/socket.h with the kernel sources
  tools headers: Sync UAPI linux/fcntl.h with the kernel sources
  tools headers: Sync UAPI linux/fs.h with the kernel sources
  tools headers: Sync UAPI linux/mount.h with the kernel sources
  tools headers: Sync UAPI sound/asound.h with the kernel sources
  tools headers: Sync KVM headers with the kernel sources

 tools/arch/arm64/include/uapi/asm/kvm.h            |    1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   18 +
 tools/arch/x86/include/asm/cpufeatures.h           |   15 +
 tools/include/uapi/linux/if_addr.h                 |    1 +
 tools/include/uapi/linux/kvm.h                     |    4 +
 tools/include/uapi/linux/rtnetlink.h               |   25 +
 tools/perf/Makefile                                |    5 +-
 tools/perf/Makefile.perf                           |    3 +
 tools/perf/scripts/sync-headers.sh                 | 1676 ++++++++++++++++++++
 tools/perf/trace/beauty/include/linux/socket.h     |   11 +-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |    1 +
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |    1 +
 tools/perf/trace/beauty/include/uapi/linux/mount.h |    1 +
 .../perf/trace/beauty/include/uapi/sound/asound.h  |  200 +--
 14 files changed, 1867 insertions(+), 95 deletions(-)
 create mode 100755 tools/perf/scripts/sync-headers.sh

base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
v2-head: 593c116cb5ff1ea4
v1-head: e038fb24a0925576ac82b065f32b3c72bebe4b62
