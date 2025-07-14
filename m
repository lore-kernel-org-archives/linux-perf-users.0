Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5EC212FB6
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521986; cv=none; b=QKnZ/bSQuX7gAgdvsk5gPMmpfyFb50qNC3EO18owUAjAGHIJG+rLEzm8laqQDcnoPqZ1UaPUxvFJPkiw4Hst3p4HqrzaJ3LnHAKjqK9sQni1owk12K6zZF1GGCBojXWmV7YJ5g3BXfmsUP0Z4nAVrjjW6EU8pN2Zw7C6/R7mjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521986; c=relaxed/simple;
	bh=5cSCYdKyaKnlsB59d7LA/sqcozRwuYbnW6S02DziChQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P9k1Jc6sulWZibZQPlOyH+koekLd0fr1M46PWrxeyAER2YrKgD0To1TqYu9FtnR+seoW0WPeowQ2Ji/ewMoSazM3xzJMnRJVf0RvYNfgWknS8YxD3ZjxMDUtzHvl5JAG44KTnj7yS4Ph4Az+YKeN5kzr3pr4WIMU6eEnqbMBY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+lEts+O; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+lEts+O"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61593d51267so68993eaf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 12:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752521983; x=1753126783; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=urOya2QD0PAv3aRyUi92qVBccHFN0GyUQM4mpsavCC0=;
        b=F+lEts+OFVJIPuwVRnJK5F1pfmdT8s0b33WyPl3yTSpNzYc94+Ra3pdGqSBX9oXkZj
         zc5FeOr9OPpCrRH3OUAE2AHItRNZXv0JzsCwrS4IQlZexQ/8ObfrLmgTilXyv757B5rS
         sqTbM4JjI/euxM6GVNOWtBwz4PURIWU2GnNKOmguIxcWb2WuED7OQjtuH7NqUTcKCrcL
         56GOombgsGoU6TcZCI8HQpOlxRl1dEo3smb1sYZGU5ks/yd7qjJOcwAinl9CsqCsUncx
         V5T4qgOOy2+0ZK5j+7fhFq23EbhI9FM6PgC2MHLNaBRI5iN7mCjmUfEL5q7DQXkvT2D6
         vpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521983; x=1753126783;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=urOya2QD0PAv3aRyUi92qVBccHFN0GyUQM4mpsavCC0=;
        b=rqS6GEf60kyOWyWYJe1Mtz7+wQF5g5HG3VYPGHO4mztlL3OHhZT809BWhABacgfVLR
         XwaN8E7gdA9kcIgVbv7X4uUvGPMMKDVoTbF/qeY3XFL5Nnn93ez9sBDCcZE+2cZ4Boxy
         UfaasyfHLGw2URi9dCSjP7cUn7pjnNDT3MVhlzK79kE4UmotKhnHL0rnAqYB/Dyh7ze8
         lgvjeFsv9BLV4FZ7gPKAKULDkO70G6km66sCaDabMRwO3c8l/Q2duObzcC735pK23J5M
         /iVAH5DKed+zMY6c3/UNFtzwh+Ak+HCjHSozpA7DSzbvd9ozRuDKOyw02bQxCwOXs+Oi
         rkZA==
X-Forwarded-Encrypted: i=1; AJvYcCXyEdg1wR1V9JnFqGi2Z37ByL/02FIBpV5SEADUP/iO88D+d9KQTbiuNIADKsdBdxvVbzdJF4+2AUnfQSgx22U9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/oR17GuLw+FgrNuhp8XCPKgkMeqweafl+9IpkIs9FxW0AUh5
	5HAmcNgwWE9ZyPGn0GEh9nh9TQ+wPcuoxML/0uN0n5E6pAeCoML2X7O+TKryC9eO51o=
