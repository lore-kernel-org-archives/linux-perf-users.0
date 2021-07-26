Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F1BC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8860F46
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Jul 2021 10:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhGZKC5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhGZKC5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Jul 2021 06:02:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556B5C061757;
        Mon, 26 Jul 2021 03:43:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id da26so9965874edb.1;
        Mon, 26 Jul 2021 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=AkL+3e8jBrNcLRkjbsBpF4y4JNtsRO+AcpLHdmakYls=;
        b=dNIgSn/VSK9XUHmG020MXHJtiOa1BBuZktZDvQsVM4EXlxWYLk2EblEnR7aFJZNChT
         vCj2AZlpA0778Rfi7131ebzbWFCoyibOjB+mg9cypa697MB4bhdWI25Ru++ktcTEQojd
         UUlx6md3ISevOhYLgvoybN8xXOavoVEd23P1DOp9F69+bj4TJYXAIVGEMOtn+KF/r39J
         5zIABlmXmT2mWDEcx+ikDqvUW82II6J/8oyFAQuL0+J3dSzjEQtIU1BfSgf5RKiZhFzl
         0dxTtZ9YUmtZw03P+1eqwhjYF3+3RXVgRqskF8nYJLG7y8HM3tM3+IBJM5wH0OkHb1HM
         Whyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AkL+3e8jBrNcLRkjbsBpF4y4JNtsRO+AcpLHdmakYls=;
        b=R+w/9gk6sSxr925YNLme2BlJA2JW62xogTmvsSWwR9a5k/TD+ciicvhPMuCNbvclv4
         2w4+YtoSuJ9XRfRKKTrQz3ITm8aCKXBOaz4veMgZJAdydbjhNdUnHj3W/3iPnaOAexDW
         tUf7pSSofoWaWR6UDVandoWcIlKnBcjk8bs4xwb9vMuJzDQBSirq3x37L7Pg+jsXsd7M
         rnD79Fnab70Ziad5a2EsEx9TsouXZcYrPNtmzCLx1RGcldv5S/qU7r/B2Anu62fw4MDi
         O41cA5jNLEq42n9EZyVD1DekFOJaCnLH/yRLSTQhPIs6w8DLl1OAX3eYhqKKGWNKjTdh
         aUfw==
X-Gm-Message-State: AOAM533HBF/gMngcuUrf2CWKUHhcW0fkgGWtwI+JvPfCxty9/VtKewPW
        hE74zFlVHpMCAtC1bezOm1k=
X-Google-Smtp-Source: ABdhPJxDfkJEAMFGxAObkgGTwqm3Bv/qEzKSGrwvzjvYCBbKZ6BqGggwYOWJRMBAcpakyqgnySl0Kw==
X-Received: by 2002:a50:d71e:: with SMTP id t30mr8563995edi.72.1627296202929;
        Mon, 26 Jul 2021 03:43:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id z27sm3092181eja.59.2021.07.26.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 03:43:22 -0700 (PDT)
Message-ID: <b57142d5ada4a852836f7c0bcbd9cffc4fb8681e.camel@gmail.com>
Subject: Re: [PATCH 1/3] tools libc_compat: add gettid
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Date:   Mon, 26 Jul 2021 12:43:21 +0200
In-Reply-To: <202107260534.Q3Cd7MYm-lkp@intel.com>
References: <309becd325626e04015ad7b5f6fc701e569f918d.1626966805.git.rickyman7@gmail.com>
         <202107260534.Q3Cd7MYm-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

