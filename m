Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60CB156CF;
	Sat, 15 Jun 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443239; cv=none; b=r+DAroLHnLq9OD3rLtQfd9gE0oCELCbh0scWUc1CNfwiSgL7zEZSxkGvPh/Tysk9kAr8xyJzc8Z5wdFKMLC6rJVhxny+mkhh2x3LnZBxZwfJK3QJf8TTttUgsYksYjHa7D33hMXmpLjLNDX5C/Bih+B4TCBPH/8typQXr6JpEGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443239; c=relaxed/simple;
	bh=xGGT+6WkCh72LDF5wT25OjdIrbcQyfLkhhs2+9H24QU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KbdszTktBEJKzeOhIZ32HuxOmwJ6FCKN6rtL0odKHTMfDKOvGTFKY5i7t+YNw0M0YMNf96+EGx2vG4WB5gvoF8kalTas4EqC+XFHa/FIK4C/CabYDOd/a8UfQgQNMZSf62l+VDQrFIxIJGe8oa7GqTAHX/9Nq+gcfDN+TPnvmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W1VrS6X9DzxRb9;
	Sat, 15 Jun 2024 17:16:24 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D62C180060;
	Sat, 15 Jun 2024 17:20:32 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 15 Jun 2024 17:20:31 +0800
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
Subject: [PATCH v2 0/4] perf: support specify vdso path in cmdline
Date: Sat, 15 Jun 2024 17:20:11 +0800
Message-ID: <20240615092015.1820362-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


v2:
  - now search vdso automatically as long as vmlinux, as suggested by Adrian.
  - remove change 'prefer symsrc_filename for filename'.

Changbin Du (4):
  perf: support specify vdso path in cmdline
  perf: disasm: use build_id_path if fallback failed
  perf: symbol: generalize vmlinux path searching
  perf: symbol: try to seach vdso path if not given by user

 tools/perf/builtin-annotate.c   |   3 +
 tools/perf/builtin-c2c.c        |   2 +
 tools/perf/builtin-inject.c     |   2 +
 tools/perf/builtin-kallsyms.c   |   2 +
 tools/perf/builtin-probe.c      |   2 +
 tools/perf/builtin-report.c     |   2 +
 tools/perf/builtin-script.c     |   2 +
 tools/perf/builtin-top.c        |   4 +
 tools/perf/tests/builtin-test.c |   3 +-
 tools/perf/util/disasm.c        | 122 ++++++++++-------
 tools/perf/util/machine.c       |   4 +-
 tools/perf/util/symbol.c        | 232 +++++++++++++++++++++++++-------
 tools/perf/util/symbol.h        |   9 +-
 tools/perf/util/symbol_conf.h   |   6 +
 14 files changed, 293 insertions(+), 102 deletions(-)

-- 
2.34.1

