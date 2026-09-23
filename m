Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C945D5C4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147673; cv=none; b=F/pPqhtDNWGFCnNI3upd+5OCzlPK7TGDPAFKRw/IgfDPZOuFBkc91CoJHKhPGKJ3ywGnUG6i0E2TbF4e1pE/qT+/RuVPYLnZqvOr2aH031D0g+XxsVdFuy09G3i228aZU2NuUCDk3cRejE9rMJ5ztF+TD7wANjgISW5pOKUyCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147673; c=relaxed/simple;
	bh=ClBRPt0PX+BdDlotzkipLlfgDTGCEc0HqYURNxfWCBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ai1Jyq2ahDaMIzE+de5MBCP+V+nG+xqF66B4Dsg9sxNU4+oG1UTWmDi1ExbqkRhulj48AhxDdgEm6z7I1IG5pBTMZejRdzVkooul8hxFDOTRNl1hJmo5ODAi0mQqkV/npGW5Vgkax72d30GdOC36ACmPi8OZYVHspLRIXTsWSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UP8ucDgs; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UP8ucDgs"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso818220eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147670; x=1790752470; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gy5ZJj44yW2Y41JxZ137X9PGWzszng8gimxO0G3/Sm8=;
        b=UP8ucDgs49jUZkREYruFq1fs9MGKhtu7CWqYYZiC9/z5Lw6C4vC+XA9wvtGf4i8g9g
         gxI/0tVnQsqFDDv6iS7DIzi0kZM7G7GMft8Fb/y415AJd4j/0p9Yba5ZA9kplM4s9U8C
         D/9ABK/tryQobTDnYUkRd+/qoOQUj+OJmE7jUfXcSFoJ+dySWVwacjT2kKxOoSRmF33V
         cYYpNQF1KL/jeT6aaMC5BPdkHURg+LaGeJNgRnoyWIpk7/f29j35KNpkLE8QafLotl8H
         wr8IGDzwK09xVQHmTmSoJJs62N3YPM9o6or/k7+59g6jvm66zSVk19s2qjj0bIjHieTp
         4fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147670; x=1790752470;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gy5ZJj44yW2Y41JxZ137X9PGWzszng8gimxO0G3/Sm8=;
        b=SDGtJlSNFW1eWsGHbtkTyIBwuA4FMNi3hUu/SWM/cflTOrNMzq79BYIVjdCjsnReAE
         4b7kpeXOhS6Tas0g1RSENwohRlyQOZwM/CRS18ERdRMURYh62y8q9JaHBllF7nENA8yn
         hYP8aQFKwgu0AeY9mV/vIHB3gphTBvWB+KAT1FSZ6uJMgmq1sp2saE3QMZnBg7Mi7f30
         b7Ub5bxRSpLkvyINUP2ZLKuY5x/+wZo9grJDTH/RTjHRIhjn2qUF/CVYzjT0khhoTmcr
         2N9uqMQc2DF6/3zv1antxZbuA5KZHZEHo1W3wzATiie3PSkiyVe2swP8T/VR/lOk3g1I
         anrw==
X-Forwarded-Encrypted: i=1; AKwUvBxuueD3Y5A7FHCCioqDjmV7/AATdaLYXNJT9Uyh2jyI6vFHDn28cxJzBeRhK1BNXew7al1Alt6OTi0mBHjk9MwH@vger.kernel.org
X-Gm-Message-State: AFuF++kKoUxyYalFiB9tkUqyUDF1VQisRQSBvZJexwOgGDRsbl++46ZO
	0BJ6Ecno7zecDTW+4ubA5ANB7DjQZpJA7Bu549m8vyHg3DOYIkF6uHgN5P9kQF9WBbjuWFwGKtk
	O3TdCZPQtAw==
X-Received: from dyrx23.prod.google.com ([2002:a05:7300:3a97:b0:33b:c09b:a189])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87d3:20b0:339:7572:7b2b
 with SMTP id 5a478bee46e88-33ee381562bmr864132eec.24.1790147669961; Wed, 23
 Sep 2026 00:14:29 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:49 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <8a2a96e2f9c8511fa5f162682acac29807243972.1790145937.git.irogers@google.com>
Subject: [PATCH v5 09/23] perf trace: Bound the fixed size augmented argument beautifiers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The timespec, sockaddr and perf_event_attr beautifiers read a fixed
sized type out of the augmented payload without checking that one is
there. The payload is only as long as the augmenter made it, which for
a sockaddr is the addrlen the tracee passed and so can be as little as
two bytes, and which for a perf_event_attr is the attr size the tracee
chose.

