Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E81C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891896120A
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 21:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhIJVle (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 17:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhIJVld (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 17:41:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2C6A611F0;
        Fri, 10 Sep 2021 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631310022;
        bh=iVEY9VLFCJeYEo9jsUnCHylE3ARaYTaAKIEjcJoUS7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gbq9zpY6ve25Xt9LOF9kuB3SjMvkFDq+YC2o8dQM3UyRDO2D3qXijc58rtyQS6grU
         RZqhUjD7qe9x/5iVPcIvkCxT4FQntuDs3RuQSxzuh+14FyiSk6RjWAw36rTzsONutj
         b30+nhJmfeGWbEpSAwouNfJmFu4jBzEUcyy+Exh2CnqjcI/CkacpcUEs9Zq8RANniU
         p3MHPRWD6ttqYSKu1DVstJv4f3mkKqvp/4eSFyYuRvWDNBJOpDKRtK3vPp1Y/JVeRK
         uuxl08dSYA8KAqwd8ThrRo9Hh+1lFcqYjq+52WFm+uiNF1kbcs/shbxmHptZbb/JwT
         160qzuCPabpWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3AB04038F; Fri, 10 Sep 2021 18:40:17 -0300 (-03)
Date:   Fri, 10 Sep 2021 18:40:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Another bug: Re: [PATCH 0/3] perf report: Add support to print a
 textual representation of IBS raw sample data
Message-ID: <YTvQwQk91tM/ag0f@kernel.org>
References: <20210817221509.88391-1-kim.phillips@amd.com>
 <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
 <YTth5DLWGbyAzxvQ@kernel.org>
 <YTtmwrZ6iy0TzG3l@kernel.org>
 <YTtnpAcaCNYozoJF@kernel.org>
 <YTto5xw/XSMuiGrG@kernel.org>
 <YTu2mu6a4lkx92ee@kernel.org>
 <YTvG5ndtSQtRHte2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTvG5ndtSQtRHte2@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 10, 2021 at 05:58:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Sep 10, 2021 at 04:48:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> > 
> > All the cross builds are failing:
> > 
> >   28     9.20 debian:experimental-x-arm64   : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
> >     util/amd-sample-raw.c:12:10: fatal error: asm/amd-ibs.h: No such file or directory
> >        12 | #include <asm/amd-ibs.h>
> >           |          ^~~~~~~~~~~~~~~
> >     compilation terminated.
> 
> Trying with the same trick used by intel-pt to build on all arches:
> 
> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
> index fbb7d61c50489374..d19d765195c54b79 100644
> --- a/tools/perf/util/amd-sample-raw.c
> +++ b/tools/perf/util/amd-sample-raw.c
> @@ -9,7 +9,7 @@
>  #include <inttypes.h>
>  
>  #include <linux/string.h>
> -#include <asm/amd-ibs.h>
> +#include "../../arch/x86/include/asm/amd-ibs.h"
>  
>  #include "debug.h"
>  #include "session.h"

Not enough, this one is needed for msr-index.h, same reason, a bit more
involved, but check-patch.h has a few entries like that, see below.

Now it seems to be ok:

# export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.14.0.tar.xz
# dm  android-ndk:r12b-arm android-ndk:r15c-arm debian:experimental-x-arm64 debian:experimental-x-mips debian:experimental-x-mips64 debian:experimental-x-mipsel fedora:24-x-ARC-uClibc fedora:34-x-ARC-glibc fedora:34-x-ARC-uClibc mageia:7 openmandriva:cooker ubuntu:16.04-x-arm ubuntu:16.04-x-arm64 ubuntu:16.04-x-powerpc ubuntu:16.04-x-powerpc64 ubuntu:16.04-x-powerpc64el ubuntu:16.04-x-s390 ubuntu:18.04-x-arm ubuntu:18.04-x-arm64 ubuntu:18.04-x-m68k ubuntu:18.04-x-powerpc ubuntu:18.04-x-powerpc64 ubuntu:18.04-x-powerpc64el ubuntu:18.04-x-riscv64 ubuntu:18.04-x-s390 ubuntu:18.04-x-sh4 ubuntu:18.04-x-sparc64 ubuntu:20.04-x-powerpc64el ubuntu:20.04-x-s390 ubuntu:21.04-x-mips ubuntu:21.04-x-mips64
   1    29.83 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   2    40.15 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   3    49.76 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
   4    38.37 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
   5    45.28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
   6    45.15 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
   7: fedora:24-x-ARC-uClibc

Some more to go, but should be ok by now.

- Arnaldo

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 46e1df45efc04627..174e7d83fcbdb22f 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -4,7 +4,7 @@
  * 55898 Rev 0.35 - Feb 5, 2021
  */
 
-#include <asm/msr-index.h>
+#include "msr-index.h"
 
 /*
  * IBS Hardware MSRs
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 4a6b2b4ec5074a49..f1e46277e8226b5a 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -34,7 +34,6 @@ arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/include/asm/irq_vectors.h
 arch/x86/include/asm/msr-index.h
-arch/x86/include/asm/amd-ibs.h
 arch/x86/include/uapi/asm/prctl.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
@@ -145,6 +144,7 @@ done
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
+check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
