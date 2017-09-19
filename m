From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 03/13] perf report: create real callchain entries for
 inlined frames
Date: Tue, 19 Sep 2017 14:27:27 +0200
Message-ID: <20170919122727.GC13388@krava>
References: <20170906135501.306-1-milian.wolff@kdab.com>
 <20170906135501.306-4-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906135501.306-4-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Sep 06, 2017 at 03:54:51PM +0200, Milian Wolff wrote:
> The inlined frames use a fake symbol that is maintained by
> inline_node which in turn is maintained by the dso->inlines tree.
> This tree is always sorted by name. All other entries of the symbol
> beside the function name are unused for inline frames. The advantage
> of this approach is that all existing users of the callchain API can
> now transparently display inlined frames without having to patch
> their code.
> 
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Yao Jin <yao.jin@linux.intel.com>
> Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
> ---
>  tools/perf/util/dso.c     |   2 +
>  tools/perf/util/dso.h     |   1 +
>  tools/perf/util/machine.c |  37 +++++++++
>  tools/perf/util/srcline.c | 186 ++++++++++++++++++++++++++++++++++++----------
>  tools/perf/util/srcline.h |  19 ++++-
>  tools/perf/util/symbol.h  |   1 +
>  6 files changed, 203 insertions(+), 43 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index b9e087fb8247..72e6e390fd26 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -9,6 +9,7 @@
>  #include "compress.h"
>  #include "path.h"
>  #include "symbol.h"
> +#include "srcline.h"
>  #include "dso.h"
>  #include "machine.h"
>  #include "auxtrace.h"
> @@ -1233,6 +1234,7 @@ void dso__delete(struct dso *dso)
>  		       dso->long_name);
>  	for (i = 0; i < MAP__NR_TYPES; ++i)
>  		symbols__delete(&dso->symbols[i]);
> +	inlines__tree_delete(&dso->inlined_nodes);
>  
>  	if (dso->short_name_allocated) {
>  		zfree((char **)&dso->short_name);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index f886141678eb..7d1e2b3c1f10 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -141,6 +141,7 @@ struct dso {
>  	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
>  	struct rb_root	 symbols[MAP__NR_TYPES];
>  	struct rb_root	 symbol_names[MAP__NR_TYPES];
> +	struct rb_root	 inlined_nodes;

should you init this like below?

jirka


---
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 53ceccdf74be..ed8cab3b51b1 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1202,6 +1202,7 @@ struct dso *dso__new(const char *name)
 		for (i = 0; i < MAP__NR_TYPES; ++i)
 			dso->symbols[i] = dso->symbol_names[i] = RB_ROOT;
 		dso->data.cache = RB_ROOT;
+		dso->inlined_nodes = RB_ROOT;
 		dso->data.fd = -1;
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
