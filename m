Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E83FCB35
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034927; cv=none; b=oO43MHF2ZoJgE4IjFmm2k7bMBUrrkHT2qoD4gpsCR7bv4VyLH/57cj+fXmOFi/rMGsUU1VqvQDpCATAtGTCTlUQ5MahcKF6DdBmpy36bxq83LWvcd0QhbolzduSMUX8tHi29ve3H2NXMbSqe94c6Ho1mBi/xLHq8eMHKBZuKCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034927; c=relaxed/simple;
	bh=VBRBWOOsTuUZUQAm9Xp4jFDUX44iF/hvvynPgGnEBf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ut0NDIbpa+HD458R2+Wcpv8hr7PKP7AYWrUpOjuy39t/Sbfe+3/gUZHCXd7fS5J4PU16oZLyYUgDgXYyAOp+YsIYCdWnDV3WF2Pv9VN3vyfqp83Up/ENOzTtpJQ4dwlEgI+6R8YRlOr2shXpToFS5tWoKBYQDGHP15Z3Gj5QTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/xzLtZk; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/xzLtZk"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso1557586eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034923; x=1774639723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex7esaiGl8GWNlFO/kP2nPhlftSsne7shuQzPr/LD2Y=;
        b=e/xzLtZku0eGrBwKtTJDqSchrS/s6rMYuSqn+iQV6533wbcFjBsF6DPwfkEKpNHI6f
         HTgMsNLZSHRIinvgsOTt/8judQPaVjoxqfRJKrC7PKy8PGhdkuGsrqXPtIlQcf/20OtW
         B9vT25mSkOPhZqgBe4HS9JkVd9x7JwAjae2a/zuG9K3GLU5V+f2nJzezTUchfdR0m2vp
         sPuUFDHdWxMo2KG+cS/c1NpMu1npq8GLLhcPhLxNIY+mc+uKHJm2J7Rx1yrahmSzh21V
         NzinzxVX3TeBiliT2S347tG9pxzVoRmiU+xtfg7vLaBh/dMhAFA5RHoIUIW62qolHsTO
         jRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034923; x=1774639723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ex7esaiGl8GWNlFO/kP2nPhlftSsne7shuQzPr/LD2Y=;
        b=BIfXPm0IBvp42N9o16zw1PcVaAKM6hXVqfO0Lxt1+wD/cvANTlIFAIsAUrvRffEIJ6
         hfuw6lRc1m1EBzreqiWAvadnDW3KZSxwDDy5a0pTMgdf3HFOSISJ0k09icDrD9/MZ+or
         /jzBXxvuMoRtE1Gofgc/Ltd090MVyLfo8BkxpePKr9colrVYArvmhbeo7RSYfOwBsqYv
         ctzP0/ygLpWJWKTs2Ke299jRZVfDA88ygGnSZHS1l6aTTl+Vseex0uD7hWgpiWDI/P16
         zXuQPbPiXsy6WZ2o3tYGHy8GLODN/BDyENFfPC46XmC7AvAYc9A0RD2ZxRoB+zgRocYQ
         CH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiuvz63twAqTSxWZBpI6mEFpp81fW9vvriwZ24GeMvTlpx5oZalQTh6oH50Kj+hICJzJgwLv9S0oplSr0CMyep@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVauJT0brvZvHi1fNTXSVPP/iEuib4xyPqwidcmfJjmBgVU2t
	RdXey5pZ70hrGrEChhqoUIroJOjS1SmofXr3gwgXb5bF16cm9brMbS8HG5FBpejUGjNjdz1MWPR
	gV3y1mHm/oA==
X-Received: from dycpg9.prod.google.com ([2002:a05:7300:dd09:b0:2c0:f659:16d0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e2cb:b0:2c0:dd99:f11
 with SMTP id 5a478bee46e88-2c1097589e5mr2098853eec.22.1774034922570; Fri, 20
 Mar 2026 12:28:42 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:16 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-15-irogers@google.com>
Subject: [PATCH v4 14/25] perf report: Directly use sample->evsel to avoid
 computing from sample->id
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1051d7b75361..d53aa7a94192 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -793,9 +793,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.959.g497ff81fa9-goog

