Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A82221FD0
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686579; cv=none; b=VhgkJAWeuOze/8jeHPX0G763kZi08lc/R7gwqtrusb8P083fo+12xdPL6dnvSyYZrlbaLyWAhP8Wk7cpM9pAkIkq4xSvB4BXMW6bnF4N3YmTI1GRu2oZ5Jhotf0F67HHSG/FnhZ+xvjYAa3xNmt+sAC9Nzc/pR+9xsGdAxvsDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686579; c=relaxed/simple;
	bh=Pjk02iZBUF3faJ9OfwJSxc90AdIcEl/VwK5o/FaFnu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=La1GGqCnoFKWFbEv5XmNGNPTQCbASAUIZNtxDhgAhCV/TLGQ97lwkdDPnakKvUfUsCZIoa+16n5HIqOEfslKpyDiUyUDtt+BEiod2HR72QTzNHaPHSRo5dsi1U8LY/7w6DCfqMBELWZy4A6PLgpAK9M9+v0CRrKS5IWNsklRE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WByq+Gmw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WByq+Gmw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236445722f9so1882355ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686577; x=1750291377; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMWlsa8rt4dvTdh/xG3kGdrV56jBuLAq/3tOzqWqwtM=;
        b=WByq+GmwxWNVPcGCBSjQiz97IfjZKb30IiO+4ocUC+m9v3O6h0UVuX212EwhR5goLW
         J6H0fcnQUBWLiy1/D7JRGL4y+6dlE5uBMRyxziZJEYFCuFQY/TKlzGa2I7d+eT/QYPQY
         Vij3wwMV+MF+H44HLZAzJntvHlRQf57ycxWF261/8hZhKpgI12WSDQ6FU0aA2TxzxKre
         JP2Ul/LV4BWkLut2+ExyHCenO30/jHjEdY6qRSSTkE1hYyJ6PVrMf5oewRWw6agYGUHv
         jNdZ2QgrxNkI856MTy4o4UX8i+SxcPd9km6yS1KbJVWulePic4Qes3/kR1lsaka8r+XL
         pFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686577; x=1750291377;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fMWlsa8rt4dvTdh/xG3kGdrV56jBuLAq/3tOzqWqwtM=;
        b=eyxDKxGaY0TPtC4MFb93BNjHB1KzZ/Ppj0ZgcvTgnq665ebEaor9D4TmYdkrDCuqKq
         vpR9l7hEq4tD8eDpgnB3Q6T15xMOXvA0qFT6E/oYLyxzsuAfmnKVtb1c58lfbE9hHkOt
         rvrotNEJpWOL6axQrLpMnBjsa2ZJIpK8jtXl3XkbO9HVYO+l0lGTuEYSm+Pq+jbuGyC5
         W3Xx7+U+EbHVh9SssG4xCWMm84027LNsedn1WbUNxUprsB4MQvMNe3L6TdxSbu6ZbPQI
         LYhDayXRgUYTLG0VdOxfuagVbdArDgVj6+FcA3Cc3uFljuMEvhiximM39ocqCVR467no
         dEAA==
X-Forwarded-Encrypted: i=1; AJvYcCWW+2KeddmK5NJ0ZvW4VzcYmZx6nLBCxoPXCzHRFBfpOPqzTzMKlCOtjWkqpNff+JeINI6Ss8jLVkW2otBdwN53@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ao2nXoSBgUyanz7hVqdzr2HwVv15nHHMAmV224tO9Tk2STFO
	Fr2DKcghag5LfajYFGaXzRyi7Axl9CEGj1RFv5CCPscG5QKcdDHPoLT9lG8n6FbGFmmkBIKNQXk
	ItdGwpvt8JQ==
X-Google-Smtp-Source: AGHT+IGXqboljmOGoVvybRNBhEhxhowQHZ0b6+liBCE6UD77WrKGl2AOcCBBl5t3+696YX/tvbCerp2Edn06
X-Received: from plgs4.prod.google.com ([2002:a17:902:ea04:b0:235:e55c:8df5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b65:b0:234:cf24:3be8
 with SMTP id d9443c01a7336-23641b1998cmr84298985ad.28.1749686577153; Wed, 11
 Jun 2025 17:02:57 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:24 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-16-irogers@google.com>
Subject: [PATCH v1 15/15] perf vendor events: Update TigerLake events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.17 to v1.18.

Bring in the event updates v1.18:
https://github.com/intel/perfmon/commit/943fea37d0d54232605f12abf72a812ac31=
4cd1d

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv             | 2 +-
 tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 2d9699efff58..354ce241500b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -35,7 +35,7 @@ GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
 GenuineIntel-6-86,v1.23,snowridgex,core
-GenuineIntel-6-8[CD],v1.17,tigerlake,core
+GenuineIntel-6-8[CD],v1.18,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
 GenuineIntel-6-2F,v4,westmereex,core
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/tigerlake/pipeline.json
index 7ef1bac08463..b417e1db9e07 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
@@ -497,7 +497,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
--=20
2.50.0.rc1.591.g9c95f17f64-goog

