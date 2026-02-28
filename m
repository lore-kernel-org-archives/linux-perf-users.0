Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CB332637
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262010; cv=none; b=Iw4joRHiNq//om+XzUjohZE4bNxr4m9k7sXYdynwHFBbqRJk29owf5ujDdwZuyUegv+s8+b4HwT7g5gN5F9+XI24vMmHaP4vZ+MJUQlbltSqU15s4ZWIGQdVfeX/GMPHCIkpTopt+6x+fNRG50VSe/b+NO0Am5nAr3aqH7m2dT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262010; c=relaxed/simple;
	bh=Wb4HW2pf4s1Y1bSeLdR3jhykalyGXfsHznDoVntSTq0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=HbHG3MH/Rft80V0voDZZEasQgDFLu86zkpxQiG1pPhqFZZybQMzYwRf2MOb5SY1mje9nmVImEBiq1FP+aco162+lBodoccVY2kis0q6tJNQBBBB/i7+QfXcoQ8jVEsHASXwU6nQtYcovul/0/eM6x0VAj4aEv96tlZZYCAzLmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lihcKSfk; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lihcKSfk"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12776bebeb3so17148091c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262007; x=1772866807; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KVVEJNk7/yr3HWxyL/m+52oFpjzk+cJmsHSX45K8J+0=;
        b=lihcKSfkOLhYGavC72dh0luxFrpC8gVRF2gfxL9DKuSYyi4vMQYGSNNqlfqUH0Z0tP
         GgvVO6KmJOLtSTmXclrMHaMTAWg9hCq4K9rZZmokPUz8IU2PGdQ4DzkLy+AGb1aO+4zI
         Hc/57iUeWs+4tWQeo15w8ypQqt/ja6ejeZAqc2WwfWLohmGjPzh1vndbvVbMReXkdVMm
         5vqRDPjmbj4593QX7Mf/3wQJjZX0RWW6YeJAPfI0I5dvG/Hv2wLhTOuRQ+01SorvagSC
         1uzGl9W3lvp1vq3WFEpajloy2+vfwbyEQpUJ9s1D4DejFgy40J156yGyKfnWeIjRYw+I
         kSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262007; x=1772866807;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVVEJNk7/yr3HWxyL/m+52oFpjzk+cJmsHSX45K8J+0=;
        b=R/4pnjebO3mmwdnp7ELdQCqmV9YavF84RTR4tMSlzlcFbQElSjTBNMWjbyI51VR8dH
         IoqHvE5C+tckN33YabkcEusyiS1Jdr36CTQYs6qixOrqEOUkp+Dcdlc6A/mUGTG1RObm
         /0PfOweEhPxzmBNtzt8tkNJSdfZwrA1vJUmOLPLVMKJ6J5wGqugInzQpy4m0xxx4aZ/G
         W/OMr1G6xzjk+ozcc4SbFOAELCxOXHX476+ZisEUQU4idcrE5SU7xE2dhrbKakH+ZCNo
         R15IVt3JfQds+1j9TE4D0bacjo07Ol4fC5ihXaDpq5bWjSz+CDAmgOuN83rtB9L41Roa
         gQVw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9bCV7hqNTHixHU1w+ob72CmUYljenqJtksbTNJU9u34RzuqdMwA63mRMoFrjROLRbNw+fD+n5GnJZEWF1gVf@vger.kernel.org
X-Gm-Message-State: AOJu0YzVV3m+z899OpRUckahrGYfmRjNpal+j1kSljdlexW/Yucnpe6l
	X7+ItZ0UVJaynTz8LCQ3CkMp4XwTfh/dL9KbBldhFejJQkOLzzM9OX4f8f53hdh/UkApd5tdV6b
	25O9wDQhU+Q==
X-Received: from dlbro3.prod.google.com ([2002:a05:7022:1583:b0:126:faf3:bc29])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:611:b0:11b:9386:a3c2
 with SMTP id a92af1059eb24-1278fd58445mr2164359c88.45.1772262006664; Fri, 27
 Feb 2026 23:00:06 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:46 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-1-irogers@google.com>
Subject: [PATCH v2 0/7] perf data/pipe handling improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm looking at improving the perf data converter with files generated
in pipe mode. In pipe mode I found the feature handling for the last
feature marker was problematic. If a new feature was added then the
old marker looks like the new feature. These changes do some minor
logging and build fixes, but they also change the last feature
handling in pipe mode so that the marker is treated as a marker and
not a feature that is broken.

Two additional fixes are added in v2. The first is making ordered
events handle positive process event return values in a consistent
manner with the reader that ignores positive values. Not handling this
properly breaks with tracing data events in pipe mode. The second set
of fixes are to the perf data converter --to-ctf output where
generating the CTF events is deferred until the event desc feature or
tracing data events occur in pipe mode.

v2: Two additional fixes, bring back --header-only early exit
    (Namhyung) and some comment/whitespace nits.

v1: https://lore.kernel.org/lkml/20260226013534.2028272-1-irogers@google.com/

Ian Rogers (7):
  perf clockid: Add missing include
  perf header: Add utility to convert feature number to a string
  perf session: Extra logging for failed to process events
  perf header: Refactor pipe mode end marker handling
  perf ordered-events: Event processing consistency with the regular
    reader
  perf evsel: Make unknown event names more unique
  perf data convert ctf: Pipe mode improvements

 tools/perf/builtin-annotate.c       | 11 +----
 tools/perf/builtin-report.c         | 27 +++++-------
 tools/perf/builtin-script.c         | 11 +----
 tools/perf/util/clockid.h           |  3 +-
 tools/perf/util/data-convert-bt.c   | 63 +++++++++++++++++++++++----
 tools/perf/util/data-convert-json.c | 12 +-----
 tools/perf/util/evsel.c             |  7 +--
 tools/perf/util/header.c            | 66 +++++++++++++++++++++++------
 tools/perf/util/header.h            |  6 ++-
 tools/perf/util/intel-tpebs.c       | 11 +----
 tools/perf/util/ordered-events.c    |  2 +-
 tools/perf/util/session.c           | 28 ++++++++----
 12 files changed, 154 insertions(+), 93 deletions(-)

-- 
2.53.0.473.g4a7958ca14-goog

