Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693498;
	b=MEbNlZrQfLNpLH5NjEz5lnFqM1Xi+84v/11EYQBQ89XIyjcI39Mc2EpGjDpfsXtI2Yiw
	 Ed9g5+YHvhWA969sDxjrY+/Fz1BPizBZsbsFUJoOj8q+pOv9BI/t0UzozNV6iAd/fxDkh
	 Tu+6l5uEsPK8zrbmpklQpnLiI+YYxajLs2npXh3gf6powJuE3F8HKxFLLU2MBzhTgma0Q
	 LBUxPVTlpFHMEe32evVgP6zWcFPe0NwNJDdtaJEfbTWi3JPE91/gL49v6nQ7eamA1GPPT
	 kp32t82miRhh0nKZkyBwSQKaOcfRj1RtpWCreZFxrW7e12wG7JsoM7/XmxU/YNaf5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e4JybK43PGY9FZ811mlzmATVYgEM/4zuAuoBSEnmHc4=;
	b=TS6lUD3Y+C69WzVojAMJ6oUoUYVqCJYcuZOklRBTEDVASgdtcebCDeO2XczkzCRCZJHo
	 1esSpoVdO1FHZKl76WiL0q2z6acqULvFDSJjPu55XMD2vOr+CvX1q9hye8Fq5FSm32UzN
	 NIguyxVXlGAj7AIvu+47HAy9Etul4RsqvH44dlqwCHc1UkdWtdRu7FJyhsNdKjrz92zlu
	 2Or+edCdS44N2WpBg4JaiYL40P3rTeDkfevNmsN/J/YykwdCPEMOHTwrLgNgTIvC73n3R
	 umDl02dIDoZWA6uTNQHIXweEV9QOB9cpWgeInS0HZ47BqCGIJ1VQygvbBt6BevwZ/sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmdB5kyO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED0606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RmdB5kyO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244791F01825;
	Thu, 22 Oct 2026 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693497;
	bh=e4JybK43PGY9FZ811mlzmATVYgEM/4zuAuoBSEnmHc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmdB5kyOG7C1SwEsZxjxgp8m2z5a0WpoVubzI6L/xWP5TkkNZeCZWKfFF1IcdXapF
	 Vg4/eh8l6MtCFHQUk9tUtM+/yq/V1ZB047tOL4NVDXoMOjy0mixuytu0dS3/IoCcwq
	 7GO+a5VRheg7e8aUxybMeKhS6KVE5s1WUlYHbD77fYbJnWBKM8Yu9xVwLrMor1d0/a
	 xnPR1bskE++jRZYIbjtZwcNFkxGGW3l/Yj63K7ASkBBLSYDzVA4bnlm//Abnr04ePU
	 LNcVK331LtVAiNADDMZe48S3TzHTk2KCkAyUFzzEggNMN6JhxXo9LGvPhkUGTksLU9
	 RzlSnGAYtM7vw==
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
Subject: [PATCH v3 05/10] tools headers: Sync linux/socket.h with the kernel sources
Date: Thu, 22 Oct 2026 15:24:24 -0300
Message-ID: <20261022182431.25673-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261022182431.25673-1-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
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

