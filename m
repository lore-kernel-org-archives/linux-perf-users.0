Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD43227EA4;
	Mon,  7 Apr 2025 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744001226; cv=none; b=PW7U0T9fh7/C4cXnMDIQzehx6LWdzv8AkuIyUT90Einw2rb1xV/fQWlqP3Kc3tOa4Yhbim/cABA/I6EYmzoz/N0ynxnr23yvXYda2feeQSVegOO7cjl3OtB0QNFHRWbX0+oQa47kxJo7kx0YVO2kgs3NP1aiLG7NHKIJjtjKheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744001226; c=relaxed/simple;
	bh=kZviMfYtRCR7gR5VoFkDRwcKeTgAqfWp35C3egDQLf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOISyeBft3FZuWGc+aCwaxV5Xgs11QWdANaRwWzsfE8XZ+XPTG0JkC4SQqgeK8PV5yRkOseV0POj1WjpwdDdEtS3aKeS7reLaNReiMKc5l+Yho0BBwliaDxnetfbwbYyGakDjAXGBuRerxDRvDzNaAEP5+eN+G5lXOHeGG+ed5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQlEbC7Z; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQlEbC7Z"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso2561215a91.2;
        Sun, 06 Apr 2025 21:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744001224; x=1744606024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65yvptSdo6oSSwoGRF8EUfcgAwuQwDq5kFTQAdR/3Jo=;
        b=BQlEbC7ZnWgOO5p8l/uxhW20rGp4qFRIKsc5cFbv1I6jCgIcrKuNs4uDKZhPwKGTQD
         EHjfj+O6JVoJjoqgFc1pnaQnytv7MdoRIFf6xP/+mBZFJ7XtEOGYdmD/7guHiBZ6XMeK
         s/gA00YM/Ef9rJblLz8lyKrdKZhzD4iFPOP13S4oJ742w1Z20swt2GSU/OD6h7eaCshH
         6YgL5eq7CIkfc+IEgBcHRcm/o3jUz9h/ndjQkXQrFdo0F4fd8gMRcA5jHqkPR4083pqp
         DBJZt9r2yM1n7nPDW/Ghbm7X9SHQMYMryeE8ST0KD79GJ4lzuFeRq2U2eKpa5Q5kfw4o
         AHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744001224; x=1744606024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65yvptSdo6oSSwoGRF8EUfcgAwuQwDq5kFTQAdR/3Jo=;
        b=wkqYrcYy2rLKXyDZlZin6cskDdPuVfRRc6O2IJWsazxpx5f8pPpINGZuOC9bVGLRkT
         3AMy1OWXEuWtwOgWPqENWndxuvYwTYJySDjbl7wVLzTvGSzUYD4tJW37sFpEVLlQ2LkM
         mgSprcM6c8afdLdmLGVeXkYUJpXBGqkE4fHrQ6QZ+9oy0cDiW263F5RrGb9X6V4oos4U
         z6lsP09Tuw5jiQJmm9OzUP4ldH6lJ5Ta9+xKJBcHB5VoRvQNBO2A7IPlQgxTXn/HnEBx
         G7iO3yLVC5HHdaBcDpyqWjq9iBipuzqrMGfWs2v+qAQKIjDbBLc/iAO2+E8D3+W7HgWr
         U0fw==
X-Forwarded-Encrypted: i=1; AJvYcCV+N5OCKk1mUQZETN4plJ/z+Qn/hRPqdeP6AJMUbWWAbWJvOzNnMUACmHYO/TpemOEgDfUb+ItR4HN4yfw1@vger.kernel.org, AJvYcCVYHPS+VyttjuZTD8R7qKOKTD9TYpeUt1T+PAMe0ZExSjMW8TxmqkBu0rORuAMDs+HcHvkxRQ0nLrcg@vger.kernel.org, AJvYcCW8nczfWbTbQrRRnEhjdMT/TcI6iz4xxiiizhycsqjW7uymJp05LNI4/zuaFPcozMOo8uibzZ+aIHHNFps4AyqqmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpgC12+hU/4RRxvJGgPbj7KTT5TrQCM5Cad/6kn21Wk3Z3RN7
	oppOFHCZ4lzbBsbFLEqBzh4A4Rw5/xEikqId7tGtMbbZxrhs8rTb
