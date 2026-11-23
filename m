Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471236;
	b=fT99pDXz3XrjEW8oLet7wjhan45XRCmoDeTy6DTtPgTpghb3mADTHdR02ud3QpDjoYDY
	 AShNJkHjAK9ExnexbBRcVgl6UO/s9Y402D0gx5WBWjVa45HO9ocvAZZ8ah+m31Lukjtpc
	 RhJ+T6Vlk7srd8Edl62A/lzNZknjAjHfRObAQ3lR+FpogrZT43y2GqxWgpp4YAEMqP3KL
	 Pba4KrKxq9EbuAowNtQ4B1K0ensWbSBPriuM031cpne9YYbVf/UaZRVBaY9mpnEu9iuI2
	 GU7sQPCle1ZQATPbz8oixfRF9f41YRlelvqD+3bbtYkP7d0H+zrNebN8kIp5ry6p6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sVVVivoHslApfTcqxM1CCxGzJ/G5HGm6uVal0C5hstg=;
	b=5J7ELfS6IQjwwy9IsTOoJQAwjmXT6Tk2zdC2zkO1c3Hgx1w6rom+D8Vq4YLoGq+Do20H
	 C9UsQkuVQ77eTz7RtWF9qcMdR4lnu+WPk9yc+hkt6B2CHoz6cxnGtxVFCJY9qsQtzmB7X
	 G+gDiA1YRR+E2ioyn4hl6w3ffbwpU8+ht788hYpaVT1sdYwh49WP6Q+Paw5J5UmZ9tTMr
	 KXzV+Rl6kcgMcO1omI00rGpZ7olA+jWOymB4Qdke/J/7aGr+0QuLDvaJNtaBmMsOW+/m4
	 jOUmR6SAWt4pR2ruZdmeM9m8xjSIu5qjEbItAEEXSWSlnohyzWwVw9Ehi6nr1roIQDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4l+Q7t6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C720606A31E;
	Mon, 23 Nov 2026 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4l+Q7t6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1B31F000C4;
	Mon, 23 Nov 2026 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471236;
	bh=sVVVivoHslApfTcqxM1CCxGzJ/G5HGm6uVal0C5hstg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4l+Q7t6eaY6p2wsLf5li3CBJmepl1BtTzv4FU3wDZpirojatiwWlDjih0u5csu35
	 pxgPvtCxm+3Z/2jACX/oJAXTmo/yYpUo20G2VL5rraAEpWB/Z6Og5OIzeD+ynEt0PV
	 WVDKuy86964pmoLlXFNVnA8Km8l477vSLrax18sq23sGArwDkR6qNbcFNFGAI5KuPR
	 u/6W28farNl2ZbssKPldSOQBATT76CUYruvIa97d3ic++psQ00WIwBtAIhal261NUk
	 iH4NGV9w38gmuJrspwjlEq4xGue98jABgUjcN4pJGJg6CegaHxAYlrj0iUHMQ8hZAm
	 6df4PuNNdNn0w==
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
Subject: [PATCH v12 01/19] perf build: Link the GTK UI with EXTRA_CFLAGS
Date: Mon, 23 Nov 2026 19:00:06 -0300
Message-ID: <20261123220024.14891-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

