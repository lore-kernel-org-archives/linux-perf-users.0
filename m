Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A7FC7618E
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Apr 2023 06:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDUGlF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Apr 2023 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDUGlE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Apr 2023 02:41:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3150171B
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Apr 2023 23:41:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f08b6a9f8aso270885e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Apr 2023 23:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682059259; x=1684651259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=316PSvUrUKNHsSOcln92fYW/lkHL8aHVx/JN9HDPWyQ=;
        b=xUaGVOB4Zx8ESteX5NhC4DiFYJPRs58V2PwikDSOs0jUvhuLnsXuUzdWEsH2Xk9xGL
         q0M+2JRlcIleQOZP939O0hppcUw0FXEi67ENbbUgWJ6bmz9eXpjgb6GLSQElnFVVXSzI
         bYMb7kZiYyNypn0SidpdfYdfCGRvKuMT/N1MIzf1i4NpSjQjMJ17e0NNKDIt6v+Z8xsH
         oKlzXa83M8J2h/Mh8JQUfnIlBJSCq8jm94LOS/io8CoXjl/T7rCnQzs3x4uDZiUqe/3r
         A80lVokXD/MRcpBCDUXrY1UORhxH1d0l98k9/5cYCJZ/pl1KaiMU7M6eWlqpKPIo0Y0U
         FyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682059259; x=1684651259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=316PSvUrUKNHsSOcln92fYW/lkHL8aHVx/JN9HDPWyQ=;
        b=QUZLrwSfKzMSlfrZrOSL9F/ICdSy3PSzSMmXVwWEBysJ6nNyFuEEQZETvQkQcKdRjy
         wdeIz41aPoGwFn/H/gdcJC/oetjigS8h7QqaK1GAV+MgU5+m2MlD2eI6UmNkKdTYEnw+
         a6gqKb6T4suPD2Ny7K3ROED4CdZp5pBsDkLS52fa7udxKN+RZy9JL3TMEdsKffX0Vhwv
         j61xRFooUfKx37nRL/4syO+zpZSoM9uhSfnbi+wTRcgs88M5PX9GNpHfZl9i+PP5E+nY
         JX8+2hwRbRXU7wlUpcM+OJTmG+mWMDD0t5f/rHR8j8SWhXsOh8sACEJkSpA0+s3aghU4
         1Jgw==
X-Gm-Message-State: AAQBX9fXH5iWQLnYVPoPIYnl9jNGLeSaqcKGdyhs386LFXd+dVRU2XzX
        gQWqAkij4gFpjXmYMSKB3kCkuiqZmvDcro1sKhiv2Q==
X-Google-Smtp-Source: AKy350af+oza398YkDzKpX/Cf/o+A7YiWDEi3iTwJQbqCWefw38qn0EYgefTUPrbfygG6iO4ffJx8F5LSvEU/FFIkyI=
X-Received: by 2002:a05:600c:5574:b0:3f0:aeef:e2da with SMTP id
 ja20-20020a05600c557400b003f0aeefe2damr78138wmb.3.1682059258941; Thu, 20 Apr
 2023 23:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <202304211253.cbcd33b7-oliver.sang@intel.com>
