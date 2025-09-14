Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847A2E612D
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873519; cv=none; b=Ln0cj4SUo0BW1UlY9s+5MqIOvD6l5zOOn3zG4mbimDs3eB8wfEYU1CsXBzMAGN47QP6BnJPcHIAEmvBuBXwsLT7r71bD9bLr9bYBc7WBePkSqR3tmUzT6QjJC7xdTnwus/U5xq9W0wUoH8zr9YOo9ut4piz5UD8OPGDj+YeDdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873519; c=relaxed/simple;
	bh=ljI0WTUYOuJFrnJBziodRTXhC0o8YtCEikX70wIWVdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TPbwqgZK/Dfmqya7lGPO7n33cRghI9cxn0ZthCBLdEP53exJq/9kooUkZEruQoeyWYMY5X3wj4PKnad87tq5nxhjIWS3EOfcJYo7l0RrQ0sXoZvdKEu72mn9HWUH/PscPFOWE2ckdSO3dnzO3fGd0094Y81k1KBCZTAIvvvlubs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/+dDghz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/+dDghz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581953b8so40014685ad.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873517; x=1758478317; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cszoCuCF/4pJ27efpqxPpEc9IoYBZusH2U1UEnIjtyY=;
        b=z/+dDghzMv/PHsPKe3ey0ynoflELVXTzq1fRkk7aFbKu0Ndbi8+bLtubBqq3Dib45L
         CRyZaDyuz/Iqrol1ksH4ZXXtFH7J5c4d4SaA0HZ27O3/6yzFLPHyd9daU0IDZFK5AjH7
         LkBENj4XBGtXiUHkpaN+DjFSHoBghay/5F0wdsMVlMntp3ufdS9QuA7hCDBR99phxDx2
         DLhG4XauYBAE9g+v9O60dsJAusGYcTaxEVfAIZtvOZjUHWIFbrAppsvsbyoehblg7+/2
         Mg+056tFyPC93/i+vK/J1shPUiBQWnj2Ub7FnKRpHBUsPIRA6UkHdbaGEd3P+tmCQX4A
         Y2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873517; x=1758478317;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cszoCuCF/4pJ27efpqxPpEc9IoYBZusH2U1UEnIjtyY=;
        b=J+Q+JuK0r7wK6Yc3w1Eew4i8fuXbkFL/XBsqkdiBm05m2ONcS/7/x64OgEd3ZEkvU7
         Yge9kZdiS085p4q97IGxKLOe7oOMRXDJV93w/QW4shSMdL2qHQzBODZW3tZi9wZy2QWQ
         OaAHjx+VG4bmz8NczLEZv6NP4JyJwwLFXav0DbM+e2p8xk5ORTwRY0ZwUhQltjHzHJLO
         wCgtogFFKyV2Dc90KhkMTCh7+DI+lz0gQU1Eq6YpBJrHA4mqxV96iZCn/YmStvHcKP88
         pNXHjzF+m+DxPy1S9nsChVmBSoyecGhnPZsx8khx65E9aqLjOsBg4vE7tUtkw4qSDssd
         CqSg==
X-Forwarded-Encrypted: i=1; AJvYcCW3zpZ64cDNaRF2f4RYKCS0iyEIl9geVcJiPNHi10ioNBJmtjibFcsh9keHSyspdIx9Bx5I4/9yQtqshPWyTZi2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxv5JAnd4w6ixBGni4BMBQwOMDA0a5Gx7bJaaoaJDi9vWIqb5x
	BW+uPK1Q36YqlDcchLjYPsbhrZhSArh7a/T5RBkFn4HQoaBxwzrZQhkkWmXD0HiMvHTuGGMqMKc
	SkvNkPSg4kg==
X-Google-Smtp-Source: AGHT+IFOWE0dHH6/DPzHfcurS//5mAYhaRLp8T8QI8OCJte54DrklhIzwzjTyHhmS/wBztTimb1vUq4Y01Ng
X-Received: from plbd3.prod.google.com ([2002:a17:902:f143:b0:246:727:7f8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4c:b0:263:d6b5:fbe1
 with SMTP id d9443c01a7336-263d6b60724mr38223545ad.55.1757873516786; Sun, 14
 Sep 2025 11:11:56 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:16 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-17-irogers@google.com>
Subject: [PATCH v4 16/21] perf record: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8e289f352fc8..d29a3bec1a5f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4346,9 +4346,13 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		err = parse_event(rec->evlist, "cycles:P");
-		if (err)
+		struct evlist *def_evlist = evlist__new_default();
+
+		if (!def_evlist)
 			goto out;
+
+		evlist__splice_list_tail(rec->evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
-- 
2.51.0.384.g4c02a37b29-goog

