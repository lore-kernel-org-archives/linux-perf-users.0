Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965896;
	b=wLflC71djMFNm7BtWvEewRdYpF8pcxGKV5WYiUXSESysVtuKj8O50e5BV89DZKOud/58
	 KXziAPKTewe98069Y55RB8GqIZHmZ283XyTi4jwhvCVhNWe074phCLWk3SF0CvLrS1SRI
	 4I3QDj3D3dWlx/c/IhClFU9QBr2IAdGVfOwKPb6++5bUZGwGsjzCF9Sc39GtBNvJ8fLUV
	 LFpfB2yRYjBSDRsa+Whm+VK46kNvQ/QP3b6c9n6h1RJuqCjsEPsdae7EXNkPlJ/5aBSCj
	 VzkQThx7g8E4utxa2IVO53xZGxsn18Ux55gd98OqmKnNH8oxzKsBiG4u2u8PyP3s6IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=OfqLq2Wyjby8tJh1B5C3yDh0EX/uJgrZHG+gv1L4SSI=;
	b=Jg/jyDTglxcW6swbDgig+iyCkpgqpZtf3oASgcFLxP3OAzatvnIs1HOsUj/BKZODpx1/
	 NL4Pe20yBilQ2bud7hsCmOam9TNIEayaxU4Io099u8agSHStIy/iKc3a/WDcoDmQf8vyI
	 1ahi704eAJeaaAg6AFJvTFAUdjQgqPAqg/Q9ClLMeeo2QLfsLtYJVoDqw4xP0ZD9lyiAd
	 LOUN0DJNL0lcf8kNaIQk5Z7/7EfFxjVwNRXeiAOBggSEpijoaxc+o4enzJ5RvhfghvFDx
	 DBrpuAcyZyJk1FiHZkFSeAk8BRI8geP/zLP0+LnygSJNqBrOU67/pKiIWCgHfcRC3rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RJgFPabG;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EEB606A33C
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3EEB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RJgFPabG
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35cbea41088so3838762eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965895; x=1793570695; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfqLq2Wyjby8tJh1B5C3yDh0EX/uJgrZHG+gv1L4SSI=;
        b=RJgFPabGH1Z8HH02RP2SVN8f+xyQZsgoh148XWYjG1p4N6gpLZn1HyPXEedBYVMnV6
         zxEOW7tV6pUDJTPd1fdHaPek8z/PSqshfv76M7ff9EJdr1oxFaYyBQGRw2CYdwj1rfTb
         tX3oGW3N5hZ44a0oZbaUyrE+7xD2flgWCaufwYR8Gtgkk9X9rXUMA232H/VB9tp+1RjU
         Y42v4FR2C0F8WZFJ9FvIbERa9/wk9NC6m5vz0syv7lF64KMKZtSSRJn+FbWQ7jSq4YBo
         3Kn+C6hAG14LjQaORsrsgKnRXSOZZBDV2NuKR4L7L9cb8eFn/5etmvaFCjgd3nwo3ypx
         Rqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965895; x=1793570695;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfqLq2Wyjby8tJh1B5C3yDh0EX/uJgrZHG+gv1L4SSI=;
        b=0wQwOI6TbP8zVuxFp/jh0zmkBD42rfuwYfb6w2G2wlm4nyFMC0Nr3+dh4QwIOaSdqr
         MBmVUcuPCOX3yblVss54UOz4AvF6lISgU0baXbnxI4Mm9sUc98pwVjpybpMkYed2D6Ii
         WluePFjsTHZ93jh0ljEg/0570dYGJTEnwn6Eg3WBedPlLgR2sB4Oec3GKplMOljVxoab
         WZZNZ0Sohnb9603tD4kFrLx8Qzqj/lOZvuukrnxmmxnBcmg830RCkQmABubc2wpIBaYh
         xisnEMiqOXjWPiEh4IH64UhjXkhhMv6AvyM8WI266srDkKW0IUcObo/FGdEg9a5oWiAS
         LKqA==
X-Forwarded-Encrypted: i=1; AKwUvBxSoMXWWBDxWisUrzpnLAjwD5SUb2cE7eFBVTfCB1X9MuIQOD1mOIHzs2IqOnt9NeuZZuWHi5dRYRMaJ0htbGpV@vger.kernel.org
X-Gm-Message-State: AFq9FYLuk06VOQKoLeMH89N9+zkU6k2kMS/+59vxhw3VFIU6j2UvFo6a
	0KbJjSR6FXc3cnI595RFkRfnC/pSkpmgHoakZHGUefTpzfRXp2l1wnL3FWjB+FOgBFJ/ia511lh
	dDKSMUCkujg==
