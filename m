Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E6396B8E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019233; cv=none; b=c9CMYblakKHhj+yDegP+b4A+xfZS8gCFahGXlhoROA8Y+siTzpwpnl/H1mvxXxcS+Iv31zoUWTTsMHpSM7KW4CG+CcpNuGxQpsj9DjZGaoPjPhdBU8sdVgNX7lbdqJV7scNpFzzm9UnebZ3SieTcnZ/E4jKDiQvzIWBbxPLzKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019233; c=relaxed/simple;
	bh=9NJhvnMb2WzoR+1Xqcml2CCcX3ljBfMGnAluGqdBIHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KkmyYaORXpO13zbvsYCvMCbD6Qr63DmtPp/+TXbmryGDswtY9Yay3wgOOxmNEzweILX345hkb7XCdzD6QxhM69u4B4rNBPXX2FpZmOpYVFJkcoy5LWpfood/Un+8WCaIMAi+LBXHTXtZkbJdrBG5QJJy7WQrg+5HbDiUCp9Zj70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7VPTBbv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7VPTBbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774019230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yX54CfA8Z4/s2Z7zgrl9bkBwpnQ0SIfZEsoNAvqWGy8=;
	b=E7VPTBbvSsavKy0fEl97+D9Y5c3a2eQalp1EDNy8kVPVSvwzgE4gWwi4UGSvpN5pk7qov9
	lS2m1Dgp6Ez7+VZ1PsjmUbrYZBIsBz1mdOH59fRzsSw+lA2wuH3WloGsSDt0A1tDyjwZDQ
	GFBTBdMyKVHj1JPJ2YuDw0Qw/Ml5UMM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-Od-XMuRvMXWs3aQ2hbdRYQ-1; Fri,
 20 Mar 2026 11:07:06 -0400
X-MC-Unique: Od-XMuRvMXWs3aQ2hbdRYQ-1
X-Mimecast-MFC-AGG-ID: Od-XMuRvMXWs3aQ2hbdRYQ_1774019223
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B57D219560AB;
	Fri, 20 Mar 2026 15:07:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C084E30001A1;
	Fri, 20 Mar 2026 15:06:59 +0000 (UTC)
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: [PATCH 0/3] rtla: Migrate to libsubcmd for command line option parsing
Date: Fri, 20 Mar 2026 16:06:48 +0100
Message-ID: <20260320150651.51057-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

[ CC to linux-perf-users for the libsubcmd code change (second commit) ]

rtla currently uses its own implementation that uses getopt_long() to
parse command-line arguments.

Migrate rtla to use libsubcmd for command line argument parsing,
similarly to what is already done by other tools like perf, bpftool,
and objtool. Among other benefits, this allows help messages to be
generated automatically rather then having to by typed out manually
for each tool.

libsubcmd is extended with an option to parse optarg from separate
argument if a new flag is turned on. Without the flag, the old behavior
is preserved. That keeps the parsing working for tools that use
positional arguments, and allows RTLA to keep its flexible syntax for -C
and -t options and their long variants, --cgroup and --trace-output.

The new implementation is moved into a separate file, cli.c, together
with a tiny header counterpart, cli.h. This helps separate the parsing
logic, which has little in common with the rest of RTLA, in a separate
module.

Macros to generate struct option array fields for libsubcmd's
parse_args() are used to preserve the consolidation of argument parsing
code across different RTLA tools. Kernel and user threads are, as
an exception, treated as common, although they are currently implemented
for timerlat only, in line with earlier consolidation changes.

I expect more improvements to the code being possible in the future,
like creating macros for option groups to further deduplicate the code,
or reduce the amount of extra code in the _parse_args() functions.

Tomas Glozar (3):
  rtla: Add libsubcmd dependency
  tools subcmd: support optarg as separate argument
  rtla: Parse cmdline using libsubcmd

 tools/lib/subcmd/parse-options.c       |   53 +-
 tools/lib/subcmd/parse-options.h       |    1 +
 tools/tracing/rtla/.gitignore          |    1 +
 tools/tracing/rtla/Makefile            |   53 +-
 tools/tracing/rtla/src/Build           |    2 +-
 tools/tracing/rtla/src/cli.c           | 1207 ++++++++++++++++++++++++
 tools/tracing/rtla/src/cli.h           |    7 +
 tools/tracing/rtla/src/common.c        |  109 ---
 tools/tracing/rtla/src/common.h        |   26 +-
 tools/tracing/rtla/src/osnoise_hist.c  |  221 +----
 tools/tracing/rtla/src/osnoise_top.c   |  200 +---
 tools/tracing/rtla/src/rtla.c          |   89 --
 tools/tracing/rtla/src/timerlat.h      |    4 +-
 tools/tracing/rtla/src/timerlat_hist.c |  317 +------
 tools/tracing/rtla/src/timerlat_top.c  |  285 +-----
 tools/tracing/rtla/src/utils.c         |   28 +-
 tools/tracing/rtla/src/utils.h         |    9 +-
 tools/tracing/rtla/tests/hwnoise.t     |    2 +-
 18 files changed, 1331 insertions(+), 1283 deletions(-)
 create mode 100644 tools/tracing/rtla/src/cli.c
 create mode 100644 tools/tracing/rtla/src/cli.h
 delete mode 100644 tools/tracing/rtla/src/rtla.c

-- 
2.53.0

