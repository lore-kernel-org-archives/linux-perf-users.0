Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792729109;
	b=ZefQ9cSl/8jd3CjrzNFgBcj6sPK9CmLsvcIjmBmZ85IdUnYgHQkQVmfOMVkCTGO14WRI
	 WOBRWuT9f72hoEqcF63RPy45lpQ840NwInNX82M5ExO+Ae2GSim2izNRLcgrtQSbT6Wd5
	 fxxcJ/wmgFG6fY1LYCBJ4PC38lNs6eiHTNRpWBSh2DFA3Zf40pF7l6CdIokZvbyblkM6G
	 CBFN/W52w8VZFmFXicMQyHiFGXEmTTBakY4lG1FnTprtnB4R49n3v/PAoz/35/sTZgGDq
	 KeVT8MdH4841gwB9cR9TSLkxQV/t22FqLh+B+ht6j4/+r/71oN0wg04XAgMZ0j0TZ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792729109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iIJmKLrzvxIg0OJqVcSfaYZDqKZjcxSxZP7eownyawg=;
	b=XNWXNAj0tnLyJpyc9iMdnd2d3TIgKCvt+aYVeMiXfQnc47wjxXbZEIXvUuBSdL+40z5r
	 8XKUwL3xnURD6e4Uo3ipx5+C1GMpTyRuKMWAUwFx1VFGU0eu40wqiJDGdX0kdsxLyGqVG
	 rp1g8LC5cY8txhkL2k9iCXoqA7tPDfUMqqEdXCEI4jiC20cqOt1hKqjTXhw8Fi/mqmo3r
	 mUjuEYBqPmSIEIPtWL5VjcgavYXWhKE0hSoyzDhnyE0Nw/PrQjA/rVZQTd2r1jlwcAhR8
	 JqWGchR0Gf+Sc+GjvNlUqw0fL2/aT9zvxTTiEmvSGfKQzO4G4MGF8/gI4p+oRmZ9Arw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qns2m14L;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E256C606A319
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 04:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E256C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Qns2m14L
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso990365c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 21:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792729108; x=1793333908; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iIJmKLrzvxIg0OJqVcSfaYZDqKZjcxSxZP7eownyawg=;
        b=Qns2m14LZlV4dszoi0utHSgyJhPq8uJq3cyA2ZM/9RLpZR70PNyZoRzuaVwle/oZfJ
         54YApc3biT+Sr0nPtPhOR3uiQpx+ANsVg0f/aUfeX7Q0o9O9z+T1sCJGzhDow9l9OjE+
         nsqWdju2MRR0extVUzWJOLzH8nLhPJKwQR6P/UXJPFERmqqCNNZv1EuYkQtDgKi01DN2
         LQrYrmU4NXpSdmm4Wxix/EZh4o/c43+XngAyZN0Jl0YZW1/gp0UlkkmBTXO0JlBRSg+/
         hwUMoyHa/m2UCCsnI/8zjN21+PAyeRo2swWnufHT46YIuL79XjLw7q2a50gejnzJ+qgy
         N6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792729108; x=1793333908;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iIJmKLrzvxIg0OJqVcSfaYZDqKZjcxSxZP7eownyawg=;
        b=BAoXL6p0EdTe+VKtuUniWdzkAPb4FLNxbXFu9+o/+63a07qsakOb0uGWC00BOxcvd3
         2TEYrujKVoAKIL/HcX67cXsdHpgM2ShBhgqcigNAl1b7Yl1vtGfbyhiExXScqMnKxGDM
         un0XcZBw+fMAAMkp3RLqnyCq8F+sWGUUg07we2zDi7RA8Cfq/jQ9MpMClowrv272GOub
         zmAOPUg/xhZUZBVuzDu4WmCNjguqXxxrJ3eXCtCQGxuxK/WSTOE0r6zUIbCY1g3tm2sw
         YWW9Q15Z3lf7qccWGsCwub4JjgiuM7HVoBd2JxkCxjiDGYoM+OHs9Gh6xT4xQc3YDdn3
         Gh1w==
X-Forwarded-Encrypted: i=1; AKwUvBzD4/pePJkCpC7P/XTdaxvdMg+Xg8QGVyWobnnOeH+EqPZFo6+iYy7MCr0QTkZbtzNszZ1y3prGAaJ4aIXKLjDy@vger.kernel.org
X-Gm-Message-State: AFq9FYLjtL3zTBUVYbQxVqqjmL2X2xgzVc3XVb9SaFTSD4QXTjA7R6to
	Oxqo5zIlwnBKV+tQ6matp9k10Oy8avWiL2tF+G7hdTVhX6RlZVeMDMpSP3D3Gm8RCqygEbDsU+I
	Ep3m53eQMhQ==
X-Received: from dldz19-n2.prod.google.com ([2002:a05:701b:4193:20b0:163:a42e:b837])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2053:b0:13b:2f26:6881
 with SMTP id a92af1059eb24-1959a9454dcmr1700375c88.4.1792729107542; Thu, 22
 Oct 2026 21:18:27 -0700 (PDT)
Date: Thu, 22 Oct 2026 21:18:15 -0700
In-Reply-To: <20261014042249.2379829-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261014042249.2379829-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023041819.2361900-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf timechart: Add --live mode to the TUI and test
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, atrajeev@linux.ibm.com, changbin.du@huawei.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tanze@kylinos.cn, 
	thomas.falcon@intel.com, wutengda@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

Add a '--live' option to 'perf timechart' and 'ttimechart.py' that streams
live scheduler, power, or I/O (-I/--io-only) events from a 'perf record'
subprocess over a pipe and displays them in the Textual TUI with a rolling
time window (--window, default 10s), pause/resume via the control pipe, an
optional workload after '--', and optional output recording (-o), along
with headless shell tests in test_ttimechart_python.sh.

v3: Address Sashiko review feedback:
    - Patch 1: Explicitly include <string.h> in builtin-timechart.c.
    - Patch 1: Reject non-finite --window values (e.g. 'inf') that
      overflowed converting to nanoseconds.
    - Patch 2: Stop the fake recorder in a try/finally in the synthetic
      live UI test so a failed check can't leave its background thread
      running and hang the test.
    Rebase onto the latest perf-tools-next.
    v2: https://lore.kernel.org/linux-perf-users/20261014042249.2379829-1-irogers@google.com/

v2: Rebase the remaining 2 patches onto perf-tools-next after patches 1-11
    of v1 were merged.

Alice Rogers (2):
  perf timechart: Add a --live mode to the TUI
  perf test: Test perf timechart --live

 tools/perf/Documentation/perf-timechart.txt   |  20 +-
 tools/perf/builtin-timechart.c                |  81 +-
 tools/perf/python/ttimechart.py               | 786 ++++++++++++++++--
 .../tests/shell/test_ttimechart_python.sh     | 303 +++++++
 4 files changed, 1115 insertions(+), 75 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