X-Received: from dydxu14-n2.prod.google.com ([2002:a05:693c:894e:20b0:351:16da:ebbc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1403:b0:34d:755b:d60b
 with SMTP id 5a478bee46e88-369e8501bafmr7589789eec.34.1792965894554; Sun, 25
 Oct 2026 15:04:54 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:03:48 -0700
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025220349.1244499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025220349.1244499-6-irogers@google.com>
Subject: [PATCH v1 6/7] perf inject: Set ordering_requires_timestamps before
 creating session
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In cmd_inject(), inject.tool.ordering_requires_timestamps was initialized
after delegating tools (such as aslr_tool__new()) and __perf_session__new()
had already been called, leaving delegate tools with the uninitialized
value. Set ordering_requires_timestamps on inject.tool before creating
delegate tools and the session.

Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 49 ++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index c30f5aaabf4c..3f3108fd3981 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2463,13 +2463,18 @@ static int __cmd_inject(struct perf_inject *inject)
 #endif
 		}
 	} else if (inject->itrace_synth_opts.vm_time_correlation) {
+		bool ordered_events = inject->tool.ordered_events;
+		bool ordering_requires_timestamps =
+			inject->tool.ordering_requires_timestamps;
+
 		session->itrace_synth_opts = &inject->itrace_synth_opts;
-		perf_tool__init(&inject->tool, /*ordered_events=*/true);
+		perf_tool__init(&inject->tool, ordered_events);
 		inject->tool.id_index	    = perf_event__process_id_index;
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.auxtrace_error = perf_event__process_auxtrace_error;
-		inject->tool.ordering_requires_timestamps = true;
+		inject->tool.ordering_requires_timestamps =
+			ordering_requires_timestamps;
 	} else if (inject->itrace_synth_opts.set) {
 		session->itrace_synth_opts = &inject->itrace_synth_opts;
 		inject->itrace_synth_opts.inject = true;
@@ -2482,8 +2487,6 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.aux	    = perf_event__drop_aux;
 		inject->tool.itrace_start   = perf_event__drop_aux;
 		inject->tool.aux_output_hw_id = perf_event__drop_aux;
-		inject->tool.ordered_events = true;
-		inject->tool.ordering_requires_timestamps = true;
 		/* Allow space in the header for new attributes */
 		output_data_offset = roundup(8192 + session->header.data_offset, 4096);
 		if (inject->strip)
@@ -2514,12 +2517,6 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.finished_round	= host__finished_round;
 		/* Keep track of which CPU a VCPU is runnng on */
 		inject->tool.context_switch	= host__context_switch;
-		/*
-		 * Must order events to be able to obey finished round
-		 * ordering.
-		 */
-		inject->tool.ordered_events	= true;
-		inject->tool.ordering_requires_timestamps = true;
 		/* Set up a separate session to process guest perf.data file */
 		ret = guest_session__start(gs, name, session->data->force);
 		if (ret) {
@@ -2536,8 +2533,6 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.exit	= perf_event__repipe_exit;
 		inject->tool.mmap	= perf_event__repipe_mmap;
 		inject->tool.mmap2	= perf_event__repipe_mmap2;
-		inject->tool.ordered_events = true;
-		inject->tool.ordering_requires_timestamps = true;
 	}
 
 	if (!inject->itrace_synth_opts.set)
@@ -2816,6 +2811,10 @@ int cmd_inject(int argc, const char **argv)
 	data.path = inject.input_name;
 
 	ordered_events = inject.jit_mode || inject.sched_stat ||
+		inject.itrace_synth_opts.vm_time_correlation ||
+		inject.itrace_synth_opts.set ||
+		inject.guest_session.perf_data_file ||
+		inject.convert_callchain ||
 		inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
 		inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY;
 	perf_tool__init(&inject.tool, ordered_events);
@@ -2862,6 +2861,21 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.tool.merge_deferred_callchains = false;
+	if (inject.jit_mode ||
+	    inject.itrace_synth_opts.vm_time_correlation ||
+	    inject.itrace_synth_opts.set ||
+	    inject.guest_session.perf_data_file ||
+	    inject.convert_callchain ||
+	    inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
+	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
+		/*
+		 * to make sure the mmap records are ordered correctly
+		 * and so that the correct especially due to jitted code
+		 * mmaps. We cannot generate the buildid hit list and
+		 * inject the jit mmaps at the same time for now.
+		 */
+		inject.tool.ordering_requires_timestamps = true;
+	}
 	if (inject.aslr) {
 		tool = aslr_tool__new(&inject.tool);
 		if (!tool) {
@@ -2932,16 +2946,6 @@ int cmd_inject(int argc, const char **argv)
 		}
 	}
 
-	if (inject.build_id_style == BID_RWS__INJECT_HEADER_LAZY ||
-	    inject.build_id_style == BID_RWS__MMAP2_BUILDID_LAZY) {
-		/*
-		 * to make sure the mmap records are ordered correctly
-		 * and so that the correct especially due to jitted code
-		 * mmaps. We cannot generate the buildid hit list and
-		 * inject the jit mmaps at the same time for now.
-		 */
-		inject.tool.ordering_requires_timestamps = true;
-	}
 	if (inject.build_id_style != BID_RWS__NONE && known_build_ids != NULL) {
 		inject.known_build_ids =
 			perf_inject__parse_known_build_ids(known_build_ids);
@@ -2978,7 +2982,6 @@ int cmd_inject(int argc, const char **argv)
 	if (inject.jit_mode) {
 		inject.tool.mmap2	   = perf_event__repipe_mmap2;
 		inject.tool.mmap	   = perf_event__repipe_mmap;
-		inject.tool.ordering_requires_timestamps = true;
 		/*
 		 * JIT MMAP injection injects all MMAP events in one go, so it
 		 * does not obey finished_round semantics.
-- 
2.56.0.307.g5fe7bd680c-goog

