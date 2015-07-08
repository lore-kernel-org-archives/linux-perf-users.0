From: Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] perf stat: Fix shadow declaration of close
Date: Wed, 8 Jul 2015 13:17:31 +0200
Message-ID: <20150708111731.GA3512@krava.redhat.com>
References: <CAHTgTXWecD6LoDRt4a5gJ385GULuhyB6YaK6iMNh=YW9cCkiZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHTgTXWecD6LoDRt4a5gJ385GULuhyB6YaK6iMNh=YW9cCkiZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jul 07, 2015 at 11:01:25AM -0700, Vinson Lee wrote:
> Hi.
>=20
> 4.2-rc1 commit 106a94a0f8c207ef4113ce7e32f34a00b3b174e7 "perf stat:
> Introduce read_counters function" introduced a build error with older
> toolchains.
>=20
> This is the build error on CentOS 6.
>=20
>   CC       builtin-stat.o
> cc1: warnings being treated as errors
> builtin-stat.c: In function =E2=80=98read_counters=E2=80=99:
> builtin-stat.c:346: error: declaration of =E2=80=98close=E2=80=99 sha=
dows a global declaration
> /usr/include/unistd.h:350: error: shadowed declaration is here

hi,
oops, sry.. patch attached

thanks,
jirka


---
Vinson reported shadow declaration of close introduced
by following commit:
106a94a0f8c2 perf stat: Introduce read_counters function

Using close_counters name instead.

Reported-by: Vinson Lee <vlee@twopensource.com>
Link: http://lkml.kernel.org/n/tip-x4029j7ktlsxr0tnoontt4l8@git.kernel.=
org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index de9577503ea6..2c9edd22e6e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -297,7 +297,7 @@ static int read_counter(struct perf_evsel *counter)
 	return 0;
 }
=20
-static void read_counters(bool close)
+static void read_counters(bool close_counters)
 {
 	struct perf_evsel *counter;
=20
@@ -308,7 +308,7 @@ static void read_counters(bool close)
 		if (perf_stat_process_counter(&stat_config, counter))
 			pr_warning("failed to process counter %s\n", counter->name);
=20
-		if (close) {
+		if (close_counters) {
 			perf_evsel__close_fd(counter, perf_evsel__nr_cpus(counter),
 					     thread_map__nr(evsel_list->threads));
 		}
--=20
2.4.3
