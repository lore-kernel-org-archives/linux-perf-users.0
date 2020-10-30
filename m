From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tools changes for v5.10: 2nd batch
Date: Fri, 30 Oct 2020 15:59:08 -0300
Message-ID: <20201030185908.20611-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Dengcheng Zhu <dzhu@wavecomp.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, "Justin M . Forbes" <jforbes@fedoraproject.org>, Leo Yan <leo.yan@linaro.org>, Peng Fan <fanpeng@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Stanislav Ivanichkin <sivanichkin@yandex-team.ru>, Tommi Rantala <tommi.t.rantala@nokia.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit 7cf726a59435301046250c42131554d9ccc566b8:

  Merge tag 'linux-kselftest-kunit-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2020-10-18 14:45:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-10-30

for you to fetch changes up to 7b3bcedf5ee50ca9b0ec74003e14ccbd088408d1:

  perf scripting python: Avoid declaring function pointers with a visibility attribute (2020-10-30 08:35:16 -0300)

----------------------------------------------------------------
perf tools updates for v5.10: 2nd batch.

- Update documentation about CAP_PERFMON.

- Add --quiet option to 'perf stat record'.

- Update kernel header copies.

- Do not compile BPF specific code if libbpf isn't available.

- Fix visibility attribute in python module init code with newer gcc.

- Add perf arch instructions annotate handlers for MIPS.

- Show in 'perf version' if libpfm4 is linked in.

- Fix DRAM_BW_Use 0 issue for CLX/SKX in intel JSON vendor event files.

- Add test for JSON defined arch std events.

- Fix the build on new fedora by removing LTO compiler options when
  building perl support.

- Improve warning if no memory nodes are detected.

- Make 'perf test tsc' present in arm64.

- Support regex pattern in --for-each-cgroup in 'perf stat'.

- Remove broken __no_tail_call attribute.

- Add kvm-stat for arm64.

- Fix segfault when trying to trace events by cgroup.

- Fix crash with non-jited BPF progs

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results on the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-for-v5.10-2020-10-30
