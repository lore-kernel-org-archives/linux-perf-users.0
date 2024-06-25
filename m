Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971831802D7
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336424; cv=none; b=c1+ZwrW/UzGGJtV20jEpTsRvy0U9M0oYQE3+rm9aTrsiG1vJbrj17U7daLi4nj8buBxPz/GZ47dJh+F/V+L4unNOdXsAg9QwZy+QWCwFenTxjgGdBvHVMveWOPuYhToZYl/7p6NFwH/3Tn8ZxD+moLnGK8ftDFgNhOW3IwucUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336424; c=relaxed/simple;
	bh=vLAWwP6pxeZ3+8l+944tuEizrGnbW644ZT2RUZBRZLw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EAJfylDUtVMyzzFKxWJ/rdswvDOn65y6bht/KFOJdbEJ9nOoxFb4nzdgndU2DFW0Z3G5IJ8/HBA/0L/6iUI4cVKrwhJX68vwFVqkICmMpc33F110iSRoB8t2UJEbg/6Bt7yEz4y470uGvdNP7FtAazeKAeSTfGAC/6eWYFpowTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFL1a92B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kFL1a92B"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02f2c852f3so8412375276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336422; x=1719941222; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=kFL1a92BmfFIC3sSGyyUXcAqMcEV/c0UlacstSrUylxpWamXRjaid9ZPai8ZugiWS6
         Ip6aWESYF3CS1VZgneuCizuT5qn427zdiCu1YGAplFIgUWiJws9jTLmIjQljc6HCm9nD
         mVUAeUmM/gtuipM0W8R+V3J23CEk5PmJKuUWKC7tIT+Y2Rwu0N3bk1IlZsIB1J7/UtbS
         wmbHWonYfyaB6RlCHmh5z7Bwgpcts4a03DhKKnvNmX8DXd3t1Que250PGgii6YZiAuET
         Ht7DH++PdS19SUNYt9P+DFRy6qpbyPcR3QDnN8iNPcT+O7PjRGVY0DK7qVb1J5p+zYCH
         51RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336422; x=1719941222;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=syc8A6uZsaExNmJlPzdkyJ7+fwhp0yYKL9Nsuw6SwIhrxRojAcFxWMEhZVdSu+2ScW
         OEc4k6ZBdt7K745Gb91vJsEeYCPCMY+lIZpPERHxv+2gULsmxeEDQEtOJSi7QpzmoQ7N
         G+aDHbrndamdPuC7UUio8qyL59WIGKGP6kc7M3n3gGMrDyMYq1zMDme+qWVrsnLYeCdw
         GVTRmFeCqTpgEuFL4g3MDxK3n0x/s4Am0SWM9Zuih85xWEBBkDuIZV+NNkTnB78ZL7av
         87aL+hF8PAnLBkKh6F8eyTlw1jK+VOsBiy9prDFlqAGpxtnnav2E+ID7dcXsIcBie65G
         oSzw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4YLggwcJMKGRrNQLPUiSFQlYbACMg9Qtp0B6QG3J0fppaeeyICsXQbKg/CNjtA6Cl4Kg6co04oWcSDAgUBXk+IoZV1gSR62LaAPRlFEGZg==
X-Gm-Message-State: AOJu0Yyo+2za7Z1r4nR7QP0Y3dRFqh7EKMFhnBARmB0WQDVGYU6n0hJs
	KDoGZdfrlVI9fNbfVve82MQgm2SxOy4NUjESG3n+NWxG8H7/eBLKBEUeYhgI6kFGuAx5HGb1sBh
	8GjoqYA==
X-Google-Smtp-Source: AGHT+IEIJrvS8Di9GHrS7HY7MQGBt42o3442HpJrxb6gkWIG5aRlpvERcLbaC9Aj1Jog8BdPYhFCbRMarycP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8e:b0:dfb:b4e:407a with SMTP id
 3f1490d57ef6-e03040c112cmr445932276.9.1719336422541; Tue, 25 Jun 2024
 10:27:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:26:00 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 23/26] perf test event_update: Ensure tools is initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure tool is initialized to avoid lazy initialization pattern so
that more uses of struct perf_tool can be made const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index fdecad920f59..d6b4ce3ef4ee 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -103,6 +103,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update scale",
 			!perf_event__synthesize_event_update_scale(NULL, evsel, process_event_scale));
 
+	perf_tool__init(&tmp.tool, /*ordered_events=*/false);
 	tmp.name = evsel__name(evsel);
 
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
-- 
2.45.2.741.gdbec12cfda-goog

