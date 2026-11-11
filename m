Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370249;
	b=q9oZd67z6JEBpuGBqQZWsYyQ2Z8UR2WS+yW0wbzeRcDgayxCP902sozvvYDziBMhLHnL
	 NmPcx85WwAjvIz+JQUWKnCIUe52mdjv9G8avNaKAKWyoEJTlRsbMfdz4E39f0ulg2o+Is
	 HVdzi9x2/3UFRznB+hlVL1DVtyBWUqt+SpFGbIbh4884qbTjXCHvwPUwND3NupYPf/Cx3
	 mUhu1297u7WXpU+T7gNAwZU4rs6fDuLe7Uvkxnr5D2SpK95hNdRv1CIpdfR5jcqTedd0k
	 ra+gVwU7Rb1CRovaUrgxdfrqxxGHNe4Q2y5eT0VsJ7hH+9CS6yWqkhKTLkwNO+v6jNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ySu7MEVrLJUCUm2blNlsN2/YDHnP6+c4oAKwJCwJsH4=;
	b=Dr416lad/ylHdkVdIFrltYLUaRSVbHtV5zOxVnB2shcug7l7WWHz37QGvhzYPjurw4Ls
	 RCzk8mri5JBYTNwaftadi76ZEYymgTIn4k9TmHxOkjTeONAfUHRXUtyoce0QtHShAOgsA
	 euSwsy6neh8XTjOo7aDAjygo7242WzNEUgJj1pFdG8jv9bsKGCbFXekqoAGlZKij248Me
	 iGdu6betJf2WUR6JM7uHqdo1D/8yc7pVHEL6qfWhKY76nWDfOdErG5CzN4/x+2McQg+zk
	 Gii7g0fXntTxS04g9ceVCOWaANMYWwojOsU77whjdfqXKdLg6VO9Y14O2tY53aM5X7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="M0kHG/sh";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C826606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 04:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C826606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0kHG/sh
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so4747730c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 20:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370248; x=1794975048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySu7MEVrLJUCUm2blNlsN2/YDHnP6+c4oAKwJCwJsH4=;
        b=M0kHG/shVIGSXiGDCigLoJ5jt51v2QuelVk+iBMsleWiPXx3Q3GA0QGfC3RUcQmc5E
         P4g+Y9kyAzBSzR0cJc936F5Y2EXfUC1VA5If9WYNHPRVCGKQOWz61XyJMy7PPN8BcPKF
         4EajKJuFNHx6se2t51A3330F2Mqm1wx5WoQz2ABZGdNHt8ja4xVqSB95WWp5XC8S4dab
         2Tzku+s/lR9ZulC2JqnKJCSO6f3s8CuytRv60FsI2mqmsEDuOEGwEowj04ljOdpAFstg
         BiAhoUsNFSBbQcV/FCRIfOcutoQ02yGG+IbCYemziFzrmWDWW98QefCJzSQwZR03aBnn
         FRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370248; x=1794975048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ySu7MEVrLJUCUm2blNlsN2/YDHnP6+c4oAKwJCwJsH4=;
        b=w2K/Yv13O2hl/peG3lQx8QIBguwU1pVt6x5513otMZuMCtv/FH184RyT7QjpLio7Rf
         w6owiuuTqrVJIuSML5eZEs4an5sHbpdj9d0JbspMmAGI0DTn4h8el2C7Lgm5iz8km9D6
         W9SH87fTYeqQPi00Mvg5s212Rr+0K4QJxtrA9mkRj+TlUDyTZi30/qM/0k02QKo4y02z
         hDcX0U2fZww4uR/uAlwD6KZlVGidGEVgnyEuHdMWQbl0aoeepv0advskdduQDfYLjTRG
         UNRA4N9uHOWK8rrahijTzA4AR6Obx7bUkKzsTX4WVZWBFFcVthB6c4TZK85xou/wCYzX
         G0rw==
X-Gm-Message-State: APuU4Z9s67OKzCl1aX91T10akD5EVLA4UTfImrY99nFtFB4p06fiQd2X
	I40tUiE/0Udo57ielYhsSpAWbGaHubbbKoVUM6CbSLq91Xi2wSWYsY5eY4pVOzUi
