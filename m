Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634603;
	b=YpFe/ekdm0s+8pEps1l7JhYafSNif6SIFOa5KeINAxML4z+1hf+EA6JNcZLAYKT8Dyla
	 ibkWnrFx1OnKeToQAl3OnxrZrkVV+vkxUKBxEAxCEoPr93VmGTR55qV/59uA4tufVRmRg
	 J1MnMYnvddGu+8CGIEeTjt10058LZXtL8ypeBMP7hgGSatfYLLLiURJ7BFZUhZ2FoOaoe
	 Q0MIKSVekthmB/8In1tnSCZryvkjnxyDRzuw8Sd+1PidhGqq9WJ/cXIM0y1jBGQkg7pRc
	 rOzkQWyC/e7L4WiZS0zTyVmYrkXvCH7sQpgRZ8VyOATE4KpZ75f2jbByO8D+TmtDmGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sVVVivoHslApfTcqxM1CCxGzJ/G5HGm6uVal0C5hstg=;
	b=cmiqyGT4j4BUVuWmHSAbz+wBb7ACYZX+Om1kkMF9WVZoUXiywk48IM9LdLq3LlxA4nfq
	 UTno6RLVaX2BSPjAbAX0dmpkaXLv+1PujyBjwctBtc4UZxcNybI/vDweuv9UwTf7QeO9M
	 rzCtwQepB+4bRJUY+kPLKG5F7xnevp/8f4QwDRDsWRIeV0j+cw4FPvIEteENTvYd2ictJ
	 /5Bo8JyoQcxl7u/5ykuxY0uzM6gjn0pANCi0cBlLSEsJKJpHrqwQtyRYBXiw27t/EmC4o
	 hqo3mZlM5JwGNKlWoumTvlptLyNR/ji1TT8TFuDdnRQS12mmMcMDo5q4D2LjpXHC1gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSnKZXMN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15927606A32A;
	Wed, 25 Nov 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSnKZXMN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27BF1F000D3;
	Wed, 25 Nov 2026 19:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634602;
	bh=sVVVivoHslApfTcqxM1CCxGzJ/G5HGm6uVal0C5hstg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSnKZXMNHRuXcnuvWPUGm0xpBooB3Fy+bABaJTMYHhqxFJHDhdQFsdqk1BMd4hFfD
	 TWG6VS8CDkqcaxf/D6g9zcAWmT5bUb6rsabvrP+KC6AR1RQX775yOL7f/htrybqRF0
	 27R1gVDdrsvfRu1NWt0ax8ZX4dgL3n81FjTLhC+r+2Gk88KZOy289j5aYaKKHQuwD4
	 kZPc2aSQAhnH37vr0C3FuBjdIBIXlJIFa/kCLsjSzSRSiGJXnH/9uWK27FY568Xi8T
	 rHoGKUdq8HVGsRlNO64BQX+lYfArFDSCNoHQkCDICrRXLT9mu3XZgANKMM1IR/UUij
	 NtlJxloF6G2JQ==
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
Subject: [PATCH v13 01/19] perf build: Link the GTK UI with EXTRA_CFLAGS
Date: Wed, 25 Nov 2026 16:22:54 -0300
Message-ID: <20261125192312.34134-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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

