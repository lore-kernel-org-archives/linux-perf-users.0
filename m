Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E48C49EA7
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3A3613CC
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Jun 2021 16:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhFXQpk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:45:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232248AbhFXQpi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Jun 2021 12:45:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA32AED1;
        Thu, 24 Jun 2021 09:43:18 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.13.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C41E3F719;
        Thu, 24 Jun 2021 09:43:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Date:   Thu, 24 Jun 2021 17:43:03 +0100
Message-Id: <20210624164303.28632-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210624164303.28632-1-james.clark@arm.com>
References: <20210624164303.28632-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently --dump-raw-trace skips queueing and splitting buffers because
of an early exit condition in cs_etm__process_auxtrace_info(). Once
that is removed we can print the split data by using the queues
and searching for split buffers with the same reference as the
one that is currently being processed.

This keeps the same behaviour of dumping in file order when an AUXTRACE
event appears, rather than moving trace dump to where AUX records are in
the file.

There will be a newline and size printout for each fragment. For example
this buffer is comprised of two AUX records, but was printed as one:

  0 0 0x8098 [0x30]: PERF_RECORD_AUXTRACE size: 0xa0  offset: 0  ref: 0x491a4dfc52fc0e6e  idx: 0  t

  . ... CoreSight ETM Trace data: size 160 bytes
          Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
          Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
          Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
          Idx:80; ID:10;  I_ASYNC : Alignment Synchronisation.
          Idx:92; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
          Idx:97; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0xFFFFDE2AD3FD76D4;

But is now printed as two fragments:

  0 0 0x8098 [0x30]: PERF_RECORD_AUXTRACE size: 0xa0  offset: 0  ref: 0x491a4dfc52fc0e6e  idx: 0  t

  . ... CoreSight ETM Trace data: size 80 bytes
          Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
          Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
          Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;

  . ... CoreSight ETM Trace data: size 80 bytes
          Idx:80; ID:10;  I_ASYNC : Alignment Synchronisation.
          Idx:92; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
          Idx:97; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0xFFFFDE2AD3FD76D4;

Decoding errors that appeared in problematic files are now not present,
for example:

        Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
        ...
        PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 88e8122f73c9..ad777c2a342f 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2430,6 +2430,22 @@ static int cs_etm__process_event(struct perf_session *session,
 	return 0;
 }
 
+static void dump_queued_data(struct cs_etm_auxtrace *etm,
+			     struct perf_record_auxtrace *event)
+{
+	struct auxtrace_buffer *buf;
+	unsigned int i;
+	/*
+	 * Find all buffers with same reference in the queues and dump them.
+	 * This is because the queues can contain multiple entries of the same
+	 * buffer that were split on aux records.
+	 */
+	for (i = 0; i < etm->queues.nr_queues; ++i)
+		list_for_each_entry(buf, &etm->queues.queue_array[i].head, list)
+			if (buf->reference == event->reference)
+				cs_etm__dump_event(etm, buf);
+}
+
 static int cs_etm__process_auxtrace_event(struct perf_session *session,
 					  union perf_event *event,
 					  struct perf_tool *tool __maybe_unused)
@@ -2462,7 +2478,8 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 				cs_etm__dump_event(etm, buffer);
 				auxtrace_buffer__put_data(buffer);
 			}
-	}
+	} else if (dump_trace)
+		dump_queued_data(etm, &event->auxtrace);
 
 	return 0;
 }
@@ -3038,7 +3055,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 	if (dump_trace) {
 		cs_etm__print_auxtrace_info(auxtrace_info->priv, num_cpu);
-		return 0;
 	}
 
 	err = cs_etm__synth_events(etm, session);
-- 
2.28.0

