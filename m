Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BB3BED7C
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772572579; cv=none; b=jkZcGmghwUfUr1NFMNjwjBBrtilhJEhk9Nh4xDmIJxpJV5Fs1PMqtbF5xy4BgYr8YKT78K4g1WAMq5AupDPkdm6ZgJO3HAMkn/O0XoVgQwZ0NDQAmfJ7m+4ao2dccJoIfZPLznbt0Ro/SIx4P8jwTX7jD1//J0vKRxz3dG4AsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772572579; c=relaxed/simple;
	bh=DSuMj7aNeROIC/Y2sruEF45fO0e6aVW8aYCE8MzOhPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQhXLubu0P8hcGmuxwsLcMipJD7LfypQp1t/e6ucbgQ7Rr5jLnZsgEpICWCaPOVah+N0JgG9rfRft4EMPFEzQe28/xJzjzCLgQ8QcduD8gO4mCn1rXc8deAmg2IQ7bCgeYkkYXonqWZCLfjDICRjzjFrUw3H5hHIHBy81PWHkYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hRiupHX6; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hRiupHX6"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-c70ece855e2so2539499a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 13:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772572577; x=1773177377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59O5+vKo+jtbcjGinkLiiwlOeS+dXB3u9zs9mLWdeDE=;
        b=g1O9kK11gIfbYweSKAN23mvLyrd0Q4lEuLCZwGmpIDrVl/I4CRyM04pAmrAk16TWWA
         hvI7A2n3B2/dvo97/9nE3mjIl1c1B+NCkBTKY0/v8XJKIenauK3xTZ8AJOUCnllFozeB
         6zUHNgQZ+ixjPgwsYza1bE+evwuhwHM9SMDbOq4s/ZddGshZrwSshIxdhntggIjTI9oR
         yAUKaVO1FVrQ7DYyQzmyCKzU5F8isPeBamWBlkdYiyo13d2WbeWifwM/RRJQHIm3ytYQ
         /BQnRineDXSLI1mkaZW3hcWM2yIFG3KNOsCASVoftoPnDJp19ByjGX7wuCxA5lOvQ5EE
         Xt0w==
X-Forwarded-Encrypted: i=1; AJvYcCWm49WMOmHkQ+q4gN4qksI3htrA2dyxoliGk2MrWYVqlADAZZSiKg0zO4TeP9hLIqkhccq8CFHzMr2cWC3k+1HY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlw0ruY5f3Wz7hPz3otDlc/NFCpUsGa6TN2BPmkDxt1RoXCGQU
	TgkYnWhCRhtipVtm92+5uT4XvJFkejg5w3trpoGrPPcPvHJQH9fhOpG1JQYW22u8XXGlWyoED6z
	h4+ZxZgOl063VhO7e1XVXo0VM/4YCe/IqbbKusp2FXEp3hDNzZKjv2Boedt+IvQ5V20lBI/ecHf
	2Z8L4T/+OMoWo2LE/WKpUJazktMA0IaHfwoUjtdt2DZaylWkG1HxgCNHtaiSJtbZmaeaoY1bsfw
	FJ9W9/TGVaCykgO/7jfJrlkkpc=
X-Gm-Gg: ATEYQzy+c9yUHqDBJAm/oDd0I3ccnwi3bCRY8Y4LINPxDr8Lb+yViNWXSx+Rg55VWy7
	hfYqKbvL1JBmRh1OeZgbk4o/VGjRcI3YrTfEb62YXaq+ih4MAoysygBiN4q/QSnRbx9Tj5nF/uo
	1HwMLYXmLelKjGX+ApcBWucgEki1BEhQrolKtwNH8LbzpWUGKRefYoHF7+iGNQx5dkj3Spl/oQT
	JizwtG6yjnls5LGXtMZjunh/jkUUZKmNKoJwntkS0vCDTMRGmlAf/1jfTjdJcsDhefD4n4JLjCE
	K/uA23UljDw8XxIHtNAuRCKEj5QFie6DzcrIDlgkmE0pxXleVYIa1/FLteVbigfLNQvT78Bik0G
	vZv8DPPZyAP+kcUVt4is3TExj5fHdBwT3ke8KnmqKVuSi/r+JO1M6hf+17UUwxk2aVE9WuMItfh
	nwi21GOUoUFUfIjVRm1hXLkhGLRn8RJ9kV3RRmFMhcMEMcwS/aTtqlrXCKL74=
