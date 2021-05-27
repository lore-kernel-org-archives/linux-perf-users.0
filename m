Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F07C4707F
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 10:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D124613BA
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 10:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhE0KoQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 27 May 2021 06:44:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236157AbhE0KoP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 27 May 2021 06:44:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4B6D13A1;
        Thu, 27 May 2021 03:42:42 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.0.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E378F3F73D;
        Thu, 27 May 2021 03:42:39 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3] perf cs-etm: Split Coresight decode by aux records
Date:   Thu, 27 May 2021 13:42:34 +0300
Message-Id: <20210527104234.24313-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Populate the auxtrace queues using AUX records rather than whole
auxtrace buffers.

This is similar to the auxtrace_queues__process_index() ->
auxtrace_queues__add_indexed_event() flow where
perf_session__peek_event() is used to read AUXTRACE events out of random
positions in the file based on the auxtrace index.

Now there is a second pass using perf_session__peek_events() which loops
over all PERF_RECORD_AUX events, finds the corresponding auxtrace
buffer, and adds a fragment of that buffer to the auxtrace queues,
rather than the whole buffer.

This is a completely new implementation compared to v1 and v2 of the
patchset where significant modifications were made to the decoding flow,
including saving all of the AUX records, and changing the point where
decoding started. These changes had effects on the outcome of decoding,
but with this implementation, the output of decoding is identical to
perf/core, except in the case where decoding failed due to the issue
that this change addresses. No changes to decoding were made, apart
from populating the auxtrace queues.

Because the decoder is already reset between each auxtrace buffer,
populating the queues with fragments of whole buffers based on AUX
records has the same affect as resetting the decoder on the AUX record
bounds during decode. But this approach only requires a change to one
part of the whole flow, rather than many parts.

There is still one TODO about how buffers are found. Currently there is
a plain loop as a search, but this could be improved with a binary
search or keeping a record of which buffers have already been added and
starting the search from the last used place. AUX records and buffers
will come in similar orders in the file so the latter would be simpler
and probably be good enough. But I'm looking for feedback about the
approach as a whole before ironing out all of the details.

Other issues that were fixed by the previous patchsets such as fixing
the case where the first aux record comes before the first MMAP record
can now be fixed as completely independent issues.

Testing
=======

Testing was done with the following script, to diff the decoding results
between the patched and un-patched versions of perf:

	#!/bin/bash
	set -ex

	$1 script -i $3 $4 > split.script
	$2 script -i $3 $4 > default.script

	diff split.script default.script | head -n 20

And it was run like this, with various itrace options depending on the
quantity of synthesised events:

	compare.sh ./perf-patched ./perf-default perf-per-cpu-2-threads.data --itrace=i100000ns

No changes in output were observed in the following scenarios:

* Simple per-cpu
	perf record -e cs_etm/@tmc_etr0/u top

* Per-thread, single thread
	perf record -e cs_etm/@tmc_etr0/u --per-thread ./threads_C

* Per-thread multiple threads (but only one thread collected data):
	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597

* Per-thread multiple threads (both threads collected data):
	perf record -e cs_etm/@tmc_etr0/u --per-thread --pid 4596,4597

* Per-cpu explicit threads:
	perf record -e cs_etm/@tmc_etr0/u --pid 853,854

* System-wide (per-cpu):
    perf record -e cs_etm/@tmc_etr0/u -a

* No data collected (no aux buffers)
	Can happen with any command when run for a short period

* Containing truncated records
	Can happen with any command

* Containing aux records with 0 size
	Can happen with any command

Snapshot mode still needs to be tested.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 151 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 64536a6ed10a..5d6c03488187 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2679,6 +2679,153 @@ static u64 *cs_etm__create_meta_blk(u64 *buff_in, int *buff_in_offset,
 	return metadata;
 }
 
