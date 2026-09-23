Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E546463B7C
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187181; cv=none; b=G4AmnZgOVdFuUwKHtlmjxH7WEODgdyTQegGu4N89U9inCrOh85gl1gaOruo22LOS/eNUxqIi+kiVtCAVVSQO8CCtVmQtJ5VSANaJxsaCzgCf5VVavbWdsJXpSSz8Mk0mfg0UI48ZMRmChUEhld7JDCGtwEMM9QESh2OjHZtbXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187181; c=relaxed/simple;
	bh=iT6AIO3TWyMclKnHI0XpdeyTiqsSKBsOrIJNRIGDRFM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kAWEMiG9V3K7YKU6cPIK6PP9OrkqtJQ0ym2WtXpl8rC+muT3YxzuHTFDbVZEXlR8DfHOw3FgQI1w8Hchk+psapOS+LQZjQQVKPqOlB8/LfvYYAUw7dC9x0J1rVg5aMOIXhyeHSEq/XhH5T40gnuTCQevWbdSu16l8neIuakqufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bN4KmUQX; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bN4KmUQX"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1384427c3efso2022599c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187177; x=1790791977; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vhLzj8CHSgnPZEQaoqsxZs/Q7iBTiQNebqxNpexBaOA=;
        b=bN4KmUQXDolot861HRjGA6K8ntEtK4JSHrfikehkcyYocUyqJf+G/SdKv3QjApuP1Y
         puPfM2eZZFTa0n8p1AwEm2+GGr4fZR7YMgkJQQl40uBqt6bka2oY1qc3iGUgcEIasJYu
         hUkTFq5iLgKZD3zEjyNmE283g7njW6DXpec/fWJ8QvD9WAiyUzr+Tsj2b6NQWvejb3CB
         AISfMLsssJUyf+PTVrAt1OkXXfbh9ZAB+ryXwsRaXuSdWqPkRi0xdECAnYGEoeo9qoI1
         fhsMJirBtgyRZ+1EB4g0f9shsK/ixovIvNyIZdv2ar2oYSw5b6KKTq9bkTjKrevNUcIq
         Zo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187177; x=1790791977;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vhLzj8CHSgnPZEQaoqsxZs/Q7iBTiQNebqxNpexBaOA=;
        b=ruYVl/Ar2b76Ar/4RVZkF6gkMEhwh0T237Td8ktL97iIuSu4yw5Rl+0ACeMBK591Nc
         RAH5pa6XNmoMeltjY/qqKTztIb7y5/ZjXXpU+PuZ33tkqaV+7yR1Ajw+FtaCgg0t5ebO
         W2oRftZpd6YnF6vEV1nRdYgB+wGY9witPvjuNiOqTRytt/a/q9bM4wIotAQXA2X4+zjU
         xsUxJu0/rZ6BUADHkUEX9LdHX9RIU7/42PPjA1IngmpgZ5AosGsMh89HkyUcCJcqpTv0
         nz1y+mEBnQOvgnuUQtm7zWUlufMII5l/HRSvAd7zT3Se7GGA7UENlrGPLA8yeNIhsqkh
         cwCQ==
X-Forwarded-Encrypted: i=1; AKwUvBye24NiwSY0JZnPQh8QHD/O809xMOwHcaMv204oA6QH+RKNRInIUjzH7+gWoFuWiI7TQWLczXJMjwr48XaGsBtl@vger.kernel.org
X-Gm-Message-State: AFuF++kjUCbrL0DnK8kcSIqywDP2ilApZuD5+m8e4d9pPFCgyrKlL9GJ
	ovWNwEZ9K4+OfJ8iqFjMENHKsmHFjklRCV5+lIPZDDIecUNaHUWfoW9Whe/XczayzdkY3mMngY0
	YXfnBlTHdVQ==
X-Received: from dlan17-n2.prod.google.com ([2002:a05:7022:eb51:20b0:144:cf85:b103])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2304:b0:130:6c8f:5a87
 with SMTP id a92af1059eb24-144f914402fmr3425597c88.13.1790187176387; Wed, 23
 Sep 2026 11:12:56 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:29 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-7-irogers@google.com>
Subject: [PATCH v3 06/49] perf python: Clean up pylint warnings in twatch.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
2.56.0.rc1.310.g51773c2048-goog

