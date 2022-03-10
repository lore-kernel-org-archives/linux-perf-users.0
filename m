Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79977C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Mar 2022 09:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiCJJkB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiCJJkA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Mar 2022 04:40:00 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877641B781
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Mar 2022 01:38:59 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id t8-20020adfa2c8000000b001e8f6889404so1486161wra.0
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Mar 2022 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LzAOFFkeKRRy9GW6WPFJI1nv4Gmx5I7ZyhCyHYDjtOE=;
        b=aFsDVFoksSjan0XyYhfEjancqGaSPRjCuudwfv9LN5VOTsJhcqoRuZnnhmJZF00slH
         iL+chvrIxdmi9dYZsTTf8JSInKQb9pubxUqgThbMrUAXTrpSXdLaFumHtid5tj0MJUEI
         S2iKY0cuokOX2I8tFxqOD3GUVl8OU226xFt3kRvfe4Jg3hJSdOXtc4pCfakZeLhKDXL5
         56UttuqedLxBI6bsZqLymRCARbxXpx2S0tKK1Aci1yeYcj0LsqX89xPX4bCfrjI/+Ws3
         KPKyuqCdtxF28oIS299Ugo1omZg8DEt2sG78eMnG8EXghEQR7VSEjSvLbKkQt4ntPYVY
         D7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LzAOFFkeKRRy9GW6WPFJI1nv4Gmx5I7ZyhCyHYDjtOE=;
        b=PImB67iROqAueHw7lb7YQAnXH38REEX36e+nXpSGqbYnR5chumpsamft6tWKVaGjA+
         H5OXMlnN5Vaduu+z7vvZlnFKwrjuL2Q03sOi+dGlBilXW5F2w6FHvcA8F0C+1VE4DqWq
         4ChNtXtUik5G+M9/JT3aBoIfOtupQabm2YTBCKu9C1Y62hpdQ7ylvtemphUd9oltCMra
         mkoxkpoShWOwLv2Tpwy6JYFIZl4URAUJ/MiPMyxP6YP53BRlhU5PJiIChtgWdr5mUJma
         Ne/dN7HH1tc1TQTJ3S1vgH4f4wDVUbTpgakcpYAANfiE8h5fZwP4snPGbaD7MvuWKZV+
         /V6Q==
X-Gm-Message-State: AOAM5306JT3GXpRzdA/v/9LoXeeaQKj4bIkyy+2t72P1qnEMLrVamJno
        AOMEP1iRS9P7UQ/dEkillEH3bdB+Wg==
X-Google-Smtp-Source: ABdhPJykaYQntlwKDIsoBuNM1726ZLPt6OSdioP0EWZRmZ3s9hA78Nu7ic4/qkIz5QyHpRD22NlMRMGEsg==
X-Received: from sesstop.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:26f6])
 (user=sesse job=sendgmr) by 2002:a5d:4b87:0:b0:1f0:68b1:5741 with SMTP id
 b7-20020a5d4b87000000b001f068b15741mr2795795wrt.69.1646905137970; Thu, 10 Mar
 2022 01:38:57 -0800 (PST)
Date:   Thu, 10 Mar 2022 10:38:44 +0100
Message-Id: <20220310093844.982656-1-sesse@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH] perf intel-pt: Synthesize cycle events
From:   "Steinar H. Gunderson" <sesse@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

There is no good reason why we cannot synthesize "cycle" events
from Intel PT just as we can synthesize "instruction" events,
in particular when CYC packets are available. This enables using
PT to getting much more accurate cycle profiles than regular sampling
(record -e cycles) when the work last for very short periods (<10 ms).
Thus, add support for this, based off of the existing IPC calculation
framework. The new option to --itrace is "y" (for cYcles), as c was
taken for calls. Cycle and instruction events can be synthesized
together, and are by default.

