Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3327C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Mar 2022 05:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiCWFIF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCWFIE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Mar 2022 01:08:04 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FA13DCF
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 22:06:35 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id q85so261468vkq.4
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z0naPi9sBPzKHeJh3b79UeAbKq9HOyCcYTBkfTEM5Vc=;
        b=M7CL9q3qCLANaUrZZcTMfNgLOhJDGsVre7Bz/4cFv2aMDS+QTkb1l0lIdfwpMGAS9l
         s2OuCUU6KhCcIEyLKOUnYJJNZq8WnB8Q8sRdIKvBCq7KsFZp8QwM0kaqLxXqMUZX3/Gt
         +ce5lyugzLM7r9iN3GDFRN8PZfGRxDkf2Ul9o8gd1rp6ssXi/xw50Jv0r6sFoceWbhX9
         i+w9kA8KZX5iQLm+VbR7tyNbOzqdUWVWKZdeUKDPPVkCeTNOjftyoEMFPiy3Zy7qVNeB
         B6Bqc9DCCmt59p6FZaRJyi3460RtzpxGLNRsOJe+qdRhYvvxvCTcSDsf8cl5B6P9n0ZV
         3LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z0naPi9sBPzKHeJh3b79UeAbKq9HOyCcYTBkfTEM5Vc=;
        b=GU52zE6RQzqT6mvRdSyxH68gnP2DR0YkEIGewpegj6KxrxwnxAvru2a0xWFJmc81gm
         CeFYvBp82gl42RV83C5cuDAFuGgQtvbSNVHyi/XKAehcUZjhwG0Y5xUX6X3fvED3sLHH
         LvthCULH2gNBbuNvpgigJnwtzfFORqq+tCFCoAClGaAxV40zEYHRnQXbt7pX9saATLRE
         97YLn53U+VJPdYlo1tr36tMi+Boo5Y3ULlcppgHvguyPPP44R6wX7LZ4KFsEO7NmUZIW
         BZ0ZIFxn0wLNOkKlfA7+dxJzk3gQGw/mra3PIo41CVDXgNRtOBNjLqB6QD+u+3NmPClw
         cxpw==
X-Gm-Message-State: AOAM531qq2nNVa4tPQbe3uPcBMaHDXKqVAgRXyT5GEATueih1ZYeeCpF
        sOyLALpWhCsya8iqy95G71PKwKRkYHD+fzl7vsSRUNhttnzGyw==
X-Google-Smtp-Source: ABdhPJwq7+16CLRKBQeYWyqsbOEQhS32CyKYBZG0YV/I6SfiyM7rDa//wJ2BDf1peTScZ+FP+7iSZo5NI2T4FthFb5E=
X-Received: by 2002:a1f:b297:0:b0:33e:3d7f:cc0d with SMTP id
 b145-20020a1fb297000000b0033e3d7fcc0dmr12002741vkf.13.1648011993899; Tue, 22
 Mar 2022 22:06:33 -0700 (PDT)
MIME-Version: 1.0
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 22 Mar 2022 22:06:22 -0700
Message-ID: <CABPqkBSKMU-r+AbYvZ9e17nZ70idCyxBQ4sUhKzhkTn-1JaTDA@mail.gmail.com>
Subject: perf record crash with Intel PT
To:     linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

I was trying some simple command lines with perf record from tip.git tree
and Intel PT and to my surprised I got an immediate crash with cmdline such as :

$ perf record -e intel_pt// -a -C 1 sleep 5

As soon as you specify -C you get a crash in:

Program received signal SIGSEGV, Segmentation fault.
perf_evlist__id_add_fd (evlist=<optimized out>, evsel=<optimized out>,
cpu=<optimized out>, thread=<optimized out>, fd=<optimized out>) at
evlist.c:291
291 evlist.c: No such file or directory.
(gdb) bt
#0  perf_evlist__id_add_fd (evlist=<optimized out>, evsel=<optimized
out>, cpu=<optimized out>, thread=<optimized out>, fd=<optimized out>)
at evlist.c:291
#1  0x00000000005c6645 in mmap_per_evsel (evlist=0xfc1440,
ops=0x7fffffff8d10, idx=0, mp=0x7fffffff8d30, cpu_idx=<optimized out>,
thread=0, _output=0x7fffffff8cc0, _output_overwrite=0x7fffffff8cc4) at
evlist.c:498
#2  0x00000000005c6c67 in mmap_per_cpu (mp=0x7fffffff8d30,
ops=0x7fffffff8d10, evlist=0xfc1440) at evlist.c:550
#3  perf_evlist__mmap_ops (evlist=evlist@entry=0xfc1440,
ops=ops@entry=0x7fffffff8d10, mp=mp@entry=0x7fffffff8d30) at
evlist.c:602
#4  0x00000000004b8969 in evlist__mmap_ex (evlist=0xfc1440,
pages=<optimized out>, auxtrace_pages=1024,
auxtrace_overwrite=auxtrace_overwrite@entry=false,
nr_cblocks=<optimized out>, affinity=<optimized out>, flush=1,
comp_level=0) at util/evlist.c:993
#5  0x000000000041cfcf in record__mmap_evlist (rec=0xd9cc20 <record>,
evlist=<optimized out>) at builtin-record.c:855
#6  record__mmap (rec=0xd9cc20 <record>) at builtin-record.c:882
#7  record__open (rec=0xd9cc20 <record>) at builtin-record.c:965
#8  __cmd_record (rec=0xd9cc20 <record>, argv=<optimized out>,
argc=<optimized out>) at builtin-record.c:1728
#9  cmd_record (argc=<optimized out>, argv=<optimized out>) at
builtin-record.c:2962
#10 0x00000000004a0630 in run_builtin (p=p@entry=0xda71d8
<commands+216>, argc=argc@entry=8, argv=argv@entry=0x7fffffffe380) at
perf.c:313
#11 0x0000000000402d5f in handle_internal_command
(argv=0x7fffffffe380, argc=8) at perf.c:365
#12 run_argv (argv=<synthetic pointer>, argcp=<synthetic pointer>) at perf.c:409
#13 main (argc=8, argv=0x7fffffffe380) at perf.c:539

Any fix for that?
Thanks.
