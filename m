Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036967;
	b=KIe0a8KTdrYdGQQgYjot9v5nycTEjcc5DcDoVdTX9wCWuzf/FSHxx6zC5yMhu+tFnEWA
	 I19AUnPHLUbYpwnD69Xn4FhXSkBJlp9bjGknaODId91j0go/QHUDJGmtdbNtctDs/zvQT
	 lD1XkLouuzKJSeMVygjoDvEWaWF9Sq8kB64YN57lW/kaUSyi7D/uOxs5FRkATO+WsdIsI
	 vr6E18mlk0E/EabETggFujx/KsTNBEOOChgQYHG+rb7cgYGeQ3ci6ZWcNp+bp/co/nVBX
	 utECXfTIs4yJdQWf4M8ORqwnnwbeyldRmFSYHi9S/2dm1dIbn6TctcM57dLTMgdf2Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036967;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=9TTg9pb/7fpyUF/iQ6S1hdT7qvfB/N3V50wHOOlSh9Q=;
	b=dmOVM2QXX9WWO7FkXk0tVeg+5yW8bsTHS3uwKt8CZhYaQyGQjQtw4nvHOsHA/y0IWBvH
	 9xRl/h4/2nl6EcqTJGagoO8aOR21/I+ogcgIfvG6qXZvgZIjI9ZWwLxNx2fs9a/GsTuZX
	 Uj5BuTaPSg0XO+opewdM5USkIktyOYU2B19vrpDR8AK9szVC8vTtbhFV/cu5ESIUdJ8EF
	 E7ubV6TWgg83EbJNXERW0ikxGydG7Ymdz4YAiHNIb83dwKuZJInww3k6R1EE8RcRgWyZo
	 Hd6PN5Co2P4T3SmeVz6knd0mTTh+UUtkG8XET5b8UEJvvTc8pNjYabO4yhvbWF/YgAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Q0zhGw+m;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E8606A31D
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 17:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 454E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Q0zhGw+m
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1173600a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036966; x=1793641766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9TTg9pb/7fpyUF/iQ6S1hdT7qvfB/N3V50wHOOlSh9Q=;
        b=lMAJDGvc8QaA+oWoBwd/o+1Fps62BTot2Jhans4Px2P6GHrd1FVgGrpnB3qNIYkNee
         wWHQMRpvTY7IZV3CA2zwkEasr6yHJB5iTtJMIdpV9hdNHZfhniMipn1YOO7GaU7eVvuO
         0N4X7lEeORuIyleVH1pN5RR2gukcRdYcGSiipbSdhNadgvGEZRKK6pO/ttKFyb2wIuyW
         XBls1a3zKPDYXq0lIRkaBd+b8WeMb038raGCOxqxho3E6ll//Y1PB7LRO0er/siE2Jk7
         61Si1BSprDms1E+uDyjIFYWHKRirLxQANbRsZCSIe3E5GDUKXfxjCLgF2sKqhL/HAfr5
         QN3A==
X-Forwarded-Encrypted: i=1; AKwUvBwTCSmC9VVzJ2Zn3i7xtDLAnQpN1iotkHGIA7NbwZrIWAlsTNAbA+B+vkM2Z8OHnFxwGxPkLKe4Mzk+c4AoVoqf@vger.kernel.org
X-Gm-Message-State: AFq9FYIbVxFOe3YZTJHeTyjDbbxdOTIwifwwxoe2o1iyNRox7aeYJeWi
	1IBfQsdDWKJUn0D2Ig1EPwrYMPvTxlqXlIvaLIX1baadHf9P2X+HYBRHiA2bo8fZRpL8zYVk3sP
	rpIb73pV6LWJ3ZsJ6Arx9/6VziapugH3o6V4umzatUDBpUFsKfXJsjtij+gj0nbRyf8gyRK2J55
	xKPvnqW1S/utAawsvbN0ji1BvianMPjVuf2elG0w9XjgoIX6YRqBVsPdj7nygosSWP9sW0qWW3F
	Z3mpR1iGj2ybKlTHL5LuoEkz3dNCfZ5
