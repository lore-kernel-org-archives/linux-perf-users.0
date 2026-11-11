Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423232;
	b=b7GKdXFCWpxI+m0Kpua8y7475RUatmwaK8OX+AIFct6wpYR6ixz45mDxknsAnk1GQ8lW
	 dsh4hEnYJL5/1PlPbOJ13vI9kgst7OcpeHVLirl79a5w7G6PcvHSaLV9wtERBRE/+UM1/
	 pYCS/S8UbLIFP3iJnA/NfidUQJ4gb2Jmlrxyj7OVaVFsserZgJrFODH7ms9kahMghzCM1
	 27zZ9K3yePBlqHu40Ibk5RvOUhAiUhT7iGOC1xyXZpikSm32VTb04ITBd1/AHaJuzBQKc
	 cjqnKP10mrfbvsoK2EmowhDGJpw8vOMuzH2hqs8yrMWOkrnIzt5WcfM06EFspdAlWnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/4cIr29+Hs9PI3pucOGutK0nS3SkmtCaGaKmmkeWSq0=;
	b=Ta+dlRK0W0HVBEcSmelEMdKaRBBfvsjGW0DCvn70L7RQDpK+ZQXWoRzk+aaMEc4oaz3a
	 pCpIT/iGgVCiTSaSAGbb1EnE+f8h1tRtaQI8zQpyu6eHmztGm2R3ehdV3KKx0PJdLgmc2
	 q1JPKzmCl0Ntige0eqTJGGw+32qGL+rhLlnAnhl0dD5g3atoEJSb/gm6z3m6eSARgJTjM
	 dklo0hQZmt2Sl7IOdxkk4sG4EKGaQW6QEQZvvp4/Wkc/zLw8+V4L5hoFIAgUUQ3f6vHpG
	 5b+MUJF4lc6cqjfrT0/nOXNc6TfrVXZgSnlyyPcbAHbAc8JQB7ySNaXIkP9M0hKm9kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2oiFpvV;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86624606A327
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 18:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86624606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B2oiFpvV
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cddac941ed1so224921a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 10:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423232; x=1795028032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4cIr29+Hs9PI3pucOGutK0nS3SkmtCaGaKmmkeWSq0=;
        b=B2oiFpvVAHCSvVkAoCwh7p1b4GljYuVmSE9qalBNHF7fqaqMLdw7J+eMm8RyEaTKr9
         4ZRywasMpgkfbdFSVbWeYIzuD/fxfIA2zPA0BW8RVFyj+qV5Ay/hwL5hamI9yLO22oVF
         jr8UcubCg4zAYwX97+geS0L29ZL+YGdEcqSMp9zN9GGbs/xaRkLsplzvuOwLVZo1GdJs
         BDTXon7HSQOOHOmLfnumZXvS++ShdeyHEURCh9n+B5UirORqy7dlsilS0Omti/N/YDPW
         UKYZY7AICnwfd6e4BLAZ/8oiZ7ALgSZTIAXqTuKpABqHTYEc+0WEHd41/VLawS+y/Dvk
         tBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423232; x=1795028032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/4cIr29+Hs9PI3pucOGutK0nS3SkmtCaGaKmmkeWSq0=;
        b=Q0534S89vZfC1s3W8fEXS3c45Mw+ez4uZ7bMxsJp3og/JRIEbv3L4Ww8HOQp800eg2
         vW5lfjJHWYsb1vBu5sU8q7Vw4d/Ar0g6aJxYZPitzgtbgFDY0cwdpZxbuYxzBULOzbyA
         c7ltRRnPMqXq+KrZ38vlApZDS+2ijp69UweL8HFuEexD9fyKr9QfEYUpWRXTKYTMEJi0
         pU7pFKc3sWgoaLLfHlLD5w6sfly9sjpSt+shAsm9cEVh+DxLLm32aCOVFHiE046yWn+I
         Wop8Mn3PCkZw9bf/hwpWygdA4LaaBArkxNEYfadAfi+Ksp70Ph/19zxP0zgQdFvTON7F
         B+WA==
X-Forwarded-Encrypted: i=1; AL+hErGm/qrwxTvxrbbzGe1uJmePAfI65te1rgKcSPENRdaRog2ggwtVaEfQ3EoMGTNpPXjS1JiCt8Rc8979SVbJyzMW@vger.kernel.org
X-Gm-Message-State: APuU4Z8IMZdhR261JGFGPFMSQuIcMWB27W7+OBEZi5rjPF/EieTua4Aq
	IjzvKS+TsvrHOmOLGMgvbmwJBRblpuKa9MOlnvC3vgNI0XcpEwHwOru99BThmZpq
X-Gm-Gg: AYBFou1wQ0OYywdSXNQZHmX1/9rIo5ZvNdaEj4TGIpsHx3RIW3nzyKTKQL0MtBF8izy
	idU6Khfznz/eAvu8KROnxc1W7TwqH62MW6y39K2jI5f9nmJ/A3J8WzEKARQ4xvYEPOY/pQ/AEPh
	kxz0CRtb3DMWwr+jtSNfv12EnCHBejI3ajpcdfkF46MmjPDx0sUvV9JbI8H21nKpGJ5/yVCd4j2
	GIoQM/D6dcKk6oATIHHpUX0gqI7MI7+NiEpTg4icKVIXXCwTAu7hNDX+yjL2saKbt/PmVjEKbtr
	lFGsMvqVrYGlUAazsT/tHI9TBlCGwVvpqcWFLeVPq8Fq47Hrx5EAZPA7VFJ+F2FhABEDpFdHAv4
	iZrmNwLnCmkTSnEXD+4pqnG1/b2ATDSAISuHIaaKmtYSWCcgwmFNryUX9Rzk44Jm2MsZmcPSmcd
	5WoYUF6178q24ngMnFV41F6aW0jslkxcTCLn2m/pmJ9mde/aXmXgSaURLG8YxA0T6Yaf609GGVd
	xY/uJSRrlrqglyleTfj+pQoRMJhDWoB0JjZbY/pl2G8yv0GpytMmvhrZ88qHNUwxqUZtnvZEBjm
	kaqxZAbrOnxN3yBsLzIMbFPtMUTFaZw0bwk8Smx4D/muITAVnKe1+0eEDQiOhPA0Fly9eDL/HXp
	u6fZ+1bS94LJSeSZD/BYD41+ZkEEhQg==
X-Received: by 2002:a17:90b:5787:b0:3ab:c370:3684 with SMTP id 98e67ed59e1d1-3b182ee13ccmr2619693a91.30.1794423231792;
        Wed, 11 Nov 2026 10:53:51 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce55c1sm480194a91.3.2026.11.11.10.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:53:51 -0800 (PST)
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
Subject: Re: [PATCH v8] perf stat: Include PMU name and split uncore events per PMU in metric-only JSON output
Date: Thu, 12 Nov 2026 02:53:43 +0800
Message-ID: <20261111185345.3538734-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111183209.1892421-1-ctshao@google.com>
References: <20261111183209.1892421-1-ctshao@google.com>
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

On Wed, 11 Nov 2026 10:32:09 -0800, Chun-Tse Shao wrote:
>   - Gate "pmu" output in print_aggr_id_json() on metric-only mode and
>     skip software PMUs via perf_pmu__is_software(), [...]

Thanks, tested again on AMD Zen 3; both issues I mentioned are fixed.

Tested-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
