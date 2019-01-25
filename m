From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/29] perf bpf: Add bpf_map() helper
Date: Sat, 26 Jan 2019 00:18:38 +0100
Message-ID: <20190125231843.2895-25-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To make the declaration of maps more compact, the following patches will
make use of it.

Standardizing on it will allow to add the BTF details, i.e.
BPF_ANNOTATE_KV_PAIR() (tools/testing/selftests/bpf/bpf_helpers.h)
transparently.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-h3q9rxxkbzetgnbro5rclqft@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index e667577207dc..0482028c1d11 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -18,6 +18,14 @@ struct bpf_map {
         unsigned int numa_node;
 };
 
+#define bpf_map(name, _type, type_key, type_val, _max_entries)	\
+struct bpf_map SEC("maps") name = {				\
+	.type	     = BPF_MAP_TYPE_##_type,			\
+	.key_size    = sizeof(type_key),			\
+	.value_size  = sizeof(type_val),			\
+	.max_entries = _max_entries,				\
+}
+
 /*
  * FIXME: this should receive .max_entries as a parameter, as careful
  *	  tuning of these limits is needed to avoid hitting limits that
-- 
2.20.1
