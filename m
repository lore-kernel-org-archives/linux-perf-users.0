Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E53246F4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171543; cv=none; b=h8zcnqOVKVqvB5xhZnYkTuAk6mSq2GM1tNz+jl5WhGzkQxoUkUKuZ2X/i++1OOpUnsc8o4+8vraoqn2l1Rof9Hb6Mxe9E3KfyojJZks++PTGQJ+M8xyH7bFJVPvouo7er39CW4ry0oxhz7sbTxacMcd+1Zy4OmZrHxdy29YADfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171543; c=relaxed/simple;
	bh=U9iWaVNkVNi3vlsjZABvr31qE1vOlVVC6nCKmAYEIsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ywe7Mf6ahTAHi7N7mnL9Jxwg9ssGBQCEQyxS4DcHhDm2OlU4nyY4aWgS+SfazxkyRYQefFyThAkxnL3S06P+vHQsmiDVXcDRQhbhgMAAjSC8voxMRFKfy+DNlpVVXjnNFfV14y3frOppCENb4TV6TOUAbwn6LN81To3F4BP6P1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUY4beoh; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUY4beoh"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so4852435e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790171540; x=1790776340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oGIFkxwZ9bBjS+3ZXDVd/F3W6tAedWtQ6ECDASCr0o=;
        b=SUY4beohuWW5CoJYfPfn8YNiw4kiFyuYkFhbDejbzkDmOTWwQB+5ml8jI286o5/Had
         8/bKKPJhL5Lu4ctGQfn5jsnXryhjbmBHGsk0mr0SxWIyOSuidcvprYy2Mlw+wrDhn5jY
         S916AM7XkKOaZIHp9/6DrKs+IA5ucRkYdWmoODQOEzqyNWdxe7Oy0wW/THRa7hfF8PNK
         jSVUWRTfDQ4J+cF0PytwoX1+6zm96+f2KmVGvYahbdvhC+kyX2wcUYSfenx6aqiSLlVI
         apYivbHhNYxmVOMSyNCGaniI5gYf59+bsfZCkDlxPXD+tCKtSgE81F5/YD7QVl+dAMAi
         dH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790171540; x=1790776340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/oGIFkxwZ9bBjS+3ZXDVd/F3W6tAedWtQ6ECDASCr0o=;
        b=wXKLDUBEgjfSwZ5z3w163glOf0Dk+JHUw8mzBMO4+h3jsMCvJWenC5d9F9jYFRRi5O
         oHqkXCy2Yg9o8Qh6mkfxKKdAFeR2JhO1qcCGaHKpU57eMG8wxSMN4VsI1GniVKHmuQCr
         nwX7uWPIjson5Z2u/gN95ObB5qPpX6zdTacdzLhRt5I+h7aksDvSy/5Gf4NRs8qGYFMK
         fpBVL+ILXAXTO4wlyosvE4kcViZlNcNWlwDGur9Wq/OIX8/9jy6hXBuntnlLlPvnnFMy
         xFXnRUg82vV8uIRen2VbprMWFBbdB+FwXyuaK42z02Q5rTHhDoQdt+DgN2s8Fap1WQah
         3Uqw==
X-Forwarded-Encrypted: i=1; AKwUvBzS6ggO0Km6Bb52whWwjiI6AAsT0PTWRwnvPQrS2J/ZkJn05oP4wEn5ni9ze1D6Kh3LpAl6/AUcNr53A7cXzESg@vger.kernel.org
X-Gm-Message-State: AFuF++k0ST/6NQBZzpG2kdWqV73YfcsrvUD3d2FHRP6RkH/cfbdNU5O3
	c6vsdYvJ2txaMlYKEg2wFnlYWSPwjsrrawaYCLr8frmBt0eC+1LeuGgG
X-Gm-Gg: AYBFou3od4I5iZDEBtu58RIU2SiNCFO+LmxDtfKIZNhB19MBa3XQlIikAfHqB+u5gep
	BrSIZ6YcRM8iDxTimvrS3+o4lI5Wof2gIWIfxWl8j1YgZIgSDuPE9sMRC/WtPVfMV42xNFqWuo2
	cLMyQAMCnUs0YEzl5YZPdaP7XJSn19Tfi/D1R6qhsnFM7m6PPEK0hIbcLfXB/0rJEe7DZKyuDkb
	GB9kisyHK29oj7E8UsXyShTXy9ccpTk19rGe3p4n/YulMThihH+lA+n4FnzT5M/28ExI1LqoigV
	xvr/DgFrDIDZg5CuJC4CL1q/fVewH8E9WQQn8u+dpX2kudUvyaWAqUPvdIWOi8olJljzuiCTj1W
	J48BQI4O/juUgRecWBcl3rm6ofl9L/jE71np8/sfpgVdHyqcPe5dIAfdeZGnOyJ5kzx1SGjiSy/
	FaI+0dBLkVuEbSueEIagl1p3U/kB0Ir/wCLn1M3zcAGseQSmPeAFiSk9AiNbTJevgMmQ4iS272V
	dlgHai+CkasE0INwdwvhrKXqP/wgg==
X-Received: by 2002:a05:600c:4ece:b0:49e:84bf:6110 with SMTP id 5b1f17b1804b1-49fdee0af85mr41236635e9.6.1790171540051;
        Wed, 23 Sep 2026 06:52:20 -0700 (PDT)
Received: from christian-ThinkPad-T470.. ([2a03:4460:170d:5700:4660:b0ee:e7f9:8eac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm73603685e9.7.2026.09.23.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:52:19 -0700 (PDT)
From: Christian Melendez <chrismelnu@gmail.com>
To: acme@kernel.org
Cc: irogers@google.com,
	namhyung@kernel.org,
	jolsa@kernel.org,
	peterz@infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Melendez <chrismelnu@gmail.com>
Subject: [PATCH] perf stat: document task-clock/cpu-clock in TIMINGS
Date: Wed, 23 Sep 2026 15:51:40 +0200
Message-Id: <20260923135140.386033-1-chrismelnu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
References: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task-clock/cpu-clock appear in perf stat's own example output but
were never explained in perf-stat.txt, unlike time elapsed/user/sys.
This came up unanswered on the list in 2013 and 2015 without docs
ever being added.

Link: https://patch.msgid.link/CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com
Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
---
 tools/perf/Documentation/perf-stat.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index f334aabdc809..c0d6c344f9eb 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -621,6 +621,16 @@ user/system lands:
 
 Those times are the very same as displayed by the 'time' tool.
 
+We also display a clock-based timing metric that depends on the
+target being monitored:
+
+        83723.452481      task-clock:u (msec)       #    1.004 CPUs utilized
+
+For a single task, task-clock reports a clock count specific to that
+task. When the target is a CPU or the whole system (-a or -C),
+cpu-clock is reported instead. cpu-clock is a high-resolution per-CPU
+timer. See perf_event_open(2) for more details.
+
 CSV FORMAT
 ----------
 
@@ -671,4 +681,4 @@ that can be used for parsing.
 
 SEE ALSO
 --------
-linkperf:perf-top[1], linkperf:perf-list[1]
+linkperf:perf-top[1], linkperf:perf-list[1], perf_event_open(2)
-- 
2.34.1

