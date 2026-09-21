Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072983537E5
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967253; cv=none; b=WkLbqswJSQ1yFD+5cgOQJRFCu6JAxa94Z4M8hOb0pmkCsep56nj15HMmiJiBNJmymqy02h0Z6Q/7M3/lrYOEghZLljOqRkxnd5kmXoqdzAV8x9MzNWVkdoZdchRbDSTuPDkXPcKqaQ8mM5LHrVfvQODbsmMWUnaKM5sMaqkZelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967253; c=relaxed/simple;
	bh=o5M0jZ5YfiZRF6sAzgtdJjRODspLtXN1XHtc9RmBpFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gab7p3F1ieunRkafnhh305UfNpcQ1HPbXJ4j3a3KJ5amX636TiEpnJ0POF4OI1S1bM6d4yDRPwXP9lcAR7x19YOCxow9A/kJUSA1zwVZCW1Ao5HQWI2xAwBiQALVY5m+kKYV6PA5Wgv4kvo/B6qzOhsCtMS/PNHuZxZdaZAlpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtGSvGHF; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtGSvGHF"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so6787637a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967251; x=1790572051; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRpHFZt5ixyx6D+aLau/jDSAEqIDn3ZK4zKoAUbdefo=;
        b=dtGSvGHFQgdrF6U185Pc/DDVzYcvNpnKAwy9p4XQqgJsNwVo5KOHtdERLPm3iNUmsn
         gFUpmDsQgII5gDb515n5Mshvcj7qd77aBQiEYY7vbkzOEGyj+G4WBhm3DbtEigzJv1qP
         62FY6/GcbFa1K61BlaVYziCGEGKzwHWtAidOlHvmhWJo7zPfczvChkg4Gao5954AVy73
         KI+d0CSYnbpHF3eJTvNK8T5kdC6jKEs3YBmuV3BnrfzdUi27lR14plN0JqXuHmu0sF8C
         Vd+phiYccbhXRioDXTxZCpyl4+g0M/ZKIbwoGxrsjU8RlKiWjlaJoBVgQHSLG6GJwTN/
         tNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967251; x=1790572051;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRpHFZt5ixyx6D+aLau/jDSAEqIDn3ZK4zKoAUbdefo=;
        b=fpbNRzq4he2IUGSD7Ur3bC1HeGp1L0PAzzjTQceB+8RATiyXk2YOrZaq7+nbzCaWDh
         Mdy/bZyhBz3iMMpin5y6oWOzQ7k/7DHRD9TooCiK7fz7LSXaT/kHzKxG6n1kOlEmrSHa
         6cQkHVV8JaFa0WAueCWcGbZM8rKNC73jsl0As6hg/Ek8f32Hez0NM93X5IWDmgPMNQCJ
         eH8/oUnVbC+Aqww63AO1zV+G18nGEZyrPuVQiQmes+ElZkKF4dSU5i5xJ3Q6BjkoNwQG
         YFYlqGtIVYnn9A5QaF8YoNJoGk8XGji6svZQ/QRWVeN0Mrwj5aySkAjjtZ/xtbv0kVYv
         QzyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsUkij6wvwUTeiKHRZGInRYYqKgdZOatbmQx+/VwcUOYUqY4ZSXCV4WgUOMaq9FO28iXQXPd682FF+m9cq5h5y@vger.kernel.org
X-Gm-Message-State: AFuF++kvU/nXHNxw/NcdILflHRnYih+SuA6+zhpeDE+6cAznVbgglN9D
	MDoUD1B1mAPL5e7WJ0FgdNCAzUjVwcGDzN/yQtF/PDaiBKgmNGb2dpuQIQVHMEu4RhEUFbi4zeL
	15XHMMiy3FA==
X-Received: from dly25-n2.prod.google.com ([2002:a05:701b:2059:20b0:144:cf85:b103])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc8:b0:39e:237c:50e0
 with SMTP id 98e67ed59e1d1-39e54c05010mr17269403a91.13.1789967251278; Sun, 20
 Sep 2026 22:07:31 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:24 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <d05062e2b188b513f66a91d2ee7c2c03f7407486.1789966896.git.irogers@google.com>
Subject: [PATCH v2 06/49] perf python: Clean up pylint warnings in twatch.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up pylint warnings in twatch.py so that it passes pylint without
warning suppression comments:
- Convert tab indentation to 4 spaces (W0311: bad-indentation).
- Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
  after evsel.open().
- Convert floating multi-line string comments to '#' comments (W0105:
  pointless-string-statement).

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/twatch.py | 80 ++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/tools/perf/python/twatch.py b/tools/perf/python/twatch.py
index 04f3db29b9bc..ad35b1620781 100755
--- a/tools/perf/python/twatch.py
+++ b/tools/perf/python/twatch.py
@@ -9,53 +9,51 @@
 import perf
 
 def main(context_switch = 0, thread = -1):
