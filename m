Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEB20469B
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096217; cv=none; b=ojb+E3Z4f42d5rWZFHazP2Tg3ZKBuC1RLyPB6R6qpqOwXwaJ7Lh62QGW7cCiuA8pQkd+0kXp5mo6g+c3GIq04rDFBrkU+PYZEIxys3aGl2Bf21WoEcwduL51todfKhVyJYie6INh028C8/QTAz3TmY7A8PLmQ1q/19pZcNG+LiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096217; c=relaxed/simple;
	bh=VIqcZfiOk0OaZ2h4QCbBt4ZSsIFKt9GBkYKdO7Qnc0c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NcDzzW/TTD1gBUrx9GnSjxMbBwz618rB1ffKGhGYPcpeMU0p9pdCTqlFC6pUH8+U4PysyWWmm1p2zSohltSwYOulLszZtmjyY3/Z/B9p501wMPGQxhgI4zpiHKnZ85kZtfkqWt97C5ONQ2hVqoxN2Sr/4ncIPDnrMCwJtwqQllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDilSD43; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDilSD43"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394036c0efso36424905e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 05:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096214; x=1741701014; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GF053zzKXV4TcXq6EZaCYpeQukmq+2ermGWSI6/DtXs=;
        b=HDilSD43tNNGNcQVdTKt90SYKEr3jWLnTGKnX5W/GhfMawuDA/jsz5RHAUc5JHbOVf
         DEIa3RheQ9u6CA/Cy9JbNfDhtJGRa3DBEO8/BmYvIv/JohWjnIMuLX6wGC8YqPd8u1Wg
         C8apHrjamlbIs5bDJwXTQFQzIYvjxgJMTN02LrTqE3/RiEE3a9vKHnF1VFNF+QHKtbl7
         dXw6M7PDwpR8ETD3s7GlQqRQBBgcloawZPFQoyNLNg4feEqeAl8qg4m0ji7ykLb8epjG
         0FcLsyyR0UvWpynFyHPr4ZcHUK6GGLrzT6xMWuGrCfpKvi+uaEozUvSDv+9K5LGnSSNI
         Ul7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096214; x=1741701014;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF053zzKXV4TcXq6EZaCYpeQukmq+2ermGWSI6/DtXs=;
        b=ayONAcrzECHLrwf92UXw91qtAwUdLeefJRrG4jiBwdrMdSDLeXnyMLpUjw7PBV8mC6
         k/IvR4xbAN9pDxLzV7gQZNEVQo7dMH7aUeDmO8422z7iJ88PSGfOvYHe4Gl/M4H+szKt
         qlsDCYQYoSpEmGJjh/cgZafsVqpPNS2CM24qYX73HRuREoyGvuKCw3fMqEPcbZR8e2BI
         EDp0s6DmVqmwpFKwR2A9XNKGzI/8NMTXDS62mWTPUOg2COChZoH10EfMn3SHJJgJ42RG
         UZwGJ9TZoGJTQ84TdKooHppf+AJHNsV0T05vOVZ0Eb5hgKC0cgZDnYBZkUD+SKg3hQ30
         rTNA==
X-Gm-Message-State: AOJu0Yz24VxHzvUgWFwBRHj8cKvzw8dQG1Qr9L1oF6Z2gfJZmuWRoVhv
	L4Vgvw5Rs/haFsvxuFSsz+In/TJnrAtJVV0wXJOMJy0SV/ETtifPQHS+0Dsr0EI+47zYKj2hsf9
	8rI8=
X-Gm-Gg: ASbGncvTW8KC2ysPVabKkhCMfLYsKN9KXQOXsiFI+ldMvnCFK0SgbDdFHyPNymtK5Nv
	iSseSKwwVDDu1zLDjPFree8Satj8vO87RKIWloIN1pgIgY0sfEnkMFbBVB1sD+ng/reyeQUGtFX
	VkNRFCUt/gkURvn6SWqt+E9T3H/J3hk8X1oysSqLs1/xNt7dC8aqVL8yl87aX/RoHrhlC4Jq6EM
	fxTKQJH70DG+MLioTiv4UkfTZNf06mYEpO+nLjaAEzpJqmsbPNOPgL4mAPAd2aPzmdfIIviADB6
	ymH8CknOFqwT1IhJc8ZJ+Wjc3iudbuGlLiH2IfHlor78qoq3
