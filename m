Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869404;
	b=4E//+BMLBPBUEZPnFHmFB+TtyB9RUNT/K+40JR6vxA/qIiEdva7DVRHj6t29WT5lilco
	 epQfD2UNex0lH/DmT7fBHg2N6y++GeynW6XXep0ov9zuYDtm+/5pxjEkta1FnxX+6HOga
	 A8rdIDdWKaLffHT6o7YXl3dPj5XOeIwKm/lgOQNsbvTdJrRlDQfAH1s1Tpnt1R0prhhm4
	 PleNME9L4wQdLgp3WgOlz28MQiOTvLbk0uLQScLd7Liw8iHKeJl9fxOYQ50h2Jfr+eRPe
	 uucHIPC//98DIYfWmd9kJdUH1Gf92hAhZf9p+8ej6Qvpc/d9hhVqSXJ8Yua9gQbyM7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869404;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1NYk/R+AjvZfblsV7HCmGu0xMESmf/3Rl3LdxJTF5qY=;
	b=eUZg6iCvHwQDfNgKZJkCRcItsGjgvl+lhp1rJfta556RfVacM1VA7NlWWf3HM4nVM8ox
	 8F6Em8X3XIzRQkpSkYcGJhtzLl+8mOHXt9o1qCqt4hbFrPR9k3i7dpCn+e//um759UFKD
	 0ojYmyHKSqQEilUSsRuTvN2GitNFA2QlgSNEIMDBKGLbfTaqe+0nA7cn4HxzekezXjpCD
	 iSIJpQafQL6g6pGruGnUK8pkZNwfBY5Zg0AHQfrVW6FssTGLzoHX8IfQgkhX+Wd/WSWQO
	 Fr3ayCOAAR5St/Do9POAA9pbZqDU0LiScWI4YbZWe5qKM869AyBKnIQ1FAG41bHE6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pmNLQSFO;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25613606A31B;
	Thu,  5 Nov 2026 09:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25613606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pmNLQSFO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793869399; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1NYk/R+AjvZfblsV7HCmGu0xMESmf/3Rl3LdxJTF5qY=;
	b=pmNLQSFOpq/RuRuhP0vzWZQi+r2DSovBx8mbaVk24pezHXtwBKmp9/8XAPGE4gUt5nNM5gtVYmEo7HW6q/uzke4zADGtHy2IriKE+h6xZfOzrVwLbt12RwIY9O8luJNn4U7bqlbiLt4H19tTsSrH6vK432upsOL+i6+b125lCWM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XE8DYxW_1793869381;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE8DYxW_1793869381 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Nov 2026 17:03:17 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	anup@brainfault.org,
	david.laight.linux@gmail.com,
	guoren@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	mark.rutland@arm.com,
	mike.leach@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	palmer@dabbelt.com,
	peterz@infradead.org,
	pjw@kernel.org,
	will@kernel.org
Subject: Re: [PATCH v3 0/2] perf riscv: Implement rdtsc()
Date: Thu,  5 Nov 2026 17:02:57 +0800
Message-ID: <20261105090300.2889-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009032715.2841-1-cp0613@linux.alibaba.com>
References: <20261009032715.2841-1-cp0613@linux.alibaba.com>
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

On Fri, Oct 09, 2026 at 11:27:13AM +0800, Chen Pei wrote:
> [PATCH v3 0/2] perf riscv: Implement rdtsc()

Gentle ping on this series.

Is there anything else you need from me to get it queued for the next
perf-tools cycle? If you would rather see it resent on a newer base,
or want a change I have not thought of, say the word and I will do that.

Best regards,
Chen
