Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989374;
	b=JG2DjlYIGAuD6kK14A9d08OIP1qf5ydfoAIRAa19R23C34scLOXK35nQq/BaJGszaXFB
	 SQiV7N+iUzVU1fuxMn4RRtLrUJFZz+KZqz9L07ENxs5SEvDTxH+GeCMpQsCXJdRCUXgFk
	 b6+EsDKWMfacLRrTIfYdz3NWGDB31b5ZziIUeSB39DyTZ+zEsSQlacQNlaHF3ZGzXmsxn
	 gTqOnqfSZWs2haY5MYodZrjoEYCFXPhjv5BQ3+Lg1lGZlAnzY3tzoW3AkzVph5JLmDiEM
	 APwYsZKoRdvV5uGtV020OJ73EBJM7jp52WFEddVpXKqTaHMYzMBQ2h5WGXte2ZXLz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Jk2ZwxV40Z5cBoAxsVcL6on1/+5n7nlvs0/xx/GRVak=;
	b=sfNgcxrHdSg3KBoU7F/ISAdhyQiyJJHPXXw5jOIukiPsKFAXCi1sL7YVMKT1YzALgggE
	 O7/B6RnX7ZtbkgfZyMru6jBiAImtp/wdZHq0WfY6IT3C3h/vMNAJbb2ZhksZzi+p/awEW
	 z5blVO7BQoq975jA58j6duduaS6E/5yg5FU6yYMauDpPck5q5DCdfsa4oIvxpWn3okobR
	 ZrxGWY30FZSL1M6IJtA+Mx3ty4UaVe6FS92ipkHKXhCBHSHGKGZU5vWI0KEXhJ/2dZ/Kp
	 sM1+LNKKBGtsiUxpYCiomRoxa8WgbbOHKlXPmKIQQJqNl2pTu/3OYD2tIUL8B9N37TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="p/j7qCWB";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E76606A326;
	Fri,  6 Nov 2026 18:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E76606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=p/j7qCWB
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jLnbd0TrQz1XMmDj;
	Fri,  6 Nov 2026 18:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1793989370; x=1796581371; bh=Jk2ZwxV40Z5cBoAxsVcL6on1
	/+5n7nlvs0/xx/GRVak=; b=p/j7qCWBtI5/FiljsNFOFFGK2VQdlXxI9owZGo2s
	85Padf9qXJyWhB3UuLUgozFKvd0M0Q2tETzxnzIqMtwWJgJBiKXljiilqty9XGzy
	bybCV++RWeRpKeVtllDe2z8zUwx1dE5OULJHQrNl5kp5uCH7lO3Gi9Zdp2APSTSg
	NcLv27IGJAF5cgBR9ISoWBf9u1UD9uLz65AFIKiJ53heJrWZL84gk0XVUFUD8A+s
	+uS0UAz95s0Rpv8mDDubkN4BIOQ2YLDG62SoQpmQC14ZCaTun1rKLTSsOC5H0IdV
	NI8FaN9vjA8rihXDklEySYwdR4IRy2F9TK7swH3zcw6iBQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aQXB9dUkTU-N; Fri,  6 Nov 2026 18:22:50 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:a09a:30e6:d2b4:a215] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jLnbZ1klFz1XMmDg;
	Fri,  6 Nov 2026 18:22:50 +0000 (UTC)
Message-ID: <d8ccc4f4-d9d1-45d6-8b19-e1762dff14df@acm.org>
Date: Fri, 6 Nov 2026 10:22:48 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/20] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Ian Rogers <irogers@google.com>, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org,
 jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com,
 morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
 peterz@infradead.org
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-2-irogers@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261106070344.329897-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 11:03 PM, Ian Rogers wrote:
> -static inline void _context_unsafe_alias(void **p) { }
> +static inline void _context_unsafe_alias(void **p) { (void)p; }
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

