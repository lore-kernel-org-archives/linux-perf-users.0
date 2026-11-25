Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619554;
	b=Dry6r2HPPyb0mfSUQeFSNjtwSnee+XpLGsewsry99hdc5UNeAsEOlUamr7N/e0F7usLL
	 VWVXq/Wak6w1mdw1/HqxxAz59tfrS2DDEEIRNW5aDmcXrVowyNhSC92zJl/pazgfv0uZD
	 kZS/0E0x2VU7kAr5i2PBoJw7IGbNKHUUhvV9ieYCQPRsljtE1jXzb2IebHme3jIyq0f6U
	 mn0lVTp/5A948pavGuWuyUjkrVZNYrXldDNX1m6ojM2dUtDhvnyNaRV6iVa3L7xllzpas
	 soXg57wblBxcPhIE2laRLfe98DUhicE1YxQuMRTPo2gwYLNP3piIXrDpiYYHDjuBXDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=xF4JRWH1q9UqaShKbo4Aa+Vb+tQRrPw7UDPaEFuk3BE=;
	b=aAwPYWZ+pcAhkZ0OCCwpC65sz6XAPsqwoCrz0Az5jauwM7R85okwRK1PJo8LC8nrkHOn
	 3XhpVvZXM723G0NdpqoO/cvnZmt1MJVvIZYWtA9OZhznt79ri6E5KLUa2XLvdVmaCZxM+
	 +4BMiL3HosIv6lQyWUHLdpJEXURW5ngwKEiSwdFwnZaygxrb0RgDvkNeHiFCBSTF+owWq
	 DIG5bAM3/g0syuL+Ds+2MSOX8i/XAGn3e0u2Ks+UonhmwCnCPtJGe2rwmTcFcGTdrj0MU
	 8qqjD9jawFyQgG/2fDGF6tpfBEzLGWeZMcslu9tkNXsxR2GO3pvPBfPNu6ozrSZBHWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Arf2l48y;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1A606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 15:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C1A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Arf2l48y
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so40145175e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795619552; x=1796224352; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xF4JRWH1q9UqaShKbo4Aa+Vb+tQRrPw7UDPaEFuk3BE=;
        b=Arf2l48yzE8BzILRqcU8Fya/JC8Vr1z6S6mDLKIAzxvHt9eahVd1LawKL1vtXXMMzz
         nyjU/LoSm3Vg/cBn6hd4Vpas9zXqLjI5XR76Y1TzRjuVmr9YTBdDFdbCqEUzX8BFsaEY
         BBHAW+akFqnceZ2nNy7iiu8wFD0al0mgnIne3odTnTpymm2+nQ90cXfvUqRmp7ihhu+7
         2SyOzAinT/RiOBPSaY/FzV2If0xhWMMzsXMhDVFP2SX+FFV22D1utEa96CymSaSZM1xe
         WPFFdu7vcLyIH1NbKaTHTibdT906Wp9FuxjO/Cee5lRSEAnM3jysduTtTY7XHjbvmLnS
         pv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619552; x=1796224352;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xF4JRWH1q9UqaShKbo4Aa+Vb+tQRrPw7UDPaEFuk3BE=;
        b=VaveZZmyyZLqELtZ97SPbOi02gi+WpFGrS86jxN61Q8LrrFAkc3XuFs/IBbbLQhbhl
         JR0qgVCg6QueVFX8QAz0jri8GJfL5j99NN6ysA/6t/WldVHN6Ibcv6gBkCDTMPjVakvg
         xn+u+l6nqP5w/lNAetPDQ24K/s9XdaqnjpIaImQzOd1d/xTJwhEyThr1y6U/LZRJprwS
         h8277/3GRkt1iwTg//AF2TRSIyHESSc+ffTnDTClWLPSj5V01KEkvGxwtKe+RoITVdyu
         vmqOD657SiVjUfGPy6dtrMz0DVecdPyfeV85RgpcVsdNQP/1gfD9nqphuykrWpmOZYvW
         Qv0g==
X-Forwarded-Encrypted: i=1; AL+hErEGsziaFXHY9+/9Fo120Gknhw9JRCUSEnsdQyo0tbhv+ciserD/KTUk+OXeuCeXH/oXMoFDsPJn3NXaGdnzbp36@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ts/qIogHuTGIXhr2uW/9WVBk36Q0Tm3W/Q2IjKMMmwvxF5s7X
	9PdW8MnkB7aBuwZy694LK0sJoN4hYWKGlW2Q8newpXeg+LMrwTPA/b9rnNKmwHFkA4k=
X-Gm-Gg: AZFdTZcnlDax4d+CtbClACo5IbdwXcFNDTMPjbldnVxb3xhr6KqXtTuCugACClNCqGO
	FDNtkYPGeiTaGD1ynTxwcbcP77Gv5VEC2aQVYKUi1rRmwUqZEWx1IOBGZpYgNCkcxzIz/P2BaRC
	3pC23YFKbXZhvfive3g2X9MwCcmqrokXIrHtxx7cF5v5EfudVLidv3i/OqnYN9wrDX3V37o/IBb
	q8VLVD19THnaaUsCi9IO05jzbx6VoMBVwszE4mvgOx/Ju06KxARmXQPafBCzJl0tI5zoFpIc50J
	kpsJ4W+dtdZLdTDlDcCHxgqStW1mZyknQVCnd0uU2f6yR9mkp882HX7WX0D+laXIYQIuk4YXCiB
	F++uvslIAU/se0sf7eBjnFh9TsDI1J5wE4UlhQThD4hT0OlZZgR8hVU7jDxrIYHoUWA5XJ9tsP4
	7TdnrTk7dHWWbZRrEOgxgVOXSoHlSKMg2UnHW4PL0zC1BH/+Bu05G5W6UZzsD2i9Pa+zxrd22x6
	Vhk17pnmdRYovDiv5073X4lJFlZGcdcb373+OnF2kS7XmxGJOec5tSQq75HdX29lJGg4jibqFtL
	K5V5VDPLiUd6n8eUbsSVza5DHRNOuBLTXUjf3LCZCTDYXZL7Dj+f7Q==
X-Received: by 2002:a05:600c:5307:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4bb88921468mr352479355e9.19.1795619552272;
        Wed, 25 Nov 2026 07:12:32 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm39845282f8f.24.2026.11.25.07.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:12:31 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf kvm: Don't create an empty perf.data in live mode
Date: Wed, 25 Nov 2026 15:12:13 +0000
Message-Id: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAM36BmsC/yXMQQ6CMBBG4auQWTsJraCJVzEuKPyjg4Ckgw0J4
 e5WXX6L9zYyRIXRpdgoIqnpa8pwh4LaRzPdwdplky/9yTlfc9+MMJ4RhZ9p5EETWHQA177sgsj
 xHCqhnM8Routvfb39be/Qo12+P9r3D3gdzQp8AAAA
X-Change-ID: 20261125-james-perf-kvm-live-file-520dbff37b4f
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

Running the perf tests drops an empty perf.data file in the cwd which
gets in the way sometimes, especially when the tests are run as root.

Fix an existing error path bug to appease Sashiko, then fix the empty
data file.

Assisted by Claude Opus 5.5.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf kvm: Don't pass an ERR_PTR to perf_session__delete()
      perf kvm: Don't create an empty perf.data in live mode

 tools/perf/builtin-kvm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 148690b95cc425950dbba79d73eb4f7938347fce
change-id: 20261125-james-perf-kvm-live-file-520dbff37b4f

Best regards,
--  
James Clark <james.clark@linaro.org>

