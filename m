Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693489;
	b=vvX/CsmOf2fw4zIAz5yXiQ34ALGPkAJZrrhwXLySd8qD61xoRtfICQ8HFsfkxH2vW5rX
	 8uDaqjJGa2cqO4iG698gtxxG7b8bB2A9NIWqKrxhUz8nBp9RWvVD0zxy7l0sMBJbj8cup
	 8R5PRaQX0FdFzZroRFDbU7XvSssEt1HGLfKYJbb6qu2e3TtZQZVOwpTO0mHTpvJKNXSh9
	 Fq7+znUBVP+h3UPq0LBl4F+9bww2tR+yowwesVce82exoEIgf4LlwavzhfX9yEv9D9Glq
	 2EfRTQAUbztqX2MPnuMG9gMuZsaQQFjV0JfEKXqWC5FBqXXEljqWr3+gASF6EdGxdVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nBgZu/WpMhlQAHNw6DXQuLzGgFe97kd6nrjHkKz+GSo=;
	b=z1TDrNvs0V9EBa0oqBMmN0A5ORd+NH3yAptK14/x1cU+F1iOnJJVV2sMo4xo/wUd/AZh
	 LepChnpuEiy5+WtVXIh5/ht/fh9delE32/be5nZgFwIv2xgw//jFe/3pJqkw5UnN2iCj5
	 oo3z7ritupjUR0LoUPwv4HTPMWLp7Rv67Tf2/X4zT+C+2MWTsDmYni4csjqaf/7t0oD+M
	 bNJjfIk5+9FR/w55dKuOaVuUmGfciVBxfHGr2cyln1VU8uImm35vt2/wVJHGdUPpZpEb2
	 r6MeHhZPBb6jwaIxBfOS1EEbrrqM7Li8sIZny2rh26ejtftwuHsFxxVj/SQe3dS4A+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oq5wEQbC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0476606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oq5wEQbC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C162F1F031E1;
	Thu, 22 Oct 2026 18:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693488;
	bh=nBgZu/WpMhlQAHNw6DXQuLzGgFe97kd6nrjHkKz+GSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oq5wEQbCIZCjwm0eazJt2nLqul1TOjNya8DTtHwOa3yEZMirVGhGtg3oNuOMkQS9Q
	 GxAjpDsnZfHE+8pIGxSiOx8Fh4by6YJTEhUcRel3K5jrLnTmKL6KxJ4uVXbfrb55HR
	 mNKJXVXxjvqgIrGYjB59jMluvH2CExnZ8AVOYgk6E8b1tJg+Ao0xJbsD0/Lgc//wT7
	 /uOrK+l3lXfytSuOhFWunA9M3qcdhXD2vXuQiIS2QMBf4cpmu1AJk6+zpvlOBIWnMe
	 MlOpwMpl8eZiJxHZC3jYH3FVC90XnxH2lFYCp0WKPNt1JhrXLUSVVNzbaFO02Q5mM+
	 gd4V3T6MkXxTA==
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
Subject: [PATCH v3 02/10] tools headers UAPI: Sync linux/if_addr.h with the kernel sources
Date: Thu, 22 Oct 2026 15:24:21 -0300
Message-ID: <20261022182431.25673-3-acme@kernel.org>
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

