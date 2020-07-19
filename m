From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf/urgent improvements and fixes
Date: Sun, 19 Jul 2020 10:02:05 -0300
Message-ID: <20200719130205.2430019-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 8882572675c1bb1cc544f4e229a11661f1fc52e4:

  Merge tag 'drm-fixes-2020-07-17-1' of git://anongit.freedesktop.org/drm/drm into master (2020-07-16 21:39:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-07-19

for you to fetch changes up to 25d4e7f513d4f8afcf81cb6f00edf1248b0ff8fc:

  tools arch kvm: Sync kvm headers with the kernel sources (2020-07-17 09:39:16 -0300)

----------------------------------------------------------------
Third batch of perf tooling fixes for 5.8:

- Update hashmap.h from libbpf and kvm.h from x86's kernel UAPI,
  silencing build warnings.

- Set opt->set in libsubcmd's OPT_CALLBACK_SET(). Fixes
  'perf record --switch-output-event event-name' usage.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Arnaldo Carvalho de Melo (2):
  perf tools: Sync hashmap.h with libbpf's
  tools arch kvm: Sync kvm headers with the kernel sources

Ravi Bangoria (1):
  libsubcmd: Fix OPT_CALLBACK_SET()

 tools/arch/x86/include/uapi/asm/kvm.h |  5 +++--
 tools/lib/subcmd/parse-options.c      |  3 +++
 tools/perf/util/hashmap.h             | 12 ++++++++----
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.26.2
