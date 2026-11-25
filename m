Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619555;
	b=rMzVq7gVK9leD3i0Pcpj2z2uDlSIebB3rJFKJS+Ty7p8OEXmwFbFvnNhtsc8KSmki3pG
	 UppQwIPxl4pZ1r0nMqgmE/MOzKcCqd+a2X3zyKp8mu6DvhQKXIe+EAjtw3kiVFrVnMwCm
	 SZOiODrro2KsOIPrcf24m4InZQ8XL4a8pnswU0Fp/1cbfiUmxDYhwbqa3YVhPFe/GyI5T
	 6RcnJgvd65q+EXfb2WiEjF+TiiGzLqQavv1D2I/GZgjEAFJ8yLTKiOCgsWcDxV/bLyMBF
	 bMpx6rDVaUczoDF3okVLFtAvCbY8y/ItfaRop8Ly/WLd3i6ghNbxHQ8EjHB+OL3Xfrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xo7WrNxk6dDX7UKfTjZ4Wt8i+/bBKGXUCuSojJqGcJo=;
	b=CERd1D+5Xx5CXFVKtCoEB9v9Ee6UdMkGgNuGqfHOlpvNCA1bJ2jb0I6vyb90H8GYslMW
	 EZXwBkKDnDFzCMZJXMJ+N387BN7VUeJ/HdS/h83tgkofgrbguZBvD4BdQqduCn6vJSG9g
	 ruUMSH/KEEQJ5mT9UhXUvuo/hEjgkSK02Vsb7UyJIww5LCLBfy5z9iBbnCDw5lPHPRY87
	 Oi5MXv28X+r15zwY+xFfVUVLexubWQsiWhsJ0XKqX3XJipqhZ4ZNL630xs2BrpALb0z9h
	 G/GUnQ6plwo32eoXZ+OFvxws90FYJdPFpYfGWSVaStj+Qh3m2lQdPwTYFwtpRl1czmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QATYt15W;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E7606A32E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 15:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184E7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QATYt15W
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so63530405e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795619553; x=1796224353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xo7WrNxk6dDX7UKfTjZ4Wt8i+/bBKGXUCuSojJqGcJo=;
        b=QATYt15Wc2i9zQCF4Mx/YgQf4+CuE7f1zDfg6RnQkma8WXyUsfpY+83jhy/dnVXOW3
         oMFMgGozeiesmo6n49VGOqCfg7utivB12q1lOCQjjbkrpAt7QYhAi7HEuJnTgE3gMlwE
         dFWqMaxhebp10aUyvV6TjN/RlpTrEHvWWpqEuRGy6pmVI7/q3EaWlmIJt9XnqKvlyawy
         xCHBz8toWYSo0tn95hHMrhx2BYq44rEXmXldrdrKKYIArA8RJoOtABmRkaEPEO9BoNnX
         A2JFUjyrR62DK2RIqKNfSbNO1MPENqaku/wCsFVyL3FitRqjm8yjZJOXj7Rv9VwIHkq3
         uuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619553; x=1796224353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xo7WrNxk6dDX7UKfTjZ4Wt8i+/bBKGXUCuSojJqGcJo=;
        b=JIYhHFJLa58Ul9dyZ05oJ8FswII6RuFcRZhhstJXIcWnHajt2TpswuU/4zWLti6UWs
         e7RwMEJ0Assn+BUerxtLdCUrr4J8MYx1o8Gx8qiR6CSDtpOHOsS/Z/nM+gVq+z802xjh
         iZIusWuFSL9keeWRoMq5w94+3AlEA7+wNKswe7hcYHsEe/PPsryjjF8GNWQ3EtY8sX4Q
         HCqd3kDeBLBN06F2JQctaS6LRLZhruykTt5M+v1VvwBnlCTyIsaIW3dpuyqetF1+UB/s
         eUJIOO9gTVxJMkCFDo7/zqWlPT4FgjFYBoArKz2pPx6RQbXi4fjab9U5WFYVq2OjkaXH
         D6uA==
X-Forwarded-Encrypted: i=1; AL+hErFlHHSeGw/jDr0Hwp1y3sXOHrcFXfPY4dfG/ryDhhFBc8MFkbBx+lBmZag0xcjoTzMy7LiaM2YtK+OYlNHHMz3k@vger.kernel.org
X-Gm-Message-State: APuU4Z+/KmX6doXcOeqQnyRJDGsS2zg03YRsWN5DuoSoo4bZ9b9JAMWR
	1TSDsx1ftUIzLWN2b5SOHY57CKJnkR1KmVWpf6EJMDCbDklazXjPWxJaE+5qNptAn+o=
X-Gm-Gg: AZFdTZeGrPSZNy4141XR5jwLrUluGp11dljth/jKwbni3qAYcKFcP08O3rxAarZifBV
	fPuoB8oOaVu71gxFykEyDDxXMrVgqY+W1f9IO1xXOiU5pmkgeT9nWiSFHloHq5ibWdoDLYJ4QYL
	wPWGNebkPLkM6UAd71G3YI32R0JIf7CFuDnzCPq46PE+RaTJ26iooVlKNPJ5X8Fp/aSubC/SPll
	1zRfC70g1/lBszahBfQoxswveJnwyHHMGkl4eD7pDfJ8Y+6iX3iiQftu37T1UXBYdpyk1QkzGBE
	0xpoZlsbj3HVBN9Rx2AoQ5mPTJnpRbCxYBfJjeKS52pUNs/+q2iE01qd0lHmpQYe5az7ItI25T+
	+WFgIyirSyHVQvhZiNvvPq/AGvrk8+RrlxjO9tG6aeyLeRQFxGnKxj8bp20D60RhfcBwz6NIykb
	LY2vgC7CjOM427GugBsFgHjJTeUsd5BIdELSH71tPuZPhS8/TLeB9Eq2ORdS0XAFf82sEbY/ncn
	ZGfwwGmyrnpmVZobPY1lUEEIzyqizQ8vBKfNomiPmBE5Z/mZDQ3LAgbs9/V9UOa3ZNdI6I6z9Dt
	5Y+jumsy31ncdY6UzD/Pg0pntj90bxfR
X-Received: by 2002:a05:600c:638e:b0:4bb:6c5e:b006 with SMTP id 5b1f17b1804b1-4bb887e265fmr343043815e9.3.1795619553431;
        Wed, 25 Nov 2026 07:12:33 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm39845282f8f.24.2026.11.25.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:12:33 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 25 Nov 2026 15:12:14 +0000
Subject: [PATCH 1/2] perf kvm: Don't pass an ERR_PTR to
 perf_session__delete()
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
Message-Id: <20261125-james-perf-kvm-live-file-v1-1-946f478ce2a1@linaro.org>
References: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
In-Reply-To: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

If perf_session__new() fails, kvm->session is left holding the ERR_PTR
value when jumping to the out label. The cleanup then calls
perf_session__delete() on it, which only checks for NULL and goes on to
dereference the error pointer.

Fix it by clearing kvm->session before the goto. builtin-top.c and
builtin-lock.c already follow the exact same pattern.

Fixes: 6ef81c55a2b6 ("perf session: Return error code for perf_session__new() function on failure")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 67eb3f667c99..785b761fb951 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1926,6 +1926,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	kvm->session = perf_session__new(&data, &kvm->tool);
 	if (IS_ERR(kvm->session)) {
 		err = PTR_ERR(kvm->session);
+		kvm->session = NULL;
 		goto out;
 	}
 	kvm->session->evlist = kvm->evlist;

-- 
2.43.0

