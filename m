Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E57222154F;
	Fri, 20 Jun 2025 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454683; cv=none; b=dFXSOntHG26BhQ7wNfALG6S43noPOdfDzY9yeW/Q3WBBzFx+GiTD8J/UXGtexzG3s98KRF7rzqxWOr9DVnxnF63fhridaqqh0+3erorCEaIdK1qTk8kxdXpahARa4OC23w96kLbb6GqzjYfXGRlBw5D3v0Fcft+V2dtoaoLdflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454683; c=relaxed/simple;
	bh=T53V69It3nS2qxIFma71UB3Nabwl81FR7FCLU8hjnkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBGkR5vH8ZECd7PvMeXqG7EQJ6wOye77PtDx6VCBE5mhTYZhYD2SLoH01Y2SrDEqivRPLgwIdABCscBEHaSlaqwpISyfgGe+PUFY7rDjgF7JjfLNwrBigO9phO1nk1sVZZ+fOCg8DwmB5f4O56ZrwTTdZOQ0K2pjRm7we9Uijik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lppxgdbu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lppxgdbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58344C4CEE3;
	Fri, 20 Jun 2025 21:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750454682;
	bh=T53V69It3nS2qxIFma71UB3Nabwl81FR7FCLU8hjnkQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LppxgdbuBI5+XgFisIecnDPydEJGV/1J8feluWZm9BduFC77CdVbPTJ2cer5b+ppl
	 dzR6+bJ1R0eoJh0HWqN0LHjqnkIF1rnpqhsAqEgjAVhIS/GdP2OlcgiIpymcJY5fX2
	 4NUhG5QVKLrkuDj0EMyZ1KtfVjnLdiA/ybN+KdRwgcQ03RHYnGY0E2FAwCmhWk++ls
	 vQQHaa24Z/KMN3NjOk4BCX7jz46GFyw1mZYWe3mikPIEvtU0ikxTASsrgiG0+L8y5t
	 chQ13twj7OG3HPUFPN90u2O9CH/4R3qNzytqXxHoahHm1OgyAj8sS733yH4AUAyqY3
	 aim0I381bAL3g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Junhao He <hejunhao3@huawei.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: [PATCH 0/3] perf tools build process cleanups and extra hints
Date: Fri, 20 Jun 2025 18:24:32 -0300
Message-ID: <20250620212435.93846-1-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Some simple cleanups and extra hints for the build process,

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf build: Suggest java-latest-openjdk-devel instead of old 1.8.0 one
  perf build: Add the libpfm devel fedora package name to the hint
  perf build: The bfd features are opt-in, stop testing for them by default

 tools/build/feature/test-all.c | 19 -------------------
 tools/perf/Makefile.config     |  9 +++++++--
 2 files changed, 7 insertions(+), 21 deletions(-)

-- 
2.49.0

