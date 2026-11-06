Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962117;
	b=dAwWOnHnEMiFjW9LA+ImOt6uAWq52Y+5VBXkma+olaJxsZqPdJ/jiVVLx1+/X8oYLBzU
	 IXpIjvJoXQqethz9opjsvAJmPVdobieqRroNeABV3nJnXclNCWIsHaIKx1WDW1Ru0ly7+
	 iUTdRtADGq73eePfUovQBZWu3GS/DYqd1yYBjHLd28JtuD2zYJ2+r7tQSPC4xgTTz+Wld
	 iGL5FtUXx4JfcBYDd46HujlzCVu4o+oKZz/ZjxKXmuIbs0XFdq482nk2RAt6aHOE/vApR
	 k5xipFT6g4SzSQSQjcFknaGADZ41jqlF1O/HqZF3weCS0LgLSe5wuEkkMDLn6v8uE0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=QPhlS7hNAGme7fTUkdKF49UIBocGWfyVeEHaKEHHT+U=;
	b=Lzh4yumi8dghXTjjEJNDR5sYfjEQg0YXAT1gxYb2VFSzT2A/v4H4DKJvMlk4KmYNCA7K
	 1+6MQl3UrxumFlULi2D7lR70bwgHYIAUOnmwn29eXl3NkUJiL3MIYkOVbgqw3XCSv3Pmq
	 qJKNJyIxpqWd0MzCOhELDcBK9neL0jQ2llzb2tnw6cO9Awvx8+TfHbHICljjCWFGMKPEM
	 IRiTbpbJZ7IdIOsIasJ4TJzPltQ6SP8RSCs9MhF40rnm2qlP3Qyznmz+7ojWRmFimA1kf
	 cqvIidEf05ob1oSkjk4ZeBVW/J5hQeKMy5A6H8tnwVkLXGDWcg2wgI9/HEf8vHImKwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a7nNAOzt;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535C606D826
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D535C606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a7nNAOzt
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so3490935e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 02:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793962115; x=1794566915; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QPhlS7hNAGme7fTUkdKF49UIBocGWfyVeEHaKEHHT+U=;
        b=a7nNAOztDIRAE0EaFYTkDJcetY/0vMZ8fv5QVLf5WAQ3Y7hpF+2H2986u3hs1dqCAl
         8JMPZtucl+vr1+4+XUPYD6pk8J4GFheRRdMSK5hEDKlD8X5zLaoUd3aL+DXG/ix2O6kC
         5O7Av9rGcjzD8dVi6YFTOPPSmrEN1L3jOb37UOMuGZ70gv4Qy0+/Bt7h88PvkjAHQobh
         7vHQdyNPgk+X2/zCbBa94ASwRIJ1MOq6XpedM6w8Uw6Elf7e3BaPucgQy5Pno0Lmf7QK
         3OokzOpOu/QYTUeAkDNtaR3SwHFDSBo6qYoJ5PTtfQB3UCzzT22jqTTmCs8XKoY23IpR
         7qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962115; x=1794566915;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QPhlS7hNAGme7fTUkdKF49UIBocGWfyVeEHaKEHHT+U=;
        b=lFpJZcxB3xXaZwAgOQjYlZXwDN+azJ1BS7vvTV86uyiRjMQpxkiOnXCnSqERpY0og6
         Axw4uLtV9ZV/kOE0FSIv7LlAc+JuU888hVgQseLvI8rZszueHX7imD+Tl6iBCvMIs5Aj
         E9qGdF3Zj5AIEw0gP+HFJ1t/wJe7btNixcBvOytVHaAYWJjMoEjlv70ewipDOYyvg6wQ
         flvI4lOR3nZfEfEIFalQjKq4jWZQm/UlPLxH1vXXmu4iMtECYx6D4HVNFJdL1nQVNyJE
         bzMn+YyO+r9F87dQusNNkpjMYIlnIF9d9xzUBdkqpzDYjDky9xafrM9z6TLronDEuEFg
         HKbA==
X-Forwarded-Encrypted: i=1; AKwUvBzPLDnFPl+9PK/f+6GBZUtx/QMsQrNECVsl52ZjVwNBrUBYHgMQ5IlcnSPJr4DWt/Vja5/LQZzbuQyRZYfitLoA@vger.kernel.org
X-Gm-Message-State: APuU4Z8MY80a+VwGXHZVFmSEzYqQH2DBygX/7qHM+4NsiurjwuNctsxr
	U7LbCv1esYgezGf9VXUzQJKJa4vfVIxT+icaix8c2eENJNJehcFR8XKe6oTGB/3syvI=
