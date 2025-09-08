Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAF303A05;
	Mon,  8 Sep 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325739; cv=none; b=qy0BI10XjJ4BsTqusykL8/lMVpVSomk9XasVQf9nMsVOMlLaUgNF4umPxrFHBlEdnRS7yPvIj3C9K9M2kpCkwt4AKhtaPuQUA4LlkK/ASL8npdb+hj9x2LcUiDVRrCO3JWQtpL0rCYAyW9ysY5PXf9bTwEZ3exuIhDuM8tKgvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325739; c=relaxed/simple;
	bh=aC00DD3jiZSVPA6I5+G806JpCyFv8tDWkvwqkbp+yEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHCwDxRjA83Vw5b5BI5/eUk+YyvnXUPrSRIcGwyzoenz51ZEYs6vxjecotcFkU7qGTMDUEvN8QJub/7e44263Ca8OOcXDdBaW9/q9IcWUNe2Akg7HyI9h8zw+vhlwp8lW2aqQoGVM2nLRO028ewsVmI16GzwWySJlzGoVS9paFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAcnoaSj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAcnoaSj"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7728a8862ccso3642481b3a.0;
        Mon, 08 Sep 2025 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757325736; x=1757930536; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L/G/Lg7srDy0beJ935wpO9N4JjYVVtt8v3yHlGagArU=;
        b=AAcnoaSjhUTi//Le+lcy1WbKfBBcVCQdaoKvAz048kLkr7EKclf352BCCShq0uUtHX
         0yyhm4hl9dhXtgzLGBP5NJpuUzBMFFp1NXmqnUlCYgKtnzZv0vVIS0PJBX4ATSnbX1Z3
         u777Rm19+7VoPFqn6efy86XND0EsM/vjlSkoUg0/uqZdEuckReTaq0OcILj+cJSkSOWO
         Hp2xZIGvuD4KvFrym9Rn76niwPamcEnJdTP0ItOjB5NscV3JEJsVMZ0p7A2ojeFmEI6z
         VRVLgqDFqFJ+k9PBAKZy6KLu5R2Oi2BTI0mQLfiBfUdIbCY9vik6pmoPE1B2L02gIcdD
         4LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325736; x=1757930536;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/G/Lg7srDy0beJ935wpO9N4JjYVVtt8v3yHlGagArU=;
        b=QvxnBYvrHIl4vwsaXr4zfCSafg7mv3BRgGOZzrq1CYrUjuLlPPwFLslWEO3pb3vbk5
         8OW02t+vAI4aNXVCvNBREWAaAsPxdRirBO4uchjTovQtAbJ6sZORlOqLFsqR2ufqs7bf
         AGvjFkCKbkwgryCIYfkmKqV+XTvAnB8gGmE1B61I6cJenlKRXo1swfVt/52kp/KhDvpU
         b0svX8knzt2J0Eowu1yqbUoG5AWbYGzCx8Rn0f0hkt08293N3llpfhivP8wHJTyRryT9
         Vk/I+qeezK3VPBtyVccttzBzx24tvpBNN4UIli1aqI5iY0Ujoq5v6TWLkZAvntyBwOWg
         Ki5A==
X-Forwarded-Encrypted: i=1; AJvYcCUCcx84zvuuUauOabu62UVfVBQ0A4wuI51DYHLbj10EIrliACNjGLqd+zinrtvFwEiX3CpB2/erEPsqGwwJjW5KpQ==@vger.kernel.org, AJvYcCUzQ+Mi2bTu/0xsgqxJcOPB4ifc+6OHRkQ2Zgb65kP7I1rHzLUL+vB4V7jzBCRDWaP5oNFVl2oULPxIUv8K@vger.kernel.org, AJvYcCX+ho3MnutKCi7H7HTiO4yvpquPe/M+q8GqLBDKOM6h9igOTAEgnLpZrcw7azBm9Q3YHHldglKmkr3V@vger.kernel.org
X-Gm-Message-State: AOJu0YzwwnKIKs5up4N2VMnGx0KeeD/rrD3tSKTjRoIxSx7Jk4sraiil
	+9L/+l4uTTbhJ2SeGsgibmcg9BqOkyFazrLWGz7OGoxA3F97lBYAofbu
