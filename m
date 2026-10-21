Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622746;
	b=r6bIPalr40vjaoV+ML9Ltt6iCwGptNST7QA8ozs5y3pJaIopAGlweWu4bckeBq5LIlzu
	 bUAn8bt7D5wxttj23FFEkOiY0jGRq/mBFn6c6ur91LHO1fUV5zHJH/jo7TOtA0oOmu14U
	 zH4vcoIKt1cdvXYANTn0ccJegjyGoOB8mWm2lYGV1rLBlC7FOAng3upQiOlYARDhumoI3
	 v6KxaUG4GVnUJcSyQHxkOJ70X+1VGVr/DMN2epn1dkb84PYY0Aaxci8VPZ6m6BeX+0uWz
	 WjoJ2hVUnkhWi+CDIqb/7KwtZWBGgtsWwIJdRAxcVD1Mrmsxm16nFU7C9n//4bj5JXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=tUnY/xcLCCwsERt5Qg8FpPAZtwn+Co7y4pdL6+JKAOQ=;
	b=BSadHXAFdwJV1UctQLf6HJrxLdfMBs1oZp2mD/Jv3VIvH5I4dg8hv2rNEUsMhbnMxLPV
	 BA8ifgZDH+iZBZUto7Jdp3C/UIs0bdXK0SiUS7fABxQTF2zxsKioehnZ47sTjjEZ6lrNp
	 GDC+tllgiyRIFcGFft7bekZrVHCgDRZoohrqO8kgwoWD3facBbgCQ+uduhOjMFyao/5CV
	 ARcGhQEWR8PYoQM/U/T93g21jiGDwZ8IQcW1KsC+jpF47T3h/Wl9moj4tX3S01QaOOIhY
	 Ph/QDaEFWSr2VreaDgDzrddJtPRdXnHZVZ1UtKzBA5fccHVPb3tLu1P9RDpWDhq24cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XvG2xHd4;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4983D606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4983D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XvG2xHd4
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso2235721eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792622745; x=1793227545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUnY/xcLCCwsERt5Qg8FpPAZtwn+Co7y4pdL6+JKAOQ=;
        b=XvG2xHd4grqi9a9fxbz5jHP0bMpgMVZhZ9xyMFLxz68mceNmfZypX17VLqdN7xmUJ0
         +cnqF70VZaMfa49HdP3yamdL9SxUYW5OMbJ46P9VmO54VrhdxPSAGCMarFJqaXRX1Ph7
         7vIen3VW3hy8SAe87wtNS+aJbsqjfSj/XYNwyVW0l4LsPxMAPwZ6T4vLHAotoTnd+Ox/
         YJ4ieQwtEKtSx+WF96ka/zJhwnkVpn+1GgxMDAwIXP6oseLMnm40RMcbmvv3s3dA8dtm
         S5mgfcOpVlboGJDGRLfWLMenHxnkgTXs9GEzdT6gAYyFFQWGqFl+iQcv9y2dR/OWUeff
         G+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622745; x=1793227545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tUnY/xcLCCwsERt5Qg8FpPAZtwn+Co7y4pdL6+JKAOQ=;
        b=UBPpST1MAGdsOgvA6R0ITnCiHmt6H4I4aqpMebMU0B51WzLRck85QUzdLkHqg3njdg
         OLspfZH7Pv5/DpCQXeAmHgr77rghF9gIAvLjjeSOE+el38idQIvoiFMScri0XqvVj91O
         CcXFUnM5y3hSC666tuOsWUu2ZpOSxXmwra6ljS7IexMx4QuwEkJMkhcblNtV+FKM6Rqe
         c/Cdb/lhMPMPyX0Kz4jbTjszyBlNeBE+vKO2jhSpTsEr5fgQUk/PrwEhSOPXyYcWOfr6
         fLmfmNldr7TRyvpo+OBZPk5JXmIqWZDm5kERSTq38G04HEOv3hQD0hGAqqv7jNRnxKIU
         HKpw==
X-Gm-Message-State: AFq9FYK0gP5usDXr2Jv8vHgutZdS4ptoDpzv9ldAq9EW96ywDwkxk5MO
	KM+YQT8CDCnKLNEjWjMq5xn2vWRskp0OAihn9funWL6xsHNQkdJaJczEgctNxEAe
