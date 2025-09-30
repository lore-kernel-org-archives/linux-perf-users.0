Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15AD270EA5
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200372; cv=none; b=TMdMzBin00Ey9uJ9daND9x6Bm2z8WckpkM7ZSb9f5Oq89/Fy+Znkkgee8eELdMvM4FMcMtgviticCvFy/3SAufjTeSFiwT+4mGOZrCUUZdFCLU/EgdVebJK5cqA51/Q1zB5aUzGXEwfL3lc9EkA6QBoyH06WQvSDR1Gf0UFre7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200372; c=relaxed/simple;
	bh=1x1tZkclSlUAFkeAbCTbg9ur9vKYhrQAjAn0c+iWPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvHO6j9Ubu6fLCvhDULQMONFkLsMJqe3IK7c4giUz1iyJ8G4qe/WNQAsg80p1TXZoLujf9Pbecou/iO5FCBHvbq5GG69u+0fA6vSx9pzsgLo/EG+2pYDIBT9vm7uQTH6CiaNdQbjYkdQgIdO5P/w/UWtr2W8TVaoJ/AgQ1hGpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD+28C8I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD+28C8I"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698384978dso39122915ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200370; x=1759805170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=GD+28C8IUPvPybTav2nSS/vfj11laS+g6x4FMtRKDrg3QGJgVIb6VedaPqMxB3SpB0
         3gTNvyiTrJIg6YqhoHZgmnXsd1WHyDJrUrPuAjVQLkuAHt5Ez8sZ2gbP1Q/Y0+8fkpnE
         w6rHB1gdgfhM5iJfg+xpCr3uT+K2D7kVhWikJum0aAbMyVnQClxJJDuIpPQUy2bEUeUb
         3c/LPOFfuLI3+gzDMRGqmPn5AfOY0N9A2uDReaMBYHslN1Tp/vHVAwso7qTYFkFZd9ao
         8fQKAYcL+5FuME8Ha8G1FwAgZ3TeTKWIbMg6nT8+BZGTJmos1M/W0pwoJ8rHf54otuNH
         xmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200370; x=1759805170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6dXdR7Vr7GvNxroOAYy+aBhMqtIGh2YpUvjEzBf0MIg=;
        b=I/C4bblEkbUM9Y97vBF1atpST8N52dmerozOYB8qZSZbP0tbCAOB/LQ64MJhCdQQhu
         k4pggdvOHJAwkXXSStFpAzTVXe5hsuZNDn70oRKi6urVyC2250Na7hxPcqXoOylU+J4a
         ek4e0zgDzCp4JsR+PJK+ZkTg8G58eOYK54DYEg66Nh7xveHiZw5OHlaNx7JsUXnE7K3+
         hFLR2kCKR0kIq+7nm2XKMjN4eVFJb18WQEw0tndFM8qdNGxOHnG0Gbd7ru8wEopYiY3G
         pIfHLp5RnMENP24N1TsHJG8irl5ZIsYcDTQeUvM57xsj1mRMLS0rV86mog5vCuV7Kg6/
         w1gw==
X-Forwarded-Encrypted: i=1; AJvYcCXQlZRe5ck0oy50kZl0MwhUvm6R2JqnVIZf+6dGKRYVvEGIjOMp3T/cmbR4f0GU58F08YblxzMVE5D7Oca9Vw64@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+17uQTreKyIMvR6n5Y6tPVyL1A+Z1NRXLhhA3Dzx3jcdytWa
	QjUgsShytswDAMs4Bv4Tw1idlkz9aQapOZCTEFT6GDBz7et/O12rcrx7
X-Gm-Gg: ASbGnctzuIG91x1u7nNqccIdVQJ1lons6Oi9MWE2h5x9vLFfSlN/IDbPGxYHkUhHs7b
	vqxx/3uIs40DggQ7qv6rTXeW7megh6zrav/q6Mlgn1ACvRKaWixk3PlyOizRoBbkejKWMaRC0MI
	sVMiTU2HUYaVH5r7TeacSOed12Sz7OPvJuwbePp9Dfv/BZF1BTvIztJ7sjA1/lHG5W2qHyrnN3m
	7uh9owVuemm/CcCrVJNJof1IgkxNWtEd0QDDi4xPxrdkFUyLUBOz3tIV0y6tBes6TeBCSIrxXcm
	aTTHTcjtubjztejPp11EUvicn6TZkpI/Kkc6OKpDcgFcz4frchAPPWucFK2yyFDNdIgc+pCfGSv
	xLVfadjT1xlzlCUKWWqiNjlHMCwSOg7UfoF/w8qmyZnWLSjyXWOrWXr/LduUCn9yWiA==
X-Google-Smtp-Source: AGHT+IEoEe43JjNKdWndUwta+OzzU/8noer3nQDRA4tPEoZN9FB7in6q7dddTrTKlJfmrNdEMUXFZw==
X-Received: by 2002:a17:902:f9c6:b0:275:2aac:fef8 with SMTP id d9443c01a7336-27ed4a78d81mr138634555ad.38.1759200370200;
        Mon, 29 Sep 2025 19:46:10 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6715f0esm144277015ad.52.2025.09.29.19.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:46:09 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v6 23/23] MAINTAINERS: add entry for KStackWatch
Date: Tue, 30 Sep 2025 10:43:44 +0800
Message-ID: <20250930024402.1043776-24-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a maintainer entry for Kernel Stack Watch.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3..3d4811ff3631 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13362,6 +13362,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
 F:	Documentation/dev-tools/kselftest*
 F:	tools/testing/selftests/
 
+KERNEL STACK WATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+S:	Maintained
+F:	Documentation/dev-tools/kstackwatch.rst
+F:	include/linux/kstackwatch_types.h
+F:	mm/kstackwatch/
+F:	tools/kstackwatch/
+
 KERNEL SMB3 SERVER (KSMBD)
 M:	Namjae Jeon <linkinjeon@kernel.org>
 M:	Namjae Jeon <linkinjeon@samba.org>
-- 
2.43.0

