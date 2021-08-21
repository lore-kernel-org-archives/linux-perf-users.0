Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D30C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C79961178
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhHUJmX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhHUJmW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:42:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D34C061757;
        Sat, 21 Aug 2021 02:41:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z20so25254508ejf.5;
        Sat, 21 Aug 2021 02:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=FHmrLvebUn+JAncIxDYg8TyCkLepWt1lPSU8TIwqV40=;
        b=Gqx/Wg6CdzW6WQscg8J58pBj6+xTvC6X+bI+gg+lYSP1lkDZnd9HP1UV8m04j0l/Yx
         9EV+oKlxfbagVqfVYDAw0rr3meiPIVDc2zKWkqcCXfmY6oFkrTVbeRmhEsNJ/EqZZ2wg
         nq63IPIxi8voN1h0O3t0UxGqsdA4VFG85EPv6ywded/YjNOmLCDB3iwS/5W4+gMCT/X/
         5CkqqTW7d9ANMzhrELgFrKk2/o7S6OQh2aCY4bsOjEKN1fYrLKI4ohLDPVh5Cqi17u3r
         K8wCJdM4qCS7G+vk3BoJzOx/C8jQ3iwhSTZOmv9QpqCT+fUE4hBnuysKPKG6xToEmpeC
         F08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=FHmrLvebUn+JAncIxDYg8TyCkLepWt1lPSU8TIwqV40=;
        b=oMNrC0n3KZGqweVWR3FUp2dxtiLlfhmcpZnKt9T0VKDI/DJ/IWOcJaB+jSJzs6n+eR
         HvE9fYCkNNg0D9bBmqEUpg8X2ehjWSbMBi+b1BpurIR7IK5q+ooMFqv0zj10+qwtHJYX
         /i2l9L6gNY+ncsSBkb/meGgVuzm/sFkPqtY82w+epDJ6jBHXuHuk9csoCNW9WqmY2SNt
         kWtXVYV6kLKsAe2sGvYxEaedmZkxj+p+4CTig/LwcByPSCgQronHJz5WUsZYtxLqlFyf
         CSWB2fwo4aAnUKqxQRFctPMopuAisExG1thVRJrR8WLw5JTtCCqUVm4mP4Ieem4rAWQv
         ubNA==
X-Gm-Message-State: AOAM5337ijiGi7muBPlAleRbJ0nntoL7sgqA8Me6KpbmDYi4VeqNF640
        yN2iSWmvEIyAR814UKssoFs=
X-Google-Smtp-Source: ABdhPJwM/gPxGmLHisuAYxR0mTEgzqbXtyGtYdBlS+OlbIQru/jI7BfUQKiGum1eLFyvks0QuviiTg==
X-Received: by 2002:a17:906:405:: with SMTP id d5mr25740758eja.189.1629538901378;
        Sat, 21 Aug 2021 02:41:41 -0700 (PDT)
Received: from [192.168.43.131] (mob-37-181-141-79.net.vodafone.it. [37.181.141.79])
        by smtp.gmail.com with ESMTPSA id t12sm3713910ejc.63.2021.08.21.02.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:41:40 -0700 (PDT)
Message-ID: <3c4f8dd64d07373d876990ceb16e469b4029363f.camel@gmail.com>
Subject: [GSoC] Multi-threading in perf: Final Report
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Date:   Sat, 21 Aug 2021 11:41:39 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

this is the final report of my project "Multi-threading in perf",
developed as part of the Google Summer of Code with the Linux Foundation.
https://summerofcode.withgoogle.com/projects/#4670070929752064

The final outcome of my project is a new utility library in perf for
asynchronous execution of tasks. This new abstraction follows the kernel's
workqueue API. This utility is then used to replace the manual
perf synthesis threads and to add multithreading to the evlist 
operations (open, enable, disable, and close lists of perf events).
At the moment, not all features of the kernel workqueue are supported
(e.g. no work chaining), since I focused on the features that I needed
for implementing the aforementioned features. Hopefully, in the future,
the library would be tested and improved and could be moved to tools/lib
for other tools to use it.

