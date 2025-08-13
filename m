Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4D2EAB6E
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092357; cv=none; b=P8fANDwZ3S4/8gmaVDrdyMNzGxLqU2xk7KzedM8+V5nsxrgckbVXoLzhMgfAtHhSA84DQb8nfgMUtDltRZiBU3OoktBBzq3SfI7p1lW0ZDrdpo+uxzFefvQmwVjxgnGltTvX9z2bYj2a5w64GfZVmbWS3UuAbPjrU1OasS+FczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092357; c=relaxed/simple;
	bh=BSquri1ehPvo/7d5c+a4YTv4dM4257Xit2wsucmaE4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZrfOsWjhQJGKyfgj3+cObhIUMWziKwmc8o1UxZQTkqfk6nFpLS3CWjsUp8IIxGWYJbcjlY2xes6QooNt35rZ4Xb1aDrjjPk5G/JFUUlJQxw/ToMT/B0taF+6o0Qq64EtPOocbkPkJ2rIZb8t9DGicx6zuoeFNMY/ykh/ijVG9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBEVIFyG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBEVIFyG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so61483715e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092353; x=1755697153; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eXRTSxaBDiamZdLryvWgDWimTgP/dkmICkmflBjhYNk=;
        b=IBEVIFyGCN+2VJ5uRjo5cQr/O0fYF5TZkCykgYqvV1jgcW0N5FTfKeGN8D1nAXKNZe
         h4OIH9wIqz0ZcKTr7nHHYJg3R0AoodJ5nYYyT0VGM8cNqU1KhlhH8VMHfY64xv1oXucC
         ZqWWAyHlSEMK+hGdP7X3FnDuPExXdplFWOGvyzYmZfAQbzhfWjLXXYdZnMV9qGApND5Q
         5XIqrlX/k0j7UTfoL2TeXy2jXujCO4gkSUBgbwoN/Tqzu3Dm57ZmNClPljqV98aghlUM
         0ev3s/kOfUIVLxO6Brs0KvtNVazP/WOYfg5k6u5hJM4KbPviSvOoQBQ3kV4AOoVQUIvb
         Ieaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092353; x=1755697153;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXRTSxaBDiamZdLryvWgDWimTgP/dkmICkmflBjhYNk=;
        b=cIL6wekWObjKG7sDXe2oG7ADjSEJFs2aQ81JWK/oPXDJzsXmSeFr5wuZ/kBw9a5o8x
         bO951sXa3iYL2VenCSC/o1TZOFTnOrEfdEh2jCRZTgDtl3kaCB5gZo0w/H94Y3hWQUMG
         U4+FTB3Y53hkUotfBx9Z2SpPpDYrD7Lsc2IGz5RBk2iJk3nIc8VYiiLdF1YdUvHWu5SL
         NWCryfKfLgTWT2lQ/6+jaHs16QQP+1HsyHXGze+0BnCzkTAHDCYE+jYdLnbWR68yBE8d
         qdz9UyBtXWvE9I96EG4OLv2VwoZrIyGi7G9fmxcanVQcQwwg47C4SXFMmfftjmHpgyC8
         c8Eg==
X-Gm-Message-State: AOJu0Yxk1fPKcUL+h/TFfL68yWaU6xsppXNfXOQ1o1QNAGikNGq7PgSL
	7ElXXINSyWLTnbVnuzLxf1EgVVqugnrhK1WK9EiC5mgGHCe1+W1uEZQxJM8+bOnF1Gg=
X-Gm-Gg: ASbGncuNoyKShMPMJSFQqca5NGlSaGMfQeTxNMmQmYRsmACVmjdLB+77XlaT6PdsJ+p
	G6corDmVML4BTUQpopQZFAd4odwVRttXGnSsBwkwZ238ciJdsgbkCYNBwJtB/h541aR9a8vt6kM
	wJ7aj0/GpcOGWL+h471kVXnw6aCxvyGxcCDDAEr3tsRszdhGwEBIPOkhxYbAQr2MTFrqdx6+1yA
	t+368Ahp4qysb25+nZYk3UQiSIXppj4WoPfCs62nQKlE8iKit+o6IO8QHw895be56S8TQyRUbOz
	Pq0qngPZWoAThalZ3WeUi+1kly1L6ZQWz7Ce8g2EOH9Ll6azb1jAa71VUMax3pzL5Ic3mrElz6r
	+VYv0T3SXpSd/iqTlEwpNMtwN91LsRyo=
X-Google-Smtp-Source: AGHT+IG3udgDaAlwh+lrjjXU3BJxo4TAd0E1NhlNY+y0CX1dG832Sh7haHOGucTAmj0XC09O9jxQYA==
X-Received: by 2002:a05:600c:310d:b0:456:f1e:205c with SMTP id 5b1f17b1804b1-45a1659a26amr32940525e9.4.1755092352977;
        Wed, 13 Aug 2025 06:39:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a596280sm2559145e9.28.2025.08.13.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:39:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/3] perf test: Extend branch stack sampling test for arm64
 BRBE
Date: Wed, 13 Aug 2025 14:38:48 +0100
Message-Id: <20250813-james-brbe-test-v1-0-76a0144b73fb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGiVnGgC/x3MTQqAIBBA4avErBtQK4quEi00x5qgH5yIILx70
 vJbvPeCUGQS6IsXIt0sfOwZuixgWuw+E7LPBqNMozqtcbUbCbroCC+SC0NjjfIh+LaqIVdnpMD
 PfxzGlD41g06cYQAAAA==
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mark Rutland <mark.rutland@arm.com>, "Rob Herring (Arm)" <robh@kernel.org>, 
 Adam Young <admiyo@os.amperecomputing.com>, Will Deacon <will@kernel.org>, 
 German Gomez <german.gomez@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Refactor and add some extra tests for all platforms which were useful
when developing and testing the BRBE (Branch Buffer Extension) driver
[1]. Then lastly extend the test for new features which are BRBE
specific.

Tested on the Arm FVP RevC model [2] and Intel Raptor Lake.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=58074a0fce66
[2]: https://developer.arm.com/Tools%20and%20Software/Fixed%20Virtual%20Platforms

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (3):
      perf test: Refactor brstack test
      perf test: Add syscall and address tests to brstack test
      perf test: Extend branch stack sampling test for Arm64 BRBE

 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/shell/test_brstack.sh | 106 ++++++++++++++++++++++++++++++---
 tools/perf/tests/tests.h               |   1 +
 tools/perf/tests/workloads/Build       |   2 +
 tools/perf/tests/workloads/traploop.c  |  31 ++++++++++
 5 files changed, 132 insertions(+), 9 deletions(-)
---
base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
change-id: 20250811-james-brbe-test-f5a20dffd734

Best regards,
-- 
James Clark <james.clark@linaro.org>

