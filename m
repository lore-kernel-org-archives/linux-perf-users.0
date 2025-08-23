Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71682B9BA
	for <linux-perf-users@vger.kernel.org>; Sat, 23 Aug 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907240; cv=none; b=XZk8mO0cAIG0jBmjygzwfeEvFVjenp8DUcEPr4Q/iMEbG8Ip6aGuFWGPMwAmahrivtGXdMk/+IZo5AoGfKWQgrXgS0Zk2uFh5wfWN0aIHOZBfKgl8QBE1sbWnq1R9NHBMWywAdRmw3IkkNMt6r+MzebqIzwI735BeVn4jkXuZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907240; c=relaxed/simple;
	bh=nc5wVeijK9Wjrn+uLqWACfEooHV8FiDKIuhW3vIA6SE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=eyfsb64GnhOmum0ybQu/7Y+FjqPo3j+/AJq8FdS4S6ubUxpGJJmVdWIElCVk1ocmQJMGnPY4mempoiZ3haJ6ODBUGwtLVGAJVfPydB0B4tslYd6vwU8VsJmCM5ERqiFhywdRp0VKUikLAZFP3407SUeBgW6RBUw8xjSCwx60kVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/YGDR2Q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/YGDR2Q"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445820337cso28415975ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755907238; x=1756512038; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfWFIMVz0mm2fZwbJirBIf2BOl0V5TcQ24dxKezr25Q=;
        b=p/YGDR2QA8CKJQC1AdsFEprBOqrIC+VCpohBrnfIX/m62QIKvIfuJ6RM5moS3k7WyL
         V6LIrjpegqoEB4QeKB+mrkC7UllwAg7INYXz6MwIaLVIF/EhuIpo4r4Ri6Y+TY7gb5Ev
         knscJg0lcJUZHsQCJ94efaT/s3eIVlpxU+q1aeW5eoA9oul/oD/K1fo9f/xHp2J86dEG
         KNzSzV9HOd/+3guE5u6MeKePJ9ttDAZaPP2um5j+hBZhy5j136kuUd08bmUwqNQr8rQA
         i4LE9rO5D1JcEtHtrybAC0b98MlTOhrgLdHdCYUOlo+BhPmcAN4o7sb3v8DiEifpy8zk
         BEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755907238; x=1756512038;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfWFIMVz0mm2fZwbJirBIf2BOl0V5TcQ24dxKezr25Q=;
        b=JqbeawXGgTz+VvxG7qCRU0wBTcLLM88ogd/aLAGzpRTRDZmozabzXjuZ3UhYOPlEpB
         ReO7VCz9vDZzChd9ofaLDAPK/RtZiW1q5shq45RxP+jmP14JrIRZ3MYN+ijo+6LDKVts
         0hQ6b2dKWZgBIgsNAkbAtZ9diyKnrY3jFWhbTk0Iew+tlbDkaJ4dZih4bILrpyvhDMna
         jaFhJ0V9H6zlA2PtvPn0kN+B537Lyv90yMKIRCGqgUbc+5ViDnA5lAg7URmWx3aVbaM5
         lZ5C/fu0iGnORKWx8rPj6e74ahDvShfrRaLB00WwZKFFnNxplaaDIpn9c3KyNEFoKlBT
         C6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5y0mBUWtPePVBF+gApwWO9E/uOe7J2RM9d96ScVXPM35RhZtg7SO94awdy4wz8Nwe4XkMfSU1mQPdkkjItVAV@vger.kernel.org
X-Gm-Message-State: AOJu0YyxblgsPNLLr3bT+OthAcPeq8nhun8AiSTW4UYQxGwFuRzJAcwN
	VPHgzaibLixnXC96PuL/UkYuGML2HeEewnNi7d/FT6e0GySPH3Fg/TFCc3lBdsRLzMqAi8ONN2F
	F9A4zdCz+KQ==
X-Google-Smtp-Source: AGHT+IG/VGthMy/qmvxyNzqmFHntL0M8KkI/7D+gED1RZgKsZVo3/xXoLaEGAswtOFcHoSsKkiL04hwQRIBl
X-Received: from pldp2.prod.google.com ([2002:a17:902:eac2:b0:245:f002:d659])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4ca:b0:234:cf24:3be8
 with SMTP id d9443c01a7336-2462ef0380amr64931075ad.28.1755907237930; Fri, 22
 Aug 2025 17:00:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:00:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823000024.724394-1-irogers@google.com>
Subject: [PATCH v1 0/2] Build ID mmap related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Dmitry Vyukov <dvyukov@google.com>, Song Liu <song@kernel.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now that build ID mmap is the default I was seeing hangs during event
synthesis in the perftool-testsuite_report. The hang was happening due
to data pages giving block device file paths and opening the file to
read a build ID was blocking in the open. In investigating this issue
a bug in symbol-minimal was found. These 2 patches fix both issues. As
the issues are present in v6.17-rc2, I think it would be worthwhile to
add the patches as v6.17 fixes.

Ian Rogers (2):
  perf symbol-minimal: Fix ehdr reading in filename__read_build_id
  perf symbol: Add blocking argument to filename__read_build_id

 tools/perf/bench/inject-buildid.c  |  2 +-
 tools/perf/builtin-buildid-cache.c |  8 ++--
 tools/perf/builtin-inject.c        |  4 +-
 tools/perf/tests/sdt.c             |  2 +-
 tools/perf/util/build-id.c         |  4 +-
 tools/perf/util/debuginfo.c        |  8 +++-
 tools/perf/util/dsos.c             |  4 +-
 tools/perf/util/symbol-elf.c       |  9 +++--
 tools/perf/util/symbol-minimal.c   | 59 +++++++++++++++---------------
 tools/perf/util/symbol.c           |  8 ++--
 tools/perf/util/symbol.h           |  2 +-
 tools/perf/util/synthetic-events.c |  2 +-
 12 files changed, 58 insertions(+), 54 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog

