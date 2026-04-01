Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D6D22F74A
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060012; cv=none; b=tgUi7MA9QJdaF8lwdwSP9W4oK/K/TQZrLnBcOqdyq7k4Zyaz9kok9NHkPg8E0kPWvz2V/CYu2FTwl8HH7RSY1JduudIWDpWW4flmq/7R7P4Rfby5S/2V8xTfLU9jZGKHUkkV0wfVGZqOG9g4lInVQUwqmdrVbkl8OzNaobtH70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060012; c=relaxed/simple;
	bh=1kbTa1lce5oe13kY+pov4gz/79pK/MW06kVEi9LqMs4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BljUwdm1fBfJAUBcRTq48//xiOHf8YzR4Lh2E/fhamwL/JcQJttVSlmG6bXr8Rhm+Vu5hStEoyNtadOorJV2NW/TdRJoWb6wwMd0Sf4762AtVEpeVSelEAnBaLd8FoIOZBMu0vS6cbmp2iLJB9NzUSsZsfXFGaHfykY3Pt2Bvss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTvUF9NX; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTvUF9NX"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c18175fc54so24753066eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060009; x=1775664809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycvbUXas+3Kfq4hRjmYWmKpRIRA72MTflrpt4SOoTEE=;
        b=VTvUF9NX1GXuzYSa4Jckp8fjrHLnZah6JFuTzMfajTkoXnh2sg4K+Pg8O8yYIuQNGw
         BfTvt1Hg9WoKjEdz7VDAJuBD2KCxkczK5+AAsZCVbl/0sFx0Xag5rqGbo0u6eBXtYa4B
         CkzzrGygN0lgKWtaIQO/SlZyjRurwkDKKaYrm60Oz+wqmBqLTbAP0Mmur3CCjINssFRn
         FnFJk3C3mPa4vAUiDl2mHC+wQBaA18M8cUiBBiR7BTUE9U2eXqL6JfplU9xLHQ0fyzbb
         HSMtVfsXMYdfZXCuFG01MqCiAnZLGUuEMIEI2hQjZZti3ObJdlr2WZ5bjPtgIhNXLBwi
         f92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060009; x=1775664809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycvbUXas+3Kfq4hRjmYWmKpRIRA72MTflrpt4SOoTEE=;
        b=PS1aRvUCB5Gn8y5xHb0R6FWPLG6EGRFtco6iqFrUVnwjmaVQtJQumKKA9zYUGowAYo
         DMKQGjCc2wFNraZ4rmDylhjsQaX+eIF0h1XTQfQSduCwLyLeVzWbYXSdb8g4I4szeQyd
         k4nMmRGw136EVzMv+7oe9O+ObT5x8KtUlIXL+/gtbaGhI6QDbW24bgTy1+6ijEFCTFg/
         OSdvD+nOpPPIBvwbgIn6yM6GcO0mK1fjcypQ5rJWacPA6wHShMj/W53O6X05uHlQwTGf
         uIuaODG0TJoggydHseHaBZdOyHVR4swKgVcMYUd1qLrN2S8G5jclP+sXVz/Lm7y1ntAo
         fOjw==
X-Forwarded-Encrypted: i=1; AJvYcCXI9W8umM2dMk37Jl49viMXnD/LgGOncRZjYaoHINg0Dw6dSJZM3XNKc016XyUmSRrFa4ILtMvYyK1rtn8GCcc1@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+9vh1RuU+x0WwTW7KqIGSxsveRVA+Adqze/o/5e4pQ/aNEVY
	7O5YJ1wO93x9JJ2devWOAohlmhYqpp7kfzaRX6GKwSATUZT18m+M2qfRMycFlTPMafXDAZjjMxL
	hLK7JCJW3Uw==
X-Received: from dyek27.prod.google.com ([2002:a05:7300:641b:b0:2be:6911:c4f2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fb8e:b0:2c5:347:e628
 with SMTP id 5a478bee46e88-2c9327a42cfmr2621166eec.21.1775060009051; Wed, 01
 Apr 2026 09:13:29 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:16 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-1-irogers@google.com>
Subject: [PATCH v4 0/8] perf data/pipe handling improvements
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

v4: Address Sashiko nits, primarily extra bound checks. Add patch to
    better warn about libtraceevent/libbpf support being missing.

v3: Adjust comment for event setup that in pipe mode the initial one
    does nothing (Namhyung).
    https://lore.kernel.org/lkml/20260401055206.43187-1-irogers@google.com/

v2: Two additional fixes, bring back --header-only early exit
    (Namhyung) and some comment/whitespace nits.
    https://lore.kernel.org/linux-perf-users/20260228065953.3226283-1-irogers@google.com/

v1: https://lore.kernel.org/lkml/20260226013534.2028272-1-irogers@google.com/

Ian Rogers (8):
  perf clockid: Add missing include
  perf header: Add utility to convert feature number to a string
  perf header: Properly warn/print when libtraceevent/libbpf support is
    missing
  perf session: Extra logging for failed to process events
  perf header: Refactor pipe mode end marker handling
  perf ordered-events: Event processing consistency with the regular
    reader
  perf evsel: Make unknown event names more unique
  perf data convert ctf: Pipe mode improvements

 tools/perf/builtin-annotate.c       |  11 +--
 tools/perf/builtin-report.c         |  27 +++---
 tools/perf/builtin-script.c         |  11 +--
 tools/perf/util/clockid.h           |   3 +-
 tools/perf/util/data-convert-bt.c   |  72 ++++++++++++--
 tools/perf/util/data-convert-json.c |  12 +--
 tools/perf/util/evsel.c             |   7 +-
 tools/perf/util/header.c            | 145 +++++++++++++++++++++-------
 tools/perf/util/header.h            |   6 +-
 tools/perf/util/intel-tpebs.c       |  11 +--
 tools/perf/util/ordered-events.c    |   2 +-
 tools/perf/util/session.c           |  28 ++++--
 12 files changed, 217 insertions(+), 118 deletions(-)

-- 
2.53.0.1118.gaef5881109-goog

