From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/18] perf trace beauty ioctl: Pass _IOC_DIR to the per _IOC_TYPE scnprintf
Date: Tue,  1 Aug 2017 16:56:42 -0300
Message-ID: <20170801195645.16986-16-acme@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170801195645.16986-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Not all subsystems use the fact that we may have the same _IOC_NR for
different _IOC_DIR, as in the end it'll result in a different ioctl
number.

So, for instance, vhost virtio has:

  #define VHOST_GET_FEATURES      _IOR(VHOST_VIRTIO, 0x00, __u64)
  #define VHOST_SET_FEATURES      _IOW(VHOST_VIRTIO, 0x00, __u64)

So same _IOC_NR (0x00) but different _IOC_DIR (R versus W), but it also
have:

  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)

A "get" operation that uses a "W" _IOC_DIR, and its implementation, uses
copy_to_user, it should've probably been _IOR().

Then:

  /* Base value where queue looks for available descriptors */
  #define VHOST_SET_VRING_BASE _IOW(VHOST_VIRTIO, 0x12, struct vhost_vring_state)
  /* Get accessor: reads index, writes value in num */
  #define VHOST_GET_VRING_BASE _IOWR(VHOST_VIRTIO, 0x12, struct vhost_vring_state)

So we'll need to use _IOC_DIR() to disambiguate the VHOST_VIRTIO ioctl
bautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-rq6q717ql7j2z7kuccafgq84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/ioctl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
index 89fa4eb68247..8633d96ed131 100644
--- a/tools/perf/trace/beauty/ioctl.c
+++ b/tools/perf/trace/beauty/ioctl.c
@@ -19,7 +19,7 @@
  */
 #include <uapi/asm-generic/ioctls.h>
 
-static size_t ioctl__scnprintf_tty_cmd(int nr, char *bf, size_t size)
+static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
 {
 	static const char *ioctl_tty_cmd[] = {
 	"TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
@@ -41,10 +41,10 @@ static size_t ioctl__scnprintf_tty_cmd(int nr, char *bf, size_t size)
 	if (nr < strarray__ioctl_tty_cmd.nr_entries && strarray__ioctl_tty_cmd.entries[nr] != NULL)
 		return scnprintf(bf, size, "%s", strarray__ioctl_tty_cmd.entries[nr]);
 
-	return scnprintf(bf, size, "(%#x, %#x)", 'T', nr);
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 'T', nr, dir);
 }
 
-static size_t ioctl__scnprintf_drm_cmd(int nr, char *bf, size_t size)
+static size_t ioctl__scnprintf_drm_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/drm_ioctl_array.c"
 	static DEFINE_STRARRAY(drm_ioctl_cmds);
@@ -52,10 +52,10 @@ static size_t ioctl__scnprintf_drm_cmd(int nr, char *bf, size_t size)
 	if (nr < strarray__drm_ioctl_cmds.nr_entries && strarray__drm_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "DRM_%s", strarray__drm_ioctl_cmds.entries[nr]);
 
-	return scnprintf(bf, size, "(%#x, %#x)", 'd', nr);
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 'd', nr, dir);
 }
 
-static size_t ioctl__scnprintf_sndrv_pcm_cmd(int nr, char *bf, size_t size)
+static size_t ioctl__scnprintf_sndrv_pcm_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/sndrv_pcm_ioctl_array.c"
 	static DEFINE_STRARRAY(sndrv_pcm_ioctl_cmds);
@@ -63,10 +63,10 @@ static size_t ioctl__scnprintf_sndrv_pcm_cmd(int nr, char *bf, size_t size)
 	if (nr < strarray__sndrv_pcm_ioctl_cmds.nr_entries && strarray__sndrv_pcm_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "SNDRV_PCM_%s", strarray__sndrv_pcm_ioctl_cmds.entries[nr]);
 
-	return scnprintf(bf, size, "(%#x, %#x)", 'A', nr);
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 'A', nr, dir);
 }
 
-static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, char *bf, size_t size)
+static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/sndrv_ctl_ioctl_array.c"
 	static DEFINE_STRARRAY(sndrv_ctl_ioctl_cmds);
@@ -74,10 +74,10 @@ static size_t ioctl__scnprintf_sndrv_ctl_cmd(int nr, char *bf, size_t size)
 	if (nr < strarray__sndrv_ctl_ioctl_cmds.nr_entries && strarray__sndrv_ctl_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "SNDRV_CTL_%s", strarray__sndrv_ctl_ioctl_cmds.entries[nr]);
 
-	return scnprintf(bf, size, "(%#x, %#x)", 'U', nr);
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 'U', nr, dir);
 }
 
-static size_t ioctl__scnprintf_kvm_cmd(int nr, char *bf, size_t size)
+static size_t ioctl__scnprintf_kvm_cmd(int nr, int dir, char *bf, size_t size)
 {
 #include "trace/beauty/generated/ioctl/kvm_ioctl_array.c"
 	static DEFINE_STRARRAY(kvm_ioctl_cmds);
@@ -85,7 +85,7 @@ static size_t ioctl__scnprintf_kvm_cmd(int nr, char *bf, size_t size)
 	if (nr < strarray__kvm_ioctl_cmds.nr_entries && strarray__kvm_ioctl_cmds.entries[nr] != NULL)
 		return scnprintf(bf, size, "KVM_%s", strarray__kvm_ioctl_cmds.entries[nr]);
 
-	return scnprintf(bf, size, "(%#x, %#x)", 0xAE, nr);
+	return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAE, nr, dir);
 }
 
 static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
@@ -97,7 +97,7 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 	int printed = 0;
 	static const struct ioctl_type {
 		int	type;
-		size_t	(*scnprintf)(int nr, char *bf, size_t size);
+		size_t	(*scnprintf)(int nr, int dir, char *bf, size_t size);
 	} ioctl_types[] = { /* Must be ordered by type */
 			      { .type	= 'A', .scnprintf = ioctl__scnprintf_sndrv_pcm_cmd, },
 		['T' - 'A']=  { .type	= 'T', .scnprintf = ioctl__scnprintf_tty_cmd, },
@@ -111,7 +111,7 @@ static size_t ioctl__scnprintf_cmd(unsigned long cmd, char *bf, size_t size)
 		const int index = type - ioctl_types[0].type;
 
 		if (ioctl_types[index].scnprintf != NULL)
-			return ioctl_types[index].scnprintf(nr, bf, size);
+			return ioctl_types[index].scnprintf(nr, dir, bf, size);
 	}
 
 	printed += scnprintf(bf + printed, size - printed, "%c", '(');
-- 
2.9.4
