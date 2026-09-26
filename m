Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4947F35F5E1
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403665; cv=none; b=asON/GHpnAm5ci1RlGBHAyiY8EVuhogPpGrVMkdjPOVyOCMG7Tl6u90jMuhCx9YXgXLe2XWJ28+LcH5GvWLqDyFKJK5GbKHtI54nVEtXnzh/k0UlGqZeNx2TYl0Cv8/WwWM9XKJ/FsuuqioxYppuz0R0RCf1dJvDVz3YUdDekyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403665; c=relaxed/simple;
	bh=BEfSSUHQO7PM55TDqzjAb18GU6Q7B6GfKiLQzOw5mV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BJUzgKyojsvNrHfpgSz2II5nS2HzDaDO4B354wjOL1ri03utd7lhquFBrgFApGglQD3s0CLvGHFghs5P6cCvyNUp59+XnAbOVxC8BkP/YnkObE9hPohU0nsrveDBqBj0x+Vw9BPaLAuaQo4JAiE/Q8SCheRufzXACDwPR0CZsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qux0JUfJ; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qux0JUfJ"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1466ab2bc8dso3064841c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403661; x=1791008461; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcGR/oDsgUEvem4FbtHO1c82Jd0KuR3xni07TlO7avc=;
        b=Qux0JUfJ0NUMkboqwEgbSwP5zyw3AeGvP8FsdPpp0Dvpgudj4yo7PznPolHX+OS5cQ
         JzE6bg9+RS0xix48JuERyCBod2nn4vyz8qMEcPzaDfoHAuxVLpyPtoScLbuAEuxHye0E
         hFbBqVgTiO9lRnYIXFMFNbSZPnDBlVZvXc2NBwmgAXBjgmT5YupYRsCv5OJifQDmPc9z
         ogXbhxhufu6I3mg8PJHmy4s5HYv9bpj0OctzciXj35GZ2Zk8ups3CCHAhWzzslwpmyBE
         sExANKxm+UOCRiIxDVrWju5i1pNCyECvogZ6EyvD/svua9biqxtZgNVGXXaCKcc6QyY2
         tnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403661; x=1791008461;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rcGR/oDsgUEvem4FbtHO1c82Jd0KuR3xni07TlO7avc=;
        b=mE+994DNCxHD4Ggf5Fx+OuhYuAk4GAZDxMnOjHAfdlSGKccr7hI50oOCTdhHf3RBW4
         CAW+2QHaNMUvHt9VLS+9jeE0YjpDSPAUUB+CNnRoaBAtypjXpnWRfEQy4Ah5PF2Bduv3
         2F4jqEWpuxNHgeKVFnyT/4wVByOF2PjiYmI7IRjfapTcijsPTILpwdfIcA+f1PEglgJN
         nUTn5VOv+civ49c/jPI4HaCPgmjfQKW+kY7ezQY9aoVDWBmMKVVQ+zAzMNqGgDgbCSO+
         G//8uUA4/FhO7Y2BdvK1/UiTrUARhWBaEzD9hNAOo19jq86RG0m/mWkuXqrinoPK0Om6
         OdLA==
X-Forwarded-Encrypted: i=1; AKwUvByl9GpPXRf2NMf0vxvfH7uT71coOl9ketlclWT+jhYdy6N6FJprsBd4jFRDTerMzsk21luR+UbmJI+qMS1nOu4v@vger.kernel.org
X-Gm-Message-State: AFuF++kErscMmF9eDIUMnvT01yoKfsMxrjhSbK7eY0WvUwHYgebViN2U
	eEDIfAZ5MaI3wfB1FYbroxONYkdtQhKdIH7FL+v0qGGZZYJdNuDWv4uC9Rlrpc4brw3vHbwLKvl
	kFssq2UQXAw==
X-Received: from dlbps2.prod.google.com ([2002:a05:7023:882:b0:143:7c9b:184f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f519:b0:144:edc5:32d9
 with SMTP id a92af1059eb24-146ce67ee3amr1843855c88.7.1790403660878; Fri, 25
 Sep 2026 23:21:00 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:32 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-6-irogers@google.com>
Subject: [PATCH v4 05/49] perf python: Clean up pylint warnings in tracepoint.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up pylint warnings in tracepoint.py so that it passes pylint
without warning suppression comments:
- Catch ImportError instead of bare 'except:' (W0702: bare-except) when
  importing setproctitle.
- Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
  after evlist.enable().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/tracepoint.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 15b0c8268996..9d49a25b3b1e 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -9,7 +9,7 @@ def change_proctitle():
     try:
         import setproctitle
         setproctitle.setproctitle("tracepoint.py")
-    except:
+    except ImportError:
         print("Install the setproctitle python package to help with top and friends")
 
 def main():
@@ -29,7 +29,7 @@ def main():
 
     evlist.open()
     evlist.mmap()
-    evlist.enable();
+    evlist.enable()
 
     while True:
         evlist.poll(timeout = -1)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

