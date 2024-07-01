Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1318F5D
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719808962; cv=none; b=jtRZQf1TLrO6uMapqbDjKPOVXQMOiMesQVOI4Fuo/sCMi41xuer0bKNkqMIS0zwI68tGBoNHgiqdPl1h0ZdWRxShU2ItDHxJW+myZdVEBniDrugHiNp9Zi6sIitHjHuDNIe7MCSIGgaVSclkZNMv0s6D3oA7oUJExnpxr1t712M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719808962; c=relaxed/simple;
	bh=f17c88A26NZskfgiFXDQMND/t9HuKkVv+EOcHsvscrQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=c3FTWXAD0eOd/6ZwgTjR0pYf2vvWc31Rs3ZF62aYXZv3DHbHyQVx+dxit9dYLJKq5JYQq7V3jVwoLB+Zf+MPd12Ebfsgx5eqi2bpgKcnoAJln0HOcTZvKPqP8OeALVYwssiPTk7HdormnPwZDoo+n3BMhUZkGsXJg9X4Eej44So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1JGeSid; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1JGeSid"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0335450936so4644066276.1
        for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719808959; x=1720413759; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ja0X0aEX+OPc1UcZxy/m1jTtUBMOJm0IX9nvA6gMdVk=;
        b=p1JGeSidvIsJa6T/EhjB31zVmImik86Y/pTsH5zX7NseWNpomJQ/eOGKF4ctC+gafp
         a8mIBIb25MXEeDW5bnUL0uT1pceQzVk5iuFzSD6fIxuu5SRq2bAhGJ0N0tsJHg2+8Ms5
         LeLoucuolnGauCV4oXv/Kv6IwxlIpMK9YVJ9WZiQZiYBoUtvcen/IBE96zNff9FzE4Bu
         Ugr2Pi3C2Px8SdVFXnTzoKcPZWFLalfhgJ2Dz9akAOB9E5qVO6raUTu/j3VsnKikmzD7
         lhXSj1TXGmn+Yap4nP6shGP1nz8gWnTAWoEoXEETyVb8icMydCXBHvpXJUKX3qjn875T
         dNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719808959; x=1720413759;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja0X0aEX+OPc1UcZxy/m1jTtUBMOJm0IX9nvA6gMdVk=;
        b=QP9nq8VjWpHsuo5I5JbFm0B8GrggDrCKrtCTOp22lS5IhFQOtAh/LllTeyjb/NcM/H
         p3ZpefR5oFrkQ6OpbJLbwksAelfLOT0sRdetBoB1wM/18dIr0GTmzTZzuqycnVnOS/jD
         PqXwKbtKvMp9u8Ucpni07lNbmH89hbIoTAYT97Jyt7N2vmkti3ZYkHTbJZDpbni9jWkV
         zhxLFZWXytQCGeDcej5pjBfwVHqerZk9/XkIKRRj+/czF67Rck9LSiFzczPnNMBzuIDV
         Eht8l+vIfu+XyJtrTzGqYOzfXJ7z82znYvYuzbD7Qgic0HJUKoLs9/cZqEFwuSRDjYf9
         Qnfg==
X-Forwarded-Encrypted: i=1; AJvYcCXpiSvsAOEua5LBZQ1rjHtxT/DzR5KO24o5hJTfWpPbgGVyXg7IXKA12P8YsDn9NLIBJil84GTJZYv7SjOTG8Qu0ZaFW7vISsmZ+LqzKNStCw==
X-Gm-Message-State: AOJu0YznW3GsMOQHAghJJnYBQt/RQQ3Mt0mfy78tJJbJtaLxcd2EAJhK
	V8zH2/P7/HDvnWbrm4ET3aT9yzPsbHQP+vJvwwgJJHdcA4sGK7QZldV9N+Aq0WY7QR8pp4oiM0z
	elSByog==
X-Google-Smtp-Source: AGHT+IFxobfPLI+HYKOSGevXm/fFjBZH1Ej99MSAQeEXdFzOTyUxD8UDyMe878XEaCetpI4+dWDCHii3+Md/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7bcd:6ae9:263e:82ff])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d45:b0:e02:e1c7:6943 with SMTP
 id 3f1490d57ef6-e036ec43f15mr9180276.12.1719808959578; Sun, 30 Jun 2024
 21:42:39 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:42:34 -0700
Message-Id: <20240701044236.475098-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v2 0/2] perf test: Display remaining tests while waiting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The v1 patch series:
https://lore.kernel.org/lkml/20240405070931.1231245-1-irogers@google.com/
was partially merged. The check_if_command_finished wasn't working as
intended as stdout/stderr could be lost due to waitpid being
called. Modify this function to not use waitpid and use procfs
instead.

Keeping the output test display logic in 1 place should simplify
improving parallel and sequential output. Namhyung was experiencing
issues with this in:
https://lore.kernel.org/lkml/20240628215751.1512250-1-namhyung@kernel.org/

Ian Rogers (2):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of remaining tests

 tools/lib/subcmd/run-command.c  | 33 ++++++++++++++
 tools/perf/tests/builtin-test.c | 77 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 3 files changed, 86 insertions(+), 25 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog

