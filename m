From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/60] perf auxtrace: For reporting purposes, un-group AUX area event
Date: Mon, 20 Apr 2020 08:52:47 -0300
Message-ID: <20200420115316.18781-32-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

An AUX area event must be the group leader when recording traces in
sample mode, but that does not produce the expected results from
'perf report' because it expects the leader to provide samples.

Rather than teach 'perf report' about AUX area sampling, un-group the
AUX area event during processing, making the 2nd event the leader.

Example:

 $ perf record -e '{intel_pt//u,branch-misses:u}' -c 1 uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.080 MB perf.data ]

 Before:

 $ perf report

 Samples: 800  of events 'anon group { intel_pt//u, branch-misses:u }', Event count (approx.): 800
        Children              Self  Command  Shared Object     Symbol
     0.00%  47.50%     0.00%  47.50%  uname    libc-2.28.so      [.] _dl_addr
     0.00%  16.38%     0.00%  16.38%  uname    ld-2.28.so        [.] __GI___tunables_init
     0.00%  54.75%     0.00%   4.75%  uname    ld-2.28.so        [.] dl_main
     0.00%   3.12%     0.00%   3.12%  uname    ld-2.28.so        [.] _dl_map_object_from_fd
     0.00%   2.38%     0.00%   2.38%  uname    ld-2.28.so        [.] strcmp
     0.00%   2.25%     0.00%   2.25%  uname    ld-2.28.so        [.] _dl_check_map_versions
     0.00%   2.00%     0.00%   2.00%  uname    ld-2.28.so        [.] _dl_important_hwcaps
     0.00%   2.00%     0.00%   2.00%  uname    ld-2.28.so        [.] _dl_map_object_deps
     0.00%  51.50%     0.00%   1.50%  uname    ld-2.28.so        [.] _dl_sysdep_start
     0.00%   1.25%     0.00%   1.25%  uname    ld-2.28.so        [.] _dl_load_cache_lookup
     0.00%  51.12%     0.00%   1.12%  uname    ld-2.28.so        [.] _dl_start
     0.00%  50.88%     0.00%   1.12%  uname    ld-2.28.so        [.] do_lookup_x
     0.00%  50.62%     0.00%   1.00%  uname    ld-2.28.so        [.] _dl_lookup_symbol_x
     0.00%   1.00%     0.00%   1.00%  uname    ld-2.28.so        [.] _dl_map_object
     0.00%   1.00%     0.00%   1.00%  uname    ld-2.28.so        [.] _dl_next_ld_env_entry
     0.00%   0.88%     0.00%   0.88%  uname    ld-2.28.so        [.] _dl_cache_libcmp
     0.00%   0.88%     0.00%   0.88%  uname    ld-2.28.so        [.] _dl_new_object
     0.00%  50.88%     0.00%   0.88%  uname    ld-2.28.so        [.] _dl_relocate_object
     0.00%   0.62%     0.00%   0.62%  uname    ld-2.28.so        [.] _dl_init_paths
     0.00%   0.62%     0.00%   0.62%  uname    ld-2.28.so        [.] _dl_name_match_p
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] get_common_indeces.constprop.1
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] memmove
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] memset
     0.00%   0.50%     0.00%   0.50%  uname    ld-2.28.so        [.] open_verify.constprop.11
     0.00%   0.38%     0.00%   0.38%  uname    ld-2.28.so        [.] _dl_check_all_versions
     0.00%   0.38%     0.00%   0.38%  uname    ld-2.28.so        [.] _dl_find_dso_for_object
     0.00%   0.38%     0.00%   0.38%  uname    ld-2.28.so        [.] init_tls
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] __tunable_get_val
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] _dl_add_to_namespace_list
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] _dl_determine_tlsoffset
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] _dl_discover_osversion
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] calloc@plt
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] malloc
     0.00%   0.25%     0.00%   0.25%  uname    ld-2.28.so        [.] malloc@plt
     0.00%   0.25%     0.00%   0.25%  uname    libc-2.28.so      [.] _nl_load_locale_from_archive
     0.00%   0.25%     0.00%   0.25%  uname    [unknown]         [k] 0xffffffffa3a00010
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] __libc_scratch_buffer_set_array_size
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_allocate_tls_storage
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_catch_exception
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_setup_hash
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_sort_maps
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] _dl_sysdep_read_whole_file
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] access
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] calloc
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] mmap64
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] openaux
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] rtld_lock_default_lock_recursive
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] rtld_lock_default_unlock_recursive
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] strchr
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] strlen
     0.00%   0.12%     0.00%   0.12%  uname    ld-2.28.so        [.] 0x0000000000001080
     0.00%   0.12%     0.00%   0.12%  uname    libc-2.28.so      [.] __strchrnul_avx2
     0.00%   0.12%     0.00%   0.12%  uname    libc-2.28.so      [.] _nl_normalize_codeset
     0.00%   0.12%     0.00%   0.12%  uname    libc-2.28.so      [.] malloc
     0.00%   0.12%     0.00%   0.12%  uname    [unknown]         [k] 0xffffffffa3a011f0
     0.00%  50.00%     0.00%   0.00%  uname    ld-2.28.so        [.] _dl_start_user
     0.00%  50.00%     0.00%   0.00%  uname    [unknown]         [.] 0000000000000000

 After:

 Samples: 800  of event 'branch-misses:u', Event count (approx.): 800
  Children      Self  Command  Shared Object     Symbol
    54.75%     4.75%  uname    ld-2.28.so        [.] dl_main
    51.50%     1.50%  uname    ld-2.28.so        [.] _dl_sysdep_start
    51.12%     1.12%  uname    ld-2.28.so        [.] _dl_start
    50.88%     0.88%  uname    ld-2.28.so        [.] _dl_relocate_object
    50.88%     1.12%  uname    ld-2.28.so        [.] do_lookup_x
    50.62%     1.00%  uname    ld-2.28.so        [.] _dl_lookup_symbol_x
    50.00%     0.00%  uname    ld-2.28.so        [.] _dl_start_user
    50.00%     0.00%  uname    [unknown]         [.] 0000000000000000
    47.50%    47.50%  uname    libc-2.28.so      [.] _dl_addr
    16.38%    16.38%  uname    ld-2.28.so        [.] __GI___tunables_init
     3.12%     3.12%  uname    ld-2.28.so        [.] _dl_map_object_from_fd
     2.38%     2.38%  uname    ld-2.28.so        [.] strcmp
     2.25%     2.25%  uname    ld-2.28.so        [.] _dl_check_map_versions
     2.00%     2.00%  uname    ld-2.28.so        [.] _dl_important_hwcaps
     2.00%     2.00%  uname    ld-2.28.so        [.] _dl_map_object_deps
     1.25%     1.25%  uname    ld-2.28.so        [.] _dl_load_cache_lookup
     1.00%     1.00%  uname    ld-2.28.so        [.] _dl_map_object
     1.00%     1.00%  uname    ld-2.28.so        [.] _dl_next_ld_env_entry
     0.88%     0.88%  uname    ld-2.28.so        [.] _dl_cache_libcmp
     0.88%     0.88%  uname    ld-2.28.so        [.] _dl_new_object
     0.62%     0.62%  uname    ld-2.28.so        [.] _dl_init_paths
     0.62%     0.62%  uname    ld-2.28.so        [.] _dl_name_match_p
     0.50%     0.50%  uname    ld-2.28.so        [.] get_common_indeces.constprop.1
     0.50%     0.50%  uname    ld-2.28.so        [.] memmove
     0.50%     0.50%  uname    ld-2.28.so        [.] memset
     0.50%     0.50%  uname    ld-2.28.so        [.] open_verify.constprop.11
     0.38%     0.38%  uname    ld-2.28.so        [.] _dl_check_all_versions
     0.38%     0.38%  uname    ld-2.28.so        [.] _dl_find_dso_for_object
     0.38%     0.38%  uname    ld-2.28.so        [.] init_tls
     0.25%     0.25%  uname    ld-2.28.so        [.] __tunable_get_val
     0.25%     0.25%  uname    ld-2.28.so        [.] _dl_add_to_namespace_list
     0.25%     0.25%  uname    ld-2.28.so        [.] _dl_determine_tlsoffset
     0.25%     0.25%  uname    ld-2.28.so        [.] _dl_discover_osversion
     0.25%     0.25%  uname    ld-2.28.so        [.] calloc@plt
     0.25%     0.25%  uname    ld-2.28.so        [.] malloc
     0.25%     0.25%  uname    ld-2.28.so        [.] malloc@plt
     0.25%     0.25%  uname    libc-2.28.so      [.] _nl_load_locale_from_archive
     0.25%     0.25%  uname    [unknown]         [k] 0xffffffffa3a00010
     0.12%     0.12%  uname    ld-2.28.so        [.] __libc_scratch_buffer_set_array_size
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_allocate_tls_storage
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_catch_exception
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_setup_hash
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_sort_maps
     0.12%     0.12%  uname    ld-2.28.so        [.] _dl_sysdep_read_whole_file
     0.12%     0.12%  uname    ld-2.28.so        [.] access
     0.12%     0.12%  uname    ld-2.28.so        [.] calloc
     0.12%     0.12%  uname    ld-2.28.so        [.] mmap64
     0.12%     0.12%  uname    ld-2.28.so        [.] openaux
     0.12%     0.12%  uname    ld-2.28.so        [.] rtld_lock_default_lock_recursive
     0.12%     0.12%  uname    ld-2.28.so        [.] rtld_lock_default_unlock_recursive
     0.12%     0.12%  uname    ld-2.28.so        [.] strchr
     0.12%     0.12%  uname    ld-2.28.so        [.] strlen
     0.12%     0.12%  uname    ld-2.28.so        [.] 0x0000000000001080
     0.12%     0.12%  uname    libc-2.28.so      [.] __strchrnul_avx2
     0.12%     0.12%  uname    libc-2.28.so      [.] _nl_normalize_codeset
     0.12%     0.12%  uname    libc-2.28.so      [.] malloc
     0.12%     0.12%  uname    [unknown]         [k] 0xffffffffa3a011f0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 60 ++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2c4ad6838766..b60bae8e395c 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1234,29 +1234,79 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 	return err;
 }
 
