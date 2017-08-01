From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 07/18] tools headers: Fixup tools/include/uapi/linux/bpf.h copy of kernel ABI header
Date: Tue,  1 Aug 2017 16:56:34 -0300
Message-ID: <20170801195645.16986-8-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 04df41e343db ("bpf: update tools/include/uapi/linux/bpf.h") the files
added in 40304b2a1567 ("bpf: BPF support for sock_ops") were added to
tools/include, but not in a verbatim way, missing the comments, which
ends up triggering this warning when build tools/perf/:

  make: Entering directory '/home/acme/git/linux/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
  Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'

Make sure the the lines are equal, to fix the simple header copy
drift detector in tools/perf/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Lawrence Brakmo <brakmo@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 04df41e343db ("bpf: update tools/include/uapi/linux/bpf.h")
Link: http://lkml.kernel.org/n/tip-z9qyyqht9qq3yyxu76sfy0dh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bpf.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8ff155ffcd84..e99e3e6f8b37 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -750,6 +750,8 @@ struct bpf_map_info {
 
 /* User bpf_sock_ops struct to access socket values and specify request ops
  * and their replies.
+ * Some of this fields are in network (bigendian) byte order and may need
+ * to be converted before use (bpf_ntohl() defined in samples/bpf/bpf_endian.h).
  * New fields can only be added at the end of this structure
  */
 struct bpf_sock_ops {
@@ -759,12 +761,12 @@ struct bpf_sock_ops {
 		__u32 replylong[4];
 	};
 	__u32 family;
-	__u32 remote_ip4;
-	__u32 local_ip4;
-	__u32 remote_ip6[4];
-	__u32 local_ip6[4];
-	__u32 remote_port;
-	__u32 local_port;
+	__u32 remote_ip4;	/* Stored in network byte order */
+	__u32 local_ip4;	/* Stored in network byte order */
+	__u32 remote_ip6[4];	/* Stored in network byte order */
+	__u32 local_ip6[4];	/* Stored in network byte order */
+	__u32 remote_port;	/* Stored in network byte order */
+	__u32 local_port;	/* stored in host byte order */
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.9.4
