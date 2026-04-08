Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431793D668E;
	Wed,  8 Apr 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669349; cv=none; b=CFKaaljGZtk9kr/vHBaJlIh+G7loxSYFGjruaNsWFvvxHrOZ5KMvQnEhVhVPZa0bfSO3f9IaVH7vAOUCzYZKZfyzfS+lMQHk9oGYhzRO/Nilgz5MDJIuXnRJulGEMOdraU5BKwNibPSx9nlSoUklLh3r7odrissMEJmAdr77Km8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669349; c=relaxed/simple;
	bh=HbJ7sM0ZRYJQnV7G5bpqZIrpwmMLTALc9DKvcWNeLkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glu8imhuzsbTeZjHueLF340yOXMYAkuMXw+vLkOHC16Px0m+pwuyreWS6wFSuRcvZ2rVViaO7S6/4rv9mtl9PrNuZIHYVI+KPdBuPixXuAk156bi2TIub03ku4v/hcIoBDBpmGg+yQ/wCQqVT5yFSb+/Wo3DJ5620jKmO9OBDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apPbKxzc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apPbKxzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78F6C19421;
	Wed,  8 Apr 2026 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669349;
	bh=HbJ7sM0ZRYJQnV7G5bpqZIrpwmMLTALc9DKvcWNeLkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apPbKxzcnA6m++EJ6DKlGdr9rp6RI30WhKS2ibp5lnYEHsErL1c++DXfE/1d31F4U
	 iX55FJs8fp2kqL6Mvii87qG6vqomHrXi/FotQ6aUqcOBbA3L9ai19gYLEbB1f2C7my
	 fnP7E67D00IXlSxxf9wrzkz1qOVVLiCaYOhOw0gRQAbefe6YU+MUSqhdFox/O+IFTX
	 5g65NY8X87zRSeh9N+CZXEgHk6DmH9FmYrDiq7ttUmrpt3fDSFuqOY3v67Dv4iXyvV
	 vZLeDc1G4BLZr7rIJeY1D5mJl5nQUYs4pAAuty0fSL2HfpwRs06pR/WiFCrPl/EigQ
	 iOUriV5TwQXUw==
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
Subject: [PATCH 2/8] perf util: Kill die() prototype, dead for a long time
Date: Wed,  8 Apr 2026 14:28:40 -0300
Message-ID: <20260408172846.96360-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408172846.96360-1-acme@kernel.org>
References: <20260408172846.96360-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In fef2a735167a827a ("perf tools: Kill die()") the die() function was
removed, but not the prototype in util.h, now when building with
LIBPERL=1, during a 'make -C tools/perf build-test' routine test, it is
failing as perl likes die() calls and then this clashes with this
remnant, remove it.

Fixes: fef2a735167a827a ("perf tools: Kill die()")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 394dbfa944ac706c..e935438451b81fda 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -30,7 +30,6 @@ extern bool perf_guest;
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-void die(const char *err, ...) __noreturn __printf(1, 2);
 
 struct dirent;
 struct strlist;
-- 
2.53.0

