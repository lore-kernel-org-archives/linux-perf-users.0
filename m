Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4F29E061;
	Tue, 29 Apr 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898287; cv=none; b=fiq8+xH9lkbD56xKG2h/E5SnZUqK2mctVl3YjGX80PIhv5vV0udAb2FllhHHXStFG4+WB7leXjxQkn9/ZUElOPQQPK7JaeuGrbWbIBkFjiehzscwuNgeLxTir1J4q7TGPiGbyFr1m0bpkdiq+8wdNpZt67rHp4258p66ZmscbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898287; c=relaxed/simple;
	bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMNz7ePCCerwohNJpu7iPbSLElKSOShX1o+X3W6Vu3rzNMzucFiUGLpXBreMrS6qBZl6Vj5m+xvpgqe4jHeQPUbY6y9cK5NQISga3FWz34cMIsdqrmdL6ZTVYWbjQn9CxMpvRSJBkzujijmNFf6rHm0JtWPurFOT0iDlC8Yz8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6E+TVTc; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6E+TVTc"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b03bc416962so3909657a12.0;
        Mon, 28 Apr 2025 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745898285; x=1746503085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=J6E+TVTcHqoic2FWSsiS5LN/14fa2uPfGX3dELQBYfXQmp4H7Y8u19Ui1/rCVL2Qk4
         cFAIBuZQxFeB4MDIedWDkRFopHgbvHfrCrc83bzfLBO522CYwhPT7WE9OoAw1SA2QB/R
         5Mf3Q4mA7jsVRWcQ0ykfc1s0B64jVPB+MwvS7QxZkOpNQoQ5WS8Q7UCDx2hr0TsWdGss
         9QunY3DRHxgz409gXlSv1D2HJB73E5/iiTC2snZMo+j6Bp8QONaw5t7YzFTsB8Zl7/oT
         G6aZutM8y4JRoEj+M27tM4IPw5gYSXRJU0zDK8T+j1JmylFi+tJduSvQLeLrvXmD9X3g
         ug6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745898285; x=1746503085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbV9nsv1jvdE6TIAVwMdOO2R8WMK9uKpowquURgrnXA=;
        b=uQok+ATcNRAlGR6IoX9aejf4QP0Q6g2VIqmauC19PvZbxP3wygkKnw8lcPEjWCYBi4
         NcRT+iU8cqnMAGwUp/1TDrzffYsgZRolohYj28NUfXrJrekIFRXeHCfDbRGv9QJo05jY
         K8DQqMjKjb0P8+bOmBtyky0EuuNs7IDXIURO6ijEq+IDNX4zl4n26BIM5M3fG7kWAgcU
         o2nWaW20Ha9c5JP1wfyXrzpFsk1qNVJozS814Esp4ezWtoYjIJG58YiQ4wH4Mft/Pluw
         dWyApkSf7/qoZgqdPvwOYgzeqUSJ3FzSxtI0gzixBl2E5qbL0abhAbAMbQwR5FM0fovd
         3/Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUAeqzqdRmn70AbfbfCE5Fzrb29ZvQWv4grgth2poCkWtNVyO0/cIy14aOXh/ezsu9sNT2SMl/l/qdmqLxA38CiFQ==@vger.kernel.org, AJvYcCW8GM27il2mRkSyvz1vq+NxqKHpuH7Kbo7w2J/tJUeb6PznmRMGSt3fNnVou+qzyrNJHu59o15WT1YW@vger.kernel.org, AJvYcCWh2oj77cDhRsAfAPm7EtgCMVSb5/4tABW09A0ZykCFUDMfK28ee7XxcdsD3HdVTfEsALTpNdkkabWQVpnZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPgHdThsJBZbqGbH9ZpxOpIV7kOVVfHnRgnqyo9M4kpdAwjxG
	//j+hiIWXH7+RIG031UNsktvzEtocY3bd9Y/tFlJMcqkHrIY0O61