+/**
+ * Puts a fragment of an auxtrace buffer into the auxtrace queues based
+ * on the bounds of aux_event, if it matches with the buffer that's at
+ * file_offset.
+ *
+ * Normally, whole auxtrace buffers would be added to the queue. But we
+ * want to reset the decoder for every PERF_RECORD_AUX event, and the decoder
+ * is reset across each buffer, so splitting the buffers up in advance has
+ * the same effect.
+ */
+static int cs_etm__queue_aux_fragment(struct perf_session *session,
+						off_t file_offset, size_t sz,
+						struct perf_record_aux *aux_event,
+						struct perf_sample *sample)
+{
+	int err;
+	char buf[PERF_SAMPLE_MAX_SIZE];
+	union perf_event *auxtrace_event_union;
+	struct perf_record_auxtrace *auxtrace_event;
+	union perf_event auxtrace_fragment;
+	bool matchesCpuPid;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	/*
+	 * There should be a PERF_RECORD_AUXTRACE event at the file_offset that we got
+	 * from looping through the auxtrace index.
+	 */
+	err = perf_session__peek_event(session, file_offset, buf,
+				       PERF_SAMPLE_MAX_SIZE, &auxtrace_event_union, NULL);
+	if (err)
+		return err;
+	auxtrace_event = &auxtrace_event_union->auxtrace;
+	if (auxtrace_event->header.type != PERF_RECORD_AUXTRACE)
+		return -EINVAL;
+
+	if (auxtrace_event->header.size < sizeof(struct perf_record_auxtrace) ||
+		auxtrace_event->header.size != sz) {
+		return -EINVAL;
+	}
+
+	/*
+	 * In per-thread mode, CPU is set to -1, but TID will be set instead.
+	 * See auxtrace_mmap_params__set_idx()
+	 */
+	if (auxtrace_event->cpu == (__u32) -1)
+		matchesCpuPid = auxtrace_event->tid == sample->tid;
+	else
+		matchesCpuPid = auxtrace_event->cpu == sample->cpu;
+
+	if (matchesCpuPid &&
+	    aux_event->aux_offset >= auxtrace_event->offset &&
+	    aux_event->aux_offset + aux_event->aux_size <=
+			auxtrace_event->offset + auxtrace_event->size) {
+		/*
+		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
+		 * based on the sizes of the aux event, and queue that fragment.
+		 */
+		auxtrace_fragment.auxtrace = *auxtrace_event;
+		auxtrace_fragment.auxtrace.size = aux_event->aux_size;
+		auxtrace_fragment.auxtrace.offset = aux_event->aux_offset;
+		file_offset += aux_event->aux_offset - auxtrace_event->offset +
+				auxtrace_event->header.size;
+		return auxtrace_queues__add_event(&etm->queues,
+					       session,
+					       &auxtrace_fragment,
+					       file_offset,
+					       NULL);
+	}
+
+	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
+	return 1;
+}
+
+static int cs_etm__queue_aux_records_cb(struct perf_session *session,
+			     union perf_event *event, u64 offset __maybe_unused,
+			     void *data __maybe_unused)
+{
+	struct perf_sample sample;
+	int ret;
+	struct auxtrace_index_entry *ent;
+	struct auxtrace_index *auxtrace_index;
+	struct evsel *evsel;
+	size_t i;
+	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	/* Don't care about any other events, we're only queuing buffers for AUX events */
+	if (event->header.type != PERF_RECORD_AUX)
+		return 0;
+
+	if (event->header.size < sizeof(struct perf_record_aux))
+		return -EINVAL;
+
+	/* Truncated Aux records can have 0 size and shouldn't result in anything being queued. */
+	if (!event->aux.aux_size)
+		return 0;
+
+	/*
+	 * Parse the sample, we need the sample_id_all data that comes after the event so that the
+	 * CPU or PID can be matched to an AUXTRACE buffer's CPU or PID.
+	 */
+	evsel = evlist__event2evsel(session->evlist, event);
+	evsel__parse_sample(evsel, event, &sample);
+
+	/*
+	 * Loop throuch the auxtrace index to find the buffer that matches up with this
+	 * aux event.
+	 * TODO: binary search?
+	 */
+	list_for_each_entry(auxtrace_index, &session->auxtrace_index, list) {
+		for (i = 0; i < auxtrace_index->nr; i++) {
+			ent = &auxtrace_index->entries[i];
+			ret = cs_etm__queue_aux_fragment(session, ent->file_offset,
+							 ent->sz, &event->aux, &sample);
+			if (!ret) {
+				etm->data_queued = true;
+				return 0;
+			} else if (ret < 0) {
+				/*
+				 * Anything other than 1 is an error. Positive values are 'not
+				 * found' we just want to go onto the next one in that case.
+				 */
+				return ret;
+			}
+		}
+	}
+
+	/*
+	 * We would get here if there are no entries in the index (either no auxtrace buffers or
+	 * no index). Fail silently as there is the possibility of queueing them in
+	 * cs_etm__process_auxtrace_event() if etm->data_queued is still false;
+	 *
+	 * In that scenario, buffers will not be split by AUX records.
+	 */
+	return 0;
+}
+
+static int cs_etm__queue_aux_records(struct perf_session *session)
+{
+	return perf_session__peek_events(session, session->header.data_offset,
+					 session->header.data_size,
+					 cs_etm__queue_aux_records_cb, NULL);
+}
+
 int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session)
 {
@@ -2879,12 +3026,10 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_delete_thread;
 
-	err = auxtrace_queues__process_index(&etm->queues, session);
+	err = cs_etm__queue_aux_records(session);
 	if (err)
 		goto err_delete_thread;
 
-	etm->data_queued = etm->queues.populated;
-
 	return 0;
 
 err_delete_thread:
-- 
2.28.0

