Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794500908;
	b=KeX8unu0xfkiMLnjUhAUovcHDivY7k8U7sBbCL88ZZCfp06NZS0SeUzUktmYa1G1mfBH
	 zk0eGVQr/LeX7oHpjQRRNb8nQ3ZC6miW3ZRr8Icym6EnDab/lS1jZ6NGIzKRV1MyEswLh
	 NKn6PWkhXmD8rCfjDckMeJpjunYTTA3hix8qLNghvVh7Q6j85jj4G2ToHxnP4m18KbjmQ
	 Ao40HhVOZUCfHgVdcnCWUmoS9r5f2ywan+/zhgPWV5jMC/Db7szqcIg00qBBoB5O7mdwe
	 uEK+nBXoRzR+QfbXGsdO6cLJtjNAzbGEcQtRfDk4CzE17E8L87QpL1qHh3hgiruUk/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hrS1i2uptDqi4qx6tpsDZbcAZjX5RWLF9/OmhrBxonk=;
	b=aOpuoTE84rd5J3kGokwOEbPe9+4d+Q8WDthlctWeazXC0k0pxy6jsvSR393Er6UiqC/N
	 ptDr6aGDhHuyQv8wOMn5OatZDIM8tcHgxAIeaIK4yHT21eT/KHleAYm3wWujtrAuFLNBt
	 Rt9xuslQ6nb85XQ7EIWFkDTBCc06AofZuuopJweWEXFZi86zR3LoawTK7kCDidz8x6Z8L
	 LpGXcrtG7Aeos33fE0ay2YWiCYBI9IVtxwzQOspg/75hPitCob44RkcPtUMwFbp/+0ae4
	 1zerGf5XnYckdfA0tyzzkSXiPRGVHdoig3khRZAfd2tDsofz8SxjSwQeWnEuefLvZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNWgrxCr;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A9606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 16:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF3A9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bNWgrxCr
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3282db206d3so123955eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500907; x=1795105707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hrS1i2uptDqi4qx6tpsDZbcAZjX5RWLF9/OmhrBxonk=;
        b=bNWgrxCrRv44X/NYFSwO19+St8cxtP9lgEFdumIL95RtoWACaMRU7T2Ato/XmuawoJ
         FOwyIWIV1T8saZbjTZ3rppvgmddU2r5D937ouVZIR6RrivK1rLE3zUd1sjxrhUxXB6Au
         cOBxE8olWi5DhxbP108K3D6ENux1C7shTR9sqr4QNrSXkFB64oKgH84cMHWhcLkH0A/C
         89EGFCgRkk25k25tamIy/euHZyzTvja2mHCuRvY7q72WaDtxI/b6n8DcMyjOCChA+pdj
         l6SiNrq/XppCJ9o8gQ4cFEM9U7n9cfhlEw7SXd3t4ZOD0JjObAmIcnIHFpDHHEIWThR8
         X/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500907; x=1795105707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hrS1i2uptDqi4qx6tpsDZbcAZjX5RWLF9/OmhrBxonk=;
        b=Uab6Cgk8JVmUDdmMPnjlwznVsZdpCPFCY9XzY9HfgAUCqKCgxQAMW5G5dy9voE9eV+
         zklUWDNNo535SOp1m6o9y1J9f91jDB9GOMgrxodj9izUN/uIEOP4deqaBXGZD4sbfT9K
         sfw/TvS5BLgwgcX/no+u+Ru7/4Squj7FTKFAZTJ9O7gFv3W0N6CZ7SF4LGYHh65e9oL8
         /TsAQ0nSUzPNoyRin5x1U6sSJpDYvwS9aoAoUiUi/bgqW9ktk/FBTgfUJWiI6dKOGhZk
         Yx9lm5Q+kZshi413NEvkUeAHVXpVGeFKQ0jS6i7Zsag6og2iLJvb+D7osjA00H5ryQmL
         WgkQ==
