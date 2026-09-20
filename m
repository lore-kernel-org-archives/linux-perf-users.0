Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5B03D47C0
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881772; cv=none; b=YSmzjNTaOIGu0x369JlwmlphRUQ9jGzdEYrvSR9Huas4v97+Fu90n25eV/jLSikDJRvQKax4sfWuSFLpQfzqfs1pu9IHK/ZI/u346e/ntIysl/Wj8PJKm+/qj7Jym93BOdVF6kc8tGth9SI9IR5fO4ARpgNqcmDZ4AzBj0NxMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881772; c=relaxed/simple;
	bh=o5M0jZ5YfiZRF6sAzgtdJjRODspLtXN1XHtc9RmBpFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p3vWIgrGhI+vu+ALefH8gsul8afLERroywEUOM9ImHvO2jyTWFnq3GACBCwK3XfLVNtItgxde3RPuGTPaFC3byVzd3QkAagei8EsIg09YaMxQUC7vXQfpSl72kggjS6L6IkD/nm1p9CyqfkTcuwkAXlyq18fmqaJAVa2a42Yp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/VHGsdF; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/VHGsdF"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39533bb224cso4012466a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881769; x=1790486569; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NRpHFZt5ixyx6D+aLau/jDSAEqIDn3ZK4zKoAUbdefo=;
        b=d/VHGsdFoelD03w1ZNN2WqFT3e961LszIs0odt2VqqmkYXJ1UmBwzKoXRmufqy7tSH
         sb/GvjpHHt/gYELi6y2PgnDTSZz85hZr6fUnH+GItE5wndai8ZrXVc8WFSMeI0sOSWz5
         pJIgm7FB7ebcIxO4pbnnDimDbgHmwJu/FALpkPVt1LXq6F7wOcHHgGkEOigw8AWtZaD8
         LC9hVHM1tSGTde9re5HPZ/ewNfrGqE/xf45bpST+9A/IC/v80TJR0Boqv+3h7SJtT6bS
         DnlFwyWPS1qByUyLtJjESQ+eN+DiPuOF1pfx7DT++qjk4SeAR2c/y2cMadw+5HOjkxiI
         iXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881769; x=1790486569;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NRpHFZt5ixyx6D+aLau/jDSAEqIDn3ZK4zKoAUbdefo=;
        b=SaVY14Fiu92ojEOeABRX09JVlTHkhXD4vbHrt4WM4Q+07OxEdZfJGUwtj4r30b9JpR
         Sf7N/6THCKPO19Lq5Wy3oP8/myM28T/7fC0sDdmvuT6w/9xJTiFut36y40OyM3xKS6S/
         zSJIX5Rn5IX5L+s56GylXECmvVlJ4WGdQp+Gj+ZF12nRCrsDw8Gf6LEwuCAJFAA6Seur
         vvSh4gC0oOXGUCfH08kiArFseT8hN5jPAdPrWDHOkTFaG3BWsCcDOAlxMRLgYu21dW1x
         FgPzUX+LDVWh7xrhq7q96ZdkWYaOfbnsTP31M8/RcsXCwdd/k2HNZ5yWWZ0S/h/g7lht
         RWsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxO5S+qYlQsS0U6qcPt8Slsy2qEH4BhbXskvvufEJtN60ZRQ9Yn+Z3uRCvMpXHLMxz7TU9Qx8s+pP8GOFa6E4qj@vger.kernel.org
X-Gm-Message-State: AFuF++mKu26bmcs4tLPcWj31Itjz+WPAQbp2w1TYf4VXNm1Vm5d7YKrt
	Z22Ax6MKNXrULFU5cdsEHWKeDzjuxAlcOEw1bP4TSUYs656isrztZFLUs7cDl7YnGTiyFy3BqRr
	NiLVOWZhhhQ==
X-Received: from dlx21.prod.google.com ([2002:a05:7022:95:b0:144:e2c0:2c4a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c88:b0:39e:6c6a:4b73
 with SMTP id 98e67ed59e1d1-39e6c6a54b4mr5727480a91.61.1789881768599; Sat, 19
 Sep 2026 22:22:48 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:20:58 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <04eae243b929ccafe1ed8d679c426dbd7bc40098.1789880842.git.irogers@google.com>
Subject: [PATCH v1 06/49] perf python: Clean up pylint warnings in twatch.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
2.55.0.1082.g2b9226bbc0-goog

