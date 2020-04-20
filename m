From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/60] perf machine: Set ksymbol dso as loaded on arrival
Date: Mon, 20 Apr 2020 08:52:19 -0300
Message-ID: <20200420115316.18781-4-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, =?UTF-8?q?Bj=C3=83=C2=B6rn=20T=C3=83=C2=B6pel?= <bjorn.topel@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, "David S . Miller" <davem@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no special load action for ksymbol data on map__load/dso__load
action, where the kernel is getting loaded. It only gets confused with
kernel kallsyms/vmlinux load for bpf object, which fails and could mess
up with the map.

Disabling any further load of the map for ksymbol related dso/map.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andriin@fb.com>
Cc: BjÃ¶rn TÃ¶pel <bjorn.topel@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20200312195610.346362-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 97142e9671be..06aa4e4db63d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -759,6 +759,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+		dso__set_loaded(dso);
 	}
 
 	sym = symbol__new(map->map_ip(map, map->start),
-- 
2.21.1
