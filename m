Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739504;
	b=DkPmzfI4apX1cX/ot+UNb1aHja4A3Oc9h4cQJW/Gr3fREjRB3qTqJxk2RE74l7apleii
	 EL1/Cggfc1OHgP31ZNKH2cDylZ7jcbIMX1wN3PQoMTGzoZAosu8XsqkocJMPKPLjohjW9
	 fl2cacfetWS4ZW95dvUT5yVBDQTmA3fclLRFGJZkCsS1VubF7ySYaHNPCUuQPJ1VCWme+
	 H8TppxqFm0dtzs8aAKalU4uj2GAc3Ws4ctHk2yd17OZ20kEPpbsnxQV2zeokLRvQNnQvG
	 pa2Ugn3SBoZMZ1YQpP1aWwlZ0YIj9Da+r+roxWKU1q/0t3xI3WWmFhgNukslHeetYbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739504;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B8G1uKFyKiP0gCHFlwxtNFC+vZpLhBDRBl6/EnX/qhE=;
	b=c3T7Riuu8UmVFKJM6dbAJfoszzO6ZZ0xUD/DAP7TJORS7Nkz1vRfK/LX07NgB+ibKWKB
	 YBzLJg19EGp5sfnPFHNyjVfJCl5mQU/UBLYqBtmYJriaBqDTDNh6j5jkxSEE/qoxcrQRY
	 X/L2UFklK0Ex+hboRHUqesvEdbyFE5T9ywZN7xJyydo+1Jp2iIznco2ZOBCJDzPv1IJBg
	 CbiUHyZ4ztfWqNlhXAv2GNtIyxfMAZPWWFpKt4uVlrsYkoQ3gCqaDwdpEEFcGujz5vRru
	 l4kkqGuevoXEMu6FGCAHUwxqBw0/+J3w0qwy9WzwC+/D+SXUxZ9lBkVbo+FmNFDQvJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alcWdzZb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE4606A31A;
	Fri, 23 Oct 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alcWdzZb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1221F031E0;
	Fri, 23 Oct 2026 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739503;
	bh=B8G1uKFyKiP0gCHFlwxtNFC+vZpLhBDRBl6/EnX/qhE=;
	h=From:To:Cc:Subject:Date;
	b=alcWdzZbz1vCaET0qdmzHlgdiom83YfJGdRkUD8/sF1AxyA/jVDbYP4NdD+rItkfz
	 PaLVWd7hJZMfXp14y1GAXgAfDsf6nJz/NGhDxB2fJZ5FMUXRoEFrUgACGEL3M41V/f
	 YpOHdKVveGekSwNMX730vpwd4mxvnnSO1Hr+JaG1puX72aypdyyQ558pUEgL2+AlZp
	 EdyEyaG3oR7NsWJLwPOH3x1x+kq/TubB4x9CJhK/3hVGnPXS9YEFl6VCW0yL+FR41A
	 cAEghFgZarouc8uzYdxQXp1hxLMm8gast1mO/Slxn1gmkIRKOHehogzsMTcPoy1DS8
	 7CfDeRjADheWA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 00/11] perf tools: Enhance namespace and chroot handling 
Date: Fri, 23 Oct 2026 00:11:30 -0700
Message-ID: <20261023071141.134149-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
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

Hello,

This patchset improves namespace and chroot handling with regards to
file access.  Basically it reads the information from the proc file
system but it's only meaningful when you run the perf command on the
same machine and the target thread is still alive.

Also some file types don't need to namespace and chroot translation
because they are located in a global directory and expected to be in
the same namespace and root directory with the perf command itself.

Thanks,
Namhyung


Namhyung Kim (11):
  perf tools: Add HEADER_BOOT_ID feature
  perf tools: Add perf_env__is_same_boot()
  perf tools: Add nsinfo__new_thread() to track tid
  perf tools: Defer /proc lookup until nsinfo is used
  perf tools: Verify thread status and mount namespace inode
  perf tools: Check thread liveness when accessing /proc
  perf tools: Handle chroot inside nsinfo__mountns_enter()
  perf tools: Export filename__read_build_id_ns()
  perf tools: Remove redundant chroot handling
  perf tools: Only enter mount namespace if necessary
  perf tools: Scope mount namespace entry in dso__load()

 .../Documentation/perf.data-file-format.txt   |   5 +
 tools/perf/builtin-inject.c                   |  13 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/util/build-id.c                    |   6 +-
 tools/perf/util/capstone.c                    |   6 +-
 tools/perf/util/dso.c                         |  41 +---
 tools/perf/util/dso.h                         |  36 ++-
 tools/perf/util/dsos.c                        |  17 +-
 tools/perf/util/env.c                         |  65 +++++
 tools/perf/util/env.h                         |   3 +
 tools/perf/util/header.c                      |  28 +++
 tools/perf/util/header.h                      |   1 +
 tools/perf/util/machine.c                     |  12 +-
 tools/perf/util/namespaces.c                  | 230 +++++++++++++++---
 tools/perf/util/namespaces.h                  |  12 +
 tools/perf/util/symbol.c                      |  51 ++--
 tools/perf/util/symbol.h                      |   3 +
 tools/perf/util/thread.c                      |  39 ++-
 tools/perf/util/thread.h                      |   7 +-
 tools/perf/util/util.c                        |  31 ---
 tools/perf/util/util.h                        |   2 -
 21 files changed, 436 insertions(+), 174 deletions(-)

-- 
2.56.0.257.gf7497c7d27-goog

