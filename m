Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78101137762;
	Thu, 13 Jun 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260531; cv=none; b=FgCeaLWISAU/cbDWHtnREZK14yyeGKNdVaIczSuzlNMJt+TlTrNblkX7bU5dcxAnQBsE0+Mbq3u+1432FItFO+3rLic+jm/kNe+N+N74mz8Spek+u1PkNnGwQvF9S/hD1O39V8y99DTJUh6hr+MzADEvDI76u0VrKJS8z9d3b/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260531; c=relaxed/simple;
	bh=OWo4rrebCjJM7qWQjGzNFquIUysjDOnaqUlR2C+r7Xg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=meoMaAnPSjwmpLxnZASdtYrcrO7G3VLwOeSvmdxTUkfNWc8gA7THQBmUXXW1h5WppWTxaJb3TO8+lWMCCVyNA2SiuXWiPfPVTBpw6Pj2SdLFFe2BzV+gHmxAqJ2x5hZXrel2SxtyeXEDXc9/OxaWb0bFFpYTL5FKOTZJP7x98AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W0CHg4SmyzPpN3;
	Thu, 13 Jun 2024 14:31:59 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 93662140382;
	Thu, 13 Jun 2024 14:35:25 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 14:35:24 +0800
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
Subject: [PATCH 0/2] perf: support specify vdso path in cmdline
Date: Thu, 13 Jun 2024 14:35:08 +0800
Message-ID: <20240613063510.348692-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100011.china.huawei.com (7.221.188.204)

The vdso dumped from process memory (in buildid-cache) lacks debugging
info. To annotate vdso symbols with source lines we need specify a
debugging version.

For x86, we can find them from your local build as
arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may resides in
/lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that the
builid has to match.

$ sudo perf record -a
$ sudo perf report --objdump=llvm-objdump \
      --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg

Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
__vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
Percent│       movq    -48(%rbp),%rsi                                ▒
       │       testq   %rax,%rax                                     ▒
       │     ;               return vread_hvclock();                 ▒
       │       movq    %rax,%rdx                                     ▒
       │     ;               if (unlikely(!vdso_cycles_ok(cycles)))  ▒
       │     ↑ js      eb                                            ▒
       │     ↑ jmp     74                                            ▒
       │     ;               ts->tv_sec = vdso_ts->sec;              ▒
  0.02 │147:   leaq    2(%rbx),%rax                                  ▒
       │       shlq    $4, %rax                                      ▒
       │       addq    %r10,%rax                                     ▒
       │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {▒
  9.38 │152:   movl    (%r10),%ecx                                   ▒


When doing cross platform analysis, we also need specify the vdso path if
we are interested in its symbols.

Changbin Du (2):
  perf: support specify vdso path in cmdline
  perf: disasm: prefer symsrc_filename for filename

 tools/perf/builtin-annotate.c |  2 +
 tools/perf/builtin-c2c.c      |  2 +
 tools/perf/builtin-inject.c   |  2 +
 tools/perf/builtin-report.c   |  2 +
 tools/perf/builtin-script.c   |  2 +
 tools/perf/builtin-top.c      |  2 +
 tools/perf/util/disasm.c      |  5 +++
 tools/perf/util/symbol.c      | 82 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/symbol_conf.h |  5 +++
 9 files changed, 102 insertions(+), 2 deletions(-)

-- 
2.34.1

