Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618245;
	b=5XFZ4QobjmodHm1ziVZ+jlTc+XozDrFOg+6+1Ioxr3C2EvJ+6t8LydH7iICBddHzq5y9
	 df5I84hifVQYlym9WXt8wqpLSrVwKZPO2mBc7Vf++kMmpbnfq4eEtZAfUMRZhglG/noOH
	 tFaf1LYIf9jEVpWhGW8vcbwP7FJ+AE2J300KSQ0I8qXFRKI8LUBslrS9Oh/EJeBS8PXsT
	 HulVOoYRw0EudSwXvHkeL44PQ5XqjlDpE8CcUjivS0nj6hnDrOQ/xO3DfsbPGJXvfgTQn
	 nqq4YDX4g1mzl3HzDbVkXj57ybzw4L9EFqh8439EyCwjnRlKnSklydsHid6XoPKcSww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lS+slFaOZA/bTrv06t/lGxUwEamCYlMpmJqTfdXv4Sk=;
	b=sGzbzNnPaYSJ89QzG7vo38tw24mHV3NQiA3+GhQFGdBlTYHEXDOZJ4kqL6unXo3pFsgI
	 XjULb7gJYsT5RZ7M4pa/2DoHEnhTjSv57NSRzfIW2DhGPVsCWzAPMiFJSqQlCivgShycN
	 ajC7aMTVbX048XlbfIHo+UIZNNCUU+XV6us8P+3O9ZQi7Ll5NL1mH1h5dKRKV7HChh88S
	 Tl7daedo/rmW+ur1IneF0TgvE/fuu83eAkj7oEg9SnkeTkCtQ0AxM3iwiqAfi5yyfYQt2
	 0Uskx6htBhKGw11QdnWERf/WyoCu7QiBVfHeXWT5fPqqKu9K9D4CKr08yKD5+M3M+PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuJUyP4h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F339606A337;
	Wed, 21 Oct 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuJUyP4h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF41F000C4;
	Wed, 21 Oct 2026 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618245;
	bh=lS+slFaOZA/bTrv06t/lGxUwEamCYlMpmJqTfdXv4Sk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuJUyP4hsb7ggvWD9u3IEM8ww3jCMY4cqhx0JSwTDlj340KLeN1SSGJqDAEyI3mZ0
	 nk+oTOoVh02YZlxtwBYqJxDJO2xn4YYs8qt89KuKvjfaX1tbHIhIxLrCx2fb/8zsyy
	 RK4mKJy4f65O1JYbLZS64psahx0LziCl9kgIQfh8derXR7k6DGIRto8d3T511AE5lw
	 HwK6/H2Cwe232zptIzDvbWolyEbj9VWOi2pNFMImLqM43WjrntEgCr9lV+lOeS0VNa
	 0znOH000Bgq2rO4YedB3RD23qcDJN/Z8fgFCiPpWWFgXpX86zjPlM24zqmGYhuET++
	 KXPc5vEaUUgvQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH v1 07/12] perf beauty: Update copy of linux/socket.h with the kernel sources
Date: Wed, 21 Oct 2026 18:30:01 -0300
Message-ID: <20261021213007.21046-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021213007.21046-1-acme@kernel.org>
References: <20261021213007.21046-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  be3a5e06b962 ("net: add SO_PASSPIDFD_THREAD to get a thread-specific SCM_PIDFD")
  5bd369c05576 ("net: Add connect_socket() helper")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/linux/socket.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 2a8d7b14f1d11959..b17fdb7d38a7734a 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -189,10 +189,11 @@ static inline size_t msg_data_left(const struct msghdr *msg)
 
 /* "Socket"-level control message types: */
 
-#define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
-#define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
-#define SCM_SECURITY	0x03		/* rw: security label		*/
-#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
+#define	SCM_RIGHTS		0x01	/* rw: access rights (array of int) */
+#define SCM_CREDENTIALS		0x02	/* rw: struct ucred		*/
+#define SCM_SECURITY		0x03	/* rw: security label		*/
+#define SCM_PIDFD		0x04	/* ro: pidfd (int)		*/
+#define SCM_PIDFD_THREAD	0x05	/* ro: thread pidfd (int)	*/
 
 struct ucred {
 	__u32	pid;
@@ -461,6 +462,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
 extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
 			     int addrlen);
+int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
+		   int addrlen, int flags);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
-- 
2.56.0

