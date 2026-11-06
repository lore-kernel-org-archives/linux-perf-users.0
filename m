Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939460;
	b=ki1y/SekA9Njw4DnwbHpORg4ZfAosSQhIwFv2fe1uh/ABikkwjQ0/143iqmteLfz5VMH
	 Hv5WpQtebmXTfbsAxoA3x9mAfNtk+17yB5cZKBhWkAy7ZUR/X3EIvKx8+4bnBJrQn4R03
	 C0lsV3GamZF0bYRKnG7e8+kYlP+UF/M3b4Ms0Qr7P632eeKiEXyfeKxahtdJti2XQfLNn
	 IKDzR3X2Fi7pa/8PtoeInLkmSXL8u5nFd59pZq3urPXHTVEa0TVZFB11UcJ8G1DYkQndY
	 zZReernEt4Mcxm64mt0D776CO3xQg7KsEvTchwbkcb1q21wlxNnZbNVwn1+zy69KoUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MsPW5K9wIVWLH8zTIi0shO9heiIb/dOsSeBuo+Lhef0=;
	b=Y9YSOPRKzJMvuOFGaczzbDkxX/ajxcNLGFPWwXcAcGDB7SWtrkD6mTONT+RmjMr/vugQ
	 2ZL4ow3oEoQl489lNlw6bwI1TssUYBiP/+vog4EXaKI4OkzxTF9THaXVPhW/CTWRsgPYQ
	 a9/Vf9nI6Qlw0sfs64S3Dtaxln8exOnz+fuiYoHZl0zqHvxyhhW4OucO4zp1YikZ4x59r
	 bP2+rfcRay2/cAoJflukRS9fVX2Bm+CwxFupf1Z3/wgAonryqN4I7mkslQ8TTne+AZE+V
	 bhJyeIJ2qNGS77Gues3cbk0y1mijk1uNk+g1Xo1wnbfAZTZFfEGbrqwAz0J01M3ueYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L7MECB70;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0C606A33F
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 04:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D0C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L7MECB70
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b305d38bafso1187267b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 20:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793939459; x=1794544259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsPW5K9wIVWLH8zTIi0shO9heiIb/dOsSeBuo+Lhef0=;
        b=L7MECB70DwWz713BM4+LuzQwCxLCy9bzNYAZNX1OrN3ke5g9nymLp+njHxZmAVJqrY
         xKX/ePAjXg9VJRi1cqPn8GEUjgleL7axnNyCdpNA1zAkgrsKxkpB8lwZ/EmTZcH/b4x3
         tibbLBFjD/+HLO2+tniKIzPpGSDbYtPjncsKH8sBFn/Q20zw1AIBn2vyjSP0xIjyhWoM
         ++9bzBQpgg4kh1/KdufEK8okI/UcS65elEi0pyu9KEQNELEG8cFLW110LVzTnZEBv3wd
         z1mScfxNSqHhMXEVnziBiWdRdYwsn7OffxB1rNqdji6CoUOZ2R5+2eyWBCcASxwzaxTd
         om0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793939459; x=1794544259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsPW5K9wIVWLH8zTIi0shO9heiIb/dOsSeBuo+Lhef0=;
        b=UBNyNMMw6+YFxcSYo09+H8QORPlub+NkmLp1p3b9nim06jUn5eQf/RXbDpun4ZZJfe
         gLr8EKypydOdkJdJcPtaHKDgLqi0a/R2hPUJRQ1E6eBT0Mx0qGWIKOpk82Qpky7fCTsc
         iryxDJDYvmZI6vIeHz7vkzEY4NhzH7aFepZ7b1EbZRYSt5k1Kb2YWSsbMSKQAHFl7j7d
         WvKUNE6lVNvMfDrrGwVytVUNPdo6SS7kjqZ0e5cIjd3Wvdr5kybZW5Q12De3KToLF1Be
         jTMCHl4bmY2O9CVF1MUuLxCWD4gqaHISJrcCtMh0ZKPWVOkMwcAyShPcfZN7M+kNT8cB
         +gkg==