X-Gm-Gg: AYBFou3TAQmGxNrOn06U1EjKxphUA3h60wM0P+AFwovNx2tajlnKfNtm+3wEsJc5tlV
	7qSS0YoEpINvDmdg/kWGlvJ27tRwREKpgqYvlvRyTT6wnkEmr6ZCiiWHeXoDJZZ1hZ+9BYraqrD
	uP7HdhuKbwvi7ZnL5HYuGuPnUSNElfNot5nxXBWbHtBMyQETVzEnX4UFqo3vTlU4pduynR9Ca/u
	P3Dn+XJfiJvF1y5I3voKTfsMfR0dksPPT7Za/OIsjFkkEfvC0gcQAMYGy6YZCHROJu+nUlbLua2
	l2LNV5YoeosfljynZ46uZKN5sTf+Tx70tvuj9zKd3LCa3ORb8VuZu26GIASb0cdxLXMPUuXe8x1
	CW6Q+NppVIASZWo8WxugdXkJd4nK5/fJIsjZtZPhiOCIwdEFEarQhWeoKVxZEPMsepSGrfPPbh6
	8LtqH9YPbUqKCw2rKqCrdrgypGlDiw6mGR6+ZIQz7oQAxpeq/rGnI6p8xtTLrCyDpobzePVGYNM
	qHwtc/4xSys3SnyfIdlrgIXP8zGSpaDEMck9bYptWjPmRvK6dgAECkpsH1/yDLKEzY157qcQAwB
	FD38FQn4SmEfiNUpfKW8RQxo8vfFUvyMCI8iNlR3xg==
X-Received: by 2002:a05:7022:1701:b0:1b2:3742:828e with SMTP id a92af1059eb24-1b3c024f239mr1196609c88.3.1794370248316;
        Tue, 10 Nov 2026 20:10:48 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm11451201c88.2.2026.11.10.20.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 20:10:47 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/3] perf jevents: Report the JSON keys that jevents.py never reads
Date: Wed, 11 Nov 2026 04:10:41 +0000
Message-ID: <20261111041045.2031464-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034333.2019831-1-takano32@gmail.com>
References: <20261111034333.2019831-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

jevents.py takes the fields it wants out of each JSON object by name and
ignores the rest, so a key spelled differently is dropped without a word
and the object is built without whatever that field held.

Patches 1 and 2 make the generator name what went wrong, and let the
model argument be omitted. Patch 3 adds a --check mode that reports the
keys jevents.py never asks for, along with a make target and a perf test
so that it runs without anyone having to remember it.

This is the second posting of the check. It went out alone in November
(https://lore.kernel.org/linux-perf-
users/20261110193239.1741014-1-takano32@gmail.com/) and the review found
two ways it could call a tree clean that no build can use: a MetricName
with a dash in it that loses its MetricExpr was invisible to both the
reader and the report, and a metric without an expression was skipped
rather than reported unless its key was spelled close enough to be a near
miss. Both are fixed here, and the failure-path changes the check needs
are no longer mixed into it.

The test runs the check over a fixture table rather than over the tree,
so it is green whatever the tables happen to look like, and it checks the
three exit statuses: 0 for a clean table, 1 for a reported key, 2 for a
table that does not parse.

The two misspellings the check reports in the tree today were posted
separately in November:

https://lore.kernel.org/linux-perf-users/20261108184600.3810059-1-takano32@gmail.com/
https://lore.kernel.org/linux-perf-users/20261108183846.3804875-1-takano32@gmail.com/

TAKANO Mitsuhiro (3):
  perf jevents: Name the metric when a MetricExpr is missing
  perf jevents: Make the model argument optional
  perf jevents: Check the JSON keys that jevents.py never reads

 tools/perf/Makefile                     |  14 +-
 tools/perf/Makefile.perf                |   1 +
 tools/perf/pmu-events/jevents.py        | 407 +++++++++++++++++++++---
 tools/perf/tests/shell/jevents_check.sh |  68 ++++
 4 files changed, 439 insertions(+), 51 deletions(-)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

