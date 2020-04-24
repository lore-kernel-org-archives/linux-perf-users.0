From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Fri, 24 Apr 2020 10:07:22 -0300
Message-ID: <20200424130722.GK19437@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
 <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Gerstmayr <agerstmayr@redhat.com>, Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, Konstantin Kharlamov <hi-angel@yandex.ru>, Stephane Eranian <eranian@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel Díaz escreveu:
> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> > >  85 files changed, 1851 insertions(+), 513 deletions(-)

> > Pulled, thanks a lot Arnaldo!
 
> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> script: Add flamegraph.py script"):
>   ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> in package perf-python requires /usr/bin/sh, but no providers found in
> RDEPENDS_perf-python? [file-rdeps]


yeah, the flamegraph scripts are the outliers, there, everything else is
using /bin/bash, so I'll switch to that, ok Andreas?

[acme@quaco perf]$ vim tools/perf/scripts/python/bin/*
34 files to edit
[acme@quaco perf]$ head -1 tools/perf/scripts/python/bin/*
==> tools/perf/scripts/python/bin/compaction-times-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/compaction-times-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/event_analyzing_sample-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/event_analyzing_sample-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-postgresql-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-postgresql-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-sqlite-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/export-to-sqlite-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/failed-syscalls-by-pid-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/failed-syscalls-by-pid-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/flamegraph-record <==
#!/usr/bin/sh

==> tools/perf/scripts/python/bin/flamegraph-report <==
#!/usr/bin/sh

==> tools/perf/scripts/python/bin/futex-contention-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/futex-contention-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/intel-pt-events-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/intel-pt-events-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/mem-phys-addr-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/mem-phys-addr-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/netdev-times-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/netdev-times-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/net_dropmonitor-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/net_dropmonitor-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/powerpc-hcalls-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/powerpc-hcalls-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sched-migration-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sched-migration-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sctop-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/sctop-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/stackcollapse-record <==
#!/bin/sh

==> tools/perf/scripts/python/bin/stackcollapse-report <==
#!/bin/sh

==> tools/perf/scripts/python/bin/syscall-counts-by-pid-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/syscall-counts-by-pid-report <==
#!/bin/bash

==> tools/perf/scripts/python/bin/syscall-counts-record <==
#!/bin/bash

==> tools/perf/scripts/python/bin/syscall-counts-report <==
#!/bin/bash
[acme@quaco perf]$
