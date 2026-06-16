Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06042EBBB9;
	Tue, 16 Jun 2026 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572122; cv=none; b=GYAazoMrsts79jA8aSN6KWFd84gniu/DsQFl/MesSTjx72ln+Ma22YH4VRtxwwT0D/YadDB2auPLhy2VrTLKNuqKOA0Tiy2p4JdCiRyGJ3QzB8RbpWC4QsQoxj/IO5ht7/gT2K5SIWq49OlT9z+p5WC9MOB7Qk4xgNttYv5kDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572122; c=relaxed/simple;
	bh=O6V8NWfhT2Wpfw8LeAmdFCSoOt2TFb/LJwhVMXLwy6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R1XjjVk10VPJP0Xhjo3AjjxyYYOTghvGtL5i3iNp5zzWazMR3rmi972RefGXczm4cR5+ACQug4YlGOLTweRqHRNeI5Ce4CLA/TWeelFkfRLaIcQ0gFiHgoKHdlZJvNyv3d+rxVx22FrHXAF7ml122m77u8cKNmAy3hji23fGK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqfti+5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqfti+5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947481F000E9;
	Tue, 16 Jun 2026 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572121;
	bh=hbcBSl+GwcBpqLhH2SBaTwDyQXw1m2VZ2pP7jzBHGxw=;
	h=From:To:Cc:Subject:Date;
	b=Nqfti+5zQgf9TByMw/sGYt9IpwkAoXIuUgDA2II7wfBincJ7FR4CMDDtlTFB2uXWh
	 NmQDjd2FGrPtA5NSJVtEVjDESCIN93vn0ZsFGsaRNkynUVFvK9cZaRMVs2/uKMYBG/
	 XU7I7doNuGdn2FpEhdMaeM8IqB4e1fIhYG2E5f/WUjubMyA4YBbOExCZod3rE5+A2J
	 qTY5i8Y+UR0jUGwNiZXe/bfD100eBQ5YWnDXRE+aOYtfOV2fXVwJBCyDP6edQH9m6+
	 fHklj4mSLHY/q/c2df2rpb0OU5pJ+fe01++LJusfNYEXqyJZ0eYGa0g9Nib9JfaZmt
	 K5pJ266r+CMWQ==
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
Subject: [PATCHES v3 0/9] perf tools: Fix pre-existing bugs in machine, cs-etm, c2c, bpf, and dso
Date: Mon, 15 Jun 2026 22:08:25 -0300
Message-ID: <20260616010834.37618-1-acme@kernel.org>
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

Nine more pre-existing bugs found by sashiko-bot during AI-assisted
code review.  All are independent of the perf-data-validation hardening
series — they are latent bugs in surrounding code exposed during review.

The fixes are grouped by subsystem:

machine__init() error propagation (patches 1-2):
  machine__init() always returns 0 on allocation failure because the
  error code is never propagated through the return statement.  Callers
  (including machines__init() and __machine__new_host()) proceed with a
  partially initialized machine struct.  The error cleanup also uses
  zfree() on refcounted kmaps instead of maps__zput().  Additionally,
  machines__findnew() and get_kernel_version() use sprintf() with
  unsanitized guestmount paths that can overflow PATH_MAX stack buffers.

CoreSight ETM metadata validation (patches 3-5):
  cs_etm__process_auxtrace_info_full() reads num_cpu from untrusted
  perf.data and uses it directly in a multiplication that can overflow
  to zero on 32-bit, producing a zero-sized allocation followed by OOB
  writes.  The minimum size check in cs_etm__process_auxtrace_info()
  doesn't cover the global header fields actually accessed.
  cs_etm__get_queue() indexes queue_array[] without bounds checking
  the CPU value from untrusted trace payload, and several queue
  iteration loops dereference .priv without NULL checks after array
  growth zero-initializes new entries.

c2c hist entry leaks (patches 6-7):
  When c2c_hists__init() fails, dynamically allocated format structures
  are leaked because the error path frees the container without
  unregistering them.  During resort merges, c2c_he_free() only walks
  the output-sorted tree (empty before resort), leaking all inner
  hist_entry objects from entries_in_array[] and entries_collapsed.

BPF prog info pointer validation (patch 8):
  Several functions cast bpf_prog_info u64 fields to pointers without
  checking whether bpil_offs_to_addr() actually converted the file
  offsets.  A crafted perf.data with PERF_BPIL_* bits unset but non-zero
  counts causes raw file offsets to be dereferenced as pointers.

DSO decompression errno (patch 9):
  dso__get_filename() sets errno to a negative custom DSO_LOAD_ERRNO
  value on decompression failure.  __open_dso() computes fd = -errno,
  producing a large positive value that looks like a valid fd, causing
  close_data_fd() to close an unrelated file descriptor.

Build-tested with gcc and clang.  Passes perf test on x86_64.

Changes in v3 (patch 1 only):
  - Move perf_env__init() before machines__init() in
    __perf_session__new() so the goto out_delete error path doesn't
    call perf_env__exit() on uninitialized mutexes/rwlocks
    (sashiko-bot).

Changes in v2 (patch 1 only):
  - Move dsos__init()/threads__init() before maps__new() so that
    machine__exit() is safe to call when machine__init() fails at the
    first allocation (sashiko-bot).
  - Propagate machines__init() error in aslr_tool__init(), which was
    added by the ASLR patches after v1 was written (sashiko-bot).

Arnaldo Carvalho de Melo (9):
  perf machine: Propagate machine__init() error to callers
  perf machine: Use snprintf() for guestmount path construction
  perf cs-etm: Validate num_cpu before metadata allocation
  perf cs-etm: Require full global header in auxtrace_info size check
  perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
  perf c2c: Free format list entries when c2c_hists__init() fails
  perf c2c: Fix hist entry and format list leaks in c2c_he_free()
  perf bpf: Validate array presence before casting BPF prog info pointers
  perf dso: Set standard errno on decompression failure

 tools/perf/builtin-c2c.c             |  3 ++-
 tools/perf/tests/hists_cumulate.c    |  3 ++-
 tools/perf/tests/hists_filter.c      |  3 ++-
 tools/perf/tests/hists_link.c        |  3 ++-
 tools/perf/tests/hists_output.c      |  3 ++-
 tools/perf/tests/thread-maps-share.c |  2 +-
 tools/perf/util/aslr.c               | 12 +++++++++---
 tools/perf/util/bpf-event.c          | 20 ++++++++++++++++---
 tools/perf/util/bpf-event.h          |  4 ++--
 tools/perf/util/cs-etm-base.c        |  4 +++-
 tools/perf/util/cs-etm.c             | 37 ++++++++++++++++++++++++++++++++++--
 tools/perf/util/dso.c                | 18 +++++++++++++++++-
 tools/perf/util/header.c             |  3 +--
 tools/perf/util/hist.c               |  2 +-
 tools/perf/util/hist.h               |  1 +
 tools/perf/util/machine.c            | 32 +++++++++++++++++--------------
 tools/perf/util/machine.h            |  2 +-
 tools/perf/util/session.c            |  7 ++++---
 18 files changed, 120 insertions(+), 39 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
