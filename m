From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/52] perf symbols: Use symbol type instead of map->type
Date: Wed,  2 May 2018 12:19:32 -0300
Message-ID: <20180502151942.20542-43-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dave Martin <dave.martin@linaro.org>, David Ahern <dsahern@gmail.com>, "Dr . David Alan Gilbert" <david.gilbert@linaro.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

map->type is going away, we can derive it from map->prot, so use
the same logic as in the kernel's arch/arm/kernel/module.c file:

  ELF32_ST_TYPE(sym->st_info) == STT_FUNC && !(sym->st_value & 1))

This was introduced in b2f8fb237e9c ("perf symbols: Fix annotation of
thumb code"), that fix is maintained with this change.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Dr. David Alan Gilbert <david.gilbert@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-us590h81uqgxaumucfttqj50@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index cf2e6f428bb4..82a1aadc245f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -982,7 +982,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		/* On ARM, symbols for thumb functions have 1 added to
 		 * the symbol address as a flag - remove it */
 		if ((ehdr.e_machine == EM_ARM) &&
-		    (map->type == MAP__FUNCTION) &&
+		    (GELF_ST_TYPE(sym.st_info) == STT_FUNC) &&
 		    (sym.st_value & 1))
 			--sym.st_value;
 
-- 
2.14.3