as reported by the kernel test robot, I forgot to include sys/syscall.h and
unistd.h, which were included by some other headers in perf but is causing
troubles in the bpf selftest.
However, this is not all, since bpf tests are still failing since they do not
use HAVE_* macros, therefore gettid gets defined twice (in libc and
libc_compat.h).
Since, afaict, bpf is no longer using libc_compat.h [1] (perf is be the only
user atm), I would remove its dependency on libc_compat.h.
Furthermore, this made me also think whether the HAVE_* or NEED_* macros are
more suited for this case (reallocarray is using COMPAT_NEED_REALLOCARRAY,
gettid is using HAVE_GETTID). I believe HAVE_* are better since compilation
fails if they are missing or misused (as in this case), while NEED_* failures
may be more subtle (ie. only happening with older versions of libc). Therefore,
I think we should also change COMPAT_NEED_REALLOCARRAY to HAVE_REALLOCARRAY.
What do you think?

[1] https://lore.kernel.org/bpf/20200819013607.3607269-2-andriin@fb.com/

Thanks,
Riccardo

On Mon, 2021-07-26 at 06:04 +0800, kernel test robot wrote:
> Hi Riccardo,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on linux/master linus/master v5.14-rc2 next-20210723]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:   
> https://github.com/0day-ci/linux/commits/Riccardo-Mancini/tools-add-gettid-to-libc_compat-h/20210722-233601
> base:  
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git c76826a65f50038f0504
> 24365dbf3f97203f8710
> config: x86_64-rhel-8.3-kselftests (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         #
> https://github.com/0day-ci/linux/commit/42df183984cce4c25932242bbf9133684e9425db
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Riccardo-Mancini/tools-add-gettid-to-
> libc_compat-h/20210722-233601
>         git checkout 42df183984cce4c25932242bbf9133684e9425db
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash -C
> tools/testing/selftests/bpf install
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from main.h:15,
>                     from xlated_dumper.c:14:
>    tools/include/tools/libc_compat.h: In function 'gettid':
>    tools/include/tools/libc_compat.h:24:16: warning: implicit declaration of
> function 'syscall' [-Wimplicit-function-declaration]
>       24 |  return (pid_t)syscall(__NR_gettid);
>          |                ^~~~~~~
> > > tools/include/tools/libc_compat.h:24:24: error: '__NR_gettid' undeclared
> > > (first use in this function)
>       24 |  return (pid_t)syscall(__NR_gettid);
>          |                        ^~~~~~~~~~~
>    tools/include/tools/libc_compat.h:24:24: note: each undeclared identifier is
> reported only once for each function it appears in
> --
>    In file included from main.h:15,
>                     from common.c:27:
> > > tools/include/tools/libc_compat.h:22:21: error: static declaration of
> > > 'gettid' follows non-static declaration
>       22 | static inline pid_t gettid(void)
>          |                     ^~~~~~
>    In file included from /usr/include/unistd.h:1170,
>                     from common.c:15:
>    /usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous
> declaration of 'gettid' was here
>       34 | extern __pid_t gettid (void) __THROW;
>          |                ^~~~~~
>    In file included from main.h:15,
>                     from common.c:27:
>    tools/include/tools/libc_compat.h: In function 'gettid':
> > > tools/include/tools/libc_compat.h:24:24: error: '__NR_gettid' undeclared
> > > (first use in this function)
>       24 |  return (pid_t)syscall(__NR_gettid);
>          |                        ^~~~~~~~~~~
>    tools/include/tools/libc_compat.h:24:24: note: each undeclared identifier is
> reported only once for each function it appears in
> --
>    In file included from main.h:15,
>                     from btf.c:20:
>    tools/include/tools/libc_compat.h: In function 'gettid':
> > > tools/include/tools/libc_compat.h:24:24: error: '__NR_gettid' undeclared
> > > (first use in this function)
>       24 |  return (pid_t)syscall(__NR_gettid);
>          |                        ^~~~~~~~~~~
>    tools/include/tools/libc_compat.h:24:24: note: each undeclared identifier is
> reported only once for each function it appears in
> 
> 
> vim +/__NR_gettid +24 tools/include/tools/libc_compat.h
> 
>     20  
>     21  #ifndef HAVE_GETTID
>   > 22  static inline pid_t gettid(void)
>     23  {
>   > 24          return (pid_t)syscall(__NR_gettid);
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


