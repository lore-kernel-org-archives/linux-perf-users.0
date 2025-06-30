Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D312D3234
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301093; cv=none; b=PeBlzDyjjGZ1pZvtznlHq6FunaXfcBivpD9ZnW6VvBJOSa4a6Bse3NrNPtpw1neWyxRTAMsvzZiEuvB4YKd9XTxfeQlypyGEFN/Mrcv2LhtIyudvippeUeMUt+DJtRyl3rBaNF8aNr1qeNMMWG5d32Ox4ppahmNN1AnrZopHTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301093; c=relaxed/simple;
	bh=UB3LC+DAsMPcMj2tI3JyN+CwaCI4DfXgOfh3KKQ9Vis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QJMcsiqJV9jeIxrEJ1zOWnX9WytylS7OjMCGfH1hVbMnJJu+cNp0iK7Tp6lfB4t+ADWIwmkFwR4So8O8KrnAM8N7pHK+f2RzANZ70mjK86AbGacCk6yrlVV3L+hxF9ZWuVN0yDPeib/FtTK3zBDjQXeYtz7p307W3/0ZhV16RSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwnQ/NWb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwnQ/NWb"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2369261224bso26105915ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301091; x=1751905891; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VNpGqNb2MHhnrI7sffrX6seyL0+K2TdL07Y5kBKeGQ=;
        b=DwnQ/NWbzWh1FJ1omtPNr6W4Bpi+H/+I/5ISwNLWzpCJ5WpWr7TwIK6H33wTlXypx/
         gUCClurXIwOlaeLe0xlnBn3UIWGcNJQUJLaCMzZGryXhsKyJFW1LCnB31Ni0vV+SJhCO
         HxYBRlKQqRbgZEMq+feWVnA+bb7zpPWGrmpQgL6kIuF+FCGcklxu0uT5j8wTCF3rD+Xz
         h+O0MWYd60fmBthpMkN6opNe332AAHV5DSkWAB+QqRfouKeXTzTPz0cOIhLQ0b2QZxS1
         DUum/bTW/6Dw3nbOfpw6wJuEYxq+BHGuGNBnrqaPHlUUcy5c3XJhzy5UDL1TtyjaFwpQ
         Ou8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301091; x=1751905891;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9VNpGqNb2MHhnrI7sffrX6seyL0+K2TdL07Y5kBKeGQ=;
        b=rMd4fJF2Mc7TcF8ciWIicphn/0xCPavjeH52dmoTi6xIJmnClw4U7MSYbVky4NG2+O
         MIJMt7GNqJS5SU/4PutOHsvBXXLHmsW+lEOXhkA5rr0/oeFofO+FCN8E8yfZqDG1+nzT
         EqH0F/4MeML6YsaygZ16HLe4EDOL4Ey49SaXOM71Xi5u3PGRL9kTG+S5fYSeU8afJ21P
         5lyaNBQZSkGufpepxYlwDMmxm2pucD/Feyb+4jRhfkhO0rGOORulT6KfmxE7yHqRUDH/
         w/yA4rGS04D1u/FJYAuQB20KJZn/wsy0yQRUP4lBuy9VnAZR4h0iAWQi+7MXeB1jvzYa
         OLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIO45XUwPwR6rbQVob/Dh08Hli2qjHQO3BdCJbh3IOY2VATXE9QATXPd7SNHJsoO010gsQjix+lRIKB212ZrPG@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCVVedPDfFI5ocwj/vHbaqpTjPb51kOYoxQbdyN5YbXbskz9K
	j8jRo0L1mkU2QuUELin8H4DeK7yn6MrN1ZFSuF1z/oHHryMy/VQLKUk9tvdZtYF8MCmTQjm7r9T
	cVVQCaFbBIQ==
X-Google-Smtp-Source: AGHT+IFBDK6gJXuL74p8rOzSw7isbI3y77om1IjixdaHY38msI+2J2/4El5suMFOdxy2nN+pHGs+DlWYu8Lf
X-Received: from plil12.prod.google.com ([2002:a17:903:17cc:b0:231:def0:d268])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b2c:b0:235:15f5:cc30
 with SMTP id d9443c01a7336-23ac40debc6mr203270255ad.16.1751301091022; Mon, 30
 Jun 2025 09:31:31 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:59 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-15-irogers@google.com>
Subject: [PATCH v2 14/15] perf vendor events: Update SkylakeX events
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.36 to v1.37.

Bring in the event updates v1.37:
https://github.com/intel/perfmon/commit/6ee8e4cadda8b6954bd84236e20fab95e34=
5578f

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv            | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/pipeline.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 54c2cfb0af9c..2d9699efff58 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -33,7 +33,7 @@ GenuineIntel-6-8F,v1.28,sapphirerapids,core
 GenuineIntel-6-AF,v1.11,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
-GenuineIntel-6-55-[01234],v1.36,skylakex,core
+GenuineIntel-6-55-[01234],v1.37,skylakex,core
 GenuineIntel-6-86,v1.23,snowridgex,core
 GenuineIntel-6-8[CD],v1.17,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/skylakex/pipeline.json
index 3dd296ab4d78..9a1349527b66 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
@@ -542,7 +542,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4C",
         "EventName": "LOAD_HIT_PRE.SW_PF",
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
2.50.0.727.gbf7dc18ff4-goog

