From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/18] tools headers: Fixup tools/include/uapi/linux/bpf.h copy of kernel ABI header
Date: Tue,  1 Aug 2017 16:56:31 -0300
Message-ID: <20170801195645.16986-5-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper") BPF_ADJ_ROOM_NET was
added to include/uapi/linux/bpf.h but BPF_ADJ_ROOM_NET_OPS was added to
tools/include/uapi/linux/bpf.h, making these files differ, fix it by using the
same name in both, BPF_ADJ_ROOM_NET, the one in the kernel headers copy.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 2be7e212d541 ("bpf: add bpf_skb_adjust_room helper")
Link: http://lkml.kernel.org/n/tip-2bmwovi9lymplyz6wsszppyf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ce2988be4f0e..8ff155ffcd84 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -643,7 +643,7 @@ enum bpf_func_id {
 
 /* Mode for BPF_FUNC_skb_adjust_room helper. */
 enum bpf_adj_room_mode {
-	BPF_ADJ_ROOM_NET_OPTS,
+	BPF_ADJ_ROOM_NET,
 };
 
 /* user accessible mirror of in-kernel sk_buff.
-- 
2.9.4
