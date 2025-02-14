Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFE25D52B;
	Fri, 14 Feb 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739543430; cv=none; b=cHuK7E3nz7OkKPpJv491Qbm5rkSJeFClE2AUZjO7vfWRzE+zdeowS8RsqT9OU1gV/s4SGziFQM7Q0eIEpzTmHj5mddfwlH4gYYTzBRoOaDI1ArBDvNdV3MAqM4XVa0hRSg2xUBpuDr2AMeaehUJxCFszZgiEH+l6JRlNS5+i0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739543430; c=relaxed/simple;
	bh=gtQMWCY0nW0A18HtWxRoKoFtQ4tFPKmIdXgTS2ef1gY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NDWyUGXPEGhz5l+i5KB6B5c/D0Z6xJVAguzn+HBPGmpEdeE0w0N3uXHygmsqzjLvh4m5LdwXTMwhGONVEwLYRdmMWEycHRoP0gKCyKge4T8RtKUoCofEy7qkVEbNYNdNtXFBipjGD4Y3dz+8yZZ5yAo17Zr+0kQd7I9/IMstizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ2RVqaE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ2RVqaE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so3145365a91.2;
        Fri, 14 Feb 2025 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739543428; x=1740148228; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35aTfl9eEGV17VrFB86CmV/usP3FQo76VFTBz22tACk=;
        b=QJ2RVqaE2iC41F1TD7sRi80adMfro/bTmQi8Sy0ULsSRNUCWzX4Tas63K6CGtYldLR
         UGsEB7RQ20FH9Pq3cdtzBhNrUiRkgWio3K4eNh+xeqOiXOdxh9jNpCRwbwpL5e4FZwE6
         Ky0kWZNlUmypHIk9gwjXo4vtwPb1911knbSDDuRJH3+7JV5dBNTiDhi2S/FdhUA6mduJ
         WtzfOd+2ThWMyWwXrOn8K1v6fftkxmH97R1Gf6pCGqSA4a7v2qbneJd5SYmVAgIJ4YBR
         vVNCjV2wfxzr+gKYHYhGcRmb1eYx84cBfBYrsUZQBcj/GyzW01veeuSlyX0p4NqoFiRE
         bKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739543428; x=1740148228;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35aTfl9eEGV17VrFB86CmV/usP3FQo76VFTBz22tACk=;
        b=PtMa5mcJcv9sO5WSmTmG2xlibq+CnbGksNtisqzIvxCWBAxr3DkT/P5DNP5nNAKCMM
         9SOPP35ZRJO7l57ZoQUV/TukCwZzmvyGTr4KGZBfA9vjIiTH0n91Tg2o368Xh657Zvru
         kgfPBZYjWTypWM9nTMuKB68ds1kC5pe1ncnj0YSTBnFdQsuHZR0LmcUSGTLt6RorZKGW
         tw5ewCGALfx7XHp8GYQMHrv4SOPC7KWI3HOpS6bpE4FFz8RmEPobl59pSEsrloyA4Grs
         L8ChpgVCtBjwEZrgkoHEw9lrKgex5krytk/rRhVqbzVOSNYuYDDRWCo0g5hQWjNbZsZF
         0mFA==
X-Forwarded-Encrypted: i=1; AJvYcCV/XJflb7nwr781EIkmNRTfZ0KIhMTPaQyH0WB0Ap5wRM/begav716FiOFEU9N4ARUracBTJlKT9xHB@vger.kernel.org, AJvYcCV5zob90aXpJ0zJq0wIMBuD1lBEDlRsGl+7y4HPgeU8cPDlebxCeE3nUjTVgL8AgG893NiinAJqtW9n3XS4@vger.kernel.org, AJvYcCWLYKauvrJoY4RDnk7XoUvYHu55CGqOCEJwi3PerND+tKVZmGR+Xwqra+eg4TlUmwf7b6zevResY9K08JzvCIljkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjthwhAfH4rMqimO7DZ0eHSHoqg5XQhjJ0aMuvon/Yk3BdsLz
	zrtF+APb1ZGB1F0pHmh9PU4qZBqnBBWkEiR7aAZ7jfDalW1lKLdU
X-Gm-Gg: ASbGncsMohbSbeJYlfikI85D7E29GsinPqJo7S5JLnC8oRo8wG5AsBdDmBxu2EDhcfS
	hijqFtOTHdEIHVCwyC0wLqRpC3SCFxu0SVBRxw+1JMZugXRFI9Dbk4aRE1k0uVIuoqICnpUo2bP
	3nEi53mwmgJjkBM4Avyv6u5CA1hz1xBaXKaCm5AVO4SjqRG3d77vL9gxhDzDxTk8N1dJvfvgSbw
	5Ew/xNX543+mmaBFuMxUXm0Xsa5uDgULyJbbW09vCcMutUMxxPktLSX/akTyR7GM+xH4l/Rsg4l
	CVZ69cQ1zRUP9nKGTg==
X-Google-Smtp-Source: AGHT+IGs2oJbWsBd2mmLA46RkL5aQhsZza/epKIJ6zzfwAjcLXEGBDxv7SMnURG3VhsbOrnsni1MWg==
X-Received: by 2002:a17:90b:3904:b0:2f9:cf97:56ac with SMTP id 98e67ed59e1d1-2fc0dbbcdbfmr13243789a91.0.1739543428566;
        Fri, 14 Feb 2025 06:30:28 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm29490315ad.113.2025.02.14.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 06:30:28 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v4 00/11] drivers/perf: apple_m1: Add Apple A7-A11, T2 SoC
 support