X-Received: by 2002:a17:902:ce84:b0:2ae:5435:1940 with SMTP id d9443c01a7336-2ae60d37320mr32112125ad.20.1772572577161;
        Tue, 03 Mar 2026 13:16:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adf8f4a2b0sm22951635ad.0.2026.03.03.13.16.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 13:16:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-127876be621so3630136c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772572575; x=1773177375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59O5+vKo+jtbcjGinkLiiwlOeS+dXB3u9zs9mLWdeDE=;
        b=hRiupHX6mnRM6vZzj7+kZ5cArln9rkw1Sf050FK9z5b9boVB72BGlfbtR1zi+Flltz
         9+bcU5QolpC8FVQgSiHPe2I+mrnCHqDsh1JdsHQfW4p6SyAF7JXzjXw8qHKli4FfDT+Q
         +skW7LFdcAlDf3fC0Uk59ENrdrowOngGRalPk=
X-Forwarded-Encrypted: i=1; AJvYcCWTS1ZNlUsPzEo4OXQfdMRWw87acLHA/+nVAEkh6ZrG6x5ixQcG57sDcRagJLYk81G5EPgCCif0Anx3xveZqad5@vger.kernel.org
X-Received: by 2002:a05:7022:4a7:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-128b0de1b3bmr1349314c88.19.1772572575432;
        Tue, 03 Mar 2026 13:16:15 -0800 (PST)
X-Received: by 2002:a05:7022:4a7:b0:11d:fbf1:1e27 with SMTP id a92af1059eb24-128b0de1b3bmr1349292c88.19.1772572574749;
        Tue, 03 Mar 2026 13:16:14 -0800 (PST)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a5312dsm17452405c88.16.2026.03.03.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:16:14 -0800 (PST)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
	id D6810F04; Tue,  3 Mar 2026 13:16:12 -0800 (PST)
From: Markus Mayer <mmayer@broadcom.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Perf Mailing List <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf build: prevent "argument list too long" error
Date: Tue,  3 Mar 2026 13:15:01 -0800
Message-ID: <20260303211503.165337-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Due to a recent change, building perf may result in a build error when
it is trying to "prune orphans". The file list passed to "rm" may exceed
what the shell can handle. The build will then abort with an error like
this:

  TEST    [...]/arm64/build/linux-custom/tools/perf/pmu-events/metric_test.log
make[5]: /bin/sh: Argument list too long
make[5]: *** [pmu-events/Build:217: prune_orphans] Error 127
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [Makefile.perf:773: [...]/tools/perf/pmu-events/pmu-events-in.o] Error 2
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile.perf:289: sub-make] Error 2

Processing the arguments via "xargs", instead of passing the list of
files directly to "rm" via the shell, prevents this issue.

Fixes: 36a1b0061a5 (perf build: Reduce pmu-events related copying and mkdirs)
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 tools/perf/pmu-events/Build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 63c65788d442..dc5f94862a3b 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -214,7 +214,8 @@ ifneq ($(strip $(ORPHAN_FILES)),)
 quiet_cmd_rm  = RM      $^
 
 prune_orphans: $(ORPHAN_FILES)
-	$(Q)$(call echo-cmd,rm)rm -f $^
+	# The list of files can be long. Use xargs to prevent issues.
+	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
 
 JEVENTS_DEPS += prune_orphans
 endif
-- 
2.52.0

