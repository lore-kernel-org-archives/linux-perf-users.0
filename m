Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F63C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 08:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E83860EB4
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 08:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhI0IPM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhI0INJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 04:13:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A69C061769;
        Mon, 27 Sep 2021 01:11:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so3107422pjv.5;
        Mon, 27 Sep 2021 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=me0nDcJ1BsVUxZtbF9wC1kc3Muw2nPnnQYADxLYEd54=;
        b=AsFm5ak+SxGBicsy6c6lYAPwGeN3HrQ99ujJm3G61UXmi0tKCj/SJxIbbqgWSP+kUI
         +Vj5Enz4rrcJbbRW4RyiJxZEKxmpGN0eyAcdPmRY2CTchSpBt3sO4oxpaoT31Mn8gTlO
         2SgMq8Ud2DSbnK17p0c/48fw6K1pnPgS8DMsvBUtOR/8bVFsq35KJglDQfULmktwkw4c
         3EDXC/EwzVDXDp7nq4mMonllpXSqatuvXmnCplIqwyanVzwm7typZlmGVZhSPXWTHfSv
         QArW5EfMq82vmQXrQ2GFjo5CgjMxGFBGRhgKmT+BRBIOdUnqtyp9CKLiG1zG7i+vWVV9
         1EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=me0nDcJ1BsVUxZtbF9wC1kc3Muw2nPnnQYADxLYEd54=;
        b=JY8IzHBEG7Jp4dS0/4oD6cleN6ghcudbH/p4397fq9hC/5L8OSvU4eqJdutubfdmJj
         U4sErTl78n+A2ZRS3cpf/fNx6P0BDancigXL65UQZHKYGQtMUq3ja2OPbMh0plNZiBIL
         Mxqx4hvh94QoyeuW4oyQtQ7bikl3k1HXchiznic9SiinVTYL1g7i78eYZZxxheAsbfGY
         jU6nROI/B1PUtwO6WWDYWdfR6mY4R9UvT4NrNitVxzhpOy7VnnZCw/21uMBYvGin88Yr
         jf7ewMIMtaRoTp7WbAuADui1gddnQaj4BVQe+dd40pveOdGheXwGvcBXgh9LKiAWaB2h
         z29Q==
X-Gm-Message-State: AOAM530hbT/0IRDp7RD4jle43obq/mj9zJ4Op2/pg9DkGkLrq+CqIIfu
        TRjDNNVUtprTI6fE0ldxHWs=
X-Google-Smtp-Source: ABdhPJynV9bgCGUyEPcVj/7yPAlM5WqE7723LkvQnBZ/7QMJJoJ6/UUJr9pjuEp7S7T885rTtcounA==
X-Received: by 2002:a17:902:9a06:b0:13c:86d8:ce0b with SMTP id v6-20020a1709029a0600b0013c86d8ce0bmr21392009plp.51.1632730288297;
        Mon, 27 Sep 2021 01:11:28 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id y80sm16042240pfb.196.2021.09.27.01.11.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Sep 2021 01:11:28 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf iostat: Fix Segmentation fault from NULL 'struct perf_counts_values *'
Date:   Mon, 27 Sep 2021 16:11:15 +0800
Message-Id: <20210927081115.39568-2-likexu@tencent.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210927081115.39568-1-likexu@tencent.com>
References: <20210927081115.39568-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Like Xu <likexu@tencent.com>

If the perf-iostat user specifies two or more iio_root_ports and
also specifies the cpu(s) by -C which is not *connected to all*
the above iio ports, the iostat_print_metric() will run into trouble:

For example:

 $ perf iostat list
 S0-uncore_iio_0<0000:16>
 S1-uncore_iio_0<0000:97> # <--- CPU 1 is located in the socket S0

 $ perf iostat 0000:16,0000:97 -C 1 -- ls
 port 	Inbound Read(MB)	Inbound Write(MB)	Outbound Read(MB)	Outbound
 Write(MB) ../perf-iostat: line 12: 104418 Segmentation fault
 (core dumped) perf stat --iostat$DELIMITER$*

The core-dump stack says, in the above corner case, the returned
(struct perf_counts_values *) count will be NULL, and the caller
iostat_print_metric() apparently doesn't not handle this case.

 433	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
 434
 435	if (count->run && count->ena) {
 (gdb) p count
 $1 = (struct perf_counts_values *) 0x0

The deeper reason is that there are actually no statistics from the user
specified pair "iostat 0000:X, -C (disconnected) Y ", but let's fix it with
minimum cost by adding a NULL check in the user space.

Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/arch/x86/util/iostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index eeafe97b8105..792cd75ade33 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -432,7 +432,7 @@ void iostat_print_metric(struct perf_stat_config *config, struct evsel *evsel,
 	u8 die = ((struct iio_root_port *)evsel->priv)->die;
 	struct perf_counts_values *count = perf_counts(evsel->counts, die, 0);
 
-	if (count->run && count->ena) {
+	if (count && count->run && count->ena) {
 		if (evsel->prev_raw_counts && !out->force_header) {
 			struct perf_counts_values *prev_count =
 				perf_counts(evsel->prev_raw_counts, die, 0);
-- 
2.32.0

