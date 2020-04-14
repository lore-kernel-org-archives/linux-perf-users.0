From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/15] tools include UAPI: Sync linux/vhost.h with the kernel sources
Date: Tue, 14 Apr 2020 13:48:47 -0300
Message-ID: <20200414164854.26026-9-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  4c8cf31885f6 ("vhost: introduce vDPA-based backend")

Silencing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/vhost.h' differs from latest version at 'include/uapi/linux/vhost.h'
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h

This automatically picks these new ioctls, making tools such as 'perf
trace' aware of them and possibly allowing to use the strings in
filters, etc:

  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > before
  $ cp include/uapi/linux/vhost.h tools/include/uapi/linux/vhost.h
  $ tools/perf/trace/beauty/vhost_virtio_ioctl.sh > after
  $ diff -u before after
  --- before	2020-04-14 09:12:28.559748968 -0300
  +++ after	2020-04-14 09:12:38.781696242 -0300
  @@ -24,9 +24,16 @@
   	[0x44] = "SCSI_GET_EVENTS_MISSED",
   	[0x60] = "VSOCK_SET_GUEST_CID",
   	[0x61] = "VSOCK_SET_RUNNING",
  +	[0x72] = "VDPA_SET_STATUS",
  +	[0x74] = "VDPA_SET_CONFIG",
  +	[0x75] = "VDPA_SET_VRING_ENABLE",
   };
   static const char *vhost_virtio_ioctl_read_cmds[] = {
   	[0x00] = "GET_FEATURES",
   	[0x12] = "GET_VRING_BASE",
   	[0x26] = "GET_BACKEND_FEATURES",
  +	[0x70] = "VDPA_GET_DEVICE_ID",
  +	[0x71] = "VDPA_GET_STATUS",
  +	[0x73] = "VDPA_GET_CONFIG",
  +	[0x76] = "VDPA_GET_VRING_NUM",
   };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/vhost.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/include/uapi/linux/vhost.h b/tools/include/uapi/linux/vhost.h
index 40d028eed645..9fe72e4b1373 100644
--- a/tools/include/uapi/linux/vhost.h
+++ b/tools/include/uapi/linux/vhost.h
@@ -116,4 +116,28 @@
 #define VHOST_VSOCK_SET_GUEST_CID	_IOW(VHOST_VIRTIO, 0x60, __u64)
 #define VHOST_VSOCK_SET_RUNNING		_IOW(VHOST_VIRTIO, 0x61, int)
 
+/* VHOST_VDPA specific defines */
+
+/* Get the device id. The device ids follow the same definition of
+ * the device id defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_DEVICE_ID	_IOR(VHOST_VIRTIO, 0x70, __u32)
+/* Get and set the status. The status bits follow the same definition
+ * of the device status defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_STATUS		_IOR(VHOST_VIRTIO, 0x71, __u8)
+#define VHOST_VDPA_SET_STATUS		_IOW(VHOST_VIRTIO, 0x72, __u8)
+/* Get and set the device config. The device config follows the same
+ * definition of the device config defined in virtio-spec.
+ */
+#define VHOST_VDPA_GET_CONFIG		_IOR(VHOST_VIRTIO, 0x73, \
+					     struct vhost_vdpa_config)
+#define VHOST_VDPA_SET_CONFIG		_IOW(VHOST_VIRTIO, 0x74, \
+					     struct vhost_vdpa_config)
+/* Enable/disable the ring. */
+#define VHOST_VDPA_SET_VRING_ENABLE	_IOW(VHOST_VIRTIO, 0x75, \
+					     struct vhost_vring_state)
+/* Get the max ring size. */
+#define VHOST_VDPA_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
+
 #endif
-- 
2.21.1
