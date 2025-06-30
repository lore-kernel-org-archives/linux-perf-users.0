Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151A299949
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301083; cv=none; b=S/kW8gRdVywgb3W7mWYkhx6Zmcb1019yQEcbISXoNqQheg0nO6T5QatzYmEZBvB7LDONeNurTEpWk1b1x4TwINqD2BjktqcZG4YPv1260tD4grLqdagAou6MhRKMrzIFp8vpcIppLjOQbLqz/nvo//6PTr/X6qR3RGS3wV5XsBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301083; c=relaxed/simple;
	bh=sRS7Gtylb6zmmWkrE5k0r/XG56fFw//pjn/SOKSj0FY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ABwkAgt1+UhajQoF5u6GM2aZAY1w5rZXQFdytgOW5fD2Qn1IzHVy2+LUcht/F8MCDstPHldFupegQW2ZbR5A5AxK0N8LRG/gxGreuhyk8rV6ymXQNINqDezTdzmYc37hAoH1FeRKtu6Z5BNCJX2L6/Xl3COTZu1jWDkio4Pei10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Dup6ZHc; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Dup6ZHc"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31e1ef8890so1620870a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751301080; x=1751905880; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7uH+zUAqqmYkd4i1H0IIyCkQzYRAUthnTfATCWP3FI=;
        b=2Dup6ZHcNmOPHeq9439iINORg3majCQf8uW52h3dq0dLM4BPgP1CukvKGZjcFvoKr1
         6/OKymcOIbdhb0UVz7e83imEXORMef6RpkD95ERDj8lW7KZNKD8afsWy5zLJy7sMlnvx
         EPrSX/D9CEUHZaMK7nSl2I1I6NsihtEq9lzx+PDnquOCYjzcgYNI8DIDjrJN1kaVg5Z1
         IK532mULu9E7HCX8PF17g95xaxk/WJT3TOzO1mQs/pIl7b+GuBHsFzkkGmuX2YfoxGEW
         yi7jJPnosnptBYxiHg7uLosZTzmX8GCf+xfrJLeCY1oTbL1dgf1DSi7LFrJQBS/Fxe7n
         l/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301080; x=1751905880;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7uH+zUAqqmYkd4i1H0IIyCkQzYRAUthnTfATCWP3FI=;
        b=R2fBe0rGdxJvAHoeA0q5s9aTzewQ+isVn7McwhBADz4FoCuifotyafKIg2k8BIYDo6
         B03IHR6kAolDiLk5ub/AwgeSFqdARJ8eOYNkvZ9Cgb0XLKy0BhU5igQthU/ofYvvk/e7
         wpPuZpk1UCLoEryJx2As/YliJmjSDqsMFtApjXFhX8k5mpqPD9FaUy1WGEYo1XOhj8Ub
         LdFsM7BiD0wQbWfUczkeKHvq0tr2Ebzg146tuR/JMh6ea4wZIQNpaVk2ACOpFN6vTq2Y
         rlX0HsA43E1xG3Q+ZjDzY2pfGXB1h3Zdqes6HyYehsYWq3sQzYOwcGEczKn4mzjZ2yJY
         golw==
X-Forwarded-Encrypted: i=1; AJvYcCUjlXWihxt/KvdKW9vjCvItCTPTNom2XnMG0ZKFwg+niJi4a48/3b4gBnaOozd5RXHrMnxyJgxMtzB3wQUjpJSb@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSjHsWdSNar6qP4Yj6Ut37ZJXUXWGWMDIXiv/65wub0kRF5Qs
	q39C38LadYTkMM6rvr+/nKVJ8P5t1stNi0z1SosSnsdMNQNdnwDWCPruVLtlzUTZePtflBP1aL0
	zvcyxfDK7ZA==
X-Google-Smtp-Source: AGHT+IFWzwOouegVUYgVBzdfVlIDYn/kbQRbN9BfUtxnUtP00uSASKw4/kXNprLHMt117HdGPMWzk+pRYSkB
X-Received: from pfhp11.prod.google.com ([2002:a05:6a00:a0b:b0:746:2a27:3025])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:220:e5e:5909
 with SMTP id adf61e73a8af0-220a1696693mr19922880637.20.1751301080153; Mon, 30
 Jun 2025 09:31:20 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:30:53 -0700
In-Reply-To: <20250630163101.1920170-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630163101.1920170-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630163101.1920170-9-irogers@google.com>
Subject: [PATCH v2 08/15] perf vendor events: Update IcelakeX events
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

Update events from v1.27 to v1.28.

Bring in the event updates v1.28:
https://github.com/intel/perfmon/commit/c52728a46cf37ba271c09b1eb7093cfc82d=
fbf29

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/icelakex/pipeline.json     | 2 +-
 tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json | 2 --
 tools/perf/pmu-events/arch/x86/mapfile.csv                | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index f1446f1b67c6..f3a0d7f49af4 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -477,7 +477,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
index 8c73708befef..6f84ad47276d 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
@@ -8193,7 +8193,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 missed the LLC : Counts the number of entries successfully inserted into t=
he TOR that match qualifications specified by the subevent.   Does not incl=
ude addressless requests such as locks and interrupts.",
         "UMask": "0xc803fe04",
@@ -8234,7 +8233,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Inserts : RFOs issued by IO Devices : Co=
unts the number of entries successfully inserted into the TOR that match qu=
alifications specified by the subevent.   Does not include addressless requ=
ests such as locks and interrupts.",
         "UMask": "0xc803ff04",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 960076e3f66f..53c0d19c51d4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,7 +17,7 @@ GenuineIntel-6-A[DE],v1.10,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-GenuineIntel-6-6[AC],v1.27,icelakex,core
+GenuineIntel-6-6[AC],v1.28,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
--=20
2.50.0.727.gbf7dc18ff4-goog