The only real caveat is that CYC packets are only emitted whenever
some other packet is, which in practice is when a branch instruction
is encountered. Thus, even at no subsampling (e.g. --itrace=y0ns),
it is impossible to get more accuracy than a single basic block, and all
cycles spent executing that block will get attributed to the branch
instruction that ends it. Thus, one cannot know whether the cycles came
from e.g. a specific load, a mispredicted branch, or something else.
When subsampling (which is the default), the cycle events will get
smeared out even more, but will still be useful to attribute cycle
counts to functions.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
---
 tools/perf/Documentation/itrace.txt        |  3 +-
 tools/perf/Documentation/perf-intel-pt.txt | 33 +++++++-----
 tools/perf/util/auxtrace.c                 |  9 +++-
 tools/perf/util/auxtrace.h                 |  7 ++-
 tools/perf/util/intel-pt.c                 | 59 +++++++++++++++++++---
 5 files changed, 88 insertions(+), 23 deletions(-)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c52755481e2f..af69d80a05b7 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -1,4 +1,5 @@
 		i	synthesize instructions events
+		y	synthesize cycles events
 		b	synthesize branches events (branch misses for Arm SPE)
 		c	synthesize branches events (calls only)
 		r	synthesize branches events (returns only)
@@ -23,7 +24,7 @@
 		A	approximate IPC
 		Z	prefer to ignore timestamps (so-called "timeless" decoding)
 
-	The default is all events i.e. the same as --itrace=ibxwpe,
+	The default is all events i.e. the same as --itrace=iybxwpe,
 	except for perf script where it is --itrace=ce
 
 	In addition, the period (default 100000, except for perf script where it is 1)
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index cbb920f5d056..d457facfde03 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -101,12 +101,12 @@ data is available you can use the 'perf script' tool with all itrace sampling
 options, which will list all the samples.
 
 	perf record -e intel_pt//u ls
-	perf script --itrace=ibxwpe
+	perf script --itrace=iybxwpe
 
 An interesting field that is not printed by default is 'flags' which can be
 displayed as follows:
 
-	perf script --itrace=ibxwpe -F+flags
+	perf script --itrace=iybxwpe -F+flags
 
 The flags are "bcrosyiABExgh" which stand for branch, call, return, conditional,
 system, asynchronous, interrupt, transaction abort, trace begin, trace end,
@@ -146,16 +146,17 @@ displayed as follows:
 There are two ways that instructions-per-cycle (IPC) can be calculated depending
 on the recording.
 
-If the 'cyc' config term (see config terms section below) was used, then IPC is
-calculated using the cycle count from CYC packets, otherwise MTC packets are
-used - refer to the 'mtc' config term.  When MTC is used, however, the values
-are less accurate because the timing is less accurate.
+If the 'cyc' config term (see config terms section below) was used, then IPC
+and cycle events are calculated using the cycle count from CYC packets, otherwise
+MTC packets are used - refer to the 'mtc' config term.  When MTC is used, however,
+the values are less accurate because the timing is less accurate.
 
 Because Intel PT does not update the cycle count on every branch or instruction,
 the values will often be zero.  When there are values, they will be the number
 of instructions and number of cycles since the last update, and thus represent
-the average IPC since the last IPC for that event type.  Note IPC for "branches"
-events is calculated separately from IPC for "instructions" events.
+the average IPC cycle count since the last IPC for that event type.
+Note IPC for "branches" events is calculated separately from IPC for "instructions"
+events.
 
 Even with the 'cyc' config term, it is possible to produce IPC information for
 every change of timestamp, but at the expense of accuracy.  That is selected by
@@ -865,11 +866,12 @@ Having no option is the same as
 
 which, in turn, is the same as
 
-	--itrace=cepwx
+	--itrace=cepwxy
 
 The letters are:
 
 	i	synthesize "instructions" events
+	y	synthesize "cycles" events
 	b	synthesize "branches" events
 	x	synthesize "transactions" events
 	w	synthesize "ptwrite" events
@@ -890,6 +892,13 @@ The letters are:
 "Instructions" events look like they were recorded by "perf record -e
 instructions".
 
