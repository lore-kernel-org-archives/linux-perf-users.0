Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719492857DD;
	Mon, 16 Jun 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037595; cv=none; b=BSB3aDDq6yxCRtjySTtBHY8Ay8/g7yurEf0iLD/0I+ReenFGOPFIGxGcCArCEvB25hPUt8yPL/jO230txhoC3h6glt3SzmRPml3sIlghoW8sxpxlP27SQzfIZkzvM/EuaJnAOnWze+zmjU/qFVNv9jpd+xOXZigPr/txG0GnILU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037595; c=relaxed/simple;
	bh=kZviMfYtRCR7gR5VoFkDRwcKeTgAqfWp35C3egDQLf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gi8rstE2A0yGOa4TvYqLQ6Ci3/F58ot7zrNJVH2KWVWLjRvHPxUAIwmiRa8/9GXfdpDy1TpigBhyjxJmnfZ27h7yAWMxHh0EgmQieYMWGohBytVx7v4P4ABkk4UWPGP6Xz19y62hD7tBlta3mT8DxNb8Vj552gkqkGWehfYAnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkRVjGcn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkRVjGcn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236192f8770so26410415ad.0;
        Sun, 15 Jun 2025 18:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750037593; x=1750642393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65yvptSdo6oSSwoGRF8EUfcgAwuQwDq5kFTQAdR/3Jo=;
        b=NkRVjGcn1Q76zCvBdfTnIWS3F1oDHMmajzQ7gg14i/JziwNrFaLEBM9CDBFBkMgApf
         Uhn9qVAAm64Nmsfrx+WzwTOelvNQJ1ArOzdU9PpVz+H+RJ2s8xvl3kd+v/5AWqPyPv6u
         15QM9l2wjYeuX5ZMyqpXP4HA5k6POrEQ36rM65gq1fJCKMGg/RDk/uwjtwSPGLu9Uz7K
         +cI8ciPWS1FukSArRNMABf0p1qctb8LjsQnSGfEz7rX9SuKZFJ/3D0hOaGEqYgiY7ePh
         ZqtK13BGqVNsBWV0G1Tcxm1L0HHZ0VgjFZzsCeRnT1+HhEY+wpESHgE/zUuNSM45mVaY
         2Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750037593; x=1750642393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65yvptSdo6oSSwoGRF8EUfcgAwuQwDq5kFTQAdR/3Jo=;
        b=SDDn75PHcJ8GbS4l8V8L4+LaW/XPxrnsJ0DUEJ3gLIBTa/6cNs3LKjsYDY7P5ftPc1
         3pAoB6teFSQQ8KEXpQqpXsAVdsChXgGn4320wAxw9xbu1+oOja3KUIl5mzpri8WANBhH
         UeLQcEYmG36L05XX0B5yTyAkU3W9UOSYLoAQyostsueRWFB2Ngf6thXMDChIndk99pvR
         zKUjkOMyjxwDcsvMG0eCRmNz99vpcxxpsOGHQHvITX8BgW97yVVaLDOqtOKX0jrEkLTD
         JpkPUpzmBhuPCOrEjwfRlCj4g/5cR5oakOhu3tpB+0DHejJF9Quh84Avy4fLN51HvMNF
         WjhA==
X-Forwarded-Encrypted: i=1; AJvYcCVvPr8VgulrWu/uIZ29UlGMpSZYrMeog2kYCHh7A5pJIo4bw4paPMnI++eaLemooEXwzoc4xQM8pJfESUMc2PXvGg==@vger.kernel.org, AJvYcCW+vybSgjOZ8t+0HulpJqLmYuZ7WTJEjCHk8lquc+78bhzFzqNzVWWEDQKMnxfTpPLklG4ZfVoThbDfsNKO@vger.kernel.org, AJvYcCWGxSQmv3TtSXxh9C03qCcO3lZ4PA61Wb8PcHvLVvv1dL5ZNcO/j4zR3z7f+TeZcQLb7p/YAWWEC5MP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6j14IiNmMsb+u7eGPy4SS/L7nDDQSRHeGBJCC+3pt0a9Zobhw
	GVWeGRaSiUBFMIQ9+KRMF6sjbmCjeNoA9yVoeSZyv4MTB8O032vWA3OMJqFdAQ==
