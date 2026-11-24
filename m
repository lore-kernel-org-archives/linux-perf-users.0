Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795521926;
	b=psQRKjuVN7uu1j2WzWwulze8iXNbuqEmNEHYUUDKbcq/VbaNTVtyy+bf/k+pgiJ1ASzh
	 gQHZFAP1gWMLSyhRpkb3CWteA92Ud3aWh7tn0KdliSeFdjnymvetTWi7ZECIBVtNTp0wi
	 rhbTMtuVeOu1R+rX+5nmEkAhfr6YgNnt6X7geohQC72bj8VCkbMX9wTP1a7xgS2xSJER+
	 69qBIp1CJpDViWFjh86nSq8MC1HAf0JP5BiQmwF5HQ6U9CiE/GDj88mO8yeg5dbvDHWAW
	 QoGjAonmdFx6SB44MuKoIOWEEg7XR12VB3YkgapG9ecs4ipt+8z4op3DxgqkKT6kPJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tmJEK+xuhHTQNxm5L1PikJeV+V+rw5ssnZCLgMM/+K8=;
	b=G2x/RNKycwoZK8aXVE8M8So8L5JOaAVTg1wqhl8G32F2cS4HHDIr9d/5xopKDDrg7dPB
	 dcl1j0MM/S5f15htsENm2KQirFYKBH6YPxS0Rg0Xgr69aQLqxCqdUi77FY8ME3rikE6sT
	 dm4nbpnRyNq7PDhNft2MhYZDy1WgGjBJtVup8tqVI8jYAZfa9zrB2m93/DnZcWxactfUF
	 nAXwU99DutHmUHysdqfDKZmq4qXrbAJJBOOqdrq7q1xNWnHuap08OaohOxgRdFLP1n4bc
	 1mj0Wxa+zFWCWotblvb6KrrAcdvza+gaoHcDvoO0/+Hvglg2J9Yn7JzrrpO1DmcEuZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUQ4HSe5;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF703606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 12:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF703606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUQ4HSe5
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f0481b35c9so24668225ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 04:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795521925; x=1796126725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tmJEK+xuhHTQNxm5L1PikJeV+V+rw5ssnZCLgMM/+K8=;
        b=zUQ4HSe5MUJyfs+9sO8NZSZj5/CdRXoWKJ6Ws1Fltkdjr+s1XaF0Om10vBntvgT7/0
         dOZgqOxiZiv9wBo96j/jfyQWtWBxuqMSnbV6sxyqom4D5CDU6z0frFNOy8dze9HyGJDN
         9pvEKmF9qb7jIfd/fN2b4B4lY6tDa/UxRUzQ60dh7ShYADmSwLXr/bqXfeLW39/7j0Pq
         yohaxrQLCj+urzVwL2aTLUK1SWIJ7kqrw9TUqACllq0Urb8N1dYJaupGbKK+ferpimBr
         ZZjS67mN7E6uSLYwzW9qHClzjlwfM9YUB5Zm5G9vdCw27CepjygrIMXd8U9dAs1U4icq
         VWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795521925; x=1796126725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tmJEK+xuhHTQNxm5L1PikJeV+V+rw5ssnZCLgMM/+K8=;
        b=zgAPG1T4xl0FzW8lPs7UOw2Lo5A5KrmwFuUiXEMGuPy+k++h+Z3+yP54sX+sZTbFF/
         8LWuy4h/gSM1HGcUxaCfxVvOivHa9OqWP1f27763/GRxCmEMQl0OQA7ZpxQWuepnB+CB
         UzjXuAey0ZljCNeEAfIm5eWKY1sTqjc1XH2GmwwzJREyDq6CTGFsSbZwBdPZh24zKHKi
         aQBWRI/YtGoQyhQysnugTS8BunyGkIk7YxdvyTUNoYxGQ/+AG75DG6lKKXZ6JUEYn2Hh
         /OHZBASrvx6joKWpe1lPfHCuZs5GG9Y0kUSNapRzum2yi58ab0Kdr3TflFMUfu44E3Pz
         J2+w==
