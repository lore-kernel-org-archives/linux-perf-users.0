From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 1/2] perf script: allow extended console debug output
Date: Sun, 21 Oct 2018 21:14:23 +0200
Message-ID: <20181021191424.16183-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@kernel.org
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>
List-Id: linux-perf-users.vger.kernel.org

The script tool isn't using a browser, yet use_browser
wasn't set explicitly to zero. This in turn lead to confusing
output such as:

```
$ perf script -vvv ...
...
overlapping maps in /home/milian/foobar (disable tui for more info)
...
```

Explicitly set use_browser to 0 now, which gives us the extended
debug information now in perf script as expected.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4da5e32b9e03..bd468b90801b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
 		exit(-1);
 	}
=20
-	if (!script_name)
+	if (!script_name) {
 		setup_pager();
+		use_browser =3D 0;
+	}
=20
 	session =3D perf_session__new(&data, false, &script.tool);
 	if (session =3D=3D NULL)
--=20
2.19.1
