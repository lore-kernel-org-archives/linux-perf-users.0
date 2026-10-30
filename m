Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359938;
	b=JNWUjugDdk3kWJHSn/sfPw9yHdm40IrgBCX5JVIJoKzo8JhHo0RWyWqp9IWNp02O8rvJ
	 X9E77lBIpousjg4C4xwLZ2uvMurZ9RDbmdkpX2DcSnmEplWKlAxmsvzjvRZYL5VOeJICm
	 l4GYH1hBrrRdaQyhpHTWmOc9Igs31BQU+6sWiECzrmeQNqXdNNsQ2MCIGyq/QJB4fkOUn
	 BveMp5VUGHu3NoxrS9Qx9459Xaw6GcAvi9RHDqp0c6VvkLD91Rfs1jhEYQhedyI7Su3K+
	 9h3wEVSGwj76WTt3xMDsa/Vb2+M+pke/xT0UKM7A5R9MGZqzzM4963LJSgcS+/u6KBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=OeB6ued/+lD0orJhDR5wIi7Ahcx+qtctB/2Nl1HxV3A=;
	b=lPNq21BihRYXYKXJTfxOrrTfTZ3Jo6QLwPjk+Zps1E6DNDKKQkmB069ObFvFOE7gIUUl
	 QdaKUWwafrHPuJ+VNQxi8ddUon+5QBWSUMIzPMrGEPs9DssLFeHR8fDtDrbVpzL+Xzlgy
	 ecuBf67kmjAgiVzeLCTa/poEZOL9qR0scCxOmby+rVe9O1f6gkFpoYsDMfE1ls4Q4bYf5
	 CUlNWke3I/p939wYUPDHuoymEbtzOJHPEODSQFRRtFK5WhuUkFAPlMUbsY/4PRqQPaGLZ
	 wuZv34DHMPYg94IKjBTKstFRJCzZjGMGORd9B0D0kC4Z26BIZAIK3aX4KkwFuWiy2cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOiFyKhU;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA75606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 11:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA75606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOiFyKhU
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso264659a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793359938; x=1793964738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OeB6ued/+lD0orJhDR5wIi7Ahcx+qtctB/2Nl1HxV3A=;
        b=aOiFyKhUrjhgArbDyxY3+ihBTaTeD2kFsbbrIVxgVx56pVQlL9P4DhDQHho+/9vfsE
         u7mQd4beU/kGxGWD39ttZca27ShqtZBG+MnrRdrtZ0LFT9mCJAOLlqdNxKti2LMqELRd
         Ph4qWFDwc1AL4nLH8E5rlyMUnhxbT1sM8r+F0uVqTef3rBfW86VRJ/f9ZszOPTcluaLq
         kL63v8pUCUQ2t9batDTI2rvAK+m7MLPEYDWlvsAdwpRHMXPC8jjnR+eWZ/39oy1cpxpW
         c6empdu2YMTGZWrhiKfXf6WZ5YvP2JQhAXw5r9KfqG9z/WvOkQTM3PXj9aCqaDe7G6vt
         nSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793359938; x=1793964738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OeB6ued/+lD0orJhDR5wIi7Ahcx+qtctB/2Nl1HxV3A=;
        b=mHwm8iroQV7filyOULVmOSOCS6O9AlkrLtcFLSnwjJ6MC4ZEUSN8RBImLFd0pucYx9
         +oj/ChYUZsCvISDxa+PmlkZGZyXY69fqc9wK9IUorv0wVx4BbidgVgWjUw6TjbNSkfpU
         htjsDxee00+af4IxiVzUmdpJawqsjDeSDWcmCNvIstoUbGKR18jg35A/6+DEEvGHYO35
         BNg7+nD847vHiIgCiPb4KWJ0sjpofF7vb+yRSSvJPQdnX1lz1lTH72P/jCe8Dlw2IbEA
         e8tR4HSVHLxOttXXLOulWAwWSKvUKIDy1cvPWHm8r5WKm53FcClJedEYElKwrHkfxQiw
         au4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzj6rnrfG91upaiqFYYPGV5EGPmzqdj2zu/R7dsgoUoSB8nVBavuPjs+Ab0gHEb6r92NjxBEJQuIlKnXUIS6Pqf@vger.kernel.org
