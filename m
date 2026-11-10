Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280959;
	b=RrWR8x+aN9z69vx4ml08gLuQfycKDp6G/p2MGXL7VAgBw+p0UXy9f193d1479eMNl27x
	 kW7tOs4xkmW3a+ZY4Vq/OCdOymZmNW5ijq6iSmVqEGQZ9mrARiuTAWelKAlz/PSEduNzb
	 7IxegXXs4l7rSYJrknj4ye/Y5Y21SLkro+soc9BWiFdYW7uMV8squDZSUSpyo/gTMpHm5
	 KrguXFK3h0OQgXVUFO79aIbVLfLliKrq64Ex+eNSCnPUzCDv9KR6fwxWa+hDkSJjw58C5
	 PSbYtKss9BcqZYqkCKa3d+/DFogOeI1KZx3Xn40Xu6cP5urPevGY3/g5cbecTRtcR5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0n3oxuSYM0wY0dNcqd4sVlOYEFaqxsxikNeoWib2fRE=;
	b=qzKKNGAa22BuRBG70BPmNFaPQ/8oRNz92Srueb76hkxxCwmWVj3o97El97kJN1BGrDQ+
	 DZjXz+l4ji72GlQBuHM43DFBthjL3bH0bS81F9Ya/4FL5iNg1IxRnBlKj164YAWKdvd3L
	 TtpxPcH/Fr/lWIOIMZsiz6FSP7zTdSa1QOElQjeiuooOoOZ/0pkJK4q4xoEYWIi/ggoJp
	 tGegdFOUk1EvBl0aF/QJSSkNzoNcjXTfdIcmXBhdrfpfYk8pzlL1kVXaRjmPgLjGG9n4K
	 W0DSimBpYyoBHcWgPDqOdxv9mirkYCFMmSUvQTyaUV+t6Z3cdWvFMC4dYVUnPhRr0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAUVWEMJ;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB930606A33E
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 03:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB930606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAUVWEMJ
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so1222714c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 19:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280958; x=1794885758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0n3oxuSYM0wY0dNcqd4sVlOYEFaqxsxikNeoWib2fRE=;
        b=xAUVWEMJIPDmeFKsmhIV1Zj5U+r9lthtoqzb4uiUSi+lhY/v9VM4NRGRtUv0iZKNib
         48gnIUfYYOqQk+RHI+f3V/r8RoOroRbbLIzkSN1kIlMijRinYXiEMIl4fm6fVIqdGdjP
         24zwrkKvTtOLvn63wV/XoF3rWgS3UZkyQ3JPYP0IvcNnB57+DP4EruFYNfzF6ZaSaToL
         2vuPPiSUPxaSL4/oEXyRwrVWxve9OWSM0aC6pwIaI5dyiJTj/PZUvtPzUPK5int/2xqe
         z85UBeAGqDSfdIgmFkJAhdU3OstphZ8Mcy78jvm46gnohop5j00V8PL9Vj6J+W19OQRz
         Y7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280958; x=1794885758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0n3oxuSYM0wY0dNcqd4sVlOYEFaqxsxikNeoWib2fRE=;
        b=0omFfKhQmn5DLMflbeeZaAuWWhDK2dPWZk+eIx1U8RSwfs3tzUd25QprQgKlIxdCyR
         0sVYPnCGDxyAxKxeLX3RlptBrD0AP27zon2cbnna1YW6mb8PGgNxPo4ZB8OhM879i+29
         ZN0nqKvVhY32I6qch0xufrlywi620AGrosWSl/J5r6eo9ItrhaYbkiKeAMhWJt3FmvI9
         yPX5H64YSJGlbwdAZ+eFzk9khlg6RuQbpxfAVsmzB9zeeIDNhoeET9dSF7zi2pTiSwWS
         AP6GPdm5jhmXUY0mRT8Wn1tvzzwNs5XomnVHZ2WUOgAD75A4U4jh4Oo7Y1Tzy0bUN3Wv
         5Cww==
X-Forwarded-Encrypted: i=1; AL+hErGb+0L5gVY7XVO3jXDlQzmM5TOlMNhhAB6lR0v0GRViy2TOpENie2MVmjIqerftSWm8pXIUvcKsur7vrGil/QlG@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hts+h05wKzdhKNnsGIwM+b2wJUEBHLofUSZRu1IhTfDrIqFEV
	uTcS5jjTypfVl/ddxYsG3dFqbIfBjyoCBAv88b0uMHtnkT0yjOp0urII
X-Gm-Gg: AYBFou2KPBplkn/E8gkcu4L6XKNYuCrGYQJp7aaQLNMl++WzojmXKk1/UHZGzr/evZz
	9f5sM6INmdjjjo6FrnfCX9pT1fFYpWabP9THrgHNkW41nb76ZXSiBeuyzelz8of67GVdoTwqS5O
	asjZfLxlDJnIEsr3erWzIP7DluQf4VMgKjNsabRB9u9i9UKb+YaPGaA9Pn3j59IOtOjqcY4xNtx
	ey62g8A/PSpDpEBhNlQBigUEwfYB7e27++F2hGxwDuMrZa+vwVm6qf0jT6wVF6yB8KH0Mkd9cfV
	gTjufHdXOumqgkacUcE1RNe4i8U8JNSzLp9C/5lp3LTGl3t1lsOfesEk87RHjCuIIdX6qvdMG0G
	bW40ExS99LnxWXGOs8J0WuAj3OCSH+RrBMgedOYGIc4eZiOQA37LBmZpHaWQ+e9zw+x9i+F2e2K
	k4uCMsCgicteSj1kXfiWwNEthIuShAF2TDKsitudMooe8lEL9QcAUv0zYpcepYn4FJS84+RxPuH
	H2bO+B8tIk2s02JDhkw3OyawFgPBA/ofXFPp6QA+CeUGpWVL3ObJGr/nXQ80g8hkTeHF6FZVgs/
	RYvzdUATUvl0rpD3TvwPQD7/A8ZP9QgB0K4TMDgB8r96Gu5dlPprUJbCtU34M6TDNyOB1iZt2SV
	yaMenX9oF
X-Received: by 2002:a05:701b:2302:b0:1b3:a9c0:6a3e with SMTP id a92af1059eb24-1b3b5fff49bmr1860238c88.29.1794280957671;
        Mon, 09 Nov 2026 19:22:37 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm2897362c88.15.2026.11.09.19.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:22:37 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Jacob Lefkowitz <jlefkowi@akamai.com>
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ben Chaney <bchaney@akamai.com>,
	Matt Pelland <mpelland@akamai.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf jevents: Add IOMMU PTW & device entry metrics
Date: Tue, 10 Nov 2026 11:22:30 +0800
Message-ID: <20261110032232.3080268-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
References: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
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

On Mon, 02 Nov 2026 21:14:15 +0000, Jacob Lefkowitz wrote:
> Adds AMD specific metrics for the IOMMU with respect to page table
> walks and device table entires.

Tested on Zen 3 (Ryzen 7 PRO 5850U) on top of perf-tools-next
13a8d580433a.  Both groups show up and count, perf test 130 and 131
pass, and under O_DIRECT reads from NVMe the values match the raw
amd_iommu_0 counts.

Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Two values look odd on this machine:

 - lpm_iommu_ptw_nested_read_ratio is 100% with no guest running:
   page_tbl_read_nst equals page_tbl_read_tot.

 - lpm_iommu_ptw_reads_per_tlb_miss is about 0.2: 142588 page table
   reads against 440805 pte and 192018 pde misses.

Ravi, are these expected on Zen 3?

(Tested with the help of an AI assistant; I checked the results.)
