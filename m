Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324827703A
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Jul 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383984; cv=none; b=E9GIr55b3+f4APrcr0W9AkclXfbeGxgJA0jvzJGcTMogzy4yy6lUrlKQuH6nhokP92StoccYLVdyUft8jglOGn+deRSiyLlUVdPlx4m3el4d3SyN7jNnrEOhHzKOgYrXHI9IbdZSK3KyNiRDqg9ifRVd61gBOul96zT+gAaK3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383984; c=relaxed/simple;
	bh=vdTeF/m84YT/Y3csd4U3ldiSvdJObzaAHVoYx1TRjzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZy6wexR0G99drY33whWHNEINLJ0cwUfom43DHgtaKBiJsZEZHfzSqo4FmIKPJScvv6SlsP3CNpI8g0gx9JundXZQybFLGgGUz6rBnZfLnfnFceFsaCJq0mU1NxqFewK9w8gYKNT0dMVuJIieCtJr4IWug5QUEbMV1wi+FPUQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y/G+ht0/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/G+ht0/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so41227195e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jul 2025 08:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751383979; x=1751988779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwP1GAWiDk39SfGOihsNEaC+24qtW3947zs4uYy6dh4=;
        b=y/G+ht0/7776Gst8ajj/j4rB/oZfTOcqoZ5lYvwlRpeza9V41ONyiEU97bxnnEG/tc
         hWSBBb6UWpmW1kWLV6Iv7UJLnVHlnL3MqqJhsSdFX8Kyao1XTpH6ndtsgsBsMM+qiZaJ
         sxzHI7WtJDauG3ntTRYE1FpQU6sknQ+1IxSIIXIDOlCQY2WaIJ4CVoR4szCUC8prnkZB
         iB6Ly4lDKG9eJlVOs0AIdW8DXdGRCg7AP8F3ROTEKv+zOyzRn4dY+QQvpJz2USTK3k/W
         +Mi59Qi9saU7zmtR8tA1aoehs3I5l0+AnQRcy607bHTDCLiyyADAFKw5YvT49UEc00oZ
         Q6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383979; x=1751988779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwP1GAWiDk39SfGOihsNEaC+24qtW3947zs4uYy6dh4=;
        b=Qfadh312u0ew6kVe/uLL7inZDlRMTUzqfW/9/KCr/8YZkWnXdiqmasElm3aaIJU3Nf
         sCd+O1Isuc4hjTKT3FEQ6A7eITMeTpAuWlPb+4viRtkduuonbsK0S/zKcZJesUC770sq
         LL7O8M2fbTkHypNG6hQCh1GXaB29eCwlbyVdBwUZJ+6i36U84OhpYpAD5r2+iDZ8zT8P
         0WQ/ViSdiLLiNVns4nKmhKuxzkwIdDZRq8wBSBaoIs4Nh6Ki/Xli31VvbBZgivUuM8qJ
         KVIygbhPASCquz4eMJSyDNTzxSONG1wW9jsmAKIqybbwmVVHoEhLgLJpWeIN/oh2mEYX
         xl5g==
X-Forwarded-Encrypted: i=1; AJvYcCV3JXomP5ow5EO0Xxu6ZHe6A7u6scrYZ53Vj4Vx7qHmMWOE79pdwv1uwe1McoGv0XAOHWep56lKVNGFZ+YTjmPG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+FHx2+tv01QZOlt1Dvxyllr7uuzuug9YTOHes7fnLk0Jr97ns
	dAM3/tlFafVK8Uf7XZ7RElMwf/1liGS/xwNBW9ntHQtN6KsCKrk73iBDP0SVrvSR3j0=
X-Gm-Gg: ASbGncvk8mgTlIja/MHdb2Zs5HRSP8tdkHA9RNyFN91Jh4M7apyAB0Bu0ftcsRBf+Hk
	GcFHh+1MWXHoaIpU+RWdIm5ygpP+UgQF6Yzq6NKYJlYiMB+jJDfRrnEYcBlj+dlAIBDfd9vZcru
	cjj+jiJvVhr4o0kwwzQlHWD8sQ3/yKzwmf0/GBzj7pk8czA51s3FhzQgC+okeYH+q1blwb9V0Uw
	Pry1M0n8YAixkJ4HDIvdJBcsj2upU8ydiHAA2BRclL6poRtjUTnCozoH7Ne2lLATPm7fVjiIdia
	PyJfneeuBcEv1kJUX/OZO5a/CJ5VnMZLHHphjlLbSoubPSutywDdg1bRYNbr0hzzAD3UxYU=
X-Google-Smtp-Source: AGHT+IHBcNPypFwgfB92PgKhi+9On3myyxGnEdMTs6aSK6qgav8gtvbdSNFdxrarSqsinHbJfbzW6A==
X-Received: by 2002:a05:600c:4f02:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-45422f35f0fmr28544995e9.5.1751383979349;
        Tue, 01 Jul 2025 08:32:59 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c80b5a3sm13435002f8f.40.2025.07.01.08.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:32:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 01 Jul 2025 16:31:57 +0100
Subject: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
In-Reply-To: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Alexandru Elisei <Alexandru.Elisei@arm.com>, 
 Anshuman Khandual <Anshuman.Khandual@arm.com>, 
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>, 
 Robin Murphy <Robin.Murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
buffer is enabled. Ensure that enabling the buffer comes after setting
PMBPTR_EL1 by inserting an isb().

This only applies to guests for now, but in future versions of the
architecture the PE will be allowed to behave in the same way.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4e..6235ca7ecd48 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
 	limit += (u64)buf->base;
 	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
 	write_sysreg_s(base, SYS_PMBPTR_EL1);
+	isb();
 
 out_write_limit:
 	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);

-- 
2.34.1