+"Cycles" events look like they were recorded by "perf record -e cycles"
+(ie., the default). Note that even with CYC packets enabled and no sampling,
+these are not fully accurate, since CYC packets are not emitted for each
+instruction, only when some other event (like a branch) happens causes
+a packet to be emitted. Thus, it is more effective for attributing cycles
+to functions and (possibly basic blocks) than to individual instructions.
+
 "Branches" events look like they were recorded by "perf record -e branches". "c"
 and "r" can be combined to get calls and returns.
 
@@ -897,9 +906,9 @@ and "r" can be combined to get calls and returns.
 'flags' field can be used in perf script to determine whether the event is a
 transaction start, commit or abort.
 
-Note that "instructions", "branches" and "transactions" events depend on code
-flow packets which can be disabled by using the config term "branch=0".  Refer
-to the config terms section above.
+Note that "instructions", "cycles", "branches" and "transactions" events
+depend on code flow packets which can be disabled by using the config term
+"branch=0".  Refer to the config terms section above.
 
 "ptwrite" events record the payload of the ptwrite instruction and whether
 "fup_on_ptw" was used.  "ptwrite" events depend on PTWRITE packets which are
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 825336304a37..18e457b80bde 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1346,6 +1346,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 		synth_opts->calls = true;
 	} else {
 		synth_opts->instructions = true;
+		synth_opts->cycles = true;
 		synth_opts->period_type = PERF_ITRACE_DEFAULT_PERIOD_TYPE;
 		synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
 	}
