Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6716E863
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662139; cv=none; b=qmun4QkfqRsexi3W5d7BuIw0xdE45Z7qghg6X7ZXJAvgY1T8KMpqHG50mfOdJaIBzE6+DYQGN7H0RNHbTtB5TuN5okgAnyw6/IW4TgRdL0Y1A3xIgDi2p8CSR/K66vlI2+Wc4626TrLAKexeL8W7v3Ta6HvTA9B80CSElzm3N0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662139; c=relaxed/simple;
	bh=KUt3x8NLnp7l6rMq90BpQGACUXWMEdwkYc0gJ83SdHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7qaJKfJ3gA7QyGlINN7jpEyMYFpLg9PWnAz0XFLL3EJn8nXn24ar0b7CLhy3Qzp+fusr3epZOHwgdHp3E0j0+Dwp0RTm6GD9NMuQGBeJA6kq1fABiajpwMBX7HhjgAgOls02REJ/9NCL0r7Mtm26IwpW3StQkvg5fhO/W7R2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkSGdZko; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkSGdZko"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3683178b226so2183278f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721662134; x=1722266934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sGaIE2BW7BgAaIE7phZSFxnm75sxmFFkaJHJRi/UoXw=;
        b=PkSGdZkoxZfOUYfyacYLc7HSslu7tbK32XwzgShsD11le0YZWHAaDNNRdMbJBf2ESL
         /XXCj0aMK9OuddT4fRjGylsrPZImhQhUCNflbiKOM4SoA6vdZRXeg4hQRMlE4ndWRstc
         sfivehn+Bvl2Xhik0M98P1hICJzVdTy5iGeQFhbzVUi8oTLye0WPUgpMB1tkZsgtOORn
         sp279vu3w0km8Ll0w3GQ+TtAFo5inT+IC2830jGhGk7oIARYVfJQnpzhKFdOnO6eJqDu
         7s5jTEjw0V2nk9igjunoG6bV1Si5IIz6MvBlsxNZDUFykb7usufmPmYZfhIsk6dLlcHp
         alfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721662134; x=1722266934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGaIE2BW7BgAaIE7phZSFxnm75sxmFFkaJHJRi/UoXw=;
        b=qQcnlrb4wcyl6VktKjmzFefKYyVx0Oy05IqJeZJPjgqJPuL9F0p1xwOw8lORa9YqtY
         WZugX6LMA+FQ2AcxHg/3p3GjPnovY/LQu8TI2AgRTEUZQMtYZiaVQCdQmJY1ooeD3A/N
         VJuO+ri7YqOh1YUBnB2FTudlOP3oqH9vpFGbTDX16x8korv07zbMMxGYXNQAl8aUUPTk
         XaA5+RnwiQNG2EB/SRfVPGTUtnrFAlvhPDyEZwP5vngHHOmp51lfHqpSKIB9sawLX29S
         ZeUCD0SiTYj9Hn9i9eESd7EE10nZW3iVENelH2e6Gi5CmqF0MOUUzsp3wt7dPYKg8SIA
         /Umg==
X-Forwarded-Encrypted: i=1; AJvYcCXjko+IeTIWyVWYRC0UZa+HcS49KJ+jJa6fWY1zXdEN9kDCddraV16R28gsHj7Caq9HWRD+QrNnRtas6rOo78kd97TwQQjQP8h3vIb19n8tuA==
X-Gm-Message-State: AOJu0YxTraH43Bx9FN+cB4tIUe3gzKggHzwCk09XrNJLk9TxxNHgRxnf
	jfSIRRlYKTTwrMMpu97qzFpOAdwBEA5YrBJI4V4fvlFLVKZylrJ7Vgf6b/O6fVE=
X-Google-Smtp-Source: AGHT+IFf2Ks8gYykNvvkym6GDERLbQvRpWLVHjp9QVc/oQjWbWHuohfqpzS9jIPwqCj6q/nHPU9N4w==
X-Received: by 2002:a05:6000:186f:b0:367:940c:6a3c with SMTP id ffacd0b85a97d-369bb2ba0famr4873470f8f.41.1721662134479;
        Mon, 22 Jul 2024 08:28:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm160654535e9.1.2024.07.22.08.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 08:28:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@arm.com,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are flushed
Date: Mon, 22 Jul 2024 16:27:55 +0100
Message-Id: <20240722152756.59453-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed this when looking into Ganapat's fix to arm-cs-trace-disasm.py.
I assumed that seeing this in the output was a bug and went to
investigate why it happened in some cases and not others.

It turned out to not actually be a bug, but I think it doesn't look right.
In the end this change doesn't really accomplish anything and I'm not
sure if it's worth putting it in or not?

Maybe it will save someone doing the same thing as me, or maybe it will
actually break something if someones script is looking for 0xdeadbeef?

James Clark (1):
  perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are
    flushed

 tools/perf/util/cs-etm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.34.1

