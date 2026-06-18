Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36643FD140;
	Thu, 18 Jun 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795797; cv=none; b=lrr6yD1Aunb7yGj8vjaOObBunBwJGYbD2qrRoCYQrVRXId7QQfxjB7pty61D/u1aNpwqjkKvnlF46VGEQX1Y6A5z8Xtjhjitdk7y/yC5888X3huEZ8EkxaMtayQSkYTBb74zlj4j2i5F4uYroKOde8m0mSO+lA3NMx+S8OEhefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795797; c=relaxed/simple;
	bh=B5J9hoqkQWwUaCr/NhIP66CwxI6sG8w0BrzxtoKi++k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGgYSS2QHZK7Gowm3VYRKvY78olRPkDxjQCRyxkl6Xv95VtXdMAcvMaMFVdlf+G5Zn3p9eUzprudVfFETJERlEPFujfkwEX1QXkL++FlIg0xECVq/e800s7Uc+9etQTjtOVxmNI86YRUJFGcaJhWb9qrXhyrLDXAvJi+8/2l8Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3a2zV+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3a2zV+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B151F00A3A;
	Thu, 18 Jun 2026 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795796;
	bh=6OYGwKPi9e0F5A4HgCgYGwneO4l/HQKMv0UgxtkABl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B3a2zV+jbSUsHpaRjYGXart3mx6QpBFP2/CDTzAcblIYeXCay9I0JH7jM7YpNNYe6
	 Lgxn2ZjTkZ063hw+2JJSgUp4ilXLJWmP4F5bGrObrY8WXr7tA7CZXHJ1t65zLfe5pK
	 SUmFHIn0xztCljY9TcOBsXJ/SzwsrQRsXOZN1Sxu5waYXqaF9SI0Bv/etAxoETdTSi
	 4bOxgTzXR9T6+FHFFdtrrSmZUvQzgcJpmdzVZFYNgWssNXF2n5K3pK2hS7bHKyQHTP
	 kDGmFiaxJKEGqOE/6Bkik09bX7L79tf95CD8QoPqtp5wA1I3monAG/6dm3lXaggqmD
	 3K5xOMEcbejDg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 7/7] btf_encoder: Remove unused variables
Date: Thu, 18 Jun 2026 12:16:06 -0300
Message-ID: <20260618151606.82747-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Detected with gcc on fedora44:

  /home/acme/git/pahole/btf_encoder.c: In function ‘types__match’:
  /home/acme/git/pahole/btf_encoder.c:1123:49: warning: variable ‘p2’ set but not used [-Wunused-but-set-variable=]
   1123 |                         const struct btf_param *p2 = btf_params(t2);
        |                                                 ^~
  /home/acme/git/pahole/btf_encoder.c:1122:49: warning: variable ‘p1’ set but not used [-Wunused-but-set-variable=]
   1122 |                         const struct btf_param *p1 = btf_params(t1);
        |                                                 ^~

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 12c22b003b7990bf..4467710e4e03c32f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1119,8 +1119,6 @@ static bool types__match(struct btf_encoder *encoder,
 			break;
 		}
 		case BTF_KIND_FUNC_PROTO: {
-			const struct btf_param *p1 = btf_params(t1);
-			const struct btf_param *p2 = btf_params(t2);
 			int i, vlen = btf_vlen(t1);
 
 			if (vlen != btf_vlen(t2))
@@ -1128,7 +1126,7 @@ static bool types__match(struct btf_encoder *encoder,
 			if (!types__match(encoder, btf1, t1->type,
 					  btf2, t2->type))
 				return false;
-			for (i = 0; i < vlen; i++, p1++, p2++) {
+			for (i = 0; i < vlen; i++) {
 				if (!types__match(encoder, btf1, t1->type,
 						  btf2, t2->type))
 					return false;
-- 
2.54.0

