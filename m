Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF58B22259C;
	Wed,  4 Jun 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072612; cv=none; b=FBJs1skJwxdVZzRP9/q2FznqzEmQ83UlRJybQByH0Ix2qBsKUvp3mOAfZX91v00uAStErRwj7Xbgf7a8SGcKad2B38c5zJB/osIIkCv8mnKArO+JLHQ06uDF8mD6HnkDNGrQrNKfNrsZY9rT8hm01nU5gncl2xaxjraNHhJ7uZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072612; c=relaxed/simple;
	bh=mcgIqsoxQ0DUFCqqcvzlt1vRTae271UHuYTxdWHyoDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMaBWBvT1q8ha/P14dWeG6VyOzsY0UDd/CdCJbPjp7MWmqQFyw+6ZtA0gBXEPHdYUFvr6+5uFiUCM6u2xJOPXrB6Dc2KV0XH3VIjH62zdMcKOwn0L6/U5p0Mwl/wVbs11w+Y5vDRQ4a5bKxKO6vBvX+sLElpn5VMeqP/L3J6Vlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4ZRL+Jz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4ZRL+Jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F12C4CEE4;
	Wed,  4 Jun 2025 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749072612;
	bh=mcgIqsoxQ0DUFCqqcvzlt1vRTae271UHuYTxdWHyoDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4ZRL+JzEWKy4eZ/OBlu1bUqAPDBx1RazS7BtJ56+HSVD+PE3OUuwZHhZSHz66nF2
	 1TJEQsa6iPft8rS0nUQB0IJl41LXFhT2pubE1Xc8+d/L7CojPjOX+5XRoN7s1jttPO
	 2DQJEJDRKw6XHcm6t2hgWmtRsjHAYYKrNFPKo01kKQyqueVwyNnensTk8423FK236P
	 D/N4ZO31Jdqabh4DD6hz6A8tcEbJEOP/3aaYsXMDavEXcLc0yxwEF6M6PgcH+bTxcm
	 3EuTMzy1DwGVFcIKwmPudKP2KkXGOx7BB67mohPF2tPhSQ8Oc0G6yU35w1uJY4okHR
	 GD8X+rox1wngA==
Date: Wed, 4 Jun 2025 14:30:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf bpf-filter: Improve error messages
Message-ID: <aEC64oiBI3U-619x@google.com>
References: <20250604174835.1852481-1-namhyung@kernel.org>
 <CAP-5=fWap82Wjx2EBTESFsTxSikkJ3TW7B_jSjhUkgfheQu_xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWap82Wjx2EBTESFsTxSikkJ3TW7B_jSjhUkgfheQu_xw@mail.gmail.com>

On Wed, Jun 04, 2025 at 10:59:57AM -0700, Ian Rogers wrote:
> On Wed, Jun 4, 2025 at 10:48 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The BPF filter needs libbpf/BPF-skeleton support and root privilege.
> > Add error messages to help users understand the problem easily.
> >
> > When it's not build with BPF support (make BUILD_BPF_SKEL=0).
> >
> >   $ sudo perf record -e cycles --filter "pid != 0" true
> >   Error: BPF filter is requested but perf is not built with BPF.
> >         Please make sure to build with libbpf and BPF skeleton.
> >
> >    Usage: perf record [<options>] [<command>]
> >       or: perf record [<options>] -- <command> [<options>]
> >
> >           --filter <filter>
> >                             event filter
> >
> > When it supports BPF but runs without root or CAP_BPF.  Note that it
> > also checks pinned BPF filters.
> >
> >   $ perf record -e cycles --filter "pid != 0" -o /dev/null true
> >   Error: BPF filter only works for users with the CAP_BPF capability!
> >         Please run 'perf record --setup-filter pin' as root first.
> >
> >    Usage: perf record [<options>] [<command>]
> >       or: perf record [<options>] -- <command> [<options>]
> >
> >           --filter <filter>
> >                             event filter
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for your review!

