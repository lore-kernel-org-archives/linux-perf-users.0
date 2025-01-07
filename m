Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A3193402
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287317; cv=none; b=Z937Kmbb0518RbvACEUSWIZeNPatkh9IYD4n1gPzJcYdVDIeGScKdDmBgSqeOwj9RQ9iwtaH3Zo0YMntZqpIL06Vpalx1/gABlaaQWn39HcPDWsOze1EE5YSw82hr0oSZBKDl2zXub2KZj2bNa/+X6NtIj3xigT7filmuRqUrgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287317; c=relaxed/simple;
	bh=9jvc9GDV3W+dweY7TdLDbWmVYXOkn9WOHTc+oaGGgus=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=hltjt464eeYquFewFvph5PV+fp9SLrQVbO0lS0qSrYdo46bqDLwL8mYHzHUNWnLtgdY99s+KE7ODjLk3cL5SONvGe/1LCUNvvSwpxVkrtG/sVBF8AAPFAnU05V/oU5f0NmaVqqtgOoazEMLUWryQ1jS7Kyha45phaDVxx5oPDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gB7gKhs0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gB7gKhs0"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549e7072fbso7253749276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736287315; x=1736892115; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7vgayqfXgFHT4HDNJYcuAoqPaG2RbiHbjf0gqSgBfZg=;
        b=gB7gKhs0jafIsZ94ecU8WghQilfhp10IjxoAd+bv/o/Nzsfl6j7uj7ufpgbulO+u1y
         t0kyIYF8IxNoVIhcyPTuR4+CGzDYujZQ4bl5P6hhZQEfIGxRln6b47N/AsqMh8BhdE2A
         WgTNZZkNFNSpKit3x0qwtRm2t/zHwq6gX4n9QovXaDUFCvlCcp7b6GrBcaq6ThLjMf1D
         Q7og6GBfMItGJjHOv1WVUxtRXrvP0Iw6rxVKYkLzY5o4fiKgXmhrU78ve+e0LHGD7NMZ
         LHuNZHzDaDOS65dZFjhHNFSDUNPlB5fEyKdTfWKKPUyfBd3uBS0SmtCq7Weft5pbAH5j
         4gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287315; x=1736892115;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7vgayqfXgFHT4HDNJYcuAoqPaG2RbiHbjf0gqSgBfZg=;
        b=hmN7bODFddfI9rcwn5PHwa4SozfIcecyUYOwk4N5FQm+exzpZKw0unhAmZmgQwHj7/
         7p1wgR9IrjiaK0b9/qyMYr/5TZR+moWD4QXjQ9u1TIXMyYgK2WTA8AopPR1a6GHjuEXm
         atF1bZVn9JlPlwnwn4Q2TNLwkuhA+P/VmpdpFTDLs0U9hnbPuu9RzboCstGl1Y/plniZ
         HSGXU9Tv0Ylh+56FrWDs8E+lj7L8fg+tJAod0Hlv811kXsaPJCzVZRqMbuhSm/hioUZw
         dE7uZCO1psl5HxBfLi8+7QQYFkVTqsQPQUBuAjDNIGLWJYthz82AKIOsWDEu5Y6bV/OE
         0IIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdmeqqBWb/yPBTagYdG8nXXwT0bukm36/7MvALkLeW6CE4k7pzhSUgM+GAxz49R74yGtD5KQ658CfMu7dzDfUJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2OoRQ0NfrVtGwGldHFPru3PVQ8dTb8JT2lMCo9lpF+2wn9mp
	jHUvnfdFTS5OnSOLiuJ2qZwSVc9qnXDXipTdsFFCk63U2tJExOp23H+cRXnRNvIYN+dKYuTzgL9
	IjWY/SA==
X-Google-Smtp-Source: AGHT+IFtKtch5HOq4Hj0/ermFhmzxXbvBa0p1xo2eW9bhpu16N/EzL1JoZU9fJ00I5z/VHVFhyfPvGiaaZf+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a25:b10b:0:b0:e39:94b9:99c1 with SMTP id
 3f1490d57ef6-e54edf44619mr1049276.2.1736287315335; Tue, 07 Jan 2025 14:01:55
 -0800 (PST)
Date: Tue,  7 Jan 2025 14:01:49 -0800
Message-Id: <20250107220152.1213959-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 0/3] Add a runs-per-test flag
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the v1 patch Kan and I noted cleanup that would make the code
cleaner and less indented:
https://lore.kernel.org/lkml/20241109160219.49976-1-irogers@google.com/
Add patches doing some builtin-test.c cleanup and then add the
runs-per-test flag.

Ian Rogers (3):
  perf test: Rename functions and variables for better clarity
  perf test: Send list output to stdout rather than stderr
  perf test: Add a runs-per-test flag

 tools/perf/tests/builtin-test.c | 223 +++++++++++++++-----------------
 1 file changed, 107 insertions(+), 116 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

