Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FD388873
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185410; cv=none; b=LClj4aQje5bPCBuACc4P9MeQ+YnTH7vhjR9ajuWztlUyvM9rMPuw/rNKrJt1d3Y24R5nDcnalUij1GFXRrv6DspDTGrB4kIFBdlKYTDv32yRm2PvpZPIIKpSnM2lFxeELqiYTj+u+JOe98jB99QAPPug6j38iN8tO8tpNZxSWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185410; c=relaxed/simple;
	bh=lIByhbsGDdTBHg6SoB2Lw1YUVdW86WkDZiUTwZ3OgmM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ll4mj+Jta9zZTawpginYFL+1hnEKWHmOaaUGAvccjGiMP7qam4GYibezAtyzGMYWHM+Dd/S6zEVOQ69P2BnWA/wSKbJn4yCgfUV/OrdbDTYrFhS1//Jf19Ux20i0RQYTWcwoU6HIjKK5hJWyWkPT7SNR+ZBtJ7IRO5t9dZGpXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obbXuh52; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obbXuh52"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ca7c1e22995so8663357a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185408; x=1784790208; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c66jClBPGZu3ebFTqfTvjA1RhAEN8+/bEpFQ2FJgp9g=;
        b=obbXuh52qRi5MBDjz28P7OQcIbeYMWkEapA3f6PBohi0XUajmPPZPYnPpleBlpHshZ
         8DA+XzNqbRCWBMyBKwq3tdTHMymWYekiPzVprFjOoa/vmMNA6099vthoaBotWOAYRCLn
         3RbjBvavk0NoddIGm7DPagS4j52iWPi6YEFfCxXRqdw0xGvdiPJby0gRPvg8P3pZSAJK
         +sbff3d2YHXj3wLM9JlKS1ZdDAAPc6hSUrZVzhS25uH07Pz+D3Bl2N1kto7XX3YWF/nk
         ioWIPo5n4MxlbOezg/bOFlszvw5PnFPAWb5YKPh9QAGkyJaZPSkQMa77ZrYiY70ZFh0y
         cutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185408; x=1784790208;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c66jClBPGZu3ebFTqfTvjA1RhAEN8+/bEpFQ2FJgp9g=;
        b=sDUyHK1iY012WyGdz8djWBVfo9VMMG8Dx4BS5ueBv7HFKm3alj5MDoWg5RpKxzNn7Y
         tSmSBhlcqejbYt6IPgZFa79h97WZ3jeA0mxXspORkqYVs5f6XHSJwFGGtcvMnG3ZZtaq
         UEoFum3dfRXV46aR2kneZuNPVy4yPxBPvhvBphZ+2HGfL6qT/ELmqv7hf4llALv10cv/
         XVNoAU9+CHJi4vyc+1UmMvp9ybuctk5QXc8OgnGAtXU5UV1TH604FLbGb/VvSo3zOHdA
         lTLupha/KQpPBno6XiaP4zd+pAF7EglwgIDrCypJ/wu6/EholUEzYh0D7QB1qKuqnQg4
         010g==
X-Forwarded-Encrypted: i=1; AHgh+RoHWZvHlLh5Nts9TPH+Z/ForkG4J4Y3+H4nrMj/JalbIMq6XCJRkZhsWQFIxBZdmtzB40gVvKOA2B/KtYfiqv/5@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHDwyADuTVwl31ZZmLaBfL42EEelwHgrbfN3V3DP4nKHuCFrm
	RdmdFx71dw/xCylu/tE905cENhRqSClrFPWgfW8IXxZooZY6CkaOJ0VathhCcJ6YA6UrTvKDth1
	g76WtZLZXwA==
X-Received: from dlnn30.prod.google.com ([2002:a05:7022:619e:b0:13b:a0a0:3b98])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4cc5:b0:3c0:9c19:65a7
 with SMTP id adf61e73a8af0-3c36c4447camr6657730637.63.1784185407979; Thu, 16
 Jul 2026 00:03:27 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:57 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-9-irogers@google.com>
Subject: [PATCH v4 08/14] perf stat: Extend CSV output linter to test core
 aggregation checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run all
basic and core aggregation linter checks a second time under the --new
CSV print flag:

  - check_no_args
  - check_system_wide
  - check_interval
  - check_event
  - check_per_thread
  - check_per_node
  - check_system_wide_no_aggr
  - check_per_core
  - check_per_socket
  - check_per_die

This guarantees that CSV outputs produced by the decoupled printing
engine are formally verified and column-valid across standard and
interval modes.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index cd6fff597091..e4153a03d716 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -88,5 +88,21 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+# New API CSV checks
+perf_cmd="--new -x$csv_sep -o ${stat_output}"
+check_no_args "CSV (New API)" "$perf_cmd"
+check_system_wide "CSV (New API)" "$perf_cmd"
+check_interval "CSV (New API)" "$perf_cmd"
+check_event "CSV (New API)" "$perf_cmd"
+check_per_thread "CSV (New API)" "$perf_cmd"
+check_per_node "CSV (New API)" "$perf_cmd"
+if [ $skip_test -ne 1 ]
+then
+	check_system_wide_no_aggr "CSV (New API)" "$perf_cmd"
+	check_per_core "CSV (New API)" "$perf_cmd"
+	check_per_die "CSV (New API)" "$perf_cmd"
+	check_per_socket "CSV (New API)" "$perf_cmd"
+fi
+
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

