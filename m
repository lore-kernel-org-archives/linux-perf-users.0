Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B01F3D58
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436600; cv=none; b=kLsgky0yONDMx+dB2XQpImQIsO7jleeFf6HFFipYQSJ17UY3qNXrW08nkhqnvZxomKiDIOf4EQ9elgD4Ud3Yk3G04sHyiS3FRD9bBwWcH7djnqjAht3jHOrV7ehegQUove/c5xPCBJprRM7ekyS5MUkop6lQSih107sTK2HrzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436600; c=relaxed/simple;
	bh=uz/cOheGCgnwGt6ic1N6Vuscq6Gm3oMspfGnxKGBRG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVnOPI50Q6tJkpCkPt0tk1TZ3TTv5EAK77Gt7bvrknDuTe6RcJ6o1C3WM6AnlsyRLU7f1KRilg7Tt2nBb/SUgZX63c3NU7jws3kMirMiRl+LNz0RY0qzD5voP9/Tr/OzuFLJmXGD8+5C3KzsP/RlShqXh3F8eYeoSbOtme6LkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CPC/ActJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPC/ActJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43635796b48so20317205e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 03:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734436597; x=1735041397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwqWh99mkwgFG4i731gC0ut6m4bysgrlep8nFs6msoA=;
        b=CPC/ActJOpYZ+JDgY+WdKiEYlPAtj6pCGNhMRC9v4rm+p9UUs63iqwTgy9cYRJb46j
         dELYdiQJo0rnQNy0RnJU/GuFbWaCuViGAAOdptsjVUwZCaI4JytuT5QuL56d3/hTBUXE
         qWFKB3p03f9Atcp3UuJ0h9GQ/5n69xUei8cKJOk+ktsZv6f897UyxBK5LvYgljqmwsbu
         OBLziQ3VukHKvtTb86VCr4rh7ui8bHIQ7/nSUeRewkmbkwyOFUr8wTOR8eJp5azI0M2I
         erfte0MFWU/Ic7OAsukuADoNRXIbpciuZ7Dr1QnqEDUaENpLyxstnFg29TOCnzL6yxTX
         gSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436597; x=1735041397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwqWh99mkwgFG4i731gC0ut6m4bysgrlep8nFs6msoA=;
        b=YmaQekkiPaR5q/mfBb7+tQrwswtJSHet8JaVYjw5fS86nRYrfKC2SUwYeeiCR7deDS
         UhSvRyjE1bxd56SGi2GrRV/r0ZmKP8B3GyByNzlUeyUtjCD/1xLA6iBI7HzM0JEI+wcC
         KuNvjcMa7xMvhyxnuEITk+348cIC+LIFlwCCcvIKENCf8Gjn6l8gT8MXPnNgzs72sDhy
         qznaFwuBT4xOUrd0hnF1quSceTPLSQx6TJfOxRkAPYnne0VkL7AWpwmgwC4p/lIOe7wY
         Fm9aCVHWhYgna7RZNKp2hu0Hge/UP7b2L98M1VO/QnfRbxQaftt4JlLR0i60poaou4tq
         mtIg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Un6+ULv7qvMHyZcIissoXgBSKEjQZN8jNipSXchzMPylHCJdPF9vde64+VPrWBAvC/WOwSU5QMwgfrDyMrlr@vger.kernel.org
X-Gm-Message-State: AOJu0YweDk6TKfjPlOuxLJO1y6WKWauALiilUfUbSKrVGThrVgYz+0EP
	zHQJElMYQ2O5U1lOvz2TdkUmwS33NEK4Xg6wqquku1f/nxPhVCDMnrZR+iW83rg=
X-Gm-Gg: ASbGnctSI+O3pJqwcJFe9UVCL0OrGzfs5C8ccCbhTl6Wub3/VqXdjRFvSLierSj0p/4
	9c0c2RPMDcxBnDwtIh3DqyaaFXPoHAzj72fm/tIrmghRrpd/0h09vzcIUliw0H7lAzECr0L51T5
	fcV8SHh60QFX5NaVlWB3vO1TnaR8YucIMPXlRSCtsyARi4u8BITM29fyaZRWNPPyadcgIMhk3yM
	eRsPzfJyAXUwVUU5PQ+8UzWrpgsaKLFLr7Xu8pfHy8os2G7nDm7c3FS
X-Google-Smtp-Source: AGHT+IGwdSY4bxXI25oDz+FWewMmRHe9+KuuRiSPfZFzGZSjSm8Hi3QlFSfDLHoAEpYFbRs2avKTiw==
X-Received: by 2002:a05:600c:3b22:b0:434:fa73:a906 with SMTP id 5b1f17b1804b1-4364814eefdmr23438715e9.4.1734436597154;
        Tue, 17 Dec 2024 03:56:37 -0800 (PST)
Received: from pop-os.. ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436360159aasm114935825e9.6.2024.12.17.03.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:56:36 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 4/5] perf test: arm_spe: Add test for discard mode
Date: Tue, 17 Dec 2024 11:56:07 +0000
Message-Id: <20241217115610.371755-5-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217115610.371755-1-james.clark@linaro.org>
References: <20241217115610.371755-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that checks that there were no AUX or AUXTRACE events
recorded when discard mode is used.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_spe.sh | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index 3258368634f7..a69aab70dd8a 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -107,7 +107,37 @@ arm_spe_system_wide_test() {
 	arm_spe_report "SPE system-wide testing" $err
 }
 
+arm_spe_discard_test() {
+	echo "SPE discard mode"
+
+	for f in /sys/bus/event_source/devices/arm_spe_*; do
+		if [ -e "$f/format/discard" ]; then
+			cpu=$(cut -c -1 "$f/cpumask")
+			break
+		fi
+	done
+
+	if [ -z $cpu ]; then
+		arm_spe_report "SPE discard mode not present" 2
+		return
+	fi
+
+	# Test can use wildcard SPE instance and Perf will only open the event
+	# on instances that have that format flag. But make sure the target
+	# runs on an instance with discard mode otherwise we're not testing
+	# anything.
+	perf record -o ${perfdata} -e arm_spe/discard/ -N -B --no-bpf-event \
+		-- taskset --cpu-list $cpu true
+
+	if perf report -i ${perfdata} --stats | grep 'AUX events\|AUXTRACE events'; then
+		arm_spe_report "SPE discard mode found unexpected data" 1
+	else
+		arm_spe_report "SPE discard mode" 0
+	fi
+}
+
 arm_spe_snapshot_test
 arm_spe_system_wide_test
+arm_spe_discard_test
 
 exit $glb_err
-- 
2.34.1

