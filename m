Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC5215573D
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928063; cv=none; b=cig830ryPhpV8PIFFmRgretH3j4tqlbL5wdpwmLk0h4MladI8KD+njAskWntdEoqjqDxmCHv8EdXv4dRCEpmfAB/mtTVqFtNIYs+1ZUcLpnixK1t+zZW04cat2Xt84yesKeQWQfrAeCLp28kK1QnVqrolzV04+c/s1KIXA56PrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928063; c=relaxed/simple;
	bh=rG7vFCmwd1rliTM+swRMRg+eRN6ZEAoHi+x7yTU9zsM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C+Bzm6pf+2wPfEMvuedy1rusbTTlvSWKboDZtt99C5No3Q+CcpTHEw0fZfvELSwB9wdWHLFF3DsdmJA6zRdZkw388joDuOayTh5rgKYPt8Bke+S5IGfQFZ4jaoTVBMkVBtKwuhlXNttTBNAqN229X6Gx8B0XVytRofimk7xOp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GavOPjBU; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GavOPjBU"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-aa622312962so611781666b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 00:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736928060; x=1737532860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oTsbMnh3tsWvrJ6X15aFoQqr+g1MrwtLdF9bM8fVc9E=;
        b=GavOPjBU187+zyOLR15PwpuCT0pqa99e+FracMOqrqB/xdFGQk9NKQdmupxb3YUq8G
         1KWKGA01P3PcR7lDqSDqQbgPVnxr2VCXofKZ3BV5CPE4DuNEOnKQmC+Lh9pXnkts6XgX
         dBpRuxwHhuRJZc1of/k7LoDCGJtixP8k+eH4yKI6vrFoVm6fNRh3+FyIpT6PjaJlI6H/
         GZEe9q3KwODnlaLDrmD7GCBgGk6Lg55qHdgfARe6uWlrwzxiWTWkUZUfGXlgrYC3bfJA
         wiTPMv8egVe+AsEqTKxmrJ3FsFCb9PoaX7b5cU78lPoRXSoodPvRn3vHT6EQIl8Rdixg
         7Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736928060; x=1737532860;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oTsbMnh3tsWvrJ6X15aFoQqr+g1MrwtLdF9bM8fVc9E=;
        b=Uk3dMFCdcm1tWam6d5n7kFqj2WigGeCbnilzPRkf3+Vcr2P9bDi2p7B7aR6MLAqOT1
         WHqcwNJF7oAnmJNuaKyztKgPpiweY7hyzi+87m5zjGjqCn5QOte1UOUhl7y9Wv4Ae9A2
         JDTIchSWrF5ns0oZOsCdISpDn+RyA0nR/loGP5vPCK0RnnlKsFH90gPgzdNsW17L2NF1
         gIsworo6rDafZsxtQxCE6rC/EKCG+fDH0liz43e7tRAapayLT40i0/HBS7lvATAWKG44
         9QXhdzG1crsomrHxxW0oKhAD0NuO6YSCNfVJ0+kaJKgL4iShzWqf8T2gad6lLBOLYc28
         eQ2w==
X-Gm-Message-State: AOJu0YxXPmjurUK5UU/MRfHp/WE+C7arVRQpMwZ9EZ9ZlOBj9Y4X/g/d
	TllMoqLuO/fUX1H6WpdBZPF4rxvXVEQOeK16SU9fyFLFneCEQTxtWRhqq8hBMlhViMgfjbGEYPU
	aaBzBJg==
X-Google-Smtp-Source: AGHT+IEVxc3R1KQUxqPLhTLy7g6HMettzD5hlrW97AmusnvDH7ODRQaKrV6lMsI7LmdWFoY7tvKHaSIXvZ2y
X-Received: from ejzs18.prod.google.com ([2002:a17:906:c312:b0:ab2:e663:d005])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:1196:b0:ab2:eb1a:9471
 with SMTP id a640c23a62f3a-ab2eb1a9d1cmr1491982066b.48.1736928060640; Wed, 15
 Jan 2025 00:01:00 -0800 (PST)
Date: Wed, 15 Jan 2025 09:00:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <cover.1736927981.git.dvyukov@google.com>
Subject: [PATCH v3 0/2] perf hist: Fix bogus profiles when filters are enabled
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Dmitry Vyukov (2):
  perf hist: Deduplicate cmp/sort/collapse code
  perf hist: Fix bogus profiles when filters are enabled

 tools/perf/util/hist.c | 114 +++++++++++++++++++----------------------
 tools/perf/util/hist.h |  14 +++--
 2 files changed, 59 insertions(+), 69 deletions(-)


base-commit: 619f0b6fad524f08d493a98d55bac9ab8895e3a6
-- 
2.48.0.rc2.279.g1de40edade-goog

