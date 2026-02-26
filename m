Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564A1B424F
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069742; cv=none; b=CWuJeSK8TZtxTsm5c/N+iA2MsPJ2JdUHJZwQGIulIMgd19NWXO7gqiaKGPwOYw0R07FgI/VfsAVSaJ9en0yUbl3dU/5TxpVz5wfETPCY0pZ/cJLqtg39nwcYTCtYCh++LzbTnD1B0TJz0VDlBNYa0uTyeRBYSVcSef9HJvQI7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069742; c=relaxed/simple;
	bh=4umlkk+RZJNBpAdMkjCkFdcKR9LCEplPI0ZcSF/UL9c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=R/FFc5TKH8hbAiWRot5bO+oHTMj/qB1EaPUdS/fZhSQoxdU9kuvHFKiTOMEkRTvwWqYb2O9CNX4Gh5MLsOF12oFAjIKFUPPqGahyb2n5zXodJmAckwtsmVO85TxO+FoOGv/ME5vRqCC7GvxO0ZkXFKkPXoSD3WHl7bhLZGefBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukVOBhH6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukVOBhH6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc42265a2so306829eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069741; x=1772674541; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vK0BHKbeSDW6+rIxSuWt+4YctUOvYGdT9BcO+l2WcF8=;
        b=ukVOBhH6rO5JCssBWANl53tCLOTnjF+Y+Yy9qSGULXXEQap7wL1DGa4BTK8upvoOat
         ar6BGjXQt+2yAwky2KtWBi3GChm9YADQsNg4f6DumryxjWxpwky3e89oyci0weKWwpJx
         qt4Etth0nNdXDd1YojemZva2UQ0EOu2Jx/pl2Fyxxqcwppj3Nvp1SIgeNkZG9MR5G9eX
         u55gAU8Rlu0wVh0YEt6TkOxj3clEctlZk1UmLa1RJVEtLfp0k9Kgd0FJ6iyzdnBiwhdi
         XyyaNJJVnclKyTJ9bANuJpU+01PEHusQXMZffQVZtMfJGZF/R3Jr+Z6nf8lxWVyWLL47
         S9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069741; x=1772674541;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vK0BHKbeSDW6+rIxSuWt+4YctUOvYGdT9BcO+l2WcF8=;
        b=n0VN93DmusqjuL8TpA17N9qhgylChdBiKqe8z8Ixo2vdX5B3kILGvnRF5mxKQ2/t+8
         VjCh/2c3uOjdJN5FuQlzhNQZzhOvBeMFTHPZl0Z7PEIYRj0DTNqft10Pmzd5cM5mvNcU
         OefcOFPMILg0dUU9HyQQCp7FRlvPFsmkD0mAf3BbATlry3DeWz8HDIO1qkpNTkQHESTD
         3GytRtF6qqVFRwa2HAc/+zYyq/+CNzU3e5G60IT0I5O+GYgaNTZpkGP/fOOOr2aMtsax
         +wOmqKKC3+N8bqiiIarggJdYUaxHaaRObmelCHnTykzcbwOADKmzYxOK0Q0a3VLWZNxu
         NymA==
X-Forwarded-Encrypted: i=1; AJvYcCWhxADXu4lf9j/nQAFI3QvGBVrrv3k55eIU1zS+lHIL6hYLf172Xs/h7htXimsE4cPR+NYRMBrbuvtAlAv5fQr5@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQ4ErqRfyeXrf8djpAniDoVffZ3EqEOQ2+Hcq6x3t3nh7yT/A
	CiE8meMkUWBlixHOTVmuiAxdRwMKLLpZAIf93AddIoDBuv2S2mFX4xn2zN6Y+lYsgQpo1QXqdP3
	CPB+oGmFJgg==
X-Received: from dys24.prod.google.com ([2002:a05:693c:8018:b0:2bd:bced:7a12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e80e:b0:2ba:7a5f:9e5b
 with SMTP id 5a478bee46e88-2bd7bd60186mr7187161eec.35.1772069739910; Wed, 25
 Feb 2026 17:35:39 -0800 (PST)
Date: Wed, 25 Feb 2026 17:35:29 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226013534.2028272-1-irogers@google.com>
Subject: [PATCH v1 0/5] perf data/pipe handling improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
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

Ian Rogers (5):
  perf clockid: Add missing include
  perf header: Add utility to convert feature number to a string
  perf session: Extra logging for failed to process events
  perf header: Refactor pipe mode end marker handling
  perf evsel: Make unknown event names more unique

 tools/perf/builtin-annotate.c       | 11 +-----
 tools/perf/builtin-report.c         | 27 +++++--------
 tools/perf/builtin-script.c         | 11 +-----
 tools/perf/util/clockid.h           |  3 +-
 tools/perf/util/data-convert-bt.c   |  9 ++---
 tools/perf/util/data-convert-json.c | 12 +-----
 tools/perf/util/evsel.c             |  7 ++--
 tools/perf/util/header.c            | 60 ++++++++++++++++++++++-------
 tools/perf/util/header.h            |  6 ++-
 tools/perf/util/intel-tpebs.c       | 11 +-----
 tools/perf/util/session.c           | 28 ++++++++++----
 11 files changed, 95 insertions(+), 90 deletions(-)

-- 
2.53.0.414.gf7e9f6c205-goog