X-Forwarded-Encrypted: i=1; AL+hErFa90xuM/F/steSs8PAhJc7X9H2dv2P/DQ4B4ZA7S54/piu1V6QlmrEzc9L/fzaOGeZWhXcpWWGnakX0CClOLeB@vger.kernel.org
X-Gm-Message-State: APuU4Z8eb5K9iXSn7T01lLeJOg49osS8/9r000G+KUHneD+cdzA8TDEf
	04nD53cjsCpsPGCFEJWNKG39+C8FObeeZIXzRPfDazBAELGYOMUw5NrW
X-Gm-Gg: AYBFou20zo8NXKH+XMtH+Zrjr7DI1ZHx3trMxng6o+iK1nbBkhc/GpVq8jNCuFk8qMi
	FeLGKjyfC/vln0HckwS5z6V9llbIqLXchNkwbDAGQBJIcnSmybxKYaWpkrxT39KtsYRHgdiQFI4
	pnmtzfxOkFg2s/V5mjONP889lTtWBajvyWQUQW1pagKy6PlmC4cJNYRpTS3GUuarO+HUPGwzh1O
	zVZcTHmJrXjIYXyOs/RDqkGg62S1d3mN1yaUx6Gt0xj7plynRkvTTIXuEGWSckhDM5MO6e7m1K9
	xPB8Ag1hA9TIC8mOQ7I6YcvAwUkLeIqI47Ucu5FSbf31PrgsS3Vb4uEcQbpnKVC3LBGI7Hm23C9
	YNsWlPjVE7DITs0HT6AGnqnsK+SGPuTeLu1LgtaKM4K4iJ7KYqHlPUh75fNzEwdRoqcr9DoPH2Q
	0fgrSs3l3/iEEHHn0iiIsThnBCDxxRaFYiYGUky8QeBVyySfSPYoOaCE/7brwxas0YIGQq5XE63
	gAi3mZDgdm81BJLIgM3XDCOWDNwBSbyaOe66MdRtpXaJcMralrcL5F213RgN9grbesOvJH/oOb+
	EcxiYL3nsA37cbCvGRg7FGN+xJoIpJIS+hPFI3SH4nEPxhzm5tVOjc3TLPKmJ3tdGb02OkZCREj
	kB3gEYZDPxw==
X-Received: by 2002:a05:690c:1a:b0:8b1:69b4:b56b with SMTP id 00721157ae682-8b3417dc562mr8895757b3.8.1793939458803;
        Thu, 05 Nov 2026 20:30:58 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f5f316csm11175647b3.1.2026.11.05.20.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 20:30:58 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 05 Nov 2026 23:30:32 -0500
Subject: [PATCH v7 13/14] alpha/perf: sample only retired instructions for
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
Message-Id: <20261105-alpha-profileme-v7-13-c474e892abb0@gmail.com>
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=t93WYO3sOCggQKfxs++3pirdoJx+OAS0XM5ZjaMNX24=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLeht896KoZ+IpRhsUx27gy/vJ861/P2atlbvTnpP09a
 JkfkOnR8ZGFQYyLYaaYIkvcekWWWW07lvqclv4FM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 Ahk6RvEQOT0Gjczi4tLUIt20giKHvPySxJLM/LxivfyC1LyC9AK9tMy0koyM/KLiVKARenmpJaa
 ujm5GhgYmlo4WZk4WjqYmzs5Ohk5ujo7Ork5GluYmBs6WjiauluYMXJwCMNcc6mJkuBgoJn5i2f
 wF/nNO3ds1vX3D3DuMNw5XvJkl4ZFSN9ezVY2R4eTnpOV7l6ZMElzdPY+196F15bsVf1dqHJj7r
 Cds3Z47a9kB
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
Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 332ff19ffd95..aa6ec2161ec4 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -849,6 +849,11 @@ static int __hw_perf_event_init(struct perf_event *event)
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

