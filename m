Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621754;
	b=hICKDdLnH9q5kwxvPkHhMXFq57zXnWR+AXA95i2aIm06wCH9TT2sCp6cFse8Xuf23O2r
	 w5QJ9L/5hQ0kjE292pVR0EcUeP6X49v7wcqyvnEgZ3qvg42fnzfk4ANpEJ6PK7yIh3ZSe
	 5wRCPVnhXYss8kyJAGQACBe00v7KGt3r87Vn/FyeAMj7g+QZjm9HbMK2ValqrJmFmiA8S
	 mzfEJeNj7ltd44mEsJIicka/QaeFt/6mF/oWjfJWOldKcBHOGTSWeNumIionwu9x8PFzk
	 xT0Qi3KAKgPeT45SudlZhaQZLdgb2V7xHN0y36CO8WR+difpisSl9A8ggGC8+6oCvkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1cPbn7Qf9c8iItDK/ZSc6D51DtwGlZeo5sCNSCk2nEE=;
	b=4+NhpiaLGj/TEoeLmXZpwoJYLuZ7x8eyyyrQry5q740mC5ej7vGPiiXWOXc8ezlF87X1
	 BR+zysv+V/h+8Z+MffU9dyuaLSsl/Brdi5K6QvYRK4MPik7fkA06rHu41wiE2ojq9EIHy
	 Wwi+0tzcwfFNkcQ+Q5EAfzGgOyGPmeju69PlDh6X3HYcLabz9cIVorWG4jMBxedcFEkN3
	 EAETjn9IbP2kixAYj3Sz9zzmfaeY8b0s2H9PBzcaOHe1Df+10Jmx6r/Ua+jyajALYED+6
	 mrpLqOfoLMZEqx7zMhpgpnjR2oDaE87srHh4bb3B3Zvb2YFydNR+l3cwhferi22OWHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rs7ppWh5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296960A383F
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2296960A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rs7ppWh5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so33428455e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621752; x=1794226552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1cPbn7Qf9c8iItDK/ZSc6D51DtwGlZeo5sCNSCk2nEE=;
        b=Rs7ppWh5LOcpqWW3A1bBhsv/akEFHl7A6JUhib1Nh/m/6p3C0G0aMJsshRjBkCPoWj
         9S7FdMsIfap5RarP2e00IbIdsFQ7OwGCWUlWuFOfuaQ45B0OqNE5yZrm6kY3EaEVOOxE
         uKpHiSircoTdJzv+fMYCTjrZZZgttF+c1qKEJJtdGZlXSptPyBAcLrkTo3YUBQ4/Znd/
         LJ9rxMkBrlkySl7nAu6cCdvQvpJj5M08WyFCoHAw5C2FtIvJFGskunQk9mRXv4R/Kxga
         jc0KV1COTiwPesrGn4R8cHj6r3bdYueVIvEBPLAgE8UO93punXuHDqBVx3/r/fwX0crV
         kBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621753; x=1794226553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cPbn7Qf9c8iItDK/ZSc6D51DtwGlZeo5sCNSCk2nEE=;
        b=cAjWgmvnWrbvHj2yfoegr6/CImii9VD1+JHoxU6u+XLchu40NZNwQcjzPsBzckM4k0
         WrKHEzWudFwElkvqmtf0yT/GqaxMHJiV5vE9ejlLQn+dAU0C1VhxLJkFu8oBFCJCKark
         cZN8cGB04uV5+jkpYu+qOAu3GWWuHPXIn3dN8PK63d+U1XjcpgqDts6efWxPuzzLgpdH
         37ZdSiLjB7qMSXdkxMrd/vFSNGWzSoDi4h/4EcBhbtXbOuUKmDxnvEqpzHDq2JABpCCl
         1Uv4KdjRazs4E2l8PRHnoPuDC/Uk90bq8FTVufl8ivuKaomkrHSvbyCFZS72EL0Ou0ED
         uzpw==
X-Forwarded-Encrypted: i=1; AKwUvBwAnZhJIQUpPNxy/s/2UDgUy/D79vTLqYXNUGt0wlhyg6+s2BxvkgJy2UkbtF5J9rewji7Yx0HtvfHAlKrbksxw@vger.kernel.org
X-Gm-Message-State: APuU4Z8CRNpoYsjLsXvc/D58/PD9d+s8VqdHjKO6YX8068zl1D6l+K7X
	SwFjQFKAgZ85e8/Kt/RD4G7TRSHQEvv+eaeskAD2Vr24xA+KKvJKErT4Oj40CmsLuk8=
X-Gm-Gg: AYBFou1AOZ/wLrNvzREj4xycB8DgeMHqbNld+mbDi56/H4ZHfTkvD6lYSsNVTDoskLu
	6rtL4McspmZrSqGGx05zvwMSG3293BnhsfhcoA5cX5sfiTPP/5gj+gXdAU8+GH3kI+W3oYMiB7Y
	Nj2eHHmdhTP1Z1p8jdh7rMuI1ZqhfkAeD8JGQXlDGpFrzEzpZg4ywoM/Gj5GzngjjlSZTrh4549
	Nj4L25dCxFgp+57ujPXoPnqVltz6pgLvXnpGDePiLWONJxH8Hmz95ue++d+cm3hCX8BScyy+CtT
	0RTHH9mezZnQVqkOZv4osaHrH0QZeBsbnZ2az+z1hNxCHJbW8MwwLhSe5eIo7cN3mS6lEbGi9Sk
	m9juds9RzSARMfwe9bNgIo/VCwO6Ssc4wKmWUN3GdgL2567mOPoT/GXC4KeMhcwp+eXQL35yLHS
	bFdPEjKdT5Is766wVizmeQDpaab2Tz++25u6fGZld+HHg29/mZm/fe2cDi3Sb735wIou49H2DcX
	Yn8JBX2QZHQjsr3HQv6K6Ho9xEmdPYii/X1U7+qWvGTs3GtSyno3l6a1HamOUvARB+iFn+4yfSa
	vknbxOd2B0DWxBuin273AFk26MifZTxf
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4ac185bc4a1mr230066925e9.27.1793621751493;
        Mon, 02 Nov 2026 04:15:51 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:51 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:21 +0000
Subject: [PATCH v3 07/18] perf python: Expose sample instruction length
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-7-dbcb0c281b9b@linaro.org>
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

Expose perf_sample::insn_len as a read-only insn_len attribute.

Trace decoders supply instruction lengths on synthesized samples to
indicate whether an instruction was executed or not during a call or
exception. Let scripts read this value directly.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/python/perf.pyi | 1 +
 tools/perf/util/python.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 087da00728fd..525d34ed08dc 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -215,6 +215,7 @@ class sample_event(_sample_members):
     sample_data_src: int
     sample_insn_count: int
     sample_cyc_count: int
+    insn_len: int
     type: int
     raw_buf: bytes
     dso: Optional[str]
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 60dbe2dad5eb..d2aff058eb89 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1380,6 +1380,7 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
 	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
 	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
 	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
+	sample_member_def(insn_len, insn_len, T_USHORT, "event instruction length"),
 	sample_member_def(flags, flags, T_UINT, "event flags"),
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	{

-- 
2.43.0

