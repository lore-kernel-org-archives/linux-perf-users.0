Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC34035D0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060013; cv=none; b=luDbRQJQMPk/787TJOGXTH5Nr0g9FhNxEmEVvGrP+wnwdTMivQty6S6K+3rme4ylYNhRzco+/aPc+nZUHsYg/prusf2p83N3L+s5ENiOItKsuOACogTYF6ZgffdouWvs8Mh7OX6lP1oSaUstsCSYNfDLgkaUC+nOp3dUh3O6Kso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060013; c=relaxed/simple;
	bh=M6LerUGQ/FegXHi0SxaTfjtXEbJdYcXQ+sl9wiXh/SQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9qdfB85oJ8EO+4nr1xz0G1KThAmM6Tn+wz2GSmEDPP6zaW240ALk0fvlLjRk1o+ayQUoTB33bD3/e6pP5Qd83J7OFI5jalkUnwDPGf5PkeWqlDB9iBZpYG9XQnC6ouhZlklE8H1knPpd+kaznc3jgheFN2TIRFU7YhxCfx2ERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryKwLgYq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryKwLgYq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35c12a3bbb9so7568524a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060011; x=1775664811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+JPhC0NfmjsreQ1S+6TmS21rrwcvm5mWtScohYKt4w=;
        b=ryKwLgYqvbbJj4ORGxxfk90Vi7xqzpx1Q406vujbeSDxcAM4i8Lk49kEZYsbW/5S2k
         ExRn2wLqi782cDnJhcik2ingTEvLWagjlPdW3SfAdb3zhEqMiX9IrVvm4C9LGPe4nE4O
         5KpDUZCdCO0u6p1RlZGXHw5YUrQwZd73hJxxY5rz5f4YUxvbpLggrV1Vm5QlmqPylGMm
         ComcZMxaB48f+ZH7r+WE7pSZtuJqu6giftRmIb/kKeZc30kbeV6mz83HwSq+Bdy3Yft4
         T5A+8RzvPIAvDQMO51mP20vNIu4z0BFvL5DZciGW4bY0uDUH4+YTgyDFHFDzRXZdT5Dw
         78Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060011; x=1775664811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+JPhC0NfmjsreQ1S+6TmS21rrwcvm5mWtScohYKt4w=;
        b=jHOKFbpl19kl7CLA+RYxejM306FDF5Ojp7QO1OaBrWvi+11KJEQBj0cAAKbVqMyRch
         EvfgXFEwkcMUX6r51UWnG2PyBfeL+aIj5sDShIk58pHaDHr5iAMO3ECvqakbG6zpTMzT
         1gNpT0oK9MqA+rRIWxjW2dvXHHv6nKdBvqgEbLRmKlsVlfvHJpZM+85gCL97UarMeqIS
         Z5MgjsuDq91/JjzsFkCYHiGlWdfL/SHcxPlk8GEtec1BHS8xb/XjDAb0zxgn8M/d8Ifd
         IZAx/KWRmskjq/LXDo2RZkL4wdvRQEFWFVExQbeudH3LvcQRQB5yTEeYR+FdigQgVc+z
         +/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWoAtaLsh0PHBRGNfykGPQrOEA1sdgtc4HuB2AtvMRJPb6J19zLAoNId+izD61baks4wBg3mFgL2d+uofLpNF82@vger.kernel.org
X-Gm-Message-State: AOJu0YyDE6Pq2RMDk32tW/aPJ1nW+EGH1CKDVA+mcF+LXHzkJGNU2ftq
	V2uZ/+ZnUicicXUOGkQO4lApXW9C6A8y7icyj0qdsBOyEQGWZQ/fSEG+WIYJjFj9MjXa49h6VCM
	AeRyhqryYaw==
X-Received: from pjev15.prod.google.com ([2002:a17:90a:e0f:b0:35d:ab01:e224])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e47:b0:35d:9dc8:7191
 with SMTP id 98e67ed59e1d1-35dc6edc843mr4125867a91.14.1775060011170; Wed, 01
 Apr 2026 09:13:31 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:17 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-2-irogers@google.com>
Subject: [PATCH v4 1/8] perf clockid: Add missing include
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

clockid_t is declared in time.h but the include is missing. Reordering
header files may result in build breakages. Add the include to avoid
this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/clockid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/clockid.h b/tools/perf/util/clockid.h
index 9b49b4711c76..33dbd8673c1c 100644
--- a/tools/perf/util/clockid.h
+++ b/tools/perf/util/clockid.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef __PERF_CLOCKID_H
 #define __PERF_CLOCKID_H
 
+#include <time.h>
+
 struct option;
 int parse_clockid(const struct option *opt, const char *str, int unset);
 
-- 
2.53.0.1118.gaef5881109-goog

