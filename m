Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795299942;
	b=az6i07W7EKeAgJ6DgPx3uhksnJAci7WIOrVsMxBinrNs3EbEoqPJCrg3rCHIRW0FHHFQ
	 6+jDzW/5Ioh3Xe3Odz85bhlR56Bmpxd0G+RwW5uNXzNvDdL5aHZIq4bblEiW53UvnlRFG
	 pt/2hT0+Pl1VlbVr+sp2y/t7gQeXhQH1lyxPQJ3BlNMCmwfQ89lSE/Uh1QIQTp7jLhDZO
	 eXYWUgd9UUCSAp1bo/dvWpYI+5qMGvJ5UON1p/RTsh4mHKEF/c96i9ZaP2FKlGWx1w48a
	 wndMynqroe1JvZNiP9hDEPIcyH8cTWy5eCerFmVdumUxbo9HLWSNLRsnMAm+lZc9Zfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299942;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=O6MTsxR9ESdrf4eb9aW5r4naqS2hJK9aQ9a6iqwNlCc=;
	b=HLmqfnOnSOQaBTAYchiSW83UhkuIfT9DekHOGIDVAswIHP14k4bW03pse55nPhdsxt86
	 mm5La1+CrqG3qXX65Hmdo5LnhpyQmpeemJz2DzoZ9sYgya/2mce9JTI+hGJEUPxbsB2sV
	 ZsaMS3GAk0XbEk8tKe1TNIMGY4vDuxvvVv2G/uGIgLRsr0MB2LWJCOKaixmpO9XT0SZay
	 Sig7uN2rTwh3Fx70VX2HHgZOAiKOB43KMMGAaReoTlPAd81ddj8lfJniAuXSi6M+k2oRp
	 E70MueJ/rsn42zL5gZp+SPk15y0znPaKIanHO3XCui7y72WePA5RVOJ3lHVJu7GuwzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFdV1NND;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CBB606A330;
	Sat, 21 Nov 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFdV1NND
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795299941;
	b=QnJF54+o+3Mi6YBUcfA04PW1owH52y1ypAB6zI9HAZNzjsFfPZMMFjnu8jxR+RJ29CYM
	 osRQIJzfG7ZbCj/4sbZ7nUwJXnHS/KKv/yC/iqqeRgSFLSUtZ8Lj/RHr0tNh++oEU2mPv
	 cJqT17T/M69VlUZupQ1fAULfPBVw6ZDnKOZLm0jPuwVOaq98/9JQiC8L+3pNj9J8eb9TF
	 IFgH5J54R8bhBzQ/QTFuYgKXthjuKs6QIg13SLFG4F+fmkjBEJOVqA+KyHmQPDmQK0kXx
	 3xeNqsdLtzVnXxgqyuFRGnEXZZlMVTvpdOBt4Fxp83Rp1WupoVIDbitk4bdZMtvvcpw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795299941;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=O6MTsxR9ESdrf4eb9aW5r4naqS2hJK9aQ9a6iqwNlCc=;
	b=LePrA02llkgNp6TsxXq4ePBcUWENbgrjSKiv58bdvFlMbSkR0ZeiS1dZ9lTOuwbosHf4
	 dO80WTCs2/k+7eDRk9DXDpULHeYoMTXrDMguJaq/kxc7HVtPbgPRsWNB9NCrXJDjf9XhD
	 7oUxdzwkElia5MVGcheyuJt6CKsUe37u9eKex5HKhQuFp4vbq8jZFEGDhYHIdrMGcTWWm
	 o2ttIC9C1/AxMTEJbIBO71jIEmKonBEXtm4gQniSy8lAkRJeNeKtbCmp4YkZllO6RTGjn
	 ZVRcJ1g9XxTy8ibsdctEgeaff53sMmoMqNPcrdqAYPXv1WcM/sMQHKTKszLhs9Jfv4g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 59B291F000C6;
	Sat, 21 Nov 2026 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795299941;
	bh=O6MTsxR9ESdrf4eb9aW5r4naqS2hJK9aQ9a6iqwNlCc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=dFdV1NNDTGNUIXiekavnkuboPNpwKvxNMQ5UICwo908l1pGKCBELbENHU68LdVSJp
	 QIkDACwKV7wgKUJiXKEmek08bBcxI1BGgN/LffdkXH+M53Brqq9ygyqrdCvyZb0Xsq
	 7jxlb9Se7F2hmnz3O7t8pkh8KSxOcw9DtWA7Km3og15YLM1C6ZoRSJNa6TFgus5X8J
	 vr/artjZ5o9J+q8b3lJ/pIDUGX8hacCJIUq/k5ThPWmEVmgXe1RbRSDp7IujnoGD74
	 jsCpg1/KrZO9r2PJrtTQuY6aCNeWegdYEM/8TLsgMn6grl1rQhFitMX/nea8U82zLa
	 0PiXs5+YcGDcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DD8DE4BE1A;
	Sat, 21 Nov 2026 22:25:40 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Sat, 21 Nov 2026 14:25:23 -0800
