Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB48C2B9F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F1C613EB
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 May 2021 16:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbhE1QRl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 May 2021 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhE1QRk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 May 2021 12:17:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD955C061574
        for <linux-perf-users@vger.kernel.org>; Fri, 28 May 2021 09:16:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q16so1859231pls.6
        for <linux-perf-users@vger.kernel.org>; Fri, 28 May 2021 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0AesoJC8dwORvJZMJlCBYhqk7Et+XhC6wlAE9oBGZmU=;
        b=BNXlCVIv2yFGtr4/5VcBsHUBS2FUvwvMCBbr83tzJOADVrNRwJT3qG9QbbauwZsa8N
         lL9oJx+4kgTstdtKP2uGfkK/4cF/valjhPq9GUC61cxGP8xE5IzliKNVw1LEtjibvEwc
         onD/pkaMmPlH1pHZhtNIY/6OyMVI/Ln1WeX8qXdHlrPYcgLHtAcKNTupIfGXTHAMZFdy
         ksb4/tAItKPY01+c97xaNU8jjlKgWiFMffVFhMLKTsVdmVKrs0PvHYmvHRK1OvktOgQB
         tqlQuxXtpsGxnTGnY3/l3oaNve7p1749MDSqPlx38u6gJ/6DZ9r2azPE90FmhhDQ6phi
         14xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0AesoJC8dwORvJZMJlCBYhqk7Et+XhC6wlAE9oBGZmU=;
        b=injMA90hdfE0lK0LhtP3t2wrePgSpn4d2ZE7KcfeqAkpI4iKD6JglEBTsdx0lTZwVy
         T35ZxqyS6q4kht6FSx82jbtTkQH/CAb0IEGjbQGigaWt9vr9KfaX8UwNFkAK1whrTNYI
         qLECV/WDU6WoQPPyMg4U07ZjrykeON+0caJNUwjOnXoal1YgiHRxkPFNUp1GJ5dayWtw
         ve1ZI50Bc9NjkfF8hzWF2TTQsFMBhFEh37ygoUGlzVgy4SwhX3TZNsH5JYQSUM9tNHGR
         PeLEgJwCaMGRqmwqfU05QLHhzmKykWdaGIBTXgwieOOyMkfJzL1l9KH+bUQf7h/OhPmY
         /1OQ==
X-Gm-Message-State: AOAM530TgfEZGC9Ci0rs3cOO6r7OnoHIslJPIxarwC69U+Tm2o619iqd
        kmfyFHXUxmaQUIk2PCrhHwu94Q==
X-Google-Smtp-Source: ABdhPJz3sQx7BOFbfTjpVcSP7iMwnq4OEB+6a7He3sKx3CCRW9+RzFVmw36Z/fxwU+MxNrYLviZu8A==
X-Received: by 2002:a17:902:d88e:b029:ff:1df8:f8b8 with SMTP id b14-20020a170902d88eb02900ff1df8f8b8mr7095746plz.4.1622218565185;
        Fri, 28 May 2021 09:16:05 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id u8sm4775604pgg.51.2021.05.28.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:16:04 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for snapshot
Date:   Sat, 29 May 2021 00:15:50 +0800
Message-Id: <20210528161552.654907-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528161552.654907-1-leo.yan@linaro.org>
References: <20210528161552.654907-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The perf tool records the Arm CoreSight trace data with snapshot mode
with the option '-S', when receiving USR2 signal, it is observed the
captured trace data size is very varied: from several MBs to ~20MBs.
This can be reproduced with the command:

  perf record -e cs_etm// -S \
	-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
  PERFPID=$!
  sleep 1
  kill -USR2 $PERFPID

It's different for only specifying option '-S' than options '-a -S'.  If
without option '-a', perf tool creates separate AUX buffers for every
CPU, but the tracer will be enabled only when the profiled program is
scheduled onto the corresponding CPU, this might lead to record very
old trace data when snapshot.

Let's see below diagram:
                                                            snapshot
  CPU0: ______###P1###__________________________________________|
  CPU1: __________________________###P3###____________###P5###__|
  CPU2: ____________________________________###P4###____________|
  CPU3: ________________###P2###________________________________V

