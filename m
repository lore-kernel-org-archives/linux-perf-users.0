Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419526A1D0;
	Wed, 11 Jun 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653727; cv=none; b=JJtOYicXxErxpqhAOJl/OJ1SNoVD1QzBHuJuPkAWXcwjp14gk0kZn478iD7ecxeh0YkmqWAaUnOOowlQ1gVNUKivgEYoBt6iEMedJUAjGfFPH351bsd5kiTAZ0rCoGC7oBZiTCdGqpKDwBw68Q3Tbr0zfMRzcdmvuWzbqtzsRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653727; c=relaxed/simple;
	bh=FBCkRe+k8+xEOZprRRR6Xd/hIQOAiqScmRcgOoffXqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjlDa6XCcg6r910m8/+GDxpCZxxmgk9S6jKd0NF4A4ygb1ESp/ISSK5g3eu3swCjvTHhc7//3gwFDZcf58bNMQbWxuO/kGtEBghsIXjiShskVgMs/hRdFr/pdsf5ORQWuwNld2sFrDZq4kRZRVHjrg2Uisz21hgK3cGvDuxUcFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbqwceu/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbqwceu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB59C4CEE3;
	Wed, 11 Jun 2025 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653726;
	bh=FBCkRe+k8+xEOZprRRR6Xd/hIQOAiqScmRcgOoffXqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbqwceu/CVnCeD/ZqrAmfbcKVp7vzEOTzeCz535VVOuZZHRdB4e1PyOPm7JOhpgSQ
	 X0sWh8xY5DD6iJ5vs3IDmV1dHvTxnL7RHwJSN4nboRc4K/5nGz7KOegoNw/gpQVeiJ
	 Qw3vdO1WfVSYSKfD+HJqlfMfuLlvUwzW+RCLzUnMFzElTi8s+bK10pKVBk+cqmH1MW
	 893QodfZqTa3Uhf0e0QUWlulx6ANvdgxklDPNi63HtDZqn12CRIOj8KLqiYLHLL8yw
	 +aQHVEL5SXXQ10/ZYMhg8U46K/JBo3CSUwn+KPzMMPCnMyCB6V5GZaSj/58xjuzLDv
	 jDctSmQco4sTw==
Date: Wed, 11 Jun 2025 11:55:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <aEmY259Mx92D60KG@x1>
References: <aEh6xO14wDSCFUDr@google.com>
 <20250611092542.F4ooE2FL@linutronix.de>
 <aEmBOO0bSJYSvX2i@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmBOO0bSJYSvX2i@x1>

On Wed, Jun 11, 2025 at 10:14:32AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jun 11, 2025 at 11:25:42AM +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-06-10 11:34:44 [-0700], Namhyung Kim wrote:
> > > Hello,
> > Hi,
> > 
> > > I've updated the perf-tools-next to v6.16-rc1 and found a build error
> > > like below on alpine linux 3.18.
> > > 
> > >   In file included from bench/futex.c:6:
> > >   /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
> > >      88 | struct prctl_mm_map {
> > >         |        ^~~~~~~~~~~~
> > >   In file included from bench/futex.c:5:
> > >   /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
> > >     134 | struct prctl_mm_map {
> > >         |        ^~~~~~~~~~~~
> > >   make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
> > > 
> > > git bisect says it's the first commit introduced the failure.
> > 
> > Hmm. So your /usr/include/sys/prctl.h and
> > /linux/tools/include/uapi/linux/prctl.h both provide struct
> > prctl_mm_map but their include guard must be different.
> > 
> > My /usr/include/sys/prctl.h is provided by glibc and contains the
> > prctl() declaration. It includes also linux/prctl.h.
> > The tools/include/uapi/linux/prctl.h is the same as
> > /usr/include/linux/prctl.h.
> > 
> > The /usr/include/sys/prctl.h on alpine linux is different. This is
> > probably coming from musl. It contains the PR_* definition and the
> > prctl() declaration. So it clashes here because now the one struct is
> > available twice.
> > 
> > The man page for prctl(2) says:
> > |       #include <linux/prctl.h>  /* Definition of PR_* constants */
> > |       #include <sys/prctl.h>
> > 
> > so musl doesn't follow this.
> > 
> > To align with the other builds, I guess the following help:
> 
> So I noticed this as well in perf-tools/perf-tools, I'm trying with your
> patch applied, lets see...

Can I keep this as below?

With it:

toolsbuilder@five:~$ time dm from alpine:3.16
   5   130.36 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   6   100.65 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   7    90.44 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   8   106.18 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
   9   108.16 alpine:3.20                   : Ok   gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
  10   111.19 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 20.1.6 flex 2.6.4
  11   109.28 alpine:edge                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 19.1.4 flex 2.6.4
  12    92.62 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4) flex 2.6.4
  13    98.43 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  14    17.24 archlinux:base                : FAIL gcc version 14.2.1 20240805 (GCC) 
    <command-line>: error: "_FORTIFY_SOURCE" redefined [-Werror]
    <command-line>: note: this is the location of the previous definition
    cc1: all warnings being treated as errors
    error: command '/usr/sbin/gcc' failed with exit code 1
  15    97.65 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-21) , clang version 17.0.6 (Red Hat 17.0.6-1.module_el8+767+9fa966b8) flex 2.6.1