X-Forwarded-Encrypted: i=1; AL+hErHPooTLes0d6WtRkwYoQaPWiPBhGOrZbBiB0Fr9J/JsQZgJ7fyOL0wv86WOcSlOFBNI11Nod9nbs96LdxrQf4Io@vger.kernel.org
X-Gm-Message-State: APuU4Z9Boy2i8yZpaH/KnxJfuT40rCPrDDejH8xZF43yDAC7TVLmzIRs
	iezzwGs9BSi3kqclsxpr6qOhG+zNBvYF4YkQ23ydo6I7RyXHu3WQFHh3
X-Gm-Gg: AZFdTZcZZjPhY6MxJMQdzMh4FW3Hqjdd1VZPlo8Y4B9iOqIH4aT2PuRZh02EIM2qW1m
	7Ka7hfpQKpLo7gCHprdu2szXIfJ5CjXZyQvnpisoSJsYmM/npN3yum6WWerjM9aROQQEQfPF0pe
	MOexN8BU1luR3MVBXC03hTidZupB7R4l+e7Qn+0QSwVfTcgXHC5SnrSc0y/lPSO9eU9i0DWMzSf
	uJHBX1UwkNuCUnzWyceP2v0mpaDOiARwLyNkkXkb98gM5CggKpgG2dIfolI1xXiUFbkuajqq598
	XgdSSNdIF93Bf4DU2cBOph44dRhe/lnDMKpgrKvZx9s2QfR4qYyeQJgbqnfzfqfVyWdHmPXEZbQ
	Mi4qlVbhAj0TRE7KJS2NZ1EWfysY4OYyghLJS30emE6T51Cn0jgnWW0BTSncP58IFMhaJZSHXvm
	MjRe2GMtClkV7jmjUPK5HMarsjD7PcoOBfJjO1/j8KwQnp+baRW99VamnmFFQu/rkgHeHB6fduH
	/oazTZCJziL/gNNTxCn2uGMvPCbYAa4r46icDx5fbIRXJFcr7G9bzEE2mN9SIF1IKZO8KHlIyxP
	kTE6JV83FX1Qbbw2k+5XlvGwMlUchRzxAfGURXTWs81lvsHB+hTX6bc9aEkrr4rIsDaI/6d5lY1
	qHdIqL3oqPh4rDAzPSVqWO4a8mOs1x5NQtOES0FAzJRNvw2Tyvctv5LBJA57qIizPfA81fa3fy/
	FOP4nScQBdmk6Xiti2ftpDPimJhi6Fvt+BVwF4hX50+aWDrkJB8nWnpzTwaPyo0gduS5oZSIlqI
	a0uEzF5aGQkmxPhsjc3/HsQ+soTPVXDe6/3byLyjI/E3/455y8BzkYmRgx7XaDx
X-Received: by 2002:a17:903:1a43:b0:2ef:f46a:e221 with SMTP id d9443c01a7336-2f03f2719bfmr128352945ad.67.1795521924863;
        Tue, 24 Nov 2026 04:05:24 -0800 (PST)
Received: from localhost.localdomain (27-32-254-230.static.tpgi.com.au. [27.32.254.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f07d6d4bddsm39621705ad.62.2026.11.24.04.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:05:24 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] perf: Reject group leaders detached by CPU hot-unplug
Date: Tue, 24 Nov 2026 22:35:01 +1030
Message-Id: <20261124120503.334-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

Patch 1 is the v2, unchanged.

Patch 2 is the wakeup suggested by Aditya.

v2: https://lore.kernel.org/all/20261119014730.2074-1-danjwade95@gmail.com/
v1: https://lore.kernel.org/all/20261116081248.21059-1-danjwade95@gmail.com/

Daniel Wade (2):
  perf: Reject group leaders detached by CPU hot-unplug
  perf: Wake pollers when CPU hot-unplug detaches an event

 kernel/events/core.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
