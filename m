Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C4CC4321E
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 May 2022 09:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446158AbiEGJdE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 7 May 2022 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383837AbiEGJdD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 7 May 2022 05:33:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C866562E1
        for <linux-perf-users@vger.kernel.org>; Sat,  7 May 2022 02:29:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so13040477wrg.3
        for <linux-perf-users@vger.kernel.org>; Sat, 07 May 2022 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O46NG4I/Ehd11dycpk2RjsN/cJ86swAD+6NyN8Wu3oM=;
        b=pEJT+rz+VfSx+i3BXIXcXBka/5Yg7AcIDPJqzI64zSkN1WUpTztaU5kum35UgrsfF9
         DzOjJPlOXIfoUzWT5jSe26grmDrcE5y4YRZ4YR+l+KCgM4xNILwg4UsizkKWsczzl+De
         nX6pK3uT0jQrV4KFZSgHFgFeD2qqS/Q51S4GZiQOJ4lfG8T7AE63PEcYjY2oxMoY9aqJ
         KPWdvUwiryRluS9vjmaRgu1H83GjAAQS1C7TsJMRlMrMgQMCmzL3mmrDMbW3OJyOj5Y9
         EQP9LAp0ElcPFJCYbA8qRiTa5YvhVwVsbiztmAuOvi5ZjZGIAm5UQjWZ/T6CG7ioVXxa
         fe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O46NG4I/Ehd11dycpk2RjsN/cJ86swAD+6NyN8Wu3oM=;
        b=7INbkl7dbOXx+k4lG34QeB5uXWQRWx+CB3ovT880zSse6ZPKamjQl/P75lzno77TH7
         yCfPkh3/sUERqPws0N3Lyq/74J682VIlvkydqhccuedW5Lw/PBYqKNP/5rFYd0MHAW9K
         vW2kynH5haYUNbmWcDc3lQ33X/IbusFDSOeAUbONjP7voMmZNRjAAYNd2RvUDTHK1GLn
         6hQ0dScKmZMIQ9MeCbk5iKuMtMxvQqcYT408RTS4atJSwzjatKJlTU5y9bi74juLnPAO
         AFNVEJZR2YdEpiCTOqreI8tdlgiz1gvwKMLhuoIDS7WPOe8DG+HzVcBl7qfL2Bfpq0RP
         jxDg==
X-Gm-Message-State: AOAM531u/41YC0F2H3o0hsstrkFThBnNcSN8jzqlQZZX78ayCAuzVz+T
        q+58pB3/hyf2YTnWQhWTEWtkB1pfVilUMK4lO9NqMQ==
X-Google-Smtp-Source: ABdhPJwmX5iwSt0ucutb+u1FHWUawG0af5FN3nvZMbahKeV3F7Ce0O0VSgqTSlIoIeUQl+Jhb3u7MOWpzqebYk3FohA=
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id
 h7-20020a5d4307000000b002079f82e238mr6283084wrq.430.1651915754752; Sat, 07
 May 2022 02:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org>
In-Reply-To: <20220507052451.12890-1-ojeda@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 7 May 2022 17:29:03 +0800
Message-ID: <CABVgOSm5S2=QYnHJ+B0JbYtFYKBDRZiOhE5YMKKUKZU56d17HQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/23] Rust support
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-kbuild@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, May 7, 2022 at 1:25 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Rust support
>

<...>

>   - Support running documentation tests in-kernel, based on KUnit.
>
>     Rust documentation tests are typically examples of usage of any
>     item (e.g. function, struct, module...). They are very convenient
>     because they are just written alongside the documentation, e.g.:
>
>         /// Sums two numbers.
>         ///
>         /// # Examples
>         ///
>         /// ```
>         /// assert_eq!(mymod::f(10, 20), 30);
>         /// ```
>         pub fn f(a: i32, b: i32) -> i32 {
>             a + b
>         }
>
>     So far, we were compiling and running them in the host as any
>     other Rust documentation test. However, that meant we could not
>     run tests that used kernel APIs (though we were compile-testing
>     them, which was already useful to keep the documentation in sync
>     with the code).
>
>     Now, the documentation tests for the `kernel` crate are
>     transformed into a KUnit test suite during compilation and run
>     within the kernel at boot time, if enabled. This means now we can
>     run the tests that use kernel APIs.
>
>     They look like this (their name is generated by `rustdoc`, based
>     on the file and line):
>
>         [    0.581961] TAP version 14
>         [    0.582092] 1..1
>         [    0.582267]     # Subtest: rust_kernel_doctests
>         [    0.582358]     1..70
>         [    0.583626]     ok 1 - rust_kernel_doctest_build_assert_rs_12_0
>         [    0.584579]     ok 2 - rust_kernel_doctest_build_assert_rs_55_0
>         [    0.587357]     ok 3 - rust_kernel_doctest_device_rs_361_0
>         [    0.588037]     ok 4 - rust_kernel_doctest_device_rs_386_0
>
>         ...
>
>         [    0.659249]     ok 69 - rust_kernel_doctest_types_rs_445_0
>         [    0.660451]     ok 70 - rust_kernel_doctest_types_rs_509_0
>         [    0.660680] # rust_kernel_doctests: pass:70 fail:0 skip:0 total:70
>         [    0.660894] # Totals: pass:70 fail:0 skip:0 total:70
>         [    0.661135] ok 1 - rust_kernel_doctests
>
>     There are other benefits from this, such as being able to remove
>     unneeded wrapper functions (that were used to avoid running
>     some tests) as well as ensuring test code would actually compile
>     within the kernel (e.g. `alloc` used different `cfg`s).

It's great to see some KUnit support here!

It's also possible to run these tests using the KUnit wrapper tool with:
$ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_RUST=y
--make_options LLVM=1 --arch x86_64 'rust_kernel_doctests'

That also nicely formats the results.

(It obviously doesn't run under UML yet, though I did get it to work
after indiscriminately hacking out everything that wasn't supported.
Assuming we can hide the irq and iomem stuff behind the appropriate
config options, and rework some of the architecture detection to
either support SUBARCH or check for X86_64 instead of X86, it should
be pretty easy to get going.)

That all being said, I can't say I'm thrilled with the test names
here: none of them are particularly descriptive, and they'll probably
not be static (which would make it difficult to track results /
regressions / etc between kernel versions). Neither of those are
necessarily deal breakers, though it might make sense to hide them
behind a kernel option (like all other KUnit tests) so that they can
easily be excluded where they would otherwise clutter up results. (And
if there's a way to properly name them, or maybe even split them into
per-file or per-module suites, that would make them a bit easier to
deal.) Additionally, there are some plans to taint the kernel[1] when
KUnit tests run, so having a way to turn them off would be very
useful.

Regardless, this is very neat, and I'm looking forward to taking a
closer look at it.

Cheers,
-- David

[1]: https://lore.kernel.org/linux-kselftest/20220429043913.626647-1-davidgow@google.com/