The archlinux one is unrelated. More are building now.

- Arnaldo

commit 8386dc356158fc50c55831c96b1248e01d112ebc
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Jun 11 11:25:42 2025 +0200

    perf bench futex: Fix prctl include in musl libc
    
    Namhyung Kim reported:
    
      I've updated the perf-tools-next to v6.16-rc1 and found a build error
      like below on alpine linux 3.18.
    
        In file included from bench/futex.c:6:
        /usr/include/sys/prctl.h:88:8: error: redefinition of 'struct prctl_mm_map'
           88 | struct prctl_mm_map {
              |        ^~~~~~~~~~~~
        In file included from bench/futex.c:5:
        /linux/tools/include/uapi/linux/prctl.h:134:8: note: originally defined here
          134 | struct prctl_mm_map {
              |        ^~~~~~~~~~~~
        make[4]: *** [/linux/tools/build/Makefile.build:86: /build/bench/futex.o] Error 1
    
      git bisect says it's the first commit introduced the failure.
    
    So your /usr/include/sys/prctl.h and
    /linux/tools/include/uapi/linux/prctl.h both provide struct prctl_mm_map
    but their include guard must be different.
    
    My /usr/include/sys/prctl.h is provided by glibc and contains the
    prctl() declaration. It includes also linux/prctl.h.  The
    tools/include/uapi/linux/prctl.h is the same as
    /usr/include/linux/prctl.h.
    
    The /usr/include/sys/prctl.h on alpine linux is different. This is
    probably coming from musl. It contains the PR_* definition and the
    prctl() declaration.  So it clashes here because now the one struct is
    available twice.
    
    The man page for prctl(2) says:
    
    |       #include <linux/prctl.h>  /* Definition of PR_* constants */
    |       #include <sys/prctl.h>
    
    so musl doesn't follow this.
    
    So align with the other builds.
    
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Reported-by: Namhyung Kim <namhyung@kernel.org>
    Link: https://lore.kernel.org/r/20250611092542.F4ooE2FL@linutronix.de
    [ Remove one more in tools/perf/bench/futex-hash.c and conditionally define PR_FUTEX_HASH and friends ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index fdf133c9520f73a4..d2d6d7f3ea331c84 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -18,7 +18,6 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/prctl.h>
 #include <linux/zalloc.h>
 #include <sys/time.h>
 #include <sys/mman.h>
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 26382e4d8d4ce2ff..4c4fee107e5912d5 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -2,11 +2,18 @@
 #include <err.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <linux/prctl.h>
 #include <sys/prctl.h>
 
 #include "futex.h"
 
+#ifndef PR_FUTEX_HASH
+#define PR_FUTEX_HASH                   78
+# define PR_FUTEX_HASH_SET_SLOTS        1
+# define FH_FLAG_IMMUTABLE              (1ULL << 0)
+# define PR_FUTEX_HASH_GET_SLOTS        2
+# define PR_FUTEX_HASH_GET_IMMUTABLE    3
+#endif // PR_FUTEX_HASH
+
 void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 {
 	unsigned long flags;
