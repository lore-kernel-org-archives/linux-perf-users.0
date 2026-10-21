Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618231;
	b=dHl2lqUto76T9wXPQuBseKC4TXUQpqounA0CI0B5xNsZprTJomGUdOr7o0tcOH2VxuqC
	 ExVuKLC3KpTojE0ce3M6K4DhLWWoChLUpPxmK6VoFEJt3yHaljkAUn102pPNVGkWnQDHo
	 +7Dlj8mTHzHljKTWbS+haD9r3jrXODiYSvE2cMYNqD71nRTVJg4T70V1AWXgl71lEVM/x
	 BFa0cCOHve8NLMlQ3f1OtfNSnZrgM1yfVQfAB8w29fSmb98HB6gnQcyV35xeYPChI3JZG
	 RPJ6a5fCP7FjF/K53iTmS1F4j19BhCl0oZWynzVbz7yUX/2YiBOwPP1n7nSNfFisEHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618231;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mCz5faZcAW52tJYBbukECioPM85ClEcij99Okwm51M0=;
	b=tZmwyCMYT8IaekkwHflzW/aBZxdloBX6R4TyK5w2c21haKARGVNdoBR4EF4/GbjfUi7L
	 VJfGzq64nA12+b9XVn6PrkzbfmIog4zj+vj1hpWcVdm5QBKVY8qRYqR5v2SGXegn2YqqF
	 QC/NN72qK9zT3tCjPuTjIlMDDK+L47mEFt3dweK4KgnQxbpdvXD80EPYKTt1S1ysGVxR6
	 joa7FNBx+DPSbkDQVFtJ4uGALcPcIyXTsZ8s3sqWvAUK1aTsLHj8zb9QF4v2ApCgpSH7x
	 5rmVElkf9qB4qjYCqmzgPpjd0dR461JOuiX+AKkG6ecI4HtD4V/IWCyrJdHnsh+glsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAxgWfa4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F62606A327;
	Wed, 21 Oct 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mAxgWfa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5871F000C9;
	Wed, 21 Oct 2026 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618230;
	bh=mCz5faZcAW52tJYBbukECioPM85ClEcij99Okwm51M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mAxgWfa4moiuQj+NDy1Q4ur0derQmf2NsUN8eZ+QDW/JKhZHml4TEfIg2d4f5ysqQ
	 9QOX8An5Rlv89y+m5SlFnOGSVEqlBZf/OqxUUxZsN+959zBj4NqAEuB2BDXwbcIBtd
	 3zXHFXZPSMsylLtO0mzdlJuBZ5MD46BaQU4JYRnlYuGQXIi4Z43hVXqIQhsQvzHkBx
	 mvOCkX6gutiD+WyM03CcbnTUvuhR9vrTqDVxVNYOAqMd5+MHh7w9X/w7nU9lLY/jJo
	 zDdbujLImnihCvL1TGeqijpoJzperpd2tOzmJFmqwUVpE9YblyDPrCt5bY9rGuUKbB
	 jEcjJ5k7Bg4zA==
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
	Yuyang Huang <sigefriedhyy@gmail.com>
Subject: [PATCH v1 03/12] tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
Date: Wed, 21 Oct 2026 18:29:57 -0300
Message-ID: <20261021213007.21046-4-acme@kernel.org>
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

  cc17e386f8a5 ("ipv6: add ip6_del_rt_reason()")

That just rebuilds perf, silencing this build warning.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/rtnetlink.h include/uapi/linux/rtnetlink.h

Please see tools/include/uapi/README for further details.

Cc: Yuyang Huang <sigefriedhyy@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/rtnetlink.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/include/uapi/linux/rtnetlink.h b/tools/include/uapi/linux/rtnetlink.h
index 27265fd31e5fc99c..3988b51db539fe4f 100644
--- a/tools/include/uapi/linux/rtnetlink.h
+++ b/tools/include/uapi/linux/rtnetlink.h
@@ -399,6 +399,7 @@ enum rtattr_type_t {
 	RTA_DPORT,
 	RTA_NH_ID,
 	RTA_FLOWLABEL,
+	RTA_DEL_REASON,
 	__RTA_MAX
 };
 
@@ -407,6 +408,30 @@ enum rtattr_type_t {
 #define RTM_RTA(r)  ((struct rtattr*)(((char*)(r)) + NLMSG_ALIGN(sizeof(struct rtmsg))))
 #define RTM_PAYLOAD(n) NLMSG_PAYLOAD(n,sizeof(struct rtmsg))
 
+/* RTA_DEL_REASON: why the kernel deleted the route. u32.
+ * Emitted only on RTM_DELROUTE notifications, and only when the deletion
+ * path records a cause. Absence means either an older kernel or a
+ * deletion path that does not (yet) record its cause - consumers must
+ * treat "absent" and "unspec" identically. New causes may be appended.
+ * Currently only IPv6 deletion paths record a cause.
+ *
+ * The attribute is notification-only: the kernel rejects it in
+ * requests, so a notification must not be echoed back verbatim.
+ *
+ * The value space is family-agnostic: a value must never be
+ * reinterpreted per address family. A cause that only one family can
+ * produce still gets its own value rather than reusing another
+ * family's.
+ */
+enum rt_del_reason {
+	RT_DEL_REASON_UNSPEC,		/* cause not recorded */
+	RT_DEL_REASON_EXPIRED,		/* RTF_EXPIRES lifetime ran out (GC) */
+	RT_DEL_REASON_RA_WITHDRAWN,	/* zero-lifetime RA / PIO / RIO */
+	__RT_DEL_REASON_MAX
+};
+
+#define RT_DEL_REASON_MAX (__RT_DEL_REASON_MAX - 1)
+
 /* RTM_MULTIPATH --- array of struct rtnexthop.
  *
  * "struct rtnexthop" describes all necessary nexthop information,
-- 
2.56.0

