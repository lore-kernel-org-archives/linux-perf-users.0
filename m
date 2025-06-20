Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418122154F;
	Fri, 20 Jun 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454686; cv=none; b=tksS0gyn1Op6d4QlkPIgIdh1vbxrL+Db04XFZRDS/HG2di+so9r7F3hpQiNfgiIoPVcrBWz0s4MRgQQ820UVFvgnNH4i9kJVhfVntxfJ/mZjN16teZ3w2vZ1nGxkJPz8VZRXOXPnpyGNWoaLAn2o7uiSiY7FiXEOFdDFK1GgXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454686; c=relaxed/simple;
	bh=/hSkjtEDlXrR0ho4M/i5ZK6Ma3bmlxF8RIl+NX9kMEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=es7zvFGbUAoSPQ7FPW8i7q5ob1JdDhxlszPmbATm1d8C0e3IEupyNLHWPabGnxsgfw/2JIks6IbaVsnQsQklcXprjfAfF/E3VJsGYs5a5kZJU8sOWTNXvO6rxygGKBaKQdI+D3KbfEvcnfiKLJQZVX3p8lAusuA2YKk0DrE+GkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7pOcoC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7pOcoC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE1FC4CEEE;
	Fri, 20 Jun 2025 21:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750454685;
	bh=/hSkjtEDlXrR0ho4M/i5ZK6Ma3bmlxF8RIl+NX9kMEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7pOcoC5m7YwdeLSvb5VH4YdhDYucn7Ld42fUY49n9wsuMjg+CqV+e179FvQO7UYT
	 URZ3Nr0Ix0M5BBqQ2a+SVimiQyHvwvjVen0ZJcqbSTME1Ayp7lOVTKWokCfC/t43tA
	 phEm+qxrmAqpVYxxad7SRppGjI+XKOiESyT8mSswVKxA/WAxDQpEaQYEWTzj/aSxPa
	 QvwKfTz7WSADCzZGZjGx6GxpxGiz0haX4j/S9Ud5U4bch7dXsYlfUjCP7k4U6Ef+VD
	 pCAW0DvN5Vz0zu08rok8kBZqf/WwRR6XGnSANGw0nkt1m6i1AlX+px/CM2R/CqncDu
	 2+ivwWMtM/BzQ==
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
Subject: [PATCH 1/3] perf build: Suggest java-latest-openjdk-devel instead of old 1.8.0 one
Date: Fri, 20 Jun 2025 18:24:33 -0300
Message-ID: <20250620212435.93846-2-acme@kernel.org>
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

Just tidying up the suggestion to pick the latest and not some specific
version.

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
index d1ea7bf449647eb2..afebd3b1e6cb9f58 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1144,7 +1144,7 @@ ifndef NO_JVMTI
       endif
     endif # NO_JVMTI_CMLR
   else
-    $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel)
+    $(warning No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-latest-openjdk-devel)
     NO_JVMTI := 1
   endif
 endif
-- 
2.49.0

