Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9F355F43
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772879; cv=none; b=HkjwF3YqDIP8dI3uO8kmkzjuXa6506xxhZq98Q3/gX6zWEZjMnsiQbinx81j94GVUNd56z37/WKRNgpUDiETylU/Qw45k1gJf9qGelBfOlDScVf814Lh2de6w3qiU0CjQXcszzNykyOccr56XWHJu5zN4xGQFegsHOV/5F+yF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772879; c=relaxed/simple;
	bh=IlEOEK9psHRcUCQ0TvYpAEPy8eKK+XtGT0cHQnAKG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/gRbWX1bq1NR5+Skkf2j0QUt4CmleQiAWQjzuHT1G71pi0ByvNhX5XUaH6Y22ycKXWuvWvJw9DLnz3I9e13Ptr+GWLlUwesPKaj/QUzNbdTAiMjA5/ZgqX31jaQB4b8dX6324YHxXWK1EmrpnreE8u8ZK5SgaUtQdq0OkxG+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fsonaWf+; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fsonaWf+"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-79a60975dc5so16269757b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 15:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772877; x=1776377677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq61NuSioqeK9Ij19oY22/JbQCoqVgQAnKmc0h81Ayg=;
        b=E9fPIuXSZS/6PsJNglzbssLjKNTDYHLJngSOZ7sQ7bNZngP7ZgUMN4rUPURYP5+oA0
         9onVDVVCKaXDW0chNG9l1vDt1VjAaoUvroaaYRJ1S6+2cjsFSR1ZDXvIG6piqbgWd31o
         bNVeV7hlxMGIk4Nakq4HvIYD3YYvwBI9UO1tgy3cGKJooLhexGO9KL5nr+aJsNdYVrZ6
         l0NTBSbi+lqfYHyQIs0nXkgUpnX/AmN2ZCPXdzJ5vygncmP/8OKDXV+QIirx/ztn9O2g
         gMJxWJVMs1jsuOWiSSH0vfIsLd33qAd5F6Hw5RwtRQoSKv84f2mr/4bEbwQ2jvbP5LSo
         G0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfLSdeCwTpA4j/NfYHXPNtEp6MZOjzecbe7MiGtS1Nqo48esBCHgaMGVKQoJlD4n0TF5mnFTE1omeHRBB0cs2l@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqygHVu4YdnES1ZgUXS/oC//HmTv+OUuJBTva+Vq5SyCZYwMt
	dnhiJRZLFds4ac8uFs52lGKH+3Cs8geE9nMAiDz2uiBlMd5kvAqp5MbTjnpF2T6a75vr2ggBvLo
	G8OyK78tapZAxvJVOmYacJVPw+G46x+Q0dShX5IQ+h4MzSG0Rt4NjS1WvCp9lw4rnkBJLP+PFOT
	1v5YC8o7lxOj4MoKS9UMkG/V0rs1Ahx/8IfNt08NDGnUeZ8RfMBeeyhaLm36czpV2A9+jr4ctfB
	7D8dKz8LaGG90166ZieDgCf2Zw=
X-Gm-Gg: AeBDietChj09BlgszkRjgvz45ynKeYLVoGqU43a1CLV/pOtXB7WuKk6keUHzEOYBXgi
	2yzAoQgFQjm/0Albj3jyO4P/Q9K6u4H297ZWZCTcQVv8ZzeJO7EUpp2VEtPbrkgh1PdagTRFI3C
	yjMPMvv2DJ6F+DF/hOtnej/Q4ePNgjUGaOsn0IhvHMVxtPn68Gts+rLku++SxaaKm86Z5ofUVkq
	NUca8ByW/Si6xpx4voUh41//4iddj6uNYgy/8mKc4/bPb/krd1BJCZfc8XtRIuzspkb6wp72lDU
	pAtNb/2Xu0ocU0RWJkscfdT1N4pDg1kAgq1RlZtFScq2FBmS40wVh02m6svlcrs8INMsW8Aauph
	mqVN6aM6Bn6SnyCGf1MAyxsnXWdwsflIesOWEdxS2va72d3C+MtYhoKTsDMjFhwWWsFc+6iX3m5
	fAxLfHXrWfixCnRZJIKUmlpywdlR9kIfcFOI+J3PiUoe4LmF+Pe4paQVrZ
