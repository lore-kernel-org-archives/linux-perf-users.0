Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D121A070E;
	Fri, 11 Oct 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666902; cv=none; b=CQnW7iTqc0cIpqPn7NUEpNH3rZ6K9peInHAp8OuS3siVo7Y+/RhFX9kGparF+PBsRMEkoIC7e1xFJSFcvhVduEsT+Tlk3dHJ95hmeDhUUnz0OPAF28lSqhzpFPbfogw2XbHojbIbA2A3jZNdW3ayRyfQZO0TmGn3eSrhpvlmfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666902; c=relaxed/simple;
	bh=Jpqzmj1nH3w4HcUwo5OcakLWRkzESKC/YwbjEzVfC/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hEzMhiUMVKFKAJr5dwfSc4QQTXApIH3uYbEDPmMd5WPPcxm2zKSmZlRPfDfMeDDRwHqc5fHBMb6pDxOBAlWL/jEq8wiFiQtZx2RceFuSTt4pmkYEyX8Rykn8FsxPWrZT69To2t+FaFMCKV5UTxyiG8CUtygg/ZB1jQsf8zlbZlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9fNioRu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9fNioRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D72C4CEC3;
	Fri, 11 Oct 2024 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728666901;
	bh=Jpqzmj1nH3w4HcUwo5OcakLWRkzESKC/YwbjEzVfC/w=;
	h=From:To:Cc:Subject:Date:From;
	b=r9fNioRuN6CVntgpWdGZXPb+MmCke3Kd917lDBDl+l9Jcj+LKaMsn+ndaxdhAwgYW
	 4Ql2n0dvdEuLzOvYZcSQrF+UCu1macfqMbYx+4uk05yt3NKAcDyhWT6mGps1RFSwoE
	 4PunQWwAlJo/W6NDarJ0f6MsRcL/wu9+zymtzkZNrnVuvi7Mxa1RF8UqOTOEVgkTqT
	 7Peai6vQGX+fb9wqPkLl21416ViTwFCczglJArZpEkQoxDY8glwJ86MDKwtTBtQMVN
	 jDkFiL4xPjDskLAQQChInO5NTveiiMOR7mFUx0K359MWGB27cQIGzn5iwElE0d0RIS
	 zvLNtofbS75rA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/3] Document the 'perf test -w' workloads functionality
Date: Fri, 11 Oct 2024 14:14:46 -0300
Message-ID: <20241011171449.1362979-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

        I noticed that the 'perf test -w' code wasn't well exposed, so
add a '-w --list' option to list the existing workloads and document it
in the 'perf test' man page.

- Arnaldo

v2:

- Use --list-workloads, as suggesed by James Clark.

- Add info in the man page about the parameters the built-in workloads
  accept.

Arnaldo Carvalho de Melo (3):
  perf test: Introduce workloads__for_each()
  perf test: Introduce '-w --list' to list the available workloads
  perf test: Document the -w/--workload option

 tools/perf/Documentation/perf-test.txt | 14 +++++++++++++
 tools/perf/tests/builtin-test.c        | 27 ++++++++++++++++++++++----
 2 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.47.0

