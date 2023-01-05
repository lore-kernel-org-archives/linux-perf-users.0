Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E601C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Jan 2023 12:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjAEMy1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Jan 2023 07:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjAEMyD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2023 07:54:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FA54726
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 04:53:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B95FB81979
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 12:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3C7C433D2;
        Thu,  5 Jan 2023 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672923198;
        bh=VujAjppGrk2JW5m7MoxBtVdY6jxQWPUUBXxD5lb2bF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g71kuVDgBmjey+uN7ku3+6GFxEp/7s+bySOKBV4eWkXRRzrjhvtQUnGEk9g3jARrY
         J3VeqjXgpP2hcxLrxW7rpIW1TQlUsVP++hJ/lmDaY0X18WcWvjFsl81/IDlkBr0JUG
         J3J8PUTFtaJb9ms+sQl5/HIkK9uQx7ijyJLf3TtRFZvtGu5E8dlwZSl3OLjkK4FFJb
         ElgeGiUHdjnGBo8vMftab2ojd6/i0ImmD7jy5Q/sDWPZg3kvlu+SMpLgAE6DGhrNQz
         q79Mq3Px105yJEYKacBPbivphJJYLsVvEioxgk/a1zbizOmbSpiO1zBZXEkeeG2kPP
         OUmgjRbYy4TpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12FAE40468; Thu,  5 Jan 2023 09:53:16 -0300 (-03)
Date:   Thu, 5 Jan 2023 09:53:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     jolsa@kernel.org, ak@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: Re: [PATCH] tools/perf: Fix bpf-script-test-prologue test compile
 issue with clang
Message-ID: <Y7bIPIVx9Y7agt7L@kernel.org>
References: <20230105120436.92051-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105120436.92051-1-atrajeev@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jan 05, 2023 at 05:34:36PM +0530, Athira Rajeev escreveu:
> While running perf test for bpf, observed that "BPF prologue
> generation" test case fails to compile with clang. Logs below
> from powerpc:
> 
> <stdin>:33:2: error: use of undeclared identifier 'fmode_t'
>         fmode_t f_mode = (fmode_t)_f_mode;
>         ^
> <stdin>:37:6: error: use of undeclared identifier 'f_mode'; did you mean '_f_mode'?
>         if (f_mode & FMODE_WRITE)
>             ^~~~~~
>             _f_mode
> <stdin>:30:60: note: '_f_mode' declared here
> int bpf_func__null_lseek(void *ctx, int err, unsigned long _f_mode,
>                                                            ^
> 2 errors generated.

Thanks for fixing this, I noticed the problem but didn't got around to
investigate it.

Tested and applied.

- Arnaldo
 
> The test code tests/bpf-script-test-prologue.c uses fmode_t.
> And the error above is for "fmode_t" which is defined in
> include/linux/types.h as part of kernel build directory:
> "/lib/modules/<kernel_version>/build" that comes from
> kernel devel [ soft link to /usr/src/<kernel_version> ].
> Clang picks this header file from "-working-directory" build
> option that specifies this build folder.
> 
> But the 'commit 14e4b9f4289a ("perf trace: Raw augmented
> syscalls fix libbpf 1.0+ compatibility")', changed the
> include directory to use: "/usr/include".  Post this change,
> types.h from /usr/include/ is getting picked upwhich doesn’t
> contain definition of "fmode_t" and hence fails to compile.
> 
> Compilation command before this commit:
> /usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=72 -DLINUX_VERSION_CODE=0x50e00 -xc  -I/root/lib/perf/include/bpf -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/<ver>/build -c - -target bpf  -g -O2 -o -
> 
> Compilation command after this commit:
> /usr/bin/clang -D__KERNEL__ -D__NR_CPUS__=72 -DLINUX_VERSION_CODE=0x50e00 -xc  -I/usr/include/ -nostdinc -I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include -I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h  -Wno-unused-value -Wno-pointer-sign -working-directory /lib/modules/<ver>/build -c - -target bpf  -g -O2 -o -
> 
> The difference is addition of -I/usr/include/  in the first line
> which is causing the error. Fix this by adding typedef for "fmode_t"
> in the testcase to solve the compile issue.
> 
> Fixes: 14e4b9f4289a ("perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/bpf-script-test-prologue.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/bpf-script-test-prologue.c b/tools/perf/tests/bpf-script-test-prologue.c
> index bd83d364cf30..91778b5c6125 100644
> --- a/tools/perf/tests/bpf-script-test-prologue.c
> +++ b/tools/perf/tests/bpf-script-test-prologue.c
> @@ -20,6 +20,8 @@
>  # undef if
>  #endif
>  
> +typedef unsigned int __bitwise fmode_t;
> +
>  #define FMODE_READ		0x1
>  #define FMODE_WRITE		0x2
>  
> -- 
> 2.31.1

-- 

- Arnaldo