X-Gm-Message-State: AFq9FYL13HHAh/KQw4tVfqMb8OzAlaKzsdYF9hbATZKMottL8U9tBWDp
	Kc9Fh7NtsRP83QLfymjbBtowKrwpxbjFzHZ9rLczt/lawtNzXMUm7eto
X-Gm-Gg: AYBFou1kK7Ql3oQRUqX3fBFQaO9rSwSI8Q9hvYq4QQVNbq4YKIVc4RXfvTsWeFAaF/D
	N8SzapS3td2JzqaL0TaPBOVzjiRfZWzkeZqwgLr86CE4ZX9BNzg67or00j3sn8uEkurKCIvxI8F
	XdXuIWtaSOM2/hWRYl/hTBHdYTlsj4eLysHn8ASFe0zO2ouvoMBD4LahJug0OaT8JjvmkqK9z1A
	VVMN8pCn0aajfJLbVQw12GRDRNpp3GjU/NHTvR+tzuJOAVxvApFc8PBSYtbEMP/mgnHqDWxfeQk
	ov0HHAjfXzw+BJdzDhUI0WdJq77GQdzj+uFw3VyyJfFCWoCmLacbq3yPadATLRRo2DahTh32kBt
	AIVIjDiVodS7DsO7WBJ5bZuzthv5Ew5nXmMH5xKd04ruWCjahzUzu/VYPfQp2IGR2O6kM0dS76/
	78FelANilKC1OF7l4sXBXwH6xjdN3eNhwC53Tk//Q/xUQaw7RdZMrRkN+3Pov3hZlCXvKsJgwIS
	v7W8WVP4jrLXe7p2NCSLPBIaE2P/Ml5vetFwcoPX93J5ifDz75DPAMOW2cMAzVlBXfSVy/xVmtg
	td1aZwSrrqyze4/Cgu+CEVkkK3t1CpdtWZpV/9tto2PNRjLNSrfQ5hqB
X-Received: by 2002:a17:90b:17c5:b0:3ac:7c52:faf6 with SMTP id 98e67ed59e1d1-3ae89574d7emr1504433a91.1.1793359937853;
        Fri, 30 Oct 2026 04:32:17 -0700 (PDT)
Received: from hsj-2U-Workstation ([220.248.78.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm3774756a91.16.2026.10.30.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:32:17 -0700 (PDT)
Date: Fri, 30 Oct 2026 19:31:55 +0800
From: Huang Shijie <shijie8@gmail.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Huang Shijie <huangsj@hygon.cn>, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, zhongyuan@hygon.cn,
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuqi@hygon.cn, lijing@hygon.cn,
	wangfengyu@hygon.cn, wujianyong@hygon.cn, 1537577747@qq.com
Subject: Re: [PATCH] perf/amd/ibs: add phy_addr_only software filter for
 ibs_op
Message-ID: <auSAK3OuOOqWtKfZ@hsj-2U-Workstation>
References: <20260902085251.4046240-1-huangsj@hygon.cn>
 <auMrUXp42Djz3zu9@hsj-2U-Workstation>
 <f151155a-54c1-41b1-8905-2347a1404001@amd.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f151155a-54c1-41b1-8905-2347a1404001@amd.com>

在 Fri, Oct 30, 2026 at 09:45:03AM +0530，Ravi Bangoria 写道：
> 
> The BPF filter is giving more accurate data here because neither kernel
> nor userspace should access the first physical page:
> 
>   $ sudo head -1 /proc/iomem
>   00000000-00000fff : Reserved

Yes.
But I can change the patch to skip the first physical page too.

Thanks
Huang Shijie
