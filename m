Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231265;
	b=P1zwBgclDrY9Y0Xdl+nqkanjE2r/vP2N6Q4KWtPq3ZPUsDhZQQfUgaBKuUFT7013XrnS
	 QCzn4QYBqIsrkPYwIeMv0lK/Po19GLz3ds2dM8b0H2Zw2+tmqCHWwlUuA0EWkydLYqymK
	 DHSYmvE6wb0C4Rvlm79gL1YAksj6wyHFOfR0QHb5F5cXmZYIKzoE0RC917l5VrGQ0VbLd
	 Fdsr6uxy5YOsmbll4l+1CS8OXCAVIwFoSMizKlQkDCzqPa4wUuk0bBy+/8BtDXt4OJ5rn
	 VKI76qDawHVADCnbkO12vkjUYwQ5tJV+zx8pTzgpvgEu15OucpSOtrvuAytHHxKPPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231265;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sVVVivoHslApfTcqxM1CCxGzJ/G5HGm6uVal0C5hstg=;
	b=qpwDT0dcwCviDVYh4W1K5VhD2UmDehXVs7PDlVp7A65C9Ai76j1MzwGB6IZxQ3zHIP8O
	 CYOPNLKgkJ0oOTmLlafWNq8NGzBcSpSpe4/r1z1Nat2gX2/rMTUpshLf+8YMmTM614cF4
	 GSh3UwCrP5p8ZI+AyqfYotdcbD00lZNFBDlW3wVElSqn4SDqivK+MxFritJfc+qHnkZrL
	 sKJqvb3Vgog+kmAJwfmgz4bIbtJgY3kluNmp2StZpASzu47ZNgSCsZ2+Xs5CaMtOE/9AN
	 MsjZvL3nzXmJIrn9KVasxFh8NLox5bTATTCQxAARr9CinAufy507T+62OSpHJtmMNlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+FCcWmR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F9606A6B1;
	Sat, 21 Nov 2026 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+FCcWmR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC421F000C4;
	Sat, 21 Nov 2026 03:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231265;
	bh=sVVVivoHslApfTcqxM1CCxGzJ/G5HGm6uVal0C5hstg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+FCcWmR15bqqTb6S0AWZ8C6LR9SmBON+MmtUW3BwrrmxcTBCtZ3whPsepjHaf9b2
	 klKbm5AnrEFSDZ6fsZ6k5fNuAZsiyotkISPeHz2BxwW+ns8lV1a6hEYI/O4h2qP3Rd
	 bxiLHPJXsrEIf2g7jvFq5CFYr2OuQJ5EU81yGbcrXipo1F8wHAa+GqW/YwdyXY7+A+
	 EztPyttQn81GULtDdzuqKPMRxGpE70iXQ3/PJn1S2kIBpcMyZ3HuIU+LBWLHdfAyl5
	 W77hK7WMkZRfOCAJ0+Q9SleHRk1HC4LXf3APovKCv1F1GdhtQKMxJvNFKsW4E1qb5i
	 XIOpoEMyT5L0w==
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
Subject: [PATCH v10 01/16] perf build: Link the GTK UI with EXTRA_CFLAGS
Date: Sat, 21 Nov 2026 00:20:37 -0300
Message-ID: <20261121032052.1392234-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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
index 1850ca2eeffe962a..d4b641925ab296db 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -644,7 +644,7 @@ $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
 
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
-	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
+	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(EXTRA_CFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
 $(SCRIPTS) : $(OUTPUT)% : %.sh
 	$(QUIET_GEN)$(INSTALL) '$<' '$@'
-- 
2.56.0

