Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFDF38E100;
	Tue, 23 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198200; cv=none; b=KXSoHOZGMBrKqVtl+mF56ykZLRSzIkI4H4dBN9OdeLcVPqynFnpaXfqtofw3XMWEq9nKFN9BJtGBHsWMkHD6axOGnlKyJNSxy2gmxBcxgK1diUb2dLwePR7pk4XsaCd5EekgYQZ2jJ09tST947P2Gt2J6trRPaO1Na38keCvqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198200; c=relaxed/simple;
	bh=H+KttiEIC1B4uLMhcP3ut18s+DSeqCC9X3zeAxubtnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gj+NBUwH+6CaqOx2IAS39bOKjCSDswba1MAr9+ngJ+o28y8iB6xqiaR2Tp7VogTmZURm2LqNLvP7QhLi1otqRXq/qLsbBRauhOI1+mgcOsN34iCKd+6qr3Fq4qf2rtHmO79iT8Ma3JjZf+M4w6c7T3CkRoygOxSTdT3UckhUo8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnkgoUww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnkgoUww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078201F000E9;
	Tue, 23 Jun 2026 07:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198199;
	bh=ZsfHWNsMYZ8gEaZQqrvp0GRjTej1gYz1Jp1xE41CHZs=;
	h=From:To:Cc:Subject:Date;
	b=CnkgoUwwDGWYwNiZ1AdWqHt2e/YrKSxCDcqLI1WxGM/kuCCPhtRNC+rNDIiKKRKxl
	 8cPDawty4M7kIu6QFvxff6pudA2+bJ+j4OfO5xdNaNTkMbYUjNYtfEcphpEIw7GvAG
	 ZAPzokq5ywc3jAaSL/m3JAiwPcPHYExCtEqCiFlrt7aIYR1/RSU/H7xdU0QzS6tzBr
	 dyrA5CMtqCFWNRlNfXiu79Uo7S/0uko6ePd/TH9A2vNyjng0vI81CWrGtCrOVdqZnR
	 b/Ev8/UUE/1+RlqrLqb3/3qrc6S2Pisq2O8+anUC5FRyvU2HrzP39a2P7UIj2o7OvH
	 Sn4v2COM+CbLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 0/4] perf kvm: A small update in default arch event
Date: Tue, 23 Jun 2026 00:03:09 -0700
Message-ID: <20260623070313.55225-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Ian said there's an issue in the perf kvm record command line option parsing.
This is my attempt to address the issue and simplify the code.

Thanks,
Namhyung


Namhyung Kim (4):
  perf kvm: Factor out kvm_need_default_arch_event()
  perf kvm: Check kvm_need_default_arch_event() early
  perf kvm: Kill STRDUP_FAIL_EXIT()
  perf test: Simplify perf kvm record/report tests

 tools/perf/builtin-kvm.c                      | 71 ++++++++-----------
 tools/perf/tests/shell/kvm.sh                 |  8 +--
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     | 31 ++------
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  | 32 ++-------
 tools/perf/util/kvm-stat.c                    | 27 +++++++
 tools/perf/util/kvm-stat.h                    | 17 ++---
 6 files changed, 73 insertions(+), 113 deletions(-)

-- 
2.54.0

