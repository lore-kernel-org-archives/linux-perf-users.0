Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9AE1BC099
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Dec 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037077; cv=none; b=gDj5bJT08heavpsMt0TBggVU8Q2C+o9GW59jeFzQMMghuGa1wO2DtRYpYsow/BcLVDfUPnxRYx4ixAA82ACy3WzZK9W4ef9ipjhw1GjIzfb6q9e/tfCvmoRJHM7cc2JDCnZB4eYgPPsZ+jAgFusRG24HA9mrvfMcko9EQCStlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037077; c=relaxed/simple;
	bh=jAyEF1XgXNFKM8eyzKIrWDhYrJjbY7DkOcBXnln8DjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nnGyloIPbo+oedOANzpmQ1K9lG2Epbnzarm6OK+vSfCHYQEe6xUoWS1LZDSDe2o5IQbJ6E9T415ow/Y2kSvlA/Z5uAT4HmBWUUWbQ46WOdWxxbSKyo3uBNpcKMgE/SYcIuDKKXfn2E0xDXJLZGmIir4uGcgmaYmS0gzpuVuFIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bQ+CAZR+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQ+CAZR+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso4306133f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Dec 2024 02:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735037074; x=1735641874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GC94EcAYbMBUjUIz25uAVNdsPCjZLYUODaiYVrPBPmU=;
        b=bQ+CAZR+LdHlxoj0cAcLpo8S+PLXR1DzMzn+bTbSzjzOZuaUMOx62tYE0IHZJ52OXA
         iQHQhrO/+ozA+byFQIi0Tmk8zDkUn/Px3q27ozgt1exORcPEYCFAsq5sCKWs9kydSuK7
         6MGkSpwe6/SpN9haktClIMlVdw2SE6Zt44tHLPDUKi5RV+2GB6zxi9aNMZnznpyv1Fu4
         hfcWe6TdyezoYbXJIzj4ftntKcMVvaXjUll1Zd2LR7wgppiYB3h5tKt5uzT8JUYCe99F
         X1dCR+qGyuv+1Xs9dW4SmXLfNHA4pxtmahhCYwkjunj+PePzq/lvznOHY3hya3h01h59
         pTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037074; x=1735641874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GC94EcAYbMBUjUIz25uAVNdsPCjZLYUODaiYVrPBPmU=;
        b=uVcJazoPi8vt/5YoX2HU1Scrv5KfbAs6m0CBFfu3DX0soA6zq8J2eqEns+W3OlRcI+
         2ubpPhLLsSjdO8tTdjRwi3iTlGLRmV5Q5fcyETKJcwdoKnpTO4YCd8DwaolTByMuHZIz
         n3nNeHD7o1Q3TsihqEyefsyOAakWTkVuogidhIWUT8xko7vgazZGmg4WiaGNQlTxyFJI
         czoaUUsARJM6kT/ERSJzZrO/4es3oA+aRQ/n4wJ54AkVpY0P6QuDHBiPG29z/1W/7TTs
         tmnZnQYqaO3cvQRho9W47lH5q0hjwFPrF5xovX7Zovn+0Bi+hS9CDfOCDZjv2INHIQrQ
         cImA==
X-Forwarded-Encrypted: i=1; AJvYcCW/ao9w/ALASCxbiQn2aZbaiJ7agjitzp7v9Fh7Y1EHNYgkya9Qipx62yTucm9BTmNXtYsDkuACbdxsl7c4dTUk@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVTIv8DwBljKZK9S8qcL9+1GyMya10HpBBUu1akqtSunsnIf3
	eDF0SJUSu4thtbNUzWPl8WljPVZfn6cx+OV7nsyAfqtvIyijyfxjNxf4GyfcUC0=
X-Gm-Gg: ASbGncuqRX57q2fgEc0xbRcjMLLSHufUGAlH6C6k1znMQ1wmgycII0s5qIV0BdaG7du
	q5pXlrgdeEwp5hGN0yyUuD7Cg6eSOWc2XICw2b+ul4yONasUVxcadTtPAkEEgstYEoKh5Au5Rbi
	PWbloTOHQooeetdwy8D8Hj4bsfvsBZ04z/4+aOcomPh1Ut/Gsn6emB13PLtpaE5PKqshnKKFhso
	7ILxixaBc7H2BvkwHgmMrQD9cC7gjPtz3aLcitfxw0vgLWtbcCpw7U=
X-Google-Smtp-Source: AGHT+IGsMgTuO0pGQvcVI5qARtXeuTRPJmGG/qKyW3MAU5lGxMoG/jQVQ07m+joXnw4orY88L8Fh8Q==
X-Received: by 2002:a5d:64eb:0:b0:385:fb8d:865b with SMTP id ffacd0b85a97d-38a223ff5bbmr15275872f8f.48.1735037073679;
        Tue, 24 Dec 2024 02:44:33 -0800 (PST)
Received: from pop-os.. ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847714sm13938184f8f.54.2024.12.24.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:44:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	irogers@google.com,
	yeoreum.yun@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: robh@kernel.org,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Graham Woodward <graham.woodward@arm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/5] perf: arm_spe: Add format option for discard mode
Date: Tue, 24 Dec 2024 10:44:07 +0000
Message-Id: <20241224104414.179365-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discard mode (Armv8.6) is a way to enable SPE related PMU events without
the overhead of recording any data. Add a format option, tests and docs
for it.

In theory we could make the driver drop calls to allocate the aux buffer
when discard mode is enabled. This would give a small memory saving,
but I think there is potential to interfere with any tools that don't
expect this so I left the aux allocation untouched. Even old tools that
don't know about discard mode will be able to use it because we publish
the format option. Not allocating the aux buffer will have to be added
to tools which I've done in Perf.

Tested on the FVP with SAMPLE_FEED_OP (0x812D):

 $ perf stat -e armv8_pmuv3/event=0x812D/ -- true

 Performance counter stats for 'true':

                 0      armv8_pmuv3/event=0x812D/  
 
 $ perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
 $ perf stat -e armv8_pmuv3/event=0x812D/ -- true
 
  Performance counter stats for 'true':

             17350      armv8_pmuv3/event=0x812D/ 

Changes since v1:
  * Add a new section and some clarifications about the PMU events to
    the docs. (Ian)

James Clark (5):
  perf: arm_spe: Add format option for discard mode
  perf tool: arm-spe: Pull out functions for aux buffer and tracking
    setup
  perf tool: arm-spe: Don't allocate buffer or tracking event in discard
    mode
  perf test: arm_spe: Add test for discard mode
  perf docs: arm_spe: Document new discard mode

 drivers/perf/arm_spe_pmu.c                | 23 ++++++
 tools/perf/Documentation/perf-arm-spe.txt | 26 +++++++
 tools/perf/arch/arm64/util/arm-spe.c      | 90 +++++++++++++++--------
 tools/perf/tests/shell/test_arm_spe.sh    | 30 ++++++++
 4 files changed, 137 insertions(+), 32 deletions(-)

-- 
2.34.1

