Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926103FE65F
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484188; cv=none; b=rq22MlJudRa8/flABoEAh45MwtnTb0ffn+VztsivGw0AWOiV/AGnf5ng9IxW8Xl+hxHkijXwLzcf2KGx+HOFQ3XXBXNh/Hf2x6c0+WdN1VC4UBv1O9RL6MN4X5vF0vT+OHmp/vzd3uiqnEInOhyLABRuiOY/zLcYLAresCPCPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484188; c=relaxed/simple;
	bh=rbsBVPTHVp24qvxU2IVJVxWmUYIL1gdsUjJFJuBiVks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2Sz+b9tH/S0gMo77H3T+TJCQN5XwY3VJQF+RDHw1WKo5hseaR8Fvbw0hdJarT7mNmNeZ3+j90iZMaB8VFSThsaUBGItNXW51OB4wJ8fScSEbV4p2ZQvPeCv0Z8K1m3/mEfmVJzEqVtD2nq1uI9fkDVSIhhbjy0PAper5xqArrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=bMjw4+6M; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="bMjw4+6M"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2de831d2b20so137039eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777484187; x=1778088987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8cx787r0/c1DcR0zTQ9mKZp9CswPwIysu4DNnG68zM=;
        b=bMjw4+6MOZjCCHAfBSgbozR70YjvMWlFIu3WckGb8yNn07XkY0aBnW27TJRia6ekvg
         yYS3I6nwXEscfhUNmCyBOVaIBe4Ky681zlLz/d/pBuZJSoz3/K0sXWLzomqQNcWkv7St
         ODAebS687VwVcetxOMsCo5Ue4SoyzfAazM95nSknKOKAu0R6UlRka9CDwWRJJxUN/uLz
         LTz18p8fPedFA6Xi+8rIP4r+WiRtbtt7l+nf4dMOiwNcvcqLjTxC/oy8F29HsYWLdaNg
         TtklzBGMAhOJqrB/rVJLWgfe/cABpF8llBKrPztzxSt5ygOcsld8XyE4RQBcLe1PNgEK
         0jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484187; x=1778088987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8cx787r0/c1DcR0zTQ9mKZp9CswPwIysu4DNnG68zM=;
        b=XBXyXiPIWE8yTawkjYUOeZnxGj8AcKC20yuYR5ZILHYmVxvEiLzZtpMzyQ3Beq1hd7
         58aKprck7t8luxLHHZPR1RSSlcK93/a/UPTzv6vK4YFCKmEOTAyyQZTYa7DjvwdPfNn5
         xEmKhnyw14rWxQzjtYOBtC+BThBBfMYdM78r0FSu0wy1bLWz+tdmdUA1OTLmlHkB4tpc
         tvLz6QeRzg3mMiGVQRtJdNwMhRrCI35ag76TIkX2VYXdPdwieZbFWCd7YUf5IBVKSGvw
         6D8qVwQC+SMeWDFBN0DRALyhBinsHWU4FSb1yWmWHe0iOBOTD8X8pxFQk4832RMOi6T7
         4A7Q==
X-Gm-Message-State: AOJu0YyfCwKydb1+ACa8v6QUttRzLA81vAOf77kSktOCDLnjrlhJbiWZ
	FrBvubBcDztipqKFT/02Bc65Ktcrx9g6vsDssdimZDpMMeaOOe6G5qObATCMHuORrvk=
X-Gm-Gg: AeBDies/b1O9fSGU+oSsjYoPeQAgVNNpGhwdQ7L96e4OCF+RvnkQZxPmWboC4HuksrG
	VJM/0aHH05aPJDoXvTXNTNXFiMNKIMcblx3cBOyRx77WkqSbfRZw7zG7SOU7KMSqNMgWRmV8Rnm
	5xDu0gcKfjGmjMk7xFJ0i554cKHBFos+pbocB+8csCr7+U8+5ACbZv/+CFtsYcsaTsmYVEu0AKl
	0MTuVk28V2eM8gTK7e9OgcBRlK0QgHdjw3tzqXqAhgFYsH7hEvsLuUgkiEDYYC/oSnSkzdRpODV
	4SRq5AjB2WmGbqf1O8ik42wONmneSaspcSC19B5jKVY8afwlB72xgr5DLFJH0yIyVQstYth0e+7
	r0O3VlVYQAZ4z6WgcdbZXDEJ7LCjM/7M0gIQiLOIqdqToZRS4PVveVYIacUC7bge0+KR6SP6IIq
	EyE9oNGZGHZjYF6/zQbLOYMArw5LS4sx/3/17JMeLrl29Epxg=
X-Received: by 2002:a05:7300:8628:b0:2e6:e7da:7c30 with SMTP id 5a478bee46e88-2ed0a0f1139mr4447996eec.17.1777484186634;
        Wed, 29 Apr 2026 10:36:26 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:eadf:43ff:5bad:d931])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c09c6e3sm2899087eec.25.2026.04.29.10.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:36:26 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 0/2] Two semi-related perf throttling fixes
Date: Wed, 29 Apr 2026 10:36:09 -0700
Message-ID: <cover.1777483573.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is a refresh of this little series:
https://lore.kernel.org/lkml/cover.1774969692.git.calvin@wbinvd.org/

Patch [1/2] is the same, patch [2/2] has two minor fixes described in
the patch itself. The remainder of this cover is the same as in v1.

Cheers,
Calvin

---

In the course of investigating [1], I set out to understand why this
sequence of messages is printed every boot, even when nobody is using
perf at all:

    perf: interrupt took too long (2516 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
    perf: interrupt took too long (3156 > 3145), lowering kernel.perf_event_max_sample_rate to 63000
    perf: interrupt took too long (4014 > 3945), lowering kernel.perf_event_max_sample_rate to 49000
    perf: interrupt took too long (5035 > 5017), lowering kernel.perf_event_max_sample_rate to 39000
    perf: interrupt took too long (6302 > 6293), lowering kernel.perf_event_max_sample_rate to 31000
    perf: interrupt took too long (7879 > 7877), lowering kernel.perf_event_max_sample_rate to 25000
    perf: interrupt took too long (9852 > 9848), lowering kernel.perf_event_max_sample_rate to 20000

It turns out this happens because of how the dynamic sample rate
throttling interacts with the perf hardware watchdog. Patch [2/2] is my
attempt to prevent the dynamic throttling logic from acting solely based
on the latency of the watchdog NMI.

Intel CPUs were happy with that. But AMD CPUs still printed the messages!

That happens because AMD CPUs have a second PMU facility with its own
NMI handler, and both NMI handlers average in their latency, even when
they don't actually handle the NMI.

Patch [1/2] fixes that, which is a correctness issue entirely
independent of patch [2/2]. But it also happens to be required for patch
[2/2] to achieve its goal on AMD CPUs, so I sent them together.

Thanks,
Calvin

[1] https://lore.kernel.org/all/acMe-QZUel-bBYUh@mozart.vkv.me/

Calvin Owens (2):
  perf/x86: Avoid double accounting of PMU NMI latencies
  perf: Don't throttle based on NMI watchdog events

 arch/x86/events/amd/ibs.c |  6 +++---
 arch/x86/events/core.c    |  3 ++-
 kernel/events/core.c      | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.47.3

