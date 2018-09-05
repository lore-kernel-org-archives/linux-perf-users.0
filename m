From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 18/77] perf trace beauty: Reorganize 'struct sockaddr *' beautifier
Date: Wed,  5 Sep 2018 19:03:41 -0300
Message-ID: <20180905220440.20256-19-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Use an array to multiplex by sockaddr->sa_family, this way adding new
families gets a bit easier and tidy.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v3s85ra659tc40g1s1xaqoun@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/sockaddr.c | 60 +++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index 3944a7d54d3c..71a79f72d9d9 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -17,34 +17,52 @@ static const char *socket_families[] = {
 };
 DEFINE_STRARRAY(socket_families);
 
+static size_t af_inet__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+{
+	struct sockaddr_in *sin = (struct sockaddr_in *)sa;
+	char tmp[16];
+	return scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin->sin_port),
+			 inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
+}
+
+static size_t af_inet6__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+{
+	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
+	u32 flowinfo = ntohl(sin6->sin6_flowinfo);
+	char tmp[512];
+	size_t printed = scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
+				   inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
+	if (flowinfo != 0)
+		printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
+	if (sin6->sin6_scope_id != 0)
+		printed += scnprintf(bf + printed, size - printed, ", scope_id: %lu", sin6->sin6_scope_id);
+
+	return printed;
+}
+
+static size_t af_local__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+{
+	struct sockaddr_un *sun = (struct sockaddr_un *)sa;
+	return scnprintf(bf, size, ", path: %s", sun->sun_path);
+}
+
+static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
+	[AF_LOCAL] = af_local__scnprintf,
+	[AF_INET]  = af_inet__scnprintf,
+	[AF_INET6] = af_inet6__scnprintf,
+};
+
 static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct sockaddr_in *sin = (struct sockaddr_in *)arg->augmented.args;
+	struct sockaddr *sa = (struct sockaddr *)arg->augmented.args;
 	char family[32];
 	size_t printed;
 
-	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", sin->sin_family);
+	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", sa->sa_family);
 	printed = scnprintf(bf, size, "{ .family: %s", family);
 
-	if (sin->sin_family == AF_INET) {
-		char tmp[512];
-		printed += scnprintf(bf + printed, size - printed, ", port: %d, addr: %s", ntohs(sin->sin_port),
-				     inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
-	} else if (sin->sin_family == AF_INET6) {
-		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sin;
-		u32 flowinfo = ntohl(sin6->sin6_flowinfo);
-		char tmp[512];
-
-		printed += scnprintf(bf + printed, size - printed, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
-				     inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
-		if (flowinfo != 0)
-			printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
-		if (sin6->sin6_scope_id != 0)
-			printed += scnprintf(bf + printed, size - printed, ", scope_id: %lu", sin6->sin6_scope_id);
-	} else if (sin->sin_family == AF_LOCAL) {
-		struct sockaddr_un *sun = (struct sockaddr_un *)sin;
-		printed += scnprintf(bf + printed, size - printed, ", path: %s", sun->sun_path);
-	}
+	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family])
+		printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
 
 	return printed + scnprintf(bf + printed, size - printed, " }");
 }
-- 
2.14.4
