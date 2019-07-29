From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/12] tools headers UAPI: Sync usbdevice_fs.h with the kernels to get new ioctl
Date: Mon, 29 Jul 2019 18:14:53 -0300
Message-ID: <20190729211456.6380-7-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  6d101f24f1dd ("USB: add usbfs ioctl to retrieve the connection parameters")

And address this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/usbdevice_fs.h' differs from latest version at 'include/uapi/linux/usbdevice_fs.h'
  diff -u tools/include/uapi/linux/usbdevice_fs.h include/uapi/linux/usbdevice_fs.h

Which ends up autogenerating a ioctl_cmd->string table used by 'perf
trace':

  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh > before
  $ cp include/uapi/linux/usbdevice_fs.h tools/include/uapi/linux/usbdevice_fs.h
  $ tools/perf/trace/beauty/usbdevfs_ioctl.sh > after
  $ diff -u before after
  --- before 2019-07-26 15:26:55.513636844 -0300
  +++ after 2019-07-26 15:29:11.650518677 -0300
  @@ -23,6 +23,7 @@
          [2] = "BULK",
          [30] = "DROP_PRIVILEGES",
          [31] = "GET_SPEED",
  +       [32] = "CONNINFO_EX",
          [3] = "RESETEP",
          [4] = "SETINTERFACE",
          [5] = "SETCONFIGURATION",
  $

Now 'perf trace' ioctl beautifier will translate this new ioctl to a
string and at some point will allow filtering the 'ioctl' syscall with
something like this in a system wide strace-like sessin:

  # perf trace -e ioctl/cmd=USBDEVFS_CONNINFO_EX/

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tkdfbgzqypwco96b309c0ovd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/usbdevice_fs.h | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/usbdevice_fs.h b/tools/include/uapi/linux/usbdevice_fs.h
index 964e87217be4..78efe870c2b7 100644
--- a/tools/include/uapi/linux/usbdevice_fs.h
+++ b/tools/include/uapi/linux/usbdevice_fs.h
@@ -76,6 +76,26 @@ struct usbdevfs_connectinfo {
 	unsigned char slow;
 };
 
+struct usbdevfs_conninfo_ex {
+	__u32 size;		/* Size of the structure from the kernel's */
+				/* point of view. Can be used by userspace */
+				/* to determine how much data can be       */
+				/* used/trusted.                           */
+	__u32 busnum;           /* USB bus number, as enumerated by the    */
+				/* kernel, the device is connected to.     */
+	__u32 devnum;           /* Device address on the bus.              */
+	__u32 speed;		/* USB_SPEED_* constants from ch9.h        */
+	__u8 num_ports;		/* Number of ports the device is connected */
+				/* to on the way to the root hub. It may   */
+				/* be bigger than size of 'ports' array so */
+				/* userspace can detect overflows.         */
+	__u8 ports[7];		/* List of ports on the way from the root  */
+				/* hub to the device. Current limit in     */
+				/* USB specification is 7 tiers (root hub, */
+				/* 5 intermediate hubs, device), which     */
+				/* gives at most 6 port entries.           */
+};
+
 #define USBDEVFS_URB_SHORT_NOT_OK	0x01
 #define USBDEVFS_URB_ISO_ASAP		0x02
 #define USBDEVFS_URB_BULK_CONTINUATION	0x04
@@ -137,6 +157,7 @@ struct usbdevfs_hub_portinfo {
 #define USBDEVFS_CAP_REAP_AFTER_DISCONNECT	0x10
 #define USBDEVFS_CAP_MMAP			0x20
 #define USBDEVFS_CAP_DROP_PRIVILEGES		0x40
+#define USBDEVFS_CAP_CONNINFO_EX		0x80
 
 /* USBDEVFS_DISCONNECT_CLAIM flags & struct */
 
@@ -197,5 +218,10 @@ struct usbdevfs_streams {
 #define USBDEVFS_FREE_STREAMS      _IOR('U', 29, struct usbdevfs_streams)
 #define USBDEVFS_DROP_PRIVILEGES   _IOW('U', 30, __u32)
 #define USBDEVFS_GET_SPEED         _IO('U', 31)
+/*
+ * Returns struct usbdevfs_conninfo_ex; length is variable to allow
+ * extending size of the data returned.
+ */
+#define USBDEVFS_CONNINFO_EX(len)  _IOC(_IOC_READ, 'U', 32, len)
 
 #endif /* _UAPI_LINUX_USBDEVICE_FS_H */
-- 
2.21.0
