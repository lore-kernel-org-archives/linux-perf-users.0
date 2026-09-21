Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82668369D4F
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967271; cv=none; b=GJ6/KuRhAJSJlKDXCN8hgQOAnEKbtc8MCsVNCTAfmLF7W0gE8kq0CjKqS8kKEg/vJcypHGBBS76xmGeTPztX0obsQG9oYHepNqA2c4YAlWfKh4A0A7jWr7kClg7R6ycl7lZJMA/C+U6I3UHNC91+/OPx70ZGZS9Pk/7spL1Jkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967271; c=relaxed/simple;
	bh=/VOAtg2lu5N2Nvzvlu6ANo0nxnKw4y0WWHEMAzYuN90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sdrkERcqn1Q2fyp/m2mLUZ3DPl0CwcNjznOAln/uqXp+HJHjFGTdpD8lerCS4F9akLUSdB4DZPXAc3HVYMJEJDcGTTqrnVw2DIEKeFsu1Q+LZUILpnbWiburwLvFH/sIufBGdaGhr8pvpgYUH8MsL0I1iVj9d3VAkQKIHezQo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4CRfpBa; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4CRfpBa"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so6743723a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789967268; x=1790572068; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njBfARfpD3SnV1SNIGOHUGhGOxd8dPHLz+F5h6CB8AM=;
        b=l4CRfpBa37kpY6mkEzz0iyKKB5bK5ET/4mViJt7J62OWMWnF1gtv+15WTWEMWtL4oA
         qLigfSP+b1qx5YzqsGVgnfN18eyBsOD8RV+B7PBxnTqRdL0O8Ky6ZyE16IUA/v5VThVX
         q+Ozjqb/jQymsEE3OXXJvBmO9rU+LKw8z4z1dUCWzr4evCilkzY6mz/lkQdhxZ8jPKhd
         rO1cj8r5P5a6lxBtFNEUeIJ8qOoDAo/wWcDE8eawUgByAbnM8ezJm/QC+eQXljx0X1oG
         uiYPL2DpZPmUUG8HaG6FmyJEdjsBFIf4ksG4XUTWGE8DbmHb8J3yLp/vAxbR8MN6/qnN
         KpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789967268; x=1790572068;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njBfARfpD3SnV1SNIGOHUGhGOxd8dPHLz+F5h6CB8AM=;
        b=E1EoaRc8qfQtCCrT09bm3OFIyz2UTX+rsZAZG1zobIhIfowIuYfpKYsxzLeS+VgCV6
         tlBVrH/tCH5S3K954oJuyPVgQRSQs2xbVjMVkdBZdm+S6jRfaOge/C5uqeIbB8T/EYIB
         +EltGGPHNfzwa1FXtY7HgH9wu5io+jX0oDTtNkaZLVdzFEt4qp8zCncD44lMm8Av+PVg
         ShL9jaSoy03ctY+9PYktyhsxXMeifGPMh8jZnWqKm7R884MgJqtriFqpZudY5Y4mcw18
         AaU/Q10U24QcXIkde/WYtsx5Kp3500Yp7gWl6t3b0WO5GejoAEiDI40X04GCya7C+bSq
         9bTg==
X-Forwarded-Encrypted: i=1; AKwUvBxzCs9OqIgpfb8uqHEua/kmWJ48jOo+tajhGt3Jfkl4xcbRtF6n7Y4iPNqHV66gjuekfTzbiQ5SFy90lzsJUAbe@vger.kernel.org
X-Gm-Message-State: AFuF++l/I2dK2hqVNGunaRniLJebHC8BxxLyoRGnc2Jrosc0RhBOsioE
	jCQRaHeYtmfVhR1kKkJZIQeYbfNhnsKCihoQhZyqw9Uplln5SISKA72Qt4khF3xQFWXHHpL3COP
	pFHfvOuxdTw==
X-Received: from dldyr17-n1.prod.google.com ([2002:a05:701b:4511:10b0:143:7976:20e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5830:b0:39e:6a82:afd3
 with SMTP id 98e67ed59e1d1-39e6a82bb9emr10090926a91.37.1789967267600; Sun, 20
 Sep 2026 22:07:47 -0700 (PDT)
Date: Sun, 20 Sep 2026 22:06:33 -0700
In-Reply-To: <cover.1789966896.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <bc2109d93d728f8cb71a9a1f6079920870b29130.1789966896.git.irogers@google.com>
Subject: [PATCH v2 15/49] perf Makefile: Install standalone Python scripts
 during transition
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
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

