Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693492;
	b=PJd4EdeDDs91XjY3r9QUOYt5TW6qGGQ4ArhkXZb0DuVPMlj3e00dftFPW29VLwrdcMsg
	 55L5sgs2xRScVDoESsR0g5triVJAcCbc4PxidKd/e3JHTkWbSM+v06QIGrud+van5tWis
	 MxUp3BIRFOtjLHQXC4mRGmAiPq8/3p+aMRywKqvSIJnRYL/QFcvwYmRZxiFimEWK598/5
	 juMqeXp8B9n0arQQGwIhj1imv7P9Q7rl3mSNcXpHgKeHnuZ5aFecoQtcL8uYLieWpVVTL
	 adTxlsV9FykXSUsFemKkxwit8nloGcx2nh1CgSMkDtIS3b6xcg+NcL5rT1vDNpO6yJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693492;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mCz5faZcAW52tJYBbukECioPM85ClEcij99Okwm51M0=;
	b=sSnBmQqSTCsOLcbOL+MKug0cGHNn1ahUx49G/b26wKcpRcgygP3bTbsAiOb3meCMzoTL
	 P/iFbHbn07rXBM5+YVLZk3fLV0ORuFKy033v2ftlxUuGFShHG67Mt6t7hVI69+AtgV49D
	 cXuuXFU0inGV7S8WqvzKpQSU71/zAJUyXdk8UIBwF1Wykl8bbR1SZssYUBAHnTx466xU3
	 9/OOFnCq/pt/v/4buJ6Bupnp4kVI8GqzCmyB89l9iCn2L1e6qNPxl2f1sqQ6kJBVYpO3C
	 8wuYW2sIkALk5/qU2RcREeIR3Ngemao3Gm0rKG04r7mA1vsjRnMs65xaBC8yiwISOIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iht2ILuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE01F606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iht2ILuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA5A1F01829;
	Thu, 22 Oct 2026 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693491;
	bh=mCz5faZcAW52tJYBbukECioPM85ClEcij99Okwm51M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iht2ILuYYJtAVcIJ4Rmr12Y0TXBoPNVfAJTyr/L25H2qEv19eHUUZ+KYEtP9cInFY
	 hwvQ2bEW7xcVFB3yYMJ7o5+Zyoe3l+IOrA6EkZ/DuhPc3fqWSHl9cjpK6ujGuVrZYu
	 4Vs0TYuc6q+9bznVIKTd80kzQLxswTDtliQX8lCeG4GSwzNtfDAace2KhMw6Leynqd
	 eFNTiHA9vgwtvwRTbp48MGGLx5BIJCuxOW8L9/lAurPoxCIxHLOhkDiILeq4i19pbP
	 QkmCtKIM1rBhr6hzs72/CDaYItoixceBB0Rv3P05KiK2yn/k0foNEofeQIJ2jCk9tV
	 3+13XgeqHbw+g==
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
	Yuyang Huang <sigefriedhyy@gmail.com>
Subject: [PATCH v3 03/10] tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
Date: Thu, 22 Oct 2026 15:24:22 -0300
Message-ID: <20261022182431.25673-4-acme@kernel.org>
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

