Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBB23BD1B;
	Fri, 20 Jun 2025 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454689; cv=none; b=FqbSXjVpccuyzmOPRvf97g4gbkc6bbxduE1jWUQ+VP8wWaCTBA+TGrZrZl765lqlBfxq4mCu+lyKsZWzNhVulbHWvl83DquzY624Vt5mjlXGKtwvk1LWKbdae0eBYR+/A09EWXL+56NzmuluegBIPcJI+Vuf4sjo+BDk3PuLvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454689; c=relaxed/simple;
	bh=hRaUvXX98gJVxK5Cw0IxQPYU+W+hBJ6gZf5zsYiD/KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eD4Zhc4qascquKflidrqq3rV+uOOZPl86wYrLy3aDfFwFB91K2+mJzQcSEmET1JMvUIEY2dIK4OyvgzKZ/x7uhCcCAzeVXNFak+urscahzum7Uy68hZ6pfRxmrSw4MBAudhPPTd+5vBxGpWk83ja9RFwElmoCZFCmVVcy9QTKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+cTfwkl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+cTfwkl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A9FC4CEF1;
	Fri, 20 Jun 2025 21:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750454688;
	bh=hRaUvXX98gJVxK5Cw0IxQPYU+W+hBJ6gZf5zsYiD/KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+cTfwklBoCJOhNi0SzOAbQrhy/J8NtetMEMUhR4dYjiAASVHQU3ar3u8w0lPplXT
	 dncPu+hZ9jbB5NJ9WfS8qbzBjgH4rhth8hSKpilHlWprlZtBjnKtKkJ3GA3BhXgw+e
	 2DH63GE5laq43gqGJmT+BV7rswHbAa65g2XjcKVp4+xC2Y1+Y6ph26uTzxm4WYHXq1
	 4er+V6P7AQx1p5elt+JGPdrTBym/pxHvZw9EHEJpPzs7PT07VCLRVJy8WRMKWJ1XCg
	 ww7j3QymFxd8Zopr7WVed98nIXkLaCA25uMP3p43OUHGNo9RkZCzK2ELkvBWAJTp23
	 XSYDF8ztigmTw==
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
Subject: [PATCH 2/3] perf build: Add the libpfm devel fedora package name to the hint
Date: Fri, 20 Jun 2025 18:24:34 -0300
Message-ID: <20250620212435.93846-3-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620212435.93846-1-acme@kernel.org>
References: <20250620212435.93846-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just to follow the pattern with other devel packages.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index afebd3b1e6cb9f58..fd03ba83a48ee08b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1157,7 +1157,7 @@ ifndef NO_LIBPFM4
     ASCIIDOC_EXTRA = -aHAVE_LIBPFM=1
     $(call detected,CONFIG_LIBPFM4)
   else
-    $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev)
+    $(warning libpfm4 not found, disables libpfm4 support. Please install libpfm-devel or libpfm4-dev)
   endif
 endif
 
-- 
2.49.0

