Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618227;
	b=cBDZMyofvGMT/TRY4YsnlnfEVbwduyIhYmtAoFqfYK5AwbeQVMxeMfHH2bT75TkjyaZU
	 bFrqj74S2SGC7BQmDUHj2n1Vq0M//v1YiXZBPNju4GWK74JgY/wn0+5U5g5ijWvEwBLZ8
	 nWozzYjMiXzy9G1AcnKMvxFMxzqUqC80TSM4p10u2AG4r2zyxxEUm7ieakD6JWZIye2tU
	 40jKkf/iZA4FyG1pbDMeE2epB6kbLyZLUn88CBrTsxclnwhHxwiygePyMpJ5UCs5ggUEv
	 siCJUr8xq5tun2/VXGLkN+cOpWxgiRN1bhl4EzFc/xgBkjdNpxD/81a6IDohUA2PxDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618227;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nBgZu/WpMhlQAHNw6DXQuLzGgFe97kd6nrjHkKz+GSo=;
	b=O0f3jGfjksiGMEjy5NFiUIZKuTh+J48zVOkPHgOLtBdaq+Qa7UFaXkw1jjtpClPShAj2
	 3yyHf41MQAGurk4mGzBuX5kHunHDyH/Jz42SmGeM7XEqg+BSmOYp6/ofzyWNclokcIz6m
	 NIM/GmuYz2MIwPgbZ0vUxiH4zH8ikawvIEbJ9GkDauYLPc/UToyp0hPLM7DMKylIecmwH
	 XpI4hVZYUcvjXNrCPH781WWb+aiGKRGULU7LWSBb+vbAch/JAWbtdSllVMRr+SOjXEQDI
	 v4k4cEXvL9Wki6DzCmvMdXJnAndeDXwDaHZ7LWIQzT6+7R1D72iq+xKh1L4Abtl7d2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIOZQbYH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23ED606A334;
	Wed, 21 Oct 2026 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIOZQbYH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA151F000C4;
	Wed, 21 Oct 2026 21:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618227;
	bh=nBgZu/WpMhlQAHNw6DXQuLzGgFe97kd6nrjHkKz+GSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GIOZQbYHuyJQLlTBAN1vtI0J/SG0bGm7WxAAWv7gGTo0fo6TCZA5+ve/ocOb5arUp
	 kUguGK7x7t11dJdL5chJijhJXnQp+pMqqXJO59t3AaP3jYxDov82bUXLkI98FdZemS
	 ANpP+B4eGJFYDMzmaxc3lbsmQcL4i6BjInyhrEmOvoVZRECIRilwbfVbwpe/+4xB+l
	 lPlE6Pe7LJ/aLvpjTwEQ7+63DxK9QK2j4IM3ryOnhnVFQPQ+y/hK1jVkdquPFV840W
	 HkyH8ozOSj4vDZeMt8+oqqnVUjmbEMsdc15wbX9Fe++VPcbmuPwHcF3ekJ12mKB1Xo
	 wSwnte+De0Xyg==
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
Subject: [PATCH v1 02/12] tools headers UAPI: Sync linux/if_addr.h with the kernel sources
Date: Wed, 21 Oct 2026 18:29:56 -0300
Message-ID: <20261021213007.21046-3-acme@kernel.org>
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

