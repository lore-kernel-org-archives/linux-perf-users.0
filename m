Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621761;
	b=l1g5hBPU0AgWlqEmOJYYqXisbTcqbcvgRqPVEVtc8/7xgFHOJDiHM9kpBzebpfTl7zWa
	 q68qw3jTplAmGpBVqg/JiZ6varT1bkc+WK36ymT2j5Hv0lS9kqVn/+rchdqLYMo/3wWWB
	 0nyuMSCMA6q3Uzx0NAV9YRK3U96VVPdO/kMdRMG7fSXMYFZfs4+1ugGvxi3JlX1aimMP4
	 hV3TMmcsfnxw/NSq/f1A3ubbQbBAXNkUYWvK7Ke9c5B/EI9Z5+SjsJKIEBJZsx4FPWamH
	 uDTw1btvqJsvuhxBjd6/HQX09xDjLd52zXXN6wBl2UW1UR+EtZE3TcAkPHu8tX8op+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=S4s5XiFFed+m0dwtvV2BD0K5lP+U3CdMGGYPhjLKYQ8=;
	b=mp7ufei5LlK4APAuv9K4J2Z85DPaeNh3iqXeYGtLHBSUmXpl3ADjIzg6LPFyC75tZ0tU
	 ueNa88Zv8qxM3htQcA3l4OVYa1/5EXL/T8G8WELmE9XUhF09KnltLinJnNBYedhcYB0Rg
	 XNZhxrIWbJLT3BWCFlhlsi0CG2PtOUHJPgLHVpsyoh/Q9WBmb0L2OHpRVpEefoyNiQyE6
	 bBECBqsdZf5nkA5bqgPo1K/3GfHHoj7dc5KD3hZScvExqR4rGTLHfBu8lZqi5IBmfYIUW
	 iI+jEDOtdcN2H4J8k4FkLIFtM29n/KLDebA7Hr4+m64E/S4wc5sX6eqe5qmd4oMt8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v+k6p67j;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5460A260D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D5460A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v+k6p67j
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so29917065e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621759; x=1794226559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4s5XiFFed+m0dwtvV2BD0K5lP+U3CdMGGYPhjLKYQ8=;
        b=v+k6p67jlSCCtAFLTJHEr/fOP9jUFtDJoZqJvF4UwB4P7qpSBHVS3eUZvY9DppleiP
         ncB/xEDSRl37A0F6ns4DDzlZP6inyg5KWPo8e6ykcJk30dPKR5DnnEUgn0WrLZc/xAnd
         N0QvD6LwpBeF+HSJiazvoTsSciBmIy/nKEFxLq+4ijHyKjQoW3xxnAyo8OtnpRiwzQa1
         oRTg0fI69BbAXuYXlQdTgcLOBvUbjpBfw7v2UmLtEse94ConR3apsuQwBAcl+6TeEJYZ
         jH0MHdU4hFz/923Fuha1P6EBUsNwFW8Y6YklDiL3BPlWBon+mOjM5oOm6WDpzRPsucsD
         mESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621759; x=1794226559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4s5XiFFed+m0dwtvV2BD0K5lP+U3CdMGGYPhjLKYQ8=;
        b=EaP9IiFwjLigrhbmy6v2A0XGODhief0APy1sZuoH2uYtO4w53ketc6wu3zWbAG5ghO
         pR1Czv2Hp4ExrtF5o3no08Fd4q5kzhPB6EO1uqzAJZrf1ahQY01Qe5vqx7amy+IA0LaY
         LVpYmU5dVG4T/oAhJHsWAn1XRPrwxfI/Qc/+1SHWsGMitkcyXDfbamMkVSGR5FKNH7bv
         luXBNgeAxULNWMU+LqxgKl4J5QIwp8eqMkj800WDbH93Fx8hMacWzDdocxR/oCwprX/2
         0zgYL9aCgnAIzCMmKtrrRQMNZ8/FP434b30IEWrbW1Lle9Y+jMvHIW+Ae0SAxjdxAdqh
         u+ig==
