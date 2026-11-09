Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250046;
	b=xwrQy5PlABQAsIAnZU9G3hGYbvVcW0ccNmi5g4YWt2stw3ymVaB7MCOsL/4fU0aRbTUp
	 rCGTBW1EH4lckmFMqLhi3Lm2QNtQWbBOg3JlcixZf3wIBnmEv7p9PzNpreZOELe9e+myW
	 KMUPR+65b1vxOR+h+md7tnB/qHJ/oSq7U7MfxNtGqHKI5zN6jE7kKz3bIWyh5RFggr7o6
	 vN+ZrCbNvQQ6d58aMR96gjoYQODwcV4VnRUgri8Jjw6hwbZo2GDHmzFspqsd6moOfyrCw
	 MEVhAXSlx26RCb86L2OrF9BgIdj3MCvij6aWzOjKuGAOqsjGYXV6nuc8HfmhBV4HSSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bp17VnBvBSFn3pUqDNW8uNFJO4ozps2bt47BhpkIeVs=;
	b=cNVd/uLeC+jSghph1s35qoXohDEDkcIdACZaMdckkX4CWB0MPfdnGh5Jd6sladrsxSph
	 cmdkvcatX4VvrucracmMGA6qPS9TwgRPkNYckco58J6p8md0xj8NwpC/JKOnP/of0mkdM
	 bmpqNbut118xn4S4Cq7MmCW+tnNhfsAxJv1k1ByH5X30xh3JCFuGDJgsAH7rGqH8XE8kV
	 G+Gu3AebuCkzjiyp59drAzxhesWsUc0Yodpg8QwbApbedF4VmMlPUroS4JH6ei13x91/p
	 XyeHRt7VVvFrSdtugrFCwNFl2kqIL17Q+6GNvzbyR1JG3885srjUmgK/M1SuVfNt8Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FsA0jb13;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC8606A332
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 18:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CC8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FsA0jb13
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1594114eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 10:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794250045; x=1794854845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bp17VnBvBSFn3pUqDNW8uNFJO4ozps2bt47BhpkIeVs=;
        b=FsA0jb13/AzjPiZ699QxFqAMRbUMEf/wzXbLqCsmKhN8hN3rnlnQFpNdwVSjN5IGHu
         3T1ipT/IKpkXo3lgaZIKbVksiNcd4CnV+O3y10/PCuw4BoaMBzHoAgotp29eiDZZ64au
         Q5RDV9qA3Wz/oCTNwkhVKfygePcOtmS8V3MdYqIz0lY60qhSxkGIz/J+MAixNFwdJrNI
         jkq0NzDDoAMAi2+uDLuF6OItGgs5jPTF3rMi392NnPhiPPMXTKVXCw0awzHaFf4b85bl
         BwzcOxGA6jm5YttMPHCXiU7ksJ0PY12OLEgv5LLyOIWdphdXokZovjUetHf6UFLMR/fr
         518g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250045; x=1794854845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bp17VnBvBSFn3pUqDNW8uNFJO4ozps2bt47BhpkIeVs=;
        b=jlIf/gColbh5tfGu54mY/DIdzFeqFqbzzz0aKnnguru7MDCYMyuRQuFzWIlv1thL6q
         XOVnkdKvDqilBHyinVzjbDkNW5rTRV1v8U2W2z/0VeY0RWu1HJ1Xo9nVZF7Kb24iXKR9
         vsQGhuiqn/qrrrGmXA2bhRmiplQg863G4wYicMjTEexW9zYuMKGFN/eVqmccsjJ6elQf
         BwuNbKqgi3T+qOzrl8ndwtjk6t5aNVU+cAlF0RgCF6Gl1tqe0SM3p1mY+IEyeuxtGF07
         QeGRdyReoEBAOHjMrOs7EEJbUXdjEd0DhJzGkCX61rk42kO0DHQv1DNxlG++gGCH4pNE
         mGyQ==
X-Gm-Message-State: APuU4Z+8LIN9lvpzkex+oGee7Vr6melHbXq3TLVeL5vPT+fYxs9UBPvK
	sCKlqX9C6IQnNGUIGQitwrAnwlTDy4kp00HMQMJiHHK0DHEM1oeUWZI2
X-Gm-Gg: AYBFou17xexvpHBbw4b5Ovg24u2KiLCzuNSBEMvmBwZRq+SHJOBBx+IUjpghCtDMhU2
	RZ+MfJnwndIfkD9qFjLXrwD8aa9OWifJZVamVWDVEwTUBnD6v4XJreg0D+4O+IOLuEmTRJMSwMV
	1FCX6j3J7DMnWsmFYf+bum8aDA0P4aMzKQ8ZlSmPi3uegWCxpqPiwUtBi/AnueKotc/9eTDsWsl
	ngp+P/1Qkzk4F304iQo2RRsacuLzLNtJOuqCzrPjM262iedrEoLtrY0pbcFHHI2T/UduFBJm70n
	sujJam4RpITLDzdJv1RWYXNC2yCUzAHbVC3VkhTqn5XiJOBi1X12yg6tfxu+KQ/BPvpUiRz110j
	8iYxN7ck6Lho2hmB43d3FWdlJXztdKtGxhRia+UKXvPzh4cBbPAlFZ3De2IOeDLc1sR9YaufQiv
	JEBNnGyPRoUnVzzEP5SioqZPWw3h+W70NduA7nT4QiH5WYWbfMYPBuENAQYkgxgaM1lvFZniAgD
	TmfnC5jxLPeatCVxAdZpaYM+cNKhTiYNOJ1BuaCSZ/CoaV2jZb8J+N+BEiPWwxolD3BPlS1WZ5M
	+iiETmT91pctrK/UcJvDGGi2uRSH6zd6ULFfCZl9Z1yjXN2o0ITPnD6w/AQN3V4G0VQvpcoHm7D
	ZyrXHzyw1
X-Received: by 2002:a05:7301:5f17:b0:36e:20ee:b288 with SMTP id 5a478bee46e88-3751eb8b097mr156178eec.12.1794250044929;
        Mon, 09 Nov 2026 10:47:24 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm315231eec.18.2026.11.09.10.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:47:24 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf timechart: Fail IO recording when no syscall tracepoint is available
Date: Tue, 10 Nov 2026 02:47:19 +0800
Message-ID: <20261109184719.2794382-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
References: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
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

Hi,

Gentle ping on this one. It still applies cleanly to perf-tools-next.
Please let me know if anything should be changed.

Thanks,
Hang
