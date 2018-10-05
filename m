From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/5] perf/urgent fixes
Date: Fri, 5 Oct 2018 18:14:50 +0200
Message-ID: <20181005161450.GA73272@gmail.com>
References: <20181005161012.18475-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005161012.18475-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Sandipan Das <sandipan@linux.ibm.com>, stable@vger.kernel.org, Thiago Macieira <thiago.macieira@intel.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 5d05dfd13f20b01a3cd5d293058baa7d5c1583b6:
> 
>   Merge tag 'perf-urgent-for-mingo-4.19-20180918' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-09-19 13:25:35 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20181005
> 
> for you to fetch changes up to 7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf:
> 
>   perf record: Use unmapped IP for inline callchain cursors (2018-10-05 11:18:09 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix the build on Clear Linux, coping with redundant declarations of
>   function prototypes in python3 header files by adding
>   -Wno-redundant-decls to build with PYTHON=python3 (Arnaldo Carvalho de Melo)
> 
> - Fixes for processing inline frames in backtraces using DWARF based
>   unwinding (Milian Wolff)
> 
> - Cope with bad DWARF info for function names for inline frames,not
>   trying to demangle this symbol. Problem reported with rust but
>   reproduced as well with C++. Problem reported to the libbpf
>   maintainers (Milian Wolff)
> 
> - Fix python export to postgresql and sqlite code (Adrian Hunter)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf script python: Fix export-to-postgresql.py occasional failure
>       perf script python: Fix export-to-sqlite.py sample columns
> 
> Arnaldo Carvalho de Melo (1):
>       perf python: Use -Wno-redundant-decls to build with PYTHON=python3
> 
> Milian Wolff (2):
>       perf report: Don't try to map ip to invalid map
>       perf record: Use unmapped IP for inline callchain cursors
> 
>  tools/perf/scripts/python/export-to-postgresql.py | 9 +++++++++
>  tools/perf/scripts/python/export-to-sqlite.py     | 6 +++++-
>  tools/perf/util/machine.c                         | 8 +++++---
>  tools/perf/util/setup.py                          | 2 +-
>  4 files changed, 20 insertions(+), 5 deletions(-)

Pulled into tip:perf/urgent, thanks a lot Arnaldo!

	Ingo
