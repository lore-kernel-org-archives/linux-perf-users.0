Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEA395266;
	Wed,  8 Apr 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669345; cv=none; b=mGZ18oPkAKKb9/akkffIB3mEfEocTRSSGFf9fwEhixaq9JK6vyw4UOG0re1ITrIrAjKKfbV1X7zWjIOyqPm+cB5JLt0mncbRE3N0JkGTlTODjd/r3QjJ3zAXEbNehNj7dubO0JEeANKtyuLOiKLzut28SGWs4XAcR5o0OsYdNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669345; c=relaxed/simple;
	bh=EShclxNu6pRrud94k4SQiZ8VTYXHzEfH6c2jhDarHLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lcvfue8DIszzO7DciI6Zy2abZc28OcDU+o0Bz35Oyb+KfnjaMxgcMCdfgxGQLkT+5oul3Y5SjO25hjcOUAZWUD7fEolTycmYewN9PTX+VRfgAmI/+nRWKbaCjkjPmRQE0g3sSIECWEnlzbvONdviAzI+JY3Jz2pjnNdyCmH6L/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzj4u6eW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzj4u6eW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE58C19425;
	Wed,  8 Apr 2026 17:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669345;
	bh=EShclxNu6pRrud94k4SQiZ8VTYXHzEfH6c2jhDarHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzj4u6eW52zqQQ0I47CT25wPqgD+mA/Z8ZhYY2t1vXizv/pSDxlvw7//PSXrxbUw0
	 DtzhwuNY9N50DUmX6+jEieSaErTIVcLmiXdVjI4Zy9mVg2LeNwYrrX3iy7cEdjvzqn
	 6LBAQX16MMfvoFq8r3xJifxgZ4MRfkFidQu44dk//qCZt5F4M1WtyipHLCwHyWbZWy
	 6GH1ZCWtw7hG4uJ4pShPn9JRPY9nzhTRgRNhF5RrbJbLPpmomgMfAblVxa9d0CHCuw
	 jcP6OY41f2CKjjtE0LZx9aZRqhvlO0thNilfNNowKZujfortGL4riVWhF+HnDqkWcv
	 FTh9lTHWYsBQA==
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
Subject: [PATCH 1/8] perf symbols: Make variable receiving result strrchr() const
Date: Wed,  8 Apr 2026 14:28:39 -0300
Message-ID: <20260408172846.96360-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408172846.96360-1-acme@kernel.org>
References: <20260408172846.96360-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Fixing:

  util/symbol.c: In function ‘symbol__config_symfs’:
  util/symbol.c:2499:20: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   2499 |         layout_str = strrchr(dir, ',');
        |

With recent gcc/glibc.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b4b30675688dbda5..708375d67b85fd1f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2492,7 +2492,7 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused)
 {
 	char *bf = NULL;
-	char *layout_str;
+	const char *layout_str;
 	char *dir_copy;
 	int ret;
 
-- 
2.53.0

