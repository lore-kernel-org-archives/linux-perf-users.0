Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF924E4C6
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Mar 2025 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360870; cv=none; b=es2OzU4f9dJjHGMMpqfpgajagwxL32N+tgO9GEsiEe7mHhtdTegY8NoYbxDSF9u1C21UQcEVPRnsehgcejUxELHsE0df9b0BagEuvdr233bXdJZB+Bv37GrFIj/CLw2CXygwHa/pusATGZcwC1PAbaAJmanLLlL9jIvjhAhhwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360870; c=relaxed/simple;
	bh=echg6bhB2aBWSvnzX4SOEk+Z9aELKuECpxJgQ98XvbI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=TUrb0ZENr4ZZVvuHZfcwWoDKnFcr5Aw0Ko8yO72S9GViCuC0Hkmy2xTa2GGhXqHHDRWkHhrsFER0ImEdYYxBPx6c4RdOXU9DIbc3SjeVt9Jncw1HwFpFvtrTZ60bItOFox2iT7ZEkbdMrWYHHo29DViAHAdMNBgJ3LrdzXVaV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiaeWK5j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiaeWK5j"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e64124940abso5699584276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360868; x=1742965668; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=abYRMOxViqYMp92GMDii3ruSxpFYmB3QwrQR3Z5L6HY=;
        b=QiaeWK5juIdWWM1ZoRalomqo2NkblnOrNd7lclJjqwX7xegP6QdEqi6DPTztzQzbQG
         HYZ1crGjhJhy5yP7Wdp3e3/Eyq9wVH+iLnf4dSgxaXPeYn5zET2UYfZb9CCpST3hZKOY
         E7I3c07co/dvBOoD5z1Id4mjtEhewtzGi7Vf//a3S9+Ci9Yd1ycSptW2xUVLOyghu9Fn
         SuZ+4vgM/K1nZpKc7HuyO/x6EatBGtHCdOHvF00GA1OWv0p+sJCAr9hiirNfwWX8KQpC
         Bb7W+hlUOfsU+pn/5FQWwZ95wZXyJIKyQT77492FaOc9scnYDf3SIiekrQJDLxdMUf7d
         B1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360868; x=1742965668;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abYRMOxViqYMp92GMDii3ruSxpFYmB3QwrQR3Z5L6HY=;
        b=nZZxtNiEhGgNIngACbVOH0fyxwpj+siklsrruWGgc/pvWvpa7XMrt3DAGsJhfYE8nR
         IwkEd+B+x/GF3q3RQWgTqUww2GzKkOZDk3un1xkXAZe4QChr9gUEcbySA+K/oNLsEUt+
         OmmDLPYX4tYupTxU7Qz1U00ymHdmxzGVcAZ37ugo7YgGuNrPN8M3HmHc8Bruaw5Nf+oU
         maIzR3bQEsutih5fX4WOxNL7j/68f2lIJWW6f/DXlauxG8kLkX5U+C4yMjkHAYX33+ZK
         0i6V7WyuoHfRJOeytuNQzMLrTODTzofEKFUmtlPQT8Hi8dd5vXswC9pADh43BKE47uHb
         XwGw==
X-Forwarded-Encrypted: i=1; AJvYcCUE4WvamLeajnG5+iRRWqA5+hJ9u0vJeXfcnI67pVexDkd7sxYYWw8LYulLkngaLfwLyInvIx8gS/qi5yb1LhF7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2xFgPBAC4s5CxqFY/FOeo3odnnfWrtvr/QLhQEE8dJZ0Af6O
	XF6iQxZ6v/8nk8j1z8qIx/6Ah+MhQXl9wmWr9bsZHudQlckB6BGjqhfGpcC/C+BznOgAcFLiB8f
	7X6FPzw==
X-Google-Smtp-Source: AGHT+IGRmoWaZCuVB5ee3Iv2LzVEuNeEJLA9zgD9tzBFtuvqHm9F4Ignee+o0RWj2MTQlY6HLf9109e/Wj7N
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a25:b323:0:b0:e5b:f74:f5a with SMTP id
 3f1490d57ef6-e667b456dc4mr504276.8.1742360867177; Tue, 18 Mar 2025 22:07:47
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:28 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 01/14] perf dso: Move libunwind dso_data variables into ifdef
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
which is conditionally built on having libunwind support. Make the
variables conditional on libunwind support too.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 846b74510038..2cc1f6593f9e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -155,10 +155,12 @@ struct dso_data {
 	int		 status;
 	u32		 status_seen;
 	u64		 file_size;
+#ifdef HAVE_LIBUNWIND_SUPPORT
 	u64		 elf_base_addr;
 	u64		 debug_frame_offset;
 	u64		 eh_frame_hdr_addr;
 	u64		 eh_frame_hdr_offset;
+#endif
 };
 
 struct dso_bpf_prog {
-- 
2.49.0.rc1.451.g8f38331e32-goog

