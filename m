Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98876C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 15:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A4BA61B04
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jul 2021 15:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhG0PI1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232328AbhG0PI1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jul 2021 11:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE1D561B22;
        Tue, 27 Jul 2021 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627398507;
        bh=r1VSYpNzhzOjFrdIwXO7XZ/o6DWg1islt0qNrbNpaz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWHQyKWkwlkZHr602J/saSjSZMdEa1yZXIG/ZSZ+IqIe5QcFbrb/ARFJ4UuEU1SV3
         gIdDqWBkj5T7196S3urGL1h5//u317iGqovWgLKBYzmcnjZqthq8fttzuqxsCt9iVI
         yNd8ym1BVovzpkESXJHlUrS1E7Zag5syTPZRIFKiciIYf+d67S4cd8ZkkIq91oTM6l
         5V7g7d6/+vxnDzKD3gOu+m0eq3nbWxOVdFbXRypvSDMltcGAanPmH2Vhk9jiMbgpRJ
         bCN/JDdC4v+EibiJ/V7VcVDhpotBN4vVQtNK1gIF3+dGmz5YDz027Y/f7zgMRAEsqq
         Yv9pRa21Zi2sA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF71E403F2; Tue, 27 Jul 2021 12:08:22 -0300 (-03)
Date:   Tue, 27 Jul 2021 12:08:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf beauty: Reuse the generic switch.
Message-ID: <YQAhZp/tCDhYEp6L@kernel.org>
References: <20210513060441.408507-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513060441.408507-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 12, 2021 at 11:04:41PM -0700, Ian Rogers escreveu:
> Previously the code would see if, for example,
> tools/perf/arch/arm/include/uapi/asm/errno.h exists and if not generate

If tools/arch/arm/include/uapi/asm/errno.h exists, drop that 'perf/'
after 'tools/':

⬢[acme@toolbox perf]$ ls -la tools/arch/*/include/uapi/asm/errno.h
-rw-r--r--. 1 acme acme 5434 Jul 15 16:17 tools/arch/alpha/include/uapi/asm/errno.h
-rw-r--r--. 1 acme acme 5792 Jul 15 16:17 tools/arch/mips/include/uapi/asm/errno.h
-rw-r--r--. 1 acme acme 5764 Jul 15 16:17 tools/arch/parisc/include/uapi/asm/errno.h
-rw-r--r--. 1 acme acme  278 Jul 15 16:17 tools/arch/powerpc/include/uapi/asm/errno.h
-rw-r--r--. 1 acme acme 5539 Jul 15 16:17 tools/arch/sparc/include/uapi/asm/errno.h
-rw-r--r--. 1 acme acme   31 Jul 15 16:17 tools/arch/x86/include/uapi/asm/errno.h
⬢[acme@toolbox perf]$

I added the steps needed to translate your description to verify
everything and added as committer notes.

Thanks, applied as:

commit b22cc9a6701143fb1fee397e0c2088ee0473340a
Author: Ian Rogers <irogers@google.com>
Date:   Wed May 12 23:04:41 2021 -0700

    perf beauty: Reuse the generic arch errno switch
    
    Previously the code would see if, for example,
    tools/perf/arch/arm/include/uapi/asm/errno.h exists and if not generate
    a "generic" switch statement using the asm-generic/errno.h.
    
    This creates multiple identical "generic" switch statements before the
    default generic switch statement for an unknown architecture.
    
    By simplifying the archlist to be only for architectures that are not
    "generic" the amount of generated code can be reduced from 14 down to 6
    functions.
    
    Remove the special case of x86, instead reverse the architecture names
    so that it comes first.
    
    Committer testing:
    
      $ tools/perf/trace/beauty/arch_errno_names.sh gcc tools > before
    
    Apply this patch and:
    
      $ tools/perf/trace/beauty/arch_errno_names.sh gcc tools > after
    
    14 arches down to 6, that are the ones with an explicit errno.h file:
    
      $ ls -1 tools/arch/*/include/uapi/asm/errno.h
      tools/arch/alpha/include/uapi/asm/errno.h
      tools/arch/mips/include/uapi/asm/errno.h
      tools/arch/parisc/include/uapi/asm/errno.h
      tools/arch/powerpc/include/uapi/asm/errno.h
      tools/arch/sparc/include/uapi/asm/errno.h
      tools/arch/x86/include/uapi/asm/errno.h
      $
    
      $ diff -u4 before after
      @@ -2099,32 +987,16 @@
       const char *arch_syscalls__strerrno(const char *arch, int err)
       {
            if (!strcmp(arch, "x86"))
                    return errno_to_name__x86(err);
      -     if (!strcmp(arch, "alpha"))
      -             return errno_to_name__alpha(err);
      -     if (!strcmp(arch, "arc"))
      -             return errno_to_name__arc(err);
      -     if (!strcmp(arch, "arm"))
      -             return errno_to_name__arm(err);
      -     if (!strcmp(arch, "arm64"))
      -             return errno_to_name__arm64(err);
      -     if (!strcmp(arch, "csky"))
      -             return errno_to_name__csky(err);
      -     if (!strcmp(arch, "mips"))
      -             return errno_to_name__mips(err);
      -     if (!strcmp(arch, "parisc"))
      -             return errno_to_name__parisc(err);
      -     if (!strcmp(arch, "powerpc"))
      -             return errno_to_name__powerpc(err);
      -     if (!strcmp(arch, "riscv"))
      -             return errno_to_name__riscv(err);
      -     if (!strcmp(arch, "s390"))
      -             return errno_to_name__s390(err);
      -     if (!strcmp(arch, "sh"))
      -             return errno_to_name__sh(err);
            if (!strcmp(arch, "sparc"))
                    return errno_to_name__sparc(err);
      -     if (!strcmp(arch, "xtensa"))
      -             return errno_to_name__xtensa(err);
      +     if (!strcmp(arch, "powerpc"))
      +             return errno_to_name__powerpc(err);
      +     if (!strcmp(arch, "parisc"))
      +             return errno_to_name__parisc(err);
      +     if (!strcmp(arch, "mips"))
      +             return errno_to_name__mips(err);
      +     if (!strcmp(arch, "alpha"))
      +             return errno_to_name__alpha(err);
            return errno_to_name__generic(err);
       }
    
    The rest of the patch is the removal of the errno_to_name__generic()
    unneeded clones.
    
    Signed-off-by: Ian Rogers <irogers@google.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lore.kernel.org/lkml/20210513060441.408507-1-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 9f9ea45cddc4384c..2c5f72fa81087956 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -87,14 +87,13 @@ cat <<EoHEADER
 
 EoHEADER
 
-# Create list of architectures and ignore those that do not appear
-# in tools/perf/arch
+# Create list of architectures that have a specific errno.h.
 archlist=""
-for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | grep -v x86 | sort); do
-	test -d $toolsdir/perf/arch/$arch && archlist="$archlist $arch"
+for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
+	test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
 done
 
-for arch in x86 $archlist generic; do
+for arch in generic $archlist; do
 	process_arch "$arch"
 done
-create_arch_errno_table_func "x86 $archlist" "generic"
+create_arch_errno_table_func "$archlist" "generic"