Gate each of them on syscall_arg__augmented_args_valid() with the size
it needs before its first read, so that a payload too short for the
type leaves the raw pointer printed instead, as happens when there is no
augmented data at all.

Two reads that are unbounded for reasons other than the header go with
them:

  - perf_event_attr__fprintf() always reads a whole struct
    perf_event_attr, so an attr from an older version is read past its
    end. Copy the payload into a zero padded local instead of reading it
    in place, which also replaces the local copy that was only made to
    fix up a zero size field.

  - af_local__scnprintf() prints sun_path as a plain string, but the
    payload holds only addrlen bytes and the path need not be NUL
    terminated. Pass the payload length to the address family printers
    so the path is printed with a bound, and so that the AF_INET and
    AF_INET6 printers do not read a sockaddr_in or sockaddr_in6 out of
    a payload too short to hold one.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/perf_event_open.c | 38 +++++++++-------
 tools/perf/trace/beauty/sockaddr.c        | 55 ++++++++++++++++++-----
 tools/perf/trace/beauty/timespec.c        |  2 +-
 3 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
index 6315b46bcdf0..fba8993f3b93 100644
--- a/tools/perf/trace/beauty/perf_event_open.c
+++ b/tools/perf/trace/beauty/perf_event_open.c
@@ -81,33 +81,39 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf
 
 static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct perf_event_attr *attr = (void *)arg->augmented.args->value;
+	const struct augmented_arg *augmented_arg = arg->augmented.args;
 	struct perf_event_attr local_attr;
+	size_t copied = (size_t)augmented_arg->size;
 
 	/*
-	 * augmented_raw_syscalls.bpf.c (shipped with perf) copies
-	 * PERF_ATTR_SIZE_VER0 bytes when the tracee passes size=0,
-	 * but leaves the size field as 0.  The payload size is
-	 * guaranteed by perf's own BPF program, not externally
-	 * controllable.  Copy to a local so we can fix up size
-	 * without writing to the potentially read-only augmented
-	 * args buffer.
+	 * The tracee picks attr.size, so the payload that
+	 * augmented_raw_syscalls.bpf.c copied can be anything from
+	 * PERF_ATTR_SIZE_VER0 up to the size this build of perf knows about,
+	 * while perf_event_attr__fprintf() below always reads a whole struct
+	 * perf_event_attr. Work on a zero padded local copy so that a payload
+	 * from an older attr is not read past its end, which also lets the size
+	 * be fixed up without writing to the augmented args buffer.
 	 */
-	if (!attr->size) {
-		memcpy(&local_attr, attr, PERF_ATTR_SIZE_VER0);
-		memset((void *)&local_attr + PERF_ATTR_SIZE_VER0, 0,
-		       sizeof(local_attr) - PERF_ATTR_SIZE_VER0);
+	if (copied > sizeof(local_attr))
+		copied = sizeof(local_attr);
+
+	memcpy(&local_attr, augmented_arg->value, copied);
+	memset((void *)&local_attr + copied, 0, sizeof(local_attr) - copied);
+
+	/*
+	 * The BPF program copies PERF_ATTR_SIZE_VER0 bytes when the tracee
+	 * passes size=0, but leaves the size field as it found it.
+	 */
+	if (!local_attr.size)
 		local_attr.size = PERF_ATTR_SIZE_VER0;
-		attr = &local_attr;
-	}
 
-	return perf_event_attr___scnprintf(attr, bf, size,
+	return perf_event_attr___scnprintf(&local_attr, bf, size,
 					   trace__show_zeros(arg->trace));
 }
 
 size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
+	if (syscall_arg__augmented_args_valid(arg, PERF_ATTR_SIZE_VER0))
 		return syscall_arg__scnprintf_augmented_perf_event_attr(arg, bf, size);
 
 	return scnprintf(bf, size, "%#lx", arg->val);
diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
index a17a27ac2a6f..173402400018 100644
--- a/tools/perf/trace/beauty/sockaddr.c
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -10,21 +10,36 @@
 #include "trace/beauty/generated/sockaddr.c"
 DEFINE_STRARRAY(socket_families, "PF_");
 
