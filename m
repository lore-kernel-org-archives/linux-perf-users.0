Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795279282;
	b=MZbfRpIu8p3LaAy7nwY301LyCck/7Ese/7n/ETUPdflcRa6hsAOW7Nl6toMhsjeenpBb
	 QpzMODJ22RI6KqVdTtz1Xg8EfgB9b63gvdXdK/c2hmgKqTDVw18Vt4185sWOWD5QuhBqP
	 h3VGDoJSt7J1PbpkON2FxiJwklVtp5rokUyArC6JTJmM2zCClnvN6/JYdHwPIEO69tDJL
	 KqXq0Ag5YAymqIpoG3mE4bI1F2gmm5yhdZ+OS3EFKN3Pr0Vp+HuZxXudpUiBXGyR38/e3
	 Ps/Yiv/IkgcC5+Euno/MzwF3iBV6JKH+hI3rWKS/uay6MXGxPWXYmEyTxzfoVpt/73g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795279282;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wddhUG+x376L1zWxDRCVNP1bCKGcfbj1AVsQXjGrYpo=;
	b=OomKzyCdUpSAtqo0cIDlSkdiSVo13oOoLqJdXjN9HPDMsBG09CZnGQB0a3dWdK2nr5ue
	 BxEcObXDyJ6zNDwaUir1Uiac0fUPu5n4zw1l1Bs9vzWQSJi8G488xjvjuoTMyoUCUBPav
	 4/SjqZOfdSUcY4RSyC5GROI7VXX/hyYjR/cRc8dBSkculvv6Hpa2RHWTd+sbe9a5Cd6BU
	 oRvl/Xk2OSgwQJyFXffKOwyS3wfn0yIoP9aEfB6LlfVGsSvtmNwl3c1LoP/7qtP7PEkMQ
	 mm4NNFS+Ipqx6+kv8t7X4EsXoynt6gak6u9CPiIzXqyvLJOlY6KDvI+yGRUnSbUOFDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxDk6ciI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E8606A320;
	Sat, 21 Nov 2026 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxDk6ciI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795279282;
	b=TrN4dagAjdfNKISAX2ZMur7wgVj5sIBlnzrVGws7YFY1S/uDwV8JSX/x685MDUoR9LYS
	 alC7Lb+mCijUocAn/oq5UVCv25UhzpVLS5cp0IePy2b47liEzRr2cn0WVxgipsiNnBiM5
	 mV/OA8mCkNokXaAUlHzGOjILZhGuoWdEyy1R7XXv7LYYsLzo2r76gEQuw5g1pQ8tmcbDN
	 93+IpfddZ2OdRN4xzeyiTNsUPUzeWxbaa/s+oJQpOROOmx4Pv0WyPTnhUiZH+ovAxgQXT
	 Lg1N8zQVH9Li/c2xJEYfL92rQL6ZahAXFaZ2ITz55CqUYsFuJL/qPG4rObuTrN3/Q6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795279282;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wddhUG+x376L1zWxDRCVNP1bCKGcfbj1AVsQXjGrYpo=;
	b=R3WK/UHQJnkQGQrwS4m13pwcLHYVTyj6lSy1Uc3XC2mm48nxm0Fwtx9u/Diw10DGDawv
	 kVC6cARvq+0OXsPUETNbSXG02frieoIW1jgtj522t++Ya+A3hk8uWw+Biqnck3ZPHI01C
	 ncH2ZIO28u62mFkouPSDMOH/UlBx7Yoitdm1LWJ+qq1DjxV8Oll2Ip04V8TjX8fXFOCT9
	 WIRSGy3Shav+HHMQdnHmyfhWBfMhv7yLygmjbpp2nu3x0i0efL+PCxp5+8R9B13nva6lI
	 eK+ENbFRJZMA8EhrpMIjPN2D07ZLF54T2b1OK+mBbO7o6CK3UMcmHce4dZvkpjOxccQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8EFC51F000CA;
	Sat, 21 Nov 2026 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795279282;
	bh=wddhUG+x376L1zWxDRCVNP1bCKGcfbj1AVsQXjGrYpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HxDk6ciI9+OPdOSincbQQw5MJ9WgXvkrQ7Lp4lIC0szomGD6rTiKN/Cy6iZVb6vT2
	 XfuFYEVdXgsooXscpsJ2LGDUasQjK7PKlWsisnsyCaH8bjhT2q6HIX3kDGjx8KAYTN
	 E9UV9JEsh58fLI8hWnOU+/19fV13FDTfyFqKG4RqSHCtuxawe85dI2WQO8Z9byIkZf
	 4AaggZnmzN3CvfErPANx+QkO5fdWGaqNuywz3Hr/6z1JyGrmsgSCZbCR7fyi6aIQYm
	 drJOBtTwHVxKBtd5zpk1eN2b/unAKeJ5fizEzIz8jbxLAFNDy8M1/zsFeLxxJ59C3I
	 5CtUU9TWi+Fng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 16CBE4BD08;
	Sat, 21 Nov 2026 16:41:21 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Sat, 21 Nov 2026 08:41:02 -0800
