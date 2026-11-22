Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383638;
	b=IIXjcdQaNkvwMP2cLmUD6MBA4Pe3p0jjP0OhCHXhG8RvtUQvheTob1IphZu3i7NsqbHa
	 oB4OGDuvhUlTi/4PGgEkFh90AkchcgB+QPwmCNp0ZYOrrKM9pePF07ipSOQbD/SsUNOz6
	 cuiNfqTEw35jSOEoMOg4TLxDEWvfO976Do7BMLa0mISWaliI/XFdyPY/IVi0E77NmSW/N
	 dmwVWRqUmm9jh8WrLPrLfOz0t7rr581DzwKkExRDG+tw/E+ggwviOXOACgIQ0pccz1uOQ
	 3Nk3d3zo2bvVuIGsrhFwhpVyGkq69XKvSHGkbC58XY6v1FwEfSsMX9mmPNAQ29eG7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383638;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YQhr5YFX/Byx7Gcl2wnHY0B59A1I2rtQNNvPQ48RHIs=;
	b=CiYvcgL8yYgMjKLqZ1cQogkM7dK2Tu5U0czS88kaCP0pKF9D/tRoBwwhRwL2zH+m81yW
	 2r5c0ykQ5MZnDqxwjTERBdkRkuhyvuxU5vaoh8sjCrin2WZbLbS80SMa9XCGkI2JOmv2I
	 NvqxgoSQDNtP31QH1JIw4uNerAVOTBJOZtsWnsr9xKrtP2KrdeQOVTQOKT2FFxm2lYuHa
	 VfMiOidfNGrk1DqdlK0z+4QegOcCAuu07QHPUhcDfnqqxRVYBJ0LvHd+QYLZ73Cx7iLWQ
	 WT9KwpiVYBP0YNmgE8Q1tm7z+x7CXPWoLoCBIv7sJ12p9MRwk3YA0kp5K86p2rQg9DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EePC7BAB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D8606A32A;
	Sun, 22 Nov 2026 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EePC7BAB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D097E1F000D3;
	Sun, 22 Nov 2026 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383637;
	bh=YQhr5YFX/Byx7Gcl2wnHY0B59A1I2rtQNNvPQ48RHIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EePC7BABPQhJpZDk630Zg/R7ohN9DJzrObUSFYRXMCLAy5yeJnYwkIYYZ9f/XlQqd
	 tBPdWy79MDJ4Jcwpn2MjNbAk5ebURCL3mPQLzkafsvLy1ShHTPyXQuFdHDVUTpYoRx
	 CYFtpSjv93soJpjEdupfUFdlWlx06lAOTICfI/Xy4ETJGrhOWOJaW2rxEeFFdw+ab7
	 V9DEySGUrVoFFY+c7TkryWl44o0VPaeEqtd6EDdx3h7lEodgBe3sX/ZO51JZfj317n
	 uSRKo2lsGqdU6+uLaltdkOZqOO1mJX+hY01157mBgWkKrnb6DMDpBIrRn5F+3JBGuO
	 iaxbqIJWjk/nQ==
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
Subject: [PATCH v11 01/19] perf build: Link the GTK UI with EXTRA_CFLAGS
Date: Sun, 22 Nov 2026 18:40:07 -0300
Message-ID: <20261122214025.16769-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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
2.56.1

