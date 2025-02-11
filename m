Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6F2676EF
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 21:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309502; cv=none; b=l7nNhEqeAwEkpgr4EeW/Jn6dkRFyDsCr0k69comY2E1lmym+IOJOsSUcsEpJKjA2y6yapyc9OrizW1SmKtOZIYqGcEr+klqF2Qz51Hi6LxVh3FF+DNiwutI+mbP/gCHzXF1Z4Z4bWOASLPrMMTXM17ETYkXQUgQXkpAzwUkZCgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309502; c=relaxed/simple;
	bh=BFPUfUPV9C28sQ+5++oI/Mt7czcCX79RjU67ZXHg4wc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tYrBh0OpgVMJGdZYBv7+V9y+GBuExdno3LUrTyBJUh8BwxdHFDAPWx27jE8bmPO5fj+jX870hTfcl1QgR11UJ4C1E0BEfkfSdQwo5ekGkxSLSB8lGdoEWAABSyQpaPJ8udvZLV5UgHw9WUH4BJJ1cTPY8jaQhLUYnkXhPnrP/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Um0tHsY6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Um0tHsY6"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2b4c302e1so68020777b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 13:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309495; x=1739914295; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=Um0tHsY6LT7ErnQ3IgXlt5x1TUJXQLHyhzsFARvM7H/bD66BlktHfp/t2tQKT7Uur4
         5wONkOzjkV884wT+MFrDSgNW8rTCOZPFCrLjF36CW9SJK6bOh58M7O5OgtMWzrhauhuI
         H3RGErGbWC2lewru1bhzCCPsMspzgH9XftwA6GygYhzq3XFVL7NgMOo7osbWOP/L2ccc
         GOVoyKDPvdkr9pbnR9uju1CbcIZxImXK8LRg7ry3RkBREDe63T1ebfpklO9vi6InGIdr
         PmnIMofmTsUMhJpAInxWEbSnMBYT461FJspDAYRpDMAAY8V7CO70phJn2MTvckivDc7Z
         A9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309495; x=1739914295;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ1B/xiMtyqfDg8YY7mV/zwkOmMpFHIKV2LiJJcfRRg=;
        b=xHZycdpgCcSTUhR36fD3D1FZ/VR9cUlAzgf/eB5L3AvWDtbWsIia/wnzct0dOGZHKU
         NDVTOhz/iNkaN1/vUXfkxwNgdQsg4ekqcp9XTsjaAfdAU1kS76uxOHvYdOjuO0U14QkK
         KxahtBcJzwftluIT9NorFGKOpxkCZ28qPiJbAI9suz1o5PU3xW440F+prc+IETUlbr9A
         C1aKGQ225Ej0HqLjpZxY5BQBujNU5vnr7ka/aAGRkxNjxxyCz4ItuKKwNoKYG3bDsPzB
         GWg3q3/K6lgeBdaNjUZZyptTqqYLf+/H2hDBMyKrB2WxU1g29JuIkRFH32ISfNOtQR9t
         joFw==
X-Forwarded-Encrypted: i=1; AJvYcCXQHIDR/AYQWP34/ATiEPynpFb4/MqzmQ56bDGezb6SSiPcAAkNyIblh/+XaQr2mBDXFA8WpN9WvWaSteZAmvNR@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ18OtjGny82/xV6ie5yZG/V0vvMOmen6R3Fs/sENE9msaAK7Y
	0Rt7adhUhnl6wmYT2nos3ctx6mz5AbYkeAY7dTMO/tmqcgyw9onKm++4GulVFcOurIK+tHi8MA9
	RSjOvdQ==
X-Google-Smtp-Source: AGHT+IHcP+fUgMI7D5VP489sJpp8yrK92+IZGMsVKgnNa6+/ErAQ38Qw7fxa/sOVeZ/4JY91WureC2X5HHwn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a24c:c86a:18a9:d15b])
 (user=irogers job=sendgmr) by 2002:a05:690c:5509:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6fb1f5957bamr98667b3.1.1739309495526; Tue, 11 Feb 2025 13:31:35
 -0800 (PST)
Date: Tue, 11 Feb 2025 13:30:31 -0800
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
Message-Id: <20250211213031.114209-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211213031.114209-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v8 24/24] perf test stat_all_metrics: Ensure missing events
 fail test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Issue reported by Thomas Falcon and diagnosed by Kan Liang here:
https://lore.kernel.org/lkml/d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com/
Metrics with missing events can be erroneously skipped if they contain
FP, AMX or PMM events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 73e9347e88a9..ee817c66da06 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -20,7 +20,13 @@ for m in $(perf list --raw-dump metrics); do
   result_err=$?
   if [[ $result_err -gt 0 ]]
   then
-    if [[ "$result" =~ \
+    if [[ "$result" =~ "Cannot resolve IDs for" ]]
+    then
+      echo "Metric contains missing events"
+      echo $result
+      err=1 # Fail
+      continue
+    elif [[ "$result" =~ \
           "Access to performance monitoring and observability operations is limited" ]]
     then
       echo "Permission failure"
-- 
2.48.1.502.g6dc24dfdaf-goog