Subject: [PATCH v8 2/7] perf symbols: Point to the symbol name instead of
 embedding it
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
Message-Id: <20261121-perf-symbol-memory-send-v8-2-370561cbb5a7@uber.com>
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
In-Reply-To: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2165; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=X3XQyODxuaREhcHmNWercdhA15/A72ND/YbOdegAntc=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBrAcmuCxVQhqj5c5cxtsJ21gBCGQlnUgsnKHgHl
 x9p+gkMARKJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCawHJrhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtjBARAAjk8ev3TdlAfVl8vKlDGeut4Tu0EF4oj
 Xamwc4TT7d82OOYH56fQJC5s9cTcHlLpJnATyP/pXAQ672n0+p6DRHyeiWUNslcRyOi9B2ypzjk
 PAAqLivJvf7OFKeszVP9MBw/TlswxmPNHg+V57sJmyi0EW0M+BQ+e2E79+j4JDytT2v0nQxKidj
 b3kUAX+L/U+FcdaRRiOOwY8SEtPbtKtR3wU/oh4UCKk7AvCn+Y4gYk51GH28Qb7lHKgrQPkUTzu
 gIXJ8RXc0da4iv9rFSlXBN2S0VxqQCDpnxqTCLaLtmuv4oww/b16EwQKPzj/JmdhieBUFtLvgUz
 rF3Hyx8VTjk3uc3uRvwCY8OIXasMN2BnfpO/vDBRykztPqf6ezY159oEOEdeiI3yiBBY8mIiLE/
 NALK3GMFiy/dTPfEeY4PcxmmovF9bIQYkyhrOBmaTmQmz6Y0zeYKt4NsURKu4xaumV6V7aCK7H5
 SseaBUG7UCB8kS9m6YgkicoMBewk7q6rBl/wrvx/7I9Bd+fcEQfOoml/vlsBE5GHtZ28bhxdJfE
 plcABb50WyHyoAZG8lHR9WxpES8ssJg/2FM7K14girMcyJWNebITS8ezQKioGFf+qYzcix0BVUv
 0OC/onTlkyK9X/B8MyYPPnU9B2IwjslqatSFgjPaOsxcpBveVMr8=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com
Content-Transfer-Encoding: 7bit

From: Alireza Haghdoost <haghdoost@uber.com>

This patch changes the name field of struct symbol from a flexible
array (char name[]) to a pointer (char *name). It does not change
behavior, but each symbol allocation grows by 8 bytes on 64-bit hosts.

The next patch creates symbols whose names are read only when needed.
perf does not know the length of such a name when it creates the symbol,
so it cannot allocate the name after the symbol. It cannot reallocate
the symbol later either, because the rb-tree and the callers hold
pointers to it. With a pointer, the name is allocated separately and set
when it is read.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 tools/perf/ui/stdio/hist.c | 1 +
 tools/perf/util/symbol.c   | 1 +
 tools/perf/util/symbol.h   | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 3240c39bd025..45841eac6f52 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -106,6 +106,7 @@ static void init_rem_hits(void)
 		return;
 	}
 
+	rem_sq_bracket->name = (char *)(rem_sq_bracket + 1);
 	strcpy(rem_sq_bracket->name, "[...]");
 	rem_hits.ms.sym = rem_sq_bracket;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a5ed8a65986b..ad4bf7685293 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -354,6 +354,7 @@ struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *
 
 	pr_debug4("%s: %s %#" PRIx64 "-%#" PRIx64 "\n",
 		  __func__, name, start, sym->end);
+	sym->name = (char *)(sym + 1);
 	memcpy(sym->name, name, namelen);
 
 	return sym;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index fc98fab1c8d0..a449c170d834 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -92,7 +92,7 @@ struct symbol {
 	/** Architecture specific. Unused except on PPC where it holds st_other. */
 	u8		arch_sym;
 	/** The name of length namelen associated with the symbol. */
-	char		name[];
+	char		*name;
 };
 
 void symbol__delete(struct symbol *sym);

-- 
Git-157)


