Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156333D1712
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331010; cv=none; b=Ng3mhlfqqMthrjCXAZ1l/LXaxl4Lpmgvfd9TW7YhYK+pCNhM6JTs7Izp2QWiceixvJnKKrNXOEDU+orYr13UuEHUOHzboBWwBLgrgwEtVPhryNnn/kDLQLE1gfd3c5eS7oXCdXybYmOZXB8p1DSQcU5eZmmNuYRQv4Ram2GrYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331010; c=relaxed/simple;
	bh=bOeeJlR1z+ZmlCVS3ncjbl+NSUZoxWsH5n6bWoRic58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XT+JdF98tZLVT/MbF5qYJu/khAJzAaz6Glv1S6M/IEB0zbF9e+S83BTuhb+yAE1mAZ5g+nXsAWJ/N2JSKZaxTIDE4zi6/uD/TLIaAer3UEbk2RFfDMWKQSptST3muSbVI0hvRdTChFe1gMRm49Vh6OHy3qFvX6n2D3JHh40AE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy8x/cyO; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy8x/cyO"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35d0be18c71so2547476eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331008; x=1792935808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xl79s2FBLYzmNsy3ZHfzJmTaTzI3p4ehFskthqfWREg=;
        b=Yy8x/cyOwfIQDEn5pgl739Wqg2uhvzG0en1Jl+PqztWqsDdTEi8LmHS7Yt8/nkMdb3
         pxAgBDc4Ao/XaS1pIy01B16VCTUoC8HZcaJYH0S8FRFKGNI5hcGLX8kjltH27++I/A03
         mKKxoPaLx7yGFLpecc6eeThY3KfwNBdjSjik5feYuQEuhfBI7g/+sagrNfBuoty9UETg
         17SJz/TbLVswJuPd0VTJtpPbu/t68M06VCNSF6JJaby32Phe8DGOgUGxRmq/SxwNegw3
         TNS15ZpI5Ynmvj9OutKi9OmnTNVPyg7rt0xAQOEtRHPnUb0Hrh/kQIm8GV4TLCltAMbG
         Rmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331008; x=1792935808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xl79s2FBLYzmNsy3ZHfzJmTaTzI3p4ehFskthqfWREg=;
        b=n53XwCjADakvP1MTNbbKmJQDsSoCRYof+d/akq4jty+lGmeaHV1TjeUWsc/k4T4o2q
         8lbgCiTVIRqjrJlXPMrzGw9opF8YKp6NCEph+Mh8als06sIcCWoGSD0Wi9DpaPi1JvUE
         DwJwdIeaFaGZBt6LXndENvEpZRZmAwt5RqNQT8/T7tcTDsl7wucWdT4PjhGIrbHy5fW/
         VzMGQT6UbMutvVAD8HegEed17qg9JRpaT6gCDP8iGGfm4Q7aSEFokQoSRLEo/dUPHDWR
         uJOPF0iEWc46Xsuyzv5MSqErH2MqzOI9utAqZq0mKnrN18Yl/HyqJUm/LJNDnTXSX3K9
         0Gcg==
X-Forwarded-Encrypted: i=1; AKwUvBxU53UWcStIyo5pEi0iY5Pz/I5c8kM5cB43k9/+bomUD4OIh4tfiFvgy2+6YBk/FpvXi9ZZsvG/mdjyNmEsBEoM@vger.kernel.org
X-Gm-Message-State: AFq9FYLlJ5hCDX7ULSbZRNwYNDtRAY90Q6JBI5io0U92+g1SWifn6V65
	gxmr0CHkfaGIcmFcHIvLXQi7zJb24otS57UkzdvbIYAtM6mV7vVPvqcZ
X-Gm-Gg: AYBFou0PfXj9oy3/hc2cjTz5cMgg9LXNSYielP+TgaGR0rxYP7mipozsN80nQ419FoN
	5lxahfWlMEEA5KfxAsxHdUxxqupCnW4Os11jAwpQ7cz6joy641etb+btIxBC1A5RSrGHfykAqUK
	IG/RqNArn7i48puNHXW1UDsDRriXEh0Vt9GsmQxyQc0X8nYV8ZEuLvIfv/+07wTWxArEk4nPH+a
	ZaEiIW3zmQzRpTg3SjlktjnHLrJGwkE09XwLiBkyxaY6PWwjMiCRlneFGCgHFL5K57SdTYrP6dq
	EOZbp3RViMKH03jd8tZ9i1RmSV9SRFJLfeFNqXFrV2/V3S10igWBWzfd28+GSQQjiuORTWKt/lf
	J6mfsXvtqWLeibHv/ar8CFahu+U/dj3nunfyfectY/gKpu6fnwOnHiFCbBF5zDzYhXvCkTZSdNl
	CuAM9c3G0Nm0eLLIW0mS1k3PoDalw6u0NvRra+a0rYu84M1E7vYhuyYLdfKNzZToSZw6SsCN+uk
	hYR+QKdKwuIFl4oyuLA0lxJEK4z6VC50FLaHFYygw==
X-Received: by 2002:a05:7022:ea81:10b0:148:ece:8cc3 with SMTP id a92af1059eb24-1825b6dfd9emr9527607c88.24.1792331007934;
        Sun, 18 Oct 2026 06:43:27 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm27868593c88.16.2026.10.18.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:43:27 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH v3 0/2] perf: convert Perl test helpers to Python
Date: Sun, 18 Oct 2026 10:43:20 -0300
Message-ID: <20261018134322.26445-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018133032.24467-1-breno3011alves@gmail.com>
References: <20261018133032.24467-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 changes since v2:
  - Fix accidental deletion of the tap_timeout() function header and
    opening brace in runner.sh (Sashiko finding). The v2 runner.sh left
    the body of tap_timeout() at top level with an orphan closing brace,
    which would fail with a shell syntax error when sourced by
    run_kselftest.sh.

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
 tools/testing/selftests/kselftest/runner.sh   |  4 +-
 19 files changed, 260 insertions(+), 248 deletions(-)
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