X-Forwarded-Encrypted: i=1; AKwUvBzazDiHibnODl/CzqlcAATgnmCzIawOxR4HLSQOQZ3xJZRtOhCQuUBwCNZ9AMp0OJkgwEoc+K6lYEIur4RmYzRU@vger.kernel.org
X-Gm-Message-State: AFq9FYLh3L2g5uxfoQo66bKf/Fek2awmo0fddBTnafvzmj/8h8nhJzBa
	mRDIN1VxC/QnY8WNDt0Dw74Bk1GF/F64hPqt/VJrQgqOr9NUiCraRh63KxJ+FcPzUbQ=
X-Gm-Gg: AYBFou00mIcsYJP4lqlPEOep0op3uegWHp7OxGzIzNfeVKNkZdwX2zdc3Z2Ls0DkSAw
	4ecsOQuG7gbDbx4ogkBRT9X99q5bbXMXPqKPIutp20f44AJAZIW3O+dv+6GWzn82bukh+QDmsQh
	9B6uhw+hPJnwbenrw2OOu2f8zd8urCxyEsWZI06lPf8TFJFeli0EXzTHIhEWvWEXWvEL6v5DaOH
	Z1tJdp7oXTb14wqhEMWFW6Dp9nVl/uDoggyc9viWiChUng457dbzKowBy89z48s1eobiaKKjAxn
	7Shqq6Tt86IudYzh5oFnNW/j2mvYBEYUOoZI1IBprrj85CEdrFo+B/dCM/UvbY0RQw/CsoUKGqh
	limpWofEtIOgOKBjBvDCvY6msA2xvn9kkacgCmfC/MSZNSZ4RXKnq0Rk20ORGiKyxKUUP5FqB5k
	qoHeZkYA1lagD2smXZUbPK+gljAGfRvgVwlBT92Aw75IBHjL106yiXMpnLxTtRBE038xZSz6WwE
	MNrmE0OhXsXGQdnILBbkhuOIA0/O1cS9RlNVagFH6jYXk9/BCcSe917arRRsN26d7UeQwZOjPyL
	VtA75Gwkh1XZwP7Xpr0NSbefYZ53MpCZ
X-Received: by 2002:a05:600c:83c5:b0:4a1:f377:5c75 with SMTP id 5b1f17b1804b1-4ac19329ea4mr197102405e9.33.1793621759044;
        Mon, 02 Nov 2026 04:15:59 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:58 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:26 +0000
Subject: [PATCH v3 12/18] perf auxtrace: intel-pt: Use common snapshot
 pointer fixup
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-12-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Intel PT has its own wrap search but the same pointer fixup logic as the
generic auxtrace_record__default_find_snapshot(). Replace the duplicate
code with auxtrace_record__snapshot_fixup().

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a533114c0048..ce854209213d 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1150,26 +1150,7 @@ static int intel_pt_find_snapshot(struct auxtrace_record *itr, int idx,
 		}
 	}
 
-	/*
-	 * In full trace mode 'head' continually increases.  However in snapshot
-	 * mode 'head' is an offset within the buffer.  Here 'old' and 'head'
-	 * are adjusted to match the full trace case which expects that 'old' is
-	 * always less than 'head'.
-	 */
-	if (wrapped) {
-		*old = *head;
-		*head += mm->len;
-	} else {
-		if (mm->mask)
-			*old &= mm->mask;
-		else
-			*old %= mm->len;
-		if (*old > *head)
-			*head += mm->len;
-	}
-
-	pr_debug3("%s: wrap-around %sdetected, adjusted old head %zu adjusted new head %zu\n",
-		  __func__, wrapped ? "" : "not ", (size_t)*old, (size_t)*head);
+	auxtrace_record__snapshot_fixup(mm, wrapped, head, old);
 
 	return 0;
 

-- 
2.43.0

