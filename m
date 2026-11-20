Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138350;
	b=IWhwVX+6aRjCtfgAz+dOxW2NnA+aRneTAgvnkn4UneHXkOczbRN7aIJqrOOCOhquRb8J
	 vK7X5hgrYYTiZNlOp2DC2VlXpNcEpVFtpZT0kINRpetrRv1DUDcF7APe0Pq87d1ML4nSy
	 em7FJTjGp4dvf+V9JlWkbpSdcyoBhFUVA1ev5FYoLFd2/ZiVLzD8Z/yXNWj6U+BVnPnHd
	 0Re4y8FeGrGdjS7xniV4+PWeJcsAtpKb9+7Jq74CGL8WAneGrm6QAx0oHWo88r2P9IDmt
	 GzmT6pptk0RAATgfX+3xqVe7dAH/tMXgILl9CZR8tICNHPhH+bN0mkY5KsMm3SwBgFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qvJ81lB0oIwJTR7pjMR/qSf5fWit2McJfVj2tQ03k2E=;
	b=dLTMy2qAlRuBJs9TQGCGpUkUt4LT2lIFqTyuEUxeeVvTkpx8DPf5/FZa8Uj+8fKO4IQm
	 YWDYCz6d6uGSG9xakCssXE3i9f9W3/Y+iylRmKDdN6qt5ljzvY5SoPqFvghWa1eyiEo+G
	 4y17WbDOVH9/iTOpH5hjn+5Lwr0269xnsgIgs0UQI+g+E7lGpKcGAq9OA+oAO/Wr1tuIx
	 JwsomZWae2CLigrUL9FCuuL2AZLLOGx/zhogCDZMYlTncTt/+NN8Y9ciEOReBOKQlHYSL
	 CN2CmcnYniWudIx826NxFvZvPMiOc09+AST94Usw35gIHAIc5AIMzeG19A507YkZQ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbm0znfy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445E606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fbm0znfy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977431F000D1;
	Fri, 20 Nov 2026 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138350;
	bh=qvJ81lB0oIwJTR7pjMR/qSf5fWit2McJfVj2tQ03k2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fbm0znfy7vIs2GsmC0jH4z9VuqkbSCOEZ1rLnsAi/554FgW3MzFBmpxkLii2k2gFz
	 kUJ9UT+XatR0t5aSV+dmmtEvpMsgU+g5o77VIbp1z3IHHmAlZzSEwRrmuLF9P/k4lq
	 uwZawqtJ4+8FzOeCZr78l4mT63CfEccjhaqFsjBiNEmw7SveOif2Je2EQ88MN4i3sG
	 5ibRfoLNwBcI9c2G+6Z5aviPdFCXCqjnu4tM3HmA4lxnXZdMCzT7MAwgP5mD2doH/D
	 95t1+XqAYQo3GwOsei1fmyfW/8ZzntPmGTbShEiwH/anVzB4addRrAFCF/l/WtUs84
	 pII40/WZ66cQw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 01/13] perf build: Link the GTK UI with EXTRA_CFLAGS
Date: Thu, 19 Nov 2026 22:31:56 -0300
Message-ID: <20261120013211.1510-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The GTK objects are compiled with EXTRA_CFLAGS but libperf-gtk.so is
linked with LDFLAGS only, so flags with link-time parts never reach it.
With -fprofile-instr-generate the profiler runtime is missing at link
time.  Pass EXTRA_CFLAGS at link time, as the dlfilter rule does.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9f3e248d5c4efff8..e730f1a209cb44a4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -640,7 +640,7 @@ $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
 
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
+	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(EXTRA_CFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
 $(SCRIPTS) : $(OUTPUT)% : %.sh
 	$(QUIET_GEN)$(INSTALL) '$<' '$@'
-- 
2.56.1