Date: Fri, 14 Feb 2025 22:28:26 +0800
Message-Id: <20250214-apple-cpmu-v4-0-ffca0e45147e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAApTr2cC/3XM3QrCIBjG8VsZHmdM3625jrqP6MDp6ybsQ7SkG
 Lv33CBYQYfPA7//TAJ6i4Gcs5l4jDbYaUyjOGREdXJskVqdNuE5L3POGJXO9UiVGx60lKUELaE
 uBJAEnEdjn1vseku7s+E++dfWjmx9Pxm+z0RGc2qEqgyXilUFXNpB2v6opoGsmcj3FL4oT1RUD
 ZxYDRyF+KXwn0KiDVZGSI1aMLOny7K8AfzAuRoaAQAA
X-Change-ID: 20250211-apple-cpmu-5a5a3da39483
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=gtQMWCY0nW0A18HtWxRoKoFtQ4tFPKmIdXgTS2ef1gY=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnr1N7RBkPZAp85QlcDJZT0ti1VtbqLJHg+lrbB
 gcL1iCD6yyJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ69TewAKCRABygi3psUI
 JHZaD/4ydiNHvX1RevtAsKyPrnxMj4JKddZn5+JxVXazvY3+KP9r8pJOqofBxsasQb7jSUqyRRY
 MrC784SMe8P123v4vCmDG5/ODIBVWrXZdAq+08Pu0luK6K8FJF8bBLItkkeGSTjyS1e5ifGdGvX
 /PHxGeTI4/temzJKL9GcnxE7f4vAf9qMDqglc8vuDoX4I6zHb2KnbbcHkrnNXwNkSB/wHO4l95d
 Ly5ltUSUXNusvz/EmijnAZWFq3O9XiVd72hvGMHhFjNPxtIsbMPOOY4jiWHmrAPWQTgaK/1dJLL
 4/W3fBB8EgAMEcWFJrB6cFEn8fsuCaWZJcIHQgD6UlInDmV2xn0tMbVpvCPH9rdpXDsMwwdoEZ7
 IU8BV48qsuI+YHwATC8UGwxJd6GOI3bKGMIyqXEvKCH4wm+vapFJZV43cYmxoJW1HqmzqgEcrBr
 hLEBAu3v39zQS7JLx3XZv1Vf6ikmO9d1neUJFN0XJjItRx2OMGM8W1madyswXX34dWtQBenkHh4
 zHyYtkM+DWO9MMhAKjHItA9UZrmA8HfiF5r+lQcZ8q5PiEE43dXOc0ydKb9zR8fPJ86r2iRBB5t
 aSV11KZKbnHBqhsuN43t0j3L4t31QzdrMs0FZiii9nXLZqyO8+Ac/ggcKKmntMI1QAOBU8TPJA8
 LndGEHDir7iZk/A==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

This series adds support for the CPU PMU in the older Apple A7-A11, T2
SoCs. These PMUs may have a different event layout, less counters, or
deliver their interrupts via IRQ instead of a FIQ. Since some of those
older SoCs support 32-bit EL0, counting for 32-bit EL0 also need to
be enabled by the driver where applicable.

Patch 1 adds the DT bindings.
Patch 2-6 prepares the driver to allow adding support for those 
older SoCs.
Patch 7-11 adds support for the older SoCs.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v4:
- Support per-implementation event attr group
- Fix Apple A7 event attr groups
- Link to v3: https://lore.kernel.org/r/20250213-apple-cpmu-v3-0-be7f8aded81f@gmail.com

Changes in v3:
- Configure PMC8 and PMC9 for 32-bit EL0
- Remove redundant _common suffix from shared functions
- Link to v2: https://lore.kernel.org/r/20250213-apple-cpmu-v2-0-87b361932e88@gmail.com

Changes in v2:
- Remove unused flags parameter from apple_pmu_init_common()
- Link to v1: https://lore.kernel.org/r/20250212-apple-cpmu-v1-0-f8c7f2ac1743@gmail.com

---
Nick Chan (11):
      dt-bindings: arm: pmu: Add Apple A7-A11 SoC CPU PMU compatibles
      drivers/perf: apple_m1: Support per-implementation event tables
      drivers/perf: apple_m1: Support a per-implementation number of counters
      drivers/perf: apple_m1: Support configuring counters for 32-bit EL0
      drivers/perf: apple_m1: Support per-implementation PMU startup
      drivers/perf: apple_m1: Support per-implementation event attr group
      drivers/perf: apple_m1: Add Apple A7 support
      drivers/perf: apple_m1: Add Apple A8/A8X support
      drivers/perf: apple_m1: Add A9/A9X support
      drivers/perf: apple_m1: Add Apple A10/A10X/T2 Support
      drivers/perf: apple_m1: Add Apple A11 Support

 Documentation/devicetree/bindings/arm/pmu.yaml |   6 +
 arch/arm64/include/asm/apple_m1_pmu.h          |   3 +
 drivers/perf/apple_m1_cpu_pmu.c                | 801 ++++++++++++++++++++++++-
 3 files changed, 777 insertions(+), 33 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250211-apple-cpmu-5a5a3da39483

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>

