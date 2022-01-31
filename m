Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A9BC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 Jan 2022 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiAaKeU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 Jan 2022 05:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358210AbiAaKeT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 Jan 2022 05:34:19 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982CC061714
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 02:34:19 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id l20-20020a05600c1d1400b0035153bf34c3so7423088wms.2
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jan 2022 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UKwbbY9OvBECTqZsXnc3pFs8yvEOFYua3q+Sg/9PamM=;
        b=eWt3zv0kRA4wQt3MlbgMyJgscYdJwQgBWw0btUhS0++HVsyL7mEaMZXZt2cdiSsN/V
         TS/hKlLe7fIjzWMsyQhpGF8aXcCX+2qHFuymKyFS/XDVgolXTfzWejSa2u4l3OxRnToZ
         WegL29fR2dShOZ8nww+tXS0f+VePPYa+YEdFgakJQQf7pgQrmcAJU7ltPaVYTjidvf39
         vti1Z6HtWxlCCVpiy/a4IrPxqptHV5iuvlHYgW/OB3gBrZ+1jGXoqNCIFUTm+b8oVrJy
         eRlq6B1LYn+5GNrfNhgFBNJmWv+DuC4WsMhKHJjqVFGjQxN8Azb/tjNtm88keE62o3eU
         t2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UKwbbY9OvBECTqZsXnc3pFs8yvEOFYua3q+Sg/9PamM=;
        b=VCatJVvpAVbbE8fVoYnhJGt0IJPQmyk0OBtgUG9j1KgaW/M6e62uCfS7yXoi33EFXT
         4bAjvuRKWjdE/XcImQ0LtkgvnYczqp8v8+7oNtmTh2nssFscXnGYzcfI0bqIHWWAweuM
         fLEFVXN2kPMicW6eVqv7BipLIl8fgOXZQGphA3jqLNUdbRO3NDQ9OqkMTHnfAdNipBhb
         MbvfQWlSmTIsGJTA3TZ2TRPmmUJdQIfTxrzz1z+TLjr2gV35/QrKtI3nub3d7EXNaH93
         0akBQtvCRM7t/MC2L1cdNFQ7Eu66NNl0MVDp+MPtkyGNyWW09NXUFC7OjLZ1yiYAIyb+
         S67w==
X-Gm-Message-State: AOAM531FHSiIezkduFSJVFs3k+GPBC/6k12B08txBMbq6zSXfoHj+aWR
        J5zphv/nQt5m1s/0dYGrzJrr8RtMqA==
X-Google-Smtp-Source: ABdhPJw+UEZg1ncwcYgblG7tTB1/5HqlTFOzk7CD5OyF3EeH6ucbq2Rp3Lx5iXubkkDLzuqdsMvQaVJG4w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:76:dcf3:95f9:db8b])
 (user=elver job=sendgmr) by 2002:a05:600c:4f4e:: with SMTP id
 m14mr17527439wmq.155.1643625258015; Mon, 31 Jan 2022 02:34:18 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:34:06 +0100
In-Reply-To: <20220131103407.1971678-1-elver@google.com>
Message-Id: <20220131103407.1971678-2-elver@google.com>
Mime-Version: 1.0
References: <20220131103407.1971678-1-elver@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 2/3] selftests/perf_events: Test modification of perf_event_attr::sig_data
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Test that PERF_EVENT_IOC_MODIFY_ATTRIBUTES correctly modifies
perf_event_attr::sig_data as well.

Signed-off-by: Marco Elver <elver@google.com>
---
 .../selftests/perf_events/sigtrap_threads.c     | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 8e83cf91513a..6d849dc2bee0 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -44,9 +44,10 @@ static struct {
 } ctx;
 
 /* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
-#define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
+#define TEST_SIG_DATA(addr, id) (~(unsigned long)(addr) + id)
 
-static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
+static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr,
+					      unsigned long id)
 {
 	struct perf_event_attr attr = {
 		.type		= PERF_TYPE_BREAKPOINT,
@@ -60,7 +61,7 @@ static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
 		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
 		.remove_on_exec = 1, /* Required by sigtrap. */
 		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
-		.sig_data	= TEST_SIG_DATA(addr),
+		.sig_data	= TEST_SIG_DATA(addr, id),
 	};
 	return attr;
 }
@@ -110,7 +111,7 @@ FIXTURE(sigtrap_threads)
 
 FIXTURE_SETUP(sigtrap_threads)
 {
-	struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on);
+	struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on, 0);
 	struct sigaction action = {};
 	int i;
 
@@ -165,7 +166,7 @@ TEST_F(sigtrap_threads, enable_event)
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
 	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 
 	/* Check enabled for parent. */
 	ctx.iterate_on = 0;
@@ -175,7 +176,7 @@ TEST_F(sigtrap_threads, enable_event)
 /* Test that modification propagates to all inherited events. */
 TEST_F(sigtrap_threads, modify_and_enable_event)
 {
-	struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on);
+	struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on, 42);
 
 	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr), 0);
 	run_test_threads(_metadata, self);
@@ -184,7 +185,7 @@ TEST_F(sigtrap_threads, modify_and_enable_event)
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
 	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 42));
 
 	/* Check enabled for parent. */
 	ctx.iterate_on = 0;
@@ -204,7 +205,7 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
 	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on, 0));
 }
 
 TEST_HARNESS_MAIN
-- 
2.35.0.rc2.247.g8bbb082509-goog

