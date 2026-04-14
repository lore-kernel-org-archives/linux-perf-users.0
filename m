Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6E21D590
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170896; cv=none; b=dRGSG0THK2R9XlN1ucicXgr/aBaRxq8ioTx5QxNO/9F9CBH5cFTO97ewwE6VTzqLuR9fDQEfhRo6Miz7Acc7SkZWtmZtTzO2zKJ4/p+Ys8w4Y054tywnCZ3vUI8ee0aIWOWPQEmyKr5P7bwpAVxb5+22uTQ0DAhXgl/z8RCUbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170896; c=relaxed/simple;
	bh=YrZo8Sz4peDwlBGDfyNFotxciFBk92jX4lJ+BDtt604=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eTet4Tprct5WR9y0EPAHSAkBkbbjnqvULNj7pBiXLu0UFE6LUjJPShE/7AE+urzc8eHb7LauSL8rW7B1o80tg7nmdeIsovL4sIFtY+8iw4rVQAMHMc9KKhevWaldut+DqG0smNmTnjMsPQac0a8P21t5Bg2roAbaIMrlXwSXcfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ohg8VUHe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohg8VUHe"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so74470325e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776170892; x=1776775692; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bRMqXcgfTBMb2taAmCioY8eT98K2Okrp/46Mz8Swy10=;
        b=ohg8VUHePmvzL9lcNA0dJsecRvolTaXAEwi0+y1z87bXj2bSngi65lnWkEtfD7RpfK
         NbU9pjbvwFQq/pJN1LXkKwqOkMzKkoWavZHvSj0OZFhe0GRTtZzNmfqiux7jhhXhbn88
         sbCC6EZ05bRy3RGtYDDNboftydyyjYdUFt77Hm9ReoKXtGBIVm/C98rBwFlcGVnmmtIw
         NQcb5LoUHJjqWyrqMLicyMytcd7OOH5uYmJygeq3fBrSt8pWUHqQ7AugsWVssB+SO1N0
         6vegepQsKfxRaEezwZyyqf92fmWQcI2Yy5rp/Pa/qNLmk7OWaBZDc8ZVVBFMmoFYdavI
         0LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170892; x=1776775692;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRMqXcgfTBMb2taAmCioY8eT98K2Okrp/46Mz8Swy10=;
        b=aOYRsUI7FEKVl+gKLVE5K8IU1GyiWco/tiGqO4nyxutqZlz16u9WpE3wnamPvxiG7d
         1om8ufc6Vp5YZ/DfkRKP+z87wGJAZIhnhgXfssZN5kDKG4I+dWzpWq1gjkXX8mZmvNn5
         uUG7wbQ8W2LhrmsxzKWXaEoVJrGknvkRvVxZmaAt26wie+CsPUWQwz9dTU9q5zNZpoHU
         ZULIccU2WldN9rI9QOU1Jd3Rfx4FaiXdB9hw+gpfcQW8ieAeYR3kL09FticMdsbAzBTd
         81CRUn/JPe4Gv8GVOXQMEADyljV4mCQJ6O8b/TJTUYqBxkK8valalnYmbc3pktSdPv9O
         ODyw==
X-Forwarded-Encrypted: i=1; AFNElJ+ArRS3ngSQ3077J6b/B/HgDw7CVpr/DR7iJpF+OqjTx8tmMV1DPV21syuoFpyQ/UD0C+2Q0RsySWXmZ0h6+w1T@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pzQSnMVF5Ksa12LI7MkpuvTb2j6xX9zgX5MceGcqgdz3N2ny
	u4ackockzlVyfnYZL/I3+gTezsok1qvKGVFKOLTZbU9QX+qBlB2ukIJzygVeCbcYiLA=
