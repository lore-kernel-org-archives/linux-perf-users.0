Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41384B541D
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330240; cv=none; b=K3PFs1d5Y7ugqb9G7ZYDmOXywC6dfFZRF9MQcIeCUouhttBBTBh2zD5Da+CyfsQxlqZ9+sx7U0TZbJIZC/o200uvSeu6O2qOjGa4+Lf5k4ZjcmMIpGY0d3xPY1kZ4YNIe+Lp4dYPLwQiQqsGyZDPqSTVSDME/B2RK+q+TprWIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330240; c=relaxed/simple;
	bh=NNkfZMaHqUINHPy4yAyt09M/t54snH42tS/afOsUZmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOrWnfnCqXD2O6JzEtfreJYoPDDnkRWOv58I3V2ZZX61TR5tXOAz12tYkXrWyEGZft13e1MWiiUS+oX9n6/Ldj4DzhK3upiGnJyM8etupX/BDS3EATGfTDMEowjzrl7IUbHauu7fOqMEA9LJjMCFbqWHpge3I9NnfaGaLdmHUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9SIDYkA; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9SIDYkA"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15354aa70e8so903678c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792330238; x=1792935038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxNMEUEtD9CHubkx0OvUL7KBqR4421WFDcx17ucFJkk=;
        b=W9SIDYkA5VPWXXIEPz1n0iEPmdtZUE3+KzJoyymXQfS1cDJYHjH5gH6EuiClk2xrdo
         wj6HUhTT7cpB5TtzjPRZm/stqDSG/ZwvTRUasklr6dsS5O5W4WjzVXx/EJCEWE3OKuG8
         FZGK7QmPc+KGg1I0bVniAMnIgLZ+dhHakKOJAdpcFdlp+sY+0PjSeaEA459GySXj/zzn
         qdSBSDBnOPunR70yNezaT6Hm6KWnb3ZLrjSFEQLfk68OJFjJ7iUPK1vP/WW7A5MIKscV
         aSWIGh4r6U2cwuNHPSDKrfeCB1avghcn5WNSE4ul8GOVAJJ8HM12i80rrAseT4yEiPqZ
         VNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792330238; x=1792935038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UxNMEUEtD9CHubkx0OvUL7KBqR4421WFDcx17ucFJkk=;
        b=b91pi9/UUEPUzjeGDmRc+Qf/c1ZkmOwgwz3oIG8/msY3VlNJwxKXZmIAl2LZUp+Jd/
         g5yhpQueb+92cOh1zTQtuRQUWl8/tQI/fly8nFTjcwT9wrAOSVsgOSGVeM4H2aZDHxDt
         PlRwHtuM2LRneOekSEkyWnXckvQLJDKgO+Gf/4QmpKzazdgY8QHHyeiqtzQjUvD3fffQ
         Oa/oM2JJyQmMcKofGbMmCNNgYiWJh0k12u6+zpNDl7V/LHnTyMkc/U+x0pnJ3FBbqtdL
         tCwg3WklBNtPWji3XLzOKyaHIVQafdzj52hz+1Bj+qBQF0XDWqNCs1A+RPVpE6bv668K
         T/pA==
X-Forwarded-Encrypted: i=1; AKwUvBxImoT4BOybSjq7fDYJELqYivA9Y/Keyn69n2Pq7srH6IrdPvtI9MB9R2IhROcIRQMmvFtXKL/ktHu+UGG5+iq2@vger.kernel.org
X-Gm-Message-State: AFq9FYKROrftIxFTyyKPYr52DUgAd5BMBWFwwGFoZdzKWSiKFE5IdK33
	SZ3XvNwzsxhPdbp8Cjca1MuKkN0YbSCQlGeFv+3+dmj3hkvKRlYUVsAr
