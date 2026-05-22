Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649B3914F8
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489260; cv=none; b=jeIDPkNq/RRUtq8hzoRvIb4EwuGrtF4KE5LxhhBerO565W8Ty56AAzV3+6/plC32XijhIMXxToCRxILCMuLAKD08lLHY2zRw4CyjZD20XBhcMWqBZwI2gTp3YfU8P7RXAzaIwP3R02cvq/6kbBpbqDC4H9l5qxKsBptf3JFJ1/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489260; c=relaxed/simple;
	bh=BI4TEobKkCnWm6fjmCNLDXLWLzD9tRE7a0S9TIuMpIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Mv5RXypAahLFJcOm2ieo7ET7EvnfAJXwIkVR6Xx6IKW9iP0ALF04PwQcGYwq3JexKbv45wnsb42vpY60kke2Fzs8vXC1wv/+GXImFXoeDQzA8NuPx0tnPQbtyK9lg7S36DsULY0PkjkGCnaH8Y9SF1iAW+SKAD1AmJN53xuhkgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMtjuhXu; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMtjuhXu"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135de949041so6534829c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489256; x=1780094056; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbuxZ66k165gjxfcqkOHiRnswir15qirhXLxfhhwE3Q=;
        b=IMtjuhXus0EGHkY2YWcbrK2oGyFNpquF9u+9fqHZANa7aodFFIg86MZunmoHAdCZJi
         qInPZCDESCh3dDycIgKcm3w4JypWnkhuqwTdqfLD70TfE2zb+Gj/BL6JvDTojBQjAu9n
         KrUb5ujRGU1v/dDXv3Xi1xT2iUDXX7bI525/ACfBiYj0Bzq91Y+D2HtyRd91rMTIVcDt
         yAWCjqy9BZt5D3pti+WRkRzoaK8gKVUTWvCyL+fkr+Vq4c0fAKsWuGIL6WdxZHSf6nIe
         Jyh2qk6h62zHNilnUOLGA+BTnoOZM68jQHNaMGD7VWwm81o2SZEl+aaDZsMEFcVVQ8Ug
         RETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489256; x=1780094056;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbuxZ66k165gjxfcqkOHiRnswir15qirhXLxfhhwE3Q=;
        b=YZXDJtzltIVV+nP7IxN+6KI0G6pBud7XE5kgNNEYQcW21Y+6k7+XtQGj0nz49MHnmk
         JYNWDJ6BOhklnymBlUYh1llAZ0VN1pJ1ssmH8nrphWtfFb8LGt0Il/boSzosf9/SiYp5
         VOP2dWKOiKrtPS1X35mgO3YQ45s19X7HmqaR09oe9ZFiwe3q7PbrzWhjSm9QEY6q6/YJ
         Pw7WVoxAPZIqiP7X3sscNgALRyOJwjcLLpmKNNaYZLaFak2wEvYKBDxK/loVXaPet3iE
         vQKHbndOTXAcWHYVDasMwn47+YlxKKTjvfink7f09OA82vAgFG/2oX2eT8mj9khtVEu7
         e2qA==
X-Forwarded-Encrypted: i=1; AFNElJ+Xe7yLBHIvoqLhCckddbTIPWZgGWq4VP8tfaz4FUyepe/JAthbcxq19jfzu93W0x119ohv1vGnVA0kox4elj+J@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSuO/pI6caTCZCEg/262o7DwfGS+VNq9plNVxvblFLQ4u4LEy
	d2sqXipB6rzhAEgKr8u5rSGKf/wexHQGt3NITl6ecx624JNlJWZ/ptRyC8/wE1WhKu1pMF/RDVP
	lCh59UOEZXw==
X-Received: from dlbsn12.prod.google.com ([2002:a05:7022:b90c:b0:135:cac1:fe63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6197:b0:128:d375:f1d4
 with SMTP id a92af1059eb24-1365fb403admr2032094c88.28.1779489255446; Fri, 22
 May 2026 15:34:15 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:34 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-7-irogers@google.com>
Subject: [RFC PATCH v1 06/14] perf stat: Extend STD output linter to test
 metric-only checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run
the metric-only check under the --new print flag:

  - check_metric_only

This guarantees that standard console metric-only outputs produced by
the decoupled printing callbacks are formally validated by the test linter.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+std_output.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index e4e8e4238ae0..b48f0ebe2921 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -137,6 +137,7 @@ then
 	check_per_cache_instance "STD (New API)" "$perf_cmd"
 	check_per_cluster "STD (New API)" "$perf_cmd"
 fi
+check_metric_only "STD (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