X-Gm-Gg: AYBFou3fXS1/o1k6L7JqBx5ptrel9CgWnOFq9JHjezlL1QuJmpy6sbgJzAdCX8DRdu5
	p2UuQotvhGVBXIMd7B0SacJE6tRUvy00fJqK8F9tHWZWKGWXNyib5ppRfDRPUVHR9PSo4asS0gu
	sCyypyBuXNDjEcd1G9JHT43jMvzAYaPU30fy6dlmsLJq7pvpUUj8u/wkoQb7Td5tplMmicUGvHq
	Bu4A/3GCjRaG9A8wzp3dc5lnESdAG41ZLHND0WX9zKUDwq1nFsB9TjWMCj6zEK+IcUuhN0TubYH
	qoalWnFWg58J1LNeYke97gbXlUgbh1XfXWdM8vr14ox7DtZ6agsn1vmy+9mfLa4wop6s9FwN/gw
	w5L6U2ZTci6vFE4rwrL8BIeceWYmCMJybrAONFk8pE/1Lzq34ohDdG3LJS2QlreK+PBoEGko566
	2GiRndEgw88Qlcve2oR4MlOVaQ5mEessbUKXTjb7eBfxVJ3tjA3AAXe2uFRc5ZNZk3gpLqcIIl9
	wV1LFxk6wUX/+h/hYAleJY0V0JsD2Do/PAbnNcrLdKl+lRpzqjdUvPP4pf46kMR5Y2IpRaAUXw+
	lesLx7QzPnjHs6S/sjhkfkvd3u9d2cUo
X-Received: by 2002:a05:600c:4e14:b0:4a9:18f4:925e with SMTP id 5b1f17b1804b1-4b6df8c9443mr32392275e9.18.1793962115177;
        Fri, 06 Nov 2026 02:48:35 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3232248f8f.11.2026.11.06.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:48:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/4] perf tools: LLVM dwarf and flaky test fixes
Date: Fri, 06 Nov 2026 10:48:06 +0000
Message-Id: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaw7WoC/3WNTQ6CMBBGr0Jm7Zi2WFBW3sOwKDBAiVLSqURDu
 LsF49Lly/fzFmDylhiKZAFPs2XrxgjqkEDdm7EjtE1kUEJlUooTDuZBjBP5FgNxwNa+Ire5Upn
 WqWykgbidPO1BnN7KL/OzGqgO29nW6C0H59+7eJZb7+fQfxyzRIGiUvmlItLnVFzvdjTeHZ3vo
 FzX9QOtSMu4zQAAAA==
X-Change-ID: 20261104-james-perf-test-fixes-f72265531d1a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Running the tests on an LLVM build results in some dwarf issues that
need fixing. And there is an easy fix for some flakiness caused when
tests are run in parallel.

Assisted by Claude Opus 5.5

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v2:
- Break perf probe line (Namhyung)
- Use a software event instead of cycles for VM compatibility (Namhyung)
- Link to v1: https://patch.msgid.link/20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org

---
James Clark (4):
      perf libdw: Find the CU by iterating all CUs when aranges are missing
      perf dwarf-aux: Support DW_OP_addrx locations for global variables
      perf test probe_vfs_getname: Fix missing debuginfo detection
      perf test: Don't starve per-process tests with system-wide events

 tools/perf/tests/shell/lib/probe_vfs_getname.sh |  6 ++-
 tools/perf/tests/shell/record.sh                |  6 +--
 tools/perf/tests/shell/record_lbr.sh            |  2 +-
 tools/perf/tests/shell/record_sideband.sh       |  4 +-
 tools/perf/util/annotate-data.c                 | 27 +---------
 tools/perf/util/dwarf-aux.c                     | 70 ++++++++++++++++++++++---
 tools/perf/util/dwarf-aux.h                     |  3 ++
 tools/perf/util/libdw.c                         | 19 +++----
 8 files changed, 89 insertions(+), 48 deletions(-)
---
base-commit: 29fd95dbd25cda35ac1e38d096a85809e952274b
change-id: 20261104-james-perf-test-fixes-f72265531d1a

Best regards,
--  
James Clark <james.clark@linaro.org>

