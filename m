Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76F363C59
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403681; cv=none; b=ZcQ7pJtJl8vZbgND4JV6VwnZZB/I3w6WLpL4f2Yqz4kjNuBrbC9+X2AHRJvaCFF46z715OcmHC4UBQiTkAyqPdb5P2njnqyOPhYoYyKlHZbSowFab504BJZ07wTmz1M/xhmI0v8ktgBcT8eh5+hI9SHbze3mz4QQGz2C9gNPFqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403681; c=relaxed/simple;
	bh=zZRDpy2pCf3rGznnJhTBBBq7ZDSfbefM6KlIxw6R5wc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TTFzGSzhvUoY0d1iy8wVOjRjgKF4SWh3Nx/ZtJlZc1lP/w4dOB2Uslt+KBdOWSoSWLfWi6v/sXdvQmpWZFysk4VvsGkzAr1lmhC0BzXV4xIxKgEasWvfs+DoeU8SOl2lThcW6hFB8oboTO/7SatQQV83wZRafTGasKYofWhlAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBQfBGD4; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBQfBGD4"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3437d0cc8c7so117884eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403679; x=1791008479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZWaULzvPwtrby9JvMFuaXO1rmgi6w3tKeneWwQVAh8=;
        b=nBQfBGD45LKRTIXyqQGNbqgs0CrWG2cYQtaQjMwRNwUTrJXnANUpIm8vZD5l0vrZtw
         xXkMVN5UGu0v7+M3LnWgm9tUGockVZFrPuAX/MkN19p+XdFPwR0mqaTzBdBJ3pFyZr0R
         sggksF55a/c/+SrrvQz0+NFH28yGy/JsgeQoX/qMStUEv+i01fx8QK5c8ouZTdQH6fTo
         mkdlrogLqrcoNCvY5S5hfFTNjIQHlWSJ44lCoiyqGnMAYg0yZgo9vehdDM6tKN0FZrpJ
         4H6fTKoJ4NGhisxWlKExy3uLJgRyWVSElciZyQhM6kbj6iW2sQ7TLBus7eRWktgUPJEX
         ZtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403679; x=1791008479;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZWaULzvPwtrby9JvMFuaXO1rmgi6w3tKeneWwQVAh8=;
        b=cbjgmNiQKY6EDWd7zbmZbxrdChN8+G0e1TsDFGCLTp37xklWEjV6MxOYNu7b/ilvS7
         eshIukEDYJcurCah0ncCp3vxO12k96wASyRVfhccZffLhYdwsIwsKlNaZxaV9fZxOF+d
         RjcIln7/qILr5n4oUt9xLooU8zvdud5+KHEzN3igZ4gBTwWpvRnQSdw1w+Jm9Mi15pkW
         hGcNOgm18IG9uxkz31I7kfn69F36ceuHdYndBzk7kMFix5crNOp6+MWOvEtjiOGkcmKB
         vab5NSzUpOGgibWfB9/a2+oD7ozghLJuJlZ9ocpry1AWrxFiVI1e8OtI1mlWSjHdel8A
         LjFg==
X-Forwarded-Encrypted: i=1; AKwUvBwDTSaHdpic88P8vmz6xqDbwyS6gjKvGJ6T6HyIMjCOCTVaubMRQA5o6XmfSD6mV0wNvYUdBVPtEpsCNFWZX4gj@vger.kernel.org
X-Gm-Message-State: AFuF++lnq3FZ8cuc0DLmRwfKYB+LphalOoQ+xh7pnZgL2509b6JcUPZS
	Wwpue3kJ/RD0fHZ/ype47KPSyVCS8PuWvMMdeLY+O15wqiILCsgbn6r0NT2GTqs7sHmosjVQHvy
	lHXIVyj6LpQ==
X-Received: from dlbrs4.prod.google.com ([2002:a05:7022:f684:b0:144:3f31:5c89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4314:b0:13b:3c3b:8dbb
 with SMTP id a92af1059eb24-146d03a0a9bmr2056237c88.23.1790403678303; Fri, 25
 Sep 2026 23:21:18 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:37 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-11-irogers@google.com>
Subject: [PATCH v4 10/49] perf python: Allow KeyboardInterrupt to propagate in LiveSession
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

LiveSession.run() synchronously blocks while polling evlist for events.
When running interactive tools or scripts from the terminal,
KeyboardInterrupt exceptions raised via Ctrl-C must propagate so the
caller can break out of the polling loop.

Previously, LiveSession caught KeyboardInterrupt with an empty pass
statement, swallowing the exception and preventing calling scripts from
detecting the interrupt cleanly. Remove the empty handler so calling
scripts receive KeyboardInterrupt and can perform clean teardown.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf_live.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
index 616b5f657463..99e73d58a96f 100755
--- a/tools/perf/python/perf_live.py
+++ b/tools/perf/python/perf_live.py
@@ -33,10 +33,16 @@ class LiveSession:
                 # Poll for events with 100ms timeout
                 try:
                     self.evlist.poll(100)
+                # CPython's PyErr_SetFromErrno() invokes PyErr_CheckSignals() on
+                # EINTR, converting SIGINT into KeyboardInterrupt, which inherits
+                # from BaseException rather than InterruptedError/OSError, so
+                # Ctrl-C exits the loop and triggers finally: self.evlist.close()
+                # while non-fatal signals retry poll().
                 except InterruptedError:
                     continue
                 for cpu in self.cpus:
-                    for _ in range(1000): # Limit to 1000 events per CPU per poll to prevent starvation
+                    # Limit to 1000 events per CPU per poll to prevent starvation
+                    for _ in range(1000):
                         try:
                             event = self.evlist.read_on_cpu(cpu)
                         except TypeError as e:
@@ -53,7 +59,5 @@ class LiveSession:
 
                         if event.type == perf.RECORD_SAMPLE:
                             self.sample_callback(event)
-        except KeyboardInterrupt:
-            pass
         finally:
             self.evlist.close()
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

