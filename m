Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5833FE05
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557362; cv=none; b=FxxiF6tj7gGnpyXbKrKIx/uLt6Gu/W4rIu0DuT9MpkuwRGDDHZwsm/Ahj3qCIhY+bNU9NfQepbJCUtzl3v90Tyl3cUIpYhNBCesPWxAnDrRSXoS98C0rt7/MUfQV7ecvFleO8mwzAEtpsd+8LNBvSkP9HY7RPRd1JSDN4nhMGcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557362; c=relaxed/simple;
	bh=aWZ5HcFMXl1VzTghLnSGrhORupqnBvdLRRT1cJ1vQa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7t9b5j+W5iq8OdH76N5eEc96uxpz8YmvcuIkAmKzdXkjdd5RvonGYbzlyjAML+Ghg+m7poME2Tdf+HFn6dt4jlVtFCKNtBNOl4KAbKVy5HCJ/MkITqSxb9MNM4y9sOmsWOZEOf9ckmhVeVfowKHHMh/bqe5hY6GQoIN9kkjfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/VG3WCL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/VG3WCL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffb83bf7aso11379625e9.2
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 18:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557359; x=1791162159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rig2zwORTLMLRCPpGPY7+gmti2mlQJRGf/4YQHeFYQU=;
        b=E/VG3WCLro+/QcFOls8HEbJg3QhCxEfTgcNwSbb0K4rIRg0a0Ul7c/bGz7fzhH8hqJ
         seCw+Hwvj3Ud+DAWQhgvujtT7cOy5JVD0LaG9TJxcRABTRNxelsJC1t7eXr3Rv+Jwjhj
         hh5GDoRNmTafHcl2jyY8vqAOorRPQjPpnWVG4xzOsFv1IeehKzdmIGhyZWVvdvRtjLuE
         28WaCs5MhQdXFQz4im3/mO4Mc/j8deXn7xJcF3xY1qBaFK+YYGpnZeYurPC5Oyv+9G9c
         GDNilQ5e/q9R/wirRWKd7oxzZrS/o4IWVadtruvavKYYH63BcRbaSsAivprdbimrd4nP
         IOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557359; x=1791162159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rig2zwORTLMLRCPpGPY7+gmti2mlQJRGf/4YQHeFYQU=;
        b=YdW3g2JSnzOkPm7EdA4KAgEIax/7sXrZ9hZI4WDaoDe5MkcdyVrvR8C1qhizdtGAKq
         fQWssYxNvSvBf6B3YTKTNdfgPj54mt/tpNQqKDz5K576wWCJXif34X6qp/mHPuk8B6jr
         impgiXhiJtY+Fvuqmf254H6KKxLk9Qh0/5bnkCUgLSVcy9DRqtVeC7z9AG5GxhkEpUZN
         Msp1kAk25XseniuixYTTtbigtJqRofzCnnaVub6yuMtGt0gx/ip9mtH4bnLt+mQ/f3ZJ
         Pm2MDQboI8fHXrzxzuunlips22b/qCjxWymN/zSJkVn46WRkioZlqqILnx0II3wWryvT
         ERDA==
X-Forwarded-Encrypted: i=1; AKwUvBwACBEEHTj0/iCht+R+4yQ2V7HFXOd3AL9F86otTsXaT3gmhwjxHdqrTKcXHrveYKpUcOstcPjgI2N3iQhwWzsO@vger.kernel.org
X-Gm-Message-State: AFuF++mQb55wTltwsgO7tAwzIDYqypG52Qs+kmTwmBJ2AdkjYTdy8iPc
	nIDK6l/10cDERCKbNxgyV7VDk/7fFWhIMh51/LjaPfw9l+mp1eDvImkZ
X-Gm-Gg: AYBFou0CGCHUQf/ObP9d2KZQUetNaVo+UxjyP0U95S9BOUbV7625dqCB6jGMxo2mkYq
	6/DlHagHT/IrqBjnEsAvX6XB+xJ/4AldFeze2/OLR9JeZiVV9sg+qBngpSJ/0pcF3XAvASYbptV
	Y/O2NnRqe2jtBElKjl1anY+2dcSUPb/iAcmQZz/E5Rtf+kGpMmaitDgtIBZwazFMIAeQRn8m6o/
	+cBfXAfV2Bzy1vVgePPmOeHRJv1NhZbfAeQU63O8wkmmdrdlAkYqHtUSY4lCGKqunkQVuAfpSyl
	ukh5Vplk80Kn/06T/bu4kTvwSWgw43Y88L6fKSrJQOc4JTWPaFvnyYbzTDZ8iJqo4abBXh+QaxF
	bz8FPTLIfZYrR89Y15AjSGj+QStZ7ty1g4kdyr9c1RIhuChvu3abt9wJWOOyAx8cFcTM/X343Vs
	4YBDuE9q4NlOc1WXgBUt5GcRkw2erjJXG9tfTnI/L13SQzlUEXH7QwrK9gqJWmMY7SsdB8tXxua
	Qzl3fewDv+xKSTZRt8RKjtneNnA9AFV00xYv4IyqJtsw7uClDbnto5OfKiQOkeQvasDPv7sCFaQ
	pyHAxhHz1JEldbIIurxSkBBINjhVDHFTskmZJULuI0mj+9MGPZk=
X-Received: by 2002:a05:600c:314f:b0:49f:e4ca:e09 with SMTP id 5b1f17b1804b1-49fe66ca9e5mr199203595e9.3.1790557359191;
        Sun, 27 Sep 2026 18:02:39 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm144207825e9.5.2026.09.27.18.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:02:38 -0700 (PDT)
From: Michal Pluta <michalpl2003@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf symbol: Don't return an unterminated Rust demangle buffer
Date: Mon, 28 Sep 2026 02:02:24 +0100
Message-ID: <20260928010227.1903673-3-michalpl2003@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928010227.1903673-1-michalpl2003@gmail.com>
References: <20260928010227.1903673-1-michalpl2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dso__demangle_sym() runs out of retries or fails to grow the
output buffer for a Rust v0 symbol, it returns the buffer and callers
blindly use it as the demangled symbol name.  However,
rust_demangle_display_demangle() doesn't NUL terminate its output when
it reports OverflowOverflow, so the buffer isn't a string.

Free the buffer and return NULL in both cases.  Callers already fall back
to the mangled name when no demangled name is returned.

Fixes: e20848c317b5 ("perf symbol-elf: Integrate rust-v0 demangling")
Assisted-by: LLM
Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/util/symbol.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 163652f071c6..3cb42805a82f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2762,17 +2762,16 @@ char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 		     buf_len < 1024 * 1024; buf_len += 32) {
 			char *tmp = realloc(demangled, buf_len);
 
-			if (!tmp) {
-				/* Failure to grow output buffer, return what is there. */
-				return demangled;
-			}
+			if (!tmp)
+				break;
 			demangled = tmp;
 			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
 							   /*alternate=*/true) == OverflowOk)
 				return demangled;
 		}
-		/* Buffer exceeded sensible bounds, return what is there. */
-		return demangled;
+		/* Failure to grow output buffer or buffer exceeded sensible bounds. */
+		free(demangled);
+		return NULL;
 	}
 
 	demangled = cxx_demangle_sym(elf_name, verbose > 0, verbose > 0);
-- 
2.43.0

