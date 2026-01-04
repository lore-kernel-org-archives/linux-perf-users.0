Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F38E555
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Jan 2026 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767489463; cv=none; b=QMr5dE+/wlJzEosF5S6kqtTlj0nOVpy90w7486QnZEyLS9TbJ7jpjPrY45gYC721lk8SQenhk8MNWe6hqEGbRuff1QCeDQ1dmW9Fi5carwhGgOgqWSltHOoKXI/htfUPNZseBhBvLCCN7pFGQ/SVDaJTeQvZT7spG4mPmgUEkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767489463; c=relaxed/simple;
	bh=hT7LkChqXBHZ15NVKTqud1DX336urs3UZhRAh5zcdc8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=XIN3pITynzePJGsKVUwkDEsY0xO8qCJA/EGRJuIUTkHsoCHzQOB1cvLSv73h0uiIE8d8Ci8Xtj4wGSs/kci+Sx9u9U/yRAUPqZtj2jsiXdbqqVWt4cxSvXxt1ZtFXj1q8r6oRzIQIWTpxZiDYxZwS4/+vCrQvH8l1FJazBxqg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYE+cL7p; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYE+cL7p"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso36289930a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Jan 2026 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767489461; x=1768094261; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bShVqsUYkJFOiF4N+zEY4XzDD78BDOcOTkc7Erl4y08=;
        b=gYE+cL7pC/f1Gfr6BC6UpXbJnTipDzLPQ9keaj3IjhRN+KvV7wiS+zxNa4sfTGrSFs
         mAXLhA43MyXfISi5HwFI07v2oXZ2HkwOaL+u2PR9+Iaov+hPBB0m6oTmQufimySrefyD
         qvjV9ZZKczJ/cnlNqh99bbwWcqTZ/uDPRkvmAZlpzGgiifCFoQTYBq2m0IJuv7oIUBl4
         hHZL+uXr+68cKzgQkv5S58ZN1WoGdPuIbXXy6z7VUmE3+RyrLhFylC3Gfw3u7xTlF46d
         rdmDoHl7DNz50PVKiVD5ZY4eRQfIhqJCYP4dTBsQp7Yy59UtKCQLbUx7pNzNFRcXz+G2
         gaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767489461; x=1768094261;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bShVqsUYkJFOiF4N+zEY4XzDD78BDOcOTkc7Erl4y08=;
        b=eh4ARhfDhlp/xaEcNPGnKOpORX7+dzQcs9G/T6Bexqb4NPiVikkyZYOGUf4iu5HooN
         oeVseflwJsIXk89KFw58lHvVyhbQX1lDmPperUh3EgKV9OdOxp4wDQ22xByIWdFegl6y
         V+rJTOVAnZGKvjDEW6gVTB4OZyRJBPLxEv6EXMkOUv+rrTDWGNtOmg4D1lv0tW/74FyF
         /zk1VsVczs2MJ9GMMNuqCpsLXCfRURrwcdLpueIbv8JKiJ6q2issGS0q+LMrsZMHDdOy
         bs8wvETDNLUilfGurknEMl3Vn/V6eFc7rSoJuYrCSdww6cOK1Rpv1myTaSZcoeziM3Uk
         8cYw==
X-Forwarded-Encrypted: i=1; AJvYcCVlp6amjf1EQIMU/CueaaMSdxYAWqANg+iQN/KIrpUapfEORHTjFNORNNWn99UGzYIt3H9WSoL5F3FteVViMzjj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kaQbrfWe8UwfJXaJ3t4kYYiOn+euI8jeNXhK/+CpVzoaKNVX
	/mvwuOUsdiLMRu0cdYpkobbX/S5ZN3sEf76N/HAGaptpWwGFceo6rS2rDhCHQYB6TKiTlqJQe6A
	zVZ8qk52Zww==
X-Google-Smtp-Source: AGHT+IHwgvx06s76KTsc5hZmCRM5CFB52C9ff6FkDDT4n5CqFYr+IfNIkxCD0iBg+za3OXCbC6HgNOKjjnuM
X-Received: from dlbdx41.prod.google.com ([2002:a05:7022:e29:b0:11f:3043:2c7f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:264b:b0:119:e56b:c75a
 with SMTP id a92af1059eb24-121722e5240mr37543042c88.31.1767489461365; Sat, 03
 Jan 2026 17:17:41 -0800 (PST)
Date: Sat,  3 Jan 2026 17:17:36 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260104011738.475680-1-irogers@google.com>
Subject: [PATCH v1 0/2] Add procfs based memory and network tool events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add events for memory use and network activity based on data readily
available in /prod/pid/statm, /proc/pid/smaps_rollup and
/proc/pid/net/dev. For example the network usage of chrome processes
on a system may be gathered with:
```
$ perf stat -e net_rx_bytes,net_rx_compressed,net_rx_drop,net_rx_errors,net=
_rx_fifo,net_rx_frame,net_rx_multicast,net_rx_packets,net_tx_bytes,net_tx_c=
arrier,net_tx_colls,net_tx_compressed,net_tx_drop,net_tx_errors,net_tx_fifo=
,net_tx_packets -p $(pidof -d, chrome) -I 1000
     1.001023475                  0      net_rx_bytes
     1.001023475                  0      net_rx_compressed
     1.001023475         42,647,328      net_rx_drop
     1.001023475        463,069,152      net_rx_errors
     1.001023475                  0      net_rx_fifo
     1.001023475                  0      net_rx_frame
     1.001023475                  0      net_rx_multicast
     1.001023475    423,195,831,744      net_rx_packets
     1.001023475                  0      net_tx_bytes
     1.001023475                  0      net_tx_carrier
     1.001023475                  0      net_tx_colls
     1.001023475                  0      net_tx_compressed
     1.001023475                  0      net_tx_drop
     1.001023475                  0      net_tx_errors
     1.001023475                  0      net_tx_fifo
     1.001023475                  0      net_tx_packets
```

As the events are in the tool_pmu they can be used in metrics. The
json descriptions they are exposed in `perf list` and the events can
be seen in the python ilist application.

Note, if a process terminates then the count reading returns an error
and this can expose what appear to be latent bugs in the aggregation
and display code.

Ian Rogers (2):
  perf tool_pmu: Add memory events
  perf tool_pmu: Add network events

 tools/perf/builtin-stat.c                     |  10 +-
 .../pmu-events/arch/common/common/tool.json   | 266 ++++++++-
 tools/perf/pmu-events/empty-pmu-events.c      | 312 +++++++----
 tools/perf/util/tool_pmu.c                    | 514 +++++++++++++++++-
 tools/perf/util/tool_pmu.h                    |  44 ++
 5 files changed, 1026 insertions(+), 120 deletions(-)

--=20
2.52.0.351.gbe84eed79e-goog

