Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572136C0AC
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373132; cv=none; b=bBgwOdbyHkBnpzN4oRfJ6WdMRm13uatjcgnL1voiTy/w2XCQOV54Bz4SG6bLm6G7KXMHzq1xaCUkuaw0E+g0uT81L93ayRXIF5mnjYHdDmmrLavZPtxyJh2cQSP+tp0Li0ATfA/awQP6aaii88FZYMr8B/x/QVSz2JXqCaJypxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373132; c=relaxed/simple;
	bh=wq0ygm1UaQkKzQU6Bn1qVW1wJ2KdUQoLhHF2GpuC7iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1n3dz/+wsXk4wnHOA9td9LR+SMOy78DXZvsVETO6o5tMKAhrCLgA+6gRLVG6BYKMWItUxT65qnUOkwoD8ixTlp8uGqYrwCg22ZgC+2JoQ+n0+09JDKlWC45AFmqYKWzSkibIUM00sF5/dT00xu50rANM/skBp9G5ZjDP2UjwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQDLTuaY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQDLTuaY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779373130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rB4AkqI6df+DgjjyvyZrp/tRbc8LJgJY/owNSnWRxS0=;
	b=HQDLTuaY7h+pJTZSuJVucZTuBbruTrPDiXOrl4uhrMMxJOrUt2Vz+vlhyknTqlEXQxUkDn
	jdxbsh19j+1HF96VuIiXdW7JalTYsGLwL4rSRdqI5Ee8u+EdVLiynvFrKbcjENyMGCipaG
	agA7H2Dl1WkazVR5LmuCtBUCdOL+PXM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-DRXapqMWPIW26-dlfGbikA-1; Thu,
 21 May 2026 10:18:41 -0400
X-MC-Unique: DRXapqMWPIW26-dlfGbikA-1
X-Mimecast-MFC-AGG-ID: DRXapqMWPIW26-dlfGbikA_1779373120
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4837E1955F68;
	Thu, 21 May 2026 14:18:40 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.109])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C56B1684;
	Thu, 21 May 2026 14:18:36 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2 0/6] rtla: Migrate to libsubcmd for command line option parsing
Date: Thu, 21 May 2026 16:18:27 +0200
Message-ID: <20260521141833.2353025-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

[ CC to linux-perf-users for the libsubcmd code changes ]

rtla currently uses its own implementation that uses getopt_long() to
parse command-line arguments.

Migrate rtla to use libsubcmd for command line argument parsing,
similarly to what is already done by other tools like perf, bpftool,
and objtool. Among other benefits, this allows help messages to be
generated automatically rather than having to be typed out manually
for each tool.

libsubcmd is extended with a flag to parse optarg from separate
argument if a new flag is turned on. Without the flag, the old behavior
is preserved. That keeps the parsing working for tools that use
positional arguments, and allows RTLA to keep its flexible syntax for -C
and -t options and their long variants, --cgroup and --trace-output.
Another flag is added to disable automatic definition of --no-xy for
every option --xy and vice versa, which overlaps for RTLA's --irq and
--thread options.

The new implementation is moved into a separate file, cli.c, together
with a tiny header counterpart, cli.h. This helps separate the parsing
logic, which has little in common with the rest of RTLA, in a separate
module. Another new file, cli_p.h, is used as a private header to contain
macros and static function declarations that are also used by unit tests
next to cli.c, but should not be imported from elsewhere.

Macros to generate struct option array fields for libsubcmd's
parse_args() are used to preserve the consolidation of argument parsing
code across different RTLA tools. Kernel and user threads are, as
an exception, treated as common, although they are currently implemented
for timerlat only, in line with earlier consolidation changes.

The test suite is expanded to include two levels of unit tests, one testing
the already existing tool_parse_args() functions, one tests option callbacks,
which are a new level of the CLI parser added in this patchset. This helps
to verify that no regressions are caused by this refactoring.

I expect more improvements to the code being possible in the future,
like creating macros for option groups to further deduplicate the code,
reducing the amount of extra code in the _parse_args() functions, or
implementing support for unsetting options (which is currently only
supported for those that do not use a custom callback).

