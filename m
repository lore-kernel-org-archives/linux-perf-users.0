Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B395380FCE
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779084755; cv=none; b=qjEyDqEdpgFC5FMOc2yjX8SFPecHM8rQKcQYr06qz5gPgebiCE7OEDIgE7667HbDSNgWohXM/posPSRhRkkh25neDOyK+OsL0vDyz21/wJf4YO0UGdIR3WpvX5mZER92GkHZfTyctxLJ8ZT8PpS+R7es7V9BupUhJSRsh87z3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779084755; c=relaxed/simple;
	bh=zqPX2xXsaBdF1D2OQcUu/6Wi3jnch+KGMZaEohm6g6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3rIv1fOe3mWTI7NbW5qiKkoGK/NiI6xbkp3VGBCnSGj7DVbxvPFTL03L0/jQscosTMBXv95YHKLmu6JqMMEBNHdHjpOIZwCTQRFjWMK6yzZ7IG4q6OncjfTbo9hNwMZiXTuVaDjMyh/AKzFKd73Nn4pb2D7h67gt5DIUYqIdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvwLKvmh; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvwLKvmh"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc3d81736so1196411c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779084752; x=1779689552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=svrBpcf/Ip/LN+2rU1He1WB/MKRBGxKYLI2XlJwS7MM=;
        b=kvwLKvmh7gdQTC+vyTXsfAxPiHB0q1JA71uzuZgHuG1gswRqaOFdhH7OTyy8XLB963
         Zu9XO3owq+b3dUPDGraTdKvA5YtKju1F2HdKGglQKtmlp2X6h3ijqKSN9vdF+cXtaR6h
         tqKsFaAriMqlmeX6UD95i1EtCrtpE8USxx5Y9dGwA3TPxMEDSAFC5a/EW7cz8yRk45pF
         8s72ItElcXAgyf848LVoDJDR8mNCz5Wix5ASd9zDXOdfrM4kwwteYKDFnQeCx8jJN4jq
         QMKZlcEQQklYG1/oDs97zM4e87C1gEjM3nmP6iJS8kNVq1S0uqL0FGNrvncU+fwbbmvU
         3gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779084752; x=1779689552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svrBpcf/Ip/LN+2rU1He1WB/MKRBGxKYLI2XlJwS7MM=;
        b=k/B5F05z34SAHIdbNpTzo4xr8PoGXA3qbVuYFleh7f6YiVjnfPdUmvENh3nU9wAMuC
         XotxOVk+mkQAx6HYbGgS0c67+i29/82A4k1xYVfQuvYAIdLf8HRrl9QKUSs9qlsW5FZz
         HT+/Qix7SX/+7UKvU8gtDR7YL57enF+/wx44mF3PD7kj63fvRye8ZW6gsRt2HkviAlqH
         yljqv6enzuyoGgGhAaadk8KDLX7jgERNwhlmWJZThM71feZyPLhBSnPuUY3agnU8AXPM
         7P8iRCa9zBqGCJqyZkyWykj0cFPUrm4rsNgCLQFf+dkdJKKLztIo+FSU/XLga00lT2Th
         k9cw==
X-Forwarded-Encrypted: i=1; AFNElJ9CT1p389CnEkZR9oTVmBmMFg5+J79bxCVstUIUseHqvIo80wTXz3CD/qNRN/WpWlm2b/xptBHx62uSrpdUtfy6@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVl4fpaMNY4d1y39MQzhw0eJ92PdzxPR8Fyc3WmTYgiXhfdHg
	1zznZOOazwYT6jpWxPnoWMyJoUWeSzSFF7DUBM9ndAsn8gfItwMtqqXmYzH2GBYSXN89n1iU3Ma
	r3DbiS+Z0nQ==
X-Received: from dlbrl26.prod.google.com ([2002:a05:7022:f51a:b0:12c:912f:7ce9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff42:b0:133:3bb1:8d40
 with SMTP id a92af1059eb24-1350451ace4mr5109989c88.15.1779084751549; Sun, 17
 May 2026 23:12:31 -0700 (PDT)
Date: Sun, 17 May 2026 23:12:26 -0700
In-Reply-To: <20260429181136.2712655-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429181136.2712655-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518061228.2582860-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf inject intel-PT LBR/brstack synthesis fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

An intel-pt trace can be turned into LBR events either in perf script
or perf inject with the --itrace=L option. With perf inject the
generated perf.data file failed to be parsed as the sample events were
out of sync with their perf_event_attr. A range of fixes were
required.

This patch was separated from a large perf script refactor that
highlighted the breakage:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

v3:
 - Add missing Fixes: tags on both commits.
 - Refactor perf_event__repipe_attr to avoid in-place modifications on
   read-only mmap buffers, preventing SIGSEGV in file mode and premature
   evsel updates in pipe mode.
 - Use perf_event__synthesize_attr to correctly construct and repipe
   attributes in pipe mode.
 - Replace manual arithmetic in convert_sample_callchain with
   perf_event__sample_event_size to prevent uninitialized memory leaks.
 - Retrieve evsel branch_sample_type dynamically in util/arm-spe.c and
   util/cs-etm.c instead of hardcoding 0, resolving missing hw_idx field
   on synthesized branch stacks.

v2: Response to sashiko fixes for patch 2, Namhyung's acked-by for patch 1.

v1: https://lore.kernel.org/lkml/20260428070328.1880314-1-irogers@google.com/

Ian Rogers (2):
  perf event: Fix size of synthesized sample with branch stacks
  perf inject: Fix itrace branch stack synthesis

 tools/perf/bench/inject-buildid.c  |   9 +-
 tools/perf/builtin-inject.c        | 141 +++++++++++++++++++++++++----
 tools/perf/tests/dlfilter-test.c   |   8 +-
 tools/perf/tests/sample-parsing.c  |   5 +-
 tools/perf/util/arm-spe.c          |  21 ++++-
 tools/perf/util/cs-etm.c           |  23 +++--
 tools/perf/util/intel-bts.c        |   3 +-
 tools/perf/util/intel-pt.c         |  26 ++++--
 tools/perf/util/synthetic-events.c |  25 +++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 216 insertions(+), 51 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

