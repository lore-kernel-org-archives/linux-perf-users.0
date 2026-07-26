Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDFD32936C;
	Sun, 26 Jul 2026 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785108135; cv=none; b=PAV3djK4QrTDGsRUw+7e2VVP9GEjvv/rba5euhRtJtDl9lWvrrU6nSv57gAzhDDQ8uIPJz3f2XtGKLq07/7D27RW4fX1F/oVd4SITiAeu5YXxiBf99SM16S2Djgtbe6J04zlQ53Uqr0BzFnMhGMs3LkxindVqKfWXD2pYoUut+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785108135; c=relaxed/simple;
	bh=j6S152pLQ4Y28ygX3/OwAGb/P7eXgoftUG7CCU6iQVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TvnsUSBWZSOaqZKHADM7I1/rekzmBO1mWBEJr0J8ysc2f5cEvGyvNTiZPpcU0Yl26PQ/wbzoy6AUSY8kSXOlj52fXgjwHfp2nJz5fTJ+Amk88RltRLk/IpInqghOBvnuUmoEyp9A9OqBD9zNJTCs0whJklC3dhmOnjCMyuXEUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeXvRFuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeXvRFuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF881F000E9;
	Sun, 26 Jul 2026 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785108133;
	bh=Zt39pFYIQMqqek7dgutmm6zzaOq6y7hQGDPRmfGUOEo=;
	h=Date:From:To:Cc:Subject;
	b=TeXvRFuc/KJC2IeRqM9RGwbSWDNRHU89ktpXh2pXWR3Ne+F3IQjBPvZU2JWTN4dm5
	 /9VLd04Q2r5w88/TfLXuG/HIjzooAMfeqgHXei4igpJ5Fhls2y2ZfniOfya14rVoFt
	 JDoSip4yj8eT1OMABH8LrbTEzMskZpyuJ6zdSP0B7vSPILQTEbTgUQ2IAFUo90Wd00
	 XyRzYqsDbtzEQ1dy9BZ4S/Yx4TYNHOrpnv7cCR/+ysFSfUZLKtBCXQ34TwCnmpFYBk
	 FpHO5OMLcQeDTbRtaikxZMgvXWksRKy1N/9GvDL2aCjhinYV34slPn4d4sR+1fMzvQ
	 PCg4mtKAA9eNw==
Date: Sun, 26 Jul 2026 20:22:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian McDonald <ian.mcdonald@jandi.co.nz>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Flaky tests
Message-ID: <amaWoGWxQ4Z4iNPk@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

	Getting back on track with perf I noticed these two flaky tests,
