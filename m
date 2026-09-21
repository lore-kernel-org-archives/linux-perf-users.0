Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57734357D17
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967261; cv=none; b=a3RYDB53IhKiJ86H5ey1QJAyjiE3RgUkExhGelaHJZYjSd89mubEpY5BuCVV37f1GsYkxqHT+j0Ld814uHDUV/aXHsNZTnkJgHFTxSd8OKOopeClF0GxrbvVRu67OHcoNcngYtJso9DNscZr9IsQngWlUSNLCfvvvwRzTF2Qeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967261; c=relaxed/simple;
	bh=1ctgB2B+ZxMK6Z2NaNpbOhAH1lQm5ZUsEeZU+eUo4jQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FDZWdlqW5/d/y6ULhvCo8jYPeOgIWRvA/DnaFZQC70tH8O06Lne+E1pA9TKAR58WXwuUejXdKVhotkSIYASkciDOGJrtNe+TKoezQNQfZg2x5gHqwyFfZ8lpucScdJuWvc3A6l8T8M41JQ01vJtcTCO7X0XrNhbBJe+ZGPPKgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kUF+f3CK; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kUF+f3CK"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so3717997a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967259; x=1790572059; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cAjsS2t5gC5KcXjO4gB49sCxhPsBd5xcjLU7IyFB70=;
        b=kUF+f3CKmY1ILqRyl+x7BS/vi/qmR3x5jVf8dswb7mrwBRzVlTupy9yZhDSdkiOaWH
         FRmZGaZhJEV9mfU4wbLRAqg4X9+UxN/e1IEQ0K42JKR4tit2/PBtSNGCBDpB6N12DvF4
         sO30CO2rfUV8O4MLpVkVvXO+4FT1axdyMBDFO9rq4IuDcmIBXurvFsDtmCgyCf2npFXj
         R95TH4IILZYfG4Z2B/icXONzBnoIa78Zqbj8VSiRuiR5lvTkCps6voM8Odw3QWdqxEUu
         ZsKIs1G/oecNLKT9U+k6R3/0c344Y+22aWR/u5hzodN27TAnRcWS/dlRbe+i68DqhkSj
         eiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967259; x=1790572059;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cAjsS2t5gC5KcXjO4gB49sCxhPsBd5xcjLU7IyFB70=;
        b=YB/eeFDhVaBqYc+WM7v56xiWRxXaIk1AglPjev3g0M/DJK7Y3tkkQR9e/RDuIJkOEN
         lV1cF55NeoidOIYrXy+fGzX58fUYKIrEA3pYUGtus9DXslx4rs9kM0SKhSInU81hIasp
         6klKtGHz5CVQHGt+561mJuFRljsyxaQSiTIVHzKyMQ44FtJ8Pcp1dr6QMCRQZmJYHj+8
         aixu07ShY2LKUU/l6nklcYh+GB3+CAmMRxJs5OQ6vBpL9pkI4x0ZjbJA2T11evPogw0z
         Cc+ZOC0L/KwQCwir2Yqe7RRC0f/uZVssrMb+5rjhE7sDH2FsQ+iUwYHJuk6P45GfZrpZ
         D3hQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf6JOvkMgJyE8hz21x6ogw1HKWx29SXsvm5jicon2RFa1bIH65izhPr/Eja9LPsPTzBOTA/BNK07vpjS3DeJt3@vger.kernel.org
X-Gm-Message-State: AFuF++k2deyMsqo6QXHMMZDFaIN5RnTodh6T7OrWsA/pemkPI4dLE2GN
	S3mz0O0/9ap1KFQIBiRV8p5Ee4rqkW+gS590m/7l9Olja2roXLIHnQCXb/21B3uCSWMdA17rjuv
	l0YnmqlPzVQ==
X-Received: from dlan4-n2.prod.google.com ([2002:a05:7022:eb44:20b0:144:d2ba:3139])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c50:b0:39e:6a81:f351
 with SMTP id 98e67ed59e1d1-39e6a81fd31mr5721132a91.43.1789967258496; Sun, 20
 Sep 2026 22:07:38 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:28 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <f23fef97cc4532fe1f6729ad6533d4a3f2716bf3.1789966896.git.irogers@google.com>
Subject: [PATCH v2 10/49] perf python: Allow KeyboardInterrupt to propagate in LiveSession
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
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

