Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616128;
	b=MQxuP6QVQn0+xCOqwx9mVjFI+XoBzZPkZ/x53eCw9yj6/I934vZFW2TJUJpEaMz4fmg9
	 VR4YxOcloqdan9ZOE0Q7X85SWZ+C00XeUDfwfnCWtndM565UN71yeXGbbPZsr4vIBZubp
	 XH6rDqsWTzxBCcUb8ng3ujmEBpa5sUkzFLEThmUbQGg+gLSw0FOuaKnyyBLCxZurs48f9
	 GSLxiUI9KxyQGw1uYcS7CX+aStWvXAo23VQqc3995It/miMmP/vyZXPxqg+96yVD5G9tc
	 JT7MRbXpC5JTzHpU4EOjFGUesIFs2cOabyp9xsnCQjvlL2pCrx4HoSqQKyFtk65v2Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BoG6FgQzAOsqSSw4b90ZKrbZ/8eF7MERpzSbbqg2z5o=;
	b=LejUz9dd62etRqUSxXL4Im4r7tymyNwbLQNk0+KvvaHJuXRWbKGBJ0HDy9GTdiNUoa4/
	 uC1kzxEHPuxkNDiUY0u6hfKgzDVkRYGIlGClSnMwSwg3qhZh9ZrNPifBX2ABJog9jSmTJ
	 /2vVnOR78PQ2JcUf52FVIlSRVGXZN1tBHRgSj1V+cdDAgSpwWNaToE9Y6juoWv0l0q+5m
	 JJfF9LlAePrzgKZm4nyxu41jJwxGvbkORNKEneIkM2eFHt8IKqs6QcX+Hc0Gh8wg+3rxL
	 OWk/k38oaQ+/kevfTr0Izr1oSHpn4UagslmEEakUiav2KcyFqt0MyWtvBcrBB0sMnZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlsoi9gk;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB0606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 20:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64DB0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rlsoi9gk
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso1274737e0c.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792616126; x=1793220926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoG6FgQzAOsqSSw4b90ZKrbZ/8eF7MERpzSbbqg2z5o=;
        b=rlsoi9gkS/LM3Pu3xYPtL7zf/U6dTptg6cRP/51gPEafMMPbJkkfk5F1Sgimdip3h9
         PTtEPJw0y6xSa5uQsJAL0fNMDnIraWtFrsA678FnlLlc4rNRtsjgMQcACLSLWHbB+pJF
         1cgJ1mJjEOFGAK0j2jsPClYtjcPl+346TKtQBE4XyiTTHLCAXB07T4wDkIPoYfRENcz0
         H1aJVgf5J/WycWH9fkBBvZYWhSELd4BOB4VJCKkoC5l4x6NscEM2gkGqkpJ3tuHIKfUJ
         UBdi9kJhU6N/x8P9PclLHtuHK/ZqtfQdLf9z3GOdC7H38pmSgiArGz1V9Hm+Dt2F64BD
         4EfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792616126; x=1793220926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoG6FgQzAOsqSSw4b90ZKrbZ/8eF7MERpzSbbqg2z5o=;
        b=PMBa5CA6FACzrr7fV3O7tGA6LOuE2850iIJ5nLZ+lgnbuu1d2X91GGFC3sXbHsNtex
         54fbsi8075jdpnNXmdIthZo0p3RLAx9J0eLemLn7WWYhicWjHtletCeBcPSMu6NCYBcY
         sxlXF+0rNoY3h1k/bQj+zKqBw/igpcxOz5zibqURXPLnwRL4DviqU9/Yu8facq8nA803
         GyQibix0gcGvQrk0ATM22TeJdVFuHwLDO2IL2ZsM92PPDk6m3TIGT+z5YXYhVqdL+XBp
         hH0W9RyaMGnqmUjhSeF7cl/XQicYAzVUShIJN8M61+8vP2hbsyoXDZxdcNVY4B0uPdC+
         VDAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQFKluyDnVN53PbYEc9VAXqTXq5k18/0D2NNMb6LYXTFwXA3Mb+svd7XMDNfVcmDd6YHIkLmVcJBIwK+17QhQ1@vger.kernel.org
X-Gm-Message-State: AFq9FYKH6T4jABeBmkZHbESqzQOjalXzWn112iZ2MkyH7GCtSdqd/Wky
	tgGkwQGWxhy7nc1MZCmBS69Mwp3ozT0Wm/cBzTC2Xy6ziziQTx5ALTvKTvjMB304xYY=