X-Gm-Gg: ASbGncvB/OysR6EHVRPwPvaVe0iSSiN2HabKWlFDUKosy5sAwdGS4NFv3wWCUIGoHM2
	/iCK2W9r5BhNs7+h5JcjrTcODU4mdS21zeGcn5jZx6iENrKnlo4FKjd3R/J3BcKs1I2J59/Fc6Z
	mXPSlqFRSHykOXD9TfUMnwQYvP2kAzh7v7LP3+a7BHP8lTfHHaWeZ/AIeNmy85eFYNo2bUlsn+j
	G+oLOy5FcXNL3YuNa1pLlByLjNZ7jIQgXKHqZPzJZ0f+RsO/IAlpM/W0nFTmHWCsjHroYDEO4tt
	+GhbKYKdIpgvbhTjRJHYZvNZKtDp+pVsZ+1TRq3RPW4vNZw=
X-Google-Smtp-Source: AGHT+IE0r8ZCa3wPwQVT2JXNI8jjTdmqctdoQ9nSxWYmL0fJFs8RNi2jnGeP8GXAxNy75fDe1TLsxg==
X-Received: by 2002:a17:90b:2e42:b0:2fe:99cf:f579 with SMTP id 98e67ed59e1d1-306a4823704mr15643498a91.4.1744001224016;
        Sun, 06 Apr 2025 21:47:04 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-305983b9954sm7765810a91.32.2025.04.06.21.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 21:47:03 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 07 Apr 2025 12:45:27 +0800
Subject: [PATCH v6 18/21] arm64: dts: apple: t8010: Add CPU PMU nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-apple-cpmu-v6-18-ae8c2f225c1f@gmail.com>
References: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
In-Reply-To: <20250407-apple-cpmu-v6-0-ae8c2f225c1f@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=kZviMfYtRCR7gR5VoFkDRwcKeTgAqfWp35C3egDQLf8=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBn81iIkXiBrt3zrY3WJU1Kcvs+HkHwDmKaSnZQu
 kGBfrQgRP+JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ/NYiAAKCRABygi3psUI
 JCG3D/9wNW8HJ5mruLZkPUoQshdnt8LlV1N3TSdbYEVZCHi+53035DIKB6OeCqrhv87BUBlo/Gf
 AabxUgFWRTwl+r+1x7kZ7KjaJbol//DjdhwBPICwk5pVuOTgU56S6jAQjOWh3/6gkMcQ/k378Qn
 E8x21FUSanhbMKKyz8QYeJ4O5IhJ3hL2FPcjug/0fwnDei4SnN6VdEpnorjm7mTKVHqlEWKaHDQ
 Wzeaw8FAVWM50hZYfJvf3et9/hSiBBsq+0P9UALilKn0r1RVboM/DZYz2BEoOFAoUxPUaE81mr9
 /Olcp7mpDuO3E/AqhyobaKSIavT6HPajfQmbe9w8z0o+3es/jad5zxM4H52KANmZZeSrmx4gvR8
 7qK9i8er7GwPSxfLjpUsc0jLEJcP4VkxiqyRFH/+R+ROGoQjZPIqH7UaRhO4z9XsCSDoonxCbUr
 OpDOi5YgL3okxqO4Vsn+k2oGCLuXbfQn6D7EnZEkBYLook0JMWkBAqSApzY3W+JCpz+idbbUvUU
 b/7T+dmzJ1LxHgtt4hu5SlyVR6X5aH3M8ToxUqY5ZJVDXPFf0ht5Y0BMujay7mnERFbMcCul53r
 CaSZIJRO2fuQ3nfgy9IPC4lArYJVBgCyN51pcA4b8jfZqXHrAU08ArLGkVi80thybNCAG61qmRI
 javzEDOo8L9iMaA==
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

