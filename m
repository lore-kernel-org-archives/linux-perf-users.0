Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5191891A8
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448051; cv=none; b=qku8NHL8ryUuO6t7WPW8okTTcu1uwMAN1C32aWzEP9nEj1daE45nBZ2d59zLZejrG3oqpEBC+wLm79lBAGJqthk/7kPZiFekSDJHbK9Z1P9DckZWO3zo6DZvcXNr+0zjYInw3LFWhSw+5NdQcImCyzFanIw3uexkn0LEr5ENIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448051; c=relaxed/simple;
	bh=2KLOLDN2ltenp/y3nNmIs/TniDnGFuyVmNiWx8Qx+Gc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=b+wqPY90WlH8ht8l0YuH9F1nY4GgGpULtBKEf2vb05cNaQKtiKFonrTKSdKpSJTWnYKWwYj06XhKOTKJRlwOskJ31jUW8WfYebvWwF6nIYFUX71IaUIa1oMctzYJ8o9RqGXi+kysn2M4/MNKgLJ19rTeO+7ulzkDLjFRC/T5sEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YcO5uUl1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcO5uUl1"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e53bf9e60e4so2797391276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448049; x=1737052849; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szzYBvdSpFCjfBcHaEOS458kq3uizBXhKhg70WHPmWo=;
        b=YcO5uUl1wKsENzD4gDHvfCdHx3uJ9dH7st0jAJDZOd/4FNqsPsdepLiAfFIwStjJvZ
         ekDuMpvFYnK2DHx1GvsLo6R/qafJh9GJutiaAeXLE9/BZJ9po21jNfXNeFvERs9jHvA3
         q4yNcNwcOw5Eoj9AwUHgqcHGRw1EZSooLoaSoIhzmuV3AD+UsS+KVBHxUGYVT1p/eMu4
         Jn51RjWSo4b9olbilDvcigqFce22tzlEymplEqsJsCgVfH2EqmS0Qe+RTMXDxbu6y2ts
         e5s2ueDkESkY9vR+ltSMuEEFgtAR6iURJ2zFOw2TJVZGuL4lEaOUMrGV1eECcC2Px4IU
         zJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448049; x=1737052849;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szzYBvdSpFCjfBcHaEOS458kq3uizBXhKhg70WHPmWo=;
        b=htXaiwLAoPMxZOuIN6TgqBVJJXnApGqkfrl3eC+eRWnmKVyyVwAx/OZRgyDKOnM5LR
         nuCmHDYSHN5lPkXcOpWiS3YYf0zW1p6TVckO2jML7ULudKZvD/ljOhtP3KGnLbiGldWA
         KI16xiUKD+a7PnF2FljLnqgugtDXTT5dbnpF+L3qY6cNndcI4LLbLxOx9SQnviWdf0lY
         fqU5Ad8pE5V5eyLEIQm1OibqKO8oGtGIeJ/Y1xX70oUaKXjKS/FucM5eMk24RleHiBDS
         lKAWYYrlqG9TOqOBtQgVFhreVzZFb3CvJyhbxD/a5ZiJ9WQGCI704p9uxNgBE7LfuqTC
         kE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2/WHqFwHhivpm2SWXogRDRCEsu+DkMR1K3Tg8aY2LZzpa0E1vsaDZ5mdOlZdBn/rd3Q1BG7TxNX2yZfYyQyOM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3G4oxOYvLybWEpfp63lwVuvQv4hp5bIa+d1H5S+wvPf/RGEp
	K/YjiRTl/j8XfbaUhskB1QyMbFI0GOhuXKpKu50w06J2A/LJ6QI37Kj8+IsIWRGT1CjaFGRWuko
	206IrkA==
X-Google-Smtp-Source: AGHT+IEHlFlL2TrGZAazdFCdJ2nKo5V+DIOkAndedxKoqmHJgdc9QnNzvxkDXaWlttLW+PZpW5C/Hn5j8Ulh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:33c6:0:b0:e39:78c0:3dd with SMTP id
 3f1490d57ef6-e54ee2127a0mr17360276.5.1736448049398; Thu, 09 Jan 2025 10:40:49
 -0800 (PST)
Date: Thu,  9 Jan 2025 10:40:41 -0800
Message-Id: <20250109184046.193736-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 0/5] perf test: Add a runs-per-test option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a runs-per-test option to perf test inorder to better diagnose
flakes. Each runs executes as if it were a different test, the tests
appear together in the output:

```
$ perf test -r 3 lbr -v
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
```

v3: Improve perf test documentation, including for the new option, and
    add some example output to the commit messages as requested by
    Namhyung.
v2: In the v1 patch Kan and I noted cleanup that would make the code
    cleaner and less indented:
    https://lore.kernel.org/lkml/20241109160219.49976-1-irogers@google.com/
    Add patches doing some builtin-test.c cleanup and then add the
    runs-per-test flag.

Ian Rogers (5):
  perf test: Rename functions and variables for better clarity
  perf test: Send list output to stdout rather than stderr
  perf test: Remove parallel option documentation
  perf test: Add a runs-per-test flag
  perf test: Improve verbose documentation

 tools/perf/Documentation/perf-test.txt |  20 ++-
 tools/perf/tests/builtin-test.c        | 223 ++++++++++++-------------
 2 files changed, 119 insertions(+), 124 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

