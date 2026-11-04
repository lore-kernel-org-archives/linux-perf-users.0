Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818171;
	b=PmSKzfr0YtfwSpXlzb18EmGYstE8OOsfCGHYfHpiYdtzCHHEgD+nYsY0U46/oCW+wPyE
	 idAhOWQsAT3lOVbwDqbr/+I+h344IofxRneg5L1OrpgT6A5TfBi9MrbWIRcnclyuMCM1/
	 cO0JvaXRtny0rQMhhVELnejnd+SgO/fsaNhh4kOUG28my7SEj1P5hD32QfUWf34aQhPVA
	 ojWUZLOCWC7UZS2yDMUAhy+SwFCTi3LMwYQw93rGu3k9OiA3WB6H22tbsaJsK5VkYdq7R
	 mNsftK3K0F7dF58j/lS54a9YWyWKmHlruQ7Mr7a31+3TDoy/JuIRXFFRwlfm1IoykTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=yqpx/mpDeXMZXHlMMGG8fT7M3snzQ/eaSZH/S7I+jLw=;
	b=fd4dJzsqZGmNqfJ2OQhpkpUlS24JmTiDCcI7tQm9uDMR3qNaxELm78/gykDV0zYG+C83
	 XQL8U4o/5aLwLSZgmDQNHarbfaN9cJu2Xdc74zsJo916u/V+gX8diXKNwsj7Uf7xbyAfd
	 iRjGp/4tbBzJslETbLmWsJAUaxdscwbJ0rKQaJvPm/f0BDm0g0oATrt6gj0cD+I4J9eEv
	 0zCZf7Ibug317QXRTxldbmBBBLslzzstFW2rX5gn37tQpuqn0JUJyqOF4TWEIB3R0opU4
	 Un3Q2opndWFO9iTfqyoRoJ2NT04yDbDo1e+wZaPVZhypJKbn16HeMbJUV0BxfWwf/UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBcvN3bX;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D46083619
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 604D46083619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TBcvN3bX
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0a921ee46so10485697b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818170; x=1794422970; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqpx/mpDeXMZXHlMMGG8fT7M3snzQ/eaSZH/S7I+jLw=;
        b=TBcvN3bXAtfwxVhcDIjc0RC/pX42zn6EaoVCD84MEzTO9LjZOK+EVZ++2sEVgjYu0H
         epp+4/B5E5wZSc704IMncCP9lZa02Vr4XWgqs2bPcF5UBV4+KI+VSZUIFuanYTx28y9C
         TLlCvsTK9p34Q8Zm5Pvp8Z1YHVvMQca5O2qji3kwMOy8Z3ywh4XFsrb492G0yEX67vM4
         3CQA6B7vBVvRLbZtfjbzwnThhfc6j7lSV0a+ZmmbQCH5T0EXSpqWHB6rASCGIctZZR5C
         GL08OMePQxiZwA1QIimhGY3G//Vj5Zu9joAZDTuqbyN3BfeCMOvUtZxib0gVA7tX+nm7
         g/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818170; x=1794422970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqpx/mpDeXMZXHlMMGG8fT7M3snzQ/eaSZH/S7I+jLw=;
        b=dI6e9p77tJ8cG3iSq1dhF2ipXgGeodBC19gKTMqxI3krXTOx+f9gH9CfqZFAxPC/Gd
         gT0/h4dXUOPxHpH7E0BBTVOFGRvc2YEZgxh1seV0gFK61j5yZqqFNfX8aWSYINSeztxC
         aD33M7c7sTAnDSKuaet+QN6pBwzkSrPq5+GbRdF7n4+FSQxzTU1iUrZR4haqaP3IbFfZ
         EtEXNqTpQ3TFeGOnhybs3ynAeqzAOZo5uZWlSmEhRn0y7kHIz6gVIk46cgIM1XFBdXUJ
         AaxQ0UjkXGTcue0++fpWZcCY7glOQHtEI7BA5Ey31ptmKtgPYLMMWg++n1U4F50p8HM6
         FDtg==
X-Forwarded-Encrypted: i=1; AKwUvBxloHYxlM5Jfa3HC9sQcsj3AUCudVDoNB/TmNNZu2ODTGV6Ud+Ez8Fcpkhq/oM85V1hfUmHDnZQke72zq0lN416@vger.kernel.org
X-Gm-Message-State: APuU4Z/eeNyrj99gF6CVlT6EeMIx2VPRWarueh0CRJ6F+zC0BdzzCDyd
	raesNWbymdqXhgMe+hddKEiAe6UNQez6FIPg9Qp/53j6A0+j2gXkBgsH
