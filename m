Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAD320CD9;
	Tue,  9 Sep 2025 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412767; cv=none; b=NX3WUZQr7doupEbwt5TMzyweQK9FIQ+/mpxTvYtEIHiTbqE7dlDtUiJ5bK+lVUEoiyoabWKn8qptwD0uPeIoXOTw/4Lu7rINrYf5172Vfet7mHD3EUt/4XQB2Ga5Hupa88YjwAP++Vp1wZLzOp2Xy9sLsy4DxGMdOXKu6sqOnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412767; c=relaxed/simple;
	bh=TNHhiriH8FNnf0CCQaSelF5B1lS5hSVWg6Kwr85a3KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmH31oFucESA+mIhQ0dp+KbQaxnwpwEM6CUlz76AtazWCV6fZQhkuvo48tlgQODzNwLj7lUY+r6m+ZpjtNXecgFKFqMlWFwsODvneg6ycw2+fr8SHg6RPJyIiudaA7gSFwaEOtp0HwDsAiyncBaHoayxcQ5kcXaOk/7njVGucFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0xs6xdl; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0xs6xdl"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso26773555e9.2;
        Tue, 09 Sep 2025 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412764; x=1758017564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/JnNvzakffKPPEMHSBabUxrFocT7sdCvSDe3/0LkLI=;
        b=M0xs6xdlHlUINmLmUIhiL/C9KU9ONBTmEnvRwe4W3Xb8/p7g00jRBH0HC39WbmP8bK
         XT7UQHi/GRPANEcVGeWOLL4CXh0NiEinpXsyow3Bk0siMRq+NbxEPV+ALnichYtf0FjA
         r+9P7OzXXL5JNXM1Lb+rtK+yeYkALjNL28AtBmpablcCDxlZoItv3XLjDTtM/AANv4s9
         nHh1mpKZ9jxPRijnuCIGDPPi70EGAZV1PWzjEQ+YzT0069OF9FfRAZn9XviK15HOOEdI
         ny64MqCMwfhZzJO0LuGXRJOnIehKKTRHiGfqzdqbElXSxLjAGuJK2LNG5j2+SJdybJW6
         Ispg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412764; x=1758017564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/JnNvzakffKPPEMHSBabUxrFocT7sdCvSDe3/0LkLI=;
        b=iaviBlL1slN0Iqhx3wAh6yTR7rzOKrJaIfaDvQOC5nqZmQcDJQkwzRSzHnVLOq9kj/
         LTUi3PNtTtv8FmMPri6JDCWVpoRScdUBqJO/Azebi6ZI2wa6pyzpd6H+IFQ+J6toENyp
         L0ZGlGOCpj8vIV7/LNatjNdHlF/XI0qQQktS/RAqgH3DFA+nu8bFfEDl3BGW8ZfCf35n
         BaaM1gxGSoKi2VhvMHx3BHHNsL8QTajPC8jkRJ0bxblM86c4KvVBfyJAczfplwSHlUlV
         HmwXs/wpazAPQOR/ko4LcCZv39LZf7cVmnqZYQDPlEUYSO8PG4Mlsiu0rIlcCBrXebEW
         ylRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUPAFzQfz2PhzygQ52iKrJCpwsEfBeXrF553JHCYttu3H2tWE5TiveRh7RHYwSTc17HeDHedk8h+wW@vger.kernel.org, AJvYcCUmgSS403eGbZP3zXEju7/tfzDJSUozyghcuLaTLUETKJ2hceuINxzFCNWADyjZGTqyk9htTlItQrby@vger.kernel.org, AJvYcCWs2oD570XpyYv1DdPZnAYBEbcK0J1jy2lMmIibC58ckne31g3TkyTvQzsb6WW1/MF5IWxWlvYOAsIUiH7y@vger.kernel.org, AJvYcCX/YDb2pOFgjeQpSmRhGzuDbMrCU050UQJbnh0OAUNc/9pXRDoyiGWU+ITLAL+O0T6PqSBSGszyZKKMtRv0epVn4A==@vger.kernel.org, AJvYcCXn0iwQqBInKgsJzMEWP26GBT+ZrWCq32VsOYwEjnLWJ1MxaVHfgmfnpjesC9kG6UjdlcjgSz+7QRPc@vger.kernel.org
X-Gm-Message-State: AOJu0YyAls3cfM0EwxBMwRhesvtrUn0IEdqI3hLEW/vHvTumV3vWlVhm
	+DcNRQan0AuF3X9x54TRl3fZ7umZE534gUpAMJ4joxWCLDhW1jhg5Pqg
X-Gm-Gg: ASbGncvCfj+oKLbv0O5lcn2KfrSZmbmDe7O96wejU1MC6u135UDEe+mgyf3yjWGtu9+
	5Jjc0wbReiVEH3N35f3V90wFZLFZhwF51nGEWEVD5KdVfDIjDONZaN0QmK2/CsC6AuSrQVtqHD0
	lIZwizKE5oTfo+CcTfDmY9IVLdt8zGRHLD3b4irUuMg81mPbWc47ThheU4UdPz1pWNz/JKLXexB
	jIp79nGM0JtOucu5HTMJZs4V9aWkmThiGHA9GElVA3lTwg+SAZuRenq67Bn2psGB0tA2Mn19PvM
	tdJFAl2G0JGh0RvKJi3aSO0yI4JvMt31k4IpkVUh8wd4/1KelOLm2mHlQCMiwddeodqRy0ngkb+
	WIyWAqQPOI306kpuiUYMN0PJuN19/f0w/3dtHfVIskPKiFWR4Jpy5opg1W9rUQCbsD3jvoiG1Hc
	fN6iwupYjeNDf9q1IYeH2lNPLl0mMYlulHzhOW
X-Google-Smtp-Source: AGHT+IHYgNE08p6/wajlNo3gODYmIE9OcboUMxxGcEpzItxEg+T3n0c8sN0TtIa1aNSeY+YV/NhdLA==
X-Received: by 2002:a05:600c:a47:b0:45b:6275:42cc with SMTP id 5b1f17b1804b1-45dddeefa72mr99293505e9.28.1757412763707;
        Tue, 09 Sep 2025 03:12:43 -0700 (PDT)
Received: from localhost (2a02-8440-7136-74e7-5ebf-4282-0e1a-b885.rev.sfr.net. [2a02:8440:7136:74e7:5ebf:4282:e1a:b885])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm181833615e9.7.2025.09.09.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:12:43 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 09 Sep 2025 12:12:22 +0200
Subject: [PATCH v6 15/20] MAINTAINERS: add myself as STM32 DDR PMU
 maintainer
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250909-b4-ddrperfm-upstream-v6-15-ce082cc801b5@gmail.com>
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

Add Clément Le Goffic as STM32 DDR PMU maintainer.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..a35c48ae925f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23865,6 +23865,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 F:	drivers/power/supply/stc3117_fuel_gauge.c
 
+ST STM32 DDR PMU
+M:	Clément Le Goffic <legoffic.clement@gmail.com>
+S:	Maintained
+F:	Documentation/admin-guide/perf/stm32-ddr-pmu.rst
+F:	Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
+F:	drivers/perf/stm32_ddr-pmu.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained

-- 
2.43.0

