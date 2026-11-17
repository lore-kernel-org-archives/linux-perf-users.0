Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945883;
	b=RZ+B8nb+Dd4ocyQ8ss/Bkm0CJZfMLZd9kxMhlO4KXicmcSb5kfEB6xzmbJxK9UlMPS9i
	 sNipzNg2JCYiWkyCV5yAvlOQkbGL4YnbevGo2k8s4PqA50XdobXCeOi5oHq4TYDsXYUNk
	 0Dqc7hYgLHKHWA/Ju0CFb2pJD9bfYb2F4pg1AFIYxR7MygST2cobzO3LUQ84/d3UvU0T0
	 QOpGWBXaP/RPWvdKxRjGrjnbYMzieIY3JUBh6C+8J97b0Gxs245nBkOktD0NlxNVF8VNh
	 mzwSEHB5zAIVThFcb5KOwefJflr7KoRxz2qni5WLyQaF5Q/BN4gsOrnHUWzE3QWkyUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=47jgWnh4CBhKGYBuXtPVazQvDNIMjjTFA/rc5fvwvCM=;
	b=j764iJansohG86LQj0cdn50XLgwfWtdGuXieq6fkcMOWxRTyrzPsYrn5CsF5BRTHOqGj
	 mmp6yKkysU867cj5gN4EByudB/gyRTdEKFH2a+1XpGG3FI7+u4cbSkLi92hPCIiFXkVub
	 weic/SIUVb2LyAlbNWbl6oUO2nhxj5dVg6P13vRbPYNF5X51gc+VOUju5bYAJPeFhKp/+
	 HB+AMcDn1vAX6IX5j7WV+42uTeK16I2lcAv3naWhvFhPOnsGw6VdjnBbUKm2h7gr2/3PL
	 uk8/IjP2AG0wZEoqFjrUTydoYzIR4/rfYmDn0yuFAU1ryCZoKvSU73KffYBAKRW/MvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdxdVzul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D229606A336;
	Tue, 17 Nov 2026 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdxdVzul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13851F000C4;
	Tue, 17 Nov 2026 20:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794945883;
	bh=47jgWnh4CBhKGYBuXtPVazQvDNIMjjTFA/rc5fvwvCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BdxdVzulwZ9Rm4kT183KnqJ/eBS01YB3gHWGXLcRYD1on8mKjGW/rMBfs0aPllnGO
	 W4jOZpS4rSsKU4Y+QUvxeaQQFKT55o6ldY2Lm9Qq60HlZjG9Vlj0FRqRZMM3USWWyN
	 GQ07xyuW8kTgN2HIhlGqKGGCsukcCRq53z7kIB1rXPVaeXncVMuH66t1B4/FfZGVci
	 vUmp24h9LW25wS8SgMxil0+fqXMsSUyO4Z2xVTSkVKD6r3RAixWIYBHww4x9AeaMO6
	 R0oZldeZxznVNs61lT1kG28ja+NU4V+eGAzxy1tBwJOIhesUWjLZUNRQbPtGizeVtZ
	 l6w9GVO4J1J2A==
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
Subject: [PATCH v6 01/13] perf jvmti: Link the agent with EXTRA_CFLAGS
Date: Tue, 17 Nov 2026 17:04:19 -0300
Message-ID: <20261117200433.45174-2-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117200433.45174-1-acme@kernel.org>
References: <20261117200433.45174-1-acme@kernel.org>
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

The jvmti objects are compiled with EXTRA_CFLAGS but the agent is linked
with LDFLAGS only, so flags with link-time parts never reach the shared
object.  With -fprofile-instr-generate the agent's __profc counters had
no __llvm_profile runtime to write them, and its files showed 0.00% in
the coverage report.

Pass EXTRA_CFLAGS at link time, as the dlfilter rule already does.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b74b534e1153ffcb..9f3e248d5c4efff8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -791,7 +791,7 @@ $(LIBJVMTI_IN): prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
 endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
-- 
2.56.0