X-Gm-Gg: AYBFou12ck/e2C1ntffYTRJLLT5GVvcndEzHpgN9rqBo4k9yUQxijClwlQxEUe6RX4N
	HIabjWu3tA0d81vFS6DtKmZy4/uQNBe5Ur+ur2Rg/LEqVsosUGo6YxDS1DGvv7m+zxMMjV8zUTv
	wIf/GfaOA1IInFcLG3EKUpYx3+dJNSL9rR72VJN7zXcARS3DazroJYQ5Ur7YWeLKrlHh6Q0ib8/
	bhhgOnViho+n2Zjp+QJ2WPc/if9vfg/xCX5UYEP/bS8caoRSwsiOuL/GGUSEMo0mn6RhY+dk8ND
	ohJnSHLBEcydo1arngwd5oxqUAbeXpVMs7tTENpD5brS2ZqBhci9i2F6uSN2XIBa/jWLLoPvilD
	Y0Mat/icrZK03GmyMK48/UU5vSnyAki8qyzywyXHp7HCJwd+7FDGSGViHOmycqWzUSpnb1POcOm
	7imWCFnGi9x1u5YF1fw/HShwFJ/wkCNk1LpfzhX3yCnNiyOANa8+mdi32rBUk356HglSUEs35dD
	4W0A/PWtRFicARJEqXsW7cgF8+qipmJYs9Xtv9M5Jmgnh4h4U7BdU+7XbqBGQCGNb2I6BWRZrKL
	jUHiXI7Z8X1itWqeTDxz3ovlZ6cimfZDrAYh1pHqL0bODowevI3fSIfdlSpOKmIrrsdqAewM+0g
	zDA+JGOWd5A==
X-Received: by 2002:a05:690c:e0dc:10b0:8b2:aea2:64c5 with SMTP id 00721157ae682-8b2b67a4c2dmr71395087b3.96.1793818170428;
        Wed, 04 Nov 2026 10:49:30 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:66f3:d5d6:2d12:d460])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee28e4e1sm1983347d50.17.2026.11.04.10.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:49:29 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 04 Nov 2026 13:49:19 -0500
Subject: [PATCH v6 12/13] alpha/perf: sample only retired instructions for
 precise events
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
Message-Id: <20261104-alpha-profileme-v6-12-63362e9290a3@gmail.com>
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=dXinNQWRSOHUF7W4/7e5c+VGWyfWHZj2yb6aCe5eh9I=;
 b=kA0DAAoWrOspdAyaTpcByyZiAGrrfiWhrdh1ohcZkL3nl5+bqVxZIQ6Hu94iqr9FHGv6llraq
 ojxBAAWCgCZFiEEXq8hBJqGuKVMyxv6rOspdAyaTpcFAmrrfiUbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9wZW5wZ3AuZmlmdGhob3J
 zZW1hbi5uZXQ1RUFGMjEwNDlBODZCOEE1NENDQjFCRkFBQ0VCMjk3NDBDOUE0RTk3AAoJEKzrKX
 QMmk6XxhgA/0Y0ha3Nl0y6k33nwxDP4L3wVWh6lAWbgaQRyd3mXDqfAQDnDfnx3+h6FfO9gLlXj
 IESk2GyTMmJxMsvAjrGdXOgCQ==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

ProfileMe samples include instructions killed on a wrong path, which
show up as hot spots in perf report although they did no work. On an
EV7 loop with a randomly mispredicted branch, 19% of the samples were
killed before being mapped and another 48% later.

PEBS and AMD IBS op samples are of retired instructions only, so make
precise_ip imply the retired filter, unless filters are given. The
profileme bit still selects every sample. With cycles:p, both kinds of
killed sample went to 0%.

DTB miss samples, whose instruction is aborted, are then dropped too:
cycles:p reports DTB hits only, and the misses need cpu/cycles,trapped/p.

The kept samples carry the full period, as do those AMD IBS keeps when
its swfilt discards others. So in frequency mode the sample rate, and
the event count perf report estimates from the periods, fall by the
share of killed instructions: to about a third on that loop.

Suggested-by: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 32a8b5c98381..7e34eac0ea47 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -837,6 +837,11 @@ static int __hw_perf_event_init(struct perf_event *event)
 	if (attr->config1 && !profileme)
 		return -EINVAL;
 	hwc->config = attr->config1;
+	/* As with PEBS, precise samples are of retired instructions. */
+	if (attr->precise_ip && !attr->config1 &&
+	    !(attr->type == PERF_TYPE_RAW &&
+	      (attr->config & ALPHA_PERF_CONFIG_PROFILEME)))
+		hwc->config = ALPHA_PERF_CONFIG1_RETIRED;
 
 	if (attr->type == PERF_TYPE_RAW &&
 	    (attr->config & ALPHA_PERF_CONFIG_RANDOMIZE)) {

-- 
2.55.0

