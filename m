Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87D26ACD;
	Tue, 25 Jun 2024 03:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286689; cv=none; b=ogiqOCnO6Lf2QTxMB7aAatGECIEkv2Gls2aAmRO7DR6DzTBd5MQCxIBGiZiKDgu4g7G3mRrOVb8KOO1ZP5p0Y8NGVHKzUdLxr5rWT9V0F/BiNWhccwUdThvEg4Oe7fe046u6umfx1LFl3qaqKphwqpp1nzNz7RO6866rl/SZZy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286689; c=relaxed/simple;
	bh=dszVw76g6BcOGNPoIPoOuFqo3nET3iG/lHb4lRNIeiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=thuERU86niRZNnTnp5F4UBLBX/60SJhkTtJ0G0EPAjyNaXAFYj5M3NB6SfYnt+c9hkGkU2BYgAO9Dd2KRIY83HOSdXARyDCu145drKetG/rox/kQxy9ORuokqwptCWL8ZXE4OpNQc9kg1YSB5K5lAnvzsxAsbgIlBin1XMtKEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W7Vpx1bcGz2FbCJ;
	Tue, 25 Jun 2024 11:35:53 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 312E2140109;
	Tue, 25 Jun 2024 11:38:02 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 11:38:00 +0800
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
	<llvm@lists.linux.dev>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v4 0/5] perf: support specify vdso path in cmdline
Date: Tue, 25 Jun 2024 11:37:35 +0800
Message-ID: <20240625033740.223009-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The vdso dumped from process memory (in buildid-cache) lacks debugging
info. To annotate vdso symbols with source lines we need specify a
debugging version.

For x86, we can find them from your local build as
'arch/x86/entry/vdso/vdso{32,64}.so.dbg'. Or they may resides in
'/lib/modules/<version>/vdso/vdso{32,64}.so' on Ubuntu. But notice that the
builid has to match. 

If user doesn't specify the path, perf will search them internally as long
as vmlinux.

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

When doing cross platform analysis, we need to specify the vdso path if
we are interested in its symbols. At most two vdso can be given.

$ sudo perf report --objdump=llvm-objdump \
      --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg

v4:
  - split the refactoring from the actual change.
v3:
  - update documentation.
v2:
  - now search vdso automatically as long as vmlinux, as suggested by Adrian.
  - remove change 'prefer symsrc_filename for filename'.

Changbin Du (5):
  perf: support specify vdso path in cmdline
  perf: disasm: refactor function dso__disassemble_filename
  perf: disasm: use build_id_path if fallback failed
  perf: symbol: generalize vmlinux path searching
  perf: symbol: try to seach vdso path if not given by user

 tools/perf/Documentation/perf-annotate.txt |   3 +
 tools/perf/Documentation/perf-c2c.txt      |   3 +
 tools/perf/Documentation/perf-inject.txt   |   3 +
 tools/perf/Documentation/perf-report.txt   |   3 +
 tools/perf/Documentation/perf-script.txt   |   3 +
 tools/perf/Documentation/perf-top.txt      |   3 +
 tools/perf/builtin-annotate.c              |   3 +
 tools/perf/builtin-c2c.c                   |   2 +
 tools/perf/builtin-inject.c                |   2 +
 tools/perf/builtin-kallsyms.c              |   2 +
 tools/perf/builtin-probe.c                 |   2 +
 tools/perf/builtin-report.c                |   2 +
 tools/perf/builtin-script.c                |   2 +
 tools/perf/builtin-top.c                   |   4 +
 tools/perf/tests/builtin-test.c            |   3 +-
 tools/perf/util/disasm.c                   | 122 +++++++----
 tools/perf/util/machine.c                  |   4 +-
 tools/perf/util/symbol.c                   | 233 ++++++++++++++++-----
 tools/perf/util/symbol.h                   |   9 +-
 tools/perf/util/symbol_conf.h              |   6 +
 20 files changed, 312 insertions(+), 102 deletions(-)

-- 
2.34.1

