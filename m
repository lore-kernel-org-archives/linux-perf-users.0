From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 3/3] tools include uapi bpf.h: Sync kernel ABI header with tooling header
Date: Tue, 10 Oct 2017 12:26:57 -0300
Message-ID: <20171010152657.27435-4-acme@kernel.org>
References: <20171010152657.27435-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010152657.27435-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@fb.com>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Silences the checker:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

The 90caccdd8cc0 ("bpf: fix bpf_tail_call() x64 JIT") cset only updated
a comment in uapi/bpf.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-rwx2cqbf0x1lwa1krsr6e6hd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 43ab5c402f98..f90860d1f897 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -312,7 +312,7 @@ union bpf_attr {
  *     jump into another BPF program
  *     @ctx: context pointer passed to next program
  *     @prog_array_map: pointer to map which type is BPF_MAP_TYPE_PROG_ARRAY
- *     @index: index inside array that selects specific program to run
+ *     @index: 32-bit index inside array that selects specific program to run
  *     Return: 0 on success or negative error
  *
  * int bpf_clone_redirect(skb, ifindex, flags)
-- 
2.13.6
