From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 4/6] tools headers kvm: Sync uapi/linux/kvm.h with the kernel sources
Date: Mon,  7 May 2018 17:13:31 -0300
Message-ID: <20180507201333.26990-5-acme@kernel.org>
References: <20180507201333.26990-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180507201333.26990-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KarimAllah Ahmed <karahmed@amazon.de>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The changes in 5e62493f1a70 ("x86/headers/UAPI: Move DISABLE_EXITS KVM
capability bits to the UAPI") do not requires changes in the tooling nor
will trigger the automatic update of used ioctl string tables, copy it
to silence this build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8o5auh1lqglsgl1q97x00tlv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 1065006c9bf5..b02c41e53d56 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -676,6 +676,13 @@ struct kvm_ioeventfd {
 	__u8  pad[36];
 };
 
+#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
+#define KVM_X86_DISABLE_EXITS_HTL            (1 << 1)
+#define KVM_X86_DISABLE_EXITS_PAUSE          (1 << 2)
+#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT | \
+                                              KVM_X86_DISABLE_EXITS_HTL | \
+                                              KVM_X86_DISABLE_EXITS_PAUSE)
+
 /* for KVM_ENABLE_CAP */
 struct kvm_enable_cap {
 	/* in */
-- 
2.14.3
