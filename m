Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149F6EB7C;
	Fri,  6 Sep 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652228; cv=none; b=HhYw3remShbnfis12aBLJlnS27lbq1MFJEU1xwGEiBam5ny7qPSptO6W1SNRhaG8LT14ch/BFD91RmbCBtNIJ3PbSSeeHNXSuRQYBENRDelnZRPUZE/V0D7rDGFHnxaWyj3H1YpqDBIReKRTegV0dt9QwZvu1mQ8De06My3m9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652228; c=relaxed/simple;
	bh=+0rvTR6As1EkOBNin/ToxockoK5ir2C06ATLrbPoXso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn7CasVRaGq1JjvEHxtUjJxkzh9g9rscAiH/X1FNZZuuNkVkl3OvMDHHa0GZuOsJ5QmQDualr9SNX3SyNUyV4i+bwmdnX9fdVLwIw5SEspHlTUr34OOjNyg1ITxYaVNS95SZr8VGRH/v/rHCPjEaLLnbgND4reBuUa58R2yhTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj9cfqPh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj9cfqPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B6BC4CEC4;
	Fri,  6 Sep 2024 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725652227;
	bh=+0rvTR6As1EkOBNin/ToxockoK5ir2C06ATLrbPoXso=;
	h=From:To:Cc:Subject:Date:From;
	b=lj9cfqPhy0acNXN1iK6bJ4nOw2ZsKB66j6nu2lxZaQ20/se+l4g6pbJHPoDxFUZRK
	 QIiRrDvDlyifAxSLXeUef64V8RoYc/BzWesEThebB+XoMbETkJFFYUXTXlM98/M92E
	 L4vaNHfs0swGUhpX3dI42lVXOComZFcXZGRDbznIb1y8bEvxJPSAJ2pEINHEEnMbe4
	 YLxNuVmWSxsXgD1xW5Fpc+qZsIStJFydbF8DIRg53uZx49FIQHNmMbi0P4557Kl59v
	 s9jNQuTdGHEyX+7cRWYOkc03WrrSd75mUHWNEQlG2EDWQL6QhWMMWEPZpYqT8SB2Fd
	 Db+zyYvJkXC7A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH RFC 0/2] Prep perf trace for a generic BPF+BTF pretty printer
Date: Fri,  6 Sep 2024 16:50:18 -0300
Message-ID: <20240906195020.481841-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	This is an attempt at paving the way for the remaining parts of
Howard's work on this years GSoC to be merged, as we want to keep the
existing pretty printers for the few structs we have, that have special
characteristics (see the commit logs) while having the generic BPF + BTF
collector/pretty printer, using the libbpf BPF dumper (see more ideas on
the commit log on how to improve it, maybe even getting
tools/perf/trace/beauty/ into tools/lib/beauty/ to get reused by
libbpf).

	I plan to work on the weekend to plugging his latest series on
top of these patches so that we can get it merged in the next merge
window.

	Any comment/test is more than welcome,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf trace augmented_syscalls.bpf: Move the renameat augmenter to
    renameat2, temporarily
  perf trace: Use a common encoding for augmented arguments, with size +
    error + payload

 tools/perf/trace/beauty/perf_event_open.c     |   2 +-
 tools/perf/trace/beauty/sockaddr.c            |   2 +-
 tools/perf/trace/beauty/timespec.c            |   2 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 108 +++++++++++-------
 4 files changed, 68 insertions(+), 46 deletions(-)

-- 
2.46.0

