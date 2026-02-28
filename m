Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F8346FAA
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262024; cv=none; b=GdjDDGisfzt2y3JDvGfVrdL0zUCRqQpkhYihqJ8KcSagBTMToZZQrKzWoZz3FFvlMXJsjc9mnThtyZB3qRVkSCQcuLSmdzKBk7Dxl+OJP/ET2RGalUhYaphqpYLv8cBAFjyUxUVTj6zlL+qHyiPZSQ3IYZslqmpng/wK9O+H4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262024; c=relaxed/simple;
	bh=RliYG1vtA9yaOSRN1mSCoxA/CjGp73TxlW38mjNPxws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cl+w61zHkQ40I/kGkla28MuJwy7URF/gULy8QYwvGFfNpNiLl3f10s+lDLv3iLWSsWnz5+g/FQ2FSs1ZQGEfD53vGbPxIsdYVhEHXe5xokmYc1dn2M79JtIyRgytqYsNPGxNFRgeAtzHgflQirBtoOeMcs/iFIs4PHGhgMDsr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAk3HoyN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAk3HoyN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so5249119c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262017; x=1772866817; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=za18wqJGPZ4qBV9MGIgRWVqdllmP5Iez95b0lcxgM8w=;
        b=OAk3HoyN0W5A8T7cHIMIwqA3r2WWFE9hsGMCpAWteppLc8Z3TSkg6NLpheq9XwqHq5
         PS5wBoD+oxin8xDEwBjGpyOTOMuhnRG97Jj9RwNfklepNKNTNkpXguGa3FKro0mF4OrL
         K4rPVK3pj2KY4CtLW8LGWUe/EF5jDmBmzekBuvn4312+kqFHnKEs/kyA03y9c9fT++JR
         jU2tMOVfF1BPBB6v1HP2WeFD7OtPOrSktnHrZyo2PtipNw7heOyGyfh0Z0rE7ZeQVLsP
         xaVAeo9UrV+nGcJK4E2YPlygG35QvhhqckR67w3anNwGeZMJbux0klwRjWps1uvYQOky
         /ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262017; x=1772866817;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=za18wqJGPZ4qBV9MGIgRWVqdllmP5Iez95b0lcxgM8w=;
        b=Rf8BqFN4QxyB4je9KzAm76AGIMVFPrGXadi9mdBvubuLHEROc9ghhGcEPgJ5SmbLu8
         JDhcffSgP7Lr01Yewj/8dKzq7nqFNQxbO3XqZ3q8EDNcv56k/z577rJxmO3N2FIRYZUY
         DBRv2BcROmGr5yH16yUPzWDFr9LKGqd4Rk1dW42uYCPDEbX9srFspIjPFAiQ7dGu7Xt7
         YaV5K/3HYH6sSh4Gqt3SmQzEQP0qMe7UYMjA/gtliw4ndiC34DcEnjZvS6fWcoeq4RPP
         fHkOwSS1XNQOX4nM9z/INERvRwONezpJ2QKqfPpWYO5jHvJg7vLhRyZzueYBMis/mFHs
         +GeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoF08Mgz3FCwz/j3cDaWZW1xYulo0YhWrZ+ECs2+SmJJWNBJX10dbXHn+iX+8Xy6lI0VNO8sHgvsyA274XwcZX@vger.kernel.org
X-Gm-Message-State: AOJu0YyDZyUAQ6nX3toLjs+Ib/zqvFB2xDMeDV9UnBSfDJLKnplw8G1O
	zFIrq451Y8PwIxJIS4u9AUEa8Artzgkn64hDM9df/v+9kHvpCyOeaz/eTHhs6QNrkZ8AEr5MVMK
	U/VVnHzpz5A==
X-Received: from dlam21-n1.prod.google.com ([2002:a05:701b:2095:10b0:127:89b6:8d2a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:486:b0:123:3488:899c
 with SMTP id a92af1059eb24-1278fc5b9ecmr2052627c88.40.1772262016629; Fri, 27
 Feb 2026 23:00:16 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:51 -0800
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-6-irogers@google.com>
Subject: [PATCH v2 5/7] perf ordered-events: Event processing consistency with
 the regular reader
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some event processing functions like perf_event__process_tracing_data
return a zero or positive value on success. Ordered event processing
handles any non-zero value as an error, which is inconsistent with
reader__process_events and reader__read_event that only treat negative
values as errors. Make the ordered events error handling consistent
with that of the events reader.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/ordered-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 8c62611f10aa..a5857f9f5af2 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -243,7 +243,7 @@ static int do_flush(struct ordered_events *oe, bool show_progress)
 		if (iter->timestamp > limit)
 			break;
 		ret = oe->deliver(oe, iter);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ordered_events__delete(oe, iter);
-- 
2.53.0.473.g4a7958ca14-goog

