Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622171;
	b=Mq+yoDzm3ixMMTStR9M5JJlhpgq4ofNhYIf8EDXLRVPAVUh/nvA5oELXf+YafV2YeNtg
	 vAvYB95X6vAbdi5w27uYqL5fIIPNbhVBFuqztynn/aaifdR2bCh5IlBbmnw9lUpHtKG5J
	 Xe4uCq4V0UJ07lZOjdp3ADQKYyAGnQJRY8/3y3JtJBY/IMt/k9S135soId+t7lkPvo7SD
	 m4lOFfWniNjzc9Mq4VHQNvNA8GcJTDqYUKGP1Mgpl51142i1zPneZcBss4748XQRPp6WB
	 4RMDRackF67dTrdiKZZC7z9YOlrXXIZje9zX9u1qCHJu5viiYZbHbHf9h7ZXfGVwJsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622171;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nBgZu/WpMhlQAHNw6DXQuLzGgFe97kd6nrjHkKz+GSo=;
	b=hmdQwfsNkzwkQKXqzDAj1M0L4g7NzvTI4pA9oTykOYrWeSTdxEsgLhfY5XY/YiWwqFBT
	 NRuXF1MrSFm8zRPFy1TDPfvmef+QL1tPl0ATGRLn+OYZqsLbUU15PnpWBwQpLJZx3z0IE
	 XUdmscCNMWffMWem2Bs5iFFCYPudqczTRknJGLDG9AKqO8njze6K948cTvemo4ekIzIoO
	 ekOs/Bshqgg/I6dk3oPiWWYHo/G51LlZ3vXoHoc45LptHSiMdeTZBO5ELW/TBkgNKiMVP
	 qHvImfpafExpb/dqU7mcPRNok3VheDad5Csfkle+geCgnplTwy4Sr5iJgqWyLaOfhhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D8Uxqp/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C183606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8Uxqp/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC55D1F000C1;
	Wed, 21 Oct 2026 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622171;
	bh=nBgZu/WpMhlQAHNw6DXQuLzGgFe97kd6nrjHkKz+GSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8Uxqp/n22qmI2oKNPAwQgajXYCqYqXk7zKzqAOzA1S9L7aFgTB4eugmGgGBKh0/8
	 6fiyFlbhjqp8KL/TJwoRTEbUoJLlPRaYFijzxGMIkEWhuSZ3Y0TX7ZkbkQSi0BBRKa
	 EQEtbaINbhP63Y1CT/YGgtA2BjHxkiKgzadTapv6jbknjFS9xL5YvFbjfTCMhRwfd/
	 c07IJ4E+OXNSbD0hRb/5G9uqPArRb/Skb5NxXbz8u5OS0NwTpVVAhlfzw4aJsQ7nG1
	 GV++83uJj0Yusz9/EVRRziBUu5byPA+60pRhMa0rLi/h/5zaSonAmh6eGQ9oc8fmSM
	 Yvm33hW8s1cDw==
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
Subject: [PATCH v2 02/12] tools headers UAPI: Sync linux/if_addr.h with the kernel sources
Date: Wed, 21 Oct 2026 19:35:41 -0300
Message-ID: <20261021223555.28372-3-acme@kernel.org>
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

  7cb8198761e6 ("net: ipv4: report multicast group user count")

That just rebuilds perf, silencing this build warning.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/if_addr.h include/uapi/linux/if_addr.h

Please see tools/include/uapi/README for further details.

Cc: Yuyang Huang <sigefriedhyy@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/if_addr.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/if_addr.h b/tools/include/uapi/linux/if_addr.h
index aa7958b4e41d044b..7fb630b7fe311ab4 100644
--- a/tools/include/uapi/linux/if_addr.h
+++ b/tools/include/uapi/linux/if_addr.h
@@ -36,6 +36,7 @@ enum {
 	IFA_RT_PRIORITY,	/* u32, priority/metric for prefix route */
 	IFA_TARGET_NETNSID,
 	IFA_PROTO,		/* u8, address protocol */
+	IFA_MC_USERS,		/* u32, multicast group users */
 	__IFA_MAX,
 };
 
-- 
2.56.0

