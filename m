Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7318A950
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914269; cv=none; b=TTXvb73Mr9Y9p4A4b+HdWwAUd2AUXneURElkyP5T1r8k6tIbaujfHL2HIFIdV08cenIASfqfp8mDKfonTsHKl0oHaVY5HGIwSRlDDcCtdy/n6uiR1/+CbN7vF18pFMfoj0S6Ln/2//woE7PK2KAMT7Hv4S0e8riWuWT3XvhAtms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914269; c=relaxed/simple;
	bh=DW2EcfOQy2W5Jmza9VbPs7QjtIGUqL290Rk2S6cyo+g=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ayOn94NEG5/HPeJN6y+Smi21naROMiyXmtQUADeTCCK5y1qDeqnqvHxge9V3YMVjInIEETF1Rh7bnwAVODgV4WvusSHo3BfK2jkZ+sDgUYcmVScBi0v/6f19RrXR11OGg7Bp7vPEmCK2Ggl9OTxWQZZHbXDyRhQpdCip8kjc3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0F/29vZ1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0F/29vZ1"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b47ff8a5c4so164626987b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2024 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725914267; x=1726519067; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L6unlErgHNzcfcaOSF844WY49vPWncZCWe3dSt1GbFk=;
        b=0F/29vZ1foLn7D46jUjEumOnBQh3mfEAhEABFoPzx0FahNBSbIJlZNEcZyupIdVatb
         1tCaXDZI8j2r3blkts/vL3EJk/YJE5UJso1AuL8Ym0Z3VwyZy7FCCKVktbiXtD6mXk1Q
         kQ9+PmkhwGvqJgR4j/xzt9MBy8EkqAymXqiRQD5Fxw6YEkfli9x6UqIq7OePBMv8acVo
         u0dc9MD/KUxvTeS6n5dZuAY3+VLmK3VSdaB2jaBYwN0NjA5C6ADX5RTpqbucjhwozYJi
         QhJETQZA/QJ+ALBCAkuz2leu9p4vCnqRrLfi7Mmur21ep4MQagIyd4rj9rR5xkxZvwp1
         g6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725914267; x=1726519067;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6unlErgHNzcfcaOSF844WY49vPWncZCWe3dSt1GbFk=;
        b=r2PNpjYaFNScVatdh+8jV7Vv/QYHn1cdVEEUmhaKJ2HqN3z5eTOOuM3f9yUgi7KFla
         9b2hOguyTOxdlqo9Gy7PXo1GE2P3KzbRTLJQtevz00P0UKnHm2STkKK7qSe+K9oM3ra+
         XEQMfNBvzOlfqggHnCjRlAmvZ0PoL/FQfBOVUsuZB2QKQVswm3Ju21HV4tPLngruKlP/
         yNsVzv0KYfPo/BgsDiS0mHrnNiByKwfMzYcgGh5wtvbuTH3fxlzoFv21YEEdsRqT0wdl
         KG02Jtpnds1m6rUmRweo3g0opmVhQdLK4VuemHNVgapGaBtwfRF0PkjRET5ivRcWMNL5
         zycg==
X-Forwarded-Encrypted: i=1; AJvYcCVQlyrCFFHDo/UR7tLGOVlIhEA45/ov0yxqXIN6rxN57Sgiy+q7tKH7cC79R0oIg+122jzUE/Qf3vkPCpiH3DXn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69H2XypE42rygJ2JjlyTC4cVddMY5o6k4sjZt/qcZPauxo0tZ
	gn4P7KgOrwHTg+Lojtjq5bAuxqhU0pfBy09HREgYDrQXWOK2KDNBHdU1hU/sjgmKCLQXOAWhuiw
	4FF4ssg==
X-Google-Smtp-Source: AGHT+IHYf14xz+KMmoxbUzIZayaT/NO0P22QobwybS9PKjpUBmLTjDj8gWarY65loFkwM5whBvjlGTXv2yCX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b7b9:f9a0:1197:ff33])
 (user=irogers job=sendgmr) by 2002:a05:690c:6a04:b0:6ad:e9c1:fc4f with SMTP
 id 00721157ae682-6db4516ff0cmr3800187b3.5.1725914266795; Mon, 09 Sep 2024
 13:37:46 -0700 (PDT)
Date: Mon,  9 Sep 2024 13:37:36 -0700
Message-Id: <20240909203740.143492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Subject: [PATCH v2 0/4] perf inject improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Casey Chen <cachen@purestorage.com>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix the existing build id injection by adding sample IDs on to the
synthesized events. This correctly orders the events and addresses
issues such as a profiled executable being replaced during its
execution.

Add a new --mmap2-buildid-all option that rewrites all mmap events as
mmap2 events containing build IDs. This removes the need for build_id
events.

Add a new -B option that like --mmap2-buildid-all synthesizes mmap2
with build id events. With -B the behavior is to do it lazily, so only
when a sample references the particular map. With system wide
profiling that synthesizes mmap events for all running processes the
perf.data file savings can be greater than 50%.

Reduce the memory footprint of perf inject by avoiding creating
symbols in the callchain, the symbols aren't used during perf inject
and necessitate the loading of dsos.

v2: Rename dso__inject* functions to tool__inject* addressing feedback
    from Arnaldo and a suggestion from Namhyung that the name should
    reflect the first argument's type. Rebase, in particular over the
    perf inject pipe mode fixes. Add Namhyung's acked-by.

Ian Rogers (4):
  perf inject: Fix build ID injection
  perf inject: Add new mmap2-buildid-all option
  perf inject: Lazy build-id mmap2 event insertion
  perf callchain: Allow symbols to be optional when resolving a
    callchain

 tools/perf/builtin-inject.c         | 304 +++++++++++++++++++++++-----
 tools/perf/tests/shell/pipe_test.sh |   2 +
 tools/perf/util/build-id.c          |   6 +-
 tools/perf/util/callchain.c         |   8 +-
 tools/perf/util/callchain.h         |   2 +-
 tools/perf/util/machine.c           |  92 +++++----
 tools/perf/util/machine.h           |  33 ++-
 tools/perf/util/map.c               |   1 +
 tools/perf/util/map.h               |  11 +
 tools/perf/util/synthetic-events.c  | 101 +++++++--
 tools/perf/util/synthetic-events.h  |  21 +-
 11 files changed, 468 insertions(+), 113 deletions(-)

-- 
2.46.0.598.g6f2099f65c-goog

