Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588F3E1732
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228283; cv=none; b=lcWPRHTd50p6NesGk8dYt/1mu//IoR8m67Cfgt7b04S9kuctEBDtGZ0cx2jCcFalycCEZN4O/jLLEw8vVRw0vTQJ4j2+XQo6AFZwFeKva3faEL5fsFg+2hRiVxadxzA30VcLCZ7LvIXFBVBjxsW3wN0xYB+ZIeR3yAY1ZBRRH+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228283; c=relaxed/simple;
	bh=irTzU0Lwbfu8mZUQvgu8/gN8APK9/RAgMgQm0o31+JM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Jda97MGp+oX1gsrDzPgcCu0uW1aKQ94Ye/DbUPVng4UZlcqwj2skHyUGmd9gVm9ZYBUZYC8edZfEaXbdyi5BC2I6PdhUjI/2rNjpXd6+Vu4J0yNccJHLNezuhRUswxRCQR014c5StuJ2CgOo9eoVfoQ+zowTn0thfWc3emqvBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fG+D/y6K; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fG+D/y6K"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33bee712354so2192851eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 22:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790228278; x=1790833078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3wY9f2BiM8ctX++yyiyeBB3mUrtrBlYPM7oAod7QxA=;
        b=fG+D/y6K/01wC3W4NLMmTFHv/YoW1MoE7O/d5fY2jO0OBnP/NPIBvVZAhLk5cnxjRH
         tERqaJSnzI1VN/2L2ZqSKDaLn5DZ6MdnSCmHy1+t9FaK0tXuCKOI57zucIUA/SddNvXq
         V/31NFU35QjmQJ+Rifr62s8WBOzTbB5C9/VCOD1ewgTydrnBXkDIbJtySEBEM7CavBfV
         D8otNywgCXZO7b5UgXTk2iT+FUHpmW7NF4xoR+dUP+W/6bDlz1VFSK93Q9oSE0gBSjLe
         tJ3gBRchPD7s1BkrPnsJbExV/BKLUp2fh+VygJBYfqN63S054lrNhKCmKRHMkr+9lJ3F
         JWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790228278; x=1790833078;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q3wY9f2BiM8ctX++yyiyeBB3mUrtrBlYPM7oAod7QxA=;
        b=CYV2KTPDaN7uRZnBiv88E3ktHYgeXiliNrsvYfi5c4Wo7LkH1efy5O1dR5HwEwQnJ9
         GSkmEuNEZ8QbkgUep+J5iVeZvdxZqjSwJswZLAde/j3Sax/G5kcx3eC3ntXwYii2HhLr
         S3wf53WLh6Zb35/0F/BDSH+Ujk8VZjF+qZ9nr/ZCbVT+f3EyEBPLN9hUick1HRiDm8Mr
         wgM4P/fCQ61sIQ4ucNeXaQ8OO2x5OpDtjVqICQQyxAeykozoA4xKEOLA1NGADF5DI6bv
         x/NabWU7MdDPPUb9wHvgScEovYJI1I9PS4NwUKvmzjfe2KXQvSYCjjIBP5Y569LgF8mr
         6CQQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+MoiiGuKOzu6vN0sRd0m5+WDuaMEdVdaAW+iF4v3O3/+AW8bp+QmvZakwULhlhqYVuK7E71r6bfDohzZhLgUB@vger.kernel.org
X-Gm-Message-State: AFuF++lnO5CWJ4fXxT8KvBGTLy54AFeuhy1+UXvTRCSwBbM2jEpTstMg
	hw3zoY5trYVPfqkQO4p0PHS4wsHZZ376UL7batOe46tBNmIQJFszUW+zARjjPk4v3fQRgR8lMlN
	0gI7V0UkEXw==
X-Received: from dlbpt9.prod.google.com ([2002:a05:7022:e809:b0:144:bfb6:b5b2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:231a:b0:145:77f:293e
 with SMTP id a92af1059eb24-145077f2a8emr206703c88.39.1790228277339; Wed, 23
 Sep 2026 22:37:57 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:36:26 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924053645.3555041-3-irogers@google.com>
Subject: [PATCH v1 02/21] perf vendor events intel: Update alderlaken events
 from 1.40 to 1.41
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:

  https://github.com/intel/perfmon/commit/5d7b37d5671a49c72abf735dc81d147c7=
776119c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/alderlaken/cache.json | 4 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index b39c73614b86..38851c1580c1 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -4,7 +4,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
-        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
+        "PublicDescription": "Counts the number of core requests (demand a=
nd L1 prefetchers) rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q. It also count=
s requests that would have gone directly to the External Queue (XQ) but are=
 rejected due to a full or nearly full condition, indicating back pressure =
from the IDI link. The L2Q may also reject transactions from a core to ensu=
re fairness between cores, or to delay a cores dirty eviction when the addr=
ess conflicts with incoming external snoops. (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event). Counts on a per core b=
asis.",
         "SampleAfterValue": "200003"
     },
     {
@@ -12,7 +12,7 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x30",
         "EventName": "L2_REJECT_XQ.ANY",
-        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition, which likely indicates back pressure from the IDI link. The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
         "SampleAfterValue": "200003"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 866b5fba7124..748d1ee1605c 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.41,alderlake,core
-GenuineIntel-6-BE,v1.40,alderlaken,core
+GenuineIntel-6-BE,v1.41,alderlaken,core
 GenuineIntel-6-C[56],v1.20,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
--=20
2.56.0.rc1.310.g51773c2048-goog