+static void unleader_evsel(struct evlist *evlist, struct evsel *leader)
+{
+	struct evsel *new_leader = NULL;
+	struct evsel *evsel;
+
+	/* Find new leader for the group */
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->leader != leader || evsel == leader)
+			continue;
+		if (!new_leader)
+			new_leader = evsel;
+		evsel->leader = new_leader;
+	}
+
+	/* Update group information */
+	if (new_leader) {
+		zfree(&new_leader->group_name);
+		new_leader->group_name = leader->group_name;
+		leader->group_name = NULL;
+
+		new_leader->core.nr_members = leader->core.nr_members - 1;
+		leader->core.nr_members = 1;
+	}
+}
+
+static void unleader_auxtrace(struct perf_session *session)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		if (auxtrace__evsel_is_auxtrace(session, evsel) &&
+		    perf_evsel__is_group_leader(evsel)) {
+			unleader_evsel(session->evlist, evsel);
+		}
+	}
+}
+
 int perf_event__process_auxtrace_info(struct perf_session *session,
 				      union perf_event *event)
 {
 	enum auxtrace_type type = event->auxtrace_info.type;
+	int err;
 
 	if (dump_trace)
 		fprintf(stdout, " type: %u\n", type);
 
 	switch (type) {
 	case PERF_AUXTRACE_INTEL_PT:
-		return intel_pt_process_auxtrace_info(event, session);
+		err = intel_pt_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_INTEL_BTS:
-		return intel_bts_process_auxtrace_info(event, session);
+		err = intel_bts_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_ARM_SPE:
-		return arm_spe_process_auxtrace_info(event, session);
+		err = arm_spe_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_CS_ETM:
-		return cs_etm__process_auxtrace_info(event, session);
+		err = cs_etm__process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_S390_CPUMSF:
-		return s390_cpumsf_process_auxtrace_info(event, session);
+		err = s390_cpumsf_process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
 	}
+
+	if (err)
+		return err;
+
+	unleader_auxtrace(session);
+
+	return 0;
 }
 
 s64 perf_event__process_auxtrace(struct perf_session *session,
-- 
2.21.1
