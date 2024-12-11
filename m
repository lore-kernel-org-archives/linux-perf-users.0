Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967A1BC085;
	Wed, 11 Dec 2024 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957373; cv=none; b=YDH7MwaU1hh1W/kIZ/q54XH0OtUBi9h/WMywo/uBMW4xbzKx4RuuKv7grmpbE8TMuNRVGuSTx9X6jCes2TYjlUa062UkiIcVLU+KDiW+TJqMdprSYhFDpNEgpZwvMVWN1yoKmNoyISoJMqMMi1Aw5OiWyTqDsyqgMGOcpeWnimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957373; c=relaxed/simple;
	bh=FFY1p0QopYu7/IIU8a277/5Oa7us2BzoRVOYRBgFapE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgc6YGhZYOCGLZvZVENRYxkf5byuUcFsK7jC8jSA+3f6a8MGQrsSLYmR1kD1Nfdyyj6hE2Il/HYPjFSo7bm1UVS464tiLwXDYFZJoJgpbewEyLg6TNvnkXIGFctZBRFiTjd/3kYL9iK5kWOC5u2t7AsYTdUke3Jk3CKmV0M7Fts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A77jva/i; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A77jva/i"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72739105e02so5852b3a.0;
        Wed, 11 Dec 2024 14:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733957371; x=1734562171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxVgYiLU2aeTmGBLQYgfiK7iXtWcPm1PqRPh7NBTzco=;
        b=A77jva/iRclko3atfdcp9trYdzdoRqPG9s3DTzmPHLR1KHm3lL5mn7zXPkXfbWj1D0
         0cB4cLlnMEBj+mom3+OF9Ifq4sZ1boupn6pa4QiC9TiLKKkIOm55Hn5NkerHYd2cRd2U
         fpHcdGpUHmN8KVmGMtEYlbdZJctQuuvMaIF/Ah205liD7kslSXuRfy77vj8kGaHHs+iK
         xlGP+W47VH8pFwawhHaHRukQA+ITLNOE3qCWj3aIYGIPvEHv2pjLy0nUjgg965CYSLLr
         fa8SomHoTW3tnbw9cs6q9zl3cK7szNNt87xkIbmHuJE6rae2BZI7MaljdGGjraPWaJdh
         P2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957371; x=1734562171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxVgYiLU2aeTmGBLQYgfiK7iXtWcPm1PqRPh7NBTzco=;
        b=uibzreUZaYSYlZouzK3crp3eL7VhUVOvtAj8nbcdE7AWlKTLk5HtFwoXsCxt4uzEsg
         ry3am6j/+Ny+B3U+t106J11206SUwc/R6gg3DwAleXTjf+fgH2qnC2roV+2GRY0hIVAe
         DxodSLym81jZAeh17azkvPnArFTbuBmRIWFAT9+58yFnQFEgWViMUKJl3OK6CY327hg6
         buHuRFWRHDNX2kjhHy5Zruzl4zmEcZQC4tFyNbCxl9dh8sUo4KNasvlL4mr6BHDrSAY8
         LHJ6L2m+OP7gp7bR5SUyr1+SLg2zz4lxoRG3BI+qCXynQ4Cv34pltmZVuxXprnawgJFN
         BKeg==
X-Forwarded-Encrypted: i=1; AJvYcCWs9H9iKzfj4oCx1JPu6LyaRIN/ax2rYoX52RHVy+7lJPpKOH6v8r558pbmlrJaI3l1JhHPHvPBsly2G0LmaDhm8A==@vger.kernel.org, AJvYcCXjyBnQmII+IG1ZowYtpHFHtkjooXmdHUrsF5+phqqPWFzb9gsMjoFICaFx6zdMN3glTunyK/cZPUx1ovY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT451w4B4bI11Wdesrjy+IWihNkeabzB6wLBceva2U6Ml5mcxG
	8TPwBNHrE4lvwB0Zpsr4VCraVwREoRSPxLMGvCLQIw6GGXgRLT6T
X-Gm-Gg: ASbGncuLxtURQcmpRqvGVgGfv4FSYTw3qUkwNY343ozw7D+jlkYQo35bWrY1kXjUvmp
	lO/eD0UlHiBynlYYzm2a4evWUj3hqDsortLXpXovvvT7OuchgOVSKKVjwobhp2PwzxIBzdGGjnu
	JFp0OLRUNih3CxHmB6KnQfnM3VYXiG3VsvEuAg2Agd/a/3cWTjdnz4GFeBtu0rc6hTZHq+v0Buj
	U6Q4rKZ8sGiQ9t0WDAKZqXlw+kXKGhXAbG7MQJ1FfLDsvO3pAYEJG+dPdIU1kszy7oJN2tuqn1i
	LDXdPH6PbWXB
X-Google-Smtp-Source: AGHT+IHikvdlrMEHrPyv/vfKfCBciw4qtl8yTdM4fMULnRZx0k/+XNygDj0i6tZk0a84jKR6Zlvgbw==
X-Received: by 2002:a05:6a00:895:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-728faa2a486mr1390945b3a.13.1733957370752;
        Wed, 11 Dec 2024 14:49:30 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-728e2520144sm3430506b3a.116.2024.12.11.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:49:30 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v3 0/2] perf trace: Add more tests for BTF-augmented perf trace
Date: Wed, 11 Dec 2024 14:49:25 -0800
Message-ID: <20241211224927.968483-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Add vmlinux BTF check, and skip the tests if it doesn't exist

v1, v2:

The previous version of the perf trace BTF general augmentation tests
didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
<acme@kernel.org> for pointing this out), this version uses bash instead
of POSIX shell to pass Shellcheck.

This patch series also adds documentation for the new option
--force-btf, which is used in the tests.

Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/

Howard Chu (2):
  perf trace: Add tests for BTF general augmentation
  perf docs: Add documentation for --force-btf option

 tools/perf/Documentation/perf-trace.txt     |  5 ++
 tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

-- 
2.43.0

