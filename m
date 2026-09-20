Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835523D567E
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881787; cv=none; b=O9gp25dtLDr+/xSqFf3ib7R/+gcNkezX5NP5On/37kuGtuULZDHeKBJ6oNqYdO67QeuRf/IKVIEyG6HULj6qtED9UGiN6lUrKaBsMrDF7o7Di88ZA5OdvvWLktd12X9RDOT/iWsQlzYnJLpoa94Z69XWKJuoJ3A9KJ99njeT5so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881787; c=relaxed/simple;
	bh=/VOAtg2lu5N2Nvzvlu6ANo0nxnKw4y0WWHEMAzYuN90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNG1G596/+r4ATdtqugfLRJeEAxf/9wLnb1sZkTzLL6M9JXQy8nlCUFLvxHlYlhgQTgFtHq8IBKhOy3qRzS067kg9hf39TxazAkAplyDrgbLgwLw5rATds2gFwaAk6NFHeBCiDDpsBjIs4fkDIMJyrkB4g8NX56cxlx/EhE/e5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SoC0nka2; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SoC0nka2"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so5179648a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881785; x=1790486585; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njBfARfpD3SnV1SNIGOHUGhGOxd8dPHLz+F5h6CB8AM=;
        b=SoC0nka2Net8WrA7+hFNxI6x4Sz8NXvaAxKcrIAdfPLY7WHbIqFLs+8+Se9CFS5bLP
         uB0WitXS0Fje51JAapAQdv85qcXgst3hWGIQyOz/lYHKvjLaD9S+VCHijQlXNsd78W5v
         M8n2JK+y/p4+HQrHX00yfkaQLGLP48ds7+nrgG4Ljw2GSkBuRhqklcDplPBrVmj9D1ki
         HY8JiLSwbdJ7siCtRqA6pvJNHkW7cX2Jf26C2qWawaLLqlOAmYjf5IGWqzzsMEbYp225
         VJ+tIK85dsuNs9y+e8VGFzb+qglzGNwvVjhZsS8SqGaytJq9nVZTof4ESmwiChfgkNQt
         TGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881785; x=1790486585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njBfARfpD3SnV1SNIGOHUGhGOxd8dPHLz+F5h6CB8AM=;
        b=b49s5r8+gtjuhoEO/sc7EUQ05V5Nr0yOL39nR2bG2+1hQ+IZfZTEF+GNgrhi16r/1p
         lFFzlUUCk0b+HOqsjGgk/PdiORaGl2yOJ3pbV3Rczew2ol8oQSyfvsT9r+mAPyGdzxzf
         Y7y7PKjujoo/2MXz5JNF/jsISj2r3NcsrvdSdTLRS+NHGqz8az937nFYCxxudeyt+god
         fy5yvbu8N7B7KUQokMeDb0ZnKmqInEkpgmxMrYQ+lO+YJ6wNFZsyrWRY+nApFiTvaCc0
         5kFAGCFosKFOaQpCuPBBP44Z6uaOWfXOpFpQyto38bzyKEzfxozSBE6WROeIutIbRpnj
         3vPA==
X-Forwarded-Encrypted: i=1; AKwUvBy5D9pkMCJPxjOMmG3wpJX0eIomKd2OUgUBqLSqsSbxS0uBFY7ux213Yi/DeNV6tZmyVkwBVWg3pdxDGQOb+ORu@vger.kernel.org
X-Gm-Message-State: AFuF++m4QpXHgzyZUJ3QYSwgHxIO6M/AxEtwLOvNZDXD7iZO0pBYyQBB
	VkapdJIxqV3fo7O9eLm2Xo9LRK3mJK1KmnpUnguwrgGw3FqZpTgs1nHal4bz4pvVfV+sLMpANFR
	fBmlV1zUuHQ==
X-Received: from dybtk5.prod.google.com ([2002:a05:7300:d945:b0:33c:2cf5:c43e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5784:b0:39d:f5b1:e365
 with SMTP id 98e67ed59e1d1-39e54f35b9cmr12058496a91.25.1789881784802; Sat, 19
 Sep 2026 22:23:04 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:07 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <f8600b666480094589f38b430cbbd0519d1d539f.1789880842.git.irogers@google.com>
Subject: [PATCH v1 15/49] perf Makefile: Install standalone Python scripts
 during transition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Install the newly ported standalone Python scripts from
tools/perf/python/ alongside the legacy scripts during the transition
phase so that newly ported scripts are available in the installation
directory before legacy support is removed.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3e193d609988..abd377c16435 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -905,6 +905,9 @@ ifndef NO_LIBPYTHON
 		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
 		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
 		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'
+	$(call QUIET_INSTALL, python-scripts-standalone) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python'; \
+		$(INSTALL) python/*.py -m 755 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python'
 endif
 	$(call QUIET_INSTALL, dlfilters) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters'; \
-- 
2.55.0.1082.g2b9226bbc0-goog