X-Gm-Message-State: APuU4Z8MXHv9lVA1efssRALbwhg0/2HNtmqMPhld7BLfTZU9OUxUQXuZ
	QsOiew9dn4wMP+0SbCe9uJPVRB6CMxpJQrok/BSL87PoMPyiWtiyFbHn6K8zmJff
X-Gm-Gg: AYBFou2crH8LYZB+JJ2rGP+Eld4RNOKfmOqFVwCtPcDknBVS00chzJ8QpT3NPwPSTBr
	lJaD9oG+vmqpXkGVrM+Wn9mP3df/twpav6kjBB3oBPY0bEY0dagWU4mgcsbVr/TNUMbZiaNE9e4
	0jU/AfRZDOdiEBWbTBmMCh8KHJit5d2NxCMwq87UmuFM7dE0CzVV0duIr7YmMIcUvrp9uqMBTBR
	DFQlU44BXRpUmqXmtxYa+NzM2xR+rlYkhumeXhYXZJY/T+pcqlgHiigkrfWYcUwnQyic9f//QAu
	BjYXfWl3OzSpbOy7rey+t9HmPY6EQ6lWUjERYdBThWdiyE1Ayc44JoVp4gD42Yd6mvcfjOkHVE9
	jEIlB9mLTisaSughSu37M/f5RikRaypCYXhuAsTceuPMqJrObZu513bdztVi9q0km/hZE8JEion
	290fHkUCwOl9JVpSkeIQ34QDIGjVDEwVJ+H9LZ6WVJwS5ukUOt+uj7DImh/ywSiGxOWC5P6zXqo
	c/JMT8N1hazZD2vQ9t2ZeEnOUTCXs0kfv9NrZkJJ0d9LyYDeck+jVqZxNvYLI0DOdgOxGCip0a+
	kY6xdZbi9ScPPv16lkk0eA==
X-Received: by 2002:a05:7300:fc0e:b0:376:9e80:2bf5 with SMTP id 5a478bee46e88-3769e8f760amr5812930eec.38.1794500906823;
        Thu, 12 Nov 2026 08:28:26 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37926251a09sm705997eec.23.2026.11.12.08.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:28:26 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.garry@linux.dev>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v7 0/1] perf jevents: Check the keys of the JSON tables
Date: Thu, 12 Nov 2026 16:28:22 +0000
Message-ID: <20261112162823.139419-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111150920.2383157-1-takano32@gmail.com>
References: <20261111150920.2383157-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the check from v6 with everything that was not the check taken out,
as James asked.  What is left is the walk, the set difference against the
fixed list, and the file the object is in:

  - no "make check-jevents" target; it runs as a perf test only
  - no arch filter, no summary line, no handling of a table that holds a
    single object, no special case for files that cannot be read
  - the check is 14 lines and the list of 51 keys is 13, and the two-line
    shell wrapper exists only because perf test finds tests by file name;
    it is not part of the check

Patches 1 and 2 of v6 are dropped, so this is one patch: the check alone.
The command line still takes arch and model the way the generator does, and
the check ignores them.

On today's tree it reports 19 keys in four tables and exits 1:

  arch/arm64/ampere/ampereonex/mmu.json    PublicDescrition   16 objects
  arch/x86/amdzen4/cache.json              BriefDescript6ion   1 object
  arch/x86/amdzen5/load-store.json         BriefDescript6ion   1 object
  arch/x86/amdzen6/load-store.json         BriefDescript6ion   1 object

Both spellings are being fixed by patches already posted, so the check goes
green once those land.  The metricgroups.json files hold a dictionary keyed
by group name and are skipped by file name; without that every character of
every group name is reported.

Changes since v6:

  - one patch instead of three; patches 1 and 2 are dropped
  - the check reports the file and the key and nothing else

TAKANO Mitsuhiro (1):
  perf jevents: Check the keys of the JSON tables

 tools/perf/pmu-events/jevents.py        | 38 +++++++++++++++++++++++++
 tools/perf/tests/shell/jevents_check.sh | 24 ++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100755 tools/perf/tests/shell/jevents_check.sh


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

