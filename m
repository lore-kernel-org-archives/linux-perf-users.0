Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279147;
	b=PrnBUKH0kBHEbZN24dKiI2v4RiDNHmyiXAHjWBpHsR1KIC+++FMnxkKHm0gfikgLQP4d
	 qA3OziEdAdNI9Ag+5TWjJfcQsKLTty79/kln3XUP7aaECZZrbm+v65ODtaai7uPFpuS84
	 CbpYj0GbiSMVDKXPhbAMhLbz5oRpJHn5WcFTkh8zQORGnEcJ8z9cvouHchUjWASXQqBDy
	 qIHszFyUys/vNuq9vJURa2WXmrw90V+KzHI46dYr9uweheSnc88uGkLHGKR+gQbPfoCZ3
	 nMACV2Lw8TlTokyoxEhYoeZUXA2Lxe3ONgMD3dmgU1+7rhjGdpu/PI5xH1VyWaYA9gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279147;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=lQNUV5YgUByNTPltTuqOFpYJlWyhTkTkFmY14rehLIY=;
	b=EpwwZxRs68giJ7W6BnxqtCQe2jPuaYM9ACnY9aOXbw2sQAt1Z7xmjdrYzuRLMTh7X7qq
	 yyOaPWqTZAseQ6JcI05u5O13lSojDlKT2g9JVRgl0JUtbN/VHUL0ElSGeQ0TJhZ+hg2dg
	 EdqTrdxypshaG4eaY0OKh1U55h0TUFRLyucLXqlPu7nQC2LK2jhdtMu/rkG3vrUJJWit/
	 zL4u+B8V0pH0oAARP6wLpeWh92nS0pQBxG94gtWGbVyvvo4p+Ms0B1EbIPGEo6e5BlWd6
	 W2QE3g6c4zfwy8gdrxdSff2kbWeNELIt6NJQqXM/FYAG2N5J5VEKK5VBf/4hpxbrH7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2M2JpNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BC60A2622;
	Tue, 10 Nov 2026 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2M2JpNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258791F008A5;
	Tue, 10 Nov 2026 02:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279146;
	bh=lQNUV5YgUByNTPltTuqOFpYJlWyhTkTkFmY14rehLIY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=V2M2JpNXr6rbh+djVU0eYs6a3sLhSDAbAd79nJinvsp4fyVZnGCANL6TnB2dY+oIf
	 MeUNjuPXXN9J/JuVCXIZmMyU/w3U7ZLx8PtaJ5+cgtcxcwLo3DdMpdfCcOtiqTRdtG
	 wrK4Kww9qIgdsrBYPFr/8chYorpCdcAwAHibzmZfPfHYhr6/6eD3akM4tytKMnO1i+
	 FqZMUjdr4PI039joXcqF9COBm2B+XyKP+ZdeYgSwT+31eQXc9ywvHxoV7K7bzXx59a
	 qJiKQfsYeEmOjMat/p2JTnYz3ZoWFwneMamrYaGM49q4mX1QihIiVnN7NxkMt7wsGo
	 AACyQ5bHobOPQ==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, acme@kernel.org, peterz@infradead.org, 
 mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
 jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
 lv.yating@zte.com.cn
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 liu.qingtao2@zte.com.cn, he.yilin@zte.com.cn, zhang.cheng35@zte.com.cn, 
 ye.zhihao1@zte.com.cn, shen.lin1@zte.com.cn, dai.hualiang@zte.com.cn
In-Reply-To: <202611021227.6A2CRwkO000175@mse-fl1.zte.com.cn>
References: <202611021227.6A2CRwkO000175@mse-fl1.zte.com.cn>
Subject: Re: [PATCH] perf test: Add LBR call stack branch filter test
Message-Id: <179427914610.13444.13056121071412016191.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:26 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 02 Nov 2026 19:02:28 +0800, lv.yating@zte.com.cn wrote:

> While debugging a NULL deref in resolve_lbr_callchain_sample()
> triggered by "perf record -j stack" (fixed in commit
> 4626d370ae89b8af4d46a45372b269f926ec662d "perf machine:
> Fix NULL deref in thread__resolve_callchain_sample()"), the "-j
> stack" filter was found to lack coverage in the perf record LBR
> tests.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

