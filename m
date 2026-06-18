Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996CC3FAE15;
	Thu, 18 Jun 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795774; cv=none; b=H/qI7rWioTnta9LWCN9HHGEZUyJ396U0HYR0GdER0epfjPkGJASdmC3a4vy8ITI1hlQfUGYBcTUzj3b3PN+3C9KJMqr1rJ7KOKMBxIGqmnsS33paOA7OzTkD0tktRBtXFK3C56k/Z2+j3CCRf5AYAe896h8k58V/jtaKds8qlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795774; c=relaxed/simple;
	bh=FmOIrX5js7gAqgxIwvaP23T4wBf167hZFc0Tl5x6Dy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdVj4x56gV2UamsIS9SByYDznRCj56iN7mxwps8axuaW1peI27iEyOMF+wHQUM0VxbZJfKXbwxzDxUJ+CwR+UIn+mTKJafNaKI5H15r4GtqwpXsfDYe54AvCfKbOfTZM50fZOsq+N1dsJBGEZUU0pL3GgOF9slIxBkhh5YC5CzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6rmt6dU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6rmt6dU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA501F000E9;
	Thu, 18 Jun 2026 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795773;
	bh=2wbzwmomZ+c6gFsadwCg2Vl0CDt2tKqDizxnflKBZoA=;
	h=From:To:Cc:Subject:Date;
	b=U6rmt6dUv4VAdxURh+9nYra+MwSFx44Na5j7U1Q8JcUdmxl1XMCrV2MtqvKKNQ9v/
	 Q0y5i1WzHD7rcM+smBucYemqurOFVZRBQHuMNkv58Mdv+VYCH0U/JiBBc18k1Km67l
	 b0JDROGNTfSKtVxHOwGSa8AFq6/mbjEraa1qJfcYkmwegQhb4B/KzhTYLC36og1e1R
	 Xg+Qbi0Z7TyERbOBUqzR9Rw/bHnyhmWCOwfpsfiu1zA7VR4yoqCLaB5PqXeeLFt/eu
	 6s89p+hllHp2qDS2MEsl8pNEatIj2xUdZq/fOxqs6mpySD44CaydOCGiIg6uLs+u1U
	 vkLhpte6r9VGQ==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v2 0/7] Initial support for some Rust tags + way to ask for CU merging at load time
Date: Thu, 18 Jun 2026 12:15:59 -0300
Message-ID: <20260618151606.82747-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

        Here is a series with some initial support for some Rust DWARF
tags and a way to ask for CUs to be merged just like we do for LTO to
cope with inter CU tag references.

        This makes one of the regression tests to pass again as perf now
has some rust source files and thus Rust CUs in a perf binary built with
DWARF, which is used to test pahole's pretty printing features, where it
uses the DWARF in a perf binary to decode perf.data records.

	Now this is implemented as --features=force_cu_merging,
following a suggestion from Alan, so that we can ask for this, that
albeit not optimal is a way to handle Rust and other cases that may need
this CU merging approach while we don't have something that works in
parallel as without this option.

- Arnaldo

Arnaldo Carvalho de Melo (7):
  dwarf_loader: Initial support for DW_TAG_variant_part
  dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag
    references
  dwarf_loader: Initial support for DW_TAG_subprogram in
    DW_TAG_enumeration
  encoders: Fix diagnostic messages for unexpected tags in enumerations
  dwarves_fprintf: Accumulate function__fprintf return value in
    enumeration printing
  dwarves: Use tag__delete for enumeration children
  btf_encoder: Remove unused variables

 btf_encoder.c               | 17 ++++++----
 ctf_encoder.c               | 16 ++++++---
 dwarf_loader.c              | 67 +++++++++++++++++++++++++++++++------
 dwarves.c                   | 35 +++++++++++++++----
 dwarves.h                   | 19 ++++++++++-
 dwarves_emit.c              | 10 +++---
 dwarves_fprintf.c           | 44 +++++++++++++++++-------
 man-pages/pahole.1          | 17 ++++++++--
 pahole.c                    | 20 ++++++++---
 tests/prettify_perf.data.sh |  4 +--
 10 files changed, 195 insertions(+), 54 deletions(-)

-- 
2.54.0