-static size_t af_inet__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+/*
+ * The augmented payload is only as long as the addrlen the tracee passed, so
+ * each of these gets that length and prints nothing rather than reading a
+ * struct that isn't fully there.
+ */
+static size_t af_inet__scnprintf(struct sockaddr *sa, size_t sa_size, char *bf, size_t size)
 {
 	struct sockaddr_in *sin = (struct sockaddr_in *)sa;
 	char tmp[16];
+
+	if (sa_size < sizeof(*sin))
+		return 0;
+
 	return scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin->sin_port),
 			 inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
 }
 
-static size_t af_inet6__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+static size_t af_inet6__scnprintf(struct sockaddr *sa, size_t sa_size, char *bf, size_t size)
 {
 	struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sa;
-	u32 flowinfo = ntohl(sin6->sin6_flowinfo);
+	u32 flowinfo;
 	char tmp[512];
-	size_t printed = scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
-				   inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
+	size_t printed;
+
+	if (sa_size < sizeof(*sin6))
+		return 0;
+
+	flowinfo = ntohl(sin6->sin6_flowinfo);
+	printed = scnprintf(bf, size, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
+			    inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
 	if (flowinfo != 0)
 		printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
 	if (sin6->sin6_scope_id != 0)
@@ -33,13 +48,28 @@ static size_t af_inet6__scnprintf(struct sockaddr *sa, char *bf, size_t size)
 	return printed;
 }
 
-static size_t af_local__scnprintf(struct sockaddr *sa, char *bf, size_t size)
+static size_t af_local__scnprintf(struct sockaddr *sa, size_t sa_size, char *bf, size_t size)
 {
 	struct sockaddr_un *sun = (struct sockaddr_un *)sa;
-	return scnprintf(bf, size, ", path: %s", sun->sun_path);
+	size_t path_size;
+
+	if (sa_size <= offsetof(struct sockaddr_un, sun_path))
+		return 0;
+
+	/*
+	 * Unlike the other families the path is variable length, and it need
+	 * not be NUL terminated, so print at most what the payload holds. An
+	 * abstract socket's name starts with a NUL, which %.*s stops at, as
+	 * printing it as a plain string used to.
+	 */
+	path_size = sa_size - offsetof(struct sockaddr_un, sun_path);
+	if (path_size > sizeof(sun->sun_path))
+		path_size = sizeof(sun->sun_path);
+
+	return scnprintf(bf, size, ", path: %.*s", (int)path_size, sun->sun_path);
 }
 
-static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
+static size_t (*af_scnprintfs[])(struct sockaddr *sa, size_t sa_size, char *bf, size_t size) = {
 	[AF_LOCAL] = af_local__scnprintf,
 	[AF_INET]  = af_inet__scnprintf,
 	[AF_INET6] = af_inet6__scnprintf,
@@ -47,7 +77,9 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
 
 static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
 {
-	struct sockaddr *sa = (struct sockaddr *)&arg->augmented.args->value;
+	const struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct sockaddr *sa = (struct sockaddr *)&augmented_arg->value;
+	size_t sa_size = (size_t)augmented_arg->size;
 	char family[32];
 	size_t printed;
 
@@ -55,14 +87,15 @@ static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg,
 	printed = scnprintf(bf, size, "{ .family: %s", family);
 
 	if (sa->sa_family < ARRAY_SIZE(af_scnprintfs) && af_scnprintfs[sa->sa_family])
-		printed += af_scnprintfs[sa->sa_family](sa, bf + printed, size - printed);
+		printed += af_scnprintfs[sa->sa_family](sa, sa_size, bf + printed, size - printed);
 
 	return printed + scnprintf(bf + printed, size - printed, " }");
 }
 
 size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
+	/* Only the family is read unconditionally, the rest is up to the family printer. */
+	if (syscall_arg__augmented_args_valid(arg, sizeof(sa_family_t)))
 		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
 
 	return scnprintf(bf, size, "%#lx", arg->val);
diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty/timespec.c
index b14ab72a2738..8da0b28be0af 100644
--- a/tools/perf/trace/beauty/timespec.c
+++ b/tools/perf/trace/beauty/timespec.c
@@ -14,7 +14,7 @@ static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_arg *arg,
 
 size_t syscall_arg__scnprintf_timespec(char *bf, size_t size, struct syscall_arg *arg)
 {
-	if (arg->augmented.args)
+	if (syscall_arg__augmented_args_valid(arg, sizeof(struct timespec)))
 		return syscall_arg__scnprintf_augmented_timespec(arg, bf, size);
 
 	return scnprintf(bf, size, "%#lx", arg->val);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

