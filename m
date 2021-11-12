Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD4C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 21:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F6560FBF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 21:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhKLV4t (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhKLV4s (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 16:56:48 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82638C061766;
        Fri, 12 Nov 2021 13:53:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y196so8882791wmc.3;
        Fri, 12 Nov 2021 13:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cFjb/lDzzlXVJnZfz1as4jhxMaf6Lx1QqAEp4XJUqg=;
        b=b7A7QfCdpPbJyRls7yWUAUdTlkwy3RQjasXDIK1XYMULHIJesVfghnCB7HtJTBufD+
         28TiYhXDBw/CBMBf9NjgvPY6RzeW3ri3Y8WFfjPEOWHJTufXAlBRPAQM8qo5UCiwB0+e
         Xb6VWNn/dVLjdsgKmqdOxgyPdFFJnSEdn31QuAIRTOoWvNHMd/FOevUzujWDLy6p/iis
         3562u+JfAFhdkIlm+2uFycueXlJMZHTe7Lx+ilP/cvTFWNrnKmUYBrREwRHoTkuMPChg
         OGRq7tCKCmcAZ5E3HMeXCQYO2Dof3CSp/g9h+OlzkiotzC5NVasOrZSKKKgYr4wavD8g
         ewdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7cFjb/lDzzlXVJnZfz1as4jhxMaf6Lx1QqAEp4XJUqg=;
        b=idxDUffSbuuX9OPsei54Vb8pa2b1jlcdzWU6jatibhip2bkoJ2/EaDzrUq/XmiEBsi
         Wwl7LTp5gn3hXP8/avX9NqK0N10cRPWuJRbF8j8sJvwF+osjiVy+VssotYwvPFCSsuf0
         Hbdgs9gI5TarijFHBMJkArL4ZKwyIoen8djxBV6oK5Qa8Ua/hL0qVuLqejPPcqPOE6aF
         RrAjPm3+jQZchdM9Utr0imHwSh64cp9jCXqnwZOmX0RdA1M5AN/iAJGfbatcw7JWu3Hb
         5sHifdIrqo+iHyJNlDyzc8JzCUNt9T4mDWUiM1ELHFLq8Qly9Bkd97sctnCQc4ZvI4bv
         YcaQ==
X-Gm-Message-State: AOAM531Kp/Ga7UWUJgWKEOXSpMGfRg4eD5KVd4M3uWy5GPGiufgizi7o
        R+tflRbhjbHb31MKfN3RR9IAcAXaoP7eLg==
X-Google-Smtp-Source: ABdhPJyMgtVQZ/MpQOF2AuJPkBhdoZDSBgAEp2yBjG4kGYPpC5oDwfVmPAPAyiUNosNf6yzsdztpxw==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr20178245wmc.39.1636754035994;
        Fri, 12 Nov 2021 13:53:55 -0800 (PST)
Received: from localhost.localdomain ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id x21sm12498686wmc.14.2021.11.12.13.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:53:55 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     sohaib.amhmd@gmail.com, rickyman7@gmail.com, irogers@google.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench: flush stats when pipe it to a file or to tee
Date:   Fri, 12 Nov 2021 23:53:12 +0200
Message-Id: <20211112215313.108823-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The output of perf bench gets buffered when I pipe it to a file or to
tee, in such a way that I can see it only at the end.

E.g.
$ perf bench internals synthesize -t
< output comes out fine after each test run >

$ perf bench internals synthesize -t | tee file.txt
< output comes out only at the end of all tests >

See, also:
$ perf bench mem all | tee file.txt
$ perf bench sched all | tee file.txt
$ perf bench internals all -t | tee file.txt
$ perf bench internals all | tee file.txt

Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 tools/perf/bench/find-bit-bench.c | 1 +
 tools/perf/bench/synthesize.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
index 22b5cfe97023..39fb4184fbcb 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -113,6 +113,7 @@ static int do_for_each_set_bit(unsigned int num_bits)

 		if (use_of_val == accumulator)  /* Try to avoid compiler tricks. */
 			printf("\n");
+		fflush(stdout);
 	}
 	bitmap_free(to_test);
 	return 0;
diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 7401ebbac100..d21d311df61b 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -92,6 +92,7 @@ static int do_run_single_threaded(struct perf_session *session,
 		update_stats(&event_stats, atomic_read(&event_count));
 	}

+	fflush(stdout);
 	time_average = avg_stats(&time_stats);
 	time_stddev = stddev_stats(&time_stats);
 	printf("  Average %ssynthesis took: %.3f usec (+- %.3f usec)\n",
@@ -186,6 +187,7 @@ static int do_run_multi_threaded(struct target *target,
 		perf_session__delete(session);
 	}

+	fflush(stdout);
 	time_average = avg_stats(&time_stats);
 	time_stddev = stddev_stats(&time_stats);
 	printf("    Average synthesis took: %.3f usec (+- %.3f usec)\n",
--
2.25.1