X-Gm-Gg: AYBFou1njDZe4w0FkCBVT6KgH1NsJFHCccRPGQYPQaYCbv4i+d0I07S0KCJeprDrU9C
	J7ghDV8Uk3mEAuzQFIF5hS9YbN5crkW7COnMl89jlMvCU3LEayaP19ScAURYNHHfeSZUndffsCR
	l5Ql2fsovHQbBCudT98qlkgI6lFBMZ68/zYRHnCl5lmQ+IoXLL9H0T6U+65FivdLjQvwpHZFsnY
	hbqgChC593pTwA4HlxLuzMXVGyXNRWTq+XM9MOX4Z7u59G2zsSRAWsQZ/rUjmKTDMlaRu/R9R51
	h5nto84TQ6L61UJ+LiVZW6swxWvXaYBMVNVi/z349cEjIyGpPMx1qr2VTmCZcMoaoo4AmnZQ80M
	X1NKD82yaD20Mmx8Bm0+asbCLyWBJ9CvDqo8TlK4gJ37p+pUUX6Sp1EI9FKyQyPzAZlwa19QtRt
	WWexFdvom1G4UgG/YNfaBoVC4bi5fapEGqfW76TLgJVAVXULcX+tgi5venu2zQ/HUe5kyGORVn+
	ol56XFvqVbNp1qFF9WYNmfrNxfIGfvRC/mlOJ7HmCMqD1bo7oU/BgNIXZS4qkz+S51sSbOg6OEB
	lvILwh7xFI2XP2jPUTA1
X-Received: by 2002:a05:6122:a50f:b0:5ca:856d:cf80 with SMTP id 71dfb90a1353d-5eaebde8b71mr1215288e0c.11.1792616126316;
        Wed, 21 Oct 2026 13:55:26 -0700 (PDT)
Received: from Biostar-A520MT ([187.94.15.233])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae980f64esm4553359e0c.13.2026.10.21.13.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 13:55:25 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: irogers@google.com
Cc: acme@kernel.org,
	namhyung@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [RFC PATCH v4 0/2] perf/kselftest: convert Perl test helpers to Python
Date: Wed, 21 Oct 2026 17:55:04 -0300
Message-ID: <20261021205506.26736-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018134322.26445-1-breno3011alves@gmail.com>
References: <20261018134322.26445-1-breno3011alves@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the series converting the Perl test helpers to Python.

Changes since v3:
 - Fixed pylint W1514 in check_errors_whitelisted.py by passing an
   explicit encoding to open():
     open(path, encoding="utf-8", errors="surrogateescape")
   "surrogateescape" preserves the byte-for-byte behavior of the Perl
   original, which reads raw bytes.

 - Also fixed two issues found while testing the series locally:
   * open() failures on the whitelist now exit with the underlying
     errno (matching Perl's die), e.g. ENOENT -> rc 2, instead of
     always rc 1.
   * stdin/stdout are reconfigured with surrogateescape so that
     non-UTF-8 bytes in the log (e.g. oops/KASAN output) do not
     raise UnicodeDecodeError/UnicodeEncodeError, preserving the
     byte-for-byte behavior of the Perl originals.

 - The series is split by tree, addressing Ian's suggestion:
   * Patch 1 (kselftest:) touches only tools/testing/selftests/ and can
     go through the kselftest tree.
   * Patch 2 (perf/tests:) touches only tools/perf/ and can go through
     the perf tree.

 - Note on pylint-tests: it fails on tools/perf/tests/shell/lib/
   perf_json_output_lint.py with:
     W4904: Using deprecated class FileType of module argparse
   This is pre-existing in perf-tools-next and reproduces on the base
   commit without this series. The four files touched by this series
   pass pylint 10/10 with the flags used by Makefile.perf.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>


Breno Rodrigues Alves (2):
  kselftest: convert prefix.pl to Python
  perf/tests: convert check_*.pl helpers to Python

 tools/perf/Makefile.perf                      |  2 +-
 .../base_probe/test_adding_blacklisted.sh     |  6 +-
 .../shell/base_probe/test_adding_kernel.sh    | 44 +++++++-------
 .../perf/tests/shell/base_probe/test_basic.sh | 12 ++--
 .../shell/base_probe/test_invalid_options.sh  |  4 +-
 tools/perf/tests/shell/base_report/setup.sh   |  4 +-
 .../tests/shell/base_report/test_basic.sh     | 54 ++++++++---------
 .../shell/common/check_all_lines_matched.pl   | 39 -------------
 .../shell/common/check_all_lines_matched.py   | 47 +++++++++++++++
 .../shell/common/check_all_patterns_found.pl  | 34 -----------
 .../shell/common/check_all_patterns_found.py  | 37 ++++++++++++
 .../shell/common/check_errors_whitelisted.pl  | 51 ----------------
 .../shell/common/check_errors_whitelisted.py  | 58 +++++++++++++++++++
 .../shell/common/check_no_patterns_found.pl   | 34 -----------
 .../shell/common/check_no_patterns_found.py   | 37 ++++++++++++
 tools/testing/selftests/Makefile              |  2 +-
 tools/testing/selftests/kselftest/prefix.pl   | 24 --------
 tools/testing/selftests/kselftest/prefix.py   | 24 ++++++++
 tools/testing/selftests/kselftest/runner.sh   |  4 +-
 19 files changed, 269 insertions(+), 248 deletions(-)
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
2.56.0

