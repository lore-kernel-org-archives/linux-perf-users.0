Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C0B30B509
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278158; cv=none; b=aa5xHGNcGRrH3tqu/NPPBRp03X1BEV7lJ3HE3G3Kc2RTQkNzIWSgANJz1HmCVSNF46RgMGPbN2VV1jCPBAwxUe50il7UelVkpqMq7fZ1SSjmG4Qym+ajMV47lT1vHvLJ6SAvEl5L4+R9BpM4if/G6o4WK8unVgWXo+2k/HOVbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278158; c=relaxed/simple;
	bh=6gaNNsM3QsGSL6Z/u0Bak3+noraJ0xcSTjKBLWCfW7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SojgeMTpkyBogdkFoPJPSqxNPtyGDZxnrabD8kAOQVqLzes1FZGDPjo0hUKZmVzM/v4oD2fE8q4NXI602QxBcVjgtcCrNCxkpKfFQGDlv/IKX4uooBEZmx/DFGxptYi3LeUuk2e2ZxrPp5ucd+FUuBs/lA2Sc2YQHKsyK960860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNWDb7rl; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNWDb7rl"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139b62317d0so2508457c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278156; x=1782882956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wJPelRIQw8f/Dg4s7jbpIWSg3DgRcwrqK7YBo20jNU=;
        b=iNWDb7rliTuV3noen0ZTTcHWQRYGwL3WHo0oW9ME7iGlVedHLABkFE3rFgtSTOSQ84
         G+q4UK6IPq75E4bhUDFhpeM913qxVWN5ajtO4DOfVy7IllW7VQa0IIimoIniQ82InsJl
         ZjShBkH5qfzfoH4XlLmYDKMaTsjjvfBwqgxwm75D3VpNf30lbot5tSD4A8S0o1BYACAe
         QjDzGLTeoszVRyaTX/GiHR7WV6wQscBHlnYgg+PRZJEy7kGZBeUDOdfg/wCESBx2XXOa
         A2fAkr/wSe3I5zksmwtHeQIncFsQNKZT/sUeAjQlPsK+J5dh4m9sWeIFNc025xid5Ta5
         xAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278156; x=1782882956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wJPelRIQw8f/Dg4s7jbpIWSg3DgRcwrqK7YBo20jNU=;
        b=Qki6xexxHc6HO/FuTrXbXVaG54u9/2Xrt69wt+bulMeexGMyjdjyfLP+HlRV2g3SMN
         zs/nNJcUIdTaoTN5f9hw4+cKOCmGvjBbo2PQs1Imn56R5rSqQqoso/TKBYZQqRfU2FgP
         Akk/VcYTgwv/TAFkAb/LyRtSRhtf6bcvXFwG6X6tbUS+HmkX+sdbmngkODMYkAr13XSy
         ZD6grzeQJYWL/x+CB4RjevcIumfNLgRwsSt+fiYb+SiyE+XktWWTstP0C4RtFZxxVxC+
         YrPnxY5ptqSfTDaGkl7ixOS1H+4CP7wzKH7YkCJllC2qMIFUjjHNgc6s94xRtl9nAqwP
         bmxQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MgXSG4A1zqKaPbrkJixsfqQWFNfPoEKUBb2bxuD5parhKTA0SKlTdEDCJsF9Xq++M9wcomwXkic571DbM5/oa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/RVuWvabKWk/C7bJMVW1PP4POcdEWNI6tifu7IgnUl72J4TZI
	8pubdrXM0GvLdrBeOtS+UFMd62V2TFodFqZnWniEMxUuVG0bCBCLIq2FUwHETfwMQZhhAhFDfw5
	huTkzHI/1mQ==
X-Received: from dlber4.prod.google.com ([2002:a05:7022:2644:b0:139:ae4d:e464])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2507:b0:139:b977:9bc6
 with SMTP id a92af1059eb24-139d0c81f85mr1561205c88.18.1782278156091; Tue, 23
 Jun 2026 22:15:56 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:24 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-8-irogers@google.com>
Subject: [PATCH v2 06/16] perf data: Fix directory file descriptor leak in perf_data__switch
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a file descriptor leak in perf_data__switch() when running in
directory mode. By substituting perf_data__close() for
perf_data_file__close(), any thread-local directory files are properly
closed during file rotation.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 040f9915e99e ("perf data: Add perf_data_file__switch() helper")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 33fd1b82019e..32d4d908ad38 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -472,8 +472,7 @@ int perf_data__switch(struct perf_data *data,
 		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
 
 	if (!at_exit) {
-		perf_data_file__close(&data->file);
-		data->open = false;
+		perf_data__close(data);
 		ret = perf_data__open(data);
 		if (ret < 0)
 			goto out;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