> 
> > ---
> > v2) change fprintf() -> pr_err()  (Ian)
> >
> >  tools/perf/util/bpf-filter.c | 28 ++++++++++++++++++++++++++++
> >  tools/perf/util/bpf-filter.h |  3 +++
> >  tools/perf/util/cap.c        |  1 -
> >  tools/perf/util/cap.h        |  5 +++++
> >  4 files changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> > index a4fdf6911ec1c32e..92e2f054b45e91dd 100644
> > --- a/tools/perf/util/bpf-filter.c
> > +++ b/tools/perf/util/bpf-filter.c
> > @@ -52,6 +52,7 @@
> >  #include <internal/xyarray.h>
> >  #include <perf/threadmap.h>
> >
> > +#include "util/cap.h"
> >  #include "util/debug.h"
> >  #include "util/evsel.h"
> >  #include "util/target.h"
> > @@ -618,11 +619,38 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__new(enum perf_bpf_filter_term
> >         return expr;
> >  }
> >
> > +static bool check_bpf_filter_capable(void)
> > +{
> > +       bool used_root;
> > +
> > +       if (perf_cap__capable(CAP_BPF, &used_root))
> > +               return true;
> > +
> > +       if (!used_root) {
> > +               /* Check if root already pinned the filter programs and maps */
> > +               int fd = get_pinned_fd("filters");
> > +
> > +               if (fd >= 0) {
> > +                       close(fd);
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       pr_err("Error: BPF filter only works for %s!\n"
> > +              "\tPlease run 'perf record --setup-filter pin' as root first.\n",
> > +              used_root ? "root" : "users with the CAP_BPF capability");
> > +
> > +       return false;
> > +}
> > +
> >  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
> >  {
> >         YY_BUFFER_STATE buffer;
> >         int ret;
> >
> > +       if (!check_bpf_filter_capable())
> > +               return -EPERM;
> > +
> >         buffer = perf_bpf_filter__scan_string(str);
> >
> >         ret = perf_bpf_filter_parse(expr_head);
> > diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> > index 916ed7770b734f15..122477f2de44bb60 100644
> > --- a/tools/perf/util/bpf-filter.h
> > +++ b/tools/perf/util/bpf-filter.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/list.h>
> >
> >  #include "bpf_skel/sample-filter.h"
> > +#include "util/debug.h"
> 
> nit: I'd generally avoid the util/ prefix here as bpf-filter.h and
> debug.h are in the same directory. The compiler first looks in the
> same directory before using include paths:
> https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html
> So including this way is saying please search using the include paths
> which is weird when the files are in the same directory. I know the
> style in the code base is inconsistent with this, but I wish it
> wasn't.

I see your point.  But I thought it's more flexible to file move and
for people to find out where the file is.

Thanks,
Namhyung
 
> >
> >  struct perf_bpf_filter_expr {
> >         struct list_head list;
> > @@ -38,6 +39,8 @@ int perf_bpf_filter__unpin(void);
> >  static inline int perf_bpf_filter__parse(struct list_head *expr_head __maybe_unused,
> >                                          const char *str __maybe_unused)
> >  {
> > +       pr_err("Error: BPF filter is requested but perf is not built with BPF.\n"
> > +               "\tPlease make sure to build with libbpf and BPF skeleton.\n");
> >         return -EOPNOTSUPP;
> >  }
> >  static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused,
> > diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> > index 69d9a2bcd40bfdd1..24a0ea7e6d97749b 100644
> > --- a/tools/perf/util/cap.c
> > +++ b/tools/perf/util/cap.c
> > @@ -7,7 +7,6 @@
> >  #include "debug.h"
> >  #include <errno.h>
> >  #include <string.h>
> > -#include <linux/capability.h>
> >  #include <sys/syscall.h>
> >  #include <unistd.h>
> >
> > diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
> > index 0c6a1ff55f07340a..c1b8ac033ccc5826 100644
> > --- a/tools/perf/util/cap.h
> > +++ b/tools/perf/util/cap.h
> > @@ -3,6 +3,7 @@
> >  #define __PERF_CAP_H
> >
> >  #include <stdbool.h>
> > +#include <linux/capability.h>
> >
> >  /* For older systems */
> >  #ifndef CAP_SYSLOG
> > @@ -13,6 +14,10 @@
> >  #define CAP_PERFMON    38
> >  #endif
> >
> > +#ifndef CAP_BPF
> > +#define CAP_BPF                39
> > +#endif
> > +
> >  /* Query if a capability is supported, used_root is set if the fallback root check was used. */
> >  bool perf_cap__capable(int cap, bool *used_root);
> >
> > --
> > 2.49.0.1266.g31b7d2e469-goog
> >
