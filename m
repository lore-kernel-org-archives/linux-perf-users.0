Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D5A33372A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770668533; cv=none; b=XbzY+WjKj/ZtZrMbDxDgkqdE/+0+XZmSm4EDICnSU7Jl3fQzyAUd44JRkALPLdIYkki1uDwdhAwAwy2Qm0pcV/cXI28+hwXwb0q9GUvm8d+Z4oreptv4DD9qWYGBd0ILEWQSze6BNErCwfe9bCQ8mc2oj5kc5xQMH2fOpV72yQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770668533; c=relaxed/simple;
	bh=cZ4R1RRMz/RGeS24uRyCUuWWDbgfEPrua3rFxDMUfRw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Fy+6gP3CFky1A4re6/W+WypV05vLqud9lqAnzE0a2srNIpwqNZ6et5RX1AJTKqnmVOHX/TCJr5//TrFPO6q1wYbb3Hfdi9CWgIi9kCI0e3GEgNmte1T1jNgCU7soJFHZk42TL15EkPnJcJkR1O0Nx01Dpx/83uUDKWG07CJ+3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbJWTXMS; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbJWTXMS"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba7e98178fso427065eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770668531; x=1771273331; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5kHAmUd5wDChCVptXVY2hlsH2Ml6OzZFZZHE7/38CLE=;
        b=WbJWTXMS4pVT2B7cQhL8b3LMVGOwsuJpwE6LyWxEywyJTJzzFpU5qi+Swz43sVj/Re
         E3A8/Ji4QJwBkWoMxgrh6N5Vu4aDTrKyQNuTuAXy2anOMFCaxOo5kI0FW2mxJNdDreRQ
         3wiX8AoVRsCaYKJIV855iztEl2nV0bkxRgzvJS3rfrQ+DLS4Zzy+tO1EFqNDFMyp6fsv
         l3beSBUbeSOkqGzAHSJy223TkOTIOD0ExoFPEbZ0iuHW0pr+FW0V3NkVVt8CVDE6de0o
         bhucGHLXlO4HdaNcuCQ18fvHQWgm47zXvhSPIaMOURm9Ke30F1I91Q198meLuOl+1ekU
         mWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770668531; x=1771273331;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5kHAmUd5wDChCVptXVY2hlsH2Ml6OzZFZZHE7/38CLE=;
        b=YEXHtTL7uHL4GbmPJJt2wrpwtQaOiklM0Ypz9nhsM+teKpE8QnbLR1mIj7j4dQ1K8X
         muXIjgPmR+pCad8+tpOL0yT0FFlk9exxlBYtJoLIv6D+vT+sXsv2bzH+rbOq+swtBJBZ
         Jo8wMRIYj936eVU7Zpkgt7tIHpNYV+Pyo+fFp34wu+q1T1KMv3qWZ/oaacnYnxjsDHkY
         r3nGmSKkDjC0bIQQcNBb39UxdmKatxKd1sVFV9kgE6K5sUemHplI8tR5jtUb4wDVOdNz
         uBTYD30YOTk+fMP7WE819+YLQyk0rR0+/sWv/2tWETVPUkl8zobMsFU23AQOUoHld3IE
         XAag==
X-Forwarded-Encrypted: i=1; AJvYcCUC2r68JE0QSMnSsoqBFTD97rv2zfmSuVAmW9SwI34oyIcNrwXMkRKFYReDw8p8cTS5uQB+K4AyatqvDBBBDwh1@vger.kernel.org
X-Gm-Message-State: AOJu0YzDQ/0yvAPJ/VDPtrk5Oiq0uZC1rbT/h79/aGWGQUL1Zc6ugd5b
	hX/xbcgE6YKavtWIJJx/ifx5GTglmvVVEVfWWuGfRJJgGhLzsK8LDPlaiia0ATLz8KfdXjsLMMt
	X/ONA0AAoIQ==
X-Received: from dyhd2.prod.google.com ([2002:a05:7300:8282:b0:2ba:6d74:ea4a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e80a:b0:2ab:ca55:89ab
 with SMTP id 5a478bee46e88-2b856b55787mr5633858eec.42.1770668531244; Mon, 09
 Feb 2026 12:22:11 -0800 (PST)
Date: Mon,  9 Feb 2026 12:22:05 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260209202208.2027001-1-irogers@google.com>
Subject: [PATCH v1 0/3] perf script engine testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add tests for generating a script and that the basic APIs work. I'd
grown concerned that refactoring patches may inadvertently break perf
script engine support, particularly for perl, and this does something
to prevent this.

Ian Rogers (3):
  perf script: Allow the generated script to be a path
  perf test script: Add perl script testing support
  perf test script: Add python script testing support

 tools/perf/Documentation/perf-script.txt |   6 +-
 tools/perf/builtin-script.c              |  24 ++++-
 tools/perf/tests/shell/script_perl.sh    | 102 ++++++++++++++++++++
 tools/perf/tests/shell/script_python.sh  | 113 +++++++++++++++++++++++
 4 files changed, 239 insertions(+), 6 deletions(-)
 create mode 100755 tools/perf/tests/shell/script_perl.sh
 create mode 100755 tools/perf/tests/shell/script_python.sh

-- 
2.53.0.rc2.204.g2597b5adb4-goog

