Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053223A562
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866455; cv=none; b=e0vOoZOlSLgIzoHPxpu5Os0k2YESJoHoF/5KwBI24Bj5WtN0xVXCHJI8gljw2mn0Snux4Vd+lVQ2Cj1QN//heAeiyV4mzeOLKqWFQmlD09oFJgPHqjz1RTgTb7TlvvyJrsh/xISw1cT0Qj3PS0piG6d0dGN07aF6jB1LSyOUSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866455; c=relaxed/simple;
	bh=Hn+ninI+3DORFAi5IiVb4iNnpGvxM660lr3ejF1wZ0Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W8pjkMlF01HyQhWRNXHZ7uDkfZuZoWmsjRDwl3Zt9IGV44L6V6u1lt43dABXQ8hzN68J/tGtPbfokk292fRWq41Px43EssMaTL3sSb4osi6eMrM8OEIw5k1rjCSDhqkHHInWdp+vK8InANZfrEqDAJVWsfwXzyu/eY3kr/PqZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yo17fa9/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yo17fa9/"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e0fee53eso4302930a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 15:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747866453; x=1748471253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6CzPvyStvAZAPyHPlHV4MF8oG4Na1WXPekGCGMFPJTY=;
        b=yo17fa9/02pJzy+l2cE6NkY650R6eYLbqgygkhyvLzeHJI8L/AEXUSVNwepYHXi8l3
         31zpeAQJwk9vsSuKIvtdomYhrsy3vKGfDUSJq2nDcUaZXZfFoEIWNZY8mDejHnov6jb6
         P+AghdVYsJu5zNFlmiIw05XI4iJiXaT47XfaLIBDRxmKBjcy0l/na7JkQYrqSgsn6k9V
         q7d7hTM68wbk+YzXP9kdkD1n5GiyBahTaX4BHLt0rj2Laa4v3wVZplglE8EFZ3BYPjj5
         fLXerMguIBmH8Mivcd6zzrIJ7ZPPPv6aZYf3VTdyBDF+z4hnrAX1dWqP0VM4czqNGCGl
         3Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866453; x=1748471253;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6CzPvyStvAZAPyHPlHV4MF8oG4Na1WXPekGCGMFPJTY=;
        b=WvE/fEtpgEK6jQajEmvxqbneDrhZ1x7LIA+85ONT93wXma9RpYWo/+Td9BagY3YqLq
         Vm33NbAlYPrSEhWA1DjH168t8B5dfmiRyWMNNsi3gBNLbWmwaeKKb5vGUm3DNqOTV9Jv
         JfwpKbccYo0dBfPJoZQKoblniUNQRMIv7jUQbtdJwCjEL2ZQ47sb448Cveu9aPbP3Ahc
         0/AdrkTxNV9bYxurQTWslU73sVlC7N/PlaaapSRrC+aeZdOYsW+r4GicNUH80BhRrdZa
         JiHom1secWBEGk2pQ1orbBXRMxA/5ohac0dJBERH3a5ALOpNCN/dDErUDoAuFQaqDJic
         eTwA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGBfZIvtcfJwKt36Xm7HNCaIcJOsq/dLJflaH80OrhnecAOcnRbcgoCrXPs96m9AnuxSAY2y8/29dHWsbtlhn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LMNSN2YjMKhT3DtgCN799ZOxqLeh7Thp8frfYGncohilfUSI
	m0oN63TWHn0F2PED32Nx/RkHbZXA475m1RS+WNvO6GxOjSJfXspqUbCiRU/w3m7ql/UwHUev3i6
	x4G1+Cg3ajO3Mn+elC3EH2w==
X-Google-Smtp-Source: AGHT+IG54BcjRXKVsaiuZXKqpcjlPd7g7iqMWG+1AwsqqQQ0uCuk5cmYtmsN3yBUhHutC6FZx7inBBAT5OsRKXes
X-Received: from pgah25.prod.google.com ([2002:a05:6a02:4e99:b0:b26:8f51:5788])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734c:b0:1fd:f4df:9a89 with SMTP id adf61e73a8af0-2170ccd7b7amr30549212637.25.1747866452952;
 Wed, 21 May 2025 15:27:32 -0700 (PDT)
Date: Wed, 21 May 2025 15:27:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521222725.3895192-1-blakejones@google.com>
Subject: [PATCH 0/3] perf: generate events for BPF metadata
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit ffa915f46193 ("Merge branch 'bpf_metadata'"), from September 2020,
added support to the kernel, libbpf, and bpftool to treat read-only BPF
variables that have names starting with 'bpf_metadata_' specially. This
patch series updates perf to handle these variables similarly, allowing a
perf.data file to capture relevant information about BPF programs on the
system being profiled.

When it encounters a BPF program, it reads the program's maps to find an
'.rodata' map with 'bpf_metadata_' variables. If it finds one, it extracts
their values as strings, and creates a new PERF_RECORD_BPF_METADATA
synthetic event using that data. It does this both for BPF programs that
were loaded when a 'perf record' starts, as well as for programs that are
loaded while the profile is running. For the latter case, it stores the
metadata for the duration of the profile, and then dumps it at the end of
the profile, where it's in a better context to do so.

The PERF_RECORD_BPF_METADATA event holds an array of key-value pairs, where
the key is the variable name (minus the "bpf_metadata_" prefix) and the
value is the variable's value, formatted as a string. The event also
includes the BPF program's name, so it can be correlated with
PERF_RECORD_KSYMBOL events.

Blake Jones (3):
  perf: add support for printing BTF character arrays as strings
  perf: collect BPF metadata from existing BPF programs
  perf: collect BPF metadata from new programs, and display the new
    event

 tools/lib/bpf/btf.h                          |   3 +-
 tools/lib/bpf/btf_dump.c                     |  51 ++-
 tools/lib/perf/include/perf/event.h          |  18 +
 tools/perf/builtin-inject.c                  |   1 +
 tools/perf/builtin-record.c                  |   8 +
 tools/perf/builtin-script.c                  |  15 +-
 tools/perf/tests/shell/test_bpf_metadata.sh  |  67 ++++
 tools/perf/util/bpf-event.c                  | 356 +++++++++++++++++++
 tools/perf/util/bpf-event.h                  |  14 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |   4 +
 tools/perf/util/env.c                        |  19 +-
 tools/perf/util/env.h                        |   4 +
 tools/perf/util/event.c                      |  21 ++
 tools/perf/util/event.h                      |   1 +
 tools/perf/util/header.c                     |   1 +
 tools/perf/util/session.c                    |   4 +
 tools/perf/util/synthetic-events.h           |   2 +
 tools/perf/util/tool.c                       |  14 +
 tools/perf/util/tool.h                       |   3 +-
 19 files changed, 600 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/tests/shell/test_bpf_metadata.sh

-- 
2.49.0.1143.g0be31eac6b-goog

