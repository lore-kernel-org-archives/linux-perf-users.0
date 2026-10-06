Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA613DDDDD
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291837; cv=none; b=rxah8fBJKDuVaSETRahKtD3TND6GDGkBp4nwATkERzRUAbELIC9/S8e1qzUOz2+rpLA4eIZeA4lb+6npuBnc7AE/e7eWuHQ4HpsSyHfrVk7gHe2+l2pZ6mA4uYg9f/HG6sH8KZMMGPgq0u1K7uombBAdM4dH87Ibb7SHQSPk7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291837; c=relaxed/simple;
	bh=9zQu7wg1xjbiD5jQtWxleHDg0CQmiEWV+WvaA8rFa1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WS0sccA5LpXyNVacUtCWt8xMerLBSZsjWeb8lI4SyreT/V2R8dTwIwKZ+YObSSqseUgFD6y7DPREYxm8YsYYtHRMbh7P11ykZbgLzglqcRHeWwJWzyT+AE3U5FUb4a+Pg+xSNGThb1iwBMYxhM0Vd1igiHLIbetz8+MByXgjSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TvrCtNCd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvrCtNCd"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so13462955e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 06:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791291834; x=1791896634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fRxFX5jd7vzqIjZY35n79LbZDv/XaQ+6fw2e2XJNrQ8=;
        b=TvrCtNCd6BTrYLyOMuscXZhkX/jhlXsRjVXeYORI9maCHVXIhHRZFx8+2xil+oGQeR
         ZraG/C4q6NYpjEmKrqU44/RKzt88kmhrrMCf+TFE0rP6j742/LuhduKc35dpr0m60PbP
         SRGkIhw40gQ/1+bYNFVmQmdAqgXaGOQi7+d1GIGcLz8PgMsImwUSgeZnND+1xvUUV91h
         b5W88Oj2fwkBQZQtRvpMeQ/nRY3CRZcYS1HUy5OWMwDyV49Z9sXjFmKsNMonngyl++tU
         uZpo3YJhMfRGM2nqyZgz+FyepJoZDJqUUtJp82i2GMnMfjIV22CYa9nFD70tnl3pejpI
         uTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291834; x=1791896634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRxFX5jd7vzqIjZY35n79LbZDv/XaQ+6fw2e2XJNrQ8=;
        b=ZQe/96xGvfeE4lWJ4aq+XG12QPTf7pMPf1Qiy0U6cwjvUVdH+gyPQQpuhhNWM738GF
         4aX7SWVuVLISGYLb9Hx8g61A6Bzfdgj1uvJ7xqMqPWOQdpKkMsdAnaQ6unHRunUJHVfg
         Z88zsTJWszz1AArsg21wKXdNKX2mqzu5jXOh38a92fTzMqNx6NNQ9EzagpTFKbB4aV/r
         H9+N1EPWKYVz0C1nUP9lQw+z64VRy3+e0gDPZ0bfDGxkFVXS2REQ76l/CcmkEwnrVDNG
         zOXZdI9tbxWo9fqRpj/NikVfI3FNzJSV9TeaQqYIaGWGLQazNaQ4q0leP1RIL2tGCXkK
         RgmQ==
X-Forwarded-Encrypted: i=1; AKwUvBytkj2qOEuv4sBHNqttWkLpSNQ07dtEhYwwtYtTSIzvRTL+lrLd49ANoO1bRV8RhJI6nUeIZExW7YkscTeiMoev@vger.kernel.org
X-Gm-Message-State: AFuF++kfpPEyCm1d0THxXXqqgiIGYyoD23O5zaqSxwNZdxfw0xRUAB52
	pyRExJjTPJjcEgPsn+fEQUzrth5k9+JYaY/gM+z9PPumdczaeluGH3HfUPV0UdfoClY=
X-Gm-Gg: AYBFou2sVZrLQ4HyVjoVvEF3/p9SX7hbl9zg9a7ysI/jXioYaFnM1ZonHwz3SVBGkhf
	68mF6AtOPb4NfmCrl4ngzQLSPTxSq2Jm04Gzh5dMmkTuHZKfHzVVOcfmUToFnKDrorCWNreBIHY
	k+0diuoRxvE2cdi6Sd/qat+2Y0HDkSBxHS9VsIzAG9hpFgAqwocsIUoXnV4Ld3YZpCk4dER/QfQ
	fmGQOseW23SYpJ81CaklvJQMiLXcAGKHazfJSz4u31CSsBulyNKPJrrSNbwTedqMeM0IfwUAs6D
	44QzdNEJVSBNKBmfI7ocjjAmfu4WToVWQWqmdNrdrs/Wy9AEztY5Bq6UPgBcFwGARMCEOVaU7J1
	J303zWn7yHQCWNXNCYOtPhXs4yR2f1PmJPGaCfFmuGyP3hryYS5r9lDBXnaCoaIYPjv3nmmqSBO
	2hehmde7hSyjG0kxKQOUeIMrCQ3NuY9dh+brj+OeNjb6f5l99t3VR9J5aCYq67i7iErLuH2Qyo8
	g==
X-Received: by 2002:a05:600c:4712:b0:4a0:251c:fa72 with SMTP id 5b1f17b1804b1-4a17b53bf09mr21476995e9.11.1791291833973;
        Tue, 06 Oct 2026 06:03:53 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a178c49c35sm78638295e9.9.2026.10.06.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:03:53 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 Oct 2026 14:03:31 +0100
Subject: [PATCH 1/2] perf timechart: Fix task row type narrowing in
 goto_task()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-james-perf-timechart-mypy-v1-1-e2c7edf4dd31@linaro.org>
References: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
In-Reply-To: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alice Rogers <alice.mei.rogers@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Mypy cannot narrow Row to TaskRow or IoRow when the class passed to
isinstance() comes from a loop variable, causing the perf build to fail
with:

  python/ttimechart.py:1686: error: "Row" has no attribute "task" [attr-defined]

Check against TaskRow and IoRow explicitly so mypy can verify access to
the task attribute. The tasks and I/O views contain TaskRow and IoRow
instances respectively, so task navigation behaves as before.

Fixes: e7a72d691980 ("perf timechart: Add an interactive --tui mode")
Assisted-by: Codex:GPT-6.1-Sol
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/python/ttimechart.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimechart.py
index 34ecf84e68c1..d7ba0276a9fb 100755
--- a/tools/perf/python/ttimechart.py
+++ b/tools/perf/python/ttimechart.py
@@ -1676,14 +1676,13 @@ class TimechartApp(App):
 
     def goto_task(self, tid: int, time: Optional[float]) -> None:
         """Select the task in the tasks or I/O view, optionally moving the cursor."""
-        for tab_id, view_id, row_type in (("tasks", "#tasks_view", TaskRow),
-                                          ("io", "#io_view", IoRow)):
+        for tab_id, view_id in (("tasks", "#tasks_view"), ("io", "#io_view")):
             views = self.query(view_id)
             if not views:
                 continue
             view = views.first(TimelineView)
             for idx, row in enumerate(view.rows):
-                if isinstance(row, row_type) and row.task.tid == tid:
+                if isinstance(row, (TaskRow, IoRow)) and row.task.tid == tid:
                     self.query_one(TabbedContent).active = tab_id
                     if time is not None:
                         self.window = self.window.with_cursor(time)

-- 
2.43.0

