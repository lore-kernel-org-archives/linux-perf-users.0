Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619434DB7B;
	Mon, 13 Jul 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965642; cv=none; b=q/WFV4ZBEAaBgiVWVkUevd8tsqk2/RrynT6s2afTSIga+da4dv9ERgmwmmMso4Bt/Bb4CNzXNYFRAb70ePho1dqamTqO/H/eEn5ItPGDmZcIp3HuK4/fFZKVCzBaHZGqz11+xNFNcpb1A71LF1NR2qyhb6uNuj4AEEzfHEXluTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965642; c=relaxed/simple;
	bh=eVPlSXGFM3IbaP998uV7x/zfr/eEupXGcPHd5tsKxYs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TT2+yzwMVpYVuEfGR7O6mHCmJMjd7tSTGu4vOiCFTgovw3rdMsbKvj9Y+a+6/uey74y25pIbhEsy9hFubhFayq9dRrDgU/1dLGAYHtbXLR/mhv1SqrWmapDxm82+qz/4i2tD0DMfbe+eE+MXVAS5xOChFk7D7gmwTGvju617ZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QtyVbW5C; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QtyVbW5C"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4468E1570;
	Mon, 13 Jul 2026 11:00:34 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524443F7D8;
	Mon, 13 Jul 2026 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783965638; bh=eVPlSXGFM3IbaP998uV7x/zfr/eEupXGcPHd5tsKxYs=;
	h=From:Subject:Date:To:Cc:From;
	b=QtyVbW5CwNxCOYUr1FJ6dQ/5CkxBxaEyBA7ZxNOJ+QZKJNMzu/rZDq22CLGYEzk3h
	 jzoEUOoemx2k+1pKEewVztlOTDU3yNnXeHQMz6cQ2v7259YbfldJGJ+Iocwktj4pWD
	 uvc5Z2puaENW+Gq98V1iK1mwklwVIoRKoPrhXLEI=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf cs-etm: Fix bogus branch samples
Date: Mon, 13 Jul 2026 19:00:26 +0100
Message-Id: <20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALonVWoC/x2MXQqDMBAGryL73ECiaQNeRcriz5d2KV0lERHEu
 xt8HJiZgzKSIFNbHZSwSZZZC7hHReO31w+MTIWptvXLBteYBSnymBnrn6PsrLPy2v+g5jn4KcT
 QRO9ApV8SinC/u/d5XijQTrxrAAAA
X-Change-ID: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783965636; l=912;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=eVPlSXGFM3IbaP998uV7x/zfr/eEupXGcPHd5tsKxYs=;
 b=QP36DFn6MqmhK04qZo+pyM3SNBnFpub3G1FhEkek2YDWFP66faq1XNyEa281MyM07NZq82V3n
 lQnBRuBaGN6Bd2fGDBC03n4xHizuCvV3k2u8H074aF+r1KvxrgVtt+B
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series fixes the bogus branch samples in the CoreSight ETM trace.

When an interrupt occurs immediately after an untaken branch, the
decoder incorrectly synthesizes a branch sample for that branch.
The first patch fixes this issue.

The second patch consolidate the branch check so make sure the flush
flow to apply the same check to avoid generate bogus samples.

The series has been verified on Orion6 board.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      perf cs-etm: Avoid bogus branch samples before async exceptions
      perf cs-etm: Centralize branch sample checks

 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)
---
base-commit: ef3af1df4f3372bd8ad47619452a283048b3bc8d
change-id: 20260713-perf_cs_etm_fix_non_taken-5b4d7f73f41e

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

