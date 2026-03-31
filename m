Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E1402BBE
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970761; cv=none; b=jza6S7YP3g71pNanIIFFfFLTnVxr59Z9Qn5iHzXB7Zxyw7QUXm/tTTcczYCw1e+6e/1LC1BB3CYoY3TXEvmQ+Hz1e+0hdEkTbIp/mNy60Et/TSNqK1Zp0ZE7kDQgxnxv2C+fVhx898C7fY1kpVihThEuoERdSLTraGM5sJ4aXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970761; c=relaxed/simple;
	bh=931WL5lxRqSVTB3j5gbXnoGACtUkYVdgB+a8sDGnyUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgF+QI0DwwT3uWfH2iEkpKkhA0yC6bVNSVGpjoLOEbBy2JsuyAZOJX3VxkGQsN6LfZXzGL1//tLCICYxLgC3k3Kylwd0UbvrjA5Omr75443lntQelF9gaEYTnglNtc0g6URZoq9WI5PxggzVEWW7ppVIy8wGeZje17RcVHGVRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=LqItqOnT; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="LqItqOnT"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12a74039dc6so4637223c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774970759; x=1775575559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XyB5u8iR+k4gpxBMoQKfY1JLhLhiFgCfs6MUItcTw6Y=;
        b=LqItqOnTMS1fvQcx55bnaij9NH9XhgIrp9tT2cwXicstGi1D+KXqrzBt/hWP7ptg82
         pJRhYIh6W0PUOc44VVy+wBdL774nZS8FykWo3jp//DMD0Gu4Ebnv8uw9rsS0cJeGDZMw
         kaVrmFDabaqpGn0v3xtgn3CfxuJFhgWjgjRGaKOPu4Ctk7FoFS40gTOuvg/8KKtXT4hW
         jVAFO9uHQOqdiQEo7K2f2fshdG8GwskNRGr6wrG999wSi6EcehxHMBysmSAJfeT/0lQ1
         C9hjWIi3nTvwkXpH/6QsK/aBzm9hF1Z9tzqpLT3eqsYr/TXxn6k9mWs3Dd75mzn0w31M
         6uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970759; x=1775575559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyB5u8iR+k4gpxBMoQKfY1JLhLhiFgCfs6MUItcTw6Y=;
        b=dnCvN+QlS0jQlTeSNwwna2xvPbDAxoStRRZRlylrJpqNeDFu3kcq88pgA/fWxHtOH/
         GC6YdiuTnqCDx08rzezPmD86+USSHEwBevGKDRKNQrC4dtnbbiK/dCkbw13FmbOOmP+j
         DTN+4ylCZ/NcjnAwOoOe1JIzo1CCZJWEofOgW9VF3LPDoGUObwJTeFdaTpLRuxlDuIwq
         AR7VdL3G8bQziU0IjRaAAaURu5sOnY2/So4AbU722hXBO1jxOCkzSIzd1vSPHnzz7p5o
         mdHPZpP31g2fqFy4zzsv1L6OrfmZkLXIaXRrh+3ILgEnwTMrFhrsk5sA0D8kwjtw5G1y
         TjVA==
X-Gm-Message-State: AOJu0YyafPTXcvtklZOh0K0w662hN4z1xvLD/3FhQN2yTX0TxQFNVMC2
	YBqFggkhkPZy+aPCYUmgtiGa41Y6qzxUhgEnMKTb40XtmgBxhJEvqMq4ezemHiGUWUk=
X-Gm-Gg: ATEYQzz+Pmrw/rFDu3EdIRLiIlWYVtuNDmVFdVOXVDhkLUJkbbqZmTlssAjVR8mcx6d
	MTG45cSdm9mcWZNxm299qkEXCsKdwVJngeEUo4F5Y8raBBrEK+6lNMMETWeHk8SmNZB24w6e7Zw
	kZaCR1DWwRKpzPKM4524eqFWtqBkpW/zRaJYpXRj7oK+tkGcJ4YoVc8WxVViQGByKAXHdbtRZin
	YtvV8wBr06/8j/a+IsF9zIzpjwpd1tlqga8JrrHzAcd0TOy08P5rIPSJ/Bcc/pdzuDzJhymyb6V
	GttbBKJzVtKarmh7EOjHbVhwtCzD/hbrubTXs3cRO5s0TXytQzmrk52WaWRtiX4Tf5Magv2qXUd
	gIMJ2voMWiNxeYqss10Tktw6DHH7TAyaX/5cK1qwx3/2QIcpdNyOk+PRqG+FnpOoc8Zc0jlWE41
	AatLozudgqDH7AKK3Q0evG4lhawJPhaQqFLw==
X-Received: by 2002:a05:7022:61b:b0:119:e56b:98bf with SMTP id a92af1059eb24-12ab29021femr9101926c88.38.1774970759146;
        Tue, 31 Mar 2026 08:25:59 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:5f44:e3d:a8c5:d59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f9f3sm15618113c88.10.2026.03.31.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:25:58 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 0/2] Two semi-related perf throttling fixes
Date: Tue, 31 Mar 2026 08:25:48 -0700
Message-ID: <cover.1774969692.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

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
 kernel/events/core.c      | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.47.3