In this diagram, the program runs for 5 periods (from P1 to P5), these 5
periods show the task run on different CPUs, e.g. during P1 period the
program runs on CPU0, and during P2 period the program is migrated to
CPU1, and so on.  At the end of P1 period when the program is switched
out from CPU0, the ETR trace data is saved into AUX trace buffer, this
AUX buffer is a dedicated buffer for CPU0's tracer.  With the same
logic, P2's trace data is saved into CPU3's tracer buffer, P4's trace
data is saved into CPU2's buffer, P3 and P5's trace data is saved into
CPU1's.  Therefore, when snapshot, it saves the trace data from all AUX
ring buffers (in this case, it have total 4 AUX ring buffers) into perf
data file.

This is why we can see varied trace data size, it's quite dependent on
the task scheduling on CPUs, if the task is spinned to only one CPU and
without scheduling out, it will only record trace data from only one
AUX trace buffer.  If the task is frequently scheduled in and out, then
it gives more chance to fill trace data into the AUX buffer.

In this example, it also causes the discontinuous trace data.  If P3's
trace data is lost after P5's trace data overwrites the AUX trace data,
thus perf tool fails to record continuous trace data if only have
trace data for P1/P2/P4/P5.

For snapshot mode, usually the user only wants to capture the trace data
for the specific time point and prior to the that point the tracer
should work with free run mode.  This means it's not necessary to
capture trace data for task's scheduling in and out until the perf tool
explicitly disables tracers for snapshot.  This can be fulfilled by
checking the variable "event->ctx->is_active", when the task is
scheduled out this variable is set to zero, and when snapshot this
variable is still non-zero value.  So the driver can only record trace
data only when "event->ctx->is_active" is non-zero.

After applying this change, the perf tool can record the consistent
trace data size for snapshot.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.c  | 30 +++++++++++++++++--
 .../hwtracing/coresight/coresight-etm-perf.h  |  2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 6f398377fec9..fd36d0530087 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -284,6 +284,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (!event_data)
 		return NULL;
 	INIT_WORK(&event_data->work, free_event_data);
+	event_data->overwrite = overwrite;
 
 	/* First get the selected sink from user space. */
 	if (event->attr.config2) {
@@ -517,9 +518,32 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		if (!sink_ops(sink)->update_buffer)
 			return;
 
-		size = sink_ops(sink)->update_buffer(sink, handle,
-					      event_data->snk_config);
-		perf_aux_output_end(handle, size);
+		/*
+		 * In the snapshot mode, if only specifies option '-S' (note,
+		 * user doesn't specify option '-a' in this case), the AUX ring
+		 * buffers are allocated for every CPU but the AUX trace is
+		 * recorded in per-thread mode.  In this mode, it's needless to
+		 * save AUX trace data into the AUX ring buffer when the
+		 * profiled program is scheduled out from a CPU, alternatively,
+		 * the driver should only capture AUX trace data when the perf
+		 * tool receives USR2 signal for taking snapshot.
+		 *
+		 * The variable "event->ctx->is_active" can be used to
+		 * distinguish the cases between the program scheduling out and
+		 * snapshot: its value is zero when the profiled task scheduled
+		 * out, and it is a non-zero value when perf tool invokes ioctl
+		 * PERF_EVENT_IOC_DISABLE for snapshot.
+		 *
+		 * Only updates AUX ring buffer for snapshot, or for the perf
+		 * session which is not in snapshot mode.
+		 */
+		if (!event_data->overwrite || event->ctx->is_active) {
+			size = sink_ops(sink)->update_buffer(sink, handle,
+						      event_data->snk_config);
+			perf_aux_output_end(handle, size);
+		} else {
+			perf_aux_output_end(handle, 0);
+		}
 	}
 
 	/* Disabling the path make its elements available to other sessions */
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3e4f2ad5e193..2cc3af05495f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -49,12 +49,14 @@ struct etm_filters {
  * @mask:		Hold the CPU(s) this event was set for.
  * @snk_config:		The sink configuration.
  * @path:		An array of path, each slot for one CPU.
+ * @overwrite:		Flag for snapshot mode.
  */
 struct etm_event_data {
 	struct work_struct work;
 	cpumask_t mask;
 	void *snk_config;
 	struct list_head * __percpu *path;
+	bool overwrite;
 };
 
 #if IS_ENABLED(CONFIG_CORESIGHT)
-- 
2.25.1

