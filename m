From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC 0/2] tools/build/ patches to allow setting NO_SYSCALL_TABLE=1 from make command line
Date: Fri, 29 May 2020 12:55:50 -0300
Message-ID: <20200529155552.463-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Jiri,

	Can you please take a look if these are ok? I've tested it
extensively, but being Makefiles, I may be missing something... There
are more patches on top of these in the tmp.perf/core branch in my tree,
if you could take a quick look on those, that would be great as well.
The one that makes libaudit not be tested by default, for instace.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf build: Group the NO_SYSCALL_TABLE logic
  perf build: Allow explicitely disabling the NO_SYSCALL_TABLE variable

 tools/perf/Makefile.config | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.25.3
