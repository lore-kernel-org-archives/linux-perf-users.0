Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F383672AB
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751171; cv=none; b=rTWx518VZPL1zEQ8yh4ARXkp6gdw6hhzaeW4xsd4M8W+4gSNIKJCMLEuBFdGOsBYUFV64rsfzX0eIM+12UnP70BsfW1uURZ07k0Q1PcUBhVnrbimzbwBz9Y1qLSdDKkLpUx4nONH+TBSt+cLyJSuyI8XhWhsyfywpMlj5MhfwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751171; c=relaxed/simple;
	bh=qIOP2PLMSCjaI+oZ1XK3BnopPxnw5s3AUOSP0CpPkUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erIGB8B0j8Jhmf9+Mfde8UOZfS/6WpioOGNCbejS6oR7I5iMpWTbY0ekXZI/43Vu91Q4VlTDrT9/k01nxTpe3gVR5aZkUlKNzUEOnDeWeybdFwselZScaSlCW4A6K95ywnJy5uYW1+CwA8blzKaebbGdoLSgzXaoB86oX3eKnJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cLpRUMhd; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cLpRUMhd"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304448ab58cso1403661eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751169; x=1780355969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOgBhfkhz9Rl+cCIvRmHfpLylwK0trKuV+4bVEafs/0=;
        b=cLpRUMhdxM0YCKUtpcRf3lvlDOuQ6yjzg/yhTQgB8p2s4m2HJGIuitZQHUi2rD6MQv
         gCY9EtIS1TcU/MfOlLpk2EvU16H+l5HE0toimOFpbRRokWi31CgU2r3F0XS3KvnjEXBb
         UhLCh5cSUwe5LZyLHHn0XZggVYHXPKWbB2jTsVqIlMZWTLWJ5qxSr1JW9vsguF0+Ag4G
         nT4bejOWE72UNnSE019zL5kskM0wpvoRMHd8EXQQ90039/uGyXTYhdXeGILjQF+b8BAs
         wheL8vTk69vv+yzdduqd6iTbbQffRPIHnTnk3a67G7qG7PIdd8Dnptj7KwyQY3lH4wNt
         bgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751169; x=1780355969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOgBhfkhz9Rl+cCIvRmHfpLylwK0trKuV+4bVEafs/0=;
        b=SgpT7VNLrBuxEybOLogH3k+KMC2/V1z5ymy6ZszDxcMKagD6QoxmjCvspPhUYb5BYl
         EYSv4oTXHlI9XqRLjGzvU5kcL5J8j0kdmn1FG1PdpHSiWZN0eO+kvXpIxL08F+EprYuM
         XUlV6Xsdjccxa6BeDPWt6xis9YQE85uKDsDNWqbTe5T/BO4bS1GckPZm21j74+xTPa3S
         o8zwXbR3sX4k/7nHsn0hfNeyDCtmwtNJrFyPcsJx5p5eDnErdzZti9b2qhPNNCrhAhn4
         QdxDhtaWRSVyklxnvre5MrnZkDR0EnPYy1gAvm3uKdgdCqhNgl/LN+dfloDrbJQJoNdd
         BjVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xh7ZidTQIxMH5vUft8VFMxyDLJfsddqMfQzLiV6M93dxf6TVTiaH+hVh7ojN3TaZu0Uo5gTQVkJ9e9K7JMNQv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyizp9sdwCsI6hOtXjEJjLePhCcnsQ2XR/TaCITu0T6KD0q2eQZ
	c83m/XDqiAABS+FOZ9CXIjrhrP8mHyXV+Q3lKm/FmDQogxmGHIogBQOiHjSR/7wfhTkaqJj8qkg
	6o4gCzBBGGw==
X-Received: from dybsc18.prod.google.com ([2002:a05:7301:4b12:b0:2df:c53c:24a5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6589:b0:2ed:e17:d50c
 with SMTP id 5a478bee46e88-304491fb381mr7595907eec.31.1779751168980; Mon, 25
 May 2026 16:19:28 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:55 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-10-irogers@google.com>
Subject: [RFC PATCH v2 09/14] perf stat: Extend CSV output linter to test
 advanced PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run
the advanced hardware PMU, topology-aware aggregation, and metric-only
checks a second time under the --new CSV print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that CSV outputs produced by the decoupled printing callbacks
are verified and column-valid under advanced aggregation modes and metric-only
CSV row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/tests/shell/stat+csv_output.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index e4153a03d716..c48d9e2b6429 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -102,7 +102,10 @@ then
 	check_per_core "CSV (New API)" "$perf_cmd"
 	check_per_die "CSV (New API)" "$perf_cmd"
 	check_per_socket "CSV (New API)" "$perf_cmd"
+	check_per_cache_instance "CSV (New API)" "$perf_cmd"
+	check_per_cluster "CSV (New API)" "$perf_cmd"
 fi
+check_metric_only "CSV (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

