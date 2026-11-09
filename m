Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219451;
	b=dI4gz3dYfFNb94bSKF6mTk5cihPqBWob8AjDhTm9kMoFebBuivLfF2h4OfrVw68IDh5J
	 s7/9DdM7ofpZHHlSu3VQQmOSth1nwrokO3CQJ0/kjYrTGV7lrquq5zXAP81457DmamOhG
	 00FMSpfRQQ2t0eiGS74gQD8en2ueZJpgBAIeFvlDrX/MHA9r0qe2zFVS5jAxXu4C8NpLa
	 rrfNoNRlMyhBkRZqbEt2dOFlwEDFEkZrPi5Eo+eummFvMFbpn4LC5OyMdbVL8FPN3CO6P
	 98IrrWOoLEMAz+ZcY+0p+lbzCXtwItdpD458Oyv0/fGphC3UmSF1MWrl6UrroK83RJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=TJaSvhKXpOs4hPW+qhrc6bZ76dM2q6MMdsGYOHYjFdc=;
	b=2RAfSWh36jopOQ2Rarmo/RZudxbKgt36qs7JWKIvi+Z5q04MGgWQv3z2YwjW6LjKsf9u
	 idaexUZ/RxFtTID2OixSj8PpX5tm2spW9S3LySMMPhr886OrMep0dNf1sYioej3MtQ4v0
	 Z5nrehaG6fXpXJCts3P+1mjQNkggtC+X5mtZzVJAY2Xn13KNySkRDMuV8bwGvODgvX2IU
	 Lh+2rEbeHp9BeydIbnovZIjAdNqu0k+SpCQeRDJY2d/muVKUWZZ4711Ui0426lfCGoF7T
	 bswpZbgT8d4rLlWtA9sd4byi/CvBVCcVaGkbPsnGfi3wpOaEGYjnqMJSfD+9/ROpaFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jYWPiZtM;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3AF606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 10:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC3AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jYWPiZtM
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so4421305e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 02:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794219449; x=1794824249; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TJaSvhKXpOs4hPW+qhrc6bZ76dM2q6MMdsGYOHYjFdc=;
        b=jYWPiZtMTC1lB+9ahM3rmPP/S3UjVUcqZq+wKSDRfw9xU8z5bUcHf3zg+ZzIOD4+G8
         x2JstWyS8oD7Xq2AdE+5NJcGeeYXxdvhYAwKNYZ6XnEHaOXlW5FDzV2hqqqmdyzpz5GN
         3xeu9s/hssF7zfYabYFqJd3O5dZPsAGXaFd5DTHIkbJxAFnoat4N1VjvToYA+7V+iD7O
         dcl+TQsBl6itTT7g5hQcOhanKOu6+WZZ0z6eTQljil2zx54K8YZvgJk5damRfJzR54H/
         gvrcmaA+nIIKHTDQ08b6p4xZVWwp+GBLm8o22D974volh8lsKb1ktXUqsq+7EzMImENi
         QAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219449; x=1794824249;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TJaSvhKXpOs4hPW+qhrc6bZ76dM2q6MMdsGYOHYjFdc=;
        b=Yw8jU4C555fr5J4anSZfXTFHMWQd4bhkSxMhhGGXZc/MWZG7rTGXeV2Gb0EWA9ij1S
         j1Ry/F7y1j3Me8ENXt2dssYw7MsqOAWFukhpM1udGETVUwOuyqjcR0oQMZTvIjSnLruJ
         /vpJkIRirzhwKaHAALn2wHEe0mg1mx5h8LOk8UNWtl3J9PO8k+fruX4FO0MynZKXppt1
         i+RZkQEOFQsDMb9+67drlC8J/jT6s0XJj2ha7fF7KvsWV6Vobtseg5UOp6HhXvIIAWat
         MsaowlLjo/ijsnG/uRu2t3TSBTOF+qCYRaHWOHGrxD3vmbX7hV+EnyyJpCRUclStHHqT
         9WGQ==
X-Forwarded-Encrypted: i=1; AL+hErGpRjvaFzCXad/e3SHarLIJ4g8dhwAr1Y3C6kg6RUA/BMFjZCLcxoqDnFKjxV6isZHLY5EE29qQUekhcpjWi6b2@vger.kernel.org
X-Gm-Message-State: APuU4Z/D313GvGxUJKJcHpiQkKRWe5zoeeazIvGTASZrxreEcmKlLdU+
	c7fpDi/KN81sbBtbzDGkTgaBUWrzETs4sDQPhUQri6DmPdCkqEGHv27nhkA1vGTEgrY=
X-Gm-Gg: AYBFou04n92MVmigsA7fNsZ/bb9vARMVSPHOh9QY+25YU0c9EXgU7mLAbVUtTTK+uTj
	5aEELI+N8AgLOAmJedixfTZTnB2fbBE0UU7EZQwNZVLCwlP9CZiIGGKk8fqHP0SDADWQEH61RWb
	8QevmgfclxAitFWCJ54A8ki6pMhEYi0X96VoMwYmLLEa4oK761Ofu83Vc8EC3hdsB4/gbzDB7XQ
	3V6YjgDaipJGX49htUtqL/nSa9fefB8z8PqdKWDzlqFX8yIsZg4H2Gs7n2dj8JJWkxVl/7Waf+H
	mwv3BBxhv0CMok9xS+kBRwrwXkTwBV2UTmuoSFO4gKuBsVpdl/Sfps2RoeqXi171OsFvD97UC6S
	l9kpkAilyvuYfs8w/ur2NNJIYfOKm7WOUIAa6iKhHeUe/SyTMrziZipyZV7HsKn43AmrWMXeonG
	AiBf10XcmdlE1Mwuf886O9ZbsW59dLb5ADQzzStCbxqOyU8jhpZZcA5z5BPy5sT70YitNc44ZAp
	6yE10ZgvfsiuIPHTkC1lQ8dVJS2i3EySsl7J8AN7KHGA1yfdeD4O8RA4zyP8/P8j6DlFsixx0pr
	WVCpjTis8lsHK0Mju2eRepejVEhCc/Bf
X-Received: by 2002:a05:600c:c4aa:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4b963c8c64dmr68512305e9.28.1794219449235;
        Mon, 09 Nov 2026 02:17:29 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee1de2esm121575795e9.5.2026.11.09.02.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:17:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 0/4] perf tools: LLVM dwarf and flaky test fixes
Date: Mon, 09 Nov 2026 10:17:00 +0000
Message-Id: <20261109-james-perf-test-fixes-v3-0-e8d0a65e618a@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAJyd8WoC/3WNQQ6CMBBFr0K6tqYdpIAr72FcFJhCiVLS1kZDu
 LstxkQXLl9m/nsLcWg1OnLMFmIxaKfNFCHfZaQd5NQj1V1kAgwE5+xAR3lDR2e0inp0nir9iKx
 KAFEUOe+4JHE7W9wOcXq+vNndmxFbn2TpY9DOG/vcwoGnv0+j+NMInDLKGijrBrGocna66klas
 ze2JykS4Fsj/mkgampZcxACVAXwo1nX9QXIOfLcFAEAAA==
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
Changes in v3:
- Rebase to resolve new conflicts
- Link to v2: https://patch.msgid.link/20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org

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
base-commit: 13a8d580433a3b72b10be34f0e26787fe5659d3c
change-id: 20261104-james-perf-test-fixes-f72265531d1a

Best regards,
--  
James Clark <james.clark@linaro.org>

