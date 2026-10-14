Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277E1223DFF
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 04:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951778; cv=none; b=gGWrZVQ78XlvFsgbrK8qDjeFbpWVZplzIiHliLX/jjBS7iWR8qSXCKwN5xnQdavdN65XuM9SBnqazW3Xd2IOc0dQbHlQy+JTNNX15W6jzzac8Baz9euvifzxgaqrGMARecQTHs3RAj0biweWgF4efhvmltnf+A9ASwqkPWojhok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951778; c=relaxed/simple;
	bh=pthNk02sT5MhtNVGjPzZDe3I9Gl6nBSMh/U26T0qcFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MyODwk6GKrisIveAiOq/AhZQ0TmAg3vfvtgOMMLQ/TOLqrYlQW3wRc96A8atDrQI1ozwXscQS4urxkEej4W/OyczIq997/qY8/Gc4r7j/nVtAM8QGGwF/Ipnu7WnoparMrXST15HeCPVcr8EolwZxqCQV7UGymXy5yG1S1LxMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PT0XI4dL; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PT0XI4dL"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-351788121cfso5877021eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 21:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791951775; x=1792556575; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yE9kiZyHPWW8D6z0CBqVP5Y77+hh44cVozCo1RtidPE=;
        b=PT0XI4dLQY95nC3BkiyQ+H2t/z+hs0MMUvzfZnRESLguI4Oq+xOu2iXbVwusSGdDgP
         TILmpvdUy/SwSjy2bmepUxK4TJSIqs8rMW2RkfhQ+2arr4sPu3UvgqGoRb8y+Y+EiNEk
         vuz/ZJZ3zKUAkmA7XntH7L4iDlwnRXl1rjUuo9m3PEkQRwcYYa8FY3GQ90kjsCVt+hYv
         oYKNT8eKxnY3HlVQlRA6b5x+PLqYHdpFN4rFbkrr4Spfob1Ggu7NCVigVYqSJWE1eSoS
         4D99JlvakOyElsE+18wdVIVjjHH3Xq/otAFeiuTw7jJeQNUnwOFNOc9WKkHghdZqUTlK
         UrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951775; x=1792556575;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yE9kiZyHPWW8D6z0CBqVP5Y77+hh44cVozCo1RtidPE=;
        b=F0oA3qszUluULrwjJTXd9Kk2u3PDsMc1o0ksexbrInGJApaaZ6j8dGIGEN09b+IQrZ
         P13IJo5zZ1Oz4gWau8lrU6nxS64i6a+p6AyABYqox7TcOGMgIwiH9ZzjLpqf/q2vm97f
         73qC6hPU3+VMpfQY3S530PI7PprVSlaOVSJ+frcNTjTk/cpw/YmvEfuSNZvZ9/Ry+idS
         QRcgvBuwHdC689lCgrFaiJ+oGaWWmxaAwpgZPR1MznLe4d64/scdhW+p5eOrbTUrrSHA
         Y0X0yTnaGPiEnlCEQ/FLUHzIejc6iq4QR0yoGWXT3bSY1bhiKWDXq8nj690chF5WGDzv
         JxUg==
X-Forwarded-Encrypted: i=1; AKwUvBzybSyMvsXajLYT2oPpxcRZ6nh+DVZscfoWTLpQ2n9iBgz4jU7p4wY8B3r5TuRLn6JRSgxOjKt9G2pemkDa1OJV@vger.kernel.org
X-Gm-Message-State: AFq9FYKaUIuP7VoEMpXr/cKVK4RVRu43hBMnK6wyV865pQVKI4b6aiMs
	k7I3aHxdWq5iLsu+Dq99rY+sx7Tyn/lTXGCOLO47Hy+LoTPjjn3kSHB26hepJFgTJxY1D7QNwgS
	qHqPL4HwQog==
X-Received: from dyr27.prod.google.com ([2002:a05:693c:401b:b0:35a:be33:bab0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd03:b0:351:4866:255c
 with SMTP id 5a478bee46e88-3537e058277mr26818915eec.32.1791951774700; Tue, 13
 Oct 2026 21:22:54 -0700 (PDT)
Date: Tue, 13 Oct 2026 21:22:45 -0700
In-Reply-To: <asDHqdVt4CKq_EoL@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <asDHqdVt4CKq_EoL@x2>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261014042249.2379829-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf timechart: Add --live mode to the TUI and test
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, alice.mei.rogers@gmail.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, atrajeev@linux.ibm.com, changbin.du@huawei.com, 
	dapeng1.mi@linux.intel.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tanze@kylinos.cn, thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

Add a '--live' option to 'perf timechart' and 'ttimechart.py' that streams
live scheduler, power, or I/O (-I/--io-only) events from a 'perf record'
subprocess over a pipe and displays them in the Textual TUI with a rolling
time window (--window, default 10s), pause/resume via the control pipe, an
optional workload after '--', and optional output recording (-o), along
with headless shell tests in test_ttimechart_python.sh.

v2: Rebase the remaining 2 patches onto perf-tools-next after patches 1-11
    of v1 were merged.

Alice Rogers (2):
  perf timechart: Add a --live mode to the TUI
  perf test: Test perf timechart --live

 tools/perf/Documentation/perf-timechart.txt   |  20 +-
 tools/perf/builtin-timechart.c                |  80 +-
 tools/perf/python/ttimechart.py               | 786 ++++++++++++++++--
 .../tests/shell/test_ttimechart_python.sh     | 300 +++++++
 4 files changed, 1111 insertions(+), 75 deletions(-)

-- 
2.56.0.385.gd3acb90ef8-goog

