Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0735E391835
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403691; cv=none; b=sfoRILobOnDYssvQNUATd3zpOrnfE0OsJ1jkDoZxm4c5QBE/RngPMCw2/l5Of1PYi0Ru+70EUKgFEGFBCpTNWyL5b5e9rQF0lcoR5TP7NuXb4ZikNTXvR7kRa430EaSs/WamtUPkZnT5JKNmm3znNCqllIgobjkwchxCc/H8uYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403691; c=relaxed/simple;
	bh=QaOKcC3xB9tJnn86MlbEa8bSn+Cblnb5/u/A/81MgrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srjZp7U8IKbN2YkNE5KfwmKyhwSZ7e44tQkxTCskB5tu4lzVcFyeMxWX9TlMfKs3Du/8IabhrS582/s3dZX/X8deAC/BlWxY7OaFWGn/Fbty8Z1SH6DGbDvbm90dQKBIA1YSA8UQWcsrq1VNYlflEBsWS9ap24NJWvoCRtBShq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JDPKDk2w; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDPKDk2w"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-342217d8d53so2868241eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 23:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790403688; x=1791008488; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qe05FHDdu95HVgsXpSMUSqcDD6kwb7IAJCk1+vrij5c=;
        b=JDPKDk2wzbwvT90tpueikc/1qsQlLht4A1R6YcjRyEUB3NMqxahzJDGW4oCbyuIzD1
         OBnuVLggDUAVUv59UPwAmSO0njoQuk0XwwXXq0K/Yh0ACIXk628iaFojPwhIp7nIeqQ6
         BXJvlQQ0KZoMqXC+J6+jqbZMVILSgUWMfcl9Mnvmy60AM0Jcn1wrM0WHfhLjkGg8LbZh
         ISx13w5QQENZfADoJQgYg+n4YwudaRhMGquaEzENYCbJKSpXWiA1L0E49+joKI6Zp1gz
         R5m0F1cV0sx1ZpJjrSqwiNL3+KwMQa1mOleBck3NRRcBL93LSDpDk37mBnM01Unn1GCI
         5xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790403688; x=1791008488;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qe05FHDdu95HVgsXpSMUSqcDD6kwb7IAJCk1+vrij5c=;
        b=eMjQe34eMJ3V8CMqNbHfbRn0DIdolkvIFzmEHHJdzT6wHZVROExyg9paaJwNGDS4WF
         JyS8AsXZmF0C7xqEMg07fYe8dprRR5GKuMiecCi/5Vk4zH2u07oJdTGGQNE3YEUero2N
         4csKm2bR9fIaLaNbh5sWqYZ48DNAS8rVqFToiINVHlLV9NdGd/vFDQFl6NUGL1RoZy7T
         bXZ7CZ9JwGXAw5IHbVQripSUTNORH9yAUU+dghkQLuswbwSB8+E/Exwogq0VGVRkxVau
         15M+K+mpi6OA0Ehm6ByCfc1T5VKZHnEuytuEn/7KrYfF+ePefsRwpQnf/yUe1WeE5twG
         HQKw==
X-Forwarded-Encrypted: i=1; AKwUvBw4y7JNAE/jD3rwQFaywKm3tUHqX+koYQr9c7TcMnx9nptvcYsZQ+oK76XYXlETcSpWNKKyWHHSelXFVKmPIHmv@vger.kernel.org
X-Gm-Message-State: AFuF++nNPOUsk34jbHBV1CgXMpH7bj/9yV3rPI+nYZVSPpGbFhAXBK7g
	Ggs8P1v82cRGsKCk+kzAPEZT07n6VU9w7gqtNhT9KMdr30PBgZree57WD4NFJiGVSVSl3wMu6Ch
	sRol1/eXpLg==
X-Received: from dyos30.prod.google.com ([2002:a05:7300:6c9e:b0:342:805e:c749])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2511:b0:342:84ac:2a5e
 with SMTP id 5a478bee46e88-34284ac2b27mr2011339eec.19.1790403687673; Fri, 25
 Sep 2026 23:21:27 -0700 (PDT)
Date: Fri, 25 Sep 2026 23:19:42 -0700
In-Reply-To: <20260926062029.800743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260926062029.800743-16-irogers@google.com>
Subject: [PATCH v4 15/49] perf Makefile: Install standalone Python scripts
 during transition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Install the newly ported standalone Python scripts (python/*.py), type
stubs (python/perf.pyi), and compiled perf Python extension module
(python/perf*.so, when built) into $(perfexec_instdir_SQ)/python
alongside the legacy scripts during the transition phase so that newly
ported scripts can import perf directly from the installation directory
before legacy support is removed.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 168b286770f3..89edf2720fc1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -907,6 +907,13 @@ ifndef NO_LIBPYTHON
 		$(INSTALL) scripts/python/Perf-Trace-Util/lib/Perf/Trace/* -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/Perf-Trace-Util/lib/Perf/Trace'; \
 		$(INSTALL) scripts/python/*.py -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python'; \
 		$(INSTALL) scripts/python/bin/* -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/python/bin'
+	$(call QUIET_INSTALL, python-scripts-standalone) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
+		$(INSTALL) python/*.py -m 755 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
+		$(INSTALL) python/perf.pyi -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python' && \
+		if [ -f "$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)" ]; then \
+			$(INSTALL) "$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)" -m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/python'; \
+		fi
 endif
 	$(call QUIET_INSTALL, dlfilters) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/dlfilters'; \
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

