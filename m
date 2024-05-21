Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19933125D5
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253494; cv=none; b=TqcFfzGwpcHc555kvv3geMXZ6CY7j/lUj9YN+yplSyJDtvphydclosbm04+UH85h2rffr8+qjdSUQ/ptrVSfOVk2DamLlIXHmZsSHHF6MKgOWTqwMgRot/ZLw4ReBkNc5JF77IuFXTQQAeNmrwLP4dJBj68QK5Zl7bM3fMLk0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253494; c=relaxed/simple;
	bh=HnZOyTLA1z7HGjFiTaimfVCHoyCYiv6gxIK1l/WLd9c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=RB7BsGfyGfO+ua24VKoUlQocXSDF8wIrTrbuFEUYYsjkZCCMvwUbVzbkf1IbP9P6kQlB94XzgeBmLRJllxFY9KKBpWUZW3jzMREJA0AGxSIhmF5kTG1j0QKrvNLx3bNyOo6NiQw+QQb5+XoXExnPr6TJM6TVSl3gBHM+KgtHllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clp322AP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clp322AP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so26656930276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 May 2024 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716253491; x=1716858291; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpOLP0XnzrTQf20d05HSRvs4OM1Ncix8hyKknNTHteQ=;
        b=clp322APGH01SehhXEomMqOXDsUBlV6LzkR909b/LG8TnlVmQEEo0d/q4XoQV/UcRd
         NI6q9shi93Gg4LvAfTMCTlGnZjdej2Y3WUbP6vEbJ0Twq7mnkfJs0c2MdMWqBiqwTMy0
         YibS5OYcVH7V9qvruf7e5BmdjqNfTuytX9mDhfTNOo03vyiVcKDA6/ggKpJxzwAHpJhT
         9J2ItzI2Om2OR+/NFgsuFoBWxeAvvOEKJcylOYBatDtFBWOZeXtAHKRBn8CzBbVVVu37
         za0huhStK95cGnKTpVW5nYYK75uNLGswQOLfg0BjGDCoDE3tbwkhbZKcdBAamaxqLdiM
         y29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253491; x=1716858291;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpOLP0XnzrTQf20d05HSRvs4OM1Ncix8hyKknNTHteQ=;
        b=BZqCryfdEOLSqlcBFfdfjpWvcT0nSbL4rZfs4M4Z9B3dlUN67eMBts5fkGehHkDYj0
         gl2lrVLvov3XXT2IolQe1axuaXf4a0bQ5HO4zDrPjqALLz0iJoMXp2WTSUZeXHSta/Rv
         coI1ydJwGBCaB49e8A9XTu6rl7kIq/a6as0JXvItTRLFeqJULn2KiFPvYYnNNjHJCH+2
         53dx9fw1ZlcmICnLcySUkD7B1/rQy1x8k90zlgvA7DCAGB2L+h2QAbGMNC6pT9S/nnbK
         SiARGTt5j+UGjBZ+wTl7j7vM+oTEygZMW9LhYwghUDB6nT4OVHR3wyMihKt4W0JDsT/K
         +elQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf81+GT2kDBodc9m3FtBecIOIiGC9dHx5VbPjnHjkeynhDPHJGCp6LyTMDHLY40pxRmwDXChD/7UeVcSlZw4FdSTXf0FOk2htMZmqwKDsKgQ==
X-Gm-Message-State: AOJu0YwN4FbvMUdK2Ivc5o7jcDce9gNQJtP0LHnxJXGhn1NAs/MTzIRY
	iOIojDYHEHOX1mwpCMTQFfo655I1CMpb2v3Qy9+ffazK11DKg4xwSPZXtKX9i9q2dmk9oKbFOdR
	eY7ZYig==
X-Google-Smtp-Source: AGHT+IH3laioA2ReSfTb001L3Np4E6P0YRTj77ACLXkl114QIRHb+vY7xJeursyPnrL6W1q5Bah5nKB5u06g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8533:b29a:936d:651a])
 (user=irogers job=sendgmr) by 2002:a05:6902:a8b:b0:dc7:7ce9:fb4d with SMTP id
 3f1490d57ef6-dee4f322140mr7251230276.12.1716253491136; Mon, 20 May 2024
 18:04:51 -0700 (PDT)
Date: Mon, 20 May 2024 18:04:36 -0700
Message-Id: <20240521010439.321264-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v2 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

v2. Allow PERF_SAMPLE_xx to be computed from the PBF_TERM_xx value
    using a shift as requested by Namhyung.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 33 ++++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 ++++++++++----------
 tools/perf/util/bpf-filter.y                 |  7 ++-
 tools/perf/util/bpf_skel/sample-filter.h     | 61 +++++++++++++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 54 +++++++++++-----
 9 files changed, 171 insertions(+), 70 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

