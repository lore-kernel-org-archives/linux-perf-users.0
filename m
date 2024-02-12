Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7E47793
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Feb 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764356; cv=none; b=Rxg8EcMBRcpgVOocs8Z1ry4CK6SEdUd126/7Utg/p/sVJIKAxibHxjmGl0SkYknBdBZvOn4yYWPA0S832NHPymAp4+Ca4e79c6oPP56ivH8XMzjCzjVsm42QO8WJj7HRPFIy7r9r8XXjZqFVssmm+mRAioQQHhDOd/GWkqDymWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764356; c=relaxed/simple;
	bh=cEoquvI2Ge+v6/Ow4yXCwb905NVQF3PwLLtFQnXzKG0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=R09PvgKxLF+kDuck2E42pgvpz6CpTfRMXn5ZJUt5ljkPjFa7fo6F9yfAqpdYp1ZmaQ7y/MBPZ/zVMdEb14LC4/JLGEdclJcCDaKLGdYMpALo9JymO3WoQblKzelum6MRw6zsYX6SISzVuBZKyS0zCH7WUJVI9l5P863z2okoHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b3qyvL7h; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3qyvL7h"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso91178276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Feb 2024 10:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707764354; x=1708369154; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQsEsQdYL+F7rq54Mfa+75HgoPY/TwxmW9rhD6V78kU=;
        b=b3qyvL7hKvSiShvVNQaxcvEvKsCZdzosqakFJkI3oZze12klYVVyv1VSYZdXvbJX5I
         1dudKCo/MwdMVTFpmL5z/f491Q2zeNtfWT9NMVTCPbXyzOMRc88lAVsq818iVh/hxC35
         weS46+ZmJKtiHwJ3w+y9jkHGDSMSaQB7prK1g3zumZ3N/eGTh+qHaZsjRKjX3SXFU4dh
         nJL2r3ZK2+U+qKeHKrIqBXYA9oq0Z7M5Toow35y6fOvPMMa48vek2D48ATwjVbnUd4JX
         yu6P0FUgHcvFmVM3WiMI/MSwz/tE8+bmecubIhOekMLWmj08gYf7pLigFLrwO9rt7uKD
         CZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764354; x=1708369154;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQsEsQdYL+F7rq54Mfa+75HgoPY/TwxmW9rhD6V78kU=;
        b=S+tgyhvAiBOnuL+XlbnBJdf5TO0gJ0VaKQCA184JtMnAvUDdTtOe4NXTNytU8bw/+z
         lDcxDKhAGToLq4/6BbH7Qs6W3ivPfiSQ2E08MoTUBfiyPxS2GCxqmGZyAodeOtABItik
         i/KLllMkQsJiYfCP3AmntSzAoItFCPXak4E3s0KgSVQ90GDDb9B2xaIe2itP0/g21zt6
         H9/GzAZeUaOtDRHeZ8H2lu69yB0izHl/Kd3ANxj29iHuS2RoURpBZFRtYMgS/8pp3p6h
         9HN5V5MyBNhq+FxVXaCLdM43gayXzuq4LYgHgVeBBjNmLC/zUQrJJ/tYTVSj8vFFD6L4
         1rOg==
X-Gm-Message-State: AOJu0YzsU5Muj4aej1hkAAottFRozcFUxI23XecZXVcMuhyXmr8yvgNb
	qTGdphUoJBtsdfgZaLFM0ZhHyQnaOfCXnoP/ShTTALoQXnZenrwv3Ao6JNwT+KibG5klf+8QJJU
	hldWDMQ==
X-Google-Smtp-Source: AGHT+IHiKcmNRG+oK564DasQqJu4KLrzYsGTIqh58ndlp5tR6/bM86Cw+35Q8wd8t+rVtSAhwGVk7oS7/43U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:125c:bcda:4fe2:b6e6])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:d2c8:6e50 with SMTP
 id w2-20020a05690210c200b00dc6d2c86e50mr1160978ybu.7.1707764353986; Mon, 12
 Feb 2024 10:59:13 -0800 (PST)
Date: Mon, 12 Feb 2024 10:58:53 -0800
In-Reply-To: <20240212185858.68189-1-irogers@google.com>
Message-Id: <20240212185858.68189-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212185858.68189-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 3/8] perf tests: Avoid fork in perf_has_symbol test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@arm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

perf test -vv Symbols is used to indentify symbols within the perf
binary. Add the -F flag so that the test command doesn't fork the test
before running. This removes a little overhead.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/lib/perf_has_symbol.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
index 5d59c32ae3e7..561c93b75d77 100644
--- a/tools/perf/tests/shell/lib/perf_has_symbol.sh
+++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
@@ -3,7 +3,7 @@
 
 perf_has_symbol()
 {
-	if perf test -vv "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
+	if perf test -vv -F "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
 		echo "perf does have symbol '$1'"
 		return 0
 	fi
-- 
2.43.0.687.g38aa6559b0-goog

