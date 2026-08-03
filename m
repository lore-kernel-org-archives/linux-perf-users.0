Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10D3093A6
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743409; cv=none; b=J9Z9K+Vo05cRz+bH5IM3jdooF9i6bWgC/3HFYsOmuIC22qjnA49SQNxVhy/l2vLzwZq13i+I06pr970NUwZ1cFHbhCRwm2QcZPD6XqJsQ6rr9Z9+ucyFghy/CWXatwE/DvKvtKjXh6/wb/O/ilb0Z5/XzJ4IlbFPF8n5cqILkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743409; c=relaxed/simple;
	bh=AFXhT95IQh/MSVcnnpzL+/e3dn9n4UkkD+vjBRqVWQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W6CuSEY/V1i8et6zEdwTboP9UG4wIniWMmUbaq/pPteLT+Eb93Z6YN1a413RUi01JKlVPOY2QAlXmzbVyFe7Oq5QK9PNbxThBXt7sgTl+tWtJ8yDqaCz1TTRGw8bHTpOqP4dMXQkE2M6BQ0qBFTmAtPyF/QKvSjDKmWNrPrNN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFdRKj6E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFdRKj6E"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b966dd74so9215715e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Aug 2026 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743406; x=1786348206; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnmTiXEUilPxW7eVFgPRbPyBpYMslCIhdWDrpAHc/fE=;
        b=MFdRKj6EAc9wDurlL5fLCkX98z42WK0POy5MFo2KxjjNQztNnhzoaRQRhPGDZWJCr9
         wN9bWS1fcvujGBwIKFCAEEsSGpN4GfsCmFIt8PXD9W55l0Tl5VFEuf4+Pq+ZgmIUBU+Z
         9u34qa+vrgqXxXT+p9gKw3db/GaWu4wGIiliZXRMjnsBCoQ65ZgXVveKehOYpTEHquUJ
         PwOApRQWaxBbTYcGs5qwOjxAr35gttB9dn/ADc7jiCpMT8Coeg0d/MDdZALMTUQqjJee
         vZuHP0fdqn3YQQNaO15wyQ0k3WcUv/JpD0JUNtBqSshoTYRj0ERVwrRES1WizBkXUjDO
         HBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743406; x=1786348206;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnmTiXEUilPxW7eVFgPRbPyBpYMslCIhdWDrpAHc/fE=;
        b=j6HvXk7JBhYf+Otq9+iwVz0c1MHDkOpTdDGhQYNOjtVwFf+bibKo0t+d1qczvAkJ2H
         /tcOtrdwLskyeBsI6s+BtR2/l7Tc2ZSGBLmghhx3JRN26dsoyxFTGPkMCZ3sDi/XxejE
         Spjx4hDThktWH4xpHYRx9DFEmBcmAD68LrQgJXvECg6eT7rqS/uj9XVco6zKxiRkV+x2
         SLptw3WJQWfhy53UHch4PoCcNPHLnOYdmJmuTjU5gfcD/VY375cYtnGfV5Dp0tLepim3
         KK5zmWH6sNw6xT5AfhuULr0u05ESUy6qrtbLP8YPU3zemLTy6u3bcwVCbax5mopYHNLg
         OSlQ==
X-Gm-Message-State: AOJu0YzL7EJrxGjRcMEuKqP8Qyahult9Z8WGg7mZsx6sNYZS9xGLm70e
	eNYbwVSTV4sVYmr661aGRWGx0qAXZyQk726n7dYHge/gqPURCfdf4kMk
X-Gm-Gg: AR+sD13PqFeQyNyVMA//QvJHmW6SlqLCZiH/wyvpJa3/5QVPwRTlnDD8p9IqbJcET5C
	hluaDInWVyDNSzbvc1o2RybPMzBjcqK4gz7Vk68IQ0yjb6qru3gORBhUER6UvQaf7CSkvFmOOgA
	U3bVrfxPTV9ifTLkegYRirNJ+/h9GWsKkTvPGmWuOG/C7HgAh6mPzMBK3gfqwIdH5PqHsc1/m9N
	T4h1gTD8XoCK6yXY53T7m5k6tlP3a5UiL+Gkii8BaUUCGB3VzAUeeGsd1mG9TljNbLf4p9gwl0k
	cVCh2tXiQCetA80Iv+ic+/g49fMg+nxNzklLQ2Hgohmy4eogaKbL3Fvat/REhr5f9rJ3atwM2Ho
	NCAsaN+T1/5tiduKCwJG/5hHp1+kAKyVziHScU9MKEh2bvnxryi9RxRBea1XK5Kes7nYTww6S/N
	JW8Z95pszS2c/aO7na81PQvNHbm2pQRk94A5ZyP9kTbChbSlYbvrukacN3JMsViMwzP1H4N3LZB
	dB4fsNsAdtMW3XbalX9Ubdj
X-Received: by 2002:a05:600d:8443:20b0:493:e974:41ac with SMTP id 5b1f17b1804b1-4980c6562c5mr147133455e9.16.1785743405833;
        Mon, 03 Aug 2026 00:50:05 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a5csm298759465e9.4.2026.08.03.00.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:50:05 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:50:04 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf ftrace: Fix leak in parse_filter_event
Message-ID: <anBILHWZfxku7OWq@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

strsep() advances the pointer given to it. After the loop s is
either NULL (on success) or points mid buffer (early exit if malloc
fails) so the original buffer is never freed properly.
Fix by adding a tmp pointer for use by strsep and free the original
pointer

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 tools/perf/builtin-ftrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index f7126196b092..4f881a40c311 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1607,14 +1607,15 @@ static int parse_filter_event(const struct option *opt, const char *str,
 {
 	struct list_head *head = opt->value;
 	struct filter_entry *entry;
-	char *s, *p;
+	char *s, *p, *tmp;
 	int ret = -ENOMEM;
 
 	s = strdup(str);
 	if (s == NULL)
 		return -ENOMEM;
 
-	while ((p = strsep(&s, ",")) != NULL) {
+	tmp = s;
+	while ((p = strsep(&tmp, ",")) != NULL) {
 		entry = malloc(sizeof(*entry) + strlen(p) + 1);
 		if (entry == NULL)
 			goto out;
-- 
2.43.0

