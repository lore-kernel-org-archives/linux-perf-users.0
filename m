From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/15] perf callchain: Use 'struct map_symbol' in 'struct callchain_cursor_node'
Date: Tue, 12 Nov 2019 15:37:49 -0300
Message-ID: <20191112183757.28660-8-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To ease passing around map+symbol, just like done for other parts of the
tree recently.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c                     |  4 +--
 tools/perf/builtin-sched.c                    |  2 +-
 tools/perf/util/callchain.c                   | 33 +++++++++----------
 tools/perf/util/callchain.h                   |  5 ++-
 tools/perf/util/db-export.c                   |  4 +--
 tools/perf/util/evsel_fprintf.c               | 29 +++++++++-------
 tools/perf/util/machine.c                     | 24 +++++++++-----
 .../util/scripting-engines/trace-event-perl.c | 16 ++++-----
 .../scripting-engines/trace-event-python.c    | 16 ++++-----
 9 files changed, 71 insertions(+), 62 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 9661671cc26e..003c85f5f56c 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -412,8 +412,8 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
 				 sizeof(key), callcmp);
 		if (!caller) {
 			/* found */
-			if (node->map)
-				addr = map__unmap_ip(node->map, node->ip);
+			if (node->ms.map)
+				addr = map__unmap_ip(node->ms.map, node->ip);
 			else
 				addr = node->ip;
 
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5cacc4f84c8d..8a12d71364c3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2172,7 +2172,7 @@ static void save_task_callchain(struct perf_sched *sched,
 		if (node == NULL)
 			break;
 
-		sym = node->sym;
+		sym = node->ms.sym;
 		if (sym) {
 			if (!strcmp(sym->name, "schedule") ||
 			    !strcmp(sym->name, "__schedule") ||
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 89faa644b0bc..8f89c5a4781f 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -582,8 +582,8 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 			return -1;
 		}
 		call->ip = cursor_node->ip;
-		call->ms.sym = cursor_node->sym;
-		call->ms.map = map__get(cursor_node->map);
+		call->ms = cursor_node->ms;
+		map__get(call->ms.map);
 		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
@@ -720,21 +720,21 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 		/* otherwise fall-back to symbol-based comparison below */
 		__fallthrough;
 	case CCKEY_FUNCTION:
-		if (node->sym && cnode->ms.sym) {
+		if (node->ms.sym && cnode->ms.sym) {
 			/*
 			 * Compare inlined frames based on their symbol name
 			 * because different inlined frames will have the same
 			 * symbol start. Otherwise do a faster comparison based
 			 * on the symbol start address.
 			 */
-			if (cnode->ms.sym->inlined || node->sym->inlined) {
+			if (cnode->ms.sym->inlined || node->ms.sym->inlined) {
 				match = match_chain_strings(cnode->ms.sym->name,
-							    node->sym->name);
+							    node->ms.sym->name);
 				if (match != MATCH_ERROR)
 					break;
 			} else {
 				match = match_chain_dso_addresses(cnode->ms.map, cnode->ms.sym->start,
-								  node->map, node->sym->start);
+								  node->ms.map, node->ms.sym->start);
 				break;
 			}
 		}
@@ -742,7 +742,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 		__fallthrough;
 	case CCKEY_ADDRESS:
 	default:
-		match = match_chain_dso_addresses(cnode->ms.map, cnode->ip, node->map, node->ip);
+		match = match_chain_dso_addresses(cnode->ms.map, cnode->ip, node->ms.map, node->ip);
 		break;
 	}
 
@@ -1004,8 +1004,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	int err = 0;
 
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
-		callchain_cursor_append(cursor, list->ip,
-					list->ms.map, list->ms.sym,
+		callchain_cursor_append(cursor, list->ip, &list->ms,
 					false, NULL, 0, 0, 0, list->srcline);
 		list_del_init(&list->list);
 		map__zput(list->ms.map);
@@ -1044,7 +1043,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 }
 
 int callchain_cursor_append(struct callchain_cursor *cursor,
-			    u64 ip, struct map *map, struct symbol *sym,
+			    u64 ip, struct map_symbol *ms,
 			    bool branch, struct branch_flags *flags,
 			    int nr_loop_iter, u64 iter_cycles, u64 branch_from,
 			    const char *srcline)
@@ -1060,9 +1059,9 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	}
 
 	node->ip = ip;
-	map__zput(node->map);
-	node->map = map__get(map);
-	node->sym = sym;
+	map__zput(node->ms.map);
+	node->ms = *ms;
+	map__get(node->ms.map);
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->iter_cycles = iter_cycles;
@@ -1107,8 +1106,8 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	al->map = node->map;
-	al->sym = node->sym;
+	al->map = node->ms.map;
+	al->sym = node->ms.sym;
 	al->srcline = node->srcline;
 	al->addr = node->ip;
 
@@ -1571,7 +1570,7 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 		if (node == NULL)
 			break;
 
-		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
+		rc = callchain_cursor_append(dst, node->ip, &node->ms,
 					     node->branch, &node->branch_flags,
 					     node->nr_loop_iter,
 					     node->iter_cycles,
@@ -1597,5 +1596,5 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 	cursor->last = &cursor->first;
 
 	for (node = cursor->first; node != NULL; node = node->next)
-		map__zput(node->map);
+		map__zput(node->ms.map);
 }
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 83398e5bbe4b..706bb7bbe1e1 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -141,8 +141,7 @@ struct callchain_list {
  */
 struct callchain_cursor_node {
 	u64				ip;
-	struct map			*map;
-	struct symbol			*sym;
+	struct map_symbol		ms;
 	const char			*srcline;
 	bool				branch;
 	struct branch_flags		branch_flags;
@@ -195,7 +194,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 void callchain_cursor_reset(struct callchain_cursor *cursor);
 
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
-			    struct map *map, struct symbol *sym,
+			    struct map_symbol *ms,
 			    bool branch, struct branch_flags *flags,
 			    int nr_loop_iter, u64 iter_cycles, u64 branch_from,
 			    const char *srcline);
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 44b465c0a343..d029faf9fc9f 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -249,8 +249,8 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 * constructing an addr_location struct and then passing it to
 		 * db_ids_from_al() to perform the export.
 		 */
-		al.sym = node->sym;
-		al.map = node->map;
+		al.sym = node->ms.sym;
+		al.map = node->ms.map;
 		al.mg  = thread->mg;
 		al.addr = node->ip;
 
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 028df7afb0dc..3b4842840db0 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -125,13 +125,18 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 		callchain_cursor_commit(cursor);
 
 		while (1) {
+			struct symbol *sym;
+			struct map *map;
 			u64 addr = 0;
 
 			node = callchain_cursor_current(cursor);
 			if (!node)
 				break;
 
-			if (node->sym && node->sym->ignore && print_skip_ignored)
+			sym = node->ms.sym;
+			map = node->ms.map;
+
+			if (sym && sym->ignore && print_skip_ignored)
 				goto next;
 
 			printed += fprintf(fp, "%-*.*s", left_alignment, left_alignment, " ");
@@ -142,42 +147,42 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_ip)
 				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
 
-			if (node->map)
-				addr = node->map->map_ip(node->map, node->ip);
+			if (map)
+				addr = map->map_ip(map, node->ip);
 
 			if (print_sym) {
 				printed += fprintf(fp, " ");
 				node_al.addr = addr;
-				node_al.map  = node->map;
+				node_al.map  = map;
 
 				if (print_symoffset) {
-					printed += __symbol__fprintf_symname_offs(node->sym, &node_al,
+					printed += __symbol__fprintf_symname_offs(sym, &node_al,
 										  print_unknown_as_addr,
 										  true, fp);
 				} else {
-					printed += __symbol__fprintf_symname(node->sym, &node_al,
+					printed += __symbol__fprintf_symname(sym, &node_al,
 									     print_unknown_as_addr, fp);
 				}
 			}
 
-			if (print_dso && (!node->sym || !node->sym->inlined)) {
+			if (print_dso && (!sym || !sym->inlined)) {
 				printed += fprintf(fp, " (");
-				printed += map__fprintf_dsoname(node->map, fp);
+				printed += map__fprintf_dsoname(map, fp);
 				printed += fprintf(fp, ")");
 			}
 
 			if (print_srcline)
-				printed += map__fprintf_srcline(node->map, addr, "\n  ", fp);
+				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
 
-			if (node->sym && node->sym->inlined)
+			if (sym && sym->inlined)
 				printed += fprintf(fp, " (inlined)");
 
 			if (!print_oneline)
 				printed += fprintf(fp, "\n");
 
 			/* Add srccode here too? */
-			if (bt_stop_list && node->sym &&
-			    strlist__has_entry(bt_stop_list, node->sym->name)) {
+			if (bt_stop_list && sym &&
+			    strlist__has_entry(bt_stop_list, sym->name)) {
 				break;
 			}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3874bb89ac79..d08c7285c708 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2006,8 +2006,9 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 	return mi;
 }
 
-static char *callchain_srcline(struct map *map, struct symbol *sym, u64 ip)
+static char *callchain_srcline(struct map_symbol *ms, u64 ip)
 {
+	struct map *map = ms->map;
 	char *srcline = NULL;
 
 	if (!map || callchain_param.key == CCKEY_FUNCTION)
@@ -2019,7 +2020,7 @@ static char *callchain_srcline(struct map *map, struct symbol *sym, u64 ip)
 		bool show_addr = callchain_param.key == CCKEY_ADDRESS;
 
 		srcline = get_srcline(map->dso, map__rip_2objdump(map, ip),
-				      sym, show_sym, show_addr, ip);
+				      ms->sym, show_sym, show_addr, ip);
 		srcline__tree_insert(&map->dso->srclines, ip, srcline);
 	}
 
@@ -2042,6 +2043,7 @@ static int add_callchain_ip(struct thread *thread,
 			    struct iterations *iter,
 			    u64 branch_from)
 {
+	struct map_symbol ms;
 	struct addr_location al;
 	int nr_loop_iter = 0;
 	u64 iter_cycles = 0;
@@ -2099,8 +2101,10 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
-	srcline = callchain_srcline(al.map, al.sym, al.addr);
-	return callchain_cursor_append(cursor, ip, al.map, al.sym,
+	ms.map = al.map;
+	ms.sym = al.sym;
+	srcline = callchain_srcline(&ms, al.addr);
+	return callchain_cursor_append(cursor, ip, &ms,
 				       branch, flags, nr_loop_iter,
 				       iter_cycles, branch_from, srcline);
 }
@@ -2472,8 +2476,11 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 	}
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
-		ret = callchain_cursor_append(cursor, ip, map,
-					      ilist->symbol, false,
+		struct map_symbol ilist_ms = {
+			.map = map,
+			.sym = ilist->symbol,
+		};
+		ret = callchain_cursor_append(cursor, ip, &ilist_ms, false,
 					      NULL, 0, 0, 0, ilist->srcline);
 
 		if (ret != 0)
@@ -2502,9 +2509,8 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (entry->ms.map)
 		addr = map__map_ip(entry->ms.map, entry->ip);
 
-	srcline = callchain_srcline(entry->ms.map, entry->ms.sym, addr);
-	return callchain_cursor_append(cursor, entry->ip,
-				       entry->ms.map, entry->ms.sym,
+	srcline = callchain_srcline(&entry->ms, addr);
+	return callchain_cursor_append(cursor, entry->ip, &entry->ms,
 				       false, NULL, 0, 0, 0, srcline);
 }
 
diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
index 741f040648b5..0e608a5ef599 100644
--- a/tools/perf/util/scripting-engines/trace-event-perl.c
+++ b/tools/perf/util/scripting-engines/trace-event-perl.c
@@ -294,17 +294,17 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 			goto exit;
 		}
 
-		if (node->sym) {
+		if (node->ms.sym) {
 			HV *sym = newHV();
 			if (!sym) {
 				hv_undef(elem);
 				goto exit;
 			}
-			if (!hv_stores(sym, "start",   newSVuv(node->sym->start)) ||
-			    !hv_stores(sym, "end",     newSVuv(node->sym->end)) ||
-			    !hv_stores(sym, "binding", newSVuv(node->sym->binding)) ||
-			    !hv_stores(sym, "name",    newSVpvn(node->sym->name,
-								node->sym->namelen)) ||
+			if (!hv_stores(sym, "start",   newSVuv(node->ms.sym->start)) ||
+			    !hv_stores(sym, "end",     newSVuv(node->ms.sym->end)) ||
+			    !hv_stores(sym, "binding", newSVuv(node->ms.sym->binding)) ||
+			    !hv_stores(sym, "name",    newSVpvn(node->ms.sym->name,
+								node->ms.sym->namelen)) ||
 			    !hv_stores(elem, "sym",    newRV_noinc((SV*)sym))) {
 				hv_undef(sym);
 				hv_undef(elem);
@@ -312,8 +312,8 @@ static SV *perl_process_callchain(struct perf_sample *sample,
 			}
 		}
 
-		if (node->map) {
-			struct map *map = node->map;
+		if (node->ms.map) {
+			struct map *map = node->ms.map;
 			const char *dsoname = "[unknown]";
 			if (map && map->dso) {
 				if (symbol_conf.show_kernel_path && map->dso->long_name)
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 9e0582717f5f..9581a904af29 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -428,24 +428,24 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
 		pydict_set_item_string_decref(pyelem, "ip",
 				PyLong_FromUnsignedLongLong(node->ip));
 
-		if (node->sym) {
+		if (node->ms.sym) {
 			PyObject *pysym  = PyDict_New();
 			if (!pysym)
 				Py_FatalError("couldn't create Python dictionary");
 			pydict_set_item_string_decref(pysym, "start",
-					PyLong_FromUnsignedLongLong(node->sym->start));
+					PyLong_FromUnsignedLongLong(node->ms.sym->start));
 			pydict_set_item_string_decref(pysym, "end",
-					PyLong_FromUnsignedLongLong(node->sym->end));
+					PyLong_FromUnsignedLongLong(node->ms.sym->end));
 			pydict_set_item_string_decref(pysym, "binding",
-					_PyLong_FromLong(node->sym->binding));
+					_PyLong_FromLong(node->ms.sym->binding));
 			pydict_set_item_string_decref(pysym, "name",
-					_PyUnicode_FromStringAndSize(node->sym->name,
-							node->sym->namelen));
+					_PyUnicode_FromStringAndSize(node->ms.sym->name,
+							node->ms.sym->namelen));
 			pydict_set_item_string_decref(pyelem, "sym", pysym);
 		}
 
-		if (node->map) {
-			const char *dsoname = get_dsoname(node->map);
+		if (node->ms.map) {
+			const char *dsoname = get_dsoname(node->ms.map);
 
 			pydict_set_item_string_decref(pyelem, "dso",
 					_PyUnicode_FromString(dsoname));
-- 
2.21.0
