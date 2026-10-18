Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B524A0933
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328211; cv=none; b=mxQL4JZ422yEhXm+WeAS9gaPAyc7QJp7hdWcwPIBHGxAbwr1RUxNQLtoAzJ1dYhm8LpkChnxOjFuJljbGPlbKAv+Q3+YWyMdJe5yXaqDhEoQZVaDtNaP45oSLqAzXBuioEQ7TgabTJ2m9EvXG+uRq0Hwir2ZuvAKxGV9FNppWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328211; c=relaxed/simple;
	bh=2WJTSDjAEakWpXPC/NVEOZ+BPuvaLCgPchT0JxuXVV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuEylJvp88cVExO6J6waeKHMwcCnO3fQi8mt21OWkxJExmYcyNHvtq02/51/+xug5KSD6Yv7aQm/h8DaIWkp5oiupTkWyIuFTjvgsXquH38C+l2gYL6gQZPIM/w9Zf5fo8Rp180u5AYBdSASiKW9wnG4XkulJU2qJbkvymCf26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sthafnpB; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sthafnpB"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-16079d54c17so3158896c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792328209; x=1792933009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JERkWB0TDE76PWFJHk1bArxy1QoTkEsYgt43aA6L+iw=;
        b=sthafnpB/g8QaQsUMmsJww5liZNrt3yXIg6uCJg+Ufq7UZQmYmmKIdKhp2UYatLF24
         jwoootDi2Vj2WoFVKATyJTe/5TN6QVtyiGkew5UgWZzXdxw9sJFMNcNyi0ykZsoVYTG9
         RgsNaP+s8bnCTrwHJ7JmVjyjL5B/DeYPgCm57VWL5SBH15zjitjWAIAcpFA9mHipVmhU
         vlyvf9NyfnSbLY4pN4xfToTQFtYWu6DD4v5/eYgk6tAqDkibXrcf8CJ4I7h1aCY/9xfF
         VbOvVEl0KieN2THUIVQzWmvCQfuZEaQa/6aQBhDLhulzIbXooyL5azaQRAntEjN7wSdY
         MbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792328209; x=1792933009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JERkWB0TDE76PWFJHk1bArxy1QoTkEsYgt43aA6L+iw=;
        b=fWCMw4bPbEX3/hVkth94IH41tqBAlSkxyb9fdWo/vz3n5hHdVexvUAfVcEpt6mPNfg
         cnTZ94/kI+P1u1KN+xov17AGk1EgpsU3OuzZZ17rQfhz17OpJ0akouBfc/E5rbPRuXJX
         +yuxcEQwOvF2jzn7As1yCbpYdZ7tk3wKF6q56SGphxZrNYeIO7nM19JiTYaJh9qSFGIs
         96JN1N08/k4nGFl3CeRt8VFl+MtLuZGvCCCzanLLqtCe+Q/QjcKRbuIXqWt1nTlOn8tl
         VlAXI3QgV5mLGqbXrnqInqiWfmMVplPwF/3HtK1cyxry5+h3lA9wUmCrwVAFCrvgzZm9
         vqdg==
X-Forwarded-Encrypted: i=1; AKwUvByISHZSs921d1FhN060rOsjh4M6JAVI15si2PZkmlELB2Tnot5pODOj8jFjtXwkkM7Ka29iYc4zvXW9enMT3ltO@vger.kernel.org
X-Gm-Message-State: AFq9FYL7pNYqlKD4FkSdXjlwt8bW4Wzimtiga7bseFPlyXBFf5ZTEJVb
	EmqUdqxj/90zQvtWeCeL3iut4a9b4tJBwLPKlIfsRQDKYcxptGiCJkli
X-Gm-Gg: AYBFou2iLWXRhvnPt4HOY0Q/cXO1W2GUfHB03JIxJwddAGvT1Og6Z++d4FKhV97LvnR
	2kUNwPL8g/tG5jpnacqYYZAcZPgss3qr5ElUIMue8hUg6UfqyQnIgziGdpxQOuTBH/FRFw0HQIo
	uO03pkZcY1v7Git5foJoKC0Vt1U8i2eAeH69mKrDrhcRvpr3ZTQQszg4bPU4Qw6lPwpTGLF0cvW
	ynF+TjML9uiDXklFFRDJBIB63DzZiim0YSmeX3amR9mTH2sDIuyidXoo3QDD4FHGy7cmo25Ro5h
	SnzpxK8r+tMMz8ufBoPU8YDRh2DAbOMxIqp3p4B5aO77gkHKkgb+grWRMAi0+h9FmmBz7tquWRX
	xxesWtLp2wGUOpwEDGHmurnXLVkqegFK/O+vI39pFT8pcwk6FB0Mfw3E046jHBif6qQt0GHt5Be
	FkY4Hu7L4IwM7iJBzqG8Yyil93LDNszSfaEL8kn3DR3rk6yF8ljCa/XDdGWUrzDpuW+BLVC31x+
	xVImLcG4hzaQvgQMUV1ddMEvijEt4D6+Arw5xwjjg==
X-Received: by 2002:a05:701b:2816:b0:151:d6e5:596b with SMTP id a92af1059eb24-18511ad88c3mr6664435c88.9.1792328208664;
        Sun, 18 Oct 2026 05:56:48 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm20404082c88.21.2026.10.18.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:56:46 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH 0/5] perf/tests: convert Perl test helpers to Python
Date: Sun, 18 Oct 2026 09:56:36 -0300
Message-ID: <20261018125641.23064-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts five Perl test helpers in tools/ to Python 3,
continuing the Perl-to-Python conversion effort for the kernel's
auxiliary scripts.

Each conversion is a faithful 1:1 port: same CLI, same output,
same exit codes. All use only the Python standard library.

The five scripts are:
  - prefix.pl                      -> prefix.py
  - check_all_patterns_found.pl    -> check_all_patterns_found.py
  - check_no_patterns_found.pl     -> check_no_patterns_found.py
  - check_all_lines_matched.pl     -> check_all_lines_matched.py
  - check_errors_whitelisted.pl    -> check_errors_whitelisted.py

All five were verified byte-for-byte identical to their Perl
counterparts on synthetic inputs.

These files are used by perf test shell scripts to validate
test output; they have no dependency on the perf binary or its
Python bindings, so they can be converted independently.

Breno Rodrigues Alves (5):
  perf/kselftest: convert prefix.pl to Python
  perf/tests: convert check_all_patterns_found.pl to Python
  perf/tests: convert check_no_patterns_found.pl to Python
  perf/tests: convert check_all_lines_matched.pl to Python
  perf/tests: convert check_errors_whitelisted.pl to Python

Breno Rodrigues Alves (5):
  perf/kselftest: convert prefix.pl to Python
  perf/tests: convert check_all_patterns_found.pl to Python
  perf/tests: convert check_no_patterns_found.pl to Python
  perf/tests: convert check_all_lines_matched.pl to Python
  perf/tests: convert check_errors_whitelisted.pl to Python

 .../shell/common/check_all_lines_matched.py   | 45 +++++++++++++++
 .../shell/common/check_all_patterns_found.py  | 35 ++++++++++++
 .../shell/common/check_errors_whitelisted.py  | 55 +++++++++++++++++++
 .../shell/common/check_no_patterns_found.py   | 35 ++++++++++++
 tools/testing/selftests/kselftest/prefix.py   | 24 ++++++++
 5 files changed, 194 insertions(+)
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.py
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.py
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.py
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.py
 create mode 100755 tools/testing/selftests/kselftest/prefix.py

-- 
2.43.0

