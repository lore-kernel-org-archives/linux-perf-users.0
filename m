Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24D140E58
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420961; cv=none; b=rjTRxqnekUFwWBi/icplxcaZXk4tpkFGXKwCW1ADeT5Eb+2v38MUA3sIuADw6sc3SbCNubxbf7REl+YRdbdG/gfsP0eZ0RtTL0z1YQYCnL6a63coUtMVLRKEb6wO9ETZ1a05MKCixsTm53HY3g1STjbisioSefFLqfT6SusK4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420961; c=relaxed/simple;
	bh=YyvsWLWngfSh9nnSqgcZese8fTAPRzDb4ZSWq14LiNg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=jrv7yag74GE8I7xFanvenX914nh8q0L8G3SrNINFLuU6yAart2pC49/b4V6h0ECjZPLS6Wy1V2u9jTkBBq2+DolEEfWLKw08coobpuXsKcV4kZ2wckuPVzACvKoxq71Jm2X9BCysn1qRUJE+n2DbkI7HMnyrMae8nED4i9mmEhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEF4gbkb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEF4gbkb"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61babe30125so49629987b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420958; x=1715025758; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbGOcW4P3upkfkJhKMRnRlo5SQ4rO5/K3xu4UpOuH9M=;
        b=vEF4gbkb4kV/PRvrMoYDD95JN0oLGF7hFZ+cITex1TdqIKCigG229g9SK0OqfZe4df
         SJiRKcJgXmXLLAv1VXbTu87WPzeQ1neWa2C2iHFtDJMMu4XikLQB9xWcbUyLZM5+oBBE
         xIolGzr45/80bL3KPjad4lKist5O4aHzHogOBJRhAtKQq6+pgvj24VCbpwx7KYI2MtWN
         /vT394zpjapPli+FuYdXbYA6KoU0y5hcjQRQzzn4MFzyWmTQlSc34+SWJdw1BKx/IWwj
         BZ6XL4EUqszIeD45DB7kYG5n3/KdbA0moFrC6ooLpcrNkfjEWX0Y6lV8JR7RqNRKm3eG
         6g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420958; x=1715025758;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbGOcW4P3upkfkJhKMRnRlo5SQ4rO5/K3xu4UpOuH9M=;
        b=SioLZtiPeWfT9AG2blF5GPuwkwozg2KvveBsgaSX87nRC6+iCuMqb8imN/qabztmKV
         WtS0AzHJ9Fd8ilR+BSvM/9ESHjp12FofzhmNt/yxioJk4KsJqpTiW2jFAD6fhNO4pMa/
         X+8dLl6HHr9TB0njxrYSdEJf6jLqA1RchCJsoICm5YLSjtzWi4Z2OcJK7Wjtt/Y1bEFV
         p7uQ9XRnpzuSx9BhufwYTTniumTxHj1Qhn+FqDl1DR2iyZ5WuINZ76IQLVQs5yitlOCF
         2Hk4GGPbDCIKJVPrrL3rshENmiws0gYE13lnUWq8WkZBGhPksV9Bg8khy5cndyxJ58vj
         eQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXdQJA8brB0QsRZuAEZmALyeo/e9TyBODHgvyl8sidqris1Wk+5sr6PHCgX6Sp2xjtORxymNNE5Mq6J7QfWIphxR3CX3zlhd8TdhlSYTVxjWA==
X-Gm-Message-State: AOJu0YxJ6GZ2EFyDbFWqAeaYp8L1VVdnqBHTULaFmsXKDLnuG4d+xMVK
	DmEajkw8DI08GeiR6nKKJcMqAfrn4gzAkT+sbbRu5qttrKURHUwN8Ht5S7te3u3uV8VACZBvqgQ
	xw84gMA==
X-Google-Smtp-Source: AGHT+IHidjJKOQ3Mb39cydoxlPwjZkrNOD/yd72CZlEPerBURKz1ZE/xpzGhWNmPJbjfvIyKvRY/38f2JUBp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:150b:b0:dda:c4ec:7db5 with SMTP
 id q11-20020a056902150b00b00ddac4ec7db5mr207193ybu.4.1714420958248; Mon, 29
 Apr 2024 13:02:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:19 -0700
Message-Id: <20240429200225.1271876-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 0/6] Assume sysfs event names are always the same case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

By assuming sysfs events are either upper or lower case, the case
insensitive event parsing can probe for the existence of files rather
then loading all events in a directory. When the event is a json event
like inst_retired.any on Intel, this reduces the number of openat
calls on a Tigerlake laptop from 325 down to 255.

v1 sent as an RFC:
    https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/

v2: addresses review feedback from Kan Liang, by updating
    documentation and adding tests.

v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
    that s390 event names are all upper case. Do a lower case probe
    then an upper case probe, make documentation and tests also agree.

Ian Rogers (6):
  perf test pmu-events: Make it clearer that pmu-events tests json
    events
  perf Document: Sysfs event names must be lower or upper case
  perf test pmu: Refactor format test and exposed test APIs
  perf test pmu: Add an eagerly loaded event test
  perf test pmu: Test all sysfs PMU event names are the same case
  perf pmu: Assume sysfs events are always the same case

 .../sysfs-bus-event_source-devices-events     |   6 +
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/tests/pmu.c                        | 457 ++++++++++++------
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/pmu.c                         | 111 +++--
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/pmus.c                        |  16 +-
 tools/perf/util/pmus.h                        |   2 +
 9 files changed, 405 insertions(+), 197 deletions(-)

-- 
2.44.0.769.g3c40516874-goog

