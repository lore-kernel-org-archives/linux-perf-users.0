Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC23946E
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Oct 2023 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFF+wSOi"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1721181
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b53a48e5so3041857b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280341; x=1698885141; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fS6WNbKrdhI9LhL+fdlwOt3dMxlWD/TnwGXZN+cwPHo=;
        b=dFF+wSOiXa6VtieUp4erRA+Xo+PUeFOr0rGMf3qJnncGDZe3aArvZ62vo7RllHHHJi
         6Z/LdV/YyP6A/DhGYEQCnyugrD2o+r1pG/ixdAtcPR3gYE0suXd6CR6zNfMNnMSA98R6
         mPFCInxefNJFzhX5ffLlUzXmVRWiUinEZOAHVmfe7FuOEjTwh1cDY7sNWP4XxnCiw5hV
         mn6MsyJzsS/IO+JWJWA5QeUIU3yQ0oMtvRe1liVXbnpptxj7BQcAZFCILD+UZpmwXNzQ
         cmmOMKeDny7YTBtQpAl45iN2pyQu/f3+FvZ01C9+n2OABeV8S9zB5DeV2nDNxyKyWOiI
         P+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280341; x=1698885141;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fS6WNbKrdhI9LhL+fdlwOt3dMxlWD/TnwGXZN+cwPHo=;
        b=pfTQiDksa90ehqBGJZFOQnNrUA1C9SX0LNgz+9LzAx272Y7G1dgsbsCQy+vdW/QFWO
         W1zF0PieGNo5qZfVRacxqynZvxR61SDy0Na8FIhlUt/Ke2PJc7tWPQuNKZwMunsQl18I
         Vj+gUlsHaYDeuT0+/zsrPUgRBi7aRcgDb6KIOaAJaf5FEP5q+pZ+An6LBW2KnkyUwrnQ
         VUDqVD2yaare9m/UvagNlpaTq/O+HPa9t3vKe56spdWsugkphT5cqOb+0NEq0HdaaOlP
         WcIucEhCCfF9+eliV5ajMUKGa1BzbCkTIeXPuWtNTG+ZeMPIwYozotubD4DaUKxzYr4q
         +Eag==
X-Gm-Message-State: AOJu0Yy6rB3T28Tg+uvhlXzCuAEq40Rtt90d6Lbbjb3HTS6n2EmuMy6T
	cUf0g/+QGrBpOgR5M0jHx3PY5T3bbdAH
X-Google-Smtp-Source: AGHT+IHa/FHFGFt42zD1qd2yqnDQO99w6WxAOWdDuStE5VU4UMbiBqGt/AZOayawBzwRXdJWlUtN8pYeZKsA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a81:4c8f:0:b0:59f:3cde:b33a with SMTP id
 z137-20020a814c8f000000b0059f3cdeb33amr143012ywa.6.1698280340923; Wed, 25 Oct
 2023 17:32:20 -0700 (PDT)
Date: Wed, 25 Oct 2023 17:31:43 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 3/9] perf vendor events intel: Update a spelling in haswell/haswellx
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Zhengjun Xing <zhengjun.xing@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The spelling of "in-flight" was switched to "inflight".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/haswell/memory.json  | 2 +-
 tools/perf/pmu-events/arch/x86/haswellx/memory.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/per=
f/pmu-events/arch/x86/haswell/memory.json
index df44c28efeeb..2fc25e22a42a 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/pe=
rf/pmu-events/arch/x86/haswellx/memory.json
index d66e465ce41a..2d212cf59e92 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
@@ -62,7 +62,7 @@
         "BriefDescription": "Counts the number of machine clears due to me=
mory order conflicts.",
         "EventCode": "0xC3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data in-flight in the pipeline.  Machine clears can have a significant perf=
ormance impact if they are happening frequently.",
+        "PublicDescription": "This event counts the number of memory order=
ing machine clears detected. Memory ordering machine clears can result from=
 memory address aliasing or snoops from another hardware thread or core to =
data inflight in the pipeline.  Machine clears can have a significant perfo=
rmance impact if they are happening frequently.",
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
--=20
2.42.0.758.gaed0368e0e-goog

