Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FECC77B7E
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 May 2023 22:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjE1WtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 May 2023 18:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjE1Ws7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 May 2023 18:48:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63DB9
        for <linux-perf-users@vger.kernel.org>; Sun, 28 May 2023 15:48:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f70597707eso955e9.0
        for <linux-perf-users@vger.kernel.org>; Sun, 28 May 2023 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685314131; x=1687906131;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eaS3n103hIYL7yW3nPuZEJfFcA+bMqzC6kPjpg8rVt0=;
        b=yf9ruA7sOwxGlOK376BD7b57V5Pj07Wt3hx+K9WYJrZvw86h+P2DRCU0jrbGYWAlbi
         jIelM7hNQK9FRFNgycQFUU3h2BIcPYttisMG160LqbAd/AiSIo7EeEsHL798dsQwcGli
         3/gqzPehE2/J668mgYgIM4esYUS8S3p5IWzPGnMa02MZda+0ujCuRX7aq4t2odIfUUst
         qToXw/q/csQ3OBfXX5VEfk0dgCoI2oo3Cg1nZDx+fGNmmTIv1HbhwhITpCt9A128KyMy
         sUyUE7CNAw0gbgePDSDKBBV48M7RCezucP6BViEy8hlURAu5uZYWxlB5Z6cNdfI0mMMl
         dWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685314131; x=1687906131;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaS3n103hIYL7yW3nPuZEJfFcA+bMqzC6kPjpg8rVt0=;
        b=a+zKLfpPdBfvArO0TeJyz1eT193fdtqSBRBsPtAY2c50EMFQ0gMe6a2l5le2S1ULNt
         GrLANW/JZAWALxdcGQF8t3SHzdbwBGBv6pRahOVjtmmIplPZvuy4VIpO44sG62gT9e6L
         4q9zh6kXSjz52Rq1QVbzTj20slrpCIlolJK/9PnreJG9pD4E3Ji+nlIOoj0aLkaLEgkK
         BadIdHshykM3zuoLtGzJciII/oZrbQE9/nrTrO0M2U6fKRFlRbmB4BJGzJQDMzn/yP6W
         /ULMWwM4VM8/OgXFBL66iPNZ5C7OuW/ESMHHn3iTSkzv/zOWVUwxw4eHAYxk07TBBueL
         q0tQ==
X-Gm-Message-State: AC+VfDwAyp6tG5Cb/A/RSXNh7YFtb+DmDRj2vYKMxXQBDUPRmPJ7VWGb
        /kBWMHQbavsH7+Mh01rV4l4eiA1ss4/76lgBGu87X+eUZWOZDD88h86QRA==
X-Google-Smtp-Source: ACHHUZ7HdcZ0P+3gCNzySNaxjI7JaL0fLYvKfLHtowb9QDBHRmndyPwpLDKSCyJ0uBclTgN2IixeuMksF8+ewhPYG5Q=
X-Received: by 2002:a05:600c:4f02:b0:3f4:2736:b5eb with SMTP id
 l2-20020a05600c4f0200b003f42736b5ebmr325470wmq.1.1685314131129; Sun, 28 May
 2023 15:48:51 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 28 May 2023 15:48:31 -0700
Message-ID: <CAP-5=fVMnYMKFGBypCGWOB9uq_zgOiQhuiXUy+o3ej0b0JuMGQ@mail.gmail.com>
Subject: LTO builds
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I just wanted to post on this as I think others may be interested,
perhaps in the future the standard non-"DEBUG=3D1" build can be LTO. I
played around a bit with LTO builds for the perf tool. clang worked if
I did:
$ make -C tools/perf O=3D/tmp/perf EXTRA_CFLAGS=3D"-flto"
EXTRA_CXXFLAGS=3D"-flto" CC=3Dclang CXX=3Dclang++ LD=3Dld.lld

However, gcc didn't compile without the hacky patch at the end, and
then it failed with link time issues:

