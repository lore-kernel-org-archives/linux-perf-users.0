Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839195473A
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084459; cv=none; b=NCg9WBljPV7NiRaR0+Is+9X7pIr8SrrZOZqyOTr1TUOM9L9rct7dR4owANhTi75htOfk5SS/W4FFpEeAG3Ehri7DdKwwtkkFrtxsXMqOI1NfRBsrDZWmzN6XGGJCruYoacEV2xuZ+fF9vQdpyRntAhqiinSmDMJc9cSz+ZBzb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084459; c=relaxed/simple;
	bh=dphi9qBP63ALc85YmSjwCdzNIVpfkRQLHJHQrbhmr1k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PwOpmn4kwp9uRz9BcZy/yr+ZgDHyi16S9gXPiGwTvRiQ9au5+FF9rFm7lWnhZwtGDGLPu+pLTAh+mYkHV/djQqW28pMEalF7Y29TD7lthQKKqLZoGOlU1UFT/pRuACr98HRe+3kQ0+gJWYFYVbWvWusE807J38DVGWfuy/cREIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2amSNHXc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2amSNHXc"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de45c577ca9so3291321276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Apr 2024 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084457; x=1714689257; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PRyB6ZTPXeEQyqvBeQnDzSQ3aoVG6ArsSOU0946h4+I=;
        b=2amSNHXcRHIuqrk5p78qfYCdZuvrfmWEnVxzH037tSXvS7iyCUKXnuuJmw8br7kZqS
         vIQgqLW+oYNsN/v7YmgCkfGJN5C12yNuWyUWHZcVQg/Rdc4A8tJZJkR4w6DBDgcsaVlY
         vtJJmezZKTKGO4zhcvwLupF0uwW/GHzcMp9yT888fSsfQd9nA7nwJ964WYaRr4drS5HT
         +8pYrJkbr1jXoah5ZxQFePrlFP20oMgl4KAQtmanYUPXg1jvuMHIXOMBPKM9/osACd7V
         5PQnk2ZZFt6E2poZp4qIzv/9MqjO8enI8pVfPniATMI4LOZ4WryceomMy2wTII/gVaKl
         rhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084457; x=1714689257;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRyB6ZTPXeEQyqvBeQnDzSQ3aoVG6ArsSOU0946h4+I=;
        b=R/YfLIO+UZjvxQ9rWVef4gKQ3j3S3/pZC9GzirO9BtFLTuW8s9j3fkWILZMNRd+0ne
         dwdLSZ4387qF7ju2CQCKdLpn+wqfOl6U6GtHo2ApwWRdECr4iKtRxe512y0Aco+Y40A9
         VJQWIs0uUFBbW0WWxZFwtWalKP7J/p2IhY+TJlQBWM2DRrww0FHWfsJf3zGIDaEms6sv
         +K9QwwdjSKDNJJo5/ThDjmLiKeg0uHpsxXC5w0ifhL7jFo+fBHhPgqu9eCGtBJ4a8DJs
         OgLawjgvXiqCPlD5cthjpGP91zQT37XNY9g8z0SC9db0CIhpm1y4D4HoJG8HTFGreF7v
         kYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVX4DSfWfMz1G9RydXM0wEv3HKeRL76j9f/8hFybiE2mxhaYFd8FZF6+gFRqUZBih8RbARYAT9/8qppyVqVjwqGT1ZAQI/HchR9acHV1L4mw==
X-Gm-Message-State: AOJu0YxbFD/jaSLIxy1QP2DZ+vDurIQ/3pDM214Qrsp4BE2MHnI+IdFn
	5/Zu1+nL2eCHzMejSRf6GGURDU3lBVhynH3omv9TV45aPBfdYdoLu3zhwzdIH6cYArkcGi3jvkb
	kLMrp+Q==
X-Google-Smtp-Source: AGHT+IEQ/sIEgXuPsq1khlWSJrM0X0hALhujw4KeoPWU3mHHONJFz2LIsLabZBngG/PF7TMXMHovH8xNLJZ4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8708:517d:aade:8c87])
 (user=irogers job=sendgmr) by 2002:a05:6902:c04:b0:dd9:2782:d1c6 with SMTP id
 fs4-20020a0569020c0400b00dd92782d1c6mr339697ybb.1.1714084457578; Thu, 25 Apr
 2024 15:34:17 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:34:04 -0700
In-Reply-To: <20240425223406.471120-1-irogers@google.com>
Message-Id: <20240425223406.471120-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425223406.471120-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v1 1/3] perf evsel: Don't open tool events
From: Ian Rogers <irogers@google.com>
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tool events are set up as software dummy events. Don't open them to
save some work and a file descriptor. The evsel's fds are initialized
to -1, so it suffices to just early return.
---
 tools/perf/util/evsel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3536404e9447..2743d40665ff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2005,6 +2005,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
+	if (evsel__is_tool(evsel)) {
+		/* Tool events are set up as dummy but don't need opening. */
+		return 0;
+	}
+
 	err = __evsel__prepare_open(evsel, cpus, threads);
 	if (err)
 		return err;
-- 
2.44.0.769.g3c40516874-goog