X-Gm-Gg: AYBFou16as5PnTf2r8hU0m96lXl4HXVhQfwvyI4EMYVxlOxq0BvdV5QRa7Hdi1i3XTs
	IYWsoh2nJ6r5eq66akb3N4Dg4qHhqqGtcfDVrPGrdpGjJeQfD7JnetiYzxvugBQoPyp9IUBB09k
	19w+njTAih2BAoAWNXAgGVCPyyXj3WShCXcvXgbMcTJlFKM1+E8+AbZ6eyS/EJD5k3tQXzNXjCi
	7T2cIQ9O9zdVy2WKblkGT9V4cfw3qgs7FAmDtdIqzVNJMQFBmXdGsl8nYewkY9spBs/LTiqhIPZ
	4Kd5a3tVLbR+bijijUkOboltWIXjUwB0jNZ72Ns65iTQJmraL+L0O5AkhPoUZxpLgQ3W5kC/kYG
	gl0HwPoGefaKImVLCme63+MtH+gus+MGE5wPPd6CxUF43gobh/TmTKxvv2ke3IU15i6jwh8MKwI
	Int8TkcT3u77vyLvv1GJL7Xch/mbbPRd2Y2qRPktqOVcWYyfjXYO6GH02XDGxyyYHmaqukUGrW7
	Uo5MSza4qCuhnpnVQdEXOMRCThsa3nvPcSM0j8HjdLUz6mRqOvRD1eMxp7poyud8kH3
X-Received: by 2002:a05:7301:5808:b0:360:34e4:39d2 with SMTP id 5a478bee46e88-3674d44a645mr6606105eec.10.1792622745067;
        Wed, 21 Oct 2026 15:45:45 -0700 (PDT)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc88b5sm10770274eec.10.2026.10.21.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:45:44 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	John Garry <john.garry@linux.dev>,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] perf vendor events arm64 AmpereOneX: Drop stale BPU_FLUSH_MEM_FAULT entry
Date: Wed, 21 Oct 2026 22:45:27 +0000
Message-ID: <20261021224527.167637-1-takano32@gmail.com>
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

AmpereOne carried BPU_FLUSH_MEM_FAULT for EventCode 0x121 until it was
renamed to GPC_FLUSH_MEM_FAULT in 10a149e4b4a9; that rename and the
AmpereOneX table were patches 3 and 4 of the same series, so the new file
kept the old name.

The result is a table that names the 0x121 counter twice:
ampereonex/core-imp-def.json has GPC_FLUSH_MEM_FAULT, and
ampereonex/memory.json adds BPU_FLUSH_MEM_FAULT with the same code and
the same description.  On AmpereOneX perf therefore lists two events for
one counter, one of them under a name the documentation does not use.
No metric and no other file refers to either name, so removing the stale
entry cannot change a metric.

It also leaves memory.json holding only the ArchStdEvent aliases the
other files of that kind carry: AmpereOne's memory.json has no raw
EventCode at all, and neither has any other file of the AmpereOneX set
except the ones where raw codes belong.

Nothing catches this at build time.  jevents.py asserts on duplicate
event names, but x86 repeats an EventCode for many events because the
code carries umask and unit bits (3756 times across its tables) and
powerpc repeats five codes, so a duplicate-code check is not possible.
arm64 is the only architecture where no table but this one repeats a
code.

Not tested on hardware: there is no AmpereOneX machine here, so perf was
not run against the real PMU.  The change only edits a JSON table; the
perf build was verified and the generated table for this PMU goes from
two names for 0x121 to one (rebuilt, counted in pmu-events.c).

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Assisted-by: LLM
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 .../pmu-events/arch/arm64/ampere/ampereonex/memory.json     | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
index 6c06bc928415..2a83782f51b0 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
@@ -33,11 +33,5 @@
     },
     {
         "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
-    },
-    {
-        "PublicDescription": "Flushes due to memory hazards",
-        "EventCode": "0x121",
-        "EventName": "BPU_FLUSH_MEM_FAULT",
-        "BriefDescription": "Flushes due to memory hazards"
     }
 ]

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.53.0