```
$ make -C tools/perf O=3D/tmp/perf EXTRA_CFLAGS=3D"-flto"
EXTRA_CXXFLAGS=3D"-flto" CC=3Dgcc CXX=3Dg++ LD=3Dld.lld
make: Entering directory '~/kernel.org/tools/perf'
  BUILD:   Doing 'make -j16' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h'
differs from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event=
.h
Warning: Kernel ABI header at
'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest
version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h
arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h'
differs from latest version at 'include/linux/coresight-pmu.h'
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
Makefile.config:602: No sys/sdt.h found, no SDT events are defined,
please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:985: No libcap found, disables capability support,
please install libcap-devel/libcap-dev
Makefile.config:998: No numa.h found, disables 'perf bench numa mem'
benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1057: No libbabeltrace found, disables 'perf data' CTF
format support, please install
libbabeltrace-dev[el]/libbabeltrace-ctf-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ OFF ]
...                                  libelf: [ on  ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL libsubcmd_headers
  INSTALL libapi_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libbpf_headers
  LINK    /tmp/perf/perf
lto-wrapper: warning: using serial compilation of 50 LTRANS jobs
lto-wrapper: note: see the =E2=80=98-flto=E2=80=99 option documentation for=
 more information
/usr/bin/ld: /tmp/cclv2Qid.ltrans3.ltrans.o: in function `script_fetch_insn=
':
~/kernel.org/tools/perf/arch/x86/util/archinsn.c:23: undefined
reference to `insn_decode'
/usr/bin/ld: /tmp/cclv2Qid.ltrans32.ltrans.o: in function
`inline_list__append_record':
~/kernel.org/tools/perf/util/symbol-elf.c:286: undefined reference to
`cxx_demangle_sym'
/usr/bin/ld: /tmp/cclv2Qid.ltrans37.ltrans.o: in function
`dso__synthesize_plt_symbols':
~/kernel.org/tools/perf/util/symbol-elf.c:286: undefined reference to
`cxx_demangle_sym'
/usr/bin/ld: ~/kernel.org/tools/perf/util/symbol-elf.c:286: undefined
reference to `cxx_demangle_sym'
/usr/bin/ld: /tmp/cclv2Qid.ltrans37.ltrans.o: in function `dso__demangle_sy=
m':
~/kernel.org/tools/perf/util/symbol-elf.c:286: undefined reference to
`cxx_demangle_sym'
/usr/bin/ld: /tmp/cclv2Qid.ltrans37.ltrans.o: in function
`dso__load_sym_internal.lto_priv.0':
~/kernel.org/tools/perf/util/symbol-elf.c:286: undefined reference to
`cxx_demangle_sym'
/usr/bin/ld: /tmp/cclv2Qid.ltrans41.ltrans.o: in function `arch_fetch_insn'=
:
~/kernel.org/tools/perf/arch/x86/util/archinsn.c:23: undefined
reference to `insn_decode'
/usr/bin/ld: /tmp/cclv2Qid.ltrans49.ltrans.o: in function
`perf_sample__fprintf_insn.isra.0':
~/kernel.org/tools/perf/arch/x86/util/archinsn.c:23: undefined
reference to `insn_decode'
/usr/bin/ld: /tmp/cclv2Qid.ltrans10.ltrans.o:(.data.rel.ro+0x28):
undefined reference to `memset_orig'
/usr/bin/ld: /tmp/cclv2Qid.ltrans10.ltrans.o:(.data.rel.ro+0x40):
undefined reference to `__memset'
/usr/bin/ld: /tmp/cclv2Qid.ltrans10.ltrans.o:(.data.rel+0x28):
undefined reference to `memcpy_orig'
/usr/bin/ld: /tmp/cclv2Qid.ltrans10.ltrans.o:(.data.rel+0x40):
undefined reference to `__memcpy'
/usr/bin/ld: /tmp/cclv2Qid.ltrans33.ltrans.o: in function `__intel_pt_log_i=
nsn':
~/kernel.org/tools/perf/util/intel-pt-decoder/intel-pt-log.c:236:
undefined reference to `intel_pt_insn_desc'
/usr/bin/ld: /tmp/cclv2Qid.ltrans33.ltrans.o: in function
`__intel_pt_log_insn_no_data':
~/kernel.org/tools/perf/util/intel-pt-decoder/intel-pt-log.c:251:
undefined reference to `intel_pt_insn_desc'
/usr/bin/ld: /tmp/cclv2Qid.ltrans34.ltrans.o: in function
`intel_pt_sample_flags':
~/kernel.org/tools/perf/util/intel-pt.c:1503: undefined reference to
`intel_pt_insn_type'
/usr/bin/ld: /tmp/cclv2Qid.ltrans34.ltrans.o: in function
`intel_pt_walk_next_insn':
~/kernel.org/tools/perf/util/intel-pt.c:860: undefined reference to
`intel_pt_get_insn'
/usr/bin/ld: /tmp/cclv2Qid.ltrans35.ltrans.o: in function
`intel_bts_process_queue':
~/kernel.org/tools/perf/util/intel-bts.c:335: undefined reference to
`intel_pt_get_insn'
/usr/bin/ld: ~/kernel.org/tools/perf/util/intel-bts.c:390: undefined
reference to `intel_pt_insn_type'
/usr/bin/ld: /tmp/cclv2Qid.ltrans42.ltrans.o: in function `test_data_item':
~/kernel.org/tools/perf/arch/x86/tests/insn-x86.c:106: undefined
reference to `insn_decode'
/usr/bin/ld: ~/kernel.org/tools/perf/arch/x86/tests/insn-x86.c:122:
undefined reference to `intel_pt_get_insn'
/usr/bin/ld: /tmp/cclv2Qid.ltrans42.ltrans.o: in function
`test__arch_unwind_sample':
~/kernel.org/tools/perf/arch/x86/tests/dwarf-unwind.c:72: undefined
reference to `perf_regs_load'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:682: /tmp/perf/perf] Error 1
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '~/kernel.org/tools/perf'
```

A number of the link time issues are with C++ code and assembly code.
I played around with options like AR=3Dgcc-ar but without success. I
wondered if people on the list had thoughts on how to get this to
work.

Thanks,
Ian

Patch:
```
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-tes=
t.c
index aa44fdc84763..6bf13e052fff 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -33,9 +33,7 @@
static bool dont_fork;
const char *dso_to_test;

