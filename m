Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D663B22CF36
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775271; cv=none; b=UGi3UJp8DdsB5tt7G2Qog1LjRMSJq3DP8r+1uhoaoQYYubUt09VPVleaZUJ/Th9IchIi4CVOZaOp/OeDBY5w7zWEzMzd5W00aA/S8oa3TqP9uGgj0CGT8GiuzI3ayn0AI2RXSL63RbPCJ6OvD1mVtrQjm2OzKqpRz7KmQtcjl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775271; c=relaxed/simple;
	bh=mhfKsdxy4ny09CpivFZEqqoBkgWKbVRCHfE7fxK5B7Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y4fKmUZDgbGVMDSzj9CCenv0PTmh2Nu/wpWjVHQ8MKzbqLzBFYcVqFNTjiTg51LRkMh4CNYMoo0uMfzr2QFO1pLET9ZMC8tKKCyvu4tjvyXSgylRDYl0Wxmxs6eC62ltlh1YiEb+PxEt6beUvi+mPWaZ8XR/R9Z7jY/6t30KXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mskKPRml; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mskKPRml"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa622312962so402617366b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736775268; x=1737380068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2K3+InxgWdcedIUmFC5ZBMbgnGaWRgOdwpB/Jt6OUHI=;
        b=mskKPRmlGzGAzPuYDlI1PLo53Ea7Gp8PjpAiAT7SU0Eotkay22LCBl/IhmsPqAc3bd
         axQoHHDeYAP9fXgKHNEFJEeFqwnRGTB+Cl1GCn9093lyFjfyeZNuH6qMS5lV/Oe0hy7M
         TLU8HMv6YXo6mC2qHrGR6ZLNQsTCPSozRD9U81fxL9CXs0VTtA0ihMOMJpbepLf0oOId
         feCD5GAFoLVKuaaHAwMY70j9EBXhKqYpVPeT3YgIa2mEjTrr7MgoNrkSSeYdBAa/o87l
         GheivL5Hx4EcMFhFle90k7L5KvnnXuK8E6j6EQQKwdN82KRU2h4ksTchauy6em3Rb5dL
         hWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736775268; x=1737380068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2K3+InxgWdcedIUmFC5ZBMbgnGaWRgOdwpB/Jt6OUHI=;
        b=I21wkAzfO+tECHbOnS6faekJpRefscvG1QEzRd+xrS4fGvWO2OJdgSNsET2QTMcTnM
         xEyOBqjd7KDre3rQiKcTfPDqsoANpLi2h48UpKVjiGHEUEMP+61vb5rbUZFA7OwngZkU
         3wYfpmWoF0TCtL77xgWUBnnBeslGT105mjTiV8zRaD9wruKaHLu9iAZpmr1SikzxFEUq
         DtYugRObH0j8BTxIJs+5ZqrK4kiwIIWWFOWXwmyD7nqtzLVhgkqsu/SUlRVLxmG6ZuLX
         bZZ4uDwrb3CKYbmL4fzqIv4WoPYjHeyoggjWiimVee8LqrDPBL1c2/y5HJkBnHwewpKP
         kCRw==
X-Gm-Message-State: AOJu0YwSPt2JsCOw/iTGwt/bx8b58WVc7wqkYs/1gCAOs7LsNSg07FZ2
	jg5ZCIkHRMw5ypd3B89Mg0yclZONTgV8hBgFuzWMvVCwdQmTeHdm7ZLOrwkD6VeQCtEGg4uTRxD
	3z7CWRQ==
X-Google-Smtp-Source: AGHT+IFLl3aj3KyIPB/I7grW9IgFpMaf/UuPgW7QssbZLcQc0R06FWJrx2b3EGuqN+/97/axyKG4G236zsgQ
X-Received: from edsr9.prod.google.com ([2002:aa7:da09:0:b0:5d9:d4a:7e1c])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7da7:b0:aae:85a9:e2d
 with SMTP id a640c23a62f3a-ab2ab6bfa39mr1996807266b.45.1736775268330; Mon, 13
 Jan 2025 05:34:28 -0800 (PST)
Date: Mon, 13 Jan 2025 14:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <cover.1736775109.git.dvyukov@google.com>
Subject: [PATCH v2 0/2] perf hist: Fix bogus profiles when filters are enabled
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

*** BLURB HERE ***

Dmitry Vyukov (2):
  perf hist: Deduplicate cmp/sort/collapse code
  perf hist: Fix bogus profiles when filters are enabled

 tools/perf/util/hist.c | 114 +++++++++++++++++++----------------------
 tools/perf/util/hist.h |  14 +++--
 2 files changed, 59 insertions(+), 69 deletions(-)


base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
-- 
2.47.1.688.g23fc6f90ad-goog

