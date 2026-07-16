Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AE6386579
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176386; cv=none; b=HBMCu3sK8YJEE1zoPNZH/c2n5NAfkAY5XxxZWlC788j9xW2v5f5xzJwW+oBBloSxvzd4bNakwoUQvkF/jrWwVgj5L1KJEALa7/ELXtwthAmt3FS9h3eobcLfsjlsXm+n1x78s5HvYiNa49Im2mkjZCzcFqOZkNh15140Kd0wcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176386; c=relaxed/simple;
	bh=+/jde5xJEcvJ9w9A9h5wWVZW2A/MnCJXHnhVGKQdU6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKETGmTGeMn8TfXoVHpLA/YguisgmMIlGhqPih076sREiMBhJgjpdDo5zrwa30CodEdkckuLqkQbCq+KZm+PD5Nvlxl0BSkq/1SEUrnrGtC40WQnOY3wJJVjLGBCEZBHtn+shLTLnN1ftYOZ5tKFJ/msUojS/8y6DoN50XyupW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0ewmFB0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0ewmFB0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-384419c6c74so8056174a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176384; x=1784781184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7F66QJIywv4Z3XOH3MXKYaS2H77ys6CAb27lLyQhbHk=;
        b=O0ewmFB0PGdvO8FfX1Z4JU1L+8JgmTZK/yrjsyrxt5VtjXaJewKKFUFVjUPP/XNBDx
         Edg9cKIuDKOy0/A65X84ApEpxMtZ2JAcC7A+z7NpBoEXzgrsBhGTRQwH1TuZB3uICWWl
         uXNLv8dpm/GcoQ3AivUhXzUY7q/akPF7rnwXSJlav2kdoBJ6/7hhdtBTrsXpxmwdBUD1
         u5tEdT1yjZ2WAAN+jFBSFfxERpWEvKgZSo0/fTkzXJmJbifKKm/O7F/QbUXzSywZeok+
         L7zLmmUHuly3zr6wGChAJnONjczem9oe0upiN11gBz64+ucTAc1xMfU2gIs4UTDCveBa
         EKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176384; x=1784781184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7F66QJIywv4Z3XOH3MXKYaS2H77ys6CAb27lLyQhbHk=;
        b=JwRYGkqV9r+XGPQbkLoSbhVmaEbH+CXzWXMi5IKc1C0xdQAYNXInZiGUM/1IyS39i6
         XoRz+eV9Q05+bdBqRsfki7Z0K9P8DNbw4XRirqUMPABIFqafmcZ3RSdp06Oq+5pMooJu
         kHEkwOSWDbDVHD7rEcW50HBaiWG8JORSO+LxZyqS0+b3Y93u3RGbDKVPJnbSH00Ez9BH
         iIkA2hxOJGith1k8Ga/q/ybuI+WTmK320RBm002CrMh02RMWTYHzLJJd3lcYdSvTvHd7
         p7giQmOBxmYxmEVpcpsJm2I9r40jvyNcKbhN1fG1MLKpZV03vJzlGZNt6utiy6WKWwo3
         WgHg==
X-Forwarded-Encrypted: i=1; AHgh+RreEaxIBMxMO2BwX2od1fCYwhik5TCncEMVejmJarkCzN50rudW/bfELCZ3oKQ/OK23mz6dIW+8vaTeZw7kHtg3@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMIBbZ9Urb6YFmPw+NscssXCVOlWLWq9IpJJ8G1UtL0iqwP4x
	DSkp1uhVrzwIjsz5N93vyB56f0isc8UnrMAFcW3LJrwOo2+ZonNaj5RDSmIMg9N39UFCYekn23B
	wRdeZqScRqw==
X-Received: from dybqh10.prod.google.com ([2002:a05:7301:624a:b0:313:c814:320f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d8d:b0:37f:9ce1:cdaf
 with SMTP id 98e67ed59e1d1-38e2a0a31f4mr4986135a91.29.1784176384005; Wed, 15
 Jul 2026 21:33:04 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:13 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-5-irogers@google.com>
Subject: [PATCH v3 04/14] perf stat: Extend STD output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run all
standard CPU and thread aggregation checks under the --new print flag:

  - check_system_wide
  - check_system_wide_no_aggr
  - check_interval
  - check_per_thread
  - check_per_node
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that standard console outputs produced by the decoupled
printing engine are verified across all core CPU-aggregation modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 233e0a50eb33..8dee005a7281 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -121,6 +121,17 @@ fi
 # New API basic checks
 perf_cmd="--new -o ${stat_output}"
 check_no_args "STD (New API)" "$perf_cmd"
+check_system_wide "STD (New API)" "$perf_cmd"
+check_interval "STD (New API)" "$perf_cmd"
+check_per_thread "STD (New API)" "$perf_cmd"
+check_per_node "STD (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "STD (New API)" "$perf_cmd"
+	check_per_core "STD (New API)" "$perf_cmd"
+	check_per_die "STD (New API)" "$perf_cmd"
+	check_per_socket "STD (New API)" "$perf_cmd"
+fi
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

