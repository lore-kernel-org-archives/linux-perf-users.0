Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE0C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 06:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15083617E5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 06:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhKSGR1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 01:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhKSGRZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 01:17:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C6C061574;
        Thu, 18 Nov 2021 22:14:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r8so16142203wra.7;
        Thu, 18 Nov 2021 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6hJoQP/qTYzgOj5iX39aXQFUKoO5JZyoxh9IrlQx1Y=;
        b=XCLzn0h+OjuKUpRT6kK3BEloHaWkW7+NyKcHHe9P3AQ3av0C/u6r2/mGvok7xRfLaM
         VUvgRVs2yp8veYSVOpVEB7MTjKQbzVdhNzUBznvJ7lzEc9fYpZxhnJIFXLTrTJedlGmH
         0iVCCPyhvf/AzGfDQZyKnJvQmBQ9Ho+NHhnA9Nz8d723skiuCHu97w3+SXm//lO3Tlx9
         yIbFh3Un7TX/TEKdie2c2iwoTtkC2NJfKHBGmDxX86Bkii6J0dV9sI/d2+Ab6lZrPBLF
         sLd2z/6DsSJns6Vh15Z7zCNvUAG0M3vaNNQ4QlUBFnhli/khBsFnQ3viNzXMZi/SVtFX
         LDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c6hJoQP/qTYzgOj5iX39aXQFUKoO5JZyoxh9IrlQx1Y=;
        b=iE/WOtv6uTe3HUlcBaJu0NPG/5gsZoiVHI/JaVe2uwTMNXkmjSiY3/0ubphpgrbRfb
         sOhPUyJXwvYyDNMOi1lgt/gL7ybNe4osregAn6FnCIW8uyA3Na81rXo58xXR+ht90ZGw
         pZ32Fnjz5aB9j3yLi4C0P5bYpaM7xMLQOjRSV6Pxc1kmXq8XoaDfUKTiObakB9R00uPa
         0AmNkkosP/mo5vfdVYUjDiNWsoGGz6Lju25lnChniglQRtmWEBvmLqWMSiJ5uZyX9WDZ
         IN7pHVvJMZEv1bDkNKGBCc1ABqYW9l8GDdCN8af9pWccUeHmePm6M2s6Htt6+IqHQZCN
         FCXw==
X-Gm-Message-State: AOAM5337scnFY/a3Os9cK2WSvnGg1udIjaMgIx7trs/DmhjWmrPL5vw3
        +eDqNCZL2DeDwDKIn1SHU3g=
X-Google-Smtp-Source: ABdhPJwtTivKcqlWFwAAcJC4AqckhTgLDs7q3KCslBhO8mCOGgJ6z0QEf0KPfz2EesWqcr8wgMMT+Q==
X-Received: by 2002:a05:6000:1544:: with SMTP id 4mr4396926wry.358.1637302460183;
        Thu, 18 Nov 2021 22:14:20 -0800 (PST)
Received: from localhost.localdomain ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id 10sm2510887wrb.75.2021.11.18.22.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 22:14:19 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, irogers@google.com,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Unbuffered output when pipe/tee to a file
Date:   Fri, 19 Nov 2021 08:14:08 +0200
Message-Id: <20211119061409.78004-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The output of Perf bench gets buffered when I pipe it to a file or to
tee, in such a way that I can see it only at the end.

E.g.
$ perf bench internals synthesize -t
< output comes out fine after each test run >

$ perf bench internals synthesize -t | tee file.txt
< output comes out only at the end of all tests >

This patch resolves this issue for 'bench' and 'test' subcommands.

See, also:
$ perf bench mem all | tee file.txt
$ perf bench sched all | tee file.txt
$ perf bench internals all -t | tee file.txt
$ perf bench internals all | tee file.txt

Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
v1 -> v2:
- Use setvbuf(), instead of sprinkling fflush() calls and missing some places.

v1: https://lore.kernel.org/linux-perf-users/20211112215313.108823-1-sohaib.amhmd@gmail.com/
---
 tools/perf/builtin-bench.c      | 5 +++--
 tools/perf/tests/builtin-test.c | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index d0895162c2ba..d291f3a8af5f 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -226,7 +226,6 @@ static void run_collection(struct collection *coll)
 		if (!bench->fn)
 			break;
 		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
-		fflush(stdout);

 		argv[1] = bench->name;
 		run_bench(coll->name, bench->name, bench->fn, 1, argv);
@@ -247,6 +246,9 @@ int cmd_bench(int argc, const char **argv)
 	struct collection *coll;
 	int ret = 0;

+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
 	if (argc < 2) {
 		/* No collection specified. */
 		print_usage();
@@ -300,7 +302,6 @@ int cmd_bench(int argc, const char **argv)

 			if (bench_format == BENCH_FORMAT_DEFAULT)
 				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
-			fflush(stdout);
 			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
 			goto end;
 		}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 8cb5a1c3489e..d92ae4efd2e6 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -606,6 +606,9 @@ int cmd_test(int argc, const char **argv)
         if (ret < 0)
                 return ret;

+	/* Unbuffered output */
+	setvbuf(stdout, NULL, _IONBF, 0);
+
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
--
2.25.1