X-Gm-Gg: AYBFou1NK/E+V+4QV9YW3maRee+Z5U49nTZIktooGLB9+me5B0QNMJ3Zqi9RkiLFbBs
	GYuOlUN9a4qvRUElCSm3FDA2TVJxNjXzFlw9Ori04rpzLgkYJIs5poWphU1mty6nmxdnlt+IhAO
	XUh46eTI2Q1JDz67SoY3aYupgQyplufeJvMUzoLDoFm3+nN+kv6mkcxdLgoo+sdoG4XKPZwysSZ
	iiJRQeeHKhgwfPj/sFPGlUf5QMJiCB42TCxEF74IKNECoed/prUr5z55J3ZtWsej3xqevJ0hN9o
	Z3MXRdE8q8jfRPM3Cxr6bpuzJBkeDAeYdCLLv3t4KTGr5xMRZ2N8A8pnUNgu8Jne+rzU+gXCzt7
	7Eh9u7E1RONMeh7+dKQdbhYWTbEooKtC3K7vaYDA5vrk1u3C0H6cqP9UaoSA4vnSbm6Y8mUAyW1
	1ZGQp/LRZuXUGW3YqExq1IVtLudfnxkgWfu97ZloAw
X-Received: by 2002:a17:90b:2552:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3adea899389mr6454091a91.11.1793036966301;
        Mon, 26 Oct 2026 10:49:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeb83a327sm3444948a91.0.2026.10.26.10.49.25
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:49:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adbc9a47fbso3106160a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 10:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793036964; x=1793641764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9TTg9pb/7fpyUF/iQ6S1hdT7qvfB/N3V50wHOOlSh9Q=;
        b=Q0zhGw+mt6YCGjF3nM38g4UbPRvYaQ477cR7Wg8wHCSHAFrWylGTIqiFtCwBC8CjYe
         cfq4cjSlX3nTLeIHbvm+aF1LXWMB/jDKuoIwBJd6EViILdIi0mY1/TGZNj4oKV0P1bYc
         S3mXeETOC9Y2AO84ebU4ltBh8cSz7MaXWIqoo=
X-Forwarded-Encrypted: i=1; AKwUvBwjxfR/Ayu9neAhjAOTtlCFkM/lqkxiZaHCqHMB75IXsIDVrSg3xUs9UA+r3YbQsuKsRqbBN/VimQXhe4kjYGJC@vger.kernel.org
X-Received: by 2002:a17:90a:d406:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3adead4c656mr6303055a91.38.1793036964457;
        Mon, 26 Oct 2026 10:49:24 -0700 (PDT)
X-Received: by 2002:a17:90a:d406:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3adead4c656mr6303022a91.38.1793036963981;
        Mon, 26 Oct 2026 10:49:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1210f0sm20400355ad.25.2026.10.26.10.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:49:22 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Faisal Bukhari <faisalbukhari523@gmail.com>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf parse-events: Include errno.h before kernel headers
Date: Mon, 26 Oct 2026 10:48:10 -0700
Message-ID: <20261026174814.3158229-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Building perf against uClibc fails in config_term_common():

  util/parse-events.c:954:30: error: 'ERANGE' undeclared

The kernel headers included before errno.h pull in asm/errno.h. uClibc's
bits/errno.h undefines EDOM, EILSEQ and ERANGE before including
linux/errno.h, but the kernel header include guards prevent these macros
from being defined again.

Include errno.h before the kernel headers so ERANGE remains defined.

Fixes: 6b9c0261b3fb ("perf record: Add ratio-to-prev term")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index cc7ad331a49f..efb46ba9ba22 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/err.h>
 #include <linux/list_sort.h>
 #include <linux/zalloc.h>
 #include <dirent.h>
-#include <errno.h>
 #include <sys/ioctl.h>
 #include <sys/param.h>
 #include "cpumap.h"
-- 
2.53.0

