Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892071487CD
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600473; cv=none; b=SBqMJZ//oF/Q2EmDyJdKEz42VmYdja63iNLpnrv19GRIpd2xYueMQSTNHlO9Lin7TW6zseAmIjOQIGAXTYy5e224tQxt/8g69Km3UxmchPsrkN8pw1uH/5VVMjlm7R1mKpsIlpkyu7cX4Z6AnLh9fjwdYyq9jaAjOeqVouZAD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600473; c=relaxed/simple;
	bh=LaIas9FSnGgWYVjxyQw6wf0CKP1JRSq0bfjicuu8DW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PdgED3sfk37dyniFxSNWdKFY0+SydwvWYxXLrYjmG/j5YhFMZAXeO3vZiJ4h4hqBt4lGWW1GQvWBCra1AKI07Vqgg2GSiiHeJoYGoisWh+BAniYDI507Pb7gALksyuPykaclBWzPOl47w6hUuX3fjboX09nULUKrt8GA0bPiUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SlECpmlo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlECpmlo"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1235499e87.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731600469; x=1732205269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EcWPxoJGK5ekQBUtJfy6k9Gqm5y5BvssQlwASAQE/eI=;
        b=SlECpmlosLan42iy8OJJecMC5uhNoBE8MdCkIjwWkheU1gypXox/EFJfSzuq2v1Jx0
         dZ0iZpWU5Q/pV4F/6ci6m5xmH3mhP53jSo3ljEYRdNz661pk+sbjzJbTIbG1fMwOAFBv
         KP84k/WqILX9CcJqVen/56mn9xgDOdSmhw29mzV1FrDzMUrqNsJ0LBKYJ5RoZv9dC1lS
         pl+9Aal8Pg6WhrfCS9uxZkI5y9fexoCjuGe5A+tWWJjRP2dcNvPhHbFKMskM4KPrKazL
         VpWJ7L1IOc5x/apAmuAUF2gW7iZORVcAMtttVVCCLBv/UFdDiDtYD6wGjvKRtjPeKUNK
         YOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731600469; x=1732205269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcWPxoJGK5ekQBUtJfy6k9Gqm5y5BvssQlwASAQE/eI=;
        b=nON62YRqN78vxMNNu7Nrmbi8XYWjSfZ5bQ+YI/hOluShaL4AwlZkc4xkU6NeD3xw++
         R9bpp6gBu/JohQn7BgMZJ0P55LITn95Pzdo+8fq9jKsds45fm3HvsNQoVnU6kf5Oh30d
         mjgkL09yuPQdvjKLUze8wE8RhtbTX9jWlSjb6T2ysyJm4p2MTOnFli+xB7RLHeDm+7FQ
         +QkzGOJv9H7sw06rTTLzjmyEdVN/gs3+jeE5/Xl01zzbD+unSngNHaHWUjGkVkvw1+lk
         HXlNAIBn3n3KTzAgjqDTEPggfNY655ffN5jQFMn4ESVQ+TnWUc2XWImhnHRFKtw0Y2FF
         OiaA==
X-Gm-Message-State: AOJu0Yy46bbukwQublPKCwIa2SykFJuHhPknCF4LdSJCn9hp3sEtzTKu
	yGkdGbv7npMCUJc0a+CVMWcWsmiwCpsCAPCWIIhm7ermg3znT6Rgp4jiMPQfPe2E8wlxTCozBOm
	8Tg4=
X-Google-Smtp-Source: AGHT+IHfVg9qbrSi/omD8dytmJcpkiNEK4jvQJsDZhyhdppyBpWQDWz4ozBdP6AaTQUxqgZSxkmUhg==
X-Received: by 2002:a05:6512:3d0f:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53da5c863ecmr2468698e87.52.1731600469476;
        Thu, 14 Nov 2024 08:07:49 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046d76sm77456366b.165.2024.11.14.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:07:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	thomas.falcon@intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] libperf: evlist: Fix --cpu argument on hybrid platform
Date: Thu, 14 Nov 2024 16:04:47 +0000
Message-Id: <20241114160450.295844-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since [1] this isn't strictly required anymore, because the failures
due to opening extended type events on 'any' CPU are now skipped.

However, it does reduce quite a few spurious warnings from all the skips
so I think we should still include it.

Separated into two parts so that the first is backportable and the
second is a cleanup. Also if the first one is backported then it will
fix stable Perfs that might not get [1].

Applies on [1].

[1]: https://lore.kernel.org/linux-perf-users/20241113011956.402096-1-irogers@google.com/T/#t

James Clark (2):
  libperf: evlist: Fix --cpu argument on hybrid platform
  libperf: evlist: Keep evsel idx contiguous on removal

 tools/lib/perf/evlist.c            | 19 ++++++++++++--
 tools/lib/perf/tests/test-evlist.c | 41 ++++++++++++++++++++++++++++++
 tools/perf/builtin-record.c        | 18 +++----------
 3 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.34.1

