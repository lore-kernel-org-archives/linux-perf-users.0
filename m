Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE41DA59
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYf4a+OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF142C433C7;
	Fri, 20 Oct 2023 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697832543;
	bh=Ut9daOcuRRD9l+ZL0uzgf+bMBQJQzFl0hfVsSHDlVRI=;
	h=From:To:Cc:Subject:Date:From;
	b=EYf4a+ORI5h5jjRlejSEcLpwemqffiv05jqD/AVDRCmAst99cs2nmaJLixh3CZAI4
	 fjVRIjsff42p1QXiyyvbD0LpAg4TWu0Ba2VOphxXXMDZiqXtuTmXZpW9ehfmRdL6FS
	 RTCMInhZBZpTUBwEUIOq76gkXLdkn6gLAtmktvCvcdQoS6qHWwfeJ3T7Pg+72RwLnV
	 7/uzMVrrW9YHxl+4aiqfQCjTcoETeotlAjJJinDqzn3gcuYz0qVDZBO8/aixImLWRR
	 0AJ720RBtjVoXZ2yA71vS5ASMx2SxX6Pb1qynnbSsX5xdmTuoCfednoDxNsOI2K8Qm
	 50yzhH0eGiSJg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Manu Bretelle <chantr4@gmail.com>,
	Wyes Karny <wyes.karny@amd.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.6: 2nd batch
Date: Fri, 20 Oct 2023 17:08:46 -0300
Message-ID: <20231020200846.99350-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit e47749f1796d1df39a7eaae95f2784aaa43df57d:

  perf jevent: fix core dump on software events on s390 (2023-09-17 15:51:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-2-2023-10-20

for you to fetch changes up to 4fa008a2db484024a5cb52676a1b1534dc82330c:

  tools build: Fix llvm feature detection, still used by bpftool (2023-10-19 22:33:58 -0300)

----------------------------------------------------------------
perf tools fixes for v6.6: 2nd batch

- Fix regression in reading scale and unit files from sysfs for PMU
  events, so that we can use that info to pretty print instead of
  printing raw numbers:

  # perf stat -e power/energy-ram/,power/energy-gpu/ sleep 2

   Performance counter stats for 'system wide':

              1.64 Joules power/energy-ram/
              0.20 Joules power/energy-gpu/

       2.001228914 seconds time elapsed
  #
  # grep -m1 "model name" /proc/cpuinfo
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  #

- The small llvm.cpp file used to check if the llvm devel files are present was
  incorrectly deleted when removing the BPF event in 'perf trace', put it back
  as it is also used by tools/bpf/bpftool, that uses llvm routines to do
  disassembly of BPF object files.

- Fix use of addr_location__exit() in dlfilter__object_code(), making sure that
  it is only used to pair a previous addr_location__init() call.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()
      perf dlfilter: Add a test for object_code()

Arnaldo Carvalho de Melo (1):
      tools build: Fix llvm feature detection, still used by bpftool

Wyes Karny (1):
      perf pmu: Fix perf stat output with correct scale and unit

 tools/build/feature/test-llvm.cpp           | 14 +++++++++++++
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 12 ++++++++++-
 tools/perf/dlfilters/dlfilter-test-api-v2.c | 12 ++++++++++-
 tools/perf/util/dlfilter.c                  | 32 ++++++++++++++---------------
 tools/perf/util/pmu.c                       |  8 ++++----
 5 files changed, 55 insertions(+), 23 deletions(-)
 create mode 100644 tools/build/feature/test-llvm.cpp
