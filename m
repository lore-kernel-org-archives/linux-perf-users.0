Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC717B425
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022732; cv=none; b=VKjIpln7FwjOsiHWU+lhcx6k5k5diyKmxShSRpsT5GilyUacDw6hA4HY0bxfua0PW4ia2gpVcXKKZn/qtm2YAqXTffWyMq4OkfsjrybL95T2jmTx269DL39H6orldwqZ2j99KvQY58LfGuVwZLMhgdGQznFr5FT1xpb6SYk60Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022732; c=relaxed/simple;
	bh=zAfjtjj+YiJnJ7lFAq0FxnfpH7pv0SiSJh0YtuQCDTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9hJDrRCpp+it/of4kRLrgMQiGsCRJKxTY5fWxuz0FNx/bGcbxit/cN3TJb8cx3ZLYDI6R/VnXgC6z8VvRwWdyzdNoC6qyReM3RC9WFEF4+hUn3gy/n6o751XHMw3zrio1hv7kFVcOS1e8Mwo5GKsQ6tyMiQRfuxnEnVBkyf5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stClc259; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stClc259"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso7188233eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022730; x=1775627530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guJ3+DvItR3r71cEYZmz/hXvjvKMr2DghXVNhgv8vbA=;
        b=stClc259lu6lp97JzUhjPqkTIAzk/3i5MFjHFdQsQbad4Cov4v2sy1pCNKqj4siG2z
         ic2p6/dkqBSFd4O7WwGFSZaS98ayl1hq4SPlp/pMAZ/u3UJ3J3wKItu2YNicEE9luuxg
         mxOV6D5HBweIds/kOBNhNIZxWY6GMPZdIqdswr46PYLzTBu0P0Sj6jkjs52zBpCyLH+z
         b905b8s64VwmsI7M1EIZYYKqDTR5QemUdnZRor9zGpUH7ihP+ndG6SnSVyQBn5YauPrS
         Q9Vvie5xg1kEnpLincRe7nQeF4+3js0BCRR1JoYseL2zgf9orZUGXWZzA4t1E2I2Uc40
         aj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022730; x=1775627530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guJ3+DvItR3r71cEYZmz/hXvjvKMr2DghXVNhgv8vbA=;
        b=KQkNZuvN29RqXrKZpAAgCKgU8L7Zu6w6W7XE7oihwtbGVRcTFwO8AFiMC8Mfyz89+X
         7fsfeha0tPGPx3F4gvI7LoqLZTHkaq9dNxhvRsW/M0HkhEYiJjA2cUlPTyWUCV1afEeH
         HlqQq4NCGooaBB5tuKpwsGmy5VW37BzwM3llrhWw2q0dDPBGLXyGgInHTbW3r2Fh3ov9
         qppkEfyy12/x3TsqF+mGV7jCjhhls2PG0aNdEAU/yV4ulFbiK4pP5IYu1mF2FHIxgYXn
         lgcmEDhJ0VgBrZsdgz9EixBEFKGurbcAojS8o7FlsLqaspq/d/rq2/RjHhS8pR6LEk6W
         QfBA==
X-Forwarded-Encrypted: i=1; AJvYcCXsaKMBhNuRLaNAMo2fcq1KZAdLZun5J+sM9FK83ihk9cBCv0QCduzjH7GAiQCtYWvoAs1kaWkQIRipjR0RXAxH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZO3ZkvVwwq4GofqO7mGQwBPyK0CaMITYlGAAbqpHFRtewqZP
	yzJpxt7VVzFjeaOWDlGv+ovSr8sQX2fBQa3naAVg4i+GZZy93yy9bPXuITUhwJdCgPAstIj55wX
	c9NQ5Yktj4Q==
X-Received: from dlbts5-n2.prod.google.com ([2002:a05:7022:b045:20b0:128:d7bc:9755])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f205:b0:11a:6424:f40f
 with SMTP id a92af1059eb24-12be657ba2dmr1349417c88.36.1775022729708; Tue, 31
 Mar 2026 22:52:09 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:51:59 -0700
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-1-irogers@google.com>
Subject: [PATCH v3 0/7] perf data/pipe handling improvements
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

I'm looking at improving the perf data converter with files generated
in pipe mode. In pipe mode I found the feature handling for the last
feature marker was problematic. If a new feature was added then the
old marker looks like the new feature. These changes do some minor
logging and build fixes, but they also change the last feature
handling in pipe mode so that the marker is treated as a marker and
not a feature that is broken.

Two additional fixes are added in v2. The first is making ordered
events handle positive process event return values in a consistent
manner with the reader that ignores positive values. Not handling this
properly breaks with tracing data events in pipe mode. The second set
of fixes are to the perf data converter --to-ctf output where
generating the CTF events is deferred until the event desc feature or
tracing data events occur in pipe mode.

v3: Adjust comment for event setup that in pipe mode the initial one
    does nothing (Namhyung).

v2: Two additional fixes, bring back --header-only early exit
    (Namhyung) and some comment/whitespace nits.
    https://lore.kernel.org/linux-perf-users/20260228065953.3226283-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260226013534.2028272-1-irogers@google.com/

Ian Rogers (7):
  perf clockid: Add missing include
  perf header: Add utility to convert feature number to a string
  perf session: Extra logging for failed to process events
  perf header: Refactor pipe mode end marker handling
  perf ordered-events: Event processing consistency with the regular
    reader
  perf evsel: Make unknown event names more unique
  perf data convert ctf: Pipe mode improvements

 tools/perf/builtin-annotate.c       | 11 +----
 tools/perf/builtin-report.c         | 27 +++++-------
 tools/perf/builtin-script.c         | 11 +----
 tools/perf/util/clockid.h           |  3 +-
 tools/perf/util/data-convert-bt.c   | 68 ++++++++++++++++++++++++-----
 tools/perf/util/data-convert-json.c | 12 +----
 tools/perf/util/evsel.c             |  7 +--
 tools/perf/util/header.c            | 66 ++++++++++++++++++++++------
 tools/perf/util/header.h            |  6 ++-
 tools/perf/util/intel-tpebs.c       | 11 +----
 tools/perf/util/ordered-events.c    |  2 +-
 tools/perf/util/session.c           | 28 ++++++++----
 12 files changed, 158 insertions(+), 94 deletions(-)

-- 
2.53.0.1118.gaef5881109-goog

