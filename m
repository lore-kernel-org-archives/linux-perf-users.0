Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4232586
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O22icROD"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7359FC0
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:45:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-577e62e2adfso1929336a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Oct 2023 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269525; x=1697874325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqzza3fB+lsTu4YDyKGQewlzLBuqykDjZxJnSTk9ygs=;
        b=O22icRODd7YeUQ3NMkgufhsxl+X9aQcr1ZQLQqEAoLgn7zhy2F8gUxcADh7HEnpbaN
         BDNjPpsgMNEGCVkkSNKepZdev+jjuy5WERpN3dVLetXF6YxSnRNFfB2YDxKXXTPBT6uV
         lGdsz1iQswTpiRnmBr1BhlLayVdFMaA1U7pZiKaDIURFHFDttabWiAocm2ivvmUb7gLL
         xUu/WtsN8W7TAS6IKEDh7IMczr6X4YYIoWP3jxqSsfE4mwrX5oi46HadeUqE+ceq05gF
         BZq82u5ujjzzzU1COKg/a9OmrYTVd5sZC+nWeYdvMHnWk2TBj5uZMvP1yb8VtQnQFeao
         eutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269525; x=1697874325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vqzza3fB+lsTu4YDyKGQewlzLBuqykDjZxJnSTk9ygs=;
        b=B/Eyp93/Lh/5G1SLv9Mn+0CkAORB1Xbugj1+vLMVPsxoRUxjf2TM5J4G00t1JTrTCH
         twGg4XAXIS7QLCd9KPYQJLshSK4wgoMOOAIyWm31jpBCu6Jse56GayF+719Un9CyE+BH
         e3yA5pNNikPlVJZkXojvkWzyCc7WSjSbKC4VsxENr9f6S5KWXgpjtK0lGFVehJMPvi/w
         J6rlOEUcg+bEyF7iiMdPHrXFFy+5HwzEKQvxI2SbDsrBohrxxoEC4ZnRbrV1Co4+6fAW
         CRrx+RlrjHU9C+p+V+AzTxmASo6VuaWvxu+E/vMZlv/zkHsFcYa9DuXKP54fIGdAIVTz
         jGcg==
X-Gm-Message-State: AOJu0Ywcz596Oqc48O0iR6Fi1FBemhU2ziu3rSEhQW2N2Eo3aZMVOXr9
	lJ6twex2aAuNKoo2OMW+9B3WkQ==
X-Google-Smtp-Source: AGHT+IF4z4Im1nLH/k2ekf0tUd+qFPog23mz/Cdj38aUXoF9RZZSYKa8hP9ec6ysGxLmrBKlb+u/Ww==
X-Received: by 2002:a17:903:2305:b0:1c6:c3f:9dc3 with SMTP id d5-20020a170903230500b001c60c3f9dc3mr28632806plh.54.1697269524823;
        Sat, 14 Oct 2023 00:45:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001c3e732b8dbsm4965124pls.168.2023.10.14.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:45:24 -0700 (PDT)
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/2] perf cs-etm: Add support for itrace option 'T'
Date: Sat, 14 Oct 2023 15:45:11 +0800
Message-Id: <20231014074513.1668000-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch set is to introduce a new itrace option 'T' for forcily use
timestamp trace for kernel time and support this option in cs-etm.

Some Arm platforms (either Arm CPUs prior to Armv8 or miss the FEAT_TRF
feature, currently the ETM driver cannot decide if the timestamp trace
is same with kernel time.  This is why we introduce the itrace option
'T', we leave decision to users so users can specify this option to
forcily use the timestamp trace as the kernel time.

This patch set is tested on Arm Juno board.

Leo Yan (2):
  perf auxtrace: Add 'T' itrace option for timestamp trace
  perf cs-etm: Enable itrace option 'T'

 tools/perf/Documentation/itrace.txt |  1 +
 tools/perf/util/auxtrace.c          |  3 +++
 tools/perf/util/auxtrace.h          |  3 +++
 tools/perf/util/cs-etm.c            | 21 ++++++++++++++++++---
 4 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.34.1