X-Gm-Gg: ASbGncsRJbO5QWdspPC3x6W3F/Hb1bCsDWJcMOJr1RE10zPD22ZtVakgwZwjHOlxgEL
	C7+mXnoV96gx6O3/eswz6pzExXqKWA8+896SvAttTQ9jRMwKYJLRseTBJjY2wDOyIye04Z+BxlL
	SDvtU2QmMy+B5aLsAyPlka/1+6kLZYuhf/B13WWTCrIOiIhda3Zfr3xCucWsFzUaO83e01LFdJA
	uR4qTJb7KrVxhKHLymrDiYU7ghiRXiVcAjWj/1G1HTj0By1iQ/8Y6GCsfI/nn3vZHYBRWIiwa3C
	6QspZR2ZFp1VG84VlE3NVa1hDPNiMsb6rO1TgD/E++ghdtG6FVcWYftd7oHsRdcbJ2Z5M+qwUGI
	eNfKtOhhJPJ91t05cm0SfoHMrXiV0RIDP7yN7/g==
X-Google-Smtp-Source: AGHT+IEAIXwSOWBaq4aQTTAg+ktCQQ9sgDbFz59k1ZXwoZKqObK9N5fMVhMYXm01tFsE2HKdytctkw==
X-Received: by 2002:a17:902:fc4f:b0:248:aa0d:bb22 with SMTP id d9443c01a7336-2516e1be7a9mr93271285ad.0.1757325736198;
        Mon, 08 Sep 2025 03:02:16 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-24ccfc7f993sm107826545ad.63.2025.09.08.03.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:02:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 08 Sep 2025 17:58:44 +0800
Subject: [PATCH RESEND v8 20/21] arm64: dts: apple: t8012: Add CPU PMU
 nodes
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-apple-cpmu-v8-20-d83b4544dc14@gmail.com>
References: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
In-Reply-To: <20250908-apple-cpmu-v8-0-d83b4544dc14@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=aC00DD3jiZSVPA6I5+G806JpCyFv8tDWkvwqkbp+yEU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBovqlFBgLFwy76RbumxIV4c/4RoBztS1KNxMhXp
 g+h0sH8bYOJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaL6pRQAKCRABygi3psUI
 JPrBD/90RC79QUNeWxSVOP9mLx2PGE9DkCLNIvfuATE0hOmwCczenMR5rjgeBu3TcOy0TL5LiCm
 8BhYt4aqJvKUmWNN3PgEud4sP8LUCDqGarjqZz1v+cyHDkRe0JYy4F+PyOstw3hUr1JxQLSxkQP
 HnQjZJS4N7v1TcAI7fLUs2tRdzbayKHs8LwptI+0FaQW/lPboIjhpvtacsFdaL7XvcqpDmiDgJj
 09Z870pzP9lSW8QSO6XD6KDT42mGF0jk2EtrhOVGm8UnbQg6w/6L8KB226S8kJNo4kBAL9PriO7
 k81he20AOwARbqedkQ/Cc+KDJk4v2wp/1det7F2t5LBd2b4xvvJsVfH4HJ2/7lQVrXcOzZIi7PC
 gZWCeBTiejrJmOTg8fr1ctNBQXvTg3psIMvzneDBAX9Eo3Xg6ogoSRLljCOHprQ1pMLxIl5xbp2
 h5J5ai0+dBv+gtYuTyknryYVLJc8tizU1jqdpZFKaI8NbfzCBX6rEMQ54o+hs0m/1XkwnR0nV15
 zj/G1Hl0YagMVy73AlwTdEBo6pI3tVZiPT9O1m2YNbxtkosB7cGUPHXC0YNDhjqVws4ozr7JLG6
 mhg6FLxoU2del3YxiZxOojjgIxBxzlCHC+ujRgGfZe0BIfpfYtl//f4oYeRgYXBetbj6hQhn3WR
 5DN/DitjKgshA/Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add CPU PMU nodes for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index a259e5735d938cfa5b29cee6c754c7a3c0aaae08..fc87ab818d975974dd811cedde27292ec79f2c8b 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -289,6 +289,14 @@ timer {
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
2.51.0

