Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24511731
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892643; cv=none; b=eK9s9BaptwrQese/M4UxySBRiPkZ1Xg412DT9W8lyNYdn4XenggxCmv0v/+RT+hmsxlRdvuqomTn2itHPe5rsyy8dfL74MrHzy2GAxrp5Y9WEAEok3imp5sfebPzKIiFnZcTZkpjTjV10yY39Ibzlc2pTl8pIXPSz/iBPh+j5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892643; c=relaxed/simple;
	bh=G/2siGEslfhIe2PbP6r2MxvFbe+8RJMIG2S2/Tjz5Sk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=LXx1TAkJIFG7WTzhvkxVyDedDx3USrmEpg4W/TK5X0ssIcGWMJOhWHBeGb6w2fkEu+PV4iM1MT8u5uVH05yENvUKWc4V6o4rbTQH+E7mjosCc9RMk2PMKLE8yGSknGl+t4Vd1dQRJno4pHlzNa3qF+B2fDj/R9cxWNYjwW0GBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKC2p1yW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKC2p1yW"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604ac3c75ebso96259267b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Feb 2024 22:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892641; x=1708497441; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SjusGx6p43Fl1gAtWsqPYtqEBcBHhyA1NbBeHZWXXBk=;
        b=aKC2p1yW+k+f204eXYynN0DphVe+dqAkLQgK3xLaZ6jmJk+jt1IS3vh7gEDIi8QM0K
         tpS4zebZHOjfqUlZglRnc4FuUKJTF37LacDuO7Wf+nXddVip3XOdJWVdfy7HUXRjFyj6
         f7SSiSEMPDkEQMTt80tRSFXkVwGY6dU9HLvH9WIgmbMnTPpCnVgkurEac7gWFR75ZxzG
         GHaSgyvZl79Ucno+D2W7HhpzrIMCf4lFiVmrc5Zubofm6iBJ5bEFSd1woVA+29jKKgqa
         tUEMPNC1d67NHBHb0kEaQ1NlhZnxyTMWTjlL3Y8RINxrpyclw0e3tFD/zguCkxF9l0XT
         ZMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892641; x=1708497441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjusGx6p43Fl1gAtWsqPYtqEBcBHhyA1NbBeHZWXXBk=;
        b=Lf0yMCHRBtVm4pm6UgubMmh0w/wqmjK70EIBYXVBKh7ufZ4JbjuUma+ue2PtJdpghJ
         +wvcdPLvls308TzS2Q1URbEDylsulLodbkCEoNFuo/0K4fK18WIyojBQNLssrSfcQ6EG
         P+zZhvkhXO0R6dUsM+l93vJqyXUm1fCC7G4JOJZf0s0xUFgf5qgnMNbNJdb0ZqScf6Rp
         M0OUE/zorqoXC1D4jeGTgahNUT27+hHA99oIdjMMPQfGGaMOAIF17Y1APBvJe9V7rYiS
         EEWj5owzGNJQ84APw6CXR5aAlU0HFRw0zN9dsQQyhAU/b7O3TqzzmRikZvG0+phz3Ki7
         8ZMw==
X-Forwarded-Encrypted: i=1; AJvYcCU0vp//TgvZM3LJdbo5KfzXardY3sE/KKEbPaYFFBnbFuzm1zPvQQcxgYsl+GHoXxZWQUyYJJW0U66j7eYl/OFafgAqajZTDLSumjfu0DmstQ==
X-Gm-Message-State: AOJu0YzuVifkTV8LVLNJetwqoioyaeg7+99d5xTd/3RRtO4a2P/3K2/k
	EKVCSfMClersEDuUJ/D/kmGEoVAk9NcYsCSN5LZp3uHyHkL2FVmap95pGe5Rulc7h5+u7gyFB9i
	CszkTZA==
X-Google-Smtp-Source: AGHT+IEsG2eb9QduCybkOjAV4YmUuRlwxnqusb42GZd2TCszkl/0jHkS+z91H7/eyjXsZBnlWHjgqJVyyKgH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:a105:0:b0:603:ea10:c37c with SMTP id
 y5-20020a81a105000000b00603ea10c37cmr360558ywg.7.1707892640759; Tue, 13 Feb
 2024 22:37:20 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:02 -0800
Message-Id: <20240214063708.972376-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 0/6] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
now the initial maps fixes have landed:
https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/

Separate out and reimplement threads to use a hashmap for lower memory
consumption and faster look up. The fixes a regression in memory usage
where reference count checking switched to using non-invasive tree
nodes.  Reduce threads default size by 32 times and improve locking
discipline. Also, fix regressions where tids had become unordered to
make `perf report --tasks` and `perf trace --summary` output easier to
read.

Ian Rogers (6):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 203 ++++++++-------
 tools/perf/builtin-trace.c            |  41 +--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   8 +-
 tools/perf/util/machine.c             | 344 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 186 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 464 insertions(+), 397 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.43.0.687.g38aa6559b0-goog

