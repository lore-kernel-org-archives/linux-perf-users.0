Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39632DEA7A
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798444; cv=none; b=UxRaNFNtIZlCrf7res3GMuG3e5628pCAQ5DmHcxcpQ+gwQlKjPGJoNtY7kReybVlY0luhUo4OhgfisTrw1EUy3ZfvOHt6Kel9jpVy70pfg9D1yMLX+kgk32TIlPlK/GCowlYvERg8kCrvau+PnM0t6lqC9s3mSUbxjWYk3+XCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798444; c=relaxed/simple;
	bh=rCDV+3XVuXJlJQb0sFK0j2R1k8EuktUog2utuwzxKNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MFimAAZGI2Cv5dtQXOZwz9dDI5NjWq4j4v0JJEVd6DWsrcz17X6AgjWC+YKeH+AN8r53oXDS213CaX7KFfuAvIfFvvSjDOIKgrVhp1J3St7i8XvCmaNiCI72kCB35laGxx0f6Q8Or9lUSn5g8YWX4a2yM39yW9o2rLEXjrRx/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XhuY+qW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XhuY+qW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso418467a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798442; x=1765403242; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo+kFEEYhTtGZ8S2xC5G3JMQxS58EmO+MrIvA5H8Swc=;
        b=1XhuY+qWKDDD94ypPW+YzSuUHQ8XXHcfN1ftpoOCb6otTEy6aHPbaH155S3576Aryl
         7B4m6iQaSi3jQFTe3SE7ogaZSQErVgccFNOYJKnfZGA2AjLa9fBEfOxxiIqny9KLjcAM
         AIiLsJ0phFZ+Mij+sV5UMkEATlakm9slT+JtTqPCWAe3QsRQM7CzOJbdgDMnw2OVGMKz
         E7JhVyRhuhv2ETOHeGCkT/HLKWbZCjWi5X+EQ3ajCHk4mEXoqH6z/zHgo4ARPMOG6dFP
         9zkf1nZbXFyc+TM/QSFM4Yw0hTEfso6VfC3gee2PFJxGegeY9zq07Ta0GOoXJNEbzDsp
         ToOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798442; x=1765403242;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo+kFEEYhTtGZ8S2xC5G3JMQxS58EmO+MrIvA5H8Swc=;
        b=gd5JC0Egtnm4SSUMbDZgr1zr2yvfn+TlO/UCpggJe8MAcGhwsNBFgy5dVRduS+XwLZ
         m4Em3tgpeab7T+cjMtKMyfeleFwEkEeUrDpSWwuErdTD1qQrn+arZyBE8eEOOxWEq4xT
         DZKDpqicXjd7DvKxuwxZ8b0Dw9qA0E/wRuI4DkRmrVnlWG0tsV5T1YesuBJjox6XFUEn
         ggMdnQRYitUJ5c5ib82IlSCO8OIAIcNbQSXymKa7B4bM4A2wY8MYMOgN9A+g9KaRMHss
         inM8F1rtkbg4IHvsKi92v/6LZBUjd7fVIUrtRBwXTr+j36KYeam9kgZ4zDGhHTw9lEeq
         tSlA==
X-Forwarded-Encrypted: i=1; AJvYcCUBu2fqNVW8zs1hvNE29RM2KIgP31GBM7tiSr02TxEd85rpXI77S4ajPumOkaWlsrDuDoTTtq7Yg/+rqww4LcUR@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKJkOTNl/3yrv2ysqqqymwqIfcy+RDQ+rWzLAFOyNlS+bSI38
	7kssSzvUWNfYQ0VIIK8DGU9Mv9JqCFFkFaJ6rrF0ROClXFIa0Zxwnoyvwpv2tb/lRy+kU4EYzrp
	YNeRfU+269Q==
X-Google-Smtp-Source: AGHT+IHhe6kRQZx177bgCgxvMbSS9SftVF+Bm/qVvJrVFF8Tsu5NAx3LcXp7XVpP0fOBqaUyYQBGvjc1lKmz
X-Received: from dybgh9.prod.google.com ([2002:a05:7301:9:b0:2a4:559f:7c4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d024:b0:2ab:9e2d:a466
 with SMTP id 5a478bee46e88-2aba4235517mr639323eec.12.1764798442027; Wed, 03
 Dec 2025 13:47:22 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:04 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-6-irogers@google.com>
Subject: [PATCH v2 5/7] perf stat: When no events, don't report an error if
 there is none
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Events may fail to open as no supported CPUs were specified on the
command line. In this case a confusing "error" message of "success"
can be reported. Let's skip the error in that case.

Before:
```
$ perf stat -C2048 -e cycles -- true
WARNING: A requested CPU in '2048' is not supported by PMU 'cpu' (CPUs 0-7) for event 'cycles'
Error:
No supported events found.
The sys_perf_event_open() syscall returned with 0 (Success) for event (cpu/unknown-hardware/).
"dmesg | grep -i perf" may provide additional information.
```

After:
```
$ perf stat -C2048 -e cycles -- true
WARNING: A requested CPU in '2048' is not supported by PMU 'cpu' (CPUs 0-7) for event 'cycles'
Error:
No supported events found.
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6410115ed9c5..bd3c3de8d200 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -924,8 +924,10 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		}
 	}
 	if (!has_supported_counters && !stat_config.null_run) {
-		evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
-				     msg, sizeof(msg));
+		if (open_err) {
+			evsel__open_strerror(evlist__first(evsel_list), &target, open_err,
+					     msg, sizeof(msg));
+		}
 		ui__error("No supported events found.\n%s\n", msg);
 
 		if (child_pid != -1)
-- 
2.52.0.177.g9f829587af-goog

