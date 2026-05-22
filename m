Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0B3909B8
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489257; cv=none; b=pbTe3s0NfMm/MoHfMAkld2eo8HuMk/d/d1bGTVEj6KHZUz8xie2DE9XkdNm1fNcuaPHSfsQVYs2GCMlXokqzQmLJsGXClK1Ew8o3m4ja+i/EyyfnJoIGeGBJQJUT1eB6AkI5heBdKU4nhjB72SCKIu/Cd+UdVBqMm6ExHo7kefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489257; c=relaxed/simple;
	bh=+GDPFK96LQIDUsVeVvdUUn4Jcb/d6dmTMg3sFaT7dEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M/mxyEjN6GWeU/GyAfokKoqTx6khPJe7IZ2vofnkeyqliEUbHQKRxZ8K8qwziiTWmMpQfWKHCa1yckgmRvFq5xtkA4X0Ua6fMl7cd7FKuUpeW0SNlIONxR5epmLPPYn6LhztGTRJAqmizEaqnhBbl/OiCNdksfwmIvnBzrxZ9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bD96NsS3; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bD96NsS3"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d631edaaso46042069c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489254; x=1780094054; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sblp1Q6dJebg6sx9UNRnZOmxsbwknght1WKM1+Jo3Xg=;
        b=bD96NsS3wIzIsgZIY9uGUhcI9627pCDfvsD1G9hU/p5MSdWYoA8j5182HPjWV1SwDR
         Qx3DPb/K9ouWaT2YNjFlOf8OBIjdq+yc9QdumW4UQydtkc0hnoLTx1agXycwGoEWMSl+
         iF0tDHv8ZW3rYfNZlDCL6Me2vuMBSzhVqu7CmT0lRUonkHBBZ2FN0j/kRXd5kTpsRUDK
         75Ic56jx1CfVl17NhPwwH/jpB1qymOW1eP6StCjD37YHJKgyYqnAXvejj5o9uzg89D3E
         Ch4rzkr4Ga1TO6gnLBDPoWCdIWk53UFHO0W2Z3L8loT5cn9jtu5/GVgfO/nfetKp3UIn
         SD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489254; x=1780094054;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sblp1Q6dJebg6sx9UNRnZOmxsbwknght1WKM1+Jo3Xg=;
        b=D31FcPb6JT2xs2wNIu1kepwDVQyDTxz4EwiRiEFgReumk5xB96lRUn7geemBeBTsTi
         FDIXSZ8RIOjoF5+D7jlDNMx63gwLMPKvH0uiciYCM99Ds6ooJUdIwwQIgWklqEAbiUvX
         3U/KQ30wV+tUqri4L9Rei9JaGU59TrABw61SkqXJxoXiAtA8FBa8HY1/v9dzDlzJr6pR
         E3rn84EtADnTnxWvwWl3ndTaxEIRxbAK37NCrYOgClZAKhlFvu8p8MRy9GY83nmH7l1h
         m8BRFxDdke9+Vmyf9UhBn85xNO33vGR5cC/QpQfgqhEpfVGdsi5Ea/FGzWe7ZFHpLuuH
         VeUg==
X-Forwarded-Encrypted: i=1; AFNElJ+CMKfMYElLHuyyDHDCYoHC3c7OH3DJ9wRzq/Yhwbt7YcccuF1Og8und5DG8uVvNX4WcT43jwWzEW39IWKiHOkJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUVqNR3XoHKymbfBr9QM9DGeiq8xC9vH/0BgqUuGPTWxvD3Y3
	J/4P9vfcL68q6yqov7aV74T4ttcJWRDmMN3w2p6OkATqaq38VWDtkE+jPAzncK/bxOWP0L7i8LY
	YRXAoMAS9LA==
X-Received: from dlbph6.prod.google.com ([2002:a05:7022:3706:b0:133:5da7:fa13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:46:b0:136:8957:a66f
 with SMTP id a92af1059eb24-1368957ac01mr700448c88.25.1779489253644; Fri, 22
 May 2026 15:34:13 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:33 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-6-irogers@google.com>
Subject: [RFC PATCH v1 05/14] perf stat: Extend STD output linter to test
 advanced PMU checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+std_output.sh to run
the advanced hardware PMU and topology checks under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster

This ensures that standard console outputs are verified under advanced
topology-aware aggregation environments.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+std_output.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 8dee005a7281..e4e8e4238ae0 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -132,6 +132,11 @@ then
 	check_per_die "STD (New API)" "$perf_cmd"
 	check_per_socket "STD (New API)" "$perf_cmd"
 fi
+if [ $skip_test -ne 1 ]
+then
+	check_per_cache_instance "STD (New API)" "$perf_cmd"
+	check_per_cluster "STD (New API)" "$perf_cmd"
+fi
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

