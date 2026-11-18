Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041455;
	b=zLzel50RS22jsi6jJ7czoD/nzwGKsIynmm+kJJGVMDIh/gjwHBTYRDh1iwYbiBlv7lwi
	 Vo6GlC8CwpTIAkY2GFR5hA/zRr672FkNaVun93zK0705UtMknqGTLmrY9Jzz6KuOpp6hq
	 TSbfyMYUtt/CN0nBpZby6kz508z3RPLtsPY4Spbvln5r4knP6TPNom14AdEE2W5YPhAL/
	 siDLE+DHe2pnaA7wLwB+1MhKzcw/V12lw3PdcMsF29IZttJNVwYpABAGQigwHac+mgHBI
	 O2QBM/0fbwFGx5ywNvLDqm2Y1C7z2MIi4DNWhbATSyiX49Yrr6eBHcAAKDFO1xoM2Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041455;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9LdRInN2V1y3ZPpg9EOa+HJr4dqqAI6ntkk/lYsjp5c=;
	b=wLognpCHWuIMYnwOmw64kzbNs+1308jqsrbd6xjpOmpBW+LgyBCJrucm7y1RliGciYpg
	 GxzzLdqkz6k7xoRNEy/19rl0GDBXN5Ori4NURY8GHu0WL/qg0gzjLHok8S/3FabCdybWw
	 5N0fCjHQv/1TlRJTwrXmxkn/AJEvDbEMt9qsimfSDNPo6Vp3I7j5y9gPJJ1bKQGMwNd3U
	 uxZ6cyTaGaKPjZog9dK2UM79Zwlhva+PdlTe6rMCHf17YCWiPIwcwCG+o0IKfqQ5ltbIU
	 QjD8ANBN7wBqQXoSbUtG0PBsZDIE9e8+AAklVNdkZJhPhg6mEBTJrBihJxzgN/DdVzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dqv7dXML;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC20A606A325;
	Wed, 18 Nov 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dqv7dXML
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1191F000C5;
	Wed, 18 Nov 2026 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041455;
	bh=9LdRInN2V1y3ZPpg9EOa+HJr4dqqAI6ntkk/lYsjp5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dqv7dXML1DRcPqzUMqO8A46q0Et90aEn4XQ5tMLrxoXrka5cYXQJJQGcHRqa98OEE
	 My+yd9oogW5Sv34xLpSTooRL25tiZiljnepr+F41RKr8O/hWH8cVNh8OQ7wDMBeaUg
	 Z9ZcWQXezEixTpW5sil8Tc502s8czhvSQ5dWdf459WgYWjZFePfq2XE+4H2iA/QYM7
	 cKY2qKTOcNxk3RWMHxzG1voF/Nxav+/JTZTE07XUaTQMiPb6788mbcwF7xBeGXZP+4
	 LmhmnXxMcqTxcX6S95p52C7rl+tyEQ3u6R/6yVoSxEUfiah9Bh+A0MI8Wo8nmTMD9G
	 Q5ziCUthrZ9AQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 01/13] perf build: Link the jvmti agent and the GTK UI with EXTRA_CFLAGS
Date: Wed, 18 Nov 2026 19:37:12 -0300
Message-ID: <20261118223725.121500-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223725.121500-1-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
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

The jvmti and GTK objects are compiled with EXTRA_CFLAGS but their
shared objects are linked with LDFLAGS only, so flags with link-time
parts never reach them.  With -fprofile-instr-generate the jvmti
agent's __profc counters had no __llvm_profile runtime to write them,
and its files showed 0.00% in the coverage report.

Pass EXTRA_CFLAGS at link time, as the dlfilter rule already does.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153ffcb..e730f1a209cb44a4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -640,7 +640,7 @@ $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
 
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
+	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(EXTRA_CFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
 $(SCRIPTS) : $(OUTPUT)% : %.sh
 	$(QUIET_GEN)$(INSTALL) '$<' '$@'
@@ -791,7 +791,7 @@ $(LIBJVMTI_IN): prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
 endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
-- 
2.56.1