X-Gm-Gg: ASbGncspMcEq0p3xAvOirPXdWmnmCMDfJHG6vJSAlr7RNC4Mkp/W1qu7TcmHCvowdqu
	YTBS5qIxopnI5lIlgoHB+vXlYbWEXU0PUcQlOo8TMukwKMfCYY/vQXL34xg6x7bErTP3nmdVdgw
	5PGjXL3URntLBuX4bVOF50rg9lsFmpVIxwD1t0q80XS8SfAdsv1OxBkEwW0PaKrqMJmV5q173PH
	4nh0yZswV7nRl9VPJI+IY2eJbg0I/wr0hmuiIBnrt8UN5df4vj4xP71yKNYZoeW5gxQR0U0njmt
	WAwVLhT2qIMQq4/CCLKfnkJq00XRO1itWh5TcE47o5QFyXcmmeIFkuB0F+WjWYyg1EP3uU6GMq9
	pT33gv6XIYIuVc1dtaIFcJ7BF7u3Xdg==
X-Google-Smtp-Source: AGHT+IG9YCfy/a8BjNGBo1GzQjJuR8GmP8UR9cv+uwP5yDJexmfxPdWGAOu8EtDFH9IyIV9EN6mZeg==
X-Received: by 2002:a05:6870:c03:b0:296:bbc8:4a82 with SMTP id 586e51a60fabf-2ff2706c894mr10579426fac.27.1752521982792;
        Mon, 14 Jul 2025 12:39:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12b62e8sm1674368a34.60.2025.07.14.12.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:39:42 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:39:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
	Le Goffic <legoffic.clement@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
Subject: Re: [PATCH v2 09/16] perf: stm32: introduce DDRPERFM driver
Message-ID: <1fd92742-0958-4f64-8e50-4d0595fe74eb@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711-ddrperfm-upstream-v2-9-cdece720348f@foss.st.com>

Hi Clément,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-Le-Goffic/bus-firewall-move-stm32_firewall-header-file-in-include-folder/20250712-030518
base:   d7b8f8e20813f0179d8ef519541a3527e7661d3a
patch link:    https://lore.kernel.org/r/20250711-ddrperfm-upstream-v2-9-cdece720348f%40foss.st.com
patch subject: [PATCH v2 09/16] perf: stm32: introduce DDRPERFM driver
config: sh-randconfig-r071-20250712 (https://download.01.org/0day-ci/archive/20250712/202507122125.eve8lg60-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.4.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507122125.eve8lg60-lkp@intel.com/

smatch warnings:
drivers/perf/stm32_ddr_pmu.c:380 stm32_ddr_pmu_get_counter() warn: variable dereferenced before check 'pmu' (see line 376)
drivers/perf/stm32_ddr_pmu.c:380 stm32_ddr_pmu_get_counter() warn: variable dereferenced before check 'event' (see line 377)

vim +/pmu +380 drivers/perf/stm32_ddr_pmu.c

73af3c4ba702d7 Clément Le Goffic 2025-07-11  374  static int stm32_ddr_pmu_get_counter(struct stm32_ddr_pmu *pmu, struct perf_event *event)
73af3c4ba702d7 Clément Le Goffic 2025-07-11  375  {
73af3c4ba702d7 Clément Le Goffic 2025-07-11 @376  	u32 time_cnt_idx = pmu->cfg->time_cnt_idx;
                                                                           ^^^^^^^^

73af3c4ba702d7 Clément Le Goffic 2025-07-11 @377  	u32 config = event->attr.config;
                                                                     ^^^^^^^

73af3c4ba702d7 Clément Le Goffic 2025-07-11  378  	struct stm32_ddr_cnt *cnt;
73af3c4ba702d7 Clément Le Goffic 2025-07-11  379  
73af3c4ba702d7 Clément Le Goffic 2025-07-11 @380  	if (!pmu || !event)
                                                            ^^^^^^^^^^^^^^
Checks are too late.  The variables have already been dereferenced.

73af3c4ba702d7 Clément Le Goffic 2025-07-11  381  		return -EINVAL;
73af3c4ba702d7 Clément Le Goffic 2025-07-11  382  
73af3c4ba702d7 Clément Le Goffic 2025-07-11  383  	pmu->selected_set = GROUP_VALUE(config);
73af3c4ba702d7 Clément Le Goffic 2025-07-11  384  
73af3c4ba702d7 Clément Le Goffic 2025-07-11  385  	if (config == TIME_CNT) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