X-Gm-Gg: ASbGnct37elTYkAJQBEX7pIv6NVaLBv6j7LpRJZ9BYKaSVLqeKujVGfGjlYtyBJTzJf
	MJQqIV+23hpqsVsh9UvxAAK/8xAwuvJEfPMRnWdvAFSRu66NNXM3Vc/Mvc296nehw77Hr2jYRjF
	jjOf1L1WUuh4DjkV5/BI5reInF69LlV3GkwAkDtBpfpT+eDaO6Cym2zTDKTD0zU/zDrFkod2C9E
	Canp9KWMKX1tDKGYMvZfIuk0DvIlqtJP9/Z5lxQq0VuXeOFJE2EpN+4OAVM9fMsx37KH14GI7nd
	KbTZV3jkfPv2Krk3Tc2Q/oM+VrZxqfPwxCk0RR709J4xhYoxb2Z5Dh2zsPO7LzSwdxz2UjBqozo
	Rbbw=
X-Google-Smtp-Source: AGHT+IH8RHIqmgqFH9/PYcKJWUdxyaFMM6Kq/4bBmlVBjq5NMwMgObIJXACByRuQ2ziPGn9ASPeGPg==
X-Received: by 2002:a17:903:2ac7:b0:235:278c:7d06 with SMTP id d9443c01a7336-2366ae00e80mr122624655ad.8.1750037593408;
        Sun, 15 Jun 2025 18:33:13 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2365deb2cedsm49932455ad.163.2025.06.15.18.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 18:33:13 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 16 Jun 2025 09:32:07 +0800
Subject: [PATCH RESEND v7 18/21] arm64: dts: apple: t8010: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-apple-cpmu-v7-18-df2778a44d5c@gmail.com>
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
In-Reply-To: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=kZviMfYtRCR7gR5VoFkDRwcKeTgAqfWp35C3egDQLf8=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoT3QZxkPB9WtUskYsmB64PvR/FecyGxWdQ2YOL
 BsUBeRO9XKJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaE90GQAKCRABygi3psUI
 JG3eD/0ZWUsTwgTP6BVPRrhBb3M27+1DBsSZqei3zPBEAKmJHMVVMj1eVHoAGXno6RUOXd2MgZG
 1IpvY/dAJ06ulttFowr9wN2W1ZsdWANY9km7h7VSPfmcb1P7qa3+lKXTH/e9xvEjYuA79fiw5gZ
 +e/1mqV++Ai79/O4lA4m6uNHyw897f4dVQDiOwS1wPxFQwlpQZl9a9MN8ob6Pz+AZ/qYky9ZHBk
 RIZGmtroWuzvtOBsckFAdNLoaR9gzloq2VOvzqJzDrQLcDvxFirVy5gTs5jf4czv9l2iR04VxjR
 ATJs+PEXNAX0FaXKSFhpfFoBEzQjxRP4dNmWaUIjue/p3onMJ28G2cp+DR4mzI/gAGwA9ckii4v
 wPsRx6920SpmSLx3JQ27TTjQPm5nPNR7qejV+sXY44NnSicBmC+EhjY8DxKKTOfpePAm4T1EyKc
 Ku1cue/gswf9Uq92t0l5VuetQ8GvyrvLGghtQEy/qkfngMsV6ew88xqhXBuU/JdAjU9+p1Oa6Sk
 8jUYYAUqIrc1drr1vEU6CgNqm6qPLr5UGjAYbdpXb/LQZGNhw/QStM1HPgYzvbvs4L+E6uk4jrI
 HLqbrhp16ZiX/6uN3AS78HU0ya0IStsZU6O7awGVzrvsx5gHvH0y9Nrwvgo19VcmQT6g8fXxILp
 lXTFuPSNFf2jraQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple A10 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8010.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8010.dtsi b/arch/arm64/boot/dts/apple/t8010.dtsi
index 17e294bd7c44c7961cc3ba0ec5f4178840d5b9c6..cbffc84480379cb476d5caaecce91f746e862354 100644
--- a/arch/arm64/boot/dts/apple/t8010.dtsi
+++ b/arch/arm64/boot/dts/apple/t8010.dtsi
@@ -243,6 +243,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 83 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8010-pmgr.dtsi"

-- 
2.49.0

