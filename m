Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134F3AE715
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186649; cv=none; b=JUb1ASU5TOOGLv8IZBK3FLA6h4AU7eUCi78Cw475MJrgIJUBP4yhifyIzFyiZlS/XFmDvhbjYv3Jg4w+0fhhXwj+z8jAOUT9MkWMIFRzoV1OaJuZJCEk2QDDNQe4Fj0MNzOULPUN6KA6Y4kdBbAY2+2QKbbfWAavY4K/svuZn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186649; c=relaxed/simple;
	bh=0eJAYdw9Cb4OU+p6pnVXg2HzO28eqI+JpOyOCFvpGXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KL7GQnfniMFyU+ie4jioK1LHt7jLXRikhUs1+j0HK7jQ3nAJdUjds4iIIedHRQfxsztbJIGrKP75AIQn8GLxwFMHapzOdJJb3zrSdkE8H0OP2iKxQTkaqhaCZVVnTGFMfOlu3HnR/7q3rQMkHdjAZMQ3CTppjf92UZpbDdqhbiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TCFMz0dt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TCFMz0dt"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c96b4f58ddcso2975298a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784186639; x=1784791439; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PtRZXcrzOWsu7xZaY2RqcnEzqz+fuwmLedpDlpa9fBI=;
        b=TCFMz0dtU53e/K1HTkuLTAkos5TEUDjE8c7GXjNx8oeEDnD0ecM2yUp032M2ADZ3yz
         AWR8DUOLCAUjyQO0i3h0+WP0jEsxNxgq6kCEejZe+5KVBqHx2ySdDWVE4SDeQr28YyXQ
         rvcNAEEOMx/iIQiobpPiTpW0s3X4cv7TzrxpWW25SwnPza48UD3nFrnBnlmVnaofJ9a+
         uZ42Nyg9yMj2F/Uzy8HF0ZHSudO1XkdrLl0VMu1GRQiERzhKLNamIwf0Q9zL4MfMbC+U
         WeMlFJKcknzMe9alFV/h6W7yyI8Oc1dzwVmuhiJgnI9jRv7QZzYpMwilpnpGMLNu0G3+
         kpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784186639; x=1784791439;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PtRZXcrzOWsu7xZaY2RqcnEzqz+fuwmLedpDlpa9fBI=;
        b=cpCdzBupWuUmJPWSqytYuIMkRqt3ew0SpoQN4VUtNPYZNLM7MYjobQbTRbhz5qkB78
         Z58rgKfNv8nHjZHsepUfgrMDB2rYfzSiG3ep7J/DgYVbGZXFfDmeBU3yjjDdf+amnMad
         BwVg+r4iuPBwKHmVCT3zryEvrghk6EFA8HiP4cEyOt86QqGnXOKdxo7l+eB/uvh4EMHz
         mHHRZbL3Obrd49ySsOPzNL/6f5oFCiEl49v9tSDhU5k3okP4bnvOGpZY2izhAfzfogUY
         y6UKBRfMw72nulfOeZB+3k539ZiA0GL1+cyVfbRq+L5ZHyrCE7/1duHXkzvQjJWH2vmz
         XXOg==
X-Forwarded-Encrypted: i=1; AHgh+RrwWspxQBLhi/VeNCMUkOjbJGxqhywabQhYANpnC0KbT0JNPz3YR4y9LKl3/oZXtVi0dzYOnfqCEhbF+UPyuAEt@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtrSjz9HvTdBi0+XXW6F/RlahoOAHhQR2GajeTwkH6IQ9FYXj
	jC5wkZseIgt8qs0cZZoq4mQczgWbBpfAQ4FFjA/FLOl4Yar3ZJrNhpPfp+vJpjBnSJ1w4jkxKAO
	s5pXSR6d79g==
X-Received: from dyvj11-n2.prod.google.com ([2002:a05:693c:87cb:20b0:311:52b8:e12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:3be:b0b3:3962
 with SMTP id adf61e73a8af0-3c1102d7cb5mr20551721637.9.1784186639283; Thu, 16
 Jul 2026 00:23:59 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:23:44 -0700
In-Reply-To: <20260716072351.560311-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710053628.1861645-1-irogers@google.com> <20260716072351.560311-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716072351.560311-3-irogers@google.com>
Subject: [PATCH v6 03/10] perf ui hists: Include limits.h for PATH_MAX definition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Looking at switch_data_file(), it uses the POSIX constant PATH_MAX.
Omitting the explicit inclusion of limits.h can cause build failures on
musl libc systems, which do not implicitly include headers in the same way
glibc does. Fix this by explicitly including <limits.h> at the top of
tools/perf/ui/browsers/hists.c.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 319c3d6c0375..9a3844dc3246 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2,6 +2,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.55.0.141.g00534a21ce-goog

