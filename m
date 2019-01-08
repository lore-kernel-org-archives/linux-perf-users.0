From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: perf trace syscall table generation for powerpc with syscall.tbl
Date: Tue, 8 Jan 2019 14:04:40 -0300
Message-ID: <20190108170440.GF28965@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Thomas Richter <tmricht@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Ravi,

	I noticed that in:

  commit ab66dcc76d6ab8fae9d69d149ae38c42605e7fc5
  Author: Firoz Khan <firoz.khan@linaro.org>
  Date:   Mon Dec 17 16:10:36 2018 +0530

    powerpc: generate uapi header and system call table files

powerpc now generates its syscall tables headers from a syscall.tbl just
like x86 and s390, could you please switch to using it, taking the x86
and s390 scripts as a starting point, then test on your systems
everything works?

Thanks,

- Arnaldo
