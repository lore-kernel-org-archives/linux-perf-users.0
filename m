Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25437FF71;
	Sun,  2 Aug 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680601; cv=none; b=ENSxVYsW2s1hsPshHHo2m2KfuaFu3Ei4NDP5rkuMSnfOH352VKTTHdUwocADLdr5xE2e5vkDItLPKqDOj7py38yM5vDC4owdhf/xKhkRa6o16lvgReYwzIeeMPLQyfvSG7WR5+2waAsQ8rCmsmygmDYb4NlQZ1kxq0BI6nNeyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680601; c=relaxed/simple;
	bh=d+ZNm9hiwSOZYpCS8xyJKRpJmLcOoocIbLecFnbJyoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CJmTIvgxnwPKqe0pblsjPOotQGHp+WkPfzRSMBdO6Y3PbHtK7ks9YqExW8E5tkpnhYMpAmmBn+cZy6kUOgBIMsR95XXcmIHdQvt1mKVmL8EgrRkvWiIbZU+T+G0DYjU69UhidOpbBir9tRfSuFgMSU/0G8Gb/vka91096wM0LEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxWBoez1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxWBoez1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84661F000E9;
	Sun,  2 Aug 2026 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680599;
	bh=mLg6KGpnsEyKDx5qVd78oTY6JWx2TlI5iZc8yzHwcvY=;
	h=From:To:Cc:Subject:Date;
	b=JxWBoez1YwHcakDZPRHM7l9p2KvIeB1qOpERj2kMf6KEvoZx7PsOe+qq+P5DuvtXr
	 LZtk1W9kZYHM2XkN9OdFYDECQ5JjEF37N5selLQ1CvbdYJQeFEV500KhWWnIoLqVhU
	 zg4lnvNIUVFp9S2mpgpfEOJHmA0V9E6wJJ50dJMkdtPYPvnWLD1SimF/XlJAwkjubF
	 E5JQy1bOU5mvZ9lYp7/wfCTiJIK+aWgABYKRC5BOX8bCTw57Pc9o3+3LzMo3XwtfG4
	 6autifAcwEqOLpIrCMbWXVUS9lMKS3yexxtvYZcz+qhAapmCGAWUVN0LUp/L5WTSTG
	 nMXb48hfiTLjg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 0/2] perf c2c hardening
Date: Sun,  2 Aug 2026 11:23:11 -0300
Message-ID: <20260802142313.154514-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	Please consider merging,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf c2c: Fix error masking and OOM handling in hpp_list__parse()
  perf c2c: Clean up registered formats on c2c_hists__init() failure

 tools/perf/builtin-c2c.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

-- 
2.55.0

