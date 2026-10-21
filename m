Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622189;
	b=WFW5Rvm+1GeYlxvmLwz9KLs9MF9Cs7hpv6RDSfFRpW7d0Xoc9ve8VgnZfWDoK69kBK1c
	 igKPwmvuZqiBzq734rdukWNK6MCvFaH7FbS3/Yql9/94aeeHcbGM/4zpoFoS/NC1wJjjU
	 +Sn46YUUfq9NHFSnr3pYEGHOy3jGquONVGvaECPn4dARoU8/QmxCHFy8WTH0GZpz2VeA7
	 oHAXTWCWsHFXAH4rKJMikEVLHb/vwXELYJSKC9/7F6gBLhwwenS7sKXtQAoA//9VMn5RM
	 XRvpdTwIgEFI6JznNM/eii4DBShCXgJ0aINK+6gVnIaGrXocuV0xC2yfjDWESsqeUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e4JybK43PGY9FZ811mlzmATVYgEM/4zuAuoBSEnmHc4=;
	b=qJV9FrcFzqmh9A4jypZUuzVNswHgSjHPZF254KseDxQGUkPt3cUwE2BYqI9vb65jz3x4
	 fNG5VoKiJF/kHZNqWQ51PU5C8uGgO/Bt/hOlbCQqTS3p4GNOZ2dOr1c7spMsLeuHloMhT
	 afOGaz3QH9e92xMmT4jyknEb6xaLATNXwuo4CJmTQi99rGKtUtXIjVeCT44E2biYAlGFk
	 YSV0yBRsYL0G92CLAw8khGHy70quv+JCqbPDbI6alKPFI26j1KiFMXERhRfdtjGpuF7ov
	 fwhu4oegpEFpaMlagUvin9IazqHGYG2p+fPNpDxyDrYmoNqrr51qWZZUqixYoZkNJsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdL8+O14;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806D606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdL8+O14
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E6B1F000C3;
	Wed, 21 Oct 2026 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622189;
	bh=e4JybK43PGY9FZ811mlzmATVYgEM/4zuAuoBSEnmHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kdL8+O14LGlvvylGEMomLA8ZSHQVrrHImh/RanURqOS9Y4yW5yHWFgdURKPLxcqrL
	 sXW5BfSNM3Zbo3BQezHk0cYsWJI5EDSdSeAQbW/4g6zbf8KazwmpK+juxWir/nz1DY
	 P75ySM7nvK6S+wlL1ta1J6KF6WlWpUxKksUVQc9B4L46vwW58KN8/nRGSfSV/z9WuO
	 dEUWLo5VQ8VpvJ6uXBBguoFOf/Ub2WU+w5g76xdWceish+p+ypo2wpmGf+ePeCqFVt
	 1C13ZaeIHRWP0yxvg05IrmVeMkwLOAY/7/eLufRls/AW3NDPXOQcqjc0CQA90o96EB
	 GIIpEO2VrQlYg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 07/12] perf beauty: Update copy of linux/socket.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:46 -0300
Message-ID: <20261021223555.28372-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

Acked-by: Mahe Tardy <mahe.tardy@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
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

