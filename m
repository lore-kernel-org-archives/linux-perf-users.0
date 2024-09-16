Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DC15853E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495100; cv=none; b=X8sKOZ9PsiRRjZp+wd/ZMi+c1S4n169T1VPlBTFVnb5SNuRFezfln7FC+rLM4uuMqB9b+DaHBwObnpePZAMqOilDYkHkZKFc4QqJe2lg8jFFTKHz97/A+FvlKH2Wm8X4DcIemHvO0Kd0xQYQTUp8QUI0xZjCBlgACcP/amSR85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495100; c=relaxed/simple;
	bh=56XZscv93gXahk2skTFRJiZytJHzWDv0xVdSzYmwN00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMei26he9vZJEAdw3MdZth2ju6zGJqYT9QVoixaZJeFfDBEj+MfWVvZTWHZatZr1FtJCrlyJ++0/Z48Wo/9LOONYovb5yWYtsnV9AorERQCjpzVorVN86UbcN8YRMigKRGRZ/E1qvtXtI2FeCdqRNY9mo+MrpgjdK5Ydn8kqtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oi9tDHvm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oi9tDHvm"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso3430198f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495097; x=1727099897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWD4OzQ73S/BofCwsvT5WCADDVx0smIVRehPjeL+B1c=;
        b=oi9tDHvmLu1fihFx4pMhDQQgNR8zUw0J93xqQa/TMTguheickO4E4Vvl51ZedLH+XD
         aouJMD+MTdGviNc6n8sQ70uPbTTEdCVGOadrJ4ZXk2P/hxmuLMAsKQO8cFlxDB2jSyAo
         BEXCHWz8u5dGQiA1x2B0OMJyGmopVYwYL2NAklXaCDt/jeJXPqMIR05ceKw4EP5wUmTM
         puBsJ1bsWkoRz3iuNuabqAXVlvbiJsDAF3DbZNqMGNSfmt4zxFlF86QPEpr2efQ7zy7Q
         UmdO3fwNeGpB9pP3NHh6hjumzLdFqZtS9CcVh0xXFQcC2dq89irfAC7NftvQmLQN1zM1
         BtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495097; x=1727099897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWD4OzQ73S/BofCwsvT5WCADDVx0smIVRehPjeL+B1c=;
        b=u8Dihnf1x/7UsTlfpnWzwCWFfebhLHWjhxlQjYTKx8w/7HKV08PNZ5dJqa+5VmIiLN
         vULGuIudjpe3foVkXFkggnSVT1Pz69oekAssq0yN9/SgjopXmy5u5d3CWdJbZlgVG2wf
         /kxoQmj3YrOZyIzKyc1PNLj/o3Q80Qe5rwv/WXbTz3zynoem4uxOoiUlI4hUpVuTCN6r
         69ydg9d6wHcp2XUA3ioLN5/r7yNgzkA2LL5jBSgydG7P40n4bOQl0rHN2TMsIb3U6xG+
         Iks6mwCppe+yNxvsWRu8Pzmo3Ro0osBIbBpiG2RE6oR6q5/tdnVlFczq3GpCrUOKYwk8
         AaiA==
X-Gm-Message-State: AOJu0YyNUjSWuF4RvKxZQaK9E1ZTGu+bdohLpz7DrsD99xtYxNXNmP1E
	T39nr1t5v81HhFPpeb9ZbLyaUocFvRj2aDBerIQiRk3jNaBF+K7wiUMMArlj0nygpHiSS0JR+fr
	D1yK+OQ==
X-Google-Smtp-Source: AGHT+IGroapJr5XKoJ7u9EoDivKNB5We5yapfjogX886lT/lHYawKDjY0s9FPUZyyWS55cuS69bTfQ==
X-Received: by 2002:a5d:6c63:0:b0:374:c658:706e with SMTP id ffacd0b85a97d-378d6235f84mr12268353f8f.39.1726495096385;
        Mon, 16 Sep 2024 06:58:16 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/7] perf: cs-etm: Coresight decode and disassembly improvements
Date: Mon, 16 Sep 2024 14:57:31 +0100
Message-Id: <20240916135743.1490403-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A set of changes that came out of the issues reported here [1].

 * First 2 patches fix a decode bug in Perf and add support for new
   consistency checks in OpenCSD
 * The remaining ones make the disassembly script easier to test
   and use. This also involves adding a new Python binding to
   Perf to get a config value (perf_config_get())

[1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/

Changes since V2:
  * Check validity of start stop arguments
  * Make test work if Perf was installed
  * Document that start and stop time are monotonic clock values

Changes since V1:
  * Keep the flush function for discontinuities
  * Still remove the flush when the buffer fills, but now add
    cs_etm__end_block() for the end trace. That way we won't drop
    the last branch stack if the instruction sample period wasn't
    hit at the very end.

James Clark (7):
  perf cs-etm: Don't flush when packet_queue fills up
  perf cs-etm: Use new OpenCSD consistency checks
  perf scripting python: Add function to get a config value
  perf scripts python cs-etm: Update to use argparse
  perf scripts python cs-etm: Improve arguments
  perf scripts python cs-etm: Add start and stop arguments
  perf test: cs-etm: Test Coresight disassembly script

 .../perf/Documentation/perf-script-python.txt |   2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  11 ++
 .../scripts/python/arm-cs-trace-disasm.py     | 127 ++++++++++++++----
 .../tests/shell/test_arm_coresight_disasm.sh  |  65 +++++++++
 tools/perf/util/config.c                      |  22 +++
 tools/perf/util/config.h                      |   1 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +-
 tools/perf/util/cs-etm.c                      |  25 +++-
 8 files changed, 225 insertions(+), 35 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

-- 
2.34.1

