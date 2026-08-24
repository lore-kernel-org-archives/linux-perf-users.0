Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0673B19AC
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552929; cv=none; b=p1qndPrH8j0T35iG5guZyePvVtJy938w9cZ1kR6ogD1d4UNOHLY3tNXjxdUn9iZOiGnfgavpnDmlLsJaEQ9fidjy7tw8P0epRpbXcGtFL9btkRfQxg1CvvbvdKD8/ibAdEbG9a3WijMoLuO1aSWaQP0SiItF1ZGMtA7/+26ypww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552929; c=relaxed/simple;
	bh=1c8hgeZbe3PVO1MmOtXoJ4DdU6aI9iic6px4+2ZESOU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=u/euXhopmlhRjyosHHB9dTWt/KfdkM7PGk9T3NibceVXAqhRt9I6mBfKku3UKpbt5zDaKpp1bsPoOUI6d/ou6z77rvIUrwsCxcoB/maTBIOUkfXLDP9fiETlXnRNdGUoNO58MYuv/ionzOiTb/v2qzdQ3wA0pTSRGA+3lLuly9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faEooHmT; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faEooHmT"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b10so4196261a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787552927; x=1788157727; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Io353LsrZMJh6+YSu0YvW2I3uBWVs6PnBilHa87OdeM=;
        b=faEooHmTIct5Ul3NhxAbVIo5TYyNXJxl7BU5aKdGPc003AEs9Fs/8J1Tnk18idZWnn
         sVwKLjyWEprFZwWffLZE0NzDG3pNtxtfK8mtGwsj8kXUYgAa2c35fzszuZ3YDStC5RhB
         COxQULRi2zSPlxNLnRmXPKfUQIeLbrWTCGqbufaczM5E0uDZDr6kky4Kn8VZyNsQU7EV
         Jj8dhVg+Mn5d3aulDtgjb3BxR+bx8QAbpsp1xUEIyq43UQTogo66WAauHytqJXar+nm/
         9r7dA2tcdA6BKXZ0h7uQD0CswG0vnvszeUIgxt3Eq9L6NqXFRklS+sw6zZmHoac4nQOd
         54tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552927; x=1788157727;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Io353LsrZMJh6+YSu0YvW2I3uBWVs6PnBilHa87OdeM=;
        b=XTKochKX6EKXZTkEWVzMWURLa3S+ZNSIFmV11zVXG9sMte2DlGcmK60VoRzRsIudCp
         Od7AKswH/mXlutvJ9RhEmMrF6rWQvTV+evua1HGLXesC98XOH/cxiMjhmkj+tjRDUth6
         dAI2HMLgSC5aAkG4aGgpQ/DumNYxReXN8DkirMbGk7POf4duYZZeBnwCSYNQMJMFEDyP
         xttBsM3ClKvjuggJu6Q7DbCdKmKYfuggOTEHCvIQ0SfLI83NEqiFBEnJg1+zQ+293pU9
         ITox5y5IWqTeDmhxb9qitLn2MMHAf5iu5ZWyvSwTHADS3hj7BtIK0CSzl0B50OPJ5fUA
         R2Ng==
X-Forwarded-Encrypted: i=1; AHgh+RpEdT4wXzp9UBhmb0sjR0jmEVfyzSAMxzSi30scYLST7OMHPpSYaOsvBnzNEMqq1EN2oHb8QAozdnoKmJPVwnBH@vger.kernel.org
X-Gm-Message-State: AFuF++mQ/4PY2UthrrTr3BZjYdc8WPSiek6MutVg2TqcMqO5bTCaB8Cu
	NDZd+H1lE3QlfzAZQEz2xKk6JKbqyKxdR7Hkyec7UxJkis6yiU1tPIg/hSYZNvCG9xoFCGx1z0Q
	1TviTuxOWQw==
X-Received: from dlah10.prod.google.com ([2002:a05:701b:260a:b0:13d:d48:df85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3946:b0:3b2:a809:1000
 with SMTP id adf61e73a8af0-3cd4b9ae0f5mr24001684637.3.1787552927035; Sun, 23
 Aug 2026 23:28:47 -0700 (PDT)
Date: Sun, 23 Aug 2026 23:28:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824062841.1529489-1-irogers@google.com>
Subject: [PATCH v1 0/2] perf libdw: Improve split-debug handling and error fallback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tanushree Shah <tshah@linux.ibm.com>, 
	Michael Liang <mliang@purestorage.com>, Alessio Podda <aleph.pi.gh@gmail.com>, 
	Shimin Guo <shimin.guo@skydio.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series improves libdw's handling of split debuginfo files and its
fallback logic when DWARF data is unstructured or completely absent.

When perf's libdw backend failed to read unwinding or inlining states
due to un-mapped lines (returning 0), the addr2line_style routine fell
back to executing the system's `addr2line` potentially launching many
sub-processes.

Patch 1 Ensures split debug information is properly handled.
Patch 2 checks `dwfl_errmsg(-1)` for "no DWARF" presence to avoid
fallbacks.

Ian Rogers (2):
  perf libdw: Pass dso_name explicitly to properly anchor split-debug
    builds
  perf libdw: Optimize fallback logic for missing DWARF

 .../arch/powerpc/util/skip-callchain-idx.c    |  2 +-
 tools/perf/util/dso.h                         |  5 +++--
 tools/perf/util/libdw.c                       | 21 ++++++++++++-------
 tools/perf/util/libdw.h                       |  5 +++--
 tools/perf/util/srcline.c                     |  4 +++-
 tools/perf/util/unwind-libdw.c                | 15 ++++++++++---
 6 files changed, 36 insertions(+), 16 deletions(-)

-- 
2.55.0.766.g2966f0265a-goog