not investigated yet:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1
98bc7deff4858aa8 (HEAD -> perf/hardening-machine, number/perf/hardening-machine) perf machine: Check snprintf truncation for guest kallsyms path
⬢ [acme@toolbx perf-tools-next]$ perf -v
perf version 7.2.rc1.g98bc7deff485
⬢ [acme@toolbx perf-tools-next]$
logout
acme@x1:~/git/perf-tools-next$
acme@x1:~/git/perf-tools-next$ sudo su -
[sudo] password for acme:
root@x1:~# perf -vv
perf version 7.2.rc1.g98bc7deff485
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
babeltrace2-ctf-writer: [ on  ]  # HAVE_BABELTRACE2_CTF_WRITER_SUPPORT
        libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT ( tip: Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it )
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                  rust: [ on  ]  # HAVE_RUST_SUPPORT
root@x1:~# perf test
  1: vmlinux symtab matches kallsyms                                                                           : Ok
  2: Detect openat syscall event                                                                               : Ok
  3: Detect openat syscall event on all cpus                                                                   : Ok
  4: Test data source output                                                                                   : Ok
  5: Parse event definition strings                                                                            :
  5.1: Test event parsing                                                                                      : Ok
  5.2: Parsing of all PMU events from sysfs                                                                    : Ok
  5.3: Parsing of given PMU events from sysfs                                                                  : Ok
  5.4: Parsing of aliased events from sysfs                                                                    : Skip (no aliases in sysfs)
  5.5: Parsing of aliased events                                                                               : Ok
  5.6: Parsing of terms (event modifiers)                                                                      : Ok
  6: Uncore event sorting                                                                                      : Ok
  7: Simple expression parser                                                                                  : Ok
  8: PERF_RECORD_* events & perf_sample fields                                                                 : Ok
  9: Sysfs PMU tests                                                                                           :
  9.1: Parsing with PMU format directory                                                                       : Ok
  9.2: Parsing with PMU event                                                                                  : Ok
  9.3: PMU event names                                                                                         : Ok
  9.4: PMU name combining                                                                                      : Ok
  9.5: PMU name comparison                                                                                     : Ok
  9.6: PMU cmdline match                                                                                       : Ok
  9.7: PMU config helpers                                                                                      : Ok
 10: PMU JSON event tests                                                                                      :
 10.1: PMU event table sanity                                                                                  : Ok
 10.2: PMU event map aliases                                                                                   : Ok
 10.3: Parsing of static metrics with fake PMU                                                                 : Ok
 10.4: Parsing of metric thresholds with fake PMU                                                              : Ok
 10.5: PMU metric parsing: common                                                                              : Ok
 10.6: PMU metric parsing with fake PMU: common                                                                : Ok
 10.7: PMU metric parsing: test_soc_cpu                                                                        : Ok
 10.8: PMU metric parsing with fake PMU: test_soc_cpu                                                          : Ok
 10.9: PMU metric parsing: alderlake                                                                           : Ok
 10.10: PMU metric parsing with fake PMU: alderlake                                                            : Ok
 10.11: PMU metric parsing: alderlaken                                                                         : Ok
 10.12: PMU metric parsing with fake PMU: alderlaken                                                           : Ok
 10.13: PMU metric parsing: arrowlake                                                                          : Ok
 10.14: PMU metric parsing with fake PMU: arrowlake                                                            : Ok
 10.15: PMU metric parsing: bonnell                                                                            : Ok
 10.16: PMU metric parsing with fake PMU: bonnell                                                              : Ok
 10.17: PMU metric parsing: broadwell                                                                          : Ok
 10.18: PMU metric parsing with fake PMU: broadwell                                                            : Ok
 10.19: PMU metric parsing: broadwellde                                                                        : Ok
 10.20: PMU metric parsing with fake PMU: broadwellde                                                          : Ok
 10.21: PMU metric parsing: broadwellx                                                                         : Ok
 10.22: PMU metric parsing with fake PMU: broadwellx                                                           : Ok
 10.23: PMU metric parsing: cascadelakex                                                                       : Ok
 10.24: PMU metric parsing with fake PMU: cascadelakex                                                         : Ok
 10.25: PMU metric parsing: clearwaterforest                                                                   : Ok
 10.26: PMU metric parsing with fake PMU: clearwaterforest                                                     : Ok
 10.27: PMU metric parsing: elkhartlake                                                                        : Ok
 10.28: PMU metric parsing with fake PMU: elkhartlake                                                          : Ok
 10.29: PMU metric parsing: emeraldrapids                                                                      : Ok
 10.30: PMU metric parsing with fake PMU: emeraldrapids                                                        : Ok
 10.31: PMU metric parsing: goldmont                                                                           : Ok
 10.32: PMU metric parsing with fake PMU: goldmont                                                             : Ok
 10.33: PMU metric parsing: goldmontplus                                                                       : Ok
 10.34: PMU metric parsing with fake PMU: goldmontplus                                                         : Ok
 10.35: PMU metric parsing: grandridge                                                                         : Ok
 10.36: PMU metric parsing with fake PMU: grandridge                                                           : Ok
 10.37: PMU metric parsing: graniterapids                                                                      : Ok
 10.38: PMU metric parsing with fake PMU: graniterapids                                                        : Ok
 10.39: PMU metric parsing: haswell                                                                            : Ok
 10.40: PMU metric parsing with fake PMU: haswell                                                              : Ok
 10.41: PMU metric parsing: haswellx                                                                           : Ok
 10.42: PMU metric parsing with fake PMU: haswellx                                                             : Ok
 10.43: PMU metric parsing: icelake                                                                            : Ok
 10.44: PMU metric parsing with fake PMU: icelake                                                              : Ok
 10.45: PMU metric parsing: icelakex                                                                           : Ok
 10.46: PMU metric parsing with fake PMU: icelakex                                                             : Ok
 10.47: PMU metric parsing: ivybridge                                                                          : Ok
 10.48: PMU metric parsing with fake PMU: ivybridge                                                            : Ok
 10.49: PMU metric parsing: ivytown                                                                            : Ok
 10.50: PMU metric parsing with fake PMU: ivytown                                                              : Ok
 10.51: PMU metric parsing: jaketown                                                                           : Ok
 10.52: PMU metric parsing with fake PMU: jaketown                                                             : Ok
 10.53: PMU metric parsing: knightslanding                                                                     : Ok
 10.54: PMU metric parsing with fake PMU: knightslanding                                                       : Ok
 10.55: PMU metric parsing: lunarlake                                                                          : Ok
 10.56: PMU metric parsing with fake PMU: lunarlake                                                            : Ok
 10.57: PMU metric parsing: meteorlake                                                                         : Ok
 10.58: PMU metric parsing with fake PMU: meteorlake                                                           : Ok
 10.59: PMU metric parsing: nehalemep                                                                          : Ok
 10.60: PMU metric parsing with fake PMU: nehalemep                                                            : Ok
 10.61: PMU metric parsing: nehalemex                                                                          : Ok
 10.62: PMU metric parsing with fake PMU: nehalemex                                                            : Ok
 10.63: PMU metric parsing: pantherlake                                                                        : Ok
 10.64: PMU metric parsing with fake PMU: pantherlake                                                          : Ok
 10.65: PMU metric parsing: rocketlake                                                                         : Ok
 10.66: PMU metric parsing with fake PMU: rocketlake                                                           : Ok
 10.67: PMU metric parsing: sandybridge                                                                        : Ok
 10.68: PMU metric parsing with fake PMU: sandybridge                                                          : Ok
 10.69: PMU metric parsing: sapphirerapids                                                                     : Ok
 10.70: PMU metric parsing with fake PMU: sapphirerapids                                                       : Ok
 10.71: PMU metric parsing: sierraforest                                                                       : Ok
 10.72: PMU metric parsing with fake PMU: sierraforest                                                         : Ok
 10.73: PMU metric parsing: silvermont                                                                         : Ok
 10.74: PMU metric parsing with fake PMU: silvermont                                                           : Ok
 10.75: PMU metric parsing: skylake                                                                            : Ok
 10.76: PMU metric parsing with fake PMU: skylake                                                              : Ok
 10.77: PMU metric parsing: skylakex                                                                           : Ok
 10.78: PMU metric parsing with fake PMU: skylakex                                                             : Ok
 10.79: PMU metric parsing: snowridgex                                                                         : Ok
 10.80: PMU metric parsing with fake PMU: snowridgex                                                           : Ok
 10.81: PMU metric parsing: tigerlake                                                                          : Ok
 10.82: PMU metric parsing with fake PMU: tigerlake                                                            : Ok
 10.83: PMU metric parsing: westmereep_dp                                                                      : Ok
 10.84: PMU metric parsing with fake PMU: westmereep_dp                                                        : Ok
 10.85: PMU metric parsing: westmereep_sp                                                                      : Ok
 10.86: PMU metric parsing with fake PMU: westmereep_sp                                                        : Ok
 10.87: PMU metric parsing: westmereex                                                                         : Ok
 10.88: PMU metric parsing with fake PMU: westmereex                                                           : Ok
 10.89: PMU metric parsing: novalake                                                                           : Ok
 10.90: PMU metric parsing with fake PMU: novalake                                                             : Ok
 10.91: PMU metric parsing: amdzen1                                                                            : Ok
 10.92: PMU metric parsing with fake PMU: amdzen1                                                              : Ok
 10.93: PMU metric parsing: amdzen2                                                                            : Ok
 10.94: PMU metric parsing with fake PMU: amdzen2                                                              : Ok
 10.95: PMU metric parsing: amdzen3                                                                            : Ok
 10.96: PMU metric parsing with fake PMU: amdzen3                                                              : Ok
 10.97: PMU metric parsing: amdzen4                                                                            : Ok
 10.98: PMU metric parsing with fake PMU: amdzen4                                                              : Ok
 10.99: PMU metric parsing: amdzen5                                                                            : Ok
 10.100: PMU metric parsing with fake PMU: amdzen5                                                             : Ok
 10.101: PMU metric parsing: amdzen6                                                                           : Ok
 10.102: PMU metric parsing with fake PMU: amdzen6                                                             : Ok
 11: Hwmon PMU                                                                                                 :
 11.1: Basic parsing test                                                                                      : Ok
 11.2: Parsing without PMU name                                                                                : Ok
 11.3: Parsing with PMU name                                                                                   : Ok
 12: Tool PMU                                                                                                  :
 12.1: Parsing without PMU name                                                                                : Ok
 12.2: Parsing with PMU name                                                                                   : Ok
 13: DSO data tests                                                                                            :
 13.1: read                                                                                                    : Ok
 13.2: cache                                                                                                   : Ok
 13.3: reopen                                                                                                  : Ok
 14: Roundtrip evsel->name                                                                                     : Ok
 15: Parse sched tracepoints fields                                                                            : Ok
 16: syscalls:sys_enter_openat event fields                                                                    : Ok
 17: Match and link multiple hists                                                                             : Ok
 18: Breakpoint overflow signal handler                                                                        : Ok
 19: Breakpoint overflow sampling                                                                              : Ok
 20: Breakpoint accounting                                                                                     : Ok
 21: Watchpoint                                                                                                :
 21.1: Read Only Watchpoint                                                                                    : Skip (missing hardware support)
 21.2: Write Only Watchpoint                                                                                   : Ok
 21.3: Read / Write Watchpoint                                                                                 : Ok
 21.4: Modify Watchpoint                                                                                       : Ok
 22: Software clock events period values                                                                       : Ok
 23: Object code reading                                                                                       : FAILED!
 24: Sample parsing                                                                                            : Ok
 25: Use a dummy software event to keep tracking                                                               : Ok
 26: Parse with no sample_id_all bit set                                                                       : Ok
 27: Filter hist entries                                                                                       : Ok
 28: Lookup mmap thread                                                                                        : Ok
 29: Share thread maps                                                                                         : Ok
 30: Sort output of hist entries                                                                               : Ok
 31: Cumulate child hist entries                                                                               : Ok
 32: Filter fds with revents mask in a fdarray                                                                 : Ok
 33: Add fd to a fdarray, making it autogrow                                                                   : Ok
 34: kmod_path__parse                                                                                          : Ok
 35: Thread map                                                                                                : Ok
 36: Session topology                                                                                          : Ok
 37: Synthesize thread map                                                                                     : Ok
 38: Remove thread map                                                                                         : Ok
 39: CPU map                                                                                                   :
 39.1: Synthesize cpu map                                                                                      : Ok
 39.2: Print cpu map                                                                                           : Ok
 39.3: Merge cpu map                                                                                           : Ok
 39.4: Intersect cpu map                                                                                       : Ok
 39.5: Equal cpu map                                                                                           : Ok
 40: Synthesize stat config                                                                                    : Ok
 41: Synthesize stat                                                                                           : Ok
 42: Synthesize stat round                                                                                     : Ok
 43: Synthesize attr update                                                                                    : Ok
 44: Event times                                                                                               : Ok
 45: Read backward ring buffer                                                                                 : Ok
 46: Probe SDT events                                                                                          : Ok
 47: is_printable_array                                                                                        : Ok
 48: Print bitmap                                                                                              : Ok
 49: perf hooks                                                                                                : Ok
 50: unit_number__scnprintf                                                                                    : Ok
 51: mem2node                                                                                                  : Ok
 52: time utils                                                                                                : Ok
 53: Test jit_write_elf                                                                                        : Ok
 54: Test libpfm4 support                                                                                      :
 54.1: test of individual --pfm-events                                                                         : Ok
 54.2: test groups of --pfm-events                                                                             : Ok
 55: Test api io                                                                                               : Ok
 56: Maps - per process mmaps abstraction                                                                      :
 56.1: Test merge_in interface                                                                                 : Ok
 56.2: Test fix up overlap interface                                                                           : Ok
 57: Demangle Java                                                                                             : Ok
 58: Demangle OCaml                                                                                            : Ok
 59: Demangle Rust                                                                                             : Ok
 60: Parse and process metrics                                                                                 : Ok
 61: PE file support                                                                                           : Skip
 62: Event expansion for cgroups                                                                               : Ok
 63: Convert perf time to TSC                                                                                  :
 63.1: TSC support                                                                                             : Ok
 63.2: Perf time to TSC                                                                                        : Ok
 64: dlfilter C API                                                                                            : Ok
 65: Sigtrap                                                                                                   : Ok
 66: Event groups                                                                                              : Ok
 67: Symbols                                                                                                   : Ok
 68: util                                                                                                      :
 68.1: String replacement                                                                                      : Ok
 68.2: BLAKE2s hash                                                                                            : Ok
 69: libsubcmd help tests                                                                                      :
 69.1: Load subcmd names                                                                                       : Ok
 69.2: Uniquify subcmd names                                                                                   : Ok
 69.3: Exclude duplicate subcmd names                                                                          : Ok
 69.4: Exclude disjoint subcmd names                                                                           : Ok
 70: split kallsyms                                                                                            : Ok
 71: Test dwarf unwind                                                                                         : Ok
 72: Intel PT                                                                                                  :
 72.1: Intel PT packet decoder                                                                                 : Ok
 72.2: Intel PT hybrid CPU compatibility                                                                       : Ok
 73: x86 bp modify                                                                                             : Ok
 74: AMD IBS via core pmu                                                                                      : Skip
 75: x86 hybrid event parsing                                                                                  : Ok
 76: x86 topdown                                                                                               :
 76.1: topdown events                                                                                          : Ok
 76.2: topdown sorting                                                                                         : Ok
 76.3: topdown slots injection                                                                                 : Ok
 77: test addr2line inline unwinding                                                                           : Ok
 78: AMD IBS software filtering                                                                                : Skip
 79: perf annotate basic tests                                                                                 : Ok
 80: Perf attribute expectations test                                                                          : Ok
 81: build id cache operations                                                                                 : Ok
 82: perf c2c tests                                                                                            : Ok
 83: init.sh                                                                                                   : Ok
 84: Number                                                                                                    : Ok
 85: settings.sh                                                                                               : Ok
 86: daemon operations                                                                                         : Ok
 87: Test that perf report includes file offsets and event type names in diagnostic messages.                  : Ok
 88: perf data type profiling tests                                                                            : Ok
 89: Test that perf report handles truncated perf.data gracefully (no crash, no segfault — clean error exit).: Ok
 90: perf diff tests                                                                                           : Ok
 91: DRM PMU                                                                                                   : Ok
 92: perf evlist tests                                                                                         : Ok
 93: perf ftrace tests                                                                                         : Ok
 94: perf header tests                                                                                         : Ok
 95: perf inject to convert DWARF callchains to regular ones                                                   : Ok
 96: perf inject --aslr test                                                                                   : Ok
 97: python profiling with jitdump                                                                             : Ok
 98: perf kallsyms tests                                                                                       : Ok
 99: perf kvm tests                                                                                            : Ok
