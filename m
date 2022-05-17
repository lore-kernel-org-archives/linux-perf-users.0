Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D5C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 14:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiEQOx2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349501AbiEQOxX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 10:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1845005D
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 07:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0418B81902
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 14:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13F5C385B8;
        Tue, 17 May 2022 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652799174;
        bh=PWmAL6u/Fitq0XjDLkCwebn0CLqgf2tYqAoWgozHXrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmBPtWMgDc5kjeTxRd7XGA+0nBjr0biz/Ix25grUW3Cu08Hf2cwkCev37GSfAE/SP
         bpK+MpP8oGCG4aJSX73wcAoUTewZYi283So+F9unpvzqHy2q5LutbUmXNwto8Umgwm
         998TJzdoznkkczckgrmDJAMvU9Z+CkIP0O5cM9ribF8Kvf1E4ZCPnJWqrPRm9JEYJm
         L1TQVh1j5GrTFjmGKs7aTLI3L7fIUbixwGcujufYvElK+ybTgYtxPxF5VzgrJvA0ck
         lq8TIN+sB0ZR3fhDCxhpAZ2aVYfPHNJmh2suaM9p++DW8TGd34c9VXsL5i0qHuaQYq
         lrp4ZpyLvMmEA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D2A6400B1; Tue, 17 May 2022 11:52:50 -0300 (-03)
Date:   Tue, 17 May 2022 11:52:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Infinite recursion in `perf record`
Message-ID: <YoO2wrQ41W1lO88T@kernel.org>
References: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0add43b-3de5-20c5-22c4-70aff4af959f@scylladb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, May 16, 2022 at 06:22:35PM +0300, Avi Kivity escreveu:
> In bpf-event.c we have:
> 
> 
> struct btf * __weak btf__load_from_kernel_by_id(__u32 id)
> {
>        struct btf *btf;
> #pragma GCC diagnostic push
> #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>        int err = btf__get_from_id(id, &btf);
> #pragma GCC diagnostic pop
> 
>        return err ? ERR_PTR(err) : btf;
> }
> 
> and in btf.c we have:

> int btf__get_from_id(__u32 id, struct btf **btf)
> {
>         struct btf *res;
>         int err;
> 
>         *btf = NULL;
>         res = btf__load_from_kernel_by_id(id);
>         err = libbpf_get_error(res);
> 
>         if (err)
>                 return libbpf_err(err);
> 
>         *btf = res;
>         return 0;
> }
> 
> Obviously, if the first weak symbol isn't overridden we get into an infinite
> recursion, which is what I see immediately on running perf record:

So the intent was to be able to dynamicly link with older and newer
libbpf versions, as btf__get_from_id() is being deprecated and
btf__load_from_kernel_by_id() isn't available in older libbpf versions.

This is all only when linking with the system's libbpf, not with the one
in tools/lib/bpf/, when perf does a static link.

So I think (will check) that your build is using LIBBPF_DYNAMIC=1, and
while there is a test build for that in 'make -C tools/perf build-test'.

         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1

It will cover testing just with the libbpf-devel installed on the
tester's machine/container.

I couldn't find the perf build log, the link you provided:

https://kojipkgs.fedoraproject.org//packages/kernel/5.17.6/300.fc36/data/logs/x86_64/build.log

is for the kernel, not tools/perf.

I agree with Ian I should have done this using ifdef, a
tools/build/feature check that tries to build a test app linking against
libbpf-devel with btf__load_from_kernel_by_id(), if it is there, then
use it directly, if not, implement it in terms of btf__get_from_id().

I'll try to use my unbroken fingers to do that 8-)

- Arnaldo


 
> (gdb) bt
> #0  0x00007f3d94c26d76 in btf__get_from_id (id=282,
> btf=btf@entry=0x7ffc1dab4010) at btf.c:1410
> #1  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #2  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4060) at btf.c:1411
> #3  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #4  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab40b0) at btf.c:1411
> #5  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #6  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4100) at btf.c:1411
> #7  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #8  0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4150) at btf.c:1411
> #9  0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #10 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab41a0) at btf.c:1411
> #11 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #12 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab41f0) at btf.c:1411
> #13 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #14 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4240) at btf.c:1411
> #15 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #16 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4290) at btf.c:1411
> #17 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #18 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab42e0) at btf.c:1411
> #19 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #20 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4330) at btf.c:1411
> #21 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #22 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4380) at btf.c:1411
> #23 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #24 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab43d0) at btf.c:1411
> #25 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #26 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4420) at btf.c:1411
> #27 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #28 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4470) at btf.c:1411
> #29 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #30 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab44c0) at btf.c:1411
> #31 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #32 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4510) at btf.c:1411
> #33 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #34 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4560) at btf.c:1411
> #35 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #36 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab45b0) at btf.c:1411
> #37 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #38 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4600) at btf.c:1411
> #39 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #40 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4650) at btf.c:1411
> #41 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #42 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab46a0) at btf.c:1411
> #43 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #44 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab46f0) at btf.c:1411
> #45 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #46 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4740) at btf.c:1411
> #47 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #48 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4790) at btf.c:1411
> #49 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #50 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab47e0) at btf.c:1411
> #51 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #52 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4830) at btf.c:1411
> #53 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #54 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4880) at btf.c:1411
> #55 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #56 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab48d0) at btf.c:1411
> #57 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #58 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4920) at btf.c:1411
> #59 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #60 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4970) at btf.c:1411
> #61 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #62 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab49c0) at btf.c:1411
> #63 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #64 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4a10) at btf.c:1411
> #65 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #66 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4a60) at btf.c:1411
> #67 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #68 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4ab0) at btf.c:1411
> #69 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #70 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4b00) at btf.c:1411
> #71 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #72 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4b50) at btf.c:1411
> #73 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #74 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4ba0) at btf.c:1411
> #75 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #76 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4bf0) at btf.c:1411
> #77 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> #78 0x00007f3d94c26d8d in btf__get_from_id (id=<optimized out>,
> btf=btf@entry=0x7ffc1dab4c40) at btf.c:1411
> #79 0x000055f3ff6d5004 in btf__load_from_kernel_by_id (id=<optimized out>)
> at util/bpf-event.c:30
> --Type <RET> for more, q to quit, c to continue without paging--
> 
> 
> (rest of infinite stack trace omitted)
> 
> 
> I guess I should load some library or other, but I have no idea which, and
> in any case this is quite a fragile interface.
> 
> 
> perf-5.17.6-300.fc36.x86_64
> 

-- 

- Arnaldo
