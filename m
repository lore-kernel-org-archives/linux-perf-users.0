Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A04F31E0F1;
	Tue,  9 Sep 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412758; cv=none; b=PdrnYw3xFtCgdPJUiq7NlsIATGgACFUQ1xyRzjoaqbftPh0DvZ8IAxpIS9TPqoWZ/Q4nLdewflvOwUzy28fYVaOOAeGhWeCPA6EN3QAZV90z44TlYvuaiAbg/nhHbu7hPQdmW/ngp0lBcaGLMBCqgqdTbZwIqn3VzM4VYpJ3DXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412758; c=relaxed/simple;
	bh=1OJSwnVWIOwJ9ZLoYl+VQDzy0Ex+adY43gmbor4fP/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0cNCT5YNuLxOfk5QKUmipLLsrVCMNznuq3MhaF8wJ0ZF+30iXMyTDcfsh7d56gzZGnfvuIs1fvPLC3KoIpYHjTBaQuTYcAGQJ/De03+9lu9toT8v6GcrAh/LvLAtkFo4fZ9XnZPNqD5pMVhMwrg35gVHlxEND93UBltO3yaAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leIy9hGl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leIy9hGl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e2055ce973so2892612f8f.0;
        Tue, 09 Sep 2025 03:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412755; x=1758017555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkTVKKAKgDTt3rd0xPFa8W7IH6WaF3o91NFw0CHdy6w=;
        b=leIy9hGlQGxf0yMzygfKOK7EATk+MGW9jOHLw0J7J45PnQ0/p2y8Mkci+tbcKh7ufR
         CNLXw1m/0K6ARfNLMU7BxsiHRavTpVOuv9PHSusHw1th/GE4oYt+0rStxcH3UFHgNBPn
         OUMaO0Czp8ISN7cTxDFgYl45NBL/QkJ7zH9HDbIdF1VEgLwIAe35kRkqJs9vo4vxnYk1
         4LFZDdPkHGQbr5SQAvwhQnaSDh8mpPK1aKu5R3ZaPcrSOEISpar9w4cHTH+M48T+stGb
         MFlws6MtSLm8bY9EQDkC6s5/82w6+hTv/KKQ/svypJse7oFjoKzi3S4ksQGuaT1MoOy1
         3Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412755; x=1758017555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkTVKKAKgDTt3rd0xPFa8W7IH6WaF3o91NFw0CHdy6w=;
        b=A3qH2cYyec1+aba2lHskbbUJNQwLyhZlM91V84dVt2wf8e56NIB1c4V749bM6fpG/o
         2sW8TWBDU4jyQ2LcfRkTaGqGwlrHXgcneeySkSCoFyRGINSxvaYTMFpWZoRHuB94hwBO
         +M5NiEOyZbGfGtgWWjU48sBpeMAZhrLqOfPbc8DHdf360Z5S8mINlkNtvz2HROK0IQXB
         y2a5DqCJVLz0TEeLynKSrVo7qzf/XiGrQndGTsFmiIqPQy6BBzS8xn1A5V8DCFl0ce4v
         rzt0pYadIwnf5KePxRNVgvqKXJJ6EO9i0PIw6+ACvgVoLGhvYfPKIeIRQoikocrNBRdo
         TVIg==
X-Forwarded-Encrypted: i=1; AJvYcCU/gf7+WlzoTk8EZbpMDrAnFEOl0NfjkrEOLoe8dGEn7f32jjjT+c4iIMO0h85oS33dwrFWwZF4a+yg@vger.kernel.org, AJvYcCUKFTgTj+wjx68ok3Y5cMPHnkxEjTMulVGxKl3bhLeJ4nxY2WXUYVY5w6uQVjl39qHYnZ465vdcLfkj@vger.kernel.org, AJvYcCWe41j+bx7Ll1FC/mw8MSF2Chmui8hoNln/n7I8bJrwakfcuqK93g6BGKN09eS7vDsEXC0oFvqnysyd@vger.kernel.org, AJvYcCWySQDsYtFDol2o1/DJoxagHAyQeqg56Qz1d9JzHtcGmmB4gZMC1JaTyoo5Auqb/70bD/JN7LxAmJVQd+fp@vger.kernel.org, AJvYcCXgRPLwFYmptCrG6HrtOawwpDdAKHGkNgsvqr32a7yHLl5AGd09LeTunL7hWBEN7ffjUaSzku/aLhXiEViE6k/olg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxBWCTVwiNWXfcs6Dz/fWuaMWavrP9FdcxtBtQDLqH6F5Q7K1
	egPiZjfIPkglm+2wjvTlve/U6DIrgrioHYtLoBajPCeAtUMEPOm4tLHy
X-Gm-Gg: ASbGnctRAKHecKxJCduxZNPmT1XrR/KDuYeR8PyE5U3Hyw2NY57p5yabpTZG68BdEx9
	WIZK9BSSAtfeiquvSJEPApt5tJeJRWnliNilg9G/xo0zObRwEpNIjRUtvJ/dXkfoR907xMLR9Fp
	u3oa728c9OKPzwmTs1xXsf4d5aB/wEcYK/ZMUti1z+Xr+eKjD51dd9dIJHKg88DIoOPxRNBGvfP
	cUGGzERLgG1Px2vE00WZMsjJe+QD3TtYn5iuGEtAv/uXZaZ8ssGlSzefsE2DTdYbTlR52t5T7BF
	ByhCxZlWMPIBeOWMBbnHPrzfU3Rx80wza86q+WNNJccSj7MNLfJYNArUu+yRIYSs6EPHglQNIph
	FJlAPlHHwaWLgOVnEukqLrd60I6tsRA0ohfa8lHUgmhTeAXzZoKwi96DAJsLGoZ4UK75vFZA3JB
	rbYe9hzMfquFayCiOsX5rCOkaxqg==
X-Google-Smtp-Source: AGHT+IGkhJ0ZatSqTvrdN7sVofatAvU35CszjTeWZR69spsiQKrhVoFE96C4gnQYc/Sc1XJis21p+Q==
X-Received: by 2002:a05:6000:2285:b0:3e7:4334:2afe with SMTP id ffacd0b85a97d-3e743342e6cmr8608316f8f.5.1757412755107;
        Tue, 09 Sep 2025 03:12:35 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75224cd1dsm2002355f8f.56.2025.09.09.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:34 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:17 +0200
Subject: [PATCH v6 10/20] arm64: dts: st: add LPDDR channel to
 stm32mp257f-dk board
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-10-ce082cc801b5@gmail.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
In-Reply-To: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
X-Mailer: b4 0.15-dev-dfb17

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add 32bits LPDDR4 channel to the stm32mp257f-dk board.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a278a1e3ce03..45ffa358c800 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -54,6 +54,13 @@ led-blue {
 		};
 	};
 
+	lpddr_channel: sdram-channel-0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "jedec,lpddr4-channel";
+		io-width = <32>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x0>;

-- 
2.43.0

