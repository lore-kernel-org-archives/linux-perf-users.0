Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138636308D
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403673; cv=none; b=fqKT7SSr5cMjMw+46pKNh+B3Ua41REpOuN+5zAef+DXgK/mPdb5reauKyTtWO8LJUpEmjosmmkYHKZP+9dZK52pd2GYrc2AsFWzWzcKVuvlYnxx8R29NjG2SuiXV3EBrcZf8SiuwZ8uUQ1OCxHMFO4j0Cyhn3lTM59yvzHPRpmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403673; c=relaxed/simple;
	bh=runbW3srK9KuXn01hC44eK9G2XOycej0yqr/lQU7KpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tArquHS0gsQHiI7NKYWfDPoBIADLavcdd/jB5bftZkYJh9Hcsf8SF4sNedyZ28mGgTWTrmPE9TvSwoIrXBdy17fsvkNDRB4r6bTXXXtxYFLOzB570L3sqxK0oxLR+y/EKJblCL8/7w4+kY1BIxiTrI083+fOucn1uj3zHs2RPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNRkMIfA; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNRkMIfA"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so257359c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403671; x=1791008471; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixqfT2IJ71bgNGvTfUoosUWjFi9fSqUQaT5nKAFGsUE=;
        b=qNRkMIfAHx9Y25X+tlCkawx+pSLfE6/hn2nToFY45fVooLPnHmNf77kAIUvcQFRcu4
         CjD4FbTiZhlH69RSQBnO7bZOAuq92sDg5juoOCSX/nkh9rf+qAQYqbxwdY2U4u8TGhTJ
         EtkkxDp1940ViZcj2SI54mr5/YV0IOKcAhMEvTw7J/hd2ob0YtqZyFC++mnaY6CBGtp6
         ISOCgHxWuZRRtGndQyWjvbL0AEXc0bhFwwevgeNCK5gVMwa2pvK3L8g7DRS4H3+S7+bv
         fdWYg86KLc2dBjb5BAJDK53nyLq38ZQaBm6EpvOdzT1riSlikzNcSEb/D45qqzjW0DFN
         uI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403671; x=1791008471;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ixqfT2IJ71bgNGvTfUoosUWjFi9fSqUQaT5nKAFGsUE=;
        b=YmM/W5+SpUgYN9x8S+DberhSqbT82cpt2yH/azr5hdKJDgsaEcuzFqNyCtA3PtFDG0
         Di0dWYFaAn8w5HXbIQoZH/l2BDZCcW1QoAWiS7UOMx4B/qINLfZmyrJKKJQXIuBU0Bz+
         LN5cGCn5shLHE147vOU5PMTxVpcu6/hlpwxA8UtccrpP2oTyq8b82Q49ycdo5D6RJ0eN
         jtpdHjbv2mcnv1zfU1gjFwVuCUD5w5RRFluld3NYucrrvTFpFMKwpX+QNoVf4xir6A3n
         Hm4pVukFJ/D2fbWaH+xFUNpHjPVvUn54LA+dMndcfaS/WqJlPlDqSrTaGnOoSuJQossv
         j0wg==
X-Forwarded-Encrypted: i=1; AKwUvBxBUzcX6qY3bH74iyyMAnHrA8OJoUYOMuczDjur3mExbXHcL+oZrcU4fonkqK4la5VIuq+sKPHcwIdhsgcSrk3H@vger.kernel.org
X-Gm-Message-State: AFuF++mdSDTDyyhi6gJWILTjERwn2yyZBBsWMJEhYR6xZFUIDznOxVNq
	KaXIXAPY4rZYMNcammVYuifX8a7lrQ95iV0cYYoF4eEWsz5cxjYiWZYjeOMm1FQC4KoS4kApnyA
	pFQlcN4cX7A==
X-Received: from dlbep20.prod.google.com ([2002:a05:7022:1094:b0:144:be75:f389])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:21db:b0:141:b2c3:d868
 with SMTP id a92af1059eb24-146ce1a996cmr1867466c88.3.1790403670683; Fri, 25
 Sep 2026 23:21:10 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:33 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-7-irogers@google.com>
Subject: [PATCH v4 06/49] perf python: Clean up pylint warnings in twatch.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
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
2.56.0.rc1.315.gc6ed9934b7-goog

