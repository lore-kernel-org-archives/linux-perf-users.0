Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56C265CB7
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102204; cv=none; b=B2WFeGh9P6ODMym26rQW2W/FIlRSp0nXB9Iv62Rvtu5LFPKuklbfDjUC7FCySkacTZetsZgkQtMsSnW1bkcakjPbwTtR7VnPKcwbNVy7wv1jp3maf9nByvSB0xbe+7Z8g4Gg+YryqaKFE7GMu1o78SrJDJl1zAg8B33Iii1SaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102204; c=relaxed/simple;
	bh=DvT37mlLylWirMmvziApQyMOyXFz2tPHw47pSw/2Ns0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGJMNk/T12RjIyVSMISzQBAKaiuhCoiU9/WlZIEdgoF6n8CzPTt2+63UjsCnmhz2SOcpVeh1WWAhejS9UsPo01v2nXqn/M+eu9z7P5WgIwn1PwHWkmYW+4Mp0a/O3guedn5d3alExO9s3bcJG58jFkhTClZ6dIPVOWSXu1x3Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0qihsw6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0qihsw6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fee05829edso6058221a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741102202; x=1741707002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66psdEYIrVGR86JKMR8+mqBEFxkGfgmcukM2sBzapxc=;
        b=f0qihsw6h6E1twiuVjL+pwN2kHj+/eIdoqLQS/bM5Pu1Rcst++qQvUyQnyW4fIl3Fw
         XHmrKq6oSDnN+xGBU+RPFbDbngaZY06NTdSdDc8lixsezuXDonsQtMs1DGPVU1+5o06U
         geZyewK6D+0sAxdjsYLg23YV+TA2kHt7sp/cAAWt0tKecJxorvOrQFJpAWJlOX6rGtXT
         aiRCAFZPNplSmEsb20L7Yjy3Oy5aNa4dIG6QvrRILp33DAlP208t+V8sni5oafxqCkrI
         KowpbOlG9gjuYfBw6xi5OHCkdKYAOqnd31j/Smi9wHgI5RTMl4TKXW0BpSlgeTgElKoe
         wKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102202; x=1741707002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66psdEYIrVGR86JKMR8+mqBEFxkGfgmcukM2sBzapxc=;
        b=fDba4cz7GfLQuFAjdv+CqtibJlpZKl/AJrknO2ytq1XxgX/pqchq3GTWFWN8nMEHE+
         zOfmp2YxS2u+WP8GTaxv32Bb4qSraCqn8JMCWOicsrkT885FlC/im/d7Au8tWc6sCeEa
         UcJlYdD++POXVZpNLqGFj6V82xpFWjgdvYbtB41Hthyl7WSxoe/cpdxf3uzRUEqv9v3H
         iurI6Z1gH+bLdFBprWRR+2WomnB1S2XjdJXjICvKCvTVnMVBzX0tZk6Dq8I5qqLmgJp5
         sAZw9oq1DbiSjpvggcpsbCqjbiAV8NwUKairTLd+95FNrlGvHu4iGWIy3BiOMBRG3HSJ
         lkmA==
X-Forwarded-Encrypted: i=1; AJvYcCWvGMXeCjhvlhnyqOE0RTc1i86aQn16NpQ0LERyoyXduHaP2iCF1gAz2SMOOOYANocCWMMSm5RrbceIV45Bavoh@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJr+kOzSCU67DOH52NVjCsV3x86Wo75IMtofcaG/w5zb2lfBm
	AepJ5i0gUVufKbeOwpvLyqIg4ghasxgiaCUWYwdTeVz2g9PcdE1LJqGcnOZDtQ==
X-Gm-Gg: ASbGncuTe+GX35BZE9avL6z4A8KwDwLNtboY14IrN8ALMFhS1dD0ojYwFHlI/Hr9CiP
	UaWHoJRA0yp6rVRPluTt7+bMPkCKDZ0vJ3n8KReqePSYMCDl7cqduv2Sc7491zbIyUbSBlMwQ96
	anvfMZf7t1W0r7yyTrNVlv+xs2TZDU60Jlhlw1dU3klhiOgCMIDF67Zj5wascklCTTVjVb2pN2z
	xRAN7p48rW6B6Em9ygPAjFy2QeIYjGyu0fZegOTcpetZ9DWx4a7Z71mVLkhqQfa19ae6cErkbCo
	qag9qNgL65vI7ge0+2pnZDXcaR4U8ZS1PwYTiMSrHtk9Qc9hSQ4WiDo=
X-Google-Smtp-Source: AGHT+IHDLoudvsE8ThGCBDtv8xpmDC4PMrV1KRLn9yaD488OmdYvS42vvygcsTzqkS+txl9sTFzPNQ==
X-Received: by 2002:a05:6a20:7348:b0:1ee:be88:f5cf with SMTP id adf61e73a8af0-1f2f4e00bfbmr34435609637.32.1741102202650;
        Tue, 04 Mar 2025 07:30:02 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de38003sm10265993a12.33.2025.03.04.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:30:01 -0800 (PST)
Date: Tue, 4 Mar 2025 20:59:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 4/5] Add debugfs based error injection support in DWC
Message-ID: <20250304152952.pal66goo2dwegevh@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132039epcas5p31913eab0acec1eb5e7874897a084c725@epcas5p3.samsung.com>
 <20250221131548.59616-5-shradha.t@samsung.com>
 <20250303095200.GB1065658@rocinante>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303095200.GB1065658@rocinante>

On Mon, Mar 03, 2025 at 06:52:00PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > +		29) Generates duplicate TLPs - duplicate_dllp
> > +		30) Generates Nullified TLPs - nullified_tlp
> 
> Would the above field called "duplicate_dllp" for duplicate TLPs be
> a potential typo?  Perhaps this should be called "duplicate_tlp"?
> 

Looks like a typo. As per Synopsys documentation, there is only 'duplicate TLP'
field.

Good catch!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
