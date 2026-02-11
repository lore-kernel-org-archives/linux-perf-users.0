Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DCC2D4805
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774771; cv=none; b=psHKOO4oHvyAsTGAphx/tiLNbMZed2SJf9T5O5xAQZCis4mrGY6hjqhIpwgowsmALSNlzb4CNjeB42WzC/s1ShtRSl37UleA0Mpimxjwku7ELFRlGnok5vmV3HhcOcQDyUdScLFVwmnYQU+oZwxX2+vodHsuQVTJ0DRFVN1Zzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774771; c=relaxed/simple;
	bh=EfUmqOk3XgOZubhf5XdhSCqslIh3ucuA0NrTN9PxTiU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=kj/q6WZL3R4J9anDIWLWgQ2/7b0MwzMvpiuVM+HFle0qByuuD7Fh2kmVjo21YG2eswf/j6b0L8MJb7YfFND30FOBnILZOn3NdROZDx5m+yQBP8ywuAQ6EiZd9mRxs1cr2ijIgtvPdnZpFqBRiUQnyWsqqyjMgkIgRkqIQljXyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfvNURzK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfvNURzK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270e3704d6so27081547c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774769; x=1771379569; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lCuMxARVfx6wMEt/9AHi8gvAFiTeU58dc9CwRFC8+Ys=;
        b=FfvNURzKUoRrhuDoEocMYsyYNwG9JQJftY5o2iMv/7aDSHYCRoNXCoTcGdIcR4GKRw
         ykXxC1Nt0plRrfbOIwYGNSz++e1SBfW8vY4SSO3IGC4xRNon6UPL72duYYQo1lWQi194
         T9jKF7crJ1jtr1hjT7eBRnA/ReFtp5hm5SpqM5JnDVN7D5gdEbZvlyqIidKUr5LidCKK
         uKujrvcEpLoPkqWLDmccf8hcaTDDoaS7uBb4kZ2/X7/5KGr2FCcEm4b7gtaQy0FLElYt
         2n8XdAeOvVWXn8a3OUZ9xTpwaSdXgOCsKkrbyMkndxiAcq4Cw2Yb3hdyzQ+UgTgzqUFO
         gCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774769; x=1771379569;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCuMxARVfx6wMEt/9AHi8gvAFiTeU58dc9CwRFC8+Ys=;
        b=wCjlOOnbSH9+PxxzsFCAJNsBT0dSGnpJ4bfEo2N/xCCV+w5WZ407yyhIxXnboDDTp8
         OZVY4IWPy0nW92mVxEzCuMHFOONOK/Zp4Q5xVmT+loUcSeEuDav5kKUSlg3FmQs+SiGH
         XKbXABNHkTVH1QjOMQWVeC7iFbEQZuls8GF0UUMZnzh1YzICnHV+Kyq+fkTAYG0DFLg7
         nBgE01t7qaL499cmebDORK1gt27kvxdJG/TYbgqsCoo6aDFeF7lQVd+45981qgzjNoI4
         /ZSMgcHyl+NrZYy9Rxv3xzCMERgcqytCDdYvEzg0aNSi8ZMndm1qJhsUtLQS8+Emj6Ee
         IA7g==
X-Forwarded-Encrypted: i=1; AJvYcCVUcxr7E6CGX2a3bPM79tvaLdpIEu0dhqBHxK1kKoIe3VEPU9lXHlO1w8C+rSfo3PIa3rsED6H4ABvMmgXZR/WI@vger.kernel.org
X-Gm-Message-State: AOJu0YyYF9JIqY9F2y3hHfuAG9Bu/UxFa3WTeics3ma44Wnh7G1gMrkG
	6fsiDunKamUdVVWraBegbWCrusycv8hk9Hx9RkpHmsuDQeZF6gHwMogRBD8LIJG2Fjnw7UD0EVn
	ipOozeQbeZQ==
X-Received: from dlbbo21.prod.google.com ([2002:a05:7022:4395:b0:11f:330d:ed15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:628a:b0:122:9d:bd43
 with SMTP id a92af1059eb24-1272a78bb24mr120605c88.19.1770774768655; Tue, 10
 Feb 2026 17:52:48 -0800 (PST)
Date: Tue, 10 Feb 2026 17:52:37 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211015242.2700218-1-irogers@google.com>
Subject: [PATCH v1 0/5] perf data pipe mode support and tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add pipe mode support to perf data conversion. Add testing to perf
data with pipe mode and add --to-ctf testing if libbabeltrace is
present.

Ian Rogers (5):
  perf check: Add libbabeltrace to the listed features
  perf json: Pipe mode --to-json support
  perf json: Pipe mode --to-ctf support
  perf test: Test pipe mode with data conversion --to-json
  perf test: perf data --to-ctf testing

 tools/perf/builtin-check.c                    |   1 +
 .../shell/test_perf_data_converter_ctf.sh     | 104 ++++++++++++++++++
 .../shell/test_perf_data_converter_json.sh    |  33 ++++--
 tools/perf/util/data-convert-bt.c             |  54 ++++++++-
 tools/perf/util/data-convert-json.c           |  16 +++
 5 files changed, 197 insertions(+), 11 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_ctf.sh

-- 
2.53.0.239.g8d8fc8a987-goog

