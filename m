Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6907CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA86610E7
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJHUX3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232076AbhJHUX3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 16:23:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F66E61019;
        Fri,  8 Oct 2021 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633724493;
        bh=IGdWzYGe+SviM/0R4DR44+iD/TKsI15+WP8YeXCAk+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHyAOjnJj7+NBfwANfu3nicnyyl6wnoniVfS8DjtT+KxuW8ECgsciDM8CYGRyNMVY
         F2+YY4N/Dvysx7Zj+XbOs225sfl5l4NkidUnpH6X4IaJ5GsEfOh5eRBiDNvo9xbRiz
         gHYD3h1ztTeLNumo2piqCqNHg53a/Hz/QbWShjXysXNiMjY9+BBriUxJc/i+EBv79A
         akqpPRU+0Z0DKfi1KTXZ1OgkZCfCxHKGrKWJaTYGII3JOsn616MrFgpN9k8WUkzWum
         K7N2iU4Tz4kY0GVoRotp8YuWbU/srv9p4Gx9MEFIudlbgQR77BqPydRB9czlKsQIkL
         mQOftQsluo12A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 310EA410A1; Fri,  8 Oct 2021 17:21:29 -0300 (-03)
Date:   Fri, 8 Oct 2021 17:21:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        ToastC <mrtoastcheng@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Felix Fietkau <nbd@nbd.name>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Song Liu <songliubraving@fb.com>, Fabian Hemmer <copy@copy.sh>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 01/21] tools lib: Add list_sort.
Message-ID: <YWCoSV+M5C2IZ7cd@kernel.org>
References: <20211007165647.3514803-1-irogers@google.com>
 <20211007165647.3514803-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211007165647.3514803-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Oct 07, 2021 at 09:56:27AM -0700, Ian Rogers escreveu:
> Add list_sort.[ch] from the main kernel tree. The linux/bug.h #include
> is removed due to conflicting definitions. Add check-headers and modify
> perf build accordingly.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

⬢[acme@toolbox perf]$ make -C tools/perf build-test
make: Entering directory '/var/home/acme/git/perf/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
make[1]: *** [tests/make:347: tarpkg] Error 2
make: *** [Makefile:103: build-test] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'

⬢[acme@toolbox perf]$ ./tools/perf/tests/perf-targz-src-pkg tools/perf
  PERF_VERSION = 5.15.rc4.g0df4a50ab5aa
  PERF_VERSION = 5.15.rc4.g0df4a50ab5aa
make[4]: *** No rule to make target '../lib/list_sort.c', needed by 'util/list_sort.o'.  Stop.
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [/tmp/tmp.FxRkhaWUYd/perf-5.15.0-rc4/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:660: perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:240: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
⬢[acme@toolbox perf]$

Adding this new file to the file below cures things, I'm doing it:

diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index f05c4d48fd7e01c0..e728615a3830848f 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -17,6 +17,7 @@ tools/lib/symbol/kallsyms.c
 tools/lib/symbol/kallsyms.h
 tools/lib/find_bit.c
 tools/lib/bitmap.c
+tools/lib/list_sort.c
 tools/lib/str_error_r.c
 tools/lib/vsprintf.c
 tools/lib/zalloc.c
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index d7c976671e3a131a..a685d20165f785a1 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -18,6 +18,7 @@ util/mmap.c
 util/namespaces.c
 ../lib/bitmap.c
 ../lib/find_bit.c
+../lib/list_sort.c
 ../lib/hweight.c
 ../lib/string.c
 ../lib/vsprintf.c