In-Reply-To: <202304211253.cbcd33b7-oliver.sang@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 20 Apr 2023 23:40:25 -0700
Message-ID: <CAP-5=fV2592hai4wGhOrCBYFwTxDnre7wdJwBRHgdPf6KXYfTA@mail.gmail.com>
Subject: Re: [acme:tmp.perf/core] [perf map] ec417ad4c6: perf-sanity-tests.Test_dwarf_unwind.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        German Gomez <german.gomez@arm.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 20, 2023 at 11:02=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
> Hello,
>
> kernel test robot noticed "perf-sanity-tests.Test_dwarf_unwind.fail" on:
>
> commit: ec417ad4c691b5d90ab13cf26789e8719468ae39 ("perf map: Changes to r=
eference counting")
> https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git tmp.perf/core
>
> [test failed on linux-next/master 44bf136283e567b2b62653be7630e7511da41da=
2]
>
> in testcase: perf-sanity-tests
> version: perf-x86_64-00c7b5f4ddc5-1_20230402
> with following parameters:
>
>         perf_compiler: gcc
>
>
>
> compiler: gcc-11
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz=
 (Kaby Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> we also noticed below test failed on this commit but pass on parent:
>
> 392cf49ec54f0c7b ec417ad4c691b5d90ab13cf2678
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6           33%           2:2     perf-sanity-tests.Check_bra=
nch_stack_sampling.fail
>            :6           33%           2:2     perf-sanity-tests.Test_dwar=
f_unwind.fail
>            :6           33%           2:2     perf-sanity-tests.perf_reco=
rd_tests.fail
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202304211253.cbcd33b7-oliver.sang@=
intel.com
>
>
>
> 2023-04-20 17:08:51 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-ec4=
17ad4c691b5d90ab13cf26789e8719468ae39/tools/perf/perf test 76
>  76: Test dwarf unwind                                               : FA=
ILED!
>
> ...
>
> 2023-04-20 17:09:39 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-ec4=
17ad4c691b5d90ab13cf26789e8719468ae39/tools/perf/perf test 94
>  94: perf record tests                                               : FA=
ILED!
>
> ...
>
> 2023-04-20 17:16:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-func-ec4=
17ad4c691b5d90ab13cf26789e8719468ae39/tools/perf/perf test 110
> 110: Check branch stack sampling                                     : FA=
ILED!
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.

The important detail missing here is that these tests are failing with
address sanitizer. Here is the first failure:

=3D=3D742187=3D=3DERROR: AddressSanitizer: stack-buffer-underflow on addres=
s
0x7fffe253b430 at pc 0x7f2f2cc4814b bp 0x7fffe253b360 sp
0x7fffe253ab10
READ of size 8192 at 0x7fffe253b430 thread T0
    #0 0x7f2f2cc4814a in __interceptor_memcpy
libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:827
    #1 0x561de4706b25 in sample_ustack arch/x86/tests/dwarf-unwind.c:39
    #2 0x561de4706cf7 in test__arch_unwind_sample
arch/x86/tests/dwarf-unwind.c:77
    #3 0x561de43d8832 in test_dwarf_unwind__thread tests/dwarf-unwind.c:120
    #4 0x561de43d8b08 in test_dwarf_unwind__compare tests/dwarf-unwind.c:15=
2
    #5 0x7f2f2bc5c47b in __GI_bsearch ../bits/stdlib-bsearch.h:33
    #6 0x7f2f2cc4a4ac in __interceptor_bsearch
libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:10155
    #7 0x7f2f2cc4a4ac in __interceptor_bsearch
libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:10150
    #8 0x561de43d8cc9 in test_dwarf_unwind__krava_3 tests/dwarf-unwind.c:17=
6
    #9 0x561de43d8d4f in test_dwarf_unwind__krava_2 tests/dwarf-unwind.c:18=
5
    #10 0x561de43d8d92 in test_dwarf_unwind__krava_1 tests/dwarf-unwind.c:1=
94
    #11 0x561de43d90b5 in test__dwarf_unwind tests/dwarf-unwind.c:234
    #12 0x561de434fe6c in run_test tests/builtin-test.c:238
    #13 0x561de4350111 in test_and_print tests/builtin-test.c:267
    #14 0x561de4350f40 in __cmd_test tests/builtin-test.c:404
    #15 0x561de435240f in cmd_test tests/builtin-test.c:561
    #16 0x561de43db29a in run_builtin tools/perf/perf.c:323
    #17 0x561de43db80b in handle_internal_command tools/perf/perf.c:377
    #18 0x561de43dbbd3 in run_argv tools/perf/perf.c:421
    #19 0x561de43dc13b in main tools/perf/perf.c:537

Address 0x7fffe253b430 is located in stack of thread T0 at offset 0 in fram=
e
    #0 0x561de43d8716 in test_dwarf_unwind__thread tests/dwarf-unwind.c:113

  This frame has 2 object(s):
    [32, 40) 'cnt' (line 115) <=3D=3D Memory access at offset 0 partially
underflows this variable
    [64, 1440) 'sample' (line 114) <=3D=3D Memory access at offset 0
partially underflows this variable
HINT: this may be a false positive if your program uses some custom
stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-underflow
../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors=
.inc:827
in __interceptor_memcpy
Shadow bytes around the buggy address:
  0x10007c49f630: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f650: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f670: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=3D>0x10007c49f680: 00 00 00 00 00 00[f1]f1 f1 f1 00 f2 f2 f2 00 00
  0x10007c49f690: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f6a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f6b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f6c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10007c49f6d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D742187=3D=3DABORTING

Which corresponds to:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/arch/x86/tests/dwarf-unwind.c?h=3Dperf-tools-next#n39
sp =3D (unsigned long) regs[PERF_REG_X86_SP];
...
memcpy(buf, (void *) sp, stack_size);

ie address sanitizer is failing because of reading non-data values
from the stack, which is an inherent property of the test. So what's
confusing in this report isn't that we see failures, but why the
failures are being reported now. Presumably because code changed and
there is some effort to correlate the two things.

Thanks,
Ian

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>
>
