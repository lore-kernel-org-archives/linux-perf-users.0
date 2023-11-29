Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359272CCB8
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPg89qL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9DEC433C8;
	Wed, 29 Nov 2023 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701272849;
	bh=va2Tar7pxnejs3M1VcAGZWrzhchuLOk49oqr393r88A=;
	h=From:To:Cc:Subject:Date:From;
	b=BPg89qL7zrSnlQbpUPKqMUHJ6XP5jT4axiCT8fXb1nUmV8APdQcnJcuIqDuBfUJNX
	 QpgWwk7pw0SNDGOC/ZnNmVEdSG7K7eikvlGGD8HGSZPp4J8pH8Ocy/LnhkuGTYthlY
	 cAxFqHk7w+o87epGY5B+WTHJ3HyAWeGVIv6R8DUKk8YgWrgSG/b7s8x1jnMTBvkFg/
	 n3uLM7K4PnmSuaOIq+MGDUZ+6iFajMDJ3OBnM9ZJhdaF1d32nmoeHwrcCSAsLUhtNT
	 qFcy2WMQ3qtstEmYc07HpiYibj8sEkoGSN1hg4yzwBCR53DTbAA7lFq2RNKKeAXdYt
	 HhmFyGXOSziJA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marco Elver <elver@google.com>,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] Skip the 'perf test sigtrap' on kernels with sleepable spinlocks
Date: Wed, 29 Nov 2023 12:47:16 -0300
Message-ID: <20231129154718.326330-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Please take a look,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf test sigtrap: Generalize the BTF routine to reuse it in this test
  perf tests sigtrap: Skip if running on a kernel with sleepable
    spinlocks

 tools/perf/tests/sigtrap.c | 106 +++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 22 deletions(-)

-- 
2.41.0

