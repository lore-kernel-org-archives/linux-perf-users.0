Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039047;
	b=rTwYWQP44vIDIoILjn55T4aB12CgyNspMg/lr2dyPqsppIgJ4hx7elFkjClexPYKfJO6
	 ttherTWoCblK+u150vlKkw9SgNSIBZav6NfRPyZg4deLYCeMCIQYQlOAV4/9dhBapTo/i
	 JRZI+NMW9HJRDgCzuIGM1qzCCTOaCtqAbPCrLnvjQ9ffOJJBTkQSyWlmiSbLbeJnjzBwf
	 f2MQepfzl/Bts15qzU71/7fW7MQrD0fbQWDEToGIe5z8sZ8JnoPKidXdGyxzGGTPacwe6
	 DbA9wjrMm4ezkcS1EvzAbCpby2/sdlcN3+fAyiME4NPyKwBSpzpQE7jEUVOSXjeBq3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9LdRInN2V1y3ZPpg9EOa+HJr4dqqAI6ntkk/lYsjp5c=;
	b=tkIrpD5+iYw0cBy40Gb+AmdkJByezg3Eh7Q1RCbArYyDvb0WC3+tGvKezBY55OWL6W9h
	 Mu0FXkUUxeqnxAzuHLgxQ/o/hqYLFOsGQ+hgd8UqyBiyXILs+QrAMl96Wo/OwIsx3GzAm
	 gYy4qISB5t+IAn38pJD1jL1/9Zb7Z4pj28Ei1bPSkBwQRJuZIbaBUTuujl76aeUFf/MHl
	 E/cpi5/kLHYyihLsdamCqREZCsGVK2sV/zGo2IUJwMLH24G45CFURrvBWYE/rKCcFn6g7
	 pfkrUuTN2PxX6edDKyqSytbrZmM+1uLZ0/Llvqv9rUWCIZaUcRwmm9+PdiGZ+gnGzng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mT4lliCv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41826606A31C;
	Wed, 18 Nov 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mT4lliCv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B68E1F000C4;
	Wed, 18 Nov 2026 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039047;
	bh=9LdRInN2V1y3ZPpg9EOa+HJr4dqqAI6ntkk/lYsjp5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mT4lliCvu0TokQdnS2ipmovyxvx7FNdHZPpyunGEpydahwOkkAxiBT3nnqQzxJmhU
	 WG9NBaighuyKDo02y/hMXjR5aZTm8ylilPYYoLgWFqnK/krXyYKn09CPhA3p3E4Ka2
	 +xn4oyF0Jvz9R7Dq+/r5cCewraTBfXJHundRjhfkwdVB9lop8wEmzAu8Twp5mJELb3
	 Sc1cDDOETPdLR2FhN/K+depLN5dCBjqkcCqPjJ2f+HYm0UrjBgX/uQzNTyZp8lrgUf
	 +NOFRLaMb772cGdBRuiI3TqSzDYJrE0iYTZ5M088bZ659e/9jD+egsq+wYsO89m2ts
	 tx5b4H86nvtEQ==
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
Subject: [PATCH v7 01/13] perf build: Link the jvmti agent and the GTK UI with EXTRA_CFLAGS
Date: Wed, 18 Nov 2026 18:57:03 -0300
Message-ID: <20261118215716.114868-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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