X-Received: by 2002:a05:690c:a052:b0:79a:b824:ccb0 with SMTP id 00721157ae682-7af7223b5e4mr6576067b3.46.1775772876932;
        Thu, 09 Apr 2026 15:14:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7af3e46d62dsm597157b3.4.2026.04.09.15.14.36
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 15:14:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8d65190e52fso252817385a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775772876; x=1776377676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uq61NuSioqeK9Ij19oY22/JbQCoqVgQAnKmc0h81Ayg=;
        b=fsonaWf+mWJW+ulrDbDp/cxtsCmaurgvpaJek8uzLorTjmLn4Ru+PPz49XhUWsR4bN
         lnM1o2R+bRJ+TH8FZhkGXrtDoHQ9iMvLda2wbrpjqXFzdd9eGrMwxdGV/jC5Q1FZ1/+u
         vlRbaV0u0KgTyVV2OWje8Tjsn5tR3wAm/dK2c=
X-Forwarded-Encrypted: i=1; AJvYcCU+L/LBS0+r4mmYN3qY4f9mXzgbrtbnVzOjoMsNtDhhSA19gf5lmU9n5YdlkGT//egpg76CxorIPdzrOD0t36ng@vger.kernel.org
X-Received: by 2002:a05:620a:4688:b0:8da:358a:c481 with SMTP id af79cd13be357-8ddccb293f3mr107438185a.1.1775772875016;
        Thu, 09 Apr 2026 15:14:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4688:b0:8da:358a:c481 with SMTP id af79cd13be357-8ddccb293f3mr107433985a.1.1775772874510;
        Thu, 09 Apr 2026 15:14:34 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb5f89ccdsm56866385a.5.2026.04.09.15.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:14:33 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
	id 7DF92D86; Thu,  9 Apr 2026 15:14:32 -0700 (PDT)
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
Subject: [PATCH 0/1] perf build: fix "argument list too long" in second location
Date: Thu,  9 Apr 2026 15:14:16 -0700
Message-ID: <20260409221418.185343-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi all,

My apologies for not catching this one sooner. Using xargs in the actual
build recipe worked, but it turns out echoing $^ in quiet_cmd_rm also
offends the shell. Somehow, it didn't show up during my tests before
submitting the previous fix[1] for this issue or I would have addressed
both together.

But then it did start to show up. Like this:

  GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
  TEST    linux/tools/perf/pmu-events/metric_test.log
make[5]: /bin/sh: Argument list too long
make[5]: *** [pmu-events/Build:220: prune_orphans] Error 127

This was a bit of a head-scratcher before I realized that this came from
    quiet_cmd_rm  = RM      $^
and that no attempt of putting quotes around $^ would help.

With change proposed here, it'll look like this instead:

  GEN     linux/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/extra-metricgroups.json
  TEST    linux/tools/perf/pmu-events/metric_test.log
  RM      ...634 orphan file(s)...
  LD      linux/tools/perf/util/perf-util-in.o

This is probably a good thing, regardless of the shell complaining,
since listing 634 files in a so-called "quiet" message is probably not
very fitting.

I don't know why my build has 634 orphans every single time it runs
(straight-up cross-build on x86_64 for ARM64) or if that is a lot. I do
get the impression that it is probably rather unusual. Not really doing
anything special, though.

Also, the build machines are running Ubuntu 24.04. As such, /bin/sh is
provided by /bin/dash. This may also factor into why I might be seeing
this issue while others may not.

Again, sorry for the churn. Hopefully this is it now on the orphan front.

Regards,
-Markus

[1] https://lore.kernel.org/linux-perf-users/20260303211503.165337-1-mmayer@broadcom.com/

Markus Mayer (1):
  perf build: fix "argument list too long" in second location

 tools/perf/pmu-events/Build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0