100: perf kwork tests                                                                                          : Ok
101: perf list tests                                                                                           : Ok
102: kernel lock contention analysis test                                                                      : Ok
103: perf report --hierarchy                                                                                   : Ok
104: perf sched stats tests                                                                                    : Ok
105: perf pipe recording and injection test                                                                    : Ok
106: 'import perf' in python                                                                                   : Ok
107: Zstd perf.data compression/decompression                                                                  : Ok
108: Zstd perf.data compression/decompression of multi-record data                                             : Skip
109: perf record tests                                                                                         : Ok
110: perf record sample filtering (by BPF) tests                                                               : FAILED!
111: perf record LBR tests                                                                                     : Ok
112: perf record sideband tests                                                                                : Ok
113: record weak terms                                                                                         : Ok
114: perf sched tests                                                                                          : Ok
115: perf script tests                                                                                         : Ok
116: perf script --dlfilter tests                                                                              : Skip
117: perf script perl tests                                                                                    : Skip
118: perf script python tests                                                                                  : Ok
119: perf stat CSV output linter                                                                               : Ok
120: perf stat csv summary test                                                                                : Ok
121: perf stat events uniquifying                                                                              : Ok
122: perf stat JSON output linter                                                                              : Ok
123: perf stat metrics (shadow stat) test                                                                      : Skip
124: perf stat STD output linter                                                                               : Ok
125: perf stat tests                                                                                           : Ok
126: perf all metricgroups test                                                                                : Ok
127: perf all metrics test                                                                                     : Ok
128: perf all libpfm4 events test                                                                              : Ok
129: perf stat --bpf-counters --for-each-cgroup test                                                           : Ok
130: perf stat metrics --for-each-cgroup test                                                                  : Ok
131: perf metrics value validation                                                                             : Ok
132: Check Arm64 callgraphs are complete in fp mode                                                            : Skip
133: Check Arm SPE doesn't hang when there are forks                                                           : Skip
134: BPF metadata collection test                                                                              : Ok
135: Check branch stack sampling                                                                               : Ok
136: Perf event open fallback test                                                                             : Ok
137: Test java symbol                                                                                          : Skip
138: 'perf data convert --to-ctf' command test                                                                 : Ok
139: 'perf data convert --to-json' command test                                                                : Ok
140: perf test junit XML output validation                                                                     : Ok
141: test perf probe of function from different CU                                                             : Ok
142: perf timechart tests                                                                                      : Ok
143: perf trace enum augmentation tests                                                                        : Ok
144: perf trace exit race                                                                                      : Ok
145: perf trace record and replay                                                                              : Ok
146: mmap interface tests                                                                                      :
146.1: Read samples using the mmap interface                                                                   : Ok
146.2: User space counter reading of instructions                                                              : Ok
146.3: User space counter reading of cycles                                                                    : Ok
146.4: User space counter disabling instructions                                                               : Ok
146.5: User space counter disabling cycles                                                                     : Ok
147: Number of exit events of a simple workload                                                                : Ok
148: Track with sched_switch                                                                                   : Ok
149: AMD IBS sample period                                                                                     : Skip
150: CoreSight synthesized callchain                                                                           : Skip
151: CoreSight concurrent threads                                                                              : Skip
152: CoreSight context switch thread attribution                                                               : Skip
153: CoreSight deterministic workload decode                                                                   : Skip
154: CoreSight raw dump stress                                                                                 : Skip
155: Check Arm CoreSight trace data recording and synthesized samples                                          : Skip
156: Check Arm CoreSight disassembly script completes without errors                                           : Skip
157: perftool-testsuite_probe                                                                                  : Ok
158: perftool-testsuite_report                                                                                 : Ok
159: Add vfs_getname probe to get syscall args filenames                                                       : Skip
160: probe libc's inet_pton & backtrace it with ping                                                           : Ok
161: Use vfs_getname probe to get syscall args filenames                                                       : Skip
162: perf record offcpu profiling tests                                                                        : Ok
163: perf all PMU test                                                                                         : Ok
164: perf stat --bpf-counters test                                                                             : Ok
165: Check Arm SPE trace data recording and synthesized samples                                                : Skip
166: Test data symbol                                                                                          : Ok
167: Miscellaneous Intel PT testing                                                                            : Ok
168: test Intel TPEBS counting mode                                                                            : Ok
169: perf script task-analyzer tests                                                                           : Ok
170: perf top tests                                                                                            : Ok
171: Check open filename arg using perf trace + vfs_getname                                                    : Skip
172: perf trace BTF general tests                                                                              : Ok
173: perf trace summary                                                                                        : Ok

