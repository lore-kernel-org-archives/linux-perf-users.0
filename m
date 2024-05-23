Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9033313B2B2;
	Thu, 23 May 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452108; cv=none; b=SeVQ1IpLm/hrcys+Cg3z/CIeOkjGFvafgeQXMY8JpZ0lXvflQUYC8squTQNCuNj5uRsRcMzk5r4qdhgq+8j4Fi8lNlZWLaw5dcqzYGpI2ksQsdyiMwBZYng3g7BohxrznHxq9eqdveSYe/ZKM3QaNvsEf90gBgwT9M0BsjiXOx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452108; c=relaxed/simple;
	bh=Xr35r8fnEvQbu5jDaXO/dmnsPmTchpi4lhx4Uf27dWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m6e2hLl4QMCkv1glKdur4OTuypYWv5Jp1BtSGPVhKQq2itZz6HrFvBJJHbQslMeKwuqw1Ep0ceVi28c214GS+ThU+SaWbsa7pDXrhkCZ9vdY9Kt4TXT2DoKlzmPkJxVV660qYDPrI9jyDm9vpPfEZl1BbTks+5dCcZyQlRC5u70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=P45aWA2k; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="P45aWA2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1716451604; bh=Xr35r8fnEvQbu5jDaXO/dmnsPmTchpi4lhx4Uf27dWU=;
	h=From:To:Cc:Subject:Date:From;
	b=P45aWA2ktsq1k89HcOMUyNt6RgrhlQnfUMCFGzUg6HFcnJTgMYOrJWT7wBO1HHgQo
	 bgvbqo+PfekhykRIxGCLb/m/D/OpKVPHbN08qQ6cmJ33FfH/XkCXFlKHecg82bkbPL
	 muupLfoPWq7bbO5OT8hmwjh0iqytHYzYBrQAuXnA=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 23 May 2024 10:06:43 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 28930806D7;
	Thu, 23 May 2024 10:06:44 +0200 (CEST)
Received: from buildd.avm.de (localhost [IPv6:::1])
	by buildd.core.avm.de (Postfix) with ESMTP id D6945181262;
	Thu, 23 May 2024 10:06:42 +0200 (CEST)
From: Nicolas Schier <n.schier@avm.de>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Nicolas Schier <n.schier@avm.de>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] perf install: Don't propagate subdir to Documentation submake
Date: Thu, 23 May 2024 10:06:40 +0200
Message-Id: <20240523-make-tools-perf-install-v1-1-3903499e637f@avm.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=n.schier@avm.de; h=from:subject:message-id; bh=Xr35r8fnEvQbu5jDaXO/dmnsPmTchpi4lhx4Uf27dWU=; b=owEBbQKS/ZANAwAIAYjGvJyImm24AcsmYgBmTvigYLxnY3ruTSJ1G4l45UzErjtROMq1DXBRa 3RnlHtgS5KJAjMEAAEIAB0WIQQO/4WJ63TpgecLpGmIxryciJptuAUCZk74oAAKCRCIxryciJpt uPGVD/9t8/iVWp+iD0/IaaKvAHJUA1RT8aZF7iBS4FyzKjb4JltVuXaJilErGKirYZRJXWWTffL q0PwX2QQEzlvZ0MmX5+DaVWrplPq2kz2LbzodeTeVdjT1hYj+NEK44Nggga0+GlcemKSRcbuQ0J brp2vEIjqJJ7UPc/BmWqLR31olchEWUUNcGDiJZNEvC3WITnGMbHvnpe2fzOSiIISDwld38zkfa 6E2dmorljpyo6U1Ocgd6KxyLWV0Bj/D2LErohmE8tZzNKf5bYT0s+Z2wCW2dntBwR+2XEDo2qVr 3PoUgrGFFkyy/iVGc67odRnev+T/HvtLKyoCNNwPBIs/+taO37qpWeoVFc43eghyP3zAPOQifCu tB7UBCNcUQTjcoqPah9M2pW5yf1ZbUEXewZvvn7zDaY5JELo1nUqqB0WTwbMsBnAaDrS6UHcdl4 lAgXfGbi0QFngLhGXoHljl+Gk2gq/c2posE/MNLZlkl2p0MqMGZPp/UehN1SSeU3uTIkEbopX+x uFunkYtSBr+AhMHco/DWKkGbkL61xYw4ajHjIAwmUAcqWPhIHfCz3SElSk5BmzxHJvsd8nap567 4pKEOyYQHa6dhKYq2Y0ZnA1rUyLX/Zap0qQlhk58GkpU2kQTiJ6Q/uif2JZYSU/aFV8MQn0OgJN JtpI3V8qbFdzw
 BQ==
X-Developer-Key: i=n.schier@avm.de; a=openpgp; fpr=7CF67EF8868721AFE53D73FDBDE3A6CC4E333CC8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1716451603-2E0B3E6F-2631767D/0/0
X-purgate-type: clean
X-purgate-size: 1814
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Explicitly reset 'subdir' variable when descending to
tools/perf/Documentation.  Similar to commit f89fb55714b62 ("perf build:
Don't propagate subdir to submakes for install_headers", 2023-01-02),
calling the 'tools/perf_install' target via top-levels Makefile results
in repeated subdir components when attempting to call the perf
documentation installation rules:

    $ make tools/perf_install NO_LIBTRACEEVENT=1 JOBS=1
    [...]
    /bin/sh: 1: cd: can't cd to /data/linux/kbuild/tools/perf/tools/perf/
    ../../scripts/Makefile.include:17: *** output directory "/data/linux/kbuild/tools/perf/tools/perf/" does not exist.  Stop.
    make[5]: *** [Makefile.perf:1096: try-install-man] Error 2
    make[4]: *** [Makefile.perf:264: sub-make] Error 2
    make[3]: *** [Makefile:113: install] Error 2
    make[2]: *** [Makefile:131: perf_install] Error 2

Resetting 'subdir' fixes the call from top-level Makefile.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nicolas Schier <n.schier@avm.de>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d893069..ab15d199e3794 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1093,7 +1093,7 @@ install-python_ext:
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=) ASCIIDOC_EXTRA=$(ASCIIDOC_EXTRA) subdir=
 
 ### Cleaning rules
 

---
base-commit: 29c73fc794c83505066ee6db893b2a83ac5fac63
change-id: 20240523-make-tools-perf-install-71c3d1f11ffc

Best regards,
-- 
Nicolas Schier