The results I obtained from testing on my machines are promising, but the
patchset needs a more thorough test on bigger machines, since that is 
the use case for which parallelization is being introduced in the first
place.

I would be very happy to continue working on this in the future to help my
project get merged, when it will be deemed ready. However, in the next weeks I
will not have enough time to do so, since I need to complete a couple of things
before graduation.

Below you can find a breakdown of my activities during GSoC with links to
the original emails on lkml (refer to those for more details about the
workqueue and how to use it), i.e.:
 - the main project patchsets I sent in these last days;
 - other patches I sent during the GSoC, mainly fixing memory bugs;
 - review activity.

Finally, I would like to thank my mentors -- Ian, Arnaldo, and Namhyung --
for all the precious time they dedicated to me, for their useful
suggestions, and for the overall GSoC experience, which was really great.

Thanks,
Riccardo

---

Project patchsets:
PATCHSET perf: add workqueue library and use it in synthetic-events
  Status: v3
  Link: https://lore.kernel.org/lkml/cover.1629454773.git.rickyman7@gmail.com/
  [01/15] perf workqueue: threadpool creation and destruction
  [02/15] perf tests: add test for workqueue
  [03/15] perf workqueue: add threadpool start and stop functions
  [04/15] perf workqueue: add threadpool execute and wait functions
  [05/15] tools: add sparse context/locking annotations in compiler-types.h
  [06/15] perf workqueue: introduce workqueue struct
  [07/15] perf workqueue: implement worker thread and management
  [08/15] perf workqueue: add queue_work and flush_workqueue functions
  [09/15] perf workqueue: spinup threads when needed
  [10/15] perf workqueue: create global workqueue
  [11/15] perf workqueue: add utility to execute a for loop in parallel
  [12/15] perf record: setup global workqueue
  [13/15] perf top: setup global workqueue
  [14/15] perf test/synthesis: setup global workqueue
  [15/15] perf synthetic-events: use workqueue parallel_for
PATCHSET perf: use workqueue for evlist operations
  Status: v1, not reviewed
  Link: https://lore.kernel.org/lkml/cover.1629490974.git.rickyman7@gmail.com/
  [01/37] libperf cpumap: improve idx function
  [02/37] libperf cpumap: improve max function
  [03/37] perf evlist: replace evsel__cpu_iter* functions with evsel__find_cpu
  [04/37] perf util: add mmap_cpu_mask__duplicate function
  [05/37] perf util/mmap: add missing bitops.h header
  [06/37] perf workqueue: add affinities to threadpool
  [07/37] perf workqueue: add support for setting affinities to workers
  [08/37] perf workqueue: add method to execute work on specific CPU
  [09/37] perf python: add workqueue dependency
  [10/37] perf evlist: add multithreading helper
  [11/37] perf evlist: add multithreading to evlist__disable
  [12/37] perf evlist: add multithreading to evlist__enable
  [13/37] perf evlist: add multithreading to evlist__close
  [14/37] perf evsel: remove retry_sample_id goto label
  [15/37] perf evsel: separate open preparation from open itself
  [16/37] perf evsel: save open flags in evsel
  [17/37] perf evsel: separate missing feature disabling from evsel__open_cpu
  [18/37] perf evsel: add evsel__prepare_open function
  [19/37] perf evsel: separate missing feature detection from evsel__open_cpu
  [20/37] perf evsel: separate rlimit increase from evsel__open_cpu
  [21/37] perf evsel: move ignore_missing_thread to fallback code
  [22/37] perf evsel: move test_attr__open to success path in evsel__open_cpu
  [23/37] perf evsel: move bpf_counter__install_pe to success path in evsel__open_cpu
  [24/37] perf evsel: handle precise_ip fallback in evsel__open_cpu
  [25/37] perf evsel: move event open in evsel__open_cpu to separate function
  [26/37] perf evsel: add evsel__open_per_cpu_no_fallback function
  [27/37] perf evlist: add evlist__for_each_entry_from macro
  [28/37] perf evlist: add multithreading to evlist__open
  [29/37] perf evlist: add custom fallback to evlist__open
  [30/37] perf record: use evlist__open_custom
  [31/37] tools lib/subcmd: add OPT_UINTEGER_OPTARG option type
  [32/37] perf record: add --threads option
  [33/37] perf record: pin threads to monitored cpus if enough threads available
  [34/37] perf record: apply multithreading in init and fini phases
  [35/37] perf test/evlist-open-close: add multithreading
  [36/37] perf test/evlist-open-close: use inline func to convert timeval to usec
  [37/37] perf test/evlist-open-close: add detailed output mode