@@ -1424,7 +1425,11 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 	for (p = str; *p;) {
 		switch (*p++) {
 		case 'i':
-			synth_opts->instructions = true;
+		case 'y':
+			if (p[-1] == 'y')
+				synth_opts->cycles = true;
+			else
+				synth_opts->instructions = true;
 			while (*p == ' ' || *p == ',')
 				p += 1;
 			if (isdigit(*p)) {
@@ -1578,7 +1583,7 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
 		}
 	}
 out:
-	if (synth_opts->instructions) {
+	if (synth_opts->instructions || synth_opts->cycles) {
 		if (!period_type_set)
 			synth_opts->period_type =
 					PERF_ITRACE_DEFAULT_PERIOD_TYPE;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 19910b9011f3..7cd6bad3e46a 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -69,6 +69,9 @@ enum itrace_period_type {
  * @inject: indicates the event (not just the sample) must be fully synthesized
  *          because 'perf inject' will write it out
  * @instructions: whether to synthesize 'instructions' events
+ * @cycles: whether to synthesize 'cycles' events
+ *          (not fully accurate, since CYC packets are only emitted
+ *          together with other events, such as branches)
  * @branches: whether to synthesize 'branches' events
  *            (branch misses only for Arm SPE)
  * @transactions: whether to synthesize events for transactions
@@ -115,6 +118,7 @@ struct itrace_synth_opts {
 	bool			default_no_sample;
 	bool			inject;
 	bool			instructions;
+	bool			cycles;
 	bool			branches;
 	bool			transactions;
 	bool			ptwrites;
@@ -628,6 +632,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 
 #define ITRACE_HELP \
 "				i[period]:    		synthesize instructions events\n" \
+"				y[period]:    		synthesize cycles events (same period as i)\n" \
 "				b:	    		synthesize branches events (branch misses for Arm SPE)\n" \
 "				c:	    		synthesize branches events (calls only)\n"	\
 "				r:	    		synthesize branches events (returns only)\n" \
@@ -657,7 +662,7 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
 "				A:			approximate IPC\n" \
 "				Z:			prefer to ignore timestamps (so-called \"timeless\" decoding)\n" \
 "				PERIOD[ns|us|ms|i|t]:   specify period to sample stream\n" \
-"				concatenate multiple options. Default is ibxwpe or cewp\n"
+"				concatenate multiple options. Default is iybxwpe or cewp\n"
 
 static inline
 void itrace_synth_opts__set_time_range(struct itrace_synth_opts *opts,
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e8613cbda331..f6597db89962 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -5,6 +5,7 @@
  */
 
 #include <inttypes.h>
+#include <linux/perf_event.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -89,6 +90,10 @@ struct intel_pt {
 	u64 instructions_sample_type;
 	u64 instructions_id;
 
+	bool sample_cycles;
+	u64 cycles_sample_type;
+	u64 cycles_id;
+
 	bool sample_branches;
 	u32 branches_filter;
 	u64 branches_sample_type;
@@ -1217,7 +1222,7 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	if (pt->filts.cnt > 0)
 		params.pgd_ip = intel_pt_pgd_ip;
 
-	if (pt->synth_opts.instructions) {
+	if (pt->synth_opts.instructions || pt->synth_opts.cycles) {
 		if (pt->synth_opts.period) {
 			switch (pt->synth_opts.period_type) {
 			case PERF_ITRACE_PERIOD_INSTRUCTIONS:
@@ -1615,11 +1620,12 @@ static void intel_pt_prep_sample(struct intel_pt *pt,
 	}
 }
 
-static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
+static int intel_pt_synth_instruction_or_cycle_sample(struct intel_pt_queue *ptq)
 {
 	struct intel_pt *pt = ptq->pt;
 	union perf_event *event = ptq->event_buf;
 	struct perf_sample sample = { .ip = 0, };
+	int err;
 
 	if (intel_pt_skip_event(pt))
 		return 0;
@@ -1633,7 +1639,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 	else
 		sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
-	if (ptq->sample_ipc)
+	if (ptq->sample_ipc || pt->sample_cycles)
 		sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
 	if (sample.cyc_cnt) {
 		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
@@ -1643,8 +1649,30 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
-	return intel_pt_deliver_synth_event(pt, event, &sample,
-					    pt->instructions_sample_type);
+	if (pt->sample_instructions) {
+		err = intel_pt_deliver_synth_event(pt, event, &sample,
+						   pt->instructions_sample_type);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * NOTE: If not doing sampling (e.g. itrace=y0us), we will in practice
+	 * only see cycles being attributed to branches, since CYC packets
+	 * only are emitted together with other packets are emitted.
+	 * We should perhaps consider spreading it out over everything since
+	 * the last CYC packet, ie., since last time sample.cyc_cnt was nonzero.
+	 */
+	if (pt->sample_cycles && sample.cyc_cnt) {
+		sample.id = ptq->pt->cycles_id;
+		sample.stream_id = ptq->pt->cycles_id;
+		err = intel_pt_deliver_synth_event(pt, event, &sample,
+						   pt->cycles_sample_type);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
@@ -2301,8 +2329,9 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
-	if (pt->sample_instructions && (state->type & INTEL_PT_INSTRUCTION)) {
-		err = intel_pt_synth_instruction_sample(ptq);
+	if ((pt->sample_instructions || pt->sample_cycles) &&
+	    (state->type & INTEL_PT_INSTRUCTION)) {
+		err = intel_pt_synth_instruction_or_cycle_sample(ptq);
 		if (err)
 			return err;
 	}
@@ -3378,6 +3407,22 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		id += 1;
 	}
 
+	if (pt->synth_opts.cycles) {
+		attr.config = PERF_COUNT_HW_CPU_CYCLES;
+		if (pt->synth_opts.period_type == PERF_ITRACE_PERIOD_NANOSECS)
+			attr.sample_period =
+				intel_pt_ns_to_ticks(pt, pt->synth_opts.period);
+		else
+			attr.sample_period = pt->synth_opts.period;
+		err = intel_pt_synth_event(session, "cycles", &attr, id);
+		if (err)
+			return err;
+		pt->sample_cycles = true;
+		pt->cycles_sample_type = attr.sample_type;
+		pt->cycles_id = id;
+		id += 1;
+	}
+
 	attr.sample_type &= ~(u64)PERF_SAMPLE_PERIOD;
 	attr.sample_period = 1;
 
-- 
2.35.1

