Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29383515E9
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557365; cv=none; b=kCR0B7pY2QQU9+FNuiR6l8FplhGrMN+1DtbniXKjOyfmzVn7o2n9PX15t2Vr9YEaLaRS1Isf6PnCvvEHLSLKJTIlcz5mK7sPyAHTeMJYG049+em2Bhj+kwjBX6XVd8/QtKDdu3EQnl1Xy6cJWpmnndnQIUz8a4vo52aOITyfSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557365; c=relaxed/simple;
	bh=6Rgk2U5Gcs1jlm68s+8TwYLZMH+uGB+n3+xZdFJefhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upqGbnCcUhwigjDrHdhbb15/TebV50rRsxJBWb/2yxuoFRs4sRkVnd84XA95Mq59ufo2zYY7YIy3y5xEfzgtR9p1JkjXtY5/LIAr/ujbFzbgl29LFG8l1u3+ZTjIsbv5+umhHSRRyg90sgLphYWZMbQQYnvsl1MW4zsBYEFRWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owIO1w5q; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owIO1w5q"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so12821675e9.0
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Sep 2026 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557362; x=1791162162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dA1k+qnNIUMMLlr4nygQrkXcpGTQtW64tuBD4+P/LiQ=;
        b=owIO1w5qOXsaNV7Oc9HfFzG84TRS0mnLvOGIyaEguHKffBQl2IAxuOvi/nGc4kcDZh
         8L7n7WQ5StKLTMJDxnS950ANwoPL7r/aN7D4Dj0r3MBtzpfV8hl+sTmsHR5iupKMjept
         OO/6RZYiO/+ryrsxU4N9wneZw9WsMf6xFCL9znS+CsnVHYCTMAg8YdvpVxdyD1xUWddd
         CFm606FYR96+kCsoF9arCEYFopxsaSyqFGkDFL6ajuAjNwnJCVFRwwdehpmG1pXRQIUm
         BMbFdyIfkvXhb2wT4TMPxoWA23pI2awG2NoTnb05ck0lWfUaj0I9CMQSer5W+D/TGKqD
         prhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557362; x=1791162162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dA1k+qnNIUMMLlr4nygQrkXcpGTQtW64tuBD4+P/LiQ=;
        b=jzwLA2RqvzoNQSUvqHOqB48Rg+H9wx1/7044Sir+Kmx/Iza25WTjMdmUqPAoAy1hU5
         CUJc/ibKYAl+NHWPdQFz9Fz+7mX6unTXhFsJ532jf+eqbCj4rCoXm3XhgUN0KYMJklNH
         DY300WJcuZovApli+QCHlvBWQrI6xY+sb80sihJfam9blXNca8LjU0r53npFJNL+wS++
         Uq0WvBoFqXO7/HqH8kRLHebi8FtfhGEpifimYhctgD39hFL+ryYxoMYQ9CBLFARYKWyQ
         WPbl/YHFLbkTlFlnQ9/WOAONJHTWwT/aLhfw1ERce9eT0oXZgw7vDhrlH7RkuTM4fKU0
         J3eQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsgvcF0gzWI06+59ySRv/xMOA9iaDVFE9/Y9VgdFw5aMjikhrN3qCq+QuhCIQj3hfen5S30LU3ygywiOZrDs3J@vger.kernel.org
X-Gm-Message-State: AFuF++mcVaHde8faf8v9xOI3EMNgz5NaB7Euyg7JyJ+W3ZIFie+KsfqX
	3zGOdcvM0T3MTJXX9cEqCHv4NYB65zuVhIjURoXxGDrBUWsRdsulWzCF
X-Gm-Gg: AYBFou3BeO83zLwQfS9hyikoN5PgcCd5pG+PN/1iqOT2vfyFxt11Q7kpY8yh74X8Njr
	WhNlS+glm+HSFar9OiZ1oweN9e1UmI+NGBCRDKEIXOWOJvqda+L7x12lE1wFnSrYnsb+fxEodp/
	3ZYyo5wblBoX+KauMAxPq4q7nZoNrM801cJzvqmp5gEcZKhObO0DyVGfg33wZG57soABvsLW9E0
	SEWAAthxNQRrn944CTndMRK+Njwq1pRbpYOShnmbVbzKkXQ2D5jHaa+sdRjkw7gvEbBWUQcY7zS
	2PnpIAD83gZzqX9slUp3nahCxDmAZRz31sjAl3MbF4q8FA2OYY/rXois5CG4P1yJTVs+82GpJq3
	1/EpThtKZB6UzPZXLmK2yeZfMpyyQy0peaoAr9WdzaVX5NrdKxm5BrHuXboZwU2f+H0tmzgR+Ie
	Qa8FGoDfWFviS7nGWhlkIkcQl4oExXYza/MMExG67FSfezWIybxMnz3d9cqOeIE/awtp7ZAPJg/
	5p9eL+BIN925TlmDMr/ogALFJblFnzmtW9y6nqlQikzQ6IwtAIAunFIkLfAc1wHcFNDNSiz9Pg9
	Itj9Py/GZN05q3sBfSHYnlOYZAPK1VxGqe/uv1X1O/xHbMzymfs=
X-Received: by 2002:a05:600c:3b1b:b0:49f:e4d4:dd70 with SMTP id 5b1f17b1804b1-49fe6705bd7mr211875075e9.31.1790557362024;
        Sun, 27 Sep 2026 18:02:42 -0700 (PDT)
Received: from mikebook.tail5724d6.ts.net (83-244-142-114.cust-83.exponential-e.net. [83.244.142.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0017652d1sm144207825e9.5.2026.09.27.18.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:02:41 -0700 (PDT)
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
Subject: [PATCH 4/5] perf symbol: Shrink the demangled Rust buffer to fit
Date: Mon, 28 Sep 2026 02:02:26 +0100
Message-ID: <20260928010227.1903673-5-michalpl2003@gmail.com>
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

The buffer a demangled Rust name is returned in is sized to whatever
attempt succeeded, which is usually larger than the string it holds.
Shrink it to the string's exact length before returning it.

Signed-off-by: Michal Pluta <michalpl2003@gmail.com>
---
 tools/perf/util/symbol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 1a52bc2980a0..858a14a91f79 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2772,8 +2772,10 @@ char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name)
 				break;
 			demangled = tmp;
 			if (rust_demangle_display_demangle(&rust_demangle, demangled, buf_len,
-							   /*alternate=*/true) == OverflowOk)
-				return demangled;
+							   /*alternate=*/true) == OverflowOk) {
+				tmp = realloc(demangled, strlen(demangled) + 1);
+				return tmp ?: demangled;
+			}
 		}
 		/* Failure to grow output buffer or buffer exceeded sensible bounds. */
 		free(demangled);
-- 
2.43.0

