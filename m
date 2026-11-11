Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364498;
	b=MwRCK8p9+GhZzaaFSI2Ut+uaeWnjaseUUIw1F46VmpPUN0xrrgtuaBX3QBYOdvT0m9zJ
	 O0FZ/Yfxt6Ql0AHbHHbi7VLztz0uIkHVkUDuGyDQn3twEajCp4KMc/iRSwWJjVXVuAarF
	 nyaRspW5IatGoTSBJepBJKyFH5zoxZKQqP3Jsqc/+ojoha0dKbD8r4ABo1AeZlPNOp87q
	 2mfEB5bd74YTsDdLCYz/E78tOd99YoUWCpL+Ig9skEfhIzaOi70zajQyyI7VrWA+JRS8E
	 hqr0MAKnZLAe5n7P2BDJM2m8pkIwcRcaThX7JgH4AcWbp2icjoNO1xtvJ+K1SAkLGLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B8o0/xRruqTpJ2DVKaRWgCrVHgM1t4I71F6HF7YNPeI=;
	b=kUn/ehCOyvnDI+zuW0FPgylAcyDALMKqfBHQW74JoZh3RDPWZXTr3XsAKk6r1YGF4oTQ
	 8maV/B2M5Fx5I6afnB/7fWB4lBpCC4iknKOxqcmKiYWlVXUghwDK2nsz+3MevOQMmEPoT
	 cSbk/1+7FscuPtSh4oASGxgNpmJ5iAko6RLiLo60iztGyy8xIHWyfB/PGZkjMHcRxQwj6
	 4YHoiAk9P7sblia8UwT597+yrRTXGGALGrFVXUJmnc4ZICjO65w9pBQ2iYHYFkFQn4LDY
	 zpkxdAiwYs6ZHZWE3P095tNnk8l0LnFsTFlSn+FbDJPGqwgebcInO6XCgaWWoRYgmuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUZUAZ4u;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A777606A336
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A777606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cUZUAZ4u
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a3c08d6928so4660372c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364496; x=1794969296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8o0/xRruqTpJ2DVKaRWgCrVHgM1t4I71F6HF7YNPeI=;
        b=cUZUAZ4uxAQeNHm2vtPSqICmW+HCo9NyN1u+RqdUvUF5b2fHxEIBUcimMdCbsUZt4+
         F6nwsDB1Cr8vOU5SRx7OTxgjfQF8p5S6I7NoHLf2B4TEbeVDIdX2jUCOtsm7GWNVC6KQ
         LWP3j6mqSGMR237lyAXlRzUyJOHFyIy+w2vRmR+sPQJJpDFwn6q7nHASVV2hR/uwrf4K
         kzg30wG6EULzaLsWdljYgkN5z/gFSPrADGKfnAgBfO2WTxkt9uX5PoqN5kCeG6fIXR9/
         apq+kSY4w9fRvlN7hozuQ1/U54evyygV6k8xOzZchUYGXId8WSJUcWvYZKOmfnRh+Sex
         uq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364496; x=1794969296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8o0/xRruqTpJ2DVKaRWgCrVHgM1t4I71F6HF7YNPeI=;
        b=p2gB+lD7pF7cb5ncZKs80UomR40lo1fKbatLa2HlGmYrKx0xR2g/+7vMYMMoI1afGF
         yFBehmoDzavVSgQMGTTaeEDvwy//NtINpcIth9u2iPKO2Ziu1UJ2QcJJthnE13PXSjM1
         DQMdL9WjWjX1c2Xo/PnMXttYVQVEDiC8EU+m+/oSriLROJp8WVLKPrLpxlRImPE5HiaF
         q4IfLasAMCZa1UGLSnS4ekcuTD+0uh6wEm7KN3bXe5FmUmfMLIlHh9tZgPkAsHFD24eD
         wntULMYGfHhVHteW8RFUrqbS3EcHtIYNTUK1TgHQF4NZzu7HhxhOL4KgK4OpphFE7OoT
         2/Ww==
X-Gm-Message-State: APuU4Z8J/fgzhgg3eT5KIgPVo959qdAAnc66otbv8GgXxtFstj3HYklM
	oLGRCRYKBX98qyOShzKw+gwBxPYix0P6D/LyFYev/PKmQHD/1ggKdojgiqIo70i6
X-Gm-Gg: AYBFou1HXCcdWie+c6F+7JynDQTfLDt/aotwVOuTX7h5RmKlXnfDJqMoqnv84YtRCOy
	UX42Vh3h3IseQp3fbkqh875U5crsQqKC9BfOKRHbCz4z70XJ7v1NxKm5mZ2VEiHqGOKmAnhvdyh
	UChTL64hru3HzCofXpG13pp0fttVdO60UPUgGC2nLa6ZGQxbRlPEiI5zVZRsXJSiGRvnsUPtf70
	zfZtS3+T++r9f6NDz3xxYuL1SjKWT3O6wXPAxkYMbZvYvQd1BohuCBKIZMHe4lRIK2BiCHLAB0a
	evQwPlD8vJr1GqAfwKUUjxbpEAQIdHpuRSL+3CrT59JX0FLVMmKLEtMm0qrISryJPbIEI8QRqPa
	D4YHpIEEH7F/3Ru56zjVTN12n1NINZRkj788WCY52qAPgo2vZUddy6sh1KUXP+jFvfqGqmtQ4Q5
	olxxkpOa3vaJM6VlLVCqxYL0LsxZNBD7OnMLy+FHn/hQ/FfuCPOkMiG1m4N/ICMEm+vl+tGQeO5
	6ZBtUX74zdmFoi2hkwZxyuoPaiOKqb6aq0g9+clgRmJN/NrOEHG1eDTEqM6pPKkmYmQwUzTsJ4o
	3ifshV+lthQ4rFXuU0+sLg==
X-Received: by 2002:a05:7023:d0d:b0:1a0:f970:4f5d with SMTP id a92af1059eb24-1b3c0310062mr1073203c88.17.1794364495954;
        Tue, 10 Nov 2026 18:34:55 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm11752369c88.4.2026.11.10.18.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:34:55 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 2/3] perf jevents: Make the model argument optional
Date: Wed, 11 Nov 2026 02:34:47 +0000
Message-ID: <20261111023448.1970467-3-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111023448.1970467-1-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261111023448.1970467-1-takano32@gmail.com>
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

The model argument carries a default of "all", but a positional argument
with a default and no nargs is still required: "jevents.py x86 <dir>" exits
with "the following arguments are required: model", and so does any caller
that only wants the tables for an architecture.

Make it nargs='?' so the default is reachable and an omitted model means
"all".  Builds pass it explicitly, so the generated tables do not change.

Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/perf/pmu-events/jevents.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 86060a228b75..844fa82887bb 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1486,10 +1486,10 @@ def main() -> None:
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
-  ap.add_argument('model', help='''Select a model such as skylake to
-reduce the code size.  Normally set to "all". For architectures like
-ARM64 with an implementor/model, the model must include the implementor
-such as "arm/cortex-a34".''',
+  ap.add_argument('model', nargs='?', help='''Select a model such as skylake to
+reduce the code size.  Normally set to "all", and that is what an omitted
+model means. For architectures like ARM64 with an implementor/model, the
+model must include the implementor such as "arm/cortex-a34".''',
                   default='all')
   ap.add_argument(
       'starting_dir',
-- 
2.53.0