X-Gm-Gg: AeBDiesjJGA7GtS6uP34DivzVFS4QKAthgpFQuLD3XNiuUQ8pHs5SYKf4VnijFL0vj5
	OPr1Og/SDXSeCM9K3sdW+UiEOofdeFqf9ElLa9NJ3lbI86QwqDDFXws6GAgxMzWdqXrYNSBdasm
	MhaAwrmEILe61sWk+mj7AdAEXZ7pawASrr0akfMtUxPxlB+o7C3v8AwMti7f348d6yOHRVFFx+5
	bKNuTxwfbGT0avR7yIgNG1ue+N9Z2v4B8b8qMCFu8QAU3D2fGPbPDkNTgfFUa0n03kp1nFSEhyN
	CJtYDgBc5Ke7tWtDtzqOJXAYK0BZbEoMSs5zbriEPHKZDc5KRnqkkmrR7GN1A8bqCwzIu0rxY7J
	CXV7pFvin8CUa1n2Thl0dee0sD53NtSSD43tIW/6FIUhxw3QRWOdeSf8Ng5qIE9sm4eSOpks52y
	guhtTFM3MrEo/s4VZ3koXf6EdCJLz/eNK7UcZJbg+wjw==
X-Received: by 2002:a05:600c:820b:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-488d685b878mr245798645e9.18.1776170892428;
        Tue, 14 Apr 2026 05:48:12 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm81185285e9.6.2026.04.14.05.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:48:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v4 0/6] perf arm_spe: Dump IMPDEF events
Date: Tue, 14 Apr 2026 13:47:58 +0100
Message-Id: <20260414-james-spe-impdef-decode-v4-0-1dd30783a33b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH433mkC/3XNSw7CIBCA4asY1mJ41Yor72FcUGZoMVoaMETT9
 O7SutGYLv+ZzDcjSRg9JnLcjCRi9smHvoTabojtTN8i9VCaCCb2TEpOr+aOiaahLO4DoKOANgB
 S0Eo55cA6V5NyPUR0/rnI50vpzqdHiK/lUebz9GMqtm5mThk1wEDWwgrB7OnmexPDLsSWzGgW3
 1C9DokCVRVIdFrXVh3+IPkFcbUOyQLtZWOctgctG/4DTdP0BiIjJglRAQAA
X-Change-ID: 20260331-james-spe-impdef-decode-d944f4fdcff7
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Al Grant <al.grant@arm.com>
X-Mailer: b4 0.14.2

In the Arm SPE raw data dump, IMPDEF events aren't printed. Add the
ability to add names for some known events or print the raw event number
for unknown events.

For example:

  $ perf report -D

  ... ARM SPE data: size 0xd000 bytes
  00000000: b0 18 c6 32 80 00 80 ff a0  PC 0xff80008032c618 el1 ns=1
  00000009: 64 e7 42 00 00              CONTEXT 0x42e7 el1
  0000000e: 00 00 00 00 00              PAD
  00000013: 49 00                       LD GP-REG
  00000015: 52 16 10               	EV RETIRED L1D-ACCESS TLB-ACCESS

On N1 the event line becomes:

  00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS LATE-PREFETCH

Or on other cores it becomes:

  00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS IMPDEF:12

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v4:
- Change a pr_err() to pr_warning_once() to avoid spam (Sashiko)
- Link to v3: https://lore.kernel.org/r/20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org

Changes in v3:
- Revert for_each_set_bit() back to a loop with BIT_ULL to fix both 32
  bit builds and decoding on big endian machines.
- Link to v2: https://lore.kernel.org/r/20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org

Changes in v2:
- Put MIDR in arm_spe_pkt (Leo)
- Use for_each_set_bit() (Leo)
- Use BIT_ULL() to fix 32bit builds (Ian)
- Don't call strtol() with NULL (Ian)
- Link to v1: https://lore.kernel.org/r/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org

---
James Clark (6):
      perf arm_spe: Make a function to get the MIDR
      perf arm_spe: Handle missing CPU IDs
      perf arm_spe: Store MIDR in arm_spe_pkt
      perf arm_spe: Turn event name mappings into an array
      perf arm_spe: Decode Arm N1 IMPDEF events
      perf arm_spe: Print remaining IMPDEF event numbers

 tools/perf/util/arm-spe-decoder/Build              |   2 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |  17 ++-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   3 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 144 ++++++++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   5 +-
 tools/perf/util/arm-spe.c                          |  62 ++++++---
 6 files changed, 158 insertions(+), 75 deletions(-)
---
base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7

Best regards,
-- 
James Clark <james.clark@linaro.org>

