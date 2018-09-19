From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 0/2] perf/urgent fixes
Date: Wed, 19 Sep 2018 13:34:22 +0200
Message-ID: <20180919113422.GA39073@gmail.com>
References: <20180918153725.7022-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180918153725.7022-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Quentin Monnet <quentin.monnet@netronome.com>, Thomas Richter <tmricht@linux.ibm.com>, Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
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
> The following changes since commit cb48b6a26cace226d8b299a48c73e808eb0c4f61:
> 
>   Merge tag 'perf-urgent-for-mingo-4.19-20180912' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-09-12 21:10:05 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.19-20180918
> 
> for you to fetch changes up to 169e366c08084aeb49a3793c892c9abfaa47eeda:
> 
>   perf Documentation: Fix out-of-tree asciidoctor man page generation (2018-09-18 10:17:16 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix the build on !_GNU_SOURCE libc systems such as Alpine Linux/musl
>   libc due to usage of strerror_r glibc variant on libbpf (Arnaldo Carvalho de Melo)
> 
> - Fix out-of-tree asciidoctor man page generation (Ben Hutchings)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems
> 
> Ben Hutchings (1):
>       perf Documentation: Fix out-of-tree asciidoctor man page generation
> 
>  tools/lib/bpf/Build               |  2 +-
>  tools/lib/bpf/libbpf.c            | 20 ++++++++++----------
>  tools/lib/bpf/str_error.c         | 18 ++++++++++++++++++
>  tools/lib/bpf/str_error.h         |  6 ++++++
>  tools/perf/Documentation/Makefile |  2 +-
>  5 files changed, 36 insertions(+), 12 deletions(-)
>  create mode 100644 tools/lib/bpf/str_error.c
>  create mode 100644 tools/lib/bpf/str_error.h

Pulled, thanks a lot Arnaldo!

	Ingo
