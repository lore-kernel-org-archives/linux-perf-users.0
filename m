Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9531AD3F5
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625640; cv=none; b=HSKzpmP/U/45o+RNyDq4TZ9Wht1pGWkKcVebKIzUmlKQKeAIMKw25/C/M1EechfAUDm/FPutwqYGjAkx79dCp4RbaWf0roVawVntGOdoZliY0kiLL9G7bZQYIFiAWYpUatu5DwzmvBRwY/7XkesqKhPyreLsvIK0v0L/RD3cMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625640; c=relaxed/simple;
	bh=Dp15DIVEEmSIdD9NNVgWjs1O/f/At8X6WEz0SMIxKZY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=NYlxAF0qIGo5GLA8lvDDOYxzk9Qo8tW1wY1Prn7k5nTvg99ssxNDSYmzftpHLNQt8GjZWbU+skyA5BjTjcyisN3yFa2N5b5XODXrupSQI+YD38YxpXsvoJJUeirzb1NyhMKzIbJ+C2XIq1hD5w2GjULc4FkOqG71Mhc3wqONcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YI8NIcXX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YI8NIcXX"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3810bac8a7so1960324276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731625638; x=1732230438; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ll/vUW8S45nGRGrDIOMcD0GkJeApUvNMCuJ2LReRko=;
        b=YI8NIcXXRnD6H8gtDf7YKoBIMSn8+p5vvd4wSrv1z+2rE9PA3+Sr0zqkK/zlN8WjiW
         RwmmkKnvGW3qxCE6Zel6H9Qx7L1hjp4mXwNRvOk8L/6Ue3kJsojxuwTr3T6A3OsEnmSi
         PDRjWea5WJGb7KvSK6WG5ambN7vFn+Y1VG2D0tnxf/aK9OCNIPO1GW/kwU6UxyHcZu3S
         w798pOBoVZ94d45AD5hGQdBafYzBwad4xevb4SM3/AszeJVZhqmLzxM3RIImh7YEJsXL
         UNkG6BkDYaFMxV4fuOutrKIov/qRAcT0haNZ/xLMkSJk+HLUJ5BIIdBwCNFC17UgkYZk
         MB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625638; x=1732230438;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ll/vUW8S45nGRGrDIOMcD0GkJeApUvNMCuJ2LReRko=;
        b=ccK2UhWc0/Ft5v/eRnYZDVDFDGsczvQNbux8BbMR2Zf04fMvb4jcOC1XLTucRupQ/R
         uXQvblG3jx9NIZe2shmLt2Tl9bzHdsEFFFMpTLYsJKkJpnH65sbsyQMWsO3Qxj6G4dD4
         AQu0DL0nSye28Zk4FpSniOP54+zSXYFtsiKhyKofVWOmDs7UqjnhvcCJOoyPf7by7At5
         o4jYVIG1vYXt+wCueMJJkljTY8fZAg3j+jHcgxUIPkiHeaEIYXT8A2hBpIRpA6PwDmg0
         RRUdO6kqKLVtr9K/YIdufbFWgURiHxcwY7dFHdP0Z+XpveruZfE0Cm2GNw0u9SKjCrYk
         9k0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8+yyFryILQKvZcfzNtzPiPGicYVEIcYF/mm5Vcd82T0noOyTwUh3w/NzQF+kpzvbYGjg1rrsukZN7CdzUP1Lb@vger.kernel.org
X-Gm-Message-State: AOJu0YzJsYNhpGA+wiyrA2jCDvfkYl5zMuITPdjAbJEo0ptJKSJ+Cogo
	C+N1FC71T45t8zVd2QmVOfOgkmGZT54F6L2VBD/f8zvjBuWTXdNaF1kfwJzmk32YQh9UooUKga8
	EbFOjnQ==
X-Google-Smtp-Source: AGHT+IHFF9XsruTHygct2BUmMIVXMOfzIFG3QuYDLL+UaiMJSCi+DbVqlHtkgUqfQV2zEFhqf5nETeSphKtp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7595:be86:b969:ac41])
 (user=irogers job=sendgmr) by 2002:a25:a28e:0:b0:e38:10a7:808e with SMTP id
 3f1490d57ef6-e3825bd1b6dmr10359276.0.1731625638147; Thu, 14 Nov 2024 15:07:18
 -0800 (PST)
Date: Thu, 14 Nov 2024 15:07:10 -0800
Message-Id: <20241114230713.330701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 0/3] Prefer evsel over evsel->core.idx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

James Clark's patches fixing evsel->core.idx [1] reminded me that we
pass the int value around unnecessarily. Passing the evsel avoids
issues if the evlist is reordered but paired with sanitizers we can
also know when something is used when it shouldn't be. These patches
do some initial work reducing the use of evsel->core.idx or reducing
the API to pass evsels and not their interior index.

[1] https://lore.kernel.org/lkml/20241114160450.295844-2-james.clark@linaro.org/

Ian Rogers (3):
  perf stream: Use evsel rather than evsel->idx
  perf values: Use evsel rather than evsel->idx
  perf annotate: Prefer passing evsel to evsel->core.idx

 tools/perf/builtin-diff.c         |   4 +-
 tools/perf/builtin-report.c       |   4 +-
 tools/perf/builtin-top.c          |   4 +-
 tools/perf/ui/browsers/annotate.c |   2 +-
 tools/perf/util/annotate.c        |  32 +++++----
 tools/perf/util/annotate.h        |  20 +++---
 tools/perf/util/stream.c          |   7 +-
 tools/perf/util/stream.h          |  10 +--
 tools/perf/util/values.c          | 106 +++++++++++++-----------------
 tools/perf/util/values.h          |   9 +--
 10 files changed, 90 insertions(+), 108 deletions(-)

-- 
2.47.0.338.g60cca15819-goog

