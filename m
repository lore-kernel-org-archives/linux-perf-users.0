Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785020C013
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990740; cv=none; b=lzlkZHwLWzZb/rO0/WNX6Gcz4BYimaD7y+IZXzoZPH3t/k0CEywH6rZU1fC8lNDDFy5KclUTMYTY7f1FVPWm3mpZphQX9E+9md6nCZi0RKXckCaU0aRAPDhnpKuuAYTDi4EZkyhsmjYbf8vyW+W/RGhaRt0MloHGQTH/0W/idDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990740; c=relaxed/simple;
	bh=iEVYgx/hxX84VyoDEpscAjkrNLwDJylilFK5OuBYN9g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WIL5/1J3KLRqMCM5yzlYVSnNoDOiKGJdRUJaoX95iU/6lscWFnhCOgcTrVCM1S/AdXVi/0nS6ZNxKc900rCDxsH3JckFvqtHCaAIADPRIx2gmnQMBXUD2pNp3edNRw0G17OVm0nS8FrFQc3leQhgbpIEaJMb+Ay3FqRvE5/EckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAAke++y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAAke++y"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39a1a1f27dso413258276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 00:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990738; x=1734595538; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=LAAke++yMNo/sV7z6+FgooHbJAWChVprJHnV4u2VQIW8t8U+iQs2fGDm1rM87+KK2S
         jJQpl2F8uLrnM3SM4dLNbnb/fHGn+fF5TiFGHOYF1ls2MbM3eHLiJpd9oEnOezhTRfd9
         bRhEINvmhhhOXvtXoUt3/ygcDW5Vtit/mlRdj1/gPRBLYKDI64YIJIi/4GV2BGWj8zcV
         /YR4t15uhUkD3jXgxNGlJL+oQ/7UGGZu4uCYug11vvuQNdiy3hLoIdE1tQ0+WSzS2MW3
         IdMzA6BI/2RdyO1r/kClxhsyINso54d86Ha8XsXpxx0G8hSzpf2UqbcjRIEgpMGNpvq+
         lK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990738; x=1734595538;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=k2MLN69G6nvL6o7IuDrYqUQe8S3C8lQW0nfpOuMdsCKnjAJYmmooVvmehg+caOl6on
         6+9PrOaKoQwBExhDERXHOTLTG5894xd+4D9naz5A6zsxvZqRTFniN9GB5nzKNuBbObfO
         AMiSGMtNmVOzm/iafWzO6vcQMqsnYsdfQbnvA6fJt1XhbvD5Ms5TrQ+BpKoGHizOHaau
         /+QKJhRWOtq+UIq0HoJQdQGowRRhssIEA9wRe5GNmZ4HpKZV7hmZRpAXCqk4ndejHjk/
         JAzuzXIagvni/bFzLQebJbJBImLf5a0kaSH2fxMjLMtjv1gRS/+YyPfC2mjCfsE1m2eU
         CLLA==
X-Forwarded-Encrypted: i=1; AJvYcCVl20x8efRfiJpnXiP6RXYPSI2zljUrLgqTqArWWfRZd60ItydztOymXBLmaBWlxzLtvLpBVB4u0azjCfPGTNg7@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8QiS0Eig/spyiGq8XJme8H3ZoTXk7MW78U2kLycG7WV9QIIV
	ndEulTdAZhgvdufvsQEiObVC+6R5pwWj6r6OM+7sTRDXryfocE2FAyY/g95wHn6Dd1yVj8efbLz
	SpPsJ6w==
X-Google-Smtp-Source: AGHT+IGBXWJ3ucqX9hMLm0vrc3zRY5NRfTUR84iS3B8eBzM1iEFlb5CZtt1FWUdjD/dw6Z5GJ9hNZsv5a41v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c22f:1975:e7cf:849c])
 (user=irogers job=sendgmr) by 2002:a25:58c2:0:b0:e39:fc33:e15e with SMTP id
 3f1490d57ef6-e3da21da53amr1406276.8.1733990737951; Thu, 12 Dec 2024 00:05:37
 -0800 (PST)
Date: Thu, 12 Dec 2024 00:05:30 -0800
In-Reply-To: <20241212080530.1329601-1-irogers@google.com>
Message-Id: <20241212080530.1329601-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212080530.1329601-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 3/3] perf record: Assert synthesized events are 8-byte aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Capture that events are 8-byte aligned and avoid later misaligned
event problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..a5689d0e93ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -624,7 +624,10 @@ static int process_synthesized_event(const struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, NULL, event, event->header.size);
+	size_t size = event->header.size;
+
+	assert(PERF_ALIGN(size, sizeof(u64)) == size);
+	return record__write(rec, NULL, event, size);
 }
 
 static struct mutex synth_lock;
-- 
2.47.1.613.gc27f4b7a9f-goog

