Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D257882
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Dec 2023 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ch12lXcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2304CC433C7;
	Fri,  1 Dec 2023 20:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701462653;
	bh=oYvbCsefC5KwoaF4UMSezCq8AouWW9D3M0cUHQKQjZI=;
	h=From:To:Cc:Subject:Date:From;
	b=ch12lXcNqhMroaWVCJExuQeZiV/Ju0LjE1Wb4NQv1YipJlFnDOjE6hRuBdrFBOUuL
	 zozYHRK+Z0ctoILkMP3f0RDRfT5sF5qCbbU7tlfRGb1J7oxNI4dUGv8p4C/2C14vLB
	 drnVuHtybSHE1LoDIR5R13JrhI7ZCXMvS3E+IeXUbeACWaAZk7WE+XiInExX+Mp9A1
	 AHJvEJYgZXQQp1rQlg4puYCdT6/O/I9gjlMNdwOxabn3SEnuNRic9B212AaAwGhOGV
	 db8kDoequT1mu48kA9xQ+JsAcfE5Khq80G5AMrZmHB6Yay9ZnEthNzOdQT4RyhuNN1
	 MaapTknfSS07A==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/2] Cache the arch specific stderrno routine
Date: Fri,  1 Dec 2023 17:30:44 -0300
Message-ID: <20231201203046.486596-1-acme@kernel.org>
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
  perf env: Introduce perf_env__arch_strerrno()
  perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()

 tools/perf/builtin-trace.c                  | 6 ++----
 tools/perf/trace/beauty/arch_errno_names.sh | 6 +++---
 tools/perf/trace/beauty/beauty.h            | 2 --
 tools/perf/util/env.c                       | 9 +++++++++
 tools/perf/util/env.h                       | 6 ++++++
 5 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.41.0

