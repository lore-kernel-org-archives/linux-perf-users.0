Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1151198A2A;
	Fri, 16 Aug 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805919; cv=none; b=Pjm5MMgs07XE9xKNFf2Q6/RCDzyvVkcealTm72vZYODwOXzyJPj8uSS7azQk7Hvlq0Z16cWAPGifW/WwD5nPuqZbqNJgFkXfuoO+NmYGf0ATFh8OlFviKWjOyRA1PNExwnusbkpYfyOfjDkCiQusf3QELFgRLmII7DFNmtii4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805919; c=relaxed/simple;
	bh=5MKMiHqNYxOWYkERmuriknP4XxB271ms588YEXuYO9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BeNPoRQGMNV2IU37b19UM0yOvF+ENpMmDosmNz10uI5qcTE9Dpe3VqlQw9oDng4fWxoX+Gz5hXyj2b5hTDFwBXeE99ixDFmVfNzlq80ncle2j49F6kaRXp4PIwisBgzdmOoF1jrmyy/FIlKgqTU7Jdo//kxfKxgoU285rWYv1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wlf4309Sxz1S82c;
	Fri, 16 Aug 2024 18:53:39 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id E5471180019;
	Fri, 16 Aug 2024 18:58:33 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 16 Aug 2024 18:58:32 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Hui Wang <hw.huiwang@huawei.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [RESEND PATCH v6 0/8] perf: Support searching local debugging vdso or specify vdso path in cmdline
Date: Fri, 16 Aug 2024 18:58:03 +0800
Message-ID: <20240816105811.1812897-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The vdso dumped from process memory (in buildid-cache) lacks debugging
info. To annotate vdso symbols with source lines we need a debugging
version.

For x86, we can find them from your local build as
'arch/x86/entry/vdso/vdso{32,64}.so.dbg'. Or they may resides in
'/lib/modules/<version>/vdso/vdso{32,64}.so' on Ubuntu. But notice that the
builid has to match.

If user doesn't specify the path, perf will search them internally as long
as vmlinux when recording samples. The searched debugging vdso will add to
buildid cache as ~/.debug/[vdso]/debug.

Below samples are captured on my local build kernel. perf succesfully
find debugging version vdso and we can annotate with source without
specifying vdso path.

$ sudo perf record -a
$ sudo perf report --objdump=llvm-objdump

Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
__vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
Percent│       movq    -48(%rbp),%rsi
       │       testq   %rax,%rax
       │     ;               return vread_hvclock();
       │       movq    %rax,%rdx
       │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
       │     ↑ js      eb
       │     ↑ jmp     74
       │     ;               ts->tv_sec = vdso_ts->sec;
  0.02 │147:   leaq    2(%rbx),%rax
       │       shlq    $4, %rax
       │       addq    %r10,%rax
       │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
  9.38 │152:   movl    (%r10),%ecx

When doing cross platform analysis, we need to specify the vdso path manually if
we are interested in its symbols, because they are not installed on local
machine. At most two vdso can be given. Also you can pack your buildid cache with
perf-archive if the debugging vdso can be found on the sampled machine.

$ sudo perf report --objdump=llvm-objdump \
      --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg

I also improved perf-buildid-cache command to recognize vdso when adding files,
then place it at correct place.

$ sudo perf buildid-cache --add /work/linux/arch/x86/entry/vdso/vdso64.so.dbg

Then it will be copied to ~/.debug/[vdso]/debug.

v6:
  - split "perf: build-id: try to search debugging vdso and add to cache" 
    by functional logical. (suggested by Adrian)
v5:
  - Searching the vdso in record stage instead of report. So the debugging
    vdso will be in build-id cache. This is friendly for cross-machine analysis.
  - Improve perf-buildid-cache command recognize vdso when adding files
v4:
  - split the refactoring from the actual change.
v3:
  - update documentation.
v2:
  - now search vdso automatically as long as vmlinux, as suggested by Adrian.
  - remove change 'prefer symsrc_filename for filename'.

Changbin Du (8):
  perf: support specify vdso path in cmdline
  perf: disasm: refactor function dso__disassemble_filename
  perf: disasm: use build_id_path if fallback failed
  perf: symbol: generalize vmlinux path searching
  perf: build-id: add support for build-id cache vdso debug
  perf: build-id: extend build_id_cache__find_debug() to find local
    debugging vdso
  perf: disasm: prefer debugging files in build-id cache
  perf buildid-cache: recognize vdso when adding files

 tools/perf/Documentation/perf-annotate.txt |   3 +
 tools/perf/Documentation/perf-c2c.txt      |   3 +
 tools/perf/Documentation/perf-inject.txt   |   3 +
 tools/perf/Documentation/perf-report.txt   |   3 +
 tools/perf/Documentation/perf-script.txt   |   3 +
 tools/perf/Documentation/perf-top.txt      |   3 +
 tools/perf/builtin-annotate.c              |   2 +
 tools/perf/builtin-buildid-cache.c         |  26 ++-
 tools/perf/builtin-c2c.c                   |   2 +
 tools/perf/builtin-inject.c                |   2 +
 tools/perf/builtin-report.c                |   2 +
 tools/perf/builtin-script.c                |   2 +
 tools/perf/builtin-top.c                   |   2 +
 tools/perf/util/build-id.c                 |  57 +++++-
 tools/perf/util/disasm.c                   | 131 ++++++++-----
 tools/perf/util/machine.c                  |   4 +-
 tools/perf/util/symbol.c                   | 209 ++++++++++++++++-----
 tools/perf/util/symbol.h                   |   9 +-
 tools/perf/util/symbol_conf.h              |   5 +
 19 files changed, 359 insertions(+), 112 deletions(-)

-- 
2.34.1

