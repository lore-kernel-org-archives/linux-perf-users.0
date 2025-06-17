Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946113A26D
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750121886; cv=none; b=bKuSTkr5qd55NiSMyfco7yxDqhQlP+9QAnpKZrHZYKJYeGXkh/3MCEsiDibKLm7KUvAMz+WPMV0L60LNnOO/gJ/GCQzC1cRG6P6frORnzlULXWxGpZKgvbRGazDrdDJWSLdVyTa7JUom/ix8tpE/zVjexd/E20Vsre40eaNK4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750121886; c=relaxed/simple;
	bh=wj6A9LHFyVjwvPVEoRIGxcDa5CHiIAoWCIVo8VGY3yQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F4bsGci86WnxEzLyi0tOUHNsbrUSwz1o09wCAI7KgM64XGF2DDDMuWN/AQYNPEkWYxcEDou4icUPD4BgoLJWwzeACE46HNu4GmWOMPLfxcKvTihwzC+jMwyvU8EsuH3m5hpsWKhyG2SV31uuozKNFVod5q4cBZ8xErPyEgtvUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKaKiKG1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKaKiKG1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2eeff19115so6514254a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 17:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750121884; x=1750726684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUxUSOYgZf1bwPg50BKLldc1HPLAvephNepZ3aUtt/E=;
        b=jKaKiKG1GLpr3AqiAJm1KU27ceToez5tnX3Mlhgc9ETCIBSoQypXuafWLJcwf5gOS+
         63pHA4fgx38hpFv+gYTVhLCKyjfFFwFZRI7GL05WKrVA+6IS3AOtXQGCh6hZ33oSPUXL
         WL6MlG7Ekj3ypmljyYwgr5wNEqPfxGpTyTSH6oaYHoxM2vTtGFyldYkJOurN+Laxzbfd
         P9iXOk5dJYEfeUUSLwcbXCFgbVfRNj3ncpPsbiJrSoMa5GwuR1VHNQ8kdRE2sYcUUqaQ
         W8Q2GssP/4+++QT5LRxhWIJn+Xzz76fK/vYzzkpz5D9PhDiwNafm5r+l3xz2BhTOkzkQ
         zLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750121884; x=1750726684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUxUSOYgZf1bwPg50BKLldc1HPLAvephNepZ3aUtt/E=;
        b=o/6P0LA29GeFcYqvAxU17MUxmrCvoYcbemod+kVLIJQ+HNB4BM+rrBr/4nq6+m8Q/z
         GVSW+K3CIzMGIRglQx5hZj0jDx31KSdwsqe5MEK2h8AjEHMbjDfxqQL4lAPKqisbIkDH
         iYbKFnziSvHwdny6wdnhyybUXyHVDfV6hEOZowAUoqxucNQHDBHINm3OYeNaxOTrq0pb
         k7KVnX52fUgD2yXP0B8GsocKewhdbtoGm0YMFC86EVJDTZersKDUvqj4fSuPQnHFcmV1
         PZeKWKqoAszo4KkAD4lYW5ef9idvyMkVRTd3iokIjQFMXEQY/99h4sg7h9s1zEW3/ncp
         niQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuWAl20WmBq78Po2E7Gh/aooTdQDxA6i73s5l6Ovj7sTIdx0893321RQoLqlUDxVm2BQExcCTg281tpnh9lh9V@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8ut+qEbSNDT67xHeneh1ejejnMdP48LSPVIEBstwtWvFyman
	jdo4nYXvwMVScCkjliyxadcCnLPpCJzFkpcg0ra2G+HxSJZr6XS7dxO+DDT4rhM5fypXYEis+i8
	CXtUPOR1Pjg==
X-Google-Smtp-Source: AGHT+IE0qcZmbns6zBGFQJhOWX1LORcuNmCNbLkI+P2wzasgkJVPKeyIMLL4buG+nUEjKbNjEeyoJWrGNeFL
X-Received: from pgbbe5.prod.google.com ([2002:a65:6e45:0:b0:b2e:c392:14f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a90:b0:1f5:70d8:6a98
 with SMTP id adf61e73a8af0-21fbd295a7fmr16716677637.0.1750121883851; Mon, 16
 Jun 2025 17:58:03 -0700 (PDT)
Date: Mon, 16 Jun 2025 17:57:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250617005800.1410112-1-irogers@google.com>
Subject: [PATCH v1 0/3] Switch get/put unaligned to use memcpy
From: Ian Rogers <irogers@google.com>
To: Eric Biggers <ebiggers@google.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing type punning approach with packed structs requires
 -fno-strict-aliasing to be passed to the compiler for
correctness. This is true in the kernel tree but not in the tools
directory resulting in this suggested patch from Eric Biggers
 <ebiggers@google.com>:
https://lore.kernel.org/lkml/20250614044133.660848-2-ebiggers@kernel.org/

Requiring -fno-strict-aliasing seems unfortunate and so this patch
makes the unaligned code work via memcpy for type punning rather than
the packed attribute.

Ian Rogers (3):
  vdso: Switch get/put unaligned from packed struct to memcpy
  tools headers: Update the linux/unaligned.h copy with the kernel
    sources
  tools headers: Remove unneeded ignoring of warnings in unaligned.h

 include/vdso/unaligned.h        | 48 ++++++++++++++++++++++++++++-----
 tools/include/linux/unaligned.h |  4 ---
 tools/include/vdso/unaligned.h  | 48 ++++++++++++++++++++++++++++-----
 3 files changed, 84 insertions(+), 16 deletions(-)

-- 
2.50.0.rc2.692.g299adb8693-goog

