Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280967;
	b=MpGE564IKTnJtQZ7GLU4JXUFLYQ6YSrTcsvrV1UIYycexDcoCuNXdu2ah0xPBWzLEsMM
	 Qz+TL/s5Yx3ymeH+at6KaeImmB51OEm9Ua+VebHI5DQOxZ1trJV9Wnt8hmJzcK/opIEV3
	 5olIgCam8zbpx5GQu3NjURk81aBR8tnPlT3j4yrSCpgmru6+OtZffvA8SZccMbvlk+Rmb
	 Q84UHYhyVKGhatkdbjB2fFGX3KFW3yQZwuzhVQYIGtnaERnhOJJXRizHsGHP3lA52svsv
	 pCw1pSL2Q+TZsugeIh50z46tdM3dlU//h6IymDUvyPemEvkT80AFnlESG0AB+neUi0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=stnzaxH8NkDuiOo85TJCNs0yAvKFW6/an24wa5kJvj8=;
	b=jxcCinLdsojpGc5+Lu1MQLUe1TzNict3N1HY5nehmpy3fG/6oFYr91bcLdAddDDzfI/g
	 rVD462W9KDNqAkdsezwxslDnYM+jwQK1f3PJgmj08MvKOcjY8ZLIi9wRKKF65o3hLdgeA
	 Be4ANBFdLsB229VlV1OsXHYp7L8eiwt7YXdY7OFfx/NWsk3bxQJGRYXMbqrjJ7EdP4w3o
	 AsXKN9RPEEHwssCv/dcy3wMTZ5u6B6bcFv98MA6hNA4rozhYKOHtfa5ankHP+Ncv9oAax
	 nZX7BDbQT3Vo6jVBJzlymlJWzh7nSHKUyX2huIpn5H7IRVbwptl8ZCzDrFXgThSdZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=clGMaWxd;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D05606A326
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 03:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=clGMaWxd
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso2078884c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 19:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280966; x=1794885766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=stnzaxH8NkDuiOo85TJCNs0yAvKFW6/an24wa5kJvj8=;
        b=clGMaWxd1xDbbN+gMw/ioN1VLgmuJekJgKgfL3QzKFjCdJrb1uXulezmJxeyhJhrbf
         lT5v5cI1hFkX1HUKQE/YI9jDCe3FZJriOm8BGTNbYrwiGx8zgZJyw9IYXPJptgmq5Oah
         f1u51+46gzKXGBUCD8UKQa8DFoxsopJAM7/lBf/19N6yeQ1x25oUV0KZkil4gcZmZaCd
         lEefzmOiaq2+07BtO9V3Q/kgQbfpLmAtJcYKHo8cunpCabtV99uzPtcrwI8ihDJH8tT0
         fJ8uO9XzlXrxY67CFk+Vn7jMi6zd5680f9DualvtChmxyvaxbxaNs8k4Bs8n+Y4Le6aB
         6W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280966; x=1794885766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=stnzaxH8NkDuiOo85TJCNs0yAvKFW6/an24wa5kJvj8=;
        b=MM62QYJj7pqrwnV24RMWyYH8QitAnjJmqByk6ObryzAEHYYer1kQSDGxy5eRlBsqTQ
         wwjcztSKKTGfKz89Ixb7USL1IwqnvMzmViCPDUkabepeUYICtX7j9kt/21fTqnJlZU+n
         9UTAOIJrF6EM5QuFYZoqbdMq5T4coCvU4eHSnif4WS5StDKqMPTvhB/czbO0fzI6vAdu
         EgC0YP6EGA/becsNMrOAhi1NQL6pv2lo8k4qhSNI32hHWEN2f8hbreKE9MIH9h2/vSf9
         ou+qr6MHuxxOt29aa6ONXUUPrdg40fnBd3uRzEjGU+2QDakPFdmIggVy+Q3DZuD+BJFB
         qeGQ==
X-Forwarded-Encrypted: i=1; AL+hErGWTqDwoL4wtXa3hCUTJWiIKaZTU/JjmGnKd9tRbd7jND40gdIdS028adPH8/JvWseLt9VuCbZsAGTZFdbHD88z@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZqSHXDk/tRzy0Ueto8NBmIYCjZkZstXDFh9VEhfSWg8nuPcDN
	q8ynTzjgGmer8dBefShJJnbhWAEe7+2VY7YDAgtZghG6nc1Xs2PkTEXX
X-Gm-Gg: AYBFou1juixTeiZIHdzAExyLFaHwRrdxfjzOiO/Uhp2PXwWkxAVJKS49b0f0rfkURZu
	pzQD1JMxyHufKub9R1G9tNAemeASpQQNRvY7hPbpFXuUwoMdtvxS4lBp65OOnX4kjGR9DGy+vGG
	R3yFQNglNyBDwvdcUWGqGf8rKaGo+QyOt+pAfOi5eocPVzJV3Cwd/83uX/JuzzqWFP5TpRz6FQH
	xOQb0JYSOsizN4ELae9TMm5h5eONudKu7PXMCzHZWfyYjcbLDomK/kH7zL/ODB8+5i9SLiQzkbY
	mgOL8i3zoWtt9t+HokVxhoB0PS8YT7iMv1dHyQ/pfWrTKPk1/Yvcuky4uGuiSM4ZF2fCUMQbVSq
	dchBvgoj1vuf7XrGQyQhBHSRKxaztB6TXmoEQ1lOMI1wGZi65IYVCCPX8G6EFAiZUVuv4rKbRjo
	da45oVkncl0nMJFz/9Qtc2H/ABrUYJblHym11Bi2tDeBSBeio3EtIav+BIHnf7soxEf4vW2CB2u
	QWIe2LqvXBOtVQOFcEBEEc+BWaukHWtjkoKE8tvWHPSWWor4fjLF3RtKbAtfevPRseVnVDgJj9H
	MZHsmO3UgrGd0LvNpOagDDip4LkNK/2wIgMPh2Wu5X8LUWhkSO0Sqh64PirN0DJlqx+96KKNPoM
	ZgICLRqL3
X-Received: by 2002:a05:7022:290:b0:195:c6c2:c6b with SMTP id a92af1059eb24-1b3b6183256mr1937438c88.35.1794280965622;
        Mon, 09 Nov 2026 19:22:45 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890e04sm3284470c88.2.2026.11.09.19.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:22:45 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Chun-Tse Shao <ctshao@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] perf stat: Include PMU name and split uncore events per PMU in metric-only JSON output
Date: Tue, 10 Nov 2026 11:22:38 +0800
Message-ID: <20261110032240.3080302-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030192537.3079368-1-ctshao@google.com>
References: <20261030192537.3079368-1-ctshao@google.com>
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

On Fri, 30 Oct 2026 12:25:37 -0700, Chun-Tse Shao wrote:
> When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> JSON output mode (`-j`), [...]

Tested on AMD Zen 3 on top of perf-tools-next 13a8d580433a.  With
'-M l3_cache,data_fabric,iotlb -a -A --metric-only -j' the metrics are
now on separate lines labeled amd_l3, amd_df and amd_iommu_0.  STD, CSV
and aggregated JSON output are unchanged, and the stat linters pass.

Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Two changes the changelog doesn't mention:

 - Without -M, 'perf stat -a -A --metric-only -j' now prints two lines
   per CPU; the first is labeled "pmu" : "software".

 - Plain 'perf stat -a -A -j' gets the "pmu" key too.

Are those intended?

(Tested with the help of an AI assistant; I checked the results.)