Other patches:
Merged patches:
da963834fe6975a1 perf test: Iterate over shell tests in alphabetical order
  Link: http://lore.kernel.org/lkml/20210525230521.244553-1-rickyman7@gmail.com
69c9ffed6cede9c1 perf symbol-elf: Fix memory leak by freeing sdt_note.args
  Link: http://lore.kernel.org/lkml/20210602220833.285226-1-rickyman7@gmail.com
67069a1f0fe5f9ee perf env: Fix memory leak of bpf_prog_info_linear member
  Link: http://lore.kernel.org/lkml/20210602224024.300485-1-rickyman7@gmail.com
c087e9480cf33672 perf machine: Fix refcount usage when processing PERF_RECORD_KSYMBOL
  Link: http://lore.kernel.org/lkml/20210612173751.188582-1-rickyman7@gmail.com
6de249d66d2e7881 perf annotate: Allow 's' on source code lines
  Link: http://lore.kernel.org/lkml/20210624223423.189550-1-rickyman7@gmail.com
cf96b8e45a9bf74d perf session: Add missing evlist__delete when deleting a session
  Link: http://lore.kernel.org/lkml/20210624231926.212208-1-rickyman7@gmail.com
5a4451e4d562d5c3 perf annotate: Fix 's' on source line when disasm is empty
  Link: http://lore.kernel.org/lkml/20210705161524.72953-1-rickyman7@gmail.com
83952286f2683716 perf top: Fix overflow in elf_sec__is_text()
  Link: http://lore.kernel.org/lkml/20210621222108.196219-1-rickyman7@gmail.com
eb7261f14e1a86f0 perf test: Add free() calls for scandir() returned dirent entries
  Link: http://lore.kernel.org/lkml/20210709163454.672082-1-rickyman7@gmail.com
PATCHSET         perf: fix several memory leaks reported by ASan on perf-test
  Link: https://lore.kernel.org/lkml/cover.1626343282.git.rickyman7@gmail.com/
  0967ebffe0981571 perf inject: Fix dso->nsinfo refcounting
  2d6b74baa7147251 perf map: Fix dso->nsinfo refcounting
  dedeb4be203b382b perf probe: Fix dso->nsinfo refcounting
  42db3d9ded555f71 perf env: Fix sibling_dies memory leak
  233f2dc1c2843372 perf test session_topology: Delete session->evlist
  fc56f54f6fcd5337 perf test event_update: Fix memory leak of evlist
  dccfca926c351ba0 perf test event_update: Fix memory leak of unit
  581e295a0f6b5c29 perf dso: Fix memory leak in dso__new_map()
  244d1797c8c8e850 perf test maps__merge_in: Fix memory leak of maps
  da6b7c6c06269014 perf env: Fix memory leak of cpu_pmu_caps
  a37338aad8c4d867 perf report: Free generated help strings for sort option
  02e6246f5364d526 perf inject: Close inject.output on exit
  423b9174f5f71fd3 perf session: Cleanup trace_event
  1b1f57cf9e4c8eb1 perf script: Release zstd data
  faf3ac305d61341c perf script: Fix memory 'threads' and 'cpus' leaks on exit
  f8cbb0f926ae1e1f perf lzma: Close lzma stream on exit
  6c7f0ab04707c288 perf trace: Free malloc'd trace fields on exit
  f2ebf8ffe7af10bf perf trace: Free syscall->arg_fmt
  3cb4d5e00e037c70 perf trace: Free syscall tp fields in evsel->priv
  659ede7d13f1cc37 perf trace: Free strings in trace__parse_events_option()
  937654ce497fb6e9 perf test bpf: Free obj_buf
  e0fa7ab42232e742 perf probe-file: Delete namelist in del_events() on the error path
