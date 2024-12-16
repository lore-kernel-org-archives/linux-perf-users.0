Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F941D63E9
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391512; cv=none; b=ZYx5Hju4HQtvCsa1BCHWTfCPwu01hUDzNQ1BhxRXrfXMVmxJKhYkG0r+Z69V5tLJKWeUNn0tTzGayIl8bH4/DNnRzvJOSypI3FbADkV49UKL6kJXKicLNv08JVPSfOsF9JKU+RsuDYq5dJRE/wgCjXEsOV398I2eFMg0m//9g9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391512; c=relaxed/simple;
	bh=BrUJvr7HXzMJyoNYnziI4wlrd5p8WOXp8dhXnVgi80k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=G/kRG5ar7to8zCAPW0t4GuC5k/g/+gMVk5kjNwBp8NBSOM90Sfg8iH/8CpiNa0lVhRW423Gamq4/JL2I1Za/TR9yrcCX6LtVCU1tmekWYNi0HYrkTnQ1JHjNQofGmqamOIXVcoD3HNAAjPg6R3nzOKpbX17BY1WOGnwKDn/mOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crfsoyi7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crfsoyi7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ef4f873240so31916717b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391510; x=1734996310; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLJ1stvpEh/i9mxehEqquhSJV82oFfMq3Eq8V809bTo=;
        b=crfsoyi7TwlBKtEypJWDFUPLCQZE7GZG8G1J4ekb5xwxsMQ0YUQsntvGoZ2W/9eF8V
         Ge47PAvXRNdxG/btRXTCcoHaz2mi0tWQXyyrSELNgOqP84Z/+108CbQxiJQRsKuMj/32
         MqbI/fcjg4KJSL4jYTuC/DH7yXWX7VAyxSOLUvd6RcZbao6MzDjJxTZ1DZiidybaHcYE
         AS4WSHO2xBUJay6sNfTSACc10D3nxH1HWxAFY80VWoIw3NCytTkBOwi+QqY2LasqR7EY
         fE/YbSqe6ZVbFPG3F6jRCiwE2WWmm6RX1tY0OYX7rP+840A7WWC42onW+dtOtyrgGTbC
         xx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391510; x=1734996310;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLJ1stvpEh/i9mxehEqquhSJV82oFfMq3Eq8V809bTo=;
        b=H/26xMb4nVpxwOylijTOEggy3zSnL/JKAc+Bw+zcXE+icUfo2li/8d0ymCRw8FR+C2
         yPGsi8J7xs3aOfCDbjdruakF7xl6Fdqa7p4Xtx17lH3uw4fNm012lOY5kzeXdeYv1h7R
         7XXt9B2HvLEMbbs1GZP4Lk429kaujdtcgJJA3Q1IFsKLtuRkVMj+OUDg0gENOrWPSUlx
         5j9PslEw/n3UIAPz9K3i/EtuROfFHNoDtW24ruSznc3jKVWVCaPO0WiFXPeMpVTmFr/P
         UpcdYvMhBRC+TuO/MuJ32OPTUkg4v7mSyZ8ofLKkXRJfSiXygJ2wIXsCtjowN7FBREAX
         cv2g==
X-Forwarded-Encrypted: i=1; AJvYcCWtY9F37HsuGIj5Hh+SyV05A+q4/qBI05cZP8ihSzWQgG642x92Uho3YYHusUzli38EBC88NdJf8Hndfe44ijX3@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGlZJJ+Fop6JLnVIX+ePz5mMYv3LoA7/sdHVxUd7WM+7m2YXQ
	A5F2WMnVOuuhTgpDWY3YpUHEHyAT6EbhUpzrGtULBdtuBg+XTrSLzq7Icghzlvu5f0TOuUdJft9
	i3ut7Ww==
X-Google-Smtp-Source: AGHT+IEBk2ZWqf3tvA5JHyC7+FOyJZXG8fvNRj78GZbr7laoh+Qh/+6h6VlNMjqZMzkUaxrw+ZzcYont7naS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:c74d:0:b0:e3c:88e3:b8ba with SMTP id
 3f1490d57ef6-e434e9bfa53mr7252276.5.1734391509720; Mon, 16 Dec 2024 15:25:09
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:57 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 3/5] perf synthetic-events: Ensure features are aligned
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

Features like hostname have arbitrary size and break the assumed
8-byte alignment of perf events. Pad all feature events until 8-byte
alignment is restored.

Rather than invent a new mechanism, reuse write_padded but pass an
empty buffer as what to write. As no alignment may be necessary,
update write_padded to be tolerant of 0 as a count and count_aligned
value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c           | 7 ++++---
 tools/perf/util/synthetic-events.c | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 03e43a9894d4..d10703090e83 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -168,11 +168,12 @@ int write_padded(struct feat_fd *ff, const void *bf,
 		 size_t count, size_t count_aligned)
 {
 	static const char zero_buf[NAME_ALIGN];
-	int err = do_write(ff, bf, count);
+	int err = count > 0 ? do_write(ff, bf, count) : 0;
 
-	if (!err)
+	if (!err && count_aligned > count) {
+		assert(count_aligned - count < sizeof(zero_buf));
 		err = do_write(ff, zero_buf, count_aligned - count);
-
+	}
 	return err;
 }
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index f8ac2ac2da45..ee6e9c2fb11b 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2401,6 +2401,8 @@ int perf_event__synthesize_features(const struct perf_tool *tool, struct perf_se
 			pr_debug("Error writing feature\n");
 			continue;
 		}
+		write_padded(&ff, /*bf=*/NULL, /*count=*/0,
+			     /*count_aligned=*/PERF_ALIGN(ff.offset, sizeof(u64)) - ff.offset);
 		/* ff.buf may have changed due to realloc in do_write() */
 		fe = ff.buf;
 		memset(fe, 0, sizeof(*fe));
-- 
2.47.1.613.gc27f4b7a9f-goog

