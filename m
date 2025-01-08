Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDEA17C20F;
	Wed,  8 Jan 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736329806; cv=none; b=n7iEnz/n9/OLXf8+1llseAgvo26zh4RFq+m112KUX7SodAE6r5H9D7L2FoRballRx3lSrFw/tAJJbCd7tcIRnyLlMOGbRgWTGLlpocN8CasW3wnTitC7JaY0Kykaw2RUk6CPCg2EQw9leP3xPorgwLOY9wEgKPUSb5GnuPelTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736329806; c=relaxed/simple;
	bh=fMnywm9bnkqVZTTf5svtwtKIV+4/C0KaR/yTLNTWiVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egB8kyE+In6wwFXfuF7r6XHDNCN/tYUxHe8KuVXIMuWyvyOHLcqvsKQ8wayksPpUjAZdHuPq+tzQdLE7IgtLLNvHeoI2eUSB9FYazBEpgK2ekMvi9EolqOBtseSgEBeI2RysbokGH4mKAFqPQlxxdtexDN4j59JVx625n7d0Xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YSj1z29jRz9sTK;
	Wed,  8 Jan 2025 10:15:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JXqH98mUMs-g; Wed,  8 Jan 2025 10:15:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YSj1v6vHVz9sT8;
	Wed,  8 Jan 2025 10:15:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D9C028B768;
	Wed,  8 Jan 2025 10:15:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id W3lE1VrnDTXq; Wed,  8 Jan 2025 10:15:31 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F0D38B767;
	Wed,  8 Jan 2025 10:15:31 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Song Liu <songliubraving@fb.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf machine: Don't ignore _etext when not a text symbol
Date: Wed,  8 Jan 2025 10:15:24 +0100
Message-ID: <b3ee1994d95257cb7f2de037c5030ba7d1bed404.1736327613.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736327725; l=940; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=fMnywm9bnkqVZTTf5svtwtKIV+4/C0KaR/yTLNTWiVo=; b=s9cyyvTfb0vXSaQrRB5BruTpr5EI+jmIh8y1bJ2ybVcZt3u3PtHv36xGPGd4sUysOlNIOSKAG 2yZTi7DoS9wCVspFcZ8zuWY0khKJccyXtpURJmZyTlXrIkXf90B8nig
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Depending on how vmlinux.lds is written, _etext might be the very
first data symbol instead of the very last text symbol.

Don't require it to be a text symbol, accept any symbol type.

Fixes: ed9adb2035b5 ("perf machine: Read also the end of the kernel")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 27d5345d2b30..9be2f4479f52 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1003,7 +1003,7 @@ static int machine__get_running_kernel_start(struct machine *machine,
 
 	err = kallsyms__get_symbol_start(filename, "_edata", &addr);
 	if (err)
-		err = kallsyms__get_function_start(filename, "_etext", &addr);
+		err = kallsyms__get_symbol_start(filename, "_etext", &addr);
 	if (!err)
 		*end = addr;
 
-- 
2.47.0

