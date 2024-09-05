Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B283CDB
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533462; cv=none; b=Ubq6EgYK+HXiCnn5OnGdAJtX4IuzlibxKp10Efu1kGAWVaK5BPcpCS4PF2gjjHuSuC+EXjCl+i6+afGQMYKDYfctBUh6rBJCBV/o/SXgfesl8iv1GasYpt0cqXc5JQJyQ5+QMB7WnhsPnI0GJNYlJzGrcY8JI653H7tb0BYF0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533462; c=relaxed/simple;
	bh=GNRh2lRRZsVbQ6TfXkUUV9PHKcq0DKE7VIm4q8c3w+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6YL/Q3I0KRI2wNvBgTxJjrZtVIjigNVV3pRTtUvb27/RL0iUU9P3QJBoMm3H+04nQDcHrOILcW8+otx5Ks3M0BmFkF3sFJI7Elegff1oztKl8CLii/Ho5/EsjvvZZvv+iq1sHu8D3eS5QyZQdGxskaO0anXeUBGAeJa1BizGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmeJlhCB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmeJlhCB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso4669955e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Sep 2024 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533459; x=1726138259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrDjMdMGpsV+SMiDpPkaWCXT3mQwpYh4u8w/BLX87is=;
        b=qmeJlhCBJzPd50fD9SIJMCz805zF6TLIMNuQQvmJVWWq+n7y1W5DQaUj1TXwihvvLy
         gPwyjJoNKMBQ5CERn55hQo8NMWg6mX5wx0hE1uK+BLh8kdr8NRWIBOhw5XXN+x8kIXgO
         gKCCJU2RbLztsRj6Cg4i1Iu+010wjsF9QXub+YV+6VuXZhuM8G0D7u772bOxwZLhVbvc
         bi5l38Mmv/fd9H8r4iYrURcoHgKagGyBS7QfqIj4cnMHEHNvLR8Ebg7HWopWyD4j19ip
         QryWtnnAovTODHizfFK7HnkH4cpjoMjy2g9x04QBQgzLXF5kiavq3IllwDbUQx367Rax
         oyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533459; x=1726138259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrDjMdMGpsV+SMiDpPkaWCXT3mQwpYh4u8w/BLX87is=;
        b=rx5NI5CYuR2DF2zNG4Pev76kzrJhwEhPkAlj1thErtB7pRNB7rHHhRKlK1d3Zd0AzQ
         IoYQKeauZ6+hvhG5vs+lTmu2msM4/wUqKQ/hFlQ1PQTiXClxifK4FlATMY3FDc5OA7/3
         ezotJlQ8AKiL3qRq6+VHgiXI9AzCwWj+nQQ5IMo3FDhi/TW/bp8UIcUZEBXU1QS2t24t
         54VRMreMYSYyGweZzV+KdFTXTgqY9i32eprLlye8JWeuFIQUNDNUgiqj2gt1GZPFrVh8
         /0/baoL1xAy97le9STL/pQVjQmvfRU0qnYimeHbN2oR+vD/YRBVavRjO1/I4fCAspo3D
         hrIg==
X-Gm-Message-State: AOJu0YwnUJkuN0QflUtbLCZjZ7GqsQUNETFC1OaP2d2yyga/JWXS1HnW
	z2HvOn1ovJFUuUXx590H+8txCbWgyFn96BwzyQRDs1DIy8+W7YF6drOGvhrGCRu57lALZR0AkDa
	qgBc=
X-Google-Smtp-Source: AGHT+IE3NCEI/gXttimfIrTl8DkzUXfi3ncD+kozCZR22fME7/IdooTQv6dLJudGLUQpNATZJI5Jvw==
X-Received: by 2002:a05:600c:19d2:b0:427:fa39:b0db with SMTP id 5b1f17b1804b1-42c8de9ddb6mr51601575e9.27.1725533458315;
        Thu, 05 Sep 2024 03:50:58 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:50:57 -0700 (PDT)
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
Subject: [PATCH 0/8] perf: cs-etm: Coresight decode and disassembly improvements 
Date: Thu,  5 Sep 2024 11:50:31 +0100
Message-Id: <20240905105043.160225-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A set of changes that came out of the issues reported here [1].

 * First 3 patches fix a decode bug in Perf and add support for new
   consistency checks in OpenCSD
 * The remaining ones make the disassembly script easier to test
   and use. This also involves adding a new Python binding to
   Perf to get a config value (perf_config_get())

[1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/

James Clark (8):
  perf cs-etm: Don't flush when packet_queue fills up
  perf cs-etm: Use new OpenCSD consistency checks
  perf cs-etm: Remove cs_etm__flush()
  perf scripting python: Add function to get a config value
  perf scripts python cs-etm: Update to use argparse
  perf scripts python cs-etm: Improve arguments
  perf scripts python cs-etm: Add start and stop arguments
  perf test: cs-etm: Test Coresight disassembly script

 .../perf/Documentation/perf-script-python.txt |   2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  11 ++
 .../scripts/python/arm-cs-trace-disasm.py     | 109 +++++++++++++-----
 .../tests/shell/test_arm_coresight_disasm.sh  |  63 ++++++++++
 tools/perf/util/config.c                      |  22 ++++
 tools/perf/util/config.h                      |   1 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   7 +-
 tools/perf/util/cs-etm.c                      |  68 +----------
 8 files changed, 192 insertions(+), 91 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh

-- 
2.34.1

