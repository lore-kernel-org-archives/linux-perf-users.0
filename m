From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/28] tools include uapi: Update linux/mmap.h copy
Date: Wed, 31 Oct 2018 13:45:01 -0300
Message-ID: <20181031164508.4784-22-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from:

  20916d4636a9 ("mm/hugetlb: add mmap() encodings for 32MB and 512MB page sizes")

That do not entail changes in in tools, this just shows that we have to
consider bits [26:31] of flags to beautify that in tools like 'perf
trace'

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from latest version at 'include/uapi/linux/mman.h'
  diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3rvc39lon93kgt5pl31d8g4x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mman.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index bfd5938fede6..d0f515d53299 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -28,7 +28,9 @@
 #define MAP_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
 #define MAP_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
 #define MAP_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define MAP_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
 #define MAP_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define MAP_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
 #define MAP_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
 #define MAP_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
 #define MAP_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
-- 
2.14.4
