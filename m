Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695938BF63
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176403; cv=none; b=oxGLd/WPv7mURhSzu9YS+oOz5EHgRN+7JLYtoUx4Vot4yR+Qnp2k/ngbTr3wXWBPqF4ZStkiD3fbRQWaY0vhvSusId+2tvUkhgSCjejFLHPKE04+T8sJjG5bqIB5O1Kk8lTNRKn5YsHqsIgDOhlaDAfiVEv8RiYWb7CM16xCQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176403; c=relaxed/simple;
	bh=QV7teflAaTCw5mXJY+79rE8M7brnuuS42FrYnQ7qeZ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxbVeFWfZwcmY1mcYqtVEuY4TNqj6+ghIoo6akVqCu8VN5+8TqKZeTaJwH/TqbRp8zHXBByivyH/UVGzTcDS13qLLCMpg8Oknbc0nFblWsnmAyRp/khhXZOlT0+kEfUaMWYh55BrFmdIAN89Ijs3YH9u4DmxEHDVQpnspyoBXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cw1pDx7U; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cw1pDx7U"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso2924156a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176400; x=1784781200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s1G5dLctYbcsHMXWYnv46B4pMvQkJnPXkD8MipKrFPU=;
        b=cw1pDx7U8QyyYjdErBhzy8SmqQhM90ho0npT1AfIj2yqU2JZieFoC9vrQcjSlPv7wE
         xXbjkBZxXwDgNpZjemcRd1rsTvIRC1/K27zvWPMLDboHYgSOzC9rS5hupecSgLJnYOH1
         X9o7WA9Fg42uA2pziVI9yGgz9WrYRrUePBgGe1QMMn+JRvzwv0kLHML1oAkc/CZbrZJr
         Md382/a5DQQCLf25qXtzmuXsscfHEMb9RXkik5NV5RI1xGGm+W39H81Iy9WodgwVSRzm
         gCSJ1PeiJtgz7/hDWtsZlcANKsxDj+7X6mydmYd2q1LwBK0ZIye4lsHm9S6imoEcv+gj
         hGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176400; x=1784781200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s1G5dLctYbcsHMXWYnv46B4pMvQkJnPXkD8MipKrFPU=;
        b=Szot+Cm7lrePN04t1efN8FG8scmMGj9BL1S5OxfOgKVLM/tmdnc3PlO652NdXur/wA
         SweTH9xwOODzQnXVNb9VySCtH9f6MLtOtIL2glx/UEsuFXDBXrHQcL9hRWq2s8Xm0aB0
         oEVrYdCCTwObP6ZWnKpKxmT0aLm8UtTI/jGxzdhvDJBJy7pUy+a7oLDK7ROctpBOi8r1
         dAYszxbabm4ybAPh/he7vaNoZPnne3Uc9WLprJBKwp7H0vBsIpOEfTiS8Bdcwu3y4ePg
         AnVwBOEZUuGcDpxu1m8U+6EeehArAXPcrDWXTV6Sjz2XDc0+QPQWtLQZN1+XlP1Gn4Mh
         eksA==
X-Forwarded-Encrypted: i=1; AHgh+RqhIivjgl1n2qIeLgYYoTxdGHezUMY9FcmSHmXH0aTotVgeTvhYl3OWrPvKNR54p9tz0Ewb1ZbPviOBL0pSDEvo@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCAClousKNnX8DBPeouQi2fFRapZtfAKqJZhj3qU3eHOGdmQh
	pHpdmYNp/82CvvAvrE6mRPiQkaGsIP49O9JAu2WhFSstKRwAtyoCWkJRNxr1FXh01WugB3DfS5O
	Wh+m79+awrw==
X-Received: from dybb11.prod.google.com ([2002:a05:693c:608b:b0:313:f3ec:ae85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224a:b0:37f:b0a9:1a68
 with SMTP id 98e67ed59e1d1-38dc782c68emr17741391a91.7.1784176399347; Wed, 15
 Jul 2026 21:33:19 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:21 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-13-irogers@google.com>
Subject: [PATCH v3 12/14] perf stat: Extend JSON output linter to test
 advanced PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run the
advanced hardware PMU, topology-aware aggregation, and metric-only JSON
checks a second time under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that JSON outputs produced by the decoupled streaming
printing callbacks are verified and structurally valid under advanced
topology-aware modes and metric-only JSON row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+json_output.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 8168b861ade7..d18cac5dcff1 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -249,7 +249,10 @@ then
 	check_per_core
 	check_per_die
 	check_per_socket
+	check_per_cache_instance
+	check_per_cluster
 fi
+check_metric_only
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