=== Test Summary ===
Passed main tests : 133
Passed subtests   : 152
Skipped tests     : 24
Failed tests      : 2
List of failed tests:
   23: Object code reading
  110: perf record sample filtering (by BPF) tests
root@x1:~# perf test 23
 23: Object code reading                                                                                       : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x1:~# perf test 110
110: perf record sample filtering (by BPF) tests                                                               : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x1:~#

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -20
98bc7deff4858aa8 (HEAD -> perf/hardening-machine) perf machine: Check snprintf truncation for guest kallsyms path
e8d437c36c541100 perf machine: Free scandir entries in guest kernel map creation
91bf0906631ae0a8 perf machine: Reset errno before strtol in guest kernel map creation
77ed3cc26bcd39e3 perf machine: Don't abort guest map creation on first inaccessible dir
428247c2b3b5c497 perf machine: Check snprintf truncation in machines__findnew()
7ac4bfbf50bc6f44 perf machine: Guard against NULL strlist in machines__findnew()
8f24fb3effa0c62d perf machine: Fix NULL parent dereference in fork event processing
f57f40ec26ad5b82 perf machine: Fix fd leak on bounds check in maps__set_modules_path_dir()
da85966dfd23a3b0 (perf-tools-next.korg/perf-tools-next, perf-tools-next) perf trace: Format instruction pointer fields as hexadecimal
ab74d1fbe0618940 perf trace: Add --bitmask-list command-line option
89493fe58c81db19 perf trace: Correct default cpumask formatting to hexadecimal
eaab2eb09dc2f86f perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py
1fa8d81be1ebaf03 perf python: Clean up and restructure setup.py
87ec3437f37b9fe4 perf cap: Remove used_root parameter and simplify capability checks
ec99be8a31db999a perf cs-etm: Avoid truncating AUX buffer sizes to int
64724095a33fbee8 perf stat: Add --hide-zero-events option to suppress zero-count events
e01c7bd5b1eece25 perf build: Fix compiler errors with old capstone
5bc1647216b68c17 perf ui hists: Fix NULL pointer array gap in add_script_opt()
1243a5e741a4f933 perf disasm: Fix potential NULL pointer dereference and use-after-free in arch__find()
c6275783931ddb9d perf ui hists: Include limits.h for PATH_MAX definition
⬢ [acme@toolbx perf-tools-next]$
acme@number:~/git/perf-tools-next$