X-Google-Smtp-Source: AGHT+IGbdm2bSX/GRgVRkuVD6qCgZWkLZAlu4OLR1FMdBVqYgxPW5Ql3R1YZzWMUfz3c/ALaXTMdpw==
X-Received: by 2002:a05:600c:3b1b:b0:43b:cc3c:60ca with SMTP id 5b1f17b1804b1-43bcc3c61ccmr18071935e9.21.1741096213994;
        Tue, 04 Mar 2025 05:50:13 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cf2sm18096697f8f.59.2025.03.04.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:50:13 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf list: Collapse similar events across PMUs
Date: Tue, 04 Mar 2025 13:49:12 +0000
Message-Id: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgEx2cC/x3MSQqAMAxA0atI1gZaByheRVxUTTXiRCKiiHe3u
 HyL/x9QEiaFKnlA6GTlbY2waQLd6NeBkPtoyExWmtwUOPmFFHeSgOPdCvc4sx5obeuc60KRlx5
 ivAsFvv5x3bzvB472/5doAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Some changes related to the discussion here [1] about deduplication of
PMUs. This change stands on its own right now, but it may not go far
enough. This can either be dropped for now or applied and improved
later. Extra ideas are as follows.

Treating alphanumeric suffixes as duplicate has been slightly
problematic due to marketing strings having looks-like-but-not-actually
alphanumeric suffixes. For example 'cpum_cf' and now the one digit
longer than before 'cortex-a720'. The easy fix is to increase the
minimum length considered for deduplication as suggested [1], but as
also mentioned, the current mrvl_ddr_pmu PMU names don't zero pad the
address, meaning that > 2 alphanumeric suffixes are already technically
not enough to deduplicate the same PMUs. They could have only a 2 digit
alphanumeric address suffix. Increasing the minimum digits feels a bit
like kicking the can down the road and it places awkward limitations on
marketing names which we have no control over. Also I'm not sure helps
the following much:

The problem is that arm_cmn_[n] PMUs have a numeric suffix, but they can
have different events. Even if we were adding this PMU today, keeping
the suffix rule in mind, it would be difficult to come up with a suffix
that differentiates the different ones. Flavour words might work, but
that complicates the kernel which would have to group them and come up
with flavours rather than just doing an i++. Deduplicating too
aggressively on only PMU name suffix means only arm_cmn_1's events get
listed, missing other events, and it's hard to see which events relate
to which PMU.

Therefore in addition to the changes in this patchset I'd like to look
into:

 * Collapsing duplicate PMU names into ranges, for example
   arm_pmu_v3_[0-4], rather than simply concatenating names as done in
   this patchset
 * Deduplicate uncore based on the contents of events/ rather than just
   the suffix

As some background, the original commit for deduplication, commit
3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
mentions reducing the number of duplicate PMUs, and is presumably
motivated by usability. But there are also other commits mentioning
reducing openat()s, for example lazily loading formats 504026412162
("perf pmu: Make the loading of formats lazy"). Deduplicating based on
the contents of the events/ folder is somewhat in contention with this
reduction, but could be done along side some more lazy loading (like of
the terms) and hashing the result of readdir() without opening any of
the contents. JSON tables can have event name hashes calculated at build
time if we want to consider them for deduplication too.

Then with the events hash, PMU's can be sorted based on this and the
'Unit:' string can be constructed with a set of values that collapses
adjacent suffixes to display as ranges. I believe that could remove the
need for any further changes to duplication based on suffix, but still
avoids over deduplication.

[1]: https://lore.kernel.org/linux-perf-users/CAP-5=fW_Sq4iFxoWPWuixz9fMLBPyPUO0RG0KPbYa-5T0DZbTA@mail.gmail.com/

---
James Clark (3):
      perf list: Order events by event name before PMU name
      perf list: Collapse similar events across PMUs
      perf list: Don't deduplicate core PMUs when listing events

 tools/perf/builtin-list.c      |  2 +
 tools/perf/util/pmu.c          |  5 ++-
 tools/perf/util/pmu.h          |  2 +
 tools/perf/util/pmus.c         | 95 ++++++++++++++++++++++++++++++++++--------
 tools/perf/util/print-events.h |  1 +
 5 files changed, 86 insertions(+), 19 deletions(-)
---
base-commit: 7788ad59d1d9617792037a83513be5b1dd14150f
change-id: 20250304-james-perf-hybrid-list-11b888cf435a

Best regards,
-- 
James Clark <james.clark@linaro.org>