X-Gm-Gg: ASbGncs/DiINV3uZzeYo2Z/Ngyc56kl/f0TQr3M4swHxt9AR+lqaDcGPzSNbmECs60S
	3CkG06WnZd5IG/QFmCDEerpJlPgGAwtiDAfurnmRBXkbcolJHj37NRbw97jF5oi0YWE5m+sJNfw
	WmUQw1eyiIbiSslpFIO78tW6X0npOuJZjrN/T+84UnvdvJguQPkz34gq2+2hp7I9jKFOGyqSiMl
	ghsqZs8nlDZmZh2JGc4vc5/D3vSVeyv8Qd1RGWwS/pcyws1mhto/J2N5iZl6uBD4ivyoQv4ebn1
	k6Jnq1gGcDsagtqsg3iPY7XDrK6uYJtbAr+zMz6xKm7+cS+kw2TgAYckzA==
X-Google-Smtp-Source: AGHT+IFEbVkPWYNQnY1Eec1Z/JJdXhHAO0h1WUxh3tHn6ObSEJqONbzchnPFoKFOa85JTrCDNEdlqg==
X-Received: by 2002:a17:90b:2dd2:b0:2fe:9581:fbea with SMTP id 98e67ed59e1d1-30a013bcc03mr14963519a91.29.1745898285220;
        Mon, 28 Apr 2025 20:44:45 -0700 (PDT)
Received: from [127.0.1.1] (wf121-134.ust.hk. [175.159.121.134])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb7fsm9953249a91.9.2025.04.28.20.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 20:44:44 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 29 Apr 2025 11:42:44 +0800
Subject: [PATCH RESEND v6 20/21] arm64: dts: apple: t8012: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-apple-cpmu-v6-20-ed21815f0c3f@gmail.com>
References: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
In-Reply-To: <20250429-apple-cpmu-v6-0-ed21815f0c3f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=iSgQuvf9kmSTE4D2ckw53TzjQOR5RrwNb5r5c6wUTAU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoEErmBO4nJnK5mFPF40lad4p+BSKJJgrH+MZn7
 sq2/grmPHyJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaBBK5gAKCRABygi3psUI
 JOtkD/9p5R5bmRzF8RZxw0kgeMs0uNsPHoqfnYjW+vmoqBbxtxeoO6ad3tbGJ9wfuvHxK5mpxMO
 wIxI0CXw5vmijcdumpsQcOkB7JVaZqrID7+Zr2ye58YFLpFWKRi77q8ffHFHrZ8Gggm7Og8Xvol
 UNbMssQR1fLxePqjUnfSST7/n0t+HiJWcDRdW9XFizJH9wyZ/NrTeRki6N78F3yUwO0cH/z6F7g
 /TORZXoKldoHsSHanyvFdJGj+lsrBcabdzp4zokYekXiYccfG6pqPXMgdBhmfhwrog/v5reAbIx
 Kvb3p8CQbxgnD8rLuo7rq//4nOouJoC6oHHuRWNs8aZHw7fNea65Qhy6+yodo6haAjiZASQrhnp
 jISf+cvhVA98LZeijP2N8717K/qZj+ArhpITbGmD2GKh8m3bfrqvvIF2OvejSuqODpIGuSHKah4
 CsPh8tcbFe3oPcUo3P2gyvVUCpEvTzo+g8ZG6WOWFdNK9nTQkfWRMgUs9qIbDERPFJL6B4X8Fw8
 fxb4Hc2Ua4zgvnDMgO8kkTA/sIHAKOQh7D8g/GSapyx5+cynYVtm7CAPPs1JdiXnfcScaCm0W6N
 +VAlmG7IVsFIgUXnJy1avWP9WKc+tPHEWi8FuYEaAmqrzEfg4cojYwrn6aedQDgUxNR9/9KbXbY
 cZYlEABjiv6VR7A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index 42df2f51ad7be4c4533e76d18e49a9a747b6b7a8..d79ed754c68dd89fc8c52887e6dcbbce04fe126b 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -276,6 +276,14 @@ timer {
 		interrupts = <AIC_FIQ AIC_TMR_GUEST_PHYS IRQ_TYPE_LEVEL_HIGH>,
 			     <AIC_FIQ AIC_TMR_GUEST_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	pmu {
+		compatible = "apple,fusion-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 86 IRQ_TYPE_LEVEL_HIGH>,
+			     <AIC_IRQ 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0 &cpu1>;
+	};
 };
 
 #include "t8012-pmgr.dtsi"

-- 
2.49.0

