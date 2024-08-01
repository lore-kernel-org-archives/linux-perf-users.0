Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FB14C5B8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476353; cv=none; b=peJTcjYJAzboFHCahUAlvOu5++Hjh1PtRzs7nCq2Odtxa2Y/K5fvWjQ1/4hySTnduM+EpY39GaAjfQsFtoUzGSgKqaNZq6ffabZw07tSabuzUF/Qbo1Fn9yuqTdoPm0OozXqqPh2or6G4Nfg2KW8gvK3CFrbqDV5hmBqqjhgoTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476353; c=relaxed/simple;
	bh=RTyceth+mxn6QaOnqtKbXzAURGPUmxA3nMOQCHvtCeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOQ1Be6XxaIvsGzlHyJPjqL2y2lRCjzR8SgHdW0NWfU7H3NZt7BQ241Fv80y4YL7qiF4NgP+fZ2Xq6D3VU2NgI2Z75MuCgwVxC6MIt37xYvQ6hO0vRwGdNd8GxuzkGtU3T300ex9KMrYr9OiELJMOsA0mCivTlexxnAVINOtykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrp3iGEY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrp3iGEY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4aff530dso351995ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 18:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722476351; x=1723081151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTyceth+mxn6QaOnqtKbXzAURGPUmxA3nMOQCHvtCeM=;
        b=rrp3iGEY2OkZQ6tBnx5i0fSID5atwQqlQG2v4Vs4AZ4jIs0IgDQKRJOC3n65wrCTsn
         INUhyxmpzRcp8pjWRZnHg6W6R+mLOxpF1KVmOaKXCq2JO+EeLtsFMiOS4mqFksYEgd64
         lso/eL1tGCerHH8E5iJDR23IvTI8iyfGSSLkVtm+L7QPidboKalrPvXH2/1OodboBpmv
         dQwZBdMW33M6nO+S+8r3QW536f0TC44PqLcH8A75rQkJ+wNwPljr3Ua1jLu66LX2Ins+
         glJv7ob8MMbpfCbR5evoNI6zgRFP0xTpfrhkiId76hM0eiNsIqIp1zcwSVC+cvxfQwfc
         0gIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722476351; x=1723081151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTyceth+mxn6QaOnqtKbXzAURGPUmxA3nMOQCHvtCeM=;
        b=RYbFPYO+DztT4af7ZzdOj+LcjkDyiU7GS1O2QvQcUHacjcVrVVH0bEIJxgKQ2xA0jw
         684EFXRaAbyrX5I116ZCqVvogkLujsjVPh5Emtoq4BU5xewrAlKx9aZKBbz9cPoXsRrP
         rV+S3PSVC0m1gEHEcg6Er9BK/+dN7TUvRGG71JVUyEfk6NSv2WqEndKYjCAvdvXYVl/Q
         mgRn6JbnNP0bM/iq/WM8TfVs2zgfj3JJFUG4yVmO1YVGur6rfAonAueIty3CYder0Tq8
         TE33oUAQQ/VNsgEHSrBFV7xkFWeUdLZ7VYLFWEkpuIyeYMcY63ytayAk0PDPXd2/mr3F
         19Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWlGQ2TCC8Y45kY3ZlqIYgkcH/ZVbBXTB/9lw7aOaZrOCkd+DvgtK2PZOwJyRE92LRLHnzBarBXykoBKjSBiPrCm2Jx9Odi3l0CYORprZt0JA==
X-Gm-Message-State: AOJu0YxtaSPQJ93nZhmHwMrp7tTF9+eSQXv7G1AdIMZPLQLggzwhFVM+
	NCBdLwdNkE1CJ5H+D9/9YKAhMKXHyR7/h0n+K0jClbkVJx0oOxdqN6C9upWxYiR4IVOGyoWo2jx
	OS8h9mXTyUUreLolayel0EvSNlG3OXpxXUIcw388vm1d1cZL1qQCVroc=
X-Google-Smtp-Source: AGHT+IGo/WzGYjFSbdEC6o/Rbz/PYKIGDhEU8lqtb89SNQ0lBJH4ydpnk1HHq9OChue22fi2YkhsGWz5s9ZF8wMPJus=
X-Received: by 2002:a17:903:32c1:b0:1fa:2c8c:7e8 with SMTP id
 d9443c01a7336-1ff4ec7654amr810165ad.4.1722476350843; Wed, 31 Jul 2024
 18:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721202113.380750-1-leo.yan@arm.com> <20240721202113.380750-5-leo.yan@arm.com>
 <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com> <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
 <1cb6fdfc-0405-4bfb-acd4-ed3b24744c8b@intel.com> <951fc660-58a2-4b8a-a763-5a1e4d807c75@arm.com>
In-Reply-To: <951fc660-58a2-4b8a-a763-5a1e4d807c75@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 18:38:59 -0700
Message-ID: <CAP-5=fWfU40-QO_TuUMd2KQprvxPOH2pnpKCUxJf1yoUsw-9mQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish reading
To: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Just a heads up. Arnaldo added this to tmp.perf-tools-next and it
caused the intel-pt tests to start failing:
```
$ perf test 118 -v
118: Miscellaneous Intel PT testing:
--- start ---
test child forked, pid 148999
--- Test system-wide sideband ---
Checking for CPU-wide recording on CPU 0
OK
Checking for CPU-wide recording on CPU 1
OK
Linux
Failed to enable event (idx=0): -22
Failed to record MMAP events on CPU 1 when tracing CPU 0
...
```
It's likely Adrian's comments already address this but you may also
want to double check this test is passing with v2.

Thanks,
Ian
