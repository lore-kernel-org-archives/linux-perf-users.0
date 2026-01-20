Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D92D662F;
	Tue, 20 Jan 2026 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947085; cv=none; b=WfzbRzbDjtV54pa0i5YGHVb/dZwNUi7QFtvRV1ACtP9pyYxJoBP3TMRgvf8hEdPn5r1rhdqOaplFk9Vah1heA+DHqwcSh6AHE1sGvtyEMthxDCivcffM5Qa+VE7MpVFLEk+oit3EWrVVLlotxdjOA5Z5UcqtMdJ9CZyEV3JFcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947085; c=relaxed/simple;
	bh=RxIm06w4RCsyoUx1X3ErpEBF6qQYRq4597Bqwj1grxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tshngWwGfPg5R5ydekZMIxYRiguDbRBgTaOQCfVvwwEaKirF+qvgOtUQ4t8bWYeofoNBXdroBql7M8eWtsWsI+gyrSsQt4/yhvhJtk4M5KkZzeEehcPctltaSu5p+AM5kC0I3qF6v8HcKbM0+jgaY9OMuOXBwieBg7W+b0v9gKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVm/d9yc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVm/d9yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F10FC2BC86;
	Tue, 20 Jan 2026 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947084;
	bh=RxIm06w4RCsyoUx1X3ErpEBF6qQYRq4597Bqwj1grxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVm/d9ycqmM7ttaNF6+TX+xpidQbJpIgFRJAJVcGgtL0lCxcM1hCtm05TgMofdHcr
	 wF27FYdqicukK9bjJdAgSUq3tXEeHfcU6/Hfsma5Exhtn7EHNknYDtsxFMnBXLBpkk
	 cKXIuGs0lgstcRPFBmuHJNOp9eQYPVqQklHbiWa9HYLg3dr3sIQH0GVZ8eEWM23wNe
	 PusyvFLDu9zmMOfB7RJd87E8rv1bk8o3RKOguA/40Hf2cwhmtPJq6SpyxVbGj/nkDa
	 l9DJzBzdftFJMU0e4d7sZ5CDkElM0Cdq3TdUIneLu5JxR9+X1nih+vUI/Wua5sOPbp
	 R0FwoY3vboJqw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 3/4] perf list: Don't write to const memory
Date: Tue, 20 Jan 2026 19:08:59 -0300
Message-ID: <20260120220900.366451-4-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120220900.366451-1-acme@kernel.org>
References: <20260120220900.366451-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Something now detected on fedora 44, where strchr() returns const if it
is passed a const pointer:

  util/print-events.c: In function 'print_sdt_events':
  util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     89 |                 char *bid = strchr(sdt_name->s, '@');
        |                             ^~~~~~

Fix it by using strnchr() if strchr finds the separator instead of
temporarily scrubbing it with '\0'.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/print-events.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 8f3ed83853a9e468..898cf426509790cd 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 		} else {
 			next_sdt_name = strlist__next(sdt_name);
 			if (next_sdt_name) {
-				char *bid2 = strchr(next_sdt_name->s, '@');
-
-				if (bid2)
-					*bid2 = '\0';
-				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
-					show_detail = true;
-				if (bid2)
-					*bid2 = '@';
+				const char *bid2 = strchr(next_sdt_name->s, '@');
+
+				show_detail = bid2 ?
+						strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0 :
+						strcmp(sdt_name->s, next_sdt_name->s) == 0;
 			}
 		}
 		last_sdt_name = sdt_name->s;
-- 
2.52.0