Subject: [PATCH] perf dso: Stay in perf's mount namespace for cached
 debuginfo
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-perf-dso-ns-fix-v1-1-897322ddadf8@uber.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAQBCF4VfRXJva2UR5FbnAzjIulnaQkne3u
 PxOnf8C5SisUGcXRD5EZQkJlGcwTF0YGcUlgzW2JLKEK0ePThcMil5OLLqKemdN6U0B6bVGTvN
 XbNrfuvczD9ubgft+AGy1nlRzAAAA
X-Change-ID: 20261121-perf-dso-ns-fix-4a71bd206f04
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=EAXOQVOAn0fKpuNLh46HZnF+G1un7kl6r1BJ6M/WW0w=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrAhpki5k3op5BAKR22CQszWu6em9YTI3ai3BcO
 t0Wg6G5IgCJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawIaZBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtj8aBAAjJRK/Cjl5VXdRA1uhCypbwd/MdJJQ/C
 dWwRCO099FA6UsipOzsqWHUITdWr7dYjq3A0hYw0d/ReXxsWJaThQ80DLQlXOfnbJcO/T1wl6ep
 EeI1ww3x+amOB4o5vZAwys5IqSnXQybDCuizX3hwXd2vLEkjSpuDOyVDzijP476g+BW9JxY+IOc
 d4m5A1CSYXh91maGUFjKyLGrdN5PWBLT8yyH9D90QaJt8njtZWKerYvfAVBFUx0zhsI/occ+eIv
 +kCEXjZrqnL/0C3IhWDuTkdRC4ZNXKOkFQZyvrzzkOKg3M31BzE3kiH0ENmYRyydjcYeuxaqY3q
 DGVmXLjWeTykhBLTvnt3cy4I24j7t5PdnXXOQLiL5CQJeDHv5tTq1xnscNY0Vvi6NitXhdu4IBF
 WZ6s+ntYgDOM8M2vctBKmfZeigblNwdO29aKpNbjVlluwxqe63z5jcvZf0/83i8EprFVURQRPgO
 30OOGZ5jwYfoxAu94N83N4MP0NDnlGklO6TWtynqk4d3hx075YXQ/Pwl+RvDp5aOrtan9jt26sp
 mIVYtIqzB8O8I0vGmzqa3LOHQ5e9NycnKXLvq72Nyg6K3HWre8n8YgZsywdS+TzTUM0nOTtD0Ed
 YBiE1QysirCqXncOeaYAXQq5zlnIvbJobgbsc8Z3UiUN6ff5YQVc=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

When perf reads the data of a DSO that belongs to a process in another
mount namespace, open_dso() enters that namespace to open the file. It
does not do this for files in perf's own build-id cache, but it only
checks for DSO_BINARY_TYPE__BUILD_ID_CACHE.

Cached debuginfo files (DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO) are
in the same build-id cache, yet open_dso() looks for them in the
target's namespace. The file is usually not there, so for example
perf script -F +insn prints no instruction bytes. If a file with the
same path does exist there, perf reads the wrong file.

This patch skips the namespace switch for both build-id cache types, as
dso__load() already does.

Fixes: 5363c306787c ("perf symbol: Set binary_type of dso when loading")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
Found while working on lazy symbol loading [1]. It does not depend on
that series.

[1] https://lore.kernel.org/all/20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com/
---
 tools/perf/util/dso.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e46cd614eb21..6aad25e9d4f5 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -707,14 +707,17 @@ static int open_dso(struct dso *dso, struct machine *machine)
 {
 	int fd;
 	struct nscookie nsc;
+	enum dso_binary_type bt = dso__binary_type(dso);
+	bool nsenter = bt != DSO_BINARY_TYPE__BUILD_ID_CACHE &&
+		       bt != DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO;
 
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE) {
+	if (nsenter) {
 		mutex_lock(dso__lock(dso));
 		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 		mutex_unlock(dso__lock(dso));
 	}
 	fd = __open_dso(dso, machine);
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+	if (nsenter)
 		nsinfo__mountns_exit(&nsc);
 
 	if (fd >= 0) {

---
base-commit: bb27ddbaee56536fb8df0a24f07b526766dfe131
change-id: 20261121-perf-dso-ns-fix-4a71bd206f04

Best regards,
--  
Alireza Haghdoost <haghdoost@uber.com>