d4b3eedce151e639 perf data: Close all files in close_dir()
  Link: http://lore.kernel.org/lkml/20210716141122.858082-1-rickyman7@gmail.com
4241eabf59d5b7e9 perf bench: Add benchmark for evlist open/close operations
  Link: http://lore.kernel.org/lkml/20210809201101.277594-1-rickyman7@gmail.com

Unmerged patches:
PATCH    perf: fix segfault when wrong option for --debug is provided
  Link: https://lore.kernel.org/lkml/20210531212828.240077-1-rickyman7@gmail.com/
  Status: rejected, already fixed in earlier patch by Ian
PATCHSET tools: add gettid to libc_compat.h
  Link: https://lore.kernel.org/lkml/cover.1626966805.git.rickyman7@gmail.com/
  Status: withdrawn due to compilation issues in BPF 
  [01/03] tools libc_compat: add gettid
  [02/03] perf jvmti: use gettid from libc_compat
  [03/03] perf test: mmap-thread-lookup: use gettid
PATCH    perf test: make --skip work on shell tests
  Link: https://lore.kernel.org/lkml/20210811180625.160944-1-rickyman7@gmail.com/
  Status: accepted
PATCH    perf tests: dlfilter: free desc and long_desc in check_filter_desc
  Link: https://lore.kernel.org/lkml/20210820113132.724034-1-rickyman7@gmail.com/
  Status: accepted
PATCH    perf config: fix caching and memory leak in perf_home_perfconfig
  Link: https://lore.kernel.org/lkml/20210820130817.740536-1-rickyman7@gmail.com/
  Status: needs improvement

Unsent patches:
PATCHSET perf mmaps: grab refcount in maps__find
  Link: https://github.com/Manciukic/linux/commits/perf/mem-leaks/patches/grab-refcnt-in-maps-find
  Status: never sent due to difficulty in testing such big change. Some commits 
          have been cherry-picked in other (approved) patchsets.
  [01/17] perf: prepare space for exit statements in preparation for maps__find to grab a refcnt
  [02/17] perf: have maps__find grab a refcount on map while holding the lock
  [03/17] perf: propagate refcnt'ed map from maps__find_symbol
  [04/17] perf: propagate refcnt'ed map from maps__find_ams
  [05/17] perf: rename addr_location__put to addr_location__put_members
  [06/17] perf: add refcounts to addr_location members
  [07/17] perf: add addr_location__put_members
  [08/17] perf: return refcnt'ed map from maps__find_symbol_by_name
  [09/17] perf: return refcnt'ed map from kernel_get_ref_reloc_sym
  [10/17] perf: unwind: return refcnt'ed map from find_map
  [11/17] perf: add utility functions to put members of branch_info and map_symbol
  [12/17] perf: fix refcounting on he->mem_info
  [13/17] perf: add missing puts on branch_info
  [14/17] perf: unwind-libdw: add refcounts to map_symbol in ui->entries
  [15/17] perf: hist: fix refcounts for he->ms
  [16/17] perf: nsinfo: fix refcounting
  [17/17] perf: missing map__put in arch__post_process_probe_trace_events
PATCH      perf: add read lock in maps__first 
  Link: https://github.com/Manciukic/linux/commit/d1a46bcdd3447ad56cb54fdd3a21a280eab3cd4f
  Status: ready to send
PATCH       perf: ensure that a read lock is held when looping over maps entries 
  Link: https://github.com/Manciukic/linux/commit/ad948ef8e771c1ab03838c92afd3c2690019c694
  Status: needs splitting


Review activity:
PATCHSET Introduce threaded trace streaming for basic perf record operation
  Link: https://lore.kernel.org/lkml/cover.1629186429.git.alexey.v.bayduraev@linux.intel.com/
  Contribution: helped in fixing some bugs, performed extensive testing
PATCHSET perf tools: Add PMU alias support
  Link: https://lore.kernel.org/lkml/20210729070619.20726-1-yao.jin@linux.intel.com/
  Link: https://lore.kernel.org/lkml/20210729070619.20726-1-yao.jin@linux.intel.com/
  Contribution: helped in fixing some memory bugs


