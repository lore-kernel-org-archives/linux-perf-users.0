Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63722DAFA0;
	Wed, 25 Jun 2025 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883080; cv=none; b=kqAbz1qeLoJbYL7uXn1LXg0Ne4XbQN2G1f+MqoNt4QaKEhE/SMKO413lem7tVbVbelUFuVs6wLd15RsXW/44auWbOxxnT+pgBKjuxCFZHWgvn2MnuSAQ23FgDjVjkBPo0ZGDsfiewkZ8muD0vpDzY4wk9OTfZtju4EUbjqGztp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883080; c=relaxed/simple;
	bh=zfnOd71bAojm5iGKAe8Q4ThsKf2XWKTnmyK+ej0sZv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRpAtF6adCJKt/656by8UCVdbL79TF50jak7p6krLXzk11mZVXk+YT2nB+0Jhc6wspf29UOEWEhgPb/fFncYMqWvDHaOhdTllivBJQJZ5dUDufFGbP75zAHHv+UEiR3taYm9QBDHryklB2TZBTglivmSexuH71rjT0cilaqzYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7peBvLa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7peBvLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AEAC4CEEE;
	Wed, 25 Jun 2025 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750883080;
	bh=zfnOd71bAojm5iGKAe8Q4ThsKf2XWKTnmyK+ej0sZv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7peBvLaTZJyfoQ3G3IlhQEBpIKWpFmXasW6RJvXLt9dNVM41B0mj5UvVt9cdyIiy
	 TTVGHsB9U70fg3y0+mDB4qrsfVm6XMW/Gl9iNi+BvKIlgtytNZTWr3bq9Ro8RiIoJP
	 q9b/xfmXtydXX9PFJFKDNlKxSpC9TuHIxnju0lpF6P0dgJStXi6D36IJxahHhcxg2R
	 HKjcM22gDS4hSWJ8qppRYQw/XdSySZ+jWERIZisJikf1edtlczP+XuG58zj9s646JV
	 HeIMHEgiZyZANaEHEpBFY3A0wLoIMR/Pf1oXziY6Tz/KP7kFOEcgxm5fW6Ll/n2rQ8
	 fDTGqhpCkJpOQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v3 1/4] perf build: enable -fno-strict-aliasing
Date: Wed, 25 Jun 2025 13:23:08 -0700
Message-ID: <20250625202311.23244-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625202311.23244-1-ebiggers@kernel.org>
References: <20250625202311.23244-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf pulls in code from kernel headers that assumes it is being built
with -fno-strict-aliasing, namely put_unaligned_*() from
<linux/unaligned.h> which write the data using packed structs that lack
the may_alias attribute.  Enable -fno-strict-aliasing to prevent
miscompilations in sha1.c which would otherwise occur due to this issue.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 tools/perf/Makefile.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 24736b0bbb302..70a3e771c7c08 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,10 +17,14 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
+# This is required because the kernel is built with this and some of the code
+# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
+CFLAGS += -fno-strict-aliasing
+
 # Enabled Wthread-safety analysis for clang builds.
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -Wthread-safety
 endif
 
-- 
2.50.0

