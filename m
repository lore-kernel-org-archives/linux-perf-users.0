Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879137;
	b=ymX/Xa82ZiMog6AK0Q8je3VPgO9Pxfj8WAtmd/N+e1YyCdCfFy5Rq0eVRwooA0wIdAco
	 orlnZbsHIdwTiv3cLLllTrJZYw2XfaC+PlRnLZtxarEdWucYMV2KGWUj2b87M7wqy8p0I
	 7st81c/ySJXwP+4RUOhti6/9KBeGUIxT6qDrUcmxU0BXtzUtsOOPQaoYqxQa6AJr7+9Le
	 9Reue5jr4Hifs3D3F/5fRh6Oi1xfL7/UAQ7pobnvfLkc3dESi35piYupZWBLQzyxambA4
	 9Gkeu4SZJp7v9K2zmwnKV3aAAQCQZqVm6jVZny88i5Da9NJSyrZtePKiTU6YunajwjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Tm1JqNpkIR3AuQ9Vudhz2ZVhLAcgUVr0gzTf/oH+1qs=;
	b=snl96eNFC7N6xlTMH/ahbdvtFlFBTL5BzXLRl6EWg65PN83TQwIo7cgqFDGrR4XpwMl0
	 +xCPIy9tKQxrA0NOUu8uihvSqEy9Opp7XwRPJBOqn7bMhuR+kix3yZ9DX80nu9ryZtZUT
	 BkCrkGBdzvjTk1saTeI2hq3xHmm7qslb3y6kmb9P7Bq/6bBFO+2TZseh24Lcy5s1XaSp2
	 zDb4KawTONJ/e8m5WIOcM1JS487IJhfv5gRA9TTTZK0Us9t7gBhIeWDwwm4vPw3rM9LND
	 20MdJcOUslTqTjkD8q0F287YsI2oXOt1BNB3RKnyraUgXoA9Iy2Ak+x4I5/OP+jEIqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fdty3Cxx;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FA60A6F73
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A91FA60A6F73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Fdty3Cxx
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso16288895e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879135; x=1794483935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tm1JqNpkIR3AuQ9Vudhz2ZVhLAcgUVr0gzTf/oH+1qs=;
        b=Fdty3CxxZQa3Fbe8+i/1j18pyDc8cv8OYFTvZzrWBtctEw+HtmIMApE8V8QzVUnSId
         IfTrlbm9YCbm0ZLzW9oPu39vFDqYowwgkqnQHAPRmewSzYDeAQ0bLx3id1rc4/Ow3sle
         Enp0gcJrCRfwhR88A6pAQq32oGtNerO2TVtJfJX7XOanUgCS8Ppo8nOnz1YsqwIyGSmD
         eFZ7OwQI/7KGdS6WL61wWib32TfBCtX6RMJFMSVtBeh2lMwfnbKlry8MjlTivwilDGks
         pba3RhpdcRSt2G9bs9U71cpI89gUREB9N7Lueqy2ai2iIIQcm4IzvfaFzr/fH3GL/GCS
         HWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879135; x=1794483935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tm1JqNpkIR3AuQ9Vudhz2ZVhLAcgUVr0gzTf/oH+1qs=;
        b=JmAl4iw/Tl+AxR5ZBQFF0AifSQ1+GQx6Gm04C6SSC3N7HAv40eN6uWTcmczB8IQqK1
         BViprDJhNGkUwJ/VOMQh/y1umCvWnWG7uk9jWJ5++EeuaQ8wHctwpoFCOJTaP4p2wSff
         XSItpIFcKIBeaRDBw60mqzXCnlOY0uiEAo/GM3XI7QQ6acP4/AiQPyP+Xgx6Bhpd0b8K
         Mwe2gKgQV/ntB11mBtBq8sYXkQvdBiDhCa+wTVu/C5siyPSq+8cnztDm4pNq++4SYg5O
         Pzt9FkSqtrNp0HugF2uzaYrhgNdOzQyXncnDfx8di9vL3+zM5TbZyE+Xuiby489rhHKL
         vMYQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/OIFYffZprPtjHqnEWNmjN084mALxciQ5RIXdNTyJFSRBsDk+Ghhl1HhETABwPath9TqtLCD7poW3RgvpISb+@vger.kernel.org
X-Gm-Message-State: APuU4Z8mmmvbzhGVcHwFnQUMqsEguzdPH+y775bGocRkrhhXcTenBGZ7
	J3y+eybmHX2v8ATyxIBlL5TVvVFKj4lC4OQy7DJpAhy9f5vFnNwuVG7l+8iUDokTVz1qD2uM+1/
	72BlBdDM=
X-Gm-Gg: AYBFou0hSwb2BrDJbqtp9HNyWCW3OP06j8ZOwYaiCi0V4WSMBV7MDYlo3PrKE8eBhFl
	hM7CHnNHXlwL8tgIPkxCyQ6MML/ujFboFjp+Xuhwo8lIJWhYZFH1g6DjhbVxy2kE3nG4r0kq7lm
	V8s63IHB/TIcEoTsnBgiB/shRTNM9YhmsWHELuVqXCAqwNctAdeacc4ctdOZJuJqv0I1E5OYifj
	rMJme11zmdtMKhYGiM+eIJjkoGRv6t8yQoQRwUrlp3Vf+ZgDDJeS/ZQRT87nBifsw1xt5l54CdS
	Acb5lKk5/n+WEraSpZQ65YNjr5NYUwZrhCoQBhCIXztevJg38IIbT+ieF8/HXzzgwgCcfUdW1t0
	wofKt1v3rxo2wrVE70rRPLZ5EzwZNJc1dLTeP7ONY5Pr3+G7ck9lSz8a0uFVIw3pr1YWZvV+kAz
	EFbZIpyjlGwBvbHa0J/bzRCvE3hae5xRZLjtHPrOAn4ypuijWmh/tufpjssGQiYY621+HFP9Ol2
	ifjrmgx83Iny3FqPwWQkf2mpEsfqWKsiVlnUi3Our4oL52s9yXCfqPEbrSa3zF9Vhm5M3v9ZGfN
	8ehz3RYHN2bqFknbAmzQcF/ErSVJrZK/
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr410942325e9.9.1793879135180;
        Thu, 05 Nov 2026 03:45:35 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:45:00 +0000
Subject: [PATCH v4 12/19] perf auxtrace: intel-pt: Use common snapshot
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-12-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
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

Tested-by: Leo Yan <leo.yan@arm.com>
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

