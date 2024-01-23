Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C96145B1D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968374; cv=none; b=mnjVgn2t11sIN2nU6Omvwf0bDcntvxCufCt6jw5hagBsCMAwa+7WvpDU52vN9sicAhp5II4GAb6TEuXDXQB7dSuZjjE5Oo28hFxZLVjnvkPJhB1lVR5QEDCdb1nKT5Ygiz6YXBsn1yRbBd0pvtmhcmOKjQv7P31s2Nvn8OY4WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968374; c=relaxed/simple;
	bh=WyYDJ5I8crHfIjGKOEWsj+g+4ZRWKdyhFy1bp2Mbx4w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Mks/W/OqQmlHI1vXa5mgLLq2sgUG7Tx5lg2zrlNGA1szHwDp2hZ6GLDs4V+RdTCfBbY4JrytXZJvSuD6PyWPBjLogEXe/hvX2opSaaXp7pFmiiTKCVPJR68g1EKm4kB2VdZWtQ0/a2XIj4Dumjb+Fmt5YLyVOZnBrJ1rhRODib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3iOaORx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3iOaORx"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f874219ff9so51675007b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 16:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968371; x=1706573171; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AXffGr7LphP1tXOOtskGblZIv2JUqybLVLOLn41CS90=;
        b=U3iOaORxg3/OGMRqn8GRR6dNEf3KGq2XfoeM6hI+Dgt/4QnMHrHLluh/u0uzDreaBN
         5WD8c3+ZrM/Q4a26qoSAB/je2+pY60/gsP/zV5tFNfBtUVJ8VKyRHfIX7KfjcWhylhSu
         o5ztNWGqEeLBaSTRFbIGs26KYoXrMCaFVrelNetWfl3AaT/BIyb+yK3rdU8luQgTa3f2
         KR9S7EL+idb7tlrUeq9L8ZicCAzrqMm71qtlRd12hWfsglyM2c2tHrutLTqIIjhs/vNf
         I46E9ajucTzPf9OJLcC/bSlqQRIi/0WvQJE34diYel/vp12uMEfOahooKXpUY6Ot+bGa
         0uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968371; x=1706573171;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXffGr7LphP1tXOOtskGblZIv2JUqybLVLOLn41CS90=;
        b=BHYsyTAzfMC8OHlMzwRjknWyzNX4NMeh5cl3w5COpghzWxg834DknRTLtRNq9zZxR/
         aBRua+v8T8crRFTQ/Zr/x5UYLfXjYygFaE8TkVuFV3SVxheI3lhZEujenvLnZ/5vTjEg
         De4EH7hzspSKMY20Sq76KNnRScgNMvGZg16dVyevUeU2GSVFUEEpMW/uwiEms11dmqnB
         Oar+LF7gAT3jMmQNVDjeqSo923fwzWa488joHJOkNWOktaDddvxVPyAVC/k8ECA4Y59R
         quVAKh3U5itufyyKcmPHxxAUOuZWOTjylsCwSMqYR1YYrIkF4JH109CUgnvSbLpJaock
         WJYA==
X-Gm-Message-State: AOJu0YziEWKKaNljSQ5vdPEStuSuGYbYZpJwSPavsO8ZrKorfoelo9Xp
	JEu7m03C97gUjcL9MhDwnry5AVPa0LxPRREjENfPokksYDWZMNFlyA4eDBE01PHPyz3a6I5rr+V
	+GXJJ+g==
X-Google-Smtp-Source: AGHT+IGNt2kudlGiyydNX1G2X00S7qrLNufjPUdMK4crkJDKauSfJgzekImNEet6MZllxK70aQ7vXudeB552
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a81:9805:0:b0:5fc:7f94:da64 with SMTP id
 p5-20020a819805000000b005fc7f94da64mr2150138ywg.5.1705968371736; Mon, 22 Jan
 2024 16:06:11 -0800 (PST)
Date: Mon, 22 Jan 2024 16:05:59 -0800
Message-Id: <20240123000604.1211486-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 0/5] Fixes for 6.8 PR1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Discovered some testing issues around perf list, perf script and perf
daemon based on Linux 6.8-rc1. Some of the issues were discovered in
the context of an Alderlake system.

Ian Rogers (5):
  perf list: Switch error message to pr_err
  perf list: Add output file option
  perf test: Workaround debug output in list test
  perf test: Fix script test for python being disabled
  perf test: Make daemon signal test less racy

 tools/perf/Documentation/perf-list.txt |   4 +
 tools/perf/builtin-list.c              | 211 +++++++++++++++----------
 tools/perf/tests/shell/daemon.sh       |  34 ++--
 tools/perf/tests/shell/list.sh         |  21 ++-
 tools/perf/tests/shell/script.sh       |   3 +-
 tools/perf/util/print-events.c         |   2 +-
 6 files changed, 177 insertions(+), 98 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog

