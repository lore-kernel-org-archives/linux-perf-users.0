Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D771917F0
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874107; cv=none; b=PkLrvfghRjJNoE1nhKYsWb4j+l4f8E/ZqnrTGLFVQrLJFX/fKFmNFFgsVTHPFBA4Se0dBDYT27OWoojc0gX4KfcumHvMPn8N5OVeZC5l2wQ4uYo5+6njE0QmuBIt+TxBfYPN9gV+4ADLO88YFTXyu+sZWqNab3IQuEh18MHPWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874107; c=relaxed/simple;
	bh=GsAIYc4aavaEsHeHft1wPWlWNFRL8pkAWYVQqnWXhD0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=pZx2W1kPcwUJ+It7h/DfcuckaeJayAZ2v6EfuVQ/cAjx2phI3CZaebXwcTzTDpaMHLCvxVAg3M60sNZqpPOAtoeFN0PmpLsjwsU4ONZqfcceG8KpEIOKFwfoC6u7sMnm6n8g3yIFUuBICwlQpvbGA8iWMdg1jDXSsYaCl9za4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sSoBuB1c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSoBuB1c"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32dd692614aso5272861a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874105; x=1758478905; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w1j/v+twDt0ZUaShb07DVO0ufp1ep8m6kkLq8qghy74=;
        b=sSoBuB1cLXdC3qbJK+9oztD0vzRbSyvebxOrisHER3kV2Z+mKVQihXvE93XqMRtjvy
         UVd0LTB0xwdNpziWfCaF6Evg6+KkTMQKUr9j9CeLHcThyTUCfSbntlsEl68BXF4Y0HDh
         moiI269Og5reu1QQzDHwzxCQoMqEjjF7PU5EBPSZJkPPOSRpDOVDCcAEIyd2Ce+x8GGb
         YIsv0LaJmttNUm+3jfjHYkuwXZsIZT8izPnLbtBvz9QPr96lDFJyKjCPPnahGsbjebQY
         ldBqlOlUss+MEbvyRyjJ5yISsw7lSHTGVGJfVWXghPtB40KqSXv+JXn6fr0GIkm/vydX
         k2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874105; x=1758478905;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1j/v+twDt0ZUaShb07DVO0ufp1ep8m6kkLq8qghy74=;
        b=kSEtcqED8qzX4GuqverGPdD7mI/yYhLGs7zdea2ooc+binS6R+06ec+dpwf0JYWCPK
         e2VNR3I4OFmjvj0uMEZlU0jPPA+dwLQ29Mjv4MvjE8jCWOUja56s4FzEwJd8CSErs3bg
         tI11UAb2v9xhakTV35bVKsrPkYfOsayTg3vlp3t+5zw3FvkIr29BheyPyh/YeYmguyyU
         2tWIHPKW5zzTylXyXcaQO2kOC7vs7/T5xqxB8N7vWBLKZFHbPUCMFNLLVWv7i35+QPDa
         XuzG0wl5NuSBH2LBJsmJhdZGw2WiJ9+JN5D0tLbaTW2P8pvzTPZAUYjk08+2EDJBgXXD
         ujEg==
X-Forwarded-Encrypted: i=1; AJvYcCWekSGlEuY/WGB/b8+gbQ8wDUJqw2mwpl166wfj56ALn1l4acGPL9hE3ERg0YvWlXLisp4uOVkVEmzLMDZXLd6R@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKQaQPmbDHjC0TPSkdqs2btAq8QLGj+Fna5+lzdaQ3rspRBqn
	VKi6k6A75nCw1pK9AbRAc7oqAazQz8jzEKRClaxbrev7bIydMeX64cOVH11zCgPqyysAdzZ1Dwr
	5aW2szl5X9Q==
X-Google-Smtp-Source: AGHT+IFACbFgKBKlPscCXxu2FJpvWOu17SDKIWI7vglqGTGg8uhPIjaxhMCTv1EV7riOiN0nLCXS4urRqJZU
X-Received: from pjwx7.prod.google.com ([2002:a17:90a:c2c7:b0:327:d54a:8c93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528d:b0:32e:358d:6678
 with SMTP id 98e67ed59e1d1-32e358d6fb4mr2881411a91.4.1757874105483; Sun, 14
 Sep 2025 11:21:45 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:21:40 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182140.1958530-1-irogers@google.com>
Subject: [PATCH v1] perf test: Stat std output don't fail metric only
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When running on a hypervisor the expected IPC metric may be missing as
the events may fail to be read. Don't expect metric output for this
test to avoid it failing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 6fee67693ba7..ec41f24299d9 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -90,7 +90,11 @@ function commachecker()
 		}
 	done < "${stat_output}"
 
-	[ $metric_only -eq 1 ] && exit 1
+	if [ $metric_only -ne 1 ]
+	then
+		echo "Missing metric only output in:"
+		cat "${stat_output}"
+	fi
 	return 0
 }
 
-- 
2.51.0.384.g4c02a37b29-goog

