Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665D3A16BC
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249003; cv=none; b=qQ5BVOs0VFn3zlml7KjQqzqst2SGmc5UWahhfawftgBh2QVz75osVyt5rB77M9r/aRJeUuYFPiVMQC3+xJj9e+uOMZcInIgFyvcFEXbZVxVC9aAZaiOWcSJouL9luhDIIxsuQB41tsCokn65ynLuv65h3+5ExKQUoEPqkedx1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249003; c=relaxed/simple;
	bh=d5o0bLguMGRQ/2438X6AeN2rnEfeqrQTx4wVju0e8RY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TVhreawxlDJi4h2K6lO9k1bOktCtWOIvurPJOkQEmC7petZR/9CEcwF76mqMfaZ0muj09XLcTn+DMTlVSnV1j6L5dTlUpGx1EniDejHxC+3s+twBerUSch3tuvx4NgwDmNor8R3T8K+1BO9wAg2wDAvyy/3uaW5rRvyorHDNVBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAH2rWTb; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAH2rWTb"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e2f61c09dso1335556a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Aug 2026 21:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786249001; x=1786853801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0U7FWaWeTy/6n/1JU9paZVB5dpBHVOskpExTpfPo7hE=;
        b=UAH2rWTbGrPrjaI4M4DOEWeob9WONe3QbSDAaZKNfx8Ori21Mc7+UIiSA23l5fF5Yj
         AX7CSs+EpVWKlvmPc2tdyPcQDTlHZUshRqBjet1Y+F+mp0Mcrg1JL+6uXHEVIyUHMOru
         aN7fpy7y9b/FwYbpbniXKmt45Qb3Ger6xzA/q77TgtDFyf/P6Ytr24BB/uoBZXPrfYoW
         h2akRXMBM+bc/jgp35rWA8/0+Sr88TsAOQlFW2cmuu3bM+4Q1o7hMqB4r1lsrthAyfBc
         255Z6chnFp2NXjibB29Uc43RD7ashMoK1arpRpEf8/aaQ1HljnQdcaOSOUYKSgDtL8Xt
         +lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786249001; x=1786853801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0U7FWaWeTy/6n/1JU9paZVB5dpBHVOskpExTpfPo7hE=;
        b=iRSc7geQbQW6/9y03QWUaPclwgd3OoplJKlJ+p86N4LTegnAvGc2oMmTm5dWLu7pWx
         I30T4ooHwl2VUR4mXrKoXtqytuXxn6b0YBJk95lLOczOfj3q4gg2U0dJy/ESCoIyu8fB
         1Eu5FDgtd4TNXVrQjEmIVI8fa9k2CNFU8wSe1OjQvMZRXGUZilBW6KnWG/CsUN/e8v9z
         0BaaIFoKWdN+Vb9qU3o+Pp6NEnaUvvVW9FpkffP6Fgp3h1mVYQNaSU3pkx/v3SiG5pEl
         oevdbBIB6zhi/P2FuxG/HftUMIfTUN3dUeZno1zMlrtaZNtF/pT+YP0xj1VnCWKnlzhx
         95dw==
X-Forwarded-Encrypted: i=1; AHgh+RqKj4t41eDZkXGpYhLgSEAcGeS8tCXoZ1v+vztjZNgxMnV+OG+ilXJ6n4p5SNC88VlHmd3UbjxfRAPDGJLflClk@vger.kernel.org
X-Gm-Message-State: AOJu0YzqKZDyqH4Wa17qOLblj9bMlZSh/UnOk0i2wODzrhrdIbYQyz6g
	zF3sDdVz41W1oXIsDWkPUJ2tosgAFwdBO8MmJFohC6pWi8aBgVH2jLWy4N7V970bKA3jNuMryFg
	0EdRMKJYkZQ==
X-Received: from dlbrl8.prod.google.com ([2002:a05:7022:f508:b0:13f:c550:f0a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f43:b0:37c:6130:7a5b
 with SMTP id 98e67ed59e1d1-3903c54302bmr35322138a91.8.1786249000886; Sat, 08
 Aug 2026 21:16:40 -0700 (PDT)
Date: Sat,  8 Aug 2026 21:16:31 -0700
In-Reply-To: <20260808065743.2328212-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808065743.2328212-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260809041638.2402705-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf python TUI report and flamegraph
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, laixintaoo@gmail.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Implement a perf TUI using the python textual module. Using the
textual framework means that in most modern terminals the mouse is
supported, the color scheme can be configured, and screenshots made.

The work is dependent on the extensions to the perf python module
merged into perf-tools-next such as commit 88439191ad5e ("perf python:
Add callchain support"). It is also dependent on the python textual
module for TUI support.

v3: Tweaks to commit messages (Sashiko).

v2: Migrate from inbuilt perf python interpreter to perf python
    module. Improve the flamegraph performance. Use the textual's
    color scheme rather than red and white.
https://lore.kernel.org/linux-perf-users/20260808065743.2328212-1-irogers@google.com/

v1:
https://lore.kernel.org/linux-perf-users/20250725082425.20999-1-irogers@google.com/

Alice Rogers (2):
  perf python: New treport script
  perf python: treport add flamegraph support

 tools/perf/python/treport.py | 560 +++++++++++++++++++++++++++++++++++
 1 file changed, 560 insertions(+)
 create mode 100755 tools/perf/python/treport.py

-- 
2.55.0.654.g21b8a5bc05-goog