-struct test_suite *__weak arch_tests[] =3D {
-       NULL,
-};
+extern struct test_suite *__weak arch_tests[];

static struct test_suite *generic_tests[] =3D {
       &suite__vmlinux_matches_kallsyms,
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 500974040fe3..706780fb5695 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -27,7 +27,7 @@ static int process_stat_config_event(struct
perf_tool *tool __maybe_unused,
                                    struct machine *machine __maybe_unused)
{
       struct perf_record_stat_config *config =3D &event->stat_config;
-       struct perf_stat_config stat_config;
+       struct perf_stat_config stat_config =3D {};

#define HAS(term, val) \
       has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index e0c3f2037477..80ac426b7e6a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -754,7 +754,7 @@ parse_events_config_bpf(struct parse_events_state
*parse_state,
                       struct list_head *head_config)
{
       struct parse_events_term *term;
-       int error_pos;
+       int error_pos =3D 0;

       if (!head_config || list_empty(head_config))
               return 0;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 0f7b8a8cdea6..cef1d4a41c05 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -707,7 +707,7 @@ size_t perf_event__fprintf_stat_round(union
perf_event *event, FILE *fp)

size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
{
-       struct perf_stat_config sc;
+       struct perf_stat_config sc =3D {};
       size_t ret;

       perf_event__read_stat_config(&sc, &event->stat_config);
```
