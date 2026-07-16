Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09528386C0D
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185408; cv=none; b=FTJyoGwwbUZTLIB+UeIPu+Up8XcJHWQmaFRhFSr/YByYl25zTn/2Iq+WxqGnDI9xvuKz8MJSeNcf0F6EIZD6EDFYeKIAcD41m+eL/R4CprUST1G+K87Qsx8L+GTT3Tj0UO5WNB1tEA7BXNMAawadmeo6l0rBqCRyEO79oqNAXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185408; c=relaxed/simple;
	bh=UftcpZmurSmWOkHRhAfumQiBO9fPZRiBECvBmt0QEjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+x6s1ky4ZM8MpBj4ZZaioaobrnbDZ5A5CLW7OwQTxxtFv/XeL3gYv7i15UYB8rSrRsfaJMywZaAzLBL5fMTUckEA/+U6bIBTBQ1ZD8vBE68o9eacZJ6H3fjVImE78L1xxp0T1v7uWSrBDqWbgvfoATc6Umy6v1GwMmd0Nfhqsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dk/qk7Q/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dk/qk7Q/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccb687f82eso95515025ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185404; x=1784790204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NAPh6UvpkD4fk5vrJ+FvIGuSjW09efU2gKSB4rCskWA=;
        b=dk/qk7Q/WhX9TAH8zn9FnF2vLNpt22mW+mwPa+MbgpYii9wjFNzzHC0nksggioUG0K
         5FUjIe9OJElPN+vM6fz2skX9qHvp6jjr7Xos+n08GGP755j8iCEYXo78u+w3Mj8pjv/I
         5lzg/8CsxptDXRCpD4SaTHMSkk8UFpp1DRyKkmTZ54AamsomZXzj5gua3dBtib0BiSqB
         zaKlR9+c0IIj2ArJukVG1t1v6Utz++jhAt/5uX2NhY+n0n3Lvk3sqNTrUqP49lsN1XPu
         +1FdUepLs0I7m3J7ZMgAmajSJzpufYgdf7M7mnpgrGwa/3DdyOkevS9hNpvK8la7Fm5O
         WEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185404; x=1784790204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NAPh6UvpkD4fk5vrJ+FvIGuSjW09efU2gKSB4rCskWA=;
        b=kDz5hHONssTvqM/aecKag5VA7mVc/kFtjVGA4URCfGMMMxmgsbfbZQRlRf2bAr/2x/
         YAAolwSW/KE4/kTjWR2QoK36w3BwqI2AwTNeuu0q1lbWOWsOIynKtKV8xmSER4DSNcmu
         ayk2fNlt1dgO773B3if+aiUgkiMWD0oqgQ+9A4QgMutFe3fIPW08i2hf6+Uz746nOYau
         ESkybvKfBVAUA+GAmg37opaMwA6Mv6SqMwmGmZlkGbzxc1/uHbDUm9FG4DWwRlcmrFtO
         zzEi+Rzjzhc/LwSGUs/qz+Ul/AxLyUlkH9lcbUghxgO2127bWQ6KJKzYW+qGrp/swWe/
         GHww==
X-Forwarded-Encrypted: i=1; AHgh+RpudhIZ+a/3SOZbYFLnQsfhnjCLXOSXO6pJDHYdm/tDomKV+NJl6xqcBm91PTNxCzgYJcPCnT1q0TrHONIUupKr@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFjXW018zGWmtEzh0VUGn5wBMN6Yk9rYOthc74wiFpLwigQ1N
	sYA24EikFG+b/TreSXAl8I3CgzFoxhnWykHzzP9I6QD8HrohjdytIPfhcikr5XJXvMroj3AsbG9
	+RCESCTQlZw==
X-Received: from dlbcm27.prod.google.com ([2002:a05:7022:689b:b0:13b:a023:b237])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c948:b0:2cc:d192:50b8
 with SMTP id d9443c01a7336-2cf03e1f1fcmr57048515ad.47.1784185404037; Thu, 16
 Jul 2026 00:03:24 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:55 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-7-irogers@google.com>
Subject: [PATCH v4 06/14] perf stat: Extend STD output linter to test
 metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run the
metric-only check under the --new print flag:

  - check_metric_only

This guarantees that standard console metric-only outputs produced by
the decoupled printing callbacks are formally validated by the test
linter.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 0d38a1283967..69720b19b908 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -134,6 +134,7 @@ then
 	check_per_cache_instance "STD (New API)" "$perf_cmd"
 	check_per_cluster "STD (New API)" "$perf_cmd"
 fi
+check_metric_only "STD (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

