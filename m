Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224B3D3CF4
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881779; cv=none; b=hXaDMcgdGfYpUNJYdmaDWGL9CHT9OerrRWq2Uw58E8WcLJoj10QALUOm5Z8Sq+Z5r3OqcliMbKMi26dSYmwHLT/reMjr26t7AlnfIwaIXyPG0c5xbrOm55eynfjNgccHsOjRPlFI0mlW3BYQWWD9vYl23UxwOsi3k18VqK282Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881779; c=relaxed/simple;
	bh=1ctgB2B+ZxMK6Z2NaNpbOhAH1lQm5ZUsEeZU+eUo4jQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YUosSyvjDJ9ip/dyMK4/xmZeTgi6tSJVjVUW/F5s3YXJMVUJmSsxah88snuF7ecQBIwNlRZHSTLRg7JBNKZ3RWayg/oREp03hPX/JYMEHmD8ltlImy1ZPjiAZJkYjhmyHHDAApoFeT4b27q5yu819xPNhBwDbLEma9cvXKWs/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIgY1v4U; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIgY1v4U"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso2547853a91.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881776; x=1790486576; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cAjsS2t5gC5KcXjO4gB49sCxhPsBd5xcjLU7IyFB70=;
        b=AIgY1v4U88SNGluFmOA3v+F9l2VTrn9o7Bu5eJV/SrY5b5Hu0CViV9La+7tfntWcT9
         G+XSm8RKSIIr3DjlHM/aGsedo9W0MpuvrqrjrDgm+pDU0diG1ESqYmQQPqo1Ve+j4Yp7
         mY1dwIj5BlpaLuh33wmL0L0JmDSrybPKbuoBD3w+FLg4kVCMSvISK5b5veQozWoxqqv6
         8cEV2N+C5NnXatK9R4/hxrWvBBLgEQoi8NFYzaYgFZCZ7dqmauyun8u3t+eKammxXXvp
         R5dzQ/2Phpd5Ju6ySyJZKE/Gd6uAkv81dP1OGkMF0Sooap+qe3ysalbRk8qo1Coyr4gX
         6EMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881776; x=1790486576;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cAjsS2t5gC5KcXjO4gB49sCxhPsBd5xcjLU7IyFB70=;
        b=xmPPQowxJbHAqwfoKQokrXHAJldU5GaGZFIMTe2rEnXSwe4hwSQJcRxRqvoaQAQXVO
         6gqe5YX9C3HTh2My9m04Md6SKbEYL8gOUj6Fbh6LJeGgrP+2sSryfnv8ABhQAwHmbimo
         lPEd3VFx3sFRtIV79q9+UkX8nPC57EJyzxU9vIl9Hnd7WRLu+UZR7g0BBJpm8WVjTS4t
         Zf5sY7eQxaO7/u34h4LA8IVyyZhtOf3vpszcaZk5dNcX/C38EyPA5W2cmgPg5+7dMacS
         ptDEeAJkCPWum3e7JUixeuJQIPD/trHMSAWKAbnblvRvJgaJNZugIsmasCAPy3L4zDf5
         cRBQ==
X-Forwarded-Encrypted: i=1; AKwUvByNrQ25ltMHxwwyh1lSf4xtDYcNYbOpf9SQRn2TEo9IHt9clK4RUXxYgmXlMRZXhzhKVqH0bmBCC8pZpZ8jFVt3@vger.kernel.org
X-Gm-Message-State: AFuF++nMWWQAHTg75k0H1K29mfuJldnKWLC4+jInY9/fJH6ZXVpxqHvx
	zM8eex259PniAtnt1woAZYVXbzMafS6Os8LoEvoxpqUjUiYF4M/UJDlkahQhrSu2qK27kj5f5bO
	simORWyD81g==
X-Received: from dlbpv7.prod.google.com ([2002:a05:7023:907:b0:144:bbd4:62e0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270d:b0:39d:b1bd:b384
 with SMTP id 98e67ed59e1d1-39e54d0edbcmr12384166a91.17.1789881775532; Sat, 19
 Sep 2026 22:22:55 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:02 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <aa094b347932362df34f287fe8473e607a1f1ff3.1789880842.git.irogers@google.com>
Subject: [PATCH v1 10/49] perf python: Allow KeyboardInterrupt to propagate in LiveSession
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/python/perf_live.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
index 616b5f657463..665699c5407a 100755
--- a/tools/perf/python/perf_live.py
+++ b/tools/perf/python/perf_live.py
@@ -36,7 +36,8 @@ class LiveSession:
                 except InterruptedError:
                     continue
                 for cpu in self.cpus:
-                    for _ in range(1000): # Limit to 1000 events per CPU per poll to prevent starvation
+                    # Limit to 1000 events per CPU per poll to prevent starvation
+                    for _ in range(1000):
                         try:
                             event = self.evlist.read_on_cpu(cpu)
                         except TypeError as e:
@@ -53,7 +54,5 @@ class LiveSession:
 
                         if event.type == perf.RECORD_SAMPLE:
                             self.sample_callback(event)
-        except KeyboardInterrupt:
-            pass
         finally:
             self.evlist.close()
-- 
2.55.0.1082.g2b9226bbc0-goog

