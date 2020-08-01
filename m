From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] Fourth batch of perf tooling fixes for v5.8
Date: Sat,  1 Aug 2020 16:06:18 -0300
Message-ID: <20200801190618.3311731-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Philippe Duplessis-Guindon <pduplessis@efficios.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Salvatore Bonaccorso <carnil@debian.org>, Thomas Richter <tmricht@linux.ibm.com>, Wei Li <liwei391@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit d8b9faec54ae4bc2fff68bcd0befa93ace8256ce:

  Merge tag 'drm-fixes-2020-07-31' of git://anongit.freedesktop.org/drm/drm (2020-07-30 21:26:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-08-01

for you to fetch changes up to 39efdd94e314336f4acbac4c07e0f37bdc3bef71:

  libtraceevent: Fix build with binutils 2.35 (2020-07-31 09:31:55 -0300)

----------------------------------------------------------------
Fourth batch of perf tooling fixes for v5.8:

- Fix libtraceevent build with binutils 2.35.

- Fix memory leak in process_dynamic_array_len in libtraceevent.

- Fix 'perf test 68' zstd compression for s390.

- Fix record failure when mixed with ARM SPE event.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Ben Hutchings (1):
      libtraceevent: Fix build with binutils 2.35

Philippe Duplessis-Guindon (1):
      tools lib traceevent: Fix memory leak in process_dynamic_array_len

Thomas Richter (1):
      perf tests: Fix test 68 zstd compression for s390

Wei Li (1):
      perf tools: Fix record failure when mixed with ARM SPE event

 tools/lib/traceevent/event-parse.c                | 1 +
 tools/lib/traceevent/plugins/Makefile             | 2 +-
 tools/perf/arch/arm/util/auxtrace.c               | 8 ++++----
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)
