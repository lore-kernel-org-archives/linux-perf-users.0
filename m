From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/25] perf map: Move seldom used ->flags field to second cacheline
Date: Tue, 19 Nov 2019 08:32:35 -0300
Message-ID: <20191119113245.19593-16-acme@kernel.org>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So we start with:

  $ pahole -C map ~/bin/perf
  struct map {
  	union {
  		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
  		struct list_head node;                   /*     0    16 */
  	} __attribute__((__aligned__(8)));                                               /*     0    24 */
  	u64                        start;                /*    24     8 */
  	u64                        end;                  /*    32     8 */
  	_Bool                      erange_warned:1;      /*    40: 0  1 */
  	_Bool                      priv:1;               /*    40: 1  1 */

  	/* XXX 6 bits hole, try to pack */
  	/* XXX 3 bytes hole, try to pack */

  	u32                        prot;                 /*    44     4 */
  	u32                        flags;                /*    48     4 */

  	/* XXX 4 bytes hole, try to pack */

  	u64                        pgoff;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u64                        reloc;                /*    64     8 */
  	u32                        maj;                  /*    72     4 */
  	u32                        min;                  /*    76     4 */
  	u64                        ino;                  /*    80     8 */
  	u64                        ino_generation;       /*    88     8 */
  	u64                        (*map_ip)(struct map *, u64); /*    96     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*   104     8 */
  	struct dso *               dso;                  /*   112     8 */
  	refcount_t                 refcnt;               /*   120     4 */

  	/* size: 128, cachelines: 2, members: 17 */
  	/* sum members: 116, holes: 2, sum holes: 7 */
  	/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
  	/* padding: 4 */
  	/* forced alignments: 1 */
  } __attribute__((__aligned__(8)));
  $

and 'flags' is seldom used when printing details about the map or with
the "cacheline" sort order, we can move them it to the second cacheline,
that will allow combining it with 'refcnt', that is only four bytes:

  $ pahole -C map ~/bin/perf
  struct map {
  	union {
  		struct rb_node rb_node __attribute__((__aligned__(8))); /*     0    24 */
  		struct list_head node;                   /*     0    16 */
  	} __attribute__((__aligned__(8)));                                               /*     0    24 */
  	u64                        start;                /*    24     8 */
  	u64                        end;                  /*    32     8 */
  	_Bool                      erange_warned:1;      /*    40: 0  1 */
  	_Bool                      priv:1;               /*    40: 1  1 */

  	/* XXX 6 bits hole, try to pack */
  	/* XXX 3 bytes hole, try to pack */

  	u32                        prot;                 /*    44     4 */
  	u64                        pgoff;                /*    48     8 */
  	u64                        reloc;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u32                        maj;                  /*    64     4 */
  	u32                        min;                  /*    68     4 */
  	u64                        ino;                  /*    72     8 */
  	u64                        ino_generation;       /*    80     8 */
  	u64                        (*map_ip)(struct map *, u64); /*    88     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*    96     8 */
  	struct dso *               dso;                  /*   104     8 */
  	refcount_t                 refcnt;               /*   112     4 */
  	u32                        flags;                /*   116     4 */

  	/* size: 120, cachelines: 2, members: 17 */
  	/* sum members: 116, holes: 1, sum holes: 3 */
  	/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
  	/* forced alignments: 1 */
  	/* last cacheline: 56 bytes */
  } __attribute__((__aligned__(8)));
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-2cdw3zlw1mkamaf7nqtdlxfi@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index e2466aa5bb41..0a6c45f85cd9 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -28,7 +28,6 @@ struct map {
 	bool			erange_warned:1;
 	bool			priv:1;
 	u32			prot;
-	u32			flags;
 	u64			pgoff;
 	u64			reloc;
 	u32			maj, min; /* only valid for MMAP2 record */
@@ -42,6 +41,7 @@ struct map {
 
 	struct dso		*dso;
 	refcount_t		refcnt;
+	u32			flags;
 };
 
 struct kmap;
-- 
2.21.0
