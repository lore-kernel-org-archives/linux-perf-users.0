From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 5/7] tools headers uapi: Update tools's copy of linux/vhost.h
Date: Wed, 12 Sep 2018 15:55:07 -0300
Message-ID: <20180912185509.32187-6-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, "David S . Miller" <davem@davemloft.net>, Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

	c48300c92ad9 ("vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request definition")

This makes 'perf trace' and other tools in the future using its
beautifiers in a libbeauty.so library be able to translate these new
ioctl to strings:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh  > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2018-09-11 13:10:57.923038244 -0300
  +++ /tmp/after	2018-09-11 13:11:20.329012685 -0300
  @@ -15,6 +15,7 @@
        [0x22] = "SET_VRING_ERR",
        [0x23] = "SET_VRING_BUSYLOOP_TIMEOUT",
        [0x24] = "GET_VRING_BUSYLOOP_TIMEOUT",
  +     [0x25] = "SET_BACKEND_FEATURES",
        [0x30] = "NET_SET_BACKEND",
        [0x40] = "SCSI_SET_ENDPOINT",
        [0x41] = "SCSI_CLEAR_ENDPOINT",
  @@ -27,4 +28,5 @@
   static const char *vhost_virtio_ioctl_read_cmds[] = {
        [0x00] = "GET_FEATURES",
        [0x12] = "GET_VRING_BASE",
  +	[0x26] = "GET_BACKEND_FEATURES",
  };
  $

We'll also use this to be able to express syscall filters using symbolic
these symbolic names, something like:

	# perf trace --all-cpus -e ioctl(cmd=*GET_FEATURES)

This silences the following warning during perf's build:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-35x71oei2hdui9u0tarpimbq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index c51f8e5cc608..84c3de89696a 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -65,6 +65,7 @@ struct vhost_iotlb_msg {
 };
 
 #define VHOST_IOTLB_MSG 0x1
+#define VHOST_IOTLB_MSG_V2 0x2
 
 struct vhost_msg {
 	int type;
@@ -74,6 +75,15 @@ struct vhost_msg {
 	};
 };
 
+struct vhost_msg_v2 {
+	__u32 type;
+	__u32 reserved;
+	union {
+		struct vhost_iotlb_msg iotlb;
+		__u8 padding[64];
+	};
+};
+
 struct vhost_memory_region {
 	__u64 guest_phys_addr;
 	__u64 memory_size; /* bytes */
@@ -160,6 +170,14 @@ struct vhost_memory {
 #define VHOST_GET_VRING_BUSYLOOP_TIMEOUT _IOW(VHOST_VIRTIO, 0x24,	\
 					 struct vhost_vring_state)
 
+/* Set or get vhost backend capability */
+
+/* Use message type V2 */
+#define VHOST_BACKEND_F_IOTLB_MSG_V2 0x1
+
+#define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
+#define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
-- 
2.14.4
