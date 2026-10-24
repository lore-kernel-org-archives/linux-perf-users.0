Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809317;
	b=DOJFQAC7JLj9iiEQgc0mdTsn1f7RsG1Bbctw+72SK4puZeTPFXJXyfTZ1uXlHUlPHwls
	 cB5Op5J/metW1G28Q/Q/ALvMJNoVQJmbLFS3DMAzOynU3LHKfxWGOjgzlPgn72X+BrZv6
	 742/BWuQsulDERJqypiRGLchPj0GeHWkbDWzFgQZ6BQgjudIox+HLJRjVhSIgEeGgh24/
	 dvEEx3oxaXRC7nD5vPgbmdK9EYcBzgq6lmCsxqzW9Oe5fy1pwOyJ0JG3KF7NC7j8pJ+lB
	 tLuIf/IxHmlXLWaFbW7d+/YEW+i/VzqoO3Yz1dczbJwRtlxqLdBt0NZ7qqBi0tOTwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809317;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=euoB6b7GA+zEoXNxnu22fXqTompq3h3v8WFaWLasK6s=;
	b=j/b6NXB5iEQwrqheGfKPXNIURcFw/QeMF6CdSnzm2OK/3Z+d6zqOYSfTtR6Dj5Kbas60
	 P89Rm52jYaIrMM8rK0g4O10VzvdAkrjXzUiUWji0EqtJWx0gzQTO0GHDZyfEzLBjC1att
	 S0EnoUnSD3k/3bq1GVozFldHZRfFTwxW2YVjFk3YPzkMLovqYRQKy/wWBP8eaSbBFJd4s
	 u0zOkcuRl1RZqkKSueL3olZHEHXhsRfZdaeJD67DBkVp/BQ8xMY7XpE4IxeRztN6lkURp
	 84YC4hffZfF2EEKUTyNTOAJX2OkHTyiN5mXWzNcV5DLWIgtnp3F1wwrxrczZvhhbrOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RKdEsYOP;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E1606A31A;
	Sat, 24 Oct 2026 02:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RKdEsYOP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=euoB6b7GA+zEoXNxnu22fXqTompq3h3v8WFaWLasK6s=;
	b=RKdEsYOP/3+7vzJE/xpxCMywdSQE4G8WBgP8IMotByAvbhgCYcA0PXqw0KztBz
	MrQSTVD8ni5wdSwe7j3lW12b/xdgoNpKltKoOaOaD/KkBSIiKYFYVYpdTfscBbmq
	lptyvtZ3UUB+nqG01+ikRRXaui5DWxdkIPhDF8JyHbvVQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn77sZGdxqzpBmCA--.19908S2;
	Sat, 24 Oct 2026 10:34:02 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: atish.patra@linux.dev,
	anup@brainfault.org
Cc: will@kernel.org,
	mark.rutland@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	samuel.holland@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hppiscas@163.com
Subject: Re: [PATCH] perf/riscv: clear snapshot setup state when a CPU goes offline
Date: Sat, 24 Oct 2026 10:34:01 +0800
Message-ID: <caplitmus-rv.reply.20261024.pmu.b487faf5463642bb8eabd047819d6327@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
References: <caplitmus-rv.75b0e9ee82984422ba17d833767912a8.d33@163.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn77sZGdxqzpBmCA--.19908S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRN2-nUUUUU
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7Roe5mrcGRq0zgAA3A

Hi Atish, Anup,

A brief follow-up on this patch.

I rechecked mainline at 17bb0e2f6c80. After a successful snapshot disable,
pmu_sbi_dying_cpu() still leaves snapshot_set_done set. When that CPU
comes back online, pmu_sbi_snapshot_setup() therefore skips registering
the shared memory again.

Could you please let me know if any changes are needed, or if this is
already queued?

Thanks,
Pengpeng