v2 changes:
- Two unit test suites are added to cover regressions, after several
options were broken by the v1. The test suites cover all parsing
issues reported in the v1 as well as those found during additional
testing.
- Return value of all paths that print help, including those that
are handled in RTLA, are set to libsubcmd's help exit code of 129.
Previously, only the tool help returned 129. While some other tools
(e.g. bpftool) do that, RTLA unifies those for consistency. The return
value is also added to the corresponding section in documentation.
- Incorrect parsing of --no-irq and --no-thread is fixed using a newly
added libsubcmd option flag.
- Incorrect parsing of -n and -u timerlat options (which erroneously
required an argument in v1) is fixed.
- A now stale declaration of removed function common_parse_options()
is removed from common.h.
- Segmentation fault on abbreviated --help (e.g. --he) is fixed.
- Incorrect formatting of OPT_END macro (spurious tab) is fixed.
- All opt_* callbacks now reject unimplemented unset (--no-) correctly.
- opt_trigger_cb() and opt_filter_cb() now take only the required events
field, not the whole params structure.
- Spurious opt_osnoise_threshold_cb() which is actually just a wrapper for
opt_llong_callback() is removed.
- Old off-by-one typo is fixed in --dma-latency and -E/--entries error
messages, to make it consistent with the newly added unit tests.
- Fix a bug in Makefile that defined LIBSUBCMD_INCLUDES as -I... and then
used it as a target name: define it as the path only, and then add -I$(...)
to CFLAGS, as this is the only include path that is generated during the build
itself.

v1: https://lore.kernel.org/linux-trace-kernel/20260320150651.51057-1-tglozar@redhat.com/T

Tomas Glozar (6):
  rtla: Add libsubcmd dependency
  tools subcmd: support optarg as separate argument
  tools subcmd: allow parsing distinct --opt and --no-opt
  rtla: Parse cmdline using libsubcmd
  rtla/tests: Add unit tests for _parse_args() functions
  rtla/tests: Add unit tests for CLI option callbacks

 Documentation/tools/rtla/common_appendix.txt  |   7 +-
 tools/lib/subcmd/parse-options.c              |  63 +-
 tools/lib/subcmd/parse-options.h              |   4 +
 tools/tracing/rtla/.gitignore                 |   2 +
 tools/tracing/rtla/Makefile                   |  66 +-
 tools/tracing/rtla/src/Build                  |   2 +-
 tools/tracing/rtla/src/cli.c                  | 537 +++++++++++++
 tools/tracing/rtla/src/cli.h                  |   9 +
 tools/tracing/rtla/src/cli_p.h                | 670 +++++++++++++++++
 tools/tracing/rtla/src/common.c               | 109 ---
 tools/tracing/rtla/src/common.h               |  27 +-
 tools/tracing/rtla/src/osnoise.c              |   9 +-
 tools/tracing/rtla/src/osnoise_hist.c         | 221 +-----
 tools/tracing/rtla/src/osnoise_top.c          | 200 +----
 tools/tracing/rtla/src/rtla.c                 |  92 ---
 tools/tracing/rtla/src/timerlat.c             |   9 +-
 tools/tracing/rtla/src/timerlat.h             |   6 +-
 tools/tracing/rtla/src/timerlat_hist.c        | 317 +-------
 tools/tracing/rtla/src/timerlat_top.c         | 286 +------
 tools/tracing/rtla/src/utils.c                |  28 +-
 tools/tracing/rtla/src/utils.h                |   9 +-
 tools/tracing/rtla/tests/hwnoise.t            |   2 +-
 tools/tracing/rtla/tests/osnoise.t            |   6 +-
 tools/tracing/rtla/tests/timerlat.t           |   6 +-
 tools/tracing/rtla/tests/unit/Build           |   5 +
 tools/tracing/rtla/tests/unit/Makefile.unit   |   4 +-
 .../rtla/tests/unit/cli_opt_callback.c        | 704 ++++++++++++++++++
 .../rtla/tests/unit/cli_params_assert.h       |  68 ++
 .../rtla/tests/unit/osnoise_hist_cli.c        | 557 ++++++++++++++
 .../tracing/rtla/tests/unit/osnoise_top_cli.c | 503 +++++++++++++
 .../rtla/tests/unit/timerlat_hist_cli.c       | 702 +++++++++++++++++
 .../rtla/tests/unit/timerlat_top_cli.c        | 634 ++++++++++++++++
 tools/tracing/rtla/tests/unit/unit_tests.c    |  13 +
 33 files changed, 4566 insertions(+), 1311 deletions(-)
 create mode 100644 tools/tracing/rtla/src/cli.c
 create mode 100644 tools/tracing/rtla/src/cli.h
 create mode 100644 tools/tracing/rtla/src/cli_p.h
 delete mode 100644 tools/tracing/rtla/src/rtla.c
 create mode 100644 tools/tracing/rtla/tests/unit/cli_opt_callback.c
 create mode 100644 tools/tracing/rtla/tests/unit/cli_params_assert.h
 create mode 100644 tools/tracing/rtla/tests/unit/osnoise_hist_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/osnoise_top_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/timerlat_hist_cli.c
 create mode 100644 tools/tracing/rtla/tests/unit/timerlat_top_cli.c

-- 
2.54.0

