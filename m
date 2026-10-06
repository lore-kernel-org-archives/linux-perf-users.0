Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CB4C2278
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327174; cv=none; b=E8q2226E7hJARkODlxLKAckTJFxaJRfw8xzRmEL6hdsQ194CGLjhYIsESL0Ebx4i75/koLnofmE1EqI4iyFBEJv1jDSuepGQKnAqSoDyVR/K3ItFRlSSMqeoP0aJxDNvHd8UIsaIaZuWp3XQXbWjpHiJMziBZjyqRpapC/WwVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327174; c=relaxed/simple;
	bh=Z8J2I/kWX0GLRrAqLmLPVXnsmDJxut8j0wsvCdk6c18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BveAPj8tupXj5Q4D03MmVZkz14WcN56Z1lKduJ9SViiA7RfQyDj66q7/a90Hpss+XJWqcFa3FzzhRWFqXD1WLmbd7ifi+4rwTO0hfcThm4oC3PN5+Cd3+1TIY0pzu6vpY38xJjPg260rNVhBt7uQoYJ8SvEG7E49H2jkHzUrPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=OWxWSGUw; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="OWxWSGUw"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48ed188ee81so1847952fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791327173; x=1791931973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qVtFONvI1ZARq4YZjRy++svMx2rYT3eTVyRGWJwZNjo=;
        b=OWxWSGUwsSzCrbQQiINOJ8fIH1rjZGBQL3zzzo6rcU/qAoc2FQVO8SffmWcdIlaGiw
         l8wrKpb19l99/0y+Oj5eIdzAJTUczUj9diKu8+HUUtq//UZNWhzJjFD9UNt7O5X5mb+1
         jYV9z5Rb2PnOw80/Sdp/NcI/2jUUx+7lX1JbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327173; x=1791931973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qVtFONvI1ZARq4YZjRy++svMx2rYT3eTVyRGWJwZNjo=;
        b=JBfUJjAw/d+MXj97/p/dWvm0L5l0SeyewF8GTMSoyIGjQd9aZoC2ks0m5NY22eMJki
         Sp4Q5yxaVjGLEOQEwbLqWNpA6vM73nCzHa2WnTdqrvwDHRCoGsiCi98DLX4lA85EERfq
         f8ZNDL4D3+9o14TY/HSDdL8ZLesS883BH4xYrxPcd1AAZkhd2CUnOAz9u5Zeu+L3LiQt
         TL1DyoMg5X56THg8fnGRe0zedBRbjddasc4yCv59EjkhdOFSPh9v+15zpJM6TjlNeKAT
         MckVAkI2gx6TCa+z+vXL0YRVGatwZdzV3JVUt3ff6l9DyyefIeHSS1qnz8KlioCpIwxf
         o86w==
X-Gm-Message-State: AFuF++lAJKzIp5jFd0+vfRgQVYVoIaJXANT90LeKMsoSe6yDwzcLzTJW
	P+B9Y8+lm+ALZSRztCy/yxLDp3yJdIeBIHJtN3noBrsplBkZURQbXm+yp+AQ3WmVWedgqvJuUh2
	R8v9Aa3A=
X-Gm-Gg: AYBFou1X0yTQd+xh1RhyqJVbmz9e0CJmpLHD+mHfWPVhC/2EoQQDjXG5UdmDnrog40Z
	hODpzFL5EXUeAbaKmWI2cX5HKbB5eCc6A9B42SxgPzyrbW6dj/OYNa7+mOfK/OISadf9v6TGggT
	ui8n6Fg+1W8TI31qxR6y7W0LJ+8If2dOhCvQYZOrnpfqiSAQaM++y8vCKIB228u3z/yi2PMa1h9
	O0Zv3Hytm8eCAE3V6E1lOvoCHB4KVr5r5bALHKOZS5g4OGtHVugqtXsB1jj3PdRxVeYKalPYZlG
	cbW7veXxlDHF5397ny9FfAmeph/1e2stM6L6irGIp/gDzmPtI/1XukqptNY/QtN1HvMI0BijhSR
	n82HC5ZKCUR/9JRJrjHe6pfPlVjKnUmA/At9BTUQXJoX3EEBSR+cXKkOtyR6IViH/KT+IZiDG+F
	YfbKtEsKGAQE/AKfrcxWYRZZeHjw4JQaDkupz/CGoUQNUZeILinm5VW3tdrmWfSsCGXkqhDrDpa
	Plw9C1m/k+LC68EPjWm4jy7IVhHdcQiLo4N2CZLqDRr0IO66ioJhwlNdBN7sp6k1o48aXo7fRI=
X-Received: by 2002:a05:6870:891d:b0:48f:e0f6:bd5f with SMTP id 586e51a60fabf-4a2596f651amr488425fac.48.1791327172838;
        Tue, 06 Oct 2026 15:52:52 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a256da012dsm736585fac.1.2026.10.06.15.52.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:52:52 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] perf/core: Check kernel access for text poke and ksymbol events
Date: Tue,  6 Oct 2026 15:52:48 -0700
Message-ID: <20261006225248.54708-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_RECORD_TEXT_POKE contains kernel text addresses and the old and new
instruction bytes. PERF_RECORD_KSYMBOL similarly exposes kernel symbol
addresses. Both records are delivered independently of exclude_kernel,
but perf_event_open() does not check kernel access when their respective
attributes are requested.

With perf_event_paranoid=2, an unprivileged task can therefore open a
user-only software event with text_poke set and observe kernel text
patches. Opening and closing permitted counting-only tracepoint events
can produce these records through static-call updates, disclosing
relocated kernel text and branch targets.

Include ksymbol and text_poke in the existing perf_allow_kernel() check.
This authorizes the source event before allocation, also covering
inherited events and output redirection, while retaining the existing
sideband behavior for callers allowed to observe the kernel.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db7b76d6b68a..7301b320f746 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13946,7 +13946,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.ksymbol || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.53.0

