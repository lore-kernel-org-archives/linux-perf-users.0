Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669363F8E04
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975934; cv=none; b=t+4Suu6dIX5hBj6AEb1LN3aPy+fQodoDaK5ktSD+0cPsjH0AAhLFtw1o1iFvMjI2Z5F+VcuO/Y3/0Q5MVjNdCq4AD6kbpEZnznAh4OUNDfNtTx2pf8jl4jX0bOO5XB3PhQVITReMm5FfwI9hQLzCqLPVl3Lf05dGcdk2S/7A5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975934; c=relaxed/simple;
	bh=kHnfUwLJahUDKkrPkdH3H8aBQZPyQWAQf8Bdc8e7HCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0L7CLmri/8JkA7uqWlHaXS4SdpSXyyX+aHVTCe9Bp/mjON6U/kZ/Wkc6xyLqO9jWBOz1t6vQEDKim8M0V7sad/hEIc5n+doN60jhbACUyBJDsijNZNct4sWQ/CJlCtdgGc1MbKyBGUQl0wmmBhWH05h55R2pxVw+z8PLOhLnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUS7WcZb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUS7WcZb"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso4996035eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774975931; x=1775580731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=38FVmXXZNeUcBLuXOV/xbKf/kv/wfvA0fkw5xGUzxgk=;
        b=cUS7WcZbVlh7CP315yCDxdIovGNB8WWTaXwJzRphfAKg6lHZAKv+OEbTaod666slNK
         OtMXOrbYbS+Sav0NPmMliVO3NnyoNqYbQ1RrOMP5DvU40Hvf6wQDaQCz6+PDBOcGRnBu
         kE/fyoBKqh0AiD5J9w7n29mibcaMmZxMf/Y6VaGPJSeI5NMWy4mmnNR7udvfWHG1hy6q
         S7/5zcv+TLjVjajP8eLtITaq8u6qiRdpj1uc9IHYwZl6qqM9422DlD2pEccs4KNZZhow
         Zj39UAOflhwCfmx0Z62byd+YRGUN1zuqvukIcwWs4mIBlnN5FT4AgHxj5Ad3NLNzGUF2
         UOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975931; x=1775580731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38FVmXXZNeUcBLuXOV/xbKf/kv/wfvA0fkw5xGUzxgk=;
        b=VsQLGPdAWayz+J1eMHpDFK+jUZ7FB6vhWulWio22M1QluLGRq2mXptlXZq1MJLDw3S
         Wf2elAUza5eiB+LoJ+UsePm7+ba4BAIauTEKO1bZAjkYXAWt+Kg8z//1M5uwB7FlaAEf
         0gxq6lrwYMzOvmUdNOweiAXQq6j+Hi4GLsDglSt/PuWp7amENX7PSPwPazbWxDIRq614
         K48ZeMC51EBCIqVnGjnEw2WoaYf/21T564DGdJB67v9WWl1/sigAQ6z/zlog7xP9pBwB
         LIjI6owB8AgbJnZf7UCjuJqUHXNMTNHT7EP2mkueTJ6BnJ5VgLm8AB+scvlTiTQFo+r2
         ba+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIjlenBiTGZeKVvucmoHMAjHxCabv1BIdOeaAapmHPlzOv8eRvVBFGAL+irhr6qCLQUylnJbFJQFmW8XCOdE1i@vger.kernel.org
X-Gm-Message-State: AOJu0YzEia3C9xJyVIbx5YrSdMdZ6HpKvIur1khQB6ObDpRvBddcemsL
	Vq5uPBjlBBaSr4tyDn/1RR6P9lWVVqwrihZTBSzRM7SqMSAjD0fd8HVRUtsLxZYgfbHygjG3Gaq
	6LL45x3F27Q==
X-Received: from dybmt8.prod.google.com ([2002:a05:7300:d588:b0:2c1:baf:2b92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2b84:b0:2c0:c7cd:1288
 with SMTP id 5a478bee46e88-2c185f37968mr8487311eec.27.1774975931193; Tue, 31
 Mar 2026 09:52:11 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:52:05 -0700
In-Reply-To: <acs6txqcncbwCFZA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <acs6txqcncbwCFZA@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260331165207.4016392-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf tests: Add tests for uncore and perf metric event sorting
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: 9erthalion6@gmail.com, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, 
	german.gomez@arm.com, irogers@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

A thread changing event sorting highlighted a lack of testing for the
more complicated uncore and x86 perf metric event sorting:
https://lore.kernel.org/linux-perf-users/CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com/

v2: Address indentation and other nits from Namhyung. Add Zide Chen's
    tested-by tags.

v1: https://lore.kernel.org/lkml/20260325183045.1229502-1-irogers@google.com/

Ian Rogers (2):
  perf tests: Add test for uncore event sorting
  perf arch x86 tests: Add test for topdown event sorting

 tools/perf/arch/x86/tests/topdown.c     | 129 +++++++++++++++++++++++-
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 122 ++++++++++++++++++++++
 5 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

-- 
2.53.0.1018.g2bb0e51243-goog

