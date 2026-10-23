Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746173;
	b=HPD94lDMXWHXHLfgEX5/6csnG984HVIahuvK5oN9CBae3VcAqCFNu1HusYFhJfaPmkto
	 RaPHb9NfzLZGY38ALaHUtHWMCnTWBU7/dHfPQGyCvPeQhultZiExfVwUN913gPEHE/MFo
	 1sJcsFtpTMy3XKk1cNhOAFl5e0bm8OzEJG4S26GOST74TgWMs7wyqcbu6WyMk1DgcDcjI
	 5k4FV8Y5IQIr9iXITq4gs5jvgIseJ+1Fi6BCHR/in+C68DtP3gulr7YymHEwGSFRDtk1f
	 0MBx1gR32nRA6kx9ra/unskGX+Vfd1SONsPtasqFSBLtRTB4GLCmfwX1nlurS2hcoeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=W2u0GsLQA3bk5U1E5MxaT9meY+C2dBQS97y2j73TftY=;
	b=X9qRRbXGUUCl75FJyum8eByTI7nr2aPr/zFw2uoVRtLvL0bDuubz8jRsPNDqVgirQZN0
	 2UqxMd100y3OCBK6HaA+HP+IEzBXYD7Q52femKqdzJyZit7ukLh/vORwBDwiiQz6PXrJl
	 l1sREuCwLlUhpic4CVzgFkYu8sfSQ9e4vQDyPNS4JCIM+WGS3LW2o2uw60zh88CZa4y+o
	 12Yp+U45LFJ8Mr1oVubxRJuC5BrhQz2+MfLLVGlrzweQjsg0a+oxXPbZ8Llzt2UC1ION8
	 Q36j/DgVaOSiCH9rdCgoWrPI2zqkvFh9seTCMmRsi0wz00gVVHTiuL786f98wHas3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jDYO3Gx5;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B05606A329
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 09:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jDYO3Gx5
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso5767665e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 02:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792746171; x=1793350971; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W2u0GsLQA3bk5U1E5MxaT9meY+C2dBQS97y2j73TftY=;
        b=jDYO3Gx5vxCUFLI+EDpLCE0w+3pmENNpnDt5qAcEOnXTiU9yX0pZkVpC67JNc499E7
         KfjRzQvN19uJ9SpCZtXd+i6smfrSnWVNy+eXliCkOQZZ04yDLeeqacr7CRamTmxucr55
         7DC37bGnRav19FcH4+bouAuvIwtx7eUSK10yXu6CUVpsdZrVX9/oAx3CjMfaLPwKfww7
         9BBxXZ38DuNW04nlyOzqLmz7Xgwu4I77qS1MQtWsssMx5VsuHsViKTJH6X5sEZT6ogUe
         OdVPPaeirj7Zx6zLB0SONPOHP2HHa8tvKaO4okwwlUt6eKqsfUNP8kOZpA+5Moi9tnAO
         R61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792746171; x=1793350971;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W2u0GsLQA3bk5U1E5MxaT9meY+C2dBQS97y2j73TftY=;
        b=LmtvTdpyRbZjtBzXkf4Rmg2Z6U2gMSqeZx7dfl/zO7YbaQAgpS6WNGF/kDAbZ4EJX+
         1Ywvk7jaBITlwBhhAdQLAv3+/ScdGNSdzq3S5iEfLyyialOxYNT/R6wxeFy8uKpsQUOQ
         AYoFxy7yKskooW9hkdt+BrraRmQ/a8ta86A/LSzNamCv+daCFuQxJqStZ8e+uWbbn14K
         HUHKtHZonKq+Wr0ewk8dDl5zET3zXmBv3YFjEZSoUuwx1qVEWBXRolOh3XmxnJu3hVNa
         y2GEZZkwRu1pZWFfleGbhjqupPeAZaPU08YHCIBffRN4z6QT7Dd2hSna5bdW/uv+oqhN
         PGmw==
X-Gm-Message-State: AFq9FYIcUTX5u6G7JG623Tfo2Fe2DETk3lKBaSwrsrIU1wUGHSIzuK4w
	Dyxq/lP5eJqK6EkFcWL08q5OwhV7I1udAt1idLlYMz9yeaDHTyIQgXjvs4IbSIuLq90=
X-Gm-Gg: AYBFou3nPuAYDfdOf+vPoOl4N1b9CGcQG0QBNekqMgDsEIlQXoyiL8/avn9iebHVMlL
	a+cPmg4oIQon8O4iplpc0EiEcfihWAnEiSeXa1xWQmUmy9C/528W/OhCW2O539oHXMzNFlI8xl0
	V1ELns7r09AQ1UXG07ZA/BGNrv/abA8dAV5154dU5hE4MhJfnTd9IUr84DO5auTN2TGfuR2pul5
	InJBLRYIwcEHvW29MLawtb7sOTw4VLBnthJqmIKQ3GDTz/KYoV6SU6uFYNZj+KHg1XUbb4iJfHa
	4+9agxs9kEWMz25cUGsv1wTdYfNFF+hyZw43TgKkpUkJkYmTIabtR483PiUjI/78Im79w602BQ0
	IQ3GYnbjQ9I/nZ5PlmhrWXkkLtR5vRg9ojcLnYung8E3aCd2i/WfT3RXUlCJHV5tBTAwbQa/mWI
	xB2AfYJZXdURKE8Bc+N8tQrI831uO1bN6IxWR+DzY1RNYqsa0wQHnEK3PT96qMw9EHZqQR7v0V2
	nPrwnFtqQ1By8dy77BIgXClMKKWuRmiHwy0ryyBXbVtHLiBcKccQGhMZr8=
X-Received: by 2002:a05:600c:3b07:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4a211cbb062mr24588035e9.18.1792746169746;
        Fri, 23 Oct 2026 02:02:49 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a210487d16sm60582535e9.15.2026.10.23.02.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:02:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf test: Add --skip-name to skip tests by name
Date: Fri, 23 Oct 2026 10:01:49 +0100
Message-Id: <20261023-james-perf-test-skip-v1-0-b6c11bdafd46@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0i22oC/yXMQQrCMBBG4auUWTvQjKCtVxEXMf6x09IaMlGE0
 rsbdfkt3lvJkBVGp2aljJeaPpYKt2soDH65g/VWTdLKwbUiPPoZxgk5coEVtkkTh1728EfXdxF
 U05QR9f3bni9/2/M6IpTvi7btAzKWkSh4AAAA
X-Change-ID: 20261022-james-perf-test-skip-c923ea7198fe
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alice Rogers <alice.mei.rogers@gmail.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

We've had to update skip list numbers a few times in our CI, so I think
it's useful to be able to skip tests by name as well.

There are some decisions to make like whether we could put test numbers
into the tests themselves, or re-use the --skip argument for names etc.
But I think the --skip-name in these patches is the simplest and easiest
to use compromise.

I'm sure test names will change sometimes, but it's much rarer than
adding a new test or compiling with a different config which can change
the numbers. No matches resulting in an error means that the same CI
command on different architectures could cause a fatal error, but I
can't see a real use case where this would be an issue because skip
lists are arch and device dependent.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf test: Factor out the --skip check and its output
      perf test: Add --skip-name to skip tests by name

 tools/perf/Documentation/perf-test.txt |   4 +
 tools/perf/tests/builtin-test.c        | 146 ++++++++++++++++++++++++---------
 2 files changed, 110 insertions(+), 40 deletions(-)
---
base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
change-id: 20261022-james-perf-test-skip-c923ea7198fe

Best regards,
--  
James Clark <james.clark@linaro.org>