X-Gm-Gg: AYBFou14e4IfQ0YP2Y4Z93tYhuzibrTmyCtZcDpsb58MU7VQz4KYy/XPERJXijaKMS/
	PBG3EpV2LMXJ093serEXP8stKgVQ5G7ygAbjF3xrynrPUwPEyDTDzqut6ejgTFQvysqDqk3B1rh
	Qu9nC1RM7NLnpNhuHk2sGkgSzPX5Yj9Ma9QVBaCZyfzOfH+e7Ve4SW5FcB6XL8b9wGaKZRf9mP0
	8yxPGdVmE2ulvWe453/nfgpFq4wyW9WXcl1h+EVY+E7XxafaknazMYq6oQxjuOJ8bPEA4fXv8im
	a9yPnjtFug7sMQDXe7BprXHuDl67FwPZm8LTNZJH8OEJs4OqBruD9+yx5tReGI0YpeLr+5L66hi
	orJqYHYTR0p4HDLv/dIvJZOBKbm+1h3XFNyfA8NTyZ6vJslW8QOXFL9+qB4kdL/NVSvfAV/j9ok
	Ac7geDNgDpeo78YwwRjFBn9+s+qwYpHgoiqW+h/xRq2tCYRamYP/jPyR86ZcsLVKk9lSMcsv4Aw
	C7jwaCRvW48xp3zCl3iwyBry6M7DzOvKTB3FkFoAA==
X-Received: by 2002:a05:701b:2608:b0:185:9384:31b5 with SMTP id a92af1059eb24-18593843236mr6207679c88.45.1792330237788;
        Sun, 18 Oct 2026 06:30:37 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm19879934c88.3.2026.10.18.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:30:37 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH v2 0/2] perf: convert Perl test helpers to Python
Date: Sun, 18 Oct 2026 10:30:30 -0300
Message-ID: <20261018133032.24467-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018125641.23064-1-breno3011alves@gmail.com>
References: <20261018125641.23064-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 changes since v1:
  - Restructure as 2 commits (prefix.py alone; the 4 check_*.py together,
    since their callers are heavily intermingled)
  - Update runner.sh and kselftest/Makefile to invoke/install prefix.py
  - Update Makefile.perf to install *.py (not just *.sh/*.pl)
  - Update all call sites in base_probe/ and base_report/
  - Remove the 5 original .pl files
  - Add trailing newlines to all 5 files (pylint C0304)
  - Fix the check_all_patterns_found commit message:
    TESTLOG_ERR_MSG_MAX_LINES is only handled by check_all_lines_matched

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

Breno Rodrigues Alves (2):
  perf/kselftest: convert prefix.pl to Python
  perf/tests: convert check_*.pl helpers to Python

Breno Rodrigues Alves (2):
  perf/kselftest: convert prefix.pl to Python
  perf/tests: convert check_*.pl helpers to Python

 tools/perf/Makefile.perf                      |  2 +-
 .../base_probe/test_adding_blacklisted.sh     |  6 +-
 .../shell/base_probe/test_adding_kernel.sh    | 44 +++++++--------
 .../perf/tests/shell/base_probe/test_basic.sh | 12 ++--
 .../shell/base_probe/test_invalid_options.sh  |  4 +-
 tools/perf/tests/shell/base_report/setup.sh   |  4 +-
 .../tests/shell/base_report/test_basic.sh     | 54 +++++++++---------
 .../shell/common/check_all_lines_matched.pl   | 39 -------------
 .../shell/common/check_all_lines_matched.py   | 45 +++++++++++++++
 .../shell/common/check_all_patterns_found.pl  | 34 ------------
 .../shell/common/check_all_patterns_found.py  | 35 ++++++++++++
 .../shell/common/check_errors_whitelisted.pl  | 51 -----------------
 .../shell/common/check_errors_whitelisted.py  | 55 +++++++++++++++++++
 .../shell/common/check_no_patterns_found.pl   | 34 ------------
 .../shell/common/check_no_patterns_found.py   | 35 ++++++++++++
 tools/testing/selftests/Makefile              |  2 +-
 tools/testing/selftests/kselftest/prefix.pl   | 24 --------
 tools/testing/selftests/kselftest/prefix.py   | 24 ++++++++
 tools/testing/selftests/kselftest/runner.sh   |  7 +--
 19 files changed, 260 insertions(+), 251 deletions(-)
 delete mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_lines_matched.py
 delete mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_all_patterns_found.py
 delete mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.py
 delete mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.pl
 create mode 100755 tools/perf/tests/shell/common/check_no_patterns_found.py
 delete mode 100755 tools/testing/selftests/kselftest/prefix.pl
 create mode 100755 tools/testing/selftests/kselftest/prefix.py

-- 
2.43.0