-	cpus = perf.cpu_map()
-	threads = perf.thread_map(thread)
-	evsel = perf.evsel(type	  = perf.TYPE_SOFTWARE,
-			   config = perf.COUNT_SW_DUMMY,
-			   task = 1, comm = 1, mmap = 0, freq = 0,
-			   wakeup_events = 1, watermark = 1,
-			   sample_id_all = 1, context_switch = context_switch,
-			   sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU)
-
-	"""What we want are just the PERF_RECORD_ lifetime events for threads,
-	 using the default, PERF_TYPE_HARDWARE + PERF_COUNT_HW_CYCLES & freq=1
-	 (the default), makes perf reenable irq_vectors:local_timer_entry, when
-	 disabling nohz, not good for some use cases where all we want is to get
-	 threads comes and goes... So use (perf.TYPE_SOFTWARE, perf_COUNT_SW_DUMMY,
-	 freq=0) instead."""
-
-	evsel.open(cpus = cpus, threads = threads);
-	evlist = perf.evlist(cpus, threads)
-	evlist.add(evsel)
-	evlist.mmap()
-	while True:
-		evlist.poll(timeout = -1)
-		for cpu in cpus:
-			event = evlist.read_on_cpu(cpu)
-			if not event:
-				continue
-			print("cpu: {0}, pid: {1}, tid: {2} {3}".format(event.sample_cpu,
+    cpus = perf.cpu_map()
+    threads = perf.thread_map(thread)
+    evsel = perf.evsel(type	  = perf.TYPE_SOFTWARE,
+               config = perf.COUNT_SW_DUMMY,
+               task = 1, comm = 1, mmap = 0, freq = 0,
+               wakeup_events = 1, watermark = 1,
+               sample_id_all = 1, context_switch = context_switch,
+               sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU)
+
+    # What we want are just the PERF_RECORD_ lifetime events for threads,
+    # using the default, PERF_TYPE_HARDWARE + PERF_COUNT_HW_CYCLES & freq=1
+    # (the default), makes perf reenable irq_vectors:local_timer_entry, when
+    # disabling nohz, not good for some use cases where all we want is to get
+    # threads comes and goes... So use (perf.TYPE_SOFTWARE, perf_COUNT_SW_DUMMY,
+    # freq=0) instead.
+
+    evsel.open(cpus = cpus, threads = threads)
+    evlist = perf.evlist(cpus, threads)
+    evlist.add(evsel)
+    evlist.mmap()
+    while True:
+        evlist.poll(timeout = -1)
+        for cpu in cpus:
+            event = evlist.read_on_cpu(cpu)
+            if not event:
+                continue
+            print("cpu: {0}, pid: {1}, tid: {2} {3}".format(event.sample_cpu,
                                                                         event.sample_pid,
                                                                         event.sample_tid,
                                                                         event))
 
 if __name__ == '__main__':
-    """
-	To test the PERF_RECORD_SWITCH record, pick a pid and replace
-	in the following line.
+    #     To test the PERF_RECORD_SWITCH record, pick a pid and replace
+    # in the following line.
 
-	Example output:
+    # Example output:
 
-cpu: 3, pid: 31463, tid: 31593 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31593, switch_out: 1 }
-cpu: 1, pid: 31463, tid: 31489 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31489, switch_out: 1 }
-cpu: 2, pid: 31463, tid: 31496 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31496, switch_out: 1 }
-cpu: 3, pid: 31463, tid: 31491 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31491, switch_out: 0 }
+    # cpu: 3, pid: 31463, tid: 31593 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31593, switch_out: 1 }
+    # cpu: 1, pid: 31463, tid: 31489 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31489, switch_out: 1 }
+    # cpu: 2, pid: 31463, tid: 31496 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31496, switch_out: 1 }
+    # cpu: 3, pid: 31463, tid: 31491 { type: context_switch, next_prev_pid: 31463, next_prev_tid: 31491, switch_out: 0 }
+    #
+    # It is possible as well to use event.misc & perf.PERF_RECORD_MISC_SWITCH_OUT
+    # to figure out if this is a context switch in or out of the monitored threads.
 
-	It is possible as well to use event.misc & perf.PERF_RECORD_MISC_SWITCH_OUT
-	to figure out if this is a context switch in or out of the monitored threads.
-
-	If bored, please add command line option parsing support for these options :-)
-    """
-    # main(context_switch = 1, thread = 31463)
+    # If bored, please add command line option parsing support for these options :-)
+    #     # main(context_switch = 1, thread = 31463)
     main()
-- 
2.55.0.1082.g2b9226bbc0-goog

