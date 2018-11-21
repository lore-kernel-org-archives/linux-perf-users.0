From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 7/7] perf tools beauty ioctl: Support new ISO7816 commands
Date: Wed, 21 Nov 2018 11:25:05 -0300
Message-ID: <20181121142505.27379-8-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Introduced in:

  ad8c0eaa0a41 ("tty/serial_core: add ISO7816 infrastructure")

Now 'perf trace' will be able to pretty-print the 'cmd' ioctl arg when
used in capable systems with software emitting those commands.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-7bds48dhckfnleie08mit314@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 5d2a7fd8d407..eae59ad15ce3 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -31,6 +31,7 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 	"TCSETSW2", "TCSETSF2", "TIOCGRS48", "TIOCSRS485", "TIOCGPTN", "TIOCSPTLCK",
 	"TIOCGDEV", "TCSETX", "TCSETXF", "TCSETXW", "TIOCSIG", "TIOCVHANGUP", "TIOCGPKT",
 	"TIOCGPTLCK", [_IOC_NR(TIOCGEXCL)] = "TIOCGEXCL", "TIOCGPTPEER",
+	"TIOCGISO7816", "TIOCSISO7816",
 	[_IOC_NR(FIONCLEX)] = "FIONCLEX", "FIOCLEX", "FIOASYNC", "TIOCSERCONFIG",
 	"TIOCSERGWILD", "TIOCSERSWILD", "TIOCGLCKTRMIOS", "TIOCSLCKTRMIOS",
 	"TIOCSERGSTRUCT", "TIOCSERGETLSR", "TIOCSERGETMULTI", "TIOCSERSETMULTI",
-- 
2.14.5
