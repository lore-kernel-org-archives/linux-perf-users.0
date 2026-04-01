Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D3478874
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060025; cv=none; b=EhwsKQDejj5bVFlS2lNqikq40+BMsGJ8FOnUDTynyQVaDxyAFAmM74S6TFUD/ob4HErv773HJIbaTIQPxG43w/JkSfdiDpxfn2amdNWoB0bSOjd8OY7CMGrF6n+IYjQdr9YmPk/IKq4Qqm3sHQwwNj3sCDrsOzHFiVAhes223kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060025; c=relaxed/simple;
	bh=6ubSl4mQOS2cDCE+bYaE4aL6nqQ5aKfnZ4KXJ4LgEkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=skuIQL9sCczBI/zxvrJUSb8eh46DUOYzynx91U13znbudL6KI4740zeuUV4seEU395DZ/Swa1msTF9ohMlNduv/b3QtEEs5XVpXGR1omt1lKJXaTTOAg1n3ofRzRD8QZZYBEf+rdLH4C6XAAjOsy8jBmn1pHjOje3vwEIBkNh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2SR5+5b; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2SR5+5b"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127876be621so999986c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060023; x=1775664823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCJ4l1oK32c2aW0VPxyI7wG69g3+cb8rh2zHyRRWSPE=;
        b=F2SR5+5bKg313Ao3uZ9mFg10piNFt4abmGLqQih6VsS3w5imlorPYM5A8y9LmVYoC1
         KfHnigPF1Qbo5PhMiHRf2bd8rotETFuNVQa/QViw0MdzkYJ4tka56Bhr7HVvt/C5nzqx
         +sF65QnnobtgD7QwU43G5+FYIQlocJ/eBAoiOSGIsK3j/4XKfAZeYRtCj9c14f3IvA4N
         YPKKZdk0mVnqwhzaPW9mNpy/+DcoYNfhQifizotQa0ScaOOpyCFpCcHAaZaMFMlJFfxe
         ewsEg1/uES1C9ce1TlkAsRAjNq8s8ZDltO6DP0Tipo9lt7i7LONhtwCdF4klpBOCCReF
         So0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060023; x=1775664823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCJ4l1oK32c2aW0VPxyI7wG69g3+cb8rh2zHyRRWSPE=;
        b=KBWOn7VwO9/FHwaHWDSn3yhDcbRSHO2CgUT8meTOHRDBBlxovZLA8z4YyuKhHZHpWZ
         7a96OvEoLjsP/e9oVjMRapUruRAR/e78vnh6ma3S6QgQLJ9Q5K8L/S25zFAtQXKxFgJ6
         NYIV6rx8mDwn4E7vZMtFTZ5MekKq0OmTeVXyQNsh+mXnqwU16AfnRfH+5tGHINuUQVVN
         P2iP5oS/ehGg9pdpjAUgRUNUiIg3HMPK2vPzhh+qxKyv6wysU3Di4SnurKlKIm3EIYCe
         tiw4L2Nejx8qK0wEIn6oEFhcE81f54y6Ttf6y6gMLjkxgZ75/HBvtlDBLc2VOJJvWzty
         4xJA==
X-Forwarded-Encrypted: i=1; AJvYcCXghddDf3Flw+i2dE/+1XncShImgGBx/oCurVF3EBFN8m8xUnatMRUSLFbM1XTyuadtY6YMHO4OvBmuDPbKsf5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/Bco7N41I46ML0w13ks8TBqgtW4aIbjIKYLkGm2ns3t+23AA
	gQxnWQ/DXlbJv4nlApak4iv++PZWqJhLKZ0dxSN4Eu5bC4e+N9qnXLBAJpy2/gtV/EBbjxHJ5pf
	1OiolYvcvKg==
X-Received: from dlbvg26.prod.google.com ([2002:a05:7022:7f1a:b0:12a:c608:a29b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2390:b0:12a:6d05:3941
 with SMTP id a92af1059eb24-12bdde10310mr3832543c88.2.1775060022593; Wed, 01
 Apr 2026 09:13:42 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:23 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-8-irogers@google.com>
Subject: [PATCH v4 7/8] perf evsel: Make unknown event names more unique
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

In situations like the perf data converter the evsel__name will be
used to create babeltrace events. If the events have the same name
then creation can fail. Avoid these failures by including more
information into the unknown event names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5a294595a677..1281af056cec 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -926,7 +926,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-		scnprintf(bf, sizeof(bf), "%s", "unknown tracepoint");
+		scnprintf(bf, sizeof(bf), "unknown tracepoint id=%#"PRIx64,
+			  evsel->core.attr.config);
 		break;
 
 	case PERF_TYPE_BREAKPOINT:
@@ -938,8 +939,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	default:
-		scnprintf(bf, sizeof(bf), "unknown attr type: %d",
-			  evsel->core.attr.type);
+		scnprintf(bf, sizeof(bf), "unknown event PMU=%d config=%#"PRIx64,
+			  evsel->core.attr.type, evsel->core.attr.config);
 		break;
 	}
 
-- 
2.53.0.1118.gaef5881109-goog

